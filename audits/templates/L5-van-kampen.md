# L5 - Boundary maps and van Kampen

**Source target:** S6 Lemma 2.7(iii)-(iv), Lemma 7.4, Lemma 7.16, and Theorem 7.17.

**Imported interface:** The smallest `<A1,A2>`-invariant subgroup containing the cusp vanishing lattice is
`ker(gamma)`, leaving one fibre quotient `Lambda/ker(gamma) ~= Z`; invariance of `gamma` makes its generator
`c` central. With the prescribed paths and orientations the three fillings induce

```text
x^3 = c^ell1,
y^4 = c^ell2,
xy  = c^ell0.
```

The resulting group is cyclic of order `|p|`, where
`p = 12 ell0 - 4 ell1 - 3 ell2`.

## Prerequisites

L4 and the signed vectors from L3.

## Required checks

- the pi1-level invariant-closure statement of Lemma 2.7(iv); the additive Smith identity is a separate cross-check, not the bridge;
- basepoint paths and clockwise/counterclockwise meridian conventions;
- Lemma 7.16 transport of the chosen signed vectors into the filling relations;
- identification of the cusp winding class with the relation `xy = c^ell0`;
- Smith/elimination calculation after the geometric presentation is established.

## Shared handoffs

- Consume `(v1,v2)` from L3 and `ell0 = 0` from L4.
- Return `p = -1` to compare with the separate Leray consumer L6.

The `p = -7` positive-sign comparison is a useful falsification check for sign drift.

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
