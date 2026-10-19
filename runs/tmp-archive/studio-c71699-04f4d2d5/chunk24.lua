-- Definitive painting of the Lemons and Spiral Peel

-- Piles
local p_lem_base = pile{{"yellow ochre", 5}, {"chrome yellow", 4}, {"raw umber", 1}, medium = 0.12}
local p_lem_pure = pile{{"chrome yellow", 7}, {"yellow ochre", 2}, {"lead white", 1}, medium = 0.1}
local p_lem_lit = pile{{"chrome yellow", 5}, {"lead white", 4}, {"yellow ochre", 1}, medium = 0.1}
local p_lem_high = pile{{"lead white", 8}, {"chrome yellow", 2}, medium = 0.05}
local p_lem_green = pile{{"yellow ochre", 4}, {"green earth", 4}, {"chrome yellow", 2}, medium = 0.15}
local p_lem_shad = pile{{"raw umber", 5}, {"yellow ochre", 3}, {"green earth", 2}, medium = 0.15}
local p_lem_refl = pile{{"yellow ochre", 5}, {"red earth", 2}, {"lead white", 2}, medium = 0.15}

local p_pith = pile{{"lead white", 7}, {"yellow ochre", 2}, {"raw umber", 1}, medium = 0.1}
local p_pulp_bg = pile{{"chrome yellow", 5}, {"yellow ochre", 4}, {"raw umber", 1}, medium = 0.15}
local p_pulp_lit = pile{{"chrome yellow", 6}, {"lead white", 3}, {"yellow ochre", 1}, medium = 0.15}
local p_spark = pile{{"lead white", 9}, {"chrome yellow", 1}, medium = 0.05}

local p_cast = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 1}, medium = 0.2}
local p_deep = pile{{"bone black", 7}, {"raw umber", 3}, medium = 0.05}

-- -------------------------------------------------------------
-- 1. WHOLE LEMON REFINEMENT
-- -------------------------------------------------------------
local whole_pts = {
  {305, 628}, {312, 615}, {330, 604}, {365, 597}, {395, 604},
  {418, 618}, {425, 638}, {415, 655}, {395, 668}, {365, 674},
  {335, 668}, {315, 652}, {305, 638}
}
local m_lemon_whole = poly(whole_pts, true)

-- Body color coat
work(m_lemon_whole, {hand = "body", pile = p_lem_pure, angle = 0.2, coverage = 1.6, fill = true, edge = 0.15})

-- Lit volume
local m_w_lit = m_lemon_whole * mask(function(x, y)
  local v = (400 - x) * 0.6 + (665 - y) * 0.7
  return smoothstep(20, 70, v)
end)
work(m_w_lit, {hand = "body", pile = p_lem_lit, angle = 0.2, coverage = 1.5, edge = 0.3})

-- Greenish tint near nipple
local m_w_green = m_lemon_whole * ellipse(315, 626, 18, 14)
work(m_w_green, {hand = "glaze", pile = p_lem_green, angle = 0.1, coverage = 1.3, edge = 0.4})

-- Core shadow
local m_w_shadow = m_lemon_whole * mask(function(x, y)
  local v = (x - 340) * 0.5 + (y - 625) * 0.7
  return smoothstep(25, 60, v)
end)
work(m_w_shadow, {hand = "body", pile = p_lem_shad, angle = 0.3, coverage = 1.4, edge = 0.4})

-- Reflected warm light from oak table
local m_w_refl = m_lemon_whole * mask(function(x, y)
  if y < 652 then return 0 end
  return smoothstep(652, 672, y) * smoothstep(320, 360, x) * smoothstep(420, 380, x)
end)
work(m_w_refl, {hand = "glaze", pile = p_lem_refl, angle = 0, coverage = 1.2, edge = 0.4})

-- Blend whole lemon volume
blend(m_lemon_whole, {angle = 0.2, coverage = 1.3})

-- Peel dimple stippling
stipple(m_w_lit, {pile = p_lem_pure, width = 1.8, coverage = 0.9, feather = 0.3})
stipple(m_w_lit * ellipse(350, 620, 30, 20), {pile = p_lem_lit, width = 1.6, coverage = 0.8, feather = 0.4})

-- Impasto highlight
local b_high = brush{kind = "round", width = 3.5, point = 1, stiffness = 0.7}
b_high:load(p_lem_high, 0.8)
b_high:stroke({{342, 615}, {355, 616}, {368, 620}}, {pressure = {0.7, 0.9, 0.3}, orient = "along"})
b_high:load(p_lem_high, 0.6)
b_high:touch(309, 626, {pressure = 0.6})

-- Stem calyx dot on right
local b_calyx = brush{kind = "round", width = 2.0, point = 1, stiffness = 0.6}
b_calyx:load(p_lem_shad, 0.8)
b_calyx:touch(423, 638, {pressure = 0.7})

-- Contact occlusion under whole lemon
local b_dark = brush{kind = "round", width = 2.5, point = 1, stiffness = 0.6}
b_dark:load(p_deep, 0.8)
b_dark:stroke({{335, 673}, {365, 675}, {395, 673}}, {pressure = {0.5, 0.9, 0.3}, orient = "along"})


