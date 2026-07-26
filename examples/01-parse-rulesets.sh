#!/usr/bin/env bash
# Prove every vendored ruleset JSON parses and carries the fields the model needs.
set -euo pipefail

ROOT="${DOCSITE_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
RS="${VENDOR_DIR:-${ROOT}/src/vendor}/rulesets"

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required" >&2
  exit 1
fi

mapfile -t files < <(find "${RS}" -maxdepth 1 -name '*.json' | sort)
if [[ ${#files[@]} -eq 0 ]]; then
  echo "no ruleset JSON under ${RS}" >&2
  exit 1
fi

for f in "${files[@]}"; do
  jq empty "${f}"
  name="$(jq -r '.name // empty' "${f}")"
  target="$(jq -r '.target // empty' "${f}")"
  enforcement="$(jq -r '.enforcement // empty' "${f}")"
  if [[ -z "${name}" || -z "${target}" || -z "${enforcement}" ]]; then
    echo "missing name/target/enforcement in ${f}" >&2
    exit 1
  fi
  # Must declare at least one rule.
  count="$(jq '.rules | length' "${f}")"
  if [[ "${count}" -lt 1 ]]; then
    echo "rules array empty in ${f}" >&2
    exit 1
  fi
  echo "OK  ${f}  name=${name} rules=${count}"
done
