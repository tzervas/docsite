# Runnable examples

Every example under `examples/` is executed by `scripts/run-examples.sh` in CI.
An example that does not run is a **bug**.

## Catalogue

| Script | What it proves |
|---|---|
| `examples/01-parse-rulesets.sh` | Vendored/fixture ruleset JSON parses (`jq empty`) and has required fields |
| `examples/02-two-ruleset-model.sh` | Exactly the two canonical ruleset names are present |
| `examples/03-conformance-states.sh` | Three-state model (conformant / deviation / drift) is machine-checkable |
| `examples/04-runner-tier-label.sh` | Self-hosted job examples require an explicit tier label |

Run them:

```bash
./scripts/vendor-sources.sh --from-fixtures   # or --from-fleet-config
./scripts/run-examples.sh
```

Rust structural tests (also CI):

```bash
cargo test
```
