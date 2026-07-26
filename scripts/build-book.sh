#!/usr/bin/env bash
# Vendor sources, then mdbook build (+ linkcheck via book.toml output).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT}"

export PATH="${HOME}/.cargo/bin:${PATH}"

MODE_ARGS=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --from-fixtures|--from-fleet-config) MODE_ARGS+=("$1"); shift ;;
    *) echo "usage: $0 [--from-fixtures|--from-fleet-config]" >&2; exit 1 ;;
  esac
done

if [[ ${#MODE_ARGS[@]} -eq 0 ]]; then
  MODE_ARGS=(--from-fixtures)
fi

bash "${ROOT}/scripts/vendor-sources.sh" "${MODE_ARGS[@]}"

if ! command -v mdbook >/dev/null 2>&1; then
  echo "error: mdbook not on PATH. Install: cargo install mdbook" >&2
  exit 1
fi

echo "==> internal link check (src/)"
python3 "${ROOT}/scripts/check-book-links.py" "${ROOT}/src"

echo "==> mdbook build"
mdbook build

# mdBook 0.5 writes under book/html by default when multiple backends; single
# html backend still uses build-dir. Accept either layout.
INDEX=""
for candidate in "${ROOT}/book/html/index.html" "${ROOT}/book/index.html"; do
  if [[ -f "${candidate}" ]]; then
    INDEX="${candidate}"
    break
  fi
done
if [[ -z "${INDEX}" ]]; then
  echo "error: rendered index.html not found under book/" >&2
  find "${ROOT}/book" -maxdepth 3 -type f 2>/dev/null | head -40 || true
  exit 1
fi

echo "==> build OK → ${INDEX}"
