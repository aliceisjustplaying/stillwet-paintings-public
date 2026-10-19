# A request for advice: claude-paint, from the beginning

You're being asked for your honest advice and thoughts on a long-running
project. Please read this, then look at the repository and the images, then
answer. Repository: [local path redacted] (read only: don't edit tracked
files, don't commit). Scratch: `[local path redacted] fable`; export
TMPDIR=TMP=TEMP there; never /tmp. Your only output is the file named at the
end. Images are PNG/JPEG files you can read directly; renders are large, so
for big PNGs make a ≤1000px JPEG with `scripts/peek SRC OUT.jpg [H W Y X]`.

## What this is
claude-paint (published under the pseudonym "alice"; the user is Alice) is
an attempt to have AI agents paint original paintings in the manner of
Caspar David Friedrich (1774–1840) from knowledge alone: no image model, no
reference pictures, no art software. The engine is a physical oil-paint
simulator in Rust: simulated bristle brushes carrying wet paint over a
linen/ground height field, Kubelka–Munk optics, drying on a clock,
varnish, craquelure; painter agents paint either as Rust programs or live
at a Lua "easel" (crates/easel), looking at their work as they go.

The inspiration was a post: "for the past few months i've been asking our
models to paint. opus 5.5 is very skilled at emulating different styles.
every image here is a python program generated pixel by pixel. there is no
image model, and no off-the-shelf art software. instead, it's about 7,500
lines of code using standard libraries to emulate different brush styles.
the agents don't use any pictures as reference, instead working only from
what they know about each painter." It showed Pieter Bruegel the Elder,
likely Cézanne, David Hockney and probably Turner. Alice: the Turner was
"by far the most digital-looking and maybe the furthest from the original
painter. Probably not a coincidence." None was Friedrich.

## The history, briefly (details in the files)
- Rounds 1–5 (notes/round3_plan.md, round4_plan.md, round5_plan.md,
  notes/scores.md, notes/HANDOFF.md): the engine grew (drying, strokes,
  stipple, tips, form, scene, atmosphere, growth of trees, structure tools
  that grow trees/firs/rocks into drawn outlines, a Lua easel, crops,
  checkpoints). "Amnesia" rounds had fresh painter agents paint original
  Friedrichs; critic panels scored them; "loops" reworked benchmark
  paintings (notes/loops/l5_near.lua, l3_green.lua).
- **Round 2** (notes/amnesia2/: fresh2_winter.jpg, fresh2_coast.jpg,
  fresh2_mountains.jpg and .md): three painters each wrote a Rust program
  on an older, simpler engine, authoring their own motifs (the winter
  program has its own wood, prune, gnarl, limb_snow, spruce, walker_fig:
  paintings/fresh2/fresh2_winter.rs). Alice: these were "in many ways
  better than anything since"; "the winter one is the best"; "trees looked
  like trees"; it "almost moved something in me".
- After round 5 Alice felt progress went "sideways" (notes/advice/brief.md,
  astra.md). **Round 6** (notes/round6.md, notes/round6/*, notes/lab/,
  notes/lab2/): a "mark-making lab" of single-subject studies (old way vs
  new way; "hierarchical detail, not maximal subtraction"), relief
  lighting A/B, hand time and sittings, a two-layer wet-paint engine
  (branch r6-wet, still unmerged), bare-tree fixes, varnish fix, blind
  critic panels (notes/round6/panels/), two code reviews and an 8-reviewer
  "thermos" review (notes/round6/thermos.md) with a maintenance round,
  deterministic builds, fast tests.
- **Round 7** (notes/principles.md, notes/paint1/, notes/round7/*,
  notes/round6/alice_review.md): a free painting on the wet engine
  ("Evening at a Mountain Lake"); edges, craquelure, research on
  Friedrich's composition and his process (notes/friedrich.md,
  notes/research/friedrich_process.md, notes/briefs/friedrich_painter.md,
  friedrich_hand.md); a "piles" helper (palette piles instead of color
  formulas; parked on branch r7-piles); a Python look-first control
  experiment (notes/round7/compare/, notes/advice/astra_r7.md); a feature
  freeze. **The decisive calibration:** round 2's winter program ported to
  today's engine looked worse; a bisect (notes/round7/winter_ab.md) found
  two regressions (a pointed-brush default thinning the painter's marks, a
  glaze film floor erasing a thin veil = "too perfect lighting"); with
  both undone (variant d) the port is "remarkably close" to the original,
  "maybe almost edges it out". The engine is now variant d.
- **Tonight** (notes/round7/arms/, README and key): three painters on
  engine d, free subjects: A = Lua easel with procedural tools removed
  (the painter's own motifs), B = a Rust program, round-2 style, C = the
  Lua easel with everything. Alice's live reactions are the last section
  of notes/round6/alice_review.md: none moves her yet; round 2's winter
  "almost moved something"; the three converged on nearly the same
  painting (a pond, a sky, trees reflecting, grass in front); C "has the
  best vibe somehow", A and B "too precise"; she guessed the Rust one as
  the most computational; a genuine rendering bug (a whitish horizontal
  line in A's grass); "I'm more confused than ever which direction we
  should go."

## Alice's own words and principles (read these first)
- notes/principles.md: north star; tools give physics and constraints, not
  answers; prefer the human process; entropy ("the less entropy we have
  the more digital everything looks"; "hands have sooo much entropy";
  "we are modeling oil paint!"); the creativity is the painters'; feature
  freeze and the overengineering question; against reward hacking.
- notes/round6/alice_review.md: all her reviews, in her words.
- Her yardstick: "less digital, more bad painter".
- Her worries: overengineering ("I do wonder if we are overengineering"),
  reward hacking by painter agents, drifting from the human process, that
  the project "may just kind of fail", that Friedrich is a very hard target.

## What we ask
Be concrete and candid, with receipts (files, images, numbers). Look at the
paintings yourself (notes/amnesia2/*.jpg, notes/round7/winter_port/ and
winter_ab/, notes/paint1/, notes/round7/compare/, notes/round7/arms/).
1. What do you see, honestly, across the whole arc? What has actually made
   pictures better, what hasn't, and what has made them worse?
2. Why might round 2 (especially the winter) move Alice when nothing since
   does, even on a better engine? What is the "something" it had?
3. The convergence tonight (three free painters, nearly the same picture):
   what does it say, and what would you do about it without falling into
   reward hacking or prescribing pictures?
4. Engine vs painter: where is the bottleneck now? Is the physical-paint
   bet sound? Keep, cut, change?
5. Alice's principles (human process, entropy, tools as constraints not
   answers): right, wrong, or incomplete? What would you add or drop?
6. If you were steering this project for the next two weeks, what would
   you do, in order, and how would you know each step worked? Include what
   you'd stop doing.
7. Anything else you think Alice should hear.
Keep it under ~1,500 words, plain and direct. Write it to
[local path redacted] then reply with the
same text. US English, no Oxford comma.
