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
