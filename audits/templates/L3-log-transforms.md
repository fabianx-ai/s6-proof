# L3 - Finite-monodromy logarithmic transforms

**Source target:** S6 Definition 5.3 and Theorem 5.4; sign transport is consumed later through
Lemma 7.16.

**Imported interface:** The order-three and order-four local cyclic actions with the chosen signed
primitive translation vectors are free, preserve the punctured family, and produce multiple fibres
`3 S1` and `4 S2` with smooth bielliptic reductions.

## Required checks

- the translation vectors lie in the correct fixed lattices and are primitive;
- the local cyclic actions are free at the central fibres, with the general congruences `3 does not divide ell1` and `ell2` odd;
- multiplicities and normal-bundle orders are exactly 3 and 4;
- the logarithmic sections identify each quotient with the open family off the centre;
- the actual construction uses `v1 = epsilon` and `v2 = -epsilonPrime`.

## Convention ledger

Record the base rotations, choice of primitive generator, homology basis, the observable `gamma`,
and the sign convention distinguishing the sphere construction from the `Z/7` comparison.

## Shared handoff

The output passed to L5 is the signed pair

```text
(v1, v2) = (P3 gammaHat, -P4 gammaHat),
(gamma(v1), gamma(v2)) = (1, -1).
```

The projector computation selects the invariant directions; it does not select the relative sign.

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
