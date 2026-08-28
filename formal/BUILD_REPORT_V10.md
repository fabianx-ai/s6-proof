# V10 Lean build and trust-boundary report

## Status

**PASS — the repaired V10 source completed the pinned clean build and the 62-name axiom audit.**

The incoming V10 bundle proposed 32 bare `decide` proofs. The first pinned build emitted 22 failure diagnostics
in `S6Shortcuts`, where kernel reduction became stuck in rational matrix computations. All 32 bare sites were
then replaced uniformly, without changing a theorem statement, using explicit extensionality, finite case
splits, and `norm_num`. No compiler-evaluated proof tactic was restored.

## Pinned environment

- Built-source Git commit: `b6220d0fd6b301b2df2082a91885513945126f45`
- Working tree at build invocation: the manifested source tree and its source manifests exactly matched HEAD
  (`git diff --quiet` exit `0`); release evidence/prose files outside that tree were being assembled, and the
  generated untracked `formal/lean-source/.lake/` cache was present. The full tree was clean after the release
  commit and cache removal
- Lean toolchain: `leanprover/lean4:v4.31.0-rc1`
- Lean version: `4.31.0-rc1`
- Lean commit: `fd009949156901e6cf15b6d9bf1122294b8e697a`
- Lake version: `5.0.0-src+fd00994`
- Mathlib commit: `0531bb79fea20efc9ce6942db46b96be5a919400`
- V10 Lean source-tree manifest: `formal/SOURCE_TREE_V10.sha256`
- Aggregate source-tree digest: `37d55a7a16aa29bf11cc291bdca8a20c98192bb18883b5da171bc25c449a55f1`

## Commands executed

```bash
cd formal/lean-source
export PATH=/home/goblin/.elan/toolchains/leanprover--lean4---v4.31.0-rc1/bin:/usr/local/bin:/usr/bin:/bin
lake clean
lake exe cache get
set -o pipefail
lake build 2>&1 | tee ../lean-build-v10.log
lake env lean S6/AxiomAudit.lean > ../AXIOM_REPORT_V10.txt 2>&1
rg -n 'native[_-]decide|trustCompiler' . ../AXIOM_REPORT_V10.txt
rg -n 'Lean\.ofReduceBool|Lean\.ofReduceNat|Lean\.trustCompiler|sorryAx|native[_-]decide' \
  ../AXIOM_REPORT_V10.txt
```

The build pipeline was run with `bash -o pipefail`, so the recorded exit code is Lean/Lake's result rather
than `tee`'s result. The ambient shell had no Elan shim; the displayed PATH selects the exact pinned binaries
used by the final run.

## Results

- `lake clean`: exit code `0`
- `lake exe cache get`: exit code `0`; 8,488 cached files decompressed and 4 were already decompressed
- `lake build`: exit code `0`
- Build summary: `Build completed successfully (8517 jobs).`
- Current Lean source: zero `decide` and zero native-computation tactic invocations; no `sorry`, `admit`,
  custom axiom/constant declaration, or unsafe declaration
- Per-theorem axiom command: exit code `0`; exactly 62 distinct named certificates produced 62 records
- Union of reported axioms: `{propext, Classical.choice, Quot.sound}`
- Generated computation/compiler-trust axiom check: **PASS**; both the prescribed scan and the stronger scan
  returned no matches (`rg` exit code `1` means no match)
- Exact finite checker: exit code `0`; all 21 named certificates passed under Python 3.12.3 / SymPy 1.12 in
  `/tmp/s6-verifier-venv` (the ambient system Python lacked SymPy)

Complete raw output is in `lean-build-v10.log` and `AXIOM_REPORT_V10.txt`.

## Gate-discovered repair history

- Bundle-state commit `cfd91623f36f251d9c23846846d651c83c323208` exactly matched the incoming ZIP.
- The first build at `c9d6263e7018b4273c82942c10b2ab9baf5d1594` exited `1` after 22 diagnostics at
  `S6Shortcuts` bare-`decide` certificates. Its raw failure receipt is preserved in the operator notes as
  `s6-notes/v10-failed-build-c9d6263.log` and was not substituted for the successful release log.
- Repair commit `9ba64114f017016be81f55cd0a0c4e6cdffbd740` replaced all 32 bare sites with explicit
  kernel-checked arithmetic proofs. Commit `cb2adf25c8f79e67c5805d71defe8afcf50d4cf2` corrected the hashed
  proof-method description. Commit `b6220d0fd6b301b2df2082a91885513945126f45` corrected the clean/cache/build
  reproduction order, after which the final clean-source build and axiom audit were rerun.

## Release decision

**PASS — the V10 formal release gate is closed for built-source commit
`b6220d0fd6b301b2df2082a91885513945126f45` and source digest
`37d55a7a16aa29bf11cc291bdca8a20c98192bb18883b5da171bc25c449a55f1`.**

This decision covers only the reusable algebraic layer and finite certificates described in `LEAN_SCOPE.md`.
It does not establish the analytic or geometric hypotheses of the proposed construction, nor any claim that
the six-sphere admits a complex structure. The explicit presented-group-to-relation-cokernel equivalence
remains a documented formal bridge gap.
