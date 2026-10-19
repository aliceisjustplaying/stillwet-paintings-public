-- Define palettes for objects
p_pitcher_dark = pile{{"raw umber", 6}, {"red earth", 3}, {"bone black", 3}, medium=0.1}
p_pitcher_mid = pile{{"raw umber", 4}, {"red earth", 3}, {"yellow ochre", 3}, {"lead white", 1.5}, medium=0.1}

p_quince_shadow = pile{{"yellow ochre", 5}, {"raw umber", 3}, {"green earth", 2}, medium=0.1}
p_quince_light = pile{{"yellow ochre", 7}, {"chrome yellow", 2}, {"lead white", 2}, {"raw umber", 1}, medium=0.1}

-- Refine shelf plane
local m_shelf = mask(function(x, y)
  local y_top = 533 - 8 * (x / 1000)
  local y_bot = 673 - 6 * (x / 1000)
  if y >= y_top and y < y_bot then
    return 1.0
  end
  return 0.0
end)

work(m_shelf, {hand="broad", pile=pile{{"yellow ochre", 5}, {"raw umber", 4}, {"lead white", 2.5}, {"red earth", 1}, medium=0.15}, angle=0.0, coverage=1.2, fill=true})
blend(m_shelf, {angle=0.0, coverage=0.8})

-- Helper for rotated elliptical shadow
local function rot_ellipse(cx, cy, rx, ry, theta)
  local cos_t, sin_t = math.cos(theta), math.sin(theta)
  return mask(function(x, y)
    local dx = x - cx
    local dy = y - cy
    local nx = cos_t * dx + sin_t * dy
    local ny = -sin_t * dx + cos_t * dy
    local d = (nx / rx)^2 + (ny / ry)^2
    if d <= 1.0 then
      return 1.0
    elseif d < 1.4 then
      return (1.4 - d) / 0.4
    else
      return 0.0
    end
  end)
end

-- Cast shadows on the shelf:
local m_shadow_pitcher = rot_ellipse(480, 600, 100, 35, 0.25)
local m_shadow_quince = rot_ellipse(720, 645, 70, 25, 0.2)

local p_cast_shadow = pile{{"bone black", 5}, {"raw umber", 5}, {"red earth", 1}, medium=0.25}
work(m_shadow_pitcher, {hand="body", pile=p_cast_shadow, angle=0.2, coverage=1.4})
work(m_shadow_quince, {hand="body", pile=p_cast_shadow, angle=0.2, coverage=1.4})
blend(m_shadow_pitcher + m_shadow_quince, {angle=0.2, coverage=0.8})

-- Pitcher body silhouette
local pts_pitcher = {
  {320, 265}, {310, 280}, {315, 330},
  {250, 390}, {235, 450}, {260, 520}, {310, 575},
  {440, 575}, {480, 520}, {495, 440}, {470, 380},
  {415, 330}, {420, 280}, {410, 265},
  {365, 260}
}
local m_pitcher_body = poly(pts_pitcher, true) + ellipse(365, 265, 45, 12)
local m_handle = ribbon({{320, 310}, {245, 285}, {195, 330}, {195, 375}, {225, 415}, {255, 430}}, 14)
local m_pitcher_all = m_pitcher_body + m_handle

-- Pitcher underpainting: lit side (left) vs shadow side (right)
local m_pitcher_lit = m_pitcher_all * mask(function(x, y) return x < 360 and 1 or clamp((410 - x) / 50, 0, 1) end)
local m_pitcher_shd = m_pitcher_all * mask(function(x, y) return x >= 360 and 1 or clamp((x - 310) / 50, 0, 1) end)

work(m_pitcher_shd, {hand="body", pile=p_pitcher_dark, angle=1.4, coverage=1.6, fill=true})
work(m_pitcher_lit, {hand="body", pile=p_pitcher_mid, angle=1.4, coverage=1.5, fill=true})
blend(m_pitcher_all, {angle=1.4, coverage=0.9})

-- Quince silhouette
local pts_quince = {
  {610, 450}, {585, 485}, {565, 535}, {550, 580}, {560, 625}, {605, 650},
  {665, 652}, {720, 630}, {745, 575}, {730, 525}, {675, 480}, {635, 455}
}
local m_quince_all = poly(pts_quince, true)

-- Quince lit side (upper-left) vs shadow side (lower-right)
local m_quince_lit = m_quince_all * mask(function(x, y)
  local val = (1200 - (x + y)) / 60
  return clamp(val, 0, 1)
end)
local m_quince_shd = m_quince_all * mask(function(x, y)
  local val = ((x + y) - 1140) / 60
  return clamp(val, 0, 1)
end)

work(m_quince_shd, {hand="body", pile=p_quince_shadow, angle=0.8, coverage=1.6, fill=true})
work(m_quince_lit, {hand="body", pile=p_quince_light, angle=0.8, coverage=1.5, fill=true})
blend(m_quince_all, {angle=0.8, coverage=0.8})
