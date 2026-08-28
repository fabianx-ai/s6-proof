#!/usr/bin/env python3
"""List every unresolved publication marker in the release tree."""
from __future__ import annotations
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
skip_parts = {'.git', '.lake'}
rows: list[str] = []
for path in sorted(ROOT.rglob('*')):
    if path == ROOT / 'checks' / 'placeholders.txt':
        continue
    if not path.is_file() or any(part in skip_parts for part in path.parts):
        continue
    try:
        text = path.read_text(errors='strict')
    except (UnicodeDecodeError, OSError):
        continue
    for lineno, line in enumerate(text.splitlines(), 1):
        needle = 'PLACE' + 'HOLDER'
        if needle in line:
            rows.append(f'{path.relative_to(ROOT)}:{lineno}:{line}')
print('\n'.join(rows))
print(f'UNRESOLVED_MARKER_COUNT={len(rows)}')
# A publication run must pass --require-zero.
if '--require-zero' in sys.argv and rows:
    raise SystemExit(1)
