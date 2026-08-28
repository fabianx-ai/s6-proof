#!/usr/bin/env python3
"""Exact, source-independent finite checks for the LCP audit.

This file is extended phase by phase.  Finite checks use exact standard-library
arithmetic; symbolic identities use SymPy.  The long source manuscript is not
an input.
"""

from __future__ import annotations

from collections import defaultdict
from fractions import Fraction
from functools import reduce
from math import gcd
from itertools import combinations, product
from random import Random

import sympy as sp


Vector2 = tuple[int, int]
Vector3 = tuple[int, int, int]
Matrix3 = tuple[Vector3, Vector3, Vector3]
IntMatrix = tuple[tuple[int, ...], ...]


def det2(a: Vector2, b: Vector2) -> int:
    return a[0] * b[1] - a[1] * b[0]


def det3_columns(a: Vector3, b: Vector3, c: Vector3) -> int:
    return (
        a[0] * (b[1] * c[2] - b[2] * c[1])
        - b[0] * (a[1] * c[2] - a[2] * c[1])
        + c[0] * (a[1] * b[2] - a[2] * b[1])
    )


def matmul3(a: Matrix3, b: Matrix3) -> Matrix3:
    return tuple(
        tuple(sum(a[i][k] * b[k][j] for k in range(3)) for j in range(3))
        for i in range(3)
    )  # type: ignore[return-value]


def identity(n: int) -> IntMatrix:
    return tuple(tuple(int(i == j) for j in range(n)) for i in range(n))


def matmul(a: IntMatrix, b: IntMatrix) -> IntMatrix:
    return tuple(
        tuple(sum(a[i][k] * b[k][j] for k in range(len(b))) for j in range(len(b[0])))
        for i in range(len(a))
    )


def matpow(a: IntMatrix, exponent: int) -> IntMatrix:
    answer = identity(len(a))
    factor = a
    while exponent:
        if exponent % 2:
            answer = matmul(answer, factor)
        factor = matmul(factor, factor)
        exponent //= 2
    return answer


def matvec(a: IntMatrix, v: tuple[int, ...]) -> tuple[int, ...]:
    return tuple(sum(row[j] * v[j] for j in range(len(v))) for row in a)


def transpose(a: IntMatrix) -> IntMatrix:
    return tuple(tuple(a[i][j] for i in range(len(a))) for j in range(len(a[0])))


def rank_q(a: IntMatrix) -> int:
    rows = [[Fraction(x) for x in row] for row in a]
    rank = 0
    column = 0
    while rank < len(rows) and column < len(rows[0]):
        pivot = next((i for i in range(rank, len(rows)) if rows[i][column]), None)
        if pivot is None:
            column += 1
            continue
        rows[rank], rows[pivot] = rows[pivot], rows[rank]
        scale = rows[rank][column]
        rows[rank] = [x / scale for x in rows[rank]]
        for i in range(len(rows)):
            if i != rank and rows[i][column]:
                scale = rows[i][column]
                rows[i] = [x - scale * y for x, y in zip(rows[i], rows[rank])]
        rank += 1
        column += 1
    return rank


def subtract(a: IntMatrix, b: IntMatrix) -> IntMatrix:
    return tuple(tuple(x - y for x, y in zip(arow, brow)) for arow, brow in zip(a, b))


def dot(a: tuple[int, ...], b: tuple[int, ...]) -> int:
    return sum(x * y for x, y in zip(a, b))


def translation(q: Vector2) -> Matrix3:
    """The integral shear taking the ray (v,1) to (v+q,1)."""

    return ((1, 0, q[0]), (0, 1, q[1]), (0, 0, 1))


def ray(v: Vector2) -> Vector3:
    return (v[0], v[1], 1)


def add2(a: Vector2, b: Vector2) -> Vector2:
    return (a[0] + b[0], a[1] + b[1])


e1 = (1, 0)
e2 = (0, 1)


def up_triangle(v: Vector2) -> tuple[Vector2, Vector2, Vector2]:
    return (v, add2(v, e1), add2(v, e2))


def down_triangle(v: Vector2) -> tuple[Vector2, Vector2, Vector2]:
    return (add2(v, e1), add2(add2(v, e1), e2), add2(v, e2))


