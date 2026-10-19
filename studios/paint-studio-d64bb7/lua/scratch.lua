-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{aspect=1.38, ground={{apply="knife", pile={{"red earth", 4}, {"yellow ochre", 3}, {"lead white", 2}, oil="walnut"}, texture=0.25, um=35}, {apply="knife", pile={{"lead white", 6}, {"yellow ochre", 1.8}, {"raw umber", 0.6}, {"red earth", 0.3}, oil="walnut"}, texture=0.15, um=25}, {apply="brush", pile={{"lead white", 12}, {"yellow ochre", 0.5}, {"raw umber", 0.2}, {"vermilion", 0.05}, oil="walnut"}, um=20}}, linen={14, 13}, seed=42, size=620}

--@ chunk 2
-- Scratch trial 1: Testing sky, cloud, water, and foreground lay-in recipes and handling on the identical 3-layer ground
-- First draw a sample of the HB/2H horizon and trunk lines on the scratch canvas to test how thin layers let graphite shimmer through
p2h_s = pencil("2H")
phb_s = pencil("HB")
p2h_s:rule({100, 485}, {900, 485}, {pressure = 0.38})
phb_s:line({{485, 580}, {485, 360}}, {pressure = 0.6})
phb_s:line({{515, 580}, {515, 360}}, {pressure = 0.6})
fix()

-- Candidate sky piles (in walnut oil)
-- Test 1 (Failed candidate hypothesis): Prussian blue + bone black with high turps (0.65) for zenith
trial_zenith_prussian = pile{
  {"Prussian blue", 2.5}, {"bone black", 1.2}, {"lead white", 2.0},
  oil = "walnut", turps = 0.65, name = "trial_zenith_prussian"
}

-- Test 2 (Friedrich smalt-based recipes with thinner = 0.30)
sky_zenith = pile{
  {"smalt", 5.5}, {"cobalt blue", 2.2}, {"lead white", 2.2}, {"rose madder", 0.45}, {"raw umber", 0.3},
  oil = "walnut", thinner = 0.30, name = "sky_zenith"
}
sky_mid = pile{
  {"lead white", 5.5}, {"pale smalt", 4.0}, {"smalt", 1.6}, {"rose madder", 0.38}, {"yellow ochre", 0.22},
  oil = "walnut", thinner = 0.30, name = "sky_mid"
}
sky_rose = pile{
  {"lead white", 7.0}, {"Naples yellow", 1.8}, {"rose madder", 0.55}, {"vermilion", 0.14}, {"pale smalt", 0.9},
  oil = "walnut", thinner = 0.28, name = "sky_rose"
}
sky_horizon = pile{
  {"lead white", 8.5}, {"Naples yellow", 3.8}, {"yellow ochre", 1.1}, {"vermilion", 0.16},
  oil = "walnut", thinner = 0.25, name = "sky_horizon"
}
cloud_violet = pile{
  {"lead white", 3.2}, {"smalt", 3.5}, {"rose madder", 0.65}, {"raw umber", 0.85}, {"yellow ochre", 0.3},
  oil = "walnut", thinner = 0.32, name = "cloud_violet"
}

-- Water candidate piles (more transparent, slightly darker/cooler at horizon and foreground, warm echo in middle)
water_horizon = pile{
  {"smalt", 3.8}, {"pale smalt", 2.5}, {"lead white", 2.6}, {"raw umber", 0.9}, {"rose madder", 0.35},
  oil = "walnut", medium = 0.25, thinner = 0.25, name = "water_horizon"
}
water_echo = pile{
  {"lead white", 5.0}, {"Naples yellow", 2.2}, {"yellow ochre", 1.0}, {"rose madder", 0.45}, {"pale smalt", 1.4}, {"raw umber", 0.45},
  oil = "walnut", medium = 0.25, thinner = 0.25, name = "water_echo"
}
water_near = pile{
  {"smalt", 4.2}, {"raw umber", 2.2}, {"lead white", 1.6}, {"bone black", 0.45}, {"yellow ochre", 0.5},
  oil = "walnut", medium = 0.25, thinner = 0.25, name = "water_near"
}

