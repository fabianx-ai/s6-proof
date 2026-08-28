# Lean scope for V10

## Mathematical scope

The companion Lean project encodes the reusable algebraic layer and the concrete finite certificates:
cyclic averaging, square-zero exchange, lattice index, split-extension coinvariants, the two-exceptional-fibre
defect, low-degree filtration consumption, and the explicit matrices used in the paper.

It does **not** formalize the analytic period family, the toric quotient, the logarithmic transforms, the global
Hausdorff assembly, the geometric boundary maps, nearby cycles, or the construction of a complex six-sphere.

## V10 trust-boundary change

The verified V10 tree replaces every concrete native-computation proof with an explicit kernel-checked proof
using extensionality, finite case splits, and `norm_num`. It includes `S6/AxiomAudit.lean` for a per-theorem
axiom report.

At built-source commit `b6220d0fd6b301b2df2082a91885513945126f45`, the pinned clean build completed
successfully (`Build completed successfully (8517 jobs).`) using Lean commit
`fd009949156901e6cf15b6d9bf1122294b8e697a`. The aggregate source-tree digest was
`37d55a7a16aa29bf11cc291bdca8a20c98192bb18883b5da171bc25c449a55f1`. The 62-name axiom audit reported
only `propext`, `Classical.choice`, and `Quot.sound`, with no generated computation/compiler-trust axiom.
Full evidence is in `BUILD_REPORT_V10.md`, `AXIOM_REPORT_V10.txt`, and `lean-build-v10.log`.

These results do not widen the mathematical scope stated above. In particular, the gluing development proves
abelianness of the literal presented group and classifies the relation cokernel separately; their explicit
formal equivalence remains future work. Historical successful build evidence applies only to the archived
pre-V10 checkout in `archive/b3c0a190/`.
