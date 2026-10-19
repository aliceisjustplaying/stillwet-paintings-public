-- CHUNK 173: THE MASTER SYNTHESIS (SEAMLESS SURFACES, BLENDED FORMS, COMPLETE BODEGÓN)

-- 1. DEFINE ALL PALETTE PILES
p_wall       = pile{{"raw umber", 6.5}, {"bone black", 3.5}, {"yellow ochre", 1.5}, medium = 0.08}
p_stone_back = pile{{"lead white", 6.5}, {"yellow ochre", 2.8}, {"raw umber", 1.5}, {"red earth", 0.3}, medium = 0.08}
p_stone_mid  = pile{{"lead white", 7.5}, {"yellow ochre", 2.4}, {"raw umber", 1.0}, {"red earth", 0.2}, medium = 0.08}
p_stone_lit  = pile{{"lead white", 8.2}, {"yellow ochre", 2.0}, {"raw umber", 0.5}, medium = 0.08}
p_ledge      = pile{{"bone black", 6.0}, {"raw umber", 4.0}, {"red earth", 1.2}, medium = 0.05}
p_chamfer    = pile{{"lead white", 8.8}, {"yellow ochre", 1.8}, medium = 0.05}
p_shadow_stone = pile{{"raw umber", 4.8}, {"yellow ochre", 3.2}, {"lead white", 2.2}, {"red earth", 0.6}, medium = 0.10}

-- Cantaro piles
p_jug_rich   = pile{{"red earth", 6.2}, {"yellow ochre", 3.8}, {"lead white", 1.2}, {"raw umber", 1.0}, medium = 0.06}
p_jug_lit    = pile{{"yellow ochre", 6.0}, {"red earth", 2.5}, {"lead white", 4.5}, {"raw umber", 0.5}, medium = 0.06}
p_jug_core   = pile{{"red earth", 5.5}, {"raw umber", 4.5}, {"bone black", 1.2}, {"yellow ochre", 1.0}, medium = 0.06}
p_jug_deep   = pile{{"bone black", 6.0}, {"raw umber", 4.0}, {"red earth", 1.8}, medium = 0.05}
p_jug_reflect= pile{{"yellow ochre", 5.0}, {"red earth", 2.0}, {"lead white", 2.5}, {"raw umber", 1.5}, medium = 0.08}
p_jug_hi     = pile{{"lead white", 9.0}, {"yellow ochre", 1.5}, {"red earth", 0.2}, medium = 0.04}

-- Quince piles
p_q_rich_gold= pile{{"yellow ochre", 5.5}, {"chrome yellow", 4.5}, {"lead white", 2.2}, {"green earth", 0.5}, medium = 0.06}
p_q_lit      = pile{{"chrome yellow", 5.5}, {"yellow ochre", 2.5}, {"lead white", 5.5}, medium = 0.05}
p_q_half     = pile{{"yellow ochre", 5.0}, {"green earth", 2.0}, {"raw umber", 1.5}, {"lead white", 2.2}, medium = 0.08}
p_q_core     = pile{{"raw umber", 5.0}, {"yellow ochre", 3.5}, {"red earth", 2.5}, {"bone black", 0.8}, medium = 0.06}
p_q_deep     = pile{{"raw umber", 6.0}, {"bone black", 3.0}, {"red earth", 1.8}, medium = 0.05}
p_q_reflect  = pile{{"yellow ochre", 5.5}, {"lead white", 3.0}, {"raw umber", 1.5}, {"red earth", 0.8}, medium = 0.08}
p_q_hi       = pile{{"lead white", 9.0}, {"chrome yellow", 2.5}, {"yellow ochre", 0.6}, medium = 0.04}
p_stem       = pile{{"raw umber", 6.0}, {"bone black", 3.5}, {"yellow ochre", 1.5}, medium = 0.05}

