# How this site is built

## Pipeline

```
fleet-config (private)  ──vendor──►  src/vendor/**  ──mdbook build──►  book/
CONFORMANCE-SPEC.md  ─────┘              ▲
                                         │
                              fixtures/** (public-safe fallback)
```

1. **`scripts/vendor-sources.sh`** — fetches or copies sources into
   `src/vendor/`, writes `SOURCE-PIN.md` with commit SHA / mode.
2. **`scripts/check-book-links.py`** — fails on broken internal markdown links
   (offline-safe; external http links are not fetched).
3. **`mdbook build`** — renders HTML under `book/`.
4. **`scripts/run-examples.sh`** — runs every script under `examples/`; failure
   fails CI.
5. **`cargo test`** — structural tests on vendored (or fixture) ruleset JSON.

## Modes

| Flag / env | Behaviour |
|---|---|
| `--from-fleet-config` | Clone/copy private `tzervas/fleet-config` (needs network + token or local path) |
| `--from-fixtures` | Use `fixtures/` only — **public CI default** |
| `FLEET_CONFIG_PATH` | Local checkout to copy from |
| `FLEET_CONFIG_REPO` | Default `tzervas/fleet-config` |
| `FLEET_CONFIG_REF` | Git ref (default `dev`) |
| `CONFORMANCE_SPEC_PATH` | Path to `CONFORMANCE-SPEC.md` if not in fleet-config |
| `OVERRIDES_PATH` | Path to `OVERRIDES.md` if not yet in fleet-config |

## Public repo safety

Measured: **docsite is PUBLIC**, **fleet-config is PRIVATE**.

- `src/vendor/` is **gitignored**.
- CI without `FLEET_CONFIG_READ_TOKEN` uses fixtures and **must not** attempt to
  publish private HTML to GitHub Pages or any public host.
- Operators with private-read access render fully **locally** (or on a private
  runner with the token) and host the HTML on a self-hosted path if needed.

## Tooling

- [mdBook](https://rust-lang.github.io/mdBook/) (FOSS, self-hosted)
- `scripts/check-book-links.py` (internal link gate; mdbook-linkcheck 0.7 is not compatible with mdBook 0.5)
- No JS site generator; no SaaS doc host required
