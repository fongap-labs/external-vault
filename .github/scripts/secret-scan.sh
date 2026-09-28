#!/usr/bin/env bash
# Secret scanning gate for the public distribution repository.
# Primary path: gitleaks with .gitleaks.toml (allowlist covers redacted placeholders and
# third-party generated rules). Fallback: precise built-in patterns, so the gate stays
# fail-closed when gitleaks is not installed on the runner.
# Usage: secret-scan.sh <target_root>
set -Eeuo pipefail

target_root="${1:-}"
if [ -z "$target_root" ] || [ ! -d "$target_root" ]; then
  echo "secret-scan: target root is required" >&2
  exit 64
fi

cd "$target_root"

if command -v gitleaks >/dev/null 2>&1; then
  gitleaks detect --source . --config .gitleaks.toml --no-banner --redact --exit-code 1
  exit $?
fi

echo "secret-scan: gitleaks not available; running built-in pattern scan" >&2

patterns=(
  '-----BEGIN [A-Z ]*PRIVATE KEY-----'
  '\bAKIA[0-9A-Z]{16}\b'
  '\bgh[pousr]_[A-Za-z0-9]{36}\b'
  '\bxox[baprs]-[A-Za-z0-9-]{10,}\b'
  '\beyJ[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}\.[A-Za-z0-9_-]{8,}\b'
  "(password|secret|api[_-]?key|token)[[:space:]]*[:=][[:space:]]*[\"'][^\"']{8,}[\"']"
)

status=0
while IFS= read -r -d '' file; do
  case "$file" in
    output/adfilter/*) continue ;;
  esac
  [ -f "$file" ] || continue
  for pattern in "${patterns[@]}"; do
    if grep -InEi -- "$pattern" "$file" >/dev/null 2>&1; then
      grep -InEi -- "$pattern" "$file" | head -n 3 | sed "s|^|secret-scan: $file:|" >&2
      status=1
    fi
  done
done < <(git ls-files -z)

exit "$status"
