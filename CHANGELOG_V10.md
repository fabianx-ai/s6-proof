# Version 10 patch ledger

Version 10 is a source-interface and formal-trust-boundary patch against canonical Version 9. It does not
change the conditional recognition theorem, the nine-step proof spine, the central diagram, the seven-section
body, or the two unit certificates.

## Paper changes

1. Replaces the abelian H1 identity by Lemma 2.7(iv)'s invariant-closure statement at the fundamental-group
   interface, and derives centrality of the surviving fibre class from invariance of `gamma`.
2. Explains `ell0 = 0` geometrically as the zero winding of the tautological cusp section before introducing
   the normalization `X = X(0)`.
3. Exposes Theorem B.1 and Proposition 7.14 beneath the integral Leray page and states that multiplicativity
   forces the common sign.
4. Restores the non-torsion proviso in the CDP quotation and visibly discharges it with Theorem 10.5(b) and
   Proposition 10.8.
5. Credits the reusable split-extension lemma to source Lemma 10.7 and distinguishes the repairable monodromy
   issue from the conductor failure.
6. Adds the admissible period parameter `c0` and condition `(beta3)` to L1 and the moduli discussion.
7. Describes the projectors as canonical and the seed as chosen; Remark 6.5 records the full common-seed
   integrality locus `b congruent c (mod 6)`.
8. Makes the ordered bases, determinant sign, signature basis, and logarithmic-transform freeness congruences
   explicit.

## Formal repository changes

- Archives the successful pre-V10 Lean checkout and evidence under `formal/archive/b3c0a190/`.
- Replaces all 32 concrete uses of the native computation tactic by explicit kernel-checked arithmetic proofs.
- Adds `formal/lean-source/S6/AxiomAudit.lean`.
- Adds verified V10 build, axiom, and source-tree reports. The successful pinned rebuild and 62-name audit are
  recorded in `formal/BUILD_REPORT_V10.md` and `formal/AXIOM_REPORT_V10.txt`.
- Separates audit templates from supplied reviews and distinguishes interface fidelity from independent theorem
  verification.

## PDF release closure

- Rebuilt the updated self-contained TeX with latexmk 4.83 and pdfTeX 1.40.25; the final document has 29 A4
  pages and the LaTeX log has no unresolved references, undefined citations, overfull boxes, or underfull boxes.
- Made the formal-release paragraph's long commit hashes and evidence paths line-break cleanly without changing
  its mathematical or verification claims.
- Refreshed the PDF preflight and regression receipts. The rebuilt PDF is openable, unencrypted, text-based,
  form-free, and uses 33 embedded fonts; its extracted text contains the verified formal-release evidence and
  omits the legacy unresolved-gate language.
