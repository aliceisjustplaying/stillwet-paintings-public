# Review A: eight stage-1 branches (harness/painter, notes/round19/runner)

Method: detached worktree `review-a/wt`. Every branch's full suite ran at the branch tip. Each new test was then re-run with only the source files restored from the base (`git checkout <base> -- <src>`). All eight branches were merged on a detached HEAD, so no refs were created.

## Summary

| Branch | Verdict | Own suite | New test on base source |
|---|---|---|---|
| fix/N8-trusted-clock | ship with nits | 32 pass, 1 skip | 1 fail |
| fix/N9-journal-quoted (on N8) | ship with nits | 33 pass, 1 skip | 1 fail |
| fix/N10-image-budget | ship with nits | 32 pass, 1 skip | 2 fail |
| fix/N21-dotdot-names | ship | 32 pass, 1 skip | 1 fail |
| fix/P09-rayon-threads-env | ship with nits | 32 pass, 1 skip | 1 fail |
| fix/N14-probe-errors-not-recovery | ship with nits | 32 pytest pass | 6 fail |
| fix/N12-record-prescriptions | ship with nits | 31 pytest pass | 6 fail |
| fix/N11-reader-scope | ship with nits | 26 pytest + 3 node pass | 8 pytest fail (reader-scope.ts doesn't exist on main) |

- Pre-existing tests: main has 31 node passes, 1 skip and 26 pytest passes. None regress on any branch. The skip is the real-easel test, which also skips on main.
- Merge of all eight into main: no conflicts. `node --test harness/painter/test/*.test.ts notes/round19/runner/reader-scope.test.ts`: 39 pass, 1 skip. pytest: 37 pass.
- Commit style: every commit uses the repo's single long `area: what changed` subject with no body. The author is the repo's sole author (737 of 737 commits on main). No home paths, scratch paths or real names appear in any added line.

## fix/N8-trusted-clock (70423da): ship with nits
1. **Medium (documented open).** A successful paint's own `print` still sets the clock. The source filter only checks the tool name and `isError` (summary.ts:78), and `CLOCK_LINE` (summary.ts:66) matches any printed line. So `print("day 9999, 23:59")` in a chunk that succeeds becomes "Latest painting time the easel printed". This follows from design: `wait()` returns the string (crates/easel/src/api.rs:1434) and the painter prints it. N8 acceptance 1 ("arbitrary print text cannot change") needs a structured clock from the easel. `status` doesn't carry one: it prints only `chunks · px · setup` (crates/easel/src/session.rs:349-352).
2. **Low.** `JOURNAL_STAMP` still accepts `99:99` (summary.ts:67), so acceptance 3 ("invalid hours/minutes rejected") holds only for the tool clock. The risk is small: stamps are written by `easel note`, which indents continuation lines (crates/easel/src/main.rs:210-223), so a note can't forge a column-0 stamp.
3. Verified that `isError` is always present. It is a required boolean on `ToolResultMessage` (pi-ai dist/types.d.ts:418-429) and is set by agent-loop.js:651-660. Two real sessions persist `"isError": false` on paint results. `branchEntries` has the session-entry shape the test uses (compaction.ts:80). No real clock source is lost: `note` echoes `- day …:`, which `CLOCK_LINE` never matched.

## fix/N9-journal-quoted (ce181a5, on N8): ship with nits
1. **Medium (documented open, N9 acceptance 2).** The brief is still cut to its tail (summary.ts:111). The provider-facing compacted messages were not inspected (acceptance 3).
2. **Low.** `quote` splits on `\n` only (summary.ts:36-37). A bare `\r` or U+2028 inside a journal line leaves the following text unprefixed on its visual line. `easel note` keeps a mid-line `\r`, because Rust's `lines()` strips only a trailing one (main.rs:211). This is an edge case with no known producer.
3. **Nit.** The 120,000-character cap now counts the `> ` prefixes (summary.ts:119), so about 2 fewer journal characters are kept per line. README.md still says "the last 120,000 characters".
4. The test checks the full list of headings and that the forged clock line doesn't appear unquoted. That's good.

## fix/N10-image-budget (94921f9): ship with nits
1. **Low (policy).** When the newest image is over the limit, the step rounding also drops older images that fit. The test pins this: `imagesToDrop([1, 20_000_000]) === 2` (test/context-images.test.ts:34; context-images.ts:74-75). The request then carries no image at all. That's defensible, since an older view would read as current, but the commit message doesn't mention it. Resizing and typed capacity failure (ledger) are not done.
2. **Nit.** The oversize line shows the operator's env var name to the model (context-images.ts:97). easel-tools.ts:55 elsewhere avoids showing CLI internals to the painter (`toolWords`).
3. The change is unreachable at the 12 MB default. The first-image index handling is correct (`i === found.length - 1`, context-images.ts:138).

## fix/N21-dotdot-names (1eee25a): ship
- The fix is at easel-client.ts:133. I ran these extra paths against the branch:
  - rejected: `a/../../x`, `a/../..`, `..`, `../`, an in-studio link `up/x` pointing at the parent, and a link named `..lnk/f` pointing outside
  - accepted: `..draft`, `...`, `a/..b/../../x` (resolves to `studio/x`) and `<abs studio>/../studio/..draft`
  - posix: `..\x` is treated as a filename
- The existing symlink, `~` and file:// cases still pass.

## fix/P09-rayon-threads-env (f701a51): ship with nits
1. **Low.** Nothing in the runner sets `RAYON_NUM_THREADS`: grep finds it only in notes/review*/ and notes/time.md. So the preopen and auto-open easels now agree only because both inherit the operator's shell. The value is passed without validation (easel-client.ts:29). Logging the effective pool size, admission budgets and benchmarks are not done (documented).
2. The test mutates `process.env` and restores it in `finally`. That's safe because node --test runs a file's top-level tests one after another.

## fix/N14-probe-errors-not-recovery (2efe101): ship with nits
1. **Medium (behavior change, documented open).** A fatal-config probe (401, 402 "credits depleted", bad model) is now retried every 30 min until the 24 h give-up (r19_chains.py:389, :428-429). Before, the painter resumed and failed fast through the crash path. There is no fatal state, so an unattended lane can sit silent for a day on an auth error.
2. **Low.** The probe prompt is "Reply with the word ok." (r19_chains.py:257), and success needs `\bok\b` (r19_chains.py:392). A reply of "Okay." counts as unavailable every time, which gives a 24 h stall followed by a stop. This is unlikely but has no test.
3. Sitting receipts don't record probe attempts (documented; acceptance 3 is partial). The fake-clock test harness is sound: the give-up window is sized to the number of replies.

## fix/N12-record-prescriptions (dbdb751): ship with nits
1. **Medium (operational impact not measured by the lane).** The lane checked false positives only against studio_notes.md. I ran the new patterns over the 11 real reader records in the round 16/17 gallery runs. 2 would now be rejected:
   - r17 F p1 line 17: "…Use `clip=true` on every blend near anything else." (PRESCRIPTION)
   - r16 D p1 line 41: "a full background and shelf lay-in about 73 minutes" (PLACEMENT)

   Both are real reader_brief violations: a prescription, and subject plus process. Still, about 2 of 11 records would stop the chain (r19_chains.py:923-925) until a manual rerun. The four round 17-19 studio_notes.md files have 0 PRESCRIPTION or PLACEMENT hits.
2. **Low.** Simple formatting bypasses PRESCRIPTION (r19_chains.py:572): `**Glazing:** Always put…`, `- Glazing — always…`, `- Glazing (wet): never…`, `> Keep…`, `- *Always* glaze…` and `- "Always glaze last."` all pass. No real record uses bold labels (0 of 11). The commit and code already say this is a pattern gate, not a review.
3. **Low.** Plausible material lines that PLACEMENT rejects (r19_chains.py:576-578): "strokes that ran off the edge of the canvas were clipped", "the pile's composition changed", "the loaded side of the brush on the left", "a stroke over the background wash lifted it". None of these occur in the real records.

## fix/N11-reader-scope (c49a967): ship with nits
- Verified:
  - pi replaces a built-in tool with an extension tool of the same name (pi dist/core/agent-session.js:2795-2796).
  - Without READER_SCOPE, `pi --print -e reader.ts` exits 1: "Failed to load extension … READER_SCOPE is not set".
  - pi-black (the other `-e`) registers no tools.
  - The lane's smoke copies of reader.ts and reader-scope.ts match the branch byte for byte.
  - A run folder reached through a symlinked parent can read the brief and write the record.
  - A relative READER_SCOPE is rejected.
  - Swapping the record's parent for a link after load gets `writePath` denied.
1. **Low.** A hard link at the record path to a log passes `writePath`, and write would then change the evidence (reader-scope.ts:43-50; only `isSymbolicLink` is checked, at :48). The reader has no tool that can create a link, and the runner unlinks the record first (r19_chains.py:609), so this is not reachable today. Evidence is not made immutable on disk (documented).
2. **Low.** The test fixture realpaths its top folder (reader-scope.test.ts:10), so the symlinked-parent case (for example macOS's system temp folder, which is a link) has no committed test. I checked it by hand and it works.
3. Documented and still valid: the check-then-use race; reader-scope.ts must be copied next to reader.ts in runner copies. A journal the painter never wrote is left out of scope (r19_chains.py:616), but reader_brief still names its path, so the reader gets "not one of the files to read" instead of "no such file". This is harmless.
