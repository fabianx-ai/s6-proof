# Companion Lean project

This directory contains the pinned Lean project accompanying Version 9 of
*Projectors and Unit Defect in the Proposed Complex Six-Sphere Construction*.

The project formalizes selected reusable algebraic interfaces and concrete finite certificates:

- cyclic Reynolds averaging and invariant observables;
- square-zero exchange and preservation of a bilinear form;
- lattice cokernel/index arithmetic for the cusp matrix;
- two-exceptional-fibre defect arithmetic;
- final low-degree filtration bookkeeping once the geometric inputs are supplied;
- abelianization of split extensions through monodromy coinvariants;
- concrete matrices, projectors, twists, inverse matrices, and `p = -1`.

It does **not** formalize the analytic period family, toric and logarithmic fillings, global
Hausdorff assembly, geometric boundary maps, nearby cycles, or the full theorem that the resulting
complex threefold is the standard smooth six-sphere. See `../LEAN_SCOPE.md` for a theorem-by-theorem
coverage map and `../REPRODUCE.md` for the pinned build instructions.

Default build:

```sh
lake exe cache get
lake build
```

The supplied audit records a successful build under the pinned environment. Do not run
`lake update` before attempting to reproduce it.
