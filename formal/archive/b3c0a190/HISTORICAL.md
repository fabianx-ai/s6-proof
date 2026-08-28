# Historical formal evidence: pre-V10 checkout

This directory preserves the Lean source and audit artifacts shipped before the V10 trust-boundary refactor.
They attest the historical checkout identified in the accompanying reports; they do **not** attest the modified
V10 Lean tree in `../../lean-source/`.

The V10 tree replaces all uses of `native_decide` in the concrete certificate layer with proposed
kernel-reducible `decide` proofs. A fresh pinned build and per-theorem axiom audit are still required and are
marked as unresolved publication gates in the current V10 reports.
