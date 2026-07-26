#!/usr/bin/env bash
# Prove the two-ruleset model: exactly the two canonical names, no extras required.
set -euo pipefail

ROOT="${DOCSITE_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
RS="${VENDOR_DIR:-${ROOT}/src/vendor}/rulesets"

required=(trunk-default-gated trunk-integration-guarded)

for name in "${required[@]}"; do
  f="${RS}/${name}.json"
  if [[ ! -f "${f}" ]]; then
    echo "missing canonical ruleset file: ${f}" >&2
    exit 1
  fi
  got="$(jq -r .name "${f}")"
  if [[ "${got}" != "${name}" ]]; then
    echo "name mismatch in ${f}: got ${got}" >&2
    exit 1
  fi
  echo "OK  ${name}"
done

# default-gated must include a required_status_checks rule (even if empty list)
jq -e '
  .rules
  | map(select(.type == "required_status_checks"))
  | length == 1
' "${RS}/trunk-default-gated.json" >/dev/null
echo "OK  trunk-default-gated has required_status_checks rule"

# integration-guarded must NOT require PR checks (guarded, not gated)
if jq -e '
  .rules
  | map(select(.type == "required_status_checks" or .type == "pull_request"))
  | length == 0
' "${RS}/trunk-integration-guarded.json" >/dev/null; then
  echo "OK  trunk-integration-guarded has no PR/check gates"
else
  echo "trunk-integration-guarded unexpectedly has PR or status-check rules" >&2
  exit 1
fi
