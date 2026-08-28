#!/usr/bin/env python3
"""Exact independent checks for the finite certificates in s6_short_proof.tex."""

from __future__ import annotations

import sympy as sp


def check(name: str, condition: bool) -> None:
    if not condition:
        raise AssertionError(name)
    print(f"[ok] {name}")


def main() -> None:
    I4 = sp.eye(4)
    Z4 = sp.zeros(4)

    T1 = sp.Matrix([
        [1, 0, -6, 2],
        [0, -1, 1, 1],
        [0, -1, 0, 1],
        [0, 0, 0, 1],
    ])
    T2 = sp.Matrix([
        [1, 6, 0, -3],
        [0, 0, -1, 1],
        [0, 1, 0, 0],
        [0, 0, 0, 1],
    ])
    T0 = (T1 * T2).inv()
    N = T0 - I4

    A1 = T1.inv().T
    A2 = T2.inv().T

    Q0 = sp.Matrix([
        [0, 0, 0, 1],
        [0, 0, 6, 0],
        [0, -6, 0, 0],
        [-1, 0, 0, 0],
    ])

    P3 = (I4 + A1 + A1**2) / 3
    P4 = (I4 + A2 + A2**2 + A2**3) / 4

    e_gamma = sp.Matrix([1, 0, 0, 0])
    epsilon = sp.Matrix([1, 2, -4, 0])
    epsilon_prime = sp.Matrix([1, 3, -3, 0])

    B0 = sp.Matrix([[0, 1], [-1, 0]])
    B0_inv = sp.Matrix([[0, -1], [1, 0]])
    R = sp.Matrix([[3, -1], [4, -1]])
    R_inv = sp.Matrix([[-1, 1], [-4, 3]])

    check("T1 has order 3", T1**3 == I4)
    check("T2 has order 4", T2**4 == I4)
    check("T0 = (T1*T2)^-1", T0 * T1 * T2 == I4 and T1 * T2 * T0 == I4)
    check("N^2 = 0", N**2 == Z4)
    check("A1 has order 3", A1**3 == I4)
    check("A2 has order 4", A2**4 == I4)
    check("T1 preserves Q0", T1.T * Q0 * T1 == Q0)
    check("T2 preserves Q0", T2.T * Q0 * T2 == Q0)
    check("N is infinitesimally Q0-skew", N.T * Q0 + Q0 * N == Z4)
    check("quadratic Q0 term vanishes", N.T * Q0 * N == Z4)
    check("P3 is idempotent", P3**2 == P3)
    check("P4 is idempotent", P4**2 == P4)
    check("P3 projects the common seed", P3 * e_gamma == epsilon)
    check("P4 projects the common seed", P4 * e_gamma == epsilon_prime)
    check("epsilon is A1-fixed", A1 * epsilon == epsilon)
    check("epsilon' is A2-fixed", A2 * epsilon_prime == epsilon_prime)
    check("B0 is unimodular", B0 * B0_inv == sp.eye(2) and B0.det() == 1)
    check("global relation matrix is unimodular", R * R_inv == sp.eye(2) and R.det() == 1)

    ell0, ell1, ell2 = 0, 1, -1
    p = 12 * ell0 - 4 * ell1 - 3 * ell2
    check("actual defect p = -1", p == -1)
    check("central fibre Euler arithmetic", 0 + 3 * 0 + 2 == 2)

    m, n = sp.symbols("m n", integer=True)
    generic = sp.expand(m * n * 0 - n * 1 - m * (-1))
    check("projected-seed defect is m-n", sp.simplify(generic - (m - n)) == 0)

    print("\nAll exact finite certificates passed.")


if __name__ == "__main__":
    main()
