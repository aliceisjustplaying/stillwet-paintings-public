-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{
  size = 800,
  aspect = 4 / 3,
  linen = {15, 13},
  seed = 1818,
  ground = {
    -- Layer 1: Warm reddish-ochre lower priming, knifed to level the weave
    {
      pile = {{"red earth", 3.5}, {"yellow ochre", 4.0}, {"lead white", 2.5}},
      um = 45,
      apply = "knife",
      texture = 0.25
    },
    -- Layer 2: Light warm brownish-ochre middle priming, knifed
    {
      pile = {{"lead white", 7.0}, {"yellow ochre", 2.0}, {"raw umber", 0.6}},
      um = 35,
      apply = "knife",
      texture = 0.20
    },
    -- Layer 3: Pale warm pearl-ochre top ground, brushed so fine bristle striations remain
    {
      pile = {{"lead white", 14.0}, {"yellow ochre", 0.7}, {"raw umber", 0.25}, {"vermilion", 0.06}},
      um = 30,
      apply = "brush",
      texture = 0.35
    }
  }
}
print("Canvas W=" .. W .. ", H=" .. H)

--@ chunk 2
-- Campaign 1: Precise graphite underdrawing (2H and HB pencils, ruled horizon)
p2h = pencil("2H")
phb = pencil("HB")

-- 1. Ruled horizon line at y = 516
HORIZON_Y = 516
p2h:rule({0, HORIZON_Y}, {1000, HORIZON_Y}, {pressure = 0.35})

-- 2. Distant mountain ridge (far northern headland across the sound)
pts_far_ridge = {
  {395, 516}, {445, 502}, {495, 482}, {535, 472}, {575, 481},
  {625, 485}, {675, 471}, {722, 462}, {765, 474}, {815, 479},
  {868, 469}, {918, 467}, {962, 477}, {1000, 482}
}
p2h:line(pts_far_ridge, {pressure = 0.32, smooth = false})

-- 3. Middle-distance headlands (left and right)
pts_mid_left = {
  {0, 478}, {55, 474}, {110, 480}, {168, 486}, {225, 496},
  {285, 503}, {340, 511}, {382, 516}
}
p2h:line(pts_mid_left, {pressure = 0.38, smooth = false})

pts_mid_right = {
  {715, 516}, {765, 504}, {815, 491}, {865, 487},
  {915, 484}, {960, 490}, {1000, 489}
}
p2h:line(pts_mid_right, {pressure = 0.38, smooth = false})