-- Knife piles
p_steel_lit  = pile{{"lead white", 8.2}, {"bone black", 1.0}, {"smalt", 0.6}, {"raw umber", 0.4}, medium = 0.05}
p_steel_mid  = pile{{"lead white", 4.8}, {"bone black", 3.0}, {"smalt", 1.0}, {"raw umber", 1.2}, medium = 0.06}
p_steel_dark = pile{{"bone black", 6.0}, {"raw umber", 3.0}, {"lead white", 1.0}, medium = 0.05}
p_brass      = pile{{"yellow ochre", 6.0}, {"red earth", 2.0}, {"raw umber", 2.0}, {"lead white", 1.5}, medium = 0.06}
p_brass_glint= pile{{"lead white", 8.0}, {"yellow ochre", 3.0}, {"chrome yellow", 1.0}, medium = 0.04}
p_knife_wood = pile{{"raw umber", 5.5}, {"red earth", 3.0}, {"bone black", 2.5}, {"yellow ochre", 1.0}, medium = 0.06}
p_knife_wood_lit= pile{{"red earth", 4.5}, {"yellow ochre", 3.5}, {"lead white", 2.5}, {"raw umber", 1.5}, medium = 0.06}

-- Walnut piles
p_nut_shell  = pile{{"raw umber", 4.5}, {"yellow ochre", 4.0}, {"red earth", 2.5}, {"lead white", 1.5}, medium = 0.06}
p_nut_deep   = pile{{"raw umber", 6.0}, {"bone black", 3.0}, {"red earth", 1.5}, medium = 0.05}
p_nut_meat   = pile{{"lead white", 7.8}, {"yellow ochre", 2.8}, {"raw umber", 0.6}, medium = 0.05}
p_nut_meat_shade= pile{{"yellow ochre", 4.5}, {"raw umber", 3.0}, {"lead white", 3.0}, {"red earth", 0.8}, medium = 0.06}

local b_f26 = brush("filbert", 26)
local b_f20 = brush("filbert", 20)
local b_f18 = brush("filbert", 18)
local b_f14 = brush("filbert", 14)
local b_f10 = brush("filbert", 10)
local b_f8  = brush("filbert", 8)
local b_r5  = brush{kind = "round", width = 5.5, point = 0.9}
local b_r3  = brush{kind = "round", width = 3.2, point = 0.9}
local b_r2  = brush{kind = "round", width = 2.0, point = 0.95}
local b_r1  = brush{kind = "round", width = 1.3, point = 0.98}
local b_badger = brush("badger", 32)

-- 2. DISSOLVE ALL SEAMS ON RIGHT WALL AND TABLETOP (Continuous sweeps to right edge)
-- A. Continuous dark background wall sweep (y = 475 to 520, from x = 650 to x = 1015)
for y = 475, 520, 8 do
  b_f26:load(p_wall, 1.0)
  b_f26:stroke({{655, y}, {835, y}, {1015, y}}, {pressure = 1.0})
end

-- B. Continuous limestone tabletop sweeps (y = 520 to 714, from x = 680 to x = 1015)
for y = 522, 600, 10 do
  b_f26:load(p_stone_back, 1.0)
  b_f26:stroke({{685, y}, {850, y}, {1015, y}}, {pressure = 1.0})
end

for y = 605, 665, 10 do
  b_f26:load(p_stone_mid, 1.0)
  b_f26:stroke({{680, y}, {850, y}, {1015, y}}, {pressure = 1.0})
end

for y = 668, 714, 8 do
  b_f26:load(p_stone_lit, 1.0)
  b_f26:stroke({{640, y}, {830, y}, {1015, y}}, {pressure = 1.0})
end

-- Horizontal badger passes to create an unbroken, serene stone plane
b_badger:stroke({{680, 550}, {1015, 550}}, {pressure = 0.22})
b_badger:stroke({{680, 630}, {1015, 630}}, {pressure = 0.22})
b_badger:stroke({{640, 685}, {1015, 685}}, {pressure = 0.22})

