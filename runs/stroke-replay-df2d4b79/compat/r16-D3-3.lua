-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{
  size = 450,
  aspect = 1.25,
  linen = {17, 14},
  seed = 42,
  ground = {
    {
      pile = {{"lead white", 10}, {"yellow ochre", 1}, {"raw umber", 0.5}},
      um = 80,
      apply = "knife",
      texture = 0.22
    },
    {
      pile = {{"yellow ochre", 4}, {"raw umber", 3}, {"lead white", 1}},
      um = 30,
      apply = "brush"
    }
  }
}

--@ chunk 2
c = chalk()

-- Stone shelf edges
c:sketch({{0, 520}, {1000, 520}}, {pressure=0.25, wander=1.2})
c:sketch({{0, 640}, {1000, 640}}, {pressure=0.35, wander=1.5})

-- Terracotta jug outline
-- Rim
c:sketch({{325, 280}, {380, 275}, {435, 280}, {440, 290}, {380, 295}, {320, 290}, {325, 280}}, {pressure=0.4})
-- Neck & shoulder
c:sketch({{340, 290}, {345, 340}, {310, 390}, {265, 470}, {280, 560}, {315, 620}}, {pressure=0.4})
c:sketch({{420, 290}, {415, 340}, {450, 390}, {495, 470}, {480, 560}, {445, 620}}, {pressure=0.4})
-- Base
c:sketch({{315, 620}, {380, 625}, {445, 620}}, {pressure=0.45})
-- Handle
c:sketch({{342, 330}, {270, 345}, {242, 400}, {248, 455}, {275, 485}}, {pressure=0.35})
c:sketch({{345, 345}, {285, 360}, {260, 405}, {265, 450}, {280, 475}}, {pressure=0.3})

-- Quince outline
c:sketch({
  {660, 545}, {695, 560}, {720, 600}, {715, 635},
  {685, 650}, {640, 650}, {610, 625}, {605, 590},
  {630, 555}, {660, 545}
}, {pressure=0.4})

-- Small peeled lemon & curling peel
c:sketch({
  {515, 615}, {545, 610}, {560, 630}, {550, 645},
  {520, 648}, {505, 635}, {515, 615}
}, {pressure=0.35})
-- Peel spiral trailing over the shelf edge
c:sketch({
  {535, 625}, {555, 632}, {552, 648}, {538, 665}, {542, 690}, {548, 705}
}, {pressure=0.35})

-- Shadow indications
c:sketch({{430, 620}, {540, 635}, {620, 642}}, {pressure=0.25})
c:sketch({{700, 645}, {770, 658}, {820, 665}}, {pressure=0.25})

--@ chunk 3
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

