import Mathlib
import S6Shortcuts

/-!
# Full-rank lattice index

This file packages Mathlib's full-rank free-module quotient theorem in the square-matrix form used
by Lemma 6.6: the number of cosets of the column lattice of an integral matrix is the absolute value
of its determinant.  In the orbit reading, two lattice points lie in the same orbit exactly when
their difference belongs to this column lattice, so the quotient cardinal is the orbit count.

The final specialization uses only the finite integral certificate `B0`; it makes no assertion about
the analytic package or about a complex structure on the six-sphere.
-/

namespace S6.LatticeOrbitIndex

/-- The integral linear map whose image is the column lattice of `B`. -/
abbrev latticeMap {r : ℕ} (B : Matrix (Fin r) (Fin r) ℤ) :
    (Fin r → ℤ) →ₗ[ℤ] (Fin r → ℤ) := Matrix.toLin' B

/-- The set of lattice cosets, equivalently the orbit set for translation by the column lattice. -/
abbrev LatticeOrbits {r : ℕ} (B : Matrix (Fin r) (Fin r) ℤ) :=
  (Fin r → ℤ) ⧸ LinearMap.range (latticeMap B)

/-- A square integral matrix with nonzero determinant is injective on the integral lattice. -/
theorem latticeMap_injective {r : ℕ} {B : Matrix (Fin r) (Fin r) ℤ} (hB : B.det ≠ 0) :
    Function.Injective (latticeMap B) := by
  rw [← LinearMap.ker_eq_bot]
  by_contra hker
  apply hB
  rw [← LinearMap.det_toLin']
  exact LinearMap.det_eq_zero_iff_ker_ne_bot.mpr hker

/-- The index of a full-rank square integral matrix is the absolute value of its determinant. -/
theorem natCard_latticeOrbits_eq_natAbs_det {r : ℕ} (B : Matrix (Fin r) (Fin r) ℤ)
    (hB : B.det ≠ 0) : Nat.card (LatticeOrbits B) = B.det.natAbs := by
  let f := latticeMap B
  let e : (Fin r → ℤ) ≃ₗ[ℤ] LinearMap.range f :=
    LinearEquiv.ofInjective f (latticeMap_injective hB)
  have hcard := Submodule.natAbs_det_equiv (LinearMap.range f) e
  rw [← hcard]
  congr 1
  rw [← LinearMap.det_toLin']
  congr 1

section ConcreteCertificate

open S6Shortcuts

/-- The certified local matrix is unimodular. -/
theorem B0_det_natAbs : B0.det.natAbs = 1 := by
  norm_num [B0, Matrix.det_fin_two]

/-- The local orbit quotient for `B0` has exactly one element. -/
theorem natCard_B0_latticeOrbits : Nat.card (LatticeOrbits B0) = 1 := by
  rw [natCard_latticeOrbits_eq_natAbs_det B0 (by norm_num [B0, Matrix.det_fin_two])]
  exact B0_det_natAbs

/-- Equivalently, every integral lattice point lies in the same `B0` translation orbit. -/
theorem B0_latticeOrbits_subsingleton : Subsingleton (LatticeOrbits B0) :=
  (Nat.card_eq_one_iff_unique.mp natCard_B0_latticeOrbits).1

end ConcreteCertificate

end S6.LatticeOrbitIndex
