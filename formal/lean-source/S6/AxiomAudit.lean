import S6
import S6Shortcuts

/-!
# V10 axiom audit driver

Run with the pinned toolchain after `lake build`:

```text
lake env lean S6/AxiomAudit.lean
```

The complete release-run output is recorded in `formal/AXIOM_REPORT_V10.txt`. Acceptance requires that it
contain no generated compiler-evaluation trust axiom. Ordinary foundational axioms inherited from Lean and
Mathlib remain visible in the report.
-/

-- Concrete finite certificates from `S6Shortcuts`.
#print axioms S6Shortcuts.T1_order_three
#print axioms S6Shortcuts.T2_order_four
#print axioms S6Shortcuts.T0_is_I_add_N
#print axioms S6Shortcuts.T0_is_product_inverse_left
#print axioms S6Shortcuts.T0_is_product_inverse_right
#print axioms S6Shortcuts.N_square_zero
#print axioms S6Shortcuts.A1_order_three
#print axioms S6Shortcuts.A2_order_four
#print axioms S6Shortcuts.T1_preserves_Q0
#print axioms S6Shortcuts.T2_preserves_Q0
#print axioms S6Shortcuts.N_infinitesimally_preserves_Q0
#print axioms S6Shortcuts.N_quadratic_Q0_term_vanishes
#print axioms S6Shortcuts.P3_is_cyclic_average
#print axioms S6Shortcuts.P4_is_cyclic_average
#print axioms S6Shortcuts.P3_idempotent
#print axioms S6Shortcuts.P4_idempotent
#print axioms S6Shortcuts.A1_fixes_P3
#print axioms S6Shortcuts.A2_fixes_P4
#print axioms S6Shortcuts.P3_projects_seed
#print axioms S6Shortcuts.P4_projects_seed
#print axioms S6Shortcuts.epsilon_fixed
#print axioms S6Shortcuts.epsilonPrime_fixed
#print axioms S6Shortcuts.gamma_epsilon
#print axioms S6Shortcuts.gamma_epsilonPrime
#print axioms S6Shortcuts.gamma_v1
#print axioms S6Shortcuts.gamma_v2
#print axioms S6Shortcuts.B0_mul_inverse
#print axioms S6Shortcuts.B0_inverse_mul
#print axioms S6Shortcuts.relation_mul_inverse
#print axioms S6Shortcuts.relation_inverse_mul
#print axioms S6Shortcuts.defect_of_projected_seed
#print axioms S6Shortcuts.consecutive_order_defect
#print axioms S6Shortcuts.defect_three_four
#print axioms S6Shortcuts.central_fibre_euler

-- Concrete lattice-index certificate.
#print axioms S6.LatticeOrbitIndex.B0_det_natAbs
#print axioms S6.LatticeOrbitIndex.natCard_B0_latticeOrbits
#print axioms S6.LatticeOrbitIndex.B0_latticeOrbits_subsingleton

-- Derived concrete projector and exchange certificates.
#print axioms S6.CyclicAverage.P3_toLin_eq_cyclicAverage
#print axioms S6.CyclicAverage.P4_toLin_eq_cyclicAverage
#print axioms S6.CyclicAverage.P3_idempotent_derived
#print axioms S6.CyclicAverage.P4_idempotent_derived
#print axioms S6.CyclicAverage.A1_mul_P3_derived
#print axioms S6.CyclicAverage.P3_mul_A1_derived
#print axioms S6.CyclicAverage.A2_mul_P4_derived
#print axioms S6.CyclicAverage.P4_mul_A2_derived
#print axioms S6.CyclicAverage.range_P3_toLin
#print axioms S6.CyclicAverage.range_P4_toLin
#print axioms S6.CyclicAverage.epsilon_fixed_derived
#print axioms S6.CyclicAverage.epsilonPrime_fixed_derived
#print axioms S6.CyclicAverage.gammaLinear_comp_P3
#print axioms S6.CyclicAverage.gammaLinear_comp_P4
#print axioms S6.CyclicAverage.gamma_epsilon_derived
#print axioms S6.CyclicAverage.gamma_epsilonPrime_derived
#print axioms S6.CyclicAverage.gamma_v1_derived
#print axioms S6.CyclicAverage.gamma_v2_derived
#print axioms S6.SquareZeroExchange.N_quadratic_Q0_term_vanishes_derived
#print axioms S6.SquareZeroExchange.cuspExchange_preserves_Q0
#print axioms S6.SquareZeroExchange.T0_eq_cuspExchange_one
#print axioms S6.SquareZeroExchange.T0_preserves_Q0_derived

-- Reusable exported algebraic interfaces consumed by the paper.
#print axioms S6.TwoExceptionalGluing.gluingDefect_common_projected_seed
#print axioms S6.TwoExceptionalGluing.gluingDefect_consecutive
#print axioms S6.UnitTransgression.all_subsingleton_of_isUnit
