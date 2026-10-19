# Reconcile the tube boxes with the notes (r20-base)

Repo [local path redacted] (branch r20-base). Read notes/r20/BUILD.md and notes/r20/TUBES.md first.
Scratch [local path redacted] (TMPDIR/TMP/TEMP). **Bound every shell command: `timeout <s> ... < /dev/null`.**
Commit in small steps, repo-style messages. Do not start subagents. Don't touch r19-base, main or [local path redacted]

## The standing rule (decided by the user)
- Historical painters: a tube is in the box if the note documents the artist using the pigment at least once (in
  paintings or practice). Owned only (paint box, receipts) or never used: not in the box.
- Living painter (Tonn): the box follows **current** practice. Pigments used only in the past, owned but unused,
  or avoided are left out for now (to be revisited).
- Keep a per-artist "owned or past, not in the box" list, with evidence, in notes/r20/TUBES.md (never exported).

## Changes
1. **Sargent box:** remove "Indian yellow"; add "raw sienna" (sienna is documented in his paintings [APOLLO], grade
   unknown; his paint box held raw and burnt). Note §9 (sargent_materials.md): map "sienna → raw sienna and burnt
   sienna" (edit the existing mapping sentence; keep it a plain positive mapping).
2. **Inness box:** unchanged. In inness_materials.md, move the "Brown pink" table row into a research comment on its
   own line (`<!-- research: ... -->`), since even its reading is uncertain.
3. **Alma-Tadema box:** add "raw umber" and "deep cadmium". "deep cadmium" is a new catalog tube: from
   [local path redacted] §9 (`#e8861e`, hiding 0.9, stiffness 0.6, strength
   1.2) with the existing cadmium drying rate constant; pigment description like the other cadmiums'; cfg-gated to
   the boxes that hold it, as the other catalog entries are. Note §9 (alma_tadema_materials.md): add "raw umber → raw
   umber; deep cadmium → deep cadmium" to the mapping.
4. **Tonn box:** remove "red earth". Note: tonn_materials.md §9 must not map anything to red earth (check); English
   red, cobalt blue, titanium white, vermilion and zinc stay in research comments only (check none is visible in the
   stripped copy).
5. TUBES.md: record each change and its reason, the rule above, and the owned/past lists per artist (Sargent: Indian
   yellow, Mars orange, magenta, bone brown; Tonn: English red, cobalt blue, titanium white, vermilion, zinc white,
   cobalt violet; others as the notes' research comments say).

## Verify
- Tests that pin box contents/sizes updated; cargo test for paint (default, --lib per single box), easel (default,
  replay build, each box painter build); scripts/tests/*.sh (box_features, box_tubes, studio_names, export_profiles).
- A consistency check you script and run: for each box studio exported by export_profiles, (a) every tube in
  `bin/easel tubes` appears in the stripped note's §4 table or §9 mapping, (b) every tube named in §9 is in the box,
  (c) the guide's tube table equals `easel tubes --markdown`. Add it as scripts/tests/box_notes.sh.
- Reply with commits, the final four boxes, and test results.
