-- Background wall and shelf lay-in
p_wall_left = pile{{"raw umber", 5}, {"yellow ochre", 3}, {"bone black", 2}, {"lead white", 1}, medium=0.15}
p_wall_right = pile{{"raw umber", 6}, {"bone black", 5}, {"red earth", 1}, medium=0.15}
p_shelf_top = pile{{"raw umber", 4}, {"yellow ochre", 5}, {"lead white", 3}, {"red earth", 1}, medium=0.15}
p_shelf_front = pile{{"bone black", 6}, {"raw umber", 4}, {"red earth", 1}, medium=0.15}

-- Wall mask: top half of canvas down to shelf line
local m_wall = mask(function(x, y)
  local y_shelf = 533 - 8 * (x / 1000)
  if y < y_shelf then
    return 1.0
  else
    return 0.0
  end
end)

-- Left wall (lighter chiaroscuro field)
local m_wall_left = mask(function(x, y)
  local y_shelf = 533 - 8 * (x / 1000)
  if y < y_shelf and x < 550 then
    local fade = clamp((550 - x) / 200, 0, 1)
    return fade
  end
  return 0
end)

-- Right wall (deep dark background behind quince)
local m_wall_right = mask(function(x, y)
  local y_shelf = 533 - 8 * (x / 1000)
  if y < y_shelf and x > 350 then
    local fade = clamp((x - 350) / 200, 0, 1)
    return fade
  end
  return 0
end)

-- Work the background wall
work(m_wall, {hand="broad", pile=p_wall_right, angle=0.2, coverage=1.4, fill=true})
work(m_wall_left, {hand="broad", pile=p_wall_left, angle=-0.2, coverage=1.2, fill=true})
blend(m_wall, {angle=0.1, coverage=1.0})

-- Shelf top mask
local m_shelf = mask(function(x, y)
  local y_top = 533 - 8 * (x / 1000)
  local y_bot = 673 - 6 * (x / 1000)
  if y >= y_top and y < y_bot then
    return 1.0
  end
  return 0.0
end)

work(m_shelf, {hand="broad", pile=p_shelf_top, angle=0.0, coverage=1.5, fill=true})
blend(m_shelf, {angle=0.0, coverage=0.8})

-- Shelf front apron (deep shadow)
local m_front = mask(function(x, y)
  local y_bot = 673 - 6 * (x / 1000)
  if y >= y_bot then
    return 1.0
  end
  return 0.0
end)

work(m_front, {hand="broad", pile=p_shelf_front, angle=0.05, coverage=1.6, fill=true})
blend(m_front, {angle=0.0, coverage=0.8})
