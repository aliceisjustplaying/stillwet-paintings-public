# Common rules for every fixer

- Work ONLY in your assigned git worktree (given in your task). Never touch [local path redacted] (main checkout) or other worktrees. Stay inside the files/areas assigned to you; if a fix truly needs a file outside your area, stop and say so in your final message instead of editing it.
- The verified findings (with file:line evidence, repro probes and fix sketches) are in [local path redacted] The original review is [local path redacted] Read the sections for your findings before coding. Probe programs from verification are under [local path redacted]<area>/.
- Before writing or changing any test, read and follow [local path redacted] Each fix gets one focused regression test at the owning boundary that fails before the fix and passes after (check that it fails first).
- Match the repo's style: terse, plain doc comments; commit messages in the repo's style (see `git log --oneline -20`). Keep fixes minimal. No drive-by refactors.
- Rendering changes: if a fix changes rendering output, only regenerate a golden when the change is intended, say exactly which golden and why, and note which existing paintings' replays would change.
- Scratch files go in [local path redacted]<your-name>/ (set TMPDIR, TMP and TEMP there). Use a CARGO_TARGET_DIR inside your worktree (the default target/ there is fine). For Python use uv.
- Run the relevant test suites (`cargo test --workspace` in your worktree for Rust; the harness tests for TS; the runner tests for Python) and make sure everything passes. Commit your work on your branch (one commit per fix is ideal). Do not merge, push or rebase.
- Final message: for each fix, one plain sentence of what was wrong and what you changed (describe the bug in words, not by review number), the commit hash, the test that covers it, test-suite results, and anything you could not fix or that needs a decision.
