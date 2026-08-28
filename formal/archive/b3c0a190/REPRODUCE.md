# Reproducing the checks

## Lean

Requirements: Elan and network access for the first dependency/cache fetch.

From `formal/lean-source/`:

```text
lake exe cache get
lake build
```

The included `lean-toolchain`, `lakefile.toml`, and `lake-manifest.json` pin Lean 4.31.0-rc1 and
Mathlib commit `0531bb79fea20efc9ce6942db46b96be5a919400`.

Expected terminal line:

```text
Build completed successfully (... jobs).
```

The job count may vary with cache state; success is exit code 0. Do not run `lake update` before the
reproduction pass.

## Finite certificates

From the release root:

```text
python3 -m venv .verifier-venv
.verifier-venv/bin/pip install -r requirements-verifier.txt
.verifier-venv/bin/python checks/verify_certificates.py
```

Expected final line:

```text
All exact finite certificates passed.
```

## Audit arithmetic

From the release root:

```text
.verifier-venv/bin/python checks/audit_checks.py
```

Every named package block should report `PASS`.

## Paper

From `paper/`:

```text
latexmk -pdf -interaction=nonstopmode -halt-on-error s6_short_proof_v9.tex
```

## Integrity

From the release root:

```text
sha256sum -c MANIFEST.sha256
```

The manifest deliberately does not list itself or the enclosing ZIP.
