#!/usr/bin/env bash
# Central execution contract: invoked by fongap-labs/action-worker.
set -Eeuo pipefail

TARGET_ROOT="${1:-}"
if [ -z "$TARGET_ROOT" ] || [ ! -d "$TARGET_ROOT" ]; then
  echo "central-ci: target root is required" >&2
  exit 64
fi

cd "$TARGET_ROOT"

required_paths=(
  "AGENTS.md"
  "AGENTS.md"
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

# Published brief retention: each project keeps at most the newest periods in the Git tree.
# Default 14; set EXTERNAL_VAULT_OUTPUT_RETENTION_PERIODS (a whole number) to change it.
output_retention_periods="${EXTERNAL_VAULT_OUTPUT_RETENTION_PERIODS:-14}"
case "$output_retention_periods" in
  '' | *[!0-9]*)
    echo "central-ci: EXTERNAL_VAULT_OUTPUT_RETENTION_PERIODS must be a whole number, got: $output_retention_periods" >&2
    exit 64
    ;;
esac
for project_dir in output/*/; do
  [ -d "$project_dir" ] || continue
  periods="$(find "$project_dir" -type f -name manifest.json | wc -l | tr -d '[:space:]')"
  if [ "$periods" -gt "$output_retention_periods" ]; then
    echo "central-ci: output retention exceeded: ${project_dir%/} holds $periods periods (limit $output_retention_periods)" >&2
    exit 1
  fi
done
