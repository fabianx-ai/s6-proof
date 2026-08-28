# L2 - Cusp normal form and toric filling

**Source target:** S6 Proposition 3.21, Theorem 4.5, and Propositions 4.6-4.7.

**Imported interface:** The period matrix has the asserted square-zero cusp normal form; the
corrected lattice action on the infinite toric threefold is free and properly discontinuous near
the central divisor; the quotient is proper over the disc and has the stated reduced irreducible
non-normal fibre `W` with normalization `dP6`, three double curves, and two triple points.

## Required checks

- holomorphic extension and equivariance of the regular correction term `C(tc)`;
- free, properly discontinuous action and closed quotient relation;
- smoothness of the total threefold despite the singular central fibre;
- identification of the quotient incidence data `(1 component, 3 seams, 2 triple points)`;
- compatibility of the quotient with the open torus family over the punctured disc.

## Convention ledger

Record the cusp coordinate, logarithm branch, bases of `Lambda/Lambda_tor` and `Lambda_tor`, the
matrix `B0`, and the translation action on the root-system `A2` triangulation.

## Shared handoff

The output matrix must be

```text
B0 = [[0, 1], [-1, 0]],  det(B0) = 1.
```

L4 consumes the same `B0`. The determinant-one certificate checks the component orbit count but does
not prove properness or the analytic quotient.

## Evidence record

- **Failure impact:**
- **Convention-sensitive data:**
- **Current evidence:**
- **Outstanding proof obligation:**

## Status receipt

- **Interface fidelity:** OPEN / PASS / PATCH / FAIL
- **Independent theorem verification:** OPEN / PASS / PATCH / FAIL
- **Reviewer and date:**
- **Signed source/version identifier:**
