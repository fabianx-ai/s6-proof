# V10 Lean build and trust-boundary report

## Status

**PLACEHOLDER - publication gate not yet executed.**

The V10 source tree proposes replacing all 32 concrete uses of the native computation tactic with
kernel-reducible `decide` proofs. This environment did not contain the pinned Lean toolchain, so no claim is
made here that the modified tree compiles. Codex must run the commands below, repair any proof that does not
compile, and replace every `PLACEHOLDER` field before publication.

## Pinned environment

- Git commit: `PLACEHOLDER_GIT_COMMIT`
- Working tree status: `PLACEHOLDER_CLEAN_OR_DIRTY`
- Lean toolchain: `leanprover/lean4:v4.31.0-rc1`
- Lean commit reported by toolchain: `PLACEHOLDER_LEAN_COMMIT`
- Mathlib commit: `0531bb79fea20efc9ce6942db46b96be5a919400`
- V10 Lean source-tree manifest: `formal/SOURCE_TREE_V10.sha256`
- Aggregate source-tree digest: `3506b93e1a077ff6888a61285aa6d8745ed79d1de4625a9e1e0cf012650c56b1`

## Required commands

```bash
cd formal/lean-source
lake clean
lake build
lake env lean S6/AxiomAudit.lean > ../AXIOM_REPORT_V10.txt 2>&1
rg -n 'native[_-]decide|trustCompiler' . ../AXIOM_REPORT_V10.txt
```

## Required results

- `lake build` exit code: `PLACEHOLDER_BUILD_EXIT_CODE`
- Build summary: `PLACEHOLDER_BUILD_SUMMARY`
- Zero concrete native computation tactic invocations: **source scan presently passes** (`../checks/formal-source-scan.txt`)
- Per-theorem axiom report: `PLACEHOLDER_AXIOM_RESULT`
- Generated compiler-trust axiom absent: `PLACEHOLDER_TRUST_RESULT`
- Current exact checker: see `../checks/finite-verification.txt`

## Release decision

`PLACEHOLDER_RELEASE_DECISION`

The bundle is intentionally publication-incomplete while this marker remains.
