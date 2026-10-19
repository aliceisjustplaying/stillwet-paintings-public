-- Chunk 9: Carving negative space, modeling the jug and quince

-- 1. Carve handle negative space and outer wall boundary
local m_handle_hole = ellipse(265, 355, 18, 35)
work(m_handle_hole, {hand="body", pile=p_wall_left, angle=0.0, coverage=1.8, fill=true, clip=true})

-- Clean up outer left of handle
local m_outer_left = mask(function(x, y)
  if x < 190 and y > 260 and y < 520 then return 1.0 end
  if x < 210 and y > 430 and y < 520 then return clamp((210 - x)/20, 0, 1) end
  return 0.0
end)
work(m_outer_left, {hand="body", pile=p_wall_left, angle=0.0, coverage=1.5, fill=true})

-- 2. Pitcher mouth interior shadow
local p_interior = pile{{"bone black", 7}, {"raw umber", 4}, medium=0.05}
local m_mouth = ellipse(365, 267, 36, 9)
work(m_mouth, {hand="detail", pile=p_interior, angle=0.0, coverage=2.0, fill=true, clip=true})

-- 3. Pitcher body modeling:
-- Half-tone terracotta on lit flank
local p_pitcher_half = pile{{"raw umber", 4}, {"red earth", 4}, {"yellow ochre", 3}, {"lead white", 1.2}, medium=0.1}
local p_pitcher_bounce = pile{{"raw umber", 4}, {"yellow ochre", 3}, {"red earth", 2}, medium=0.15}

-- Lit flank of belly (x: 260 to 360, y: 360 to 520)
local m_belly_lit = ellipse(310, 440, 50, 70)
work(m_belly_lit, {hand="body", pile=p_pitcher_half, angle=0.3, coverage=1.5, fill=true})

-- Neck lit side
local m_neck_lit = ribbon({{330, 275}, {335, 330}}, 18)
work(m_neck_lit, {hand="body", pile=p_pitcher_half, angle=1.5, coverage=1.5, fill=true})

-- Reflected bounce light on the shadow side (right flank)
local m_bounce = ribbon({{475, 410}, {485, 460}, {460, 530}}, 14)
work(m_bounce, {hand="body", pile=p_pitcher_bounce, angle=1.3, coverage=1.3})

-- Blend the pitcher body to fuse internal transitions
local pts_pitcher = {
  {320, 265}, {310, 280}, {315, 330},
  {250, 390}, {235, 450}, {260, 520}, {310, 575},
  {440, 575}, {480, 520}, {495, 440}, {470, 380},
  {415, 330}, {420, 280}, {410, 265},
  {365, 260}
}
local m_pitcher_body = poly(pts_pitcher, true)
blend(m_pitcher_body, {angle=0.4, coverage=1.0, clip=true})

-- 4. Quince modeling:
-- Subtle greenish half-tone / bloom
local p_quince_bloom = pile{{"yellow ochre", 4}, {"green earth", 3}, {"pale smalt", 1}, {"lead white", 2}, medium=0.15}
local m_quince_bloom = ribbon({{585, 490}, {620, 540}, {660, 580}}, 26)
work(m_quince_bloom, {hand="body", pile=p_quince_bloom, angle=0.6, coverage=1.3})

-- Warm golden midtones
local p_quince_gold = pile{{"yellow ochre", 6}, {"chrome yellow", 3}, {"lead white", 3}, {"red earth", 0.5}, medium=0.1}
local m_quince_belly = ellipse(625, 530, 45, 55)
work(m_quince_belly, {hand="body", pile=p_quince_gold, angle=0.5, coverage=1.5, fill=true})

-- Blend quince body
local pts_quince = {
  {610, 450}, {585, 485}, {565, 535}, {550, 580}, {560, 625}, {605, 650},
  {665, 652}, {720, 630}, {745, 575}, {730, 525}, {675, 480}, {635, 455}
}
local m_quince_body = poly(pts_quince, true)
blend(m_quince_body, {angle=0.5, coverage=1.0, clip=true})

-- 5. Cast shadows unification & contact occlusion
local function rot_ellipse(cx, cy, rx, ry, theta)
  local cos_t, sin_t = math.cos(theta), math.sin(theta)
  return mask(function(x, y)
    local dx = x - cx
    local dy = y - cy
    local nx = cos_t * dx + sin_t * dy
    local ny = -sin_t * dx + cos_t * dy
    local d = (nx / rx)^2 + (ny / ry)^2
    return d <= 1.0 and 1.0 or (d < 1.3 and (1.3 - d) / 0.3 or 0.0)
  end)
end

local p_shadow_glaze = pile{{"bone black", 5}, {"raw umber", 5}, {"red earth", 1}, medium=0.35}
local m_shadow_all = rot_ellipse(480, 600, 105, 38, 0.25) + rot_ellipse(720, 645, 75, 28, 0.2)
work(m_shadow_all, {hand="body", pile=p_shadow_glaze, angle=0.2, coverage=1.0})
blend(m_shadow_all, {angle=0.2, coverage=1.2})

-- Crisp dark contact occlusion at base of jug and quince
local p_contact = pile{{"bone black", 8}, {"raw umber", 4}, medium=0.05}
local b_detail = brush("round", 3)
b_detail:load(p_contact, 0.8)
b_detail:stroke({{310, 577}, {375, 580}, {440, 577}}, {pressure={0.8, 0.4}})
b_detail:stroke({{570, 648}, {630, 655}, {700, 642}}, {pressure={0.7, 0.4}})