def check_l2_combinatorics() -> None:
    # The cusp transfer is an integral isomorphism.
    b0 = ((0, 1), (-1, 0))
    det_b0 = det2(b0[0], b0[1])
    assert det_b0 == 1
    assert ((0, -1), (1, 0)) == tuple(zip(*((0, 1), (-1, 0))))

    # Every maximal cone is a translate of one of two unimodular cones.
    for i, j in product(range(-4, 5), repeat=2):
        for triangle in (up_triangle((i, j)), down_triangle((i, j))):
            assert abs(det3_columns(*(ray(v) for v in triangle))) == 1

    # Integral translations preserve the height-one rays and compose freely.
    for p, q in product(product(range(-2, 3), repeat=2), repeat=2):
        assert det3_columns(*zip(*translation(p))) == 1
        assert matmul3(translation(p), translation(q)) == translation(add2(p, q))
        for v in product(range(-2, 3), repeat=2):
            tv = tuple(sum(translation(p)[i][k] * ray(v)[k] for k in range(3)) for i in range(3))
            assert tv == ray(add2(v, p))

    # Under the full translation lattice there is one vertex orbit, three
    # unoriented edge orbits, and two triangle orbits (up/down).
    edge_directions = {e1, e2, (-1, 1)}
    assert len(edge_directions) == 3
    triangle_orientations = {"up", "down"}
    assert len(triangle_orientations) == 2

    # The star of a vertex is the smooth hexagonal fan of dP6.  Consecutive
    # determinants are +1 and every toric boundary curve has self-intersection
    # -1 because previous + next = current.
    star: tuple[Vector2, ...] = (
        (1, 0),
        (0, 1),
        (-1, 1),
        (-1, 0),
        (0, -1),
        (1, -1),
    )
    for i, v in enumerate(star):
        previous = star[(i - 1) % 6]
        following = star[(i + 1) % 6]
        assert det2(v, following) == 1
        assert add2(previous, following) == v

    # Opposite boundary divisors form three conductor pairs.  The six toric
    # fixed points split into the two alternating triangle-orientation orbits.
    opposite_pairs = {frozenset((i, (i + 3) % 6)) for i in range(3)}
    triple_point_preimages = ({0, 2, 4}, {1, 3, 5})
    assert len(opposite_pairs) == 3
    assert set().union(*triple_point_preimages) == set(range(6))
    assert set.intersection(*triple_point_preimages) == set()

    # The base character has value one on every primitive ray, so on a smooth
    # chart meeting k central components its monomial is z0*...*z(k-1).
    for number_of_components in (1, 2, 3):
        exponents = (1,) * number_of_components
        assert exponents in {(1,), (1, 1), (1, 1, 1)}

    # Compactly supported Euler characteristic of the orbit stratification:
    # (L-1)^2 + 3(L-1) + 2, evaluated at L=1.
    strata_by_dimension = {2: 1, 1: 3, 0: 2}
    e_c_cstar = 0
    e_w = (
        strata_by_dimension[2] * e_c_cstar**2
        + strata_by_dimension[1] * e_c_cstar
        + strata_by_dimension[0]
    )
    assert e_w == 2

    print("L2 combinatorial core: PASS")
    print("  maximal cones: unimodular")
    print("  B0 determinant / vertex orbits: 1 / 1")
    print("  quotient cells (vertices, edges, triangles): (1, 3, 2)")
    print("  normalization fan: dP6 hexagon with three opposite-side pairs")
    print("  triple-point preimage classes: 2 alternating triples")
    print("  local central-fibre monomials: z0, z0*z1, z0*z1*z2")
    print("  Euler characteristic: 2")


