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
  "CLAUDE.md"
  "docs/README.md"
  "docs/DISTRIBUTION_GOVERNANCE.md"
  "tools/README.md"
  "tools/catalog.json"
  "skills"
  "output"
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
