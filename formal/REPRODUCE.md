# Reproducing the V10 formal layer

## Pinned toolchain

- Lean: `leanprover/lean4:v4.31.0-rc1`
- Mathlib: `0531bb79fea20efc9ce6942db46b96be5a919400`

## Commands

```bash
cd formal/lean-source
lake clean
lake build
lake env lean S6/AxiomAudit.lean > ../AXIOM_REPORT_V10.txt 2>&1
python verify_certificates.py
```

Then record the Git commit, clean/dirty state, Lean commit, source-tree digest, command output, exit code, and
per-theorem axiom set in `../BUILD_REPORT_V10.md` and `../lean-build-v10.log`.

## Current status

**PLACEHOLDER:** these V10 commands have not been run in the present environment. Historical pre-V10 evidence
is preserved under `archive/b3c0a190/` and must not be represented as evidence for the modified tree.
