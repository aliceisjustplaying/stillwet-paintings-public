# Comment and doc cleanup in the painters' folder (one file group)

Repo: [local path redacted] (branch r15-base). This folder is
what AI painters get to paint in. An adversarial review found text in it that
would steer them: [local path redacted]
(read findings 7, 8, 9, 15, 16, 17, 18, 19, 21, 23, 24 closely; skim the rest).
Scratch dir: [local path redacted] (export TMPDIR=TMP=TEMP to it).
The `rock` and `atmos` modules, `form::Ridge` and most studies are already
deleted; ignore findings about them.

Your job: clean the COMMENTS AND DOCS (//, ///, //!, /* */, and in study
programs the human-readable label strings they print or draw) in the files
listed in your task. Nothing else.

## Remove
- History: rounds, reviews, reviewers, labs, loops ("before loop 2"), fixes,
  branches, "old/new", "used to", "now", "as painted now", "the old setting",
  before/after dab counts from past runs, "found in ...", "a repro of ...".
- People: Alice, owners, reviewers, earlier painters. Artists and art
  history (Friedrich's habits or loves, Cézanne, Eckersberg, named paintings
  such as *Monk by the Sea*). The API names `Style::friedrich()`,
  `Palette::friedrich_1820()` etc. are code and stay; saying a profile is
  built from `notes/research/friedrich_materials.md` is fine. Scientists named
  for a law or model (Kubelka–Munk, Orchard, Fitts, Mixbox, spectral.js) are
  fine; legal/attribution notices stay.
- Earlier paintings and painters: "coast #3", "winter #13", "mountains #6",
  "thermos B1", "the lab2 oak", "the lime at 3200", "Evening at a Mountain
  Lake", "the coast session", "the rope coil ... as the coast painting builds
  them", etc.
- Subjective verdicts: "reads as", "digital", "salt", "salty", "static",
  "the cure", "no brush makes", "looks wrong", "floated", "worm lines",
  "buttonhole", "good for blending forms", "keeps a sunset warm without
  turning everything orange", "to quiet a network", "embossed every stroke
  into creases", "the way nature does".
- Advice tying tools, pigments, brushes, noise or presets to subjects: "for a
  sky", "sky, fog, water", "land, rocks, masses", "twigs, rigging, grasses",
  "meadows, foliage, summer", "conifers, grass, far slope", "rock, stone,
  bark", "foliage, wool, a far tree line", "ridges, rock veins", "glint on
  sea", "pebble top", "the snow as it actually is here", "a figure's feet",
  "a 1.7 m figure", "a pond", "a brook", "a bank that wanders".
- Claims about what painters do or should do: "A painter doesn't copy a
  rock's colors", "a painter covering a passage sees them and dabs paint in",
  "A painter carries a passage up to a neighbor instead", "not Friedrich's
  habit", "fuse it afterwards with blend()".
- References to files or sections that don't exist (notes/fixes/..., notes/time,
  friedrich_process.md, "Implications E", "research notes, E.5", "the
  binding"). Citations to notes/research/friedrich_materials.md and
  notes/research/oil_paint_physics.md are fine IF the cited section exists
  there (check; its numbered sections are 1–6).

## Replace with
Present-tense physical and API descriptions: what the code computes, its
parameters, their units and ranges, invariants a test checks. Keep
quantitative content (thresholds, µm, mm, seconds, measured numbers that
describe the current code) and keep genuine uncertainty labels ("proxy",
"estimate"). If a sentence has nothing left once the steering is removed,
delete it. Neutral examples: "an object of height h", "a band on the
ground", "origin in canvas units", "a closed outline", "the upper region".
Examples in API docs should use neutral geometry, not subjects.
Do NOT add any warning, any list of removed things, or any explanation of
what the folder leaves out. Don't write "neutral" or "no subject" anywhere;
just describe.

US spelling, no Oxford comma.

## Stale/wrong docs to fix (if in your files)
- handling.rs ~1524 `AIM_MARKS`: the constants are `MARKS_BLUNT` and
  `MARKS_POINTED` (palette.rs). handling.rs ~447–455: the hug description
  sits on `limit`; move it to `hug` (move the doc comment only).
- outline.rs ~1399 "the binding's default height" → "an explicitly assigned
  lobe height"; ~1423 `o:mask() - o:inset(d):mask()` → the Rust form the test
  uses (e.g. `o.mask(f).subtract(&o.offset(-d, 0.4).mask(f))`; check the test).
