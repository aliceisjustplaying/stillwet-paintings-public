-- CHUNK 7: Sculpting forms, glazed pitcher, quinces, knife, and foliage

-- 1. Unify and smooth the stone shelf plane
p_stone_smooth = pile{{"lead white", 5}, {"yellow ochre", 2}, {"raw umber", 2}, {"bone black", 1}, medium = 0.2}
local m_table_plane = rect(0, 520, 1000, 102) - (m_pitcher + m_q1 + m_q2):shrink(2)
work(m_table_plane, {hand = "broad", tool = "filbert 22", pile = p_stone_smooth, angle = 0.0, coverage = 1.6, fill = true})
blend(m_table_plane, {hand = "blend", tool = "badger 30", angle = 0.0, coverage = 1.0})

-- Reinforced crisp catch-light on stone shelf edge
local b_rim = brush{kind = "flat", width = 3, stiffness = 0.8}
b_rim:load(pile{{"lead white", 6}, {"yellow ochre", 1}, {"raw umber", 1}}, 0.9)
b_rim:stroke({{0, 621}, {1000, 621}}, {pressure = {0.6, 0.7, 0.6}, orient = "along"})

-- Deepen contact shadows under objects
local p_contact = pile{{"bone black", 4}, {"raw umber", 4}, medium = 0.2}
local b_sh = brush{kind = "filbert", width = 8, stiffness = 0.6}
b_sh:load(p_contact, 0.8)
-- Under pitcher base
b_sh:stroke({{230, 570}, {330, 570}, {460, 590}}, {pressure = {0.8, 0.5, 0.1}})
-- Under Quince 1
b_sh:stroke({{490, 580}, {570, 580}, {640, 595}}, {pressure = {0.7, 0.5, 0.1}})
-- Under Quince 2
b_sh:stroke({{660, 612}, {740, 615}, {820, 622}}, {pressure = {0.7, 0.5, 0.1}})

-- 2. Refine the earthenware pitcher
-- Pitcher mouth opening and lip
local p_lip_lt = pile{{"lead white", 5}, {"yellow ochre", 3}, {"red earth", 1}}
local p_mouth_dark = pile{{"bone black", 6}, {"raw umber", 2}, medium = 0.05}
local b_detail = brush{kind = "round", width = 3, point = 1, stiffness = 0.7}

-- Interior dark of the neck
b_detail:load(p_mouth_dark, 0.9)
b_detail:stroke({{255, 275}, {280, 277}, {305, 275}}, {pressure = {0.8, 0.9, 0.7}})

-- Lip rim catching light on the left
b_detail:load(p_lip_lt, 0.9)
b_detail:stroke({{245, 273}, {270, 273}, {295, 274}}, {pressure = {0.8, 0.6, 0.2}})
-- Pouring spout dip
b_detail:stroke({{242, 272}, {247, 278}}, {pressure = {0.6, 0.3}})

-- Smooth the pitcher handle
local p_handle_body = pile{{"raw umber", 4}, {"red earth", 3}, {"bone black", 1}}
local p_handle_lt = pile{{"yellow ochre", 4}, {"red earth", 3}, {"lead white", 2}}
local b_h = brush{kind = "filbert", width = 7, stiffness = 0.6}
b_h:load(p_handle_body, 0.85)
b_h:stroke({{332, 320}, {372, 350}, {390, 395}, {382, 435}, {348, 465}}, {pressure = {0.7, 0.8, 0.8, 0.7, 0.6}})
-- Handle outer crest highlight
local b_pt = brush{kind = "round", width = 2.5, point = 1, stiffness = 0.7}
b_pt:load(p_handle_lt, 0.8)
b_pt:stroke({{335, 318}, {376, 348}, {393, 392}}, {pressure = {0.3, 0.6, 0.2}})

-- Modeling pitcher body volume with curved strokes
local p_jug_glow = pile{{"red earth", 4}, {"yellow ochre", 4}, {"lead white", 1}, medium = 0.05}
local b_body = brush{kind = "filbert", width = 12, stiffness = 0.5}
b_body:load(p_jug_glow, 0.7)
b_body:stroke({{225, 340}, {215, 410}, {225, 480}, {245, 540}}, {pressure = {0.5, 0.7, 0.7, 0.4}})
b_body:stroke({{250, 335}, {240, 410}, {250, 490}, {275, 550}}, {pressure = {0.5, 0.7, 0.6, 0.3}})

-- Glaze Specular Sheen (glossy highlight)
local p_glaze_hi = pile{{"lead white", 6}, {"yellow ochre", 1}, medium = 0.0}
b_pt:load(p_glaze_hi, 0.85)
b_pt:stroke({{235, 345}, {223, 405}, {228, 465}}, {pressure = {0.2, 0.65, 0.15}, ramps = {0.1, 0.2}})
-- Small shoulder glint
b_pt:touch(240, 330, {pressure = 0.5, drag = {1, 2}})

-- Subtle reflected light on the shaded right flank of pitcher
local p_jug_bounce = pile{{"yellow ochre", 3}, {"red earth", 2}, {"lead white", 1}, medium = 0.3}
b_body:load(p_jug_bounce, 0.4)
b_body:stroke({{360, 400}, {365, 450}, {355, 510}}, {pressure = {0.3, 0.4, 0.2}})

-- 3. Modeling Quince 1 (upright)
local p_q_crest = pile{{"chrome yellow", 4}, {"lead white", 3}, {"yellow ochre", 2}}
local p_q_blush_v = pile{{"vermilion", 3}, {"yellow ochre", 3}, {"lead white", 1}, medium = 0.1}
local p_q_olive_sh = pile{{"yellow ochre", 3}, {"raw umber", 3}, {"green earth", 2}, medium = 0.1}

