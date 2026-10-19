# Brief: notes/easel_guide.md (painter-facing)
- Objective: an AI painter (Opus 5.5 / Gemini) can open a session, set up a canvas, mix piles, paint, look, wait and replay, using only this guide; it steers nothing about what or how to paint.
- Audience/context: an agent in a shell in the exported studio; reads the guide first; has no history, no other docs besides research notes and the journal. Will read the whole file; will copy examples literally.
- Knowledge model: they know Lua and oil painting; they don't know the API, units, the no-undo rule, how piles work, how time works, what a failed chunk does.
- Source meaning: accurate API (check against code); no undo; failed chunk changes nothing; successful chunk permanent; hand time always on; wait any length returns time of day; paint only via piles from named tubes; look shows the canvas only; grid = squaring up; journal append-only.
- Form: markdown reference, short sections, code blocks with neutral examples (swatches, a stroke, a pile). No recipes, subjects, taste, history, people, negative lists of removed features, readers/successors.
- Style: US spelling, plain, present tense, no Oxford comma.
- Review: self-review against code (grep each API name) — no subagent review needed? It's consequential (every painter reads it). Do a careful self-check of every API name against the code.
