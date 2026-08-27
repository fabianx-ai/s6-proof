# Projectors and Unit Defect in the Proposed Complex Six-Sphere Construction

This repository contains a short structural reorganization of the proposed
complex structure on the smooth six-sphere.

## Deliverables

- `s6_short_proof.tex` - publication-ready LaTeX source.
- `s6_short_proof.pdf` - compiled 20-page paper.
- `S6Shortcuts.lean` - a no-placeholder Lean scaffold for the finite matrix and
  arithmetic certificates.
- `verify_certificates.py` - exact SymPy verification of the same finite core.
- `verification-report.txt` - output from the successful exact check.
- `AUDIT_CHECKLIST.md` - the remaining analytic and integral verification
  boundary, organized for independent review.

## Mathematical status

The original 108-page manuscript has not yet received an independent community
verification and conflicts with a published result of Campana-Demailly-Peternell.
The paper therefore makes a precise distinction:

1. The **local analytic construction package** contains the period family, the
   toric cusp quotient, the two logarithmic transforms, and the integral
   specialization data.
2. Conditional on that package, the paper gives a short proof that the resulting
   compact complex threefold is diffeomorphic to the standard `S^6`.
3. The finite algebraic core is independently checked exactly and is supplied as
   a Lean formalization scaffold.

The central new shortcuts are:

- the two twist vectors are cyclic Reynolds projections of one primitive seed;
- the cusp is a square-zero rank-two exchange with a unimodular transfer matrix;
- the global topology is controlled by the unit defect
  `p = 12*l0 - 4*l1 - 3*l2 = -1`;
- the generic projected-seed defect for orders `(m,n)` is `m-n`.

## Build the paper

```bash
python /home/oai/skills/pdfs/scripts/latex_to_pdf.py \
  s6_short_proof.tex -o s6_short_proof.pdf
```

A standard alternative is:

```bash
latexmk -pdf s6_short_proof.tex
```

## Verify the exact finite certificates

```bash
python verify_certificates.py
```

All checks passed in the artifact-generation environment.

## Check the Lean file

Copy `S6Shortcuts.lean` into a recent Mathlib checkout and run:

```bash
lake env lean S6Shortcuts.lean
```

The artifact-generation environment did not contain Lean or Mathlib, so the Lean
file could not be compiled here. The file uses only `import Mathlib`, explicit
finite matrices, `native_decide`, `norm_num`, and `ring`; it contains no `sorry`,
`admit`, or custom axioms.

## Suggested review order

1. Run the finite Python and Lean certificates.
2. Audit the period torsors and the global lattice inequality.
3. Audit holomorphic extension and proper discontinuity at the cusp.
4. Audit freeness and signs in the two logarithmic transforms.
5. Audit the order-four integral specialization index.
6. Audit the common sign and integral generators in the three Leray
   transgressions.
7. Only then treat the final recognition theorem as unconditional.

## Public release

The files are prepared for public review. No copyright license has been selected
on the authors' behalf; add the intended license before publishing or opening a
public repository.
