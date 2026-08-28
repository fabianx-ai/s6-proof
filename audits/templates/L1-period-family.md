# L1 - Open period family

**Source target:** S6 Sections 2-3, especially Proposition 2.11, Theorem 3.4(iv), condition `(beta3)`, and Remark 6.4.

**Imported interface:** Holomorphic functions `tau`, `mu`, and `beta` with the stated triangle-group
transformation laws exist; for the chosen parameter range the columns of the period matrix form a
rank-four real lattice at every point, and the quotient descends to a proper holomorphic family of
complex two-tori over the punctured orbifold base with the stated monodromies.

## Required checks

- existence and global single-valuedness of `tau`, `mu`, and `beta` on the upper half-plane;
- all equivariance and cocycle identities for the generators and their product;
- the admissible parameter `c0`, the range `Im(c0) < -M`, and condition `(beta3)` for every base point, not only at sample points;
- properness and holomorphic submersion of the descended family;
- exact correspondence between the period action and the displayed integral monodromy matrices.

## Convention ledger

Record the triangle generators, orientation of meridians, period-row convention, basis of the
rank-four lattice, parameter `c0`, and the distinction between cohomological and homological
monodromy.

## Cross-checks

The finite identities `T1^3 = I`, `T2^4 = I`, `T0 = I + N`, and `N^2 = 0` must agree with the
monodromy extracted from the analytic family. These identities are necessary, not sufficient.

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