-- Foreground dark underpainting pile
fg_under = pile{
  {"raw umber", 4.5}, {"bone black", 2.0}, {"yellow ochre", 1.5}, {"red earth", 0.8},
  oil = "walnut", turps = 0.45, name = "fg_under"
}

-- Lay Trial Patch A (x = 120..360, y = 80..485): Prussian blue + high turps zenith vs smalt
work(rect(120, 80, 240, 160), {
  hand = "broad", tool = "filbert 18", pile = trial_zenith_prussian,
  angle = 0, coverage = 1.2, load = 0.75, clip = true
})

-- Lay Trial Patch B (x = 380..720, y = 80..485): Graded smalt-to-Naples-yellow sky with weighted piles + 1 gentle blend pass + stipple
local m_sky_trial = rect(380, 80, 340, 405)
work(m_sky_trial, {
  hand = "broad", tool = "filbert 20",
  piles = {
    {sky_zenith, function(x, y) return clamp(1 - (y - 80) / 140, 0, 1) end},
    {sky_mid, function(x, y) return clamp(1 - math.abs(y - 230) / 100, 0, 1) end},
    {sky_rose, function(x, y) return clamp(1 - math.abs(y - 350) / 90, 0, 1) end},
    {sky_horizon, function(x, y) return clamp((y - 360) / 110, 0, 1) end}
  },
  angle = 0, coverage = 1.6, fill = true, load = 0.82, clip = true
})
blend(m_sky_trial, {angle = 0})
-- Stipple transition zone (y = 260..420) on right half of Patch B (x = 550..720) to compare blended-only vs blended+stippled
stipple(rect(550, 260, 170, 160), {
  pile = sky_rose, width = 2.5, coverage = 0.65, pressure = {0.25, 0.45}, feather = 0.5, clip = true
})

-- Lay Trial Patch C (x = 380..720, y = 485..605): Calm water with horizon darkening, middle sky echo, and near darkening
local m_water_trial = rect(380, 485, 340, 120)
work(m_water_trial, {
  hand = "body", tool = "filbert 14",
  piles = {
    {water_horizon, function(x, y) return clamp(1 - (y - 485) / 38, 0, 1) end},
    {water_echo, function(x, y) return clamp(1 - math.abs(y - 535) / 38, 0, 1) end},
    {water_near, function(x, y) return clamp((y - 545) / 55, 0, 1) end}
  },
  angle = 0, coverage = 1.5, fill = true, load = 0.78, clip = true
})
blend(m_water_trial, {angle = 0})

-- Lay Trial Patch D (x = 380..720, y = 605..690): Foreground lean underpainting
work(rect(380, 605, 340, 85), {
  hand = "body", tool = "filbert 12", pile = fg_under,
  angle = 0.08, coverage = 1.4, fill = true, load = 0.8, clip = true
})

print("drying at sky:", drying(500, 300), "water:", drying(500, 535), "fg:", drying(500, 640))

--@ chunk 3
-- Scratch trial 1b: Testing cloud arch and veiled crescent moon in Patch B left half (x = 380..550, y = 110..260)
print("Patch B drying:", drying(460, 180))

moon_pale = pile{
  {"lead white", 9.0}, {"Naples yellow", 3.2}, {"yellow ochre", 0.4},
  oil = "walnut", thinner = 0.20, name = "moon_pale"
}

-- Cloud band mask arching upward in Patch B left half
local m_cloud_s = poly({{385, 235}, {430, 205}, {495, 192}, {545, 208}, {545, 242}, {490, 224}, {430, 238}, {385, 260}}, true):soften(14)
work(m_cloud_s, {
  hand = "body", tool = "filbert 12", pile = cloud_violet,
  angle = -0.12, coverage = 1.0, load = 0.65, clip = rect(380, 80, 170, 405)
})

-- Veiled crescent moon at (475, 148) using a fine pointed round 2.5 gesture, then a light blend pass over both
b_moon_s = brush{kind = "round", width = 2.5, point = 0.9, stiffness = 0.4}
b_moon_s:load(moon_pale, 0.65)
b_moon_s:gesture({{470, 136, 0.1}, {479, 144, 0.55}, {481, 154, 0.6}, {475, 163, 0.45}, {466, 166, 0.08}})

