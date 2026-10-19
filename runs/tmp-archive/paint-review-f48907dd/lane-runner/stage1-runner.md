# Stage 1, lane runner

Worktree: wt-runner. Three branches, each cut from main (worktree left detached at main, clean).
Python tests: `uv run --no-project --with pytest pytest -q notes/round19/runner/test_r19_chains.py` (TMPDIR in lane-runner).
The "fail on main" runs used the branch's tests against `git show main:notes/round19/runner/r19_chains.py`.

**Deployment note:** runners don't run from main. README.md:39-41 says "Runners run from a copy in `[local path redacted]", and the harness and easel code come from the round tag (r19_chains.py:87-88: `TAG = "round-19"`, `BASE = RUN / "code"`, extracted with `git archive`). So these commits change only future rounds or future copies. Any round-19 copy that is already running still has the old behavior. N11 also adds a new file: `reader-scope.ts` has to be copied next to `reader.ts`.

## N14: a probe timeout or error no longer counts as recovery
- Branch `fix/N14-probe-errors-not-recovery`, commit `2efe101`
- Change: `probe_outcome` (r19_chains.py:379) returns `available` only for exit 0 with an "ok" reply. A usage limit gives `limited`. A timeout, nonzero exit (auth, network), empty reply or unexpected reply gives `unavailable`, logged as `PROBE FAILED (attempt N), not a recovery: <reason>` (:428) and retried every LIMIT_PROBE_S within the existing give-up window. The success, still-limited and give-up logs now include the attempt number.
- Tests: `test_a_probe_that_fails_is_not_the_provider_answering` (5 cases) and `test_a_probe_that_answers_ends_the_wait_and_a_limit_keeps_it_going`. They use a fake clock that advances when the code sleeps.
  - Branch: `32 passed`
  - Main: `6 failed, 26 passed`, e.g. log `the provider answers again after 0.5 h: probe timed out`
- Label: intentional behavior change
- Open:
  - Auth and configuration errors are retried until the 24 h give-up instead of stopping at once. There is still no separate fatal state or backoff; that needs a decision on which errors count as fatal.
  - Sitting receipts (p<n>_sittings.json) don't record probe attempts yet. Only the log does.

## N12: records that pass the pattern gate are not claimed clean
- Branch `fix/N12-record-prescriptions`, commit `dbdb751`
- Change: `record_problems` now also rejects the two things reader_brief.md excludes that are catchable in plain English:
  - `PRESCRIPTION` (:572): a sentence starting with a command (always, never, keep, put, use...). A line that continues the previous sentence doesn't count as a sentence start.
  - `PLACEMENT` (:576): "center/third/... of the picture", "on the left/right", horizon, foreground, composition...

  The pass log now says `record written (it passed the pattern gate, names and syntax, not a review of what it says)` (:637). The docstring says an empty result means no pattern matched, not that the record is only about materials.
- Tests: new cases in `test_a_reader_record_reaches_the_next_studio_only_if_it_passes`:
  - The witness record ("Always put a tall arch...") is rejected with "what to do on line 1".
  - Also rejected: "never glaze...", "lower third of the picture" and "horizon".
  - A material line containing "left" and "top" still passes.
  - Branch: `31 passed`. Main: `6 failed, 25 passed`.
- False-positive check: the operator's real material-only `studio_notes.md` hits only the line cap: `['174 lines (at most 60)']`.
- Label: intentional behavior change (more records rejected; log wording)
- Policy decision needed (stopped here):
  - A paraphrase, another language or an implicit hint still gets past a pattern. Honest options:
    - (a) a human or model semantic review gate before a record enters the next studio (stalls unattended chains)
    - (b) the constrained record schema from the ledger (observation, conditions, effect, uncertainty, operation IDs)
    - (c) declaring chain inheritance an explicit non-neutral experimental condition
  - Linking claims to evidence and medium/version (acceptance 3) is not done.

## N11: reader read/write scoped at the tool boundary
- Branch `fix/N11-reader-scope`, commit `c49a967`
- Change: `reader.ts` re-registers pi's `read` and `write` and checks each path with `reader-scope.ts`:
  - It may read only the exact files the runner lists in `READER_SCOPE`: the session logs, the journal if it exists, and its brief. It may also read its own record.
  - It may write only the one record path.
  - Paths are compared by real path, so `..`, `~`, `@`, `file://` and symlinks can't reach another file. The record may not be a symlink.
  - A missing or invalid scope throws at load, and pi exits 1.
  - `read_painter` passes the scope (r19_chains.py:619).
- pi receipts:
  - Extension tools replace built-ins with the same name: pi dist/core/agent-session.js:2794-2796 `toolRegistry.set(tool.name, tool)`.
  - A load failure exits: dist/main.js:741-745 `process.exit(1)`.
  - Verified: `pi --print ... -e reader.ts` without a scope prints `Failed to load extension ... READER_SCOPE is not set` and exits 1.
- Tests:
  - `node --test notes/round19/runner/reader-scope.test.ts`: 3 pass. On main it fails with ERR_MODULE_NOT_FOUND because the module doesn't exist.
  - Python: the reader mock checks the exact READER_SCOPE, and `--tools` is exactly `read,write`. Branch: `26 passed`. Main: `5 failed` (`TypeError: 'NoneType' object is not subscriptable`, since no env is passed).
  - Scratch smoke test (lane-runner/n11-smoke/smoke.mjs) loads the real reader.ts against installed pi tools. It reads the log, then denies another studio, a symlink escape, `[local path redacted] writing the evidence and `../other/x.md`. It writes and re-reads the record.
- Label: intentional behavior change (security hardening)
- Left open (bigger than this PR):
  - The ledger's dedicated read-only evidence root: copying or projecting logs outside the session directory, together with N15/N17 bounded projections. Today the files are only checked by exact path; they are not made immutable on disk.
  - A check-then-use race if a listed file is swapped between the check and pi's read. The reader has no way to swap files itself.
  - A live-model test for acceptance 3 (an instruction planted in a log). Structurally, the log can't widen the tools, but no model run was made.
