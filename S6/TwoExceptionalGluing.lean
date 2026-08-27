import Mathlib
import S6.CyclicAverage

/-!
# Two-exceptional-fibre gluing arithmetic

This file formalizes the unconditional group-theoretic and integer-linear-algebra core of Theorem
6.8 and its two arithmetic corollaries.  The relation cokernel is reduced explicitly, using Bézout
coefficients for the coprime exceptional orders, to the one-generator quotient `ZMod |p|`.

No assertion about the existence of a complex structure on the six-sphere is made here; the local
analytic models required by the proposed construction lie outside the scope of this module.
-/

namespace S6.TwoExceptionalGluing

/-- The defect integer in the two-exceptional-fibre relation matrix. -/
def gluingDefect (m n : ℕ) (ell0 ellM ellN : ℤ) : ℤ :=
  (m : ℤ) * (n : ℤ) * ell0 - (n : ℤ) * ellM - (m : ℤ) * ellN

/-- The common projected-seed exponents `(0, 1, -1)` have defect `m - n`. -/
theorem gluingDefect_common_projected_seed (m n : ℕ) :
    gluingDefect m n 0 1 (-1) = (m : ℤ) - (n : ℤ) := by
  simp [gluingDefect]
  ring

/-- Consecutive exceptional orders give unit defect. -/
theorem gluingDefect_consecutive (m : ℕ) :
    gluingDefect m (m + 1) 0 1 (-1) = -1 := by
  rw [gluingDefect_common_projected_seed]
  push_cast
  ring

/-- The two remaining relations on `(x, c)` after eliminating `y`. -/
def relationMap (m n : ℕ) (ell0 ellM ellN : ℤ) :
    (ℤ × ℤ) →ₗ[ℤ] (ℤ × ℤ) where
  toFun z :=
    ((m : ℤ) * z.1 + (n : ℤ) * z.2,
      -ellM * z.1 + (ellN - (n : ℤ) * ell0) * z.2)
  map_add' u v := by ext <;> simp <;> ring
  map_smul' r u := by ext <;> simp <;> ring

/-- The abelian relation group associated to the two-exceptional presentation. -/
abbrev GluingCokernel (m n : ℕ) (ell0 ellM ellN : ℤ) :=
  (ℤ × ℤ) ⧸ LinearMap.range (relationMap m n ell0 ellM ellN)

/-- The coefficient of `c` in the Bézout combination whose `x`-coefficient is one. -/
def bezoutQ (m n : ℕ) (ell0 ellM ellN : ℤ) : ℤ :=
  -(m.gcdA n) * ellM + (m.gcdB n) * (ellN - (n : ℤ) * ell0)

private theorem bezout_identity {m n : ℕ} (hcop : m.Coprime n) :
    (m : ℤ) * m.gcdA n + (n : ℤ) * m.gcdB n = 1 := by
  rw [← Nat.gcd_eq_gcd_ab, hcop.gcd_eq_one]
  norm_num

/-- The map that retains the cyclic coordinate after the Bézout row operation. -/
def classifyingMap (m n : ℕ) (ell0 ellM ellN : ℤ) :
    (ℤ × ℤ) →ₗ[ℤ] ZMod (gluingDefect m n ell0 ellM ellN).natAbs where
  toFun z := ((z.2 - bezoutQ m n ell0 ellM ellN * z.1 : ℤ) :
    ZMod (gluingDefect m n ell0 ellM ellN).natAbs)
  map_add' u v := by simp; ring
  map_smul' r u := by simp; ring

private theorem classify_relation_eq {m n : ℕ} (hcop : m.Coprime n)
    (ell0 ellM ellN : ℤ) (z : ℤ × ℤ) :
    (relationMap m n ell0 ellM ellN z).2 -
        bezoutQ m n ell0 ellM ellN * (relationMap m n ell0 ellM ellN z).1 =
      gluingDefect m n ell0 ellM ellN * (m.gcdB n * z.1 - m.gcdA n * z.2) := by
  have hbez := bezout_identity hcop
  simp only [relationMap, LinearMap.coe_mk, AddHom.coe_mk, bezoutQ, gluingDefect]
  linear_combination
    ((n : ℤ) * ell0 * z.2 + ellM * z.1 - ellN * z.2) * hbez

