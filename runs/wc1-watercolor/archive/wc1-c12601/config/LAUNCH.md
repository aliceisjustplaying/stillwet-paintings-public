# WC1 watercolor — launch authorized

Alice authorized Opus 5.5 high after the approved watercolor equivalents and
offline preflight. This document records the prepared setup; launch and actual
painter activity are recorded separately in the WC1 outcome report. No stream,
OBS action or change to another painter/service/port is part of WC1.

## Studio and source

- Run folder: `[local path redacted]
- Studio: `paint-studio-c12601` within that folder.
- Source: main at `15a83a11ed7928ede4d2cf83a7516a807f4f5692`, clean and pinned.
- Profile: watercolor, all 36 library pigments. The painter can create its
  own sheet within width 2–2400 and height 2–1600 cells, with any supported
  paper kind and seed. The actual painter studio has no sheet, marks or journal
  entries. The visible blank sheet is an explicitly labeled operator preview.
- House Pi runner, Opus 5.5 high through Alice's Claude OAuth subscription.
  Image/context/compaction limits, usage-limit handling, crash classification
  and six-crash recovery remain those of r40. The host stops after the first
  completed sitting, so it cannot start a second completed sitting. Crash
  retries and same-session usage-limit recovery are retained.

The frozen r40 host functions are reused by `runner.py`; no oil check, finish,
reader, stream or OBS stage runs. A run-local `bin/easel` command shim maps the
house Pi tools to the merged watercolor runner. It records submitted calls for
host chunk counts. The engine and notes are unchanged. The lane uses a private
`lane-harness/` copy; every module except `easel-tools.ts` is byte-identical to
pinned main. Only its `look` definition, schema and unsupported-option branches
are changed, as recorded in `LOOK.diff`. Image/context/compaction limits remain
unchanged. All other tool definitions remain house text.

## Viewer

Open **http://[tailnet host redacted]/** from Alice's tailnet. The direct selection is
`http://[tailnet host redacted]/?p=paint-studio-c12601`.

Launchd label: `art.stillwet.studio.wc1`. It has KeepAlive enabled and binds
only `[tailnet IP redacted]`, never 0.0.0.0. Gallery is the viewer default, with
Color / Gallery light / Relief controls. All three operator-preview images
were fetched and matched to the native renders on M3. The operator confirmed
this fully qualified URL works from M1; bare `[tailnet host redacted]` did not resolve there.
No public tunnel is used.

The viewer uses a conventional session-folder alias to this studio's actual
Pi session directory. It will discover the painter's sessions when launch is
begins. The operator-only blank preview is labeled “WC1 prepared — painter not launched.”

Viewer relaunch, only if it is unloaded:

```sh
launchctl bootstrap "gui/$(id -u)" [local path redacted]
```

## Launch the painter — Alice's go received

```sh
launchctl bootstrap "gui/$(id -u)" [local path redacted]
```

Label: `art.stillwet.painter.wc1`. RunAtLoad begins the painter immediately.
The runner logs to `run/runner.WC1.out`, `run/runner.WC1.err`, `run/chains.log`
and `run/WC1/`. Confirm the first actual Pi tool call before claiming the painter
has started; bootstrap alone is not painter activity.

Stop the painter, leaving the viewer and all other jobs alone:

```sh
launchctl bootout "gui/$(id -u)/art.stillwet.painter.wc1"
[local path redacted] close
```

The watercolor engine is stateless between calls, so `close` needs no server
teardown. An operator-forced interruption may leave an in-flight native
watercolor command; identify it by this exact studio's binary/path before
stopping it. Do not use a broad painter, easel or Python kill pattern.

## Offline preflight

`preflight.json` records a pass with no provider called and no painter launched:
all 36 pigment ids loaded in a throwaway studio, hardware Metal status,
default paper and a separately chosen 64×48 rough sheet, a stroke/wait/look,
Gallery/Relief companions and the actual house Pi command client. The real
studio remained unpainted with an empty journal. Plists passed `plutil -lint`;
Pi is 1.1.0 and Anthropic auth is OAuth. The final rerun had about 205 GiB free,
above 15 GiB. It also loaded the lane painter and compaction extensions through
Pi's actual extension loader, checked that `look` exposes only `crop`, `mode`,
`scratch` and `size`, checked Color/Gallery/Relief modes and delivered a Gallery
PNG through the real Pi `look` implementation in a throwaway studio.

The preflight runs throwaway studios, not a painter. Its initial file-copy
permission error was fixed by preserving executable modes and the final run
passed. Build targets and temporary preflight studios have been removed.

## Approved watercolor equivalents

