# Second opinion: are we overengineering? (claude-paint)

You advised this project before (notes/advice/astra.md, astra_r6.md).
Repository: [local path redacted] (read only; don't edit tracked files; your
only output is the file named below). Scratch: `[local path redacted]
advice3`, export TMPDIR=TMP=TEMP there, never /tmp.

## The situation, in Alice's words (she owns the project)
- The project's inspiration was a post: "for the past few months i've been
  asking our models to paint. opus 5.5 is very skilled at emulating
  different styles. every image here is a python program generated pixel
  by pixel. there is no image model, and no off-the-shelf art software.
  instead, it's about 7,500 lines of code using standard libraries to
  emulate different brush styles. the agents don't use any pictures as
  reference, instead working only from what they know about each painter."
  It showed four styles: Pieter Bruegel the Elder, likely Cézanne, David
  Hockney and probably Turner. They looked amazing. No code was shared.
- Alice: "I do wonder if we are overengineering? But we are working from a
  different starting point. And I don't know if the OP's approach can even
  work for something like Friedrich." "Of all the agents' paintings in the
  OP, the Turner one is by far the most digital-looking and maybe the
  furthest from the original painter. Probably not a coincidence." "The
  early experiments of this app in round 2 were in many ways better than
  anything since. Not everything, but."
- "It's also entirely possible this project will just kind of fail."
- Her yardstick: "less digital, more bad painter". Her principle, just
  written down: tools give physics and constraints, not answers; prefer
  the human process (piles, gestures, time, looking); entropy: "the less
  entropy we have the more digital everything looks"; "we are modeling oil
  paint!" (notes/principles.md).

## What we're doing
A physical oil-paint simulator in Rust (~35,000+ lines): bristle brushes,
wet paint in two layers (branch r6-wet), drying on a clock, hand time and
sittings, Kubelka–Munk optics, varnish and craquelure, structure tools
(trees, firs, rocks, forms, scenes, atmosphere), a Lua easel where painter
agents paint live; lab studies judged by Alice and blind critic panels.
Read: README.md, notes/principles.md (including the feature freeze just
declared and its evidence), notes/round6.md, notes/round6/thermos.md,
notes/round6/alice_review.md (her reviews, in her words), notes/paint1/
(the latest painting, Evening at a Mountain Lake, its plain PNGs, two
critiques and her review), notes/amnesia2/ (round 2: fresh2_*.jpg and
.md; the paintings she finds better in many ways; they were plain Rust
programs on an older, simpler API, archived in paintings/fresh2/),
notes/friedrich.md and notes/briefs/friedrich_painter.md (fresh research).
Look at the images (they're PNG/JPEG files you can read). Just launched: a
control experiment (branch r7-python): one agent writes a look-first
Friedrich as a standalone Python program with numpy, no engine, in about
two hours; Alice will compare it blind with ours.

## Questions (answer concretely and bluntly, with receipts: files, images, numbers)
1. Are we overengineering? Which parts of the engine and workflow have
   demonstrably paid off in the pictures, which haven't, and which are
   probably getting in the way (e.g. by encouraging painters to trace
   computed structures, or by adding knobs instead of hand)? Why might
   round 2 have been better in places?
2. Can the OP's look-first approach work for Friedrich, and why might the
   Turner have been the most digital of the four? What does that say about
   smooth, luminous, atmospheric painting as a target for either approach?
3. Is the physical-simulation bet sound given Alice's yardstick and her
   entropy point, or is there a better middle path (e.g. keep the paint
   physics, drop or demote structure tools; or look-first marks with a
   few physical effects)? What would you cut, keep and change first?
4. How should we evaluate the control experiment fairly (same size, same
   subject or not, blind, what to look for), and what result would change
   the plan?
5. If you were Alice, what would you do in the next week?
Keep it under ~1,000 words. Write it to
[local path redacted] then reply with the
same text. US English, no Oxford comma.
