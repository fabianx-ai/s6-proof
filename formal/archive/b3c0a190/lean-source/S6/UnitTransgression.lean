import Mathlib

/-!
# Unit-transgression bookkeeping

This file formalizes the explicit abelian-group bookkeeping in Lemma 6.11, without introducing a
spectral-sequence API.  After choosing compatible integral generators, all three differentials are
the same map `ℤ → ℤ`, multiplication by `p`.  The data below records exactly the low-degree
filtration pieces used in the paper's proof.  Vanishing successive quotients force the sole
surviving filtration subgroup to be the whole abutment group, eliminating extension ambiguity.

This is unconditional algebra.  It neither supplies the analytic hypotheses of the proposed
construction nor asserts that the six-sphere has a complex structure.
-/

namespace S6.UnitTransgression

noncomputable section

/-- The normalized integral transgression, multiplication by `p`. -/
abbrev transgressionMap (p : ℤ) : ℤ →ₗ[ℤ] ℤ := LinearMap.lsmul ℤ ℤ p

/-- The kernel piece of a normalized transgression. -/
abbrev TransgressionKernel (p : ℤ) := LinearMap.ker (transgressionMap p)

/-- The cokernel piece of a normalized transgression. -/
abbrev TransgressionCokernel (p : ℤ) := ℤ ⧸ AddSubgroup.zmultiples p

/-- The normalized transgression really sends `z` to `p * z`. -/
@[simp]
theorem transgressionMap_apply (p z : ℤ) : transgressionMap p z = p * z := rfl

/-- A nonzero normalized transgression has zero kernel. -/
theorem transgressionKernel_subsingleton {p : ℤ} (hp : p ≠ 0) :
    Subsingleton (TransgressionKernel p) := by
  change Subsingleton ↥(LinearMap.ker (LinearMap.lsmul ℤ ℤ p))
  rw [LinearMap.ker_lsmul hp]
  infer_instance

/-- The cokernel of multiplication by `p` is the cyclic group `ZMod |p|`. -/
def transgressionCokernelEquivZMod (p : ℤ) :
    TransgressionCokernel p ≃+ ZMod p.natAbs :=
  Int.quotientZMultiplesEquivZMod p

/--
The low-degree abutment filtration after the spectral-sequence page calculation has been performed.
The three occurrences of `TransgressionKernel`/`TransgressionCokernel` use the same normalized map,
which encodes the compatible-generator hypothesis that all three differentials multiply by `p`.
-/
structure LowDegreeFiltration (p : ℤ) where
  H1 : Type*
  H2 : Type*
  H3 : Type*
  [h1AddCommGroup : AddCommGroup H1]
  [h2AddCommGroup : AddCommGroup H2]
  [h3AddCommGroup : AddCommGroup H3]
  h1Graded : H1 ≃+ TransgressionKernel p
  h2F2 : AddSubgroup H2
  h2F1 : AddSubgroup H2
  h2F2_le_h2F1 : h2F2 ≤ h2F1
  h2Survivor : h2F2 ≃+ TransgressionCokernel p
  h2MiddleVanishes : Subsingleton (h2F1 ⧸ h2F2.addSubgroupOf h2F1)
  h2TopVanishes : Subsingleton (H2 ⧸ h2F1)
  h3F2 : AddSubgroup H3
  h3F1 : AddSubgroup H3
  h3F2_le_h3F1 : h3F2 ≤ h3F1
  h3Survivor : h3F2 ≃+ TransgressionCokernel p
  h3MiddleVanishes : Subsingleton (h3F1 ⧸ h3F2.addSubgroupOf h3F1)
  h3TopVanishes : Subsingleton (H3 ⧸ h3F1)

attribute [instance] LowDegreeFiltration.h1AddCommGroup
  LowDegreeFiltration.h2AddCommGroup LowDegreeFiltration.h3AddCommGroup

