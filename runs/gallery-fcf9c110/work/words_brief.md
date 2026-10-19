# Task: titles and painters' own words for a gallery (read-only fact collection)

Project: [local path redacted] (a physical oil-paint simulator; each painting is a program written by an AI "painter" agent working from written knowledge of Caspar David Friedrich). Do NOT modify the repo or any worktree; read only (`git -C [local path redacted] show <branch>:<path>`, `git log`, reading files are fine). Scratch: [local path redacted] (export TMPDIR=TMP=TEMP=[local path redacted] never /tmp). Python only via `uv run` (a venv exists there).

Input: [local path redacted] (list of paintings: id, round, session log path, branch, notes paths relative to the repo on that branch). The last three assistant messages of each session are pre-dumped in [local path redacted]<id>.md. The script work/dump.py prints a session's text (`uv run python work/dump.py <session.jsonl> text`).
Where notes live: rounds 2-4 notes are on main (notes/amnesia2/, amnesia3/, amnesia4/) and on origin/<branch>; rounds 7-9 on branches rN-armK (worktrees [local path redacted] also exist); r7-python: experiments/python_friedrich/NOTES.md on branch r7-python; rounds 10-13 notes/<name>.md on their branches (worktrees [local path redacted]<branch>); round 14/15 notes/r14_pN.md etc. on branches r14a-p1, r14-p1..3, r15-p1..3 (folders [local path redacted] paint-r15-p*); round 15 final replies also in notes/round15/p*_final_reply.md on main. Round 1 (r01-*) painters lost their sessions to a power loss before any report: use their own assistant text in the session log.

For EACH painting id in your group, record:
1. `title`: the painter's OWN title, if it gave one (notes heading, final reply, program header comment `//!` or doc comment, or session text). Verbatim. Otherwise null. Never invent one. Also `title_source` (path, with branch if on a branch, e.g. `r10-arm1:notes/r10_winter_a.md:1`, or `session log` with timestamp).
2. `subject`: one plain sentence describing what's in the picture, based on the painter's own description (not invented).
3. `words`: 1-3 sentences, quoted VERBATIM, in which the painter talks about the picture and its artistic reasons (what it wanted the picture to feel/say, why this composition, light, motif). NOT about the engine, bugs, tools, APIs, code, friction, or project internals. Prefer the most human, moving, specific lines. `words_source`: exact path (branch:path:line, or session log file name + timestamp).
4. `notes_path`: where the painter's full notes live.
Verify every quote verbatim with grep/`git show ... | grep -n` before recording it.

PRIVACY (strict): the project is public under the pseudonym "alice". Never put a real name, an email or an absolute home path ([local account redacted]...) into any text field; write paths as [local path redacted] . If a candidate quote contains such things, pick another quote.
Style: US English.

Output: write [local path redacted]<GROUP>.json: a list of objects {id, title, title_source, subject, words, words_source, notes_path, remarks}. Your final reply: one line per id with title (or null) and any doubts.
