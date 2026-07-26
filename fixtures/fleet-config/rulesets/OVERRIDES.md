# Baselines and overrides

> **Fixture document.** Public-safe stub. Operative override model lives in
> fleet-config (or the workspace `rulesets/OVERRIDES.md` until it lands there).

## Resolution order

```
baseline   →   profile   →   repo override
```

Later layers replace the fields they name and inherit the rest.

## The rule that keeps overrides honest

> **An override without a `reason` is rejected.**

A deviation *with* a recorded reason is **conformant**; the same deviation
without one is **drift**.

```yaml
# .fleet-conformance.yaml (illustrative fixture)
profile: rust-fleet
overrides:
  versioning:
    major_version_zero: false
    reason: >
      Published at 1.x. major_version_zero would pin the major permanently.
    reviewed: 2026-07-25
```

## See also

- [Rulesets](README.md)
- [Conformance](../conformance/CONFORMANCE-SPEC.md)
