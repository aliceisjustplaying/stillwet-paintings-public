-- Refining the Linen Napkin and Painting the Sunlit Walnut on the Right

-- Piles
local p_table_clean = pile{{"yellow ochre", 5}, {"raw umber", 4}, {"lead white", 2}, {"red earth", 1}, medium = 0.15}
local p_apron_clean = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 2}, medium = 0.12}

local p_lin_lit = pile{{"lead white", 8}, {"yellow ochre", 1}, {"raw umber", 1}, medium = 0.1}
local p_lin_crest = pile{{"lead white", 8}, {"yellow ochre", 2}, medium = 0.08}
local p_lin_high = pile{{"lead white", 9}, {"yellow ochre", 1}, medium = 0.05}
local p_lin_sh = pile{{"lead white", 5}, {"bone black", 2}, {"raw umber", 2}, {"cobalt blue", 1}, medium = 0.15}
local p_lin_deep = pile{{"raw umber", 5}, {"bone black", 3}, {"cobalt blue", 1}, {"lead white", 1}, medium = 0.1}

local p_nut_base = pile{{"yellow ochre", 5}, {"raw umber", 4}, {"red earth", 2}, medium = 0.12}
local p_nut_dark = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 1}, medium = 0.1}
local p_nut_lit = pile{{"yellow ochre", 5}, {"lead white", 4}, {"raw umber", 2}, medium = 0.1}
local p_nut_high = pile{{"lead white", 7}, {"yellow ochre", 3}, medium = 0.05}
local p_cast = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 1}, medium = 0.2}
local p_deep = pile{{"bone black", 7}, {"raw umber", 3}, medium = 0.05}

-- -------------------------------------------------------------
-- 1. TAILORED LINEN NAPKIN
-- -------------------------------------------------------------
-- Define crisp, folded geometry
local nap_pts = {
  {135, 545}, {245, 548}, {265, 605}, {262, 674},
  {258, 742}, {218, 745}, {212, 742}, {165, 740}, {165, 674},
  {135, 630}, {130, 580}
}
local m_nap = poly(nap_pts, true)

-- Clean up table top and front apron around napkin
local m_cut_table = rect(100, 520, 200, 155) - m_nap
work(m_cut_table, {hand = "body", pile = p_table_clean, angle = 0, coverage = 1.8, fill = true, edge = 0.1})

local m_cut_apron = rect(100, 675, 200, 125) - m_nap
work(m_cut_apron, {hand = "body", pile = p_apron_clean, angle = 0, coverage = 1.8, fill = true, edge = 0.1})

-- Base coat of creamy linen
work(m_nap, {hand = "body", pile = p_lin_lit, angle = 0.3, coverage = 1.8, fill = true, edge = 0.1})

-- Sculpt two distinct vertical flute folds hanging over table front
-- Trough between Fold 1 and Fold 2
local trough = ribbon({{185, 555}, {205, 620}, {214, 674}, {210, 742}}, 12) * m_nap
work(trough, {hand = "body", pile = p_lin_sh, angle = 1.2, coverage = 1.5, edge = 0.3})

-- Left flank shadow (falling away toward left)
local left_sh = m_nap * mask(function(x, y) return smoothstep(165, 132, x) end)
work(left_sh, {hand = "body", pile = p_lin_sh, angle = 1.1, coverage = 1.4, edge = 0.3})

-- Fold 1 crest (left hanging fold)
local fold1 = ribbon({{155, 548}, {180, 610}, {188, 674}, {185, 740}}, 14) * m_nap
work(fold1, {hand = "body", pile = p_lin_crest, angle = 0.5, coverage = 1.5, edge = 0.3})

-- Fold 2 crest (right hanging fold)
local fold2 = ribbon({{215, 555}, {235, 615}, {242, 674}, {238, 742}}, 14) * m_nap
work(fold2, {hand = "body", pile = p_lin_crest, angle = 0.5, coverage = 1.5, edge = 0.3})

-- Blend across folds gently
blend(m_nap, {angle = 0.4, coverage = 1.2})

