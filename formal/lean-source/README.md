# Companion Lean project - verified V10 source

This directory contains the V10 Lean source accompanying
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
replaced by an explicit kernel-checked proof using extensionality, finite case splits, and `norm_num`.
The tree also contains
`S6/AxiomAudit.lean`, which prints the axiom dependencies of the exported certificates.

The modified V10 tree is covered by the completed build and per-theorem axiom records in
`../BUILD_REPORT_V10.md`, `../lean-build-v10.log`, and `../AXIOM_REPORT_V10.txt`. Those records identify
the exact built-source commit and source-tree digest. The successful historical evidence under
`../archive/b3c0a190/` applies only to the archived pre-V10 checkout.

## Reproduction commands

```sh
lake clean
lake exe cache get
lake build
lake env lean S6/AxiomAudit.lean > ../AXIOM_REPORT_V10.txt 2>&1
```

The complete output and environment identity are recorded in `../BUILD_REPORT_V10.md` and
`../lean-build-v10.log`. See `../LEAN_SCOPE.md` and `../REPRODUCE.md` for the precise boundary and
reproduction details.
