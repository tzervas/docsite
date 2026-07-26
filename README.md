# docsite — fleet policy documentation (mdBook)

<!-- FLEET-BADGES:BEGIN -->
[![CI](https://github.com/tzervas/docsite/actions/workflows/fleet-ci.yml/badge.svg?branch=main)](https://github.com/tzervas/docsite/actions/workflows/fleet-ci.yml?query=branch%3Amain)
[![Docs](https://github.com/tzervas/docsite/actions/workflows/docs.yml/badge.svg?branch=main)](https://github.com/tzervas/docsite/actions/workflows/docs.yml?query=branch%3Amain)
[![Security](https://github.com/tzervas/docsite/actions/workflows/fleet-security.yml/badge.svg?branch=main)](https://github.com/tzervas/docsite/actions/workflows/fleet-security.yml?query=branch%3Amain)
<!-- FLEET-BADGES:END -->

Reader-first documentation site for the tzervas fleet operating rules.

**Stack:** [mdBook](https://rust-lang.github.io/mdBook/) (Rust, FOSS, self-hosted).  
**Not** a JS site generator. **Not** a SaaS doc host.

## Visibility (measured)

| Repository | Visibility |
|---|---|
| `tzervas/docsite` (this repo) | **PUBLIC** |
| `tzervas/fleet-config` (source of truth) | **PRIVATE** |

Because this repository is public, **private fleet-config content is never
committed**. Builds **vendor at build time** into `src/vendor/` (gitignored).
Public CI without a private-read token uses **fixtures** so links and examples
still run without leaking policy text.

**Full operative policy HTML is for local (or token-authenticated) render only.**
This repo does not publish private content to GitHub Pages.

## What it renders

| Source | Content |
|---|---|
| `fleet-config` `policies/` | Branch/release contract, testing policy |
| `fleet-config` `rulesets/` | Two-ruleset model, overrides, JSON |
| `fleet-config` `scripts/` | Audits (reference) |
| `CONFORMANCE-SPEC.md` | Three-state conformance (path or fixtures) |

Reader front matter (committed here): what the rules are, which apply to you,
how to comply. Deep material is the vendored source pages.

## Quick start

```bash
# Tools (once)
cargo install mdbook

# Public-safe build (fixtures) — vendors, link-checks, mdbook build
./scripts/build-book.sh --from-fixtures

# Full private content (needs read access to fleet-config)
export FLEET_CONFIG_PATH=/path/to/fleet-config   # or rely on clone + token
export CONFORMANCE_SPEC_PATH=/path/to/CONFORMANCE-SPEC.md
export OVERRIDES_PATH=/path/to/rulesets/OVERRIDES.md   # if not yet in fleet-config
./scripts/build-book.sh --from-fleet-config

# Serve
mdbook serve --open
```

## Examples and CI

Every script under `examples/` is executed by `scripts/run-examples.sh`.
CI workflow `.github/workflows/docs.yml`:

- runs-on: `[self-hosted, linux, x64, podman, small]` (**explicit tier**)
- vendors sources
- internal link check (`scripts/check-book-links.py`) — fails the job on broken links
- `mdbook build`
- runs examples
- `cargo test` (ruleset structure + three-state model)

Scheduled `fleet-security` does **not** use `cancel-in-progress`.

## Versioning

0.x.x under Commitizen (`major_version_zero = true`). See `.cz.toml`.
Do not cut or propose 1.x.x.

## License

MIT — see [LICENSE](LICENSE).
