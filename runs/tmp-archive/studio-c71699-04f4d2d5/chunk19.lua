-- Unifying the background wall into a deep, atmospheric chiaroscuro backdrop

local handle_ribbon = ribbon({{630, 355}, {675, 365}, {696, 410}, {692, 455}, {668, 485}}, 16)
local handle_hole = poly({
  {636, 372}, {664, 388}, {675, 420}, {664, 462}, {652, 475}, {634, 400}
}, true)

local wall_mask = (rect(0, 0, 1000, 523) - pitcher_full - handle_ribbon) + handle_hole

p_wall_dark = pile{{"raw umber", 6}, {"bone black", 3}, {"yellow ochre", 1}, {"red earth", 1}, medium = 0.15}
p_wall_warm_mid = pile{{"raw umber", 5}, {"yellow ochre", 3}, {"bone black", 2}, {"lead white", 1}, medium = 0.15}
p_wall_left = pile{{"raw umber", 4}, {"yellow ochre", 4}, {"lead white", 2}, {"bone black", 1}, medium = 0.15}

-- 1. Base unifying coat across the entire wall
work(wall_mask, {hand = "broad", pile = p_wall_warm_mid, angle = 0, coverage = 1.8, fill = true, edge = 0.2})

-- 2. Modulate left and right smoothly
local m_wall_l = wall_mask * mask(function(x, y) return smoothstep(600, 100, x) end)
local m_wall_r = wall_mask * mask(function(x, y) return smoothstep(300, 800, x) end)

work(m_wall_l, {hand = "broad", pile = p_wall_left, angle = 0, coverage = 1.3, edge = 0.4})
work(m_wall_r, {hand = "broad", pile = p_wall_dark, angle = 0, coverage = 1.5, edge = 0.4})

-- 3. Soft broad blending horizontally across the entire wall
blend(wall_mask, {angle = 0, coverage = 2.0})

print("Background wall completely unified.")