/-- Every defining relation is killed by the cyclic classifying map. -/
theorem classifyingMap_relationMap_eq_zero {m n : ℕ} (hcop : m.Coprime n)
    (ell0 ellM ellN : ℤ) (z : ℤ × ℤ) :
    classifyingMap m n ell0 ellM ellN (relationMap m n ell0 ellM ellN z) = 0 := by
  change (((relationMap m n ell0 ellM ellN z).2 -
    bezoutQ m n ell0 ellM ellN * (relationMap m n ell0 ellM ellN z).1 : ℤ) :
      ZMod (gluingDefect m n ell0 ellM ellN).natAbs) = 0
  rw [classify_relation_eq hcop]
  rw [ZMod.intCast_zmod_eq_zero_iff_dvd, Int.natAbs_dvd]
  exact dvd_mul_right _ _

/-- The two relation rows generate exactly the kernel of the cyclic classifying map. -/
theorem range_relationMap_eq_ker_classifyingMap {m n : ℕ} (hcop : m.Coprime n)
    (ell0 ellM ellN : ℤ) :
    LinearMap.range (relationMap m n ell0 ellM ellN) =
      LinearMap.ker (classifyingMap m n ell0 ellM ellN) := by
  apply le_antisymm
  · rintro _ ⟨z, rfl⟩
    rw [LinearMap.mem_ker]
    exact classifyingMap_relationMap_eq_zero hcop ell0 ellM ellN z
  · intro z hz
    rw [LinearMap.mem_ker] at hz
    change ((z.2 - bezoutQ m n ell0 ellM ellN * z.1 : ℤ) :
      ZMod (gluingDefect m n ell0 ellM ellN).natAbs) = 0 at hz
    rw [ZMod.intCast_zmod_eq_zero_iff_dvd, Int.natAbs_dvd] at hz
    obtain ⟨k, hk⟩ := hz
    refine ⟨(m.gcdA n * z.1 + (n : ℤ) * k,
      m.gcdB n * z.1 - (m : ℤ) * k), ?_⟩
    apply Prod.ext
    · simp only [relationMap, LinearMap.coe_mk, AddHom.coe_mk]
      linear_combination z.1 * bezout_identity hcop
    · simp only [relationMap, LinearMap.coe_mk, AddHom.coe_mk, bezoutQ, gluingDefect] at hk ⊢
      linear_combination -hk

/-- The classifying map is onto: the second coordinate lifts every residue class. -/
theorem classifyingMap_surjective (m n : ℕ) (ell0 ellM ellN : ℤ) :
    Function.Surjective (classifyingMap m n ell0 ellM ellN) := by
  intro z
  obtain ⟨k, rfl⟩ := ZMod.intCast_surjective z
  refine ⟨(0, k), ?_⟩
  simp [classifyingMap]

/-- Explicit Smith reduction of the relation cokernel to one cyclic factor. -/
noncomputable def gluingCokernelEquivZMod {m n : ℕ} (hcop : m.Coprime n)
    (ell0 ellM ellN : ℤ) :
    GluingCokernel m n ell0 ellM ellN ≃+
      ZMod (gluingDefect m n ell0 ellM ellN).natAbs :=
  ((Submodule.quotEquivOfEq _ _
      (range_relationMap_eq_ker_classifyingMap hcop ell0 ellM ellN)).trans
    (LinearMap.quotKerEquivOfSurjective (classifyingMap m n ell0 ellM ellN)
      (classifyingMap_surjective m n ell0 ellM ellN))).toAddEquiv

