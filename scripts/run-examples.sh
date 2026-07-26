#!/usr/bin/env bash
# Run every examples/*.sh. Fail on first failure. Requires prior vendor step.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT}"

if [[ ! -d src/vendor/rulesets ]]; then
  echo "==> vendor missing; running fixtures vendor"
  bash scripts/vendor-sources.sh --from-fixtures
fi

export DOCSITE_ROOT="${ROOT}"
export VENDOR_DIR="${ROOT}/src/vendor"

shopt -s nullglob
examples=(examples/*.sh)
if [[ ${#examples[@]} -eq 0 ]]; then
  echo "error: no examples/*.sh found" >&2
  exit 1
fi

failed=0
for ex in "${examples[@]}"; do
  echo "==> RUN ${ex}"
  if bash "${ex}"; then
    echo "    OK  ${ex}"
  else
    echo "    FAIL ${ex}" >&2
    failed=1
  fi
done

if [[ "${failed}" -ne 0 ]]; then
  echo "one or more examples failed" >&2
  exit 1
fi
echo "==> all ${#examples[@]} example(s) passed"
