# Fix round 20's code after the second code review

Repo: [local path redacted] (branch r20-base). Review: [local path redacted] (read it all).
Scratch: [local path redacted] (TMPDIR/TMP/TEMP there). Python only via uv. Don't touch r19-base, main or
[local path redacted] Another agent (the parent) edits notes/*.md in this repo at the same time: never stage or commit
anything under notes/; commit only your own paths (`git commit -- <paths>`), small commits in the repo's style.

**Every shell command you run must be bounded: `timeout <seconds> ... < /dev/null`.** A previous agent hung for 12 hours
on an unbounded command reading stdin. Never `eval` script fragments; test real scripts or real functions.

## Fix
1. Major: the tube-string isolation check in scripts/export_r16_studio (~171-182) erases allowed names before searching,
   so an allowed "vermilion" hides a forbidden "orange vermilion"/"Chinese vermilion". Match forbidden full names
   against the original strings (e.g. longest-first matching / protecting forbidden names before suppressing allowed
   ones). Add both overlap fixtures to a test.
2. Moderate: crates/paint/build.rs enables the default box whenever the number of box features != 1. Make a multi-box
   non-replay build a compile error (or define it explicitly), and tie the default box to zero box features or the
   replay build. Add a feature-matrix check (zero, each singleton, a pair, replay) to a script test.
3. Moderate: paint's lib tests don't compile with a single box feature. Gate default-box-only tests with
   #[cfg(tube_box)] so `cargo test -p paint --no-default-features --features box-<x> --lib` compiles and runs the catalog
   invariant for each box.
4. Minor (do them): check_studio_names should scan raw bytes for exact UTF-8 spellings (Cézanne) and joined variants
   of all names (e.g. "daVinci" inside a longer token), keep word-boundary matching for prose; fixtures in
   studio_names.sh. replay_env.sh: use the easel built in CARGO_TARGET_DIR (resolve the target dir), and fail/skip
   clearly if ffmpeg is missing instead of claiming all three passed. export_concurrent.sh: add a deterministic barrier
   hook if it's cheap; otherwise document the limitation in the test header.

## Verify
cargo test for paint (default, and --lib per single box feature), easel (default, painter builds, each box painter
build), scripts/tests/*.sh, then export the four box studios and check `strings`. Update notes/r20/BUILD.md? No: that's
under notes/; put a short "second review fixes" summary in your reply and I'll add it. Reply with commits and results.
Do not start subagents.
