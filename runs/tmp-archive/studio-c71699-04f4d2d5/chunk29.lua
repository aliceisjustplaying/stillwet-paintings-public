-- Final Sculptural Refinement of Jug, Lemon Peel, and Napkin

-- Piles
local p_pot_terra = pile{{"red earth", 6}, {"yellow ochre", 3}, {"raw umber", 2}, medium = 0.15}
local p_pot_shadow = pile{{"raw umber", 6}, {"bone black", 3}, {"red earth", 2}, medium = 0.1}
local p_pot_lit = pile{{"yellow ochre", 5}, {"red earth", 3}, {"lead white", 3}, medium = 0.12}
local p_pot_refl = pile{{"yellow ochre", 4}, {"red earth", 3}, {"raw umber", 2}, {"lead white", 1}, medium = 0.15}
local p_pot_spec = pile{{"lead white", 8}, {"yellow ochre", 2}, medium = 0.05}
local p_pot_throat = pile{{"bone black", 7}, {"raw umber", 3}, medium = 0.05}
local p_deep = pile{{"bone black", 7}, {"raw umber", 3}, medium = 0.05}

local p_lem_pure = pile{{"chrome yellow", 7}, {"yellow ochre", 2}, {"lead white", 1}, medium = 0.1}
local p_pith = pile{{"lead white", 7}, {"yellow ochre", 2}, {"raw umber", 1}, medium = 0.1}
local p_spark = pile{{"lead white", 9}, {"chrome yellow", 1}, medium = 0.05}

local p_lin_lit = pile{{"lead white", 8}, {"yellow ochre", 1}, {"raw umber", 1}, medium = 0.1}
local p_lin_crest = pile{{"lead white", 8}, {"yellow ochre", 2}, medium = 0.08}
local p_lin_high = pile{{"lead white", 9}, {"yellow ochre", 1}, medium = 0.05}
local p_lin_sh = pile{{"lead white", 5}, {"bone black", 2}, {"raw umber", 2}, {"cobalt blue", 1}, medium = 0.15}

-- -------------------------------------------------------------
-- 1. EARTHENWARE JUG HARMONIZATION
-- -------------------------------------------------------------
local body_pts = {
  {545, 310}, {590, 305}, {635, 310}, {642, 322}, {630, 370},
  {665, 415}, {680, 475}, {672, 545}, {645, 605}, {630, 626},
  {590, 631}, {550, 626}, {535, 605}, {508, 545}, {500, 475},
  {515, 415}, {550, 370}, {538, 322}
}
local jug_body = poly(body_pts, true)
local jug_interior = ellipse(590, 313, 38, 9)

-- Warm unifying glaze across the belly to melt vertical stripes into smooth roundness
local m_belly_fuse = jug_body * mask(function(x, y) return (y > 360 and y < 615) and 1 or 0 end) - jug_interior
work(m_belly_fuse, {hand = "glaze", pile = p_pot_terra, angle = 0.1, coverage = 1.4, edge = 0.3})

-- Core shadow blending
local m_jug_sh = jug_body * mask(function(x, y) return (x > 585 and y > 360 and y < 615) and 1 or 0 end)
work(m_jug_sh, {hand = "glaze", pile = p_pot_shadow, angle = 0.2, coverage = 1.2, edge = 0.4})

-- Reflected light along right edge
local m_jug_rf = jug_body * mask(function(x, y)
  if x < 650 then return 0 end
  return smoothstep(650, 678, x) * smoothstep(380, 430, y) * smoothstep(620, 560, y) * 0.7
end)
work(m_jug_rf, {hand = "glaze", pile = p_pot_refl, angle = 0.3, coverage = 1.2, edge = 0.3})

-- Blend across the jug body to create smooth ceramic turning
blend(m_belly_fuse, {angle = 0.1, coverage = 1.6})

-- Crisp throat opening
work(jug_interior, {hand = "detail", pile = p_pot_throat, angle = 0, coverage = 2.0, clip = true})

-- Lip highlight on left
local b_point = brush{kind = "round", width = 2.8, point = 1, stiffness = 0.7}
b_point:load(p_pot_lit, 0.8)
b_point:stroke({{545, 317}, {570, 322}, {585, 323}}, {pressure = {0.6, 0.85, 0.3}, orient = "along"})

-- Specular glaze highlight on shoulder
b_point:load(p_pot_spec, 0.9)
b_point:stroke({{538, 432}, {542, 452}, {544, 468}}, {pressure = {0.75, 0.95, 0.3}, orient = "along"})
b_point:load(p_pot_spec, 0.7)
b_point:touch(540, 448, {pressure = 0.85})

