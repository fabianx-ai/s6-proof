# Semantic scope of the companion Lean project

The project builds a useful algebraic library around the short proof. A successful build certifies
the Lean statements below; it does not by itself identify those statements with every geometric
object in the paper. This note records the intended correspondence theorem by theorem.

## What is formalized

### `S6.CyclicAverage`

Formalizes finite cyclic averaging over a field in which the orbit length is invertible. It proves:

- the average is fixed by the cyclic operator;
- the average is idempotent;
- its range is the fixed subspace;
- invariant linear observables commute with averaging;
- the concrete order-three and order-four matrices reproduce the projectors used in the paper.

This is the reusable formal core of the projector shortcut.

### `S6.SquareZeroExchange`

For a square-zero endomorphism `N`, formalizes the exchange family `E_s = I + sN`, including:

- `E_s E_t = E_{s+t}`;
- inverse `E_{-s}`;
- preservation of a bilinear form under the stated infinitesimal and quadratic identities;
- the concrete cusp exchange and preservation of `Q0`.

### `S6.LatticeOrbitIndex`

Formalizes the determinant/index calculation for a full-rank integral lattice map and proves that
the concrete matrix `B0` has a one-element cokernel. The geometric interpretation of this cokernel
as the set of toric component orbits remains an imported theorem from the source construction.

### `S6.TwoExceptionalGluing`

Formalizes:

- the defect `mn ell0 - n ellM - m ellN`;
- the common-seed identity and consecutive-order unit defect;
- the Smith/Bézout classification of the abelian relation cokernel by `ZMod |p|`;
- commutativity of the literal group given by the three-generator presentation;
- preservation of the two signed projected-seed observables.

One semantic bridge is still absent: the file proves that the literal presented group is abelian
and separately classifies a relation cokernel, but it does not yet provide an explicit equivalence
between `PresentedGluingGroup` and the multiplicative relation-cokernel object `GluingGroup`. The
paper supplies the elementary elimination argument at this point.

### `S6.UnitTransgression`

Formalizes the final filtration-consumption step: once a `LowDegreeFiltration` object supplies the
repaired low-degree graded pieces, their identifications with the kernel/cokernel of multiplication
by `p`, and the required vanishings, unit `p` forces the low-degree groups to be trivial.

It does not construct a Leray spectral sequence, compute nearby cycles, derive the `E2` page, or
prove that the geometric transgressions are multiplication by the same integer `p`. Those are source
theorems imported by the paper.

### `S6.SplitExtension`

Formalizes the abelianization of a split extension as the direct product of the base abelianization
and the monodromy coinvariants of the fibre abelianization. This is the reusable group-theoretic
correction relevant to the CDP discussion.

### `S6Shortcuts`

Checks the concrete finite certificates used in the note:

- orders of `T1`, `T2`, and the square-zero cusp logarithm;
- preservation of `Q0`;
- the explicit cyclic projectors and projected seed vectors;
- their invariant-observable values, including the chosen negative second twist;
- explicit integral inverses for `B0` and the relation matrix;
- defect `p = -1` and the Euler arithmetic.

## What is not formalized

The current project does not formalize:

- construction and descent of the period family of complex two-tori;
- the analytic lattice condition throughout the upper half-plane;
- the proper toric quotient and extension across the cusp;
- the two free logarithmic transforms and their geometric sign conventions;
- the Hausdorff compact global assembly;
- the geometric boundary maps that yield the van Kampen presentation;
- the normalization of the cusp shift `ell0` as a geometric winding class;
- nearby cycles, integral specialization indices, or the Leray spectral sequence;
- normalization-conductor descent of the ghost section;
- the final composition to a homotopy sphere and the standard smooth six-sphere.

These are proved in the cited long source and are imported as theorem interfaces in the short paper.
They are natural targets for subsequent formal modules.

## Build evidence

The supplied `LEAN_BUILD_AUDIT.md`, `LEAN_BUILD_REPORT.md`, and `lean-build.log` record successful
builds under the pinned Lean/Mathlib environment. The environment used to assemble this bundle did
not contain Lean or Lake, so those builds were not independently rerun here.
