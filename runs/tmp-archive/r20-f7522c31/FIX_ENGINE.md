# Fix round 20's engine and export script after review

Repo: [local path redacted] (branch r20-base; read notes/r20/BUILD.md and notes/r20/TUBES.md first).
Scratch: [local path redacted] (TMPDIR/TMP/TEMP there). Python only via uv. Don't touch r19-base, main,
or [local path redacted] (live painters). Another agent is editing notes/research/*_materials.md in this repo at
the same time: never stage or commit those files; commit only your own paths (`git commit <paths>`), small
commits, messages in the repo's style.

## Fix (from [local path redacted] and review_materials.md; read both)
1. **Build race** (review_code #1): concurrent exports of different profiles share one extracted tree and one
   Cargo target dir, and copy target/release/easel after the build; a studio can get another box's binary.
   Give each variant its own CARGO_TARGET_DIR, copy from that, and make extraction safe under concurrency (a lock,
   e.g. mkdir-lock or flock via a portable approach on macOS). Add a test that exports two uncached profiles
   concurrently and checks each binary's full box-name set.
2. **pipefail false negative** (review_code #2): `strings ... | grep -q` under pipefail. Capture output first
   (or non-quiet grep) and test the result. Add a regression test.
3. **EASEL_BOX leakage** (review_code #3): unset EASEL_BOX in scripts/check_painting, finish_painting,
   replay_clip (and anything else that replays a log or opens a studio on the runner's behalf). Test with a
   conflicting ambient value. (The runner itself is already fixed.)
4. **Catalog strings in painter binaries** (review_materials, "Binary strings: must fix"): every exported
   bin/easel contains the whole pigment catalog and the legacy "smalt box" label. A painter build for box X
   should contain only box X's tube records (names, descriptions, hex) and no other box labels. Gate catalog
   entries by the box features (or generate the box at build time) so that the painter build for each box
   has only its own tubes; the replay/all-boxes build keeps everything. Default-box behavior and r19 replays
   must stay bit-identical (keep the_tube_box_is_unchanged and the golden replay). Extend the export check:
   `strings bin/easel` must not contain any tube name outside the studio's box (careful: substrings like
   "lead white" inside "lead white" are fine; check whole tube names not in the box), nor "smalt box" etc.
   For the default/blank/friedrich studios nothing changes.
5. **Painter name in the shared physics note** (review_materials): notes/research/oil_paint_physics.md line ~109
   cites a "da Vinci" brush guide (a brand that is a painter's name). Replace with a neutral citation (e.g.
   "a brush manufacturer's technical guide") and drop the URL slug containing the name. Note this file is also
   what round 19's studios got; change it only on r20-base.
6. Also add "da Vinci" / "Vinci" and "Winsor" to the export's painter-name check (hyphen/case variants), and make
   sure names are matched case-insensitively as whole words including hyphenated forms (Alma-Tadema).

## Verify
cargo test for paint and easel (all builds you touch), scripts/tests/export_profiles.sh on the final head, the
new concurrency test, and `strings` checks on all four exported box studios. Reply with commits, test results and
anything you couldn't fix. Do not start subagents.
