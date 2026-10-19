-- Table top and front apron lay-in

-- Define reserved masks for foreground objects
local napkin_pts = {
  {140, 545}, {210, 555}, {260, 580}, {280, 630}, {270, 675},
  {265, 745}, {225, 755}, {205, 735}, {175, 675}, {135, 650}
}
napkin_mask = poly(napkin_pts, true):shrink(2)
lemon_mask = ellipse(365, 635, 58, 38):shrink(2)
lemon_half_mask = ellipse(490, 660, 44, 34):shrink(2)
walnut_mask = ellipse(745, 660, 18, 14):shrink(2)

local reserved = napkin_mask + lemon_mask + lemon_half_mask + walnut_mask

-- Table top mask (y from 522 to 675)
local table_top = (rect(0, 520, 1000, 155) - reserved)

-- Table front apron (y from 675 to 800)
local table_front = (rect(0, 675, 1000, 125) - napkin_mask)

-- Table top piles
p_table_top = pile{{"yellow ochre", 5}, {"raw umber", 4}, {"lead white", 2}, {"red earth", 1}, medium = 0.15}
p_table_top_light = pile{{"yellow ochre", 5}, {"lead white", 4}, {"raw umber", 2}, {"red earth", 1}, medium = 0.15}
p_table_front = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 2}, medium = 0.15}
p_table_front_warm = pile{{"raw umber", 5}, {"red earth", 3}, {"yellow ochre", 2}, medium = 0.15}
p_cast_shadow = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 2}, medium = 0.25}

-- 1. Table top surface: horizontal wood strokes
local m_top_left = table_top * mask(function(x, y) return smoothstep(700, 200, x) end)
local m_top_right = table_top * mask(function(x, y) return smoothstep(300, 800, x) end)

work(table_top, {hand = "body", pile = p_table_top, angle = 0, coverage = 1.6, fill = true, edge = 0.2})
work(m_top_left, {hand = "body", pile = p_table_top_light, angle = 0, coverage = 1.3, fill = true, edge = 0.4})
work(m_top_right, {hand = "body", pile = p_table_top, angle = 0, coverage = 1.2, fill = true, edge = 0.3})

-- Blend wood surface horizontally along the grain
blend(table_top, {angle = 0, coverage = 1.2})

-- 2. Table front apron in shadow
work(table_front, {hand = "body", pile = p_table_front, angle = 0, coverage = 1.5, fill = true, edge = 0.2})
local m_front_bottom = table_front * mask(function(x, y) return smoothstep(680, 780, y) end)
work(m_front_bottom, {hand = "body", pile = p_table_front_warm, angle = 0, coverage = 1.0, edge = 0.5})
blend(table_front, {angle = 0, coverage = 1.2})

-- 3. Cast shadows on the table top
-- Shadow from pitcher (stretches to the right and slightly back/down)
local pitcher_shadow = poly({
  {580, 625}, {630, 625}, {720, 630}, {760, 635}, {780, 650},
  {760, 665}, {710, 665}, {620, 640}, {570, 630}
}, true) * table_top

-- Shadow from whole lemon
local lemon_shadow = poly({
  {360, 665}, {410, 665}, {440, 672}, {430, 680}, {390, 682}, {350, 675}
}, true) * table_top

-- Shadow from half lemon
local half_shadow = poly({
  {490, 685}, {535, 685}, {560, 695}, {540, 705}, {480, 700}
}, true) * (table_top + table_front)

-- Shadow from napkin
local napkin_shadow = poly({
  {240, 670}, {285, 670}, {295, 710}, {280, 755}, {265, 755}, {260, 710}
}, true) * (table_top + table_front)

work(pitcher_shadow, {hand = "glaze", pile = p_cast_shadow, angle = 0.1, coverage = 1.6, edge = 0.5})
work(lemon_shadow, {hand = "glaze", pile = p_cast_shadow, angle = 0.1, coverage = 1.4, edge = 0.4})
work(half_shadow, {hand = "glaze", pile = p_cast_shadow, angle = 0.1, coverage = 1.4, edge = 0.4})
work(napkin_shadow, {hand = "glaze", pile = p_cast_shadow, angle = 0.2, coverage = 1.5, edge = 0.5})

print("Table and cast shadows laid in.")
