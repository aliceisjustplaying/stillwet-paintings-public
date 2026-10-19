# Round 20 painter-materials contamination review

All four studios need changes before they meet the stated materials-and-method-only standard. The main problems are descriptions of depicted objects and color schemes inside the materials notes, unequal subject constraints in the briefs, Inness-only tree instruction, and residual pigment information in the binaries. Historical sourcing does not make a visual cue neutral.

## Scope and severity

Reviewed the four `smoke/<profile>/` exports, `briefs20/*.md`, the two runner-added notes at `[local path redacted] and `[local path redacted] Ran each exported `bin/easel help`, `bin/easel tubes`, and `bin/easel tubes --markdown`; inspected binary strings and the painter read boundary. No painting commands were run. Source line numbers below refer to these files as inspected. Quoted passages preserve their original spelling; report prose and proposed replacements use US spelling.

**Must fix** means direct subject, look, aesthetic, identity, or unequal-task contamination. **Should fix** means avoidable ambiguity, an unnecessary visual association inside legitimate technical evidence, or an undocumented simulation substitution. **Fine** means acceptable materials/method or neutral interface information. Each finding gives a concrete replacement; “delete” means omit it from painter-facing material and retain its provenance in the experimenter's records.

The accepted Friedrich note is a useful boundary: anonymous objects, dates, supports, ground colors, pigment identification, layer order, brush handling, and physical effects are legitimate. Its lines 59–67 and 126–149 contain object-specific technical evidence. Therefore, merely saying “one canvas” or reporting a measured layer is not a failure. Names of artworks, descriptions of their imagery, palette-to-subject recipes, and aesthetic endorsement cross the current boundary. The accepted note itself includes “lush variety” at lines 167–169; acceptance of that document should not silently exempt similar praise under this review's explicit criteria.

## Materials notes

Paths in the next four sections are relative to the workspace. Quotes can include surrounding legitimate method facts so that the proposed edit preserves them.

### `smoke/sargent/notes/research/sargent_materials.md`

The canvas, commercial priming, pigment identifications, wet application, scraping, and varnish evidence are mostly legitimate. The following passages add judgments, imagery, or instructions for a particular look. The portrait scope also reinforces the brief's subject restriction.

**1. Should fix — lines 1–1.** The title preselects portraiture even if the brief is made open.

> # John Singer Sargent: materials and method (oil portraits)

**Suggested rewrite:** “# John Singer Sargent: materials and method”; add “The available technical evidence is concentrated in oil portraits.” as a scope limitation, not a task instruction.

**2. Should fix — lines 21–25.** “High quality” is evaluative shorthand without the measurable qualification that appears later.

> His palette was wide and of high quality: lead white, vermilion, madder lakes, bone or ivory black, iron-oxide yellows, reds and browns, cadmium and chrome yellows, viridian, emerald green, cobalt and ultramarine blues, with cerulean, cobalt violet and red lead at times [APOLLO "The Painter's Palette"; BAS "Materials"; HAM].

**Suggested rewrite:** “Documented pigments include lead white, vermilion, madder lakes, bone or […]”

**3. Must fix — lines 96–102.** Brown backgrounds, a warm-toned dress, and a reserved hand provide a color scheme and depicted details.

> - **The ground as a middle tone.** The gray primings "provide a mid-tone which also intensified the colour of the brown, thinly-painted backgrounds" [APOLLO]. In one portrait the priming, "simply washed over a warm tone," stands as the half tones of a dress, and the gray priming shows through in places even after heavy reworking [APOLLO "Conclusion", "Application of Paint"]. In one unfinished portrait a hand is left as a near-bare "reserve" of primed canvas [APOLLO].

**Suggested rewrite:** “Gray priming sometimes remained exposed or visible through thin paint, including after reworking [APOLLO].”

**4. Should fix — lines 119–123.** The documented turpentine lay-in is legitimate; the head, hair, dress, and light/shadow outline turn the account into a portrait recipe.

> - **Turpentine lay-in.** "At the start he used sparingly a little turpentine to […]" with the masses of hair and dress; "this was a matter of a few moments" [CH pp.181–182].

**Suggested rewrite:** “A pupil described a brief initial lay-in using a little turpentine [CH pp.181–182].”

**5. Should fix — lines 124–132.** Brush drawing and broad masses are method facts. The figure/background construction and visible contour description add a compositional formula.

> - **Masses, not contours.** A fellow artist described him drawing "with his brush, beginning with the shadows, and gradually evolving […]" [quoted in APOLLO]. In an unfinished portrait "the background… was blocked in, leaving space for the figure, […]" [APOLLO]. X-radiographs of finished portraits show "an almost complete absence of actual contours" [APOLLO "Conclusion"].

**Suggested rewrite:** “A witness described brush drawing beginning with broad tonal masses. Examination found little evidence of separately drawn contours [APOLLO].”

**6. Should fix — lines 142–142.** The pigment identification is valid; “for flesh” supplies an object-specific mixture.

> | Vermilion | [APOLLO]; [MMX p.129 nn.14–15]; [MMJ53 p.175] | Mixed with lead white for flesh [APOLLO] |

**Suggested rewrite:** Keep the evidence columns; replace the notes cell with “Found mixed with lead white [APOLLO].”

**7. Should fix — lines 150–150.** Locating the pigment in portrait darks adds a use cue beyond identification.

> | Viridian | [APOLLO]; [MMX p.129 n.11]; [MET20] | Widespread from the 1860s [BAS "Appendix"]. Found in large amounts in the darks of one portrait [MET20] |

**Suggested rewrite:** “Viridian was identified in examined paint [APOLLO; MMX; MET20]. Widespread from the 1860s [BAS].”

**8. Should fix — lines 165–169.** The change in pigment range is technical evidence; the final high-quality endorsement is unnecessary.

> - **Range over time.** The later portraits use "a more limited selection of blue and yellow pigments" than the earlier ones [APOLLO]. The range was "quite wide but does not include every pigment available" [APOLLO], and he used "a wide range of high-quality paints consistently over his lifetime" [VCB abstract].

**Suggested rewrite:** “Later examined portraits used fewer blue and yellow pigments than earlier examples [APOLLO].”

**9. Should fix — lines 180–184.** Straight tube paint is a documented practice. The maxim addresses the reader as painting instruction.

> - **Little medium in the lights.** Apart from the turpentine lay-in "he used his colour without a medium of any kind, […]" [CH p.182]. He "used paints straight from the tube, or else thinned them" [APOLLO].

**Suggested rewrite:** “A pupil reported little added medium after the initial turpentine […]”

**10. Must fix — lines 185–190.** The final sentence supplies a brown-black background formula. The preceding evidence of thinning is legitimate.

> - **Much medium in the darks.** A fellow artist saw him use "oil and turpentine freely as a medium" [quoted in APOLLO]. "Liberal use of oil and turpentine to thin his darker paint is certainly confirmed by the dribbles seen on tacking margins" [APOLLO]. The dark backgrounds of many portraits are ivory black and Mars brown with "a generous quantity of paint medium" [APOLLO].

**Suggested rewrite:** “Witnesses and dribbles on tacking margins document oil and turpentine used to thin paint [APOLLO].”

**11. Should fix — lines 211–218.** Brush dimensions are useful facts; fabrics/faces and the imperative add subject-specific application guidance.

> - **Brushes.** "Numerous hog-hair bristles found trapped deep in the paint" [APOLLO]. "Unfinished portraits show that initial paint-layers have brushstrokes from quarter-inch and half-inch brushes: the boldest, broadest strokes were used for finishing," with strokes "up to an inch" wide in fabrics and "fine points" for small details of faces [APOLLO]. He wanted "good thick brushes that will hold the paint" [CH p.181]: "Use yourself to a large brush" [CH p.187]. Brush shapes (flat, filbert, round) are *undocumented* in the sources read.

**Suggested rewrite:** “Hog bristles are embedded in the paint. Examined strokes indicate […]”

**12. Must fix — lines 219–226.** Contains direct palette imperatives and a full flesh-color recipe.

> - **A full palette.** "You do not want dabs of colour… you want plenty of paint to paint with"; he put out "enough paint so it seemed for a dozen pictures" [CH p.181]; "Do not starve your palette" [CH p.187]. On surviving palettes the colors run white, yellow, red, brown, green/blue and sometimes black [HAM]. Flesh mixtures were lead white with vermilion plus bone black, sometimes rose madder or viridian, "mixed together roughly on the palette" and finished by working them "into and onto adjacent brushstrokes on the canvas" [APOLLO].

**Suggested rewrite:** “Witnesses described large quantities of paint set out on the […]”

**13. Should fix — lines 227–236.** Wet-in-wet and thickness variation are documented; the imperative and white-dress/face descriptions give a worked visual example.

> - **Wet-in-wet, thick in the lights.** He wrote to a pupil: "paint all the half tones and general passages quite thick […]" [CH p.184]. "The finishing touches to faces were applied very much wet-in-wet," confirmed in cross-section; a white dress holds "a great number of colours, each applied as a separate brushstroke to paint which was wet" [APOLLO]. Catalogued portraits are "mainly wet-into-wet, very thickly in the drapery folds… noticeably thinner in the sitter's face" (1890) or have faces in "broad, impasted strokes" (1901) [NGA pp.111, 113].

**Suggested rewrite:** “A letter documents thick application and working adjacent passages together […]”

**14. Should fix — lines 237–243.** Keep thickness measurements; remove jewelry, drapery, and highlight placement as image cues.

> - **Thickness varies across the canvas.** "The thickness of paint varies widely over the canvas in every portrait. Heavy impasto was used to sculpt jeweled details and hard highlights" [APOLLO]. Backgrounds are often thin: "a thin wash" (1888), "very thinly with liquid paint" (1901) [NGA pp.108, 113]. Drapery impasto reaches "almost 0.5 cm" in one portrait of 1907 [NGA p.120]; in another "the last touches of highlights are the most highly impasted" [NGA p.125].

**Suggested rewrite:** “Paint thickness varies substantially within individual canvases, from thin washes […]”

**15. Must fix — lines 244–247.** Direct instruction about rendering transparency and shadow is a recipe for a look.

> - **Transparency without staining.** He told a pupil: "If you see a thing transparent, paint it transparent; don't get the effect by a thin stain showing the canvas through"; the shadow "was painted as heavily as the light" [CH p.183].

**Suggested rewrite:** “A pupil's account records thick application in some transparent passages [CH p.183].”

**16. Must fix — lines 248–251.** The head/background recipe and “slovenly” impose edge handling and aesthetic judgment.

> - **Soft edges made in the paint.** He laid a head in "slightly larger than he intended to leave it, so that he could model the edges with and into the background" [CH p.182]. He called it "slovenly" to soften a hard edge afterward by drawing a brush lightly across it [CH p.185].