-- Handle modeling: lit strap top, shadow underside
local b_handle = brush{kind = "round", width = 3.2, point = 1, stiffness = 0.6}
b_handle:load(p_pot_lit, 0.8)
b_handle:stroke({{632, 358}, {675, 368}, {694, 408}}, {pressure = {0.6, 0.8, 0.5}, orient = "along"})
b_handle:load(p_pot_shadow, 0.8)
b_handle:stroke({{636, 372}, {670, 382}, {686, 420}, {678, 465}, {664, 485}}, {pressure = {0.4, 0.7, 0.4}, orient = "along"})


-- -------------------------------------------------------------
-- 2. LEMON PEEL CONNECTION TO CUT LEMON
-- -------------------------------------------------------------
-- Connect the peel start to the lemon cut face rim
local b_peel = brush{kind = "round", width = 3.4, point = 1, stiffness = 0.7}
b_peel:load(p_lem_pure, 0.9)
b_peel:stroke({{455, 648}, {450, 660}, {442, 672}, {430, 686}}, {pressure = {0.7, 0.85, 0.8, 0.6}, orient = "along"})

-- Inner pith highlight along the connect
local b_fine = brush{kind = "round", width = 1.6, point = 1, stiffness = 0.8}
b_fine:load(p_pith, 0.8)
b_fine:stroke({{452, 650}, {447, 662}, {436, 678}}, {pressure = {0.5, 0.7, 0.4}, orient = "along"})

-- Little nipple tip on whole lemon
b_fine:load(p_lem_pure, 0.8)
b_fine:stroke({{312, 626}, {304, 626}, {307, 628}}, {pressure = {0.6, 0.8, 0.4}, orient = "along"})


-- -------------------------------------------------------------
-- 3. TAILORING THE FOLDED LINEN NAPKIN
-- -------------------------------------------------------------
-- Clean, crisp linen body coat
local m_nap_body = poly({
  {140, 546}, {242, 548}, {264, 605}, {262, 674},
  {258, 742}, {218, 745}, {212, 742}, {165, 740}, {165, 674},
  {138, 630}, {134, 580}
}, true)

work(m_nap_body, {hand = "body", pile = p_lin_lit, angle = 0.3, coverage = 1.6, fill = true, edge = 0.1})

-- Two clean vertical folds hanging over the table edge
local v_trough = ribbon({{195, 560}, {210, 625}, {216, 674}, {212, 742}}, 12) * m_nap_body
work(v_trough, {hand = "body", pile = p_lin_sh, angle = 1.2, coverage = 1.5, edge = 0.25})

local v_left_sh = m_nap_body * mask(function(x, y) return smoothstep(165, 134, x) end)
work(v_left_sh, {hand = "body", pile = p_lin_sh, angle = 1.1, coverage = 1.3, edge = 0.25})

-- Crease lines
b_fine:load(p_deep, 0.6)
b_fine:stroke({{196, 565}, {211, 628}, {217, 674}, {213, 740}}, {pressure = {0.2, 0.5, 0.2}, orient = "along"})

-- Lit fold crests
local v_crest1 = ribbon({{155, 548}, {180, 610}, {188, 674}, {185, 740}}, 14) * m_nap_body
local v_crest2 = ribbon({{220, 555}, {238, 615}, {244, 674}, {240, 742}}, 14) * m_nap_body
work(v_crest1, {hand = "body", pile = p_lin_crest, angle = 0.5, coverage = 1.4, edge = 0.25})
work(v_crest2, {hand = "body", pile = p_lin_crest, angle = 0.5, coverage = 1.4, edge = 0.25})

-- Soft blend across folds
blend(m_nap_body, {angle = 0.4, coverage = 1.1})

-- Crisp folded linen hems
local b_hem = brush{kind = "round", width = 2.0, point = 1, stiffness = 0.7}
b_hem:load(p_lin_crest, 0.85)
b_hem:stroke({{262, 674}, {258, 742}, {218, 745}, {212, 742}, {165, 740}}, {pressure = {0.6, 0.8, 0.6}, orient = "along"})
b_hem:stroke({{165, 740}, {165, 674}, {138, 630}, {134, 580}, {140, 546}, {242, 548}}, {pressure = {0.5, 0.7, 0.4}, orient = "along"})

-- Sharp impasto highlights on the table edge folds
local b_imp = brush{kind = "filbert", width = 3.5, stiffness = 0.8}
b_imp:load(p_lin_high, 0.9)
b_imp:touch(188, 674, {pressure = 0.9})
b_imp:touch(244, 674, {pressure = 0.9})

-- Occlusion shadow under hanging drape
local b_dark = brush{kind = "round", width = 2.6, point = 1, stiffness = 0.6}
b_dark:load(p_deep, 0.85)
b_dark:stroke({{164, 742}, {212, 745}, {218, 748}, {260, 744}}, {pressure = {0.5, 0.9, 0.4}, orient = "along"})

print("Final sculptural refinements completed.")
