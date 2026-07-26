#!/usr/bin/env bash
# Prove the runner-tier rule: self-hosted jobs that compile need an explicit tier.
# Labels must include one of: micro, small, medium, large, xlarge (fleet tiers).
set -euo pipefail

ROOT="${DOCSITE_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

TIERS_RE='(micro|small|medium|large|xlarge)'

# Synthetic workflow snippets (not full YAML) — the check is on the runs-on line.
pass_lines=(
  'runs-on: [self-hosted, linux, x64, podman, small]'
  'runs-on: [self-hosted, linux, x64, podman, medium]'
  'runs-on: ubuntu-latest'
)

fail_lines=(
  'runs-on: [self-hosted, linux, x64, podman]'
  'runs-on: [self-hosted, linux]'
)

has_tier() {
  local line="$1"
  # GitHub-hosted is fine without a fleet tier.
  if [[ "${line}" =~ ubuntu-latest|windows-latest|macos- ]]; then
    return 0
  fi
  if [[ "${line}" =~ self-hosted ]] && [[ "${line}" =~ ${TIERS_RE} ]]; then
    return 0
  fi
  if [[ "${line}" =~ self-hosted ]]; then
    return 1
  fi
  return 0
}

for line in "${pass_lines[@]}"; do
  if has_tier "${line}"; then
    echo "OK  accept: ${line}"
  else
    echo "FAIL should accept: ${line}" >&2
    exit 1
  fi
done

for line in "${fail_lines[@]}"; do
  if has_tier "${line}"; then
    echo "FAIL should reject: ${line}" >&2
    exit 1
  else
    echo "OK  reject: ${line}"
  fi
done

# Also scan this repo's own product workflows for the footgun.
if [[ -d "${ROOT}/.github/workflows" ]]; then
  mapfile -t wf < <(grep -RIn 'runs-on:.*self-hosted' "${ROOT}/.github/workflows" || true)
  for entry in "${wf[@]+"${wf[@]}"}"; do
    [[ -z "${entry}" ]] && continue
    file="${entry%%:*}"
    rest="${entry#*:}"
    line_no="${rest%%:*}"
    content="${rest#*:}"
    if [[ "${content}" =~ self-hosted ]] && ! [[ "${content}" =~ ${TIERS_RE} ]]; then
      # Meta API-only jobs on ubuntu-latest are fine; self-hosted without tier is not.
      echo "FAIL ${file}:${line_no} self-hosted without tier label: ${content}" >&2
      exit 1
    fi
    echo "OK  workflow tier: ${file}:${line_no}"
  done
fi
