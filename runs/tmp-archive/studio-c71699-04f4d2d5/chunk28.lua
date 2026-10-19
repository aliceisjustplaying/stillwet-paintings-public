-- Unifying the Entire Tabletop to Eliminate Any Seams

-- Piles
local p_table_top = pile{{"yellow ochre", 5}, {"raw umber", 4}, {"lead white", 2}, {"red earth", 1}, medium = 0.2}
local p_table_left = pile{{"yellow ochre", 5}, {"lead white", 4}, {"raw umber", 2}, {"red earth", 1}, medium = 0.2}
local p_cast = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 1}, medium = 0.25}

-- Object masks to preserve
local m_nap = poly({
  {135, 545}, {245, 548}, {265, 605}, {262, 674},
  {258, 742}, {218, 745}, {212, 742}, {165, 740}, {165, 674},
  {135, 630}, {130, 580}
}, true)

local m_whole = poly({
  {305, 628}, {312, 615}, {330, 604}, {365, 597}, {395, 604},
  {418, 618}, {425, 638}, {415, 655}, {395, 668}, {365, 674},
  {335, 668}, {315, 652}, {305, 638}
}, true)

local m_cut = ellipse(485, 652, 44, 35)
local m_walnut = ellipse(790, 656, 17, 13)

local m_objects = m_nap + m_whole + m_cut + pitcher_full + m_walnut

-- Full tabletop plane (y from 523 to 674, x from 0 to 1000)
local table_top_full = rect(0, 523, 1000, 151) - m_objects

-- 1. Unify table surface across the entire canvas width
work(table_top_full, {hand = "body", pile = p_table_top, angle = 0, coverage = 1.6, fill = true, edge = 0.1})

-- Modulate light on the left
local m_left_top = table_top_full * mask(function(x, y) return smoothstep(500, 100, x) end)
work(m_left_top, {hand = "glaze", pile = p_table_left, angle = 0, coverage = 1.2, edge = 0.3})

-- Horizontal blending pass across the full tabletop
blend(table_top_full, {angle = 0, coverage = 1.8})

-- 2. Cast shadows on the tabletop
-- Pitcher cast shadow
local pitcher_shadow = poly({
  {580, 625}, {630, 625}, {710, 632}, {760, 638}, {780, 650},
  {760, 665}, {700, 665}, {620, 640}, {570, 630}
}, true) * rect(0, 523, 1000, 151)
work(pitcher_shadow, {hand = "glaze", pile = p_cast, angle = 0.1, coverage = 1.4, edge = 0.4})

-- Whole lemon cast shadow
local lemon_shadow = poly({
  {360, 665}, {410, 665}, {435, 670}, {425, 674}, {385, 674}, {350, 673}
}, true) * rect(0, 523, 1000, 151)
work(lemon_shadow, {hand = "glaze", pile = p_cast, angle = 0.1, coverage = 1.3, edge = 0.4})

-- Walnut cast shadow
local walnut_shadow = ellipse(810, 663, 15, 6) * rect(0, 523, 1000, 151)
work(walnut_shadow, {hand = "glaze", pile = p_cast, angle = 0.1, coverage = 1.3, edge = 0.4})

-- 3. Re-strike continuous table edge chamfer / highlight
local p_edge_light = pile{{"lead white", 6}, {"yellow ochre", 3}, {"raw umber", 1}, medium = 0.1}
local b_edge = brush{kind = "rigger", width = 1.6, point = 1, stiffness = 0.7}
b_edge:load(p_edge_light, 0.8)
b_edge:stroke({{262, 674}, {310, 674}}, {pressure = {0.7, 0.8}, orient = "along"})
b_edge:load(p_edge_light, 0.8)
b_edge:stroke({{425, 674}, {442, 674}}, {pressure = {0.7, 0.8}, orient = "along"})
b_edge:load(p_edge_light, 0.8)
b_edge:stroke({{530, 674}, {772, 674}}, {pressure = {0.7, 0.8, 0.6}, orient = "along"})
b_edge:load(p_edge_light, 0.7)
b_edge:stroke({{807, 674}, {1000, 674}}, {pressure = {0.6, 0.7, 0.4}, orient = "along"})

print("Full tabletop unified seamlessly.")
