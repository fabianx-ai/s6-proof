# L6 - Integral specialization and Leray

**Source target:** S6 Theorem B.1 at the cusp, Proposition 7.14 at the finite fibres, and Propositions 7.26-7.27 for global assembly.

**Imported interface:** The integral specialization lattices give the complete low-degree Leray
support and the normalized generators

```text
H^0(P1, R^1 f_* Z) = 12 Z gamma,
H^0(P1, R^2 f_* Z) = Z * 2q,
H^0(P1, R^3 f_* Z) = Z * 2 gamma u w,
```

and the three relevant transgressions are multiplication by the same signed gluing integer `p` in
compatible generators.

## Prerequisites

L4, including the assembled fibration and the same three gluing integers used by L5.

## Required checks

- Theorem B.1 and its proof dependencies at the cusp; Proposition 7.14, Lemma 7.13, and the relevant Appendix A calculation at the finite fibres;
- the order-four index-two specialization in degree two;
- complete low-degree `E2` support, including all required vanishings;
- normalization of the factors `12`, `2`, and `2`;
- clutching computation `12 ell0 - 4 ell1 - 3 ell2`;
- multiplicativity in Proposition 7.27 that forces the common sign on all three maps;
- filtration and extension bookkeeping through the abutment.

## Shared handoff

Return `p = -1` through the Leray consumer, separately from L5 but using the same signed gluing inputs. A result such as `2p`, `0`, or an opposite normalization is a
load-bearing mismatch, not a harmless convention change.

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
