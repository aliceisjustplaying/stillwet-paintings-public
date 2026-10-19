# Adversarial code review, round 2

All three round-1 majors are fixed. The current catalogs and exported variants are correct, but the new tube-isolation guard has a reproducible false negative and several feature/test edges remain unprotected.

## Round-1 findings

1. **Fixed — concurrent exports no longer share extraction or build output.** `scripts/export_r16_studio:77-123`

   Extraction is serialized by `$builds/$sha.lock`; each variant is serialized separately and built under `$src/target/$variant`; the final cache write is an atomic rename while that variant's lock is held. The Perl child duplicates fd 9, so its `flock` remains attached to the shell's open-file description until `unlock`; a second process blocked for 1.96 seconds in a hold test. Kernel-owned locks leave no stale ownership after death, and the extraction lock is released before a variant lock is taken, so there is no lock-order cycle.

   Three fresh `sargent`, `inness`, and `blank` exports started together under `review-target2/studio-build-review`. All three built and copied distinct binaries; their `tubes` outputs were respectively Sargent, Inness, and the default tube box. The exports later stopped only when the sandbox refused the smoke test's Unix-socket bind (`Operation not permitted`).

2. **Fixed — the painter-name check consumes captured strings.** `scripts/check_studio_names:34-43`, `scripts/export_r16_studio:159-162`

   `strings` completes before any `grep`, so an early hit cannot turn into pipeline status 141. `TMPDIR=... scripts/tests/studio_names.sh` passed, including its long early-hit fixture.

3. **Fixed — ambient `EASEL_BOX` is removed from runner and replay paths.** `[local path redacted] `scripts/check_painting:26-29`, `scripts/finish_painting:19-22`, `scripts/replay_clip:40-43`

   Importing the runner with `EASEL_BOX=sargent` left the process environment with no `EASEL_BOX`, so studio open/close and all descendants inherit a clean environment. Each standalone replay script also unsets it before building or invoking an easel. The runner now copies `trees.md` only for `friedrich` (`r20_chains.py:788-789`).

## New findings

### Major

1. **The tube-string isolation check can erase a forbidden longer tube name before looking for it.** `scripts/export_r16_studio:171-182`

   The checker globally removes every allowed tube name and pigment from the binary strings, then searches the remainder for outside tube names. In a Sargent build, `vermilion` is allowed while `orange vermilion` and `Chinese vermilion` are not. Given binary strings containing either forbidden name, line 179 first removes the allowed suffix `vermilion`; neither forbidden full name can then match. Running the exact Perl logic with a Sargent-like table and `bin_strings='orange vermilion Chinese vermilion'` produced an empty stray result.

   A future cfg mistake that includes either Alma-Tadema-only record in the Sargent binary therefore passes the guard. Check occurrences against allowed record intervals in the original byte stream, or otherwise preserve/protect complete outside names before suppressing legitimate overlaps. Add both overlap directions as fixtures: allowed `vermilion` plus forbidden `orange vermilion`, and allowed `orange vermilion` plus a legitimate embedded `vermilion`.

### Moderate

1. **Two box features silently restore the default box and its tubes in a non-replay build.** `crates/paint/build.rs:9-12`, `crates/paint/src/palette.rs:353-368`

   `tube_box` is enabled whenever the count of named boxes is not exactly one. Thus `cargo test --release -p easel --no-default-features --features box-sargent,box-inness --test painter the_build_holds_only_its_box_s_tubes -- --exact` exposed `[“tube box”, “sargent”, “inness”]` and failed the painter-build assertion. This is a surprising privilege expansion for an accidentally multi-featured painter build; zero features correctly gives only the default, each single feature correctly gives only that box, and the default replay build correctly gives the default plus all four named boxes.

   Key inclusion of the default box to an explicit replay marker (the existing `paint/hand-hook` propagation can serve), and either define multi-box non-replay builds as the requested union or reject them at compile time. Add zero, every singleton, two-feature, and replay configurations to the feature matrix.

2. **The catalog unit test cannot run in the single-box configurations it claims to verify.** `crates/paint/src/palette.rs:538-548`, `crates/paint/src/style.rs:104-144`, `crates/paint/src/tests.rs:450`

   `cargo test --release -p paint --no-default-features --features box-sargent --lib` fails to compile with 38 missing `Palette::tube_box`, `Style::oil`, and other `#[cfg(tube_box)]` references in default-box tests. The new catalog test is compiled in the same test crate, so it never runs there. The easel integration assertion did pass for no box feature and for all four singleton box features, but the paint package's advertised test does not provide that coverage.

   Gate default-box-only tests with `#[cfg(tube_box)]`, or move the feature-neutral catalog invariant into a test target that compiles for each feature set; run those configurations in CI.

### Minor

1. **`check_studio_names` still has binary-only false negatives for accented and concatenated non-box names.** `scripts/check_studio_names:20-22`, `scripts/check_studio_names:38-43`

   On this macOS toolchain, `strings` turns a binary `Cézanne` into `zanne`, so the declared `C[eé]zanne` pattern is never seen. A fixture containing `bonedaVincilead` also exits 0 because only the four box surnames get the inside-word pass. Scan the raw binary bytes for exact UTF-8 spellings and joined variants, reserving word-boundary matching for prose; add both fixtures to `studio_names.sh`.

2. **The new concurrent-export test does not force the original build/copy race.** `scripts/tests/export_concurrent.sh:20-31`

   Starting three full uncached Cargo builds makes the vulnerable old implementation likely to finish its copy before the next feature build has relinked the shared executable. The test checks the final artifacts well, but it has no barrier in the old gap between `cargo build` returning and `cp`, so the regression can pass nondeterministically. Test the build/cache helper with an injectable build command or pre-copy hook and hold one exporter at that boundary until another variant relinks.

3. **`replay_env.sh` can use a stale binary and can report all three paths checked after skipping one.** `scripts/tests/replay_env.sh:15-16`, `scripts/tests/replay_env.sh:39-45`

   Cargo honors `CARGO_TARGET_DIR`, but the test then invokes `$repo/target/release/easel`; with the required review target it built `review-target2/release/easel` while selecting an older binary under the repository target. If `ffmpeg` is absent, it skips `replay_clip` and still prints that all three scripts replayed the log. Resolve the built executable from the target directory (and make the scripts under test do the same), and skip the whole test or fail clearly when a required dependency is absent.

## Verification

- `CARGO_TARGET_DIR=.../review-target2 cargo test --release -p paint --lib`: 163 passed, 7 ignored; the golden scene passed.
- `cargo test --release -p easel --test boxes`: the round-19 golden replay passed bit-identically; two live-session tests failed only because Unix-socket bind is forbidden in this sandbox.
- The catalog-isolation integration assertion passed for no box feature and each of `box-sargent`, `box-inness`, `box-alma-tadema`, and `box-tonn`.
- The three-way export reached and passed extraction, concurrent builds, binary/name checks, and per-box tube output; only the later socket smoke probe was unavailable.
