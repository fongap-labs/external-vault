#!/usr/bin/env bash
# Central execution contract: invoked by fongap-labs/action-worker.
# The secret scan prints its (redacted) findings, so a failure can be read from the CI log.
set -Eeuo pipefail

TARGET_ROOT="${1:-}"
if [ -z "$TARGET_ROOT" ] || [ ! -d "$TARGET_ROOT" ]; then
  echo "central-ci: target root is required" >&2
  exit 64
fi

cd "$TARGET_ROOT"

required_paths=(
  "AGENTS.md"
  "CLAUDE.md"
  "docs/README.md"
  "docs/DISTRIBUTION_GOVERNANCE.md"
  "tools/README.md"
  "tools/catalog.json"
  "skills"
  "output"
  ".gitleaks.toml"
  ".github/manifest-allowlist.json"
)

for path in "${required_paths[@]}"; do
  if [ ! -e "$path" ]; then
    echo "central-ci: repository layout drift: missing $path" >&2
    exit 1
  fi
done

forbidden_paths=(
  ".githooks"
  "projects"
  ".github/workflows/agentdock.yml"
  ".github/workflows/build-agentdock.yml"
  ".github/workflows/oci-capacity-watch.yml"
)

for path in "${forbidden_paths[@]}"; do
  if [ -e "$path" ]; then
    echo "central-ci: source/build residue detected: $path" >&2
    exit 1
  fi
done

if git ls-files -z | grep -zEi '\.(exe|msi|dmg|pkg|deb|rpm|appimage)$' >/dev/null; then
  echo "central-ci: program release binary detected in Git tree" >&2
  git ls-files | grep -Ei '\.(exe|msi|dmg|pkg|deb|rpm|appimage)$' || true
  exit 1
fi

jq -e '
  .schema_version == "1"
  and (.tools | type == "array")
' tools/catalog.json >/dev/null

script_root="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

bash "$script_root/validate-manifests.sh" "$TARGET_ROOT"
bash "$script_root/secret-scan.sh" "$TARGET_ROOT"
bash "$script_root/check-release-catalogue.sh" "$TARGET_ROOT"

# Published brief retention: each project keeps at most the newest periods in the Git tree.
# Limits come from .github/output-retention.json (default_periods plus optional per-project
# overrides in projects); EXTERNAL_VAULT_OUTPUT_RETENTION_PERIODS (a whole number) overrides all.
retention_config=".github/output-retention.json"
default_retention=14
if [ -f "$retention_config" ]; then
  if ! jq -e '
    .schema_version == "1"
    and (.default_periods | type == "number" and floor == . and . >= 1)
    and (.projects | type == "object")
    and ([.projects[] | (type == "number" and floor == . and . >= 1)] | all)
  ' "$retention_config" >/dev/null; then
    echo "central-ci: malformed output retention config: $retention_config" >&2
    exit 1
  fi
  default_retention="$(jq -r '.default_periods' "$retention_config")"
fi
for project_dir in output/*/; do
  [ -d "$project_dir" ] || continue
  key="${project_dir%/}"
  limit="${EXTERNAL_VAULT_OUTPUT_RETENTION_PERIODS:-}"
  if [ -z "$limit" ]; then
    if [ -f "$retention_config" ]; then
      limit="$(jq -r --arg key "$key" '.projects[$key] // .default_periods' "$retention_config")"
    else
      limit="$default_retention"
    fi
  fi
  case "$limit" in
    '' | *[!0-9]*)
      echo "central-ci: output retention limit must be a whole number, got: $limit" >&2
      exit 64
      ;;
  esac
  periods="$(find "$project_dir" -type f -name manifest.json | wc -l | tr -d '[:space:]')"
  if [ "$periods" -gt "$limit" ]; then
    echo "central-ci: output retention exceeded: $key holds $periods periods (limit $limit)" >&2
    exit 1
  fi
done
