#!/usr/bin/env python3
"""Verify the pinned external S6 source identity.

The source PDF is intentionally not redistributed. Without a positional PDF path this program
checks that the release descriptor, checksum file, and LaTeX source all contain the same pinned
SHA-256. With a PDF path it additionally hashes the bytes and fails on any mismatch.
"""
from __future__ import annotations

import hashlib
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
EXPECTED = "283bba102dd1d5dc346af81b28145bdaaea6654398d5032e76e97bafb9a858f2"


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as fh:
        for block in iter(lambda: fh.read(1024 * 1024), b""):
            h.update(block)
    return h.hexdigest()


def need(ok: bool, message: str) -> None:
    if not ok:
        raise SystemExit(f"FAIL: {message}")

record = json.loads((ROOT / "sources" / "SOURCE_IDENTITY.json").read_text())
need(record["sha256"] == EXPECTED, "JSON identity hash drift")
need(record["pages"] == 108, "source page-count record drift")

checksum_line = (ROOT / "sources" / "S6_SOURCE.sha256").read_text().strip()
need(checksum_line.split()[0] == EXPECTED, "checksum file drift")

tex_files = sorted((ROOT / "paper").glob("s6_short_proof_v10.tex"))
need(len(tex_files) == 1, "Version 10 TeX source missing")
tex = tex_files[0].read_text()
need(EXPECTED in tex, "paper does not print the pinned source hash")
need("https://alpo.ge/s6.pdf" in tex, "paper source URL drift")

if len(sys.argv) > 2:
    raise SystemExit("usage: verify_source_identity.py [path/to/s6.pdf]")
if len(sys.argv) == 2:
    source = Path(sys.argv[1])
    need(source.is_file(), f"source PDF not found: {source}")
    actual = sha256(source)
    need(actual == EXPECTED, f"source-byte hash mismatch: {actual}")
    print(f"PASS source bytes: {actual}  {source}")
else:
    print("PASS release identity metadata: descriptor, checksum file, and paper agree")
    print(f"PINNED SHA-256: {EXPECTED}")
    print("RAW SOURCE NOT REDISTRIBUTED: supply a local s6.pdf path to verify its bytes")
