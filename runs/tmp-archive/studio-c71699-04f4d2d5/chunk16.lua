-- Painting the Whole Lemon and Cut Lemon Half

-- Lemon piles
p_lemon_lit = pile{{"chrome yellow", 5}, {"lead white", 4}, {"yellow ochre", 1}, medium = 0.1}
p_lemon_pure = pile{{"chrome yellow", 6}, {"yellow ochre", 3}, {"lead white", 1}, medium = 0.1}
p_lemon_mid = pile{{"yellow ochre", 6}, {"chrome yellow", 3}, {"raw umber", 1}, medium = 0.15}
p_lemon_green = pile{{"yellow ochre", 4}, {"green earth", 3}, {"chrome yellow", 2}, {"lead white", 1}, medium = 0.15}
p_lemon_shadow = pile{{"raw umber", 4}, {"yellow ochre", 4}, {"green earth", 2}, medium = 0.15}
p_lemon_refl = pile{{"yellow ochre", 5}, {"red earth", 2}, {"lead white", 2}, {"raw umber", 1}, medium = 0.2}
p_lemon_high = pile{{"lead white", 8}, {"chrome yellow", 2}, medium = 0.05}
p_pith = pile{{"lead white", 7}, {"yellow ochre", 2}, {"raw umber", 1}, medium = 0.1}
p_pulp_deep = pile{{"yellow ochre", 5}, {"chrome yellow", 3}, {"raw umber", 2}, medium = 0.2}
p_pulp_lit = pile{{"chrome yellow", 5}, {"lead white", 3}, {"yellow ochre", 2}, medium = 0.2}
p_sparkle = pile{{"lead white", 9}, {"chrome yellow", 1}, medium = 0.05}

-- -------------------------------------------------------------
-- 1. WHOLE LEMON
-- -------------------------------------------------------------
local whole_pts = {
  {305, 628}, {312, 615}, {330, 604}, {365, 597}, {395, 604},
  {418, 618}, {425, 638}, {415, 655}, {395, 668}, {365, 674},
  {335, 668}, {315, 652}, {305, 638}
}
local m_lemon_whole = poly(whole_pts, true)

-- Body color lay-in
work(m_lemon_whole, {hand = "body", pile = p_lemon_mid, angle = 0.2, coverage = 1.6, fill = true, edge = 0.2})

-- Lit upper-left volume
local m_w_lit = m_lemon_whole * mask(function(x, y)
  local v = (400 - x) * 0.6 + (665 - y) * 0.7
  return smoothstep(20, 70, v)
end)
work(m_w_lit, {hand = "body", pile = p_lemon_lit, angle = 0.2, coverage = 1.5, edge = 0.3})

-- Pure vibrant yellow in transition
local m_w_pure = m_lemon_whole * mask(function(x, y)
  local v = (x - 310) * (420 - x) * (y - 600) * (670 - y)
  return smoothstep(50000, 150000, v)
end)
work(m_w_pure, {hand = "body", pile = p_lemon_pure, angle = 0.2, coverage = 1.2, edge = 0.4})

-- Greenish tint near tip/nipple
local m_w_green = m_lemon_whole * ellipse(315, 626, 18, 14)
work(m_w_green, {hand = "glaze", pile = p_lemon_green, angle = 0.1, coverage = 1.3, edge = 0.4})

-- Core shadow on lower-right underbelly
local m_w_shadow = m_lemon_whole * mask(function(x, y)
  local v = (x - 340) * 0.5 + (y - 625) * 0.7
  return smoothstep(25, 60, v)
end)
work(m_w_shadow, {hand = "body", pile = p_lemon_shadow, angle = 0.3, coverage = 1.4, edge = 0.4})

-- Warm reflected light from table along bottom contour
local m_w_refl = m_lemon_whole * mask(function(x, y)
  if y < 652 then return 0 end
  return smoothstep(652, 672, y) * smoothstep(320, 360, x) * smoothstep(420, 380, x)
end)
work(m_w_refl, {hand = "glaze", pile = p_lemon_refl, angle = 0, coverage = 1.2, edge = 0.4})

-- Blend the whole lemon smoothly to round the volume
blend(m_lemon_whole, {angle = 0.2, coverage = 1.3})

-- Textured dimpling on peel (citrus pores)
stipple(m_w_lit, {pile = p_lemon_pure, width = 1.8, coverage = 0.9, feather = 0.3})
stipple(m_w_lit * ellipse(350, 620, 30, 20), {pile = p_lemon_lit, width = 1.6, coverage = 0.8, feather = 0.4})

