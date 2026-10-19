-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{
  size = 500,
  aspect = 1.25,
  linen = {16, 14},
  seed = 101,
  ground = {
    {pile = {{"lead white", 8}, {"raw umber", 2}}, um = 90, apply = "knife", texture = 0.25},
    {pile = {{"lead white", 6}, {"yellow ochre", 2}, {"raw umber", 2}}, um = 35, apply = "brush"}
  }
}

--@ chunk 2
-- Underdrawing: establishing composition with chalk and pencil
local ch = chalk()
local p = pencil("HB")

-- Table edge lines
ch:line({{0, 525}, {1000, 520}}, {pressure = 0.35, smooth = false})
ch:line({{0, 675}, {1000, 675}}, {pressure = 0.45, smooth = false})

-- Pitcher contours
-- Lip and rim
ch:sketch({{545, 310}, {590, 303}, {635, 310}, {640, 320}, {590, 327}, {540, 320}, {545, 310}}, {passes = 2, wander = 1.5, pressure = 0.35})
-- Neck
ch:line({{550, 320}, {552, 370}}, {pressure = 0.4})
ch:line({{630, 320}, {628, 370}}, {pressure = 0.4})
-- Belly contour left
ch:sketch({{552, 370}, {515, 420}, {500, 480}, {510, 550}, {535, 605}, {550, 625}}, {passes = 2, wander = 2, pressure = 0.4})
-- Belly contour right
ch:sketch({{628, 370}, {665, 420}, {680, 480}, {670, 550}, {645, 605}, {630, 625}}, {passes = 2, wander = 2, pressure = 0.4})
-- Base
ch:sketch({{550, 625}, {590, 632}, {630, 625}}, {passes = 2, wander = 1.5, pressure = 0.4})
-- Handle
ch:sketch({{628, 355}, {675, 365}, {695, 410}, {690, 460}, {665, 490}}, {passes = 2, wander = 2, pressure = 0.4})
ch:sketch({{628, 370}, {660, 380}, {675, 415}, {672, 455}, {655, 485}}, {passes = 2, wander = 1.5, pressure = 0.35})

-- Napkin draped on left
ch:sketch({{150, 545}, {210, 555}, {260, 580}, {280, 630}, {270, 675}, {265, 735}, {230, 745}, {210, 730}, {180, 675}, {140, 660}}, {passes = 2, wander = 2.5, pressure = 0.35})
-- Fold creases in napkin
p:sketch({{180, 550}, {220, 620}, {250, 675}, {245, 735}}, {passes = 2, wander = 1.5, pressure = 0.3})
p:sketch({{220, 565}, {255, 630}, {265, 675}}, {passes = 2, wander = 1.5, pressure = 0.3})

-- Whole lemon (left-center)
ch:sketch({{305, 625}, {320, 605}, {365, 595}, {415, 615}, {425, 640}, {405, 665}, {355, 672}, {315, 655}, {305, 625}}, {passes = 3, wander = 2, pressure = 0.4})
-- Lemon half (cut face tilted)
ch:sketch({{445, 650}, {470, 625}, {515, 625}, {540, 650}, {535, 680}, {495, 700}, {455, 685}, {445, 650}}, {passes = 3, wander = 2, pressure = 0.4})
-- Inner pith circle for lemon half
p:sketch({{455, 652}, {475, 635}, {510, 635}, {528, 652}, {523, 675}, {492, 690}, {462, 678}, {455, 652}}, {passes = 2, wander = 1, pressure = 0.3})

-- Walnut on right
ch:sketch({{725, 655}, {740, 642}, {760, 650}, {765, 665}, {745, 672}, {730, 668}, {725, 655}}, {passes = 2, wander = 1.5, pressure = 0.35})
p:line({{742, 643}, {744, 671}}, {pressure = 0.4}) -- seam

-- Light shadow indications
p:hatch(ellipse(620, 645, 120, 25), {angle = 0.2, spacing = 8, pressure = 0.25})
p:hatch(ellipse(380, 670, 70, 18), {angle = 0.2, spacing = 8, pressure = 0.2})
p:hatch(ellipse(500, 695, 60, 15), {angle = 0.2, spacing = 8, pressure = 0.2})

print("Underdrawing completed.")

--@ chunk 3
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

