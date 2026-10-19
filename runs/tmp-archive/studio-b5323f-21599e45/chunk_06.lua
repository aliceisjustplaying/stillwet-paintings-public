-- 1. Unify the background wall
p_bg_unify = pile{{"bone black", 4.5}, {"raw umber", 4}, {"red earth", 1.2}, medium=0.35}
m_bg_unify = mask(function(x, y)
  if y > 522 or x < 220 then return 0 end
  return math.min(1, (x - 220) / 250)
end) - m_objects

work(m_bg_unify, {hand="glaze", pile=p_bg_unify, angle=0.1, coverage=1.2})
blend(m_wall, {angle=0.1, coverage=1.4})

-- 2. Repair and model the jug shoulder / handle shadow
-- Paint over the rectangular patch on the neck/shoulder
m_jug_shoulder_fix = m_jug * mask(function(x, y)
  if x < 280 or x > 360 or y < 330 or y > 490 then return 0 end
  return 1
end)
work(m_jug_shoulder_fix, {hand="body", pile=p_glaze_amber, angle=1.35, coverage=1.6, fill=true, clip=true})
work(m_jug_shoulder_fix * mask(function(x, y) return y > 400 and 1 or 0 end),
  {hand="body", pile=p_jug_lit, angle=1.35, coverage=1.4, fill=true, clip=true})

-- Soft blend across the jug shoulder into the belly
blend(m_jug * mask(function(x, y) return (y >= 300 and y <= 500 and x >= 270 and x <= 420) and 1 or 0 end),
  {angle=0.2, coverage=1.3, clip=true})

-- Cast shadow under the arch of the handle (curved, following the handle anatomy)
b_round = brush{kind="round", width=3.5, point=1, stiffness=0.5}
b_round:load(p_jug_shadow, 0.8)
b_round:stroke({
  {340, 345}, {310, 360}, {285, 395}, {290, 440}, {305, 470}
}, {pressure={0.3, 0.6, 0.7, 0.6, 0.2}, clip=m_jug})

-- 3. Repair and model the quince
-- Re-model the whole quince shadow and reflected light naturally
m_quince_shadow_smooth = m_quince * mask(function(x, y)
  local dx = (x - 660) / 60
  local dy = (y - 600) / 55
  local val = 0.7 * dx + 0.7 * dy
  if val < -0.1 then return 0 end
  return math.min(1, (val + 0.1) / 0.5)
end)
work(m_quince_shadow_smooth, {hand="body", pile=p_quince_shadow, angle=0.8, coverage=1.5, fill=true, clip=true})

-- Reflected bounce light along the bottom-right curve
m_quince_bounce = m_quince * mask(function(x, y)
  local dx = (x - 675) / 45
  local dy = (y - 625) / 30
  local d = dx*dx + dy*dy
  if d > 1 or dx < 0 or dy < 0 then return 0 end
  return (1 - d)
end)
work(m_quince_bounce, {hand="body", pile=p_quince_warm_refl, angle=0.3, coverage=1.3, fill=true, clip=true})

-- Re-establish the calyx eye of the quince
b_round:reload(p_quince_calyx, 0.85)
b_round:touch(692, 618, {pressure=0.7, drag={1.5, 0.8}})
b_round:stroke({{689, 616}, {695, 620}}, {pressure={0.4, 0.2}})
b_round:stroke({{693, 614}, {692, 622}}, {pressure={0.4, 0.2}})

-- Blend quince shadow area softly
blend(m_quince * mask(function(x, y) return (x > 630 or y > 590) and 1 or 0 end),
  {angle=0.3, coverage=1.2, clip=true})

-- 4. Modulate the stone shelf and cast shadow edges
-- Soften the jug cast shadow edge
blend(m_jug_shadow:rim(6, 2), {angle=0.1, coverage=1.2})
blend(m_quince_shadow:rim(6, 2), {angle=0.1, coverage=1.2})

-- Ledge front edge definition (a subtle crisp highlight along the front lip where light catches)
p_ledge_highlight = pile{{"lead white", 5}, {"yellow ochre", 3}, {"raw umber", 1}, medium=0.08}
b_filbert = brush("filbert", 4)
b_filbert:load(p_ledge_highlight, 0.8)
b_filbert:stroke({
  {0, 638}, {250, 638}, {500, 638}, {750, 638}, {1000, 638}
}, {pressure={0.2, 0.5, 0.6, 0.4, 0.2}, clip=mask(function(x, y) return (x > 530 and x < 560) and 0 or 1 end)})
