# Version 10 verification report

## Paper build

- LaTeX engine: pdfTeX 1.40.26 through latexmk 4.86.
- Result: successful build, 29 A4 pages.
- LaTeX diagnostics: no unresolved references, undefined citations, overfull boxes, or underfull boxes.
- PDF preflight: openable, unencrypted, text-based, no forms, all fonts embedded.
- Visual verification: all 29 pages rendered; the full contact sheet and changed pages were inspected with no clipping, collisions, or malformed figures.

## Mathematical finite checks

- `checks/verify_certificates.py`: all 21 exact finite certificates passed.
- `checks/audit_checks.py`: all named arithmetic and symbolic audit blocks passed.
- These checks do not substitute for L1-L6.

## Source-interface patch

The V10 paper now names the pi1-level invariant closure, the geometric zero-winding calculation, Theorem B.1,
Proposition 7.14, the CDP non-torsion proviso, the free parameter `c0`, and the convention-dependent finite
bases. The supplied Claude Fable review is archived under `audits/reviews/`; L1, L5, L6, and CDP remain marked
`PATCH` for a final V10 source-fidelity reread.

## Formal source refactor

- `checks/formal-source-scan.txt`: 32 proposed `decide` proofs; no current `native_decide`, `sorry`, `admit`, or `unsafe` matches.
- `formal/SOURCE_TREE_V10.sha256`: per-file manifest for the modified Lean source.
- Static scans are not a substitute for compilation or a kernel axiom report.

## Formal build gate

**PLACEHOLDER:** the modified V10 Lean source was not compiled in this environment. The current bundle contains
proposed `decide` replacements, a source-tree hash, and an axiom-audit driver. Codex must close the build and
axiom fields in `formal/BUILD_REPORT_V10.md` before publication. Historical successful build evidence is
preserved separately and does not attest V10.

## Source identity

The external source remains pinned at SHA-256:

`283bba102dd1d5dc346af81b28145bdaaea6654398d5032e76e97bafb9a858f2`

Raw source bytes are not redistributed. `checks/verify_source_identity.py` checks internal metadata consistency
and optionally verifies a local copy byte-for-byte.

## Publication placeholders

Run `python checks/scan_placeholders.py` for the complete current list (29 marker occurrences in this pre-publication bundle). The final Zenodo candidate must make
`python checks/scan_placeholders.py --require-zero` exit successfully.
