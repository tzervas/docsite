# Ruleset JSON (canonical)

The JSON files below are **vendored** from `fleet-config/rulesets/` at build
time. Do not edit copies in this repo — change fleet-config and rebuild.

## Files

| File | Role |
|---|---|
| `trunk-default-gated.json` | Protects `~DEFAULT_BRANCH` (`main`): no delete, no force-push, PR required, checks required |
| `trunk-integration-guarded.json` | Protects `dev`, `sec`, `release/**`: no delete, no force-push |

On a successful vendor step they live at:

- [`src/vendor/rulesets/trunk-default-gated.json`](../vendor/rulesets/trunk-default-gated.json)
- [`src/vendor/rulesets/trunk-integration-guarded.json`](../vendor/rulesets/trunk-integration-guarded.json)

## Apply (do not hand-write payloads)

See the deep guide: [Two-ruleset model](../vendor/rulesets/README.md).

The apply helper is vendored as `src/vendor/rulesets/apply-rulesets.sh` when
present in the source pin.

## Validation

CI and local examples parse every ruleset JSON with `jq empty` and a Rust
structural test (`cargo test`). An example that does not run is treated as a
bug — see [Runnable examples](../examples/index.md).
