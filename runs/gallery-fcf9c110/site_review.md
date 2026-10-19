# (•̀ᴗ•́) stillwet: prelaunch review

## First impression — index only, before consulting sources

- **I understand the mechanism.** “Each painting is a program: the model writes the brushstrokes” is the strongest explanation. I read this as AI-written painting instructions executed in simulated paint, not physical canvases or ordinary image generation.
- **I lack the purpose and vocabulary.** “AI models painting like Caspar David Friedrich” assumes I know the artist. “Round” appears before it is explained. “They never see a painting by Friedrich” makes me wonder whether you mean these sessions or the models’ entire training history.
- **I would click** “Watch it being painted” under the winter painting. “The thing about round two is that it almost moved something in me” gives me a human reason to look. “The same picture, twice” is the next strong hook, though I wonder whether this means identical images or similar compositions.
- **I would stop reading closely at** “All paintings, by round.” The chronological restart feels like an experiment log after a curated exhibition. By the round 9 caption, “Round 8 again, with two lines added to the brief,” I would skim thumbnails rather than read captions. The missing rounds 5 and 6 add an unexplained gap.

## Findings, highest impact first

Receipts: `B` = `[local path redacted] `M` = `[local path redacted] `J` = its `manifest.json`; `R` = its `rounds.md`; `A` = `[local path redacted] Other `notes/...` paths are in `[local path redacted] `branch:path:lines` identifies a Git version there. These private receipts are for the owner, not public site copy.

### 1. The site's central claim has a real counterexample

**Exact text:** “No image model, no reference pictures: every picture here is a program, run through a simulation of oil paint.” Also the index description: “Paintings by AI models, each one a program run through a simulation of oil paint.”

**Problem:** The included Python control does **not** use the paint simulation. The index only calls it “a plain Python program as a control,” which does not disclose that exception. This is an easily demonstrated contradiction, not a stylistic quibble.

**Replace:** “AI-written painting programs, mostly run through a simulation of oil paint. One comparison uses a program without the simulation.” In the round 7 caption, use “plus one program without the paint simulation for comparison.” Apply the exception to the lede, footer and social description, not just the control's page.

**Receipt:** `M:136–178`, especially `172`; `J:640–652`. Shared footer: `B:202`; index description: `B:339`.

### 2. Limit the no-reference claim to the actual experiment

**Exact text:** “They never see a painting by Friedrich, only what is written about how he worked.”

**Problem:** The sources describe the painters’ session inputs, not the models’ training histories. “Never” invites a much broader claim about prior exposure. This is a qualification needed for public credibility, not evidence that images were supplied during these sessions.

**Replace:** “During these painting sessions, the models were given written research on Friedrich, not images of his paintings.” For the footer, replace “no reference pictures” with “no Friedrich images supplied during painting.”

**Receipt:** `R:3`; `A:14–15`; `notes/round15/README.md:6–23`. Site text: `B:302`.

### 3. Repair silently joined quotations and incorrect source labels

All eight painter quotations match the JSON. That does **not** make their editing sound: five join separated passages without marking the omission, and three use “the painter, in its notes” for material partly or wholly from elsewhere. These changes preserve the painter's words rather than rewriting them.

| Page | Exact text needing repair → replacement | Original-source receipt |
|---|---|---|
| `r02-winter` | “without a literal road. One small dark figure” → “without a literal road. … One small dark figure” | `notes/amnesia2/fresh2_winter.md:28–38` |
| `r14-p1a` | “the track to the town. The town silhouette” → “the track to the town. … The town silhouette” | `r14a-p1:notes/r14_p1.md:38–40,187–190` |
| `r14-p3` | “then to the glow. The upper sky” → “then to the glow. … The upper sky” | `r14-p3:notes/r14_p3.md:182–198` |
| `r15-p1` | “That vertical link from man to moon replaces any gesture.” → omit this final sentence; introduce the remaining quote with “On the figure:” | `r15-p1:notes/r15_p1.md:29–36`; omitted lines explain the moon's position |
| `r15-p3` | “It is empty in the way his *Monk* and his shore pictures are: the subject is the light and the waiting. They are the verticals that cross the horizon: human work, idle at this hour.” → introduce “On the fishing poles:” and quote only “They are the verticals that cross the horizon: human work, idle at this hour.” | `r15-p3:notes/r15_p3.md:16–30`; “They” refers to poles, not pictures. If retaining *Monk*, render italics rather than asterisks. |
| `r07-3` | “the painter, in its notes” → “the painter, in its code comments” | `r7-arm3:paintings/lua/bodden.lua:168,288` |
| `r10-3` | “the painter, in its notes” → split the prose and poem, labeling the latter “the painter, in its final reply”; restore its four verse lines | `M:283`; `r10-arm3:notes/r10_summer.md:16–19`; final session reply at `2026-09-25T10:08:05.570Z`, line 314 of the session log identified in `J` |
| `r11-flash` | “the painter, in its notes” → “the painter, in its code comments and planning notes” | `r11-flash:paintings/src/bin/r11_winter_flash.rs:14`; `r11-flash:notes/r11_winter_flash.md:9` |