-- Upper crest and shoulder of Quince 1
local b_q = brush{kind = "filbert", width = 8, stiffness = 0.5}
b_q:load(p_q_crest, 0.8)
b_q:stroke({{515, 430}, {495, 470}, {485, 520}, {500, 560}}, {pressure = {0.6, 0.8, 0.7, 0.4}})
b_q:stroke({{535, 435}, {525, 480}, {520, 535}, {535, 570}}, {pressure = {0.5, 0.8, 0.7, 0.4}})

-- Warm vermilion blush on the crest
b_q:load(p_q_blush_v, 0.5)
b_q:stroke({{505, 465}, {495, 505}, {505, 545}}, {pressure = {0.3, 0.5, 0.2}})

-- Deepen shadow on right flank of Quince 1
b_q:load(p_q_olive_sh, 0.7)
b_q:stroke({{565, 450}, {590, 495}, {595, 545}, {575, 570}}, {pressure = {0.5, 0.7, 0.7, 0.4}})

-- Woody stem at top of Quince 1
local p_wood = pile{{"raw umber", 4}, {"bone black", 2}, {"lead white", 1}}
b_pt:load(p_wood, 0.85)
b_pt:stroke({{525, 430}, {522, 410}, {515, 395}, {510, 385}}, {pressure = {0.7, 0.5, 0.4, 0.2}})
-- Stem highlight
b_pt:load(pile{{"lead white", 4}, {"yellow ochre", 2}, {"raw umber", 1}}, 0.5)
b_pt:stroke({{523, 410}, {517, 395}}, {pressure = {0.3, 0.2}})

-- Quince leaves
local p_leaf_body = pile{{"copper green", 4}, {"yellow ochre", 2}, {"raw umber", 2}, {"bone black", 1}}
local p_leaf_hi = pile{{"copper green", 3}, {"yellow ochre", 3}, {"lead white", 2}}
-- Leaf 1: reaching out to the left
local m_leaf1 = poly({{518, 405}, {490, 395}, {465, 400}, {485, 415}, {518, 408}}, true)
work(m_leaf1, {hand = "detail", tool = "round 2.5", pile = p_leaf_body, coverage = 1.8, clip = true})
b_pt:load(p_leaf_hi, 0.6)
b_pt:stroke({{515, 406}, {488, 402}, {468, 401}}, {pressure = {0.4, 0.3, 0.1}}) -- vein

-- Leaf 2: pointing up-right behind stem
local m_leaf2 = poly({{520, 398}, {538, 385}, {555, 375}, {548, 392}, {522, 400}}, true)
work(m_leaf2, {hand = "detail", tool = "round 2.5", pile = p_leaf_body, coverage = 1.8, clip = true})

-- 4. Modeling Quince 2 (reclining)
-- Upper illuminated ridge
b_q:load(p_q_crest, 0.8)
b_q:stroke({{670, 545}, {710, 535}, {750, 540}, {770, 560}}, {pressure = {0.5, 0.8, 0.7, 0.3}})
b_q:stroke({{660, 565}, {700, 555}, {740, 560}, {765, 575}}, {pressure = {0.4, 0.7, 0.6, 0.3}})

-- Flank blush
b_q:load(p_q_blush_v, 0.45)
b_q:stroke({{690, 545}, {725, 545}, {750, 555}}, {pressure = {0.2, 0.4, 0.2}})

-- Calyx / blossom end on Quince 2 (dark sepals)
local p_calyx = pile{{"bone black", 4}, {"raw umber", 4}}
b_pt:load(p_calyx, 0.8)
b_pt:touch(772, 562, {pressure = 0.5, drag = {2, 0}})
b_pt:touch(770, 560, {pressure = 0.4, drag = {1, -2}})
b_pt:touch(774, 565, {pressure = 0.4, drag = {2, 2}})
b_pt:touch(768, 564, {pressure = 0.4, drag = {-1, 1}})

-- 5. The Knife on the Stone Table
local p_knife_handle = pile{{"bone black", 4}, {"raw umber", 3}, {"red earth", 2}}
local p_knife_bolster = pile{{"yellow ochre", 4}, {"lead white", 2}, {"raw umber", 1}}
local p_knife_blade = pile{{"lead white", 5}, {"cobalt blue", 1}, {"bone black", 1}, {"raw umber", 1}}
local p_knife_edge = pile{{"lead white", 6}, {"bone black", 1}}

-- Cast shadow under knife
local b_k_sh = brush{kind = "round", width = 2, stiffness = 0.7}
b_k_sh:load(pile{{"bone black", 4}, {"raw umber", 4}}, 0.7)
b_k_sh:stroke({{368, 572}, {432, 588}, {515, 608}}, {pressure = {0.5, 0.6, 0.4}})

-- Knife Handle (dark carved walnut)
local b_k = brush{kind = "flat", width = 6, stiffness = 0.7}
b_k:load(p_knife_handle, 0.9)
b_k:stroke({{365, 568}, {428, 584}}, {pressure = {0.8, 0.85}, orient = "across"})
-- Brass bolster ring
b_detail:load(p_knife_bolster, 0.9)
b_detail:stroke({{428, 581}, {432, 587}}, {pressure = {0.7, 0.7}})

-- Steel blade
local m_blade = poly({{432, 583}, {512, 603}, {510, 606}, {432, 588}}, true)
work(m_blade, {hand = "detail", tool = "round 2", pile = p_knife_blade, coverage = 2.0, clip = true})

-- Razor cutting edge catch-light along the top of the blade
b_pt:load(p_knife_edge, 0.9)
b_pt:stroke({{432, 583}, {512, 603}}, {pressure = {0.6, 0.4, 0.1}})
