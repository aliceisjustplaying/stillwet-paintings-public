-- Unifying the Table Front Apron and Table Top, and Painting the Curling Lemon Peel

-- 1. Unify the table front apron across the entire canvas width
local napkin_drape_mask = poly({
  {175, 674}, {266, 674}, {262, 745}, {225, 755}, {205, 738}, {175, 674}
}, true)

local table_apron_full = rect(0, 675, 1000, 125) - napkin_drape_mask

work(table_apron_full, {hand = "body", pile = p_table_front, angle = 0, coverage = 1.8, fill = true, edge = 0.1})
blend(table_apron_full, {angle = 0, coverage = 2.0})

-- 2. Unify the table top plane
local table_top_full = rect(0, 523, 1000, 151) - m_clean_napkin - ellipse(365, 635, 65, 42) - ellipse(490, 660, 50, 38) - pitcher_full - ellipse(745, 660, 22, 16)
work(table_top_full, {hand = "glaze", pile = p_table_top, angle = 0, coverage = 1.4, edge = 0.2})
blend(table_top_full, {angle = 0, coverage = 1.6})

-- Re-apply cast shadows on tabletop
local pitcher_shadow = poly({
  {580, 625}, {630, 625}, {720, 630}, {760, 635}, {780, 650},
  {760, 665}, {710, 665}, {620, 640}, {570, 630}
}, true) * rect(0, 523, 1000, 151)
work(pitcher_shadow, {hand = "glaze", pile = p_cast_shadow, angle = 0.1, coverage = 1.4, edge = 0.4})

-- 3. Curling Lemon Peel (Zest)
-- A graceful spiraling ribbon curving forward from the lemon half
local p_peel_outer = pile{{"chrome yellow", 7}, {"yellow ochre", 2}, {"lead white", 1}, medium = 0.1}
local p_peel_inner = pile{{"lead white", 7}, {"yellow ochre", 2}, {"raw umber", 1}, medium = 0.1}
local p_peel_high = pile{{"lead white", 9}, {"chrome yellow", 1}, medium = 0.05}

-- Ribbon points of the curling peel
local peel_pts = {
  {448, 665}, {435, 680}, {420, 698}, {412, 715}, {422, 725}, {438, 718}, {442, 705}
}
local b_peel = brush{kind = "round", width = 3.6, point = 1, stiffness = 0.7}

-- Peel cast shadow on the table
local b_dark = brush{kind = "round", width = 3.0, point = 1, stiffness = 0.5}
b_dark:load(p_cast_shadow, 0.7)
b_dark:stroke({{440, 686}, {428, 708}, {422, 726}}, {pressure = {0.3, 0.6, 0.2}, orient = "along"})

-- Inner pale pith side of ribbon (visible on twist)
b_peel:load(p_peel_inner, 0.8)
b_peel:stroke({{448, 665}, {435, 680}, {422, 696}}, {pressure = {0.6, 0.8, 0.5}, orient = "along"})

-- Outer bright yellow skin side of ribbon
b_peel:load(p_peel_outer, 0.8)
b_peel:stroke({{422, 696}, {412, 715}, {422, 725}, {438, 718}, {442, 705}}, {pressure = {0.6, 0.9, 0.7, 0.4}, orient = "along"})

-- Highlighting the sharp edge of the curl
local b_fine = brush{kind = "round", width = 1.4, point = 1, stiffness = 0.8}
b_fine:load(p_peel_high, 0.8)
b_fine:stroke({{412, 712}, {420, 724}, {435, 719}}, {pressure = {0.4, 0.8, 0.3}, orient = "along"})

-- 4. Re-strike the continuous table edge chamfer / highlight
local p_edge_light = pile{{"lead white", 6}, {"yellow ochre", 3}, {"raw umber", 1}, medium = 0.1}
local b_edge = brush{kind = "rigger", width = 1.6, point = 1, stiffness = 0.7}
b_edge:load(p_edge_light, 0.8)
b_edge:stroke({{266, 674}, {410, 674}}, {pressure = {0.7, 0.8}, orient = "along"})
b_edge:load(p_edge_light, 0.8)
b_edge:stroke({{440, 674}, {722, 674}}, {pressure = {0.7, 0.8}, orient = "along"})
b_edge:load(p_edge_light, 0.7)
b_edge:stroke({{766, 674}, {1000, 674}}, {pressure = {0.6, 0.7, 0.4}, orient = "along"})

-- Occlusion shadow under napkin drape hem
b_dark:load(p_pot_deep, 0.8)
b_dark:stroke({{262, 745}, {226, 755}, {204, 739}}, {pressure = {0.5, 0.9, 0.4}, orient = "along"})

print("Apron unified, tabletop blended, and lemon peel spiral added.")
