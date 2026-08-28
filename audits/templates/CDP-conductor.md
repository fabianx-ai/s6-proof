# Side audit - CDP conductor comparison

This audit is outside LCP and is not a predecessor of the recognition theorem.

**Primary targets:** Campana-Demailly-Peternell, arXiv:1904.11179 / Compos. Math. 156 (2020),
Sections 1, 2, and 7; S6 Lemma 10.3(a)-(c), Theorem 10.5(b), Proposition 10.8, and Sections 10.4-10.5.

## Questions

- Does the published text contain the exact reduction from the conormal sequence to the
  torsion-free differential vanishing, including the proviso that the line-bundle restriction is non-torsion?
- For the actual twist `A = (L^* tensor omega_X)|_W`, does the pullback to the normalization become
  trivial?
- Does the normalization-conductor equalizer produce a global nonzero ambient section?
- Is its image nonzero conductor-supported torsion and therefore zero only after quotienting
  torsion?
- Is `N^*_{W/X} ~= O_W`, and does nontriviality of `A` imply `H^0(W,A)=0`?
- Do Theorem 10.5(b) and Proposition 10.8 visibly discharge the non-torsion proviso?
- Which conclusions require only Lemma 10.3(b), and which additionally require the global construction and the separate theorem `a(X)=1`?

## Claim ladder

1. The printed torsion-free reduction does not exclude the proposed non-normal fibre.
2. Granted the verified construction, sphere topology, algebraic dimension one, and holomorphic
   algebraic reduction, the proposed `X` would contradict CDP Theorem 2.2 and Corollary 2.3.

The first statement is narrower and should not be conflated with an existence proof.

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
