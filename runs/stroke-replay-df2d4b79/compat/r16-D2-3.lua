-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{
  size=400,
  aspect=1.25,
  linen={16, 14},
  seed=42,
  ground={
    {pile={{"lead white", 10}, {"yellow ochre", 2}, {"raw umber", 1}}, um=80, apply="knife", texture=0.25},
    {pile={{"lead white", 4}, {"yellow ochre", 3}, {"raw umber", 1}, {"red earth", 0.5}}, um=35, apply="brush"}
  }
}

--@ chunk 2
local c = chalk()

-- Horizon / rear shelf line
c:sketch({{0, 535}, {350, 532}, {680, 528}, {1000, 525}}, {pressure=0.35, wander=1.0})

-- Front edge of wooden shelf
c:sketch({{0, 675}, {400, 672}, {750, 670}, {1000, 668}}, {pressure=0.4, wander=1.2})

-- Stoneware pitcher contour
c:sketch({
  {320, 265}, {310, 280}, {315, 330}, -- neck left
  {250, 390}, {235, 450}, {260, 520}, {310, 575}, -- belly left & base
  {440, 575}, {480, 520}, {495, 440}, {470, 380}, -- base right & belly right
  {415, 330}, {420, 280}, {410, 265}, -- neck right
  {365, 260}, {320, 265} -- rim
}, {pressure=0.45, wander=1.5, passes=2})

-- Pitcher mouth ellipse
c:sketch({{320, 265}, {365, 275}, {410, 265}, {365, 258}, {320, 265}}, {pressure=0.35})

-- Pitcher handle
c:sketch({
  {315, 305}, {250, 285}, {200, 320}, {195, 370}, {225, 420}, {255, 430}
}, {pressure=0.4, wander=1.2, passes=2})

-- Quince contour (pyriform, knobby)
c:sketch({
  {610, 450}, {585, 485}, {565, 535}, {550, 580}, {560, 625}, {605, 650},
  {665, 652}, {720, 630}, {745, 575}, {730, 525}, {675, 480}, {635, 455},
  {610, 450}
}, {pressure=0.45, wander=1.5, passes=2})

-- Quince stem
c:line({{610, 450}, {602, 430}, {595, 418}}, {pressure={0.5, 0.3}})

-- Bay sprig in foreground
c:sketch({{470, 620}, {510, 645}, {550, 665}, {560, 685}}, {pressure=0.35})
-- Leaf 1
c:sketch({{510, 645}, {490, 635}, {475, 645}, {510, 655}}, {pressure=0.35})
-- Leaf 2
c:sketch({{535, 655}, {560, 645}, {580, 655}, {545, 665}}, {pressure=0.35})

--@ chunk 3
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