-- -------------------------------------------------------------
-- 2. CUT LEMON HALF (tilted, resting on table)
-- -------------------------------------------------------------
local cx, cy = 485, 652
local rx, ry = 42, 34

-- Whole cut lemon body silhouette
local m_cut_body = ellipse(cx, cy, rx + 2, ry + 2)

-- Outer rind
work(m_cut_body, {hand = "body", pile = p_lem_pure, angle = 0.1, coverage = 1.8, fill = true, edge = 0.1})

-- Pale pith ring
local m_pith_ring = ellipse(cx, cy, rx, ry) - ellipse(cx, cy, rx - 6, ry - 5)
work(m_pith_ring, {hand = "detail", pile = p_pith, angle = 0.1, coverage = 2.0, clip = true})

-- Translucent pulp bed
local m_pulp = ellipse(cx, cy, rx - 6, ry - 5)
work(m_pulp, {hand = "body", pile = p_pulp_bg, angle = 0.2, coverage = 1.8, fill = true, edge = 0.2})
work(m_pulp, {hand = "glaze", pile = p_pulp_lit, angle = 0, coverage = 1.3, edge = 0.3})

-- Central pith hub
local b_pith = brush{kind = "round", width = 2.0, point = 1, stiffness = 0.6}
b_pith:load(p_pith, 0.8)
b_pith:touch(cx, cy, {pressure = 0.85})

-- 8 radial membranes
local n_segs = 8
for i = 1, n_segs do
  local ang = (i - 1) * (2 * math.pi / n_segs) + 0.12
  local x_end = cx + (rx - 6) * math.cos(ang)
  local y_end = cy + (ry - 5) * math.sin(ang)
  b_pith:load(p_pith, 0.7)
  b_pith:stroke({{cx, cy}, {cx + (x_end - cx) * 0.5, cy + (y_end - cy) * 0.5}, {x_end, y_end}},
    {pressure = {0.8, 0.5, 0.3}, orient = "along"})
end

-- Wet glistening sparkles on pulp juice sacs
local b_spark = brush{kind = "round", width = 1.5, point = 1, stiffness = 0.8}
for i = 1, n_segs do
  local ang1 = (i - 1) * (2 * math.pi / n_segs) + 0.12
  local ang2 = i * (2 * math.pi / n_segs) + 0.12
  local mid_ang = (ang1 + ang2) / 2
  local r_mid = (rx - 12) * 0.65
  local px = cx + r_mid * math.cos(mid_ang)
  local py = cy + (r_mid * (ry / rx)) * math.sin(mid_ang)
  
  b_spark:load(p_spark, 0.8)
  b_spark:touch(px, py, {pressure = 0.75})
  b_spark:touch(px + 2.5 * math.cos(mid_ang + 1.2), py + 2 * math.sin(mid_ang + 1.2), {pressure = 0.55})
end

-- Lit top rim of the cut rind
local m_cut_rim_lit = ribbon({{452, 634}, {485, 622}, {518, 630}}, 3.5)
work(m_cut_rim_lit, {hand = "detail", pile = p_lem_lit, angle = 0, coverage = 1.6})

-- Contact shadow under cut lemon
b_dark:load(p_deep, 0.8)
b_dark:stroke({{460, 674}, {485, 676}, {515, 674}}, {pressure = {0.5, 0.9, 0.3}, orient = "along"})

-- Cast shadow to the right of cut lemon
local m_cut_cast = ellipse(535, 674, 25, 8)
work(m_cut_cast, {hand = "glaze", pile = p_cast, angle = 0.1, coverage = 1.4, edge = 0.4})


-- -------------------------------------------------------------
-- 3. CURLING LEMON PEEL (ZEST SPIRAL)
-- -------------------------------------------------------------
-- Starts from cut lemon left rim, curls forward and drops gracefully
local peel_b = brush{kind = "round", width = 3.4, point = 1, stiffness = 0.7}

-- Cast shadow of peel on table apron
b_dark:load(p_deep, 0.6)
b_dark:stroke({{440, 688}, {426, 708}, {420, 725}}, {pressure = {0.2, 0.5, 0.2}, orient = "along"})

-- Inner pale pith ribbon
peel_b:load(p_pith, 0.8)
peel_b:stroke({{450, 662}, {438, 678}, {425, 696}}, {pressure = {0.6, 0.8, 0.5}, orient = "along"})

-- Outer vibrant yellow peel ribbon
peel_b:load(p_lem_pure, 0.85)
peel_b:stroke({{425, 696}, {416, 715}, {425, 726}, {438, 720}, {444, 706}}, {pressure = {0.6, 0.9, 0.7, 0.4}, orient = "along"})

-- Crisp highlight along the sharp edge of the peel curl
local b_curl_edge = brush{kind = "round", width = 1.4, point = 1, stiffness = 0.8}
b_curl_edge:load(p_spark, 0.8)
b_curl_edge:stroke({{416, 712}, {424, 725}, {436, 720}}, {pressure = {0.4, 0.8, 0.3}, orient = "along"})

print("Lemons and spiral peel definitively rendered.")
