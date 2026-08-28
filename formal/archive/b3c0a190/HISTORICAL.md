# Historical formal evidence: pre-V10 checkout

This directory preserves the Lean source and audit artifacts shipped before the V10 trust-boundary refactor.
They attest the historical checkout identified in the accompanying reports; they do **not** attest the modified
V10 Lean tree in `../../lean-source/`.

The verified V10 tree replaces all concrete uses of `native_decide` with explicit kernel-checked arithmetic
proofs. Its current pinned build and per-theorem axiom evidence is recorded in `../../BUILD_REPORT_V10.md`,
`../../AXIOM_REPORT_V10.txt`, and `../../lean-build-v10.log`; the reports inside this archive remain historical
evidence only.
