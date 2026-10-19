# Stage 1 brief: small reproduced bugs, one branch per fix

Scratch root: [local path redacted] (TMPDIR/TMP/TEMP go here, under a subfolder named for your lane; never /tmp or OS temp dirs).
Review ledger: paint-review-deliverables/FINDINGS_AND_TASKS.md (read your items in full; source anchors there are relative to an archive, map them to the real checkout).
Witness probes (they assert the OLD defect is present): paint-review-deliverables/probes/harness-probes.mjs, runner-gallery-probes.py (that one expects an archive root with repos/claude-paint and repos/stillwet; adapt paths, do not edit the originals).
Evidence of the witnesses reproducing: paint-review-deliverables/evidence/*.json.

## Rules
- Work only in your assigned worktree. Never touch [local path redacted] or [local path redacted] main checkouts, live studios ([local path redacted] launchd jobs, running daemons, or deployments. Never deploy, push or merge.
- A golden run is in progress (golden/run_corpus.sh). Do not touch golden/ or wt-exp/, and do not kill easel processes you did not start.
- One small branch per ledger item: `git switch -c fix/<id>-<slug> main` (for stillwet, `main` is stillwet's main), commit, then start the next item from main again. Related items that must share code (e.g. R20+R21) may share one branch; say so.
- Each fix: first a test that fails on main because of the defect (convert the witness into a positive regression test of the new contract), then the fix, then the test passes. Label each commit behavior-preserving / intentional behavior change / new feature in your report (not necessarily in the commit message).
- Failures must never look like "unchanged" or success: an error, timeout or unknown outcome is reported as such.
- Keep diffs small. Don't refactor beyond the item. Don't add dependencies without need.
- Commit messages: follow the repo's style (read `git log` — a descriptive sentence of what now holds, not "fix bug"). Git identity is preconfigured as "alice"; the pre-commit anonymity hook must pass: no real names, no absolute home paths (write [local path redacted] in committed files.
- US spelling, no Oxford comma in prose you write.
- Python: use `uv` (e.g. `uv run --with pytest --with pillow pytest ...`); create a venv in your scratch subfolder if needed, never in the repo.
- Node tests: `node --test harness/painter/test/<file>.test.ts` (see harness/painter/README.md).
- Don't spawn subagents.
- If an item is bigger than a small PR or needs a policy decision, stop on that item, write down the decision needed and move on.

## Report (your final message)
Per item: ID, branch name, commit sha, one-line what changed, test command + result (pass on branch, fail on main), label, and anything left open. Receipts: file:line or command output. Also write the same to <scratch>/stage1-<lane>.md.