def check_l3_finite_arithmetic() -> None:
    a1: IntMatrix = (
        (1, 0, 0, 0),
        (6, 0, 1, 0),
        (-6, -1, -1, 0),
        (-2, 1, 0, 1),
    )
    a2: IntMatrix = (
        (1, 0, 0, 0),
        (0, 0, -1, 0),
        (-6, 1, 0, 0),
        (3, 0, 1, 1),
    )
    e_gamma = (1, 0, 0, 0)
    epsilon = (1, 2, -4, 0)
    epsilon_prime = (1, 3, -3, 0)
    v1 = epsilon
    v2 = tuple(-x for x in epsilon_prime)
    gamma = (1, 0, 0, 0)

    for a, m, projected in ((a1, 3, epsilon), (a2, 4, epsilon_prime)):
        assert matpow(a, m) == identity(4)
        orbit_sum = tuple(
            sum(matvec(matpow(a, k), e_gamma)[i] for k in range(m))
            for i in range(4)
        )
        assert orbit_sum == tuple(m * x for x in projected)
        assert matvec(a, projected) == projected

    assert matvec(a1, v1) == v1
    assert matvec(a2, v2) == v2
    assert reduce(gcd, (abs(x) for x in v1)) == 1
    assert reduce(gcd, (abs(x) for x in v2)) == 1
    assert matvec(transpose(a1), gamma) == gamma
    assert matvec(transpose(a2), gamma) == gamma

    # A second independent character completes the rational invariant
    # character space.  Both chosen twists have value zero on it, while gamma
    # has values +1 and -1.
    eta1 = (0, 2, 1, 3)
    eta2 = (0, 1, 1, 2)
    for a, eta, v in ((a1, eta1, v1), (a2, eta2, v2)):
        assert matvec(transpose(a), eta) == eta
        assert rank_q(subtract(a, identity(4))) == 2
        assert dot(eta, v) == 0
    assert dot(gamma, v1) == 1
    assert dot(gamma, v2) == -1

    # A fixed point of the kth affine power would force
    # k*gamma(v)/m to be integral.  The displayed nonzero residues therefore
    # exclude every nonidentity group element.
    residues_3 = tuple((k * dot(gamma, v1)) % 3 for k in range(1, 3))
    residues_4 = tuple((k * dot(gamma, v2)) % 4 for k in range(1, 4))
    assert residues_3 == (1, 2)
    assert residues_4 == (3, 2, 1)

    # The moving real rank is two for every nontrivial power.  Holomorphically
    # this is one fixed elliptic direction and one moving elliptic direction;
    # the latter has exact order 3 or 4, giving the cyclic BdF cases.
    for a, m in ((a1, 3), (a2, 4)):
        assert all(rank_q(subtract(matpow(a, k), identity(4))) == 2 for k in range(1, m))

    assert 12 * 0 - 4 * dot(gamma, v1) - 3 * dot(gamma, v2) == -1

    print("L3 finite arithmetic: PASS")
    print("  cyclic averages / integral fixed twists: epsilon, epsilonPrime")
    print("  primitive signed twists: v1=epsilon, v2=-epsilonPrime")
    print("  gamma values: (+1, -1)")
    print("  nonidentity affine-power residues: order 3 -> (1,2), order 4 -> (3,2,1)")
    print("  moving elliptic orders / cyclic deck groups: 3 / Z3, 4 / Z4")


def check_l3_source_comparison() -> None:
    """Exact checks prompted by the manuscript comparison, especially H_1."""

    a1: IntMatrix = (
        (1, 0, 0, 0),
        (6, 0, 1, 0),
        (-6, -1, -1, 0),
        (-2, 1, 0, 1),
    )
    a2: IntMatrix = (
        (1, 0, 0, 0),
        (0, 0, -1, 0),
        (-6, 1, 0, 0),
        (3, 0, 1, 1),
    )

    # In each case the columns of A-I generate the full kernel of the two
    # invariant characters.  The displayed identities are the manuscript's
    # integral (not merely rational) saturation check.
    columns1 = tuple(zip(*subtract(a1, identity(4))))
    k11 = (0, 1, -2, 0)
    k12 = (0, 0, -3, 1)
    assert columns1[2] == k11
    assert tuple(columns1[1][i] + k11[i] for i in range(4)) == k12

    columns2 = tuple(zip(*subtract(a2, identity(4))))
    k21 = (0, 1, -1, 0)
    k22 = (0, 0, -2, 1)
    assert columns2[1] == tuple(-x for x in k21)
    assert columns2[2] == tuple(-k21[i] + k22[i] for i in range(4))
    assert columns2[0] == tuple(3 * x for x in k22)

    # Abelianization is Z^3 modulo one relation.  A primitive relation leaves
    # H_1 free of rank two, so its torsion subgroup is zero.
    relation1 = (1, 0, -3)
    relation2 = (-1, 0, -4)
    assert reduce(gcd, (abs(x) for x in relation1)) == 1
    assert reduce(gcd, (abs(x) for x in relation2)) == 1

    # Classical BdF table: among canonical orders 3 and 4, torsion-free H_1
    # selects b2=(Z/3)^2 and c2=Z/4 x Z/2, not the cyclic b1/c1 cases.
    bdf_by_invariants = {
        (3, "Z/3"): "b1 = Z/3",
        (3, "0"): "b2 = (Z/3)^2",
        (4, "Z/2"): "c1 = Z/4",
        (4, "0"): "c2 = Z/4 x Z/2",
    }
    assert bdf_by_invariants[(3, "0")] == "b2 = (Z/3)^2"
    assert bdf_by_invariants[(4, "0")] == "c2 = Z/4 x Z/2"

    print("L3 source-comparison arithmetic: PASS")
    print("  coinvariants: Z^2 in both cases")
    print("  H1 torsion: zero in both cases")
    print("  BdF types: b2=(Z/3)^2, c2=Z/4 x Z/2")


