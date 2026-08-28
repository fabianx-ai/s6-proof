# Lean scope for V10

## Mathematical scope

The companion Lean project encodes the reusable algebraic layer and the concrete finite certificates:
cyclic averaging, square-zero exchange, lattice index, split-extension coinvariants, the two-exceptional-fibre
defect, low-degree filtration consumption, and the explicit matrices used in the paper.

It does **not** formalize the analytic period family, the toric quotient, the logarithmic transforms, the global
Hausdorff assembly, the geometric boundary maps, nearby cycles, or the construction of a complex six-sphere.

## V10 trust-boundary change

The current V10 tree proposes replacing every concrete native computation proof with a kernel-reducible
`decide` proof and includes `S6/AxiomAudit.lean` for a per-theorem axiom report.

**PLACEHOLDER:** the modified V10 tree has not yet been compiled under the pinned toolchain. The historical
successful build applies only to the archived pre-V10 checkout in `archive/b3c0a190/`.

The current publication gate is defined in `BUILD_REPORT_V10.md`. No final machine-verification claim may be
made until all `PLACEHOLDER` markers in the formal reports are replaced with actual build and axiom evidence.
