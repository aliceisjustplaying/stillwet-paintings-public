-- Definitive Modeling of the Glazed Earthenware Pitcher

-- Pitcher Piles
local p_pot_terra = pile{{"red earth", 6}, {"yellow ochre", 3}, {"raw umber", 2}, medium = 0.12}
local p_pot_shadow = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 2}, medium = 0.08}
local p_pot_throat = pile{{"bone black", 7}, {"raw umber", 3}, medium = 0.05}
local p_pot_olive = pile{{"yellow ochre", 5}, {"green earth", 3}, {"raw umber", 2}, {"lead white", 1}, medium = 0.15}
local p_pot_lit = pile{{"yellow ochre", 5}, {"red earth", 3}, {"lead white", 3}, medium = 0.12}
local p_pot_refl = pile{{"yellow ochre", 4}, {"red earth", 3}, {"raw umber", 2}, {"lead white", 1}, medium = 0.15}
local p_pot_spec = pile{{"lead white", 8}, {"yellow ochre", 2}, medium = 0.05}
local p_pot_contact = pile{{"bone black", 7}, {"raw umber", 3}, medium = 0.05}

-- Geometry
local body_pts = {
  {545, 310}, {590, 305}, {635, 310}, {642, 322}, {630, 370},
  {665, 415}, {680, 475}, {672, 545}, {645, 605}, {630, 626},
  {590, 631}, {550, 626}, {535, 605}, {508, 545}, {500, 475},
  {515, 415}, {550, 370}, {538, 322}
}
local jug_body = poly(body_pts, true)

local handle_pts = {
  {630, 355}, {675, 365}, {696, 410}, {692, 455}, {668, 485}
}
local handle_ribbon = ribbon(handle_pts, 16)
local handle_hole = poly({
  {636, 372}, {664, 388}, {675, 420}, {664, 462}, {652, 475}, {634, 400}
}, true)

local jug_all = (jug_body + handle_ribbon) - handle_hole
local jug_interior = ellipse(590, 313, 38, 9)

-- 1. Base terracotta coat over the jug body and handle
work(jug_all, {hand = "body", pile = p_pot_terra, angle = 0.1, coverage = 1.8, fill = true, edge = 0.15})

-- 2. Deep interior shadow inside mouth
work(jug_interior, {hand = "detail", pile = p_pot_throat, angle = 0, coverage = 2.0, clip = true})

-- 3. Core shadow on right side of belly and neck
local jug_sh = jug_all * mask(function(x, y)
  local t = (x - 575) / 75
  return clamp(t, 0, 1)
end) - jug_interior
work(jug_sh, {hand = "body", pile = p_pot_shadow, angle = 0.15, coverage = 1.6, edge = 0.35})

-- Cast shadow under handle on right belly
local handle_cast = ellipse(655, 430, 18, 35) * jug_all
work(handle_cast, {hand = "body", pile = p_pot_shadow, angle = 0.2, coverage = 1.4, edge = 0.35})

-- 4. Warm reflected light along right contour
local jug_rf = jug_all * mask(function(x, y)
  if x < 645 then return 0 end
  return smoothstep(645, 675, x) * smoothstep(360, 420, y) * smoothstep(625, 550, y) * 0.7
end)
work(jug_rf, {hand = "glaze", pile = p_pot_refl, angle = 0.3, coverage = 1.3, edge = 0.35})

-- 5. Lit area on left shoulder, belly, and neck
local jug_lt = jug_all * mask(function(x, y)
  local t = (600 - x) / 95
  return clamp(t, 0, 1)
end) - jug_interior
work(jug_lt, {hand = "body", pile = p_pot_lit, angle = 0.1, coverage = 1.6, edge = 0.25})

-- Olive glaze wash across the shoulder/belly transition
local jug_ol = jug_lt * ellipse(560, 460, 50, 70)
work(jug_ol, {hand = "glaze", pile = p_pot_olive, angle = 0.1, coverage = 1.3, edge = 0.4})

-- 6. Rim and handle lighting
-- Lit lip on left
local rim_lit = ribbon({{545, 318}, {585, 323}}, 5)
work(rim_lit, {hand = "detail", pile = p_pot_lit, angle = 0.1, coverage = 1.8})

-- Handle crest lit
local handle_lt = handle_ribbon * mask(function(x, y) return (y < 415 and x > 640) and 1 or 0 end) - handle_hole
work(handle_lt, {hand = "detail", pile = p_pot_lit, angle = -0.5, coverage = 1.5})

-- 7. Soft blend across the belly to fuse ceramic glaze wet-into-wet
blend(jug_all - jug_interior, {angle = 0.1, coverage = 1.3})

-- 8. Specular impasto highlights on the glaze
local b_point = brush{kind = "round", width = 3.2, point = 1, stiffness = 0.7}
b_point:load(p_pot_spec, 0.85)
-- Shoulder specular streak
b_point:stroke({{538, 432}, {542, 452}, {544, 468}}, {pressure = {0.75, 0.95, 0.3}, orient = "along"})
-- Rim specular touch
b_point:load(p_pot_spec, 0.8)
b_point:stroke({{550, 316}, {570, 321}, {582, 322}}, {pressure = {0.6, 0.85, 0.2}, orient = "along"})
-- Handle apex touch
b_point:load(p_pot_spec, 0.6)
b_point:touch(686, 395, {pressure = 0.7})

-- 9. Base contact occlusion shadow and near-cast shadow
b_point:load(p_pot_contact, 0.85)
b_point:stroke({{548, 627}, {590, 632}, {632, 627}}, {pressure = {0.5, 0.9, 0.4}, orient = "along"})

local jug_cast = poly({
  {580, 625}, {630, 625}, {710, 632}, {760, 638}, {780, 650},
  {760, 665}, {700, 665}, {620, 640}, {570, 630}
}, true)
work(jug_cast, {hand = "glaze", pile = p_cast_shadow, angle = 0.1, coverage = 1.5, edge = 0.4})

print("Glazed earthenware jug fully rendered.")