-- Brilliant impasto highlight on the crest of the lemon
local b_high = brush{kind = "round", width = 3.5, point = 1, stiffness = 0.6}
b_high:load(p_lemon_high, 0.8)
b_high:stroke({{342, 615}, {355, 616}, {368, 620}}, {pressure = {0.7, 0.9, 0.3}, orient = "along"})
b_high:load(p_lemon_high, 0.5)
b_high:touch(310, 625, {pressure = 0.6}) -- tip accent

-- Dark contact occlusion under whole lemon
local b_dark = brush{kind = "round", width = 2.5, point = 1, stiffness = 0.5}
b_dark:load(p_pot_deep, 0.8)
b_dark:stroke({{335, 672}, {365, 675}, {395, 672}}, {pressure = {0.5, 0.9, 0.3}, orient = "along"})


-- -------------------------------------------------------------
-- 2. CUT LEMON HALF
-- -------------------------------------------------------------
local cut_pts = {
  {445, 652}, {460, 630}, {490, 624}, {520, 632}, {538, 652},
  {534, 678}, {515, 696}, {485, 703}, {458, 692}, {445, 672}
}
local m_lemon_cut = poly(cut_pts, true)

-- Cut face ellipse
local cx, cy = 488, 662
local rx, ry = 44, 37
local m_cut_face = ellipse(cx, cy, rx, ry)

-- 1. Outer rind (yellow skin rim)
work(m_lemon_cut, {hand = "body", pile = p_lemon_pure, angle = 0.2, coverage = 1.6, fill = true, edge = 0.2})

-- 2. Pale pith ring (albedo)
local m_pith_ring = ellipse(cx, cy, rx - 3, ry - 3) - ellipse(cx, cy, rx - 9, ry - 8)
work(m_pith_ring, {hand = "detail", pile = p_pith, angle = 0.1, coverage = 1.8, clip = true})

-- 3. Translucent pulp background
local m_pulp_area = ellipse(cx, cy, rx - 9, ry - 8)
work(m_pulp_area, {hand = "body", pile = p_pulp_deep, angle = 0.2, coverage = 1.6, fill = true, edge = 0.3})
work(m_pulp_area, {hand = "glaze", pile = p_pulp_lit, angle = 0, coverage = 1.3, edge = 0.4})

-- 4. Central pith hub and radial membranes (spokes)
local b_pith = brush{kind = "round", width = 1.8, point = 1, stiffness = 0.5}
b_pith:load(p_pith, 0.8)
-- Central hub
b_pith:touch(cx, cy, {pressure = 0.8})

-- Radial spokes
local n_segments = 9
for i = 1, n_segments do
  local ang = (i - 1) * (2 * math.pi / n_segments) + 0.15
  local x_end = cx + (rx - 9) * math.cos(ang)
  local y_end = cy + (ry - 8) * math.sin(ang)
  b_pith:load(p_pith, 0.7)
  b_pith:stroke({{cx, cy}, {cx + (x_end - cx) * 0.5, cy + (y_end - cy) * 0.5}, {x_end, y_end}},
    {pressure = {0.8, 0.6, 0.4}, orient = "along"})
end

-- 5. Moist, glistening juice sacs (sparkles and wet highlights)
local b_spark = brush{kind = "round", width = 1.5, point = 1, stiffness = 0.7}
for i = 1, n_segments do
  local ang1 = (i - 1) * (2 * math.pi / n_segments) + 0.15
  local ang2 = i * (2 * math.pi / n_segments) + 0.15
  local mid_ang = (ang1 + ang2) / 2
  local r_mid = (rx - 16) * 0.65
  local px = cx + r_mid * math.cos(mid_ang)
  local py = cy + (r_mid * (ry / rx)) * math.sin(mid_ang)
  
  -- Glistening dot on wet pulp
  b_spark:load(p_sparkle, 0.8)
  b_spark:touch(px, py, {pressure = 0.7})
  b_spark:touch(px + 3 * math.cos(mid_ang + 1.2), py + 2 * math.sin(mid_ang + 1.2), {pressure = 0.5})
end

-- Top lit edge of cut rind
local m_rind_lit = ribbon({{455, 638}, {485, 626}, {515, 632}}, 4)
work(m_rind_lit, {hand = "detail", pile = p_lemon_lit, angle = 0, coverage = 1.5})

-- Contact occlusion under half lemon
b_dark:load(p_pot_deep, 0.8)
b_dark:stroke({{475, 700}, {500, 704}, {525, 698}}, {pressure = {0.5, 0.9, 0.3}, orient = "along"})

print("Lemons completed.")
