-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{
  size = 500,
  aspect = 4/3,
  linen = {18, 14},
  seed = 42,
  ground = {
    {pile = {{"lead white", 8}, {"raw umber", 1}, {"yellow ochre", 1}}, um = 35, apply = "knife", texture = 0.15},
    {pile = {{"lead white", 6}, {"yellow ochre", 2}, {"raw umber", 1}, {"burnt sienna", 0.5}}, um = 20, apply = "roller"}
  }
}

print("Canvas created. W:", W, "H:", H)
print("Available tubes:")
print(table.concat(tubes(), ", "))

--@ chunk 2
-- Campaign 1: Underdrawing
local p = pencil{grade = "2B"}

-- 1. Compositional division: Table horizon and table front edge
p:line({{0, 480}, {1000, 480}})
p:line({{0, 700}, {1000, 700}})

-- 2. Terracotta pitcher outline
p:sketch({
  {300, 205}, {340, 205}, {350, 255}, {395, 335}, {400, 395}, 
  {380, 480}, {370, 555}, {270, 555}, {260, 480}, {240, 395}, 
  {245, 335}, {290, 255}, {300, 205}
})
-- Pitcher mouth ellipse
p:sketch({{300, 205}, {320, 212}, {340, 205}, {320, 198}, {300, 205}})
-- Pitcher handle
p:sketch({{290, 255}, {240, 280}, {225, 330}, {245, 385}, {260, 395}})
p:sketch({{295, 265}, {250, 290}, {240, 335}, {255, 380}, {265, 390}})

-- 3. Draped linen napkin under and around pitcher base
p:sketch({
  {180, 560}, {220, 535}, {265, 545}, {320, 555}, {370, 565}, 
  {380, 620}, {355, 680}, {340, 730}, {300, 745}, {250, 740}, 
  {210, 730}, {170, 685}, {150, 620}, {180, 560}
})
-- Linen fold lines
p:line({{220, 535}, {240, 620}, {230, 700}, {210, 730}})
p:line({{270, 560}, {290, 640}, {280, 705}, {270, 740}})
p:line({{330, 570}, {350, 630}, {335, 700}, {320, 735}})

-- 4. Whole ripe quince (center)
p:sketch({
  {540, 515}, {565, 525}, {590, 555}, {595, 595}, {575, 628}, 
  {535, 632}, {500, 615}, {485, 580}, {495, 545}, {520, 520}, {540, 515}
})
-- Indentation / blossom end
p:sketch({{540, 515}, {542, 528}, {538, 535}})

-- 5. Quince wedge / slice
p:sketch({
  {630, 565}, {665, 560}, {685, 585}, {680, 620}, {650, 635}, 
  {625, 615}, {630, 565}
})
p:sketch({{640, 575}, {660, 572}, {670, 590}, {655, 610}, {640, 575}})

-- 6. Peel curl on tabletop
p:sketch({{450, 630}, {480, 625}, {505, 640}, {490, 655}, {460, 650}, {440, 640}})

-- 7. Earthenware bowl with figs (right)
-- Bowl rim ellipse
p:sketch({{710, 505}, {775, 520}, {840, 505}, {775, 492}, {710, 505}})
-- Bowl body and foot
p:sketch({
  {710, 505}, {725, 545}, {745, 570}, {805, 570}, {825, 545}, {840, 505}
})
-- Figs inside bowl
p:sketch({{740, 485}, {765, 475}, {780, 495}, {765, 510}, {740, 505}, {735, 490}})
p:sketch({{780, 485}, {805, 480}, {820, 500}, {805, 515}, {780, 505}})

-- 8. Shadow boundaries
p:line({{370, 555}, {480, 565}, {500, 575}})
p:line({{575, 628}, {630, 638}, {660, 640}})
p:line({{805, 570}, {880, 580}, {910, 585}})

print("Underdrawing completed.")

--@ chunk 3
-- Campaign 2: The Large Masses (Plaster Wall and Walnut Tabletop)

-- Knifing palette piles
p_wall_lit   = pile{{"lead white", 5}, {"yellow ochre", 3}, {"raw umber", 2}, {"green earth", 0.6}}
p_wall_mid   = pile{{"lead white", 2.5}, {"yellow ochre", 2.5}, {"raw umber", 3.5}, {"burnt sienna", 0.5}}
p_wall_shade = pile{{"raw umber", 5}, {"bone black", 2}, {"burnt sienna", 1.5}, {"yellow ochre", 1}}

