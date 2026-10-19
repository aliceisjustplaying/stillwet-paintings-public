-- Refining the pitcher, handle opening, and base contact

-- 1. Fill handle opening with background dark wall paint
local handle_hole = poly({
  {636, 372}, {664, 388}, {675, 420}, {664, 462}, {652, 475}, {634, 400}
}, true)
work(handle_hole, {hand = "detail", pile = p_wall_dark, angle = -0.4, coverage = 2.0, clip = true})

-- 2. Fuse the shadow side of the belly and neck
local jug_shadow_area = pitcher_full * mask(function(x, y)
  return smoothstep(575, 630, x)
end) - ellipse(590, 313, 38, 9)

work(jug_shadow_area, {hand = "glaze", pile = p_pot_dark, angle = 1.3, coverage = 1.2, edge = 0.4})
blend(jug_shadow_area, {angle = 1.4, coverage = 1.5})

-- 3. Occlusion / contact shadow at base of jug
local jug_contact = ribbon({{545, 627}, {590, 632}, {632, 627}}, 6)
local p_occlusion = pile{{"bone black", 7}, {"raw umber", 3}, medium = 0.05}
work(jug_contact, {hand = "detail", pile = p_occlusion, angle = 0, coverage = 1.8, edge = 0.2})

-- 4. Cast shadow immediately behind and right of jug on the table
local jug_near_shadow = poly({
  {570, 627}, {630, 627}, {680, 635}, {720, 642}, {670, 645}, {600, 635}
}, true)
work(jug_near_shadow, {hand = "glaze", pile = p_cast_shadow, angle = 0.1, coverage = 1.4, edge = 0.3})

print("Pitcher refined and anchored.")