The r02 quotation is supported by the saved notes and `J:152–153`; `M:51` and the JSON remarks are stale when they say it was not collected. Do not remove a verified quotation merely because those inventory notes disagree.

### 4. Round 15's three crescent moons are a source error

**Exact text:** “All three chose dusk or dawn, a crescent moon and a figure from behind”.

**Problem:** The oak painting has an evening star, not a crescent. Both the round summary and the look README repeat the erroneous generalization; the per-painting description and original program contradict it.

**Replace:** “All three chose dusk or dawn and a figure seen from behind.”

**Receipt:** `M:444–451`; `r15-p2:notes/r15_p2.md:13–22`; `r15-p2:paintings/src/bin/r15_p2.rs:1249–1254` draws a single star. Conflicting summaries: `R:31`, `notes/round15/look/README.md:15–19`. Site: `B:73`.

### 5. Gemini's page loses both its unfinished status and the comparison's scope

**Exact text:** “Round 11 · Gemini 3.8 Flash · written as one program · 32 minutes”; “Paradoxically, F [this painting] might be the best one ... in sort of a bad painter way.” Attribution: “Alice, who runs the project, judging blind”.

**Problem:** A direct visitor misses the index's unfinished warning. “Best one” was Alice comparing three round 11 paintings, not judging the entire gallery. Without her stated preference for less digital-looking work, “bad painter” can also sound like a sneer rather than qualified praise.

**Replace/add:** “32-minute session · unfinished: the session ran out of API credits.” Keep the quote verbatim; change its attribution to “Alice, comparing three round 11 paintings without model labels.” Add, if keeping this as a featured quote: “Alice was looking for something less digital-looking, even if imperfect.”

**Receipt:** `M:313–321`; `J:1270–1292`; `A:3–5,223–238`. `B:292–293` only adds the unfinished label for fallback images, which misses this delivered-but-unfinished render.

### 6. Avoid unsupported model supremacy and a mistaken company distinction

**Exact text:** “with the strongest model thinking hard”; “Other companies’ models took the same winter brief”.

**Problem:** “Strongest” has no stated comparison or criterion. Round 10 reused the same model at its high reasoning setting. Round 11 included another Anthropic model, so these were not all other companies.

**Replace:** “using Claude Opus 5.5 with its reasoning effort set to high”; “Three other models took the same winter brief”.

**Receipt:** `notes/round10/README.md:3–11`; `R:23`; `M:277,289–314`. Site: `B:68–69`.

### 7. Keep the twin-picture hook, but don't imply duplication or copying

**Exact text:** “The same picture, twice”; “Two painters, six hours apart; the second never saw the first”; “the third repainted round 14’s shore without seeing it.”

**Problem:** Similar compositions are not identical pictures. “Repainted” suggests deliberate copying; “saw the first” is ambiguous about painter versus painting. Six hours is supported approximately **between session starts**, not finishes. “Twilight” is not an error: the second scene is before sunrise.

**Replace:** “Two painters, a similar scene.” Caption: “Two sessions started about six hours apart. The second painter never saw the first painting. Both chose a Baltic shore with a woman at the water, fishing poles, a boulder and a ship—one at dusk, one before dawn.” Round 15: “the third independently chose a shore scene much like round 14’s.”

**Receipt:** `M:423–430,453–460` (starts 00:31 and 06:29 UTC); `notes/round15/look/README.md:9–19`. Site: `B:35–36,73,321`.

### 8. Give a stranger just enough context, then let the archive be optional

| Exact text | Proposed replacement | Reason / receipt |
|---|---|---|
| “AI models painting like Caspar David Friedrich.” | “AI models writing programs to paint landscapes in the style of Caspar David Friedrich.” | State the activity rather than implying achieved equivalence. `R:3`; `B:301`. |
| “All paintings, by round” | “All experiments” followed by “Each round tries a different setup. Rounds 5 and 6 tested revisions and small studies, so they are not shown here.” | Defines round and explains the gap. Consider putting the archive behind “Browse all experiments.” `R:3,13`. |
| “the timelapses are those looks” | “The videos show the painting previews the model viewed while working.” | More concrete than “looks”; avoids promising a continuous recording of every stroke. `M:18–19,49–50`; `B:302`. |
| “painted live at the easel” | “painted in stages at a virtual easel” | Clarifies that no physical easel or live broadcast is involved. `R:9`; `M:160–167`; `B:226–232`. |
| “blend skies while wet, and bury the feet of things” | “blend the sky while the paint is wet and soften objects’ edges where they meet the ground” | Explains the metaphor. `R:19`. |
| “good entropy, perceived” | Omit this standalone quotation. | Genuine words, but opaque outside the comparison. The winter page already has the stronger emotional quotation. `A:97–99,157–159`. |
| “avoided everything they kept painting” | “avoided the motifs the notes said kept recurring” | The evidence concerns motifs identified in the notebook, not literally everything painted. `notes/round14/README.md:17–21`; `A:292–295`. |