p_table_lit   = pile{{"raw umber", 4}, {"burnt sienna", 3}, {"yellow ochre", 2}, {"bone black", 0.5}}
p_table_mid   = pile{{"raw umber", 5}, {"burnt sienna", 3.5}, {"bone black", 1}, {"yellow ochre", 1}}
p_table_shade = pile{{"raw umber", 6}, {"bone black", 3}, {"burnt sienna", 2}}
p_table_front = pile{{"raw umber", 5}, {"bone black", 4.5}, {"burnt sienna", 1}}

local b_broad = brush{width = 45, kind = "flat"}

-- 1. Wall lay-in: midtone base across upper canvas (y: 0 to 485)
work(rect(0, 0, 1000, 485), {
  hand = "broad",
  pile = p_wall_mid,
  tool = b_broad,
  angle = math.pi * 0.12,
  coverage = 1.05,
  fill = true
})

-- 2. Lit buff sweeping from upper left
work(poly{{0, 0}, {550, 0}, {260, 485}, {0, 485}}, {
  hand = "broad",
  pile = p_wall_lit,
  tool = b_broad,
  angle = math.pi * 0.12,
  coverage = 0.8,
  fill = false
})

-- 3. Atmospheric shadow descending into lower right
work(poly{{380, 0}, {1000, 0}, {1000, 485}, {180, 485}}, {
  hand = "broad",
  pile = p_wall_shade,
  tool = b_broad,
  angle = math.pi * 0.12,
  coverage = 0.85,
  fill = false
})

-- 4. Soft blend across the plaster wall
work(rect(0, 0, 1000, 485), {
  hand = "blend",
  tool = brush{width = 60, kind = "flat"},
  angle = math.pi * 0.12,
  pressure = 0.35,
  clip = false
})

-- 5. Tabletop plane (y: 480 to 700): horizontal wood grain marks
work(rect(0, 480, 1000, 220), {
  hand = "broad",
  pile = p_table_mid,
  tool = b_broad,
  angle = 0,
  coverage = 1.1,
  fill = true
})

-- Table light passage (left and mid-left)
work(poly{{0, 480}, {450, 480}, {350, 700}, {0, 700}}, {
  hand = "broad",
  pile = p_table_lit,
  tool = b_broad,
  angle = 0,
  coverage = 0.7,
  fill = false
})

-- Table shadow passage (right side and under right group)
work(poly{{480, 480}, {1000, 480}, {1000, 700}, {400, 700}}, {
  hand = "broad",
  pile = p_table_shade,
  tool = b_broad,
  angle = 0,
  coverage = 0.8,
  fill = false
})

-- Gentle horizontal blend along table surface
work(rect(0, 480, 1000, 220), {
  hand = "blend",
  tool = brush{width = 50, kind = "flat"},
  angle = 0,
  pressure = 0.3
})

-- 6. Table front vertical bevel/edge (y: 700 to 750)
work(rect(0, 700, 1000, 50), {
  hand = "broad",
  pile = p_table_front,
  tool = brush{width = 25, kind = "flat"},
  angle = 0,
  coverage = 1.2,
  fill = true
})

print("Campaign 2: Large masses laid.")

--@ chunk 4
-- Campaign 3: Blocking In the Still Life Objects & Cast Shadows

-- 1. Piles for objects
p_terracotta_base  = pile{{"burnt sienna", 4}, {"red earth", 2}, {"yellow ochre", 2}, {"raw umber", 1}}
p_terracotta_shade = pile{{"raw umber", 4}, {"burnt sienna", 3}, {"bone black", 1}}
p_terracotta_lit   = pile{{"burnt sienna", 2.5}, {"yellow ochre", 4}, {"lead white", 3}, {"red earth", 0.5}}
p_terracotta_deep  = pile{{"raw umber", 5}, {"bone black", 3}, {"burnt sienna", 1.5}}

p_linen_base    = pile{{"lead white", 7}, {"yellow ochre", 1.5}, {"raw umber", 0.8}}
p_linen_lit     = pile{{"lead white", 9}, {"yellow ochre", 1}}
p_linen_shade   = pile{{"lead white", 3.5}, {"raw umber", 2.5}, {"vine black", 0.8}, {"cobalt blue", 0.4}}
p_linen_crevice = pile{{"raw umber", 4}, {"vine black", 2}, {"burnt sienna", 1}}

