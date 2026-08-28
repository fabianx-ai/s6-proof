# Lean build and verification report

Date: 2026-08-27 (Europe/Berlin)  
Checkout: `b3c0a190905948b99206b0e1d08bbe8ce998e4ec` on branch `master`  
Repository state before and after verification: clean

## Result

**PASS. All eight project Lean source files are included in the successful default build.**

The build was an incremental/cache-backed build of the exact checkout, not a deletion-and-rebuild of the 7+ GiB Mathlib cache.

## Pinned environment

- Toolchain declaration: `leanprover/lean4:v4.31.0-rc1`
- Lean: `4.31.0-rc1`, commit `fd009949156901e6cf15b6d9bf1122294b8e697a`, x86_64 Linux release
- Lake: `5.0.0-src+fd00994`
- Mathlib: `0531bb79fea20efc9ce6942db46b96be5a919400`

The interactive shell did not have an Elan `lake` shim on `PATH`. Verification therefore invoked the installed binary belonging to the pinned toolchain directly.

## Lean compilation

Command:

```text
/home/goblin/.elan/toolchains/leanprover--lean4---v4.31.0-rc1/bin/lake build
```

Result:

```text
exit code: 0
Build completed successfully (8517 jobs).
```

The default targets in `lakefile.toml` are `S6Shortcuts` and `S6`. The root `S6.lean` imports every module under `S6/`, so the build covers:

1. `S6Shortcuts.lean`
2. `S6.lean`
3. `S6/CyclicAverage.lean`
4. `S6/LatticeOrbitIndex.lean`
5. `S6/SplitExtension.lean`
6. `S6/SquareZeroExchange.lean`
7. `S6/TwoExceptionalGluing.lean`
8. `S6/UnitTransgression.lean`

## Source-hygiene scan

Project Lean sources, excluding dependencies, were scanned for:

- `sorry` and `admit`;
- custom `axiom`, `axioms`, `constant`, and `constants` declarations;
- unsafe definitions/theorems/opaque declarations.

No matches were found. `git diff --check` also passed. This is a source-text hygiene statement; imported Lean/Mathlib foundations have their normal trusted axioms.

## Exact finite-certificate verifier

Running the auxiliary script with bare system Python failed before checking certificates because SymPy was not installed:

```text
python3 verify_certificates.py
ModuleNotFoundError: No module named 'sympy'
```

The available verifier environment used Python 3.12.3 and SymPy 1.12. With it:

```text
/tmp/s6-verifier-venv/bin/python verify_certificates.py
exit code: 0
All exact finite certificates passed.
```

All 21 named checks passed. A fresh run compared byte-for-byte equal to the checked-in `verification-report.txt`:

```text
diff -u verification-report.txt <(/tmp/s6-verifier-venv/bin/python verify_certificates.py)
exit code: 0
```

Relevant SHA-256 values:

- `verify_certificates.py`: `c20eb7b88baec65f5fa6dbe6e4797305abbe42db6c0091ef9efb0f2a61c14477`
- `verification-report.txt`: `9be525aac0d54898c2b910ed1d42599ff48be46d78eaab78d9cc87809c414f35`

The bundle includes `requirements-verifier.txt` with `sympy==1.12` so this auxiliary check can be reproduced in a fresh Python virtual environment.

## Independent audit arithmetic

The audit's separate exact-arithmetic program also passed under Python 3.12.3/SymPy 1.12:

```text
/tmp/s6-verifier-venv/bin/python audit-evidence/audit_checks.py
exit code: 0
```

It reports PASS for the L2 combinatorial core, L3 finite and source-comparison arithmetic, L1 symbolic/numerical sanity checks, and L4 finite arithmetic/common-sign equations.

## Scope warning

A green Lean build certifies the statements actually encoded in these Lean files. It does not certify the analytic LCP or the printed four-hypothesis form of short Lemma 6.11. `UnitTransgression.lean` encodes the repaired filtration hypotheses explicitly; see `TRUE_AUDIT_REPORT.md`.
