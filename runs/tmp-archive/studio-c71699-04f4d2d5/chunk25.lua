-- Painting the Walnut, Refined Linen Napkin, and Touch-up of Cut Lemon Pulp

-- Common piles
local p_pith = pile{{"lead white", 7}, {"yellow ochre", 2}, {"raw umber", 1}, medium = 0.1}
local p_pulp_bg = pile{{"chrome yellow", 5}, {"yellow ochre", 4}, {"raw umber", 1}, medium = 0.15}
local p_pulp_lit = pile{{"chrome yellow", 6}, {"lead white", 3}, {"yellow ochre", 1}, medium = 0.15}
local p_spark = pile{{"lead white", 9}, {"chrome yellow", 1}, medium = 0.05}

local p_nut_base = pile{{"yellow ochre", 5}, {"raw umber", 4}, {"red earth", 2}, medium = 0.12}
local p_nut_dark = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 1}, medium = 0.1}
local p_nut_lit = pile{{"yellow ochre", 5}, {"lead white", 4}, {"raw umber", 2}, medium = 0.1}
local p_nut_high = pile{{"lead white", 7}, {"yellow ochre", 3}, medium = 0.05}

local p_linen_lit = pile{{"lead white", 8}, {"yellow ochre", 1}, {"raw umber", 1}, medium = 0.1}
local p_linen_crest = pile{{"lead white", 8}, {"yellow ochre", 2}, medium = 0.08}
local p_linen_high = pile{{"lead white", 9}, {"yellow ochre", 1}, medium = 0.05}
local p_linen_shadow = pile{{"lead white", 5}, {"bone black", 2}, {"raw umber", 2}, {"cobalt blue", 1}, medium = 0.15}
local p_linen_crease = pile{{"raw umber", 5}, {"bone black", 3}, {"cobalt blue", 1}, {"lead white", 1}, medium = 0.1}

local p_cast = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 1}, medium = 0.2}
local p_deep = pile{{"bone black", 7}, {"raw umber", 3}, medium = 0.05}

-- -------------------------------------------------------------
-- 1. TOUCH-UP CUT LEMON PULP
-- -------------------------------------------------------------
local cx, cy = 485, 652
local rx, ry = 42, 34

local m_pulp = ellipse(cx, cy, rx - 6, ry - 5)
work(m_pulp, {hand = "body", pile = p_pulp_bg, angle = 0.2, coverage = 2.0, fill = true, edge = 0.15})
work(m_pulp, {hand = "glaze", pile = p_pulp_lit, angle = 0, coverage = 1.4, edge = 0.2})

-- Central pith hub
local b_pith = brush{kind = "round", width = 2.0, point = 1, stiffness = 0.6}
b_pith:load(p_pith, 0.85)
b_pith:touch(cx, cy, {pressure = 0.9})

-- 8 radial membranes
local n_segs = 8
for i = 1, n_segs do
  local ang = (i - 1) * (2 * math.pi / n_segs) + 0.12
  local x_end = cx + (rx - 6) * math.cos(ang)
  local y_end = cy + (ry - 5) * math.sin(ang)
  b_pith:load(p_pith, 0.75)
  b_pith:stroke({{cx, cy}, {cx + (x_end - cx) * 0.5, cy + (y_end - cy) * 0.5}, {x_end, y_end}},
    {pressure = {0.8, 0.5, 0.3}, orient = "along"})
end

-- Sparkling highlights on juice vesicles
local b_spark = brush{kind = "round", width = 1.4, point = 1, stiffness = 0.8}
for i = 1, n_segs do
  local ang1 = (i - 1) * (2 * math.pi / n_segs) + 0.12
  local ang2 = i * (2 * math.pi / n_segs) + 0.12
  local mid_ang = (ang1 + ang2) / 2
  local r_mid = (rx - 12) * 0.65
  local px = cx + r_mid * math.cos(mid_ang)
  local py = cy + (r_mid * (ry / rx)) * math.sin(mid_ang)
  
  b_spark:load(p_spark, 0.85)
  b_spark:touch(px, py, {pressure = 0.8})
  b_spark:touch(px + 2.5 * math.cos(mid_ang + 1.2), py + 2 * math.sin(mid_ang + 1.2), {pressure = 0.6})
end


-- -------------------------------------------------------------
-- 2. WALNUT ON THE RIGHT
-- -------------------------------------------------------------
local wx, wy = 745, 658
local m_walnut = ellipse(wx, wy, 18, 14)

-- Body coat
work(m_walnut, {hand = "body", pile = p_nut_base, angle = 0.2, coverage = 1.8, fill = true, edge = 0.15})

-- Shadow side (right half)
local m_nut_sh = m_walnut * mask(function(x, y) return (x > wx - 2 or y > wy + 2) and 1 or 0 end)
work(m_nut_sh, {hand = "body", pile = p_nut_dark, angle = 0.3, coverage = 1.5, edge = 0.3})

-- Lit side (upper-left half)
local m_nut_lt = m_walnut * mask(function(x, y) return (x <= wx - 2 and y <= wy + 2) and 1 or 0 end)
work(m_nut_lt, {hand = "body", pile = p_nut_lit, angle = 0.1, coverage = 1.6, edge = 0.3})