-- C. Front vertical ledge below knife
for y = 716, 765, 10 do
  b_f18:load(p_ledge, 1.0)
  b_f18:stroke({{760, y}, {850, y}, {1015, y}}, {pressure = 1.0})
end

-- 3. FUSING THE EARTHENWARE CÁNTARO INTO SCULPTURAL ROUNDNESS
local pts_cantaro = {
  {336, 272}, {352, 267}, {370, 265}, {388, 267}, {404, 272},
  {398, 310}, {395, 360},
  {420, 395}, {450, 435}, {470, 485},
  {458, 535}, {438, 580}, {414, 624},
  {370, 626}, {326, 624},
  {302, 580}, {282, 535}, {270, 485},
  {290, 435}, {320, 395}, {345, 360},
  {342, 310}
}
local m_cantaro = poly(pts_cantaro, true)

-- Blend wet paint inside cántaro body to fuse vertical stripes into smooth cylindrical volume
blend(m_cantaro, {angle = 1.35, coverage = 1.4})

-- Restate crisp glaze impasto on shoulder curve
b_r3:load(p_jug_hi, 1.0)
b_r3:stroke({{324, 402}, {320, 418}, {316, 436}}, {pressure = {0.7, 1.0, 0.7}, swell = {0.8, 1.4, 0.7}})
b_r1:load(p_jug_hi, 1.0)
b_r1:touch(320, 418, {pressure = 1.0})

-- Glaze glint on mouth lip and handle crest
b_r1:load(p_jug_hi, 1.0)
b_r1:touch(338, 272, {pressure = 0.95})
b_r1:stroke({{230, 398}, {214, 426}, {218, 442}}, {pressure = {0.5, 0.95, 0.5}})

-- Foot ring contact shadow
b_r2:load(p_jug_deep, 1.0)
b_r2:stroke({{322, 626}, {370, 628}, {418, 626}}, {pressure = {0.95, 1.0, 0.95}})

-- Cast shadow across limestone table
b_f14:load(p_shadow_stone, 0.55)
b_f14:stroke({{414, 625}, {465, 628}, {535, 636}}, {pressure = {0.85, 0.2}, swell = {1.0, 1.3, 0.6}})

-- 4. SCULPTING THE VOLUPTUOUS GOLDEN QUINCE (ON TOP OF UNIFIED STAGE)
local pts_quince = {
  {630, 485}, {655, 495}, {680, 520}, {705, 565}, {724, 610},
  {725, 640}, {705, 668}, {675, 676}, {630, 678}, {585, 675},
  {555, 655}, {538, 625}, {535, 585}, {550, 540}, {575, 510},
  {605, 488}, {622, 484}
}
local m_q = poly(pts_quince, true)

-- A. Dense golden body coat (buries any background overlap cleanly!)
work(m_q, {
  hand = "body",
  pile = p_q_rich_gold,
  angle = 1.35,
  coverage = 3.5,
  fill = true,
  edge = "firm"
})

-- B. Luminous sunlit left lobe (chrome yellow + yellow ochre)
b_f18:load(p_q_lit, 1.0)
b_f18:stroke({{605, 490}, {575, 535}, {550, 585}, {548, 628}, {566, 662}, {598, 676}}, {
  pressure = {0.9, 1.0, 1.0, 0.95, 0.9, 0.8}, swell = {0.85, 1.35, 0.85}
})

-- Central half-tone
b_f10:load(p_q_half, 0.95)
b_f10:stroke({{625, 505}, {605, 560}, {590, 615}, {615, 668}}, {pressure = 0.92})

-- Broad warm amber core shadow down right flank
b_f18:load(p_q_core, 1.0)
b_f18:stroke({{638, 495}, {665, 545}, {692, 595}, {696, 638}, {678, 670}, {645, 676}}, {
  pressure = {0.9, 1.0, 1.0, 0.95, 0.9, 0.8}, swell = {0.9, 1.35, 0.9}
})

