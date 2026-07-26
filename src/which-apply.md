# Which rules apply to me?

Use this page as a filter. Everything below is in force for every tzervas repo
unless a **recorded deviation** says otherwise (see
[Three-state conformance](vendor/conformance/CONFORMANCE-SPEC.md)).

## By role

| I am… | I must know | Deep link |
|---|---|---|
| Opening or reviewing a PR | Work branch → `dev` (squash); never squash promote to `main` | [Branch and release](vendor/policies/BRANCH-AND-RELEASE-CONTRACT.md) |
| Owning a file or interface | Write only what you own; report defects outside ownership | same |
| Writing tests or test policy | Risk-weighted testing; no coverage % gate; silence must be loud | [Testing policy](vendor/policies/TESTING-POLICY.md) |
| Changing CI / required checks | Never require a context the repo does not emit; explicit runner tier | [Rulesets](vendor/rulesets/README.md) |
| Applying branch protection | Two rulesets only: `trunk-default-gated` + `trunk-integration-guarded` | [Rulesets](vendor/rulesets/README.md) |
| Needing a one-off exception | baseline → profile → repo override; **reason required** | [Overrides](vendor/rulesets/OVERRIDES.md) |
| Auditing fleet alignment | conformant / deviation(recorded) / drift — only drift fails | [Conformance](vendor/conformance/CONFORMANCE-SPEC.md) |

## By surface you touch

| You are changing… | Primary rule |
|---|---|
| Branch names, PR targets, merge buttons | Branch & release contract |
| `required_status_checks`, rulesets, `gh api` protection | Rulesets + overrides |
| Workflows, runner labels, scheduled jobs | Testing policy + runner sizing (conformance C6/C7) |
| `.cz.toml`, version files, release tags | Versioning (conformance C4) + branch contract release section |
| `.fleet-conformance.yaml` | Overrides + conformance three-state model |

## Recorded deviation vs drift

| State | Meaning | Action |
|---|---|---|
| **conformant** | Matches the rule | None |
| **deviation (recorded)** | Differs **and** the reason is written in-repo | Still conformant; do not "fix" without a PR arguing the reason |
| **drift** | Differs with no reason | **Failure** — record a deviation or align |

An override without a `reason` is **rejected**, not warned. Details:
[Baselines and overrides](vendor/rulesets/OVERRIDES.md).

## What does *not* apply

- **Coverage percentage gates** — explicitly rejected by testing policy.
- **Four separate rulesets** (one per branch class) — replaced by the two-ruleset model.
- **Auto-adding required checks** that the repo does not emit — forbidden (conformance C3).
