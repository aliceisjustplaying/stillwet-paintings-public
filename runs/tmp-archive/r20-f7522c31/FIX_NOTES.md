# Revise round 20's four materials notes after the contamination review

Files (edit in place, commit them): [local path redacted]
Review to apply: [local path redacted] (GPT-6 Astra). Read it fully. Also read the
accepted standard [local path redacted] and the research task
[local path redacted] Another agent is editing code/scripts in the same repo: commit only
these four files (`git commit notes/research/<file>`), one commit per note, repo-style messages. Don't touch
oil_paint_physics.md (the other agent fixes it). Keep backups? git history is the backup.

## Apply
- Every "must fix" and "should fix" finding for the four notes: remove descriptions of what pictures look like
  (subjects, motifs, compositions, color schemes, flesh/sky/marble/flower recipes, backgrounds, lighting as
  subject), named/described artworks, aesthetic judgments and praise, teaching advice presented as recipes.
  Keep documented materials and method facts (supports, grounds, drawing/transfer, pigments with evidence,
  media, layer order, brush handling, reworking, drying, varnish as history), with their citations.
- Names: remove other painters' identities in text and sources, including source authors who were painters
  (A. H. Church, Mrs. R. Barrington) and brand names containing painters' names (Winsor & Newton → "a London
  colorman" or similar). Cite such sources neutrally (title-free descriptive citation or a neutral key); do not
  advertise omissions ("the title names another painter").
- Add to each note a short, identical-in-structure section "At this easel" stating plainly: the easel is linen
  with ground layers; one oil-medium share (no solvents, driers, resins, copal, megilp, varnish controls); no
  panels or rigid supports; no canvas scraping/abrasion tool. Historical practices in the note are context, not
  available controls. No suggestions for faking effects.
- Add to each note a short "The tubes here" section mapping historical names to this studio's tubes and stating
  omissions/uncertain inclusions (see the review's per-studio suggestions; the box contents are in the review's
  table and in `bin/easel tubes` of [local path redacted]<profile>/). Neutral, factual.
- The review's uncertainty wording fixes (summaries overstating completeness; Tonn "newer statement is the one to
  rely on").
- Roughly equalize: same section structure across the four, body length roughly 2,000-2,800 words each
  (Friedrich's is ~2,100). Cut Tonn the most; cut duplicated summaries.
- Do NOT change the briefs or the choice of genre (portrait/landscape/Roman scene/open are the user's spec).
- US spelling except inside quotes; no Oxford comma.

## Check before committing
grep each note for other painters' names (the list in scripts/export_r16_studio `artists=` plus Winsor, Vinci,
Church, Barrington), for "look"/"effect"-recipe phrasing, and re-read it as a painter would: could any sentence
tell me what to paint or how the picture should look? Then reply with a per-note summary of what was removed and
the new word counts. Do not start subagents.
