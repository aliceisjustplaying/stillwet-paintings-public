-- Wall / Background lay-in
p_wall_dark = pile{{"raw umber", 5}, {"bone black", 3}, {"red earth", 1}, medium = 0.2}
p_wall_mid = pile{{"raw umber", 4}, {"yellow ochre", 3}, {"lead white", 2}, {"bone black", 1}, medium = 0.2}
p_wall_light = pile{{"lead white", 5}, {"yellow ochre", 3}, {"raw umber", 2}, medium = 0.25}

-- Pitcher silhouette mask to reserve the canvas
local pitcher_pts = {
  {545, 305}, {635, 305}, {645, 320}, {630, 365},
  {675, 360}, {700, 410}, {695, 465}, {665, 495}, {678, 510},
  {670, 560}, {645, 610}, {630, 628},
  {550, 628}, {535, 605}, {508, 550}, {500, 480}, {515, 420},
  {550, 370}, {545, 320}
}
pitcher_mask = poly(pitcher_pts, true):grow(4)

-- Wall area (above table line y = 525)
local wall_mask = rect(0, 0, 1000, 525) - pitcher_mask

-- Left wall (illuminated area)
local m_left = wall_mask * mask(function(x, y)
  local v = (500 - x) * 0.7 + (400 - y) * 0.5
  return smoothstep(-50, 150, v)
end)

-- Right wall (deep shadow)
local m_right = wall_mask * mask(function(x, y)
  local v = (x - 450) * 0.7 + (y - 100) * 0.3
  return smoothstep(-50, 150, v)
end)

-- Paint the passages
work(wall_mask, {hand = "broad", pile = p_wall_mid, angle = -0.4, coverage = 1.2, edge = 0.4})
work(m_right, {hand = "broad", pile = p_wall_dark, angle = -0.3, coverage = 1.4, edge = 0.6})
work(m_left, {hand = "broad", pile = p_wall_light, angle = -0.5, coverage = 1.3, edge = 0.5})

-- Soft diagonal blend across the wall to create continuous atmospheric space
blend(wall_mask, {angle = -0.4, coverage = 1.5})

print("Background blocked in successfully.")
