-- Soften and unify the background wall and touch up handle opening

-- 1. Complete coverage in handle opening
local inner_handle_patch = ellipse(662, 420, 15, 45) * mask(function(x, y) return (x < 680 and x > 635) and 1 or 0 end)
work(inner_handle_patch, {hand = "detail", pile = p_wall_dark, angle = -0.4, coverage = 2.5, clip = true})

-- 2. Atmospheric veil over background wall
local handle_ribbon = ribbon({{630, 355}, {675, 365}, {696, 410}, {692, 455}, {668, 485}}, 16)
local wall_active = rect(0, 0, 1000, 525) - pitcher_full - handle_ribbon

-- Thin unifying glazes
local p_wall_glaze_dark = pile{{"raw umber", 5}, {"bone black", 3}, {"red earth", 1}, medium = 0.4}
local p_wall_glaze_light = pile{{"lead white", 5}, {"yellow ochre", 3}, {"raw umber", 2}, medium = 0.35}

local m_right_wall = wall_active * mask(function(x, y) return smoothstep(350, 750, x) end)
local m_left_wall = wall_active * mask(function(x, y) return smoothstep(650, 250, x) end)

work(m_right_wall, {hand = "glaze", pile = p_wall_glaze_dark, angle = -0.3, coverage = 1.4, edge = 0.4})
work(m_left_wall, {hand = "glaze", pile = p_wall_glaze_light, angle = -0.5, coverage = 1.3, edge = 0.4})

-- Soft broad blending pass across the entire wall
blend(wall_active, {angle = -0.4, coverage = 1.8})

print("Background unified into atmospheric chiaroscuro.")