-- Deep shadow on far right contour
b_f10:load(p_q_deep, 0.95)
b_f10:stroke({{660, 520}, {688, 565}, {710, 610}, {708, 645}, {690, 670}}, {pressure = 0.9})

-- Reflected limestone bounce along shaded contour
b_f10:load(p_q_reflect, 0.9)
b_f10:stroke({{670, 535}, {698, 580}, {718, 618}, {714, 650}, {695, 670}}, {pressure = 0.45})

-- Blend quince wet paint to fuse into voluptuous, fleshy roundness
blend(m_q, {angle = 1.35, coverage = 1.0})

-- Buttery impasto highlight on the knobby sunlit crest
b_r3:load(p_q_hi, 1.0)
b_r3:stroke({{570, 565}, {562, 595}, {566, 625}}, {pressure = {0.9, 1.0, 0.75}, swell = {0.8, 1.4, 0.7}})
b_r1:load(p_q_hi, 1.0)
b_r1:touch(562, 595, {pressure = 1.0})

-- Arching gnarled woody stem
b_r2:load(p_q_deep, 1.0)
b_r2:touch(628, 486, {pressure = 0.95})
b_r2:load(p_stem, 1.0)
b_r2:stroke({{628, 486}, {634, 472}, {642, 458}, {652, 448}}, {pressure = {0.98, 0.9, 0.5}})
b_r1:load(p_q_lit, 0.85)
b_r1:stroke({{629, 484}, {635, 472}, {643, 459}}, {pressure = 0.6})

-- Calyx eye and contact shadow
b_r2:load(p_q_deep, 1.0)
b_r2:touch(650, 678, {pressure = 0.95})
b_r2:load(p_jug_deep, 1.0)
b_r2:stroke({{570, 676}, {625, 680}, {675, 678}, {710, 670}}, {pressure = {0.85, 1.0, 0.9, 0.7}})

-- Transparent cast shadow of quince
b_f14:load(p_shadow_stone, 0.55)
b_f14:stroke({{690, 678}, {740, 684}, {805, 692}}, {pressure = {0.8, 0.2}, swell = {1.0, 1.3, 0.6}})

-- 5. PAINTING THE BODEGÓN KNIFE (FORGED STEEL, BRASS BOLSTER, TURNED WALNUT HANDLE)
-- Forged steel blade (width 12 units, from tip {645, 682} to bolster {765, 714})
b_f14:load(p_steel_mid, 1.0)
b_f14:stroke({{645, 682}, {705, 698}, {765, 714}}, {pressure = 1.0})

-- Steel spine (dark forged back)
b_r2:load(p_steel_dark, 1.0)
b_r2:stroke({{645, 682}, {705, 697}, {763, 711}}, {pressure = 0.95})

-- Reflected north light across blade bevel
b_r3:load(p_steel_lit, 1.0)
b_r3:stroke({{650, 683}, {707, 699}, {764, 713}}, {pressure = 0.95})

-- Razor cutting edge
b_r1:load(p_steel_lit, 1.0)
b_r1:stroke({{645, 682}, {705, 700}, {765, 715}}, {pressure = 1.0})

-- Blade contact shadow on limestone
b_r2:load(p_shadow_stone, 0.85)
b_r2:stroke({{647, 684}, {707, 702}, {764, 717}}, {pressure = {0.5, 0.9}})

-- Brass bolster collar ({763, 711} to {778, 716})
b_r5:load(p_brass, 1.0)
b_r5:stroke({{763, 711}, {771, 713}, {778, 716}}, {pressure = 1.0})
b_r2:load(p_brass_glint, 1.0)
b_r2:touch(771, 713, {pressure = 1.0})
b_r1:load(p_steel_dark, 0.9)
b_r1:stroke({{764, 715}, {778, 718}}, {pressure = 0.85})

-- Turned dark walnut handle projecting over front ledge ({778, 716} to {855, 755})
b_r5:load(p_knife_wood, 1.0)
b_r5:stroke({{778, 716}, {815, 735}, {855, 755}}, {pressure = 1.0, swell = {1.0, 1.45, 1.0}})

