-- 1. Cast shadows on the stone shelf
p_cast_shadow = pile{{"raw umber", 4}, {"bone black", 2}, {"red earth", 1}, medium = 0.3}

local m_cast_pitcher = poly({{260, 568}, {340, 565}, {475, 590}, {460, 612}, {300, 605}, {260, 568}}, true):soften(8)
local m_cast_q1 = poly({{500, 578}, {575, 572}, {655, 590}, {640, 608}, {520, 602}, {500, 578}}, true):soften(6)
local m_cast_q2 = poly({{680, 610}, {755, 595}, {835, 612}, {820, 628}, {705, 622}, {680, 610}}, true):soften(6)

work(m_cast_pitcher, {hand = "body", tool = "filbert 12", pile = p_cast_shadow, angle = 0.2, coverage = 1.4})
work(m_cast_q1, {hand = "body", tool = "filbert 9", pile = p_cast_shadow, angle = 0.2, coverage = 1.4})
work(m_cast_q2, {hand = "body", tool = "filbert 9", pile = p_cast_shadow, angle = 0.2, coverage = 1.4})

-- 2. Pitcher Piles
p_jug_shadow = pile{{"raw umber", 5}, {"bone black", 3}, {"red earth", 2}, medium = 0.1}
p_jug_mid = pile{{"red earth", 4}, {"raw umber", 3}, {"yellow ochre", 2}, medium = 0.1}
p_jug_light = pile{{"yellow ochre", 4}, {"red earth", 2}, {"lead white", 2}, medium = 0.05}
p_jug_rim = pile{{"bone black", 5}, {"raw umber", 2}, medium = 0.1}

-- Pitcher body outline
o_pitcher = outline{
  {245, 275}, {240, 310}, {225, 360}, {195, 430}, {190, 480}, {210, 530}, {240, 568},
  {280, 573}, {320, 568}, {350, 530}, {370, 480}, {365, 430}, {335, 360}, {320, 310}, {315, 275},
  closed = true, char = "firm"
}
m_pitcher = o_pitcher:mask()

-- Shadow side of pitcher (right)
local m_pitcher_sh = m_pitcher * mask(function(x, y) return clamp((x - 265) / 60, 0, 1) end)
-- Midtone of pitcher (turning flank)
local m_pitcher_mid = m_pitcher * mask(function(x, y) return clamp(1 - math.abs(x - 265) / 55, 0, 1) end)
-- Light side of pitcher (left)
local m_pitcher_lt = m_pitcher * mask(function(x, y) return clamp((275 - x) / 55, 0, 1) end)

work(m_pitcher_sh, {hand = "body", tool = "filbert 12", pile = p_jug_shadow, angle = 1.4, coverage = 2.0, fill = true, clip = true})
work(m_pitcher_mid, {hand = "body", tool = "filbert 12", pile = p_jug_mid, angle = 1.3, coverage = 1.8, fill = true, clip = true})
work(m_pitcher_lt, {hand = "body", tool = "filbert 12", pile = p_jug_light, angle = 1.2, coverage = 1.8, fill = true, clip = true})

-- Blend across pitcher body to fuse values smoothly
blend(m_pitcher, {hand = "blend", tool = "badger 20", angle = 0.1, coverage = 1.2, clip = true})

-- Pitcher interior mouth cavity
local m_mouth = ellipse(280, 275, 34, 11)
work(m_mouth, {hand = "body", tool = "filbert 6", pile = p_jug_rim, angle = 0, coverage = 2.2, clip = true})

-- Handle
local m_handle = ribbon({{330, 320}, {385, 360}, {395, 410}, {380, 450}, {345, 475}}, 18)
work(m_handle, {hand = "body", tool = "filbert 6", pile = p_jug_mid, angle = 1.5, coverage = 2.0, clip = true})
local m_handle_sh = m_handle * mask(function(x, y) return clamp((x - 370) / 20, 0, 1) end)
work(m_handle_sh, {hand = "body", tool = "filbert 4", pile = p_jug_shadow, angle = 1.5, coverage = 1.5, clip = true})

-- 3. Quinces Piles
p_q_shadow = pile{{"raw umber", 3}, {"yellow ochre", 2}, {"green earth", 2}, medium = 0.1}
p_q_mid = pile{{"yellow ochre", 5}, {"chrome yellow", 2}, {"lead white", 2}, {"green earth", 1}, medium = 0.05}
p_q_light = pile{{"lead white", 4}, {"chrome yellow", 3}, {"yellow ochre", 2}, medium = 0.0}
p_q_blush = pile{{"vermilion", 2}, {"yellow ochre", 3}, {"lead white", 1}, medium = 0.1}

-- Quince 1 (upright)
o_q1 = outline{
  {515, 420}, {490, 455}, {475, 500}, {465, 545}, {490, 575}, {540, 582}, {585, 570}, {610, 535}, {605, 485}, {575, 440}, {545, 415},
  closed = true, char = "soft"
}
m_q1 = o_q1:mask()

local m_q1_sh = m_q1 * mask(function(x, y) return clamp((x - 520) / 45 + (y - 500) / 60, 0, 1) end)
local m_q1_mid = m_q1 * mask(function(x, y) return clamp(1 - math.abs((x - 520) / 45), 0, 1) end)
local m_q1_lt = m_q1 * mask(function(x, y) return clamp((530 - x) / 45 + (510 - y) / 60, 0, 1) end)

work(m_q1_sh, {hand = "body", tool = "filbert 8", pile = p_q_shadow, angle = 1.2, coverage = 2.0, fill = true, clip = true})
work(m_q1_mid, {hand = "body", tool = "filbert 8", pile = p_q_mid, angle = 1.0, coverage = 1.8, fill = true, clip = true})
work(m_q1_lt, {hand = "body", tool = "filbert 8", pile = p_q_light, angle = 0.8, coverage = 1.8, fill = true, clip = true})
blend(m_q1, {hand = "blend", tool = "badger 12", angle = 0.5, coverage = 1.0, clip = true})

-- Quince 2 (reclining)
o_q2 = outline{
  {660, 535}, {635, 565}, {640, 595}, {675, 615}, {725, 615}, {770, 590}, {785, 555}, {765, 525}, {715, 515},
  closed = true, char = "soft"
}
m_q2 = o_q2:mask()

local m_q2_sh = m_q2 * mask(function(x, y) return clamp((x - 700) / 50 + (y - 565) / 40, 0, 1) end)
local m_q2_mid = m_q2 * mask(function(x, y) return clamp(1 - math.abs((x - 700) / 50), 0, 1) end)
local m_q2_lt = m_q2 * mask(function(x, y) return clamp((715 - x) / 50 + (570 - y) / 40, 0, 1) end)

work(m_q2_sh, {hand = "body", tool = "filbert 8", pile = p_q_shadow, angle = 1.4, coverage = 2.0, fill = true, clip = true})
work(m_q2_mid, {hand = "body", tool = "filbert 8", pile = p_q_mid, angle = 1.1, coverage = 1.8, fill = true, clip = true})
work(m_q2_lt, {hand = "body", tool = "filbert 8", pile = p_q_light, angle = 0.9, coverage = 1.8, fill = true, clip = true})
blend(m_q2, {hand = "blend", tool = "badger 12", angle = 0.5, coverage = 1.0, clip = true})
