-- 1. Soften the background transition
p_bg_transition = pile{{"raw umber", 4}, {"bone black", 2.5}, {"yellow ochre", 2.5}, {"red earth", 1}, medium=0.3}
m_bg_mid = mask(function(x, y)
  if y > 522 or x < 240 or x > 650 then return 0 end
  return math.sin((x - 240) / (650 - 240) * math.pi)
end) - m_objects

work(m_bg_mid, {hand="broad", pile=p_bg_transition, angle=0.25, coverage=1.2, fill=true})
blend(m_wall, {angle=0.15, coverage=1.4})

-- 2. Modulate shelf top: shade toward right, plus cast shadows
p_shelf_shade = pile{{"raw umber", 3.5}, {"yellow ochre", 3}, {"bone black", 1.2}, {"lead white", 1.5}, medium=0.15}
m_shelf_right = mask(function(x, y)
  if y < 522 or y > 638 or x < 450 then return 0 end
  return math.min(1, (x - 450) / 250)
end) - m_objects
work(m_shelf_right, {hand="broad", pile=p_shelf_shade, angle=0.05, coverage=1.2, fill=true})

-- Cast shadows on the shelf top
pts_jug_shadow = {
  {420, 620}, {490, 615}, {620, 625}, {680, 638},
  {670, 642}, {520, 642}, {440, 630}
}
m_jug_shadow = poly(pts_jug_shadow, true) * mask(function(x, y) return y <= 645 and 1 or 0 end)
work(m_jug_shadow, {hand="body", pile=p_shadow, angle=0.1, coverage=1.6, fill=true, clip=true})

pts_quince_shadow = {
  {660, 642}, {720, 638}, {790, 645}, {830, 655},
  {810, 665}, {730, 662}, {670, 652}
}
m_quince_shadow = poly(pts_quince_shadow, true)
work(m_quince_shadow, {hand="body", pile=p_shadow, angle=0.15, coverage=1.6, fill=true, clip=true})

-- 3. Block in the Terracotta Jug
p_jug_lit = pile{{"yellow ochre", 4}, {"red earth", 3.2}, {"lead white", 2.2}, {"raw umber", 1}, medium=0.1}
p_jug_shadow = pile{{"raw umber", 5}, {"red earth", 3}, {"bone black", 1.5}, medium=0.15}
p_jug_core = pile{{"raw umber", 4.5}, {"bone black", 2.2}, {"red earth", 2.5}, medium=0.15}
p_interior = pile{{"bone black", 6}, {"raw umber", 4}, medium=0.1}

-- Mouth / interior dark hollow
m_jug_mouth = ellipse(380, 282, 44, 10)
work(m_jug_mouth, {hand="body", pile=p_interior, angle=0.0, coverage=1.8, fill=true, clip=true})

-- Jug lit side and shadow side
m_jug_lit = (m_jug - m_jug_mouth) * mask(function(x, y)
  if x < 370 then return 1 end
  if x > 420 then return 0 end
  return (420 - x) / 50
end)

m_jug_dark = (m_jug - m_jug_mouth) * mask(function(x, y)
  if x > 410 then return 1 end
  if x < 360 then return 0 end
  return (x - 360) / 50
end)

work(m_jug_dark, {hand="body", pile=p_jug_shadow, angle=1.45, coverage=1.5, fill=true, clip=true})
work(m_jug_lit, {hand="body", pile=p_jug_lit, angle=1.45, coverage=1.5, fill=true, clip=true})

-- Blend across the terminator on the jug body
m_jug_belly = m_jug * mask(function(x, y) return (y >= 300 and y <= 620) and 1 or 0 end)
blend(m_jug_belly, {angle=0.1, coverage=1.2, clip=true})

-- Handle
work(m_handle, {hand="body", pile=p_jug_shadow, angle=1.2, coverage=1.5, fill=true, clip=true})
m_handle_lit = m_handle * mask(function(x, y) return x < 265 and 1 or 0 end)
work(m_handle_lit, {hand="detail", pile=p_jug_lit, angle=1.2, coverage=1.4, fill=true, clip=true})

-- 4. Block in the Quince
p_quince_lit = pile{{"chrome yellow", 4.5}, {"yellow ochre", 3}, {"lead white", 2}, {"vermilion", 0.3}, medium=0.1}
p_quince_shadow = pile{{"yellow ochre", 3.5}, {"raw umber", 3}, {"green earth", 1.5}, {"bone black", 0.5}, medium=0.15}

m_quince_lit = m_quince * mask(function(x, y)
  local dx = (x - 660) / 60
  local dy = (y - 600) / 55
  local val = -0.7 * dx - 0.7 * dy
  if val > 0.1 then return 1 end
  if val < -0.3 then return 0 end
  return (val + 0.3) / 0.4
end)
m_quince_dark = m_quince - m_quince_lit

work(m_quince_dark, {hand="body", pile=p_quince_shadow, angle=0.8, coverage=1.5, fill=true, clip=true})
work(m_quince_lit, {hand="body", pile=p_quince_lit, angle=-0.6, coverage=1.5, fill=true, clip=true})
blend(m_quince, {angle=0.4, coverage=1.1, clip=true})
