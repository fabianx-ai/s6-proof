# Projectors and Unit Defect in the Proposed Complex Six-Sphere Construction - Version 10

Public repository: https://github.com/fabianx-ai/s6-proof

This bundle contains Version 10 of the short paper, the companion Lean source, exact finite checkers,
source-interface audit packages, the supplied Claude Fable V9 review that motivated this patch, and the
immutable identity record for the external 108-page source.

Version 10's formal gate is closed: the repaired Lean tree was rebuilt and audited under its pinned
environment at built-source commit `b6220d0fd6b301b2df2082a91885513945126f45`, with aggregate source-tree
digest `37d55a7a16aa29bf11cc291bdca8a20c98192bb18883b5da171bc25c449a55f1`. The TeX source records this
evidence. The bundled PDF was rebuilt from that updated TeX with latexmk 4.83 and pdfTeX 1.40.25. It has 29
A4 pages, carries the verified formal-release paragraph, and passes the refreshed preflight and text/font
regression checks under `checks/`.

## Version 10 changes

- Uses the monodromy-invariant closure of the cusp vanishing lattice at the pi1 interface.
- Makes the geometric zero-winding content of `ell0 = 0` explicit.
- Routes the Leray package through Theorem B.1 and Proposition 7.14 before Propositions 7.26-7.27.
- Restores and discharges the CDP non-torsion proviso.
- Credits and sharpens the split-extension comparison.
- Exposes the admissible period parameter `c0` and condition `(beta3)`.
- Distinguishes canonical projectors from the chosen seed and records the complete seed-integrality lattice.
- Makes determinant, basis, signature, and freeness conventions explicit.
- Uses explicit kernel-checked replacements for all concrete native-computation certificates and includes a
  62-name axiom-audit driver; the pinned rebuild and trust-boundary audit pass with evidence under `formal/`.

## Contents

- `paper/s6_short_proof_v10.pdf` - rendered paper.
- `paper/s6_short_proof_v10.tex` - self-contained LaTeX source.
- `sources/` - immutable identity metadata for the linked, non-redistributed source manuscript.
- `formal/lean-source/` - repaired and verified V10 Lean tree.
- `formal/archive/b3c0a190/` - historical pre-V10 source and successful build evidence.
- `formal/BUILD_REPORT_V10.md`, `AXIOM_REPORT_V10.txt`, `lean-build-v10.log` - completed build and axiom evidence.
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
python3 -m venv /tmp/s6-verifier-venv
/tmp/s6-verifier-venv/bin/python -m pip install -r requirements-verifier.txt
/tmp/s6-verifier-venv/bin/python checks/verify_certificates.py
/tmp/s6-verifier-venv/bin/python checks/audit_checks.py
/tmp/s6-verifier-venv/bin/python checks/verify_source_identity.py
/tmp/s6-verifier-venv/bin/python checks/scan_placeholders.py
```

The recorded V10 checks used Python 3.12.3 with SymPy 1.12 in that verifier environment. The ambient system
Python on the verification host did not include SymPy.

## Formal verification

The pinned clean build and 62-name axiom audit completed successfully; see `formal/BUILD_REPORT_V10.md`,
`formal/AXIOM_REPORT_V10.txt`, and `formal/lean-build-v10.log`. Historical pre-V10 evidence remains provenance
only and does not attest the modified source.

## Final release gate

The local build, evidence, PDF, marker, and integrity gates are closed. Before GitHub/Zenodo publication,
Fabian's remaining outward steps are:

1. verify the publication checkout with `sha256sum -c MANIFEST.sha256`;
2. update and tag the public repository atomically.
