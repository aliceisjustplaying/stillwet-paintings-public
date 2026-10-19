-- Chunk 13: Modeling the golden quince and refining the wooden shelf

-- 1. Piles for Quince
local p_quince_deep_shd = pile{{"raw umber", 4}, {"yellow ochre", 4}, {"green earth", 3}, {"bone black", 1}, medium=0.08}
local p_quince_shadow   = pile{{"yellow ochre", 6}, {"raw umber", 3}, {"green earth", 2}, medium=0.08}
local p_quince_bounce   = pile{{"yellow ochre", 6}, {"red earth", 2}, {"raw umber", 2}, {"lead white", 1}, medium=0.1}
local p_quince_bloom    = pile{{"yellow ochre", 4}, {"green earth", 2}, {"pale smalt", 1.5}, {"lead white", 3}, medium=0.12}
local p_quince_body     = pile{{"yellow ochre", 6}, {"chrome yellow", 4}, {"lead white", 2}, medium=0.06}
local p_quince_lit      = pile{{"chrome yellow", 6}, {"lead white", 5}, {"yellow ochre", 2}, medium=0.04}
local p_quince_high     = pile{{"lead white", 8}, {"chrome yellow", 3}, {"yellow ochre", 0.5}, medium=0.02}
local p_calyx_stem      = pile{{"raw umber", 6}, {"bone black", 4}, {"red earth", 1}, medium=0.05}

local b_filbert = brush("filbert", 10)
local b_round   = brush("round", 5)
local b_detail  = brush{kind="round", width=2.8, point=1, stiffness=0.6}

-- Deep shadow on lower right flank of quince
b_filbert:load(p_quince_deep_shd, 0.85)
b_filbert:stroke({{650, 520}, {690, 550}, {725, 590}, {710, 630}}, {pressure={0.7, 0.9, 0.8, 0.5}})
b_filbert:stroke({{630, 580}, {670, 610}, {700, 635}}, {pressure={0.8, 0.9, 0.6}})

-- Shadow transition (golden-olive)
b_filbert:load(p_quince_shadow, 0.85)
b_filbert:stroke({{620, 500}, {660, 530}, {680, 570}}, {pressure={0.8, 0.85, 0.7}})
b_filbert:stroke({{590, 550}, {630, 590}, {660, 625}}, {pressure={0.8, 0.85, 0.6}})

-- Reflected light along lower right contour
b_round:load(p_quince_bounce, 0.7)
b_round:stroke({{735, 570}, {730, 610}, {705, 640}}, {pressure={0.4, 0.6, 0.3}})

-- Delicate greenish bloom across the terminator
b_round:load(p_quince_bloom, 0.7)
b_round:stroke({{600, 480}, {625, 520}, {645, 565}, {635, 610}}, {pressure={0.4, 0.6, 0.5, 0.3}})

-- Warm golden body of the quince
b_filbert:load(p_quince_body, 0.9)
b_filbert:stroke({{585, 475}, {570, 520}, {560, 570}, {575, 615}}, {pressure={0.7, 0.85, 0.85, 0.6}})
b_filbert:stroke({{600, 465}, {590, 510}, {590, 560}, {605, 610}}, {pressure={0.8, 0.9, 0.85, 0.7}})
b_filbert:stroke({{615, 460}, {610, 500}, {615, 550}, {625, 590}}, {pressure={0.8, 0.85, 0.8, 0.6}})

-- Lit face and knobby bulges
b_filbert:load(p_quince_lit, 0.9)
b_filbert:stroke({{595, 470}, {580, 510}, {575, 555}}, {pressure={0.7, 0.85, 0.6}})
b_round:load(p_quince_lit, 0.85)
b_round:stroke({{565, 560}, {575, 595}, {600, 620}}, {pressure={0.6, 0.8, 0.5}})

-- Specular impasto highlights on the upper crest of the fruit
b_detail:load(p_quince_high, 0.95)
b_detail:stroke({{585, 475}, {580, 495}, {575, 520}}, {pressure={0.3, 0.8, 0.4}})
b_detail:touch(578, 490, {pressure=0.85})
b_detail:stroke({{595, 465}, {602, 480}}, {pressure={0.3, 0.7, 0.2}})

-- Calyx / blossom scar and woody stem
b_detail:load(p_calyx_stem, 0.9)
-- Calyx socket
b_detail:stroke({{602, 452}, {612, 450}, {618, 453}}, {pressure={0.5, 0.8, 0.4}})
b_detail:touch(610, 451, {pressure=0.8})
-- Woody curved stem pointing slightly up and left
b_detail:stroke({{610, 450}, {605, 435}, {596, 420}}, {pressure={0.6, 0.5, 0.3}})

-- 2. Wooden Shelf & Ledge
local p_wood_plane   = pile{{"yellow ochre", 5}, {"raw umber", 4}, {"lead white", 3}, {"red earth", 1}, medium=0.15}
local p_wood_grain   = pile{{"raw umber", 5}, {"yellow ochre", 3}, {"bone black", 1}, medium=0.15}
local p_ledge_bevel  = pile{{"lead white", 6}, {"yellow ochre", 4}, {"raw umber", 1}, medium=0.05}
local p_table_apron  = pile{{"bone black", 7}, {"raw umber", 4}, {"red earth", 1}, medium=0.12}

local b_flat = brush("flat", 8)

-- Wood grain strokes running horizontally across the shelf
b_flat:load(p_wood_plane, 0.8)
b_flat:stroke({{0, 545}, {260, 545}}, {pressure={0.7, 0.7}})
b_flat:stroke({{460, 540}, {560, 538}}, {pressure={0.6, 0.6}})
b_flat:stroke({{720, 535}, {1000, 530}}, {pressure={0.7, 0.7}})

b_flat:load(p_wood_grain, 0.6)
b_flat:stroke({{0, 590}, {250, 590}}, {pressure={0.5, 0.4}})
b_flat:stroke({{740, 580}, {1000, 575}}, {pressure={0.5, 0.5}})
b_flat:stroke({{0, 630}, {280, 630}}, {pressure={0.5, 0.4}})
b_flat:stroke({{740, 625}, {1000, 620}}, {pressure={0.5, 0.5}})

-- Sharp, luminous front bevel highlight along the ledge edge (y ~ 672)
local b_liner = brush{kind="round", width=2.5, point=1, stiffness=0.7}
b_liner:load(p_ledge_bevel, 0.9)
b_liner:stroke({{0, 674}, {280, 673}, {500, 672}, {750, 671}, {1000, 670}},
               {pressure={0.6, 0.8, 0.7, 0.8, 0.5}})

-- Deep shadow right underneath the bevel lip
local b_shadow = brush("round", 4)
b_shadow:load(p_table_apron, 0.85)
b_shadow:stroke({{0, 678}, {300, 677}, {600, 676}, {1000, 674}}, {pressure={0.7, 0.8, 0.7, 0.6}})
