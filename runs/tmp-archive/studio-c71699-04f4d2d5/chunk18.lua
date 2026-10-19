-- Sculpting and harmonizing the linen napkin

local napkin_pts = {
  {140, 545}, {205, 555}, {255, 580}, {278, 630}, {270, 675},
  {265, 745}, {225, 755}, {205, 735}, {175, 675}, {135, 650}
}
local m_napkin = poly(napkin_pts, true):grow(2)

-- Warm linen glazes to tone down the chalky brightness
local p_linen_tone = pile{{"lead white", 6}, {"yellow ochre", 2}, {"raw umber", 2}, medium = 0.25}
local p_linen_shadow_cool = pile{{"lead white", 4}, {"raw umber", 2}, {"bone black", 2}, {"cobalt blue", 2}, medium = 0.2}
local p_linen_shadow_deep = pile{{"raw umber", 5}, {"bone black", 3}, {"cobalt blue", 1}, {"lead white", 1}, medium = 0.15}
local p_linen_crest = pile{{"lead white", 8}, {"yellow ochre", 2}, medium = 0.1}

-- 1. Unifying wash over the napkin to bring it into tonal harmony with the room
work(m_napkin, {hand = "glaze", pile = p_linen_tone, angle = 0.3, coverage = 1.4, edge = 0.3})

-- 2. Sculpt distinct cylindrical flute folds hanging over the table edge
-- Fold A (leftmost flank, falling away into shadow)
local m_fold_a = m_napkin * mask(function(x, y) return smoothstep(185, 140, x) end)
work(m_fold_a, {hand = "body", pile = p_linen_shadow_cool, angle = 1.2, coverage = 1.3, edge = 0.4})

-- Crease hollow between Fold A and Fold B
local hollow1 = ribbon({{170, 560}, {195, 630}, {212, 675}, {205, 735}}, 14) * m_napkin
work(hollow1, {hand = "body", pile = p_linen_shadow_cool, angle = 1.2, coverage = 1.5, edge = 0.4})

-- Deepest crease line inside hollow1
local b_pen = brush{kind = "round", width = 2.0, point = 1, stiffness = 0.6}
b_pen:load(p_linen_shadow_deep, 0.7)
b_pen:stroke({{172, 570}, {196, 635}, {213, 675}, {206, 730}}, {pressure = {0.3, 0.7, 0.3}, orient = "along"})

-- Fold B crest (central lit fold, sweeping gracefully from table top down over front edge)
local crest_b = ribbon({{178, 555}, {208, 620}, {226, 674}, {222, 742}}, 12) * m_napkin
work(crest_b, {hand = "body", pile = p_linen_crest, angle = 1.1, coverage = 1.4, edge = 0.3})

-- Crease hollow between Fold B and Fold C
local hollow2 = ribbon({{220, 580}, {242, 635}, {248, 675}, {242, 735}}, 12) * m_napkin
work(hollow2, {hand = "body", pile = p_linen_shadow_cool, angle = 1.2, coverage = 1.4, edge = 0.4})

-- Fold C (right fold crest near lemon)
local crest_c = ribbon({{230, 585}, {255, 630}, {262, 674}, {258, 735}}, 10) * m_napkin
work(crest_c, {hand = "body", pile = p_linen_crest, angle = 1.1, coverage = 1.3, edge = 0.3})

-- 3. Soft blend across the folds to create natural cloth rolls rather than rigid edges
blend(m_napkin, {angle = 0.3, coverage = 1.2})

-- 4. Re-establish crisp highlights along the turning edge where the cloth crests bend over the table
local b_touch = brush{kind = "filbert", width = 4, stiffness = 0.6}
b_touch:load(p_linen_high, 0.8)
b_touch:touch(226, 674, {pressure = 0.8, angle = 0.2})
b_touch:touch(262, 674, {pressure = 0.7, angle = 0.2})
b_touch:load(p_linen_crest, 0.7)
b_touch:stroke({{150, 550}, {180, 595}, {205, 640}}, {pressure = {0.5, 0.8, 0.4}, orient = "along"})

-- 5. Soften the outer rim of the napkin where it meets the wood
lose(m_napkin, {pile = p_table_top, reach = {4, 6}, load = 0.2, pressure = {0.3, 0.05}})

print("Napkin sculpted with natural drapery folds and tonal harmony.")
