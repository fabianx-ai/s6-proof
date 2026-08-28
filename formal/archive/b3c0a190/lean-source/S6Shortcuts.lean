import Mathlib

/-!
Finite certificates for the proposed (3,4,infinity) complex six-sphere construction.

Scope:
* exact monodromy matrices;
* the square-zero cusp operator;
* the invariant alternating form;
* the two cyclic averaging projectors;
* the projected twist vectors;
* the local and global unimodular matrices;
* the generic defect arithmetic.

The analytic construction of the torus family, toric quotient, logarithmic
transforms, and integral nearby-cycle package is intentionally outside this file.
-/

open Matrix
open scoped Matrix

namespace S6Shortcuts

abbrev M4Q := Matrix (Fin 4) (Fin 4) ℚ
abbrev V4Q := Fin 4 → ℚ
abbrev M2Z := Matrix (Fin 2) (Fin 2) ℤ

/-! ## Monodromy and the square-zero cusp -/

def T1 : M4Q :=
  !![1,  0, -6,  2;
     0, -1,  1,  1;
     0, -1,  0,  1;
     0,  0,  0,  1]

def T2 : M4Q :=
  !![1, 6,  0, -3;
     0, 0, -1,  1;
     0, 1,  0,  0;
     0, 0,  0,  1]

def T0 : M4Q :=
  !![1, 0,  0, 1;
     0, 1, -1, 0;
     0, 0,  1, 0;
     0, 0,  0, 1]

def N : M4Q :=
  !![0, 0,  0, 1;
     0, 0, -1, 0;
     0, 0,  0, 0;
     0, 0,  0, 0]

theorem T1_order_three : T1 ^ 3 = 1 := by
  native_decide

theorem T2_order_four : T2 ^ 4 = 1 := by
  native_decide

theorem T0_is_I_add_N : T0 = 1 + N := by
  native_decide

theorem T0_is_product_inverse_left : T0 * (T1 * T2) = 1 := by
  native_decide

theorem T0_is_product_inverse_right : (T1 * T2) * T0 = 1 := by
  native_decide

theorem N_square_zero : N * N = 0 := by
  native_decide

/-! ## Dual monodromy -/

def A1 : M4Q :=
  !![ 1,  0,  0, 0;
      6,  0,  1, 0;
     -6, -1, -1, 0;
     -2,  1,  0, 1]

def A2 : M4Q :=
  !![ 1, 0,  0, 0;
      0, 0, -1, 0;
     -6, 1,  0, 0;
      3, 0,  1, 1]

theorem A1_order_three : A1 ^ 3 = 1 := by
  native_decide

theorem A2_order_four : A2 ^ 4 = 1 := by
  native_decide

/-! ## Conserved alternating form -/

def Q0 : M4Q :=
  !![ 0,  0, 0, 1;
      0,  0, 6, 0;
      0, -6, 0, 0;
     -1,  0, 0, 0]

theorem T1_preserves_Q0 : Matrix.transpose T1 * Q0 * T1 = Q0 := by
  native_decide

theorem T2_preserves_Q0 : Matrix.transpose T2 * Q0 * T2 = Q0 := by
  native_decide

theorem N_infinitesimally_preserves_Q0 :
    Matrix.transpose N * Q0 + Q0 * N = 0 := by
  native_decide

theorem N_quadratic_Q0_term_vanishes :
    Matrix.transpose N * Q0 * N = 0 := by
  native_decide

/-! ## Cyclic averaging projectors -/

def P3 : M4Q :=
  !![1, 0,   0,   0;
     2, 0,   0,   0;
    -4, 0,   0,   0;
     0, 2/3, 1/3, 1]

def P4 : M4Q :=
  !![1, 0,   0,   0;
     3, 0,   0,   0;
    -3, 0,   0,   0;
     0, 1/2, 1/2, 1]

theorem P3_is_cyclic_average :
    P3 = ((1 : ℚ) / 3) • (1 + A1 + A1 ^ 2) := by
  native_decide

theorem P4_is_cyclic_average :
    P4 = ((1 : ℚ) / 4) • (1 + A2 + A2 ^ 2 + A2 ^ 3) := by
  native_decide

theorem P3_idempotent : P3 * P3 = P3 := by
  native_decide

theorem P4_idempotent : P4 * P4 = P4 := by
  native_decide

theorem A1_fixes_P3 : A1 * P3 = P3 := by
  native_decide

theorem A2_fixes_P4 : A2 * P4 = P4 := by
  native_decide

/-! ## Common seed and projected twists -/

def eGamma : V4Q := ![1, 0, 0, 0]
def epsilon : V4Q := ![1, 2, -4, 0]
def epsilonPrime : V4Q := ![1, 3, -3, 0]
def v1 : V4Q := epsilon
def v2 : V4Q := -epsilonPrime

def gammaValue (v : V4Q) : ℚ := v 0

theorem P3_projects_seed : Matrix.mulVec P3 eGamma = epsilon := by
  native_decide

theorem P4_projects_seed : Matrix.mulVec P4 eGamma = epsilonPrime := by
  native_decide

theorem epsilon_fixed : Matrix.mulVec A1 epsilon = epsilon := by
  native_decide

theorem epsilonPrime_fixed : Matrix.mulVec A2 epsilonPrime = epsilonPrime := by
  native_decide

theorem gamma_epsilon : gammaValue epsilon = 1 := by
  native_decide

theorem gamma_epsilonPrime : gammaValue epsilonPrime = 1 := by
  native_decide

theorem gamma_v1 : gammaValue v1 = 1 := by
  native_decide

theorem gamma_v2 : gammaValue v2 = -1 := by
  native_decide

/-! ## Local and global unimodular certificates -/

def B0 : M2Z :=
  !![ 0, 1;
     -1, 0]

def B0Inv : M2Z :=
  !![0, -1;
     1,  0]

theorem B0_mul_inverse : B0 * B0Inv = 1 := by
  native_decide

theorem B0_inverse_mul : B0Inv * B0 = 1 := by
  native_decide

def relationMatrix : M2Z :=
  !![3, -1;
     4, -1]

def relationMatrixInv : M2Z :=
  !![-1, 1;
     -4, 3]

theorem relation_mul_inverse : relationMatrix * relationMatrixInv = 1 := by
  native_decide

theorem relation_inverse_mul : relationMatrixInv * relationMatrix = 1 := by
  native_decide

/-! ## Generic defect arithmetic -/

def defect (m n ell0 ellM ellN : ℤ) : ℤ :=
  m * n * ell0 - n * ellM - m * ellN

theorem defect_of_projected_seed (m n : ℤ) :
    defect m n 0 1 (-1) = m - n := by
  simp [defect]
  ring

theorem consecutive_order_defect (m : ℤ) :
    defect m (m + 1) 0 1 (-1) = -1 := by
  simp [defect]

theorem defect_three_four : defect 3 4 0 1 (-1) = -1 := by
  norm_num [defect]

/-! ## Euler certificate -/

theorem central_fibre_euler : (0 : ℤ) + 3 * 0 + 2 = 2 := by
  norm_num

end S6Shortcuts
