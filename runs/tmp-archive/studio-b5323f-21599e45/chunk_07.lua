-- Advance clock by 3 hours so the underpainting reaches setting/tacky state
local t = wait(180)
print("Time after drying wait: " .. tostring(t))

-- Palette piles for unified modeling
p_jug_body = pile{{"red earth", 4.5}, {"yellow ochre", 3.5}, {"lead white", 2.2}, {"raw umber", 1}, medium=0.1}
p_jug_light = pile{{"lead white", 5}, {"yellow ochre", 4}, {"red earth", 2.2}, {"raw umber", 0.5}, medium=0.08}
p_jug_core = pile{{"raw umber", 5}, {"bone black", 2.5}, {"red earth", 2.5}, medium=0.12}
p_jug_bounce = pile{{"yellow ochre", 4}, {"red earth", 3.5}, {"raw umber", 1.8}, medium=0.14}
p_glaze_amber = pile{{"yellow ochre", 4}, {"red earth", 3.5}, {"raw umber", 2}, medium=0.18}
p_glaze_shade = pile{{"raw umber", 5}, {"bone black", 3}, {"red earth", 1.5}, medium=0.15}
p_specular = pile{{"lead white", 8}, {"yellow ochre", 1.5}, {"raw umber", 0.2}, medium=0.05}

-- 1. UNIFIED MODELING OF THE TERRACOTTA JUG
-- A. Lay base terracotta body tone over the entire jug belly and base
m_jug_belly_all = (m_jug - m_jug_mouth) * mask(function(x, y) return math.max(0, math.min(1, (y - 320) / 40)) end)
work(m_jug_belly_all, {hand="body", pile=p_jug_body, angle=1.4, coverage=1.6, fill=true, clip=true})

-- B. Core shadow on the right side of the belly (smooth continuous ramp)
m_jug_core_smooth = m_jug_belly_all * mask(function(x, y)
  return math.max(0, 1 - math.abs(x - 425) / 50)
end)
work(m_jug_core_smooth, {hand="body", pile=p_jug_core, angle=1.45, coverage=1.5, fill=true, clip=true})

-- C. Reflected warm light along the right contour
m_jug_bounce_smooth = m_jug_belly_all * mask(function(x, y)
  return math.max(0, math.min(1, (x - 425) / 50))
end)
work(m_jug_bounce_smooth, {hand="body", pile=p_jug_bounce, angle=1.45, coverage=1.4, fill=true, clip=true})

-- D. Lit flank on the left side of the belly
m_jug_lit_smooth = m_jug_belly_all * mask(function(x, y)
  return math.max(0, math.min(1, (400 - x) / 70))
end)
work(m_jug_lit_smooth, {hand="body", pile=p_jug_light, angle=1.35, coverage=1.5, fill=true, clip=true})

-- E. Model the glazed upper neck and shoulder
m_jug_neck_smooth = (m_jug - m_jug_mouth) * mask(function(x, y)
  return math.max(0, math.min(1, (410 - y) / 60))
end)
work(m_jug_neck_smooth, {hand="body", pile=p_glaze_amber, angle=1.35, coverage=1.5, fill=true, clip=true})

-- Shadow on right of neck glaze
m_jug_neck_sh = m_jug_neck_smooth * mask(function(x, y)
  return math.max(0, math.min(1, (x - 375) / 45))
end)
work(m_jug_neck_sh, {hand="body", pile=p_glaze_shade, angle=1.45, coverage=1.4, fill=true, clip=true})

-- F. Soft blend across the whole jug body to fuse all modeling into smooth ceramic relief
blend(m_jug - m_jug_mouth, {angle=0.15, coverage=1.2, clip=true})

-- G. Rim and mouth depth
b_round = brush{kind="round", width=3, point=1, stiffness=0.5}
b_fine = brush{kind="round", width=1.8, point=1, stiffness=0.6}

-- Deep mouth interior
b_round:load(p_interior, 0.9)
b_round:stroke({
  {335, 281}, {380, 277}, {425, 281}
}, {pressure={0.4, 0.7, 0.4}, clip=m_jug})

-- Flared lip highlight
b_round:reload(p_specular, 0.8)
b_round:stroke({
  {324, 284}, {348, 289}, {380, 290}, {408, 289}, {432, 284}
}, {pressure={0.4, 0.7, 0.75, 0.5, 0.2}, clip=m_jug})