p_quince_skin  = pile{{"yellow ochre", 4}, {"cadmium yellow", 2.5}, {"raw sienna", 1}, {"lead-tin yellow", 1}, {"lead white", 1}}
p_quince_lit   = pile{{"lead-tin yellow", 3}, {"Naples yellow", 3}, {"lead white", 3}, {"yellow ochre", 1}}
p_quince_shade = pile{{"yellow ochre", 3}, {"raw umber", 3}, {"green earth", 1}}
p_quince_flesh = pile{{"lead white", 7}, {"lead-tin yellow", 2}, {"yellow ochre", 0.5}}
p_quince_seed  = pile{{"raw umber", 4}, {"burnt sienna", 3}, {"bone black", 1}}
p_peel         = pile{{"yellow ochre", 4}, {"cadmium yellow", 3}, {"lead-tin yellow", 1.5}}

p_bowl_glaze = pile{{"bone black", 4}, {"raw umber", 3}, {"burnt sienna", 1}, {"Prussian blue", 0.5}}
p_fig_skin   = pile{{"bone black", 3}, {"ultramarine blue", 2}, {"cobalt violet", 2}, {"raw umber", 1}}
p_fig_flesh  = pile{{"rose madder", 4}, {"vermilion", 2}, {"burnt sienna", 1}, {"lead white", 1}}

p_cast_shadow = pile{{"raw umber", 5}, {"bone black", 3}, {"burnt sienna", 2}, medium = 0.2}

local b_body = brush{width = 22, kind = "filbert"}
local b_detail = brush{width = 12, kind = "round", point = 0.5}

-- 2. Cast Shadows on tabletop
-- Pitcher cast shadow trailing rightwards
local m_pitcher_shadow = poly{
  {270, 555}, {370, 555}, {500, 570}, {530, 585}, {450, 600}, {350, 595}, {260, 570}
}
work(m_pitcher_shadow, {
  hand = "broad",
  pile = p_cast_shadow,
  tool = b_body,
  angle = math.pi * 0.1,
  coverage = 0.95,
  fill = true
})

-- Quince cast shadow
local m_quince_shadow = poly{
  {535, 630}, {585, 625}, {660, 638}, {675, 650}, {620, 655}, {535, 635}
}
work(m_quince_shadow, {
  hand = "broad",
  pile = p_cast_shadow,
  tool = b_detail,
  angle = math.pi * 0.08,
  coverage = 0.95,
  fill = true
})

-- Bowl cast shadow
local m_bowl_shadow = poly{
  {745, 570}, {820, 565}, {910, 580}, {930, 595}, {850, 605}, {745, 575}
}
work(m_bowl_shadow, {
  hand = "broad",
  pile = p_cast_shadow,
  tool = b_body,
  angle = math.pi * 0.1,
  coverage = 0.95,
  fill = true
})

-- 3. Terracotta Pitcher Body
local m_pitcher = poly{
  {300, 205}, {340, 205}, {350, 255}, {395, 335}, {400, 395}, 
  {380, 480}, {370, 555}, {270, 555}, {260, 480}, {240, 395}, 
  {245, 335}, {290, 255}, {300, 205}
}
work(m_pitcher, {
  hand = "body",
  pile = p_terracotta_base,
  tool = b_body,
  angle = math.pi * 0.45,
  coverage = 1.25,
  fill = true
})

-- Pitcher mouth interior (hollow shadow)
local m_mouth_interior = poly{{300, 205}, {320, 212}, {340, 205}, {320, 198}}
work(m_mouth_interior, {
  hand = "detail",
  pile = p_terracotta_deep,
  tool = b_detail,
  angle = 0,
  coverage = 1.3,
  fill = true
})

-- Pitcher handle
local m_handle = poly{
  {290, 255}, {240, 280}, {225, 330}, {245, 385}, {260, 395},
  {265, 390}, {255, 380}, {240, 335}, {250, 290}, {295, 265}
}
work(m_handle, {
  hand = "body",
  pile = p_terracotta_shade,
  tool = b_detail,
  angle = math.pi * 0.4,
  coverage = 1.2,
  fill = true
})

