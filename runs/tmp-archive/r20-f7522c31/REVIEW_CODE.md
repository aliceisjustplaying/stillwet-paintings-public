# Code review: r20-base

## Major

1. **The parallel runner races feature-specific easel builds.** `scripts/export_r16_studio:72-96`, `[local path redacted]

   Every profile for a commit builds in the same extracted tree and the same Cargo target directory, then copies the shared `target/release/easel` into its variant cache after `cargo build` returns. The runner starts all four lane exports in separate threads. Cargo's build lock does not cover that later copy: another export can relink the shared executable before the first export copies it. The initial `rm -rf`/archive extraction and `.extracted` marker are also unsynchronized.

   On a fresh concurrent run, the sargent build can therefore cache the inness executable as `built/sargent/easel`; its export then fails at the box probe and stops that lane. A concurrent no-replay all-boxes build can be worse: the probe accepts the requested box while the painter binary also contains every other box. `scripts/tests/export_profiles.sh` runs profiles sequentially, so it cannot exercise this failure.

   Give each variant its own `CARGO_TARGET_DIR` and copy from that directory. Protect extraction with a lock or extract once before starting lane threads; alternatively serialize exports. Add a test that starts at least two uncached profile exports concurrently and verifies each binary's complete box-name set.

2. **The binary name-isolation check silently ignores real matches under `pipefail`.** `scripts/export_r16_studio:145-159`

   Both checks use `strings ... | grep -q...` while `set -o pipefail` is active. Once `grep -q` finds a forbidden name, it exits; `strings` then receives SIGPIPE and the pipeline commonly returns 141, so the `if` body is skipped. Against the current all-boxes release binary, `strings target/release/easel | grep -qiE 'Inness|Tadema|Tonn'` returned 141, demonstrating the false negative.

   If an inness export accidentally receives a sargent or no-replay all-boxes binary, the checker can report no hit. The functional probe only proves that the requested box exists, so the all-boxes painter binary passes it and exposes all painter names.

   Do not combine `grep -q` with the streaming producer under `pipefail`: capture `strings` output first or consume the whole stream with non-quiet `grep`, then test the captured matches. Add a regression using a mock/fixture binary output containing a forbidden name early followed by enough data to trigger SIGPIPE.

3. **Ambient `EASEL_BOX` leaks into studio startup and final replays.** `[local path redacted] `[local path redacted] `scripts/check_painting:58-71`, `scripts/finish_painting:65-67`

   The runner inherits its full environment when it opens each studio and when it launches check and finish subprocesses. None of those paths removes `EASEL_BOX`. The easel correctly treats that variable as configured state and rejects it when it conflicts with `bin/box` or a log header.

   Launching the round with `EASEL_BOX=sargent` exports every studio successfully because the export script unsets the variable, then the inness, alma-tadema, and tonn lanes fail their first `open`: their `bin/box` disagrees with the inherited environment. If the variable appears only later, their checks and finishing runs fail against otherwise valid logs.

   Remove `EASEL_BOX` from the environment for studio opens and all log-authoritative replay commands (in the runner and in `check_painting`, `finish_painting`, and `replay_clip`). Add coverage that launches the runner and the replay scripts with a conflicting ambient value.

## Checked and fine

The default catalog is still bit-compatible: the round-19 golden replay passed, and `cargo test --release -p paint` passed 165 tests (14 ignored). Header selection is confined to the log head, duplicate/unknown headers fail, named logs replay with their recorded palette, catalog names and ranges are checked, and a feature-specific sargent binary contained no other box names. The runner's four profile mappings, Inness `trees.md` copy, `EXPORT_AS`, and `opencode`/`deepseek-v4.1-flash` `key_from` plumbing are consistent.

Some easel integration tests could not open Unix sockets in this review sandbox (`Operation not permitted`); their non-socket parser/default-box tests passed, and the failures were environmental rather than assertions about r20 behavior.
