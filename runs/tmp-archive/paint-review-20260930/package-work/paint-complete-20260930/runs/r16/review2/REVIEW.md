# Final studio review

No blocking easel defect demonstrated. Three remaining documentation issues, ranked below. Paths are relative to this directory; runtime receipts are in `scratch/`.

## 1. Historical artist discussion remains in the tree note — moderate, A/B

**Why it matters:** The final review request explicitly flags “people other than cited authors” as unintended leaks (criterion 3 in the supplied [review request]([local path redacted] This finding applies that review criterion, not an additional rule in briefs A/B.

**Evidence:** `friedrich/notes/research/trees.md:8,26–28` repeatedly names Leonardo's rule; line 26 says “Leonardo wrote” and quotes him. Lines 101–102 repeat the artist's name in paper titles. This goes beyond identifying the cited research authors, Eloy, Minamino and Tateno.

**Fix:** Use “branch-area rule” in the body and remove the historical quotation. Keep the equation, measured exponents and source keys. Cite the papers by author, venue, year and URL without the artist-naming titles. This preserves the botanical research without introducing another artist.

## 2. The Starting block reads a file it never creates — low, all studios

**Evidence:** Both `notes/easel_guide.md:27–34` present a startup sequence whose third command is `bin/easel do -f chunk.lua`. Neither studio supplies that file or a preceding creation step. Running the sequence literally produced:

```text
+ bin/easel do -f chunk.lua
No such file or directory (os error 2)
```

Receipt: `scratch/starting.txt:5–6`. Later look, note, save and close succeeded, so this is a recoverable instruction gap, not a broken session. A real file works (`scratch/file-finish.txt:4–6`).

**Fix:** Remove that line from the runnable Starting block, retaining file-input syntax in the command table, or explicitly instruct the painter to write a chunk in their scratch folder first and pass its path.

## 3. The replay prohibition conflicts with the advertised check command — low, all briefs

**Evidence:** `brief_A.md:30–31`, `brief_B.md:30–31`, `brief_C.md:28–29` and `brief_D.md:28–29` say not to replay the session. Both guides advertise `bin/easel check` as replaying the log in a fresh session (`notes/easel_guide.md:46,472–473`). The command actually does so: `scratch/file-finish.txt:13–14` reports `replay matches the live canvas exactly (15 chunks, 7.0s)`.

This is a rule ambiguity, **not** a hypothetical-preview capability: the advertised check compares the committed log with the current canvas.

**Fix:** Clarify the briefs: “Don't replay the session yourself; the easel's internal verification on reopen and `bin/easel check` are allowed.” Alternatively remove the check recommendation if painters should not invoke it.

## Verification scope

The two binaries have the same SHA-1, `7caa635fdcfb4eb8676a4240c5ecd3af19f23d08`; both guides and both studio-note files compare identically. Runtime work used only `scratch/runtime/`, copied from blank. Original studios were not modified.

The startup/save/close sequence, seven advertised viewing examples, painting and drawing examples, world/form/outline examples, file/stdin chunks, frames, finishing after waiting and exact replay checks were exercised (`scratch/starting.txt`, `scratch/runtime.txt`, `scratch/api.txt`, `scratch/geometry-finish.txt`, `scratch/file-finish.txt`). The only failed literal startup command was the missing input file above. Schematic Lua examples were supplied with concrete tubes, masks and points rather than treated as standalone scripts.

The removed globals returned `nil`; `run`, named sessions, `-s`, wet view, repeated canvas initialization and invalid waits were refused (`scratch/runtime.txt`). Varnish, relief and cracks refused wet paint (`scratch/api.txt`). No undo, hypothetical preview, drying shortcut, automatic color matching or per-pixel color access was demonstrated in these probes. This is a binary-level spot check, not a proof of absence. Host-level bypasses and intentionally retained finishing behavior are outside these findings.
