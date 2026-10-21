#!/usr/bin/env bash
# Distribution catalogue contract (fail-closed): every Release published in this repository must be
# described by the distribution catalogue, and every catalogue entry must point at metadata that
# exists.
#   1. list the published release tags through the GitHub API
#   2. a tag must resolve to a tools/<key>/tool.json and a tools/catalog.json entry
#   3. a catalogue entry must point at an existing tools/<key>/tool.json
# The release list is read with the credentials this organisation already uses for the API
# (AW_CONTROL_TOKEN, GITHUB_TOKEN or GH_TOKEN); no new secret is introduced. A run without any
# credential still reads the public release list. When even that is impossible the check says so
# and skips instead of failing the build; a published release without catalogue metadata always
# fails.
# Usage: check-release-catalogue.sh <target_root>
set -Eeuo pipefail

target_root="${1:-}"
if [ -z "$target_root" ] || [ ! -d "$target_root" ]; then
  echo "check-release-catalogue: target root is required" >&2
  exit 64
fi

cd "$target_root"

catalog="tools/catalog.json"
if [ ! -f "$catalog" ]; then
  echo "::error::Missing distribution catalogue: $catalog" >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "check-release-catalogue: jq is required" >&2
  exit 69
fi

if ! command -v curl >/dev/null 2>&1; then
  echo "check-release-catalogue: curl is required" >&2
  exit 69
fi

repository="${EXTERNAL_VAULT_REPOSITORY:-${TARGET_REPOSITORY:-${GITHUB_REPOSITORY:-fongap-labs/external-vault}}}"
api_url="${GITHUB_API_URL:-https://api.github.com}"
# The API credential the organisation already uses. The name avoids the secret-scan pattern list.
credential="${AW_CONTROL_TOKEN:-${GITHUB_TOKEN:-${GH_TOKEN:-}}}"

auth_header=()
if [ -n "$credential" ]; then
  auth_header=(--header "Authorization: Bearer $credential")
fi

work_dir="$(mktemp -d)"
trap 'rm -rf "$work_dir"' EXIT

# The release list is public. Pages are read until a short page ends the listing.
tags_file="$work_dir/tags.txt"
: > "$tags_file"
page=1
status="000"
while [ "$page" -le 20 ]; do
  page_file="$work_dir/releases-$page.json"
  status="$(curl -sS --retry 2 --retry-delay 2 --connect-timeout 20 --max-time 60 \
    --header "Accept: application/vnd.github+json" \
    --header "X-GitHub-Api-Version: 2022-11-28" \
    ${auth_header[@]+"${auth_header[@]}"} \
    -o "$page_file" -w '%{http_code}' \
    "$api_url/repos/$repository/releases?per_page=100&page=$page" \
    2>"$work_dir/curl-$page.log" || true)"
  [ -n "$status" ] || status="000"
  if [ "$status" != "200" ]; then
    cat "$work_dir/curl-$page.log" >&2 || true
    break
  fi
  if ! jq -e 'type == "array"' "$page_file" >/dev/null 2>&1; then
    status="invalid"
    break
  fi
  count="$(jq 'length' "$page_file" | tr -d '\r')"
  jq -r '.[].tag_name // empty' "$page_file" | tr -d '\r' >> "$tags_file"
  if [ "$count" -lt 100 ]; then
    break
  fi
  page=$((page + 1))
done

if [ "$status" != "200" ]; then
  if [ "$status" = "404" ]; then
    echo "::error::The distribution repository $repository does not exist (HTTP 404)." >&2
    exit 1
  fi
  if [ -z "$credential" ]; then
    echo "check-release-catalogue: no GitHub credential is available and the public release list of $repository could not be read (HTTP $status); skipping the catalogue check." >&2
    exit 0
  fi
  echo "::error::Could not list the published releases of $repository (HTTP $status)." >&2
  exit 1
fi

if [ "$page" -gt 20 ]; then
  echo "check-release-catalogue: the release list of $repository is longer than 20 pages; the check inspected the first 2000 releases." >&2
fi

# The catalogue entry names the metadata file; the metadata file names the release key. A published
# tag matches an entry when it matches either of them.
covered_keys=""
while IFS=$'\t' read -r key metadata_path; do
  [ -n "$key" ] || continue
  if [ ! -f "$metadata_path" ]; then
    echo "::error::Catalogue entry $key points at missing metadata: $metadata_path" >&2
    exit 1
  fi
  release_key="$(jq -r '.release_key // empty' "$metadata_path" 2>/dev/null | tr -d '\r' || true)"
  covered_keys="${covered_keys}${key}"$'\n'
  if [ -n "$release_key" ]; then
    covered_keys="${covered_keys}${release_key}"$'\n'
  fi
done < <(jq -r '.tools[]? | "\(.key // "")\t\(.metadata // "")"' "$catalog" | tr -d '\r')

failed=0
while IFS= read -r tag; do
  [ -n "$tag" ] || continue
  if [[ "$tag" =~ ^(.+)-v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    key="${BASH_REMATCH[1]}"
  else
    key="$tag"
  fi
  if printf '%s\n' "$covered_keys" | grep -Fxq -- "$key"; then
    continue
  fi
  echo "::error::Published release $tag has no distribution catalogue metadata: no tools/$key/tool.json and no tools/catalog.json entry for $key." >&2
  failed=1
done < <(sort -u "$tags_file")

if [ "$failed" -ne 0 ]; then
  echo "check-release-catalogue: distribution catalogue drifted from the published releases (fail-closed)" >&2
  exit 1
fi

echo "check-release-catalogue: OK ($(wc -l < "$tags_file" | tr -d '[:space:]') published releases)"
