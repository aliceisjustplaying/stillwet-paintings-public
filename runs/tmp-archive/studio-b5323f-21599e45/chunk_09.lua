-- Advance time so previous layers set firmly
local t = wait(120)
print("Time at start of refinement chunk: " .. tostring(t))

-- 1. RESTORE RADIANT GOLDEN LIGHT TO QUINCE
p_quince_gold = pile{{"chrome yellow", 5.5}, {"yellow ochre", 3}, {"lead white", 2.5}, {"vermilion", 0.4}, medium=0.06}
p_quince_mid = pile{{"yellow ochre", 4.5}, {"chrome yellow", 3}, {"raw umber", 1.5}, {"red earth", 0.8}, medium=0.1}
p_quince_impasto = pile{{"lead white", 8}, {"chrome yellow", 2.5}, {"yellow ochre", 0.8}, medium=0.04}
p_calyx = pile{{"raw umber", 5}, {"bone black", 3.5}, {"red earth", 1}, medium=0.08}

-- Golden upper dome (opaque, buttery body paint)
m_quince_top = m_quince * mask(function(x, y)
  return math.max(0, math.min(1, (620 - y) / 50))
end)
work(m_quince_top, {hand="body", pile=p_quince_gold, angle=-0.5, coverage=1.7, fill=true, clip=true})

-- Warm intermediate half-tone across the equator (y: 590 to 625)
m_quince_equator = m_quince * mask(function(x, y)
  if y < 585 or y > 630 then return 0 end
  return math.sin((y - 585) / 45 * math.pi)
end)
work(m_quince_equator, {hand="body", pile=p_quince_mid, angle=0.2, coverage=1.3, fill=true, clip=true})

-- Blend ONLY along the equator to merge dome into shadow without muddying the dome
blend(m_quince_equator, {angle=0.15, coverage=1.0, clip=true})

-- Crisp impasto sun highlight on upper-left curve of quince
b_round = brush{kind="round", width=3, point=1, stiffness=0.6}
b_fine = brush{kind="round", width=1.6, point=1, stiffness=0.7}

b_round:load(p_quince_impasto, 0.9)
b_round:touch(644, 566, {pressure=0.8, drag={1.5, 0.8}, clip=m_quince})
b_round:touch(652, 560, {pressure=0.6, drag={1.0, 0.5}, clip=m_quince})

-- Dried blossom calyx cluster (star at blossom eye)
b_fine:load(p_calyx, 0.9)
b_fine:touch(692, 618, {pressure=0.8})
b_fine:stroke({{692, 618}, {686, 615}}, {pressure={0.6, 0.2}})
b_fine:stroke({{692, 618}, {698, 615}}, {pressure={0.6, 0.2}})
b_fine:stroke({{692, 618}, {695, 624}}, {pressure={0.6, 0.2}})
b_fine:stroke({{692, 618}, {688, 623}}, {pressure={0.6, 0.2}})
b_fine:stroke({{692, 618}, {691, 612}}, {pressure={0.6, 0.2}})

-- 2. REFINE HANDLE AND JUG CONTOURS
-- Soften inner handle hole boundary with background
p_bg_warm_local = pile{{"raw umber", 4}, {"yellow ochre", 3}, {"bone black", 1.5}, medium=0.2}
m_handle_hole_blend = poly(pts_handle_inner, true):rim(4, 2)
blend(m_handle_hole_blend, {angle=0.3, coverage=1.2})

-- Clay joints where handle meets neck and shoulder
p_clay_body = pile{{"red earth", 4}, {"yellow ochre", 3.5}, {"raw umber", 2}, {"lead white", 1.8}, medium=0.1}
b_filbert = brush("filbert", 5)

-- Top joint (neck attachment)
b_filbert:load(p_clay_body, 0.8)
b_filbert:stroke({{325, 332}, {340, 334}, {345, 342}}, {pressure={0.4, 0.7, 0.4}, clip=m_jug})

-- Bottom joint (shoulder attachment)
b_filbert:stroke({{265, 465}, {276, 480}, {285, 485}}, {pressure={0.4, 0.7, 0.4}, clip=m_jug})

-- Handle crest catch light
b_fine:load(p_specular, 0.85)
b_fine:stroke({
  {334, 333}, {278, 346}, {246, 395}, {248, 435}, {268, 470}
}, {pressure={0.3, 0.7, 0.8, 0.6, 0.2}, clip=m_handle})

-- Jug mouth deep throat touch-up (cover any light rim line on inside back)
b_round:load(p_interior, 0.95)
b_round:stroke({{345, 278}, {380, 275}, {415, 278}}, {pressure={0.5, 0.8, 0.5}, clip=m_jug})

-- Front lip crisp rim highlight
b_fine:load(p_specular, 0.9)
b_fine:stroke({{330, 285}, {355, 289}, {380, 290}, {405, 289}}, {pressure={0.4, 0.8, 0.85, 0.5}, clip=m_jug})

-- Glazed shoulder specular highlight touch
b_round:load(p_specular, 0.9)
b_round:stroke({{335, 350}, {338, 360}, {341, 370}}, {pressure={0.4, 0.9, 0.4}, clip=m_jug})

-- 3. LEMON & STONE LEDGE REFINEMENTS
-- Juicy highlights on lemon pulp
p_lemon_glint = pile{{"lead white", 8.5}, {"chrome yellow", 1.2}, medium=0.04}
b_fine:load(p_lemon_glint, 0.85)
b_fine:touch(523, 627, {pressure=0.7})
b_fine:touch(535, 624, {pressure=0.6})
b_fine:touch(528, 638, {pressure=0.6})

-- Trailing peel: enhance the rich yellow zest
p_peel_zest = pile{{"chrome yellow", 5}, {"vermilion", 0.7}, {"lead white", 1.5}, medium=0.08}
b_fine:load(p_peel_zest, 0.85)
b_fine:stroke({
  {540, 626}, {554, 634}, {556, 646}, {544, 665}, {547, 688}, {552, 706}
}, {pressure={0.4, 0.8, 0.85, 0.7, 0.6, 0.3}})

-- White pith highlight on inner curl of peel
b_fine:load(p_specular, 0.8)
b_fine:stroke({{552, 632}, {553, 644}, {543, 662}}, {pressure={0.3, 0.7, 0.3}})

-- Deep shadow line right under stone ledge overhang (y: 639 to 644)
p_lip_deep = pile{{"bone black", 5}, {"raw umber", 4}, medium=0.1}
b_filbert:load(p_lip_deep, 0.8)
b_filbert:stroke({
  {0, 641}, {250, 641}, {500, 641}, {750, 641}, {1000, 641}
}, {pressure={0.3, 0.7, 0.8, 0.7, 0.3}, clip=mask(function(x, y) return (x > 500 and x < 560) and 0 or 1 end)})