- stipple.rs ~247–250 obsolete "When Palette gains its substrate-aware API
  ... aim_km workaround" TODO: describe what the code does now (it calls
  `pal.aim`).
- checkpoint.rs ~29–31: delete the branch/merge narrative (r6-time, r6-wet,
  PAINTCK8); document the current format (`PAINTCK7`, what the writer writes).
- bristle.rs ~151 "Soft pointed round": `point` is 0.0 by default; say
  "Soft round; the pointed tip is opt-in (`point`)".
- drying.rs ~210–211: `wait(180.0)` tacky / `wait(24*60)` dry is wrong in
  general; write "`wait(minutes)` advances simulated time. Use `drying_at` to
  inspect a location; `dry()` waits until all paint is touch-dry."
- sched.rs 4–5 "used to paint them in four checkerboard phases": describe
  the current scheduling only.
- style.rs: presets "no direction or look of its own" claim (finding 7):
  replace with a plain statement that presets choose stroke lengths, paths,
  pressure variation, placement and order, and that their fields are public.
- crack.rs ~1495: replace the calibration story with: "Effective
  film-thickness thresholds, µm; the count includes paint later blended or
  wiped, so these are not direct measurements." crack.rs ~1505 "Dresden
  ground" reasoning: describe the constant physically (the color the crack
  walls show, a fixed value), no history. `Cracks::aged` doc "A quietly aged
  canvas": describe its fields/values.
- stipple.rs header (finding 8): replace the Friedrich/sky recipe with a
  physical description of a stipple pass (touches of a tip, density sets
  tone, interaction with wet paint). Describe `fade`/`feather` by what they
  compute (no "salt", "static").
- noise.rs 60–65 and 363–365: "These helpers provide domain displacement,
  octave folding, cellular distance fields, anisotropic coordinates and
  nonuniform spacing." No "digital", "cure", "waves".
- palette.rs 176–179 → "Return a palette restricted to the named tubes.
  Unknown names panic." 264–269: list the added pigments (and their
  properties if stated) without subjects or suggested combinations; drop the
  "set out a sky family with only" advice. 660–666 label pairs: neutral
  labels (e.g. "light over mid", "pair 1").

## CODE MUST NOT CHANGE, with two exceptions
Engine behavior, defaults, numbers, algorithms, assertions: untouched. The
exceptions:
1. Scene-shaped TEST fixtures (the sheep skeleton in outline.rs, `fn rock()`
   test helpers, "sky"/"land" masks in tests, "oak" stages, "rope coil"):
   rename identifiers and relabel strings/assert messages neutrally
   ("sky" → "upper", "land" → "lower", "sheep" → "five-bone body", "rope"
   → "coil" or "curve"); do NOT change their numbers, seeds, geometry or
   assertion logic. Only inside #[cfg(test)] code and crates/paint/tests/.
   A string that feeds a hash or seed must not change (check before renaming
   a string literal).
2. Study programs (paintings/src/bin/study_*.rs): human-readable label
   strings they print may be relabeled neutrally (no old/new, no verdicts,
   no artists, no subjects: "sky blue" → "smalt tint", "mid sky" → "mid
   blue"). Local variable renames are fine.
Public API names (`Style::friedrich`, `Finish::aged`, `Cracks::aged`,
`Character::named("rock")` aliases, enum variants) stay as they are, even if
subject-named. You may describe them neutrally in docs.

Verify with the checker: from the repo root,
`[local path redacted] [local path redacted] <your files>`
prints code differences vs HEAD with comments stripped. Its output must be
empty, except for the allowed renames above. Then run
`timeout 1200 cargo test -p paint --no-run 2>&1 | tail -3` (and for study
files `timeout 900 cargo build --release -p paintings`) to confirm it compiles.
Other agents are editing other files at the same time: touch ONLY your
files, and do not run any git command that changes state (no commit, add,
stash, checkout, restore). Wrap cargo in `timeout`.

## Words that may legitimately remain
`loop` (Rust keyword), `fresh`/`stale` (checkpoint freshness) and "fresh
paint", `round`/`Round` (brush kind, rounding), `label`, `OKLab`, API names
with Friedrich in them, `Sky`/`Water` enum variants and fields in scene.rs
(that module's generic API stays; clean its examples).

## Reply
When done, your final message: per file, a short list of what you changed
(one line per notable change), the codediff output (or "empty") with each
remaining code change justified, whether it compiles, and anything you left
because it's code (for the parent to report to Alice).
