-- Refining Tabletop and Sculpting Linen Napkin

-- Piles
local p_table_wash = pile{{"yellow ochre", 5}, {"raw umber", 4}, {"lead white", 2}, {"red earth", 1}, medium = 0.25}
local p_edge_light = pile{{"lead white", 6}, {"yellow ochre", 3}, {"raw umber", 1}, medium = 0.1}
local p_linen_tone = pile{{"lead white", 7}, {"yellow ochre", 2}, {"raw umber", 1}, medium = 0.15}
local p_linen_crest = pile{{"lead white", 8}, {"yellow ochre", 2}, medium = 0.08}
local p_linen_high = pile{{"lead white", 9}, {"yellow ochre", 1}, medium = 0.05}
local p_linen_shadow = pile{{"lead white", 5}, {"bone black", 2}, {"raw umber", 2}, {"cobalt blue", 1}, medium = 0.15}
local p_linen_crease = pile{{"raw umber", 5}, {"bone black", 3}, {"cobalt blue", 1}, {"lead white", 1}, medium = 0.1}

-- 1. Redefine clean napkin silhouette
local clean_napkin_pts = {
  {145, 550}, {185, 550}, {235, 568}, {270, 615}, {266, 674},
  {260, 742}, {225, 752}, {205, 736}, {175, 674}, {140, 650}, {135, 600}
}
m_clean_napkin = poly(clean_napkin_pts, true)

-- 2. Clean table top and front face around napkin
local m_table_around_napkin = (rect(0, 520, 320, 155) - m_clean_napkin)
work(m_table_around_napkin, {hand = "body", pile = p_table_top_light, angle = 0, coverage = 1.6, fill = true, edge = 0.1})

local m_front_around_napkin = (rect(0, 675, 300, 125) - m_clean_napkin)
work(m_front_around_napkin, {hand = "body", pile = p_table_front, angle = 0, coverage = 1.6, fill = true, edge = 0.1})

-- Blend table surface horizontally
blend(rect(0, 520, 1000, 155) - m_clean_napkin - ellipse(365, 635, 60, 40) - ellipse(490, 660, 45, 35) - ellipse(745, 660, 20, 15),
  {angle = 0, coverage = 1.5})

-- 3. Sculpt the Napkin
-- Base coat
work(m_clean_napkin, {hand = "body", pile = p_linen_tone, angle = 0.3, coverage = 1.8, fill = true, edge = 0.15})

-- Troughs in cool blue-gray shadow
local trough1 = ribbon({{165, 560}, {190, 620}, {205, 674}, {198, 730}}, 14) * m_clean_napkin
local trough2 = ribbon({{225, 580}, {242, 630}, {248, 674}, {242, 735}}, 10) * m_clean_napkin
work(trough1, {hand = "body", pile = p_linen_shadow, angle = 1.2, coverage = 1.5, edge = 0.3})
work(trough2, {hand = "body", pile = p_linen_shadow, angle = 1.2, coverage = 1.4, edge = 0.3})

-- Crease lines inside troughs
local b_pen = brush{kind = "round", width = 1.8, point = 1, stiffness = 0.6}
b_pen:load(p_linen_crease, 0.7)
b_pen:stroke({{166, 565}, {192, 625}, {206, 674}, {200, 728}}, {pressure = {0.3, 0.6, 0.3}, orient = "along"})

-- Lit fold ridges
local ridge1 = ribbon({{145, 550}, {175, 600}, {190, 674}, {180, 725}}, 14) * m_clean_napkin
local ridge2 = ribbon({{185, 555}, {212, 620}, {228, 674}, {224, 742}}, 12) * m_clean_napkin
local ridge3 = ribbon({{235, 570}, {258, 625}, {264, 674}, {258, 735}}, 10) * m_clean_napkin
work(ridge1, {hand = "body", pile = p_linen_tone, angle = 0.4, coverage = 1.3, edge = 0.3})
work(ridge2, {hand = "body", pile = p_linen_crest, angle = 0.4, coverage = 1.5, edge = 0.3})
work(ridge3, {hand = "body", pile = p_linen_crest, angle = 0.4, coverage = 1.4, edge = 0.3})

-- Soft blend across folds
blend(m_clean_napkin, {angle = 0.3, coverage = 1.2})

-- Clean hem lines along cloth edges
local b_hem = brush{kind = "round", width = 2.4, point = 1, stiffness = 0.6}
b_hem:load(p_linen_crest, 0.8)
b_hem:stroke({{266, 674}, {260, 742}, {225, 752}, {205, 736}, {175, 674}}, {pressure = {0.6, 0.8, 0.5}, orient = "along"})
b_hem:stroke({{175, 674}, {140, 650}, {135, 600}, {145, 550}}, {pressure = {0.5, 0.7, 0.4}, orient = "along"})

-- Sharp impasto highlights on the table edge folds
b_hem:load(p_linen_high, 0.9)
b_hem:touch(228, 674, {pressure = 0.85})
b_hem:touch(264, 674, {pressure = 0.8})

-- Occlusion shadow under hanging drape
local b_dark = brush{kind = "round", width = 3.0, point = 1, stiffness = 0.6}
b_dark:load(p_pot_deep, 0.8)
b_dark:stroke({{262, 745}, {226, 755}, {204, 739}}, {pressure = {0.5, 0.9, 0.4}, orient = "along"})

-- 4. Table Front Chamfer / Highlight Line
local b_edge = brush{kind = "round", width = 1.6, point = 1, stiffness = 0.6}
b_edge:load(p_edge_light, 0.8)
b_edge:stroke({{268, 674}, {310, 674}, {440, 674}}, {pressure = {0.6, 0.8, 0.6}, orient = "along"})
b_edge:load(p_edge_light, 0.7)
b_edge:stroke({{538, 674}, {650, 674}, {720, 674}}, {pressure = {0.6, 0.7, 0.5}, orient = "along"})
b_edge:load(p_edge_light, 0.6)
b_edge:stroke({{766, 674}, {880, 674}, {1000, 674}}, {pressure = {0.5, 0.6, 0.4}, orient = "along"})

print("Napkin and table edge refined.")
