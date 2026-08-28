# Companion Lean project - V10 source candidate

This directory contains the proposed V10 Lean source accompanying
*Projectors and Unit Defect in the Proposed Complex Six-Sphere Construction*.

The project encodes selected reusable algebraic interfaces and concrete finite certificates:

- cyclic Reynolds averaging and invariant observables;
- square-zero exchange and preservation of a bilinear form;
- lattice cokernel/index arithmetic for the cusp matrix;
- two-exceptional-fibre defect arithmetic;
- final low-degree filtration bookkeeping once the geometric inputs are supplied;
- abelianization of split extensions through monodromy coinvariants;
- concrete matrices, projectors, twists, inverse matrices, and `p = -1`.

It does **not** formalize the analytic period family, toric and logarithmic fillings, global
Hausdorff assembly, geometric boundary maps, nearby cycles, or the theorem that the resulting
complex threefold is the standard smooth six-sphere.

## V10 trust-boundary change

Every concrete use of the compiler-evaluated decision tactic in the historical checkout has been
replaced by a proposed kernel-reducible `decide` proof. The tree also contains
`S6/AxiomAudit.lean`, which prints the axiom dependencies of the exported certificates.

**PLACEHOLDER:** the modified V10 tree has not yet been compiled under the pinned toolchain. The
successful historical evidence applies only to `../archive/b3c0a190/`.

## Required publication commands

```sh
lake exe cache get
lake clean
lake build
lake env lean S6/AxiomAudit.lean > ../AXIOM_REPORT_V10.txt 2>&1
```

Copy the complete output and environment identity to `../BUILD_REPORT_V10.md` and
`../lean-build-v10.log`, repair any failing proof, and replace every remaining `PLACEHOLDER` before
publication. See `../LEAN_SCOPE.md` and `../REPRODUCE.md` for the precise boundary.
