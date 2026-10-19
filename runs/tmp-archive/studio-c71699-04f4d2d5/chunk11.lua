-- Modeling the Glazed Earthenware Pitcher

-- Define Pitcher Piles
p_pot_base = pile{{"red earth", 5}, {"yellow ochre", 3}, {"raw umber", 2}, medium = 0.15}
p_pot_dark = pile{{"raw umber", 5}, {"bone black", 3}, {"red earth", 2}, medium = 0.1}
p_pot_deep = pile{{"bone black", 6}, {"raw umber", 4}, medium = 0.05}
p_pot_refl = pile{{"yellow ochre", 4}, {"red earth", 3}, {"raw umber", 2}, {"lead white", 1}, medium = 0.15}
p_pot_mid = pile{{"yellow ochre", 5}, {"red earth", 3}, {"lead white", 2}, {"raw umber", 1}, medium = 0.15}
p_pot_lit = pile{{"yellow ochre", 5}, {"lead white", 4}, {"red earth", 1}, {"raw umber", 1}, medium = 0.15}
p_pot_high = pile{{"lead white", 7}, {"yellow ochre", 2}, {"raw umber", 1}, medium = 0.1}
p_pot_glaze_olive = pile{{"yellow ochre", 4}, {"raw umber", 3}, {"green earth", 2}, {"lead white", 1}, medium = 0.2}

-- Geometry of pitcher
local body_pts = {
  {545, 310}, {590, 305}, {635, 310}, {642, 322}, {630, 370},
  {665, 415}, {680, 475}, {672, 545}, {645, 605}, {630, 626},
  {590, 631}, {550, 626}, {535, 605}, {508, 545}, {500, 475},
  {515, 415}, {550, 370}, {538, 322}
}
pitcher_full = poly(body_pts, true)

-- Handle
local handle_pts = {
  {630, 355}, {675, 365}, {696, 410}, {692, 455}, {668, 485}
}
local handle_ribbon = ribbon(handle_pts, 15)

-- Combined silhouette
local jug_all = pitcher_full + handle_ribbon

-- Sub-regions
local jug_interior = ellipse(590, 313, 38, 9)
local jug_rim = ribbon({{545, 318}, {590, 324}, {635, 318}}, 6)

-- 1. Base terracotta coat over the whole jug
work(jug_all, {hand = "body", pile = p_pot_base, angle = 0.1, coverage = 1.6, fill = true, edge = 0.2})

-- 2. Interior dark opening
work(jug_interior, {hand = "detail", pile = p_pot_deep, angle = 0, coverage = 2.0, clip = true})

-- 3. Core shadow on the right side of the belly and neck
local jug_shadow = jug_all * mask(function(x, y)
  -- Terminator runs diagonally across x ≈ 590 to 620
  local t = (x - 580) / 70
  return clamp(t, 0, 1)
end) - jug_interior
work(jug_shadow, {hand = "body", pile = p_pot_dark, angle = 0.15, coverage = 1.5, edge = 0.4})

-- 4. Cast shadow under handle on right belly
local handle_cast = ellipse(655, 430, 18, 35) * jug_all
work(handle_cast, {hand = "body", pile = p_pot_deep, angle = 0.2, coverage = 1.3, edge = 0.4})

-- 5. Reflected warm light along right edge (bouncing from table and room)
local jug_refl = jug_all * mask(function(x, y)
  if x < 645 then return 0 end
  local t = smoothstep(645, 675, x) * smoothstep(360, 420, y) * smoothstep(625, 550, y)
  return t * 0.7
end)
work(jug_refl, {hand = "scumble", pile = p_pot_refl, angle = 0.3, coverage = 1.2, edge = 0.4})

-- 6. Lit area on the left shoulder, belly and neck
local jug_lit = jug_all * mask(function(x, y)
  local t = (600 - x) / 90
  return clamp(t, 0, 1)
end) - jug_interior
work(jug_lit, {hand = "body", pile = p_pot_mid, angle = 0.1, coverage = 1.5, edge = 0.3})

-- Olive glaze wash over upper belly and shoulder
local jug_olive = jug_lit * ellipse(560, 460, 50, 70)
work(jug_olive, {hand = "glaze", pile = p_pot_glaze_olive, angle = 0.1, coverage = 1.2, edge = 0.5})

-- Stronger light on left shoulder curve
local jug_light_accent = jug_all * ellipse(545, 450, 28, 45)
work(jug_light_accent, {hand = "body", pile = p_pot_lit, angle = 0.05, coverage = 1.4, edge = 0.3})

-- 7. Rim and handle lighting
-- Rim lit edge
local rim_lit = jug_rim * mask(function(x, y) return x < 590 and 1 or 0 end)
work(rim_lit, {hand = "detail", pile = p_pot_lit, angle = 0.1, coverage = 1.5})
-- Handle top lit
local handle_lit = handle_ribbon * mask(function(x, y) return y < 410 and 1 or 0 end)
work(handle_lit, {hand = "detail", pile = p_pot_mid, angle = -0.5, coverage = 1.4})

-- 8. Blend across the belly and neck to fuse the ceramic glaze wet-into-wet
blend(jug_all - jug_interior, {angle = 0.1, coverage = 1.3})

-- 9. Crisp impasto highlights on the glaze
local b_point = brush{kind = "round", width = 3.5, point = 1, stiffness = 0.6}
b_point:load(p_pot_high, 0.8)
-- Specular dot/dash on shoulder
b_point:stroke({{538, 435}, {542, 455}, {544, 470}}, {pressure = {0.7, 0.9, 0.3}, orient = "along"})
-- Crisp touch on the lit rim
b_point:load(p_pot_high, 0.7)
b_point:stroke({{550, 316}, {570, 321}, {585, 322}}, {pressure = {0.6, 0.8, 0.2}, orient = "along"})
-- Touch on handle apex
b_point:load(p_pot_high, 0.5)
b_point:touch(685, 395, {pressure = 0.6})

print("Pitcher modeled with glazed ceramic form and specular highlights.")
