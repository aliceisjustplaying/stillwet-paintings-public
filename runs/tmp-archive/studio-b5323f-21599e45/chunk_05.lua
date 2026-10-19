-- Piles for refining and modeling
p_glaze_deep = pile{{"raw umber", 4}, {"red earth", 3}, {"bone black", 1}, medium=0.25}
p_glaze_amber = pile{{"yellow ochre", 4}, {"red earth", 3.5}, {"raw umber", 1.5}, medium=0.2}
p_jug_refl = pile{{"yellow ochre", 4}, {"red earth", 3}, {"raw umber", 2}, medium=0.18}
p_jug_light_warm = pile{{"lead white", 4.5}, {"yellow ochre", 3.5}, {"red earth", 2}, {"raw umber", 0.5}, medium=0.1}
p_rim_light = pile{{"lead white", 6}, {"yellow ochre", 3}, {"raw umber", 0.5}, medium=0.08}

-- 1. Unify background behind the jug neck and upper wall
p_bg_melt = pile{{"raw umber", 4}, {"bone black", 3}, {"yellow ochre", 1.5}, medium=0.35}
m_bg_upper = mask(function(x, y)
  if y > 460 or x < 280 or x > 600 then return 0 end
  local dx = (x - 440) / 160
  local dy = (y - 200) / 260
  if dx*dx + dy*dy > 1 then return 0 end
  return 1 - (dx*dx + dy*dy)
end) - m_objects
work(m_bg_upper, {hand="glaze", pile=p_bg_melt, angle=0.2, coverage=1.1})
blend(m_wall * mask(function(x, y) return x > 250 and x < 650 and y < 500 and 1 or 0 end), {angle=0.1, coverage=1.2})

-- 2. Model the Jug
-- A. Glaze on the neck and shoulder (from y=285 to y=430)
m_jug_neck_glaze = (m_jug - m_jug_mouth) * mask(function(x, y)
  if y < 285 or y > 430 then return 0 end
  if y < 380 then return 1 end
  return 1 - (y - 380) / 50
end)
work(m_jug_neck_glaze, {hand="body", pile=p_glaze_amber, angle=1.4, coverage=1.2, fill=true, clip=true})

-- Deep shade on the right of the neck glaze
m_jug_neck_shade = m_jug_neck_glaze * mask(function(x, y) return x > 380 and 1 or 0 end)
work(m_jug_neck_shade, {hand="body", pile=p_glaze_deep, angle=1.45, coverage=1.4, fill=true, clip=true})

-- B. Reflected light along the right flank of the jug body (x: 435 to 495, y: 440 to 600)
m_jug_refl = m_jug * mask(function(x, y)
  if x < 440 or x > 495 or y < 430 or y > 615 then return 0 end
  return (x - 440) / 55
end)
work(m_jug_refl, {hand="body", pile=p_jug_refl, angle=1.5, coverage=1.3, fill=true, clip=true})

-- C. Primary light passage on the left belly (x: 280 to 370, y: 380 to 580)
m_jug_belly_light = m_jug * mask(function(x, y)
  if x < 280 or x > 380 or y < 380 or y > 580 then return 0 end
  local cx, cy = 330, 470
  local d = math.sqrt(((x - cx)/50)^2 + ((y - cy)/90)^2)
  if d > 1 then return 0 end
  return (1 - d)
end)
work(m_jug_belly_light, {hand="body", pile=p_jug_light_warm, angle=1.35, coverage=1.4, fill=true, clip=true})

-- Blend the jug belly to integrate reflected light, core shadow, and lit flank
blend(m_jug * mask(function(x, y) return y >= 320 and y <= 620 and 1 or 0 end), {angle=0.15, coverage=1.1, clip=true})

-- D. Rim and mouth definition
b_filbert = brush("filbert", 6)
b_round = brush{kind="round", width=3, point=1, stiffness=0.5}

-- Inside shadow of the mouth lip
b_round:load(p_interior, 0.8)
b_round:stroke({
  {335, 280}, {380, 276}, {425, 280}
}, {pressure={0.3, 0.6, 0.3}, clip=m_jug})

-- Lit rim curve
b_round:reload(p_rim_light, 0.8)
b_round:stroke({
  {325, 283}, {350, 288}, {380, 290}, {410, 288}, {435, 283}
}, {pressure={0.5, 0.7, 0.8, 0.5, 0.2}, clip=m_jug})