-- 4. Linen Napkin
local m_linen = poly{
  {180, 560}, {220, 535}, {265, 545}, {320, 555}, {370, 565}, 
  {380, 620}, {355, 680}, {340, 730}, {300, 745}, {250, 740}, 
  {210, 730}, {170, 685}, {150, 620}, {180, 560}
}
work(m_linen, {
  hand = "body",
  pile = p_linen_base,
  tool = b_body,
  angle = math.pi * 0.35,
  coverage = 1.2,
  fill = true
})

-- Linen primary shadow planes
local m_linen_sh1 = poly{
  {220, 535}, {240, 620}, {230, 700}, {210, 730},
  {170, 685}, {150, 620}, {180, 560}
}
work(m_linen_sh1, {
  hand = "body",
  pile = p_linen_shade,
  tool = b_body,
  angle = math.pi * 0.35,
  coverage = 1.1,
  fill = true
})

local m_linen_sh2 = poly{
  {280, 560}, {300, 630}, {290, 700}, {280, 735},
  {250, 740}, {260, 690}, {250, 610}, {265, 550}
}
work(m_linen_sh2, {
  hand = "body",
  pile = p_linen_shade,
  tool = b_body,
  angle = math.pi * 0.35,
  coverage = 1.0,
  fill = true
})

-- 5. Whole Ripe Quince
local m_quince = poly{
  {540, 515}, {565, 525}, {590, 555}, {595, 595}, {575, 628}, 
  {535, 632}, {500, 615}, {485, 580}, {495, 545}, {520, 520}, {540, 515}
}
work(m_quince, {
  hand = "body",
  pile = p_quince_skin,
  tool = b_detail,
  angle = math.pi * 0.3,
  coverage = 1.25,
  fill = true
})

-- 6. Quince Wedge / Cut Section
local m_wedge = poly{
  {630, 565}, {665, 560}, {685, 585}, {680, 620}, {650, 635}, 
  {625, 615}, {630, 565}
}
work(m_wedge, {
  hand = "body",
  pile = p_quince_flesh,
  tool = b_detail,
  angle = math.pi * 0.25,
  coverage = 1.25,
  fill = true
})

-- Wedge outer peel edge
local m_wedge_rind = poly{
  {665, 560}, {685, 585}, {680, 620}, {650, 635},
  {645, 625}, {675, 615}, {678, 585}, {660, 565}
}
work(m_wedge_rind, {
  hand = "detail",
  pile = p_peel,
  tool = b_detail,
  angle = math.pi * 0.25,
  coverage = 1.2,
  fill = true
})

-- Wedge seed pocket
local m_wedge_core = ellipse(650, 595, 8, 12)
work(m_wedge_core, {
  hand = "detail",
  pile = p_quince_seed,
  tool = brush{width = 6, kind = "round", point = 0.8},
  angle = 0,
  coverage = 1.3
})

-- 7. Curled Peel on table
local m_peel_strip = poly{
  {450, 630}, {480, 625}, {505, 640}, {490, 655}, {460, 650}, {440, 640}
}
work(m_peel_strip, {
  hand = "detail",
  pile = p_peel,
  tool = b_detail,
  angle = math.pi * 0.1,
  coverage = 1.2,
  fill = true
})

-- 8. Earthenware Bowl & Figs
local m_bowl = poly{
  {710, 505}, {725, 545}, {745, 570}, {805, 570}, {825, 545}, {840, 505},
  {775, 520}, {710, 505}
}
work(m_bowl, {
  hand = "body",
  pile = p_bowl_glaze,
  tool = b_detail,
  angle = math.pi * 0.45,
  coverage = 1.25,
  fill = true
})

-- Figs in bowl
local m_fig1 = ellipse(755, 495, 22, 18)
work(m_fig1, {
  hand = "body",
  pile = p_fig_skin,
  tool = b_detail,
  angle = math.pi * 0.2,
  coverage = 1.25
})

local m_fig2 = ellipse(795, 498, 20, 16)
work(m_fig2, {
  hand = "body",
  pile = p_fig_skin,
  tool = b_detail,
  angle = math.pi * 0.2,
  coverage = 1.25
})

-- Split fig ruby pulp
local m_pulp = ellipse(757, 494, 12, 10)
work(m_pulp, {
  hand = "detail",
  pile = p_fig_flesh,
  tool = brush{width = 6, kind = "round", point = 0.8},
  angle = 0,
  coverage = 1.3
})

print("Campaign 3: Objects blocked in.")

--@ chunk 5
-- Campaign 4: Volumetric Modeling, Halftones, and Form Refinement

