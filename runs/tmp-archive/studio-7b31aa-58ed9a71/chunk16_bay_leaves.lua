-- Chunk 16: Bay leaves in foreground, quince edge integration, and refined details

-- 1. Integrate Quince right shadow edge into background
local p_quince_sfumato = pile{{"raw umber", 5}, {"bone black", 4}, {"yellow ochre", 2}, medium=0.25}
local b_filbert = brush("filbert", 8)
b_filbert:load(p_quince_sfumato, 0.5)
b_filbert:stroke({{660, 470}, {715, 515}, {745, 565}, {735, 615}}, {pressure={0.3, 0.5, 0.5, 0.3}})

-- Re-touch the warm bounce inside the quince shadow
local p_quince_bounce = pile{{"yellow ochre", 6}, {"red earth", 2}, {"raw umber", 2}, {"lead white", 1}, medium=0.1}
local b_round = brush("round", 4)
b_round:load(p_quince_bounce, 0.65)
b_round:stroke({{725, 560}, {720, 600}, {695, 635}}, {pressure={0.3, 0.6, 0.3}})

-- 2. Bay Leaves Palettes
local p_leaf_dark   = pile{{"green earth", 6}, {"raw umber", 4}, {"bone black", 1}, {"Prussian blue", 0.5}, medium=0.08}
local p_leaf_mid    = pile{{"green earth", 5}, {"yellow ochre", 4}, {"raw umber", 2}, {"lead white", 1}, medium=0.08}
local p_leaf_lit    = pile{{"yellow ochre", 5}, {"green earth", 3}, {"lead white", 3}, {"chrome yellow", 1}, medium=0.06}
local p_leaf_vein   = pile{{"lead white", 5}, {"yellow ochre", 4}, {"green earth", 1}, medium=0.04}
local p_stem        = pile{{"raw umber", 7}, {"red earth", 3}, {"bone black", 1}, medium=0.06}
local p_leaf_shadow = pile{{"bone black", 6}, {"raw umber", 5}, medium=0.25}

local b_leaf = brush("filbert", 5)
local b_detail = brush{kind="round", width=2.2, point=1, stiffness=0.7}

-- Cast shadows of bay leaves on shelf
b_detail:load(p_leaf_shadow, 0.7)
b_detail:stroke({{460, 633}, {485, 638}, {505, 642}}, {pressure={0.3, 0.5, 0.2}})
b_detail:stroke({{530, 654}, {560, 653}, {582, 656}}, {pressure={0.3, 0.5, 0.2}})
-- Cast shadow of overhanging leaf on the vertical apron
b_detail:stroke({{552, 680}, {560, 695}, {565, 708}}, {pressure={0.4, 0.6, 0.3}})

-- Woody twig / stem
b_detail:load(p_stem, 0.85)
b_detail:stroke({{475, 615}, {505, 638}, {535, 660}, {552, 680}}, {pressure={0.4, 0.7, 0.6, 0.3}})

-- Leaf 1 (Left leaf, pointing back-left)
-- Dark underside
b_leaf:load(p_leaf_dark, 0.85)
b_leaf:stroke({{500, 633}, {475, 630}, {448, 624}}, {pressure={0.6, 0.8, 0.3}})
-- Lit upper facet
b_leaf:load(p_leaf_mid, 0.85)
b_leaf:stroke({{498, 628}, {472, 622}, {448, 624}}, {pressure={0.5, 0.7, 0.2}})
-- Highlight along the leaf ridge
b_detail:load(p_leaf_lit, 0.8)
b_detail:stroke({{490, 627}, {470, 622}, {452, 624}}, {pressure={0.2, 0.6, 0.2}})
-- Pale central vein
b_detail:load(p_leaf_vein, 0.75)
b_detail:stroke({{495, 630}, {470, 625}, {450, 624}}, {pressure={0.2, 0.4, 0.1}})

-- Leaf 2 (Center-right leaf, resting on table)
-- Dark underside
b_leaf:load(p_leaf_dark, 0.85)
b_leaf:stroke({{520, 648}, {550, 646}, {580, 652}}, {pressure={0.5, 0.7, 0.3}})
-- Lit upper facet
b_leaf:load(p_leaf_lit, 0.85)
b_leaf:stroke({{522, 644}, {552, 640}, {580, 652}}, {pressure={0.5, 0.7, 0.2}})
-- Central vein
b_detail:load(p_leaf_vein, 0.75)
b_detail:stroke({{522, 646}, {550, 643}, {578, 652}}, {pressure={0.2, 0.4, 0.1}})

-- Leaf 3 (Curling over the front bevel edge)
-- Leaf curving over edge
b_leaf:load(p_leaf_dark, 0.85)
b_leaf:stroke({{535, 663}, {548, 675}, {558, 695}}, {pressure={0.6, 0.8, 0.4}})
b_leaf:load(p_leaf_lit, 0.85)
b_leaf:stroke({{534, 660}, {546, 672}, {556, 693}}, {pressure={0.5, 0.8, 0.3}})
-- Bevel crest catch-light on the curled leaf
b_detail:load(p_leaf_vein, 0.85)
b_detail:stroke({{544, 671}, {548, 676}}, {pressure={0.3, 0.7, 0.3}})

-- 3. Pitcher finishing specular accents
local p_specular = pile{{"lead white", 9}, {"chrome yellow", 1}, medium=0.01}
-- Crisp point highlight on the ceramic shoulder
b_detail:load(p_specular, 0.95)
b_detail:touch(296, 402, {pressure=0.8})
b_detail:touch(333, 275, {pressure=0.7})
b_detail:touch(335, 300, {pressure=0.6})
