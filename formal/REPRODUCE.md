# Reproducing the V10 formal layer

## Pinned toolchain

- Lean: `leanprover/lean4:v4.31.0-rc1`
- Mathlib: `0531bb79fea20efc9ce6942db46b96be5a919400`

## Commands

```bash
python3 -m venv /tmp/s6-verifier-venv
/tmp/s6-verifier-venv/bin/python -m pip install -r requirements-verifier.txt
cd formal/lean-source
lake clean
lake exe cache get
lake build
lake env lean S6/AxiomAudit.lean > ../AXIOM_REPORT_V10.txt 2>&1
/tmp/s6-verifier-venv/bin/python verify_certificates.py
```

Then record the Git commit, clean/dirty state, Lean commit, source-tree digest, command output, exit code, and
per-theorem axiom set in `../BUILD_REPORT_V10.md` and `../lean-build-v10.log`.

## Verified V10 result

The Lean build and axiom commands were run on 2026-08-28 for built-source commit
`b6220d0fd6b301b2df2082a91885513945126f45`, using Lean commit
`fd009949156901e6cf15b6d9bf1122294b8e697a` and aggregate source-tree digest
`37d55a7a16aa29bf11cc291bdca8a20c98192bb18883b5da171bc25c449a55f1`. The build exited successfully with
`Build completed successfully (8517 jobs).` The 62-name audit reported the axiom union
`{propext, Classical.choice, Quot.sound}` and no generated computation/compiler-trust axiom.

Complete output is preserved in `../lean-build-v10.log`, `../AXIOM_REPORT_V10.txt`, and
`../BUILD_REPORT_V10.md`. The archived pre-V10 evidence remains provenance only. Any change to the manifested
Lean source requires a new digest, build, and axiom run.

The recorded finite-checker run used Python 3.12.3 and SymPy 1.12 in `/tmp/s6-verifier-venv`. The ambient
system Python on the verification host lacked SymPy, so it was not used as evidence for that checker. Ensure
that Elan's `lake` shim is on PATH for the portable commands above; this host lacked the shim, so the verified
run used the exact pinned launcher path recorded in `BUILD_REPORT_V10.md` and `lean-build-v10.log`.
