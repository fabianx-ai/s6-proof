# Lean build audit check

This file records the build check performed for the paper-writing Goblin.

## Audited source

- Git commit: `b3c0a190905948b99206b0e1d08bbe8ce998e4ec`
- Branch: `master`
- Worktree before and after the check: clean
- Lean toolchain: `leanprover/lean4:v4.31.0-rc1`
- Lean commit: `fd009949156901e6cf15b6d9bf1122294b8e697a`
- Lake: `5.0.0-src+fd00994`
- Mathlib commit: `0531bb79fea20efc9ce6942db46b96be5a919400`
- Audit date: 2026-08-27

## Exact build check

Command run from the repository root:

```text
/home/goblin/.elan/toolchains/leanprover--lean4---v4.31.0-rc1/bin/lake build
```

Observed result:

```text
exit code: 0
Build completed successfully (8517 jobs).
```

The command was run twice during the final audit, including an independent verification pass, and both runs returned exit code 0 with the same success line.

`lakefile.toml` has default targets `S6Shortcuts` and `S6`. `S6.lean` imports all six modules under `S6/`, so this successful default build covers all eight bundled Lean files:

```text
S6Shortcuts.lean
S6.lean
S6/CyclicAverage.lean
S6/LatticeOrbitIndex.lean
S6/SplitExtension.lean
S6/SquareZeroExchange.lean
S6/TwoExceptionalGluing.lean
S6/UnitTransgression.lean
```

The project Lean sources were also scanned for `sorry`, `admit`, custom `axiom`/`constant` declarations, and unsafe declarations. No matches were found.

## Reproduction

The ZIP contains the Lean sources plus the pinned toolchain and Lake manifest. After extraction:

```text
cd lean-source
lake exe cache get
lake build
```

Do not run `lake update`; the supplied manifest records the audited dependency revisions.

## Truth boundary

This successful build proves that Lean accepts the formal statements encoded in the bundled files under the pinned toolchain and dependencies. It does not machine-check the analytic LCP or the whole paper. In particular, `UnitTransgression.lean` encodes the repaired filtration hypotheses described in `TRUE_AUDIT_REPORT.md`, not the incomplete generic hypotheses of printed short-paper Lemma 6.11.
