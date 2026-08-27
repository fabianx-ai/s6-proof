# Independent Audit Checklist

The short paper isolates the remaining verification boundary into four local
packages. A reviewer can check them independently of the global recognition
argument.

## L1. Open period family

- [x] Verify the triangle-group relations for `T1`, `T2`, and `T0`.
      — `VERIFIED-INDEPENDENT` (evidence: `~/s6-notes/audit/L1.md`)
- [x] Verify the transformation laws for `tau`, `mu`, and `beta`.
      — `VERIFIED-AGAINST-SOURCE` (evidence: `~/s6-notes/audit/L1.md`)
- [x] Check the torsor identifications with `O(-1)` and `O` on `P^1`.
      — `VERIFIED-AGAINST-SOURCE` (evidence: `~/s6-notes/audit/L1.md`)
- [x] Check existence and uniqueness from the relevant `H^1` and `H^0` groups.
      — `VERIFIED-AGAINST-SOURCE` (evidence: `~/s6-notes/audit/L1.md`)
- [x] Prove the global lattice inequality after choosing `Im(c0)` sufficiently
      negative. — `VERIFIED-INDEPENDENT` (evidence: `~/s6-notes/audit/L1.md`)
- [x] Verify proper holomorphic descent of the two-torus family over the
      thrice-punctured base. — `VERIFIED-INDEPENDENT`
      (evidence: `~/s6-notes/audit/L1.md`)

## L2. Cusp normal form and toric quotient

- [x] Derive the normal form `[s B0 + C(tc) | I]` from the period functions.
      — `VERIFIED-AGAINST-SOURCE` (evidence: `~/s6-notes/audit/L2.md`)
- [x] Verify that `C(tc)` extends holomorphically across `tc = 0`.
      — `VERIFIED-AGAINST-SOURCE` (evidence: `~/s6-notes/audit/L2.md`)
- [x] Verify the corrected lattice action on the infinite `A2` toric threefold.
      — `VERIFIED-AGAINST-SOURCE` (evidence: `~/s6-notes/audit/L2.md`)
- [x] Prove freeness and proper discontinuity near the central divisor.
      — `VERIFIED-AGAINST-SOURCE` (evidence: `~/s6-notes/audit/L2.md`)
- [x] Check that the quotient agrees with the period family over the punctured
      disc. — `VERIFIED-AGAINST-SOURCE`
      (evidence: `~/s6-notes/audit/L2.md`)
- [x] Check the local equations `z0`, `z0*z1`, and `z0*z1*z2`.
      — `VERIFIED-AGAINST-SOURCE` (evidence: `~/s6-notes/audit/L2.md`)
- [x] Verify the normalization, opposite-side identifications, three double
      curves, and two triple points of `W`.
      — `VERIFIED-AGAINST-SOURCE` (evidence: `~/s6-notes/audit/L2.md`)

## L3. Finite-monodromy logarithmic transforms

- [x] Verify that the projected twist vectors lie in the integral fixed lattices.
      — `VERIFIED-INDEPENDENT` (evidence: `~/s6-notes/audit/L3.md`)
- [x] Verify primitivity and the exact freeness congruences for orders 3 and 4.
      — `VERIFIED-AGAINST-SOURCE` (evidence: `~/s6-notes/audit/L3.md`)
- [x] Check the sign convention for `v2 = -epsilonPrime`.
      — `VERIFIED-AGAINST-SOURCE` (evidence: `~/s6-notes/audit/L3.md`)
- [x] Check the logarithmic sections and branch independence on the punctured
      discs. — `VERIFIED-INDEPENDENT` (evidence: `~/s6-notes/audit/L3.md`)
- [x] Verify smoothness of the quotients and exact multiplicities `3S1`, `4S2`.
      — `VERIFIED-INDEPENDENT` (evidence: `~/s6-notes/audit/L3.md`)
- [x] Verify the Bagnera-de Franchis types of the reduced fibres.
      — `VERIFIED-AGAINST-SOURCE`: `(Z/3)^2` and `Z/4 x Z/2`
      (evidence: `~/s6-notes/audit/L3.md`)

## L4. Integral specialization and Leray

- [ ] Verify the nearby-cycle calculation at the cusp independently of the
      geometric collapse map.
- [ ] Verify all specialization lattices at the two finite points.
- [ ] Check the index-two degree-two specialization at the order-four fibre.
- [ ] Confirm the generators `12 gamma`, `2q`, and `2 gamma u w`.
- [ ] Recompute the three local discrepancies and their signs.
- [ ] Verify that the first transgression is multiplication by
      `p = 12*l0 - 4*l1 - 3*l2`.
- [ ] Verify multiplicativity and the common sign of the next two
      transgressions.
- [ ] Confirm that no other differential or extension can alter the middle
      integral cohomology.

## Independent conflict check

- [ ] Verify the ghost-section descent on the normalization-conductor square.
- [ ] Check that the section is nonzero before, and zero after, passage to the
      torsion-free quotient.
- [ ] Verify the resulting nonvanishing of `R^2 f_*(T_X tensor L)` for every
      line bundle `L`.
- [ ] Separate failure of a published proof step from falsity of the published
      theorem itself.

## Completion criterion

The construction should be advertised as independently verified only when every
item above has either a checked proof or a precisely documented correction.
