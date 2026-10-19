# Paint a picture

Paint one picture of your choosing in oil, at the easel of claude-paint, a
simulator of oil paint on linen. Subject, composition and manner are yours.
Work from what you know; don't use reference images or image models.

## Your studio
- The folder [local path redacted] Work only there.
- You paint at the easel: open a session, paint a chunk, look at the canvas,
  paint the next. notes/easel_guide.md has the commands.
- What is painted stays painted. There is no undo: paint over what you
  don't want.
- Paint dries as you work and while you rest. `wait(minutes)` lets time
  pass, as long as you like.
- You mix your own paint on the palette, from the tubes, in the
  proportions you choose.
- Scratch: run `[local path redacted] r16-C-p1` once and export
  TMPDIR=TMP=TEMP to it; write temporary files only there.
- If linking fails with "You have not agreed to the Xcode license
  agreements", set DEVELOPER_DIR=/Library/Developer/CommandLineTools.
- Wrap anything that might not finish in `timeout` (a process that hangs
  doesn't end on its own).

## What to read
notes/easel_guide.md; notes/studio_notes.md;
notes/research/oil_paint_physics.md as needed.

## Working
- You make every artistic decision.
- Look at your painting often, whole and close up.
- Keep a working journal in notes/journal.md as you go. Add to it; don't
  rewrite earlier entries.
- Develop the painting until you judge it complete.

## When you're done
Reply with the painting's title, if you give it one, and if you like a
few sentences about the picture.
