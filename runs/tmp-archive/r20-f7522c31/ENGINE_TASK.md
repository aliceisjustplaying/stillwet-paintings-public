# r20-base: per-painter tube boxes and four "in the manner of" studio profiles

You are implementing round 20's engine and studio changes for the easel (a Rust simulator of oil paint on
linen, driven by Lua chunks that AI painters write). Work carefully; an independent reviewer (GPT-6 Astra via
codex) will review your branch for bugs AND for anything that nudges or contaminates painters.

## Setup
- Repo: [local path redacted] (git worktrees). Create a worktree [local path redacted] on a new branch
  `r20-base` from `r19-base` (commit 5069814). Build there (`cargo build --release -p easel`), test there.
- Scratch: [local path redacted] (set TMPDIR, TMP, TEMP to it for all commands). Python only via `uv`.
- Commit in small, well-described commits (style: see `git log r19-base`). Don't push. Don't touch r19-base,
  main, or any running studio ([local path redacted] painters are working in some of them right now.

## Research input (read all of it)
[local path redacted] sargent_tubes.md, inness_tubes.md, alma_tadema_tubes.md (tonn_tubes.md
may appear later; see the end). Each lists the pigments the artist used, which existing tubes match, and proposed
new tube lines (name, hex masstone, hiding, stiffness, tinting strength, drying) with justifications. The matching
*_materials.md are the painters' notes (don't edit them; you may read them for context).

## What to build
1. **One tube catalog, one definition per pigment** (crates/paint/src/palette.rs). The proposals overlap and
   disagree (e.g. lemon chrome, cadmium yellow, burnt sienna, rose madder, viridian). Reconcile: one entry per
   pigment, values chosen from the proposals' evidence, new `drier::` constants in drying.rs where needed (with a
   doc comment citing the proposal's reasoning). Existing tubes keep their exact names and numbers (old paintings
   must replay bit-identically). Write the reconciliation (each tube: chosen values, which proposal, why) to
   docs or a CHANGES file in the repo (NOT anywhere exported to a studio).
2. **Named boxes**: the existing `tube box` stays the default and unchanged. Add a box per profile: `sargent`,
   `inness`, `alma-tadema` (and `tonn` later), each exactly the tubes that artist's *_tubes.md documents him using
   (existing + new). Where evidence is weak (the proposal marks optional/uncertain), use judgment and note it in
   the reconciliation doc; don't pad boxes with tubes the artist is not documented to have used.
3. **Choosing the box, reproducibly.**
   - A new session gets its box from a file `box` next to the easel executable (e.g. studio/bin/box, one line,
     the box name), else EASEL_BOX env, else the default `tube box`.
   - The box is recorded in the painting's log (the session program, see crates/easel/src/session.rs
     `program()` and `parse_program`) as a header line, so every replay (`easel open` reattaching to an existing
     log, `easel run`, check, finish, frames/replay_clip) uses the log's box regardless of which easel binary
     or environment replays it. A log with no header = default box (all existing r19 logs keep working,
     bit-identically). A conflict (header says X, box file/env says Y) is an error with a clear message, not a
     silent pick.
   - Check the tools that replay logs: scripts/check_painting, scripts/finish_painting, scripts/replay_clip,
     the studio viewer if relevant. They should need no changes if the header is honored by the engine; verify.
4. **The guide's tube table** (notes/easel_guide.md, "The tube box:" table) must match the studio's box. Add a
   way for the easel to print its box as that markdown table (e.g. `easel tubes --markdown`, honoring the box
   file) and have the export script write the table into the exported guide. The default/blank studio's guide
   must stay byte-identical to r19's.
5. **Export profiles** (scripts/export_r16_studio): add `sargent`, `inness`, `alma-tadema` (`tonn` later). Each:
   the guide (with its box's table), oil_paint_physics.md, notes/research/<artist>_materials.md (copy the research
   file into the repo at notes/research/), and bin/box. The painter-name checker: add Inness, Alma-Tadema (and
   "Tadema"), Tonn to the list; each profile exempts only its own artist's name (as friedrich does). Keep the
   "nothing but those" and probe checks working.
6. **Tests**: default box unchanged; each box's tubes resolve in the catalog; header round trip (new session in a
   sargent studio → log has header → `easel run` of the log elsewhere uses the sargent box and reproduces the
   canvas bit-identically); conflict error; an r19 log without header replays exactly as before; export of each
   profile passes its checks and its guide table matches its box. Run the full test suite.

## Contamination rules (the reviewer will check these)
- Nothing a painter can read may nudge subject, composition, style or aesthetics beyond the brief and its own
  artist's materials note. No other artists' names; no box names that hint at other painters in shared files;
  guide examples stay subject-neutral; don't add advice.
- Painters never see the reconciliation doc, the *_tubes.md proposals, or other profiles' notes.

## When done
Reply with: the branch/commit list, the tube catalog (a compact table), each box's contents, test results, and
anything uncertain. If research/tonn_tubes.md exists by the time you finish the other three, add the `tonn` box
and profile the same way (the materials file will be research/tonn_materials.md); otherwise say so and stop.
