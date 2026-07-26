# Testing policy — risk-weighted, not percentage-driven

> **Fixture document.** Public-safe stub. Operative text is in private
> `tzervas/fleet-config`. Rebuild with `--from-fleet-config` for the real policy.

## Why coverage percentage is the wrong gate

A coverage number counts **lines executed**, not **behaviours verified**.
**No coverage-percentage gate** is fleet policy.

## Allocate test effort by risk

```
risk  =  complexity  ×  fragility  ×  blast radius
```

## Non-negotiables (fixture summary)

1. Never delete or skip a failing test to go green.
2. Never assert the mock.
3. A test must fail before it counts.
4. `empty` and `unknown` are different.

## See also

- [Branch and release](../policies/BRANCH-AND-RELEASE-CONTRACT.md)
- [Conformance](../conformance/CONFORMANCE-SPEC.md)
