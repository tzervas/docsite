# Fleet conformance specification

> **Fixture document.** Public-safe stub of the three-state conformance model.
> When building with full sources, this is replaced by the operative
> `CONFORMANCE-SPEC.md` (workspace path or fleet-config, once landed).

## The principle that makes this safe

> **Conformance is not uniformity.**

## Three states

| state | meaning |
|---|---|
| **conformant** | matches the rule |
| **deviation (recorded)** | does not match, **and the reason is written down in-repo** — this is conformant |
| **drift** | does not match, with no recorded reason — this is the only failure |

## Rules (fixture catalogue)

| ID | Topic | autofix |
|---|---|---|
| C1 | Branch topology | yes |
| C2 | Trunk protection | yes |
| C3 | Required checks reflect reality | **NO** (never auto-add) |
| C4 | Versioning | partial |
| C5 | Workflow validity | yes |
| C6 | Runner sizing (explicit tier) | yes |
| C7 | Gate honesty | **NO** |
| C8 | Python floor (>3.10) | yes |

## What the detector must never do

- Never auto-add a required check.
- Never "fix" a recorded deviation without arguing the reason.
- Never normalise a published version number.
- Never delete or skip a test to reach conformance.
- Never report `unknown` as `conformant`.
