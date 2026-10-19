-- Advance time so previous layers are set
local t = wait(120)
print("Canvas clock at chunk 10: " .. tostring(t))

-- 1. RADIANT SOLID QUINCE
p_quince_sun = pile{{"chrome yellow", 6.5}, {"lead white", 4.5}, {"yellow ochre", 2}, {"vermilion", 0.3}, medium=0.04}
p_quince_sh_solid = pile{{"yellow ochre", 4}, {"raw umber", 3.2}, {"green earth", 1.8}, {"lead white", 1.5}, medium=0.06}
p_quince_hi_pure = pile{{"lead white", 9}, {"chrome yellow", 2}, {"yellow ochre", 0.5}, medium=0.03}
p_calyx = pile{{"raw umber", 5}, {"bone black", 4}, {"red earth", 1}, medium=0.08}

-- Geometric split of quince into light and shade
m_quince_lit_clean = m_quince * mask(function(x, y)
  local dx = (x - 660) / 60
  local dy = (y - 600) / 55
  local val = -0.7 * dx - 0.7 * dy
  if val > 0.05 then return 1 end
  if val < -0.15 then return 0 end
  return (val + 0.15) / 0.2
end)
m_quince_dark_clean = m_quince - m_quince_lit_clean

-- Lay opaque body color
work(m_quince_dark_clean, {hand="body", pile=p_quince_sh_solid, angle=0.8, coverage=2.2, fill=true, clip=true})
work(m_quince_lit_clean, {hand="body", pile=p_quince_sun, angle=-0.6, coverage=2.5, fill=true, clip=true})

-- Blend narrowly along the terminator zone
m_quince_seam = m_quince * mask(function(x, y)
  local dx = (x - 660) / 60
  local dy = (y - 600) / 55
  local val = math.abs(-0.7 * dx - 0.7 * dy)
  if val > 0.2 then return 0 end
  return 1 - val / 0.2
end)
blend(m_quince_seam, {angle=0.2, coverage=0.8, clip=true})

-- Quince impasto crest highlight
b_round = brush{kind="round", width=3, point=1, stiffness=0.7}
b_fine = brush{kind="round", width=1.6, point=1, stiffness=0.7}

b_round:load(p_quince_hi_pure, 0.95)
b_round:touch(644, 564, {pressure=0.85, drag={1.5, 0.8}, clip=m_quince})

-- Delicate dried calyx star
b_fine:load(p_calyx, 0.95)
b_fine:touch(692, 618, {pressure=0.85})
b_fine:stroke({{692, 618}, {686, 615}}, {pressure={0.6, 0.2}})
b_fine:stroke({{692, 618}, {698, 615}}, {pressure={0.6, 0.2}})
b_fine:stroke({{692, 618}, {695, 624}}, {pressure={0.6, 0.2}})
b_fine:stroke({{692, 618}, {688, 623}}, {pressure={0.6, 0.2}})
b_fine:stroke({{692, 618}, {691, 612}}, {pressure={0.6, 0.2}})

-- 2. JUG FORM CREST & TACTILE CLAY HIGHLIGHT
p_belly_swell = pile{{"lead white", 5.5}, {"yellow ochre", 4}, {"red earth", 2.2}, {"raw umber", 0.4}, medium=0.06}
b_filbert = brush("filbert", 6)
b_filbert:load(p_belly_swell, 0.85)
b_filbert:stroke({
  {315, 450}, {326, 470}, {330, 490}
}, {pressure={0.3, 0.75, 0.4}, clip=m_jug})

-- 3. FINAL CONTACT SHADOWS & ANCHORING
p_bedding = pile{{"bone black", 6.5}, {"raw umber", 3.5}, medium=0.08}
b_round:load(p_bedding, 0.9)
b_round:stroke({{315, 622}, {380, 624}, {445, 622}}, {pressure={0.5, 0.85, 0.5}})
b_round:stroke({{632, 649}, {660, 651}, {685, 650}}, {pressure={0.4, 0.8, 0.4}})