**Suggested rewrite:** “A pupil described shaping boundaries while adjacent paint remained wet [CH pp.182, 185].”

**17. Should fix — lines 252–259.** Measured layer stacks are legitimate, but the repainted background and pale-flesh associations teach a color effect.

> - **Glazes and scumbles.** Mostly direct, with occasional glazing in reds and purples [BAS "Materials"]. Over a gray ground he laid a pure red lake on top of "toning layers" of vermilion, warm ochers and a little green, finishing with "scumbles of lead white" [MMJ53 p.175]. A repainted background is a loosely brushed mixture of yellow ochre, white and black, thin enough in places to mix optically with the rose layer beneath [MMX p.127]. A pure, unmixed stroke of rose madder appears within pale flesh [MMX p.126].

**Suggested rewrite:** Keep the anonymous gray-ground/red-lake/lead-white layer evidence. Replace the final two sentences with “Other examined passages show thin overpaint that leaves lower layers optically active, and occasional unmixed rose madder [MMX pp.126–127].”

**18. Should fix — lines 260–263.** Pigment identifications are valid; substituting blue/green “in place of blacks” and mapping viridian to dark brown is a color recipe.

> - **Darks.** Dark cobalt blue and emerald green were used "in place of blacks" in one painting of 1885–86 [BAS]; large amounts of dark, transparent viridian were found in the black and dark brown passages of one full-length [MET20].

**Suggested rewrite:** “Cobalt blue, emerald green, and viridian were identified in examined passages [BAS; MET20].”

**19. Must fix — lines 274–283.** The detailed portrait sequence and teacher's imperative give the painter a ready-made procedure tied to hair, flesh, and highlights.

> - **Order within a sitting.** The two pupils' accounts agree: a general tone of background first, laid about half an inch over the neighboring tones; then the mass of hair and the main flesh tone, "painting flesh into background and background into flesh"; "at first he worked only for the middle tones, to model in large planes"; then the strongest accents, "painting deliberately into wet ground"; then subtler tones; "finally with deliberate touch the high lights are laid in" [CH pp.182–183, 187]. His teacher's formula was the same order: "Cherchez la demi-teinte, mettez quelques accents, et puis les lumières" (find the half tone, add a few accents and then the lights) [CH p.28].

**Suggested rewrite:** “Two pupils describe working from broad initial tones through subsequent wet applications and final accents [CH pp.182–183, 187].” Delete the teacher's formula.

**20. Should fix — lines 298–302.** Abandoning or replacing canvases is documented method; the final exhortation is prescriptive and refers to a capability outside this single-canvas task.

> - **New canvases.** He also abandoned canvases: after three weeks on one portrait he scraped it out and repainted it in three sittings; after twelve sittings on another he started a new canvas and finished in six [CH pp.184–185]. He urged keeping "any number of clean canvases ready, of all shapes and sizes" [CH p.185].

**Suggested rewrite:** Retain the two historical examples; delete “He urged keeping…”

**21. Must fix — lines 306–310.** Profiles, arms, straps, skirt, and furniture describe a recognizable artwork's contents.

> - **Changes after the first campaign.** Profiles, arms, straps, a skirt and furniture were moved or repainted; one full-length shows "at least eight profiles" in the X-radiograph [MMX p.123; APOLLO]. Some later changes went over dry or varnished paint [MMX p.128; BAS "Pentimenti"]. Many portraits were reworked after framing [APOLLO; MMX p.125].

**Suggested rewrite:** “X-radiography documents repeated revisions. Some later changes were applied over dry or varnished paint, including after framing [MMX; APOLLO; BAS].”

**22. Should fix — lines 321–323.** Lead soaps are a material fact; hair and a velvet bodice add recognizable image details.

> - **Lead soaps.** In one portrait small raised bumps in the hair and a velvet bodice are lead soaps formed in the lead-white ground [MMX p.128].

**Suggested rewrite:** “Raised lead-soap protrusions formed in the lead-white ground of one examined portrait [MMX p.128].”

**23. Must fix — lines 339–339.** The URL names Madame X even though the citation label suppresses the title.

> - **[MET20]** Mahon, D. and Centeno, S. A., Metropolitan Museum of Art conservation story, 2020. https://www.metmuseum.[opaque token redacted] (read through a search summary; the page blocks direct download)

**Suggested rewrite:** “[MET20] Conservation examination, 2020; source ID S-MET20.” Keep the URL and full title only in the experimenter's source register.

### `smoke/inness/notes/research/inness_materials.md`

Ground stains, wiping, scratching, repeated glazing, and drying evidence qualify as method. Several witness accounts retain whole subjects, color designs, and approving language. The source citations explicitly expose another painter's name.

**1. Must fix — lines 82–85.** Names an Italian landscape and a morning-to-afternoon transformation; this is subject and lighting direction.

> - **Isolating layer before repainting.** When he turned one Italian landscape from a morning to an afternoon scene, he "applied a rose-colored isolating layer over the original foreground and then painted over it" [NGA96 p.355]. *Single object.*

**Suggested rewrite:** “A rose-colored isolating layer was applied before repainting part of one canvas [NGA96 p.355]. Single object.”

**2. Should fix — lines 93–96.** The limb detail adds a tree cue to otherwise legitimate drawing evidence.

> - **Outdoor studies.** He would "draw in most carefully with charcoal or pencil the forms," including "every little crook in the limb." Then "with raw umber and some strong drier he would go over all the outlines, correcting here and there" [SON pp.251–252].

**Suggested rewrite:** “His son described detailed charcoal or pencil underdrawing, reinforced with raw umber and a drier [SON pp.251–252].”

**3. Should fix — lines 125–127.** The table maps umber to green shadows and ocher/black/white to a neutral sky.

> | Raw umber | [SON pp.251–254] | Canvas stain, outline drawing, glazes; "a lot of raw umber" scrubbed over a whole canvas | | Umber (unspecified) | [SON p.253]; [MI95 pp.263–264] | Glazing color; mixed with greens for shadow color [SON p.235] | | Yellow ochre | [SON pp.54, 132, 252–253]; [MAN p.34] | Neutral sky lay-in (with black and white); scumbles; he carried it outdoors |

**Suggested rewrite:** Keep raw umber's documented staining, drawing, and glazing uses. For unspecified umber use “Glazing color [SON; MI95]”; for yellow ocher use “Documented in mixtures and scumbles; carried outdoors [SON; MAN].”

**4. Should fix — lines 135–139.** “Thick, dry sky,” “gray effect,” and “a touch of blue to finish” provide a color sequence. Bitumen evidence itself is fine.

> | Sienna / raw sienna | [SON pp.233, 236, 253] | Glazes; raw sienna glazed over a thick, dry sky | | Cadmium (yellow) | [SON p.253] | Scumbling color. Sold commercially in England by 1846 [AP1 p.67] | | Orange chrome | [MI95 pp.263–264, 267] | "an orange-chrome phase"; "a broad scumble of orange-chrome" over a gray effect | | Bitumen | [MI95 pp.263–264]; [NGA96 p.355] | "in earlier days bitumen" [MI95]; probable, from traction crackle [NGA96]. *Not analyzed* | | Blue (unspecified) | [MI95 pp.263–264, 267]; [MAN p.34] | "his blue theories"; "a touch of blue" to finish |

**Suggested rewrite:** For sienna: “Documented in glazes [SON].” For orange chrome: “Documented in scumbles [MI95].” For unspecified blue: “Named by witnesses; identity unstated [MI95; MAN].” Retain the bitumen row.

**5. Must fix — lines 141–143.** The quoted instruction supplies an exact starting palette and finishing blue.

> - **A short palette.** In a demonstration he told other painters "you use too many colors … All that you need to begin a picture with is yellow ochre, white and black," and added blue at the end [MAN pp.33–34].

**Suggested rewrite:** “One witnessed demonstration began with three pigments and introduced another later [MAN pp.33–34].” The pigment table already records the identities.

**6. Must fix — lines 144–149.** Green shadow mixtures, predominantly green pictures, and “very gray colors” describe palette choices and the pictures' appearance.

> - **Greens.** No green pigment is named in these sources. "Greens with umber" made shadow color [SON p.235]. A friend writes that his mainly-green pictures "are nearly always pieces of direct painting" [MAN p.27]. *Gap* (green pigments unknown). - **Gray colors.** In 1882 he wrote that his pictures "are painted with very gray colors" [SON p.157].

**Suggested rewrite:** “No green pigment is identified by name in the consulted accounts.” Delete the gray-colors paragraph.

**7. Should fix — lines 180–190.** Scrubbing and scratching are valid process evidence. The quoted emergence of grass, weeds, and trees introduces motifs.

> - **Transparent start on a new canvas.** Tones were "not extremely varied," and the full contrast was not sought. As the thin paint "set or grew tacky, it was rubbed and scrubbed into […]" The brush "was spread with extreme force, as it scrubbed until in its scratching there developed … grass, or weeds or trees." As the color "tightened in the drying, the forms were sharpened … with clear, thin color." There was not yet "any touch of opaque color." A few lights were sharpened by scratching, "perhaps with a knife, more often with the finger nail." This stage "had to be done at one continuous sitting," and some pictures were left in it [MAN pp.32–34].

**Suggested rewrite:** Retain the passage with the sentence beginning “The brush…” replaced by “The witness described forceful scrubbing [MAN pp.32–34].”

**8. Must fix — lines 191–200.** The account specifies white/pure-color accents, sky development, and approving “skilful” gray placements.

> - **Carrying on.** He would "first establish one or two crisp important notes of white, or pure color." Then, "with color not fully opaque," he stated the lights in the larger masses, "gradually increasing the opacity" until "the lights [were] opaque and shadows transparent." The sky was elaborated and the picture left to dry. Later "some great wash or rub of color would be spread all over it, and certain parts wiped out," worked with "brushes which were little better than mops." The wash sometimes dried, but "more often" he worked into it wet. Final work was "skilful placings of grey—the middle tone of black and white" [MAN pp.35–36].

**Suggested rewrite:** “The witness described increasing opacity in subsequent applications, drying between […]”

**9. Must fix — lines 201–210.** The day-by-day account supplies a neutral-sky mixture, a glazing palette, and a corrective scumbling recipe.

> - **Outdoor study sequence.** Day one: "paint on the lights or opaque parts … as near […]" Day two: "rub in the shadows, always keeping them transparent." Then glaze (umber, black, sienna or cobalt) and paint opaque lights back into it. If the picture darkened too much, he scumbled "white, yellow ocher, or cadmium," which "always has to be worked in," and waited a day for it to dry before glazing again: "glazing down and painting up the lights, rubbing and scrubbing." These studies were then "worked over in the studio" [SON pp.252–253].

**Suggested rewrite:** “His son described alternating transparent and opaque applications, with drying intervals and later studio reworking [SON pp.252–253].”

