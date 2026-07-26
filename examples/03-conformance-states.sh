#!/usr/bin/env bash
# Machine-check the three-state conformance model against a tiny fixture table.
# States: conformant | deviation_recorded | drift
set -euo pipefail

# Simulated evaluations: (matches_rule, has_reason) → expected state
classify() {
  local matches="$1" reason="$2"
  if [[ "${matches}" == "yes" ]]; then
    echo "conformant"
  elif [[ "${reason}" == "yes" ]]; then
    echo "deviation_recorded"
  else
    echo "drift"
  fi
}

assert_eq() {
  local got="$1" want="$2" label="$3"
  if [[ "${got}" != "${want}" ]]; then
    echo "FAIL ${label}: got=${got} want=${want}" >&2
    exit 1
  fi
  echo "OK  ${label} → ${got}"
}

assert_eq "$(classify yes no)"  conformant          "match without reason"
assert_eq "$(classify yes yes)" conformant          "match with reason (still match)"
assert_eq "$(classify no yes)"  deviation_recorded  "mismatch with recorded reason"
assert_eq "$(classify no no)"   drift               "mismatch without reason"

# Only drift is a failure for auditors.
is_failure() {
  [[ "$(classify "$1" "$2")" == "drift" ]]
}

if is_failure no no; then
  echo "OK  drift is the only failure state"
else
  echo "expected drift to be failure" >&2
  exit 1
fi

for pair in "yes no" "yes yes" "no yes"; do
  # shellcheck disable=SC2086
  if is_failure ${pair}; then
    echo "unexpected failure for ${pair}" >&2
    exit 1
  fi
done
echo "OK  non-drift states are not failures"