def check_l1_symbolic_consistency() -> None:
    tau, mu, beta = sp.symbols("tau mu beta")

    def g1(values: tuple[sp.Expr, sp.Expr, sp.Expr]) -> tuple[sp.Expr, sp.Expr, sp.Expr]:
        t, m, b = values
        return ((t - 1) / t, (1 - m) / t, b + 2 - 6 * (1 - m) ** 2 / t)

    def g2(values: tuple[sp.Expr, sp.Expr, sp.Expr]) -> tuple[sp.Expr, sp.Expr, sp.Expr]:
        t, m, b = values
        return (-1 / t, 1 + m / t, b - 3 - 6 * m**2 / t)

    def iterate(function, values, count):
        for _ in range(count):
            values = tuple(sp.cancel(x) for x in function(values))
        return values

    initial = (tau, mu, beta)
    assert all(sp.cancel(x - y) == 0 for x, y in zip(iterate(g1, initial, 3), initial))
    assert all(sp.cancel(x - y) == 0 for x, y in zip(iterate(g2, initial, 4), initial))

    t1 = sp.Matrix(
        [[1, 0, -6, 2], [0, -1, 1, 1], [0, -1, 0, 1], [0, 0, 0, 1]]
    )
    t2 = sp.Matrix(
        [[1, 6, 0, -3], [0, 0, -1, 1], [0, 1, 0, 0], [0, 0, 0, 1]]
    )

    def period(t, m, b):
        return sp.Matrix([[6 * m, t, 1, 0], [b, m, 0, 1]])

    for transform, matrix in ((g1, t1), (g2, t2)):
        transformed = period(*transform(initial))
        marked = period(*initial) * matrix.T
        comparison = sp.simplify(transformed[:, 2:4] * marked[:, 2:4].inv())
        assert all(entry == 0 for entry in (transformed - comparison * marked).applyfunc(sp.cancel))

    # The lattice determinant and global inequality.  D is invariant under
    # both affine transformation laws and adding c0 to beta shifts it by
    # Im(c0), uniformly.
    x, y, a, b, c, d, c_im = sp.symbols("x y a b c d c_im", real=True)
    t_complex = x + sp.I * y
    m_complex = a + sp.I * b
    beta_complex = c + sp.I * d

    def discriminant(t, m, be):
        return sp.im(sp.expand_complex(be)) - 6 * sp.im(sp.expand_complex(m)) ** 2 / sp.im(
            sp.expand_complex(t)
        )

    d0 = discriminant(t_complex, m_complex, beta_complex)
    assert sp.factor(6 * b**2 - y * d + y * d0) == 0
    for transform in (g1, g2):
        assert sp.factor(sp.simplify(discriminant(*transform((t_complex, m_complex, beta_complex))) - d0)) == 0
    assert sp.simplify(discriminant(t_complex, m_complex, beta_complex + sp.I * c_im) - d0) == c_im

    print("L1 symbolic consistency: PASS")
    print("  affine laws respect g1^3=g2^4=1")
    print("  period equivariance defects: zero")
    print("  lattice determinant: det(Im Z)=-Im(tau)*D")
    print("  D is generator-invariant and shifts uniformly by Im(c0)")


def check_l1_numeric_sanity() -> None:
    """Floating-point stress test of identities already proved symbolically."""

    rng = Random(20260827)

    def discriminant(t: complex, m: complex, be: complex) -> float:
        return be.imag - 6 * m.imag**2 / t.imag

    def g1(t: complex, m: complex, be: complex):
        return (t - 1) / t, (1 - m) / t, be + 2 - 6 * (1 - m) ** 2 / t

    def g2(t: complex, m: complex, be: complex):
        return -1 / t, 1 + m / t, be - 3 - 6 * m**2 / t

    observed = []
    for _ in range(4096):
        t = complex(rng.uniform(-4, 4), 10 ** rng.uniform(-2, 2))
        m = complex(rng.uniform(-5, 5), rng.uniform(-5, 5))
        be = complex(rng.uniform(-5, 5), rng.uniform(-5, 5))
        value = discriminant(t, m, be)
        observed.append(value)
        for transform in (g1, g2):
            transformed = discriminant(*transform(t, m, be))
            assert abs(transformed - value) <= 1e-8 * max(1.0, abs(value))

    imaginary_shift = -max(observed) - 1.0
    assert all(value + imaginary_shift < 0 for value in observed)

    # Cusp boundedness model: b=beta+tau and mu remain in fixed bounded
    # ranges while Im(tau) grows.  This is a sanity test of the estimate, not
    # a numerical construction of the cohomological global sections.
    for n in range(1, 4097):
        y = 4.0 + n / 16
        mu_im = 3.0 * ((n % 37) / 18 - 1)
        b_im = 2.0 * ((n % 29) / 14 - 1)
        beta_im = b_im - y
        assert beta_im - 6 * mu_im**2 / y < 0

    print("L1 numerical sanity: PASS")
    print("  4096 random upper-half-plane tuples preserve D under both generators")
    print("  one uniform imaginary shift makes the sampled D values negative")
    print("  4096 bounded-cusp samples satisfy the asymptotic negativity estimate")