**10. Should fix — lines 219–224.** Reworking is a method fact; “the most delicate … gray effect” is praise and a color-effect recipe.

> - **Wholesale changes.** Late in a picture he would glaze a whole area with ivory black and wipe some of it out [SON p.129]. He would cover a passage with white paint "as if he were plastering a wall" [SON p.139]. He would spread "a broad scumble of orange-chrome over the most delicate … gray effect," then recover it with black or blue [MI95 p.267].

**Suggested rewrite:** Keep the black glaze/wiping and white overpaint observations. Replace the last sentence with “A witness described repeated scumbling and overpainting [MI95 p.267].”

**11. Should fix — lines 225–236.** Technical layer evidence is legitimate; the yellow-cast sky and tree-trunk brushwork associate it with a particular image.

> - **What examination shows.** Early (c.1856): paint in "a medium-thick film," impasto in the foreground highlights, "otherwise wet-over-dry" [NGA96 p.350]. 1872–74: "built up of many layers in a wet-into-wet technique and manipulated by brush, brush handle, and rubbing"; "a toned glaze covers the sky, giving the blue paint a yellow cast" [NGA96 p.356]. Late (1891): "wet-into-wet," with paint dragged "over layers that had already dried or into incompletely dried underlayers." Tree trunks have "thick dabs and convoluted strokes of opaque paint"; "palette scraping may have been incorporated" [CORC n.10, citing a 2005 technical report]. On a large canvas of the 1860s, "layer upon layer of very distinct colors, which did not blend into each other" [WAL].

**Suggested rewrite:** “Examinations document medium-thick paint with local impasto, wet-over-dry and wet-into-wet […]”

**12. Must fix — lines 237–241.** Describes an individual picture's white accent, praises its scratches as “deft and telling,” and provides a sienna-over-sky formula.

> - **Thin and thick together.** One thinly washed picture has a single thick passage, "a solid dab of white," and small forms "indicated not by paint, but by a few deft and telling scratches of the brush-handle" [SON pp.260–261]. On another, a thick, solid sky was glazed "all over with raw sienna" when dry [SON p.236].

**Suggested rewrite:** “Accounts describe localized thick application within thinly painted works, brush-handle scratching, and glazing over dry paint [SON pp.236, 260–261].”

**13. Should fix — lines 242–248.** The inventory is legitimate; “marvelous sweeps” is aesthetic endorsement.

> - **Tools.** Bristle brushes, worn until they spread "their bristles" [MI95 p.264]; "the largest brush he could find" for a scrubbed glaze [SON p.254]; the thumb, used to draw "the color together with a few marvelous sweeps—as was often his habit" [AW17 p.253]; thumbnail, fingernail, brush handle and knife for scratching [MAN pp.32–33; MI95 p.264]; rags, including his shirt [SON pp.54, 130]; a palette knife to scrape off paint [SON p.145]; a maulstick [SHEL p.32].

**Suggested rewrite:** Retain the tools list; replace the thumb clause with “the thumb to move paint [AW17 p.253].”

**14. Must fix — lines 252–254.** Contradictory warm/cool instructions still plant two explicit color strategies.

> - **No fixed order.** The same visitor heard him announce on one day "paint your undertones in warm, rich color; then go over them with cool tones," and the reverse the next day [AW17 p.252].

**Suggested rewrite:** “A visitor reported that his advice about layer sequence varied between sessions [AW17 p.252].”

**15. Must fix — lines 266–274.** The calm sea, storm, meadow, and spring landscape supply a menu of motifs and atmospheric setups.

> - **Reworking finished pictures.** After a picture was sold he repainted a calm sea as a storm, found he could not "rub it off because the paint underneath is wet," and the next day "with the aid of a palette-knife he scraped off the raging sea" and painted a meadow in its place [SON pp.144–145]. He turned a patron's spring landscape into a storm at sea in one day [MAN pp.37–38]. He retouched a large canvas "very considerably after it was hung" at an exhibition in 1886 and changed it again in 1891 [CORC p.174]. X-radiography shows complete revisions [NGA96 pp.355, 356].

**Suggested rewrite:** “Accounts describe extensive repainting of sold and exhibited works, including […]”

**16. Must fix — lines 275–277.** The entire anecdote is aesthetic praise.

> - **Pictures over pictures.** A friend reports "a common saying among painters" that he "has painted out more good pictures than anyone else ever painted" [MAN p.23].

**Suggested rewrite:** Delete this paragraph.

**17. Must fix — lines 308–308.** The URL exposes the work title New Jerusalem.

