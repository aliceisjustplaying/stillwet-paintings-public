# Deploying stillwet.art

Everything runs from this Mac. Three checkouts sit side by side in `[local path redacted]

- `stillwet/`: this repo, the site's code (`build.py`, `inputs.py`, `deploy.sh`).
- `stillwet-data/`: the site's inputs, a local git repo with no remote: `manifest.json` (every painting),
  `rounds.md` (round captions), `finals/<id>.png` (finished images) and `clips/<id>.mp4` (timelapses).
  Its manifest still holds session-log paths under the home folder: scrub them before it ever gets a remote.
- `claude-paint/`: the painting project; `studio/export_static.py` exports the session viewer.

The session logs themselves are pi's, in `[local path redacted] and each painter's studio is
`[local path redacted]<hex>/`. The studio export and `inputs_extract.py` read them from there.

## Deploy

    ./deploy.sh --dry-run    # build, export, check; list what would change; upload nothing
    ./deploy.sh              # the same, then upload and check the live site
    ./deploy.sh --no-studio  # the gallery only; the live /studio/ stays as it is

`deploy.sh` stops before uploading if an input is missing, if fewer painting pages were built than the
manifest lists, or if any text file in `dist/` contains the home path or the account name. After the
upload it checks that `/`, the newest painting's page, `/studio/` and the studio's painter list answer 200.
The upload is `rsync --delete`: the VPS ends up exactly like `dist/`. Only changed files are sent.

## The studio, every minute

`sync-studio.sh` re-exports the session viewer and uploads only `/studio/` (files only, no rebuild on the VPS;
the exporter refuses anything that names the home folder or account). launchd runs it every minute:
`launchd/install.sh` installs the job, `launchctl bootout gui/$(id -u)/art.stillwet.studio.sync` stops it.
Log: `[local path redacted] It shares a lock (`.studio.lock`) with
`deploy.sh`. The viewer re-reads a painter's events once a minute, so visitors see painters working.

## Add a painting

    uv run add_painting.py r19-lunaf [local path redacted] LUNAF --dry-run   # look first
    uv run add_painting.py r19-lunaf [local path redacted] LUNAF             # add it

It drafts the entry from the run folder (studio, sittings and minutes, sessions, model, thinking, title,
Friedrich or free, the finished image, a clip if `clips/<id>.mp4` exists) and prints the painter's final
replies. Fill in the two TODOs it leaves (`subject`, `painter_words`); `deploy.sh` refuses a manifest with a
TODO. It also says when build.py needs a round caption or a model's display name. By hand, the steps are:


1. **Final image:** the runner's finished render (varnish and cracks), e.g. `run/<LANE>1_finished.png`,
   copied to `../stillwet-data/finals/<id>.png`. Ids are `r<round>-<lane>`, e.g. `r19-kimi`.
2. **Manifest entry** in `../stillwet-data/manifest.json`. Copy a recent entry (e.g. `r18-dsk`) and change:
   `id`, `round`, `date`, `lane`, `title` (from the painter's final reply), `subject` (what the picture
   shows, one sentence; it's the alt text), `painter_model`, `painter_provider`, `thinking`, `session_log`
   (the session files, from `run/<LANE>/p1_sittings.json`), `sittings` and `sitting_minutes` (sittings in
   which the painter worked), `final_file` (`finals/<id>.png`), `final_size`, `painter_words` (one or two
   sentences of its own) with `painter_words_source`, `painter_notes` (the studio's `notes/journal.md`)
   and `clip` (`<id>.mp4`, or null).
3. **A new round:** a caption in `build.py` (`CAPTIONS`), and a chain in `CHAINS` if it's a chain.
   **A new model:** its display name in `model_name()` in `build.py`.
4. **What the painter was given and its journal:** `nice uv run inputs_extract.py <id>` (writes
   `inputs_data/`, commit it here).
5. Commit the data repo, commit this repo, `./deploy.sh --dry-run`, then `./deploy.sh`.

## Make a clip

    [local path redacted] [local path redacted]<hex>/paintings/lua/painting.lua \
        ../stillwet-data/clips/<id>.mp4 --every 60 --pace dynamic --gamma 0.4 --ramp 0.3 --length 20 \
        --open-hold 0.25 --easel <easel>

Replays need the painting's own engine: a build of `claude-paint` at the round's base (rounds 16-18:
`r17-base`, round 19: `r19-base`; `cargo build --release -p easel` there, then `target/release/easel`).
A replay takes 10-60 minutes for a big painting. Then set the entry's `clip` to `<id>.mp4` and deploy.
