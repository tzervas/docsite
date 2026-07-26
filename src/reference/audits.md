# Audit scripts

Fleet audit scripts live in **`fleet-config/scripts/`** (private). They are
**not** vendored into this public docsite tree — mdBook would copy them into
HTML output, and token/ops helpers must not ship that way.

Typical scripts (names may grow over time; confirm in fleet-config at the pin):

| Script | Purpose |
|---|---|
| `audit-automerge.sh` | Automerge / merge-queue posture audit |
| `audit-version-policy.sh` | Version / commitizen policy audit |
| `check-md-links.py` | Markdown link resolution |
| `triage-open-prs.sh` | Open PR triage helpers |

**Do not copy-paste these into product repos.** Invoke them from a checkout of
fleet-config so behaviour cannot drift from the source of truth.

Build pin for the policy text you are reading: [SOURCE-PIN](../vendor/SOURCE-PIN.md).