-- Lit upper crest of turned handle
b_r3:load(p_knife_wood_lit, 1.0)
b_r3:stroke({{779, 714}, {815, 733}, {854, 753}}, {pressure = 0.92})

-- Turned brass pommel cap at end of handle
b_r2:load(p_brass_glint, 1.0)
b_r2:touch(855, 755, {pressure = 1.0})

-- Soft handle cast shadow down front ledge face
b_r3:load(p_jug_deep, 0.8)
b_r3:stroke({{782, 716}, {786, 738}, {790, 758}}, {pressure = {0.85, 0.2}})

-- Specular chamfer highlight along ledge rim (y = 715)
b_r1:load(p_chamfer, 1.0)
b_r1:stroke({{-5, 715}, {350, 715}, {763, 715}}, {pressure = {0.85, 0.85}, shake = 0.02})
b_r1:stroke({{778, 715}, {900, 715}, {1005, 715}}, {pressure = {0.85, 0.85}, shake = 0.02})

-- 6. FOREGROUND WALNUTS (BETWEEN CÁNTARO AND QUINCE)
-- A. Whole ribbed walnut at {470, 644}
b_r5:load(p_nut_shell, 1.0)
b_r5:stroke({{458, 645}, {470, 641}, {482, 645}}, {pressure = 1.0, swell = {0.9, 1.4, 0.9}})
b_r5:load(p_nut_shell, 1.0)
b_r5:stroke({{460, 647}, {471, 645}, {482, 647}}, {pressure = 1.0})

b_r2:load(p_nut_deep, 0.95)
b_r2:stroke({{458, 645}, {470, 640}, {482, 645}}, {pressure = 0.85})
b_r1:load(p_q_hi, 0.9)
b_r1:stroke({{465, 639}, {471, 638}, {477, 640}}, {pressure = 0.85})

b_r3:load(p_jug_deep, 0.95)
b_r3:stroke({{456, 649}, {470, 651}, {484, 649}}, {pressure = 0.9})
b_f8:load(p_shadow_stone, 0.55)
b_f8:stroke({{478, 648}, {502, 652}}, {pressure = {0.8, 0.2}})

-- B. Cracked walnut half with ivory kernel at {510, 652}
b_r5:load(p_nut_shell, 1.0)
b_r5:stroke({{498, 655}, {510, 658}, {524, 653}}, {pressure = 1.0, swell = {0.9, 1.4, 0.9}})

b_r3:load(p_nut_deep, 1.0)
b_r3:stroke({{500, 652}, {510, 650}, {522, 650}}, {pressure = 0.95})

b_r3:load(p_nut_meat_shade, 1.0)
b_r3:stroke({{502, 651}, {510, 650}, {520, 651}}, {pressure = 0.95})

b_r2:load(p_nut_meat, 1.0)
b_r2:stroke({{502, 650}, {506, 648}, {510, 650}}, {pressure = 1.0})
b_r2:load(p_nut_meat, 1.0)
b_r2:stroke({{511, 650}, {515, 648}, {519, 650}}, {pressure = 1.0})

b_r1:load(p_q_hi, 1.0)
b_r1:touch(505, 648, {pressure = 1.0})
b_r1:touch(514, 648, {pressure = 1.0})

b_r1:load(p_q_lit, 0.9)
b_r1:stroke({{498, 654}, {510, 657}, {524, 652}}, {pressure = 0.85})

b_r3:load(p_jug_deep, 0.95)
b_r3:stroke({{498, 658}, {512, 660}, {526, 655}}, {pressure = 0.9})
b_f8:load(p_shadow_stone, 0.55)
b_f8:stroke({{520, 656}, {545, 659}}, {pressure = {0.8, 0.2}})

print("The Master Synthesis executed: seams dissolved, forms sculpted and blended, bodegón complete.")
