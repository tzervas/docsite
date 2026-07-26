# How do I comply?

Concise checklist. Each item links to the deep source page.

## Every PR

1. **Target `dev`**, not `main`, for features and fixes.
2. **Squash-merge into `dev`**. Use conventional commits.
3. **Do not squash** when promoting `dev` → `main` — use a **merge commit**.
4. Prefer `Refs #n` on non-main PRs; `Closes #n` only on main-bound work.
5. Write only files you own; report cross-ownership defects.

Deep: [Branch and release contract](vendor/policies/BRANCH-AND-RELEASE-CONTRACT.md).

## Every test change

1. Allocate effort by **risk** (complexity × fragility × blast radius), not by line %.
2. Prefer contract, adversarial, and regression tests that make silence loud.
3. Never delete or skip a failing test to go green.
4. Never assert a mock as if it were the dependency.

Deep: [Testing policy](vendor/policies/TESTING-POLICY.md).

## Every workflow / ruleset change

1. Use the two canonical rulesets; do not invent a third.
2. **Never** require a status context the repo does not emit.
3. Every self-hosted compile job carries an **explicit tier label**
   (e.g. `small`, `medium`, `large`) — not only `self-hosted, linux, x64, podman`.
4. No `cancel-in-progress` on **scheduled** workflows.
5. No `continue-on-error: true` / `|| true` on security, lint, or test steps.

Deep: [Rulesets](vendor/rulesets/README.md), [Conformance](vendor/conformance/CONFORMANCE-SPEC.md).

## Every intentional exception

1. Prefer profile or repo override over forking the baseline.
2. Record `reason` (required) and, when temporary, `expires`.
3. Put the deviation in `.fleet-conformance.yaml` or adjacent to the setting.

Deep: [Overrides](vendor/rulesets/OVERRIDES.md).

## Verify locally

Runnable examples used by CI — run them before you claim compliance:

```bash
./scripts/run-examples.sh
./scripts/build-book.sh --from-fixtures   # or --from-fleet-config
```

See [Runnable examples](examples/index.md).
