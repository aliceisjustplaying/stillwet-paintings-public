-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"red earth", 3.5}, {"yellow ochre", 4.0}, {"lead white", 2.5}}, texture=0.25, um=45}, {apply="knife", pile={{"lead white", 7.0}, {"yellow ochre", 2.0}, {"raw umber", 0.6}}, texture=0.2, um=35}, {apply="brush", pile={{"lead white", 14.0}, {"yellow ochre", 0.7}, {"raw umber", 0.25}, {"vermilion", 0.06}}, texture=0.35, um=30}}, linen={15, 13}, seed=1818, size=800}

--@ chunk 2
-- Scratch Trial 1: Compare sky gradations (thinner=0.35 vs medium=0.15) and dark rock underpaint (thinner=0.45 vs turps=0.45 vs tube body)
-- Left strip (x=100..350): Sky gradation with thinner=0.35, coverage=1.4
p_zen_thin = pile{{"smalt", 5.0}, {"Prussian blue", 0.35}, {"rose madder", 0.35}, {"lead white", 1.2}, thinner=0.35, oil="walnut", name="zen_thin"}
p_mid_thin = pile{{"pale smalt", 5.0}, {"lead white", 7.0}, {"Naples yellow", 1.2}, thinner=0.35, oil="walnut", name="mid_thin"}
p_hor_thin = pile{{"lead white", 7.0}, {"Naples yellow", 4.0}, {"yellow ochre", 1.5}, {"vermilion", 0.45}, {"rose madder", 0.40}, thinner=0.35, oil="walnut", name="hor_thin"}

work(rect(100, 80, 220, 420), {
  hand = "broad",
  piles = {
    {p_zen_thin, function(x, y) return clamp(1 - (y - 80) / 180, 0, 1) end},
    {p_mid_thin, function(x, y) return clamp(1 - math.abs(y - 280) / 150, 0, 1) end},
    {p_hor_thin, function(x, y) return clamp((y - 260) / 200, 0, 1) end}
  },
  angle = 0,
  coverage = 1.4,
  load = 0.8,
  fill = true,
  clip = true
})

-- Middle strip (x=360..610): Sky gradation with medium=0.15 (no thinner), coverage=1.6, followed by 1 pass of blend and stipple transition
p_zen_med = pile{{"smalt", 5.0}, {"Prussian blue", 0.35}, {"rose madder", 0.35}, {"lead white", 1.5}, medium=0.15, oil="walnut", name="zen_med"}
p_up_med  = pile{{"smalt", 4.0}, {"pale smalt", 3.5}, {"lead white", 4.0}, {"rose madder", 0.25}, medium=0.15, oil="walnut", name="up_med"}
p_mid_med = pile{{"pale smalt", 4.5}, {"lead white", 7.5}, {"Naples yellow", 1.4}, medium=0.15, oil="walnut", name="mid_med"}
p_hor_med = pile{{"lead white", 7.0}, {"Naples yellow", 4.5}, {"yellow ochre", 1.5}, {"vermilion", 0.45}, {"rose madder", 0.40}, medium=0.15, oil="walnut", name="hor_med"}

work(rect(360, 80, 220, 420), {
  hand = "broad",
  piles = {
    {p_zen_med, function(x, y) return clamp(1 - (y - 80) / 140, 0, 1) end},
    {p_up_med,  function(x, y) return clamp(1 - math.abs(y - 210) / 120, 0, 1) end},
    {p_mid_med, function(x, y) return clamp(1 - math.abs(y - 330) / 120, 0, 1) end},
    {p_hor_med, function(x, y) return clamp((y - 320) / 160, 0, 1) end}
  },
  angle = 0,
  coverage = 1.6,
  load = 0.85,
  fill = true,
  clip = true
})
blend(rect(365, 85, 210, 410), {angle = 0, coverage = 0.6})

-- Right strip (x=640..880): Compare dark rock/oak underpaint recipes
-- Patch A (y=100..210): thinner=0.45 (solvent-limited thin wash)
p_dark_thinner = pile{{"raw umber", 4.0}, {"bone black", 2.5}, {"Prussian blue", 0.6}, {"yellow ochre", 1.0}, thinner=0.45, name="dark_thinner"}
work(rect(640, 100, 200, 100), {hand="body", pile=p_dark_thinner, coverage=1.5, load=0.8, fill=true, clip=true})