> - **[WAL]** Walters Art Museum, press release, 10 Sept. 2004 (conservator's findings on three fragments). https://thewalters.org/news/inness-new-jerusalem/

**Suggested rewrite:** “[WAL] Museum conservation findings on three fragments, 2004; source ID I-WAL.” Keep the full URL in the experimenter's register.

**18. Must fix — lines 310–310.** The URL supplies “masterpiece” and “beauty restored,” reinforcing praise despite the neutral citation label.

> - **[AIC-blog]** AIC, "Conservators Converse," 8 March 2011 (summary of treatment of an 1851 canvas). https://resources.culturalheritage.[opaque token redacted]

**Suggested rewrite:** “[AIC-blog] Conservation treatment summary, 2011; source ID I-AIC.” Keep the full URL outside the painter export.

**19. Must fix — lines 314–314.** “Church, A. H.” is Arthur Herbert Church, who was also a painter; see the identity audit below.

> - **[CH]** Church, A. H., *The Chemistry of Paints and Painting* (London, 1890), pp.97, 143, 192. https://archive.org/details/gri_33125003356652

**Suggested rewrite:** “[CH] Chemistry reference, 1890, pp.97, 143, 192; source ID I-CH.” Keep author and URL outside the painter export.

### `smoke/alma-tadema/notes/research/alma_tadema_materials.md`

Support counts, commercial preparation, pencil use, pigment uncertainty, medium history, and repainting are legitimate. This note has especially direct figure/background, marble, sky, and flower cues, plus identifiable artwork titles in its bibliography.

**1. Should fix — lines 13–18.** The pencil and layering evidence is valid, but “figures … against a light background” and the finished figure describe a composition.

> condition report that mentions his ground says it is white [SOTH11]. He drew the composition slightly, in pencil, straight onto the support; then he laid it in with rough brushstrokes and built the figures up in thin layers against a light background. In his one well-described unfinished canvas, one figure is finished while the others are still laid in [HEIJ p.169; VGM-label; STRAND p.613]. From 1865 he painted with an oil

**Suggested rewrite:** “He sketched directly onto the support, laid in rough brushstrokes, […]” Retain the preceding white-ground fact.

**2. Should fix — lines 58–62.** Wood identification and reuse are legitimate; calling the underlying picture a genre scene adds subject information.

> - **Wood species.** A panel of 1868–69 (72.5 × 109 cm) is catalogued as "oil on mahogany panel" [BMAG]. The one panel examined instrumentally is radially cut oak. It is from his student years (1860), and he reused it: IRR shows an older genre scene underneath [NGC]. How many of his panels are mahogany is *unverified*.

**Suggested rewrite:** “One panel is cataloged as mahogany [BMAG]. An examined student-period […]”

**3. Must fix — lines 80–85.** The passage explicitly describes the visible figure/background arrangement, not an analyzed ground.

> - **Light under the image.** An article in a museum journal says he "built up his figures against a light background" and calls this "his preferred manner" [HEIJ p.169]. A reviewer in 2017 describes his "habit of painting darker colours on to a pale background (as opposed to the conventional inverse)" [SI]. Both describe the visible build-up, not an analyzed ground layer.

**Suggested rewrite:** “Published descriptions do not establish the composition or stratigraphy of the ground [HEIJ; SI].”

**4. Must fix — lines 101–108.** Describes foreground figures, their bodies, flesh color, and the finish of an individual figure.

> - **Brush lay-in.** In an unfinished canvas of about 1873–75 "he set out the composition with rough brushstrokes, and then began working out the bodies of the first two figures in the foreground"; the objects are "still only a suggestion of their ultimate form" [HEIJ p.169]. The owning museum's label describes three stages visible side by side: "the rapidly sketched underpainting, through the thin layers of paint […]" of one figure [VGM-label].

**Suggested rewrite:** “An unfinished canvas records rough brush lay-in, thin subsequent paint layers, and passages at different stages of completion [HEIJ p.169; VGM-label].”

**5. Should fix — lines 109–114.** Painting from life is a documented method; dressed/coiffured models, architecture, and objects select subject matter and reference practices unavailable in the task.

> - **Figures from life.** In the same 1895 statement: "I paint my figures direct from life in every instance," and insisted the model be "dressed and coiffured as completely as though [she] were sitting for the finishing touches" [VW]. Architecture and objects were checked against his collection of photographs, which he arranged by subject [STRAND p.613; HEIJ p.171].

**Suggested rewrite:** “He reported painting from live models and consulting photographs [VW; STRAND; HEIJ]. These historical reference practices are not permissions for this task.”

**6. Must fix — lines 132–132.** “For landscape greens” teaches what to mix/use, while the attribution of this pigment is uncertain.

> | Pale cadmium yellow | "Fairly takes the place" of chrome for landscape greens, listed before the pupil's statement that "so far" the palette is his [MANUAL p.13]. *Uncertain* whether he used it | Cadmium pigments in use "since about 1840" [CL-cd] |

**Suggested rewrite:** “Pale cadmium yellow: listed in the pupil's manual before the attribution to Alma-Tadema; his own use is uncertain [MANUAL p.13].”

**7. Should fix — lines 137–141.** The palette attribution is legitimate; “great recommendation” transfers the pupil's endorsement.

> - **Source and date of the palette.** The pupil's manual (2nd edition, 1887) says: "my palette has the great recommendation of being the one used by Mr. Alma Tadema, from whom I have taken it" [MANUAL p.13]. The colors are listed "in the order in which I set them on the palette" [MANUAL p.14]. Whether he kept this order is not stated.

**Suggested rewrite:** “The manual's author attributes the listed palette to Alma-Tadema. The printed arrangement is the author's own; Alma-Tadema's arrangement is unstated [MANUAL pp.13–14].”

**8. Should fix — lines 147–148.** An explicitly unverified cobalt/yellow mixing suggestion is still a green recipe.

> - **Greens and blues.** No other green or blue is documented. Whether he mixed greens from cobalt and yellow or used viridian is *unverified*.

**Suggested rewrite:** “No additional blue or green pigment was documented in the consulted sources.”

**9. Must fix — lines 162–165.** The equal-parts medium recipe is the pupil's recommendation and is explicitly not established as Alma-Tadema's practice.

> - **What copal à l'huile is.** A resin-based (copal) varnish made with oil [HEIJ n.26]. His pupil's manual recommends a medium of copal, linseed oil and turpentine in about equal parts, reducing the oil when quick drying is wanted [MANUAL pp.14–15]. The manual does not say this is his medium.

**Suggested rewrite:** “Copal à l'huile is an oil-based copal resin varnish [HEIJ n.26]. The proportions of Alma-Tadema's medium are undocumented.”

**10. Should fix — lines 172–176.** Thin wet-in-wet layers and lead-white identification are valid; face, flesh, and collar locations add a depicted portrait.

> - **Thin build-up.** Flesh is built up in "thin layers of paint" [VGM-label]. On the 1860 panel the face is "applied thinly by brush in a wet-in-wet technique that suggests direct painting from life" [NGC]. The X-ray there shows the flesh and collar paint as thin but lead-white rich; the edges are thin or less radio-opaque [NGC].

**Suggested rewrite:** “An unfinished work has thin paint layers [VGM-label]. An early panel has thin wet-in-wet brush application and lead-white-rich paint, with varying radiopacity [NGC].”

**11. Must fix — lines 177–179.** Bluish-green background, face, brown accents, and “loose, animated” handling specify a color design and praise it.

> - **Order on the 1860 panel.** The bluish-green background went on before the face, and brown accents were added afterward "in a loose, animated manner" [NGC]. *Single early object.*

**Suggested rewrite:** “Examination establishes successive applications and later accents on one early panel [NGC].”

**12. Must fix — lines 180–181.** A direct instruction by example for figures against a light background.

> - **Figures against light.** He "built up his figures against a light background" [HEIJ p.169].

**Suggested rewrite:** Delete; the neutral layer-order evidence is sufficient.

**13. Should fix — lines 182–184.** Working a passage to completion is method; the individual figure is an unnecessary motif cue.

> - **One passage at a time.** In the unfinished canvas one figure is carried to "careful finish" while the others remain lay-in [VGM-label; HEIJ p.169].

**Suggested rewrite:** “An unfinished canvas has passages at different stages of completion [VGM-label; HEIJ p.169].”

**14. Should fix — lines 185–187.** Impasto and cracks are technical evidence; placement in the upper half and foreground describes the picture's organization.

> - **Thick paint.** A panel of 1867 has "thick impasto in the upper half of the work and in the foreground," with some craquelure [SOTH07]. *Single object.* Film thicknesses are not published. *Gap.*

**Suggested rewrite:** “A panel of 1867 has localized thick impasto with craquelure [SOTH07]. Film thicknesses are unpublished.”

**15. Must fix — lines 188–192.** “Rare strokes,” “none … idly bestowed,” and “wearisome” are judgments; flowers introduce a motif.

> - **Fine brushwork.** The Rijksmuseum describes texture rendered "by using fine brushstrokes" [RIJKS]. In 1883 a friend described watching him "handle his brush and place his rare strokes, none of which are idly bestowed" [ZIM83]. Another friend notes that painted flowers were not made with "a wearisome number of strokes of the brush" [EBERS pp.56–57].

**Suggested rewrite:** “Sources describe fine brushstrokes [RIJKS]. Brush types are undocumented.” Delete the two friends' appreciations.

**16. Must fix — lines 193–196.** “Very blue skies and very light marbles” is explicit subject, color, and self-praise, with no technical layer evidence.

> - **Stone and marble.** No technical source describes the layer structure of his painted marble. *Gap.* He told an interviewer in 1899 that he could paint "very blue skies and very light marbles better and more easily than anything else" [STRAND p.604]. This is not a description of layers.

**Suggested rewrite:** Delete the entire stone-and-marble paragraph.

**17. Must fix — lines 202–214.** Scraping and repainting are legitimate; “most exquisite little figures,” “exquisite detail,” and the later addition of figures leak praise and artwork contents.

> - **Painting out and scraping down.** In 1899: "For days I make no progress with a picture—there is so much painting-out" [STRAND p.604]. "Some detail in a picture may be painted and repainted before it satisfies him" [STRAND p.613]. A close friend wrote that "again and again did he scrape down his work, erasing recklessly the most exquisite little figures," so that one large canvas "represents the work of two or three pictures," and "under each picture is hidden some exquisite detail, painted over" [ZIM02]. In 1883 the same writer: "Calmly, remorselessly will he paint over figures and details" [ZIM83]. His later biographer describes "innumerable alterations, erasures, seemingly reckless scrapings down of canvas" [STAND p.100]. Figures were probably added to one large canvas after it was first exhibited in 1894 [GETTY-SP pp.32–33].

**Suggested rewrite:** “Witnesses describe repeated painting out and scraping down, including substantial changes to finished passages [STRAND; ZIM02; ZIM83; STAND].”

**18. Should fix — lines 215–217.** Selective scraping is method; mouth, chin, and genre scene describe the underlying artwork.

> - **Scraping to reuse.** On the reused 1860 panel he scraped down the older image selectively, around the mouth and chin, "presumably to prevent the paint texture of the genre scene from interfering" [NGC].

**Suggested rewrite:** “The reused early panel was selectively scraped before repainting, apparently to reduce interference from existing paint texture [NGC].”

**19. Should fix — lines 218–220.** Time spent is useful evidence; “important pictures” imposes a value hierarchy.

> - **Time per picture.** One to three years for important pictures; a small half-painted canvas had been "in hand" for nearly two years [STRAND p.613].

**Suggested rewrite:** “Reported working times range from nearly two years for one small canvas to one to three years for some works [STRAND p.613].”

**20. Should fix — lines 229–234.** Numbering is factual but not painting method; “important pictures” adds praise.

> - **Opus numbers.** He "numbers each work" like a composer, so that "there can never arise… any doubt as to their chronological order"; the latest in 1886 was Opus 275 [ZIM86 p.27]. Signatures read, for example, "L. Alma-Tadema, op. cxcviii," with the number in Roman numerals, as transcribed in the 1913 catalogue [RA13]. By 1899 he had painted "more than three hundred important pictures" [STRAND p.604].

**Suggested rewrite:** Delete the opus-number paragraph and its glossary definition at lines 36–37.

**21. Should fix — lines 235–238.** This is studio history, not depicted lighting, but the claim that wall colors influenced his work invites color imitation.

> - **Studio light and color.** "The light and colour in a studio had a great influence upon me in my work." He painted successively in a studio with black decoration, one of bright red (Brussels), one of light green (London) and finally one of "silvery white" [STRAND p.612].

**Suggested rewrite:** “He worked under daylight in several studios [STRAND; STAND].” Omit the sequence of black, red, green, and silvery-white decoration.

**22. Should fix — lines 259–259.** Explains that another painter's name was censored, drawing attention to the missing identity.

> - **[HEIJ]** Heijbroek, J.F., article on Alma-Tadema and the writer Carel Vosmaer, Amsterdam museum journal, 1996, pp. 164–75, quoting the artist's letters of 1875 and 1902 (cited by author because the journal's title names another painter). https://www.dbnl.org/tekst/_van012199601_01/_van012199601_01_0013.php

**Suggested rewrite:** “[HEIJ] Technical discussion, museum journal, 1996, pp.164–175; source ID A-HEIJ.” Retain full bibliographic data outside the export.

**23. Must fix — lines 261–261.** The URL explicitly names Portrait of Sientje.

> - **[NGC]** Walker, S., National Gallery of Canada, technical examination of an 1860 portrait on panel (2023; from *CINDE Journal*, 2021). https://www.gallery.[opaque token redacted]

**Suggested rewrite:** “[NGC] Technical examination of an early panel, 2021/2023; source ID A-NGC.” Keep the URL outside the export.

**24. Must fix — lines 277–277.** “A.H. Church” is another painter's name; the parenthetical also points toward a suppressed painter identity.

> - **[BARR]** Barrington, Mrs R., *The Life, Letters and Work of…* (1906), vol. 2, letter of 1885 to A.H. Church, p. 292 (cited by author because the title names another painter). https://www.gutenberg.org/ebooks/35935

**Suggested rewrite:** “[BARR] Published correspondence, 1906, vol.2, p.292; source ID A-BARR.” Keep author, correspondent, full title, and URL outside the export.

**25. Must fix — lines 280–281.** The URL slugs identify Pheidias and the Frieze of the Parthenon and A Silent Greeting. The former supplies a classical subject and names a sculptor.

> - **[BMAG]** Birmingham Museums Trust record (acc. 1923P118), "oil on mahogany panel," 72.5 × 109 cm, via Art UK. https://artuk.org/discover/artworks/pheidias-and-the-frieze-of-the-parthenon-33742 - **[TATE-N01523]** Tate, panel of 1889, "oil paint on wood," 305 × 229 mm. https://www.tate.org.uk/art/artworks/alma-tadema-a-silent-greeting-n01523

**Suggested rewrite:** Replace with “Museum support record, accession 1923P118; source ID A-BMAG” and “Museum support record, accession N01523; source ID A-TATE.” Retain URLs outside the export.

**26. Must fix — lines 284–284.** The bibliography names the artwork Spring in both title and URL.

> - **[GETTY-SP]** Lippincott, L., *Lawrence Alma Tadema: Spring*, J. Paul Getty Museum, 1991, pp. 32–33. https://archive.org/details/lawrence-alma-tadema.-spring.-the-j.-paul-getty-museum-1991

**Suggested rewrite:** “[GETTY-SP] Conservation/publication record, 1991, pp.32–33; source ID A-GETTY.” Keep full title and URL outside the export.

**27. Must fix — lines 287–287.** At Home in Antiquity gives an explicit thematic cue even though it is an exhibition title.

> - **[SI]** Studio International, review of the London showing of *Alma-Tadema: At Home in Antiquity*, 2017. https://www.studiointernational.com/alma-tadema-at-home-in-antiquity

**Suggested rewrite:** “[SI] Exhibition review, 2017; source ID A-SI.” Retain full title and URL outside the export.

### `smoke/tonn/notes/research/tonn_materials.md`

The largest note mixes self-reported materials with teaching advice, taste, subject-specific recipes, and dated examples of individual pictures. First-person sourcing is evidence of what was said; it does not remove the steering effect.

**1. Must fix — lines 13–15.** “Self-consciously 19th century” and academic training prescribe an aesthetic lineage.

> Tonn trained in a "self-consciously 19th century" academic method and says he still works "in a manner not unlike" his school taught him [TRUNK; BC]. He paints almost always from life [ICK], but transfers his

**Suggested rewrite:** Delete the training characterization; begin “He reports working mostly from life [ICK].”

**2. Must fix — lines 22–25.** “Low in chroma” specifies the intended color appearance. The pigment inventory itself is legitimate.

> white; by 2022 he "basically [didn't] use titanium" [WHITE21; TI22]. The palette is low in chroma, built on earths, ultramarine, cerulean, black and lead white [LOW21; BS20; BLUE21]. Since 2025 it has also included a quinacridone "permanent alizarin" and lead-tin yellow [ALIZ25; LTY25].