### 9. Apply house style without silently changing quotations or titles

- **“painted a ploughed field”** → **“painted a plowed field”** in the round 14 caption; **“A ploughed field”** → **“A plowed field”** in alt text. **“on a low dyke”** → **“on a low dike”** in round 7 alt text. Receipts: `B:72`; `M:143,397`.
- Keep the original title **“Ploughed field before Greifswald, October morning”** and the mixed title capitalization as authored, or explicitly adopt a display-title policy. They are source spellings, not transcription mistakes (`M:268,393–396`; `J:1634`). Do not quietly “correct” quoted speech.
- **“pagan antiquity, memory, historical time, and mortality”** contains an Oxford comma, but is a faithful quotation. If the no-Oxford-comma rule is absolute, shorten the Gemini quotation to **“Solitary wanderer (Rückenfigur) contemplating the ancient stones in the fading light.”**, with the code-comment attribution. Do not silently remove punctuation inside a purported verbatim quote (`M:320`; `J:1292`).
- Model display names consistently match the manifest (`B:220–223`). Lowercase **“round”** in running prose and capitalize it at the start of headings or standalone labels. Current highlight labels use **“round 2”**, while page facts use **“Round 2”**; choose **“Round 2”** for both (`B:291,320,326`).
- For accessible descriptions, prefer **“near the center”** to **“on the axis”**, **“boulder”** to **“granite erratic”** and **“linden tree”** to **“lime tree”** where they are editorial descriptions, not titles or quotes (`M:164,280,427`). “Bodden” can be glossed as a coastal lagoon beside the title (`M:160–164`).

### 10. Privacy: no direct identifier found in the text; one linkability caveat

The HTML/CSS scan found no real-name occurrence matching the local account name, email address, home path or `file://` link. Public copy uses Alice. The source-path filtering and attribution replacement are visible at `B:206–208,269–274`; these do not constitute a guarantee about media metadata or the eventual hosting configuration.

**Exact source text:** `https://p.mosphere.at/js/pa-8RHNoKMQSCE5QZYjVaL34.js`.

**Problem:** This external analytics hostname is visible in every page's source. It could associate this site with another domain; it does not itself establish a real-name leak. If unlinkability matters, replace the script with no analytics pending a domain-association check, or a reviewed site-specific setup. Receipt: `B:180–185`; built HTML lines 9–14. Do not deploy the private manifests or this review alongside the gallery.

## Accuracy coverage and limits

- **Index:** All 49 card instances match the JSON titles, model labels and source-stripped subject descriptions. Dates and round captions were checked against `R:5–31` and the supplied round READMEs. Exceptions and overstatements are above. The blind AI rankings are supported: all three rank round 2 first and their own fifth or sixth (`notes/round11/blind/key.md:2–15`). This is one six-picture exercise, not a general finding about AI judgment.
- **Human quotations:** The index and selected pages reproduce the documented words, allowing the explicit `[this painting]` clarification and excerpts: winter (`A:98–99,157–159`), Bodden (`154–156`), summer (`198–208,265–270`), Gemini (`223–238`), field (`286–295`), tree studies (`273,280`). The outside reaction's “second one” really is the summer painting. The selected praise is not fabricated, but neither Alice's field reaction nor her Bodden reaction was unqualified approval. For the field, the existing “it's not a Friedrich” qualifier should stay.
- **Nine pages:** Titles, models, methods, durations, alt descriptions and advertised full-size widths match the inventory. Receipts below include the painter words and reception where present. Painter statements about Friedrich's symbolism are verified as the models’ words, not independently established art history.

| Page | Inventory receipt | Duration / full width |
|---|---|---|
| `r02-winter` | `M:44–56`; `J:152–153` for painter words | 54 min / 3200 px |
| `r10-3` | `M:276–286` | 61 min / 3200 px |
| `r07-3` | `M:160–169` | 29 min / 3200 px |
| `r11-flash` | `M:313–321` | 32 min / 3200 px; unfinished |
| `r14-p1a` | `M:393–403` | 63 min / 2400 px |
| `r14-p3` | `M:423–430` | 87 min / 2400 px |
| `r15-p3` | `M:453–460` | 41 min / 2400 px |
| `r15-p1` | `M:435–442` | 49 min / 2400 px |
| `r01-winter` | `M:13–20` | 57-min session; 1000-px fallback, no full-size claim or painter quote |

The 41 minutes for the last shore agrees with the manifest's 06:29:52–07:11:02 timestamps; the look README's 42 minutes is a summary discrepancy, not grounds to change the page (`M:455`; `notes/round15/look/README.md:10`). Label durations as session time, not video length: the first winter's last saved preview predates its session ending (`M:15–18`). This was a text/source review, not a browser, image-content or video-playback review. No site or source edits were made.
