# Final painter-copy review

**All five studios: fix first.** The shared guide supplies a conflicting tube catalog; Tonn also retains a picture-building recipe. Paths and line numbers below refer to `final/`. This is a text review of the supplied copies, not a check of running studios. Assigned genres, “yours to invent,” genuine negative practice facts, and neutral interface instructions are accepted.

## Shared notes

### `notes/easel_guide.md`

- **Must — L84–101:** “The tube box” includes “smalt,” “pale smalt,” “Rinmann's green” and “copper green.” This catalog conflicts with the five notes' §9 mappings: for example, Sargent promises magenta, Inness Antwerp blue, Alma-Tadema Naples yellow, Tonn cadmium yellow, and Hopper zinc white; none appears here. **Fix:** generate each delivered guide's table from its actual studio box and reconcile that table with its materials note. Do not deliver this common catalog.
- **Should — L76–77:** “there are no separate solvents, driers, resins or varnishes.” Explicit missing-control list, excluded by the final instructions. **Fix:** end the qualification at “It is added oil only.”
- **Should — L423–427:** “`io`, `os`, `debug`, `require`, `dofile`, `loadfile` and `collectgarbage` aren't there”; “there is no `unpack`.” Another absent-capability list. **Fix:** describe the sandbox's supported interface positively and state “Use `table.unpack`.”
- **Should — L179:** “the mask level strokes start at” contradicts the corrected anchor/path distinction at L185–187. **Fix:** “the mask level used to anchor strokes.”

### `notes/oil_paint_physics.md`

- **Should — L102:** “These sources give no measured residual weave-relief amplitudes.” Visible research gap. **Fix:** delete that sentence; retain the estimates with their uncertainty labels.
- **Should — L82:** “[E, from 3]” retains an unexplained numbered reference after source stripping. **Fix:** use “[E]” and retain the stated derivation. The defined `[V]`, `[S]`, and `[E]` evidence tags are not orphan citation keys.

### `notes/studio_notes.md`

No additional contamination finding.

## Materials notes

### `notes/sargent_materials.md`

- **Should — L101–125:** “Evidence” heads a partially emptied column; rows such as “Vermilion” and “Mars (synthetic iron oxide) yellow, red and brown” retain blank citation cells. **Fix:** merge surviving evidence and notes into one description column and remove the empty column remnants. Do the same cleanup for Alma-Tadema and Tonn below; do not invent replacement evidence.

### `notes/inness_materials.md`

- **Should — L130–131:** “greens were mixed ‘with umber or some such color’.” This restores a color-effect recipe removed in the earlier review. **Fix:** delete the Greens bullet.
- **Must — L237–239:** “white → lead white” presents a specific historical identity where §4 L111 says only “White.” **Fix:** “white → lead white (simulation assumption).” This preserves the evidentiary distinction without an absent-pigment list.

### `notes/alma_tadema_materials.md`

- **Should — L97–110:** “Evidence” is empty for most pigment rows after stripping. **Fix:** merge surviving evidence and notes into one description column.
- **Should — L212:** “Naples yellow → Naples yellow (lead antimonate)” loses §4 L102's qualification that his tube's composition is unverified. **Fix:** “Naples yellow → Naples yellow (modeled as lead antimonate).”

### `notes/tonn_materials.md`

- **Must — L215–228:** “laid the background from the top down and the darkest accents first”; “leaving the lightest shapes as bare canvas”; “edges … softened on the shadow side”; “the most heavily loaded paint went into the last light accents.” This is a worked picture description and tonal/edge recipe. **Fix:** reduce the paragraph to anonymous material observations: “A filmed painting of 2026 shows about eight sessions, freehand […]”
- **Should — L59–60:** “Prime them with a tinted lead ground.” Retained teaching imperative. **Fix:** “In 2020 he reported using a tinted lead ground.”
- **Should — L120:** “more versatile on the pallet for me.” Pigment endorsement. **Fix:** retain only his reported use and the darker, more transparent grade.
- **Should — L110–125:** “Evidence” contains empty citation cells for several pigments. **Fix:** merge surviving evidence and notes into one description column.

### `notes/hopper_materials.md`

No additional finding. The §9 proxy and inference labels agree with §4.

## Briefs

Each brief retains a placeholder studio path and points to `notes/research/`, whereas the supplied files are directly under `final/notes/`.

| File | Lines and quote | Severity / fix |
|---|---|---|
| `briefs/sargent.md` | L10: “[local path redacted] L33–34: “notes/research/sargent_materials.md”, “notes/research/oil_paint_physics.md” | **Should:** substitute the launch path and make the reading paths match the delivered layout. |
| `briefs/inness.md` | L9: “[local path redacted] L32–33: “notes/research/inness_materials.md”, “notes/research/oil_paint_physics.md” | **Should:** same fix. |
| `briefs/alma-tadema.md` | L10: “[local path redacted] L33–34: “notes/research/alma_tadema_materials.md”, “notes/research/oil_paint_physics.md” | **Should:** same fix. |
| `briefs/tonn.md` | L9: “[local path redacted] L32–33: “notes/research/tonn_materials.md”, “notes/research/oil_paint_physics.md” | **Should:** same fix. |
| `briefs/hopper.md` | L10: “[local path redacted] L33–34: “notes/research/hopper_materials.md”, “notes/research/oil_paint_physics.md” | **Should:** same fix. |

These are delivery checks: the supplied text does not establish whether a launcher substitutes the paths or relocates the notes.

## Studio verdicts

| Studio | Verdict | Corrections |
|---|---|---|
| Sargent | **Fix first** | Shared notes, brief paths, table remnants. |
| Inness | **Fix first** | Shared notes, brief paths, green recipe, white mapping. |
| Alma-Tadema | **Fix first** | Shared notes, brief paths, table remnants, Naples-yellow qualification. |
| Tonn | **Fix first** | Shared notes, brief paths, filmed recipe, imperative, endorsement, table remnants. |
| Hopper | **Fix first** | Shared notes and brief paths. |
