-- Piles for setting and underpainting
p_bg_dark = pile{{"bone black", 5}, {"raw umber", 4}, {"red earth", 1.5}, {"Prussian blue", 0.4}, medium=0.15}
p_bg_warm = pile{{"raw umber", 4}, {"yellow ochre", 3.5}, {"bone black", 1.2}, {"red earth", 1.5}, medium=0.15}
p_stone_top = pile{{"lead white", 4}, {"yellow ochre", 3}, {"raw umber", 2.5}, {"bone black", 0.6}, medium=0.12}
p_stone_front = pile{{"raw umber", 4}, {"yellow ochre", 2}, {"bone black", 2}, {"lead white", 1}, {"red earth", 0.8}, medium=0.15}
p_shadow = pile{{"raw umber", 4.5}, {"bone black", 2.5}, {"red earth", 1}, medium=0.2}

-- Geometric masks
pts_jug = {
  {380, 275}, {435, 280}, {440, 290}, {420, 310}, {415, 340}, {445, 390},
  {495, 470}, {485, 540}, {450, 600}, {445, 622}, {380, 625}, {315, 622},
  {310, 600}, {275, 540}, {265, 470}, {310, 390}, {345, 340}, {340, 310},
  {320, 290}, {325, 280}
}
m_jug = poly(pts_jug, true)

pts_handle = {
  {342, 330}, {270, 345}, {242, 400}, {248, 455}, {275, 485},
  {280, 475}, {265, 450}, {260, 405}, {285, 360}, {345, 345}
}
m_handle = poly(pts_handle, true)
m_jug_all = m_jug + m_handle

pts_quince = {
  {660, 545}, {695, 560}, {720, 600}, {715, 635},
  {685, 650}, {640, 650}, {610, 625}, {605, 590},
  {630, 555}
}
m_quince = poly(pts_quince, true)

-- Reserved foreground objects mask (shrunk slightly so background meets them cleanly)
m_objects = (m_jug_all + m_quince):shrink(3)

-- 1. Background wall: y <= 520, excluding objects
m_wall = mask(function(x, y) return y <= 522 and 1 or 0 end) - m_objects
m_wall_left = mask(function(x, y) return (y <= 522 and x < 450) and (1 - (x / 450)*0.5) or 0 end) - m_objects
m_wall_right = mask(function(x, y) return (y <= 522 and x >= 400) and 1 or 0 end) - m_objects

-- Lay in warm left background
work(m_wall_left, {hand="broad", pile=p_bg_warm, angle=0.4, coverage=1.4, fill=true})
-- Lay in deep dark right background
work(m_wall_right, {hand="broad", pile=p_bg_dark, angle=-0.3, coverage=1.6, fill=true})
-- Blend the background broadly to create soft atmospheric depth
blend(m_wall, {angle=0.1, coverage=1.2})

-- 2. Stone shelf top plane (520 <= y <= 640)
m_shelf_top = mask(function(x, y) return (y >= 520 and y <= 640) and 1 or 0 end) - m_objects
work(m_shelf_top, {hand="broad", pile=p_stone_top, angle=0.05, coverage=1.5, fill=true})

-- 3. Stone shelf front apron (640 <= y <= 800)
m_shelf_front = mask(function(x, y) return y >= 638 and 1 or 0 end)
work(m_shelf_front, {hand="broad", pile=p_stone_front, angle=0.02, coverage=1.6, fill=true})

-- Under-lip shadow on the apron (from y=638 to 655)
m_lip_shadow = mask(function(x, y) return (y >= 638 and y <= 654) and 1 or 0 end)
work(m_lip_shadow, {hand="body", pile=p_shadow, angle=0.0, coverage=1.5, fill=true})