-- Additional refined piles
p_terracotta_core   = pile{{"raw umber", 6}, {"bone black", 2.5}, {"burnt sienna", 2}}
p_terracotta_bounce = pile{{"burnt sienna", 3}, {"raw sienna", 2}, {"lead white", 1}, {"yellow ochre", 1}}
p_terracotta_high   = pile{{"lead white", 4}, {"burnt sienna", 2}, {"yellow ochre", 3}}

p_linen_impasto = pile{{"lead white", 10}, {"yellow ochre", 0.5}, {"Naples yellow", 0.3}}
p_linen_deep    = pile{{"raw umber", 5}, {"bone black", 2}, {"burnt sienna", 1}}

p_quince_high   = pile{{"lead white", 5}, {"lead-tin yellow", 3}, {"Naples yellow", 2}}
p_quince_core   = pile{{"raw umber", 4}, {"yellow ochre", 3}, {"green earth", 1.5}, {"burnt sienna", 0.5}}
p_stem          = pile{{"raw umber", 5}, {"bone black", 2}}

p_peel_pith     = pile{{"lead white", 6}, {"yellow ochre", 2}, {"raw sienna", 0.5}}

p_bowl_rim_high = pile{{"lead white", 6}, {"lead-tin yellow", 1}, {"raw umber", 1}}
p_fig_bloom     = pile{{"ultramarine ash", 2.5}, {"zinc white", 1.5}, medium = 0.4}
p_pulp_glaze    = pile{{"rose madder", 5}, {"vermilion", 1.5}, medium = 0.3}
p_pulp_high     = pile{{"lead white", 4}, {"vermilion", 2}, {"cadmium yellow", 1}}

local b_filbert = brush{width = 16, kind = "filbert"}
local b_detail  = brush{width = 8, kind = "round", point = 0.7}
local b_point   = brush{width = 4, kind = "round", point = 0.9}

-- 1. Terracotta Pitcher: Modeling light, core shadow, and bounce
-- Left light mass on neck and belly
local m_pitcher_lit = poly{
  {300, 208}, {330, 208}, {335, 255}, {360, 335}, {355, 410}, 
  {330, 490}, {300, 550}, {270, 550}, {260, 480}, {240, 395}, 
  {245, 335}, {290, 255}, {300, 208}
}
work(m_pitcher_lit, {
  hand = "body",
  pile = p_terracotta_lit,
  tool = b_filbert,
  angle = math.pi * 0.45,
  coverage = 0.9,
  fill = false
})

-- Right core shadow on belly
local m_pitcher_core = poly{
  {340, 255}, {375, 335}, {395, 395}, {380, 480}, {365, 550},
  {340, 550}, {345, 470}, {360, 400}, {345, 335}, {330, 260}
}
work(m_pitcher_core, {
  hand = "body",
  pile = p_terracotta_core,
  tool = b_filbert,
  angle = math.pi * 0.45,
  coverage = 0.85,
  fill = false
})

-- Warm reflected bounce on far right flank
local m_pitcher_bounce = poly{
  {375, 345}, {395, 395}, {380, 480}, {370, 545},
  {362, 545}, {372, 480}, {385, 400}, {368, 350}
}
work(m_pitcher_bounce, {
  hand = "detail",
  pile = p_terracotta_bounce,
  tool = b_detail,
  angle = math.pi * 0.45,
  coverage = 0.75,
  fill = false
})

-- Pitcher handle volumetric strokes
b_detail:load(p_terracotta_lit, 0.8)
b_detail:stroke({{292, 257}, {242, 282}, {228, 330}, {248, 385}}, {pressure = 0.6})
b_detail:load(p_terracotta_core, 0.8)
b_detail:stroke({{296, 267}, {252, 292}, {242, 336}, {258, 382}}, {pressure = 0.7})

-- Soft blend across pitcher belly to unify the cylinder
local m_pitcher_belly = poly{{250, 250}, {390, 250}, {385, 545}, {260, 545}}
work(m_pitcher_belly, {
  hand = "blend",
  tool = brush{width = 25, kind = "filbert"},
  angle = math.pi * 0.45,
  pressure = 0.35
})

-- 2. Draped Linen: Crisp impasto ridges and deep shadow crevices
-- Deep crevice accents
b_detail:load(p_linen_deep, 0.8)
b_detail:stroke({{220, 540}, {238, 620}, {228, 700}, {208, 735}}, {pressure = 0.65})
b_detail:stroke({{278, 565}, {296, 640}, {288, 705}, {278, 742}}, {pressure = 0.65})
b_detail:stroke({{338, 575}, {355, 635}, {342, 700}, {328, 738}}, {pressure = 0.65})

