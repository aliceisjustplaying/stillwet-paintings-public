-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{
  size = 620,
  aspect = 1.38,
  linen = {14, 13},
  seed = 42,
  ground = {
    {
      pile = {{"red earth", 4}, {"yellow ochre", 3}, {"lead white", 2}, oil = "walnut"},
      um = 35,
      apply = "knife",
      texture = 0.25
    },
    {
      pile = {{"lead white", 6}, {"yellow ochre", 1.8}, {"raw umber", 0.6}, {"red earth", 0.3}, oil = "walnut"},
      um = 25,
      apply = "knife",
      texture = 0.15
    },
    {
      pile = {{"lead white", 12}, {"yellow ochre", 0.5}, {"raw umber", 0.2}, {"vermilion", 0.05}, oil = "walnut"},
      um = 20,
      apply = "brush"
    }
  }
}
print("W =", W, "H =", H)

--@ chunk 2
-- Underdrawing: graphite pencils (2H for ruled architectural lines and sky bands, HB for detailed forms)
p2h = pencil("2H")
phb = pencil("HB")

-- 1. Ruled architectural lines (Friedrich's T-square and ruler)
-- Horizon ruled dead level at y = 485 (sky is 67% of H)
p2h:rule({0, 485}, {1000, 485}, {pressure = 0.38})

-- Faint central vertical axis at x = 500 and geometric arch guides
p2h:rule({500, 60}, {500, 680}, {pressure = 0.18})
p2h:sketch({{340, 220}, {410, 340}, {500, 385}, {590, 340}, {660, 220}}, {pressure = 0.16, passes = 1})

-- Faint sky band divisions and cloud arch contour
p2h:sketch({{0, 415}, {300, 410}, {500, 406}, {700, 410}, {1000, 415}}, {pressure = 0.16, passes = 1})
p2h:sketch({{0, 310}, {250, 295}, {500, 285}, {750, 295}, {1000, 310}}, {pressure = 0.16, passes = 1})
p2h:sketch({{0, 240}, {220, 215}, {400, 192}, {500, 186}, {600, 192}, {780, 215}, {1000, 240}}, {pressure = 0.2, passes = 2})

-- Faint crescent moon high near the axis inside the upper arch of the oak
p2h:line({{512, 138}, {521, 145}, {523, 156}, {516, 165}, {507, 168}}, {pressure = 0.28})
p2h:line({{512, 138}, {517, 147}, {518, 156}, {513, 163}, {507, 168}}, {pressure = 0.22})

-- 2. Distant headlands on the horizon (framing the open central channel x = 375..625)
phb:line({{0, 464}, {95, 466}, {185, 469}, {265, 474}, {330, 480}, {378, 485}}, {pressure = 0.35})
phb:line({{622, 485}, {675, 480}, {745, 474}, {835, 469}, {920, 467}, {1000, 465}}, {pressure = 0.35})

-- 3. Foreground shore promontory contour (shallow dark zone parallel to picture plane, peaking at x = 500)
shore_pts = {
  {0, 614}, {85, 611}, {175, 606}, {260, 599}, {340, 592},
  {415, 584}, {465, 578}, {500, 575}, {535, 578}, {585, 584},
  {660, 593}, {745, 600}, {830, 607}, {915, 611}, {1000, 613}
}
phb:line(shore_pts, {pressure = 0.52})
phb:sketch({{0, 622}, {220, 614}, {420, 596}, {500, 588}, {580, 597}, {780, 615}, {1000, 621}}, {pressure = 0.3, passes = 2})

-- Waterline ripples parallel to horizon in calm bodden
p2h:rule({120, 604}, {310, 604}, {pressure = 0.22})
p2h:rule({680, 603}, {880, 603}, {pressure = 0.22})
p2h:rule({380, 545}, {620, 545}, {pressure = 0.18})

-- Glacial erratic boulders flanking the axis on the promontory
-- Left boulders
phb:line({{328, 616}, {336, 592}, {364, 583}, {395, 589}, {408, 612}, {372, 620}, {328, 616}}, {pressure = 0.5, smooth = false})
phb:line({{392, 618}, {404, 600}, {428, 597}, {442, 613}, {418, 622}, {392, 618}}, {pressure = 0.45, smooth = false})
-- Right boulders
phb:line({{572, 617}, {582, 596}, {612, 586}, {644, 594}, {654, 616}, {615, 623}, {572, 617}}, {pressure = 0.5, smooth = false})
phb:line({{640, 620}, {652, 605}, {680, 603}, {692, 617}, {665, 624}, {640, 620}}, {pressure = 0.42, smooth = false})

-- 4. Detailed underdrawing of the Ancient Winter Oak on the central axis (x = 500)
-- Trunk outlines with basal root flares and hollow fissure lines
phb:line({{464, 590}, {478, 572}, {483, 535}, {485, 485}, {486, 430}, {484, 385}, {476, 368}}, {pressure = 0.6})
phb:line({{536, 590}, {522, 571}, {517, 535}, {515, 485}, {514, 430}, {516, 385}, {524, 368}}, {pressure = 0.6})
-- Central bark fissures and hollow cavity near base
phb:line({{496, 584}, {498, 548}, {500, 520}, {503, 548}, {505, 584}}, {pressure = 0.48})
phb:sketch({{492, 495}, {494, 440}, {497, 390}}, {pressure = 0.35, passes = 2})
phb:sketch({{507, 505}, {506, 445}, {504, 392}}, {pressure = 0.35, passes = 2})

-- Left main overarching bough (with collar at trunk junction, crooked oak turns)
phb:line({{484, 382}, {458, 362}, {424, 344}, {392, 315}, {368, 278}, {358, 236}, {366, 196}, {384, 162}, {404, 138}}, {pressure = 0.55, smooth = false})
phb:line({{492, 368}, {466, 350}, {434, 334}, {402, 307}, {378, 272}, {367, 234}, {373, 197}, {389, 165}, {404, 138}}, {pressure = 0.5, smooth = false})

-- Right main overarching bough (forming the upper arch with the left bough, distinct crooked path)
phb:line({{516, 380}, {544, 358}, {578, 338}, {612, 308}, {634, 270}, {642, 228}, {632, 188}, {612, 156}, {592, 134}}, {pressure = 0.55, smooth = false})
phb:line({{508, 366}, {536, 346}, {568, 328}, {602, 300}, {624, 265}, {633, 226}, {625, 190}, {607, 159}, {592, 134}}, {pressure = 0.5, smooth = false})

-- Central retrenched stag-head spire (dead upper leader of ancient oak)
phb:line({{495, 372}, {493, 332}, {497, 296}, {494, 264}, {488, 244}}, {pressure = 0.5, smooth = false})
phb:line({{505, 372}, {502, 332}, {504, 296}, {500, 264}, {510, 248}}, {pressure = 0.5, smooth = false})

-- Secondary limbs spreading laterally (acrotonous & crooked sympodial forks)
-- Left lower-outer limb
phb:line({{428, 342}, {388, 348}, {348, 340}, {312, 322}, {284, 298}}, {pressure = 0.45, smooth = false})
-- Left middle-outer limb
phb:line({{372, 275}, {336, 262}, {304, 240}, {278, 212}}, {pressure = 0.42, smooth = false})
-- Left inner vault limb
phb:line({{374, 232}, {404, 212}, {432, 188}, {452, 168}}, {pressure = 0.4, smooth = false})
-- Right lower-outer limb
phb:line({{574, 336}, {616, 344}, {656, 334}, {692, 316}, {718, 292}}, {pressure = 0.45, smooth = false})
-- Right middle-outer limb
phb:line({{630, 268}, {666, 252}, {698, 228}, {722, 198}}, {pressure = 0.42, smooth = false})
-- Right inner vault limb
phb:line({{628, 224}, {598, 204}, {570, 182}, {550, 162}}, {pressure = 0.4, smooth = false})

-- Fix the underdrawing so it won't smear
fix()

--@ chunk 3
-- Campaign 1: Banded Twilight Sky, Distant Mist-Veiled Headlands, Calm Sea, and Foreground Underpainting

-- 1. Knife the piles on the main palette (all in walnut oil)
sky_zenith = pile{
  {"smalt", 5.5}, {"cobalt blue", 2.2}, {"lead white", 2.2}, {"rose madder", 0.45}, {"raw umber", 0.3},
  oil = "walnut", thinner = 0.28, name = "sky_zenith"
}
sky_mid = pile{
  {"lead white", 5.5}, {"pale smalt", 4.0}, {"smalt", 1.6}, {"rose madder", 0.38}, {"yellow ochre", 0.22},
  oil = "walnut", thinner = 0.28, name = "sky_mid"
}
sky_rose = pile{
  {"lead white", 7.0}, {"Naples yellow", 1.8}, {"rose madder", 0.55}, {"vermilion", 0.14}, {"pale smalt", 0.9},
  oil = "walnut", thinner = 0.26, name = "sky_rose"
}
sky_horizon = pile{
  {"lead white", 8.8}, {"Naples yellow", 4.0}, {"yellow ochre", 1.1}, {"vermilion", 0.16},
  oil = "walnut", thinner = 0.24, name = "sky_horizon"
}
cloud_violet = pile{
  {"lead white", 3.4}, {"smalt", 3.5}, {"pale smalt", 1.8}, {"rose madder", 0.65}, {"raw umber", 0.8}, {"yellow ochre", 0.3},
  oil = "walnut", thinner = 0.28, name = "cloud_violet"
}
headland_mist = pile{
  {"lead white", 4.2}, {"pale smalt", 3.2}, {"smalt", 1.8}, {"rose madder", 0.55}, {"raw umber", 0.75}, {"yellow ochre", 0.4},
  oil = "walnut", thinner = 0.28, name = "headland_mist"
}
water_horizon = pile{
  {"smalt", 3.8}, {"pale smalt", 2.5}, {"lead white", 2.6}, {"raw umber", 0.9}, {"rose madder", 0.35},
  oil = "walnut", medium = 0.25, thinner = 0.25, name = "water_horizon"
}
water_echo = pile{
  {"lead white", 5.2}, {"Naples yellow", 2.4}, {"yellow ochre", 1.0}, {"rose madder", 0.45}, {"pale smalt", 1.3}, {"raw umber", 0.4},
  oil = "walnut", medium = 0.25, thinner = 0.25, name = "water_echo"
}
water_near = pile{
  {"smalt", 4.2}, {"raw umber", 2.2}, {"lead white", 1.6}, {"bone black", 0.45}, {"yellow ochre", 0.5},
  oil = "walnut", medium = 0.25, thinner = 0.25, name = "water_near"
}
fg_under = pile{
  {"raw umber", 4.5}, {"bone black", 2.0}, {"yellow ochre", 1.5}, {"red earth", 0.8},
  oil = "walnut", turps = 0.45, name = "fg_under"
}

-- Save global masks for key zones so later campaigns can reference or protect them
m_sky = rect(0, 0, 1000, 486)

-- Cloud arch function (a gentle upward-opening arch across the twilight vault, asymmetric micro-drift via noise)
n_cloud = noise{seed = 17, octaves = 3, period = 220, stretch = {0, 3}}

work(m_sky, {
  hand = "broad",
  tool = "filbert 22",
  piles = {
    {sky_zenith, function(x, y)
      return clamp(1.05 - y / 195, 0, 1)
    end},
    {cloud_violet, function(x, y)
      local y_arch = 192 + 0.00022 * (x - 500) * (x - 500) + 10 * n_cloud(x, y)
      local w_band = clamp(1 - math.abs(y - y_arch) / 34, 0, 1)
      -- Thin out slightly right at the central axis so the arch opens around the moon and upper boughs
      local center_open = 1 - 0.35 * clamp(1 - math.abs(x - 500) / 110, 0, 1)
      return 0.78 * w_band * center_open
    end},
    {sky_mid, function(x, y)
      return clamp(1 - math.abs(y - 245) / 115, 0, 1)
    end},
    {sky_rose, function(x, y)
      return clamp(1 - math.abs(y - 365) / 95, 0, 1)
    end},
    {sky_horizon, function(x, y)
      local base = clamp((y - 375) / 105, 0, 1)
      local axis_glow = 1 + 0.22 * clamp(1 - math.abs(x - 500) / 320, 0, 1)
      return clamp(base * axis_glow, 0, 1.2)
    end}
  },
  angle = 0,
  coverage = 1.65,
  fill = true,
  load = 0.84,
  clip = m_sky
})

-- Single unified horizontal blend across the entire sky while open
blend(m_sky, {angle = 0})

-- 2. Distant mist-veiled headlands on left and right horizon (leaving open channel x = 378..622)
m_headland_left = poly({
  {0, 464}, {65, 465}, {135, 467}, {205, 470}, {275, 475}, {335, 480}, {378, 485},
  {378, 487}, {0, 487}
}):soften(1.5)

m_headland_right = poly({
  {622, 485}, {670, 480}, {735, 475}, {810, 470}, {885, 467}, {945, 465}, {1000, 464},
  {1000, 487}, {622, 487}
}):soften(1.5)

work(m_headland_left, {
  hand = "detail",
  tool = "filbert 6",
  piles = {
    {headland_mist, function(x, y) return clamp(1 - x / 420, 0.25, 1) end},
    {sky_rose, function(x, y) return clamp((x - 180) / 220, 0, 0.75) end}
  },
  angle = 0,
  coverage = 1.4,
  fill = true,
  load = 0.72,
  clip = m_headland_left
})

work(m_headland_right, {
  hand = "detail",
  tool = "filbert 6",
  piles = {
    {headland_mist, function(x, y) return clamp((x - 580) / 420, 0.25, 1) end},
    {sky_rose, function(x, y) return clamp((820 - x) / 220, 0, 0.75) end}
  },
  angle = 0,
  coverage = 1.4,
  fill = true,
  load = 0.72,
  clip = m_headland_right
})

-- 3. Calm Sea / Bodden (y = 485 down to foreground shore contour)
m_fg = poly({
  {0, 614}, {85, 611}, {175, 606}, {260, 599}, {340, 592},
  {415, 584}, {465, 578}, {500, 575}, {535, 578}, {585, 584},
  {660, 593}, {745, 600}, {830, 607}, {915, 611}, {1000, 613},
  {1000, 725}, {0, 725}
})
m_water = rect(0, 485, 1000, 135) - m_fg

work(m_water, {
  hand = "body",
  tool = "filbert 16",
  piles = {
    {water_horizon, function(x, y)
      local h_band = clamp(1 - (y - 485) / 34, 0, 1)
      -- Slightly deeper under the headlands, slightly more open on the central channel
      local side_shade = 0.75 + 0.35 * clamp(math.abs(x - 500) / 220, 0, 1)
      return h_band * side_shade
    end},
    {water_echo, function(x, y)
      local mid_band = clamp(1 - math.abs(y - 528) / 38, 0, 1)
      local center_channel = clamp(1 - (y - 485) / 28, 0, 1) * clamp(1 - math.abs(x - 500) / 180, 0, 1) * 0.65
      return clamp(mid_band + center_channel, 0, 1.1)
    end},
    {water_near, function(x, y)
      return clamp((y - 542) / 55, 0, 1)
    end}
  },
  angle = 0,
  coverage = 1.6,
  fill = true,
  load = 0.80,
  clip = m_water
})

-- Single horizontal blend pass across the calm water
blend(m_water, {angle = 0})

-- 4. Shallow Foreground Promontory Lean Underpainting
work(m_fg, {
  hand = "body",
  tool = "filbert 14",
  pile = fg_under,
  angle = 0.05,
  coverage = 1.5,
  fill = true,
  load = 0.82,
  clip = m_fg
})

print("Campaign 1 complete. Drying sky:", drying(500, 250), "water:", drying(500, 530), "fg:", drying(500, 650))

--@ chunk 4
print(wait(0))

--@ chunk 5
-- Let Campaign 1 dry completely before Sitting 2 overpainting
wait(8 * 24 * 60)
print("sky zenith:", drying(500, 100))
print("sky moon area:", drying(515, 152))
print("sky horizon:", drying(500, 460))
print("headland left:", drying(200, 475))
print("water mid:", drying(500, 530))
print("water shore seam:", drying(500, 576))
print("fg under:", drying(500, 650))

--@ chunk 6
wait(4 * 24 * 60)
print("fg under now:", drying(500, 650), "shore seam:", drying(400, 595))

--@ chunk 7
-- Campaign 2a: Veiled crescent moon, distant headlands, calm water reflections, and shoreline seam closure
moon_veil = pile{
  {"lead white", 5.0}, {"Naples yellow", 2.2}, {"pale smalt", 2.0}, {"rose madder", 0.3},
  oil = "walnut", medium = 0.35, thinner = 0.55, name = "moon_veil"
}
moon_limb = pile{
  {"lead white", 9.0}, {"Naples yellow", 3.5}, {"yellow ochre", 0.4},
  oil = "walnut", medium = 0.15, thinner = 0.15, name = "moon_limb"
}
headland_deep = pile{
  {"smalt", 4.5}, {"raw umber", 2.0}, {"rose madder", 0.85}, {"lead white", 2.2}, {"yellow ochre", 0.3},
  oil = "walnut", medium = 0.20, thinner = 0.22, name = "headland_deep"
}
headland_inner = pile{
  {"smalt", 3.5}, {"pale smalt", 2.5}, {"raw umber", 1.6}, {"rose madder", 0.75}, {"lead white", 1.8}, {"yellow ochre", 0.5},
  oil = "walnut", medium = 0.22, thinner = 0.38, name = "headland_inner"
}
shore_water_dark = pile{
  {"raw umber", 4.0}, {"smalt", 3.5}, {"bone black", 1.5}, {"yellow ochre", 0.4},
  oil = "walnut", medium = 0.25, thinner = 0.20, name = "shore_water_dark"
}
water_gleam = pile{
  {"lead white", 6.5}, {"Naples yellow", 3.2}, {"yellow ochre", 0.9}, {"rose madder", 0.25},
  oil = "walnut", medium = 0.25, thinner = 0.35, name = "water_gleam"
}

-- 1. Small partly veiled crescent moon at (515, 152) over dry sky
b_halo = brush{kind = "round", width = 5.5, point = 0.65, stiffness = 0.3}
b_halo:load(moon_veil, 0.32)
b_halo:gesture({{512, 138, 0.12}, {520, 145, 0.30}, {522, 155, 0.30}, {516, 164, 0.22}, {507, 168, 0.10}})

b_crescent = brush{kind = "round", width = 1.7, point = 0.96, stiffness = 0.45}
b_crescent:load(moon_limb, 0.72)
b_crescent:gesture({{512, 138, 0.04}, {518, 143, 0.34}, {522, 151, 0.52}, {520, 160, 0.40}, {514, 165, 0.18}, {507, 168, 0.03}})

-- 2. Distant headlands on left (x = 0..378) and right (x = 622..1000), strictly clipped above y = 485
local clip_above_horizon = rect(0, 455, 1000, 30.0)
work(m_headland_left, {
  hand = "detail", tool = "filbert 5",
  piles = {
    {headland_deep, function(x, y) return clamp(1 - x / 310, 0.1, 1) end},
    {headland_inner, function(x, y) return clamp((x - 160) / 210, 0, 1) end}
  },
  load_at = function(x, y) return clamp(0.80 - 0.58 * clamp((x - 240) / 138, 0, 1), 0.20, 0.80) end,
  angle = 0, coverage = 1.6, fill = true, clip = m_headland_left * clip_above_horizon
})

work(m_headland_right, {
  hand = "detail", tool = "filbert 5",
  piles = {
    {headland_deep, function(x, y) return clamp((x - 690) / 310, 0.1, 1) end},
    {headland_inner, function(x, y) return clamp((840 - x) / 210, 0, 1) end}
  },
  load_at = function(x, y) return clamp(0.80 - 0.58 * clamp((760 - x) / 138, 0, 1), 0.20, 0.80) end,
  angle = 0, coverage = 1.6, fill = true, clip = m_headland_right * clip_above_horizon
})

-- 3. Subtle cool reflection in water just below the two headlands (y = 485..498)
local m_refl_left = rect(0, 485, 365, 13):soften(3) * m_water
local m_refl_right = rect(635, 485, 365, 13):soften(3) * m_water
work(m_refl_left, {
  hand = "detail", tool = "filbert 6", pile = headland_inner,
  load_at = function(x, y) return 0.45 * clamp(1 - x / 365, 0.15, 1) end,
  angle = 0, coverage = 1.1, clip = m_water
})
work(m_refl_right, {
  hand = "detail", tool = "filbert 6", pile = headland_inner,
  load_at = function(x, y) return 0.45 * clamp((x - 635) / 365, 0.15, 1) end,
  angle = 0, coverage = 1.1, clip = m_water
})

-- Delicate horizontal glass-ripple gleams on the open central water channel (x = 385..615, y = 489..548)
b_ripple = brush{kind = "rigger", width = 1.3, point = 0.95, stiffness = 0.4}
b_ripple:load(water_gleam, 0.48)
b_ripple:gesture({{425, 490, 0.08}, {480, 490, 0.28}, {535, 490, 0.28}, {580, 490, 0.08}})
b_ripple:gesture({{398, 498, 0.06}, {465, 498, 0.24}, {525, 498, 0.22}, {595, 498, 0.06}})
b_ripple:load(water_gleam, 0.42)
b_ripple:gesture({{435, 512, 0.06}, {495, 512, 0.22}, {555, 512, 0.06}})
b_ripple:gesture({{410, 528, 0.05}, {475, 528, 0.18}, {540, 528, 0.18}, {588, 528, 0.05}})
b_ripple:gesture({{448, 546, 0.05}, {505, 546, 0.16}, {562, 546, 0.05}})

-- 4. Close the water-to-shore boundary seam (straddling shore_pts by ±5 units)
local m_shore_seam = ribbon(shore_pts, 10):soften(2.5)
work(m_shore_seam, {
  hand = "detail", tool = "filbert 6", pile = shore_water_dark,
  angle = 0, coverage = 1.5, fill = true, load = 0.78
})

--@ chunk 8
-- Campaign 2b: Shallow foreground rocky promontory and flanking glacial erratic boulders
earth_dark = pile{
  {"raw umber", 5.0}, {"bone black", 2.8}, {"yellow ochre", 1.2}, {"Prussian blue", 0.35},
  oil = "walnut", medium = 0.15, name = "earth_dark"
}
earth_deep_shadow = pile{
  {"bone black", 3.8}, {"raw umber", 4.5}, {"Prussian blue", 0.45}, {"red earth", 0.6},
  oil = "walnut", medium = 0.15, name = "earth_deep_shadow"
}
earth_ochre_moss = pile{
  {"raw umber", 4.2}, {"yellow ochre", 2.2}, {"green earth", 1.8}, {"bone black", 1.2},
  oil = "walnut", medium = 0.15, name = "earth_ochre_moss"
}
boulder_dark = pile{
  {"raw umber", 4.5}, {"bone black", 2.5}, {"smalt", 1.5}, {"red earth", 0.6},
  oil = "walnut", medium = 0.15, name = "boulder_dark"
}
boulder_top_dim = pile{
  {"pale smalt", 3.2}, {"raw umber", 3.4}, {"yellow ochre", 1.2}, {"bone black", 0.9}, {"lead white", 0.65},
  oil = "walnut", medium = 0.18, thinner = 0.22, name = "boulder_top_dim"
}

-- 1. Model the foreground promontory planes (central crest slightly warmer dark ochre-umber, lower & outer slopes deeper shadow)
work(m_fg, {
  hand = "body",
  tool = "filbert 11",
  piles = {
    {earth_ochre_moss, function(x, y)
      local crest = clamp(1 - (y - 575) / 55, 0, 1) * clamp(1 - math.abs(x - 500) / 280, 0.2, 1)
      return 0.75 * crest
    end},
    {earth_dark, function(x, y)
      return clamp(1 - math.abs(y - 635) / 55, 0.25, 1)
    end},
    {earth_deep_shadow, function(x, y)
      local bottom = clamp((y - 640) / 75, 0, 1)
      local sides = 0.45 * clamp(math.abs(x - 500) / 420, 0, 1)
      return clamp(bottom + sides, 0, 1)
    end}
  },
  angle = function(x, y) return -0.08 * (x - 500) / 500 end,
  coverage = 1.5,
  fill = true,
  load = 0.80,
  clip = m_fg
})

-- 2. Left glacial erratic boulders (drawn individually, never mirrored)
m_boulder_L1 = poly({{328, 616}, {336, 592}, {364, 583}, {395, 589}, {408, 612}, {372, 620}})
m_boulder_L1_top = poly({{336, 592}, {364, 583}, {395, 589}, {376, 597}, {346, 598}}):soften(1)
m_boulder_L2 = poly({{392, 618}, {404, 600}, {428, 597}, {442, 613}, {418, 622}})
m_boulder_L2_top = poly({{404, 600}, {428, 597}, {442, 613}, {424, 606}, {408, 605}}):soften(1)

work(m_boulder_L1, {hand = "detail", tool = "filbert 5", pile = boulder_dark, angle = -0.25, coverage = 1.6, fill = true, clip = m_boulder_L1})
work(m_boulder_L1_top, {hand = "detail", tool = "round 3", pile = boulder_top_dim, angle = -0.15, coverage = 1.3, load = 0.68, clip = m_boulder_L1})
work(m_boulder_L2, {hand = "detail", tool = "filbert 4", pile = boulder_dark, angle = -0.20, coverage = 1.6, fill = true, clip = m_boulder_L2})
work(m_boulder_L2_top, {hand = "detail", tool = "round 2.5", pile = boulder_top_dim, angle = -0.10, coverage = 1.2, load = 0.65, clip = m_boulder_L2})

-- 3. Right glacial erratic boulders (distinct geometry)
m_boulder_R1 = poly({{572, 617}, {582, 596}, {612, 586}, {644, 594}, {654, 616}, {615, 623}})
m_boulder_R1_top = poly({{582, 596}, {612, 586}, {644, 594}, {624, 601}, {592, 602}}):soften(1)
m_boulder_R2 = poly({{640, 620}, {652, 605}, {680, 603}, {692, 617}, {665, 624}})
m_boulder_R2_top = poly({{652, 605}, {680, 603}, {692, 617}, {674, 610}, {656, 610}}):soften(1)

work(m_boulder_R1, {hand = "detail", tool = "filbert 5", pile = boulder_dark, angle = 0.25, coverage = 1.6, fill = true, clip = m_boulder_R1})
work(m_boulder_R1_top, {hand = "detail", tool = "round 3", pile = boulder_top_dim, angle = 0.15, coverage = 1.3, load = 0.68, clip = m_boulder_R1})
work(m_boulder_R2, {hand = "detail", tool = "filbert 4", pile = boulder_dark, angle = 0.20, coverage = 1.6, fill = true, clip = m_boulder_R2})
work(m_boulder_R2_top, {hand = "detail", tool = "round 2.5", pile = boulder_top_dim, angle = 0.10, coverage = 1.2, load = 0.65, clip = m_boulder_R2})

-- 4. Basal contact shadows under boulders and rocky shore threshold accents
b_rock_sh = brush{kind = "round", width = 3.2, point = 0.85, stiffness = 0.5}
b_rock_sh:load(earth_deep_shadow, 0.80)
b_rock_sh:gesture({{326, 617, 0.4}, {372, 621, 0.8}, {418, 623, 0.7}, {444, 615, 0.3}})
b_rock_sh:gesture({{570, 618, 0.4}, {615, 624, 0.8}, {665, 625, 0.7}, {694, 618, 0.3}})
-- Flat threshold stone at the left foot of the oak's root flare
m_root_stone = poly({{448, 594}, {458, 586}, {478, 585}, {482, 595}, {462, 598}})
work(m_root_stone, {hand = "detail", tool = "round 3", pile = boulder_dark, angle = -0.1, coverage = 1.5, fill = true, clip = m_root_stone})
b_rock_sh:load(boulder_top_dim, 0.55)
b_rock_sh:gesture({{456, 587, 0.25}, {468, 586, 0.45}, {477, 587, 0.20}})

--@ chunk 9
wait(10 * 24 * 60)
print("moon:", drying(515, 152), "headland:", drying(300, 475), "shore:", drying(500, 576), "boulder:", drying(365, 595))

--@ chunk 10
wait(4 * 24 * 60)
print("boulder:", drying(365, 595), "fg crest:", drying(500, 582))

--@ chunk 11
-- Campaign 3a: The Solitary Ancient Winter Oak — Trunk, Root Flares, Basal Hollow, Primary Boughs & Second-Order Limbs

oak_dark = pile{
  {"raw umber", 5.0}, {"bone black", 3.2}, {"red earth", 0.8}, {"Prussian blue", 0.3},
  oil = "walnut", medium = 0.14, name = "oak_dark"
}
oak_cavity = pile{
  {"bone black", 4.5}, {"raw umber", 3.5}, {"Prussian blue", 0.5},
  oil = "walnut", medium = 0.14, name = "oak_cavity"
}
oak_bark_warm = pile{
  {"raw umber", 4.2}, {"yellow ochre", 1.8}, {"red earth", 1.0}, {"lead white", 0.45}, {"bone black", 1.0},
  oil = "walnut", medium = 0.14, name = "oak_bark_warm"
}
oak_bark_cool = pile{
  {"raw umber", 4.2}, {"pale smalt", 2.2}, {"bone black", 1.8}, {"yellow ochre", 0.6}, {"lead white", 0.40},
  oil = "walnut", medium = 0.14, name = "oak_bark_cool"
}

-- 1. Build the skeleton of the ancient oak (trunk + root flares + primary boughs + retrenched spire) using body_of
oak_core = body_of{
  spine = {
    {500, 588}, {500, 560}, {499, 515}, {500, 465}, {501, 415}, {500, 372},
    {496, 332}, {498, 295}, {494, 264}, {488, 244}
  },
  widths = {48, 34, 31, 29, 28, 33, 12, 9.5, 7.0, 3.5},
  limbs = {
    -- Root flares gripping the rocky promontory crest
    {{490, 566}, {478, 578}, {462, 586}, {448, 591}, widths = {16, 12, 8, 3.5}},
    {{496, 572}, {486, 584}, {476, 592}, widths = {12, 8, 3.5}},
    {{510, 566}, {522, 578}, {538, 586}, {552, 591}, widths = {16, 12, 8, 3.5}},
    {{504, 572}, {515, 585}, {525, 593}, widths = {12, 8, 3.5}},

    -- Left Primary Overarching Bough (with basal collar 18 -> tapering stepwise at each fork)
    {{492, 376}, {462, 356}, {428, 339}, {396, 311}, {373, 275}, {362, 235}, {370, 196}, {386, 163}, {404, 138},
     widths = {18.5, 15.5, 14.0, 11.5, 9.5, 7.8, 6.0, 4.2, 2.2}},

    -- Right Primary Overarching Bough (distinct crooked oak path, basal collar 18 -> tapering stepwise)
    {{508, 374}, {540, 352}, {573, 333}, {607, 304}, {629, 267}, {638, 227}, {628, 189}, {609, 157}, {592, 134},
     widths = {18.5, 15.5, 14.0, 11.5, 9.5, 7.8, 6.0, 4.2, 2.2}},

    -- Retrenched dead right fork on central stag-head spire
    {{498, 295}, {506, 272}, {514, 252}, widths = {6.5, 4.5, 2.2}},
    {{495, 328}, {482, 310}, {474, 296}, widths = {5.5, 3.8, 1.8}},

    -- Left Second-Order Limbs (thickest at collar junction, tapering outward)
    -- L-outer-low (from 428, 339)
    {{428, 339}, {388, 346}, {348, 338}, {312, 321}, {282, 298}, widths = {8.8, 7.0, 5.4, 3.8, 2.0}},
    -- L-inner-low (rising from 452, 350 toward upper left-center)
    {{452, 350}, {440, 316}, {434, 284}, {438, 254}, widths = {7.2, 5.4, 3.8, 2.0}},
    -- L-outer-mid (from 373, 275)
    {{373, 275}, {336, 261}, {302, 238}, {274, 210}, widths = {6.8, 5.2, 3.6, 1.8}},
    -- L-inner-arch (from 362, 235 curving inward toward the moon's vault)
    {{362, 235}, {394, 216}, {424, 194}, {448, 174}, widths = {5.6, 4.2, 3.0, 1.6}},
    -- L-upper-fork (from 370, 196 spreading outward)
    {{370, 196}, {344, 174}, {322, 150}, widths = {4.5, 3.0, 1.5}},

    -- Right Second-Order Limbs (thickest at collar junction, distinct crooked paths)
    -- R-outer-low (from 573, 333)
    {{573, 333}, {615, 342}, {656, 332}, {692, 314}, {720, 290}, widths = {8.8, 7.0, 5.4, 3.8, 2.0}},
    -- R-inner-low (rising from 546, 348)
    {{546, 348}, {558, 312}, {562, 280}, {556, 250}, widths = {7.2, 5.4, 3.8, 2.0}},
    -- R-outer-mid (from 629, 267)
    {{629, 267}, {666, 251}, {698, 227}, {724, 197}, widths = {6.8, 5.2, 3.6, 1.8}},
    -- R-inner-arch (from 638, 227 curving inward toward the moon's vault)
    {{638, 227}, {606, 208}, {576, 186}, {552, 166}, widths = {5.6, 4.2, 3.0, 1.6}},
    -- R-upper-fork (from 628, 189 spreading outward)
    {{628, 189}, {654, 168}, {676, 144}, widths = {4.5, 3.0, 1.5}}
  },
  blend = 0.65,
  char = "broken",
  amount = 0.45,
  seed = 91
}

m_oak_core = oak_core:mask()

-- Fill the core silhouette of trunk, primary boughs, and second-order limbs with oak_dark
work(m_oak_core, {
  hand = "detail",
  tool = "round 3.5",
  pile = oak_dark,
  angle = 1.57,
  coverage = 1.85,
  fill = true,
  load = 0.86,
  clip = m_oak_core
})

-- 2. Model the ancient trunk's deep basal hollow cavity, vertical rectangular bark blocks, and horizon edge-light
b_bark = brush{kind = "round", width = 2.4, point = 0.88, stiffness = 0.55}
-- Deep hollow cavity at base of trunk (x = 496..505, y = 515..586) and deep shadow under main bough collars
b_bark:load(oak_cavity, 0.85)
b_bark:gesture({{500, 512, 0.25}, {499, 545, 0.85}, {500, 575, 0.95}, {501, 588, 0.60}})
b_bark:gesture({{496, 530, 0.35}, {497, 565, 0.80}, {495, 586, 0.50}})
b_bark:gesture({{504, 532, 0.35}, {503, 566, 0.80}, {505, 586, 0.50}})
-- Deep crease along branch bark ridges at the primary fork (y = 368..395)
b_bark:gesture({{488, 370, 0.5}, {495, 384, 0.75}, {500, 405, 0.4}})
b_bark:gesture({{512, 368, 0.5}, {505, 382, 0.75}, {500, 405, 0.4}})

-- Subtle warm horizon glow reflected on outer bark ridges where the trunk & lower boughs cross the golden sky (y = 340..525)
b_bark_fine = brush{kind = "round", width = 1.6, point = 0.92, stiffness = 0.5}
b_bark_fine:load(oak_bark_warm, 0.52)
b_bark_fine:gesture({{485, 515, 0.15}, {486, 475, 0.48}, {486, 435, 0.50}, {485, 395, 0.30}})
b_bark_fine:gesture({{515, 515, 0.15}, {514, 475, 0.48}, {514, 435, 0.50}, {515, 395, 0.30}})
b_bark_fine:gesture({{492, 495, 0.15}, {493, 455, 0.35}, {492, 415, 0.20}})
b_bark_fine:gesture({{508, 490, 0.15}, {507, 450, 0.35}, {508, 412, 0.20}})
-- Warm underside reflection on the primary bough collars facing the glowing horizon channel
b_bark_fine:gesture({{484, 382, 0.35}, {458, 362, 0.45}, {426, 344, 0.35}, {395, 315, 0.18}})
b_bark_fine:gesture({{516, 380, 0.35}, {542, 358, 0.45}, {574, 338, 0.35}, {608, 308, 0.18}})

-- Subtle cool zenith-sky reflection along upper surfaces of the arching boughs and root flares
b_bark_fine:load(oak_bark_cool, 0.48)
b_bark_fine:gesture({{464, 350, 0.30}, {432, 333, 0.38}, {400, 305, 0.35}, {377, 270, 0.25}})
b_bark_fine:gesture({{536, 346, 0.30}, {568, 327, 0.38}, {602, 298, 0.35}, {625, 263, 0.25}})
b_bark_fine:gesture({{486, 566, 0.30}, {472, 578, 0.40}, {456, 586, 0.20}})
b_bark_fine:gesture({{514, 566, 0.30}, {528, 578, 0.40}, {544, 586, 0.20}})

--@ chunk 12
-- Campaign 3b: Third-, fourth-, and fifth-order crooked sympodial oak branches, twig network, and clustered buds

b_collar = brush{kind = "round", width = 3.6, point = 0.92, stiffness = 0.52}
b_br3 = brush{kind = "round", width = 2.6, point = 0.95, stiffness = 0.50}
b_br4 = brush{kind = "rigger", width = 1.6, point = 0.96, stiffness = 0.48}
b_twig = brush{kind = "rigger", width = 1.0, point = 0.98, stiffness = 0.45}

-- Helper to draw a tapering branch gesture and optional terminal oak bud cluster at its tip
function draw_shoot(br, pile_use, pts, bud_cluster)
  br:load(pile_use, 0.85)
  br:gesture(pts)
  if bud_cluster then
    local last = pts[#pts]
    local prev = pts[#pts - 1]
    local dx, dy = last[1] - prev[1], last[2] - prev[2]
    local len = math.sqrt(dx * dx + dy * dy)
    if len > 0.1 then
      dx, dy = dx / len, dy / len
      local nx, ny = -dy, dx
      b_twig:load(pile_use, 0.75)
      -- Tiny clustered terminal and sub-terminal buds (2 to 3 diverging 2.5-unit forks at shoot tip)
      b_twig:gesture({{last[1] - dx*1.5, last[2] - dy*1.5, 0.28}, {last[1] + dx*2.8 + nx*1.6, last[2] + dy*2.8 + ny*1.6, 0.12}, {last[1] + dx*3.8 + nx*2.2, last[2] + dy*3.8 + ny*2.2, 0.32}})
      b_twig:gesture({{last[1] - dx*1.5, last[2] - dy*1.5, 0.28}, {last[1] + dx*2.6 - nx*1.5, last[2] + dy*2.6 - ny*1.5, 0.12}, {last[1] + dx*3.5 - nx*2.0, last[2] + dy*3.5 - ny*2.0, 0.30}})
    end
  end
end

-- 1. Reinforce branch collars at major junctions and extend primary bough tips & stag-head spire
-- Central retrenched stag-head spire (dead eroded forks, no fine twig clusters on dead wood)
draw_shoot(b_br3, oak_dark, {{493, 260, 0.85}, {488, 244, 0.65}, {482, 232, 0.42}, {477, 224, 0.15}}, false)
draw_shoot(b_br4, oak_dark, {{488, 244, 0.55}, {492, 231, 0.35}, {495, 222, 0.12}}, false)
draw_shoot(b_br3, oak_dark, {{507, 268, 0.80}, {514, 252, 0.60}, {521, 240, 0.38}, {526, 232, 0.14}}, false)
draw_shoot(b_br4, oak_dark, {{514, 252, 0.50}, {509, 239, 0.30}, {506, 230, 0.10}}, false)
draw_shoot(b_br3, oak_dark, {{481, 308, 0.75}, {474, 296, 0.52}, {466, 286, 0.30}, {460, 280, 0.10}}, false)
draw_shoot(b_br4, oak_dark, {{474, 296, 0.45}, {478, 283, 0.25}, {481, 274, 0.08}}, false)

-- 2. LEFT CROWN EXTENSION (forming the left side of the symmetric Gothic vault, with rich crooked internal irregularity)
-- Upper left vault apex (from 386, 163 -> 404, 138 and arching above the moon)
draw_shoot(b_collar, oak_dark, {{386, 163, 0.88}, {404, 138, 0.62}, {424, 120, 0.40}, {445, 108, 0.22}, {462, 102, 0.08}}, true)
draw_shoot(b_br3, oak_dark, {{404, 138, 0.65}, {396, 118, 0.42}, {386, 102, 0.24}, {378, 90, 0.08}}, true)
draw_shoot(b_br4, oak_dark, {{424, 120, 0.48}, {438, 126, 0.32}, {452, 124, 0.18}, {464, 119, 0.06}}, true)
draw_shoot(b_br4, oak_dark, {{424, 120, 0.45}, {418, 104, 0.28}, {412, 92, 0.10}}, true)
draw_shoot(b_br3, oak_dark, {{378, 178, 0.70}, {362, 158, 0.48}, {348, 138, 0.28}, {336, 122, 0.10}}, true)
draw_shoot(b_br4, oak_dark, {{362, 158, 0.48}, {368, 140, 0.28}, {372, 125, 0.10}}, true)

-- Left upper-outer fork (from 370, 196 -> 344, 174 -> 322, 150)
draw_shoot(b_collar, oak_dark, {{370, 196, 0.82}, {344, 174, 0.58}, {322, 150, 0.38}, {302, 132, 0.20}, {286, 118, 0.07}}, true)
draw_shoot(b_br3, oak_dark, {{344, 174, 0.60}, {324, 180, 0.40}, {304, 176, 0.24}, {288, 168, 0.08}}, true)
draw_shoot(b_br4, oak_dark, {{322, 150, 0.45}, {328, 132, 0.28}, {332, 116, 0.10}}, true)
draw_shoot(b_br4, oak_dark, {{304, 176, 0.38}, {290, 186, 0.22}, {276, 190, 0.08}}, true)

-- Left inner-arch limb (from 362, 235 -> 394, 216 -> 424, 194 -> 448, 174, framing left-below the crescent moon)
draw_shoot(b_collar, oak_dark, {{362, 235, 0.85}, {394, 216, 0.62}, {424, 194, 0.42}, {448, 174, 0.26}, {468, 162, 0.12}, {480, 156, 0.05}}, true)
draw_shoot(b_br3, oak_dark, {{394, 216, 0.58}, {402, 196, 0.38}, {414, 180, 0.22}, {424, 168, 0.08}}, true)
draw_shoot(b_br3, oak_dark, {{424, 194, 0.52}, {444, 198, 0.34}, {462, 194, 0.20}, {476, 186, 0.07}}, true)
draw_shoot(b_br4, oak_dark, {{448, 174, 0.38}, {454, 158, 0.22}, {462, 146, 0.08}}, true)
draw_shoot(b_br4, oak_dark, {{444, 198, 0.35}, {452, 210, 0.20}, {462, 216, 0.07}}, true)

-- Left middle-outer limb (from 373, 275 -> 336, 261 -> 302, 238 -> 274, 210)
draw_shoot(b_collar, oak_dark, {{373, 275, 0.90}, {336, 261, 0.68}, {302, 238, 0.46}, {274, 210, 0.28}, {250, 188, 0.14}, {234, 174, 0.05}}, true)
draw_shoot(b_br3, oak_dark, {{336, 261, 0.65}, {312, 268, 0.44}, {288, 264, 0.26}, {268, 254, 0.10}}, true)
draw_shoot(b_br3, oak_dark, {{302, 238, 0.55}, {296, 216, 0.36}, {286, 196, 0.20}, {276, 180, 0.07}}, true)
draw_shoot(b_br4, oak_dark, {{274, 210, 0.42}, {254, 214, 0.26}, {236, 210, 0.10}}, true)
draw_shoot(b_br4, oak_dark, {{288, 264, 0.36}, {272, 274, 0.20}, {256, 278, 0.07}}, true)
draw_shoot(b_br4, oak_dark, {{348, 266, 0.48}, {342, 246, 0.30}, {332, 230, 0.14}, {324, 218, 0.06}}, true)

-- Left inner-low limb (from 452, 350 -> 440, 316 -> 434, 284 -> 438, 254)
draw_shoot(b_collar, oak_dark, {{452, 350, 0.88}, {440, 316, 0.64}, {434, 284, 0.44}, {438, 254, 0.26}, {446, 232, 0.12}, {454, 218, 0.05}}, true)
draw_shoot(b_br3, oak_dark, {{440, 316, 0.58}, {420, 302, 0.38}, {404, 284, 0.22}, {392, 268, 0.08}}, true)
draw_shoot(b_br3, oak_dark, {{434, 284, 0.50}, {452, 270, 0.32}, {466, 254, 0.18}, {476, 242, 0.06}}, true)
draw_shoot(b_br4, oak_dark, {{438, 254, 0.38}, {424, 240, 0.22}, {412, 228, 0.08}}, true)

-- Left lower-outer limb (from 428, 339 -> 388, 346 -> 348, 338 -> 312, 321 -> 282, 298)
draw_shoot(b_collar, oak_dark, {{428, 339, 0.95}, {388, 346, 0.72}, {348, 338, 0.52}, {312, 321, 0.34}, {282, 298, 0.20}, {258, 280, 0.08}}, true)
draw_shoot(b_br3, oak_dark, {{388, 346, 0.68}, {368, 362, 0.48}, {344, 368, 0.30}, {322, 364, 0.16}, {306, 356, 0.06}}, true)
draw_shoot(b_br3, oak_dark, {{348, 338, 0.58}, {336, 316, 0.38}, {320, 298, 0.22}, {306, 284, 0.08}}, true)
draw_shoot(b_br3, oak_dark, {{312, 321, 0.48}, {288, 328, 0.32}, {266, 324, 0.18}, {248, 316, 0.06}}, true)
draw_shoot(b_br4, oak_dark, {{368, 362, 0.45}, {356, 378, 0.28}, {340, 386, 0.12}, {328, 388, 0.05}}, true)
draw_shoot(b_br4, oak_dark, {{282, 298, 0.36}, {268, 282, 0.22}, {256, 268, 0.08}}, true)
-- Small epicormic / lower bough spur on left trunk-shoulder (410, 355)
draw_shoot(b_br3, oak_dark, {{446, 352, 0.65}, {424, 368, 0.45}, {402, 376, 0.28}, {384, 374, 0.12}, {372, 368, 0.05}}, true)
draw_shoot(b_br4, oak_dark, {{424, 368, 0.38}, {414, 384, 0.22}, {402, 392, 0.08}}, true)

-- 3. RIGHT CROWN EXTENSION (balancing the arch around x = 500 with distinct crooked oak geometry)
-- Upper right vault apex (from 609, 157 -> 592, 134 and arching above the moon)
draw_shoot(b_collar, oak_dark, {{609, 157, 0.88}, {592, 134, 0.62}, {572, 116, 0.40}, {550, 105, 0.22}, {534, 99, 0.08}}, true)
draw_shoot(b_br3, oak_dark, {{592, 134, 0.65}, {602, 114, 0.42}, {614, 98, 0.24}, {622, 86, 0.08}}, true)
draw_shoot(b_br4, oak_dark, {{572, 116, 0.48}, {558, 122, 0.32}, {544, 120, 0.18}, {532, 115, 0.06}}, true)
draw_shoot(b_br4, oak_dark, {{572, 116, 0.45}, {578, 100, 0.28}, {585, 88, 0.10}}, true)
draw_shoot(b_br3, oak_dark, {{618, 172, 0.70}, {635, 152, 0.48}, {650, 134, 0.28}, {662, 118, 0.10}}, true)
draw_shoot(b_br4, oak_dark, {{635, 152, 0.48}, {628, 135, 0.28}, {624, 120, 0.10}}, true)

-- Right upper-outer fork (from 628, 189 -> 654, 168 -> 676, 144)
draw_shoot(b_collar, oak_dark, {{628, 189, 0.82}, {654, 168, 0.58}, {676, 144, 0.38}, {696, 126, 0.20}, {712, 112, 0.07}}, true)
draw_shoot(b_br3, oak_dark, {{654, 168, 0.60}, {674, 175, 0.40}, {694, 172, 0.24}, {710, 164, 0.08}}, true)
draw_shoot(b_br4, oak_dark, {{676, 144, 0.45}, {670, 126, 0.28}, {666, 110, 0.10}}, true)
draw_shoot(b_br4, oak_dark, {{694, 172, 0.38}, {708, 182, 0.22}, {722, 186, 0.08}}, true)

-- Right inner-arch limb (from 638, 227 -> 606, 208 -> 576, 186 -> 552, 166, framing right-below the crescent moon)
draw_shoot(b_collar, oak_dark, {{638, 227, 0.85}, {606, 208, 0.62}, {576, 186, 0.42}, {552, 166, 0.26}, {536, 156, 0.12}}, true)
draw_shoot(b_br3, oak_dark, {{606, 208, 0.58}, {598, 188, 0.38}, {586, 172, 0.22}, {576, 160, 0.08}}, true)
draw_shoot(b_br3, oak_dark, {{576, 186, 0.52}, {556, 192, 0.34}, {538, 188, 0.20}, {525, 182, 0.07}}, true)
draw_shoot(b_br4, oak_dark, {{552, 166, 0.38}, {546, 150, 0.22}, {538, 138, 0.08}}, true)
draw_shoot(b_br4, oak_dark, {{556, 192, 0.35}, {548, 204, 0.20}, {538, 210, 0.07}}, true)

-- Right middle-outer limb (from 629, 267 -> 666, 251 -> 698, 227 -> 724, 197)
draw_shoot(b_collar, oak_dark, {{629, 267, 0.90}, {666, 251, 0.68}, {698, 227, 0.46}, {724, 197, 0.28}, {748, 176, 0.14}, {764, 162, 0.05}}, true)
draw_shoot(b_br3, oak_dark, {{666, 251, 0.65}, {690, 258, 0.44}, {714, 254, 0.26}, {734, 244, 0.10}}, true)
draw_shoot(b_br3, oak_dark, {{698, 227, 0.55}, {704, 205, 0.36}, {714, 186, 0.20}, {724, 170, 0.07}}, true)
draw_shoot(b_br4, oak_dark, {{724, 197, 0.42}, {744, 202, 0.26}, {762, 198, 0.10}}, true)
draw_shoot(b_br4, oak_dark, {{714, 254, 0.36}, {730, 264, 0.20}, {746, 268, 0.07}}, true)
draw_shoot(b_br4, oak_dark, {{652, 258, 0.48}, {658, 238, 0.30}, {668, 222, 0.14}, {676, 210, 0.06}}, true)

-- Right inner-low limb (from 546, 348 -> 558, 312 -> 562, 280 -> 556, 250)
draw_shoot(b_collar, oak_dark, {{546, 348, 0.88}, {558, 312, 0.64}, {562, 280, 0.44}, {556, 250, 0.26}, {548, 228, 0.12}, {540, 214, 0.05}}, true)
draw_shoot(b_br3, oak_dark, {{558, 312, 0.58}, {578, 298, 0.38}, {594, 280, 0.22}, {606, 264, 0.08}}, true)
draw_shoot(b_br3, oak_dark, {{562, 280, 0.50}, {544, 266, 0.32}, {530, 250, 0.18}, {522, 238, 0.06}}, true)
draw_shoot(b_br4, oak_dark, {{556, 250, 0.38}, {570, 236, 0.22}, {582, 224, 0.08}}, true)

-- Right lower-outer limb (from 573, 333 -> 615, 342 -> 656, 332 -> 692, 314 -> 720, 290)
draw_shoot(b_collar, oak_dark, {{573, 333, 0.95}, {615, 342, 0.72}, {656, 332, 0.52}, {692, 314, 0.34}, {720, 290, 0.20}, {744, 272, 0.08}}, true)
draw_shoot(b_br3, oak_dark, {{615, 342, 0.68}, {636, 358, 0.48}, {660, 364, 0.30}, {682, 360, 0.16}, {698, 352, 0.06}}, true)
draw_shoot(b_br3, oak_dark, {{656, 332, 0.58}, {668, 310, 0.38}, {684, 292, 0.22}, {698, 278, 0.08}}, true)
draw_shoot(b_br3, oak_dark, {{692, 314, 0.48}, {716, 322, 0.32}, {738, 318, 0.18}, {756, 310, 0.06}}, true)
draw_shoot(b_br4, oak_dark, {{636, 358, 0.45}, {648, 374, 0.28}, {664, 382, 0.12}, {676, 384, 0.05}}, true)
draw_shoot(b_br4, oak_dark, {{720, 290, 0.36}, {734, 274, 0.22}, {746, 260, 0.08}}, true)
-- Lower bough spur on right trunk-shoulder
draw_shoot(b_br3, oak_dark, {{552, 346, 0.65}, {574, 362, 0.45}, {596, 370, 0.28}, {614, 368, 0.12}, {626, 362, 0.05}}, true)
draw_shoot(b_br4, oak_dark, {{574, 362, 0.38}, {584, 378, 0.22}, {596, 386, 0.08}}, true)

--@ chunk 13
-- Campaign 3c: Boulder intermediate facets/crevices and calm water reflection of the oak trunk & shore edge

boulder_mid = pile{
  {"raw umber", 4.5}, {"smalt", 2.2}, {"bone black", 1.6}, {"yellow ochre", 0.8}, {"lead white", 0.22},
  oil = "walnut", medium = 0.16, thinner = 0.18, name = "boulder_mid"
}

-- 1. Bridge the top facets and shadow bodies of the four glacial boulders with intermediate planes and dark crevices
b_stone = brush{kind = "round", width = 3.0, point = 0.85, stiffness = 0.48}
b_crevice = brush{kind = "round", width = 1.6, point = 0.94, stiffness = 0.52}

-- Left boulder 1 (328..408, 583..620)
b_stone:load(boulder_mid, 0.72)
b_stone:gesture({{338, 597, 0.45}, {365, 596, 0.70}, {392, 592, 0.50}, {380, 603, 0.35}})
b_stone:gesture({{334, 602, 0.35}, {356, 604, 0.55}, {378, 607, 0.30}})
b_crevice:load(earth_deep_shadow, 0.80)
b_crevice:gesture({{364, 585, 0.15}, {368, 598, 0.55}, {372, 616, 0.40}})

-- Left boulder 2 (392..442, 597..622)
b_stone:load(boulder_mid, 0.70)
b_stone:gesture({{404, 604, 0.40}, {424, 604, 0.65}, {438, 610, 0.35}})
b_crevice:load(earth_deep_shadow, 0.80)
b_crevice:gesture({{394, 616, 0.45}, {402, 604, 0.65}, {408, 614, 0.40}})

-- Right boulder 1 (572..654, 586..623)
b_stone:load(boulder_mid, 0.72)
b_stone:gesture({{586, 600, 0.45}, {615, 598, 0.70}, {640, 596, 0.50}, {628, 606, 0.35}})
b_stone:gesture({{580, 606, 0.35}, {608, 607, 0.55}, {635, 610, 0.30}})
b_crevice:load(earth_deep_shadow, 0.80)
b_crevice:gesture({{612, 588, 0.15}, {614, 601, 0.55}, {615, 620, 0.40}})

-- Right boulder 2 (640..692, 603..624)
b_stone:load(boulder_mid, 0.70)
b_stone:gesture({{654, 609, 0.40}, {674, 609, 0.65}, {688, 615, 0.35}})
b_crevice:load(earth_deep_shadow, 0.80)
b_crevice:gesture({{644, 618, 0.45}, {652, 607, 0.65}, {656, 618, 0.40}})

-- 2. Horizontal reflection of the oak trunk & central mound in the calm water (x = 420..580, y = 556..582)
b_wrefl = brush{kind = "filbert", width = 5.0, stiffness = 0.4}
b_wrefl:load(shore_water_dark, 0.68)
-- Short horizontal reflection strokes right under the oak trunk on the water (y = 558..575)
b_wrefl:gesture({{478, 560, 0.15}, {500, 560, 0.45}, {522, 560, 0.15}})
b_wrefl:gesture({{472, 565, 0.20}, {500, 565, 0.60}, {528, 565, 0.20}})
b_wrefl:gesture({{460, 570, 0.25}, {500, 570, 0.72}, {540, 570, 0.25}})
b_wrefl:gesture({{435, 574, 0.25}, {500, 574, 0.75}, {565, 574, 0.25}})
-- Smooth out the scalloped upper edge of m_shore_seam on left and right with horizontal strokes
b_wrefl:load(water_near, 0.60)
b_wrefl:gesture({{340, 584, 0.20}, {395, 582, 0.45}, {445, 576, 0.25}})
b_wrefl:gesture({{555, 576, 0.25}, {605, 582, 0.45}, {660, 584, 0.20}})
b_wrefl:gesture({{220, 596, 0.20}, {285, 592, 0.45}, {345, 586, 0.20}})
b_wrefl:gesture({{655, 586, 0.20}, {715, 592, 0.45}, {780, 596, 0.20}})

--@ chunk 14
-- Wait 10 days on main canvas so Campaign 3 is completely dry
wait(10 * 24 * 60)
print("Main canvas drying — oak:", drying(500, 450), "boulder:", drying(365, 595), "water refl:", drying(500, 568))

--@ chunk 15
wait(5 * 24 * 60)
print("Main canvas oak drying now:", drying(500, 450), drying(495, 550))

--@ chunk 16
-- Campaign 4a: Unified blended water reflection, planar flat-brush granite boulders, and fissured oak trunk/root grounding

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
oak_bark_deep_warm = pile{
  {"raw umber", 5.0}, {"red earth", 1.3}, {"yellow ochre", 1.1}, {"bone black", 2.0},
  oil = "walnut", medium = 0.15, name = "oak_bark_deep_warm"
}

-- 1. Unified continuous horizontal water pass (m_water - m_oak_core) so no internal seam or unblended bar remains
local m_water_clean = m_water - m_oak_core
work(m_water_clean, {
  hand = "body",
  tool = "filbert 15",
  piles = {
    {water_horizon, function(x, y)
      local h_band = clamp(1 - (y - 485) / 34, 0, 1)
      local side_shade = 0.72 + 0.38 * clamp(math.abs(x - 500) / 210, 0, 1)
      return h_band * side_shade
    end},
    {water_echo, function(x, y)
      local mid_band = clamp(1 - math.abs(y - 526) / 36, 0, 1)
      local center_channel = clamp(1 - (y - 485) / 28, 0, 1) * clamp(1 - math.abs(x - 500) / 175, 0, 1) * 0.65
      return clamp(mid_band + center_channel, 0, 1.1)
    end},
    {water_near, function(x, y)
      return clamp((y - 538) / 52, 0, 1)
    end},
    {shore_water_dark, function(x, y)
      -- Smoothly darken along the rising shore contour and directly below the central oak trunk
      local y_shore = 575 + 0.075 * math.abs(x - 500)
      local shore_prox = clamp(1 - math.abs(y - y_shore) / 18, 0, 1)
      local trunk_refl = clamp(1 - math.abs(x - 500) / 24, 0, 1) * clamp((y - 548) / 30, 0, 1)
      return clamp(0.85 * shore_prox + 0.90 * trunk_refl, 0, 1.3)
    end}
  },
  angle = 0,
  coverage = 1.55,
  fill = true,
  load = 0.80,
  clip = m_water_clean
})

-- Single horizontal blend pass across the entire water zone
blend(m_water_clean, {angle = 0})

-- Hair-thin horizontal glass-ripple gleams on the central channel (stopping clear of the oak trunk x = 483..517)
b_ripple = brush{kind = "rigger", width = 1.2, point = 0.96, stiffness = 0.4}
b_ripple:load(water_gleam, 0.45)
b_ripple:gesture({{415, 490, 0.06}, {450, 490, 0.24}, {478, 490, 0.05}})
b_ripple:gesture({{522, 490, 0.05}, {552, 490, 0.24}, {585, 490, 0.06}})
b_ripple:gesture({{395, 498, 0.05}, {438, 498, 0.20}, {476, 498, 0.04}})
b_ripple:gesture({{524, 498, 0.04}, {564, 498, 0.20}, {602, 498, 0.05}})
b_ripple:load(water_gleam, 0.38)
b_ripple:gesture({{422, 512, 0.05}, {455, 512, 0.18}, {479, 512, 0.04}})
b_ripple:gesture({{521, 512, 0.04}, {548, 512, 0.18}, {578, 512, 0.05}})
b_ripple:gesture({{408, 528, 0.04}, {445, 528, 0.15}, {478, 528, 0.04}})
b_ripple:gesture({{522, 528, 0.04}, {556, 528, 0.15}, {590, 528, 0.04}})

-- 2. Re-model the four glacial erratic boulders with planar flat-brush facets (no worm-like round strokes, low lead white)
local flat4 = {kind = "flat", width = 4.0, point = 0}
local flat3 = {kind = "flat", width = 3.2, point = 0}

-- Left boulder 1 facets
local m_L1_side = poly({{328, 616}, {336, 592}, {364, 583}, {370, 602}, {354, 618}})
local m_L1_top = poly({{336, 592}, {364, 583}, {395, 589}, {378, 595}, {348, 596}}):soften(0.6)
work(m_boulder_L1, {hand = "detail", tool = flat4, pile = granite_shadow, angle = 0.35, coverage = 1.6, fill = true, clip = m_boulder_L1})
work(m_L1_side, {hand = "detail", tool = flat4, pile = granite_side, angle = -0.30, coverage = 1.4, fill = true, clip = m_boulder_L1})
work(m_L1_top, {hand = "detail", tool = flat3, pile = granite_top, angle = -0.15, coverage = 1.3, load = 0.70, clip = m_boulder_L1})

-- Left boulder 2 facets
local m_L2_side = poly({{392, 618}, {404, 600}, {428, 597}, {422, 612}, {406, 620}})
local m_L2_top = poly({{404, 600}, {428, 597}, {442, 613}, {426, 604}, {408, 604}}):soften(0.6)
work(m_boulder_L2, {hand = "detail", tool = flat4, pile = granite_shadow, angle = 0.30, coverage = 1.6, fill = true, clip = m_boulder_L2})
work(m_L2_side, {hand = "detail", tool = flat3, pile = granite_side, angle = -0.25, coverage = 1.4, fill = true, clip = m_boulder_L2})
work(m_L2_top, {hand = "detail", tool = flat3, pile = granite_top, angle = -0.10, coverage = 1.2, load = 0.68, clip = m_boulder_L2})

-- Right boulder 1 facets
local m_R1_side = poly({{654, 616}, {644, 594}, {612, 586}, {606, 604}, {626, 620}})
local m_R1_top = poly({{582, 596}, {612, 586}, {644, 594}, {626, 599}, {594, 600}}):soften(0.6)
work(m_boulder_R1, {hand = "detail", tool = flat4, pile = granite_shadow, angle = -0.35, coverage = 1.6, fill = true, clip = m_boulder_R1})
work(m_R1_side, {hand = "detail", tool = flat4, pile = granite_side, angle = 0.30, coverage = 1.4, fill = true, clip = m_boulder_R1})
work(m_R1_top, {hand = "detail", tool = flat3, pile = granite_top, angle = 0.15, coverage = 1.3, load = 0.70, clip = m_boulder_R1})

-- Right boulder 2 facets
local m_R2_side = poly({{692, 617}, {680, 603}, {652, 605}, {660, 616}, {676, 622}})
local m_R2_top = poly({{652, 605}, {680, 603}, {692, 617}, {676, 608}, {656, 608}}):soften(0.6)
work(m_boulder_R2, {hand = "detail", tool = flat4, pile = granite_shadow, angle = -0.30, coverage = 1.6, fill = true, clip = m_boulder_R2})
work(m_R2_side, {hand = "detail", tool = flat3, pile = granite_side, angle = 0.25, coverage = 1.4, fill = true, clip = m_boulder_R2})
work(m_R2_top, {hand = "detail", tool = flat3, pile = granite_top, angle = 0.10, coverage = 1.2, load = 0.68, clip = m_boulder_R2})

-- Root stone at left base of oak
work(m_root_stone, {hand = "detail", tool = flat3, pile = granite_shadow, angle = -0.1, coverage = 1.5, fill = true, clip = m_root_stone})
work(poly({{452, 589}, {462, 586}, {478, 585}, {472, 590}}), {hand = "detail", tool = flat3, pile = granite_top, angle = -0.1, coverage = 1.2, clip = m_root_stone})

-- 3. Knit the oak's lower trunk bark blocks and root flares into the dark earth (removing the pale stripes)
b_bark_flat = brush{kind = "flat", width = 2.6, point = 0, stiffness = 0.55}
b_bark_flat:load(oak_bark_deep_warm, 0.75)
-- Rectangular fissured bark blocks along the trunk where it crosses the horizon glow
b_bark_flat:stroke({{486, 520}, {487, 465}, {486, 410}}, {pressure = {0.65, 0.50}, orient = "along"})
b_bark_flat:stroke({{514, 520}, {513, 465}, {514, 410}}, {pressure = {0.65, 0.50}, orient = "along"})
b_bark_flat:stroke({{492, 510}, {493, 450}, {492, 390}}, {pressure = {0.60, 0.45}, orient = "along"})
b_bark_flat:stroke({{508, 510}, {507, 450}, {508, 390}}, {pressure = {0.60, 0.45}, orient = "along"})

-- Tone down the overly bright root-top stripes and ground the roots into dark earth/turf
b_bark_flat:load(oak_dark, 0.80)
b_bark_flat:stroke({{488, 566}, {472, 578}, {454, 588}}, {pressure = {0.75, 0.40}, orient = "along"})
b_bark_flat:stroke({{512, 566}, {528, 578}, {546, 588}}, {pressure = {0.75, 0.40}, orient = "along"})

-- Crisp dark shore-crest turf and stone overlaps along shore_pts so water and land meet cleanly
b_turf = brush{kind = "round", width = 3.0, point = 0.8, stiffness = 0.5}
b_turf:load(earth_dark, 0.82)
b_turf:gesture({{0, 614, 0.5}, {90, 611, 0.6}, {180, 606, 0.6}, {265, 599, 0.6}, {332, 593, 0.5}})
b_turf:gesture({{406, 585, 0.5}, {460, 579, 0.7}, {500, 576, 0.8}, {540, 579, 0.7}, {580, 584, 0.5}})
b_turf:gesture({{652, 593, 0.5}, {745, 600, 0.6}, {835, 607, 0.6}, {920, 611, 0.6}, {1000, 613, 0.5}})

--@ chunk 17
-- Campaign 4b: Repairing V-tip nodes into fork collars and building the fine 5th/6th-order winter twig filigree

oak_twig_fine = pile{
  {"raw umber", 4.8}, {"bone black", 2.6}, {"smalt", 1.2}, {"red earth", 0.6},
  oil = "walnut", medium = 0.20, thinner = 0.22, name = "oak_twig_fine"
}

b_t1 = brush{kind = "rigger", width = 1.15, point = 0.98, stiffness = 0.45}
b_t2 = brush{kind = "rigger", width = 0.80, point = 0.99, stiffness = 0.42}

-- Helper that turns a previous V-tip at (x0, y0) with incoming direction (dx, dy) into a true parent fork collar
-- from which crooked, strictly tapering 5th- and 6th-order winter shoots extend outward to hairline tips (p = 0.01)
function extend_vtip(x0, y0, prev_x, prev_y, len1, len2, bend)
  local dx, dy = x0 - prev_x, y0 - prev_y
  local d = math.sqrt(dx * dx + dy * dy)
  if d < 0.1 then return end
  dx, dy = dx / d, dy / d
  local nx, ny = -dy, dx

  -- Collar reinforcement at the V-tip junction
  b_t1:load(oak_dark, 0.82)
  local c1x, c1y = x0 + dx * 2.5 + nx * 1.4, y0 + dy * 2.5 + ny * 1.4
  local m1x, m1y = c1x + dx * (len1 * 0.55) + nx * (len1 * 0.22 * bend), c1y + dy * (len1 * 0.55) + ny * (len1 * 0.22 * bend)
  local e1x, e1y = m1x + dx * (len1 * 0.45) - nx * (len1 * 0.12 * bend), m1y + dy * (len1 * 0.45) - ny * (len1 * 0.12 * bend)
  b_t1:gesture({{x0 - dx*1.5, y0 - dy*1.5, 0.38}, {c1x, c1y, 0.28}, {m1x, m1y, 0.14}, {e1x, e1y, 0.01}})

  -- Second diverging fork shoot (shorter, crooked oak angle)
  local c2x, c2y = x0 + dx * 2.3 - nx * 1.3, y0 + dy * 2.3 - ny * 1.3
  local m2x, m2y = c2x + dx * (len2 * 0.52) - nx * (len2 * 0.30), c2y + dy * (len2 * 0.52) - ny * (len2 * 0.30)
  local e2x, e2y = m2x + dx * (len2 * 0.48) - nx * (len2 * 0.15 * bend), m2y + dy * (len2 * 0.48) - ny * (len2 * 0.15 * bend)
  b_t2:load(oak_twig_fine, 0.78)
  b_t2:gesture({{x0 - dx*1.2, y0 - dy*1.2, 0.34}, {c2x, c2y, 0.24}, {m2x, m2y, 0.11}, {e2x, e2y, 0.01}})

  -- Finest 6th-order lateral twig off the longer shoot
  local l1x, l1y = m1x + dx * (len1 * 0.35) + nx * (len1 * 0.28), m1y + dy * (len1 * 0.35) + ny * (len1 * 0.28)
  b_t2:gesture({{m1x, m1y, 0.16}, {l1x, l1y, 0.06}, {l1x + dx*3, l1y + dy*3, 0.01}})
end

-- 1. Extend all Left Crown V-tips into natural tapering twig networks
extend_vtip(462, 102, 445, 108, 16, 11, 1)
extend_vtip(378, 90, 386, 102, 15, 10, -1)
extend_vtip(464, 119, 452, 124, 13, 9, 1)
extend_vtip(412, 92, 418, 104, 14, 9, -1)
extend_vtip(336, 122, 348, 138, 16, 11, 1)
extend_vtip(372, 125, 368, 140, 12, 8, -1)

extend_vtip(286, 118, 302, 132, 16, 11, -1)
extend_vtip(288, 168, 304, 176, 15, 10, 1)
extend_vtip(332, 116, 328, 132, 13, 9, 1)
extend_vtip(276, 190, 290, 186, 14, 9, -1)

extend_vtip(480, 156, 468, 162, 11, 8, 1)
extend_vtip(424, 168, 414, 180, 13, 9, -1)
extend_vtip(476, 186, 462, 194, 12, 8, 1)
extend_vtip(462, 146, 454, 158, 11, 7, -1)
extend_vtip(462, 216, 452, 210, 12, 8, 1)

extend_vtip(234, 174, 250, 188, 17, 12, 1)
extend_vtip(268, 254, 288, 264, 15, 10, -1)
extend_vtip(276, 180, 286, 196, 14, 9, 1)
extend_vtip(236, 210, 254, 214, 15, 10, -1)
extend_vtip(256, 278, 272, 274, 14, 9, 1)
extend_vtip(324, 218, 332, 230, 13, 8, -1)

extend_vtip(454, 218, 446, 232, 13, 9, 1)
extend_vtip(392, 268, 404, 284, 14, 9, -1)
extend_vtip(476, 242, 466, 254, 12, 8, 1)
extend_vtip(412, 228, 424, 240, 13, 8, -1)

extend_vtip(258, 280, 282, 298, 16, 11, -1)
extend_vtip(306, 356, 322, 364, 15, 10, 1)
extend_vtip(306, 284, 320, 298, 14, 9, -1)
extend_vtip(248, 316, 266, 324, 16, 11, 1)
extend_vtip(328, 388, 340, 386, 13, 9, -1)
extend_vtip(256, 268, 268, 282, 14, 9, 1)
extend_vtip(372, 368, 384, 374, 13, 9, -1)
extend_vtip(402, 392, 414, 384, 12, 8, 1)

-- 2. Extend all Right Crown V-tips into natural tapering twig networks
extend_vtip(534, 99, 550, 105, 16, 11, -1)
extend_vtip(622, 86, 614, 98, 15, 10, 1)
extend_vtip(532, 115, 544, 120, 13, 9, -1)
extend_vtip(585, 88, 578, 100, 14, 9, 1)
extend_vtip(662, 118, 650, 134, 16, 11, -1)
extend_vtip(624, 120, 628, 135, 12, 8, 1)

extend_vtip(712, 112, 696, 126, 16, 11, 1)
extend_vtip(710, 164, 694, 172, 15, 10, -1)
extend_vtip(666, 110, 670, 126, 13, 9, -1)
extend_vtip(722, 186, 708, 182, 14, 9, 1)

extend_vtip(536, 156, 552, 166, 10, 7, -1)
extend_vtip(576, 160, 586, 172, 13, 9, 1)
extend_vtip(525, 182, 538, 188, 12, 8, -1)
extend_vtip(538, 138, 546, 150, 11, 7, 1)
extend_vtip(538, 210, 548, 204, 12, 8, -1)

extend_vtip(764, 162, 748, 176, 17, 12, -1)
extend_vtip(734, 244, 714, 254, 15, 10, 1)
extend_vtip(724, 170, 714, 186, 14, 9, -1)
extend_vtip(762, 198, 744, 202, 15, 10, 1)
extend_vtip(746, 268, 730, 264, 14, 9, -1)
extend_vtip(676, 210, 668, 222, 13, 8, 1)

extend_vtip(540, 214, 548, 228, 13, 9, -1)
extend_vtip(606, 264, 594, 280, 14, 9, 1)
extend_vtip(522, 238, 530, 250, 12, 8, -1)
extend_vtip(582, 224, 570, 236, 13, 8, 1)

extend_vtip(744, 272, 720, 290, 16, 11, 1)
extend_vtip(698, 352, 682, 360, 15, 10, -1)
extend_vtip(698, 278, 684, 292, 14, 9, 1)
extend_vtip(756, 310, 738, 318, 16, 11, -1)
extend_vtip(676, 384, 664, 382, 13, 9, 1)
extend_vtip(746, 260, 734, 274, 14, 9, -1)
extend_vtip(626, 362, 614, 368, 13, 9, 1)
extend_vtip(596, 386, 584, 378, 12, 8, -1)

-- 3. Add intermediate crooked lateral shoots along the middle boughs so the crown holds together as one organic oak canopy
function lateral_twig(x0, y0, x1, y1, x2, y2, x3, y3)
  b_t1:load(oak_dark, 0.80)
  b_t1:gesture({{x0, y0, 0.42}, {x1, y1, 0.26}, {x2, y2, 0.12}, {x3, y3, 0.01}})
  b_t2:load(oak_twig_fine, 0.72)
  local dx, dy = x2 - x1, y2 - y1
  b_t2:gesture({{x1, y1, 0.22}, {x1 + dx*0.8 - dy*0.45, y1 + dy*0.8 + dx*0.45, 0.09}, {x1 + dx*1.3 - dy*0.65, y1 + dy*1.3 + dx*0.65, 0.01}})
end

-- Left mid-crown crooked laterals
lateral_twig(408, 322, 392, 298, 382, 278, 376, 262)
lateral_twig(382, 292, 356, 288, 336, 280, 320, 270)
lateral_twig(365, 252, 342, 236, 326, 218, 314, 202)
lateral_twig(366, 214, 388, 194, 402, 176, 412, 160)
lateral_twig(416, 344, 404, 328, 398, 312, 395, 298)
lateral_twig(358, 342, 342, 352, 324, 354, 310, 350)

-- Right mid-crown crooked laterals (asymmetric, organic oak paths)
lateral_twig(592, 318, 608, 294, 616, 274, 622, 258)
lateral_twig(618, 286, 644, 282, 664, 274, 680, 264)
lateral_twig(634, 246, 658, 230, 674, 212, 686, 196)
lateral_twig(633, 208, 612, 188, 598, 170, 588, 154)
lateral_twig(586, 336, 598, 320, 604, 304, 608, 290)
lateral_twig(642, 336, 658, 346, 676, 348, 690, 344)

--@ chunk 18
-- Let Campaign 4 dry completely to touch-dry state
wait(14 * 24 * 60)
print("Final drying check — sky:", drying(500, 150), "water:", drying(450, 530), "oak:", drying(500, 450), "boulder:", drying(365, 595))

--@ chunk 19
print(wait(0))
