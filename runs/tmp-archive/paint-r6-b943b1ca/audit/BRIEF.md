# Test audit, discovery lane: {LANE}

Repo: claude-paint, a Rust physical oil-paint simulator. Checkout for you:
[local path redacted] (detached at main). **Read-only discovery:** do
not edit, commit or delete anything in the repo. Scratch: export
TMPDIR=TMP=TEMP=[local path redacted]

Method: read [local path redacted] (the
test-audit skill; audit mode) and apply its junk patterns, value bar and
retention bar. Its Validation section is written for a JS repo; here the
equivalents are `cargo test -p <crate> <filter>` (run only targeted tests;
other agents share this machine: wrap in `timeout 600`). Also read
notes/principles.md (how this project thinks) and the module docs of the
code you judge.

Project-specific notes for judging value:
- Many tests guard physical behavior (paint film thickness, drying, color
  mixing, deposit). Those are the valuable kind: keep them unless a stronger
  test owns the same contract.
- Suspect: tests whose expected values come from the code under test
  (snapshot numbers copied from a run), tests that only check a function
  doesn't panic, tests asserting exact float constants or call shapes,
  near-duplicate tests of one contract, `pub` items or `#[cfg(test)]` hooks
  that exist only for tests, and dead production code only tests call.
- A test that fails on main is a possible product bug: report it, don't
  judge it junk.

Your scope: {SCOPE}

Prefer a few high-confidence candidates over a long speculative list. For
each candidate, record ALL the skill's "Candidate evidence" fields (exact
test name and file:line, what failure it can detect, non-test callers of
the seam, stronger remaining proof, history via `git log -S`/`git log -L`
if relevant, deletion unlocked, risk and validation command) and a
proposed action (delete / merge into X / rewrite at boundary Y / keep).
Also list notable retained false positives (looked suspect, but valuable)
in one line each.

Write the report to [local path redacted]
Final message: the same report. US English, no Oxford comma.
