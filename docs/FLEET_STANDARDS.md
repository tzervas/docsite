# Fleet standards (docsite)

- Product docs site: **mdBook** (see `book.toml`, `scripts/build-book.sh`).
- CI: `.github/workflows/docs.yml` + `fleet-ci.yml` + `fleet-security.yml`.
- Self-hosted jobs require an **explicit tier label** (`small` / `medium` / …).
- No `cancel-in-progress` on scheduled workflows (`fleet-security`).
- Private content from `fleet-config` is vendored at build time; never committed.
