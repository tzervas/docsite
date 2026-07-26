# Rulesets as code

> **Fixture document.** Public-safe stub of the two-ruleset model. The operative
> guide and JSON live in private `tzervas/fleet-config`.

## The map

| ruleset | protects | enforces |
|---|---|---|
| `trunk-default-gated` | `~DEFAULT_BRANCH` (always `main`) | no delete · no force-push · **PR required** · **checks required** |
| `trunk-integration-guarded` | `dev`, `sec`, `release/**` | no delete · no force-push |

**Two rulesets, not four.**

## The one field you must fill per repo

`trunk-default-gated.json` ships with `required_status_checks: []` **on purpose**.

> **Never require a context the repo does not actually emit.**

## See also

- [Overrides](OVERRIDES.md)
- [Canonical JSON note](../../reference/ruleset-json.md)