/-- Multiplicative form of the abelian gluing group. -/
abbrev GluingGroup (m n : ℕ) (ell0 ellM ellN : ℤ) :=
  Multiplicative (GluingCokernel m n ell0 ellM ellN)

/-- The gluing group is abelian. -/
instance gluingGroupCommGroup (m n : ℕ) (ell0 ellM ellN : ℤ) :
    CommGroup (GluingGroup m n ell0 ellM ellN) := inferInstance

/-- Multiplicative classification of the gluing group by the defect. -/
noncomputable def gluingGroupEquivZMod {m n : ℕ} (hcop : m.Coprime n)
    (ell0 ellM ellN : ℤ) :
    GluingGroup m n ell0 ellM ellN ≃*
      Multiplicative (ZMod (gluingDefect m n ell0 ellM ellN).natAbs) :=
  AddEquiv.toMultiplicative (gluingCokernelEquivZMod hcop ell0 ellM ellN)

/-- When the defect vanishes, the relation cokernel is infinite cyclic. -/
noncomputable def gluingCokernelEquivIntOfDefectEqZero {m n : ℕ} (hcop : m.Coprime n)
    (ell0 ellM ellN : ℤ) (hp : gluingDefect m n ell0 ellM ellN = 0) :
    GluingCokernel m n ell0 ellM ellN ≃+ ℤ := by
  let e := gluingCokernelEquivZMod hcop ell0 ellM ellN
  have hp' : (gluingDefect m n ell0 ellM ellN).natAbs = 0 := by simp [hp]
  rw [hp'] at e
  exact e

/-- Unit defect makes the relation cokernel trivial. -/
theorem gluingCokernel_subsingleton_of_defect_natAbs_eq_one {m n : ℕ}
    (hcop : m.Coprime n) (ell0 ellM ellN : ℤ)
    (hp : (gluingDefect m n ell0 ellM ellN).natAbs = 1) :
    Subsingleton (GluingCokernel m n ell0 ellM ellN) := by
  let e := gluingCokernelEquivZMod hcop ell0 ellM ellN
  rw [hp] at e
  exact ⟨fun x y => e.injective (Subsingleton.elim _ _)⟩

/-- For consecutive orders and common projected-seed exponents, the relation cokernel is trivial. -/
theorem consecutive_gluingCokernel_subsingleton (m : ℕ) :
    Subsingleton (GluingCokernel m (m + 1) 0 1 (-1)) := by
  apply gluingCokernel_subsingleton_of_defect_natAbs_eq_one
  · simp
  · rw [gluingDefect_consecutive]
    norm_num

section GroupRelations

variable {G : Type*} [Group G]

/--
The decisive nonabelian step in the two-exceptional presentation: if `c, x, y` generate a group,
`c` is central, and `x * y` is a power of `c`, then the whole group is abelian.  The remaining
power relations are needed for the cyclic classification, but not for commutativity.
-/
theorem isMulCommutative_of_twoExceptionalRelations (c x y : G) (ell0 : ℤ)
    (hc : c ∈ Subgroup.center G) (hxy : x * y = c ^ ell0)
    (hgen : Subgroup.closure ({c, x, y} : Set G) = ⊤) : IsMulCommutative G := by
  have hxyCenter : x * y ∈ Subgroup.center G := by
    rw [hxy]
    exact Subgroup.zpow_mem _ hc ell0
  have hxyComm : x * y = y * x := by
    apply mul_left_cancel (a := x)
    calc
      x * (x * y) = (x * y) * x := Subgroup.mem_center_iff.mp hxyCenter x
      _ = x * (y * x) := mul_assoc x y x
  have hcomm : ∀ a ∈ ({c, x, y} : Set G), ∀ b ∈ ({c, x, y} : Set G), a * b = b * a := by
    intro a ha b hb
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at ha hb
    rcases ha with rfl | rfl | rfl <;> rcases hb with rfl | rfl | rfl
    all_goals first
      | rfl
      | exact (Subgroup.mem_center_iff.mp hc _).symm
      | exact Subgroup.mem_center_iff.mp hc _
      | exact hxyComm
      | exact hxyComm.symm
  have hgeneratorsCenter : ({c, x, y} : Set G) ⊆ Subgroup.center G := by
    intro a ha
    change a ∈ Subgroup.center G
    rw [Subgroup.mem_center_iff]
    intro g
    have hg : g ∈ Subgroup.closure ({c, x, y} : Set G) := by rw [hgen]; trivial
    have hle : Subgroup.closure ({c, x, y} : Set G) ≤ Subgroup.centralizer {a} :=
      (Subgroup.closure_le _).mpr fun b hb =>
        Subgroup.mem_centralizer_singleton_iff.mpr (hcomm a ha b hb).symm
    exact Subgroup.mem_centralizer_singleton_iff.mp (hle hg)
  rw [← Subgroup.center_eq_top_iff]
  apply top_unique
  rw [← hgen]
  exact (Subgroup.closure_le _).mpr hgeneratorsCenter

end GroupRelations

section PresentedGroup

/-- The three generators in the two-exceptional group presentation. -/
inductive GluingGenerator
  | central
  | first
  | second
  deriving DecidableEq

private abbrev freeC : FreeGroup GluingGenerator := FreeGroup.of .central
private abbrev freeX : FreeGroup GluingGenerator := FreeGroup.of .first
private abbrev freeY : FreeGroup GluingGenerator := FreeGroup.of .second

/--
The five relation words: `c` commutes with `x` and `y`, followed by the seam relation and the two
exceptional-power relations.
-/
def gluingRelations (m n : ℕ) (ell0 ellM ellN : ℤ) : Set (FreeGroup GluingGenerator) :=
  {freeC * freeX * (freeX * freeC)⁻¹,
    freeC * freeY * (freeY * freeC)⁻¹,
    freeX * freeY * (freeC ^ ell0)⁻¹,
    freeX ^ m * (freeC ^ ellM)⁻¹,
    freeY ^ n * (freeC ^ ellN)⁻¹}

/-- The literal group presentation used in the two-exceptional gluing calculation. -/
abbrev PresentedGluingGroup (m n : ℕ) (ell0 ellM ellN : ℤ) :=
  PresentedGroup (gluingRelations m n ell0 ellM ellN)

private theorem presented_relation_eq_one {m n : ℕ} {ell0 ellM ellN : ℤ}
    {w : FreeGroup GluingGenerator} (hw : w ∈ gluingRelations m n ell0 ellM ellN) :
    PresentedGroup.mk (gluingRelations m n ell0 ellM ellN) w = 1 :=
  PresentedGroup.one_of_mem hw

/-- The literal presented group is abelian; this is the nonabelian half of Theorem 6.8. -/
theorem presentedGluingGroup_isMulCommutative (m n : ℕ) (ell0 ellM ellN : ℤ) :
    IsMulCommutative (PresentedGluingGroup m n ell0 ellM ellN) := by
  let c : PresentedGluingGroup m n ell0 ellM ellN := PresentedGroup.of .central
  let x : PresentedGluingGroup m n ell0 ellM ellN := PresentedGroup.of .first
  let y : PresentedGluingGroup m n ell0 ellM ellN := PresentedGroup.of .second
  have hcx : c * x = x * c := by
    apply eq_of_mul_inv_eq_one
    simpa only [map_mul, map_inv, PresentedGroup.of, c, x] using
      (presented_relation_eq_one (m := m) (n := n) (ell0 := ell0) (ellM := ellM)
        (ellN := ellN) (show freeC * freeX * (freeX * freeC)⁻¹ ∈
          gluingRelations m n ell0 ellM ellN by simp [gluingRelations]))
  have hcy : c * y = y * c := by
    apply eq_of_mul_inv_eq_one
    simpa only [map_mul, map_inv, PresentedGroup.of, c, y] using
      (presented_relation_eq_one (m := m) (n := n) (ell0 := ell0) (ellM := ellM)
        (ellN := ellN) (show freeC * freeY * (freeY * freeC)⁻¹ ∈
          gluingRelations m n ell0 ellM ellN by simp [gluingRelations]))
  have hxy : x * y = c ^ ell0 := by
    apply eq_of_mul_inv_eq_one
    simpa only [map_mul, map_inv, map_zpow, PresentedGroup.of, c, x, y] using
      (presented_relation_eq_one (m := m) (n := n) (ell0 := ell0) (ellM := ellM)
        (ellN := ellN) (show freeX * freeY * (freeC ^ ell0)⁻¹ ∈
          gluingRelations m n ell0 ellM ellN by simp [gluingRelations]))
  have hgen : Subgroup.closure ({c, x, y} : Set (PresentedGluingGroup m n ell0 ellM ellN)) = ⊤ := by
    rw [← PresentedGroup.closure_range_of (gluingRelations m n ell0 ellM ellN)]
    congr 1
    ext g
    constructor
    · intro hg
      simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hg
      rcases hg with rfl | rfl | rfl
      · exact ⟨.central, rfl⟩
      · exact ⟨.first, rfl⟩
      · exact ⟨.second, rfl⟩
    · rintro ⟨i, rfl⟩
      cases i <;> simp [c, x, y]
  have hc : c ∈ Subgroup.center (PresentedGluingGroup m n ell0 ellM ellN) := by
    rw [Subgroup.mem_center_iff]
    intro g
    have hg : g ∈ Subgroup.closure ({c, x, y} :
        Set (PresentedGluingGroup m n ell0 ellM ellN)) := by rw [hgen]; trivial
    have hle : Subgroup.closure ({c, x, y} :
        Set (PresentedGluingGroup m n ell0 ellM ellN)) ≤ Subgroup.centralizer {c} :=
      (Subgroup.closure_le _).mpr fun a ha => by
        simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at ha
        rcases ha with rfl | rfl | rfl
        · exact Subgroup.mem_centralizer_singleton_iff.mpr rfl
        · exact Subgroup.mem_centralizer_singleton_iff.mpr hcx.symm
        · exact Subgroup.mem_centralizer_singleton_iff.mpr hcy.symm
    exact Subgroup.mem_centralizer_singleton_iff.mp (hle hg)
  exact isMulCommutative_of_twoExceptionalRelations c x y ell0 hc hxy hgen

end PresentedGroup

section ProjectedSeed

variable {M : Type*} [AddCommGroup M] [Module ℚ M]

/--
An invariant observable evaluates a common seed and its two oppositely signed cyclic projections
as `(1, -1)`.  This is the abstract averaging input behind the exponent triple `(0, 1, -1)`.
-/
theorem common_projected_seed_observables (m n : ℕ) [Invertible (m : ℚ)] [Invertible (n : ℚ)]
    (A B : Module.End ℚ M) (lambda : M →ₗ[ℚ] ℚ) (g : M)
    (hA : lambda.comp A = lambda) (hB : lambda.comp B = lambda) (hg : lambda g = 1) :
    lambda (S6.CyclicAverage.cyclicAverage m A g) = 1 ∧
      lambda (-S6.CyclicAverage.cyclicAverage n B g) = -1 := by
  constructor
  · have h := DFunLike.congr_fun
      (S6.CyclicAverage.comp_cyclicAverage (m := m) lambda hA) g
    simpa only [LinearMap.comp_apply, hg] using h
  · have h := DFunLike.congr_fun
      (S6.CyclicAverage.comp_cyclicAverage (m := n) lambda hB) g
    simp only [LinearMap.comp_apply] at h
    rw [map_neg, h, hg]

end ProjectedSeed

end S6.TwoExceptionalGluing
