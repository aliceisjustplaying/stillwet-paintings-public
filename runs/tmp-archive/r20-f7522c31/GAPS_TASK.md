# Fill the gaps in one materials note

Note: [local path redacted]<ARTIST>_materials.md (the sourced version; the painter gets a copy
with sources and research-only remarks stripped by scripts/strip_sources). Research rules:
[local path redacted] including its addendum. Earlier research scratch for this artist may
be in [local path redacted] (e.g. *_src/ folders): reuse it.

Scratch: [local path redacted] (TMPDIR/TMP/TEMP there). Python only via uv. **Bound every shell command:
`timeout <s> ... < /dev/null`.** Other agents edit the other notes in this repo at the same time: edit and commit only
your note (`git commit -- notes/research/<ARTIST>_materials.md`), repo-style message. Do not start subagents.

## 1. Fill the gaps
Find every place the note says something wasn't found or isn't known: "*Gap*", "not stated", "not documented", "no
... found", "not accessible", "not read in the original", "*Not analyzed*", "unknown", summary sentences listing what
no source gives. For each, search for real evidence (conservation/technical literature, museum pages, catalogs,
period accounts, the artist's own words; web search and fetch). If you find it, replace the gap with the cited fact
in the note's style (materials and method only; all the addendum's rules apply).

## 2. Hide what can't be filled
A gap you can't fill is for us, not the painter. Wrap the whole sentence or bullet in a research-only comment on its
own line(s), e.g.:
    <!-- research: - **Thread count.** No count appeared in accessible sources. -->
Don't leave an empty heading or a dangling fragment in the visible text. Summary sentences about missing evidence go
in comments too. Keep genuine statements of practice that happen to be negative ("he did not trace his drawings",
"no solvent in the paint"): those are facts about how he worked, not gaps.

## 3. Drop pigments that were never there
Remove pigment table rows and sentences about pigments the artist is documented as NOT using, rejecting, avoiding,
owning but not using, or not reported at all (e.g. "Prussian blue | Not reported", "Chrome yellow | Rejected",
"Zinc white | Avoided", "Vermilion | owns a tube, has not used it"). If the evidence matters to us, keep it in a
research comment. Keep pigments he did use, even rarely, with their evidence.

## 4. Check
Run `scripts/strip_sources notes/research/<ARTIST>_materials.md [local path redacted]<ARTIST>.md` and
read the result as a painter: no gap talk, no absent pigments, no dangling text, nothing that describes what pictures
look like. Body length stays roughly 2,000-2,800 words (visible). Reply with: gaps filled (with the new facts and
sources), gaps hidden, pigments dropped.