-- Seam line down center
local b_line = brush{kind = "round", width = 1.8, point = 1, stiffness = 0.6}
b_line:load(p_nut_dark, 0.8)
b_line:stroke({{wx, wy - 13}, {wx + 1, wy}, {wx, wy + 13}}, {pressure = {0.3, 0.8, 0.4}, orient = "along"})

-- Rugged shell texture (stippling)
stipple(m_walnut, {pile = p_nut_dark, width = 1.4, coverage = 0.8, feather = 0.2})
stipple(m_nut_lt, {pile = p_nut_high, width = 1.2, coverage = 0.7, feather = 0.3})

-- Crisp shell ridge highlight
b_line:load(p_nut_high, 0.8)
b_line:stroke({{wx - 8, wy - 6}, {wx - 3, wy - 8}, {wx - 1, wy - 5}}, {pressure = {0.4, 0.8, 0.3}, orient = "along"})

-- Contact occlusion under walnut
local b_dark = brush{kind = "round", width = 2.5, point = 1, stiffness = 0.6}
b_dark:load(p_deep, 0.8)
b_dark:stroke({{wx - 15, wy + 11}, {wx, wy + 13}, {wx + 16, wy + 10}}, {pressure = {0.4, 0.9, 0.3}, orient = "along"})

-- Cast shadow to the right of walnut
local m_nut_cast = ellipse(wx + 22, wy + 8, 16, 7)
work(m_nut_cast, {hand = "glaze", pile = p_cast, angle = 0.1, coverage = 1.4, edge = 0.4})


-- -------------------------------------------------------------
-- 3. REFINED LINEN NAPKIN
-- -------------------------------------------------------------
local clean_napkin_pts = {
  {145, 550}, {185, 548}, {235, 565}, {270, 615}, {266, 674},
  {260, 742}, {225, 752}, {205, 736}, {175, 674}, {145, 645}, {138, 595}
}
local m_napkin_clean = poly(clean_napkin_pts, true)

-- Body coat of creamy linen
work(m_napkin_clean, {hand = "body", pile = p_linen_lit, angle = 0.3, coverage = 1.8, fill = true, edge = 0.12})

-- Cool blue-gray shadows in the troughs
local trough1 = ribbon({{165, 558}, {190, 620}, {205, 674}, {198, 730}}, 14) * m_napkin_clean
local trough2 = ribbon({{225, 578}, {242, 630}, {248, 674}, {242, 735}}, 10) * m_napkin_clean
work(trough1, {hand = "body", pile = p_linen_shadow, angle = 1.2, coverage = 1.5, edge = 0.3})
work(trough2, {hand = "body", pile = p_linen_shadow, angle = 1.2, coverage = 1.4, edge = 0.3})

-- Crease lines inside troughs
b_line:load(p_linen_crease, 0.7)
b_line:stroke({{166, 562}, {192, 625}, {206, 674}, {200, 728}}, {pressure = {0.3, 0.6, 0.3}, orient = "along"})

-- Lit fold ridges
local ridge1 = ribbon({{145, 550}, {175, 600}, {190, 674}, {180, 725}}, 14) * m_napkin_clean
local ridge2 = ribbon({{185, 552}, {212, 620}, {228, 674}, {224, 742}}, 12) * m_napkin_clean
local ridge3 = ribbon({{235, 568}, {258, 625}, {264, 674}, {258, 735}}, 10) * m_napkin_clean
work(ridge1, {hand = "body", pile = p_linen_lit, angle = 0.4, coverage = 1.3, edge = 0.3})
work(ridge2, {hand = "body", pile = p_linen_crest, angle = 0.4, coverage = 1.5, edge = 0.3})
work(ridge3, {hand = "body", pile = p_linen_crest, angle = 0.4, coverage = 1.4, edge = 0.3})

-- Soft blend across folds
blend(m_napkin_clean, {angle = 0.3, coverage = 1.2})

-- Clean hem lines along cloth edges
local b_hem = brush{kind = "round", width = 2.2, point = 1, stiffness = 0.6}
b_hem:load(p_linen_crest, 0.8)
b_hem:stroke({{266, 674}, {260, 742}, {225, 752}, {205, 736}, {175, 674}}, {pressure = {0.6, 0.8, 0.5}, orient = "along"})
b_hem:stroke({{175, 674}, {145, 645}, {138, 595}, {145, 550}}, {pressure = {0.5, 0.7, 0.4}, orient = "along"})

-- Sharp impasto highlights on the table edge folds
b_hem:load(p_linen_high, 0.9)
b_hem:touch(228, 674, {pressure = 0.85})
b_hem:touch(264, 674, {pressure = 0.8})

-- Occlusion shadow under hanging drape
b_dark:load(p_deep, 0.8)
b_dark:stroke({{262, 745}, {226, 755}, {204, 739}}, {pressure = {0.5, 0.9, 0.4}, orient = "along"})

print("Walnut, napkin, and lemon pulp completed.")