-- E. Handle modeling: cast shadow onto the neck, highlight along the spine
m_handle_cast = m_jug * mask(function(x, y)
  if x < 290 or x > 340 or y < 350 or y > 470 then return 0 end
  return 1
end)
work(m_handle_cast, {hand="detail", pile=p_jug_shadow, angle=1.2, coverage=1.4, fill=true, clip=true})

-- Highlight along handle spine
b_round:reload(p_jug_light_warm, 0.7)
b_round:stroke({
  {338, 332}, {280, 345}, {246, 395}, {249, 440}, {272, 475}
}, {pressure={0.2, 0.6, 0.7, 0.6, 0.3}, clip=m_handle})

-- 3. Quince Development
p_quince_calyx = pile{{"raw umber", 5}, {"bone black", 3}, {"red earth", 1}, medium=0.12}
p_quince_warm_refl = pile{{"yellow ochre", 4}, {"raw umber", 2}, {"red earth", 1}, medium=0.15}
p_quince_hi = pile{{"lead white", 6}, {"chrome yellow", 3}, {"yellow ochre", 1}, medium=0.08}

-- Reflected light along lower right base
m_quince_refl = m_quince * mask(function(x, y)
  if x < 670 or y < 610 then return 0 end
  return 1
end)
work(m_quince_refl, {hand="body", pile=p_quince_warm_refl, angle=0.2, coverage=1.2, fill=true, clip=true})

-- Highlight dome on upper left of quince
m_quince_dome = m_quince * mask(function(x, y)
  local dx = (x - 645) / 25
  local dy = (y - 580) / 25
  local d = dx*dx + dy*dy
  if d > 1 then return 0 end
  return (1 - d)
end)
work(m_quince_dome, {hand="detail", pile=p_quince_hi, angle=-0.5, coverage=1.4, fill=true, clip=true})

-- Calyx / eye of the quince
b_round:reload(p_quince_calyx, 0.8)
b_round:touch(692, 618, {pressure=0.6, drag={2, 1}})
b_round:stroke({{688, 616}, {694, 620}}, {pressure={0.4, 0.2}})
b_round:stroke({{692, 614}, {693, 622}}, {pressure={0.4, 0.2}})

-- 4. Citrus fruit and curled peel on the stone shelf
p_citrus_pulp = pile{{"chrome yellow", 4}, {"yellow ochre", 2}, {"lead white", 3.5}, medium=0.15}
p_citrus_pith = pile{{"lead white", 6}, {"yellow ochre", 2}, {"raw umber", 0.5}, medium=0.1}
p_citrus_peel = pile{{"chrome yellow", 5}, {"vermilion", 0.8}, {"yellow ochre", 2}, {"lead white", 1.5}, medium=0.1}
p_peel_shadow = pile{{"raw umber", 4}, {"bone black", 2}, {"red earth", 1}, medium=0.2}

-- Halved lemon body at (525, 630)
pts_lemon = {
  {505, 630}, {515, 618}, {535, 615}, {550, 622}, {555, 635},
  {545, 646}, {525, 648}, {508, 640}
}
m_lemon = poly(pts_lemon, true)
work(m_lemon, {hand="body", pile=p_citrus_pulp, angle=0.0, coverage=1.5, fill=true, clip=true})

-- Lemon rind rim
m_lemon_rim = m_lemon:rim(3, 1)
work(m_lemon_rim, {hand="detail", pile=p_citrus_pith, angle=0.0, coverage=1.3, fill=true, clip=true})

-- Cast shadow of lemon on shelf top
m_lemon_sh = ellipse(545, 645, 20, 8) * mask(function(x, y) return y <= 642 and 1 or 0 end)
work(m_lemon_sh, {hand="detail", pile=p_shadow, angle=0.1, coverage=1.5, fill=true, clip=true})

-- Peeling ribbon curving over the shelf edge
-- Cast shadow of the trailing peel down the front apron
b_round:reload(p_peel_shadow, 0.8)
b_round:stroke({
  {552, 644}, {556, 658}, {554, 678}, {558, 698}
}, {pressure={0.5, 0.6, 0.5, 0.3}})

-- Outside of peel (rich chrome-vermilion yellow)
b_filbert:load(p_citrus_peel, 0.9)
b_filbert:stroke({
  {538, 624}, {554, 632}, {556, 646}, {544, 665}, {546, 688}, {552, 706}
}, {pressure={0.4, 0.7, 0.8, 0.7, 0.6, 0.4}})

-- Inside of peel (white pith highlight catching upper light)
b_round:reload(p_citrus_pith, 0.8)
b_round:stroke({
  {539, 625}, {551, 631}, {552, 644}, {542, 663}
}, {pressure={0.3, 0.5, 0.5, 0.2}})