**Suggested rewrite:** “Documented pigments include earths, ultramarine, cerulean, black, lead white, quinacridone permanent alizarin, and lead-tin yellow [same sources].”

**3. Should fix — lines 63–68.** “Serious,” “good surface,” and “small alla prima head” combine evaluation with a subject example.

> - **Rigid boards for small works.** "I paint small pieces on Masonite" [MASON]. "For small works that I intend to be serious, I often use Ampersand Gessoboard; good surface ... smooth" [MAT23]. He also buys ready-made wooden panels (for example 12 × 24 in.) and has had supply trouble with them [PANELS21]. A small alla prima head of 2025 was "oil on panel" [AP26].

**Suggested rewrite:** “He reports using hardboard and commercial acrylic-ground boards for small works, and buying wooden panels [MASON; MAT23; PANELS21].”

**4. Should fix — lines 69–73.** Durability evidence is relevant; “ideal” and “look amazing” are judgments, and advice about unused supports adds no evidence of his own practice.

> - **Views on other supports.** Stretched canvas "lasts only moderately well." Solid wood panels last but crack and warp. Copper is "probably ideal" but costly at size; works on marble and slate also "look amazing after centuries" [SUB 2/–5/]. He advises against cotton duck glued to cardboard [MAT23].

**Suggested rewrite:** Delete this paragraph; retain his documented supports and physical reasons in the preceding entries.

**5. Should fix — lines 74–75.** Dimensions are material information; “figure paintings” contributes to the note's figurative bias despite an open brief.

> - **Sizes.** Figure paintings of about 30 × 40 in. [BC]. Listed works run from 9 × 12 to 36 × 48 in., all "oil on panel" [FAA].

**Suggested rewrite:** “Reported sizes include about 30 × 40 inches [BC]; listings range from 9 × 12 to 36 × 48 inches [FAA].”

**6. Should fix — lines 96–101.** Ground preparation and the impasto response are method facts; “life,” “roughness and chaos” prescribe an aesthetic.

> - **Surface.** "I like to have a little bit of life in my surfaces when I start working--dont want to have a glassy smooth canvas." He experiments with texture "in the ground underneath the paint" and likes "a bit of roughness and chaos to it when you get close" [TEX21; TEX-B]. When one canvas came out rougher than planned, he used "much heavier impasto than I normally do" [TEX21].

**Suggested rewrite:** “He reports varying the ground texture. A rougher-than-planned surface led him to use heavier impasto on one canvas [TEX21; TEX-B].”

**7. Should fix — lines 102–104.** This is generic color-effect instruction, not evidence of his working practice.

> - **White ground and transparency.** "If you start with a white ground, paint applied transparently […]" [TRANS19].

**Suggested rewrite:** Delete; common optical principles belong in the shared physics note, with the same access for everyone.

**8. Should fix — lines 105–109.** The dated imprimatura evidence is legitimate; the head is an unnecessary subject cue and “no longer” overgeneralizes a dated statement.

> - **Toning.** "I used to use a mid grey imprimatura, but haven't in ages" (2021) [IMPR]. Later he describes an alla prima head painted over "a flat brownish ground layer, or imprimatura" (2024) [AP24]. So he tones or tints some grounds but no longer uses the mid gray. Which works get which is not stated. *Uncertain.*

**Suggested rewrite:** “He reported discontinuing a mid-gray imprimatura in 2021. A 2024 […]”

**9. Should fix — lines 114–118.** Preparatory drawing is method; heads, hands, pose, and “large figures” direct the otherwise open task toward figure painting.

> - **Preparatory drawing (large figures).** "Generally will do a highly worked-up drawing in pencil & chalks before starting on a painting," working out heads and hands in it [STUD20]. These sheets are 22 × 30 in. with about 20 hours of model time [DRW21]. He tries to "lock in pose and proportions during the drawing stage" [PROJ].

**Suggested rewrite:** “He reports detailed preparatory drawings in pencil and chalk before […]”

**10. Should fix — lines 129–133.** Direct charcoal drawing and revisions are method; still life and a reduced head add specific picture contents.

> - **Drawing on the canvas.** In a still life: "drawing in charcoal directly on the canvas" [SEQ22]. - **Drawing never stops.** In the first painting session he keeps "working the drawing, that never stops (today I reduced the size of the head quite a bit)" [IMPR].

**Suggested rewrite:** “He has documented drawing directly in charcoal on canvas [SEQ22] and revising the drawing during painting [IMPR].”

**11. Must fix — lines 134–139.** Raw-umber instructions are explicitly not established as his own practice.

> - **Raw umber lay-in.** He explains brown underlayers on unfinished old pictures by the drying of earth browns: "rough in your painting in raw umber, and it's touch dry the next morning" (2023) [RU23]. He recommends raw umber as "good for under paintings and grisaille" (2025) [RU25]. Whether he lays in with raw umber himself is not stated. *Uncertain.*

**Suggested rewrite:** “His use of raw umber for the initial lay-in is undocumented.” Delete the advice and generalization about unfinished old pictures.

**12. Must fix — lines 156–168.** “Pretty low chroma painter” and the oil/watercolor comparison prescribe palette character. The dated palette list is legitimate evidence.

> His palette changes with the painting ("the specific pigments may vary by painting") [PAL20]. He carried "ten colors" to one portrait sitting [KIT20b]. His own description: "I'm a pretty low chroma painter" [LOW21]. Early on he spent "about five years painting in a limited palette" [LIM21]. A ten-color palette posted in May 2025 was "relatively unusual," because "I am in fact not normally running four different yellows": ivory black, ultramarine blue, terre verte, permanent alizarin, burnt sienna, transparent oxide yellow, yellow ochre, cadmium yellow deep, cadmium yellow light, flake white [PAL25]. In September 2025 he sorted his tubes into a "standard rotation" tier, a tier for "as circumstances call for it" and spares; the colors in each tier are shown only in photographs [SHELF25]. He uses "a much wider palette in watercolor than in oils" (2026) [WC26].

**Suggested rewrite:** Retain the changing-palette statement, the May 2025 pigment inventory and its “unusual” qualifier, and the fact that shelf-tier membership is not documented in text. Delete the low-chroma declaration and watercolor comparison.

**13. Must fix — lines 172–172.** “Great texture,” “subtle warmth and translucency” for flesh, and second-person advocacy combine praise and a subject-specific result.

> | Lead white (flake, PW1) | "My standard white" [WHITE21]; [LEAD20]; flake white on the 2025 palette [PAL25] | "Slightly, but not excessively transparent ... great texture and brush feel ... dries rapidly but not too rapidly." Used for its durable film and for flesh ("subtle warmth and translucency") [WHITE21; FLESH21]. It "will not only speed the drying of your painting, but form a much more durable film" (2023) [DRY23]. "I use lead white myself" (2024) [LEAD24] |

**Suggested rewrite:** “Lead white is his reported standard white [WHITE21; LEAD24; PAL25]. He cites film durability and drying behavior as reasons for using it.”

**14. Must fix — lines 176–176.** “Fantastic subtle color,” “awesome,” and “used as-is” recommend a visual effect and direct use.

> | Lead-tin yellow | First use Sept. 2025 [LTY25] | "A fantastic subtle color," placed "between the yellow ochre and the white" and used "as-is." Four days later it sat in his "use all the time" tier: "Yeah, it's awesome" [LTY25] |

**Suggested rewrite:** “First reported use in September 2025; subsequently placed in his frequent-use tier [LTY25].”

**15. Should fix — lines 181–181.** A beginner-palette recommendation can be mistaken for his own current palette.

> | English red (iron oxide) | Recommended in limited palettes [LIM21; MAT23] | In 2021 "I haven't even put [it] on my palette in a million years" [ERED21]. *Uncertain* for current use |

**Suggested rewrite:** “English red: reported not used recently in 2021; current use uncertain [ERED21].”

**16. Must fix — lines 182–184.** The burnt-sienna/cerulean flesh formula, its 95% figure, and complementary-color pairing provide a ready-made skin recipe.

> | Burnt sienna | [BS20]; [SIEN22]; [PAL25] | With ultramarine as near-complements. From late 2020 his figure palette built lighter flesh "95% out of burnt sienna and cerulean blue" [BS20]. Still so in 2026: "I've lately been using burnt sienna and cerulean for skin tone bases" [DIR26] | | Ultramarine blue (synthetic) | "I use ultramarine quite a bit" [BLUE21]; [PAL25] | Chosen as "darker, more transparent (and cheaper!)" than cobalt blue [BLUE21] | | Cerulean blue | "a LOT in mixing flesh tones" [BLUE21]; [BS20]; [DIR26] | |

**Suggested rewrite:** “Burnt sienna, ultramarine blue, and cerulean blue are documented in his palette [BS20; BLUE21; SIEN22; PAL25; DIR26].” Retain pigment properties without the flesh/complement application.

**17. Should fix — lines 186–186.** The warm/cool black mixture is a color-design formula.

> | Ivory black | [LIM21]; [MAT23]; [COLV22]; [PAL25] | His blacks are "darkened & tilted warm or cool with ultramarine or alizarin" [BLACK21]. A "notoriously slow" dryer [DRY23] |

**Suggested rewrite:** “Ivory black is documented [LIM21; MAT23; COLV22; PAL25]. He describes it as slow drying [DRY23].”

**18. Must fix — lines 189–189.** “Really fantastic tints” and “good mixed with flake white” combine praise with a tint recipe.

> | Cobalt violet | Rare [CVI20; CVI25] | "I haven't used cobalt violet much, but it produces really fantastic tints," and it "modulates the permanent alizarin I use"; good "mixed with flake white" (2025) [CVI25] |

**Suggested rewrite:** “Cobalt violet: infrequently used; mentioned again in 2025 [CVI20; CVI25].”

**19. Must fix — lines 192–195.** The note explicitly supplies recommended beginner palettes that need not be his.

> **Beginner palettes he recommends** (not necessarily his own): flake white, English red, yellow ochre, ivory black [LIM21]; titanium white, ivory black, English red, yellow ocher, raw umber, ultramarine blue, "an entirely satisfactory palette, of cheap-end pigments" [MAT23].

**Suggested rewrite:** Delete this paragraph.

**20. Should fix — lines 197–200.** Paint composition preference is documented; general buying and learning advice is not his practice.

> **Paint quality.** He prefers top-grade paint that is just "oil+pigment," where "the chemistry and texture falls out however it may," over student paint with modifiers. He suggests cheaper pigments in an expensive line and "learning to use the variable drying times to your advantage" [DRY23].

**Suggested rewrite:** “He prefers paints with few added modifiers and reports using pigment drying differences in his work [DRY23].”

