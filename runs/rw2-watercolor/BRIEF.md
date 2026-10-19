# Paint a picture

Paint a watercolor of the photograph in reference/.
The easel simulates watercolor on paper. The photograph is a Google Maps
screenshot, so leave out the map's panels, buttons, small inset map and logo
and paint what the photograph shows. Don't use image models.

## Your studio
- The folder [local path redacted] this brief, your notes and the easel.
- The easel's tools are `paint`, `look`, `note`, `status` and `log`;
  notes/watercolor_easel_guide.md explains them.
- There is no undo. To change a passage, paint over it, or lift workable
  paint with a damp brush using `b:lift(path)`.
- You mix your own paint from the 36 library pigments with `b:load`, in the
  proportions you choose.
- Time passes on the painting's own clock: every mark takes the time a
  hand takes, and `wait(seconds)` lets it rest, as long as you like; paint
  dries as that time passes. Real time between chunks doesn't count.

## The rules of the studio
- Paint shapes and marks, not computed pictures: don't encode an image in
  masks, amounts or proportions.
- Shapes are drawn, not copied: don't make a mask or stroke by mirroring
  or rotating another mask's or stroke's coordinates. A shape that mirrors
  another is drawn as its own shape, not as `m:at(x, 2*H - y)` or
  `m:at(W - x, y)`. Moving a shape and reusing your own helpers are fine.

## What to read
notes/watercolor_easel_guide.md; notes/watercolor_techniques.md;
notes/research/watercolor_physics.md as needed.

## Working
Work one campaign at a time. After laying a campaign, inspect the whole picture in normal color and relevant detail before writing the code for the next campaign. Let what you see inform the next action; record what changes or why continuing unchanged serves the picture.

After the first large masses, consider whether the whole picture produces your intended effect: how its large shapes, values and spatial relationships support it, and whether anything weakens it. Before adding repeated small details, improve a weakening relationship or deliberately accept it with your reason. After a local repair, check its effect on the whole picture. If the repair recreates the problem, reconsider the composition or method before expanding it.

Before repeating an unfamiliar mixture or stroke, inspect a small trial, on the scratch sheet beside the painting (`scratch: true`) or on the painting, laid on the intended paper after the intended treatment, alongside the existing marks in a detail crop. For material trials and repairs, keep useful observations in your journal: paper and wetness, recipe ratios, water, brush load, coverage and the viewed result. Carry forward the conditions that mattered and label broader rules as hypotheses until a further trial isolates them.

- You make every artistic decision.
- Keep exploring what interests you. You’re free to reconsider a passage,
  change approach and discover where the painting can go.
- Keep a working journal with `note` as you go: your own working notes.
  You can revise them.
- You may sign the painting.
- Take your time and enjoy painting. You can keep working for hours,
  exploring and revisiting passages until you are happy with the picture.
- When you feel ready to finish, use `look` to enjoy the whole painting
  and explore detail crops in normal color after your latest changes.
  Ask yourself: is your heart happy with this? Is there something you
  would enjoy taking further? Follow that interest for as long as you
  like. When you are happy with the painting, record your reflections
  in your journal and finish.

## Your reply
When you stop working, reply with the painting's title if you give it one
and a few sentences about the picture.