The brief uses watercolor on paper, `notes/watercolor_easel_guide.md`, lifting
workable paint with a damp brush using `b:lift(path)`, mixtures from all 36
library pigments using `b:load` and `wait(seconds)`. The guide specifies a
600-second maximum per wait call. The trial paragraph says scratch sheet,
paper and water; its held-pile sentence and the simulated-oil-years bullet
are deleted. Every other template line is unchanged, apart from the previously
approved opening, studio path and reading-list substitutions.

The lane's `look` description and schema expose only `crop`, `mode`, `scratch`
and `size`. Modes are `color`, `gallery` and `relief`; default painter looks stay
Color. No light, grid, survey, compare, hold, at or palette option is advertised.
No subject, scene, composition, reduced palette or paper size was added.

`prompts/easel-tools.ts` is the actual lane tool module;
`prompts/easel-tools-r40.ts` retains the original for provenance. The other
house messages and deterministic prompt generators remain frozen. The
painter-readable watercolor notes are in `painter-files/notes/`.

## Every changed brief line against the r40 template

The unified diff lists every removed and added line, including the approved
placeholder substitutions. Context lines are unchanged.

```diff
--- r40/brief_template.md
+++ wc1/BRIEF.md
@@ -1,17 +1,20 @@
 # Paint a picture
 
-{OPENING}
+Compose and paint one original picture at the easel, a simulator of watercolor
+on paper. The subject, setting and composition are yours to invent.
+Work from knowledge and the notes in your studio; don't use reference
+images or image models.
 
 ## Your studio
-- The folder {STUDIO}: this brief, your notes and the easel.
+- The folder [local path redacted] this brief, your notes and the easel.
 - The easel's tools are `paint`, `look`, `note`, `status` and `log`;
-  notes/easel_guide.md explains them.
-- There is no undo. To change a passage, paint over it, or lift wet
-  paint with a rag or a brush.
-- You mix your own paint on the palette, from the tubes, in the
+  notes/watercolor_easel_guide.md explains them.
+- There is no undo. To change a passage, paint over it, or lift workable
+  paint with a damp brush using `b:lift(path)`.
+- You mix your own paint from the 36 library pigments with `b:load`, in the
   proportions you choose.
 - Time passes on the painting's own clock: every mark takes the time a
-  hand takes, and `wait(minutes)` lets it rest, as long as you like; paint
+  hand takes, and `wait(seconds)` lets it rest, as long as you like; paint
   dries as that time passes. Real time between chunks doesn't count.
 
 ## The rules of the studio
@@ -23,14 +26,15 @@
   `m:at(W - x, y)`. Moving a shape and reusing your own helpers are fine.
 
 ## What to read
-{READING}
+notes/watercolor_easel_guide.md; notes/watercolor_techniques.md;
+notes/research/watercolor_physics.md as needed.
 
 ## Working
 Work one campaign at a time. After laying a campaign, inspect the whole picture in normal color and relevant detail before writing the code for the next campaign. Let what you see inform the next action; record what changes or why continuing unchanged serves the picture.
 
 After the first large masses, consider whether the whole picture produces your intended effect: how its large shapes, values and spatial relationships support it, and whether anything weakens it. Before adding repeated small details, improve a weakening relationship or deliberately accept it with your reason. After a local repair, check its effect on the whole picture. If the repair recreates the problem, reconsider the composition or method before expanding it.
 
-Before repeating an unfamiliar mixture or stroke, inspect a small trial, on the scratch canvas beside the painting (`scratch: true`) or on the painting, laid on the intended substrate after the intended treatment, alongside the existing marks in a detail crop. A held pile shows thick paint on steel; use the laid trial to judge its effect on the picture. For material trials and repairs, keep useful observations in your journal: substrate and wetness, recipe ratios, medium or thinner, brush load, coverage and the viewed result. Carry forward the conditions that mattered and label broader rules as hypotheses until a further trial isolates them.
+Before repeating an unfamiliar mixture or stroke, inspect a small trial, on the scratch sheet beside the painting (`scratch: true`) or on the painting, laid on the intended paper after the intended treatment, alongside the existing marks in a detail crop. For material trials and repairs, keep useful observations in your journal: paper and wetness, recipe ratios, water, brush load, coverage and the viewed result. Carry forward the conditions that mattered and label broader rules as hypotheses until a further trial isolates them.
 
 - You make every artistic decision.
 - Keep exploring what interests you. You’re free to reconsider a passage,
@@ -40,8 +44,6 @@
 - You may sign the painting.
 - Take your time and enjoy painting. You can keep working for hours,
   exploring and revisiting passages until you are happy with the picture.
-- An oil painting can develop over simulated years. Whether yours takes
-  one simulated day or a thousand, that time is yours to use.
 - When you feel ready to finish, use `look` to enjoy the whole painting
   and explore detail crops in normal color after your latest changes.
   Ask yourself: is your heart happy with this? Is there something you
```