-- 4. Rising full moon at (642, 268), radius 22
MOON_X, MOON_Y, MOON_R = 642, 268, 22
local moon_pts = {}
for i = 0, 24 do
  local a = (i / 24) * math.pi * 2
  moon_pts[#moon_pts + 1] = {MOON_X + math.cos(a) * MOON_R, MOON_Y + math.sin(a) * MOON_R}
end
p2h:line(moon_pts, {pressure = 0.25, smooth = true})

-- Faint cloud bank contours in upper and middle sky
p2h:sketch({{380, 235}, {490, 228}, {595, 242}, {710, 236}, {840, 224}, {960, 232}}, {pressure = 0.20, passes = 2, wander = 2})
p2h:sketch({{430, 298}, {555, 292}, {665, 296}, {785, 288}, {910, 295}}, {pressure = 0.20, passes = 2, wander = 2})
p2h:sketch({{80, 175}, {220, 168}, {390, 178}, {560, 165}, {740, 172}}, {pressure = 0.18, passes = 2, wander = 3})

-- 5. Foreground rocky promontory and boulder planes
pts_crag_top = {
  {0, 548}, {45, 540}, {95, 544}, {145, 536}, {198, 548},
  {250, 542}, {305, 546}, {355, 558}, {405, 566}, {438, 562},
  {478, 565}, {505, 588}, {540, 612}, {585, 634}, {625, 654},
  {662, 668}, {630, 682}, {595, 700}, {645, 725}, {680, 750}
}
phb:line(pts_crag_top, {pressure = 0.48, smooth = false})

-- Internal boulder ridges and geological fissures
phb:line({{60, 542}, {88, 585}, {72, 645}, {40, 710}}, {pressure = 0.42, smooth = false})
phb:line({{145, 536}, {175, 578}, {195, 635}, {165, 710}}, {pressure = 0.45, smooth = false})
phb:line({{198, 548}, {235, 582}, {310, 588}, {355, 558}}, {pressure = 0.44, smooth = false})
phb:line({{245, 584}, {265, 640}, {240, 720}}, {pressure = 0.45, smooth = false})
phb:line({{310, 588}, {365, 622}, {430, 618}, {495, 635}, {540, 612}}, {pressure = 0.45, smooth = false})
phb:line({{365, 622}, {390, 685}, {375, 750}}, {pressure = 0.42, smooth = false})
phb:line({{438, 562}, {420, 595}, {430, 618}}, {pressure = 0.42, smooth = false})
phb:line({{478, 565}, {485, 602}, {495, 635}, {525, 695}, {510, 750}}, {pressure = 0.45, smooth = false})

-- Lower-right shoreline rocks jutting into the water
pts_right_rocks = {
  {705, 750}, {725, 718}, {765, 698}, {818, 692}, {865, 676},
  {915, 672}, {962, 680}, {1000, 675}
}
phb:line(pts_right_rocks, {pressure = 0.45, smooth = false})
phb:line({{765, 698}, {805, 722}, {855, 715}, {915, 672}}, {pressure = 0.40, smooth = false})

-- 6. Ancient Pedunculate Oak (Quercus robur) skeleton on the left-center crag
-- Trunk contours and roots clasping the rock
phb:line({{222, 578}, {244, 548}, {252, 495}, {254, 430}, {248, 368}, {240, 318}}, {pressure = 0.55, smooth = false})
phb:line({{312, 582}, {290, 550}, {282, 495}, {284, 430}, {282, 368}, {292, 315}}, {pressure = 0.55, smooth = false})
-- Left main bough
phb:line({{244, 325}, {210, 292}, {168, 272}, {122, 242}, {82, 224}}, {pressure = 0.48, smooth = false})
phb:line({{168, 272}, {152, 222}, {118, 178}, {88, 148}}, {pressure = 0.42, smooth = false})
-- Upper-left ascending bough
phb:line({{258, 318}, {238, 258}, {205, 202}, {182, 148}, {150, 108}}, {pressure = 0.48, smooth = false})
phb:line({{205, 202}, {232, 152}, {220, 102}, {198, 74}}, {pressure = 0.42, smooth = false})
-- High dead stag-horn bough (retrenchment leader) reaching into the upper sky
phb:line({{274, 312}, {286, 248}, {278, 188}, {294, 134}, {318, 86}, {335, 64}}, {pressure = 0.50, smooth = false})
phb:line({{278, 188}, {255, 138}, {264, 92}}, {pressure = 0.42, smooth = false})
-- Right spreading bough
phb:line({{288, 322}, {332, 286}, {378, 268}, {425, 240}, {468, 228}}, {pressure = 0.48, smooth = false})
phb:line({{332, 286}, {354, 232}, {392, 188}, {428, 158}}, {pressure = 0.42, smooth = false})
phb:line({{305, 365}, {352, 348}, {398, 355}, {442, 342}}, {pressure = 0.42, smooth = false})

-- 7. Weathered wayside wooden cross on the left crag
p2h:rule({128, 542}, {142, 468}, {pressure = 0.45})
p2h:rule({116, 486}, {152, 492}, {pressure = 0.45})

-- 8. Solitary watcher (Rückenfigur) on the promontory ledge at (456, 488..565)
phb:line({{452, 496}, {456, 488}, {461, 496}}, {pressure = 0.48, smooth = true}) -- head/cap
phb:line({{444, 502}, {468, 502}, {472, 542}, {468, 564}, {442, 564}, {440, 540}, {444, 502}}, {pressure = 0.50, smooth = false}) -- coat
p2h:rule({472, 514}, {484, 565}, {pressure = 0.40}) -- walking staff

-- 9. Two distant sailboats on the calm sound
p2h:line({{552, 520}, {564, 520}, {558, 504}, {552, 520}}, {pressure = 0.35, smooth = false})
p2h:line({{710, 548}, {728, 548}, {718, 524}, {710, 548}}, {pressure = 0.38, smooth = false})
print("Underdrawing complete")

--@ chunk 3
-- Campaign 2A: Knife twilight sky palette and lay the graded sky dome + stippled transitions
p_sky_zenith  = pile{{"smalt", 5.5}, {"Prussian blue", 0.45}, {"cobalt blue", 1.2}, {"rose madder", 0.40}, {"lead white", 1.4}, medium=0.12, oil="walnut", name="sky_zenith"}
p_sky_upper   = pile{{"smalt", 4.5}, {"pale smalt", 3.5}, {"cobalt blue", 0.8}, {"lead white", 4.2}, {"rose madder", 0.30}, medium=0.12, oil="walnut", name="sky_upper"}
p_sky_mid     = pile{{"pale smalt", 4.5}, {"lead white", 8.5}, {"Naples yellow", 1.6}, {"yellow ochre", 0.25}, medium=0.12, oil="walnut", name="sky_mid"}
p_sky_amber   = pile{{"lead white", 9.0}, {"Naples yellow", 5.0}, {"yellow ochre", 1.4}, {"vermilion", 0.35}, {"rose madder", 0.30}, medium=0.12, oil="walnut", name="sky_amber"}
p_sky_horizon = pile{{"lead white", 7.5}, {"Naples yellow", 3.5}, {"yellow ochre", 2.2}, {"vermilion", 0.65}, {"rose madder", 0.65}, medium=0.12, oil="walnut", name="sky_horizon"}
p_moon_halo   = pile{{"lead white", 11.0}, {"Naples yellow", 2.8}, {"pale smalt", 1.2}, {"rose madder", 0.12}, medium=0.12, oil="walnut", name="moon_halo"}

-- Global masks for sky and moon
m_sky = rect(0, 0, 1000, 524)
m_moon_disk = ellipse(MOON_X, MOON_Y, MOON_R, MOON_R)
m_sky_around_moon = m_sky - m_moon_disk:shrink(2):soften(3)

-- Lay continuous graded sky dome
work(m_sky_around_moon, {
  hand = "broad",
  piles = {
    {p_sky_zenith, function(x, y)
      return clamp(1.0 - y / 155, 0, 1)
    end},
    {p_sky_upper, function(x, y)
      local d_moon = math.sqrt((x - MOON_X)^2 + (y - MOON_Y)^2)
      local moon_suppress = clamp((d_moon - 45) / 95, 0.2, 1.0)
      return clamp(1.0 - math.abs(y - 185) / 115, 0, 1) * moon_suppress
    end},
    {p_sky_mid, function(x, y)
      return clamp(1.0 - math.abs(y - 305) / 115, 0, 1)
    end},
    {p_sky_amber, function(x, y)
      return clamp(1.0 - math.abs(y - 415) / 95, 0, 1)
    end},
    {p_sky_horizon, function(x, y)
      return clamp((y - 410) / 105, 0, 1)
    end},
    {p_moon_halo, function(x, y)
      local d = math.sqrt((x - MOON_X)^2 + ((y - MOON_Y) * 1.15)^2)
      return clamp(1.0 - (d - 18) / 135, 0, 1) * 0.85
    end}
  },
  angle = function(x, y)
    return 0.025 * math.sin((x - 500) / 320)
  end,
  coverage = 1.65,
  load = 0.85,
  fill = true,
  clip = m_sky_around_moon
})

-- Soft horizontal blending pass across the sky dome (avoiding the moon core)
blend(m_sky_around_moon:shrink(2), {
  angle = 0,
  coverage = 0.55,
  clip = m_sky_around_moon
})

-- Friedrich-style fine stippling across the middle sky transition and moon aureole
local m_stipple_mid = rect(0, 190, 1000, 210):soften(35) - m_moon_disk:shrink(1):soften(3)
stipple(m_stipple_mid, {
  pile = p_sky_mid,
  width = 3.2,
  coverage = function(x, y)
    return 0.55 * clamp(1.0 - math.abs(y - 295) / 95, 0, 1)
  end,
  pressure = {0.25, 0.45},
  feather = 0.5,
  mix_jitter = 0.08,
  clip = m_sky_around_moon
})

local m_stipple_halo = ellipse(MOON_X, MOON_Y, 125, 105):soften(25) - m_moon_disk:shrink(1):soften(3)
stipple(m_stipple_halo, {
  pile = p_moon_halo,
  width = 3.0,
  coverage = function(x, y)
    local d = math.sqrt((x - MOON_X)^2 + ((y - MOON_Y) * 1.15)^2)
    return 0.65 * clamp(1.0 - (d - 22) / 100, 0, 1)
  end,
  pressure = {0.25, 0.45},
  feather = 0.5,
  mix_jitter = 0.06,
  clip = m_sky_around_moon
})

print("Sky dome laid, blended, and stippled; drying at (500, 250) = " .. drying(500, 250))

--@ chunk 4
-- Campaign 2B: Stratified twilight cloud banks laid into the open sky dome
p_cloud_slate  = pile{{"smalt", 4.0}, {"pale smalt", 3.0}, {"rose madder", 0.55}, {"raw umber", 0.45}, {"lead white", 3.2}, medium=0.12, oil="walnut", name="cloud_slate"}
p_cloud_violet = pile{{"pale smalt", 4.0}, {"rose madder", 0.65}, {"yellow ochre", 0.55}, {"lead white", 5.5}, medium=0.12, oil="walnut", name="cloud_violet"}
p_cloud_warm   = pile{{"lead white", 6.5}, {"Naples yellow", 2.2}, {"yellow ochre", 0.9}, {"rose madder", 0.55}, {"pale smalt", 1.8}, medium=0.12, oil="walnut", name="cloud_warm"}

-- Cloud bank 1: Upper left-to-center stratified veil (y ≈ 150..195)
m_cloud_1 = poly({
  {40, 178}, {145, 162}, {275, 156}, {410, 165}, {535, 172},
  {610, 182}, {520, 192}, {380, 194}, {220, 190}, {95, 188}
}, true):roughen(8, 55, 101):soften(12)

-- Cloud bank 2: Upper right stratified veil above the moon (y ≈ 195..242)
m_cloud_2 = poly({
  {445, 226}, {535, 212}, {635, 206}, {745, 202}, {865, 210}, {980, 222},
  {930, 238}, {810, 240}, {695, 236}, {580, 238}, {485, 235}
}, true):roughen(7, 50, 102):soften(11) - m_moon_disk:grow(10):soften(10)

-- Cloud bank 3: Lower parting cloud bank beneath and flanking the moon (y ≈ 286..328)
m_cloud_3 = poly({
  {390, 304}, {495, 292}, {590, 294}, {695, 292}, {805, 284}, {925, 292}, {990, 304},
  {915, 318}, {790, 322}, {665, 318}, {535, 320}, {430, 315}
}, true):roughen(7, 48, 103):soften(10) - m_moon_disk:grow(8):soften(8)

-- Cloud bank 4: Distant low dusk wisps on the left (y ≈ 330..365)
m_cloud_4 = poly({
  {20, 348}, {115, 338}, {235, 336}, {345, 344}, {290, 358}, {165, 360}, {55, 356}
}, true):roughen(6, 45, 104):soften(10)

work(m_cloud_1, {
  hand = "broad",
  piles = {{p_cloud_slate, 0.7}, {p_cloud_violet, 0.3}},
  angle = 0.02,
  coverage = 0.85,
  load = 0.65,
  edge = "soft",
  clip = m_sky_around_moon
})

work(m_cloud_2, {
  hand = "broad",
  piles = {
    {p_cloud_slate, function(x, y) return clamp(1.0 - (y - 200) / 35, 0.2, 0.9) end},
    {p_cloud_violet, function(x, y) return clamp((y - 205) / 35, 0.2, 0.8) end}
  },
  angle = -0.02,
  coverage = 0.90,
  load = 0.68,
  edge = "soft",
  clip = m_sky_around_moon
})

work(m_cloud_3, {
  hand = "broad",
  piles = {
    {p_cloud_violet, 0.55},
    {p_cloud_warm, 0.45}
  },
  angle = 0.015,
  coverage = 0.90,
  load = 0.68,
  edge = "soft",
  clip = m_sky_around_moon
})

work(m_cloud_4, {
  hand = "broad",
  piles = {{p_cloud_violet, 0.4}, {p_cloud_warm, 0.6}},
  angle = 0,
  coverage = 0.75,
  load = 0.60,
  edge = "soft",
  clip = m_sky_around_moon
})

-- Light horizontal blend on the outer cloud edges so they melt into the twilight air
blend((m_cloud_1 + m_cloud_2 + m_cloud_3 + m_cloud_4):grow(4), {
  angle = 0,
  coverage = 0.35,
  clip = m_sky_around_moon
})

print("Cloud banks laid and softened into open sky")

--@ chunk 5
-- Wait 5 days for the walnut-oil sky dome and cloud strata to dry completely
wait(5 * 24 * 60)
print("Drying checks: zenith=" .. drying(500, 80) .. ", moon_rim=" .. drying(642, 244) .. ", horizon=" .. drying(650, 495))

-- Campaign 2C: Luminous Full Moon Disk and Silver-Gilded Cloud Rims over dry sky
p_moon_body = pile{{"lead white", 14.0}, {"Naples yellow", 2.6}, {"yellow ochre", 0.18}, medium=0.08, oil="walnut", name="moon_body"}
p_moon_core = pile{{"lead white", 16.0}, {"Naples yellow", 1.5}, blot=0.15, oil="walnut", name="moon_core"}
p_moon_mare = pile{{"lead white", 10.0}, {"Naples yellow", 2.4}, {"pale smalt", 0.9}, {"yellow ochre", 0.35}, medium=0.10, oil="walnut", name="moon_mare"}
p_cloud_silver = pile{{"lead white", 11.0}, {"Naples yellow", 2.5}, {"pale smalt", 0.8}, {"rose madder", 0.12}, thinner=0.25, oil="walnut", name="cloud_silver"}

-- 1. Soft atmospheric glow overlapping the moon's edge (thinned veil so the boundary breathes as light, not a cutout)
local m_moon_breath = ellipse(MOON_X, MOON_Y, MOON_R + 9, MOON_R + 8):soften(8)
stipple(m_moon_breath, {
  pile = p_moon_halo,
  width = 2.6,
  coverage = function(x, y)
    local d = math.sqrt((x - MOON_X)^2 + (y - MOON_Y)^2)
    return clamp(1.0 - (d - 16) / 16, 0, 1) * 0.85
  end,
  pressure = {0.25, 0.45},
  feather = 0.6
})

-- 2. Lay the full moon disk with quiet horizontal strokes (no circular or busy texture inside the light)
local m_moon_soft = ellipse(MOON_X, MOON_Y, MOON_R + 1, MOON_R + 1):soften(2.5)
work(m_moon_soft, {
  hand = "body",
  tool = "filbert 6",
  piles = {
    {p_moon_body, 0.75},
    {p_moon_mare, function(x, y)
      -- Subtle lunar maria shading on the upper-left and center-right of the disk
      local d1 = math.sqrt((x - (MOON_X - 5))^2 + (y - (MOON_Y - 4))^2)
      local d2 = math.sqrt((x - (MOON_X + 6))^2 + (y - (MOON_Y + 3))^2)
      return (clamp(1.0 - d1 / 11, 0, 1) + clamp(1.0 - d2 / 9, 0, 1)) * 0.45
    end}
  },
  angle = 0,
  coverage = 1.8,
  load = 0.85,
  fill = true,
  clip = m_moon_soft:grow(2)
})

-- Gentle luminous center highlight on the lower-left / center of the moon disk
local m_moon_bright = ellipse(MOON_X - 2, MOON_Y + 2, 13, 12):soften(5)
work(m_moon_bright, {
  hand = "detail",
  tool = "filbert 5",
  pile = p_moon_core,
  angle = 0,
  coverage = 1.2,
  load = 0.75,
  pressure = {0.35, 0.50},
  clip = m_moon_soft
})

-- 3. Silver-gilded moonlit rims along the cloud edges facing the moon at (642, 268)
-- Lower edge of Cloud 2 (just above the moon, y ≈ 232..242, x ≈ 520..770)
local m_rim_upper = ribbon({{515, 236}, {575, 237}, {638, 234}, {702, 235}, {768, 238}}, 4.5):roughen(2.5, 22, 201):soften(3.5)
stipple(m_rim_upper, {
  pile = p_cloud_silver,
  width = 2.4,
  coverage = function(x, y)
    local dx = math.abs(x - MOON_X)
    return clamp(1.0 - dx / 135, 0.15, 1.0) * 0.95
  end,
  pressure = {0.25, 0.48},
  feather = 0.5
})

-- Upper edge of Cloud 3 (just below the moon, y ≈ 286..296, x ≈ 485..805)
local m_rim_lower = ribbon({{485, 293}, {555, 292}, {625, 294}, {695, 291}, {765, 287}, {820, 290}}, 5.0):roughen(2.5, 24, 202):soften(3.5)
stipple(m_rim_lower, {
  pile = p_cloud_silver,
  width = 2.5,
  coverage = function(x, y)
    local dx = math.abs(x - MOON_X)
    return clamp(1.0 - dx / 155, 0.15, 1.0) * 1.05
  end,
  pressure = {0.28, 0.50},
  feather = 0.5
})

-- Wait 2 days so the moon and silver cloud rims are dry before distant mountains
wait(2 * 24 * 60)
print("Moon and silver cloud rims complete; drying at moon=" .. drying(MOON_X, MOON_Y))

--@ chunk 6
-- Campaign 3A: Distant mountain ridge, middle-distance headlands, and valley/sea mist veils
p_far_peak = pile{{"pale smalt", 4.5}, {"smalt", 2.0}, {"rose madder", 0.55}, {"lead white", 6.5}, {"yellow ochre", 0.35}, medium=0.10, oil="walnut", name="far_peak"}
p_far_base = pile{{"lead white", 8.0}, {"pale smalt", 3.5}, {"Naples yellow", 1.8}, {"rose madder", 0.45}, medium=0.10, oil="walnut", name="far_base"}
p_far_lit  = pile{{"lead white", 8.5}, {"Naples yellow", 2.2}, {"pale smalt", 2.5}, {"rose madder", 0.45}, medium=0.10, oil="walnut", name="far_lit"}

-- Build polygon mask for far mountain ridge (x = 395..1000, down to y = 520)
local far_poly_pts = {}
for _, pt in ipairs(pts_far_ridge) do far_poly_pts[#far_poly_pts + 1] = pt end
far_poly_pts[#far_poly_pts + 1] = {1000, 520}
far_poly_pts[#far_poly_pts + 1] = {395, 520}
m_far_ridge = poly(far_poly_pts, false):roughen(1.5, 25, 301)

work(m_far_ridge, {
  hand = "body",
  tool = "filbert 6",
  piles = {
    {p_far_peak, function(x, y) return clamp(1.0 - (y - 465) / 42, 0.2, 1.0) end},
    {p_far_base, function(x, y) return clamp((y - 478) / 38, 0.1, 0.9) end},
    {p_far_lit, function(x, y)
      -- Subtle moon/dusk light on ridge slopes facing (642, 268)
      local lit1 = clamp(1.0 - math.abs(x - 538) / 28, 0, 1) * clamp(1.0 - (y - 472) / 25, 0, 1)
      local lit2 = clamp(1.0 - math.abs(x - 712) / 32, 0, 1) * clamp(1.0 - (y - 462) / 28, 0, 1)
      local lit3 = clamp(1.0 - math.abs(x - 885) / 35, 0, 1) * clamp(1.0 - (y - 467) / 26, 0, 1)
      return (lit1 + lit2 + lit3) * 0.75
    end}
  },
  angle = function(x, y)
    return (x < 680) and 0.18 or -0.15
  end,
  coverage = 1.6,
  load = 0.80,
  fill = true,
  clip = m_far_ridge
})

-- Wait 3 days for far ridge to dry before laying mist in the highland valley and middle headlands in front
wait(3 * 24 * 60)

-- Gossamer sea/valley mist veil along the base of the far ridge and in the right-hand mountain saddle
p_mist_veil = pile{{"lead white", 9.5}, {"Naples yellow", 2.0}, {"pale smalt", 1.5}, {"rose madder", 0.25}, thinner=0.50, oil="walnut", name="mist_veil"}
local m_saddle_mist = poly({
  {695, 498}, {765, 488}, {845, 485}, {925, 488}, {985, 494},
  {960, 514}, {830, 516}, {715, 514}
}, true):soften(7)

stipple(m_saddle_mist, {
  pile = p_mist_veil,
  width = 2.8,
  coverage = function(x, y)
    return clamp((y - 482) / 26, 0.15, 0.85)
  end,
  pressure = {0.22, 0.42},
  feather = 0.6,
  clip = m_far_ridge:grow(2)
})

-- Middle-distance headlands (left and right)
p_mid_headland = pile{{"smalt", 4.5}, {"Prussian blue", 0.32}, {"raw umber", 1.1}, {"rose madder", 0.55}, {"lead white", 3.2}, medium=0.10, oil="walnut", name="mid_headland"}
p_mid_headland_lit = pile{{"smalt", 3.5}, {"pale smalt", 2.5}, {"rose madder", 0.45}, {"yellow ochre", 0.6}, {"lead white", 4.5}, medium=0.10, oil="walnut", name="mid_headland_lit"}

local mid_left_pts = {}
for _, pt in ipairs(pts_mid_left) do mid_left_pts[#mid_left_pts + 1] = pt end
mid_left_pts[#mid_left_pts + 1] = {382, 522}
mid_left_pts[#mid_left_pts + 1] = {0, 522}
m_mid_left = poly(mid_left_pts, false):roughen(1.5, 22, 302)

local mid_right_pts = {}
for _, pt in ipairs(pts_mid_right) do mid_right_pts[#mid_right_pts + 1] = pt end
mid_right_pts[#mid_right_pts + 1] = {1000, 522}
mid_right_pts[#mid_right_pts + 1] = {715, 522}
m_mid_right = poly(mid_right_pts, false):roughen(1.5, 22, 303)

work(m_mid_left, {
  hand = "body",
  tool = "filbert 6",
  piles = {
    {p_mid_headland, 0.70},
    {p_mid_headland_lit, function(x, y)
      return clamp((x - 120) / 220, 0, 0.65) * clamp(1.0 - (y - 478) / 32, 0.1, 1.0)
    end}
  },
  angle = 0.12,
  coverage = 1.65,
  load = 0.82,
  fill = true,
  clip = m_mid_left
})

work(m_mid_right, {
  hand = "body",
  tool = "filbert 6",
  piles = {
    {p_mid_headland, 0.70},
    {p_mid_headland_lit, function(x, y)
      return clamp(1.0 - (x - 730) / 200, 0.1, 0.75) * clamp(1.0 - (y - 484) / 28, 0.1, 1.0)
    end}
  },
  angle = -0.10,
  coverage = 1.65,
  load = 0.82,
  fill = true,
  clip = m_mid_right
})

-- Wait 3 days for headlands to dry before drifting shoreline mist and laying the sound
wait(3 * 24 * 60)

-- Drifting ribbon of evening mist along the water's edge of the far ridge and headlands
local m_shore_mist = ribbon({{340, 514}, {455, 513}, {565, 514}, {675, 513}, {755, 514}}, 7.0):soften(5.5)
stipple(m_shore_mist, {
  pile = p_mist_veil,
  width = 2.6,
  coverage = function(x, y)
    return 0.70 * clamp(1.0 - math.abs(y - 513.5) / 6.5, 0, 1)
  end,
  pressure = {0.20, 0.38},
  feather = 0.6
})

print("Distant ridge, headlands, and mist veils complete; drying at (550, 490)=" .. drying(550, 490))

--@ chunk 7
-- Wait 4 days so headlands and shoreline mist are completely dry
wait(4 * 24 * 60)
print("Drying at shoreline (550, 514)=" .. drying(550, 514))

-- Define global foreground rock masks so water can overlap their edges cleanly by 3 units
local crag_poly = {}
for _, pt in ipairs(pts_crag_top) do crag_poly[#crag_poly + 1] = pt end
crag_poly[#crag_poly + 1] = {0, 750}
m_crag = poly(crag_poly, false):roughen(2.0, 28, 401)

local rrock_poly = {}
for _, pt in ipairs(pts_right_rocks) do rrock_poly[#rrock_poly + 1] = pt end
rrock_poly[#rrock_poly + 1] = {1000, 750}
m_right_rocks = poly(rrock_poly, false):roughen(2.0, 24, 402)

m_water = rect(0, 516, 1000, 234) - m_crag:shrink(3) - m_right_rocks:shrink(3)

-- Campaign 3B: Water piles (Walnut oil, medium=0.12)
p_water_hor  = pile{{"lead white", 6.5}, {"Naples yellow", 2.8}, {"yellow ochre", 1.4}, {"rose madder", 0.50}, {"pale smalt", 2.8}, medium=0.12, oil="walnut", name="water_hor"}
p_water_mid  = pile{{"smalt", 4.5}, {"pale smalt", 3.0}, {"Prussian blue", 0.45}, {"yellow ochre", 1.0}, {"raw umber", 0.85}, {"lead white", 3.0}, medium=0.12, oil="walnut", name="water_mid"}
p_water_refl = pile{{"smalt", 5.0}, {"Prussian blue", 0.65}, {"raw umber", 1.8}, {"rose madder", 0.45}, {"lead white", 1.5}, medium=0.12, oil="walnut", name="water_refl"}
p_water_near = pile{{"Prussian blue", 1.1}, {"smalt", 4.0}, {"raw umber", 3.0}, {"yellow ochre", 0.9}, {"bone black", 0.85}, {"lead white", 0.9}, medium=0.12, oil="walnut", name="water_near"}
p_water_moon = pile{{"lead white", 7.5}, {"Naples yellow", 2.8}, {"pale smalt", 2.0}, {"yellow ochre", 0.55}, medium=0.12, oil="walnut", name="water_moon"}

-- Lay the calm sound in horizontal strokes
work(m_water, {
  hand = "broad",
  tool = "filbert 16",
  piles = {
    {p_water_hor, function(x, y)
      return clamp(1.0 - (y - 516) / 38, 0, 1) * clamp(1.0 - math.abs(x - 560) / 320, 0.2, 1.0)
    end},
    {p_water_refl, function(x, y)
      local under_left  = clamp(1.0 - (x - 180) / 200, 0, 1) * clamp(1.0 - (y - 516) / 55, 0, 1)
      local under_right = clamp((x - 710) / 180, 0, 1) * clamp(1.0 - (y - 516) / 65, 0, 1)
      return clamp(under_left + under_right, 0, 1)
    end},
    {p_water_mid, function(x, y)
      return clamp(1.0 - math.abs(y - 585) / 65, 0.1, 1.0)
    end},
    {p_water_near, function(x, y)
      return clamp((y - 595) / 95, 0, 1)
    end},
    {p_water_moon, function(x, y)
      local half_w = 22 + (y - 516) * 0.22
      local dx = math.abs(x - MOON_X)
      return clamp(1.0 - dx / half_w, 0, 1) * clamp(1.0 - (y - 516) / 175, 0.15, 0.90)
    end}
  },
  angle = 0,
  coverage = 1.70,
  load = 0.85,
  fill = true,
  clip = m_water
})

-- Horizontal blend across the sound so the reflections lie flat and still
blend(m_water:shrink(2), {
  angle = 0,
  coverage = 0.45,
  clip = m_water
})

-- Wait 4 days for the water base to dry before laying crisp moonpath glints and distant sailboats
wait(4 * 24 * 60)
print("Water base drying at (642, 575)=" .. drying(642, 575))

-- Delicate darker ripple lines and luminous moonpath glints across the sound
p_ripple_dark = pile{{"Prussian blue", 0.9}, {"smalt", 3.5}, {"raw umber", 2.2}, {"lead white", 1.2}, medium=0.15, oil="walnut", name="ripple_dark"}
p_moon_glint  = pile{{"lead white", 13.0}, {"Naples yellow", 3.0}, {"yellow ochre", 0.25}, blot=0.15, oil="walnut", name="moon_glint"}
p_moon_glint_soft = pile{{"lead white", 9.5}, {"Naples yellow", 2.6}, {"pale smalt", 1.5}, medium=0.10, oil="walnut", name="moon_glint_soft"}

-- Subtle horizontal ripple modulation across middle and nearer water
b_rip = brush{kind="filbert", width=4, point=0.4, stiffness=0.5}
local ripple_ys = {524, 531, 539, 548, 558, 569, 582, 596, 612, 629, 648, 668}
for idx, ry in ipairs(ripple_ys) do
  -- Darker quiet ripple wave outside the moonpath core
  b_rip:reload(p_ripple_dark, 0.55)
  local x_left = 390 + (idx * 23) % 140
  if m_water:at(x_left, ry) > 0.5 then
    b_rip:stroke({{x_left, ry}, {x_left + 35 + (idx % 3) * 12, ry}}, {pressure={0.22, 0.18}, orient=0, clip=m_water})
  end
  local x_right = 700 + (idx * 31) % 180
  if m_water:at(x_right, ry) > 0.5 then
    b_rip:stroke({{x_right, ry}, {x_right + 40 + (idx % 4) * 10, ry}}, {pressure={0.24, 0.18}, orient=0, clip=m_water})
  end
end

-- Moonpath shimmer: soft secondary glints and crisp primary glints down x ≈ 642
b_glint = brush{kind="round", width=2.4, point=0.85, stiffness=0.55}
local glint_rows = {
  {518, 632, 652, 0.45}, {521, 626, 656, 0.42}, {525, 635, 650, 0.48},
  {529, 622, 646, 0.38}, {530, 648, 664, 0.38}, {534, 628, 655, 0.46},
  {539, 618, 642, 0.36}, {540, 644, 668, 0.40}, {545, 630, 658, 0.48},
  {551, 615, 645, 0.38}, {553, 646, 672, 0.36}, {558, 626, 654, 0.44},
  {565, 634, 662, 0.42}, {572, 618, 648, 0.38}, {579, 630, 660, 0.40},
  {587, 622, 652, 0.36}, {596, 635, 664, 0.35}, {606, 625, 654, 0.34},
  {617, 632, 658, 0.32}, {629, 636, 656, 0.30}, {642, 638, 654, 0.28}
}
for _, g in ipairs(glint_rows) do
  local gy, gx0, gx1, gp = g[1], g[2], g[3], g[4]
  b_glint:reload(p_moon_glint_soft, 0.65)
  b_glint:stroke({{gx0 - 5, gy}, {gx1 + 5, gy}}, {pressure={gp * 0.6, gp * 0.5}, orient=0, clip=m_water})
  b_glint:reload(p_moon_glint, 0.75)
  b_glint:stroke({{gx0, gy}, {(gx0 + gx1) * 0.5, gy}, {gx1, gy}}, {pressure={gp * 0.5, gp, gp * 0.4}, orient=0, clip=m_water})
end

-- Two distant twilight sailboats on the calm water (measuring the vastness of the sound)
p_sail_dark = pile{{"raw umber", 3.5}, {"Prussian blue", 0.8}, {"bone black", 1.2}, {"rose madder", 0.3}, {"lead white", 0.8}, medium=0.10, oil="walnut", name="sail_dark"}
p_sail_lit  = pile{{"lead white", 4.0}, {"yellow ochre", 1.8}, {"raw umber", 2.0}, {"rose madder", 0.35}, medium=0.10, oil="walnut", name="sail_lit"}

b_fine = brush{kind="round", width=1.8, point=0.95, stiffness=0.6}
-- Farther sailboat at (558, 520)
b_fine:reload(p_sail_dark, 0.75)
b_fine:stroke({{551, 520}, {565, 520}}, {pressure={0.35, 0.35}}) -- hull
b_fine:stroke({{558, 520}, {558, 503}}, {pressure={0.28, 0.14}}) -- mast
b_fine:stroke({{558, 504}, {553, 518}, {558, 518}}, {pressure={0.32, 0.28}}) -- shaded foresail
b_fine:reload(p_sail_lit, 0.65)
b_fine:stroke({{558, 505}, {563, 517}, {559, 518}}, {pressure={0.30, 0.25}}) -- moon-touched mainsail
-- Subtle water reflection beneath far boat
b_fine:reload(p_sail_dark, 0.45)
b_fine:stroke({{554, 522}, {562, 522}}, {pressure={0.20, 0.18}})
b_fine:stroke({{556, 524}, {560, 524}}, {pressure={0.16, 0.14}})

-- Second sailboat slightly closer on the right at (718, 548)
b_fine:reload(p_sail_dark, 0.80)
b_fine:stroke({{708, 548}, {729, 548}}, {pressure={0.42, 0.40}}) -- hull
b_fine:stroke({{718, 548}, {718, 523}}, {pressure={0.32, 0.16}}) -- mast
b_fine:stroke({{718, 525}, {727, 545}, {719, 545}}, {pressure={0.36, 0.32}}) -- dark mainsail away from moon
b_fine:reload(p_sail_lit, 0.70)
b_fine:stroke({{717, 526}, {711, 545}, {717, 545}}, {pressure={0.34, 0.28}}) -- moon-facing jib/foresail
-- Subtle broken reflection beneath second boat
b_fine:reload(p_sail_dark, 0.50)
b_fine:stroke({{711, 550}, {725, 550}}, {pressure={0.24, 0.22}})
b_fine:stroke({{714, 553}, {722, 553}}, {pressure={0.18, 0.16}})
b_fine:stroke({{716, 556}, {720, 556}}, {pressure={0.14, 0.12}})

print("Sound, moonpath glints, and distant sails complete")

--@ chunk 8
-- Wait 3 more days so the water is completely dry before laying the foreground crags
wait(3 * 24 * 60)
print("Water drying at crag edge (550, 620)=" .. drying(550, 620))

-- Campaign 4: Foreground Rocky Promontory and Shoreline Boulders
-- Step 1: Lean, deep dark rock foundation across m_crag and m_right_rocks
p_crag_dark = pile{{"raw umber", 4.5}, {"bone black", 2.8}, {"Prussian blue", 0.8}, {"yellow ochre", 0.8}, turps=0.40, oil="walnut", name="crag_dark"}

work(m_crag, {
  hand = "body",
  tool = "filbert 12",
  pile = p_crag_dark,
  angle = 0.35,
  coverage = 1.75,
  load = 0.88,
  fill = true,
  clip = m_crag
})

work(m_right_rocks, {
  hand = "body",
  tool = "filbert 10",
  pile = p_crag_dark,
  angle = -0.25,
  coverage = 1.75,
  load = 0.88,
  fill = true,
  clip = m_right_rocks
})

-- Wait 5 full days so the dark rock foundation is 100% dry (based on Scratch Trial 2 lesson)
wait(5 * 24 * 60)
print("Crag dark foundation drying at (300, 650)=" .. drying(300, 650))

-- Step 2: Knife rock facet piles (proven in Scratch Trial 2 Method 1)
p_rock_slate_lit = pile{{"smalt", 3.5}, {"pale smalt", 3.0}, {"raw umber", 2.2}, {"yellow ochre", 1.2}, {"lead white", 4.2}, blot=0.20, oil="walnut", name="rock_slate_lit"}
p_rock_moon_edge = pile{{"pale smalt", 3.5}, {"lead white", 6.0}, {"Naples yellow", 1.6}, {"raw umber", 1.5}, blot=0.25, oil="walnut", name="rock_moon_edge"}
p_rock_slate_mid = pile{{"smalt", 4.0}, {"raw umber", 3.2}, {"bone black", 1.2}, {"yellow ochre", 1.0}, {"lead white", 2.0}, medium=0.10, oil="walnut", name="rock_slate_mid"}
p_rock_rust      = pile{{"red earth", 3.0}, {"yellow ochre", 2.5}, {"raw umber", 3.0}, {"bone black", 0.8}, medium=0.15, oil="walnut", name="rock_rust"}
p_rock_deep_cleft= pile{{"bone black", 3.2}, {"raw umber", 3.5}, {"Prussian blue", 1.0}, medium=0.15, oil="walnut", name="rock_deep_cleft"}
p_rock_moss      = pile{{"yellow ochre", 3.5}, {"Prussian blue", 0.55}, {"raw umber", 2.5}, {"Naples yellow", 1.5}, {"green earth", 2.0}, blot=0.15, oil="walnut", name="rock_moss"}
p_rock_lichen    = pile{{"lead white", 3.5}, {"yellow ochre", 2.5}, {"green earth", 3.0}, {"raw umber", 1.8}, blot=0.20, oil="walnut", name="rock_lichen"}

local flat8 = {kind="flat", width=8, point=0, stiffness=0.7}
local flat6 = {kind="flat", width=6, point=0, stiffness=0.7}

-- Upper sky/moon-lit horizontal and east-facing rock facets (leaving dark fissures between facets)
local lit_facets = {
  -- Facet L1: Left high crag ledge under the wayside cross
  {pts={{0, 548}, {45, 540}, {95, 544}, {145, 536}, {168, 562}, {85, 568}, {0, 572}}, angle=0.08, seed=601},
  -- Facet L2: Root-clasped boulder crown supporting the ancient oak
  {pts={{198, 548}, {250, 542}, {305, 546}, {352, 558}, {315, 580}, {232, 576}}, angle=0.06, seed=602},
  -- Facet L3: Promontory table rock where the watcher stands
  {pts={{398, 566}, {438, 562}, {478, 565}, {496, 584}, {432, 592}, {382, 582}}, angle=0.04, seed=603},
  -- Facet L4: Stepping shoreline slab below the watcher
  {pts={{492, 596}, {538, 612}, {582, 634}, {545, 648}, {488, 628}}, angle=0.32, seed=604},
  -- Facet L5: Water's-edge spit slab
  {pts={{578, 638}, {625, 654}, {658, 668}, {618, 678}, {565, 660}}, angle=0.25, seed=605},
  -- Facet L6: Lower middle-left shelf
  {pts={{88, 592}, {172, 584}, {190, 616}, {112, 626}}, angle=0.10, seed=606},
  -- Facet L7: Lower center boulder table
  {pts={{268, 628}, {358, 622}, {418, 626}, {382, 658}, {282, 662}}, angle=0.08, seed=607},
  -- Facet L8: Foreground shore shelf
  {pts={{442, 654}, {518, 662}, {578, 688}, {512, 708}, {432, 688}}, angle=0.15, seed=608},
  -- Facet R1 & R2: Lower-right shoreline boulders catching the moonpath
  {pts={{758, 698}, {818, 692}, {858, 704}, {798, 716}}, angle=-0.12, seed=609},
  {pts={{862, 676}, {915, 672}, {962, 680}, {998, 676}, {958, 698}, {878, 696}}, angle=-0.08, seed=610}
}

for _, f in ipairs(lit_facets) do
  local mf = poly(f.pts, false):roughen(1.8, 20, f.seed)
  work(mf, {
    hand = "body",
    tool = flat8,
    piles = {
      {p_rock_slate_lit, 0.72},
      {p_rock_moon_edge, function(x, y)
        return clamp((x - 320) / 450, 0.1, 0.85)
      end}
    },
    angle = f.angle,
    coverage = 1.45,
    load = 0.78,
    clip = m_crag + m_right_rocks
  })
end

-- Steep vertical and rusted side facets of the boulders
local side_facets = {
  {pts={{0, 574}, {82, 572}, {68, 648}, {0, 660}}, pile=p_rock_rust, angle=1.35, seed=611},
  {pts={{168, 564}, {228, 578}, {242, 636}, {188, 628}}, pile=p_rock_slate_mid, angle=1.28, seed=612},
  {pts={{236, 580}, {312, 584}, {356, 618}, {264, 624}}, pile=p_rock_rust, angle=1.20, seed=613},
  {pts={{320, 582}, {380, 584}, {426, 618}, {362, 618}}, pile=p_rock_slate_mid, angle=1.18, seed=614},
  {pts={{432, 594}, {488, 590}, {492, 634}, {428, 622}}, pile=p_rock_rust, angle=1.32, seed=615},
  {pts={{105, 630}, {192, 622}, {238, 695}, {148, 718}, {68, 685}}, pile=p_rock_slate_mid, angle=1.25, seed=616},
  {pts={{278, 666}, {380, 662}, {388, 745}, {252, 745}}, pile=p_rock_rust, angle=1.38, seed=617},
  {pts={{392, 662}, {438, 658}, {505, 712}, {485, 748}, {390, 748}}, pile=p_rock_slate_mid, angle=1.30, seed=618},
  {pts={{518, 708}, {588, 692}, {642, 725}, {665, 748}, {515, 748}}, pile=p_rock_slate_mid, angle=1.15, seed=619},
  {pts={{712, 748}, {728, 718}, {795, 718}, {845, 748}}, pile=p_rock_rust, angle=1.22, seed=620},
  {pts={{855, 715}, {955, 700}, {998, 702}, {998, 748}, {850, 748}}, pile=p_rock_slate_mid, angle=1.18, seed=621}
}

for _, sf in ipairs(side_facets) do
  local msf = poly(sf.pts, false):roughen(1.8, 22, sf.seed)
  work(msf, {
    hand = "body",
    tool = flat6,
    pile = sf.pile,
    angle = sf.angle,
    coverage = 1.35,
    load = 0.75,
    clip = m_crag + m_right_rocks
  })
end

-- Step 3: Reinforce deep geological fissures and vertical rusted veins with a pointed round
b_fissure = brush{kind="round", width=3.0, point=0.9, stiffness=0.6}
local fissures = {
  {{60, 542}, {88, 585}, {72, 645}, {40, 710}},
  {{145, 536}, {175, 578}, {195, 635}, {165, 710}},
  {{245, 584}, {265, 640}, {240, 720}},
  {{310, 588}, {365, 622}, {390, 685}, {375, 750}},
  {{478, 565}, {485, 602}, {495, 635}, {525, 695}, {510, 750}},
  {{765, 698}, {805, 722}, {855, 715}, {915, 672}}
}
for _, fis in ipairs(fissures) do
  b_fissure:reload(p_rock_deep_cleft, 0.80)
  b_fissure:stroke(fis, {pressure={0.45, 0.65, 0.35}, clip=m_crag + m_right_rocks})
end

-- Step 4: Selective light knife grazes along the moon-facing rock ridges (proven in Scratch Trial 2)
k_ridge = knife{width = 14}
local ridge_grazes = {
  {{402, 566}, {442, 563}, {478, 566}},
  {{498, 594}, {542, 614}, {582, 635}},
  {{584, 639}, {625, 655}, {656, 668}},
  {{762, 699}, {818, 693}, {855, 698}},
  {{868, 676}, {918, 673}, {962, 680}}
}
for _, rg in ipairs(ridge_grazes) do
  k_ridge:load(p_rock_moon_edge, 0.60)
  k_ridge:lay(rg, {pressure={0.32, 0.18}, lift=0.15})
end

-- Step 5: Northern moss and pale crustose lichen stippled in sheltered rock hollows and root ledges
local moss_zones = {
  ellipse(115, 558, 38, 12):soften(4),
  ellipse(275, 578, 55, 16):soften(5),
  ellipse(215, 625, 35, 14):soften(4),
  ellipse(335, 624, 42, 14):soften(5),
  ellipse(455, 648, 36, 12):soften(4),
  ellipse(145, 685, 48, 18):soften(5)
}
for idx, mz in ipairs(moss_zones) do
  stipple(mz, {
    pile = p_rock_moss,
    width = 2.6,
    coverage = 0.85,
    pressure = {0.28, 0.48},
    feather = 0.4,
    seed = 630 + idx,
    clip = m_crag
  })
  stipple(mz:shrink(4), {
    pile = p_rock_lichen,
    width = 2.0,
    coverage = 0.35,
    pressure = {0.22, 0.38},
    feather = 0.5,
    seed = 640 + idx,
    clip = m_crag
  })
end

print("Foreground rocky promontory and shoreline boulders complete")

--@ chunk 9
-- Campaign 4B: Wait 10 days for complete drying across all thick rock facets, then interlock and unify the foreground rock mass
wait(10 * 24 * 60)
print("Drying at promontory (300, 650)=" .. drying(300, 650) .. ", (450, 580)=" .. drying(450, 580))

p_rock_bridge_cool = pile{{"smalt", 3.8}, {"raw umber", 3.0}, {"yellow ochre", 1.1}, {"bone black", 1.0}, {"lead white", 2.6}, medium=0.12, oil="walnut", name="rock_bridge_cool"}
p_rock_bridge_warm = pile{{"raw umber", 3.5}, {"yellow ochre", 2.2}, {"red earth", 1.6}, {"bone black", 1.2}, {"lead white", 1.4}, medium=0.12, oil="walnut", name="rock_bridge_warm"}
p_rock_cleft_glaze = pile{{"raw umber", 4.0}, {"Prussian blue", 1.4}, {"bone black", 2.0}, {"rose madder", 0.4}, medium=0.55, oil="walnut", name="rock_cleft_glaze"}
p_rock_crest_highlight = pile{{"lead white", 6.5}, {"pale smalt", 3.2}, {"Naples yellow", 1.8}, {"raw umber", 1.4}, blot=0.20, oil="walnut", name="rock_crest_hi"}

local flat7 = {kind="flat", width=7, point=0, stiffness=0.65}

-- Interlocking transition planes bridging the gaps across the promontory
local bridge_planes = {
  {pts={{65, 558}, {195, 552}, {215, 595}, {75, 602}}, pile=p_rock_bridge_warm, angle=0.18, seed=651},
  {pts={{175, 575}, {265, 572}, {285, 635}, {175, 638}}, pile=p_rock_bridge_cool, angle=0.95, seed=652},
  {pts={{295, 568}, {415, 572}, {435, 632}, {305, 632}}, pile=p_rock_bridge_warm, angle=0.85, seed=653},
  {pts={{410, 582}, {515, 588}, {545, 655}, {425, 658}}, pile=p_rock_bridge_cool, angle=0.65, seed=654},
  {pts={{45, 635}, {165, 625}, {185, 745}, {25, 748}}, pile=p_rock_bridge_warm, angle=1.15, seed=655},
  {pts={{180, 635}, {295, 632}, {285, 748}, {175, 748}}, pile=p_rock_bridge_cool, angle=1.22, seed=656},
  {pts={{355, 645}, {465, 648}, {455, 748}, {350, 748}}, pile=p_rock_bridge_warm, angle=1.18, seed=657},
  {pts={{535, 645}, {635, 662}, {665, 748}, {520, 748}}, pile=p_rock_bridge_cool, angle=0.75, seed=658},
  {pts={{740, 702}, {885, 682}, {920, 748}, {720, 748}}, pile=p_rock_bridge_cool, angle=0.45, seed=659}
}

for _, bp in ipairs(bridge_planes) do
  local mbp = poly(bp.pts, false):roughen(2.2, 24, bp.seed):soften(2.0)
  work(mbp, {
    hand = "body",
    tool = flat7,
    pile = bp.pile,
    angle = bp.angle,
    coverage = 1.25,
    load = 0.72,
    edge = "soft",
    clip = m_crag + m_right_rocks
  })
end

-- Deep transparent shadow glaze over the lower-left and lower-center boulder bases to anchor the foreground weight
local m_lower_shadow = poly({
  {0, 645}, {140, 655}, {275, 675}, {410, 685}, {545, 705}, {675, 735},
  {680, 750}, {0, 750}
}, true):soften(18)

work(m_lower_shadow, {
  hand = "glaze",
  pile = p_rock_cleft_glaze,
  angle = 0.15,
  coverage = 0.85,
  load = 0.65,
  clip = m_crag
})

-- Crisp moonlit sky-facing bevels along the top contour of the promontory boulders
b_bevel = brush{kind="flat", width=4.5, point=0, stiffness=0.7}
local top_bevels = {
  {{4, 548}, {45, 540}, {95, 544}, {145, 536}},
  {{198, 548}, {250, 542}, {305, 546}, {352, 558}},
  {{398, 566}, {438, 562}, {478, 565}},
  {{496, 594}, {540, 612}, {582, 634}},
  {{584, 638}, {625, 654}, {658, 668}},
  {{758, 698}, {818, 692}, {862, 676}, {915, 672}, {962, 680}}
}
for _, tb in ipairs(top_bevels) do
  b_bevel:reload(p_rock_crest_highlight, 0.72)
  b_bevel:stroke(tb, {pressure={0.42, 0.28}, orient="along", clip=m_crag + m_right_rocks})
end

-- Re-accent the deepest geological cracks so they cut incisively between the now-unified rock blocks
fissures_global = {
  {{60, 542}, {88, 585}, {72, 645}, {40, 710}},
  {{145, 536}, {175, 578}, {195, 635}, {165, 710}},
  {{245, 584}, {265, 640}, {240, 720}},
  {{310, 588}, {365, 622}, {390, 685}, {375, 750}},
  {{478, 565}, {485, 602}, {495, 635}, {525, 695}, {510, 750}},
  {{765, 698}, {805, 722}, {855, 715}, {915, 672}}
}
for _, fis in ipairs(fissures_global) do
  b_fissure:reload(p_rock_deep_cleft, 0.85)
  b_fissure:stroke(fis, {pressure={0.50, 0.70, 0.35}, clip=m_crag + m_right_rocks})
end

print("Campaign 4B rock unification complete")

--@ chunk 10
-- Wait 6 days so Campaign 4B rock glazes and bevels are completely dry
wait(6 * 24 * 60)
print("Drying at oak root boulder (270, 560)=" .. drying(270, 560) .. ", watcher rock (456, 565)=" .. drying(456, 565))

-- Campaign 5A: Dark structural silhouette of the Ancient Oak (Quercus robur), Wayside Cross, and Solitary Watcher
p_bark_dark = pile{{"raw umber", 4.5}, {"bone black", 3.2}, {"Prussian blue", 0.85}, {"red earth", 0.7}, oil="walnut", name="bark_dark"}
p_twig_flow = pile{{"raw umber", 4.5}, {"bone black", 3.2}, {"Prussian blue", 0.8}, medium=0.18, oil="walnut", name="twig_flow"}

-- 1. Gnarled lower trunk and root buttresses clasping the boulder crown (y = 312..588)
m_oak_trunk = poly({
  {210, 584}, {232, 564}, {244, 538}, {250, 492}, {252, 435}, {246, 372}, {238, 318},
  {262, 310}, {292, 315}, {284, 368}, {286, 432}, {284, 495}, {292, 548}, {314, 576},
  {332, 588}, {302, 582}, {282, 562}, {268, 578}, {252, 564}, {232, 582}
}, false):roughen(1.5, 18, 710)

work(m_oak_trunk, {
  hand = "body",
  tool = "filbert 6",
  pile = p_bark_dark,
  angle = 1.52,
  coverage = 1.85,
  load = 0.88,
  fill = true,
  clip = m_oak_trunk
})

-- Root claws gripping the rock crevices
b_root = brush{kind="round", width=5.5, point=0.90, stiffness=0.65}
local root_paths = {
  {{246, 548, 0.85}, {228, 568, 0.65}, {206, 584, 0.35}, {192, 594, 0.12}},
  {{264, 552, 0.75}, {266, 574, 0.50}, {258, 592, 0.20}},
  {{288, 546, 0.85}, {308, 568, 0.60}, {328, 584, 0.32}, {342, 592, 0.10}},
  {{254, 555, 0.65}, {240, 578, 0.40}, {234, 595, 0.14}}
}
for _, rp in ipairs(root_paths) do
  b_root:reload(p_bark_dark, 0.85)
  b_root:gesture(rp)
end

-- 2. Primary Boughs (Order 1) with collar swelling and conservation of area
b_bough_lg = brush{kind="round", width=11.0, point=0.90, stiffness=0.65}
b_bough_md = brush{kind="round", width=7.5, point=0.92, stiffness=0.65}
b_branch   = brush{kind="round", width=4.5, point=0.94, stiffness=0.60}
b_twig     = brush{kind="rigger", width=2.2, point=0.98, stiffness=0.55}
b_fine_twig= brush{kind="rigger", width=1.4, point=0.99, stiffness=0.55}

-- Primary Boughs list (saved globally so Campaign 5B can add moonlit bark rims along the exact paths)
oak_boughs = {
  -- Bough 1: Lower-left spreading limb
  {brush=b_bough_md, pts={{252, 362, 0.92}, {218, 348, 0.75}, {178, 342, 0.58}, {136, 330, 0.40}, {96, 322, 0.24}, {64, 314, 0.10}}},
  -- Bough 2: Main West/Left twisting limb
  {brush=b_bough_lg, pts={{248, 326, 0.95}, {212, 294, 0.78}, {168, 274, 0.62}, {124, 244, 0.45}, {84, 226, 0.26}, {52, 214, 0.10}}},
  -- Bough 3: Upper-left ascending limb
  {brush=b_bough_lg, pts={{260, 318, 0.92}, {240, 260, 0.75}, {206, 204, 0.58}, {182, 150, 0.40}, {152, 108, 0.22}, {128, 82, 0.08}}},
  -- Bough 4: High central-right retrenchment stag-horn leader (dead bare heartwood)
  {brush=b_bough_lg, pts={{274, 315, 0.95}, {286, 250, 0.78}, {278, 190, 0.60}, {294, 136, 0.42}, {318, 88, 0.24}, {336, 62, 0.06}}},
  -- Bough 5: Main East/Right spreading limb reaching toward the moon
  {brush=b_bough_lg, pts={{286, 322, 0.95}, {332, 286, 0.76}, {378, 268, 0.58}, {425, 240, 0.38}, {468, 226, 0.18}, {496, 218, 0.07}}},
  -- Bough 6: Lower-right horizontal crooked limb over the promontory
  {brush=b_bough_md, pts={{282, 368, 0.90}, {328, 352, 0.72}, {376, 356, 0.52}, {422, 344, 0.34}, {458, 346, 0.16}, {484, 340, 0.06}}}
}

for _, b in ipairs(oak_boughs) do
  b.brush:reload(p_bark_dark, 0.90)
  b.brush:gesture(b.pts)
end

-- 3. Secondary & Tertiary Sympodial Branches (Orders 2 & 3)
oak_sec_branches = {
  -- Off Bough 1 (lower-left)
  {{178, 342, 0.65}, {152, 364, 0.45}, {120, 376, 0.26}, {92, 382, 0.10}},
  {{136, 330, 0.55}, {112, 304, 0.36}, {82, 290, 0.18}, {58, 282, 0.06}},
  -- Off Bough 2 (mid-left)
  {{212, 294, 0.68}, {182, 308, 0.46}, {148, 302, 0.26}, {118, 294, 0.10}},
  {{168, 274, 0.72}, {152, 226, 0.52}, {120, 184, 0.34}, {90, 152, 0.16}, {68, 134, 0.06}},
  {{124, 244, 0.58}, {96, 256, 0.38}, {66, 252, 0.18}, {42, 246, 0.06}},
  {{152, 226, 0.48}, {128, 208, 0.30}, {98, 198, 0.14}},
  -- Off Bough 3 (upper-left)
  {{240, 260, 0.68}, {212, 242, 0.48}, {184, 232, 0.28}, {158, 218, 0.10}},
  {{206, 204, 0.70}, {232, 154, 0.50}, {220, 106, 0.32}, {198, 76, 0.14}, {182, 58, 0.05}},
  {{182, 150, 0.55}, {154, 142, 0.36}, {124, 128, 0.18}, {102, 118, 0.06}},
  {{232, 154, 0.48}, {252, 128, 0.30}, {246, 98, 0.12}},
  -- Off Bough 4 (high stag-horn dead leader — angular broken forks)
  {{286, 250, 0.68}, {314, 218, 0.46}, {336, 186, 0.24}, {348, 164, 0.08}},
  {{278, 190, 0.65}, {256, 142, 0.45}, {264, 96, 0.24}, {258, 70, 0.06}},
  {{294, 136, 0.52}, {324, 118, 0.32}, {346, 98, 0.12}},
  {{318, 88, 0.40}, {304, 66, 0.18}},
  -- Off Bough 5 (main right limb)
  {{332, 286, 0.72}, {354, 234, 0.52}, {390, 190, 0.34}, {426, 160, 0.18}, {452, 142, 0.06}},
  {{354, 234, 0.52}, {338, 196, 0.34}, {352, 162, 0.16}},
  {{378, 268, 0.64}, {408, 282, 0.44}, {444, 276, 0.24}, {474, 268, 0.08}},
  {{425, 240, 0.54}, {448, 206, 0.34}, {478, 186, 0.16}, {502, 174, 0.05}},
  -- Off Bough 6 (lower-right limb)
  {{328, 352, 0.62}, {352, 326, 0.42}, {384, 314, 0.22}, {410, 304, 0.08}},
  {{376, 356, 0.58}, {404, 378, 0.38}, {438, 384, 0.20}, {464, 380, 0.06}},
  {{422, 344, 0.48}, {448, 324, 0.28}, {476, 316, 0.10}}
}

for _, sb in ipairs(oak_sec_branches) do
  b_branch:reload(p_bark_dark, 0.85)
  b_branch:gesture(sb)
end

-- 4. Fine Crooked Oak Twigs (Orders 4 & 5) using p_twig_flow (medium=0.18, reloaded every 2 strokes)
local twig_strokes = {
  -- Left and lower-left twig net
  {{64, 314, 0.45}, {44, 306, 0.25}, {28, 302, 0.08}},
  {{96, 322, 0.40}, {76, 334, 0.22}, {56, 338, 0.06}},
  {{92, 382, 0.42}, {70, 390, 0.22}, {52, 386, 0.06}},
  {{58, 282, 0.40}, {38, 274, 0.20}, {24, 268, 0.05}},
  {{52, 214, 0.45}, {34, 204, 0.24}, {18, 198, 0.06}},
  {{84, 226, 0.42}, {64, 212, 0.22}, {46, 196, 0.06}},
  {{42, 246, 0.38}, {24, 242, 0.18}},
  -- Upper-left crown twig net
  {{68, 134, 0.45}, {48, 122, 0.25}, {32, 114, 0.06}},
  {{90, 152, 0.42}, {74, 164, 0.22}, {56, 168, 0.06}},
  {{98, 198, 0.40}, {78, 188, 0.22}, {62, 182, 0.06}},
  {{128, 82, 0.45}, {108, 68, 0.25}, {92, 58, 0.06}},
  {{152, 108, 0.42}, {138, 92, 0.22}, {126, 74, 0.06}},
  {{102, 118, 0.40}, {82, 108, 0.22}, {66, 102, 0.06}},
  {{182, 58, 0.42}, {168, 46, 0.22}, {156, 38, 0.05}},
  {{198, 76, 0.40}, {212, 62, 0.22}, {222, 50, 0.05}},
  {{246, 98, 0.38}, {260, 82, 0.20}, {268, 68, 0.05}},
  -- Stag-horn upper bare twigs (jagged, angular)
  {{258, 70, 0.42}, {246, 54, 0.20}},
  {{336, 62, 0.45}, {348, 48, 0.20}},
  {{346, 98, 0.40}, {362, 86, 0.20}, {372, 76, 0.06}},
  {{348, 164, 0.42}, {364, 148, 0.22}, {376, 138, 0.06}},
  -- Right and upper-right crown twig net ( silhouetted against the moon-glow sky!)
  {{452, 142, 0.45}, {472, 128, 0.25}, {488, 118, 0.06}},
  {{426, 160, 0.42}, {444, 148, 0.24}, {462, 144, 0.06}},
  {{390, 190, 0.42}, {408, 174, 0.22}, {422, 166, 0.06}},
  {{352, 162, 0.40}, {366, 144, 0.20}, {378, 132, 0.06}},
  {{502, 174, 0.45}, {522, 164, 0.25}, {538, 158, 0.06}},
  {{478, 186, 0.40}, {496, 192, 0.22}, {512, 190, 0.06}},
  {{496, 218, 0.45}, {518, 210, 0.26}, {536, 206, 0.08}},
  {{468, 226, 0.42}, {488, 234, 0.24}, {506, 232, 0.06}},
  {{474, 268, 0.42}, {496, 262, 0.24}, {514, 264, 0.06}},
  {{444, 276, 0.38}, {462, 286, 0.20}, {478, 288, 0.06}},
  -- Lower-right bough twig net
  {{410, 304, 0.40}, {428, 296, 0.22}, {444, 292, 0.06}},
  {{476, 316, 0.42}, {496, 308, 0.24}, {512, 306, 0.06}},
  {{484, 340, 0.45}, {506, 334, 0.25}, {524, 336, 0.06}},
  {{458, 346, 0.40}, {478, 354, 0.22}, {494, 356, 0.06}},
  {{464, 380, 0.42}, {484, 376, 0.22}, {500, 380, 0.06}},
  {{438, 384, 0.38}, {454, 394, 0.20}, {468, 398, 0.06}}
}

for idx, ts in ipairs(twig_strokes) do
  if idx % 2 == 1 then b_twig:reload(p_twig_flow, 0.85) end
  b_twig:gesture(ts)
end

-- Extra-fine terminal twiglets on the outer crown edges
local fine_twiglets = {
  {{44, 306, 0.35}, {32, 296, 0.15}, {22, 290, 0.04}},
  {{70, 390, 0.35}, {58, 398, 0.15}, {46, 402, 0.04}},
  {{48, 122, 0.35}, {36, 110, 0.15}, {26, 102, 0.04}},
  {{108, 68, 0.35}, {98, 54, 0.15}, {88, 44, 0.04}},
  {{472, 128, 0.35}, {484, 116, 0.15}, {494, 108, 0.04}},
  {{522, 164, 0.35}, {536, 152, 0.15}, {548, 146, 0.04}},
  {{518, 210, 0.35}, {534, 200, 0.15}, {546, 196, 0.04}},
  {{496, 262, 0.35}, {512, 254, 0.15}, {524, 250, 0.04}},
  {{506, 334, 0.35}, {522, 326, 0.15}, {534, 322, 0.04}},
  {{484, 376, 0.35}, {498, 368, 0.15}, {510, 364, 0.04}}
}
for idx, ft in ipairs(fine_twiglets) do
  if idx % 2 == 1 then b_fine_twig:reload(p_twig_flow, 0.85) end
  b_fine_twig:gesture(ft)
end

-- 5. Weathered Wooden Wayside Cross on the left crag (x ≈ 126..142, y = 466..546)
b_cross = brush{kind="flat", width=3.6, point=0, stiffness=0.7}
b_cross:reload(p_bark_dark, 0.88)
b_cross:stroke({{126, 546}, {134, 506}, {142, 466}}, {pressure={0.65, 0.55}, orient="along"})
b_cross:reload(p_bark_dark, 0.85)
b_cross:stroke({{114, 485}, {138, 489}, {154, 493}}, {pressure={0.55, 0.50}, orient="along"})
-- Small wooden diagonal weather-hood over the crossbeam and base brace
b_twig:reload(p_twig_flow, 0.80)
b_twig:stroke({{141, 472}, {114, 485}}, {pressure={0.35, 0.30}})
b_twig:stroke({{141, 472}, {154, 493}}, {pressure={0.35, 0.30}})
b_twig:stroke({{120, 544}, {131, 524}}, {pressure={0.45, 0.35}})

-- 6. Solitary Watcher (Rückenfigur) standing on the promontory boulder at (456, 486..566)
p_coat_dark = pile{{"bone black", 3.5}, {"Prussian blue", 1.2}, {"raw umber", 2.5}, oil="walnut", name="coat_dark"}
p_hair_cap  = pile{{"bone black", 3.0}, {"raw umber", 3.0}, {"red earth", 0.6}, oil="walnut", name="hair_cap"}

-- Coat silhouette (fitted shoulders and waist, long skirted *Altdeutsche Tracht* coat reaching to y=548)
m_watcher_coat = poly({
  {449, 501}, {463, 501}, {469, 506}, {471, 518}, {466, 525},
  {470, 548}, {443, 548}, {446, 525}, {442, 516}, {444, 506}
}, false):roughen(0.8, 10, 720)

work(m_watcher_coat, {
  hand = "detail",
  tool = "round 2.5",
  pile = p_coat_dark,
  angle = 1.55,
  coverage = 1.85,
  load = 0.85,
  fill = true,
  clip = m_watcher_coat
})

-- Head and velvet cap (Altdeutsches Barett) at (456, 488..499)
m_watcher_head = ellipse(456, 494, 5.5, 5.5)
work(m_watcher_head, {
  hand = "detail",
  tool = "round 2.0",
  pile = p_hair_cap,
  angle = 0,
  coverage = 1.8,
  load = 0.80,
  fill = true,
  clip = m_watcher_head
})
-- Soft beret crown projecting slightly left/right
b_fig = brush{kind="round", width=2.2, point=0.90, stiffness=0.6}
b_fig:reload(p_coat_dark, 0.85)
b_fig:stroke({{449, 491}, {456, 488}, {463, 491}}, {pressure={0.45, 0.55, 0.40}})

-- Legs / boots planted on the boulder at y = 548..566
b_fig:reload(p_coat_dark, 0.88)
b_fig:stroke({{450, 547}, {449, 565}}, {pressure={0.55, 0.48}}) -- left leg
b_fig:stroke({{461, 547}, {462, 566}}, {pressure={0.55, 0.48}}) -- right leg

-- Walking staff held in right hand from (470, 516) down to boulder at (483, 565)
b_fine_twig:reload(p_twig_flow, 0.85)
b_fine_twig:stroke({{470, 515}, {477, 540}, {483, 565}}, {pressure={0.38, 0.32}})

print("Campaign 5A dark silhouettes complete")

--@ chunk 11
-- Wait 7 days so Campaign 5A is completely dry
wait(7 * 24 * 60)
print("Drying on oak trunk (268, 420)=" .. drying(268, 420))

-- Campaign 5B Part 1: Muscular branch collars (conserving cross-sectional area from trunk into primary boughs) and rich sympodial twig lacework
m_oak_collars = poly({
  -- Left lower & main bough collars
  {246, 378}, {214, 354}, {175, 344}, {218, 342}, {244, 336},
  {206, 298}, {164, 276}, {212, 286}, {246, 308},
  -- Upper-left bough collar
  {234, 256}, {204, 204}, {214, 202}, {246, 254}, {262, 296},
  -- Central-right stag-horn bough collar
  {274, 246}, {276, 188}, {284, 188}, {292, 248}, {286, 298},
  -- Right main & lower bough collars
  {334, 282}, {378, 266}, {332, 294}, {292, 332},
  {288, 356}, {332, 348}, {376, 354}, {328, 358}, {284, 376}
}, false):roughen(1.2, 14, 730)

work(m_oak_collars, {
  hand = "detail",
  tool = "round 3.5",
  pile = p_bark_dark,
  angle = 1.2,
  coverage = 1.8,
  load = 0.88,
  fill = true,
  clip = m_oak_collars
})

-- Additional crooked secondary and tertiary oak branches (covering remaining graphite lines and building sub-crown architecture)
local more_branches = {
  -- Covering graphite lines at (332..428, 158..286) and enriching right sub-crown
  {{332, 286, 0.65}, {354, 232, 0.48}, {392, 188, 0.34}, {428, 158, 0.16}},
  {{392, 188, 0.38}, {374, 162, 0.24}, {384, 138, 0.10}},
  {{392, 188, 0.34}, {418, 182, 0.22}, {442, 168, 0.10}},
  {{378, 268, 0.58}, {398, 244, 0.38}, {418, 218, 0.22}, {442, 204, 0.10}},
  {{425, 240, 0.46}, {454, 246, 0.30}, {482, 242, 0.14}},
  {{332, 286, 0.52}, {314, 262, 0.34}, {322, 236, 0.18}},
  -- Covering graphite lines on lower-right bough (305..442, 342..365)
  {{290, 366, 0.68}, {308, 364, 0.54}, {352, 348, 0.40}, {398, 355, 0.28}, {442, 342, 0.14}},
  {{352, 348, 0.38}, {368, 368, 0.24}, {392, 376, 0.10}},
  -- Covering graphite lines on upper-left bough (168..232, 74..272)
  {{168, 272, 0.62}, {152, 222, 0.45}, {118, 178, 0.30}, {88, 148, 0.14}},
  {{205, 202, 0.58}, {232, 152, 0.42}, {220, 102, 0.26}, {198, 74, 0.10}},
  {{220, 102, 0.32}, {202, 92, 0.18}, {184, 78, 0.08}},
  {{182, 150, 0.48}, {168, 122, 0.30}, {148, 96, 0.14}},
  {{240, 260, 0.54}, {224, 228, 0.36}, {196, 212, 0.18}},
  -- Left sub-crown forks
  {{212, 294, 0.58}, {190, 268, 0.38}, {162, 252, 0.22}, {138, 246, 0.10}},
  {{124, 244, 0.46}, {104, 224, 0.30}, {82, 206, 0.16}},
  {{178, 342, 0.50}, {146, 346, 0.32}, {116, 356, 0.16}},
  -- Stag-horn dead leader jagged forks
  {{278, 188, 0.55}, {255, 138, 0.38}, {264, 92, 0.18}},
  {{286, 248, 0.50}, {266, 218, 0.32}, {252, 198, 0.14}},
  {{294, 136, 0.44}, {282, 108, 0.26}, {288, 84, 0.10}}
}

for _, mb in ipairs(more_branches) do
  b_branch:reload(p_bark_dark, 0.85)
  b_branch:gesture(mb)
end

-- Dense network of crooked sympodial oak twigs (Orders 4 & 5) across the sub-crowns
local dense_twigs = {
  -- Left sub-crown twigs
  {{88, 148, 0.38}, {72, 138, 0.22}, {54, 136, 0.06}},
  {{118, 178, 0.38}, {102, 168, 0.22}, {86, 168, 0.06}},
  {{118, 178, 0.34}, {126, 158, 0.18}, {118, 142, 0.06}},
  {{152, 222, 0.38}, {138, 202, 0.22}, {122, 194, 0.06}},
  {{82, 206, 0.36}, {64, 198, 0.20}, {48, 202, 0.06}},
  {{104, 224, 0.34}, {92, 212, 0.18}, {78, 214, 0.06}},
  {{138, 246, 0.36}, {122, 234, 0.20}, {108, 236, 0.06}},
  {{66, 252, 0.36}, {48, 258, 0.20}, {34, 254, 0.06}},
  {{96, 256, 0.34}, {82, 268, 0.18}, {66, 272, 0.06}},
  {{118, 294, 0.36}, {98, 286, 0.20}, {82, 292, 0.06}},
  {{148, 302, 0.36}, {132, 314, 0.20}, {114, 318, 0.06}},
  {{116, 356, 0.36}, {96, 362, 0.20}, {78, 358, 0.06}},
  {{120, 376, 0.36}, {104, 388, 0.20}, {88, 394, 0.06}},
  {{152, 364, 0.36}, {138, 378, 0.20}, {124, 386, 0.06}},
  -- Upper-left sub-crown twigs
  {{148, 96, 0.36}, {134, 82, 0.20}, {118, 78, 0.06}},
  {{168, 122, 0.36}, {154, 112, 0.20}, {142, 114, 0.06}},
  {{184, 78, 0.36}, {172, 66, 0.20}, {158, 62, 0.06}},
  {{198, 74, 0.38}, {188, 58, 0.20}, {178, 48, 0.06}},
  {{220, 102, 0.36}, {234, 88, 0.20}, {242, 76, 0.06}},
  {{232, 152, 0.36}, {246, 138, 0.20}, {258, 132, 0.06}},
  {{184, 232, 0.36}, {168, 222, 0.20}, {154, 226, 0.06}},
  {{196, 212, 0.36}, {182, 198, 0.20}, {168, 194, 0.06}},
  -- Stag-horn retrenchment bare jagged twigs
  {{264, 92, 0.38}, {272, 76, 0.20}, {268, 64, 0.06}},
  {{288, 84, 0.36}, {296, 68, 0.18}},
  {{318, 88, 0.38}, {332, 76, 0.20}, {344, 72, 0.06}},
  {{336, 186, 0.36}, {352, 178, 0.20}, {364, 182, 0.06}},
  -- Right moon-facing sub-crown twigs
  {{384, 138, 0.36}, {396, 124, 0.20}, {410, 118, 0.06}},
  {{374, 162, 0.36}, {358, 152, 0.20}, {346, 148, 0.06}},
  {{428, 158, 0.38}, {446, 148, 0.22}, {462, 138, 0.06}},
  {{442, 168, 0.36}, {460, 162, 0.20}, {476, 164, 0.06}},
  {{418, 218, 0.36}, {434, 206, 0.20}, {450, 202, 0.06}},
  {{442, 204, 0.36}, {462, 198, 0.20}, {478, 202, 0.06}},
  {{482, 242, 0.38}, {502, 238, 0.22}, {518, 242, 0.06}},
  {{454, 246, 0.36}, {472, 256, 0.20}, {488, 254, 0.06}},
  {{408, 282, 0.36}, {424, 292, 0.20}, {440, 290, 0.06}},
  -- Lower-right sub-crown twigs
  {{384, 314, 0.36}, {402, 308, 0.20}, {418, 312, 0.06}},
  {{442, 342, 0.38}, {462, 334, 0.22}, {478, 336, 0.06}},
  {{392, 376, 0.36}, {412, 384, 0.20}, {428, 382, 0.06}},
  {{368, 368, 0.34}, {354, 380, 0.18}, {342, 386, 0.06}},
  {{404, 378, 0.36}, {392, 392, 0.20}, {380, 398, 0.06}}
}

for idx, dt in ipairs(dense_twigs) do
  if idx % 2 == 1 then b_twig:reload(p_twig_flow, 0.85) end
  b_twig:gesture(dt)
end

-- Wait 6 full days so ALL dark oak branches and twigs are 100% dry before laying bark modeling, moonlit rims, and winter oak leaves
wait(6 * 24 * 60)
print("Drying on oak collar (270, 320)=" .. drying(270, 320))

-- Campaign 5B Part 2: Fissured bark modeling, Moonlit Silver-Ochre Rims, Cast Shadows, and Clustered Winter Oak Leaves
p_bark_warm = pile{{"raw umber", 4.0}, {"yellow ochre", 1.8}, {"red earth", 1.4}, {"bone black", 1.0}, blot=0.15, oil="walnut", name="bark_warm"}
p_bark_moon = pile{{"lead white", 5.0}, {"Naples yellow", 2.0}, {"pale smalt", 2.2}, {"raw umber", 2.5}, blot=0.25, oil="walnut", name="bark_moon"}
p_stag_bone = pile{{"lead white", 6.5}, {"Naples yellow", 2.0}, {"raw umber", 2.2}, {"pale smalt", 1.5}, blot=0.25, oil="walnut", name="stag_bone"}

b_bark = brush{kind="round", width=2.4, point=0.92, stiffness=0.65}
b_rim  = brush{kind="rigger", width=1.6, point=0.98, stiffness=0.60}

-- Deeply fissured warm-umber bark plates along the right-center of the trunk (away from the left shadow edge)
local bark_fissure_strokes = {
  {{268, 322, 0.45}, {272, 365, 0.50}, {274, 415, 0.45}},
  {{276, 395, 0.45}, {278, 448, 0.52}, {276, 498, 0.45}},
  {{262, 435, 0.40}, {264, 488, 0.48}, {268, 538, 0.40}},
  {{280, 475, 0.45}, {284, 528, 0.50}, {296, 562, 0.38}},
  {{254, 505, 0.38}, {246, 548, 0.42}, {232, 572, 0.30}}
}
for _, bfs in ipairs(bark_fissure_strokes) do
  b_bark:reload(p_bark_warm, 0.72)
  b_bark:gesture(bfs)
end

-- Crisp moonlit silver-amber rim along the right-hand (east/moon-facing) contour of the oak trunk, roots, and main boughs
local moon_rim_strokes = {
  -- Right contour of trunk and root buttress facing the moon at x=642
  {{291, 318, 0.42}, {284, 368, 0.48}, {285, 428, 0.45}},
  {{285, 432, 0.45}, {284, 492, 0.50}, {292, 546, 0.45}, {314, 574, 0.30}},
  -- High stag-horn dead heartwood leader (bleached weathered wood catching moonlight on its right face)
  {{278, 312, 0.45}, {288, 250, 0.48}, {280, 190, 0.44}, {296, 136, 0.38}, {320, 88, 0.28}, {336, 63, 0.14}},
  {{288, 248, 0.38}, {315, 218, 0.28}, {336, 186, 0.16}},
  {{257, 140, 0.32}, {265, 94, 0.22}, {259, 70, 0.10}},
  -- Upper-left ascending bough right edge
  {{262, 314, 0.38}, {242, 258, 0.36}, {208, 202, 0.32}, {184, 150, 0.24}, {154, 108, 0.14}},
  {{208, 200, 0.32}, {234, 152, 0.26}, {222, 102, 0.18}},
  -- Upper side of right spreading Bough 5 & Bough 6 catching overhead/moon glow
  {{288, 320, 0.42}, {332, 284, 0.38}, {378, 266, 0.32}, {425, 238, 0.24}, {468, 224, 0.14}},
  {{334, 282, 0.34}, {356, 232, 0.28}, {392, 188, 0.20}, {426, 158, 0.12}},
  {{286, 366, 0.38}, {328, 350, 0.32}, {376, 354, 0.26}, {422, 342, 0.18}}
}
for idx, mrs in ipairs(moon_rim_strokes) do
  local p_use = (idx >= 3 and idx <= 5) and p_stag_bone or p_bark_moon
  b_rim:reload(p_use, 0.78)
  b_rim:gesture(mrs)
end

-- Moonlit rim on the Wayside Cross (right-hand edge of upright and top of crossbeam facing the moon)
b_rim:reload(p_bark_moon, 0.75)
b_rim:stroke({{143, 466}, {135, 506}, {127, 545}}, {pressure={0.35, 0.28}})
b_rim:stroke({{114, 484}, {138, 488}, {154, 492}}, {pressure={0.32, 0.28}})
b_rim:stroke({{141, 471}, {154, 492}}, {pressure={0.30, 0.24}})

-- Subtle moonlit rim on the Solitary Watcher (right edge of beret, pale linen collar hint at nape, right shoulder/sleeve, and walking staff)
p_watcher_rim = pile{{"lead white", 4.5}, {"pale smalt", 3.0}, {"Naples yellow", 1.5}, {"raw umber", 2.0}, blot=0.20, oil="walnut", name="watcher_rim"}
p_collar_linen= pile{{"lead white", 7.0}, {"Naples yellow", 2.0}, {"raw umber", 1.2}, blot=0.20, oil="walnut", name="collar_linen"}

b_rim:reload(p_collar_linen, 0.65)
b_rim:stroke({{453, 500}, {460, 500}}, {pressure={0.28, 0.25}}) -- subtle pale collar at nape
b_rim:reload(p_watcher_rim, 0.72)
b_rim:stroke({{457, 488}, {463, 491}}, {pressure={0.30, 0.22}}) -- right edge of beret
b_rim:stroke({{463, 501}, {469, 506}, {471, 518}, {466, 525}, {470, 547}}, {pressure={0.34, 0.28, 0.20}}) -- moonlit right shoulder & coat fold
b_rim:stroke({{471, 515}, {484, 564}}, {pressure={0.25, 0.18}}) -- glint along walking staff

-- Cast shadows on the rock ledges to the left of the Watcher, Oak Trunk, and Wayside Cross (away from the moon at x=642)
b_shad = brush{kind="filbert", width=4.5, point=0.3, stiffness=0.55}
b_shad:reload(p_rock_deep_cleft, 0.80)
-- Watcher cast shadow stretching left across the table rock
b_shad:stroke({{449, 565}, {412, 571}}, {pressure={0.55, 0.15}, clip=m_crag})
b_shad:stroke({{462, 566}, {420, 574}}, {pressure={0.55, 0.15}, clip=m_crag})
-- Wayside cross cast shadow stretching left
b_shad:stroke({{126, 546}, {88, 554}}, {pressure={0.50, 0.15}, clip=m_crag})

-- Clustered clinging winter-russet oak leaves on the sheltered lower and outer boughs (using Scratch Trial 3 lesson: clustered, slightly dragged small touches)
p_leaf_dark   = pile{{"raw umber", 4.0}, {"red earth", 2.0}, {"bone black", 1.8}, {"yellow ochre", 1.5}, blot=0.20, oil="walnut", name="leaf_dark"}
p_leaf_russet = pile{{"raw umber", 3.0}, {"red earth", 2.8}, {"yellow ochre", 2.6}, {"bone black", 0.8}, blot=0.20, oil="walnut", name="leaf_russet"}
p_leaf_gold   = pile{{"yellow ochre", 3.8}, {"Naples yellow", 2.2}, {"red earth", 1.4}, {"raw umber", 1.8}, {"lead white", 1.0}, blot=0.25, oil="walnut", name="leaf_gold"}

local leaf_clusters = {
  -- Sheltered clusters on lower-left Bough 1 & Bough 2
  {x=62,  y=312, rx=22, ry=10, seed=801, moon=false},
  {x=92,  y=380, rx=20, ry=9,  seed=802, moon=false},
  {x=54,  y=212, rx=22, ry=10, seed=803, moon=false},
  {x=84,  y=222, rx=18, ry=9,  seed=804, moon=false},
  {x=44,  y=248, rx=18, ry=8,  seed=805, moon=false},
  {x=96,  y=198, rx=20, ry=9,  seed=806, moon=false},
  -- Sparse clusters on upper-left Bough 3
  {x=68,  y=132, rx=20, ry=9,  seed=807, moon=false},
  {x=102, y=118, rx=18, ry=8,  seed=808, moon=false},
  {x=162, y=218, rx=18, ry=8,  seed=809, moon=false},
  -- Sheltered clusters on right moon-facing Bough 5 & Bough 6 (catching warm russet-gold moon edge)
  {x=472, y=136, rx=20, ry=9,  seed=810, moon=true},
  {x=512, y=170, rx=22, ry=10, seed=811, moon=true},
  {x=508, y=214, rx=24, ry=10, seed=812, moon=true},
  {x=488, y=264, rx=22, ry=10, seed=813, moon=true},
  {x=492, y=312, rx=20, ry=9,  seed=814, moon=true},
  {x=502, y=338, rx=24, ry=10, seed=815, moon=true},
  {x=476, y=378, rx=20, ry=9,  seed=816, moon=true},
  {x=408, y=384, rx=18, ry=8,  seed=817, moon=true}
}

for _, lc in ipairs(leaf_clusters) do
  local mlc = ellipse(lc.x, lc.y, lc.rx, lc.ry):roughen(4.5, 10, lc.seed)
  stipple(mlc, {
    pile = p_leaf_dark,
    width = 1.6,
    coverage = 0.42,
    pressure = {0.45, 0.70},
    drag = {1.2, 0.25},
    twist = 0.35,
    cluster = {0.75, 6},
    feather = 0.2,
    seed = lc.seed
  })
  stipple(mlc:shrink(2), {
    pile = p_leaf_russet,
    width = 1.5,
    coverage = 0.32,
    pressure = {0.40, 0.65},
    drag = {1.0, -0.20},
    twist = 0.30,
    cluster = {0.75, 5},
    feather = 0.2,
    seed = lc.seed + 50
  })
  if lc.moon then
    local mlc_rim = ellipse(lc.x + 4, lc.y - 1, lc.rx * 0.65, lc.ry * 0.65):roughen(3.5, 8, lc.seed + 100)
    stipple(mlc_rim, {
      pile = p_leaf_gold,
      width = 1.4,
      coverage = 0.25,
      pressure = {0.35, 0.55},
      drag = {0.9, 0.15},
      cluster = {0.70, 5},
      feather = 0.2,
      seed = lc.seed + 100
    })
  end
end

print("Campaign 5B complete")

--@ chunk 12
-- Campaign 6: Wait 14 full days so all walnut-oil darks and highlights are 100% dry
wait(14 * 24 * 60)
print("Drying checks: trunk=" .. drying(268, 420) .. ", collar=" .. drying(270, 320) .. ", watcher_rock=" .. drying(435, 570))

-- 1. Solidify the oak crown fork crotches (y = 285..375) with simple convex polygons and b_bough_lg strokes
local m_crotch_core = poly({{236, 375}, {238, 312}, {258, 292}, {288, 295}, {294, 322}, {290, 375}}, false):roughen(1.0, 12, 901)
local m_crotch_left = poly({{206, 294}, {244, 254}, {268, 305}, {244, 345}}, false):roughen(1.0, 12, 902)
local m_crotch_right= poly({{268, 305}, {288, 248}, {336, 284}, {290, 345}}, false):roughen(1.0, 12, 903)
local m_all_crotches = m_crotch_core + m_crotch_left + m_crotch_right

work(m_all_crotches, {
  hand = "detail",
  tool = "round 4.0",
  pile = p_bark_dark,
  angle = 1.45,
  coverage = 1.9,
  load = 0.90,
  fill = true,
  clip = m_all_crotches
})

-- 2. Restate the primary boughs, stag-horn leader, trunk, and cross to cover the over-bright white stripes from 5B,
--    followed by a close-in-value nocturnal slate-umber rim (p_bark_nocturne_rim: only 1.2 parts lead white!)
p_bark_nocturne_rim = pile{{"raw umber", 4.0}, {"smalt", 3.0}, {"yellow ochre", 1.5}, {"lead white", 1.2}, blot=0.20, oil="walnut", name="bark_nocturne_rim"}

-- Restate primary boughs cleanly in p_bark_dark so the silhouette against the luminous sky is deep and unbroken
for _, b in ipairs(oak_boughs) do
  b.brush:reload(p_bark_dark, 0.90)
  b.brush:gesture(b.pts)
end
-- Restate secondary stag-horn forks that had bright white stripes
b_branch:reload(p_bark_dark, 0.88)
b_branch:gesture({{286, 250, 0.68}, {314, 218, 0.46}, {336, 186, 0.24}, {348, 164, 0.08}})
b_branch:gesture({{278, 190, 0.65}, {256, 142, 0.45}, {264, 96, 0.24}, {258, 70, 0.06}})
b_branch:gesture({{206, 204, 0.70}, {232, 154, 0.50}, {220, 106, 0.32}, {198, 76, 0.14}, {182, 58, 0.05}})
b_branch:gesture({{332, 286, 0.72}, {354, 234, 0.52}, {390, 190, 0.34}, {426, 160, 0.18}, {452, 142, 0.06}})

-- Restate right edge of trunk and wayside cross in p_bark_dark, then lay subtle close-in-value nocturnal rim
b_bough_md:reload(p_bark_dark, 0.88)
b_bough_md:gesture({{288, 315, 0.80}, {284, 370, 0.80}, {285, 435, 0.80}, {284, 495, 0.80}, {292, 548, 0.75}, {314, 576, 0.50}})

b_cross:reload(p_bark_dark, 0.88)
b_cross:stroke({{126, 546}, {134, 506}, {142, 466}}, {pressure={0.65, 0.55}, orient="along"})
b_cross:stroke({{114, 485}, {138, 489}, {154, 493}}, {pressure={0.55, 0.50}, orient="along"})

-- Wait 6 days for the restated darks to set/dry before touching in the subtle nocturnal rim
wait(6 * 24 * 60)

b_rim:reload(p_bark_nocturne_rim, 0.70)
b_rim:gesture({{289, 322, 0.38}, {285, 375, 0.42}, {286, 435, 0.40}, {285, 495, 0.42}, {293, 548, 0.35}})
b_rim:gesture({{288, 320, 0.36}, {332, 285, 0.32}, {378, 267, 0.25}, {425, 239, 0.18}})
b_rim:gesture({{276, 312, 0.36}, {287, 250, 0.34}, {279, 190, 0.28}, {295, 136, 0.22}})
b_rim:stroke({{143, 466}, {135, 506}, {127, 545}}, {pressure={0.28, 0.22}})

-- 3. Repair the stick-like cast shadows on the rock ledges under the Watcher and Wayside Cross
local m_fix_watcher_ledge = poly({{398, 565}, {452, 564}, {455, 582}, {395, 580}}, false):soften(2.5)
work(m_fix_watcher_ledge, {
  hand = "detail",
  tool = flat6,
  piles = {{p_rock_slate_lit, 0.65}, {p_rock_moon_edge, 0.35}},
  angle = 0.05,
  coverage = 1.4,
  load = 0.75,
  clip = m_crag
})

local m_fix_cross_ledge = poly({{78, 544}, {130, 542}, {132, 562}, {78, 560}}, false):soften(2.5)
work(m_fix_cross_ledge, {
  hand = "detail",
  tool = flat6,
  pile = p_rock_slate_lit,
  angle = 0.08,
  coverage = 1.4,
  load = 0.75,
  clip = m_crag
})

-- Wait 5 days for the repaired rock ledges to dry, then lay soft, diffused contact shadows
wait(5 * 24 * 60)

local m_watcher_contact = ellipse(442, 567, 22, 4.5):soften(3.5)
work(m_watcher_contact, {
  hand = "glaze",
  pile = p_rock_cleft_glaze,
  angle = 0.05,
  coverage = 0.90,
  load = 0.60,
  clip = m_crag
})

local m_cross_contact = ellipse(114, 548, 18, 4.0):soften(3.5)
work(m_cross_contact, {
  hand = "glaze",
  pile = p_rock_cleft_glaze,
  angle = 0.08,
  coverage = 0.90,
  load = 0.60,
  clip = m_crag
})

-- Re-plant the watcher's boots and staff tip crisply over the contact shadow edge
b_fig:reload(p_coat_dark, 0.85)
b_fig:stroke({{450, 548}, {449, 566}}, {pressure={0.55, 0.48}})
b_fig:stroke({{461, 548}, {462, 567}}, {pressure={0.55, 0.48}})
b_fine_twig:reload(p_twig_flow, 0.80)
b_fine_twig:stroke({{470, 515}, {477, 540}, {483, 566}}, {pressure={0.36, 0.30}})

-- 4. Delicate foreground coastal sedges and dry winter grass blades springing from the mossy rock clefts
p_grass_dark = pile{{"raw umber", 3.5}, {"Prussian blue", 0.8}, {"yellow ochre", 2.0}, medium=0.15, oil="walnut", name="grass_dark"}
p_grass_ochre= pile{{"yellow ochre", 3.5}, {"Naples yellow", 1.8}, {"raw umber", 2.2}, medium=0.15, oil="walnut", name="grass_ochre"}

b_grass = brush{kind="rigger", width=1.3, point=0.99, stiffness=0.55}
local grass_tufts = {
  -- Around wayside cross base
  {x=122, y=548, dx=-6, h=14}, {x=125, y=548, dx=-2, h=16}, {x=130, y=547, dx=5, h=13},
  -- Around oak roots
  {x=208, y=582, dx=-8, h=16}, {x=214, y=580, dx=-3, h=18}, {x=220, y=582, dx=4, h=15},
  {x=312, y=578, dx=-4, h=15}, {x=318, y=580, dx=6, h=17}, {x=324, y=582, dx=10, h=14},
  -- Foreground rock clefts
  {x=162, y=632, dx=-7, h=18}, {x=168, y=634, dx=3, h=20}, {x=174, y=632, dx=8, h=16},
  {x=358, y=624, dx=-6, h=17}, {x=364, y=625, dx=2, h=19}, {x=370, y=624, dx=7, h=15},
  {x=482, y=632, dx=-5, h=16}, {x=488, y=634, dx=4, h=18}, {x=494, y=632, dx=9, h=14}
}
for idx, gt in ipairs(grass_tufts) do
  local p_g = (idx % 3 == 0) and p_grass_ochre or p_grass_dark
  b_grass:reload(p_g, 0.80)
  b_grass:gesture({
    {gt.x, gt.y, 0.38},
    {gt.x + gt.dx * 0.5, gt.y - gt.h * 0.55, 0.22},
    {gt.x + gt.dx, gt.y - gt.h, 0.04}
  })
end

print("Campaign 6 refinements complete")

--@ chunk 13
-- Campaign 7: Wait 10 days for Campaign 6 to dry, then harmonize the remaining bright slivers on the oak/cross/watcher and sign
wait(10 * 24 * 60)
print("Drying check at trunk (275, 450)=" .. drying(275, 450))

-- 1. Quiet the remaining bright slivers from 5B on the trunk core, Bough 3 fork, and Bough 6 upper edge
b_bark:reload(p_bark_dark, 0.85)
b_bark:gesture({{268, 322, 0.55}, {272, 365, 0.60}, {274, 415, 0.55}})
b_bark:gesture({{276, 395, 0.55}, {278, 448, 0.60}, {276, 498, 0.55}})
b_bark:gesture({{280, 475, 0.55}, {284, 528, 0.60}, {296, 562, 0.45}})

b_branch:reload(p_bark_dark, 0.85)
b_branch:gesture({{207, 201, 0.55}, {233, 152, 0.42}, {221, 102, 0.28}})
b_branch:gesture({{286, 366, 0.62}, {328, 350, 0.52}, {376, 354, 0.42}, {422, 342, 0.28}})

-- Subtle nocturnal slate-umber fissuring on the trunk (close in value, within 1 step of p_bark_dark)
b_rim:reload(p_bark_nocturne_rim, 0.65)
b_rim:gesture({{275, 360, 0.32}, {277, 420, 0.35}, {276, 480, 0.32}})
b_rim:gesture({{287, 366, 0.30}, {328, 350, 0.25}, {376, 354, 0.18}})

-- 2. Quiet the over-bright crossbeam and hood line on the wayside cross
b_rim:reload(p_bark_dark, 0.85)
b_rim:stroke({{114, 484}, {138, 488}, {154, 492}}, {pressure={0.42, 0.38}})
b_rim:stroke({{141, 471}, {154, 492}}, {pressure={0.38, 0.32}})
b_rim:reload(p_bark_nocturne_rim, 0.65)
b_rim:stroke({{138, 488}, {154, 492}}, {pressure={0.22, 0.18}})

-- 3. Refine the watcher's right coat skirt contour so only a hair-thin nocturnal rim remains on the upper right shoulder and cap
b_fig:reload(p_coat_dark, 0.85)
b_fig:stroke({{462, 502}, {468, 507}, {469, 518}, {465, 525}, {469, 547}}, {pressure={0.38, 0.35}})
b_rim:reload(p_bark_nocturne_rim, 0.65)
b_rim:stroke({{463, 501}, {469, 506}, {470, 516}}, {pressure={0.22, 0.16}})

-- 4. Subtle monogram signature "C.D.F." in warm umber in the lower-left dark rock shadow
p_sig = pile{{"raw umber", 4.0}, {"yellow ochre", 2.0}, {"red earth", 1.5}, medium=0.20, oil="walnut", name="sig"}
b_sig = brush{kind="rigger", width=1.1, point=0.99, stiffness=0.55}
b_sig:reload(p_sig, 0.75)
-- "C"
b_sig:stroke({{32, 728}, {27, 729}, {26, 733}, {27, 736}, {32, 737}}, {pressure={0.22, 0.25, 0.22}})
-- "D"
b_sig:reload(p_sig, 0.75)
b_sig:stroke({{38, 728}, {38, 737}}, {pressure={0.24, 0.24}})
b_sig:stroke({{38, 728}, {43, 730}, {43, 735}, {38, 737}}, {pressure={0.22, 0.25, 0.22}})
-- "F"
b_sig:reload(p_sig, 0.75)
b_sig:stroke({{49, 728}, {49, 737}}, {pressure={0.24, 0.24}})
b_sig:stroke({{49, 728}, {54, 728}}, {pressure={0.22, 0.20}})
b_sig:stroke({{49, 732}, {53, 732}}, {pressure={0.22, 0.18}})

-- Wait 14 days so the entire painting is completely touch-dry
wait(14 * 24 * 60)
print("Final drying check: trunk=" .. drying(275, 450) .. ", sky=" .. drying(500, 200) .. ", water=" .. drying(642, 580) .. ", rocks=" .. drying(350, 650))

--@ chunk 14
print(wait(0))