-- Crease lines with pointed brush
local b_pen = brush{kind = "round", width = 1.8, point = 1, stiffness = 0.6}
b_pen:load(p_lin_deep, 0.7)
b_pen:stroke({{188, 560}, {206, 625}, {215, 674}, {211, 740}}, {pressure = {0.3, 0.6, 0.3}, orient = "along"})

-- Sharp impasto highlights on the table edge folds
local b_touch = brush{kind = "filbert", width = 3.5, stiffness = 0.7}
b_touch:load(p_lin_high, 0.9)
b_touch:touch(188, 674, {pressure = 0.85})
b_touch:touch(242, 674, {pressure = 0.85})

-- Clean hem lines along bottom drape
local b_line = brush{kind = "round", width = 2.0, point = 1, stiffness = 0.6}
b_line:load(p_lin_crest, 0.8)
b_line:stroke({{165, 740}, {212, 742}, {218, 745}, {258, 742}}, {pressure = {0.6, 0.8, 0.5}, orient = "along"})

-- Occlusion shadow under hanging drape
local b_dark = brush{kind = "round", width = 2.8, point = 1, stiffness = 0.6}
b_dark:load(p_deep, 0.85)
b_dark:stroke({{164, 742}, {212, 745}, {218, 748}, {260, 744}}, {pressure = {0.5, 0.9, 0.4}, orient = "along"})


-- -------------------------------------------------------------
-- 2. SUNLIT WALNUT ON THE RIGHT (x = 790, y = 656)
-- -------------------------------------------------------------
local wx, wy = 790, 656
local m_walnut = ellipse(wx, wy, 16, 12)

-- Body coat
work(m_walnut, {hand = "body", pile = p_nut_base, angle = 0.2, coverage = 1.8, fill = true, edge = 0.12})

-- Shadow side (right and lower side)
local m_nut_sh = m_walnut * mask(function(x, y) return (x > wx - 1 or y > wy + 2) and 1 or 0 end)
work(m_nut_sh, {hand = "body", pile = p_nut_dark, angle = 0.3, coverage = 1.5, edge = 0.3})

-- Lit side (upper-left half)
local m_nut_lt = m_walnut * mask(function(x, y) return (x <= wx - 1 and y <= wy + 2) and 1 or 0 end)
work(m_nut_lt, {hand = "body", pile = p_nut_lit, angle = 0.1, coverage = 1.6, edge = 0.3})

-- Suture / seam line down center
b_line:load(p_nut_dark, 0.8)
b_line:stroke({{wx, wy - 11}, {wx + 1, wy}, {wx, wy + 11}}, {pressure = {0.3, 0.7, 0.4}, orient = "along"})

-- Rugged shell texture (stippling)
stipple(m_walnut, {pile = p_nut_dark, width = 1.3, coverage = 0.8, feather = 0.2})
stipple(m_nut_lt, {pile = p_nut_high, width = 1.1, coverage = 0.7, feather = 0.3})

-- Sharp crest highlight
b_line:load(p_nut_high, 0.85)
b_line:stroke({{wx - 7, wy - 5}, {wx - 3, wy - 7}, {wx - 1, wy - 4}}, {pressure = {0.4, 0.8, 0.2}, orient = "along"})

-- Contact occlusion under walnut
b_dark:load(p_deep, 0.85)
b_dark:stroke({{wx - 14, wy + 9}, {wx, wy + 11}, {wx + 14, wy + 8}}, {pressure = {0.4, 0.8, 0.3}, orient = "along"})

-- Cast shadow extending softly to the right
local m_nut_cast = ellipse(wx + 20, wy + 7, 15, 6)
work(m_nut_cast, {hand = "glaze", pile = p_cast, angle = 0.1, coverage = 1.4, edge = 0.4})

-- Clean up table edge highlight line in this region
local p_edge_light = pile{{"lead white", 6}, {"yellow ochre", 3}, {"raw umber", 1}, medium = 0.1}
local b_edge = brush{kind = "rigger", width = 1.5, point = 1, stiffness = 0.7}
b_edge:load(p_edge_light, 0.7)
b_edge:stroke({{wx + 25, 674}, {1000, 674}}, {pressure = {0.6, 0.7, 0.4}, orient = "along"})

print("Napkin and sunlit walnut completed.")
