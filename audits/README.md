# Interface audit packages

The paper fixes the invariant dependency graph:

```text
L1  L2  L3
 \  |  /
    L4
   /  \
 L5    L6
```

This directory separates **templates** from **evidence**:

- `templates/` contains operational receipt forms for L1-L6 and the separate CDP audit.
- `reviews/` contains completed review documents actually supplied to this release.
- `STATUS.md` distinguishes source-interface fidelity from independent theorem verification.

Blank templates are not evidence. A source citation can match perfectly while the cited theorem remains
independently unverified.

## Standard receipt

Each completed record must include:

1. exact imported statement and source pointer;
2. proof dependencies actually used;
3. convention ledger;
4. falsification attempt or reproducible check;
5. failure impact;
6. current evidence and outstanding proof obligation;
7. separate verdicts for interface fidelity and independent theorem verification.

Finite certificates are cross-checks only. They do not replace analytic existence, properness, separatedness,
geometric boundary maps, or integral specialization proofs.

## Shared handoffs

- `B0`: produced in L2 and consumed by L4.
- `(v1,v2)`: produced in L3 and consumed by L5.
- `p = -1`: computed by the two separate global consumers L5 and L6 after the shared signed data are fixed.

A mismatch localizes the defect to an adjacent interface rather than to the finite recognition argument as a whole.
