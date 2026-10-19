# Part A: the revised box rule. Part B: the Hopper studio.

Repo [local path redacted] (branch r20-base). Read notes/r20/BUILD.md, notes/r20/TUBES.md and
[local path redacted] (the previous step, done) first. Scratch [local path redacted]
(TMPDIR/TMP/TEMP). **Bound every shell command: `timeout <s> ... < /dev/null`.** Small commits, repo-style messages.
Do not start subagents. Don't touch r19-base, main or [local path redacted]

## Part A: the revised rule (user's decision, 2026-09-29; to be revisited later, say so in TUBES.md)
Historical painters: a tube is in the box if the pigment is (1) documented in use (analysis, own words, witness), or
(2) in his working materials (a paint box or palette he painted from, repeated purchases), or (3) a one-off purchase
nothing contradicts. Out: explicitly unused, rejected or avoided. Living painter (Tonn): current practice, including
rare current use. Rewrite the rule section of TUBES.md accordingly (with the evidence tiers and "revisit later").

Apply:
- Sargent: add Indian yellow (paint box), Mars orange (paint box), magenta ("Magenta in tubes", bought 1888), bone
  brown (bought 1899). Mars orange, magenta and bone brown are new catalog tubes: define each (hex masstone, pigment
  description, hiding, stiffness, strength, drying) with a justification line in TUBES.md, using
  research/sargent_tubes.md where it has them, Artists' Pigments / period literature otherwise; cfg-gate them to the
  Sargent box like other entries. In sargent_materials.md make these visible (not comments) with plain labels of
  their evidence ("in a paint box of about 1884-88", "bought in 1888") in §4, and add them to §9's mapping.
- Tonn: add cobalt violet (rare current use, 2020 and May 2025 posts). §9 mapping as needed.
- Check the Inness and Alma-Tadema notes' research comments for pigments that tier (2) or (3) would now admit; apply
  the rule consistently and report what changed (or that nothing did).
- Keep everything the previous step verified: box_notes.sh, box_tubes.sh, box_features.sh, export_profiles.sh, the
  catalog tests, cargo test (paint default and --lib per box; easel default, replay, painter per box).

## Part B: Hopper
Inputs: research/hopper_materials.md (sourced), research/hopper_tubes.md, and the review
[local path redacted] (GPT-6 Astra; verdict "fix first"). Read all three and
[local path redacted] and research/TASK.md (with addendum).
1. Copy the note into the repo as notes/research/hopper_materials.md and fix every must-fix and should-fix finding.
2. Gap pass per GAPS_TASK.md (fill with real evidence where you can; hide the rest in `<!-- research: ... -->`;
   drop never-used pigments). Where claims rest on search snippets only, keep them marked as such.
3. Box `hopper` per the Part A rule (historical painter), new tubes as needed (deep cadmium exists; light red
   probably maps to red earth unless evidence says otherwise: decide and record in TUBES.md), cfg feature
   `box-hopper`, export profile `hopper` in scripts/export_r16_studio (materials note, bin/box, name check exempting
   only Hopper), and add hopper to the tests (box_features, export_profiles, box_notes, catalog tests).
4. §9 of the Hopper note: plain positive mapping to the final box; §10 verbatim from the other notes.
Verify all of it as in Part A, then `scripts/strip_sources` the Hopper note and read it as a painter.

Reply with commits, the final boxes (all five), what changed in Inness/Alma-Tadema under the new rule, and results.