private theorem filtration_bottom_eq_top {A : Type*} [AddCommGroup A]
    (F2 F1 : AddSubgroup A) (hle : F2 ≤ F1)
    (hmiddle : Subsingleton (F1 ⧸ F2.addSubgroupOf F1))
    (htop : Subsingleton (A ⧸ F1)) : F2 = ⊤ := by
  have hmiddleTop : F2.addSubgroupOf F1 = ⊤ :=
    QuotientAddGroup.addSubgroup_eq_top_of_subsingleton _ hmiddle
  have hF1le : F1 ≤ F2 := AddSubgroup.addSubgroupOf_eq_top.mp hmiddleTop
  have hF1top : F1 = ⊤ := QuotientAddGroup.addSubgroup_eq_top_of_subsingleton _ htop
  exact (le_antisymm hle hF1le).trans hF1top

/-- The sole surviving filtration subgroup in degree two is the whole abutment group. -/
theorem h2F2_eq_top {p : ℤ} (D : LowDegreeFiltration p) : D.h2F2 = ⊤ :=
  filtration_bottom_eq_top D.h2F2 D.h2F1 D.h2F2_le_h2F1
    D.h2MiddleVanishes D.h2TopVanishes

/-- The sole surviving filtration subgroup in degree three is the whole abutment group. -/
theorem h3F2_eq_top {p : ℤ} (D : LowDegreeFiltration p) : D.h3F2 = ⊤ :=
  filtration_bottom_eq_top D.h3F2 D.h3F1 D.h3F2_le_h3F1
    D.h3MiddleVanishes D.h3TopVanishes

/-- The degree-one abutment vanishes when `p` is nonzero. -/
theorem h1_subsingleton {p : ℤ} (D : LowDegreeFiltration p) (hp : p ≠ 0) :
    Subsingleton D.H1 := by
  letI := transgressionKernel_subsingleton hp
  exact ⟨fun x y => D.h1Graded.injective (Subsingleton.elim _ _)⟩

/-- The degree-two abutment is the cokernel `ZMod |p|`. -/
def h2EquivZMod {p : ℤ} (D : LowDegreeFiltration p) : D.H2 ≃+ ZMod p.natAbs := by
  let e := D.h2Survivor
  rw [h2F2_eq_top D] at e
  exact AddSubgroup.topEquiv.symm.trans (e.trans (transgressionCokernelEquivZMod p))

/-- The degree-three abutment is the cokernel `ZMod |p|`. -/
def h3EquivZMod {p : ℤ} (D : LowDegreeFiltration p) : D.H3 ≃+ ZMod p.natAbs := by
  let e := D.h3Survivor
  rw [h3F2_eq_top D] at e
  exact AddSubgroup.topEquiv.symm.trans (e.trans (transgressionCokernelEquivZMod p))

/-- Unit defect kills the degree-two abutment. -/
theorem h2_subsingleton_of_isUnit {p : ℤ} (D : LowDegreeFiltration p) (hp : IsUnit p) :
    Subsingleton D.H2 := by
  haveI : Subsingleton (ZMod p.natAbs) :=
    ZMod.subsingleton_iff.mpr (Int.natAbs_of_isUnit hp)
  exact ⟨fun x y => (h2EquivZMod D).injective (Subsingleton.elim _ _)⟩

/-- Unit defect kills the degree-three abutment. -/
theorem h3_subsingleton_of_isUnit {p : ℤ} (D : LowDegreeFiltration p) (hp : IsUnit p) :
    Subsingleton D.H3 := by
  haveI : Subsingleton (ZMod p.natAbs) :=
    ZMod.subsingleton_iff.mpr (Int.natAbs_of_isUnit hp)
  exact ⟨fun x y => (h3EquivZMod D).injective (Subsingleton.elim _ _)⟩

/-- If the common transgression integer is a unit, all three low-degree groups vanish. -/
theorem all_subsingleton_of_isUnit {p : ℤ} (D : LowDegreeFiltration p) (hp : IsUnit p) :
    Subsingleton D.H1 ∧ Subsingleton D.H2 ∧ Subsingleton D.H3 :=
  ⟨h1_subsingleton D hp.ne_zero, h2_subsingleton_of_isUnit D hp,
    h3_subsingleton_of_isUnit D hp⟩

end

end S6.UnitTransgression