-- Gentle horizontal blend over the cloud and moon zone so they sit in the air rather than sticking out as hard objects
blend(rect(385, 120, 160, 155), {angle = 0})

--@ chunk 4
-- Scratch trial 2: Wait 12 days so Patch B, C, D are completely dry, then test Sitting 2 recipes & handling
wait(12 * 24 * 60)
print("Scratch drying sky:", drying(450, 200), "water:", drying(450, 540), "fg:", drying(450, 640))

-- 1. Crescent moon piles (over dry sky, no badger blender afterward)
moon_veil = pile{
  {"lead white", 5.0}, {"Naples yellow", 2.2}, {"pale smalt", 2.0}, {"rose madder", 0.3},
  oil = "walnut", medium = 0.35, thinner = 0.55, name = "moon_veil"
}
moon_limb = pile{
  {"lead white", 9.0}, {"Naples yellow", 3.5}, {"yellow ochre", 0.4},
  oil = "walnut", medium = 0.15, thinner = 0.15, name = "moon_limb"
}

-- Test moon at (425, 152) on clean dry upper sky of Patch B
b_halo = brush{kind = "round", width = 6.0, point = 0.6, stiffness = 0.3}
b_halo:load(moon_veil, 0.45)
b_halo:gesture({{421, 138, 0.15}, {429, 146, 0.35}, {431, 156, 0.35}, {425, 165, 0.25}, {417, 168, 0.12}})

b_crescent = brush{kind = "round", width = 2.0, point = 0.95, stiffness = 0.45}
b_crescent:load(moon_limb, 0.72)
b_crescent:gesture({{421, 138, 0.04}, {427, 143, 0.32}, {430, 151, 0.52}, {428, 160, 0.42}, {422, 166, 0.18}, {417, 168, 0.03}})

-- 2. Distant headland deep violet-umber and mist veil (at y = 466..485, x = 385..485)
headland_deep = pile{
  {"smalt", 4.5}, {"raw umber", 2.0}, {"rose madder", 0.85}, {"lead white", 2.2}, {"yellow ochre", 0.3},
  oil = "walnut", medium = 0.20, thinner = 0.22, name = "headland_deep"
}
mist_veil = pile{
  {"lead white", 6.5}, {"Naples yellow", 2.5}, {"pale smalt", 1.8}, {"rose madder", 0.45},
  oil = "walnut", medium = 0.25, thinner = 0.45, name = "mist_veil"
}

local m_hl_trial = poly({{385, 466}, {435, 471}, {475, 480}, {490, 485}, {490, 486}, {385, 486}}):soften(1.2)
work(m_hl_trial, {
  hand = "detail", tool = "filbert 5",
  piles = {
    {headland_deep, function(x, y) return clamp(1 - (x - 385) / 95, 0.15, 1) end},
    {mist_veil, function(x, y) return clamp((x - 420) / 70, 0, 0.85) end}
  },
  angle = 0, coverage = 1.5, fill = true, load = 0.75, edge = "soft", clip = rect(380, 455, 160, 31)
})

-- 3. Foreground shore overlap, boulder modeling, and dark earth planes (x = 385..560, y = 595..685)
shore_water_dark = pile{
  {"raw umber", 4.0}, {"smalt", 3.5}, {"bone black", 1.5}, {"yellow ochre", 0.4},
  oil = "walnut", medium = 0.25, thinner = 0.20, name = "shore_water_dark"
}
earth_dark = pile{
  {"raw umber", 5.0}, {"bone black", 2.8}, {"yellow ochre", 1.2}, {"Prussian blue", 0.35},
  oil = "walnut", medium = 0.15, name = "earth_dark"
}
boulder_dark = pile{
  {"raw umber", 4.5}, {"bone black", 2.5}, {"smalt", 1.5}, {"red earth", 0.6},
  oil = "walnut", medium = 0.15, name = "boulder_dark"
}
boulder_top_cool = pile{
  {"lead white", 2.0}, {"pale smalt", 2.8}, {"raw umber", 2.6}, {"yellow ochre", 1.2}, {"bone black", 0.7},
  oil = "walnut", medium = 0.15, name = "boulder_top_cool"
}