-- Patch B (y=230..340): turps=0.45 (evaporates on application, fuller pigment deposit)
p_dark_turps = pile{{"raw umber", 4.0}, {"bone black", 2.5}, {"Prussian blue", 0.6}, {"yellow ochre", 1.0}, turps=0.45, name="dark_turps"}
work(rect(640, 230, 200, 100), {hand="body", pile=p_dark_turps, coverage=1.5, load=0.8, fill=true, clip=true})

-- Patch C (y=360..470): unthinned tube body with walnut oil
p_dark_body = pile{{"raw umber", 4.0}, {"bone black", 2.5}, {"Prussian blue", 0.6}, {"yellow ochre", 1.0}, oil="walnut", name="dark_body"}
work(rect(640, 360, 200, 100), {hand="body", pile=p_dark_body, coverage=1.5, load=0.85, fill=true, clip=true})

print("Scratch trial 1 laid")

--@ chunk 3
-- Scratch Trial 2: Compare brush-faceted + light knife ridge (Patch B) vs heavy full-knife slab (Patch C) over dry dark rock underpaint
wait(3 * 24 * 60)
print("Scratch Patch B drying=" .. drying(700, 280) .. ", Patch C drying=" .. drying(700, 410))

p_rock_slate_lit = pile{{"smalt", 3.5}, {"pale smalt", 3.0}, {"raw umber", 2.2}, {"yellow ochre", 1.2}, {"lead white", 4.2}, blot=0.20, oil="walnut", name="rock_slate_lit"}
p_rock_slate_mid = pile{{"smalt", 4.0}, {"raw umber", 3.2}, {"bone black", 1.2}, {"yellow ochre", 1.0}, {"lead white", 2.0}, medium=0.10, oil="walnut", name="rock_slate_mid"}
p_rock_rust      = pile{{"red earth", 3.0}, {"yellow ochre", 2.5}, {"raw umber", 3.0}, {"bone black", 0.8}, medium=0.15, oil="walnut", name="rock_rust"}
p_rock_moss      = pile{{"yellow ochre", 3.5}, {"Prussian blue", 0.55}, {"raw umber", 2.5}, {"Naples yellow", 1.5}, {"green earth", 2.0}, blot=0.15, oil="walnut", name="rock_moss"}

-- Method 1 on Patch B (y=230..340): Constructive flat-brush facets + light knife graze on upper ledge
local m_fb_top = poly({{645, 245}, {715, 236}, {785, 244}, {830, 258}, {765, 272}, {680, 268}}, false):roughen(1.5, 18, 501)
local m_fb_mid = poly({{680, 268}, {765, 272}, {830, 258}, {835, 315}, {755, 325}, {695, 305}}, false):roughen(1.5, 18, 502)
local m_fb_rust = poly({{645, 245}, {680, 268}, {695, 305}, {650, 330}}, false):roughen(1.5, 18, 503)

work(m_fb_top, {hand="body", tool={kind="flat", width=8, point=0, stiffness=0.7}, pile=p_rock_slate_lit, angle=0.12, coverage=1.4, load=0.75, clip=m_fb_top})
work(m_fb_mid, {hand="body", tool={kind="flat", width=8, point=0, stiffness=0.7}, pile=p_rock_slate_mid, angle=1.15, coverage=1.3, load=0.75, clip=m_fb_mid})
work(m_fb_rust, {hand="body", tool={kind="flat", width=7, point=0, stiffness=0.6}, pile=p_rock_rust, angle=1.35, coverage=1.3, load=0.75, clip=m_fb_rust})

-- Light knife graze along the upper ridge of Patch B
k_rock = knife{width = 16}
k_rock:load(p_rock_slate_lit, 0.65)
k_rock:lay({{655, 248}, {720, 241}, {780, 248}}, {pressure={0.35, 0.22}, lift=0.15})

-- Moss stipple in crevice of Patch B
stipple(ellipse(740, 272, 28, 8):soften(3), {pile=p_rock_moss, width=2.4, coverage=0.85, pressure={0.3, 0.5}})

-- Method 2 on Patch C (y=360..470): Heavy high-pressure knife slab across the whole block
k_heavy = knife{width = 32}
k_heavy:load(p_rock_slate_lit, 0.95)
k_heavy:lay({{650, 395}, {740, 388}, {825, 402}}, {pressure={0.78, 0.72}})
k_heavy:load(p_rock_rust, 0.90)
k_heavy:lay({{655, 435}, {745, 430}, {825, 442}}, {pressure={0.75, 0.70}})

