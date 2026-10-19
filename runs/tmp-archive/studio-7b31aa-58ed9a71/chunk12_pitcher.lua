-- Chunk 12: Definitive modeling and brushwork on the stoneware pitcher

-- Piles for earthenware clay and glaze
local p_clay_shadow   = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 2}, medium=0.08}
local p_clay_body     = pile{{"raw umber", 4}, {"red earth", 4}, {"yellow ochre", 2}, {"lead white", 0.5}, medium=0.08}
local p_clay_halftone = pile{{"yellow ochre", 4}, {"red earth", 3}, {"raw umber", 2}, {"lead white", 1.5}, medium=0.08}
local p_clay_lit      = pile{{"yellow ochre", 5}, {"lead white", 4}, {"red earth", 1.5}, {"raw umber", 1}, medium=0.05}
local p_clay_glaze_hi = pile{{"lead white", 8}, {"yellow ochre", 2}, {"raw umber", 0.5}, medium=0.02}
local p_clay_bounce   = pile{{"raw umber", 3}, {"yellow ochre", 4}, {"red earth", 2}, medium=0.1}
local p_deep_dark     = pile{{"bone black", 8}, {"raw umber", 3}, medium=0.04}

local b_filbert = brush("filbert", 12)
local b_round   = brush("round", 6)
local b_detail  = brush{kind="round", width=3, point=1, stiffness=0.6}

-- 1. Base and belly mass:
-- Shadow side strokes (following horizontal curvature of the belly)
b_filbert:load(p_clay_shadow, 0.8)
b_filbert:stroke({{350, 390}, {410, 400}, {460, 420}}, {pressure={0.8, 0.5}})
b_filbert:stroke({{350, 440}, {420, 455}, {485, 470}}, {pressure={0.9, 0.6}})
b_filbert:stroke({{350, 490}, {415, 510}, {470, 530}}, {pressure={0.8, 0.5}})
b_filbert:stroke({{340, 540}, {390, 555}, {440, 565}}, {pressure={0.8, 0.4}})

-- Belly midtone transitions
b_filbert:load(p_clay_body, 0.85)
b_filbert:stroke({{280, 390}, {330, 400}, {380, 410}}, {pressure={0.8, 0.7}})
b_filbert:stroke({{260, 440}, {320, 450}, {380, 460}}, {pressure={0.9, 0.8}})
b_filbert:stroke({{275, 490}, {330, 505}, {380, 515}}, {pressure={0.8, 0.7}})
b_filbert:stroke({{290, 540}, {340, 550}, {380, 555}}, {pressure={0.7, 0.6}})

-- Lit shoulder and belly
b_filbert:load(p_clay_halftone, 0.85)
b_filbert:stroke({{265, 370}, {300, 385}, {335, 395}}, {pressure={0.8, 0.7}})
b_filbert:stroke({{250, 415}, {290, 430}, {330, 440}}, {pressure={0.9, 0.8}})
b_filbert:stroke({{245, 460}, {285, 470}, {325, 475}}, {pressure={0.8, 0.7}})
b_filbert:stroke({{270, 515}, {300, 525}, {335, 530}}, {pressure={0.7, 0.6}})

-- Strong light plane on upper shoulder
b_filbert:load(p_clay_lit, 0.8)
b_filbert:stroke({{275, 360}, {310, 375}, {340, 380}}, {pressure={0.7, 0.5}})
b_filbert:stroke({{260, 400}, {295, 415}, {325, 420}}, {pressure={0.8, 0.6}})

-- Reflected bounce light on right shadow edge
b_round:load(p_clay_bounce, 0.6)
b_round:stroke({{470, 410}, {485, 460}, {465, 525}}, {pressure={0.4, 0.6, 0.3}})

-- 2. Neck and Collar:
-- Shadow on right of neck
b_filbert:load(p_clay_shadow, 0.7)
b_filbert:stroke({{375, 275}, {380, 310}, {385, 340}}, {pressure={0.7, 0.7}})
b_filbert:stroke({{395, 275}, {400, 305}, {405, 335}}, {pressure={0.6, 0.5}})

-- Lit side on left of neck
b_filbert:load(p_clay_halftone, 0.75)
b_filbert:stroke({{345, 275}, {345, 305}, {345, 335}}, {pressure={0.7, 0.7}})
b_round:load(p_clay_lit, 0.7)
b_round:stroke({{325, 275}, {328, 305}, {330, 335}}, {pressure={0.6, 0.5}})

-- 3. Mouth and Rim:
-- Deep black interior void
b_detail:load(p_deep_dark, 0.9)
b_detail:stroke({{335, 267}, {365, 268}, {395, 267}}, {pressure={0.8, 0.9, 0.6}})

-- Rounded lip contour catching light
b_detail:load(p_clay_lit, 0.85)
b_detail:stroke({{315, 268}, {345, 274}, {380, 273}}, {pressure={0.6, 0.8, 0.4}})
b_detail:load(p_clay_shadow, 0.7)
b_detail:stroke({{380, 273}, {405, 270}, {415, 266}}, {pressure={0.4, 0.5, 0.3}})

-- 4. The Arched Strap Handle:
-- Under-shadow of handle
b_round:load(p_clay_shadow, 0.85)
b_round:stroke({{315, 310}, {255, 290}, {205, 335}, {205, 385}, {235, 420}, {255, 430}},
               {pressure={0.7, 0.8, 0.8, 0.7, 0.6}})

-- Top spine / lit crest of handle
b_detail:load(p_clay_halftone, 0.8)
b_detail:stroke({{315, 303}, {250, 278}, {198, 330}, {198, 375}, {225, 412}, {250, 425}},
                {pressure={0.4, 0.7, 0.7, 0.5, 0.3}})
b_detail:load(p_clay_lit, 0.7)
b_detail:stroke({{280, 283}, {235, 286}, {202, 320}, {200, 355}}, {pressure={0.3, 0.6, 0.6, 0.2}})

-- 5. Specular Glaze Sheen / Highlights:
-- Shoulder highlight (juicy impasto)
b_detail:load(p_clay_glaze_hi, 0.9)
b_detail:stroke({{295, 375}, {312, 400}, {318, 425}}, {pressure={0.2, 0.7, 0.3}})
-- Neck highlight
b_detail:load(p_clay_glaze_hi, 0.75)
b_detail:stroke({{332, 280}, {334, 305}, {335, 325}}, {pressure={0.2, 0.5, 0.2}})
-- Rim gleam
b_detail:load(p_clay_glaze_hi, 0.8)
b_detail:touch(335, 273, {pressure=0.6})
-- Secondary belly gleam
b_detail:load(p_clay_glaze_hi, 0.65)
b_detail:stroke({{290, 445}, {295, 465}}, {pressure={0.2, 0.5, 0.1}})
