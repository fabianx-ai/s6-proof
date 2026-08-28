# Version 10 verification report

## Rebuilt PDF receipt

- The updated V10 TeX was rebuilt with pdfTeX 1.40.25 (TeX Live 2023/Debian) through latexmk 4.83; the
  documented `latexmk -pdf -interaction=nonstopmode -halt-on-error` command exited successfully.
- Result: 29 A4 pages; SHA-256
  `1bc0e3900062cb0ea7d4fbf302cd6a1b46dfbe88193026d3c994e84a235e9be2`.
- LaTeX diagnostics: no unresolved references, undefined citations, overfull boxes, or underfull boxes.
- pdfTeX emitted two benign font-expansion ordering warnings; all fonts remain embedded and the rendered pages
  show no corresponding defect.
- PDF preflight: openable, unencrypted, text-based, no forms, all fonts embedded.
- Text regression: the repaired lemma labels and formal-release evidence are present; obsolete theorem labels,
  the former no-compilation sentence, and the legacy unresolved-gate token are absent.
- Visual verification: all 29 pages were rendered in two contact sheets; pages 2 and 23--29 were additionally
  inspected at enlarged or full-page resolution, with no clipping, collisions, or malformed figures.

## Mathematical finite checks

- `checks/verify_certificates.py`: all 21 exact finite certificates passed.
- `checks/audit_checks.py`: all named arithmetic and symbolic audit blocks passed.
- Both were run with Python 3.12.3 and SymPy 1.12 in `/tmp/s6-verifier-venv`; the ambient system Python lacked
  SymPy and was not used as evidence for these two checks.
- These checks do not substitute for L1-L6.

## Source-interface patch

The V10 paper now names the pi1-level invariant closure, the geometric zero-winding calculation, Theorem B.1,
Proposition 7.14, the CDP non-torsion proviso, the free parameter `c0`, and the convention-dependent finite
bases. The supplied Claude Fable review is archived under `audits/reviews/`; L1, L5, L6, and CDP remain marked
`PATCH` for a final V10 source-fidelity reread.

## Formal source repair

- The incoming bundle contained 32 bare `decide` replacements. The first pinned build emitted 22 failure
  diagnostics in `S6Shortcuts`; all 32 bare sites were then replaced uniformly, without changing theorem
  statements, using explicit extensionality, finite case splits, and `norm_num`.
- `checks/formal-source-scan.txt`: zero current `decide` or native-computation tactic invocations and no
  `sorry`, `admit`, custom axiom/constant declaration, or `unsafe` declaration.
- `formal/SOURCE_TREE_V10.sha256`: per-file manifest for the modified Lean source.
- Static scans are supplemented by the pinned build and per-theorem axiom report below.

## Formal build verification

- Built-source Git commit: `b6220d0fd6b301b2df2082a91885513945126f45`.
- Pinned toolchain: Lean 4.31.0-rc1 at commit `fd009949156901e6cf15b6d9bf1122294b8e697a`; Mathlib
  `0531bb79fea20efc9ce6942db46b96be5a919400`.
- Aggregate source-tree digest: `37d55a7a16aa29bf11cc291bdca8a20c98192bb18883b5da171bc25c449a55f1`.
- Clean-source/cache-hydrated `lake build`: exit code `0`; `Build completed successfully (8517 jobs).`
- The axiom driver exited `0` and produced exactly 62 distinct named records. Their union was
  `{propext, Classical.choice, Quot.sound}`.
- No generated computation/compiler-trust axiom was reported; both the prescribed scan and a stronger scan for
  generated reduction/native/sorry axioms returned no matches.
- Complete evidence is in `formal/lean-build-v10.log`, `formal/AXIOM_REPORT_V10.txt`, and
  `formal/BUILD_REPORT_V10.md`.

The release gate exposed a real bundle defect before passing: the first build at
`c9d6263e7018b4273c82942c10b2ab9baf5d1594` exited `1` after 22 bare-`decide` failures in rational matrix
goals. Repair commit `9ba64114f017016be81f55cd0a0c4e6cdffbd740` replaced all 32 bare sites with
explicit kernel-checked proofs. Commit `cb2adf25c8f79e67c5805d71defe8afcf50d4cf2` corrected the hashed
proof-method description, and `b6220d0fd6b301b2df2082a91885513945126f45` corrected the clean/cache/build
reproduction order; the final clean-source build and axiom run use the latter commit.

This verifies the reusable algebraic interfaces and finite certificates named by the audit driver. It does not
formalize the analytic and geometric construction package, and it does not fill the explicit equivalence
between the literal presented gluing group and its classified relation cokernel.

## Source identity

The external source remains pinned at SHA-256:

`283bba102dd1d5dc346af81b28145bdaaea6654398d5032e76e97bafb9a858f2`

Raw source bytes are not redistributed. `checks/verify_source_identity.py` checks internal metadata consistency
and optionally verifies a local copy byte-for-byte. On this host it also passed against the seated source PDF at
the pinned hash above.

## TeX/PDF release status

The PDF was rebuilt from the updated TeX after the LaTeX and PDF-inspection tools were installed. The build
completed successfully, the formal-release paragraph is present, and the refreshed receipts in
`checks/pdf-preflight.txt` and `checks/pdf-regression.txt` describe this exact PDF. The TeX source was adjusted
only to make long hashes and evidence paths line-break cleanly; the final log has no overfull or underfull boxes.

## Publication-marker scan

After the evidence files were installed,
`/tmp/s6-verifier-venv/bin/python checks/scan_placeholders.py --require-zero` reported
`UNRESOLVED_MARKER_COUNT=0` and exited successfully.