-- Glaze specular highlight on shoulder curve
b_round:reload(p_specular, 0.85)
b_round:stroke({
  {332, 345}, {337, 360}, {342, 375}
}, {pressure={0.3, 0.8, 0.3}, clip=m_jug})

-- Belly specular touch
b_round:touch(320, 465, {pressure=0.7, drag={2, 4}, clip=m_jug})

-- H. Handle refinement: unify the handle, soft shadow behind it
work(m_handle, {hand="body", pile=p_jug_body, angle=1.2, coverage=1.4, fill=true, clip=true})
b_round:reload(p_jug_shadow, 0.8)
b_round:stroke({
  {342, 345}, {305, 365}, {280, 400}, {285, 445}, {300, 475}
}, {pressure={0.2, 0.5, 0.6, 0.5, 0.2}, clip=m_jug})

b_fine:load(p_jug_light, 0.8)
b_fine:stroke({
  {338, 332}, {278, 345}, {245, 395}, {248, 440}, {270, 475}
}, {pressure={0.3, 0.6, 0.7, 0.5, 0.3}, clip=m_handle})

-- 2. REPAIR AND REFINE QUINCE
p_quince_sh_opaque = pile{{"yellow ochre", 4}, {"raw umber", 3.5}, {"green earth", 2}, {"bone black", 0.8}, medium=0.1}
m_quince_lower_sh = m_quince * mask(function(x, y)
  local dx = (x - 660) / 60
  local dy = (y - 600) / 55
  local val = 0.6 * dx + 0.8 * dy
  if val < 0.1 then return 0 end
  return math.min(1, (val - 0.1) / 0.4)
end)
work(m_quince_lower_sh, {hand="body", pile=p_quince_sh_opaque, angle=0.8, coverage=1.6, fill=true, clip=true})

-- Quince bounce light
work(m_quince_bounce, {hand="body", pile=p_quince_warm_refl, angle=0.3, coverage=1.4, fill=true, clip=true})
blend(m_quince * mask(function(x, y) return y > 585 and 1 or 0 end), {angle=0.2, coverage=1.1, clip=true})

-- Crisp calyx star
b_fine:load(p_quince_calyx, 0.9)
b_fine:touch(692, 618, {pressure=0.8, drag={1, 1}})
b_fine:stroke({{688, 616}, {695, 620}}, {pressure={0.5, 0.3}})
b_fine:stroke({{692, 614}, {692, 622}}, {pressure={0.5, 0.3}})

-- 3. REPAIR LEMON SLICE
work(m_lemon, {hand="body", pile=p_citrus_pulp, angle=0.0, coverage=1.6, fill=true, clip=true})
work(m_lemon_rim, {hand="detail", pile=p_citrus_pith, angle=0.0, coverage=1.5, fill=true, clip=true})

-- Radial segment lines of lemon pulp
p_segment_line = pile{{"lead white", 6}, {"yellow ochre", 3}, medium=0.08}
b_fine:load(p_segment_line, 0.7)
b_fine:stroke({{527, 631}, {512, 625}}, {pressure={0.4, 0.2}, clip=m_lemon})
b_fine:stroke({{527, 631}, {524, 618}}, {pressure={0.4, 0.2}, clip=m_lemon})
b_fine:stroke({{527, 631}, {540, 621}}, {pressure={0.4, 0.2}, clip=m_lemon})
b_fine:stroke({{527, 631}, {548, 634}}, {pressure={0.4, 0.2}, clip=m_lemon})
b_fine:stroke({{527, 631}, {538, 644}}, {pressure={0.4, 0.2}, clip=m_lemon})
b_fine:stroke({{527, 631}, {518, 643}}, {pressure={0.4, 0.2}, clip=m_lemon})

-- Juicy pulp glistening highlight
p_pulp_glint = pile{{"lead white", 8}, {"chrome yellow", 1.5}, medium=0.05}
b_fine:reload(p_pulp_glint, 0.8)
b_fine:touch(522, 626, {pressure=0.6})
b_fine:touch(534, 624, {pressure=0.5})
b_fine:touch(525, 638, {pressure=0.5})
