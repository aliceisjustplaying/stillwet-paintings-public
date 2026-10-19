-- 1. HANDLE HOLE & NEGATIVE SPACE
-- Background wall tone at x~300, y~400 is warm ochre-umber
p_bg_handle = pile{{"raw umber", 4}, {"yellow ochre", 3}, {"bone black", 1.8}, {"red earth", 1.2}, medium=0.15}
pts_handle_inner = {
  {334, 352}, {295, 360}, {270, 390}, {266, 420}, {274, 452},
  {286, 465}, {298, 440}, {312, 400}, {326, 370}
}
m_handle_inner = poly(pts_handle_inner, true)
work(m_handle_inner, {hand="body", pile=p_bg_handle, angle=0.4, coverage=1.8, fill=true, clip=true})

-- Re-establish the handle arch
pts_handle_spine = {
  {338, 332}, {280, 345}, {246, 395}, {249, 440}, {272, 475}
}
b_filbert = brush("filbert", 6)
b_round = brush{kind="round", width=3, point=1, stiffness=0.6}
b_fine = brush{kind="round", width=1.8, point=1, stiffness=0.7}

-- Body of the handle
b_filbert:load(p_jug_body, 0.85)
b_filbert:stroke(pts_handle_spine, {pressure={0.4, 0.7, 0.8, 0.7, 0.4}, clip=m_handle})

-- Handle shadow along the inner curve
b_round:load(p_jug_shadow, 0.8)
b_round:stroke({
  {328, 354}, {290, 362}, {268, 395}, {270, 435}, {280, 460}
}, {pressure={0.3, 0.6, 0.7, 0.6, 0.3}, clip=m_handle})

-- Highlight along handle outer edge
b_fine:load(p_jug_light, 0.85)
b_fine:stroke({
  {336, 334}, {276, 346}, {244, 395}, {247, 435}, {268, 472}
}, {pressure={0.3, 0.6, 0.8, 0.6, 0.3}, clip=m_handle})

-- 2. COMPLETE UNIFICATION OF QUINCE LOWER SHADOW
p_quince_lower_opaque = pile{{"yellow ochre", 4}, {"raw umber", 4}, {"green earth", 2}, {"lead white", 1.2}, {"bone black", 0.6}, medium=0.08}
m_quince_lower = m_quince * mask(function(x, y)
  return math.max(0, math.min(1, (y - 565) / 35))
end)
work(m_quince_lower, {hand="body", pile=p_quince_lower_opaque, angle=0.8, coverage=1.8, fill=true, clip=true})

-- Soft blend across the whole quince to merge light dome and shadow
blend(m_quince, {angle=0.25, coverage=1.1, clip=true})

-- Subtle reflected light along bottom right curve
b_round:load(p_quince_warm_refl, 0.7)
b_round:stroke({
  {660, 646}, {690, 642}, {714, 626}
}, {pressure={0.2, 0.6, 0.4}, clip=m_quince})

-- Crisp calyx star
b_fine:load(p_quince_calyx, 0.9)
b_fine:touch(692, 618, {pressure=0.8, drag={1, 1}})
b_fine:stroke({{688, 616}, {695, 620}}, {pressure={0.5, 0.3}})
b_fine:stroke({{692, 614}, {692, 622}}, {pressure={0.5, 0.3}})

-- 3. SPECULAR IMPASTO HIGHLIGHTS
-- Glazed shoulder specular highlight
p_specular = pile{{"lead white", 8.5}, {"yellow ochre", 1.2}, {"raw umber", 0.2}, medium=0.04}
b_round:load(p_specular, 0.9)
b_round:stroke({
  {334, 345}, {338, 358}, {342, 372}
}, {pressure={0.3, 0.85, 0.3}, clip=m_jug})

-- Flared lip highlight
b_fine:load(p_specular, 0.85)
b_fine:stroke({
  {330, 285}, {352, 289}, {378, 290}, {405, 289}
}, {pressure={0.3, 0.7, 0.75, 0.4}, clip=m_jug})

-- Quince impasto sun glint
b_round:reload(p_specular, 0.85)
b_round:touch(642, 565, {pressure=0.75, drag={1.5, 1}, clip=m_quince})

-- Lemon peel edge highlight catching direct light
b_fine:reload(p_specular, 0.8)
b_fine:stroke({
  {548, 630}, {556, 636}, {554, 648}
}, {pressure={0.3, 0.7, 0.4}})

-- 4. CONTACT SHADOWS (bedding objects firmly onto the stone surface)
p_contact = pile{{"bone black", 6}, {"raw umber", 4}, medium=0.08}
b_round:load(p_contact, 0.9)

-- Jug base contact shadow
b_round:stroke({
  {315, 622}, {350, 623}, {385, 624}, {415, 623}, {445, 622}
}, {pressure={0.4, 0.8, 0.9, 0.8, 0.4}})

-- Quince base contact shadow
b_round:stroke({
  {630, 648}, {655, 650}, {680, 650}
}, {pressure={0.3, 0.7, 0.4}})

-- Lemon contact shadow
b_fine:load(p_contact, 0.8)
b_fine:stroke({
  {515, 646}, {532, 647}, {546, 645}
}, {pressure={0.3, 0.6, 0.3}})