print("Scratch Trial 2 complete")

--@ chunk 4
-- Scratch Trial 3: Test oak limb tapering, moonlit bark rim, rigger twigs (medium=0.18 vs unthinned), and winter russet oak leaf stipple over the dry sky strip (x=360..580, y=100..350)
wait(5 * 24 * 60)
print("Scratch sky strip drying at (450, 200)=" .. drying(450, 200))

p_bark_dark = pile{{"raw umber", 4.5}, {"bone black", 3.0}, {"Prussian blue", 0.8}, {"red earth", 0.8}, oil="walnut", name="bark_dark"}
p_bark_warm = pile{{"raw umber", 4.0}, {"yellow ochre", 1.8}, {"red earth", 1.4}, {"bone black", 1.2}, oil="walnut", name="bark_warm"}
p_bark_moon = pile{{"lead white", 4.5}, {"Naples yellow", 1.8}, {"pale smalt", 2.0}, {"raw umber", 2.8}, blot=0.20, oil="walnut", name="bark_moon"}
p_twig_flow = pile{{"raw umber", 4.5}, {"bone black", 3.2}, {"Prussian blue", 0.7}, medium=0.18, oil="walnut", name="twig_flow"}
p_leaf_russet = pile{{"raw umber", 3.5}, {"red earth", 2.5}, {"yellow ochre", 2.2}, {"bone black", 1.2}, blot=0.15, oil="walnut", name="leaf_russet"}
p_leaf_rim    = pile{{"yellow ochre", 3.5}, {"Naples yellow", 2.0}, {"red earth", 1.2}, {"raw umber", 2.0}, {"lead white", 1.0}, blot=0.20, oil="walnut", name="leaf_rim"}

-- Test bough with collar swelling and sympodial forks
b_limb = brush{kind="round", width=7.5, point=0.92, stiffness=0.65}
b_limb:reload(p_bark_dark, 0.88)
b_limb:gesture({{450, 340, 0.90}, {445, 290, 0.72}, {425, 245, 0.55}, {395, 205, 0.35}, {375, 175, 0.16}})

-- Daughter fork obeying area conservation
b_limb:reload(p_bark_dark, 0.85)
b_limb:gesture({{425, 245, 0.45}, {455, 215, 0.32}, {485, 195, 0.20}, {515, 178, 0.08}})

-- Warm bark fissure modeling on core and moonlit silver-ochre rim on right edge
b_bark_det = brush{kind="round", width=2.5, point=0.90, stiffness=0.65}
b_bark_det:reload(p_bark_warm, 0.75)
b_bark_det:gesture({{448, 335, 0.50}, {443, 290, 0.42}, {424, 246, 0.30}})
b_bark_det:reload(p_bark_moon, 0.72)
b_bark_det:gesture({{453, 338, 0.38}, {448, 290, 0.32}, {428, 245, 0.25}, {457, 215, 0.20}, {487, 195, 0.14}})

-- Compare fine rigger twigs: top cluster with p_twig_flow (medium=0.18, reloaded every 2 strokes) vs lower cluster with unthinned p_bark_dark
b_rig = brush{kind="rigger", width=1.8, point=0.98, stiffness=0.55}
b_rig:reload(p_twig_flow, 0.85)
b_rig:gesture({{395, 205, 0.35}, {382, 182, 0.22}, {372, 162, 0.12}, {366, 148, 0.04}})
b_rig:gesture({{382, 182, 0.20}, {396, 164, 0.12}, {404, 150, 0.04}})
b_rig:reload(p_twig_flow, 0.85)
b_rig:gesture({{515, 178, 0.28}, {532, 166, 0.18}, {548, 158, 0.08}, {558, 150, 0.03}})
b_rig:gesture({{532, 166, 0.18}, {538, 152, 0.10}, {546, 140, 0.03}})

-- Sparse winter russet oak leaf cluster around the lower-right twig tip
local m_leaf_test = ellipse(542, 162, 22, 11):roughen(4, 14, 701):soften(3)
stipple(m_leaf_test, {pile=p_leaf_russet, width=1.9, coverage=0.80, pressure={0.25, 0.45}, feather=0.5})
stipple(ellipse(548, 160, 14, 8):soften(3), {pile=p_leaf_rim, width=1.7, coverage=0.45, pressure={0.22, 0.38}, feather=0.5})

print("Scratch Trial 3 complete")