-- Impasto ridges catching high light
b_filbert:load(p_linen_impasto, 0.9)
b_filbert:stroke({{195, 555}, {215, 610}, {200, 690}, {180, 725}}, {pressure = 0.85})
b_filbert:stroke({{245, 550}, {268, 625}, {258, 695}, {242, 735}}, {pressure = 0.85})
b_filbert:stroke({{305, 560}, {325, 630}, {315, 695}, {298, 740}}, {pressure = 0.85})
b_filbert:stroke({{355, 570}, {372, 620}, {350, 680}, {335, 728}}, {pressure = 0.8})

-- Soft blend of the linen shadow slopes (preserving the ridge tops)
local m_linen_slopes = poly{{170, 580}, {360, 580}, {330, 730}, {180, 730}}
work(m_linen_slopes, {
  hand = "blend",
  tool = brush{width = 18, kind = "round", point = 0.4},
  angle = math.pi * 0.35,
  pressure = 0.3
})

-- 3. Whole Quince: Spherical modeling, core shadow, and skin texture
local m_quince = poly{
  {540, 515}, {565, 525}, {590, 555}, {595, 595}, {575, 628}, 
  {535, 632}, {500, 615}, {485, 580}, {495, 545}, {520, 520}, {540, 515}
}

-- Lit cap on upper-left
local m_quince_lit = poly{
  {535, 520}, {565, 528}, {570, 560}, {540, 585}, {510, 575}, {495, 545}, {520, 520}
}
work(m_quince_lit, {
  hand = "body",
  pile = p_quince_lit,
  tool = b_detail,
  angle = math.pi * 0.25,
  coverage = 0.9,
  fill = false
})

-- Core shadow on lower-right
local m_quince_core = poly{
  {555, 565}, {590, 560}, {595, 595}, {575, 628}, {545, 630}, {540, 605}
}
work(m_quince_core, {
  hand = "body",
  pile = p_quince_core,
  tool = b_detail,
  angle = math.pi * 0.3,
  coverage = 0.85,
  fill = false
})

-- Gentle blend of quince form
work(m_quince, {
  hand = "blend",
  tool = brush{width = 15, kind = "filbert"},
  angle = math.pi * 0.25,
  pressure = 0.3
})

-- Delicate quince skin stipple for waxy/pitted texture
stipple(m_quince, {
  pile = p_quince_skin,
  tool = brush{width = 5, kind = "round", point = 0.8},
  coverage = 0.45,
  feather = 0.5,
  pressure = 0.4
})

-- Stem cavity and stub
b_point:load(p_stem, 0.85)
b_point:touch(540, 522, {pressure = 0.7})
b_point:stroke({{540, 522}, {538, 510}}, {pressure = 0.6})

-- 4. Cut Quince Wedge: Flesh modeling & seed cavity
local m_wedge_flesh_shade = ellipse(652, 600, 10, 14)
work(m_wedge_flesh_shade, {
  hand = "detail",
  pile = pile{{"yellow ochre", 2}, {"lead white", 5}, {"raw umber", 1}},
  tool = b_detail,
  angle = 0,
  coverage = 0.75
})

-- Seeds inside wedge cavity
b_point:load(p_quince_seed, 0.9)
b_point:touch(649, 592, {pressure = 0.8})
b_point:touch(651, 598, {pressure = 0.8})
b_point:touch(648, 604, {pressure = 0.8})

-- Crisp moist cut edge
b_point:load(p_quince_high, 0.9)
b_point:stroke({{630, 565}, {665, 560}, {680, 580}}, {pressure = 0.6})

-- 5. Curled Peel Strip: Inner pith and contact shadow
b_point:load(p_peel_pith, 0.8)
b_point:stroke({{455, 633}, {482, 628}, {502, 642}}, {pressure = 0.6})
b_point:load(p_cast_shadow, 0.8)
b_point:stroke({{445, 642}, {465, 653}, {492, 658}}, {pressure = 0.6})

-- 6. Fig Bowl & Figs: Bloom, glaze speculars, and ruby pulp
-- Glazed bowl rim specular highlight catching raking window light
b_point:load(p_bowl_rim_high, 0.9)
b_point:stroke({{712, 506}, {735, 512}, {760, 516}}, {pressure = 0.7})

