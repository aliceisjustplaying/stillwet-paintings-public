-- Painting the Linen Napkin and the Walnut

-- Linen Piles
p_linen_high = pile{{"lead white", 9}, {"yellow ochre", 1}, medium = 0.05}
p_linen_lit = pile{{"lead white", 8}, {"yellow ochre", 1}, {"raw umber", 1}, medium = 0.1}
p_linen_mid = pile{{"lead white", 6}, {"raw umber", 2}, {"bone black", 1}, {"yellow ochre", 1}, medium = 0.15}
p_linen_shadow = pile{{"lead white", 5}, {"bone black", 2}, {"raw umber", 2}, {"cobalt blue", 1}, medium = 0.15}
p_linen_deep = pile{{"raw umber", 4}, {"bone black", 3}, {"lead white", 2}, medium = 0.1}

-- Walnut Piles
p_nut_base = pile{{"yellow ochre", 5}, {"raw umber", 4}, {"red earth", 2}, medium = 0.15}
p_nut_dark = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 1}, medium = 0.1}
p_nut_lit = pile{{"yellow ochre", 5}, {"lead white", 3}, {"raw umber", 2}, medium = 0.1}
p_nut_high = pile{{"lead white", 7}, {"yellow ochre", 3}, medium = 0.05}

-- -------------------------------------------------------------
-- 1. LINEN NAPKIN
-- -------------------------------------------------------------
local napkin_pts = {
  {140, 545}, {205, 555}, {255, 580}, {278, 630}, {270, 675},
  {265, 745}, {225, 755}, {205, 735}, {175, 675}, {135, 650}
}
local m_napkin = poly(napkin_pts, true):grow(2)

-- Base coat of warm linen body
work(m_napkin, {hand = "body", pile = p_linen_lit, angle = 0.4, coverage = 1.6, fill = true, edge = 0.2})

-- Upper flat plane of the napkin on the table
local m_napkin_top = m_napkin * mask(function(x, y) return y <= 675 and 1 or 0 end)
-- Front draped overhang hanging down over table edge
local m_napkin_drape = m_napkin * mask(function(x, y) return y > 675 and 1 or 0 end)

-- Fold shadows: cool diagonal troughs running across the cloth
local fold1 = ribbon({{160, 555}, {205, 620}, {225, 675}, {215, 740}}, 18) * m_napkin
local fold2 = ribbon({{220, 570}, {250, 635}, {255, 675}}, 14) * m_napkin
work(fold1, {hand = "body", pile = p_linen_shadow, angle = 1.2, coverage = 1.4, edge = 0.4})
work(fold2, {hand = "body", pile = p_linen_shadow, angle = 1.2, coverage = 1.3, edge = 0.4})

-- Deepest crease line inside fold1
local b_crease = brush{kind = "round", width = 2.2, point = 1, stiffness = 0.6}
b_crease:load(p_linen_deep, 0.7)
b_crease:stroke({{175, 570}, {210, 630}, {226, 675}, {218, 735}}, {pressure = {0.3, 0.7, 0.4}, orient = "along"})

-- Light planes: sunlit crests of the folds
local crest1 = ribbon({{145, 548}, {185, 605}, {200, 672}, {190, 730}}, 16) * m_napkin
local crest2 = ribbon({{200, 560}, {235, 620}, {248, 674}, {245, 740}}, 14) * m_napkin
work(crest1, {hand = "body", pile = p_linen_lit, angle = 0.4, coverage = 1.5, edge = 0.3})
work(crest2, {hand = "body", pile = p_linen_lit, angle = 0.4, coverage = 1.4, edge = 0.3})

-- Soft blend to unite the linen folds
blend(m_napkin, {angle = 0.4, coverage = 1.2})

-- Brilliant impasto touches along the sharp corner where cloth bends over table edge
local b_impasto = brush{kind = "filbert", width = 5, stiffness = 0.7}
b_impasto:load(p_linen_high, 0.9)
b_impasto:stroke({{175, 673}, {205, 674}, {245, 674}, {270, 675}}, {pressure = {0.6, 0.9, 0.5}, orient = "across"})

-- Impasto ridge along main fold crest
local b_line = brush{kind = "round", width = 2.8, point = 1, stiffness = 0.6}
b_line:load(p_linen_high, 0.8)
b_line:stroke({{150, 552}, {180, 600}, {198, 670}}, {pressure = {0.5, 0.8, 0.4}, orient = "along"})
b_line:load(p_linen_high, 0.8)
b_line:stroke({{198, 675}, {190, 725}}, {pressure = {0.7, 0.5, 0.2}, orient = "along"})

-- Crisp crisp hem / bottom edge of the hanging cloth
b_line:load(p_linen_lit, 0.7)
b_line:stroke({{265, 745}, {245, 752}, {225, 755}, {205, 735}}, {pressure = {0.6, 0.8, 0.5}, orient = "along"})

-- Occlusion shadow under the hanging drape onto the dark table apron
local b_dark = brush{kind = "round", width = 3.0, point = 1, stiffness = 0.6}
b_dark:load(p_pot_deep, 0.8)
b_dark:stroke({{266, 748}, {245, 755}, {225, 758}, {205, 740}}, {pressure = {0.4, 0.8, 0.3}, orient = "along"})


-- -------------------------------------------------------------
-- 2. WALNUT
-- -------------------------------------------------------------
local walnut_pts = {
  {725, 655}, {735, 644}, {750, 642}, {762, 650}, {768, 662},
  {758, 672}, {742, 673}, {728, 666}, {725, 655}
}
local m_walnut = poly(walnut_pts, true):grow(2)

-- Base tone
work(m_walnut, {hand = "body", pile = p_nut_base, angle = 0.1, coverage = 1.8, fill = true, edge = 0.2})

-- Shadow side (right and underside)
local m_nut_shadow = m_walnut * mask(function(x, y) return (x > 745 or y > 660) and 1 or 0 end)
work(m_nut_shadow, {hand = "body", pile = p_nut_dark, angle = 0.2, coverage = 1.5, edge = 0.3})

-- Lit side (upper-left shell hemisphere)
local m_nut_lit = m_walnut * mask(function(x, y) return (x <= 745 and y <= 660) and 1 or 0 end)
work(m_nut_lit, {hand = "body", pile = p_nut_lit, angle = 0.1, coverage = 1.5, edge = 0.3})

-- Seam line down center of walnut
b_crease:load(p_nut_dark, 0.8)
b_crease:stroke({{744, 642}, {746, 656}, {744, 672}}, {pressure = {0.4, 0.8, 0.5}, orient = "along"})

-- Rugged shell texture (stippling)
stipple(m_walnut, {pile = p_nut_dark, width = 1.4, coverage = 0.8, feather = 0.2})
stipple(m_nut_lit, {pile = p_nut_high, width = 1.3, coverage = 0.7, feather = 0.3})

-- Specular ridge highlight on shell edge
b_line:load(p_nut_high, 0.7)
b_line:stroke({{738, 644}, {745, 643}}, {pressure = {0.5, 0.8, 0.2}, orient = "along"})

-- Contact and cast shadow of walnut on table
b_dark:load(p_pot_deep, 0.8)
b_dark:stroke({{726, 667}, {742, 674}, {760, 671}}, {pressure = {0.4, 0.8, 0.3}, orient = "along"})
local m_nut_cast = ellipse(772, 668, 16, 7)
work(m_nut_cast, {hand = "glaze", pile = p_cast_shadow, angle = 0.1, coverage = 1.4, edge = 0.4})

print("Linen napkin and walnut painted.")