-- Overlap water-shore seam at y = 602..612
work(rect(385, 600, 175, 14):soften(2), {
  hand = "detail", tool = "filbert 6", pile = shore_water_dark,
  angle = 0, coverage = 1.4, load = 0.75
})
-- Boulder trial at (410..465, 595..630)
local m_boulder_s = poly({{410, 625}, {416, 600}, {440, 594}, {462, 602}, {466, 622}, {438, 628}})
work(m_boulder_s, {hand = "detail", tool = "filbert 5", pile = boulder_dark, angle = -0.3, coverage = 1.6, fill = true, clip = m_boulder_s})
local m_boulder_top_s = poly({{416, 600}, {440, 594}, {462, 602}, {445, 608}, {422, 607}}):soften(1)
work(m_boulder_top_s, {hand = "detail", tool = "round 3", pile = boulder_top_cool, angle = -0.2, coverage = 1.3, load = 0.65, clip = m_boulder_s})

-- 4. Oak trunk and branch trial over dry sky/water/fg (x = 490..540, y = 260..610)
oak_dark = pile{
  {"raw umber", 5.0}, {"bone black", 3.2}, {"red earth", 0.8}, {"Prussian blue", 0.3},
  oil = "walnut", medium = 0.12, name = "oak_dark"
}
oak_bark_warm = pile{
  {"raw umber", 4.0}, {"yellow ochre", 1.8}, {"red earth", 1.0}, {"lead white", 0.55}, {"bone black", 0.9},
  oil = "walnut", medium = 0.12, name = "oak_bark_warm"
}

local m_trunk_s = poly({{492, 605}, {496, 485}, {495, 370}, {515, 370}, {514, 485}, {518, 605}})
work(m_trunk_s, {hand = "detail", tool = "round 4", pile = oak_dark, angle = 1.57, coverage = 1.8, fill = true, load = 0.85, clip = m_trunk_s})
-- Subtle warm horizon glow on lower trunk bark ridges
b_bark = brush{kind = "round", width = 2.0, point = 0.85, stiffness = 0.55}
b_bark:load(oak_bark_warm, 0.55)
b_bark:gesture({{496, 510, 0.2}, {497, 470, 0.45}, {496, 430, 0.25}})
b_bark:gesture({{513, 505, 0.2}, {512, 465, 0.45}, {513, 425, 0.25}})

-- Branch and fine twigs with pointed round and rigger
b_limb_s = brush{kind = "round", width = 4.5, point = 0.92, stiffness = 0.5}
b_limb_s:load(oak_dark, 0.85)
b_limb_s:gesture({{512, 375, 0.85}, {528, 355, 0.65}, {546, 338, 0.50}, {562, 315, 0.35}, {574, 290, 0.18}, {582, 268, 0.04}})

b_twig_s = brush{kind = "rigger", width = 1.5, point = 0.96, stiffness = 0.45}
b_twig_s:load(oak_dark, 0.80)
b_twig_s:gesture({{546, 338, 0.55}, {558, 332, 0.35}, {570, 328, 0.20}, {578, 322, 0.05}})
b_twig_s:gesture({{562, 315, 0.45}, {556, 298, 0.28}, {550, 282, 0.12}, {547, 272, 0.04}})

--@ chunk 5
-- Scratch Trial 3: Wait 10 days on scratch canvas, then test the 3 repairs (twig extension over V-tip, planar flat-brush granite boulder, and blended lower water reflection)
wait(10 * 24 * 60)
print("Scratch drying:", drying(450, 595))

-- 1. Test reproducing the flawed V-tip bud cluster at (582, 268) on scratch, then extending fine 5th/6th-order twigs out of it
b_twig_s = brush{kind = "rigger", width = 1.0, point = 0.98, stiffness = 0.45}
b_twig_s:load(oak_dark, 0.75)
-- Reproduce a V-tip at (582, 268)
b_twig_s:gesture({{581, 270, 0.28}, {585, 265, 0.12}, {587, 263, 0.32}})
b_twig_s:gesture({{581, 270, 0.28}, {579, 264, 0.12}, {578, 262, 0.30}})