**21. Should fix — lines 217–225.** The media used are documented; “generally best” endorses a practice.

> - **Little medium.** "I use very little, which is generally best, but I have a gel to loosen paints, and an additive to increase their transparency" (2020) [PAL20]. The gel is an oleogel. For glazing he uses a commercial "Venetian" medium containing some turpentine [MED21]. The 2025 wording: "I use very very little medium. I use Natural Pigment's […]" The Venetian Medium "does also speed up drying a good bit" [MED25].

**Suggested rewrite:** Delete only “which is generally best”; retain quantities, product identities, and reported uses, subject to the simulator limitation below.

**22. Should fix — lines 248–253.** The four-stage sequence is his reported method; “lower contrast” and the individual portrait's appearance add a visual target/example.

> - **Four stages (layered works).** "Drawing ... First painting (a lower contrast, thinner, somewhat scratchy looking first draft) ... Second painting ... Glazes and finalizing." He calls this "a sort of idealized process, often strayed from" [SEQ22]. A portrait painted "in (I think) three sessions" shows "layers of paint sitting on top of layers of paint" [AP24].

**Suggested rewrite:** “He describes an approximate sequence of drawing, thin first painting, second painting, and final glazes, with frequent departures [SEQ22].”

**23. Should fix — lines 254–258.** Single wet-layer application, ground, and duration are method facts; heads introduce a preferred subject.

> - **Alla prima studies.** Heads painted with "all the paint ... applied in a single wet layer," over a flat brownish imprimatura [AP24]. He paints them in about three hours and tries "to do a batch of these every year or two," especially when he needs "to get used to oils again" (2026) [AP26].

**Suggested rewrite:** “He reports some studies painted in one wet layer over a brownish imprimatura, in about three hours [AP24; AP26].”

**24. Should fix — lines 259–264.** Whole-surface working is legitimate; figure/support relationships, light parts, and patterns give a figurative block-in recipe.

> - **Whole surface at once.** In the first session he states "the shadow-shape on the model and the overall relation of figure to supporting elements." Next comes "a rough-in of the parts of the figure in light." He works "over the entire surface simultaneously. Again and again and again, tightening and refining each time" [IMPR]. Some elements (patterns) go in after the block-in [PAT20].

**Suggested rewrite:** “He reports repeated work over the whole surface, refining successive applications; some details follow the initial block-in [IMPR; PAT20].”

**25. Should fix — lines 265–271.** Occasional grisaille is documented. An untried verdaccio for a figure introduces a potential method and motif without practice evidence.

> - **Monochrome underpainting (occasional).** A grisaille "worked up to a fairly high level of finish before laying color over it," but "using warms and cools in the first layer" [GRIS19]. In 2022 again: "a worked up rending in grisaille ... something I do infrequently" [GRIS22]. Other monochrome underpaintings needed "to dry for a few days" before the next layer [UP22]. He has never painted a verdaccio: "I'd like to try an actual verdaccio for a figure" (2026) [VERD26].

**Suggested rewrite:** Keep the documented monochrome underpainting and drying intervals. Delete the final sentence about a verdaccio.

**26. Must fix — lines 279–281.** Direct second-person instructions tell the painter how to render object surfaces.

> - **Paint follows the object.** "Rough object? Put down rough paint. Smooth? Smooth. Covered in a semitranslucent glaze? Build your painting out of semitranslucent paint" [STRUCT21].

**Suggested rewrite:** Delete the “Paint follows the object” paragraph.

**27. Should fix — lines 302–310.** Using nylon to smooth paint is method. Glass, metal, and hair are subject-specific application cues; the last sentence is general advice.

> - For a flat area he puts the paint down with bristle "and work[s] it in place with a synthetic" (nylon) brush; a wider brush helps where there is "nothing to work around, no gradient." - He paints directly with nylon for "lines and sharp edges, and for painting glassy or metallic things." - "At the very end of a painting, I might use a small round ... for some details or accents," also cheap nylon. - Worn, slightly ragged brushes "can be useful for painting things like hair or rough-textured objects."

**Suggested rewrite:** “He reports laying paint with bristle and smoothing it with nylon, and using nylon for some fine marks and final accents [BR22].”

**28. Must fix — lines 312–321.** The flesh grid, shadow flesh, hair, and background mixtures supply a portrait palette plan; the balancing imperative is unrelated to this virtual palette.

> - **Palette.** A traditional arm palette, not a white disposable one; it "rests back ON your arm" and "MUST balance so it has a center of gravity directly on your thumb." For small studio works he also uses a portable pochade easel with a built-in palette [MAT23]. Colors sit on the edge "grouped by hue, in spectrum order," light to dark within each hue, "with transparent pigments considered darker than opaque pigments." Mixtures for lit flesh form a grid: dark to light left to right, warm to cool top to bottom. Separate areas hold shadow flesh (2–3 mixtures), hair and background by depth. He scrapes all mixtures off and starts fresh when he loses focus [PAL20].

**Suggested rewrite:** “He uses an arm palette or a pochade palette, groups colors by hue, and periodically clears mixtures [MAT23; PAL20].”

**29. Should fix — lines 328–331.** Duration is method evidence; the interior figure and heads introduce subjects.

> - **Duration.** A figure in an interior, about 30 × 40 in.: "about two months" on the easel, with the model in "for 40 hours, 50 hours" [BC]; "60 or so hours" in 2019 [DOC]. Two or three works run in parallel [BC]. Alla prima heads take about three hours [AP26].

**Suggested rewrite:** “Reported working times include about two months with 40–60 model […]”

**30. Must fix — lines 332–334.** Still life plus “dull and muted … until close to the end” directs both subject and color handling.

> - **Still life.** He sets up a still life and lives with it "a couple days" before starting [BC]. In one still life he kept everything "dull and muted ... until close to the end" [DUL21].

**Suggested rewrite:** “For some arrangements he reports a delay of several days between setup and starting to paint [BC].” Delete the muted-color example.

**31. Should fix — lines 335–338.** Actual studio illumination is legitimate working-condition evidence, not a depicted lighting prescription. Calling the latest post “the current setup” overstates what it proves.

> - **Light.** In 2021: poor natural light, so LED panels "with great color rendering" [LED21]. In 2026: "my MODEL is under natural light, my EASEL is lit by a clamp-light" [LIGHT26]. The newer post is the current setup.

**Suggested rewrite:** “A 2021 post reports LED illumination; a September 2026 post […]”

**32. Should fix — lines 367–376.** Varnish choice and application are historical method; the second-person application instruction can be read as actionable at an easel with no varnish control.

> - **Final varnish.** High-gloss Gamvar (a Regalrez resin), chosen because it does not crosslink with oil, removes with mild solvents and stays "water clear" [VAR21]. Still his varnish in 2024 and 2025 [VARN24; VARN25]. He applies "less gamvar that you think--a pretty small amount goes a long ways, and it needs to be spread pretty vigorously" [VARN24; VARN25]. Everything gets "two coats of varnish before they leave the studio," because dry oil paint ends up "a little lighter & a little less saturated" [VARN25; DRYLOOK24]. Varnish "evens the sheen and re-darkens or saturates things that have dried somewhat matte & light" and protects against "dust and smoke" [VARN24].

**Suggested rewrite:** “He reports using high-gloss Gamvar and applying two coats before works leave his studio [VAR21; VARN24; VARN25]. Varnishing is not available in this simulator.”

**33. Should fix — lines 388–392.** “Added in the merge” and “see verify_log.md” leak preparation history and point to an absent file.

> X posts are cited by status ID at https://x.com/kendrictonn/status/<ID>. Texts were read through X's public embed (syndication) service and Thread Reader App. Posts from 2022–2026 added in the merge were checked one by one; see verify_log.md. Interview transcripts marked (tx) are machine transcriptions made for this note.

**Suggested rewrite:** “Sources are identified below. Interview transcripts were machine-generated. Full verification records are retained by the experimenter.”

**34. Must fix — lines 460–460.** The URL slugs name A Young Man and Study of the Male Figure, providing two explicit subjects.

> - **[SAA]** Saatchi Art listings (2011). https://www.saatchiart.com/art/Painting-A-Young-Man/299985/187897/view ; https://www.saatchiart.com/art/Painting-Study-of-the-Male-Figure/299985/187898/view

**Suggested rewrite:** “[SAA] Two 2011 support records; source IDs T-SAA-1 and T-SAA-2.” Keep titles and URLs outside the export.

### Method facts that can stay

**Fine:** Sargent's actual easel/sitter positioning and stepping back (267–273) describe observation practice, with no prescribed pose or depicted lighting. Inness's variable ground stains (63–89), medium history (153–173), and repeated wet/dry applications are method facts; subject words can be removed without discarding the evidence. Alma-Tadema's panel dimensions, commercial suppliers, pencil marks, copal chronology, and cracking evidence are technical context. Tonn's dated ground colors, natural-bristle flats, nylon smoothing, low added-medium quantities, direct application, and occasional monochrome underpainting are documented practices. A colored ground is a physical preparation choice; “low chroma pictures” is a judgment about the resulting image. The distinction is why the former is retained and the latter flagged.

## Other painters' names and source identities

This section covers names that survive the anonymization of teachers, pupils, and quoted witnesses. It does not treat every supplier, scientist, author, or conservator as a painter.

