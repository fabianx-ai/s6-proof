# Agent Instructions — s6

Before doing substantive work in this repository, read:

- `$HOME/collaboration-protocol.md`
- `$HOME/S6-TASK.md` (the standing task for this tree)

Use both as active collaboration context, especially after compaction
or resume.

## Ground rules

1. **Lean is code.** Same core-patching workflow as the fermat tree:
   committed baseline first; compile errors are the work queue; fix in
   place, recompile after each coherent change.
2. **No metadata in this tree.** Working notes, progress reports,
   censuses, and gap reports go to `~/s6-notes/`. The tree holds only
   the paper artifacts, the Lean library, and this file.
3. **No `sorry` in committed library files.** Work-in-progress with
   placeholders lives under `WIP/` (gitignored is fine) until it is
   placeholder-free; `S6Shortcuts.lean` was delivered no-placeholder
   and every commit must keep the default target building.
4. **Claim hygiene.** Nothing in this repository may assert that the
   six-sphere admits a complex structure. The construction is
   conditional on an unverified analytic package and conflicts with a
   published result (see README, "Mathematical status"). What you
   formalize is unconditional: general lemmas and finite certificates.
   Every docstring respects that boundary, mirroring §7.2 of the paper.
5. **Never push. Never send.** Commits stay local; all outward actions
   are Fabian's.