-- Dusty bloom over dark figs
work(ellipse(755, 492, 18, 12), {
  hand = "scumble",
  pile = p_fig_bloom,
  tool = b_detail,
  angle = 0,
  coverage = 0.4
})
work(ellipse(795, 495, 16, 10), {
  hand = "scumble",
  pile = p_fig_bloom,
  tool = b_detail,
  angle = 0,
  coverage = 0.35
})

-- Split fig ruby pulp glaze and seed touches
work(ellipse(757, 494, 11, 8), {
  hand = "glaze",
  pile = p_pulp_glaze,
  tool = b_point,
  angle = 0,
  coverage = 0.8
})
b_point:load(p_pulp_high, 0.9)
b_point:touch(755, 493, {pressure = 0.65})
b_point:touch(759, 495, {pressure = 0.65})
b_point:touch(757, 497, {pressure = 0.6})

-- 7. Soften penumbra of cast shadows
local m_shad_soft1 = poly{{450, 560}, {540, 580}, {460, 605}, {360, 600}}
work(m_shad_soft1, {
  hand = "blend",
  tool = brush{width = 25, kind = "filbert"},
  angle = 0,
  pressure = 0.25
})
local m_shad_soft2 = poly{{820, 565}, {935, 595}, {860, 610}, {750, 580}}
work(m_shad_soft2, {
  hand = "blend",
  tool = brush{width = 20, kind = "filbert"},
  angle = 0,
  pressure = 0.25
})

print("Campaign 4: Volumetric modeling completed successfully.")

--@ chunk 6
-- Campaign 5: Final Accents, Specular Impasto Highlights, and Signature

p_specular   = pile{{"lead white", 9}, {"lead-tin yellow", 1}, {"Naples yellow", 0.5}}
p_clay_high  = pile{{"lead white", 5}, {"yellow ochre", 3}, {"burnt sienna", 2}}
p_peel_high  = pile{{"lead-tin yellow", 4}, {"cadmium yellow", 2}, {"lead white", 3}}
p_apron_shad = pile{{"raw umber", 6}, {"bone black", 3}, medium = 0.2}
p_signature  = pile{{"raw umber", 4}, {"burnt sienna", 2}, {"bone black", 1}, medium = 0.35}

local b_point = brush{width = 3, kind = "round", point = 0.95}
local b_detail = brush{width = 6, kind = "round", point = 0.8}

-- 1. Terracotta pitcher clay crest highlight & base reflection
b_detail:load(p_clay_high, 0.85)
b_detail:stroke({{298, 258}, {304, 275}, {312, 305}}, {pressure = 0.7})
b_point:load(p_terracotta_bounce, 0.8)
b_point:stroke({{275, 553}, {320, 554}, {365, 552}}, {pressure = 0.5})

-- 2. Quince seed moisture specular pinpricks
b_point:load(p_specular, 0.95)
b_point:touch(650, 593, {pressure = 0.55})
b_point:touch(652, 599, {pressure = 0.5})
b_point:touch(649, 605, {pressure = 0.45})

-- Quince whole fruit subtle top specular catch
b_point:load(p_specular, 0.9)
b_point:touch(536, 532, {pressure = 0.5})

-- Peel curl rim highlight
b_point:load(p_peel_high, 0.85)
b_point:stroke({{452, 630}, {478, 626}, {504, 639}}, {pressure = 0.6})

-- 3. Linen cast shadow across the front table bevel (y: 700 to 745)
local m_linen_front_shad = poly{
  {170, 700}, {345, 700}, {340, 745}, {300, 748}, {250, 745}, {210, 735}, {170, 705}
}
work(m_linen_front_shad, {
  hand = "detail",
  pile = p_apron_shad,
  tool = b_detail,
  angle = 0,
  coverage = 0.7,
  fill = false
})

-- 4. Artist's discreet signature on lower right table apron
b_point:load(p_signature, 0.7)
b_point:stroke({{870, 725}, {885, 722}, {895, 727}, {910, 724}}, {pressure = 0.4})
b_point:touch(915, 724, {pressure = 0.45})

print("Campaign 5: Final accents and signature laid.")

--@ chunk 7
-- Let the painting cure for 48 hours (2 days)
wait(2880)
print("Painting has rested for 48 hours.")

--@ chunk 8
print(wait(0))
