# Projectors and Unit Defect in the Proposed Complex Six-Sphere Construction - Version 10

Public repository: https://github.com/fabianx-ai/s6-proof

This bundle contains Version 10 of the short paper, the companion Lean source, exact finite checkers,
source-interface audit packages, the supplied Claude Fable V9 review that motivated this patch, and the
immutable identity record for the external 108-page source.

Version 10 is intentionally a **pre-publication candidate**: the paper is built, but the modified Lean tree has
not been rebuilt under its pinned environment. Every missing formal result is marked `PLACEHOLDER` and can be
found with `checks/scan_placeholders.py`.

## Version 10 changes

- Uses the monodromy-invariant closure of the cusp vanishing lattice at the pi1 interface.
- Makes the geometric zero-winding content of `ell0 = 0` explicit.
- Routes the Leray package through Theorem B.1 and Proposition 7.14 before Propositions 7.26-7.27.
- Restores and discharges the CDP non-torsion proviso.
- Credits and sharpens the split-extension comparison.
- Exposes the admissible period parameter `c0` and condition `(beta3)`.
- Distinguishes canonical projectors from the chosen seed and records the complete seed-integrality lattice.
- Makes determinant, basis, signature, and freeness conventions explicit.
- Proposes kernel-reducible replacements for all concrete native computation certificates and adds an axiom
  audit driver; the fresh build remains a visible publication gate.

## Contents

- `paper/s6_short_proof_v10.pdf` - rendered paper.
- `paper/s6_short_proof_v10.tex` - self-contained LaTeX source.
- `sources/` - immutable identity metadata for the linked, non-redistributed source manuscript.
- `formal/lean-source/` - proposed V10 Lean tree.
- `formal/archive/b3c0a190/` - historical pre-V10 source and successful build evidence.
- `formal/BUILD_REPORT_V10.md`, `AXIOM_REPORT_V10.txt`, `lean-build-v10.log` - current publication gates.
- `formal/SOURCE_TREE_V10.sha256` - current Lean source-tree manifest.
- `audits/templates/` - blank operational receipts; not evidence.
- `audits/reviews/` - supplied completed review documents.
- `audits/STATUS.md` - separate interface-fidelity and independent-verification statuses.
- `checks/` - exact checkers, source-identity check, and placeholder scanner.
- `MANIFEST.sha256` - final release-tree integrity manifest.

## Building the paper

```sh
cd paper
latexmk -pdf -interaction=nonstopmode -halt-on-error s6_short_proof_v10.tex
```

## Exact non-Lean checks

```sh
python checks/verify_certificates.py
python checks/audit_checks.py
python checks/verify_source_identity.py
python checks/scan_placeholders.py
```

## Formal publication gate

Follow `formal/REPRODUCE.md`. The required fresh V10 build and axiom report must replace every formal
`PLACEHOLDER`. Do not use the historical pre-V10 build log as evidence for the modified source.

## Final release gate

Before GitHub/Zenodo publication:

1. run the pinned Lean build and axiom audit;
2. replace all `PLACEHOLDER` values with actual evidence;
3. run `python checks/scan_placeholders.py --require-zero`;
4. rebuild the paper and rerun all exact checks;
5. regenerate `MANIFEST.sha256`;
6. update and tag the public repository atomically.
