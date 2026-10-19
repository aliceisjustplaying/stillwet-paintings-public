# WC2 watercolor: quiet sitting running

Alice authorized launch on October 12. The first successful painter tool read `BRIEF.md` at 21:26:24.840 Stockholm; model and thinking events confirm Opus 5.5 high. `run/first-tool.json` is the proof. The initial host startup exited before provider startup because `run/WC2` was missing; setup and runner now ensure that directory exists and preflight checks it. Only the WC2 service was retried. No stream, public exposure, OYO1/OBS changes or 8765/8766 changes were made.

Studio: `[local path redacted]
Source: clean main `75ff4f292d395df40b1eae9d14da1160a04a8732` in this run's `source/` checkout, including merged guidance #53.
The native Metal binary was freshly built from `0ccc2ce9`, including wash replenishment and OS advisory writer locking. Its watercolor tree is identical at `75ff4f29`; notes were re-exported from that merged commit.

The brief is byte-identical to WC1 after replacing only the studio path. `BRIEF.diff` is against WC1. All 36 pigments remain available and the painter chooses its subject, composition and paper. Opus 5.5 high uses the same frozen house runner and Pi lane as WC1, with its crash and usage-limit handling retained. The host permits one completed sitting. No reader, oil finish, stream, OBS or public exposure is configured.

## Viewer

Private tailnet URL: **http://[tailnet host redacted]/**.
Service: `art.stillwet.studio.wc2`, bound only to `[tailnet IP redacted]`, Gallery default with Color/Gallery/Relief controls.
It has only WC2's session alias. Until launch there is no painter session to display. Offline operator previews are separate from artist state and excluded from session discovery.
The session alias must be `--Users-[local account redacted]-src-a-paint-studio-0ccc2ce9--`; the viewer recognizes hex-only `paint-studio-<hex>` suffixes. The operator corrected the original nonhex alias after launch without touching the painter or studio. Future studio folders should use hex-only suffixes. Preflight requires the viewer running and checks `/api/sessions` for `painter:true` using a temporary, discovery-only session header removed in `finally`; it makes no provider request. Do not run the offline preflight on a live studio.
WC1 services and the public oil funnel are unchanged.

## Launch only after an explicit go

```sh
launchctl bootstrap "gui/$(id -u)" [local path redacted]
```

This loads `art.stillwet.painter.wc2` with RunAtLoad and immediately begins provider requests. Do not run it during preparation. Logs go to `run/runner.WC2.out`, `run/runner.WC2.err`, `run/chains.log` and `run/WC2/`. Confirm the first successful tool and send an addressed notification to the operator after an authorized launch.

To stop only an authorized WC2 painter:

```sh
launchctl bootout "gui/$(id -u)/art.stillwet.painter.wc2"
```

Viewer bootstrap, only when its service is unloaded:

```sh
launchctl bootstrap "gui/$(id -u)" [local path redacted]
```

## Preflight and guidance

`preflight.py` checks the source pin, model/high thinking, one-sitting cap, unchanged brief, pristine real studio, Metal, all 36 pigments, selectable paper, actual house client, lane extension schema and image delivery. It runs native probes only in disposable offline studios and makes no provider request. `preflight.json` records the outcome.

Guidance PR #53 merged during preparation. The watercolor notes were re-exported from `75ff4f29`, the source pin/provenance updated and offline preflight rerun. The brief remains unchanged except for its WC2 studio path. No launch was part of that refresh.

`handoff/prompts/` preserves the frozen first-sitting, later-sitting, usage recovery and limit-probe text, custom system text and prompt/context generators. Runtime UUIDs and future messages are not fabricated. `bin/easel` is the same run-local watercolor shim, with WC2's own call-log path. No monitor baseline, painter output or scratch state was copied from WC1.
