# Fleet policy documentation

This site is the **reader-facing** view of the fleet's operating rules: branch
flow, release gates, testing policy, GitHub rulesets, and conformance.

It is not a copy of those rules. The pages under **Policies**, **Rulesets**, and
**Conformance** are **vendored at build time** from the private source of truth
[`tzervas/fleet-config`](https://github.com/tzervas/fleet-config) (and, when
present, the conformance specification). Every build records which commit it
pulled — see [Build source pin](vendor/SOURCE-PIN.md).

## What are these rules?

| Area | What it decides | Source in fleet-config |
|---|---|---|
| **Branch & release** | Work → `dev` (squash) → `main` (merge commit); ownership; release gates | `policies/BRANCH-AND-RELEASE-CONTRACT.md` |
| **Testing** | Risk-weighted testing; **no** coverage-percentage gate | `policies/TESTING-POLICY.md` |
| **Rulesets** | Two rulesets for four branch classes; how to apply them | `rulesets/README.md`, `rulesets/*.json` |
| **Overrides** | baseline → profile → repo override, with required reasons | `rulesets/OVERRIDES.md` |
| **Conformance** | conformant / deviation (recorded) / drift | conformance spec (vendored) |

## Which apply to me?

Short answer: **all of them**, unless your repo has a **recorded deviation**
(see [Which rules apply to me?](which-apply.md)).

- If you open PRs, own files, or cut releases → **branch & release contract**.
- If you write or review tests → **testing policy**.
- If you touch branch protection or required checks → **rulesets + overrides**.
- If you audit "is this repo aligned?" → **conformance three-state model**.

## How do I comply?

See [How do I comply?](how-to-comply.md) for the checklist. The deep material
behind each item is linked from that page; start there, drill down only when you
need the full text.

## Visibility and local builds

| Repository | Visibility (measured) |
|---|---|
| `tzervas/docsite` (this repo) | **PUBLIC** |
| `tzervas/fleet-config` (source of truth) | **PRIVATE** |

Because the docsite is public, **vendored private policy text is never
committed**. Full renders with real fleet-config content are for **local or
token-authenticated CI only**. Public CI without a private-read token builds
from **fixtures** so the pipeline still exercises links and examples without
leaking private content.

```bash
# Local full render (requires read access to private fleet-config)
./scripts/build-book.sh --from-fleet-config

# Public / unauthenticated render (fixtures only)
./scripts/build-book.sh --from-fixtures

# Serve
mdbook serve --open
```

## Honest build status

The site is **rendered by mdBook** when you run the build scripts. The HTML
output lives under `book/` (gitignored). If you are reading a GitHub clone
without running the build, you are looking at the **source tree**, not the
rendered site.
