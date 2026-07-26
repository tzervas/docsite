#!/usr/bin/env python3
"""Fail on broken *internal* markdown links under the book src tree.

- Relative targets must exist on disk (anchors stripped).
- http(s), mailto:, and pure-fragment links are skipped (offline-safe).
- SUMMARY.md chapter paths are also verified.

Usage: python3 scripts/check-book-links.py [src_dir]
Exit 0 on success; 1 if any link fails.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

LINK_RE = re.compile(r"(?<!!)\[[^\]]*\]\(([^)]+)\)")
SUMMARY_PATH_RE = re.compile(r"\(([^)]+\.md)\)")


def check_tree(src: Path) -> list[str]:
    failures: list[str] = []
    checked = 0

    # SUMMARY chapter paths
    summary = src / "SUMMARY.md"
    if summary.is_file():
        for m in SUMMARY_PATH_RE.finditer(summary.read_text(encoding="utf-8", errors="replace")):
            rel = m.group(1).split("#", 1)[0].strip()
            if not rel:
                continue
            target = (summary.parent / rel).resolve()
            checked += 1
            if not target.is_file():
                failures.append(f"SUMMARY missing chapter: {rel}")

    for md in sorted(src.rglob("*.md")):
        text = md.read_text(encoding="utf-8", errors="replace")
        for m in LINK_RE.finditer(text):
            raw = m.group(1).strip()
            # split title annotations: url "title"
            url = raw.split()[0].strip("<>") if raw else ""
            if not url or url.startswith(("#", "mailto:", "http://", "https://")):
                continue
            path_part = url.split("#", 1)[0]
            if not path_part:
                continue
            target = (md.parent / path_part).resolve()
            checked += 1
            try:
                target.relative_to(src.resolve())
            except ValueError:
                # allow links that escape src only if the file exists (e.g. repo root)
                pass
            if not target.exists():
                failures.append(f"{md.relative_to(src)} → missing {path_part}")

    print(f"checked {checked} internal link(s) under {src}")
    return failures


def main() -> int:
    src = Path(sys.argv[1] if len(sys.argv) > 1 else "src").resolve()
    if not src.is_dir():
        print(f"error: src dir not found: {src}", file=sys.stderr)
        return 1
    failures = check_tree(src)
    if failures:
        print("BROKEN LINKS:", file=sys.stderr)
        for f in failures:
            print(f"  {f}", file=sys.stderr)
        return 1
    print("OK  all internal links resolve")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