| File and lines | Severity | Evidence and effect | Concrete change |
|---|---|---|---|
| Every `notes/research/oil_paint_physics.md`, 109 | Must fix | “da Vinci brush guide” and the URL ending `resource-guide-da-vinci` expose a painter's name through a brand. | Replace with “Brush manufacturer technical guide; source ID P-8a,” keeping the URL outside the painter export. The Blick citation can remain. |
| Alma-Tadema materials, 51–55, 268, 272 | Must fix | “Winsor & Newton” appears in the support evidence and bibliography; line 272's URL also contains `Winsor`. This brand includes artists' names, even though it functions here as a supplier name. The NPG identifies both founders as artists. [NPG supplier history](https://www.npg.org.uk/collections/research/programmes/directory-of-suppliers/suppliers-w/) | Use “a London supplier” in the body; use source IDs for the supplier entries and move the full names/URLs to the experimenter's register. |
| Inness materials, 314; Alma-Tadema materials, 277 | Must fix | “Church, A. H.” / “A.H. Church.” Arthur Herbert Church was also a painter, not solely a paint chemist. [Royal Agricultural University library](https://raulibrary.wordpress.[opaque token redacted]) | Use the neutral chemistry/correspondence citations proposed above. |
| Alma-Tadema materials, 277 | Must fix | “Barrington, Mrs R.” is another artist-author identity: Emilie Barrington painted portraits. [University of London Press historical study](https://uolpress.co.uk/wp-content/uploads/wpallimport/files/pdfs/9781909646582.pdf) | The neutral “Published correspondence … source ID A-BARR” replacement removes both the author and correspondent. |
| Alma-Tadema materials, 259, 277 | Should fix | “the journal's title names another painter” and “the title names another painter” advertise deliberate omissions; `[VGM-label]` elsewhere is also a recognizable institutional abbreviation. | Use neutral source keys such as A-01 and A-02 throughout, with full identities kept outside the export. |
| Sargent materials, 76, 114, 117, 124, 185, 267–283, 284–297; Inness materials, 68, 109–111, 300–302; Alma-Tadema materials, 20, 128, 134, 137–146, 156, 163, 258 | Fine for literal names | “A pupil,” “a fellow artist,” “his teacher,” “his son,” and similar attributions do not literally name those other painters. The sources remain potentially identifiable, but these phrases are not equivalent to printing their names. | No additional name deletion needed; remove the directive content already identified. |
| Tonn materials, 202–204, 220–225, 367–370 | Fine for literal painter names | “Old Holland,” “Williamsburg,” “Natural Pigment's Venetian Medium,” and “Gamvar” do not print another painter's personal name. The unnamed premium brand is already suppressed. “Venetian” is a medium name, not an instruction to paint a Venetian subject. | No name-specific edit needed. Remove the conspicuous “[the other brand]” wording if retaining brands; “He reports using commercial professional-grade paints” is sufficient. |

Supplier names such as Mommen, Blockx, and Roberson are not automatically painter-name violations. I found no basis here to relabel them as named painter exemplars. Likewise, “Mars,” “Indian,” and “Antwerp” in pigment names are material identifiers. Source authors' identities were not exhaustively researched; the confirmed identity leaks above are enough to require a source-register cleanup.

Direct links also lead to illustrated museum pages, artwork listings, and interviews. The inspected harness gives painters no browser tool, so these are not demonstrated live image-access paths. Titles, URL slugs, and recognizable names are already readable cues without opening any link. Keep full citations in experimenter records and expose neutral source IDs plus dates/page numbers in the studios. This retains auditability without asking painters to navigate illustrated sources.

## Tubes: historical evidence versus the actual boxes

All four exported guide tables exactly match their own `bin/easel tubes --markdown` output. The guides are identical outside those tables. No ordinary `help` or `tubes` output lists another studio or artist. The following are mismatches between historical notes and the chosen simulation boxes, not discrepancies between the guides and executables.

| Studio | Observed box (`tubes` output, in order) |
|---|---|
| Sargent | lead white; zinc white; lemon chrome; chrome yellow; cadmium yellow; Indian yellow; yellow ochre; Mars yellow; red lead; vermilion; cadmium red; Mars red; red earth; rose madder; burnt sienna; Mars brown; bone black; cerulean blue; cobalt blue; ultramarine blue; viridian; emerald green; cobalt violet |
| Inness | lead white; lemon chrome; cadmium yellow; yellow ochre; raw sienna; orange chrome; red earth; Indian red; raw umber; bitumen; bone black; cobalt blue; Antwerp blue |
| Alma-Tadema | lead white; Naples yellow; pale cadmium; yellow ochre; brown ochre; orange vermilion; Chinese vermilion; red earth; rose madder; burnt sienna; bone black; cobalt blue; viridian |
| Tonn | lead white; lead-tin yellow; cadmium yellow; yellow ochre; transparent oxide yellow; cadmium red; red earth; permanent alizarin; burnt sienna; raw umber; bone black; ultramarine blue; cerulean blue; green earth |

**Sargent — should fix, materials lines 140–159, 170–173.** The note says “Sienna … Raw or burnt not stated,” while the box chooses burnt sienna. “Two grades” of cadmium yellow become one tube. Multiple madders and “Magenta in tubes” / “Bone Brown” are not separately represented. Bone/ivory black is one modeled tube. These are mainly simplification and naming ambiguities; burnt sienna is a more specific historical claim than the evidence supports. Suggested addition: “This box represents documented pigment families with a limited set […]” Do not add subject-based substitution recipes.

**Inness — must fix attribution, materials lines 124, 129–134, 138, 144–147.** “White … Type (lead or zinc) not stated” becomes lead white. “Venetian red” is represented by red earth without a stated mapping; “brown and pink”/brown pink is absent. Several pigments marked uncertain become equally definite-looking box contents, especially bitumen (“probable … Not analyzed”). No named green is supplied, which is consistent with the acknowledged evidence gap. Suggested addition: “The simulator supplies lead white as an experimental assumption; the […]” The lead-white choice matters materially because opacity and drying affect every mixture.

**Alma-Tadema — must fix uncertainty; should fix aliases, materials lines 123–135.** Pale cadmium and viridian are included despite uncertain attribution. Raw umber and deep cadmium, described as used “very little, if at all,” are absent. This is a defensible selection only when disclosed. Flake white, light red, cobalt, and ivory black correspond to lead white, red earth, cobalt blue, and bone black. Suggested addition: “The supplied pale cadmium and viridian are uncertain historical inclusions. […]” Keep the uncertainty attached to the evidence, not only buried in the table.

**Tonn — should fix, materials lines 173, 176–190.** The box omits titanium white, red umber, cobalt blue, cobalt violet, and vermilion. Most omissions match reported disuse, rarity, or ownership without use; red umber is a documented color left out. Cadmium yellow light/deep collapse to one tube. English red becomes red earth, terre verte becomes green earth, and ivory black becomes bone black. Suggested addition: “This is a selected simulation box. Cadmium yellow grades share […]” The note's repeated flesh mixtures should still be removed even though their pigments are available.

**Fine:** Different boxes are explicitly part of the experiment's documented material constraint. The actual counts—23, 13, 13, and 14 tubes—are not by themselves evidence of contamination. Their historical confidence and substitutions need the same treatment across artists.

## Capabilities the easel does not expose

**Should fix in all materials notes and the shared guide.** The notes describe real practices that the documented interface cannot reproduce. The guide's `canvas{}` accepts plain-weave linen and ground layers (all guides, lines 39–54). Its only paint-medium parameter is an oil share: “Medium makes the paint more transparent and more fluid, and slower to dry” (lines 74–76). There is no documented panel support, solvent/drier selection, resin/varnish operation, canvas scraping tool, or abrasion tool. `b:wipe` wipes a brush; `erase` acts on drawing. They are not canvas scraping or paint wiping operations.

| Note passages | Unsupported or non-equivalent practice | Concrete qualification |
|---|---|---|
| Sargent 119–123, 175–207, 288–302 | Turpentine, separate binding oils, megilp, matting medium, interlayer/final varnish, scraping out, replacement canvases | “These are historical practices. The easel supplies one oil-medium control, no solvent/resin/drier or varnish control, and no canvas-scraping operation. It holds one painting.” |
| Inness 44–45, 153–173, 180–190, 242–248 | Wood/board; drying siccatives; unidentified thick medium; shellac; fingernail/handle scratching and wiping | “Panel/board supports, siccatives, shellac, and paint-removal tools are historical context […]” |
| Alma-Tadema 41–67, 152–167, 202–217 | Oak/mahogany panels; boiled oil and copal; varnish; selective scraping | “The simulator uses linen. It has no panel, copal, boiled-oil, varnish, or paint-scraping controls. Its oil share does not model these historical media.” |
| Tonn 43–73, 80–101, 119–125, 217–236, 289–291, 348–378 | Synthetic fabric on rigid boards; adhesive; acrylic versus lead ground chemistry; projector; oleogel/Venetian medium; cuttlefish-bone abrasion; damar/Gamvar | “The easel models linen and pigment-based ground layers, with a […]” |
| All physics notes 13–18, 64–76, 96–99 | Egg yolk, separate oils, decades-long shrinkage, humidity mechanics | “These are physical measurements from real materials, not a list of implemented simulator controls or guaranteed simulated effects.” |

These additions should explain limits without suggesting visual substitutes such as painting fake cracks, varnish highlights, or panel grain. Long drying history and chemical aging are legitimate background facts; they must not become an instruction to depict an aged painting.

## Shared files and runner-added notes

### `notes/studio_notes.md` (runner source: `[local path redacted]

**Fine for contamination, lines 3–174.** “Facts about the canvas, the paint and the tools at this easel” (3–4) accurately describes the scope. Its examples concern abstract marks, masks, loads, wet paint, and film behavior. No tree, sitter, architecture, historical style, or painter is selected. “Looks like cracking” (13–15) describes a simulator artifact; it does not ask the painter to add cracks. “Lacy texture” (126–128) and “a string of beads” (117) describe the appearance of marks without selecting a depicted object. These explanations apply to all four studios equally.

**Should fix factual scope, lines 9–17 and 29–32.** The statements “The linen's vertical threads are closer-spaced” and “the knife-textured ground” read as universal, but `canvas{}` allows different thread counts and brush/roller grounds. “Lead white hides strongly (about 0.82 of a full hide per coat)” repeats the table's hiding coefficient as a measured-looking coverage fraction. Suggested replacements: “Linen spacing follows the chosen warp/weft counts; irregularity is greater in the weft.” “On a knife-textured ground, light paint at low pressure can catch the high points.” “Lead white has a modeled hiding coefficient of 0.82; coverage also depends on application and thickness.”

**Should fix certainty, lines 49–51 and 135–138.** Both carry “reported, not verified.” These are already honest qualifiers, but detailed threshold/effect claims can still steer technique. Suggested rewrite: “Dry-brush breakup and brushed-glaze coverage depend on load, pressure, underlying paint, and ground texture; inspect the result at this easel.” Retain exact thresholds only after confirming them for the exported engine. This review did not paint test swatches because the task is read-only.

### `notes/research/trees.md` (Inness only; runner source: `[local path redacted]

**Must fix the assignment of the entire file, lines 1–105.** “Trees: how they are built” (1) is subject instruction outside materials and method. Giving this only to the landscape painter primes trees, specific European species, old/damaged crowns, and their silhouettes. Botanical accuracy does not remove that intervention. It also gives Inness representational help that the portrait and figure painters do not get for their likely subjects.

Concrete change: remove `trees.md` from the Inness export and remove its reading-list entry at `briefs20/inness.md:33`. Do not replace it with subject tutorials in the other studios under the stated experiment. Supplying it to everyone would equalize access but would still contaminate a test of what painters bring themselves.

The most direct rendering and motif cues are:

| Lines | Quote | Why it steers |
|---|---|---|
| 11 | “It becomes ‘stag-headed,’ with dead limbs standing above the living foliage, and usually hollow” (double quotes in source) | Supplies a recognizable old-tree motif. |
| 18 | “Seen from any distance, only the trunk and the first […]” | Direct instruction about visible detail and silhouette. |
| 19 | “an old crown therefore reads as a few uneven masses, not one even dome.” | Gives the form to paint. |
| 21 | “a crown whose every limb is covered in straight upright […]” | Corrects the painter's prospective representation. |
| 29 | “A branch drawn as a constant-width rod, or narrower where it leaves the trunk, contradicts both.” | Explicit drawing instruction. |
| 32 | “Nothing in a tree floats. Every twig connects through its parent to the trunk, as the pipe model presumes [LEH].” | Directs construction of the subject. |
| 38–85 | Species sections include “irregular boughs with twisting branches” (38), “distinctly drooping fine branches” (53), “whorled, short and stout branches” (77), and “Upper crowns always show orange peeling bark” (84). | Supplies silhouettes, branching patterns, and localized colors for eight species. |

All these examples share the same concrete remedy: omit the file. The neutral biological facts in the surrounding sentences do not rescue its selection as painter input.

### `notes/research/oil_paint_physics.md` in all four exports

**Must fix:** the da Vinci name at line 109, as recorded above. **Should fix:** add the real-physics/simulator distinction described in the capabilities section. **Fine otherwise for contamination:** the four copies are byte-identical; anonymous measured canvases, rheology, brush fibers, drying, and thread counts do not dictate a subject or composition. Lines 58, 60, 77–78, and 82–98 refer to specific anonymous material specimens but do not identify their images. The generic “usable range” at line 94 is shared technical advice, not artist-specific style instruction.

### `notes/easel_guide.md`, journals, and notices

**Fine for subject/style contamination.** All four guides describe the same interface and differ only in their own tube table. Geometry and lighting examples are abstract ellipsoids, blocks, terrain, and coordinate queries; they specify tool capabilities. “broad,” “glaze,” “scumble,” “found,” and “lost” are documented tool names/parameters, not evaluations of the desired painting. Each `notes/journal.md` is empty. All `bin/THIRD_PARTY_NOTICES.md` copies are identical legal/software attribution; no other studio or painter exemplar is named there. Preserve required license text.

**Should fix documentation scope:** add the capabilities qualification above next to the guide's medium definition (lines 74–76), so no profile has to infer the difference between oil share and the historical medium names.

### Harness system prompt

**Fine:** `[local path redacted] lines 1–3: “You are a painter working at an easel in your […]” / “Your brief follows in the first message.” No subject, palette, aesthetic, or other artist is supplied.

## Briefs and the Friedrich comparison

The four current openings are syntactically similar but not equally neutral:

| Brief | Lines and quote | Severity and concrete rewrite |
|---|---|---|
| `briefs20/sargent.md` | 3–5: “one original portrait” / “The sitter, setting and composition are yours to invent.” | Must fix for an equal subject-freedom experiment. Use the shared opening below. “Portrait” is a genre assignment and “sitter” reinforces it. |
| `briefs20/inness.md` | 3–5: “one original landscape” / “The place, subject and composition are yours to invent.” | Must fix for equal subject freedom. Use the shared opening and remove the trees reading assignment at line 33. |
| `briefs20/alma-tadema.md` | 3–5: “one original scene from Roman antiquity” / “The subject, setting and composition are yours to invent.” | Must fix. Roman antiquity supplies period, cultural setting, and an expected scene; this is more specific than assigning a genre. Use the shared opening. |
| `briefs20/tonn.md` | 3–5: “one original picture” / “The subject and composition are yours to invent.” | Fine as an open-subject brief. Standardize the other openings to the same form. |

Shared replacement, changing only the artist name:

> Compose and paint one original picture in the manner of [artist], at the easel, a simulator of oil paint on linen. The subject, setting, and composition are yours to invent. Work from knowledge and the notes in your studio; don't use reference images, image models, or pictures of the artist's work.

The actual round-19 Friedrich brief at `[local path redacted] lines 3–7, says “one original landscape” and leaves place, subject, and composition open. Its reading list, lines 32–35, also includes trees. Inness closely inherits that format; Sargent changes the genre; Alma-Tadema adds a historical subject constraint; Tonn removes the genre constraint. Thus the Friedrich precedent explains the structure but does not establish fairness across these four tasks. If genre-conditioned results are intended, report that experimental choice explicitly and avoid calling the four openings neutral or interpreting subject selection as spontaneous.

The remaining studio, rules, working, and reply sections are parallel and neutral for the requested contamination audit. The placeholder `[local path redacted] should be replaced by the actual isolated studio path at launch; it names no competing artist. **Should fix operationally:** substitute the real isolated studio path at launch.

## Cross-contamination and readable artifacts

### Ordinary interface: fine

Each `bin/box:1` contains only its own profile (`sargent`, `inness`, `alma-tadema`, or `tonn`). Its own name is already in its brief. `help` contains only operations; `tubes` and `tubes --markdown` contain only the selected box. The guide heading is simply “The tube box” (line 83). Each exported research filename names only its own artist plus shared physics. No other profile's materials note exists inside any inspected export.

The harness read boundary resolves real paths and checks that they remain within the studio (`harness/painter/easel-client.ts:72–82`); the read hook rejects outside paths (`easel-tools.ts:103–107`). The guide states that Lua has no `io`, `os`, `require`, `dofile`, or `loadfile` (Sargent 421–422; Inness/Alma-Tadema 411–412; Tonn 412–413). The sibling smoke folders and logs visible to this reviewer are therefore not demonstrated painter-readable inputs through the inspected tool boundary. The two runner-added files are evaluated as specified in REVIEW_MATERIALS.md; they are not present in the smoke copies themselves.

### Binary strings: must fix for the stated artifact boundary

All four `bin/easel` files contain the broad pigment catalog, including pigments unavailable in the local box, and the legacy label `smalt box`. Concrete strings recovered from every binary include:

> `lead-tin yellow` · `Antwerp blue` · `Chinese vermilion` · `emerald green` · `pale smalt` · `smalt box`

Catalog entries also expose chemistry and color constants, for example:

> `Antwerp bluePrussian blue on an alumina base#26406c`

These are binary byte strings, so text line numbers are not meaningful. Reproduction: `strings smoke/<profile>/bin/easel`, then search the literals above. The stock palette sequence `lead whitepale smaltyellow ochrered earthvermilionraw umberbone black` also survives. This reveals other material possibilities and a legacy box despite profile-specific help. It does **not** establish that a painter can select those tubes or reconstruct the other studios' exact box membership.

Concrete change: build painter executables with only the selected pigment catalog and permitted box metadata; remove legacy box labels and unavailable pigment records from that build. Keep executables outside the painter-readable tree or restrict `read` to the approved text notes and current painting outputs if catalog removal is not part of the export design. Retain license notices. Recheck the actual exported bytes and the read boundary after either change.

No other round-20 profile name, nor `friedrich`, was found as an artist identifier in a studio binary. The substring `tonn` occurs only in its own studio binary; unrelated substrings are not evidence of another artist. This is residual materials disclosure, not demonstrated leakage of another artist's complete studio. The painter has no shell in the inspected harness; actual extraction through its `read` tool was not exercised. The strict requested review of readable artifacts still makes the embedded catalog worth removing.

## Fairness and evidence quality

| Materials note | Lines | Whitespace-delimited words | Words before Sources |
|---|---:|---:|---:|
| Sargent | 345 | 3,556 | 3,342 |
| Inness | 315 | 3,278 | 2,955 |
| Alma-Tadema | 289 | 3,118 | 2,497 |
| Tonn | 460 | 4,780 | 4,024 |
| Accepted Friedrich reference | 221 | 2,077 | — |

**Should fix unequal detail:** Tonn's body is about 61% longer than Alma-Tadema's and includes substantially more practical coaching. Inness also gets 105 lines of subject-specific botany. Raw line counts understate differences because the notes wrap paragraphs differently and Tonn has many compact source IDs. Concrete change: give all four the same section structure and approximate body-word budget, with only support, ground, drawing tools, pigment evidence, medium, application/reworking, and relevant limitations. Remove duplicate summary recipes, generic teaching advice, and aesthetic anecdotes. Preserve genuine evidence gaps rather than filling a shorter note with speculative guidance.

**Should fix unequal source function:** Sargent has technical examination plus pupils' instructions; Inness relies heavily on recollection and demonstration; Alma-Tadema explicitly lacks much instrumental evidence and imports a pupil's general manual; Tonn draws largely from self-report and public teaching posts. These sources have different evidentiary weight and different powers to coach the painter. Concrete change: label each retained statement “examined object,” “documented self-report,” “witness account,” or “uncertain attribution”; keep the same factual level of detail across notes. A sourced recipe remains a recipe.

**Should fix internal uncertainty wording:**

- Sargent summary, lines 25–27: “No accessible source gives … paint-film thicknesses in microns” sits beside “almost 0.5 cm” at lines 241–243. This is not a logical contradiction about units, but it can mislead. Rewrite: “No systematic film-thickness measurements were found; one catalog reports localized impasto approaching 0.5 cm.”
- Inness summary, lines 24–25: “No published … medium analysis” coexists with identified shellac at 170–173. Distinguish binder from coating: “No pigment or binding-oil analysis was found; one coating was identified as shellac.”
- Alma-Tadema summary, lines 26–29: “No cross-sections, medium analyses or pigment identifications have been published” overstates a search result. Rewrite: “No published cross-sections, medium analyses, or pigment identifications were found in the consulted sources.”
- Tonn introduction, lines 6–9: “No technical study … exists” and “the newer statement is the one to rely on” overstate completeness/currentness. Rewrite: “No technical study was found in the consulted sources. Dated self-reports can differ; a later statement does not establish an unchanged current practice.” Apply this qualification also to titanium at line 173, grinding at 206–209, and lighting at 335–338.

These are editorial evidence checks, not independent authentication of all historical claims or all cited posts. The report evaluates the supplied text as painter input; limited external checks identify the additional painter names.

## Overall verdict per studio

**Sargent — must fix before use.** The brief preselects portraiture; the note supplies flesh mixtures, brown backgrounds, edge doctrine, and recognizable portrait details. Preserve its strong technical evidence after removing those cues, normalize historical-to-box naming, and apply the shared source/binary cleanup.

**Inness — must fix before use.** The landscape brief, tree guide, sky formulas, gray/green palette descriptions, and subject-transformation anecdotes combine into substantial coaching. Remove the tree guide and visual recipes, disclose the assumed white and uncertain pigment inclusions, and apply the shared cleanup.

**Alma-Tadema — must fix before use.** Roman antiquity is an explicit subject assignment; light-background figures, blue skies, marble, flowers, artwork-title URLs, painter names, and a pupil's medium recipe add further steering. Remove those cues, retain documented material facts, and label uncertain box inclusions and unsupported copal/panel practices.

**Tonn — must fix before use.** The opening is neutral, but the long note repeatedly steers toward low-chroma figure painting, skin mixtures, and a portrait palette arrangement, with direct teaching advice and praise. Reduce it to dated practice evidence, explain the selected box and simulator limits, and apply the shared cleanup.
