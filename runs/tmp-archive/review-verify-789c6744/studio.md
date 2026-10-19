# Studio + replay clips (#22–30): verified by the parent session from source

(The verify-studio subagent was blocked by a provider content filter and wrote nothing; these verdicts are from reading the code at 08f6324. No probes were run.)

| # | Review | Verdict | Mine | Receipt |
|---|---|---|---|---|
| 22 | P1 | Confirmed | P2 | studio.py:398-402 `/api/file` serves any file under the painter's cwd, in public mode too. Real studios hold BRIEF.md, notes/, bin/easel, .pi/settings.json (compaction settings only): overexposure, no secrets found. Public mode is opt-in (`--public`, studio.py:416). Fix: allowlist paintings/lua/*.lua (+ painting .rs) for /api/file. |
| 23 | P1 | Confirmed (logic) | P2 | export_static.py:76-85: `rel` from session-log paths; source containment is checked on realpath(cwd/rel), but the destination os.path.join(out,"data",p,"file",rel) isn't, so a rel with `..` segments escapes `out`. Needs a painter-written path with `..`. Fix: reject rel with `..`/absolute; check dest realpath under out. |
| 24 | P2 | Confirmed | P2 | export_static.py:90-95 deletes every file under `out` not written this run. Fix: marker file / manifest of owned files. |
| 25 | P2 | Confirmed | P2 | studio.py:282 writes `out` onto an earlier event; studio.py:392 sends ev[since:]; index.html:157,161 only fetch/keep new events. Paint chunks whose result arrives in a later poll lose `out`, and source() (index.html:273) drops chunks without `ok · chunk`. |
| 26 | P2 | Confirmed | P3 | index.html:280-282 applies every write/edit event with no success check. Current painters have no write/edit tools (paint/look/note/status/log/read), so only old cargo-era sessions are affected. |
| 27 | P2 | Confirmed | P3 | index.html:151 reset() doesn't clear #img/#cap; show() (index.html:345) only sets the image when one precedes pos. Cosmetic. |
| 28 | P2 | Confirmed | P3 | replay_clip:99 list=$dir/concat.txt with entries "$dir/f" (:128); replay_pace.py:184-190 same. Relative dir doubles. Absolute dirs work. |
| 29 | P2 | Plausible from source | P3 | replay_pace.py schedule() weights w[n-1] (last) but output uses fr[:-1] + fixed hold (:183-190). Not re-run. |
| 30 | P2 | Confirmed (logic) | P3 | replay_clip:113-121: capped at maxhold, no error when want can't be met; the stderr line reports actual seconds. |
