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

# When the runner has no gitleaks, fetch a pinned release and verify its SHA-256 (same pin as
# internal-vault). A download problem falls back to the built-in scan below; a checksum
# mismatch is fatal because it means the archive is not the release we pinned.
GITLEAKS_VERSION="8.30.1"
GITLEAKS_LINUX_X64_SHA256="551f6fc83ea457d62a0d98237cbad105af8d557003051f41f3e7ca7b3f2470eb"
if ! command -v gitleaks >/dev/null 2>&1   && [ "$(uname -s)-$(uname -m)" = "Linux-x86_64" ]   && command -v curl >/dev/null 2>&1; then
  gitleaks_dir="$(mktemp -d)"
  gitleaks_archive="gitleaks_${GITLEAKS_VERSION}_linux_x64.tar.gz"
  if curl -fsSLo "$gitleaks_dir/$gitleaks_archive"     "https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/$gitleaks_archive"; then
    echo "${GITLEAKS_LINUX_X64_SHA256}  $gitleaks_dir/$gitleaks_archive" | sha256sum -c - >&2       || { echo "secret-scan: gitleaks archive checksum mismatch" >&2; exit 1; }
    tar -xzf "$gitleaks_dir/$gitleaks_archive" -C "$gitleaks_dir" gitleaks
    export PATH="$gitleaks_dir:$PATH"
  else
    echo "secret-scan: could not download gitleaks; using the built-in pattern scan" >&2
  fi
fi

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