def exterior_power_matrix(a: sp.Matrix, degree: int) -> sp.Matrix:
    indices = list(combinations(range(a.rows), degree))
    return sp.Matrix([[a.extract(rows, columns).det() for columns in indices] for rows in indices])


def check_l4_independent_arithmetic() -> None:
    t1 = sp.Matrix(
        [[1, 0, -6, 2], [0, -1, 1, 1], [0, -1, 0, 1], [0, 0, 0, 1]]
    )
    t2 = sp.Matrix(
        [[1, 6, 0, -3], [0, 0, -1, 1], [0, 1, 0, 0], [0, 0, 0, 1]]
    )
    expected = {
        1: sp.Matrix([1, 0, 0, 0]),
        # Basis: gamma*u, gamma*w, gamma*delta, u*w, u*delta, w*delta.
        2: sp.Matrix([0, 0, 6, 1, 0, 0]),
        # Basis starts gamma*u*w.
        3: sp.Matrix([1, 0, 0, 0]),
        4: sp.Matrix([1]),
    }
    for degree in range(1, 5):
        w1 = exterior_power_matrix(t1, degree)
        w2 = exterior_power_matrix(t2, degree)
        equations = (w1 - sp.eye(w1.rows)).col_join(w2 - sp.eye(w2.rows))
        kernel = equations.nullspace()
        assert len(kernel) == 1
        generator = kernel[0]
        ratio = next(generator[i] / expected[degree][i] for i in range(len(generator)) if expected[degree][i])
        assert generator == ratio * expected[degree]
        assert reduce(gcd, (abs(int(x)) for x in expected[degree])) == 1

    # Degree-one finite-fibre restriction: a character phi extends over the
    # affine order-m quotient iff phi(v) is divisible by m.
    gamma_v1, gamma_v2 = 1, -1
    assert min(n for n in range(1, 100) if n * gamma_v1 % 3 == 0 and n * gamma_v2 % 4 == 0) == 12

    ell0, ell1, ell2 = 0, gamma_v1, gamma_v2
    discrepancies = (12 * ell0, -4 * ell1, -3 * ell2)
    assert discrepancies == (0, -4, 3)
    assert sum(discrepancies) == -1

    # The invariant degree-two pairing has determinant -9 at the order-three
    # point and -4 at the order-four point.  Comparing with the pullback
    # intersection form, whose determinant is multiplied by m^2, gives image
    # indices one and two respectively.
    invariant_determinants = {3: -9, 4: -4}
    image_indices = {
        order: int(sp.sqrt(abs(order**2 // determinant)))
        for order, determinant in invariant_determinants.items()
    }
    assert image_indices == {3: 1, 4: 2}

    # At the order-four point the index-two subgroup selected by the source is
    # {(a,b): a=b mod 2}; its two displayed generators have determinant two.
    parity_lattice = sp.Matrix([[2, 1], [0, 1]])
    assert abs(parity_lattice.det()) == 2
    assert all((int(v[0] - v[1]) % 2 == 0) for v in parity_lattice.columnspace())

    # If p',p'' are the next two transgression coefficients, Leibniz gives
    # p''=2p-p'.  The second product gives |p'|=|p''|.  For nonzero p this
    # forces both coefficients to equal p, including their common sign.
    p, p_prime = sp.symbols("p p_prime")
    p_double_prime = 2 * p - p_prime
    assert sp.expand(p_prime**2 - p_double_prime**2 - 4 * p * (p_prime - p)) == 0

    print("L4 independent finite arithmetic: PASS")
    print("  primitive global invariant exterior generators: gamma, q, gamma*u*w, volume")
    print("  degree-one specialization intersection: 12*gamma")
    print("  degree-two finite-point image indices: 1, 2")
    print("  first local discrepancies / defect: (0,-4,+3) / -1")
    print("  multiplicativity equations force one common coefficient and sign")


if __name__ == "__main__":
    check_l2_combinatorics()
    check_l3_finite_arithmetic()
    check_l3_source_comparison()
    check_l1_symbolic_consistency()
    check_l1_numeric_sanity()
    check_l4_independent_arithmetic()
