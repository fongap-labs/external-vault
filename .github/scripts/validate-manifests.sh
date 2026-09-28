#!/usr/bin/env bash
# Published manifest contract for output/**/manifest.json (fail-closed):
#   1. valid JSON object with the required root fields
#   2. field allowlist (.github/manifest-allowlist.json)
#   3. value regex blacklist: all fields, plus URL / user-path rules for non-URL fields
#   4. URL fields must carry an http(s) URL
#   5. trailing newline
# Usage: validate-manifests.sh <target_root>
set -Eeuo pipefail

target_root="${1:-}"
if [ -z "$target_root" ] || [ ! -d "$target_root" ]; then
  echo "validate-manifests: target root is required" >&2
  exit 64
fi

cd "$target_root"

allowlist=".github/manifest-allowlist.json"
if [ ! -f "$allowlist" ]; then
  echo "validate-manifests: missing manifest allowlist: $allowlist" >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "validate-manifests: jq is required" >&2
  exit 69
fi

if ! jq -e 'type == "object" and (.allowed_keys | type == "array")' "$allowlist" >/dev/null; then
  echo "validate-manifests: malformed manifest allowlist: $allowlist" >&2
  exit 1
fi

mapfile -t manifests < <(find output -type f -name manifest.json | sort)
if [ "${#manifests[@]}" -eq 0 ]; then
  echo "validate-manifests: no published manifests found under output/" >&2
  exit 1
fi

jq_filter='
def errs($cfg; $path; $field):
  if $path == "" and type != "object" then
    ["root: must be a JSON object"]
  elif type == "object" then
    [ (if $path == "" then
         (($cfg.required_root_keys // []) - (keys)) as $missing
         | if ($missing | length) > 0 then "root: missing required field(s): \($missing | join(", "))" else empty end
       else empty end),
      ( to_entries[] | .key as $k
        | if ($cfg.allowed_keys | index($k)) == null
          then "field not in allowlist: \($path)/\($k)"
          else empty end ),
      ( to_entries[] | .key as $k
        | .value | errs($cfg; (if $path == "" then $k else $path + "/" + $k end); $k) ) ]
    | flatten
  elif type == "array" then
    [ to_entries[] | .value | errs($cfg; $path + "[]"; $field) ] | flatten
  elif type == "string" then
    . as $s
    | ($s | gsub("[\\n\\r\\t]"; " ") | .[0:160]) as $shown
    | [ ($cfg.blacklist_all // {}) | to_entries[] as $e
        | if ($s | test($e.value)) then "blacklist_all.\($e.name): \($path): \($shown)" else empty end,
        (if (($cfg.url_fields // []) | index($field)) == null then
           ($cfg.blacklist_non_url_fields // {}) | to_entries[] as $e2
           | if ($s | test($e2.value)) then "blacklist_non_url_fields.\($e2.name): \($path): \($shown)" else empty end
         else empty end),
        (if (($cfg.url_required_fields // []) | index($field)) != null and ($s | test("^https?://") | not) then
           "url field must start with http(s)://: \($path)"
         else empty end) ]
  else
    []
  end;

($A[0]) as $cfg
| errs($cfg; ""; "") | .[]
'

failed=0
for manifest in "${manifests[@]}"; do
  if [ -n "$(tail -c 1 "$manifest")" ]; then
    echo "validate-manifests: missing trailing newline: $manifest" >&2
    failed=1
    continue
  fi

  if ! jq empty "$manifest" >/dev/null 2>&1; then
    echo "validate-manifests: invalid JSON: $manifest" >&2
    failed=1
    continue
  fi

  if ! errors="$(jq -r --slurpfile A "$allowlist" "$jq_filter" "$manifest")"; then
    echo "validate-manifests: evaluation failed: $manifest" >&2
    failed=1
    continue
  fi

  if [ -n "$errors" ]; then
    while IFS= read -r line; do
      echo "validate-manifests: $manifest: $line" >&2
    done <<< "$errors"
    failed=1
  fi
done

if [ "$failed" -ne 0 ]; then
  echo "validate-manifests: manifest contract violated (fail-closed)" >&2
  exit 1
fi

echo "validate-manifests: OK (${#manifests[@]} manifests)"