-- Now repair it by treating the V-tip as a parent fork collar and extending tapering hair-fine twigs (rigger 0.85, point = 0.99)
oak_twig_fine = pile{
  {"raw umber", 4.8}, {"bone black", 2.6}, {"smalt", 1.2}, {"red earth", 0.6},
  oil = "walnut", medium = 0.20, thinner = 0.22, name = "oak_twig_fine"
}
b_hair = brush{kind = "rigger", width = 0.85, point = 0.99, stiffness = 0.42}
b_hair:load(oak_dark, 0.80)
b_hair:gesture({{584, 266, 0.36}, {589, 259, 0.22}, {595, 253, 0.10}, {600, 248, 0.02}})
b_hair:load(oak_twig_fine, 0.75)
b_hair:gesture({{589, 259, 0.20}, {596, 261, 0.10}, {602, 260, 0.02}})
b_hair:gesture({{579, 265, 0.34}, {576, 256, 0.20}, {571, 248, 0.09}, {567, 242, 0.02}})
b_hair:gesture({{576, 256, 0.18}, {580, 249, 0.09}, {582, 243, 0.02}})

-- 2. Test planar flat-brush granite boulder over the chalky boulder at (410..466, 594..628)
granite_shadow = pile{
  {"raw umber", 4.8}, {"bone black", 3.2}, {"Prussian blue", 0.4}, {"red earth", 0.6},
  oil = "walnut", medium = 0.16, name = "granite_shadow"
}
granite_side = pile{
  {"raw umber", 4.5}, {"bone black", 2.0}, {"smalt", 1.8}, {"yellow ochre", 0.8}, {"lead white", 0.15},
  oil = "walnut", medium = 0.16, name = "granite_side"
}
granite_top = pile{
  {"raw umber", 3.8}, {"pale smalt", 2.5}, {"yellow ochre", 1.1}, {"bone black", 1.2}, {"lead white", 0.32},
  oil = "walnut", medium = 0.16, name = "granite_top"
}

local m_b_all = poly({{410, 625}, {416, 600}, {440, 594}, {462, 602}, {466, 622}, {438, 628}})
local m_b_side = poly({{410, 625}, {416, 600}, {440, 594}, {436, 612}, {426, 626}})
local m_b_top = poly({{416, 600}, {440, 594}, {462, 602}, {444, 605}, {422, 604}}):soften(0.8)

work(m_b_all, {hand = "detail", tool = {kind = "flat", width = 4, point = 0}, pile = granite_shadow, angle = 0.4, coverage = 1.6, fill = true, clip = m_b_all})
work(m_b_side, {hand = "detail", tool = {kind = "flat", width = 4, point = 0}, pile = granite_side, angle = -0.3, coverage = 1.4, fill = true, clip = m_b_all})
work(m_b_top, {hand = "detail", tool = {kind = "flat", width = 3.5, point = 0}, pile = granite_top, angle = -0.15, coverage = 1.3, load = 0.72, clip = m_b_all})

-- 3. Test unified horizontal blended water reflection at (380..560, 540..605)
local m_w_lower = rect(380, 540, 180, 65) - poly({{492, 605}, {496, 485}, {514, 485}, {518, 605}})
work(m_w_lower, {
  hand = "body", tool = "filbert 12",
  piles = {
    {water_echo, function(x, y) return clamp(1 - (y - 540) / 30, 0, 1) end},
    {water_near, function(x, y) return clamp((y - 542) / 45, 0, 1) end},
    {shore_water_dark, function(x, y)
      local shore_w = clamp((y - 582) / 22, 0, 1)
      local trunk_refl = clamp(1 - math.abs(x - 505) / 22, 0, 1) * clamp((y - 555) / 45, 0, 1)
      return clamp(shore_w + 0.85 * trunk_refl, 0, 1.2)
    end}
  },
  angle = 0, coverage = 1.5, fill = true, load = 0.78, clip = m_w_lower
})
blend(m_w_lower, {angle = 0})
