# Branch, ownership, and release contract

> **Fixture document.** This is a public-safe stub used when the private
> `tzervas/fleet-config` source is unavailable. It preserves structure for
> link checks and reader navigation. It is **not** the operative policy.
> Render with `./scripts/build-book.sh --from-fleet-config` for the real text.

## 1. The flow — one direction, no shortcuts

```
work branch  --SQUASH-->  dev  --MERGE COMMIT-->  main  --(authorized)-->  release
```

| edge | mode |
|---|---|
| work branch → `dev` | **squash** |
| `dev` → `main` | **merge commit — never squash** |
| `main` → `dev`/`sec` | **merge, never reset or force** |

Squashing the promote rewrites ancestry and destroys the merge base — measured
fleet damage; see the real policy for the incident table.

## 2. Ownership — disjoint by construction

> **Read anything. Write only what you own.**

## 3. Releases

Release process, gates, and version policy live in the real fleet-config
document. Do not invent alternate flows from this fixture.

## See also

- [Testing policy](../policies/TESTING-POLICY.md)
- [Rulesets](../rulesets/README.md)
