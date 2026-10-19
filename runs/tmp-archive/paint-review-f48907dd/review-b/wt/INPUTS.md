# What each painter was given

`inputs_extract.py` reads each painting's session log(s) and writes `inputs_data/` (given.json, docs/, COVERAGE.md).
`inputs.py` renders it: a collapsed "What the painter was given" block per painting, and `/given/` pages for long
documents (one per distinct version, by content hash).

- Given means pointed to: a document is listed when the brief, a message or the system prompt names it (path, file
  name or its folder), directly or through another listed document. Anything else the painter opened on its own
  (license notices, its own log, server.log, binaries, source, notes nobody pointed it to) goes in a collapsed
  "Also opened in the studio" sub-list, paths only, with no `/given/` page.
- "The painter's journal" (`inputs.journal(id)`), a separate collapsed section: the studio's `notes/journal.md`
  as it stood at the end, copied to `inputs_data/journals/<id>.md` and rendered as a dated list. Only rounds 16+
  kept one (`bin/easel note`); earlier painters wrote a single notes write-up instead, so their pages have no
  journal section. COVERAGE.md checks each journal's entries against the note calls in the logs. `inputs_demo.py` renders a demo without the main build.

    nice uv run inputs_extract.py                     # refresh the data (needs the session logs and [local path redacted]
    uv run --with markdown-it-py --with pillow python inputs_demo.py [local path redacted]

Hooking it into build.py (six lines):

1. dependencies: `# dependencies = ["pillow", "markdown-it-py"]`
2. after `from PIL import Image`: `import inputs`
3. in `main()`, after `caps = rounds()`: `inputs.load(man)`
4. `(DIST / "style.css").write_text(CSS)` -> `(DIST / "style.css").write_text(CSS + inputs.CSS)`
5. in the painting page body: `{words}{rec}{nav}</main>` -> `{words}{rec}{inputs.journal(p["id"])}{inputs.fragment(p["id"])}{nav}</main>`
6. before the final `print`: `inputs.write_pages(DIST, page)`

Paintings not in the manifest (rounds 17+ still running, ids guessed as r17-o1 etc.) are in the data but left out
of the pages until the manifest lists them under the same id.
