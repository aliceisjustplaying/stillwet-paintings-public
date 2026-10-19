-- Chunk 15: Integrating the pitcher shoulder, solidifying the handle, refining edges and cast shadows

local p_wall_cut   = pile{{"raw umber", 6}, {"bone black", 3}, {"yellow ochre", 2}, medium=0.15}
local p_wall_dark  = pile{{"raw umber", 6}, {"bone black", 5}, {"red earth", 1}, medium=0.15}
local p_clay_glaze = pile{{"red earth", 4}, {"raw umber", 4}, {"yellow ochre", 2}, medium=0.25}
local p_clay_body  = pile{{"raw umber", 4}, {"red earth", 4}, {"yellow ochre", 3}, {"lead white", 1}, medium=0.08}
local p_clay_shadow = pile{{"raw umber", 6}, {"bone black", 4}, {"red earth", 2}, medium=0.08}
local p_clay_hi    = pile{{"lead white", 8}, {"yellow ochre", 2}, {"red earth", 0.5}, medium=0.03}
local p_deep_black = pile{{"bone black", 8}, {"raw umber", 3}, medium=0.04}

local b_filbert = brush("filbert", 10)
local b_round   = brush("round", 6)
local b_detail  = brush{kind="round", width=2.8, point=1, stiffness=0.6}

-- 1. Negative space inside handle loop
local m_handle_inner = poly({{220, 335}, {265, 305}, {305, 320}, {295, 370}, {255, 400}, {225, 380}}, true)
work(m_handle_inner, {hand="detail", pile=p_wall_cut, angle=0.0, coverage=1.8, fill=true, clip=true})

-- Outer contour cleanup around handle and neck
b_filbert:load(p_wall_cut, 0.8)
b_filbert:stroke({{185, 270}, {180, 340}, {185, 420}}, {pressure={0.6, 0.7, 0.5}})
b_filbert:stroke({{290, 255}, {350, 250}, {430, 255}}, {pressure={0.5, 0.6, 0.5}})

-- 2. Glaze over pitcher shoulder to fuse striped marks into rich earthenware form
b_filbert:load(p_clay_glaze, 0.7)
b_filbert:stroke({{250, 360}, {300, 380}, {340, 400}}, {pressure={0.6, 0.7, 0.5}})
b_filbert:stroke({{240, 400}, {290, 420}, {330, 435}}, {pressure={0.7, 0.8, 0.6}})
b_filbert:stroke({{245, 440}, {285, 455}, {325, 465}}, {pressure={0.6, 0.7, 0.5}})

-- Soft blend on the glazed shoulder
blend(ellipse(290, 420, 55, 65), {angle=0.4, coverage=0.8})

-- 3. Solid earthenware strap handle
-- Underbody / shadow of handle
b_round:load(p_clay_shadow, 0.85)
b_round:stroke({{315, 310}, {245, 285}, {195, 335}, {200, 380}, {230, 415}, {255, 430}},
               {pressure={0.8, 0.85, 0.85, 0.8, 0.6}})

-- Lit face / spine of handle
b_detail:load(p_clay_body, 0.85)
b_detail:stroke({{315, 304}, {245, 280}, {198, 330}, {202, 375}, {228, 410}, {250, 425}},
                {pressure={0.6, 0.8, 0.8, 0.6, 0.4}})

-- Gleam on handle top curve
b_detail:load(p_clay_hi, 0.8)
b_detail:stroke({{265, 283}, {230, 285}, {202, 315}, {200, 345}}, {pressure={0.3, 0.7, 0.7, 0.2}})

-- 4. Ceramic glaze specular highlights on pitcher
-- Natural curved highlight on shoulder swell
b_detail:load(p_clay_hi, 0.9)
b_detail:stroke({{280, 385}, {298, 410}, {308, 435}}, {pressure={0.2, 0.8, 0.3}})
-- Neck highlight
b_detail:load(p_clay_hi, 0.8)
b_detail:stroke({{332, 280}, {334, 305}, {335, 325}}, {pressure={0.2, 0.6, 0.2}})
-- Rim light on left lip
b_detail:touch(335, 273, {pressure=0.7})

-- 5. Firm up background wall behind Quince right silhouette
b_filbert:load(p_wall_dark, 0.85)
b_filbert:stroke({{640, 455}, {685, 485}, {740, 530}, {755, 580}, {735, 630}},
                 {pressure={0.6, 0.8, 0.8, 0.8, 0.5}})

-- 6. Translucent glaze across cast shadows on the wooden shelf
local p_shadow_glaze = pile{{"raw umber", 6}, {"bone black", 3}, medium=0.4}
local b_flat = brush("flat", 12)
b_flat:load(p_shadow_glaze, 0.6)
b_flat:stroke({{380, 600}, {480, 605}, {560, 615}}, {pressure={0.4, 0.5, 0.3}})
b_flat:stroke({{650, 640}, {730, 645}, {800, 650}}, {pressure={0.4, 0.5, 0.3}})

-- Firm dark contact occlusion at base of jug and quince
b_detail:load(p_deep_black, 0.95)
b_detail:stroke({{305, 577}, {375, 580}, {445, 576}}, {pressure={0.8, 0.9, 0.7}})
b_detail:stroke({{565, 648}, {630, 654}, {705, 641}}, {pressure={0.8, 0.9, 0.7}})
