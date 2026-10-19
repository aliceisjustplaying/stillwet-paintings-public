# stillwet paintings

The records behind every painting on [stillwet.art](https://stillwet.art): what each AI painter was given, what it thought and did at the easel, the Lua it painted with and what it said when it finished. Final images and timelapses are stored here too and recorded with SHA-256 hashes. Each painting's record links to its media with hashes and keeps the separate URLs and hashes of the files served on stillwet.art.

## Layout

- [INDEX.md](INDEX.md) lists every painting and studio with its date, round, title and painter.
- `paintings/<id>/` holds one gallery painting. RECORD.md sums it up. Beside it are the brief, the painter's journal, its last reply, given.md (the documents it was given), events.json (the studio viewer's log of its thinking, tool calls and words), its Lua and the runner's sittings record where one exists.
- `studios/<paint-studio-hex>/` holds lane studios that ran without a gallery painting, in the same shape. Studios added from the local archive have a short RECORD.md.
- `docs/` holds every document the painters were given, one file per version, named by content hash.
- `runs/` holds the runner's text records and archived runner PNGs with their rounds. RECORD.md files link to the media with SHA-256 hashes. The text records keep the run tree's relative paths, so the provenance paths in manifest.json point at real files.
- `manifest.json` and `rounds.md` are the site's painting metadata and round captions.

## Archive records

Each painting and studio folder also holds the records imported from the local painting archive:

- `lua/archive/` holds every Lua file the painter wrote.
- `sessions/pi/*.jsonl` holds complete pi session logs. Logs over 50 MB are compressed with zstd (`.jsonl.zst`).
- `sessions/native/` and `sessions/native-text/` hold native sessions stored as text.
- `sessions/viewer/` holds the studio viewer's logs.
- `finals/` holds final images and `video/` holds videos.
- `archive.json` maps each archive path to its file here with its SHA-256.

Existing paths and the site manifest are unchanged. The raw archive stays in private R2 storage with intermediate renders, canvas saves, looks, decoded frames, operational and provenance indexes and binary session databases. Inline base64 images in session logs are replaced with `[image sha256:<hash>, stored in R2 at <archive path>]`, which points at the original log in R2. These images weren't uploaded again.

`export.py` builds the original folders from the studio machine's sources. It copies the manifest's final image and clip, checks the copied hashes and reuses existing media with identical content. A media file over 50 MiB stops the export. It can't rebuild the archive records above.

## What was changed or left out

Local paths, account names, email addresses and private network addresses are replaced with bracketed markers such as `[local path redacted]`. Tokens and opaque provider signatures are removed. Long quotations from published sources are cut to their first ten words and marked `[…]`, with the attribution kept. Where an archive filename contained a private local path, the R2 reference shows a bracketed redaction in its place. The timestamp and session ID in the name still identify the original in R2.

Four paintings were made with a stealth model offered through OpenRouter: r18-bun, r21-frdc1, r21-frdc2 and r21-frdc3, plus the unfinished studio paint-studio-ba1453. Their full records are here like every other painting's, session logs included.

## Credits

The paintings were made by AI models in a simulated oil paint and watercolor studio built by Alice. Some research notes, briefs and review files quote public posts on X by the painter Kendric Tonn ([@kendrictonn](https://x.com/kendrictonn)) about his materials and methods. His words are his own and are quoted here with credit. The CC BY license below doesn't cover them.

## License

Records and texts are under CC BY 4.0 ([LICENSE](LICENSE)). The scripts are under the MIT License ([LICENSE-code](LICENSE-code)). [NOTICE.md](NOTICE.md) covers quotations and the paint engine.
