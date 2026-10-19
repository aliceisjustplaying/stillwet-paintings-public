-- easel session "painting": recovered from original session tool calls and successful chunk results.
--@ engine 2

--@ chunk 1
--  Morning on a lake in the north country.  72 x 90 cm, fine linen.
canvas{
  size = 720,          -- mm, width
  aspect = 0.8,        -- w/h  ->  H = 1250
  linen = {13, 12},    -- plain weave, threads per cm
  seed = 1824,
  ground = {
    {pile = {{"red earth", 3}, {"yellow ochre", 2}, {"lead white", 2}}, um = 45, apply = "knife",  texture = 0.6},
    {pile = {{"lead white", 8}, {"yellow ochre", 1}, {"raw umber", 1}},  um = 50, apply = "roller", texture = 0.5},
    {pile = {{"lead white", 10}, {"pale smalt", 1}},                    um = 25, apply = "brush",  texture = 0.7},
  },
}
print(W, H)

--@ chunk 2
-- Underdrawing: a faint first pass, then the firmer contours over it.
hf = pencil{grade="3H"}   -- the faint first outline
hb = pencil{grade="HB"}

hf:sketch({{0,699},{110,697},{240,701},{380,698},{520,700},{660,697},{800,700},{920,698},{1000,699}},
        {pressure=0.22, passes=2})
hf:sketch({{0,693},{100,679},{190,685},{280,673},{380,691},{470,697},{560,701},{660,703},
           {760,698},{860,685},{930,677},{1000,685}}, {pressure=0.22, passes=2})
hf:sketch({{690,703},{760,700},{830,701},{900,698},{1000,700}}, {pressure=0.18, passes=2})

-- near bank, the edge of the land
hb:line({0,1031, 120,1022, 240,1016, 350,1013, 455,1017, 560,1026, 700,1038,
         850,1050, 1000,1063}, {pressure={0.3,0.4,0.3}})

-- the small punt on the water
hb:line({688,884, 706,873, 742,871, 764,881, 742,884, 706,886}, {pressure=0.4})
hb:line({716,872, 742,872}, {pressure=0.35})
hb:line({742,872, 756,846}, {pressure=0.35})

-- the figure, seen from behind
hb:line({414,1017, 415,1000, 417,984, 418,970, 419,952, 421,938, 424,928, 429,925,
         434,928, 437,940, 437,955, 436,972, 434,988, 433,1004, 434,1017},
        {pressure=0.4})
hb:line({414,1017, 434,1017}, {pressure=0.4})
print("underdrawn")

--@ chunk 3
hb = pencil{grade="HB"}
erase({{410,1017},{437,920}}, {strength=0.95, width=10})
hb:line({489,1019, 490,1002, 492,986, 493,972, 494,954, 496,940, 499,930, 504,927,
         509,930, 512,942, 512,957, 511,974, 509,990, 508,1006, 509,1019},
        {pressure=0.4})
hb:line({489,1019, 509,1019}, {pressure=0.4})
hb:line({499,930, 505,931}, {pressure=0.3})
print("figure redrawn")

--@ chunk 4
T1 = {
  {168,1024, 165,955, 170,886, 178,818, 185,750, 192,684, 198,620, 202,558,
   25,23.5,21.5,19.5,17.6,15.8,14,12.4},
  {192,684, 150,626, 104,578, 60,548, 22,534, 0,528,     12,9.4,7.2,5.2,3.2,1.8},
  {186,744, 124,790, 66,818, 26,830, 2,830,               13,10.4,7.6,5,2.6},
  {197,626, 228,556, 252,500, 266,458, 274,430,           10.4,8.4,6.2,4.2,2.6},
  {188,748, 242,720, 300,704, 348,696, 384,690, 408,686, 11.6,9,6.8,4.8,3,1.8},
  {201,556, 252,516, 302,490, 342,474, 372,464, 392,458,  10,8,6,4.2,2.6,1.6},
  {202,558, 214,492, 221,428, 225,372, 223,330, 218,300,  12.4,9.4,6.8,4.4,2.8,1.7},
}
T2 = {
  {302,1017, 300,960, 302,900, 306,842, 308,786, 310,730, 312,676, 314,624, 315,580,
   15,14,12.6,11.2,9.8,8.6,7.4,6.4,5.4},
  {308,780, 268,742, 232,712, 204,694, 186,684,   7.6,6,4.4,3,1.8},
  {310,724, 350,690, 388,664, 416,646, 434,636,   7,5.6,4.2,2.8,1.7},
  {312,670, 286,622, 266,584, 254,558, 248,542,   6.4,5,3.8,2.4,1.5},
  {306,838, 348,812, 388,792, 418,778, 440,770,   8.4,6.4,4.6,3,1.8},
  {315,580, 340,540, 362,510, 378,490,             5.4,4.2,3,1.9},
  {302,956, 268,930, 238,912, 216,902,             6,4.6,3.2,2},
}
T3 = {
  {382,1014, 380,970, 383,926, 386,884, 388,842, 389,802, 390,766,
   9,8.4,7.6,6.8,6,5.2,4.4},
  {386,880, 356,856, 330,838, 310,826, 296,818,   5,4,3,2,1.3},
  {388,840, 416,818, 440,800, 458,786,             5.4,4.2,3,1.9},
  {389,800, 368,770, 352,748, 342,732,             4.6,3.6,2.6,1.6},
  {390,766, 412,742, 430,724, 442,710,             4.4,3.4,2.4,1.5},
}
local function pts_of(L)
  local n = #L
  local nw = n - #L + 1
  return L
end
for name, T in pairs({T1=T1,T2=T2,T3=T3}) do
  for i = 1, #T do print(name, i, #T[i]) end
end

--@ chunk 5
T1 = {
  {pts={168,1024, 165,955, 170,886, 178,818, 185,750, 192,684, 198,620, 202,558},
   w={25,23.5,21.5,19.5,17.6,15.8,14,12.4}},
  {pts={192,684, 150,626, 104,578, 60,548, 22,534, 0,528},          w={12,9.4,7.2,5.2,3.2,1.8}},
  {pts={186,744, 124,790, 66,818, 26,830, 2,830},                    w={13,10.4,7.6,5,2.6}},
  {pts={197,626, 228,556, 252,500, 266,458, 274,430},                w={10.4,8.4,6.2,4.2,2.6}},
  {pts={188,748, 242,720, 300,704, 348,696, 384,690, 408,686},      w={11.6,9,6.8,4.8,3,1.8}},
  {pts={201,556, 252,516, 302,490, 342,474, 372,464, 392,458},       w={10,8,6,4.2,2.6,1.6}},
  {pts={202,558, 214,492, 221,428, 225,372, 223,330, 218,300},       w={12.4,9.4,6.8,4.4,2.8,1.7}},
}
T2 = {
  {pts={302,1017, 300,960, 302,900, 306,842, 308,786, 310,730, 312,676, 314,624, 315,580},
   w={15,14,12.6,11.2,9.8,8.6,7.4,6.4,5.4}},
  {pts={308,780, 268,742, 232,712, 204,694, 186,684},   w={7.6,6,4.4,3,1.8}},
  {pts={310,724, 350,690, 388,664, 416,646, 434,636},   w={7,5.6,4.2,2.8,1.7}},
  {pts={312,670, 286,622, 266,584, 254,558, 248,542},   w={6.4,5,3.8,2.4,1.5}},
  {pts={306,838, 348,812, 388,792, 418,778, 440,770},   w={8.4,6.4,4.6,3,1.8}},
  {pts={315,580, 340,540, 362,510, 378,490},             w={5.4,4.2,3,1.9}},
  {pts={302,956, 268,930, 238,912, 216,902},             w={6,4.6,3.2,2}},
}
T3 = {
  {pts={382,1014, 380,970, 383,926, 386,884, 388,842, 389,802, 390,766},
   w={9,8.4,7.6,6.8,6,5.2,4.4}},
  {pts={386,880, 356,856, 330,838, 310,826, 296,818},   w={5,4,3,2,1.3}},
  {pts={388,840, 416,818, 440,800, 458,786},             w={5.4,4.2,3,1.9}},
  {pts={389,800, 368,770, 352,748, 342,732},             w={4.6,3.6,2.6,1.6}},
  {pts={390,766, 412,742, 430,724, 442,710},             w={4.4,3.4,2.4,1.5}},
}

hf = pencil{grade="3H"}
for _, T in ipairs({T1, T2, T3}) do
  for i, L in ipairs(T) do hf:line(L.pts, {pressure=0.2, smooth=(i == 1)}) end
end
hb = pencil{grade="HB"}
for _, T in ipairs({T1, T2, T3}) do
  for i, L in ipairs(T) do hb:line(L.pts, {pressure=0.34, smooth=(i == 1)}) end
end
print("trees drawn")

--@ chunk 6
-- firmer pass over the same drawing, and a better figure
hb = pencil{grade="HB"}
for _, T in ipairs({T1, T2, T3}) do
  for i, L in ipairs(T) do hb:line(L.pts, {pressure={0.5, 0.42, 0.62}, smooth=(i == 1)}) end
end

-- the figure: a hooded cloak, shoulders turned a little to the left
hb:line({487,1019, 488,1000, 490,980, 492,960, 494,946, 497,936, 501,930, 506,928,
         512,931, 515,940, 515,953, 513,970, 511,986, 510,1002, 511,1019},
        {pressure=0.55})
hb:line({487,1019, 511,1019}, {pressure=0.55})
hb:line({491,1055, 508,1055}, {pressure=0.3})   -- hem fold, drawn a touch below
print("redrawn firmer")

--@ chunk 7
-- The sky: a pale cool wash, laid thin so the ground and the drawing stay in it.
skyM = below(function(x) return 699 end)
skyCool = pile{{"lead white", 12}, {"pale smalt", 5}, {"raw umber", 1.2}, medium=0.55}
work(skyM, {hand="glaze", pile=skyCool, coverage=1.15, clip=true, edge="lost"})
print("sky wash")

--@ chunk 8
skyCool2 = pile{{"lead white", 9}, {"pale smalt", 5}, {"smalt", 1.5}, {"raw umber", 1.5}, medium=0.3}
work(skyM, {hand="broad", pile=skyCool2, tool="filbert 16", coverage=2.0, angle=0,
            pressure={0.35, 0.55}, clip=true, edge="soft"})
print("stronger sky")

--@ chunk 9
topM = mask(function(x, y) return clamp((520 - y) / 380, 0, 1) end)
skyTop = pile{{"lead white", 8}, {"pale smalt", 5}, {"cobalt blue", 2}, {"raw umber", 1}, medium=0.35}
work(topM, {hand="glaze", pile=skyTop, coverage=2.6, load=0.45, clip=true, edge="lost"})
print(drying(500, 300), drying(500, 600))

--@ chunk 10
-- knock the blue back with a pale veil, then bring it on again with a longer ramp
pale = pile{{"lead white", 11}, {"pale smalt", 4}, medium=0.3}
work(topM, {hand="broad", pile=pale, tool="filbert 22", coverage=2.4, angle=0,
            pressure={0.4, 0.6}, clip=true, edge="lost"})
rampM = mask(function(x, y) return clamp((650 - y) / 570, 0, 1) end)
skyTop2 = pile{{"lead white", 10}, {"pale smalt", 6}, {"cobalt blue", 1.6}, {"raw umber", 0.8}, medium=0.4}
work(rampM, {hand="glaze", pile=skyTop2, coverage=3.2, load=0.6, clip=true, edge="lost"})
print(drying(500, 200))

--@ chunk 11
-- the low sun and the warm light it throws along the horizon
glowM = ellipse(642, 668, 320, 160):soften(120)
bandM = mask(function(x, y) return clamp((y - 320) / 310, 0, 1) end)
warmM = bandM:times(glowM)
warm1 = pile{{"lead white", 10}, {"chrome yellow", 2}, {"yellow ochre", 1.5}, {"vermilion", 0.4}, medium=0.45}
work(warmM, {hand="glaze", pile=warm1, coverage=2.4, load=0.5, clip=true, edge="lost"})

warm2 = pile{{"lead white", 8}, {"chrome yellow", 3}, {"yellow ochre", 2}, {"vermilion", 0.8}, medium=0.35}
work(glowM, {hand="glaze", pile=warm2, coverage=2.0, load=0.42, clip=true, edge="lost"})
print("warm band")

--@ chunk 12
-- too much: knock the yellow back with a cool white veil, then lay the warmth far more shyly
knock = pile{{"lead white", 14}, {"pale smalt", 6}, medium=0.25}
work(glowM, {hand="broad", pile=knock, tool="filbert 24", coverage=2.6, angle=0,
             pressure={0.45, 0.65}, clip=true, edge="lost"})
work(bandM, {hand="broad", pile=knock, tool="filbert 24", coverage=1.6, angle=0,
             pressure={0.35, 0.5}, clip=true, edge="lost"})
print(drying(642, 620))

--@ chunk 13
-- fuse the wet sky so the strokes stop reading as separate patches
blend(skyM, {angle=0.1})
print(drying(642, 620), drying(400, 200))

--@ chunk 14
-- a strong cool veil to knock the gold back to a whisper
knock2 = pile{{"lead white", 16}, {"pale smalt", 3}, medium=0.12}
bandY = rect(0, 360, 1000, 345)
work(bandY, {hand="body", pile=knock2, tool="filbert 14", coverage=2.8, angle=0,
             pressure=0.5, clip=true, edge="soft"})
print(drying(642, 640))

--@ chunk 15
-- the sun itself: a pale veiled disk, its foot lost in the haze
sunM = ellipse(642, 664, 34, 33):soften(13)
sunP = pile{{"lead white", 20}, {"chrome yellow", 0.6}, {"yellow ochre", 0.4}}
work(sunM, {hand="body", pile=sunP, tool="filbert 12", coverage=2.2, edge="lost", clip=true})
blend(sunM)
print("sun")

--@ chunk 16
-- start the sky again over a clean veil: the earlier bands never came clean
clean = pile{{"lead white", 18}, {"pale smalt", 4}, medium=0.1}
work(skyM, {hand="body", pile=clean, tool="filbert 16", coverage=3.0, angle=0,
            pressure=0.55, fill=true, clip=true, edge="soft"})
print("cleaned", drying(500, 300))

--@ chunk 17
lw = pile{{"lead white", 20}}
t1m = rect(420, 560, 140, 70)
work(t1m, {hand="body", pile=lw, tool="filbert 18", coverage=5, pressure=0.9, fill=true, clip=true})
print(drying(480, 590))

--@ chunk 18
-- veil the whole sky back to white: only a strong lead-white film hides what is under it
veilM = mask(function(x, y) return clamp((760 - y) / 60, 0, 1) end)
work(veilM, {hand="body", pile=lw, tool="filbert 22", coverage=3.2, angle=0,
             pressure=0.8, fill=true, edge="lost"})
print("veiled", drying(500, 200), drying(642, 640))

--@ chunk 19
print(wait(2 * 24 * 60))
print(drying(642, 640), drying(642, 500), drying(500, 150))

--@ chunk 20
bandVeil = mask(function(x, y) return clamp((y - 300) / 70, 0, 1) * clamp((795 - y) / 45, 0, 1) end)
work(bandVeil, {hand="body", pile=lw, tool="filbert 22", coverage=3.0, angle=0,
                pressure=0.8, fill=true, edge="lost"})
print("band veiled")

--@ chunk 21
blueRamp = mask(function(x, y) return clamp((660 - y) / 620, 0, 1) end)
skyBlue = pile{{"lead white", 10}, {"pale smalt", 6}, {"cobalt blue", 1.2}, {"raw umber", 0.6}, medium=0.5}
work(blueRamp, {hand="glaze", pile=skyBlue, coverage=2.4, load=0.5, clip=true, edge="lost"})
print("blue ramp")

--@ chunk 22
-- the light of the low sun, laid very thin
glowM2 = ellipse(642, 670, 300, 140):soften(130)
glowBand = mask(function(x, y) return clamp((y - 380) / 260, 0, 1) end)
glowM2 = glowM2 * glowBand
warmThin = pile{{"lead white", 16}, {"chrome yellow", 0.5}, {"yellow ochre", 0.6}, {"vermilion", 0.12}, medium=0.5}
work(glowM2, {hand="glaze", pile=warmThin, coverage=1.3, load=0.32, clip=true, edge="lost"})

sunM = ellipse(642, 666, 30, 29):soften(11)
sunP = pile{{"lead white", 20}, {"chrome yellow", 0.35}, {"yellow ochre", 0.25}}
work(sunM, {hand="body", pile=sunP, tool="filbert 10", coverage=1.8, edge="lost", clip=true})
print("glow and sun")

--@ chunk 23
work(sunM, {hand="body", pile=lw, tool="filbert 10", coverage=2.4, edge="lost", clip=true, pressure=0.7})
print("sun strengthened")

--@ chunk 24
core = ellipse(642, 672, 74, 26):soften(30)
work(core, {hand="body", pile=lw, tool="filbert 14", coverage=2.6, edge="lost", clip=true, pressure=0.75})
print("sun core")

--@ chunk 25
-- the far hills, pale in the haze, dipping where the sun stands
hillPts = {{0,700},{52,692},{100,681},{146,684},{190,686},{236,676},{280,671},{322,679},
           {380,690},{428,694},{470,698},{516,701},{560,702},{616,704},{660,704},{712,702},
           {760,698},{808,691},{860,683},{900,678},{930,675},{968,679},{1000,685}}
hillsM = poly(hillPts, true) * rect(0, 660, 1000, 120)
hillsM = hillsM:soften(7)
hillP = pile{{"lead white", 8}, {"pale smalt", 4}, {"smalt", 1}, {"raw umber", 0.6}, medium=0.5}
work(hillsM, {hand="broad", pile=hillP, tool="filbert 20", coverage=1.6, angle=0,
              pressure={0.3, 0.45}, clip=true, edge="lost"})
print("hills")

--@ chunk 26
waterM = rect(0, 696, 1000, 345)
waterP = pile{{"lead white", 6}, {"pale smalt", 4}, {"smalt", 2}, {"raw umber", 1}, medium=0.35}
work(waterM, {hand="broad", pile=waterP, tool="filbert 18", coverage=1.7, angle=0,
              pressure={0.35, 0.5}, clip=true, edge="lost", fill=true})
print("water")

--@ chunk 27
-- mist lying on the water
n1 = noise{seed=5, octaves=3, period=280, persistence=0.55}
mistM = mask(function(x, y)
  local v = clamp(1 - (y - 690) / 165, 0, 1)
  local w = 0.45 + 0.55 * n1:at01(x, y * 0.55 + 40)
  local v2 = clamp(1 - (y - 855) / 90, 0, 1) * clamp(n1:at01(x + 300, y) * 1.6 - 0.5, 0, 1)
  return clamp(v * w * 1.7 + v2 * 0.8, 0, 1)
end)
mistP = pile{{"lead white", 12}, {"pale smalt", 2}, medium=0.4}
work(mistM, {hand="scumble", pile=mistP, coverage=1.9, clip=true, edge="lost", fill=true})
print("mist")

--@ chunk 28
nearWaterM = mask(function(x, y) return clamp((y - 795) / 130, 0, 1) end)
nearWaterP = pile{{"lead white", 4}, {"pale smalt", 4}, {"smalt", 2.5}, {"raw umber", 1.5}, medium=0.25}
work(nearWaterM, {hand="broad", pile=nearWaterP, tool="filbert 16", coverage=2.0, angle=0,
                  pressure={0.4, 0.55}, clip=true, edge="lost", fill=true})
print("near water")

--@ chunk 29
dwM = mask(function(x, y) return clamp((y - 860) / 110, 0, 1) end)
dwP = pile{{"lead white", 3}, {"pale smalt", 3}, {"smalt", 3}, {"raw umber", 2.5}, medium=0.1}
work(dwM, {hand="broad", pile=dwP, tool="filbert 16", coverage=2.4, angle=0,
           pressure={0.45, 0.6}, clip=true, edge="lost", fill=true})
print("darker water")

--@ chunk 30
-- the light on the water under the sun
lpM = mask(function(x, y)
  if y < 696 or y > 1020 then return 0 end
  local t = clamp((y - 698) / 316, 0, 1)
  local halfw = 24 + 86 * t
  local cx = 642 + 20 * t
  return clamp(1 - math.abs(x - cx) / halfw, 0, 1) * clamp((1015 - y) / 70, 0, 1)
end)
lpP = pile{{"lead white", 16}, {"chrome yellow", 0.5}, {"yellow ochre", 0.4}, medium=0.4}
work(lpM, {hand="scumble", pile=lpP, coverage=1.6, clip=true, edge="lost", fill=true})
print("light path")

--@ chunk 31
work(dwM, {hand="broad", pile=dwP, tool="filbert 16", coverage=1.6, angle=0,
           pressure={0.45, 0.6}, clip=true, edge="lost", fill=true})
lpM = mask(function(x, y)
  if y < 694 or y > 1030 then return 0 end
  local t = clamp((y - 696) / 334, 0, 1)
  local halfw = 16 + 150 * t
  local cx = 642 + 26 * t
  local u = math.abs(x - cx) / halfw
  return clamp(1 - u * u, 0, 1) * clamp((1020 - y) / 170, 0, 1) * (0.35 + 0.65 * (1 - t))
end)
work(lpM, {hand="scumble", pile=lpP, coverage=1.5, clip=true, edge="lost", fill=true})
print("light path redone")

--@ chunk 32
knockM = ellipse(646, 770, 150, 130):soften(70)
knockW = pile{{"lead white", 8}, {"pale smalt", 4}, {"smalt", 1.5}, {"raw umber", 1}, medium=0.2}
work(knockM, {hand="broad", pile=knockW, tool="filbert 16", coverage=2.4, angle=0,
              pressure=0.5, clip=true, edge="lost", fill=true})
print("knocked the column")

--@ chunk 33
knockM2 = ellipse(650, 750, 190, 150):soften(90)
work(knockM2, {hand="broad", pile=knockW, tool="filbert 18", coverage=2.6, angle=0,
               pressure=0.5, clip=true, edge="lost", fill=true})
lpM = mask(function(x, y)
  if y < 698 or y > 990 then return 0 end
  local t = clamp((y - 700) / 290, 0, 1)
  local halfw = 14 + 150 * t
  local cx = 642 + 24 * t
  local u = math.abs(x - cx) / halfw
  return clamp(1 - u * u, 0, 1) * (1 - t) * (1 - t) * 0.85
end):soften(30)
lpP2 = pile{{"lead white", 22}, {"chrome yellow", 0.25}, {"yellow ochre", 0.2}, medium=0.6}
work(lpM, {hand="scumble", pile=lpP2, coverage=1.3, clip=true, edge="lost", fill=true})
print("path, gently")

--@ chunk 34
-- the far water is all mist: cover it with mist-white, then let the light glow through it
farW = rect(0, 698, 1000, 200)
mistW = pile{{"lead white", 14}, {"pale smalt", 3}, medium=0.18}
work(farW, {hand="body", pile=mistW, tool="filbert 20", coverage=2.6, angle=0,
            pressure=0.6, clip=true, edge="lost", fill=true})
glowM3 = ellipse(642, 700, 250, 95):soften(95)
work(glowM3, {hand="glaze", pile=warmThin, coverage=1.4, load=0.3, clip=true, edge="lost"})
print("mist-white far water")

--@ chunk 35
spotM = ellipse(665, 815, 80, 50):soften(45)
work(spotM, {hand="broad", pile=knockW, tool="filbert 14", coverage=2.6, angle=0,
             pressure=0.55, clip=true, edge="lost", fill=true})
n2 = noise{seed=17, octaves=4, period=200, persistence=0.6}
mistM2 = mask(function(x, y)
  local v = clamp(1 - (y - 820) / 150, 0, 1)
  local w = 0.5 + 0.5 * n2:at01(x * 1.1, y * 0.7)
  return clamp(v * w * 1.5, 0, 1)
end)
work(mistM2, {hand="scumble", pile=mistW, coverage=1.5, clip=true, edge="lost", fill=true})
print("mist feathered")

--@ chunk 36
stiffW = pile{{"lead white", 4}, {"pale smalt", 5}, {"smalt", 3}, {"raw umber", 2}}
work(spotM, {hand="body", pile=stiffW, tool="filbert 12", coverage=3.0, angle=0,
             pressure=0.7, clip=true, edge="lost", fill=true})
print("spot out", drying(665, 812))

--@ chunk 37
bankPts = {{0,1031},{60,1027},{120,1022},{180,1019},{240,1016},{300,1014},{350,1013},
           {400,1014},{455,1017},{510,1022},{560,1026},{630,1032},{700,1038},{780,1044},
           {850,1050},{930,1057},{1000,1063},{1000,1260},{0,1260}}
bankM = poly(bankPts, true)
bankP = pile{{"raw umber", 6}, {"bone black", 3}, {"green earth", 2}, {"yellow ochre", 1.5}}
work(bankM, {hand="broad", pile=bankP, tool="filbert 18", coverage=2.4,
             angle=-0.18, pressure={0.45, 0.6}, fill=true, edge="lost"})
print("bank")

--@ chunk 38
treeP = pile{{"bone black", 4}, {"raw umber", 4}, {"green earth", 1}}
local function limbs_of(T)
  local L = {}
  for i = 2, #T do L[#L+1] = {pts = T[i].pts, widths = T[i].w} end
  return L
end
O1 = body_of{spine = T1[1].pts, widths = T1[1].w, limbs = limbs_of(T1), blend = 0.92, char = "soft"}
O2 = body_of{spine = T2[1].pts, widths = T2[1].w, limbs = limbs_of(T2), blend = 0.92, char = "soft"}
O3 = body_of{spine = T3[1].pts, widths = T3[1].w, limbs = limbs_of(T3), blend = 0.92, char = "soft"}
m1 = O1:mask()
print(m1:area())
work(m1, {hand="body", pile=treeP, tool="filbert 10", coverage=1.8, pressure=0.45,
          clip=true, edge="soft", fill=true})
print("tree 1")

--@ chunk 39
treeP = pile{{"bone black", 5}, {"raw umber", 4}, {"green earth", 1.5}}
work(m1, {hand="body", pile=treeP, tool="filbert 12", coverage=3.4, pressure=0.72,
          clip=true, edge="soft", fill=true})
print("tree 1 darker")

--@ chunk 40
work(m1, {hand="broad", pile=treeP, tool="filbert 22", coverage=3.0, pressure=0.7,
          clip=true, fill=true, edge="soft"})
print("tree 1, broad")

--@ chunk 41
tp = rect(700, 300, 200, 100)
work(tp, {hand="body", pile=treeP, tool="filbert 24", coverage=6, pressure=1.0, fill=true, clip=true})
print(treeP)

--@ chunk 42
print(drying(180, 700))
blend(m1, {angle=1.2})
print("blended tree")

--@ chunk 43
skyFix = pile{{"lead white", 10}, {"pale smalt", 5}, {"cobalt blue", 0.6}, {"raw umber", 0.6}, medium=0.15}
work(rect(690, 290, 220, 120):soften(26), {hand="body", pile=skyFix, tool="filbert 22",
     coverage=3.0, pressure=0.6, fill=true, edge="lost"})
work(spotM:soften(18), {hand="body", pile=stiffW, tool="filbert 14", coverage=4.0,
     pressure=0.8, fill=true, edge="lost"})
print("fixed")

--@ chunk 44
print(drying(300, 900), drying(300, 780))
waterAll = rect(0, 696, 1000, 322)
work(waterAll, {hand="broad", pile=stiffW, tool="filbert 18", coverage=2.6, angle=0,
                pressure={0.45, 0.6}, fill=true, edge="soft", clip=true})
print("water reset")

--@ chunk 45
print(wait(3 * 24 * 60))
print(drying(300, 900), drying(300, 780), drying(642, 672), drying(500, 1050))

--@ chunk 46
work(waterAll, {hand="broad", pile=stiffW, tool="filbert 18", coverage=3.0, angle=0,
                pressure=0.7, fill=true, edge="soft", clip=true})
n3 = noise{seed=23, octaves=4, period=230, persistence=0.55}
mistM3 = mask(function(x, y)
  if y < 692 or y > 1010 then return 0 end
  local v = clamp(1 - (y - 720) / 150, 0, 1)
  local w = 0.3 + 0.7 * n3:at01(x * 0.9, y * 0.6)
  local v2 = clamp(1 - (y - 880) / 120, 0, 1) * clamp(n3:at01(x + 500, y * 1.3) * 1.8 - 0.6, 0, 1)
  return clamp(v * w * 1.7 + v2 * 0.7, 0, 1)
end)
work(mistM3, {hand="scumble", pile=mistW, coverage=1.8, clip=true, edge="lost", fill=true})
print("mist redone")

--@ chunk 47
hillsM2 = poly(hillPts, true) * rect(0, 655, 1000, 50)
hillsM2 = hillsM2:soften(6)
hillP2 = pile{{"lead white", 6}, {"pale smalt", 4}, {"smalt", 2}, {"raw umber", 1}, medium=0.3}
work(hillsM2, {hand="broad", pile=hillP2, tool="filbert 18", coverage=1.5, angle=0,
               pressure={0.3, 0.45}, clip=true, edge="lost"})

n4 = noise{seed=41, octaves=4, period=190, persistence=0.6}
wispM = mask(function(x, y)
  if y < 698 or y > 880 then return 0 end
  local v = clamp(1 - (y - 700) / 170, 0, 1)
  return clamp((n4:at01(x * 1.3, y * 0.8) * 1.9 - 0.85), 0, 1) * v
end)
wispP = pile{{"lead white", 8}, {"pale smalt", 3}, {"raw umber", 0.8}, medium=0.35}
work(wispM, {hand="scumble", pile=wispP, coverage=1.4, clip=true, edge="lost"})
print("hills and wisps")

--@ chunk 48
work(rect(650, 250, 330, 200):soften(60), {hand="body", pile=lw, tool="filbert 22",
     coverage=3.2, pressure=0.7, fill=true, edge="lost"})
patchBlue = blueRamp * rect(630, 230, 370, 250):soften(85)
work(patchBlue, {hand="glaze", pile=skyBlue, coverage=1.8, load=0.5, clip=true, edge="lost"})
print("patch feathered")

--@ chunk 49
m2 = O2:mask(); m3 = O3:mask()
work(m2, {hand="broad", pile=treeP, tool="filbert 20", coverage=2.8, pressure=0.65,
          clip=true, fill=true, edge="soft"})
work(m3, {hand="broad", pile=treeP, tool="filbert 14", coverage=2.8, pressure=0.6,
          clip=true, fill=true, edge="soft"})
blend(m2); blend(m3)
print("trees 2 and 3")

--@ chunk 50
treesM = m1 + m2 + m3
for i = 1, 3 do
  work(treesM, {hand="body", pile=treeP, tool="filbert 14", coverage=1.8, pressure=0.6,
                clip=true, fill=true, edge="soft"})
end
print("darkened", drying(180, 700))

--@ chunk 51
figM = poly({{487,1020},{488,1000},{490,980},{492,960},{494,946},{497,936},{501,930},
                {506,928},{512,931},{515,940},{515,953},{513,970},{511,986},{510,1002},{511,1020}},
               true):soften(1.2)
figP = pile{{"bone black", 5}, {"raw umber", 4}, {"green earth", 1}}
work(figM, {hand="detail", pile=figP, coverage=3.0, pressure=0.7, clip=true, fill=true})
print("figure")

--@ chunk 52
work(rect(474, 912, 56, 114):soften(7), {hand="body", pile=stiffW, tool="filbert 16",
     coverage=2.6, angle=0, pressure=0.6, fill=true, edge="lost"})
figM = poly({{499,926},{510,927},{514,935},{516,946},{520,952},{519,962},{516,978},
             {514,992},{515,1006},{518,1022},{483,1022},{485,1006},{487,992},
             {485,978},{483,962},{484,952},{488,946},{490,935}}, true):soften(1.2)
work(figM, {hand="detail", pile=figP, coverage=3.0, pressure=0.7, clip=true, fill=true})
print("figure redrawn")

--@ chunk 53
litP = pile{{"raw umber", 3}, {"lead white", 2.5}, {"green earth", 1}}
lightM = figM * mask(function(x, y) return clamp((x - 503) / 10, 0, 1) end)
work(lightM, {hand="detail", pile=litP, coverage=2.0, pressure=0.5, clip=true, fill=true})
hoodM = figM * mask(function(x, y) return clamp((952 - y) / 14, 0, 1) end)
                  * mask(function(x, y) return clamp((x - 499) / 12, 0, 1) end)
work(hoodM, {hand="detail", pile=litP, coverage=1.6, pressure=0.45, clip=true, fill=true})
dkP = pile{{"bone black", 6}, {"raw umber", 2}}
darkM = figM * mask(function(x, y) return clamp((496 - x) / 9, 0, 1) end)
work(darkM, {hand="detail", pile=dkP, coverage=1.6, pressure=0.5, clip=true, fill=true})
print("figure modelled")

--@ chunk 54
work(rect(470, 914, 64, 114):soften(7), {hand="body", pile=stiffW, tool="filbert 18",
     coverage=2.8, angle=0, pressure=0.6, fill=true, edge="lost"})
figM = poly({{502,900},{513,901},{516,909},{518,920},{521,928},{522,941},{519,957},
             {517,974},{518,992},{520,1011},{521,1022},{484,1022},{485,1011},
             {486,992},{487,974},{485,957},{482,941},{483,928},{486,920},
             {488,909},{490,901}}, true):soften(1.2)
work(figM, {hand="detail", pile=figP, coverage=3.2, pressure=0.7, clip=true, fill=true})
print("figure, larger")

--@ chunk 55
work(rect(472, 888, 62, 142):soften(8), {hand="body", pile=stiffW, tool="filbert 18",
     coverage=2.8, angle=0, pressure=0.6, fill=true, edge="lost"})
figM = poly({{495,899},{507,900},{510,908},{510,918},{513,925},{521,932},{523,945},
             {521,962},{520,978},{521,996},{523,1012},{524,1022},{481,1022},
             {482,1012},{484,996},{485,978},{484,962},{482,945},{484,932},
             {492,925},{495,918},{494,908}}, true):soften(1.0)
work(figM, {hand="detail", pile=figP, coverage=3.2, pressure=0.7, clip=true, fill=true})
print("figure, with head")

--@ chunk 56
work(figM * mask(function(x, y) return clamp((x - 503) / 9, 0, 1) end),
     {hand="detail", pile=litP, coverage=2.2, pressure=0.5, clip=true, fill=true})
work(figM * mask(function(x, y) return clamp((956 - y) / 16, 0, 1) end)
                * mask(function(x, y) return clamp((x - 500) / 11, 0, 1) end),
     {hand="detail", pile=litP, coverage=1.6, pressure=0.45, clip=true, fill=true})
work(figM * mask(function(x, y) return clamp((497 - x) / 9, 0, 1) end),
     {hand="detail", pile=dkP, coverage=1.6, pressure=0.5, clip=true, fill=true})
warmHem = pile{{"raw umber", 5}, {"red earth", 2}, {"yellow ochre", 1}}
work(figM * mask(function(x, y) return clamp((y - 988) / 28, 0, 1) end),
     {hand="detail", pile=warmHem, coverage=1.5, pressure=0.45, clip=true, fill=true})
print("figure finished")

--@ chunk 57
hzM = mask(function(x, y) return clamp((y - 545) / 150, 0, 1) end)
hzP = pile{{"lead white", 14}, {"chrome yellow", 1}, {"yellow ochre", 0.8}, {"vermilion", 0.2}, medium=0.4}
work(hzM, {hand="glaze", pile=hzP, coverage=1.5, load=0.35, clip=true, edge="lost"})
work(ellipse(642, 674, 58, 22):soften(20), {hand="body",
     pile=pile{{"lead white", 20}, {"chrome yellow", 0.45}, {"yellow ochre", 0.2}},
     coverage=2.0, pressure=0.55, edge="lost", clip=true})
print("sunlight")

--@ chunk 58
print(drying(500, 900), drying(500, 1150), drying(642, 660))
print(wait(2 * 24 * 60))
print(drying(500, 900), drying(500, 1150))

--@ chunk 59
work(waterAll, {hand="broad", pile=stiffW, tool="filbert 18", coverage=3.0, angle=0,
                pressure=0.7, fill=true, edge="soft", clip=true})
work(bankM, {hand="broad", pile=bankP, tool="filbert 18", coverage=3.0, angle=-0.18,
             pressure=0.7, fill=true, edge="soft"})
print("water and bank restored")

--@ chunk 60
lowerM = rect(0, 660, 1000, 380) * treesM
work(lowerM, {hand="body", pile=treeP, tool="filbert 14", coverage=2.4, pressure=0.65,
              clip=true, fill=true, edge="soft"})
work(figM, {hand="detail", pile=figP, coverage=3.0, pressure=0.7, clip=true, fill=true})
print("trees and figure back")

--@ chunk 61
mistBack = mistM3 - treesM - figM
work(mistBack, {hand="scumble", pile=mistW, coverage=1.8, clip=true, edge="lost", fill=true})
print("mist back on the water")

--@ chunk 62
mistM4 = mask(function(x, y)
  if y < 692 or y > 1000 then return 0 end
  local v = clamp(1 - (y - 715) / 175, 0, 1)
  local w = 0.72 + 0.28 * n3:at01(x * 0.8, y * 0.5)
  return clamp(v * w, 0, 1)
end)
work(mistM4 - treesM - figM, {hand="scumble", pile=mistW, coverage=1.7, clip=true,
                             edge="lost", fill=true})
hzM2 = mask(function(x, y) return clamp((y - 520) / 175, 0, 1) * clamp((702 - y) / 30, 0, 1) end)
work(hzM2, {hand="glaze", pile=hzP, coverage=1.3, load=0.3, clip=true, edge="lost"})
print("mist even, light on the horizon")

--@ chunk 63
work(treesM, {hand="body", pile=treeP, tool="filbert 16", coverage=2.6, pressure=0.65,
     clip=true, fill=true, edge="soft"})
work(figM, {hand="detail", pile=figP, coverage=2.4, pressure=0.65, clip=true, fill=true})
print("trees repainted")

--@ chunk 64
print(wait(2 * 24 * 60))
print(drying(200, 600))
for i = 1, 4 do
  work(treesM, {hand="body", pile=treeP, tool="filbert 16", coverage=1.9, pressure=0.62,
                clip=true, fill=true, edge="soft"})
end
work(figM, {hand="detail", pile=figP, coverage=2.6, pressure=0.7, clip=true, fill=true})
print("trees repainted firmly")

--@ chunk 65
sunWarm = pile{{"lead white", 12}, {"chrome yellow", 3}, {"yellow ochre", 1}}
sunM2 = ellipse(642, 666, 31, 30):soften(9)
work(sunM2, {hand="body", pile=sunWarm, coverage=2.6, pressure=0.6, clip=true, edge="lost"})
print("sun disk")

--@ chunk 66
skyZone = mask(function(x, y) return clamp((y - 440) / 90, 0, 1) * clamp((706 - y) / 26, 0, 1) end)
veilH = pile{{"lead white", 12}, {"pale smalt", 3}, {"raw umber", 0.5}, medium=0.25}
work(skyZone - treesM - sunM2:grow(120),
     {hand="body", pile=veilH, tool="filbert 22", coverage=2.0, pressure=0.6,
      fill=true, edge="lost"})
print("horizon veiled")

--@ chunk 67
hzZone = mask(function(x, y) return clamp((y - 420) / 80, 0, 1) * clamp((708 - y) / 22, 0, 1) end) - treesM
work(hzZone, {hand="body", pile=lw, tool="filbert 24", coverage=3.0, angle=0,
              pressure=0.75, fill=true, edge="lost"})
print("horizon cleaned")

--@ chunk 68
print("m1", m1:area(), "m2", m2:area(), "m3", m3:area(), "trees", treesM:area())
print("at 170,700:", treesM:at(170, 700), hzZone:at(170, 700))
print("at 200,600:", treesM:at(200, 600), hzZone:at(200, 600))
print("at 500,600:", treesM:at(500, 600), hzZone:at(500, 600))

--@ chunk 69
print(wait(24 * 60))
for i = 1, 4 do
  work(treesM, {hand="body", pile=treeP, tool="filbert 16", coverage=1.9, pressure=0.62,
                clip=true, fill=true, edge="soft"})
end
work(figM, {hand="detail", pile=figP, coverage=2.8, pressure=0.7, clip=true, fill=true})
print("trees firm")

--@ chunk 70
skyTone = pile{{"lead white", 10}, {"pale smalt", 4}, {"raw umber", 0.5}, medium=0.35}
work(hzZone, {hand="glaze", pile=skyTone, coverage=1.5, load=0.45, clip=true, edge="lost"})
work(sunM2, {hand="body", pile=pile{{"lead white", 20}, {"chrome yellow", 0.4}, {"yellow ochre", 0.2}},
     coverage=2.2, pressure=0.55, clip=true, edge="lost"})
work(ellipse(642, 664, 115, 58):soften(58), {hand="glaze", pile=warmThin,
     coverage=1.2, load=0.25, clip=true, edge="lost"})
print("sun and sky tone")

--@ chunk 71
haloM = (ellipse(642, 664, 165, 95):soften(50) - ellipse(642, 664, 66, 50):soften(32)) - treesM
work(haloM, {hand="glaze", pile=skyTone, coverage=1.7, load=0.5, clip=true, edge="lost"})
work(ellipse(642, 664, 34, 33):soften(7), {hand="body",
     pile=pile{{"lead white", 20}, {"chrome yellow", 0.5}, {"yellow ochre", 0.3}},
     coverage=2.6, pressure=0.6, clip=true, edge="lost"})
print("sun with a halo")

--@ chunk 72
treesSafe = treesM:grow(12)
for i = 1, 3 do
  work(treesM, {hand="body", pile=treeP, tool="filbert 16", coverage=1.9, pressure=0.62,
                clip=true, fill=true, edge="soft"})
end
print("trees firm again")

--@ chunk 73
tb = brush{kind="round", width=3.4, point=1, stiffness=0.55}
TW1 = {
  {{150,626},{128,600},{112,584}}, {{104,578},{96,548},{92,530}}, {{78,560},{64,534},{56,518}},
  {{44,540},{28,522},{18,510}},   {{132,606},{120,618},{108,626}},{{90,564},{78,586},{70,600}},
  {{124,790},{108,766},{98,750}}, {{86,808},{66,790},{54,778}},   {{52,824},{34,812},{22,804}},
  {{110,796},{104,822},{98,838}},
  {{214,584},{204,556},{198,538}},{{228,556},{238,528},{244,510}},{{246,516},{262,504},{274,496}},
  {{258,482},{278,472},{290,466}},
  {{216,730},{224,704},{228,688}},{{242,720},{252,692},{258,674}},{{270,712},{284,730},{294,742}},
  {{300,704},{312,678},{320,662}},{{326,700},{342,712},{352,720}},{{348,696},{366,676},{378,664}},
  {{384,690},{404,700},{418,706}},
  {{226,534},{218,508},{214,492}},{{252,516},{270,520},{284,522}},{{278,502},{288,478},{294,462}},
  {{312,486},{330,490},{342,492}},
  {{208,520},{196,498},{190,484}},{{214,492},{226,470},{232,456}},{{218,452},{206,434},{200,422}},
  {{222,404},{234,384},{240,372}},{{225,372},{214,356},{208,346}},{{224,340},{236,326},{242,318}},
  {{220,312},{210,300},{204,294}},
}
for i, p in ipairs(TW1) do
  if i % 3 == 1 then tb:load(treeP, 0.72) else tb:reload(treeP, 0.8) end
  tb:stroke(p, {pressure={0.8, 0.04}, ramps={0.03, 0.45}, orient="along"})
end
print("twigs on tree 1")

--@ chunk 74
tb = brush{kind="round", width=7, point=1, stiffness=0.55}
for i, p in ipairs(TW1) do
  if i % 3 == 1 then tb:load(treeP, 0.8) else tb:reload(treeP, 0.85) end
  tb:stroke(p, {pressure={1.0, 0.05}, ramps={0.04, 0.4}, orient="along"})
end
print("twigs thicker")

--@ chunk 75
local function limbs_from(paths, w0, w1, w2)
  local L = {}
  for i, p in ipairs(paths) do
    local pts = {}
    for k = 1, #p do pts[#pts+1] = p[k][1]; pts[#pts+1] = p[k][2] end
    L[#L+1] = {pts = pts, widths = {w0, w1, w2}}
  end
  return L
end
function twigfield(paths, w0, w1, w2)
  local L = limbs_from(paths, w0, w1, w2)
  return body_of{spine = L[1].pts, widths = L[1].widths,
                 limbs = {table.unpack(L, 2)}, blend = 0.9, char = "soft"}:mask()
end
tw1M = twigfield(TW1, 3.0, 1.7, 0.5)
work(tw1M, {hand="detail", pile=treeP, tool="round 2.4", coverage=2.4, pressure=0.8, clip=true})
print("twigs as a field", tw1M:area())

--@ chunk 76
TW1b = {
  {{128,600},{120,578},{114,566}}, {{112,584},{100,572},{92,566}}, {{96,548},{86,534},{80,528}},
  {{64,534},{58,512},{54,500}},   {{28,522},{20,504},{16,494}},   {{120,618},{116,636},{114,646}},
  {{78,586},{66,592},{58,596}},   {{108,766},{100,748},{96,738}}, {{66,790},{58,774},{54,764}},
  {{34,812},{26,800},{22,794}},   {{204,556},{196,540},{192,530}},{{238,528},{250,516},{258,510}},
  {{262,504},{276,514},{284,520}},{{278,472},{292,462},{300,456}},{{224,704},{236,692},{242,686}},
  {{252,692},{264,682},{272,676}},{{284,730},{298,742},{306,750}},{{312,678},{326,668},{334,662}},
  {{342,712},{356,720},{364,726}},{{366,676},{380,666},{388,660}},{{404,700},{418,712},{426,720}},
  {{218,508},{210,490},{206,480}},{{270,520},{284,528},{292,532}},{{288,478},{300,466},{308,460}},
  {{330,490},{344,496},{352,500}},{{196,498},{184,486},{178,480}},{{226,470},{238,458},{244,452}},
  {{206,434},{194,424},{188,418}},{{234,384},{246,372},{252,366}},{{214,356},{202,346},{196,340}},
  {{236,326},{248,318},{254,314}},{{210,300},{200,292},{194,288}},
}
tw1bM = twigfield(TW1b, 1.9, 1.0, 0.3)
work(tw1bM, {hand="detail", pile=treeP, tool="round 1.8", coverage=2.2, pressure=0.8, clip=true})
print("sub-twigs on tree 1")

--@ chunk 77
TW2 = {
  {{288,758},{280,732},{276,716}},{{256,724},{244,706},{236,694}},{{220,700},{206,684},{198,674}},
  {{240,706},{236,730},{234,744}},{{332,706},{326,680},{322,664}},{{372,672},{366,646},{362,630}},
  {{400,654},{412,634},{418,622}},{{356,684},{360,708},{362,722}},{{300,644},{288,620},{282,604}},
  {{278,600},{284,576},{288,562}},{{260,572},{248,556},{240,546}},{{326,824},{320,798},{316,784}},
  {{368,800},{362,776},{358,762}},{{402,786},{416,766},{424,754}},{{344,814},{350,838},{354,852}},
  {{328,560},{320,536},{316,522}},{{352,526},{364,506},{370,494}},{{366,516},{380,520},{390,522}},
  {{284,940},{272,918},{264,904}},{{252,920},{238,902},{230,892}},
}
TW2b = {
  {{280,732},{268,722},{262,716}},{{244,706},{234,690},{228,680}},{{206,684},{194,672},{188,664}},
  {{236,730},{230,748},{226,758}},{{326,680},{314,668},{308,662}},{{366,646},{358,628},{354,618}},
  {{412,634},{424,624},{430,618}},{{360,708},{368,726},{372,736}},{{288,620},{278,600},{272,590}},
  {{284,576},{296,566},{302,560}},{{248,556},{236,544},{230,538}},{{320,798},{310,780},{304,770}},
  {{362,776},{356,756},{352,746}},{{416,766},{428,754},{434,748}},{{350,838},{362,852},{368,860}},
  {{320,536},{308,524},{302,518}},{{364,506},{378,498},{386,494}},{{380,520},{394,526},{402,528}},
  {{272,918},{258,906},{250,898}},{{238,902},{224,892},{216,886}},
}
TW3 = {
  {{366,862},{356,840},{350,828}},{{322,832},{310,812},{302,800}},{{420,812},{432,792},{438,780}},
  {{370,762},{362,740},{358,728}},{{406,748},{418,730},{424,720}},{{384,930},{374,908},{368,896}},
}
TW3b = {
  {{356,840},{344,828},{338,820}},{{310,812},{298,800},{292,792}},{{432,792},{444,782},{450,776}},
  {{362,740},{350,728},{344,722}},{{418,730},{430,720},{436,714}},{{374,908},{362,896},{356,890}},
}
work(twigfield(TW2, 2.4, 1.4, 0.4), {hand="detail", pile=treeP, tool="round 2",
     coverage=2.4, pressure=0.8, clip=true})
work(twigfield(TW2b, 1.5, 0.8, 0.25), {hand="detail", pile=treeP, tool="round 1.6",
     coverage=2.2, pressure=0.8, clip=true})
work(twigfield(TW3, 1.9, 1.1, 0.35), {hand="detail", pile=treeP, tool="round 1.8",
     coverage=2.4, pressure=0.8, clip=true})
work(twigfield(TW3b, 1.2, 0.7, 0.2), {hand="detail", pile=treeP, tool="round 1.4",
     coverage=2.2, pressure=0.8, clip=true})
print("trees 2 and 3 branched")

--@ chunk 78
dryP = pile{{"lead white", 5}, {"raw umber", 3}, {"yellow ochre", 2}}
work(bankM, {hand="scumble", pile=dryP, tool="filbert 12", coverage=0.9, angle=-0.2,
             pressure={0.25, 0.45}, load=0.28, fill=false})
print("dry grass on the bank")

--@ chunk 79
work(bankM, {hand="broad", pile=bankP, tool="filbert 20", coverage=1.7, angle=-0.18,
             pressure=0.6, fill=true, edge="lost"})
dryP2 = pile{{"raw umber", 5}, {"yellow ochre", 2}, {"lead white", 1.5}}
work(bankM, {hand="scumble", pile=dryP2, tool="filbert 10", coverage=0.7, angle=-0.2,
             pressure={0.2, 0.4}, load=0.25, fill=false})
print("bank darkened, dry texture quieter")

--@ chunk 80
bankP2 = pile{{"raw umber", 6}, {"bone black", 3}, {"green earth", 2.5}}
work(bankM, {hand="broad", pile=bankP2, tool="filbert 20", coverage=2.0, angle=-0.18,
             pressure=0.62, fill=true, edge="lost"})
frontM = bankM * mask(function(x, y) return clamp((y - 1105) / 60, 0, 1) end)
work(frontM, {hand="broad", pile=bankP2, tool="filbert 22", coverage=1.4, angle=-0.25,
              pressure=0.65, fill=true, edge="lost"})
print("bank back to a dark foreground")

--@ chunk 81
waterNear = mask(function(x, y)
  if y < 820 or y > 1014 then return 0 end
  return clamp((y - 820) / 70, 0, 1) * clamp((1016 - y) / 22, 0, 1)
end)
waterNear = waterNear - treesSafe - figM
darkRip = pile{{"pale smalt", 3}, {"smalt", 2}, {"raw umber", 1.5}, medium=0.2}
work(waterNear, {hand="hatch", pile=darkRip, tool="round 2", coverage=0.85, angle=0,
                 pressure={0.3, 0.5}, clip=true, load=0.5})
lightRip = pile{{"lead white", 7}, {"pale smalt", 3}, medium=0.3}
work(waterNear, {hand="hatch", pile=lightRip, tool="round 2", coverage=0.6, angle=0,
                 pressure={0.25, 0.45}, clip=true, load=0.45})
print("ripples")

--@ chunk 82
work(waterNear, {hand="broad", pile=stiffW, tool="filbert 18", coverage=1.8, angle=0,
                 pressure=0.6, fill=true, clip=true})
print("water flattened")

--@ chunk 83
work(waterNear, {hand="hatch", pile=darkRip, tool="round 2", coverage=0.7, angle=0,
                 pressure={0.25, 0.45}, clip=true})
print("hatch ok")

--@ chunk 84
n5 = noise{seed=63, octaves=3, period=150, persistence=0.6}
ripM = mask(function(x, y)
  if y < 820 or y > 1014 then return 0 end
  local v = clamp((y - 820) / 70, 0, 1) * clamp((1016 - y) / 22, 0, 1)
  return clamp(v * clamp(n5:at01(x * 0.5, y * 2.6) * 2.4 - 0.85, 0, 1), 0, 1)
end) - treesSafe - figM
work(ripM, {hand="hatch", pile=darkRip, tool="round 2", coverage=0.9, angle=0,
            pressure={0.25, 0.45}, clip=true})
ripM2 = mask(function(x, y)
  if y < 830 or y > 1010 then return 0 end
  local v = clamp((y - 830) / 60, 0, 1) * clamp((1010 - y) / 20, 0, 1)
  return clamp(v * clamp(n5:at01(x * 0.42, y * 2.2) * 2.2 - 0.6, 0, 1), 0, 1)
end) - treesSafe - figM
work(ripM2, {hand="hatch", pile=lightRip, tool="round 2", coverage=0.8, angle=0,
             pressure={0.2, 0.4}, clip=true})
print("ripples in patches")

--@ chunk 85
boatM = poly({{688,884},{704,873},{742,871},{766,881},{744,886},{706,888}}, true):soften(0.8)
boatFig = poly({{739,872},{740,860},{742,850},{745,845},{748,850},{749,860},{750,872}}, true):soften(0.8)
work(boatM, {hand="detail", pile=treeP, coverage=2.6, pressure=0.7, clip=true, fill=true})
work(boatFig, {hand="detail", pile=treeP, coverage=2.4, pressure=0.7, clip=true, fill=true})
pb = brush{kind="round", width=2, point=1, stiffness=0.5}
pb:load(treeP, 0.8)
pb:stroke({{749,849},{758,838},{766,828}}, {pressure={0.8, 0.1}, ramps={0.05, 0.4}})
work(ellipse(726, 893, 44, 7):soften(7), {hand="body", pile=darkRip, coverage=0.8,
     pressure=0.4, edge="lost", fill=true})
print("the punt")

--@ chunk 86
grassP = pile{{"raw umber", 4}, {"yellow ochre", 3}, {"lead white", 1.2}}
grassBand = bankM * mask(function(x, y) return clamp(1 - (y - 1024) / 40, 0, 1) * 1.2 end)
stipple(grassBand, {pile=grassP, width=3.2, coverage=1.1, pressure={0.3, 0.65},
                    drag={9, -1.42}, cluster=0.5, feather=0.4})
print("grass along the shore")

--@ chunk 87
work(bankM, {hand="broad", pile=bankP2, tool="filbert 20", coverage=1.5, angle=-0.18,
             pressure=0.6, fill=true, edge="lost"})
grassP2 = pile{{"raw umber", 5}, {"yellow ochre", 0.8}, {"lead white", 1}}
stipple(grassBand, {pile=grassP2, width=3.0, coverage=0.8, pressure={0.25, 0.5},
                    drag={9, -1.42}, cluster=0.55, feather=0.5})
print("grass muted")

--@ chunk 88
skyTopBoost = mask(function(x, y) return clamp((570 - y) / 570, 0, 1) end) - treesSafe
work(skyTopBoost, {hand="glaze", pile=skyBlue, coverage=2.0, load=0.5, clip=true, edge="lost"})
n6 = noise{seed=88, octaves=3, period=420, persistence=0.5}
clM1 = mask(function(x, y)
  if y > 560 then return 0 end
  return clamp(n6:at01(x * 0.32, y * 1.7) * 3.1 - 1.7, 0, 1) * clamp((560 - y) / 260, 0, 1)
end) - treesSafe
work(clM1, {hand="glaze", pile=lw, coverage=1.5, load=0.55, clip=true, edge="lost"})
print("upper sky")

--@ chunk 89
work(skyTopBoost, {hand="glaze", pile=skyBlue, coverage=1.1, load=0.45, clip=true, edge="lost"})
n7 = noise{seed=91, octaves=2, period=600, persistence=0.45}
clM2 = mask(function(x, y)
  if y > 540 then return 0 end
  return clamp(n7:at01(x * 0.22, y * 0.85) * 2.1 - 0.78, 0, 1) * clamp((540 - y) / 300, 0, 1)
end) - treesSafe
work(clM2, {hand="glaze", pile=lw, coverage=1.3, load=0.5, clip=true, edge="lost"})
print("specks toned, broad cloud")

--@ chunk 90
work(figM * mask(function(x, y) return clamp((x - 504) / 8, 0, 1) end),
     {hand="detail", pile=litP, coverage=2.0, pressure=0.45, clip=true, fill=true})
work(figM * mask(function(x, y) return clamp((944 - y) / 13, 0, 1) end)
                * mask(function(x, y) return clamp((x - 500) / 11, 0, 1) end),
     {hand="detail", pile=litP, coverage=1.4, pressure=0.4, clip=true, fill=true})
work(figM * mask(function(x, y) return clamp((497 - x) / 8, 0, 1) end),
     {hand="detail", pile=dkP, coverage=1.5, pressure=0.45, clip=true, fill=true})
work(ellipse(474, 1022, 26, 6):soften(7), {hand="body", pile=dkP, coverage=1.0,
     pressure=0.4, edge="lost"})
print("figure modelled again")

--@ chunk 91
work(figM, {hand="detail", pile=figP, coverage=1.8, pressure=0.6, clip=true, fill=true})
litP2 = pile{{"raw umber", 3}, {"bone black", 2}, {"lead white", 0.9}}
work(figM * mask(function(x, y) return clamp((x - 506) / 7, 0, 1) end),
     {hand="detail", pile=litP2, coverage=1.2, pressure=0.4, clip=true, fill=true})
work(figM * mask(function(x, y) return clamp((944 - y) / 12, 0, 1) end)
                * mask(function(x, y) return clamp((x - 501) / 10, 0, 1) end),
     {hand="detail", pile=litP2, coverage=1.0, pressure=0.35, clip=true, fill=true})
print("figure, gentler light")

--@ chunk 92
local function field(spec)
  local L = {}
  for i, s in ipairs(spec) do L[#L+1] = {pts = s[1], widths = s[2]} end
  return body_of{spine = L[1].pts, widths = L[1].widths,
                 limbs = {table.unpack(L, 2)}, blend = 0.9, char = "soft"}:mask()
end
rootM = field({
  {{168,1022,140,1026,116,1032,98,1040}, {8,5.5,3.6,2.2}},
  {{170,1024,158,1036,150,1048,146,1058}, {8,5.5,3.6,2.2}},
  {{166,1022,190,1026,212,1032,230,1040}, {8,5.5,3.6,2.2}},
  {{172,1026,186,1036,196,1046}, {7,4.5,2.2}},
  {{164,1024,132,1030,104,1038,84,1046}, {8,5.5,3.6,2.2}},
  {{302,1016,282,1020,264,1026,250,1034}, {7,5,3.2,2}},
  {{304,1018,322,1022,338,1028,350,1036}, {7,5,3.2,2}},
  {{300,1018,280,1026,266,1036}, {6,4,2}},
  {{382,1013,366,1017,352,1022}, {6,4,2}},
  {{384,1015,398,1019,410,1024}, {6,4,2}},
})
work(rootM, {hand="detail", pile=bankP2, coverage=2.2, pressure=0.6, clip=true, fill=true})
crest = bankM * mask(function(x, y) return clamp(1 - (y - 1018) / 16, 0, 1) end)
work(crest, {hand="scumble", pile=grassP2, coverage=0.8, pressure=0.3, load=0.3, fill=false})
print("roots and a lit crest")

--@ chunk 93
bankGlaze = pile{{"bone black", 3}, {"raw umber", 4}, {"green earth", 1.5}, medium=0.35}
work(bankM, {hand="glaze", pile=bankGlaze, coverage=1.1, load=0.45, clip=true, edge="lost"})
print("bank glazed")

--@ chunk 94
bb = brush{kind="round", width=2.2, point=1, stiffness=0.4}
birdP = pile{{"bone black", 4}, {"raw umber", 3}}
local birds = {
  {{740,488},{744,485},{748,488}}, {{742,488},{746,487},{750,490}},
  {{784,454},{788,451},{792,454}}, {{786,454},{790,453},{794,456}},
  {{810,508},{814,505},{818,508}}, {{812,508},{816,507},{820,510}},
  {{698,442},{702,439},{706,442}}, {{700,442},{704,441},{708,444}},
  {{864,478},{869,475},{874,478}}, {{866,478},{871,477},{876,480}},
}
for i, p in ipairs(birds) do
  if i % 2 == 1 then bb:load(birdP, 0.7) else bb:reload(birdP, 0.8) end
  bb:stroke(p, {pressure={0.75, 0.25}, ramps={0.1, 0.3}})
end
print("birds")

--@ chunk 95
birdZone = ellipse(790, 470, 145, 95):soften(70)
work(birdZone, {hand="body", pile=lw, tool="filbert 20", coverage=2.6, angle=0,
     pressure=0.6, fill=true, edge="lost"})
work(birdZone * blueRamp, {hand="glaze", pile=skyBlue, coverage=1.8, load=0.5,
     clip=true, edge="lost"})
print("birds erased")

--@ chunk 96
bb = brush{kind="round", width=1.5, point=1, stiffness=0.4}
birdP = pile{{"bone black", 3}, {"raw umber", 3}, medium=0.15}
local birds2 = {
  {{736,486},{739,484},{742,486}}, {{738,486},{741,486},{744,488}},
  {{784,452},{787,450},{790,452}}, {{786,452},{789,452},{792,454}},
  {{810,506},{813,504},{816,506}}, {{812,506},{815,506},{818,508}},
  {{698,440},{701,438},{704,440}}, {{700,440},{703,440},{706,442}},
  {{864,478},{868,476},{872,478}}, {{866,478},{870,478},{874,480}},
}
for i, p in ipairs(birds2) do
  if i % 2 == 1 then bb:load(birdP, 0.65) else bb:reload(birdP, 0.8) end
  bb:stroke(p, {pressure={0.7, 0.15}, ramps={0.1, 0.3}})
end
print("small birds")

--@ chunk 97
sunGold = pile{{"lead white", 8}, {"chrome yellow", 5}, {"yellow ochre", 2}}
work(ellipse(642, 668, 27, 26):soften(7), {hand="body", pile=sunGold, coverage=2.4,
     pressure=0.6, clip=true, edge="lost"})
sunHalo = ellipse(642, 668, 155, 85):soften(75) - treesSafe
work(sunHalo, {hand="glaze", pile=pile{{"lead white", 12}, {"chrome yellow", 1.5}, {"yellow ochre", 1}},
     coverage=1.3, load=0.35, clip=true, edge="lost"})
print("the sun")

--@ chunk 98
sunZone = ellipse(642, 668, 230, 130):soften(110)
work(sunZone - treesSafe, {hand="body", pile=pile{{"lead white", 16}, {"pale smalt", 2}},
     tool="filbert 22", coverage=2.6, angle=0, pressure=0.6, fill=true, edge="lost", clip=true})
work((sunZone - treesSafe) * hzZone, {hand="glaze", pile=skyTone, coverage=1.4, load=0.45,
     clip=true, edge="lost"})
print("yellow knocked back")

--@ chunk 99
work(ellipse(642, 670, 23, 22):soften(6), {hand="body",
     pile=pile{{"lead white", 14}, {"chrome yellow", 2}, {"yellow ochre", 0.8}},
     coverage=2.2, pressure=0.55, clip=true, edge="lost"})
work(ellipse(642, 670, 120, 62):soften(62) - ellipse(642, 670, 34, 33):soften(20) - treesSafe,
     {hand="glaze", pile=pile{{"lead white", 14}, {"chrome yellow", 0.4}, {"yellow ochre", 0.4}},
     coverage=1.1, load=0.25, clip=true, edge="lost"})
print("sun disk")

--@ chunk 100
local sp = {{148,1082,11,6},{86,1042,7,4},{232,1094,14,7},{372,1062,9,5},
            {408,1030,6,4},{560,1044,8,4},{620,1076,12,6},{700,1040,7,4},
            {760,1100,16,8},{860,1058,10,5},{930,1096,13,7},{520,1120,15,8}}
stonesLo, stonesHi = everywhere() - everywhere(), everywhere() - everywhere()
for _, s in ipairs(sp) do
  stonesLo = stonesLo + ellipse(s[1], s[2] + 5, s[3] * 1.05, s[4] * 1.05)
  stonesHi = stonesHi + ellipse(s[1], s[2], s[3] * 0.88, s[4] * 0.85)
end
stonesLo = stonesLo:soften(4); stonesHi = stonesHi:soften(3)
work(stonesLo, {hand="body", pile=bankP2, coverage=1.4, pressure=0.5, clip=true, edge="lost"})
work(stonesHi, {hand="body", pile=pile{{"lead white", 4}, {"raw umber", 3}, {"yellow ochre", 1.5},
     {"pale smalt", 1}}, coverage=1.8, pressure=0.5, clip=true, edge="lost"})
print("stones on the bank")

--@ chunk 101
local function edgeY(x)
  for i = 1, #bankPts - 1 do
    if x >= bankPts[i][1] and x <= bankPts[i+1][1] then
      local t = (x - bankPts[i][1]) / (bankPts[i+1][1] - bankPts[i][1])
      return lerp(bankPts[i][2], bankPts[i+1][2], t)
    end
  end
  return bankPts[#bankPts][2]
end
shoreM = mask(function(x, y)
  if y < 1000 or y > 1080 then return 0 end
  return clamp(1 - (y - edgeY(x)) / 6, 0, 1)
end)
work(shoreM, {hand="scumble", pile=pile{{"lead white", 6}, {"raw umber", 2}, {"pale smalt", 1}},
     coverage=1.3, pressure=0.35, load=0.35, clip=true, fill=true})
print("the water's edge")

--@ chunk 102
work(shoreM, {hand="body", pile=bankP2, coverage=0.75, pressure=0.45,
     clip=true, fill=true, edge="lost"})
mistTongueM = mask(function(x, y)
  if y < 780 or y > 970 then return 0 end
  local v = clamp(1 - (y - 795) / 170, 0, 1)
  return clamp(v * clamp(n5:at01(x * 0.42 + 1.3, y * 1.8) * 2.3 - 0.95, 0, 1) * 1.5, 0, 1)
end) - treesSafe - figM
work(mistTongueM, {hand="scumble", pile=mistW, coverage=1.2, clip=true, edge="lost", fill=true})
print("shore softened, mist tongues")

--@ chunk 103
far = rect(688, 703, 196, 9)
for i = 1, 13 do
  local x = 696 + i * 14.2
  local h = 5 + 5 * (i % 3) + 2 * ((i * 7) % 2)
  far = far + ellipse(x, 707 - h * 0.45, 5.5, h)
end
far = far:soften(2.5)
work(far, {hand="detail", pile=pile{{"lead white", 6}, {"pale smalt", 3}, {"smalt", 1.5},
     {"raw umber", 0.8}}, coverage=2.0, pressure=0.45, clip=true, fill=true})
print("a far shore")

--@ chunk 104
work(far:grow(9), {hand="scumble", pile=mistW, coverage=1.5, pressure=0.4,
     clip=true, fill=true, edge="lost"})
print("far shore veiled")

--@ chunk 105
litEdge = treesM:offset(-2.2, 0) - treesM
print("lit edge area", litEdge:area())
work(litEdge, {hand="detail", pile=pile{{"lead white", 5}, {"raw umber", 2.5}, {"pale smalt", 1}},
     coverage=1.3, pressure=0.4, clip=true, edge="lost"})
print("rim light on the branches")

--@ chunk 106
function limbs_from(paths, w0, w1, w2)
  local L = {}
  for i, p in ipairs(paths) do
    local pts = {}
    for k = 1, #p do pts[#pts+1] = p[k][1]; pts[#pts+1] = p[k][2] end
    L[#L+1] = {pts = pts, widths = {w0, w1, w2}}
  end
  return L
end
function twigfield2(paths, w0, w1, w2, ch)
  local L = limbs_from(paths, w0, w1, w2)
  return body_of{spine = L[1].pts, widths = L[1].widths,
                 limbs = {table.unpack(L, 2)}, blend = 0.9, char = ch}:mask()
end
work(twigfield2(TW1, 3.0, 1.7, 0.5, "firm"), {hand="detail", pile=treeP,
     tool="round 2.2", coverage=1.8, pressure=0.7, clip=true})
work(twigfield2(TW1b, 1.9, 1.0, 0.3, "firm"), {hand="detail", pile=treeP,
     tool="round 1.6", coverage=1.8, pressure=0.7, clip=true})
work(twigfield2(TW2, 2.4, 1.4, 0.4, "firm"), {hand="detail", pile=treeP,
     tool="round 2", coverage=1.8, pressure=0.7, clip=true})
work(twigfield2(TW2b, 1.5, 0.8, 0.25, "firm"), {hand="detail", pile=treeP,
     tool="round 1.6", coverage=1.8, pressure=0.7, clip=true})
work(twigfield2(TW3, 1.9, 1.1, 0.35, "firm"), {hand="detail", pile=treeP,
     tool="round 1.8", coverage=1.8, pressure=0.7, clip=true})
work(twigfield2(TW3b, 1.2, 0.7, 0.2, "firm"), {hand="detail", pile=treeP,
     tool="round 1.4", coverage=1.8, pressure=0.7, clip=true})
print("crisper branches")

--@ chunk 107
print(wait(4 * 24 * 60))
print(drying(500, 300), drying(642, 670), drying(180, 700), drying(500, 1150), drying(700, 900))

--@ chunk 108
function edgeY(x)
  for i = 1, #bankPts - 1 do
    if x >= bankPts[i][1] and x <= bankPts[i+1][1] then
      local t = (x - bankPts[i][1]) / (bankPts[i+1][1] - bankPts[i][1])
      return lerp(bankPts[i][2], bankPts[i+1][2], t)
    end
  end
  return bankPts[#bankPts][2]
end
coverRect = rect(468, 888, 76, 146)
waterPart = mask(function(x, y) return clamp((edgeY(x) + 2 - y) / 8, 0, 1) end)
work(coverRect * waterPart, {hand="body", pile=stiffW, tool="filbert 18", coverage=2.8,
     angle=0, pressure=0.6, fill=true, edge="lost"})
work(coverRect - (coverRect * waterPart), {hand="body", pile=bankP2, tool="filbert 16",
     coverage=2.4, angle=-0.2, pressure=0.6, fill=true, edge="lost"})
print("old figure covered")

--@ chunk 109
figM = poly({{497,899},{505,898},{511,903},{513,912},{512,921},{516,927},{523,934},
             {525,944},{524,958},{522,972},{521,986},{522,1000},{524,1014},{525,1021},
             {484,1021},{485,1014},{487,1000},{488,986},{487,972},{485,958},{484,944},
             {486,934},{492,927},{494,921},{493,912},{494,906}}, true):soften(1.0)
work(figM, {hand="detail", pile=figP, coverage=3.0, pressure=0.68, clip=true, fill=true})
print("new figure")

--@ chunk 110
print(drying(500, 950))
blend(figM)
print("blended")

--@ chunk 111
armM = figM * mask(function(x, y)
  if y < 936 or y > 1016 then return 0 end
  return clamp(1 - math.abs(x - (523.5 - 0.05 * (y - 944))) / 3.4, 0, 1)
end)
work(armM, {hand="detail", pile=dkP, coverage=0.9, pressure=0.4, clip=true, fill=true})
work(figM * mask(function(x, y) return clamp((934 - y) / 12, 0, 1) end),
     {hand="detail", pile=dkP, coverage=0.9, pressure=0.4, clip=true, fill=true})
work(figM * mask(function(x, y) return clamp((944 - y) / 14, 0, 1) end)
                * mask(function(x, y) return clamp((x - 502) / 12, 0, 1) end),
     {hand="detail", pile=litP2, coverage=1.1, pressure=0.38, clip=true, fill=true})
work(figM * mask(function(x, y) return clamp((1006 - y) / 18, 0, 1) end),
     {hand="detail", pile=warmHem, coverage=0.9, pressure=0.4, clip=true, fill=true})
print("figure modelled")

--@ chunk 112
work(figM, {hand="detail", pile=figP, coverage=2.2, pressure=0.6, clip=true, fill=true})
blend(figM)
work(armM, {hand="detail", pile=dkP, coverage=0.6, pressure=0.35, clip=true, fill=true})
work(figM * mask(function(x, y) return clamp((934 - y) / 12, 0, 1) end),
     {hand="detail", pile=dkP, coverage=0.6, pressure=0.35, clip=true, fill=true})
work(figM * mask(function(x, y) return clamp((944 - y) / 14, 0, 1) end)
                * mask(function(x, y) return clamp((x - 502) / 12, 0, 1) end),
     {hand="detail", pile=litP2, coverage=0.7, pressure=0.3, clip=true, fill=true})
print("figure, quieter")

--@ chunk 113
work(boatM, {hand="detail", pile=treeP, coverage=1.6, pressure=0.6, clip=true, fill=true})
work(boatFig, {hand="detail", pile=treeP, coverage=1.6, pressure=0.6, clip=true, fill=true})
pb:load(treeP, 0.8)
pb:stroke({{749,849},{758,838},{766,828}}, {pressure={0.8, 0.1}, ramps={0.05, 0.4}})
work(ellipse(642, 670, 96, 50):soften(48) - ellipse(642, 670, 30, 29):soften(14) - treesSafe,
     {hand="glaze", pile=pile{{"lead white", 16}, {"chrome yellow", 0.5}, {"yellow ochre", 0.4}},
     coverage=1.2, load=0.3, clip=true, edge="lost"})
print("boat and light")

--@ chunk 114
function limbs_of(T)
  local L = {}
  for i = 2, #T do L[#L+1] = {pts = T[i].pts, widths = T[i].w} end
  return L
end
O1f = body_of{spine = T1[1].pts, widths = T1[1].w, limbs = limbs_of(T1), blend = 0.92, char = "firm"}
O2f = body_of{spine = T2[1].pts, widths = T2[1].w, limbs = limbs_of(T2), blend = 0.92, char = "firm"}
O3f = body_of{spine = T3[1].pts, widths = T3[1].w, limbs = limbs_of(T3), blend = 0.92, char = "firm"}
for _, o in ipairs({O1f, O2f, O3f}) do
  work(o:mask(), {hand="detail", pile=treeP, tool="round 2.6", coverage=1.6, pressure=0.6,
        clip=true, edge="soft"})
end
print("trunks and limbs sharpened")

--@ chunk 115
pz = mask(function(x, y)
  if y < 810 or y > 1045 then return 0 end
  return clamp((x - 385) / 38, 0, 1) * clamp((665 - x) / 38, 0, 1) *
         clamp((y - 810) / 34, 0, 1) * clamp((1045 - y) / 26, 0, 1)
end) - figM
pzWater = pile{{"lead white", 7}, {"pale smalt", 4}, {"smalt", 1.5}, {"raw umber", 0.8}, medium=0.2}
work(pz, {hand="broad", pile=pzWater, tool="filbert 18", coverage=2.2, angle=0,
          pressure=0.6, fill=true, clip=true, edge="lost"})
print("water patch repaired")

--@ chunk 116
work(pz, {hand="broad", pile=stiffW, tool="filbert 18", coverage=2.4, angle=0,
          pressure=0.62, fill=true, clip=true, edge="lost"})
work(pz, {hand="hatch", pile=darkRip, tool="round 2", coverage=0.8, angle=0,
          pressure={0.25, 0.45}, clip=true})
work(pz, {hand="hatch", pile=lightRip, tool="round 2", coverage=0.6, angle=0,
          pressure={0.2, 0.4}, clip=true})
work(pz * mask(function(x, y) return clamp(1 - (y - 830) / 150, 0, 1) end),
     {hand="scumble", pile=mistW, coverage=1.1, clip=true, edge="lost", fill=true})
work(figM, {hand="detail", pile=figP, coverage=2.2, pressure=0.6, clip=true, fill=true})
blend(figM)
print("water and figure redone")

--@ chunk 117
print(wait(2 * 24 * 60))
waterNear = mask(function(x, y)
  if y < 820 or y > 1014 then return 0 end
  return clamp((y - 820) / 70, 0, 1) * clamp((1016 - y) / 22, 0, 1)
end) - treesSafe - figM
work(waterNear, {hand="broad", pile=stiffW, tool="filbert 18", coverage=2.4, angle=0,
                 pressure=0.62, fill=true, clip=true, edge="soft"})
print("whole water reset")

--@ chunk 118
work(ripM, {hand="hatch", pile=darkRip, tool="round 2", coverage=0.9, angle=0,
            pressure={0.25, 0.45}, clip=true})
work(ripM2, {hand="hatch", pile=lightRip, tool="round 2", coverage=0.8, angle=0,
             pressure={0.2, 0.4}, clip=true})
work(mistTongueM, {hand="scumble", pile=mistW, coverage=1.2, clip=true, edge="lost", fill=true})
print("ripples and tongues over the whole lake")

--@ chunk 119
print(wait(2 * 24 * 60))
waterNear2 = mask(function(x, y)
  if y < 820 or y > 1014 then return 0 end
  return clamp((y - 820) / 70, 0, 1) * clamp((1016 - y) / 22, 0, 1)
end) - treesM:grow(3) - figM:grow(2)
work(waterNear2, {hand="broad", pile=stiffW, tool="filbert 18", coverage=2.2, angle=0,
                  pressure=0.62, fill=true, clip=true, edge="soft"})
print("water, thin haloes")

--@ chunk 120
work(ripM, {hand="hatch", pile=darkRip, tool="round 2", coverage=0.9, angle=0,
            pressure={0.25, 0.45}, clip=true})
work(ripM2, {hand="hatch", pile=lightRip, tool="round 2", coverage=0.8, angle=0,
             pressure={0.2, 0.4}, clip=true})
print("ripples again")

--@ chunk 121
print(wait(2 * 24 * 60))
work(waterNear2, {hand="broad", pile=stiffW, tool="filbert 18", coverage=3.2, angle=0,
                  pressure=0.7, fill=true, clip=true, edge="soft"})
work(ripM, {hand="hatch", pile=darkRip, tool="round 2", coverage=0.9, angle=0,
            pressure={0.25, 0.45}, clip=true})
work(ripM2, {hand="hatch", pile=lightRip, tool="round 2", coverage=0.8, angle=0,
             pressure={0.2, 0.4}, clip=true})
print("water laid again, firmly")

--@ chunk 122
print(wait(2 * 24 * 60))
lakeAll = mask(function(x, y)
  if y < 820 or y > 1014 then return 0 end
  return clamp((y - 820) / 70, 0, 1) * clamp((1016 - y) / 22, 0, 1)
end)
work(lakeAll, {hand="broad", pile=stiffW, tool="filbert 18", coverage=2.0, angle=0,
               pressure=0.62, fill=true, clip=true, edge="soft"})
work(lakeAll, {hand="hatch", pile=darkRip, tool="round 2", coverage=0.85, angle=0,
               pressure={0.25, 0.45}, clip=true})
work(lakeAll, {hand="hatch", pile=lightRip, tool="round 2", coverage=0.7, angle=0,
               pressure={0.2, 0.4}, clip=true})
print("whole lake, no holes")

--@ chunk 123
work(figM, {hand="detail", pile=figP, coverage=2.4, pressure=0.62, clip=true, fill=true})
work(mask(function(x, y) return clamp((y - 810) / 30, 0, 1) end) * treesM,
     {hand="detail", pile=treeP, tool="round 3", coverage=1.8, pressure=0.6, clip=true})
work(mistTongueM, {hand="scumble", pile=mistW, coverage=1.1, clip=true, edge="lost", fill=true})
print("figure and trunks back")

--@ chunk 124
work(lakeAll, {hand="broad", pile=stiffW, tool="filbert 18", coverage=2.0, angle=0,
               pressure=0.6, fill=true, clip=true, edge="soft"})
ripA = mask(function(x, y)
  if y < 820 or y > 1014 then return 0 end
  local v = clamp((y - 820) / 70, 0, 1) * clamp((1016 - y) / 22, 0, 1)
  return clamp(v * clamp(n5:at01(x * 0.5, y * 2.6) * 2.4 - 0.85, 0, 1), 0, 1)
end)
ripB = mask(function(x, y)
  if y < 830 or y > 1010 then return 0 end
  local v = clamp((y - 830) / 60, 0, 1) * clamp((1010 - y) / 20, 0, 1)
  return clamp(v * clamp(n5:at01(x * 0.42, y * 2.2) * 2.2 - 0.6, 0, 1), 0, 1)
end)
work(ripA, {hand="hatch", pile=darkRip, tool="round 2", coverage=0.9, angle=0,
            pressure={0.25, 0.45}, clip=true})
work(ripB, {hand="hatch", pile=lightRip, tool="round 2", coverage=0.8, angle=0,
            pressure={0.2, 0.4}, clip=true})
print("ripples spread over the lake")

--@ chunk 125
work(mask(function(x, y) return clamp((y - 800) / 30, 0, 1) end) * treesM,
     {hand="detail", pile=treeP, tool="round 3.2", coverage=2.6, pressure=0.68, clip=true, fill=true})
work(figM, {hand="detail", pile=figP, coverage=2.8, pressure=0.7, clip=true, fill=true})
print("trunks and figure, firmly")

--@ chunk 126
print(wait(2 * 24 * 60))
work(lakeAll, {hand="glaze", pile=pile{{"pale smalt", 3}, {"smalt", 2}, {"raw umber", 1.5},
     medium=0.4}, coverage=1.4, load=0.5, clip=true, edge="lost"})
work(lakeAll, {hand="hatch", pile=darkRip, tool="round 2", coverage=0.5, angle=0,
               pressure=0.3, clip=true})
work(lakeAll, {hand="hatch", pile=lightRip, tool="round 2", coverage=0.45, angle=0,
               pressure=0.25, clip=true})
print("lake unified")

--@ chunk 127
work(mask(function(x, y) return clamp((y - 800) / 30, 0, 1) end) * treesM,
     {hand="detail", pile=treeP, tool="round 3.2", coverage=3.0, pressure=0.72, clip=true, fill=true})
work(figM, {hand="detail", pile=figP, coverage=3.0, pressure=0.72, clip=true, fill=true})
print("trunks and figure restored")

--@ chunk 128
work(boatM, {hand="detail", pile=treeP, coverage=2.6, pressure=0.68, clip=true, fill=true})
work(boatFig, {hand="detail", pile=treeP, coverage=2.4, pressure=0.68, clip=true, fill=true})
pb:load(treeP, 0.85)
pb:stroke({{749,849},{758,838},{766,828}}, {pressure={0.85, 0.12}, ramps={0.05, 0.4}})
print("the punt again")

--@ chunk 129
work(everywhere(), {hand="glaze", pile=pile{{"pale smalt", 5}, {"raw umber", 1.2},
     medium=0.65}, coverage=1.0, load=0.35, edge="lost"})
print("final unifying glaze")

--@ chunk 130
print(wait(3 * 24 * 60))
print(drying(500, 300), drying(500, 900), drying(500, 1150))
work(skyM, {hand="body", pile=lw, tool="filbert 24", coverage=3.0, angle=0,
            pressure=0.75, fill=true, clip=true, edge="lost"})
work(blueRamp, {hand="glaze", pile=skyBlue, coverage=2.4, load=0.5, clip=true, edge="lost"})
print("sky re-laid")

--@ chunk 131
work(clM2, {hand="glaze", pile=lw, coverage=1.3, load=0.5, clip=true, edge="lost"})
work(hzZone, {hand="glaze", pile=skyTone, coverage=1.5, load=0.45, clip=true, edge="lost"})
work(ellipse(642, 670, 23, 22):soften(6), {hand="body",
     pile=pile{{"lead white", 14}, {"chrome yellow", 2}, {"yellow ochre", 0.8}},
     coverage=2.2, pressure=0.55, clip=true, edge="lost"})
work(ellipse(642, 670, 110, 56):soften(55) - ellipse(642, 670, 34, 33):soften(18),
     {hand="glaze", pile=pile{{"lead white", 15}, {"chrome yellow", 0.45}, {"yellow ochre", 0.4}},
     coverage=1.1, load=0.25, clip=true, edge="lost"})
work(hillsM2, {hand="broad", pile=hillP2, tool="filbert 18", coverage=1.5, angle=0,
               pressure={0.3, 0.45}, clip=true, edge="lost"})
print("sky finished")

--@ chunk 132
work(mistM4, {hand="scumble", pile=mistW, coverage=1.7, clip=true, edge="lost", fill=true})
work(lakeAll, {hand="broad", pile=stiffW, tool="filbert 18", coverage=2.0, angle=0,
               pressure=0.62, fill=true, clip=true, edge="soft"})
print("mist and lake")

--@ chunk 133
work(ripA, {hand="hatch", pile=darkRip, tool="round 2", coverage=0.9, angle=0,
            pressure={0.25, 0.45}, clip=true})
work(ripB, {hand="hatch", pile=lightRip, tool="round 2", coverage=0.8, angle=0,
            pressure={0.2, 0.4}, clip=true})
work(mistTongueM, {hand="scumble", pile=mistW, coverage=1.1, clip=true, edge="lost", fill=true})
work(lakeAll, {hand="glaze", pile=pile{{"pale smalt", 3}, {"smalt", 2}, {"raw umber", 1.5},
     medium=0.4}, coverage=1.1, load=0.4, clip=true, edge="lost"})
print("lake finished")

--@ chunk 134
work(bankM, {hand="broad", pile=bankP2, tool="filbert 20", coverage=2.6, angle=-0.18,
             pressure=0.7, fill=true, edge="lost"})
work(frontM, {hand="broad", pile=bankP2, tool="filbert 22", coverage=1.2, angle=-0.25,
              pressure=0.65, fill=true, edge="lost"})
for _, o in ipairs({O1f, O2f, O3f}) do
  work(o:mask(), {hand="detail", pile=treeP, tool="round 2.6", coverage=2.4, pressure=0.68, clip=true})
end
for _, o in ipairs({O1f, O2f, O3f}) do
  work(o:mask(), {hand="detail", pile=treeP, tool="round 2.6", coverage=1.6, pressure=0.62, clip=true})
end
work(figM, {hand="detail", pile=figP, coverage=2.8, pressure=0.7, clip=true, fill=true})
print("bank, trees, figure")

--@ chunk 135
work(twigfield2(TW1, 3.0, 1.7, 0.5, "firm"), {hand="detail", pile=treeP,
     tool="round 2.2", coverage=2.0, pressure=0.68, clip=true})
work(twigfield2(TW1b, 1.9, 1.0, 0.3, "firm"), {hand="detail", pile=treeP,
     tool="round 1.6", coverage=2.0, pressure=0.68, clip=true})
work(twigfield2(TW2, 2.4, 1.4, 0.4, "firm"), {hand="detail", pile=treeP,
     tool="round 2", coverage=2.0, pressure=0.68, clip=true})
work(twigfield2(TW2b, 1.5, 0.8, 0.25, "firm"), {hand="detail", pile=treeP,
     tool="round 1.6", coverage=2.0, pressure=0.68, clip=true})
work(twigfield2(TW3, 1.9, 1.1, 0.35, "firm"), {hand="detail", pile=treeP,
     tool="round 1.8", coverage=2.0, pressure=0.68, clip=true})
work(twigfield2(TW3b, 1.2, 0.7, 0.2, "firm"), {hand="detail", pile=treeP,
     tool="round 1.4", coverage=2.0, pressure=0.68, clip=true})
print("branches")

--@ chunk 136
for _, o in ipairs({O1f, O2f, O3f}) do
  work(o:mask(), {hand="detail", pile=treeP, tool="round 2.6", coverage=1.6, pressure=0.62, clip=true})
end
work(treesM, {hand="body", pile=treeP, tool="filbert 14", coverage=1.4, pressure=0.6,
     clip=true, fill=true, edge="soft"})
work(litEdge, {hand="detail", pile=pile{{"lead white", 5}, {"raw umber", 2.5}, {"pale smalt", 1}},
     coverage=1.3, pressure=0.4, clip=true, edge="lost"})
print("trees darkened and lit")

--@ chunk 137
stipple(grassBand, {pile=grassP2, width=3.0, coverage=0.8, pressure={0.25, 0.5},
                    drag={9, -1.42}, cluster=0.55, feather=0.5})
work(stonesLo, {hand="body", pile=bankP2, coverage=1.4, pressure=0.5, clip=true, edge="lost"})
work(stonesHi, {hand="body", pile=pile{{"lead white", 4}, {"raw umber", 3}, {"yellow ochre", 1.5},
     {"pale smalt", 1}}, coverage=1.6, pressure=0.45, clip=true, edge="lost"})
work(rootM, {hand="detail", pile=bankP2, coverage=2.0, pressure=0.58, clip=true, fill=true})
work(shoreM, {hand="scumble", pile=pile{{"lead white", 6}, {"raw umber", 2}, {"pale smalt", 1}},
     coverage=1.1, pressure=0.35, load=0.35, clip=true, fill=true})
print("bank details")

--@ chunk 138
birds2 = {
  {{736,486},{739,484},{742,486}}, {{738,486},{741,486},{744,488}},
  {{784,452},{787,450},{790,452}}, {{786,452},{789,452},{792,454}},
  {{810,506},{813,504},{816,506}}, {{812,506},{815,506},{818,508}},
  {{698,440},{701,438},{704,440}}, {{700,440},{703,440},{706,442}},
  {{864,478},{868,476},{872,478}}, {{866,478},{870,478},{874,480}},
}
work(boatM, {hand="detail", pile=treeP, coverage=2.4, pressure=0.68, clip=true, fill=true})
work(boatFig, {hand="detail", pile=treeP, coverage=2.2, pressure=0.68, clip=true, fill=true})
pb:load(treeP, 0.85)
pb:stroke({{749,849},{758,838},{766,828}}, {pressure={0.85, 0.12}, ramps={0.05, 0.4}})
bb:load(birdP, 0.7)
for _, p in ipairs(birds2) do
  bb:reload(birdP, 0.85)
  bb:stroke(p, {pressure={0.7, 0.15}, ramps={0.1, 0.3}})
end
work(far:grow(6), {hand="scumble", pile=mistW, coverage=1.2, pressure=0.4,
     clip=true, fill=true, edge="lost"})
print("boat, birds, far shore")

--@ chunk 139
work(bankM, {hand="broad", pile=bankP2, tool="filbert 20", coverage=2.4, angle=-0.18,
             pressure=0.68, fill=true, clip=true, edge="soft"})
work(stonesHi, {hand="body", pile=pile{{"raw umber", 4}, {"lead white", 1.5}, {"pale smalt", 0.8}},
     coverage=1.2, pressure=0.45, clip=true, edge="lost"})
stipple(grassBand, {pile=grassP2, width=3.0, coverage=0.7, pressure={0.25, 0.45},
                    drag={9, -1.42}, cluster=0.55, feather=0.5})
work(frontM, {hand="broad", pile=bankP2, tool="filbert 22", coverage=1.0, angle=-0.25,
              pressure=0.65, fill=true, clip=true, edge="lost"})
print("bank darkened")

--@ chunk 140
lakeNear = mask(function(x, y)
  if y < 930 or y > 1016 then return 0 end
  return clamp((y - 930) / 80, 0, 1) * clamp((1018 - y) / 20, 0, 1)
end)
work(lakeNear, {hand="broad", pile=pile{{"lead white", 3}, {"pale smalt", 4}, {"smalt", 3},
     {"raw umber", 2}}, tool="filbert 18", coverage=1.3, angle=0, pressure=0.55,
     clip=true, fill=true})
work(mask(function(x, y) return clamp((y - 800) / 30, 0, 1) end) * treesM,
     {hand="detail", pile=treeP, tool="round 3.2", coverage=2.6, pressure=0.7, clip=true, fill=true})
work(figM, {hand="detail", pile=figP, coverage=2.6, pressure=0.7, clip=true, fill=true})
print("near water darkened, trunks and figure back")

--@ chunk 141
print(drying(500, 200), drying(500, 400))
if drying(500, 200) == "open" then blend(skyM, {angle=0.05}) print("sky blended") else print("too set to blend") end

--@ chunk 142
skySafe = skyM - treesSafe
work(skySafe, {hand="body", pile=pile{{"lead white", 15}, {"pale smalt", 3}}, tool="filbert 22",
     coverage=1.9, angle=0, pressure=0.68, fill=true, clip=true, edge="lost"})
work(blueRamp, {hand="glaze", pile=skyBlue, coverage=2.2, load=0.5, clip=true, edge="lost"})
work(clM2, {hand="glaze", pile=lw, coverage=1.2, load=0.5, clip=true, edge="lost"})
print("sky veiled and re-blued")

--@ chunk 143
for _, o in ipairs({O1f, O2f, O3f}) do
  for i = 1, 2 do
    work(o:mask(), {hand="detail", pile=treeP, tool="round 2.6", coverage=1.8, pressure=0.66, clip=true})
  end
end
work(twigfield2(TW1, 3.0, 1.7, 0.5, "firm"), {hand="detail", pile=treeP,
     tool="round 2.2", coverage=1.8, pressure=0.66, clip=true})
work(twigfield2(TW1b, 1.9, 1.0, 0.3, "firm"), {hand="detail", pile=treeP,
     tool="round 1.6", coverage=1.8, pressure=0.66, clip=true})
work(twigfield2(TW2, 2.4, 1.4, 0.4, "firm"), {hand="detail", pile=treeP,
     tool="round 2", coverage=1.8, pressure=0.66, clip=true})
work(twigfield2(TW2b, 1.5, 0.8, 0.25, "firm"), {hand="detail", pile=treeP,
     tool="round 1.6", coverage=1.8, pressure=0.66, clip=true})
work(twigfield2(TW3, 1.9, 1.1, 0.35, "firm"), {hand="detail", pile=treeP,
     tool="round 1.8", coverage=1.8, pressure=0.66, clip=true})
work(twigfield2(TW3b, 1.2, 0.7, 0.2, "firm"), {hand="detail", pile=treeP,
     tool="round 1.4", coverage=1.8, pressure=0.66, clip=true})
work(figM, {hand="detail", pile=figP, coverage=2.6, pressure=0.68, clip=true, fill=true})
print("trees and figure, firm again")

--@ chunk 144
print(wait(3 * 24 * 60))
print(drying(500, 300), drying(500, 900), drying(500, 1150))
for _, o in ipairs({O1f, O2f, O3f}) do
  for i = 1, 3 do
    work(o:mask(), {hand="detail", pile=treeP, tool="round 2.6", coverage=1.8, pressure=0.68, clip=true})
  end
end
print("trunks over dry sky")

--@ chunk 145
work(twigfield2(TW1, 3.0, 1.7, 0.5, "firm"), {hand="detail", pile=treeP,
     tool="round 2.2", coverage=2.0, pressure=0.68, clip=true})
work(twigfield2(TW1b, 1.9, 1.0, 0.3, "firm"), {hand="detail", pile=treeP,
     tool="round 1.6", coverage=2.0, pressure=0.68, clip=true})
work(twigfield2(TW2, 2.4, 1.4, 0.4, "firm"), {hand="detail", pile=treeP,
     tool="round 2", coverage=2.0, pressure=0.68, clip=true})
work(twigfield2(TW2b, 1.5, 0.8, 0.25, "firm"), {hand="detail", pile=treeP,
     tool="round 1.6", coverage=2.0, pressure=0.68, clip=true})
work(twigfield2(TW3, 1.9, 1.1, 0.35, "firm"), {hand="detail", pile=treeP,
     tool="round 1.8", coverage=2.0, pressure=0.68, clip=true})
work(twigfield2(TW3b, 1.2, 0.7, 0.2, "firm"), {hand="detail", pile=treeP,
     tool="round 1.4", coverage=2.0, pressure=0.68, clip=true})
work(figM, {hand="detail", pile=figP, coverage=2.8, pressure=0.7, clip=true, fill=true})
print("branches and figure over dry paint")

--@ chunk 146
print(drying(400, 1150))
print(wait(2 * 24 * 60))
work(bankM, {hand="broad", pile=bankP2, tool="filbert 20", coverage=3.0, angle=-0.18,
             pressure=0.75, fill=true, clip=true, edge="soft"})
print("bank laid firmly")

--@ chunk 147
grassDark = pile{{"raw umber", 5}, {"yellow ochre", 2}, {"bone black", 1.2}}
work(bankM, {hand="scumble", pile=grassDark, tool="filbert 10", coverage=0.7, angle=-0.2,
             pressure={0.25, 0.45}, load=0.35, fill=false})
bankTop = bankM * mask(function(x, y) return clamp(1 - (y - 1016) / 60, 0, 1) end)
work(bankTop, {hand="scumble", pile=pile{{"raw umber", 4}, {"yellow ochre", 2.5}, {"lead white", 1}},
     coverage=0.7, pressure=0.3, load=0.3, fill=false})
work(stonesHi, {hand="body", pile=pile{{"raw umber", 4}, {"lead white", 1.8}, {"pale smalt", 0.8}},
     coverage=1.0, pressure=0.42, clip=true, edge="lost"})
print("grass and light on the bank")

--@ chunk 148
print(wait(2 * 24 * 60))
work(bankM, {hand="broad", pile=bankP2, tool="filbert 20", coverage=3.0, angle=-0.18,
             pressure=0.72, fill=true, clip=true, edge="soft"})
work(bankTop, {hand="scumble", pile=pile{{"raw umber", 5}, {"yellow ochre", 1}, {"lead white", 0.9}},
     coverage=0.55, pressure=0.3, load=0.3, fill=false})
work(rootM, {hand="detail", pile=pile{{"raw umber", 4}, {"bone black", 3}}, coverage=1.6,
     pressure=0.55, clip=true, fill=true})
work(stonesHi, {hand="body", pile=pile{{"raw umber", 4}, {"lead white", 1.8}, {"pale smalt", 0.8}},
     coverage=1.0, pressure=0.42, clip=true, edge="lost"})
print("bank, dark earth again")

--@ chunk 149
work(ellipse(727, 876, 62, 26):soften(22), {hand="body",
     pile=pile{{"lead white", 8}, {"pale smalt", 4}, {"smalt", 1}, {"raw umber", 0.6}},
     coverage=2.4, angle=0, pressure=0.6, fill=true, edge="lost"})
work(boatM, {hand="detail", pile=treeP, coverage=2.4, pressure=0.68, clip=true, fill=true})
work(boatFig, {hand="detail", pile=treeP, coverage=2.2, pressure=0.68, clip=true, fill=true})
pb:load(treeP, 0.85)
pb:stroke({{749,849},{758,838},{766,828}}, {pressure={0.85, 0.12}, ramps={0.05, 0.4}})
print("the punt, repainted")

--@ chunk 150
work(ellipse(642, 716, 200, 95):soften(85) - treesSafe, {hand="glaze",
     pile=pile{{"lead white", 18}, {"chrome yellow", 0.3}, {"yellow ochre", 0.3}},
     coverage=1.2, load=0.3, clip=true, edge="lost"})
print("light in the mist")

--@ chunk 151
print(wait(4 * 24 * 60))
print(drying(500, 300), drying(642, 670), drying(300, 900), drying(500, 1150), drying(500, 950))

--@ chunk 152
local pts = {{500,120},{500,400},{700,660},{300,900},{800,1000},{500,1150},{60,300}}
for i,p in ipairs(pts) do
  print(string.format("(%d,%d) %s", p[1], p[2], tostring(drying(p[1],p[2]))))
end
print("H", H, "W", W)
print("day", 0)

--@ chunk 153
skyBase = pile{{"lead white",9},{"pale smalt",5},{"smalt",2.4},{"raw umber",1.3}, medium=0.15}
skyZone = mask(function(x,y) if y < 760 then return 1 else return 0 end end):blur(26)
print(skyBase)
work(skyZone, {hand="broad", pile=skyBase, length={120,260}, angle=-0.06,
               coverage=1.7, fill=true, pressure={0.5,0.32}, ramps={0.12,0.3},
               dips={3, 0.5, 0.35}})

--@ chunk 154
skyBody = pile{{"lead white",9},{"pale smalt",5},{"smalt",2.4},{"raw umber",1.35}}
skyZone2 = mask(function(x,y) if y < 745 then return 1 else return 0 end end):blur(24)
work(skyZone2, {hand="broad", pile=skyBody, length={110,230}, angle=-0.05,
                coverage=1.5, fill=true, pressure={0.62,0.4}, ramps={0.1,0.28},
                dips={3, 0.62, 0.3}})
print(drying(500,300), drying(200,500))

--@ chunk 155
print(wait(26*60))

--@ chunk 156
print("drying sky:", drying(500,150), drying(500,500), drying(700,700))
-- four soft-edged bands, from a deeper cool blue at the top to warm cream at the horizon
gA = mask(function(x,y) if y<340 then return 1 else return 0 end end):blur(80)
gB = mask(function(x,y) if y>240 and y<540 then return 1 else return 0 end end):blur(80)
gC = mask(function(x,y) if y>430 and y<660 then return 1 else return 0 end end):blur(75)
gD = mask(function(x,y) if y>540 then return 1 else return 0 end end):blur(60)
pA = pile{{"lead white",8},{"pale smalt",5},{"smalt",3},{"raw umber",1.55}, medium=0.2}
pB = pile{{"lead white",9},{"pale smalt",4.6},{"smalt",2.1},{"raw umber",1.1}, medium=0.2}
pC = pile{{"lead white",11},{"pale smalt",3.7},{"smalt",1.3},{"raw umber",0.72}, medium=0.2}
pD = pile{{"lead white",13},{"pale smalt",2.7},{"smalt",0.8},{"raw umber",0.45},{"yellow ochre",0.5}, medium=0.25}
work(gA, {hand="broad", pile=pA, length={140,280}, angle=-0.05, coverage=0.9, pressure={0.3,0.2}, ramps={0.2,0.4}})
work(gB, {hand="broad", pile=pB, length={140,280}, angle=-0.05, coverage=0.9, pressure={0.3,0.2}, ramps={0.2,0.4}})
work(gC, {hand="broad", pile=pC, length={140,280}, angle=-0.05, coverage=0.9, pressure={0.3,0.2}, ramps={0.2,0.4}})
work(gD, {hand="broad", pile=pD, length={140,280}, angle=-0.05, coverage=0.9, pressure={0.3,0.2}, ramps={0.2,0.4}})

--@ chunk 157
function bandM(y0, y1, soft)
  return mask(function(x,y)
    if y >= y0 and y <= y1 then return 1 end
    return 0
  end):blur(soft)
end
skyB = pile{{"lead white",9},{"pale smalt",5},{"smalt",2.6},{"raw umber",1.4}}
skyZone3 = bandM(-20, 745, 22)
work(skyZone3, {hand="body", tool="filbert 16", pile=skyB, length={90,200}, angle=-0.05,
                coverage=1.9, fill=true, pressure={0.75,0.55}, ramps={0.08,0.25},
                dips={3, 0.7, 0.28}})
print(drying(500,300))

--@ chunk 158
dead = pile{{"lead white",7},{"pale smalt",5},{"smalt",3},{"raw umber",2.2}}
work(everywhere(), {hand="body", tool="filbert 18", pile=dead, length={100,220},
                    angle=-0.04, coverage=1.8, fill=true,
                    pressure={0.8,0.6}, ramps={0.06,0.22}, dips={3, 0.75, 0.25}})
print("done", drying(500,900), drying(500,300))

--@ chunk 159
print(wait(30*60), drying(500,400), drying(200,1100))

--@ chunk 160
print(wait(2*24*60), drying(500,400), drying(200,1100), drying(700,900))

--@ chunk 161
local SUNX, SUNY = 655, 690
local function sunfall(x, halfw, floorv)
  local d = math.abs(x - SUNX) / halfw
  if d > 1 then return floorv end
  return floorv + (1 - floorv) * (1 - d)
end
local function vband(y0, y1, soft, fx)
  return mask(function(x, y)
    if y < y0 or y > y1 then return 0 end
    return fx and fx(x) or 1
  end):blur(soft)
end
t1 = vband(-40, 340, 95)
t2 = vband(190, 530, 90)
t3 = vband(420, 662, 80)
t4 = vband(548, 712, 46, function(x) return sunfall(x, 540, 0.3) end)
q1 = pile{{"lead white",5.5},{"pale smalt",5},{"smalt",4.2},{"raw umber",2.2}, medium=0.3}
q2 = pile{{"lead white",8},{"pale smalt",5},{"smalt",2.7},{"raw umber",1.35}, medium=0.3}
q3 = pile{{"lead white",11.5},{"pale smalt",4},{"smalt",1.3},{"raw umber",0.62}, medium=0.28}
q4 = pile{{"lead white",14},{"pale smalt",2.2},{"yellow ochre",0.75},{"chrome yellow",0.3}, medium=0.3}
local o = {hand="glaze", length={160,300}, angle=-0.04, coverage=1.15,
           pressure={0.42,0.3}, ramps={0.25,0.45}, dips={2, 0.5, 0.4}}
work(t1, {pile=q1, hand=o.hand, length=o.length, angle=o.angle, coverage=o.coverage, pressure=o.pressure, ramps=o.ramps, dips=o.dips})
work(t2, {pile=q2, hand=o.hand, length=o.length, angle=o.angle, coverage=o.coverage, pressure=o.pressure, ramps=o.ramps, dips=o.dips})
work(t3, {pile=q3, hand=o.hand, length=o.length, angle=o.angle, coverage=o.coverage, pressure=o.pressure, ramps=o.ramps, dips=o.dips})
work(t4, {pile=q4, hand=o.hand, length=o.length, angle=o.angle, coverage=o.coverage, pressure=o.pressure, ramps=o.ramps, dips=o.dips})
print("sky bands laid")

--@ chunk 162
print(wait(9*60), drying(500,200), drying(500,500), drying(300,650))

--@ chunk 163
skyAll = bandM(-20, 740, 20)
blend(skyAll, {angle=1.5708})
print("blended", drying(500,300))

--@ chunk 164
dead2 = pile{{"lead white",7},{"pale smalt",5},{"smalt",3},{"raw umber",2.2}}
work(skyAll, {hand="body", tool="filbert 16", pile=dead2, length={80,170}, angle=-0.04,
              coverage=2.0, fill=true, pressure={0.8,0.62}, ramps={0.06,0.2}, dips={3,0.75,0.25}})
print(drying(500,400))

--@ chunk 165
print(wait(3*24*60), drying(500,400), drying(700,650))

--@ chunk 166
testM = mask(function(x,y) if y<120 and y>40 and x>400 and x<560 then return 1 end return 0 end)
local ok = pcall(function()
  work(testM, {hand="body", pile=coolSky, coverage=2.4, load=function(x,y) return 0.2+0.6*(y/745) end,
               fill=true, length={24,62}})
end)
print("function load accepted:", ok)

--@ chunk 167
local ok, err = pcall(function()
  work(testM, {hand="body", pile=coolSky, coverage=2.4, load_at=function(x,y) return 0.2+0.6*(y/745) end,
               fill=true, length={24,62}})
end)
print("load_at:", ok, err)

--@ chunk 168
coolSky = pile{{"lead white",5},{"pale smalt",5},{"smalt",4.5},{"raw umber",2.4}}
local ok, err = pcall(function()
  work(testM, {hand="body", pile=coolSky, coverage=2.4, load_at=function(x,y) return 0.2+0.6*(y/745) end,
               fill=true, length={24,62}})
end)
print("load_at:", ok, err)

--@ chunk 169
b1 = mask(function(x,y) if y < 250 then return 1 end return 0 end):blur(52)
c1 = pile{{"lead white",5},{"pale smalt",5},{"smalt",5},{"raw umber",2.6}}
local t0 = os and 0 or 0
work(b1, {hand="body", pile=c1, coverage=3.0, fill=true, length={24,62},
          angle=-0.05, pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
print("band 1 done")

--@ chunk 170
c2 = pile{{"lead white",7},{"pale smalt",5},{"smalt",3.6},{"raw umber",2.0}}
c3 = pile{{"lead white",9},{"pale smalt",4.6},{"smalt",2.5},{"raw umber",1.35}}
c4 = pile{{"lead white",11},{"pale smalt",4},{"smalt",1.7},{"raw umber",0.9}}
c5 = pile{{"lead white",13},{"pale smalt",3.2},{"smalt",1.1},{"raw umber",0.55},{"yellow ochre",0.35}}
c6 = pile{{"lead white",15},{"pale smalt",2.4},{"smalt",0.6},{"raw umber",0.3},{"yellow ochre",0.85},{"chrome yellow",0.22}}
local common = {hand="body", coverage=3.0, fill=true, length={24,62},
                angle=-0.05, pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true}
work(bandM(140,410,55), {pile=c2, hand=common.hand, coverage=common.coverage, fill=true, length=common.length,
     angle=common.angle, pressure=common.pressure, ramps=common.ramps, dips=common.dips, clip=true})
work(bandM(320,540,55), {pile=c3, hand=common.hand, coverage=common.coverage, fill=true, length=common.length,
     angle=common.angle, pressure=common.pressure, ramps=common.ramps, dips=common.dips, clip=true})
work(bandM(440,645,55), {pile=c4, hand=common.hand, coverage=common.coverage, fill=true, length=common.length,
     angle=common.angle, pressure=common.pressure, ramps=common.ramps, dips=common.dips, clip=true})
work(bandM(540,712,50), {pile=c5, hand=common.hand, coverage=common.coverage, fill=true, length=common.length,
     angle=common.angle, pressure=common.pressure, ramps=common.ramps, dips=common.dips, clip=true})
work(bandM(610,762,42), {pile=c6, hand=common.hand, coverage=common.coverage, fill=true, length=common.length,
     angle=common.angle, pressure=common.pressure, ramps=common.ramps, dips=common.dips, clip=true})
print("sky gradient done")

--@ chunk 171
glowP = pile{{"lead white",14},{"pale smalt",2.2},{"yellow ochre",0.9},{"chrome yellow",0.34}, medium=0.25}
glowM = ellipse(655, 686, 330, 150):blur(70)
work(glowM, {hand="body", pile=glowP, coverage=2.2, fill=true, length={30,80},
             angle=-0.03, pressure={0.45,0.34}, ramps={0.2,0.4}, dips={4,0.45,0.4}, clip=true, edge="soft"})
-- the sun's own light
sunM = ellipse(655, 668, 26, 24):blur(7)
sunP = pile{{"lead white",12},{"chrome yellow",2.4},{"yellow ochre",0.9}}
work(sunM, {hand="detail", pile=sunP, coverage=2.4, length={8,22}, pressure={0.55,0.4}, clip=true, edge="soft"})
print(drying(655,660), drying(300,300))

--@ chunk 172
sunSoft = pile{{"lead white",14},{"chrome yellow",1.5},{"yellow ochre",0.7}}
work(ellipse(655, 668, 23, 21):blur(17), {hand="body", pile=sunSoft, coverage=3.0, fill=true,
      length={16,40}, pressure={0.5,0.4}, clip=true, edge="soft"})
print(wait(26*60))

--@ chunk 173
local function streaks(list, soft)
  local m = mask(function() return 0 end)
  for i = 1, #list do
    local c = list[i]
    m = m + ellipse(c[1], c[2], c[3], c[4])
  end
  return m:blur(soft)
end
darkC = streaks({{130,235,205,17},{170,120,245,14},{640,105,260,12},{860,200,180,16},
                 {360,265,195,15},{700,300,230,13},{120,330,150,14},{930,370,140,12},
                 {430,395,170,11},{250,330,120,10}}, 17)
litC  = streaks({{250,470,190,10},{640,505,250,9},{880,470,160,10},{420,560,200,8},
                 {700,600,210,7},{180,620,150,7},{880,645,140,6}}, 13)
cloudP = pile{{"lead white",7},{"pale smalt",4.5},{"smalt",2.4},{"raw umber",1.75}}
lowCloudP = pile{{"lead white",14},{"pale smalt",2.4},{"yellow ochre",0.5},{"chrome yellow",0.12}}
work(darkC, {hand="body", pile=cloudP, coverage=1.7, fill=true, length={28,70},
             angle=-0.04, pressure={0.42,0.34}, ramps={0.2,0.4}, dips={4,0.45,0.4}, clip=true, edge="soft"})
work(litC, {hand="body", pile=lowCloudP, coverage=1.9, fill=true, length={28,70},
            angle=-0.04, pressure={0.42,0.34}, ramps={0.2,0.4}, dips={4,0.45,0.4}, clip=true, edge="soft"})
print("clouds laid")

--@ chunk 174
local function lay(m, p)
  work(m, {hand="body", pile=p, coverage=3.0, fill=true, length={24,62},
           angle=-0.05, pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
end
lay(b1, c1) lay(bandM(140,410,55), c2) lay(bandM(320,540,55), c3)
lay(bandM(440,645,55), c4) lay(bandM(540,712,50), c5) lay(bandM(610,762,42), c6)
print("bands redone", drying(500,400))

--@ chunk 175
print(wait(2*24*60), drying(500,400), drying(655,668))

--@ chunk 176
print(wait(24*60), drying(500,400), drying(655,668))

--@ chunk 177
function ell(x, y, cx, cy, rx, ry)
  local dx, dy = (x - cx) / rx, (y - cy) / ry
  return math.sqrt(dx * dx + dy * dy)
end
glowPile = pile{{"lead white",13},{"pale smalt",2.4},{"yellow ochre",1.0},{"chrome yellow",0.3}, medium=0.2}
stipple(ellipse(655, 672, 420, 200):blur(18), {
  pile=glowPile, width=14, coverage=function(x, y) return 2.7 * (1 - ell(x,y,655,672,400,185)) ^ 1.25 end,
  pressure={0.3,0.46}, cluster=0.45, feather=0.85, dips={14, 0.5, 0.35}})
print("glow stippled")

--@ chunk 178
sunPile = pile{{"lead white",13},{"chrome yellow",2.0},{"yellow ochre",0.8}}
stipple(ellipse(655, 668, 52, 48):blur(8), {
  pile=sunPile, width=9,
  coverage=function(x, y) return 3.5 * (1 - ell(x, y, 655, 668, 32, 29)) ^ 0.8 end,
  pressure={0.35,0.5}, cluster=0.3, feather=0.6, dips={16, 0.5, 0.35}})
print("sun laid")

--@ chunk 179
print("drying:", drying(655,668), drying(655,600))
-- bury the blotchy patch with the local glow colour
buryP = pile{{"lead white",13},{"pale smalt",2.6},{"yellow ochre",0.55},{"chrome yellow",0.12}}
work(ellipse(655, 668, 60, 54):blur(26), {hand="body", pile=buryP, coverage=3.2, fill=true,
      length={18,44}, pressure={0.5,0.42}, clip=true, edge="soft"})
-- a luminous pale-gold disc, solid at the core and fading at the rim
sunPale = pile{{"lead white",16},{"chrome yellow",1.5},{"yellow ochre",0.55}}
work(ellipse(655, 668, 29, 26):blur(9), {hand="body", tool="round 5", pile=sunPale, coverage=3.6,
      fill=true, length={10,26}, pressure={0.5,0.42}, clip=true, edge={found=0.25, soft=0.55, lost=0.2}})
print("sun redone")

--@ chunk 180
haloP = pile{{"lead white",14},{"pale smalt",2.4},{"yellow ochre",0.6},{"chrome yellow",0.15}}
work(ellipse(655, 668, 112, 100):blur(34), {hand="body", pile=haloP, coverage=3.2, fill=true,
      length={18,46}, pressure={0.5,0.42}, clip=true, edge="soft"})
sunCore = pile{{"lead white",16},{"chrome yellow",1.3},{"yellow ochre",0.45}}
work(ellipse(655, 668, 27, 25):blur(8), {hand="body", tool="round 5", pile=sunCore, coverage=3.6,
      fill=true, length={10,26}, pressure={0.5,0.42}, clip=true, edge="soft"})
print("sun cleaned")

--@ chunk 181
stipple(ellipse(655, 672, 460, 230):blur(24), {
  pile=pile{{"lead white",13},{"pale smalt",2.4},{"yellow ochre",1.0},{"chrome yellow",0.3}, medium=0.2},
  width=14, coverage=function(x, y) return 2.7 * (1 - ell(x,y,655,672,430,205)) ^ 1.25 end,
  pressure={0.3,0.46}, cluster=0.45, feather=0.85, dips={14, 0.5, 0.35}})
print("glow restippled")

--@ chunk 182
sunCore2 = pile{{"lead white",18},{"chrome yellow",1.1},{"yellow ochre",0.35}}
work(ellipse(655, 668, 28, 26):blur(10), {hand="body", tool="round 5", pile=sunCore2, coverage=3.6,
      fill=true, length={10,26}, pressure={0.5,0.42}, clip=true, edge="soft"})
print("sun core")

--@ chunk 183
print(wait(3*24*60), drying(655,668), drying(655,620), drying(400,500))

--@ chunk 184
print(wait(2*24*60), drying(655,668), drying(655,620))

--@ chunk 185
stipple(ellipse(655, 672, 470, 240):blur(26), {
  pile=pile{{"lead white",13},{"pale smalt",2.4},{"yellow ochre",1.0},{"chrome yellow",0.3}, medium=0.2},
  width=14, coverage=function(x, y) return 2.7 * (1 - ell(x,y,655,672,440,215)) ^ 1.25 end,
  pressure={0.3,0.46}, cluster=0.45, feather=0.85, dips={14, 0.5, 0.35}})
print("glow restored")

--@ chunk 186
local cream = pile{{"lead white",14.5},{"pale smalt",2.2},{"yellow ochre",0.75},{"chrome yellow",0.22}}
work(ellipse(655, 668, 165, 150):blur(46), {hand="body", pile=cream, coverage=3.4, fill=true,
      length={20,50}, pressure={0.55,0.45}, clip=true, edge="soft"})
print("sun neighbourhood flattened")

--@ chunk 187
local function layw(m, p)
  work(m, {hand="body", pile=p, coverage=3.0, fill=true, length={24,62},
           angle=-0.02, pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
end
w1 = pile{{"lead white",11},{"pale smalt",3.6},{"smalt",1.2},{"raw umber",0.7}}
w2 = pile{{"lead white",9},{"pale smalt",4},{"smalt",1.8},{"raw umber",1.0}}
w3 = pile{{"lead white",7.5},{"pale smalt",4.2},{"smalt",2.4},{"raw umber",1.4}}
w4 = pile{{"lead white",6},{"pale smalt",4.2},{"smalt",3},{"raw umber",1.9}}
w5 = pile{{"lead white",5},{"pale smalt",4},{"smalt",3.6},{"raw umber",2.4}}
waterZone = mask(function(x,y) if y > 690 then return 1 end return 0 end):blur(16)
layw(bandM(690,770,50), w1)
layw(bandM(750,840,50), w2)
layw(bandM(820,910,50), w3)
layw(bandM(890,985,50), w4)
layw(bandM(965,1045,44), w5)
print("water laid")

--@ chunk 188
nsh = noise{seed=7, octaves=3, period=120}
function shoretop(x) return 699 + 6.5 * nsh(x, 700) end
shoreM = mask(function(x, y) if y > shoretop(x) then return 1 end return 0 end):blur(4)
woodM  = mask(function(x, y)
  if y > shoretop(x) - 12 and y < shoretop(x) + 26 then return 1 end return 0 end):blur(5)
shoreP = pile{{"lead white",9},{"pale smalt",4},{"smalt",2.4},{"raw umber",1.45}}
work(shoreM, {hand="body", pile=shoreP, coverage=3.0, fill=true, length={20,50},
              angle=-0.02, pressure={0.6,0.48}, clip=true})
woodP = pile{{"lead white",6},{"pale smalt",3.6},{"smalt",2.6},{"raw umber",2.0}}
work(woodM, {hand="body", pile=woodP, coverage=2.4, fill=true, length={10,26},
             angle=-0.02, pressure={0.5,0.4}, clip=true, edge="soft"})
print("shore laid")

--@ chunk 189
nm = noise{seed=19, octaves=4, period=150}
mistPile = pile{{"lead white",15},{"pale smalt",2.2},{"raw umber",0.28}, medium=0.2}
mistArea = mask(function(x, y) if y > 600 and y < 900 then return 1 end return 0 end):blur(24)
function mistCov(x, y)
  local up = clamp((y - 702) / 26, 0, 1)
  local dn = clamp((880 - y) / 190, 0, 1)
  local patch = 0.35 + 0.65 * nm:at01(x * 1.0, y * 0.5)
  return 2.5 * up * dn * patch
end
stipple(mistArea, {pile=mistPile, width=9, coverage=mistCov, pressure={0.3,0.42},
                   cluster=0.6, feather=0.8, drag={7, 0}, dips={16, 0.45, 0.4}})
print("mist laid")

--@ chunk 190
bankLine = {{0,1064},{150,1043},{300,1035},{430,1025},{520,1020},{625,1027},{770,1039},{1000,1023}}
bankZone = poly({{0,1064},{150,1043},{300,1035},{430,1025},{520,1020},{625,1027},{770,1039},{1000,1023},
                {1000,1260},{0,1260}}, true):blur(6)
bankPile = pile{{"raw umber",6},{"bone black",2.1},{"green earth",1.9}}
work(bankZone, {hand="body", pile=bankPile, coverage=3.0, fill=true, length={26,64},
                angle=0.35, pressure={0.62,0.5}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
print("bank laid")

--@ chunk 191
print(wait(3*24*60), drying(655,668), drying(500,760), drying(300,1100))

--@ chunk 192
local function lay(m, p) work(m, {hand="body", pile=p, coverage=3.0, fill=true, length={24,62},
  angle=-0.05, pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true}) end
lay(bandM(540,712,50), c5)
lay(bandM(610,762,42), c6)
-- a small, genuinely small sun: nothing bigger than a coin in this picture
sunDisc = pile{{"lead white",20},{"chrome yellow",1.7},{"yellow ochre",0.5}}
work(ellipse(655, 668, 27, 25):blur(6), {hand="body", tool="round 5", pile=sunDisc, coverage=3.6,
      fill=true, length={10,26}, pressure={0.5,0.42}, clip=true, edge="soft"})
print("clean horizon sky + small sun")

--@ chunk 193
sunWarm2 = pile{{"lead white",20},{"chrome yellow",2.6},{"yellow ochre",0.9}}
work(ellipse(655, 668, 28, 26):blur(7), {hand="body", tool="round 5", pile=sunWarm2, coverage=3.4,
      fill=true, length={10,26}, pressure={0.5,0.42}, clip=true, edge="soft"})
stipple(ellipse(655, 672, 470, 240):blur(26), {
  pile=pile{{"lead white",13},{"pale smalt",2.4},{"yellow ochre",1.0},{"chrome yellow",0.3}, medium=0.2},
  width=14, coverage=function(x, y) return 2.6 * (1 - ell(x,y,655,672,430,205)) ^ 1.2 end,
  pressure={0.3,0.46}, cluster=0.45, feather=0.85, dips={14, 0.5, 0.35}})
print("sun + glow")

--@ chunk 194
work(shoreM, {hand="body", pile=shoreP, coverage=3.0, fill=true, length={20,50},
              angle=-0.02, pressure={0.6,0.48}, clip=true})
work(woodM, {hand="body", pile=woodP, coverage=2.4, fill=true, length={10,26},
             angle=-0.02, pressure={0.5,0.4}, clip=true, edge="soft"})
stipple(mistArea, {pile=mistPile, width=9, coverage=mistCov, pressure={0.3,0.42},
                   cluster=0.6, feather=0.8, drag={7, 0}, dips={16, 0.45, 0.4}})
print("shore + mist restored")

--@ chunk 195
np = noise{seed=31, octaves=4, period=70, stretch={0, 0.25}}
function halfw(y) return 20 + (y - 698) * 0.155 end
pathMask = mask(function(x, y) if y > 690 and y < 1030 then return 1 end return 0 end):blur(10)
function pathCov(x, y)
  local up = clamp((y - 696) / 34, 0, 1)
  local h = halfw(y)
  local dx = (x - 655) / h
  local a = math.exp(-dx * dx * 2.0)
  local down = 0.30 + 0.70 * clamp((1015 - y) / 300, 0, 1)
  local shim = 0.35 + 0.65 * np:at01(x, y * 0.55)
  return 2.5 * up * a * down * shim
end
stipple(pathMask, {pile=pile{{"lead white",12},{"pale smalt",3},{"yellow ochre",0.8},{"chrome yellow",0.25}},
         width=10, coverage=pathCov, pressure={0.3,0.44}, cluster=0.55, feather=0.8,
         drag={9, 0}, dips={16, 0.45, 0.4}})
print("light path laid")

--@ chunk 196
print(wait(2*24*60), drying(500,800), drying(655,760))

--@ chunk 197
v1 = pile{{"lead white",9},{"pale smalt",3.6},{"smalt",1.6},{"raw umber",1.0}}
v2 = pile{{"lead white",7},{"pale smalt",4},{"smalt",2.2},{"raw umber",1.5}}
v3 = pile{{"lead white",5.5},{"pale smalt",4},{"smalt",2.8},{"raw umber",2.0}}
v4 = pile{{"lead white",4.2},{"pale smalt",3.8},{"smalt",3.4},{"raw umber",2.6}}
v5 = pile{{"lead white",3.2},{"pale smalt",3.4},{"smalt",4},{"raw umber",3.2}}
local function layw(m, p) work(m, {hand="body", pile=p, coverage=3.0, fill=true, length={24,62},
  angle=-0.02, pressure={0.62,0.5}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true}) end
layw(bandM(690,775,50), v1)
layw(bandM(755,845,50), v2)
layw(bandM(825,915,50), v3)
layw(bandM(895,990,50), v4)
layw(bandM(970,1050,44), v5)
print("water relaid darker")

--@ chunk 198
-- bank again
work(bankZone, {hand="body", pile=bankPile, coverage=3.0, fill=true, length={26,64},
                angle=0.35, pressure={0.62,0.5}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
-- glow, properly clamped this time
stipple(ellipse(655, 672, 470, 240):blur(26), {
  pile=pile{{"lead white",13},{"pale smalt",2.4},{"yellow ochre",1.0},{"chrome yellow",0.3}, medium=0.2},
  width=14, coverage=function(x, y)
    local r = ell(x, y, 655, 672, 430, 205)
    if r >= 1 then return 0 end
    return 2.6 * (1 - r) ^ 1.2
  end,
  pressure={0.3,0.46}, cluster=0.45, feather=0.85, dips={14, 0.5, 0.35}})
print("bank + clamped glow")

--@ chunk 199
ripDark = pile{{"pale smalt",3},{"smalt",2.5},{"raw umber",1.8}}
ripLite = pile{{"lead white",8},{"pale smalt",3}}
function rip(m, p, len, cov, ang)
  work(m, {hand="hatch", tool={kind="round", width=3.2, point=1}, pile=p, length=len,
           angle=ang, coverage=cov, pressure={0.5,0.26}, ramps={0.3,0.5}, clump=0.65,
           fill=true, clip=true, edge="soft"})
end
local bands = {
  {bandM(712,790,32), {14,38}, 2.0,  0.015},
  {bandM(778,868,36), {22,58}, 1.8, -0.012},
  {bandM(858,955,40), {34,90}, 1.6,  0.010},
  {bandM(945,1016,32), {50,130},1.4, -0.008}}
for i = 1, 4 do rip(bands[i][1], ripDark, bands[i][2], bands[i][3], bands[i][4]) end
for i = 1, 4 do rip(bands[i][1], ripLite, bands[i][2], bands[i][3]*0.8, bands[i][4]) end
print("ripples laid")

--@ chunk 200
print(wait(2*24*60), drying(500,850), drying(500,950))

--@ chunk 201
local function layw(m, p) work(m, {hand="body", pile=p, coverage=3.0, fill=true, length={24,62},
  angle=-0.02, pressure={0.62,0.5}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true}) end
layw(bandM(690,775,50), v1)
layw(bandM(755,845,50), v2)
layw(bandM(825,915,50), v3)
layw(bandM(895,990,50), v4)
layw(bandM(970,1020,28), v5)
print("water back")

--@ chunk 202
ng = noise{seed=41, octaves=4, period=95}
grassPile = pile{{"yellow ochre",5},{"raw umber",3},{"lead white",1.2}}
function grassCov(x, y)
  if y < 1010 then return 0 end
  local crest = math.exp(-((y - 1078) / 95) * ((y - 1078) / 95))
  local patch = 0.25 + 0.75 * ng:at01(x, y * 0.7)
  return 2.1 * (0.32 + 0.68 * crest) * patch
end
stipple(bankZone:blur(8), {pile=grassPile, width=8, coverage=grassCov, pressure={0.35,0.5},
         cluster=0.6, feather=0.8, drag={5, -0.5}, dips={16, 0.45, 0.4}})
print("dry grass laid")

--@ chunk 203
kCrest = pile{{"raw umber",5},{"bone black",1.6},{"green earth",1.6},{"yellow ochre",1.3}}
kMid   = pile{{"raw umber",6},{"bone black",2.5},{"green earth",1.6}}
kFore  = pile{{"raw umber",6},{"bone black",3.6},{"green earth",1.2}}
local function layb(m, p) work(m, {hand="body", pile=p, coverage=3.0, fill=true, length={24,60},
  angle=0.3, pressure={0.62,0.5}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true}) end
layb(bandM(1012,1095,40) * bankZone, kCrest)
layb(bandM(1075,1175,45) * bankZone, kMid)
layb(bandM(1155,1260,45) * bankZone, kFore)
print("bank regraded")

--@ chunk 204
local ok1, m1 = pcall(function()
  return body_of{spine={{100,300},{110,240},{130,190}}, widths=8,
                 limbs={{pts={{130,190},{150,170},{170,155}}, widths=4}}}:mask()
end)
print("nested form:", ok1, ok1 and m1:area() or m1)
local ok2, m2 = pcall(function()
  return body_of{spine={{100,300},{110,240},{130,190}}, widths=8,
                 limbs={{130,190,150,170,170,155, widths=4}}}:mask()
end)
print("flat form:", ok2, ok2 and m2:area() or m2)
print(math.random(1,100), rand(0,1), randn(0,0.1))

--@ chunk 205
local ok, err = pcall(function()
  local m = body_of{spine={{100,300},{110,240},{130,190}}, widths={12,9,6},
                    limbs={{pts={{130,190},{150,170},{170,155},{190,148}}, widths={7,4,2}}}}:mask()
  return m:area()
end)
print("list-widths ok:", ok, err)

--@ chunk 206
function taperW(w0, n, keep)
  local w, k = {}, keep or 0.28
  for i = 0, n - 1 do
    local t = i / (n - 1)
    w[#w+1] = w0 * ((1 - t) + k * t)
  end
  return w
end
function limb(x, y, ang, len, w, depth, out)
  local n = 3 + math.random(1, 2)
  local step = len / (n - 1)
  local a, px, py = ang, x, y
  local pts = {}
  for i = 1, n do
    a = a + randn(0, 0.10)
    px = px + math.cos(a) * step
    py = py + math.sin(a) * step
    pts[#pts+1] = {px, py}
  end
  out[#out+1] = {pts = pts, widths = taperW(w, n)}
  local tipx, tipy = pts[n][1], pts[n][2]
  if depth > 0 then
    for i = 1, 2 + math.random(0, 1) do
      local ti = math.random(2, n)
      local bx, by = pts[ti][1], pts[ti][2]
      local side = (math.random() < 0.5) and -1 or 1
      limb(bx, by, a + side * (0.50 + 0.45 * math.random()),
           len * (0.50 + 0.26 * math.random()), w * (0.52 + 0.16 * math.random()), depth - 1, out)
    end
  end
  return tipx, tipy
end
A_spine = {{98,1092},{110,1010},{124,930},{140,860},{156,790},{170,706}}
A_spec = {
  {4, -2.62, 250, 12}, {5, -2.20, 280, 12}, {5, -1.62, 290, 12}, {5, -1.05, 260, 11},
  {5, -0.55, 200, 9},  {3, -3.05, 230, 10}, {2, -2.85, 185, 8},  {4, -1.80, 240, 10}}
A_limbs = {}
A_tips = {}
for i = 1, #A_spec do
  local s = A_spec[i]
  local tx, ty = limb(A_spine[s[1]][1], A_spine[s[1]][2], s[2], s[3], s[4], 0, A_limbs)
  A_tips[#A_tips+1] = {tx, ty, s[2], s[3], s[4]}
end
for i = 1, #A_tips do
  local t = A_tips[i]
  limb(t[1], t[2], t[3] + randn(0, 0.16), t[4] * (0.30 + 0.10 * math.random()), 5.4, 2, A_limbs)
end
print("main limbs", #A_tips, "total parts", #A_limbs)
A_mask = body_of{spine = A_spine, widths = taperW(28, #A_spine, 0.28), limbs = A_limbs, char = "firm"}:mask()
print("tree A mask area", A_mask:area())

--@ chunk 207
barkDark = pile{{"bone black",5},{"raw umber",4},{"green earth",0.8}}
work(A_mask, {hand="detail", pile=barkDark, coverage=3.0, fill=false, length={8,20},
              pressure={0.6,0.45}, clip=true})
print("tree A painted")

--@ chunk 208
twigsA = {}
for i = 1, 8 do
  local L = A_limbs[i]
  local n = #L.pts
  for ti = 2, n do
    local bx, by = L.pts[ti][1], L.pts[ti][2]
    local a0 = math.atan(L.pts[ti][2] - L.pts[ti-1][2], L.pts[ti][1] - L.pts[ti-1][1])
    for j = 1, 2 do
      local side = (j == 1) and -1 or 1
      limb(bx, by, a0 + side * (0.62 + 0.48 * math.random()), 60 + 32 * math.random(), 4.4, 2, twigsA)
    end
  end
end
for i = 1, #twigsA do
  local p = twigsA[i].pts
  for j = 1, #p do
    if p[j][1] ~= p[j][1] or p[j][2] ~= p[j][2] then p[j] = {0, 0} end
  end
end
print("twig parts", #twigsA)
local ok, err = pcall(function()
  A_tw = body_of{spine = {{0,0}}, widths = 0.2, limbs = twigsA, char = "firm"}:mask()
  return A_tw:area()
end)
print("twig mask:", ok, err)

--@ chunk 209
A_mask2 = body_of{spine = A_spine, widths = taperW(28, #A_spine, 0.28), limbs = A_limbs, char = "firm"}:mask() + A_tw
print("mask2 area", A_mask2:area())
work(A_mask2, {hand="detail", pile=barkDark, coverage=3.0, fill=true, length={8,20}, pressure={0.6,0.45}, clip=true})
print("twigs painted")

--@ chunk 210
function limb(x, y, ang, len, w, depth, out)
  local n = 3 + math.random(1, 2)
  local step = len / (n - 1)
  local a, px, py = ang, x, y
  local pts = {}
  for i = 1, n do
    a = a + randn(0, 0.12)
    px = px + math.cos(a) * step
    py = py + math.sin(a) * step
    pts[#pts+1] = {px, py}
  end
  out[#out+1] = {pts = pts, widths = taperW(w, n, 0.15)}
  if depth > 0 then
    for i = 1, 2 do
      local ti = math.random(2, n)
      local bx, by = pts[ti][1], pts[ti][2]
      local side = (math.random() < 0.5) and -1 or 1
      local ba = a + side * (0.60 + 0.70 * math.random())
      ba = ba + (-1.5708 - ba) * 0.06
      limb(bx, by, ba, len * (0.42 + 0.24 * math.random()), w * (0.56 + 0.14 * math.random()), depth - 1, out)
    end
  end
end
twigsA2 = {}
for i = 1, 8 do
  local L = A_limbs[i]
  local n = #L.pts
  for ti = 2, n do
    local bx, by = L.pts[ti][1], L.pts[ti][2]
    local a0 = math.atan(L.pts[ti][2] - L.pts[ti-1][2], L.pts[ti][1] - L.pts[ti-1][1])
    for j = 1, 3 do
      local ba = a0 + randn(0, 0.5) + (j - 2) * 0.85
      limb(bx, by, ba, 42 + 24 * math.random(), 3.2, 2, twigsA2)
    end
  end
end
print("parts", #twigsA2)
A_tw2 = body_of{spine = {{0,0}}, widths = 0.2, limbs = twigsA2, char = "firm"}:mask()
print("area", A_tw2:area())
local rows = {}
for r = 0, 39 do
  local line = ""
  for c = 0, 62 do
    local v = 0
    for dy = 0, 2 do
      for dx = 0, 1 do
        local px, py = c * 8 + dx * 4, r * 20 + dy * 10
        v = math.max(v, A_tw2:at(px, py))
      end
    end
    line = line .. (v > 0.7 and "#" or v > 0.35 and "+" or v > 0.08 and "." or " ")
  end
  rows[#rows+1] = line
end
print(table.concat(rows, "\n"))

--@ chunk 211
twigsA3 = {}
for i = 1, 8 do
  local L = A_limbs[i]
  local n = #L.pts
  for ti = 2, n do
    local bx, by = L.pts[ti][1], L.pts[ti][2]
    local a0 = math.atan(L.pts[ti][2] - L.pts[ti-1][2], L.pts[ti][1] - L.pts[ti-1][1])
    for j = 1, 3 do
      local ba = a0 + randn(0, 0.55) + (j - 2) * 0.9
      limb(bx, by, ba, 50 + 30 * math.random(), 2.2, 2, twigsA3)
    end
  end
end
print("parts", #twigsA3)
A_tw3 = body_of{spine = {{0,0}}, widths = 0.2, limbs = twigsA3, char = "firm"}:mask()
print("area", A_tw3:area())
local rows = {}
for r = 0, 34 do
  local line = ""
  for c = 0, 52 do
    local sum, cnt = 0, 0
    for dy = 0, 4 do
      for dx = 0, 4 do
        sum = sum + A_tw3:at(c * 10 + dx * 2.5, r * 24 + dy * 6); cnt = cnt + 1
      end
    end
    local v = sum / cnt
    line = line .. (v > 0.5 and "#" or v > 0.3 and "+" or v > 0.14 and "-" or v > 0.04 and "." or " ")
  end
  rows[#rows+1] = line
end
print(table.concat(rows, "\n"))

--@ chunk 212
local test = {{pts={{300,300},{320,270},{340,250}}, widths={2.2,1.6,1.1}}}
for _, b in ipairs({0.8, 0.4, 0.15, 0.0}) do
  local m = body_of{spine={{300,300}}, widths=2.2, limbs=test, blend=b, char="firm"}:mask()
  print("blend", b, "area", m:area(), "value at mid", m:at(320, 270))
end
for _, c in ipairs({"firm", "soft"}) do
  local m = body_of{spine={{300,300}}, widths=2.2, limbs=test, blend=0.0, char=c}:mask()
  print("char", c, "area", m:area())
end

--@ chunk 213
for _, w in ipairs({0.4, 0.8, 1.2, 2.0, 3.0}) do
  local m = body_of{spine={{200,600},{300,600}}, widths=w, blend=0.0, char="firm"}:mask()
  print(string.format("w=%.1f  area=%.0f  eff_width=%.2f", w, m:area(), m:area() / 100))
end
-- how thick is the mask perpendicular to a thin limb?
local m = body_of{spine={{200,600},{300,600}}, widths=1.0, blend=0.0, char="firm"}:mask()
for y = 594, 608 do print(y, string.format("%.2f", m:at(250, y))) end

--@ chunk 214
for _, b in ipairs({0.8, 0.5, 0.2, 0.0}) do
  local m = body_of{spine={{0,0}}, widths=0.2, limbs=twigsA3, blend=b, char="firm"}:mask()
  print(string.format("blend %.1f -> area %.0f", b, m:area()))
end

--@ chunk 215
print(drying(300,400), drying(150,900), drying(120,1070), drying(400,780))

--@ chunk 216
print(wait(3*24*60), drying(300,400), drying(150,900), drying(120,1070))

--@ chunk 217
burySky = rect(-10, -10, 556, 712)
buryWat = rect(-10, 690, 556, 1040)
local function lay(m, p, ang)
  work(m, {hand="body", pile=p, coverage=3.0, fill=true, length={24,62},
           angle=ang or -0.05, pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
end
lay(b1 * burySky, c1)
lay(bandM(140,410,55) * burySky, c2)
lay(bandM(320,540,55) * burySky, c3)
lay(bandM(440,645,55) * burySky, c4)
lay(bandM(540,712,50) * burySky, c5)
lay(bandM(690,775,50) * buryWat, v1, -0.02)
lay(bandM(755,845,50) * buryWat, v2, -0.02)
lay(bandM(825,915,50) * buryWat, v3, -0.02)
lay(bandM(895,990,50) * buryWat, v4, -0.02)
lay(bandM(970,1025,28) * buryWat, v5, -0.02)
print("sky + water buried")

--@ chunk 218
print(wait(2*24*60), drying(300,400), drying(300,900))

--@ chunk 219
print(wait(2*24*60), drying(300,400), drying(300,900), drying(300,1100))

--@ chunk 220
function lay(m, p, ang)
  work(m, {hand="body", pile=p, coverage=3.0, fill=true, length={24,62},
           angle=ang or -0.05, pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
end
lay(b1, c1)
lay(bandM(140,410,55), c2)
lay(bandM(320,540,55), c3)
lay(bandM(440,645,55), c4)
lay(bandM(540,712,50), c5)
lay(bandM(610,762,42), c6)
lay(bandM(690,775,50), v1, -0.02)
lay(bandM(755,845,50), v2, -0.02)
lay(bandM(825,915,50), v3, -0.02)
lay(bandM(895,990,50), v4, -0.02)
lay(bandM(970,1025,28), v5, -0.02)
work(rect(-10, 1005, 190, 1140), {hand="body", pile=kCrest, coverage=3.0, fill=true,
     length={24,60}, angle=0.3, pressure={0.62,0.5}, clip=true})
print("sky, water, bank re-laid clean")

--@ chunk 221
print(wait(2*24*60), drying(300,400), drying(300,900), drying(100,1080))

--@ chunk 222
lay(bandM(975,1065,26) * rect(0,900,245,430), v5, -0.02)
lay(bandM(1012,1095,40) * bankZone, kCrest)
lay(bandM(1075,1175,45) * bankZone, kMid)
lay(bandM(1155,1260,45) * bankZone, kFore)
work(shoreM, {hand="body", pile=shoreP, coverage=3.0, fill=true, length={20,50},
              angle=-0.02, pressure={0.6,0.48}, clip=true})
work(woodM, {hand="body", pile=woodP, coverage=2.4, fill=true, length={10,26},
             angle=-0.02, pressure={0.5,0.4}, clip=true, edge="soft"})
print("bank and shore restored")

--@ chunk 223
sunCore2 = pile{{"lead white",20},{"chrome yellow",2.6},{"yellow ochre",0.9}}
work(ellipse(655, 668, 28, 26):blur(7), {hand="body", tool="round 5", pile=sunCore2, coverage=3.4,
      fill=true, length={10,26}, pressure={0.5,0.42}, clip=true, edge="soft"})
stipple(ellipse(655, 672, 470, 240):blur(26), {
  pile=pile{{"lead white",13},{"pale smalt",2.4},{"yellow ochre",1.0},{"chrome yellow",0.3}, medium=0.2},
  width=14, coverage=function(x, y)
    local r = ell(x, y, 655, 672, 430, 205)
    if r >= 1 then return 0 end
    return 2.6 * (1 - r) ^ 1.2
  end,
  pressure={0.3,0.46}, cluster=0.45, feather=0.85, dips={14, 0.5, 0.35}})
stipple(mistArea, {pile=mistPile, width=9, coverage=mistCov, pressure={0.3,0.42},
                   cluster=0.6, feather=0.8, drag={7, 0}, dips={16, 0.45, 0.4}})
print("sun, glow, mist")

--@ chunk 224
print("bankZone area", bankZone:area(), "at(400,1100)", bankZone:at(400,1100))
print("kCrest", kCrest)
print("kFore", kFore)
print("mistArea area", mistArea:area(), "at(400,1050)", mistArea:at(400,1050))
print("glowMask area", ellipse(655,672,470,240):blur(26):area(), "at(400,1050)", ellipse(655,672,470,240):blur(26):at(400,1050))
print("drying bank", drying(400,1100), drying(400,1200))

--@ chunk 225
work(rect(240,1100,160,110), {hand="body", pile=kFore, coverage=3.0, fill=false,
     length={24,62}, angle=0.3, pressure={0.7,0.55}, ramps={0.1,0.25}, clip=true})
work(rect(460,1100,160,110), {hand="body", pile=kFore, coverage=3.0, fill=true,
     length={24,62}, angle=0.3, pressure={0.7,0.55}, ramps={0.1,0.25}, clip=true})
work(rect(680,1100,160,110), {hand="body", tool="filbert 22", pile=kFore, coverage=2.5, fill=true,
     length={60,160}, angle=0.3, pressure={0.8,0.7}, ramps={0.06,0.2}, clip=true})
print("three test patches")

--@ chunk 226
work(rect(240,1100,150,105), {hand="body", pile=kFore, coverage=6.0, fill=true,
     length={24,62}, angle=0.3, pressure={0.75,0.6}, ramps={0.1,0.25}, clip=true})
work(rect(410,1100,150,105), {hand="body", pile=kFore, coverage=10.0, fill=true,
     length={24,62}, angle=0.3, pressure={0.85,0.7}, ramps={0.08,0.2}, clip=true})
work(rect(580,1100,150,105), {hand="broad", pile=kFore, coverage=3.0, fill=true,
     length={90,200}, angle=0.3, pressure={0.8,0.65}, ramps={0.06,0.2}, clip=true})
print("coverage test")

--@ chunk 227
function layb(m, p)
  work(m, {hand="body", pile=p, coverage=9.0, fill=true, length={24,62},
           angle=0.3, pressure={0.8,0.65}, ramps={0.08,0.22}, dips={3,0.7,0.25}, clip=true})
end
layb(bandM(1012,1095,40) * bankZone, kCrest)
layb(bandM(1075,1175,45) * bankZone, kMid)
layb(bandM(1155,1260,45) * bankZone, kFore)
print("bank laid solid")

--@ chunk 228
print(wait(2*24*60), drying(300,900), drying(300,1100))

--@ chunk 229
print(wait(24*60), drying(300,1100), drying(300,1200))

--@ chunk 230
print(wait(24*60), drying(300,1100))

--@ chunk 231
function layw(m, p)
  work(m, {hand="body", pile=p, coverage=8.0, fill=true, length={24,62}, angle=-0.02,
           pressure={0.78,0.62}, ramps={0.08,0.22}, dips={3,0.7,0.25}, clip=true})
end
v1b = pile{{"lead white",7.5},{"pale smalt",3.6},{"smalt",1.9},{"raw umber",1.25}}
layw(bandM(690,772,44), v1b)
layw(bandM(750,840,44), v2)
layw(bandM(820,905,44), v3)
layw(bandM(890,968,38), v4)
layw(bandM(950,1016,24), v5)
print("water laid solid")

--@ chunk 232
print(wait(2*24*60), drying(300,900), drying(700,800))

--@ chunk 233
print(wait(2*24*60), drying(300,900))

--@ chunk 234
print(wait(3*24*60), drying(300,900), drying(300,1100))

--@ chunk 235
v1c = pile{{"lead white",6},{"pale smalt",3.2},{"smalt",1.8},{"raw umber",1.6}}
v2c = pile{{"lead white",4.5},{"pale smalt",3.2},{"smalt",2.6},{"raw umber",2.4}}
v3c = pile{{"lead white",3.4},{"pale smalt",3.0},{"smalt",3.2},{"raw umber",3.1}}
v4c = pile{{"lead white",2.6},{"pale smalt",2.6},{"smalt",3.8},{"raw umber",4.0}}
v5c = pile{{"lead white",2.0},{"pale smalt",2.2},{"smalt",4.4},{"raw umber",4.8}}
layw(bandM(690,772,44), v1c)
layw(bandM(750,840,44), v2c)
layw(bandM(820,905,44), v3c)
layw(bandM(890,968,38), v4c)
layw(bandM(950,1016,24), v5c)
print("water darkened")

--@ chunk 236
print(wait(3*24*60), drying(300,900))

--@ chunk 237
print(wait(3*24*60), drying(300,900))

--@ chunk 238
u1 = pile{{"lead white",7},{"pale smalt",4},{"smalt",2.2},{"raw umber",0.9}}
u2 = pile{{"lead white",5.5},{"pale smalt",4},{"smalt",3.4},{"raw umber",1.4}}
u3 = pile{{"lead white",4.2},{"pale smalt",3.8},{"smalt",4.6},{"raw umber",2.0}}
u4 = pile{{"lead white",3.2},{"pale smalt",3.2},{"smalt",5.6},{"raw umber",2.6}}
u5 = pile{{"lead white",2.4},{"pale smalt",2.6},{"smalt",6.6},{"raw umber",3.2}}
layw(bandM(690,772,44), u1)
layw(bandM(750,840,44), u2)
layw(bandM(820,905,44), u3)
layw(bandM(890,968,38), u4)
layw(bandM(950,1016,24), u5)
print("cool water laid")

--@ chunk 239
function taperW(w0, n, keep)
  local w, k = {}, keep or 0.28
  for i = 0, n - 1 do
    local t = i / (n - 1)
    w[#w+1] = w0 * ((1 - t) + k * t)
  end
  return w
end
function limbPts(x, y, ang, len, n)
  local step = len / (n - 1)
  local a, px, py = ang, x, y
  local pts = {}
  for i = 1, n do
    a = a + randn(0, 0.07)
    px = px + math.cos(a) * step
    py = py + math.sin(a) * step
    pts[#pts+1] = {px, py}
  end
  return pts
end
A_spine = {{95,1105},{108,1015},{122,935},{136,865},{152,795},{166,712}}
A_spec = {{4,-2.62,245,12},{5,-2.15,275,12},{5,-1.60,285,12},{5,-1.02,255,11},
          {5,-0.52,195,9},{3,-3.02,225,10},{2,-2.80,180,8},{4,-1.78,235,10}}
A_limbs = {}
for i = 1, #A_spec do
  local s = A_spec[i]
  local pts = limbPts(A_spine[s[1]][1], A_spine[s[1]][2], s[2], s[3], 4)
  A_limbs[#A_limbs+1] = {pts = pts, widths = taperW(s[4], #pts, 0.10)}
end
A_frame = body_of{spine = A_spine, widths = taperW(30, #A_spine, 0.30),
                  limbs = A_limbs, blend = 0.2, char = "firm"}:mask()
print("frame area", A_frame:area())
work(A_frame, {hand="detail", pile=barkDark, coverage=6.0, fill=true,
               length={10,26}, pressure={0.7,0.55}, clip=true})
print("tree A frame painted")

--@ chunk 240
function twigline(x, y, ang, len, w, depth, out)
  local n = 3 + math.random(1, 2)
  local step = len / (n - 1)
  local a, px, py = ang, x, y
  local pts = {}
  for i = 1, n do
    a = a + randn(0, 0.13)
    px = px + math.cos(a) * step
    py = py + math.sin(a) * step
    pts[#pts+1] = {px, py}
  end
  out[#out+1] = {pts = pts, w = w}
  if depth > 0 then
    for i = 1, 2 do
      local ti = math.random(2, n)
      local bx, by = pts[ti][1], pts[ti][2]
      local side = (math.random() < 0.5) and -1 or 1
      local ba = a + side * (0.55 + 0.65 * math.random())
      ba = ba + (-1.5708 - ba) * 0.07
      twigline(bx, by, ba, len * (0.45 + 0.22 * math.random()),
               w * (0.56 + 0.14 * math.random()), depth - 1, out)
    end
  end
end
twigsA = {}
for i = 1, #A_limbs do
  local pts = A_limbs[i].pts
  for ti = 2, #pts do
    local bx, by = pts[ti][1], pts[ti][2]
    local a0 = math.atan(pts[ti][2] - pts[ti-1][2], pts[ti][1] - pts[ti-1][1])
    for j = 1, 2 do
      twigline(bx, by, a0 + randn(0, 0.5) + (j * 2 - 3) * 0.95, 46 + 26 * math.random(), 2.6, 2, twigsA)
    end
  end
end
print("twigs", #twigsA)
barkFine = pile{{"bone black",3},{"raw umber",4.5},{"green earth",0.4}}
tb = brush{kind="round", width=3.2, point=1, stiffness=0.45}
for i = 1, #twigsA do
  local T = twigsA[i]
  local p0 = clamp(0.32 + T.w * 0.17, 0.32, 1.0)
  tb:load(T.w > 1.5 and barkDark or barkFine, T.w > 1.5 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {p0, 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
print("twigs painted")

--@ chunk 241
function twigline(x, y, ang, len, w, depth, out)
  local n = 4 + math.random(1, 2)
  local step = len / (n - 1)
  local a, px, py = ang, x, y
  local pts = {}
  for i = 1, n do
    a = a + randn(0, 0.16)
    px = px + math.cos(a) * step
    py = py + math.sin(a) * step
    pts[#pts+1] = {px, py}
  end
  out[#out+1] = {pts = pts, w = w}
  if depth > 0 then
    for i = 1, 2 do
      local ti = math.random(2, n)
      local bx, by = pts[ti][1], pts[ti][2]
      local side = (math.random() < 0.5) and -1 or 1
      local ba = a + side * (0.60 + 0.85 * math.random())
      twigline(bx, by, ba, len * (0.48 + 0.20 * math.random()),
               w * (0.56 + 0.14 * math.random()), depth - 1, out)
    end
  end
end
twigsA = {}
local function seedFrom(pts, angAdj)
  for ti = 2, #pts do
    local bx, by = pts[ti][1], pts[ti][2]
    local a0 = math.atan(pts[ti][2] - pts[ti-1][2], pts[ti][1] - pts[ti-1][1])
    for j = 1, 3 do
      twigline(bx, by, a0 + randn(0, 0.55) + (j * 2 - 4) * 0.8 + (angAdj or 0),
               100 + 55 * math.random(), 3.0, 2, twigsA)
    end
  end
end
for i = 1, #A_limbs do seedFrom(A_limbs[i].pts) end
for ti = 3, #A_spine do
  local bx, by = A_spine[ti][1], A_spine[ti][2]
  for j = 1, 3 do
    twigline(bx, by, -1.5708 + randn(0, 0.7) + (j * 2 - 4) * 0.8, 80 + 45 * math.random(), 2.6, 2, twigsA)
  end
end
print("twigs", #twigsA)
for i = 1, #twigsA do
  local T = twigsA[i]
  local p0 = clamp(0.30 + T.w * 0.17, 0.30, 1.0)
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {p0, 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
print("twigs painted")

--@ chunk 242
B_spine = {{318,1092},{331,1022},{343,957},{353,897},{363,836},{373,779}}
B_spec = {{5,-2.05,215,10},{5,-1.45,235,10},{5,-0.85,205,9},{4,-2.60,195,9},
          {3,-3.10,175,8},{5,-0.35,155,7},{4,-1.90,215,9}}
B_limbs = {}
for i = 1, #B_spec do
  local s = B_spec[i]
  local pts = limbPts(B_spine[s[1]][1], B_spine[s[1]][2], s[2], s[3], 4)
  B_limbs[#B_limbs+1] = {pts = pts, widths = taperW(s[4], #pts, 0.10)}
end
B_frame = body_of{spine = B_spine, widths = taperW(24, #B_spine, 0.30),
                  limbs = B_limbs, blend = 0.2, char = "firm"}:mask()
work(B_frame, {hand="detail", pile=barkDark, coverage=6.0, fill=true,
               length={10,26}, pressure={0.7,0.55}, clip=true})
twigsB = {}
for i = 1, #B_limbs do
  local pts = B_limbs[i].pts
  for ti = 2, #pts do
    local bx, by = pts[ti][1], pts[ti][2]
    local a0 = math.atan(pts[ti][2] - pts[ti-1][2], pts[ti][1] - pts[ti-1][1])
    for j = 1, 3 do
      twigline(bx, by, a0 + randn(0, 0.55) + (j * 2 - 4) * 0.8,
               85 + 50 * math.random(), 2.8, 2, twigsB)
    end
  end
end
for ti = 3, #B_spine do
  local bx, by = B_spine[ti][1], B_spine[ti][2]
  for j = 1, 3 do
    twigline(bx, by, -1.5708 + randn(0, 0.7) + (j * 2 - 4) * 0.8, 70 + 40 * math.random(), 2.4, 2, twigsB)
  end
end
print("twigsB", #twigsB)
for i = 1, #twigsB do
  local T = twigsB[i]
  local p0 = clamp(0.30 + T.w * 0.17, 0.30, 1.0)
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {p0, 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
print("tree B painted")

--@ chunk 243
roots = {}
local function rootFrom(x, y, s, n)
  for i = 1, n do
    local a = s + (i - (n + 1) / 2) * 0.42 + randn(0, 0.1)
    local pts = limbPts(x, y, a, 62 + 46 * math.random(), 4)
    roots[#roots+1] = {pts = pts, widths = taperW(11 - i * 0.8, #pts, 0.08)}
  end
end
rootFrom(95, 1105, 2.55, 4)
rootFrom(110, 1022, 2.50, 3)
rootFrom(120, 945, 2.45, 2)
rootFrom(318, 1092, 2.60, 4)
rootFrom(332, 1030, 2.55, 3)
rootFrom(344, 965, 2.50, 2)
rootMask = body_of{spine = {{0,0}}, widths = 0.2, limbs = roots, blend = 0.2, char = "firm"}:mask()
work(rootMask, {hand="detail", pile=barkDark, coverage=5.0, fill=true,
                length={10,24}, pressure={0.65,0.5}, clip=true})
-- the trees' long shadows, thrown left by the low sun
shadowP = pile{{"bone black",3},{"raw umber",4}}
shadowM = (poly({{-10,1128},{120,1090},{330,1060},{470,1048},{470,1078},{300,1104},{110,1140},{-10,1180}}, true):blur(22)) * bankZone
work(shadowM, {hand="body", pile=shadowP, coverage=3.5, fill=true, length={30,80},
               angle=0.28, pressure={0.6,0.45}, clip=true, edge="soft"})
print("roots and shadows laid")

--@ chunk 244
local rows = {}
for r = 0, 25 do
  local line = ""
  for c = 0, 49 do
    local v = 0
    for dy = 0, 2 do
      for dx = 0, 2 do
        v = math.max(v, rootMask:at(c * 20 + dx * 6, r * 50 + dy * 16))
      end
    end
    line = line .. (v > 0.6 and "#" or v > 0.25 and "+" or v > 0.05 and "." or " ")
  end
  rows[#rows+1] = line
end
print(table.concat(rows, "\n"))

--@ chunk 245
rootsA, rootsB = {}, {}
local function rootFrom(list, x, y, s, n)
  for i = 1, n do
    local a = s + (i - (n + 1) / 2) * 0.42 + randn(0, 0.1)
    local pts = limbPts(x, y, a, 62 + 46 * math.random(), 4)
    list[#list+1] = {pts = pts, widths = taperW(11 - i * 0.8, #pts, 0.08)}
  end
end
rootFrom(rootsA, 95, 1105, 2.55, 4)
rootFrom(rootsA, 110, 1022, 2.50, 3)
rootFrom(rootsA, 120, 945, 2.45, 2)
rootFrom(rootsB, 318, 1092, 2.60, 4)
rootFrom(rootsB, 332, 1030, 2.55, 3)
rootFrom(rootsB, 344, 965, 2.50, 2)
function merge(a, b) local r = {} for i=1,#a do r[#r+1]=a[i] end for i=1,#b do r[#r+1]=b[i] end return r end
goodA = body_of{spine = A_spine, widths = taperW(30, #A_spine, 0.30),
                limbs = merge(A_limbs, rootsA), blend = 0.2, char = "firm"}:mask()
goodB = body_of{spine = B_spine, widths = taperW(24, #B_spine, 0.30),
                limbs = merge(B_limbs, rootsB), blend = 0.2, char = "firm"}:mask()
goodMask = goodA + goodB
print("good area", goodA:area(), goodB:area(), "total", goodMask:area())
artifact = rootMask - goodMask
print("artifact area", artifact:area())
print("A_frame area", A_frame:area())

--@ chunk 246
print(wait(3*24*60), drying(150,400), drying(200,800), drying(150,1100))

--@ chunk 247
print(wait(2*24*60), drying(150,400))

--@ chunk 248
print(wait(3*24*60), drying(150,400))

--@ chunk 249
local bands = {
  {b1, c1}, {bandM(140,410,55), c2}, {bandM(320,540,55), c3}, {bandM(440,645,55), c4},
  {bandM(540,712,50), c5}, {bandM(610,762,42), c6},
  {bandM(690,772,44), u1}, {bandM(750,840,44), u2}, {bandM(820,905,44), u3},
  {bandM(890,968,38), u4}, {bandM(950,1016,24), u5}}
for i = 1, #bands do
  local m = artifact * bands[i][1]
  if m:area() > 30 then
    lay(m, bands[i][2], (i >= 7) and -0.02 or -0.05)
  end
end
print("artifact erased from sky and water")

--@ chunk 250
print(wait(3*24*60), drying(150,400), drying(200,800))

--@ chunk 251
lay(b1, c1)
lay(bandM(140,410,55), c2)
lay(bandM(320,540,55), c3)
lay(bandM(440,645,55), c4)
lay(bandM(540,712,50), c5)
lay(bandM(690,772,44), u1, -0.02)
lay(bandM(755,845,50), u2, -0.02)
lay(bandM(820,905,44), u3, -0.02)
lay(bandM(890,968,38), u4, -0.02)
lay(bandM(950,1016,24), u5, -0.02)
work(shoreM, {hand="body", pile=shoreP, coverage=4.0, fill=true, length={20,50},
              angle=-0.02, pressure={0.6,0.48}, clip=true})
work(woodM, {hand="body", pile=woodP, coverage=3.0, fill=true, length={10,26},
             angle=-0.02, pressure={0.5,0.4}, clip=true, edge="soft"})
print("sky, water, shore clean")

--@ chunk 252
local m = bandM(950,1016,24)
local out = {}
for y = 1000, 1200, 20 do out[#out+1] = y .. ":" .. string.format("%.3f", m:at(500, y)) end
print(table.concat(out, " "))
print("bankZone at 1100:", bankZone:at(500,1100), "at 1040:", bankZone:at(500,1040))
print("area of bandM(950,1016,24):", m:area())

--@ chunk 253
shoreBand = mask(function(x, y)
  local t = shoretop(x)
  if y > t - 2 and y < t + 22 then return 1 end
  return 0 end):blur(6)
woodBand = mask(function(x, y)
  local t = shoretop(x)
  if y > t - 14 and y < t + 5 then return 1 end
  return 0 end):blur(4)
print("shoreBand area", shoreBand:area(), "woodBand", woodBand:area())
print(wait(3*24*60), drying(500,900), drying(500,1150))

--@ chunk 254
waterZone = mask(function(x, y) if y > 692 and y < 1016 then return 1 end return 0 end):blur(6)
layw(bandM(690,772,44) * waterZone, u1)
layw(bandM(755,840,44) * waterZone, u2)
layw(bandM(820,905,44) * waterZone, u3)
layw(bandM(890,968,38) * waterZone, u4)
layw(bandM(950,1014,22) * waterZone, u5)
work(shoreBand, {hand="body", pile=shoreP, coverage=4.0, fill=true, length={20,50},
                 angle=-0.02, pressure={0.6,0.48}, clip=true})
work(woodBand, {hand="body", pile=woodP, coverage=3.0, fill=true, length={10,26},
                angle=-0.02, pressure={0.5,0.4}, clip=true, edge="soft"})
print("water + shore redone")

--@ chunk 255
layb(bandM(1012,1095,40) * bankZone, kCrest)
layb(bandM(1075,1175,45) * bankZone, kMid)
layb(bandM(1155,1260,45) * bankZone, kFore)
print("bank redone")

--@ chunk 256
print(wait(3*24*60), drying(500,900), drying(500,1150))

--@ chunk 257
print(wait(3*24*60), drying(500,900))

--@ chunk 258
p1 = pile{{"lead white",9},{"pale smalt",3.6},{"smalt",1.8},{"raw umber",1.0}}
p2 = pile{{"lead white",6.5},{"pale smalt",3.4},{"smalt",2.2},{"raw umber",1.7}}
p3 = pile{{"lead white",5},{"pale smalt",3},{"smalt",2.5},{"raw umber",2.6}}
p4 = pile{{"lead white",3.5},{"pale smalt",2.5},{"smalt",2.5},{"raw umber",3.5},{"bone black",0.8}}
p5 = pile{{"lead white",2.5},{"pale smalt",2},{"smalt",2.5},{"raw umber",4.5},{"bone black",1.5}}
layw(bandM(690,772,44) * waterZone, p1)
layw(bandM(755,840,44) * waterZone, p2)
layw(bandM(820,905,44) * waterZone, p3)
layw(bandM(890,968,38) * waterZone, p4)
layw(bandM(950,1014,22) * waterZone, p5)
print("water ramp laid")

--@ chunk 259
print(wait(3*24*60), drying(500,900), drying(500,300))

--@ chunk 260
print(wait(3*24*60), drying(500,900))

--@ chunk 261
function layS(m, p, ang)
  work(m, {hand="body", pile=p, coverage=13.0, fill=true, length={24,62}, angle=ang or -0.05,
           pressure={0.88,0.72}, ramps={0.06,0.18}, dips={3,0.75,0.22}, clip=true})
end
layS(b1, c1)
layS(bandM(140,410,55), c2)
layS(bandM(320,540,55), c3)
layS(bandM(440,645,55), c4)
layS(bandM(540,712,50), c5)
print("sky opaque")

--@ chunk 262
layS(bandM(690,772,44) * waterZone, p1, -0.02)
layS(bandM(755,840,44) * waterZone, p2, -0.02)
layS(bandM(820,905,44) * waterZone, p3, -0.02)
layS(bandM(890,968,38) * waterZone, p4, -0.02)
layS(bandM(950,1014,22) * waterZone, p5, -0.02)
layS(shoreBand, shoreP, -0.02)
work(woodBand, {hand="body", pile=woodP, coverage=4.0, fill=true, length={10,26},
               angle=-0.02, pressure={0.55,0.45}, clip=true, edge="soft"})
layS(bandM(1012,1095,40) * bankZone, kCrest, 0.3)
layS(bandM(1075,1175,45) * bankZone, kMid, 0.3)
layS(bandM(1155,1260,45) * bankZone, kFore, 0.3)
print("water, shore, bank opaque")

--@ chunk 263
print(wait(3*24*60), drying(500,900), drying(500,1150))

--@ chunk 264
print(wait(3*24*60), drying(500,900))

--@ chunk 265
print(wait(3*24*60), drying(500,900), drying(500,1150))

--@ chunk 266
function glaze(m, p, cov)
  work(m, {hand="glaze", pile=p, coverage=cov or 2.4, fill=true, length={150,300}, angle=-0.02,
           pressure={0.55,0.45}, ramps={0.15,0.35}, dips={2,0.6,0.3}, clip=true})
end
glaze(bandM(690,780,60) * waterZone, pile{{"smalt",3},{"raw umber",2},{"pale smalt",2}}, 1.8)
glaze(bandM(750,850,60) * waterZone, pile{{"smalt",3},{"raw umber",3},{"pale smalt",2}}, 2.2)
glaze(bandM(820,915,55) * waterZone, pile{{"smalt",3},{"raw umber",4},{"bone black",1},{"pale smalt",2}}, 2.6)
glaze(bandM(890,975,45) * waterZone, pile{{"smalt",3},{"raw umber",5},{"bone black",2},{"pale smalt",2}}, 3.0)
glaze(bandM(950,1016,28) * waterZone, pile{{"smalt",3},{"raw umber",6},{"bone black",3},{"pale smalt",2}}, 3.4)
print("water glazed darker")

--@ chunk 267
print(wait(3*24*60), drying(500,800), drying(500,950))

--@ chunk 268
pA = pile{{"lead white",10},{"pale smalt",3.4},{"smalt",1.6},{"raw umber",0.8}}
pB = pile{{"lead white",8},{"pale smalt",3.4},{"smalt",2},{"raw umber",1.3}}
layS(bandM(690,748,38) * waterZone, pA, -0.02)
layS(bandM(728,806,40) * waterZone, pB, -0.02)
layS(shoreBand, shoreP, -0.02)
work(woodBand, {hand="body", pile=woodP, coverage=4.0, fill=true, length={10,26},
               angle=-0.02, pressure={0.55,0.45}, clip=true, edge="soft"})
-- cover the bare line at the bank crest
crestM = bandM(1015,1075,26) * bankZone:grow(9)
layS(crestM, pile{{"raw umber",5},{"bone black",1.2},{"green earth",1.4},{"yellow ochre",1.8}}, 0.25)
print("far water, shore, crest")

--@ chunk 269
print(drying(500,880), drying(500,960), drying(300,1040))

--@ chunk 270
pC = pile{{"lead white",6.5},{"pale smalt",3.2},{"smalt",2.2},{"raw umber",2.0}}
pD = pile{{"lead white",5},{"pale smalt",2.9},{"smalt",2.8},{"raw umber",3.0}}
layS(bandM(790,872,46) * waterZone, pC, -0.02)
layS(bandM(858,940,40) * waterZone, pD, -0.02)
print("water steps smoothed")

--@ chunk 271
print(wait(3*24*60), drying(500,850), drying(500,980))

--@ chunk 272
print(wait(3*24*60), drying(500,850))

--@ chunk 273
print(wait(3*24*60), drying(500,850), drying(300,1100))

--@ chunk 274
function zlay(m, p, cov)
  work(m, {hand="body", pile=p, coverage=cov, fill=true, length={20,58}, angle=-0.02,
           pressure={0.55,0.42}, ramps={0.15,0.35}, dips={4,0.55,0.35}, clip=true})
end
zlay(bandM(690,790,55) * waterZone, pile{{"smalt",2},{"raw umber",1}}, 1.6)
zlay(bandM(760,852,50) * waterZone, pile{{"smalt",3},{"raw umber",2.5},{"pale smalt",2}}, 3.0)
zlay(bandM(830,912,44) * waterZone, pile{{"smalt",3},{"raw umber",3.5},{"bone black",1},{"pale smalt",2}}, 4.0)
zlay(bandM(890,962,38) * waterZone, pile{{"smalt",3},{"raw umber",5},{"bone black",2},{"pale smalt",2}}, 5.0)
zlay(bandM(945,1016,28) * waterZone, pile{{"smalt",3},{"raw umber",6},{"bone black",3},{"pale smalt",2}}, 5.5)
print("lake glazed")

--@ chunk 275
print(wait(3*24*60), drying(500,850), drying(500,980))

--@ chunk 276
L1 = pile{{"smalt",4},{"raw umber",2}}
L2 = pile{{"smalt",4},{"raw umber",3.5},{"pale smalt",1.5}}
L3 = pile{{"smalt",4},{"raw umber",5},{"bone black",1},{"pale smalt",1.5}}
L4 = pile{{"smalt",4},{"raw umber",6},{"bone black",2},{"pale smalt",1.5}}
L5 = pile{{"smalt",4},{"raw umber",7},{"bone black",3},{"pale smalt",1.5}}
local function layL(m, p, cov)
  work(m, {hand="body", pile=p, coverage=cov or 3.2, fill=true, length={24,62}, angle=-0.02,
           pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
end
layL(bandM(690,762,48) * waterZone, L1, 2.2)
layL(bandM(748,822,46) * waterZone, L2, 2.8)
layL(bandM(808,884,42) * waterZone, L3, 3.2)
layL(bandM(868,948,40) * waterZone, L4, 3.6)
layL(bandM(932,1016,26) * waterZone, L5, 4.0)
layS(shoreBand, shoreP, -0.02)
work(woodBand, {hand="body", pile=woodP, coverage=4.0, fill=true, length={10,26},
               angle=-0.02, pressure={0.55,0.45}, clip=true, edge="soft"})
print("lake re-laid")

--@ chunk 277
print(wait(3*24*60), drying(500,850), drying(500,980))

--@ chunk 278
wA = pile{{"lead white",9},{"pale smalt",4},{"smalt",2},{"raw umber",1.2}}
wB = pile{{"lead white",7.5},{"pale smalt",4},{"smalt",2.6},{"raw umber",2.0}}
wC = pile{{"lead white",6},{"pale smalt",3.8},{"smalt",3.2},{"raw umber",2.9}}
wD = pile{{"lead white",4.5},{"pale smalt",3.4},{"smalt",3.8},{"raw umber",3.8},{"bone black",0.6}}
wE = pile{{"lead white",3.2},{"pale smalt",3},{"smalt",4.4},{"raw umber",4.6},{"bone black",1.2}}
local function layW(m, p)
  work(m, {hand="body", pile=p, coverage=3.2, fill=true, length={24,62}, angle=-0.02,
           pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
end
layW(bandM(690,772,50) * waterZone, wA)
layW(bandM(752,838,48) * waterZone, wB)
layW(bandM(818,900,44) * waterZone, wC)
layW(bandM(882,962,40) * waterZone, wD)
layW(bandM(946,1016,26) * waterZone, wE)
layS(shoreBand, shoreP, -0.02)
work(woodBand, {hand="body", pile=woodP, coverage=4.0, fill=true, length={10,26},
               angle=-0.02, pressure={0.55,0.45}, clip=true, edge="soft"})
print("lake laid with sky recipe")

--@ chunk 279
print(wait(3*24*60), drying(500,850), drying(200,950))

--@ chunk 280
work(goodMask, {hand="detail", pile=barkDark, coverage=6.0, fill=true,
                 length={10,26}, pressure={0.7,0.55}, clip=true})
print("frames and roots laid")

--@ chunk 281
tb = brush{kind="round", width=3.2, point=1, stiffness=0.45}
for i = 1, #twigsA do
  local T = twigsA[i]
  local p0 = clamp(0.30 + T.w * 0.17, 0.30, 1.0)
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {p0, 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
print("twigs A laid", #twigsA)

--@ chunk 282
for i = 1, #twigsB do
  local T = twigsB[i]
  local p0 = clamp(0.30 + T.w * 0.17, 0.30, 1.0)
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {p0, 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
print("twigs B laid", #twigsB)

--@ chunk 283
function fillCrown(ells, cx, cy, count, len0, w0, depth)
  local out = {}
  for i = 1, count do
    local e = ells[1 + math.random(0, #ells - 1)]
    local r = math.sqrt(math.random())
    local a = rand(0, 6.2832)
    local bx = e[1] + e[2] * r * math.cos(a)
    local by = e[3] + e[4] * r * math.sin(a)
    local out2 = math.atan(by - cy, bx - cx) + randn(0, 0.85)
    twigline(bx, by, out2, len0 * (0.6 + 0.7 * math.random()), w0 * (0.6 + 0.6 * math.random()), depth, out)
  end
  return out
end
crownA = fillCrown({{60,190,640,200},{200,190,520,200},{330,150,620,160},{150,160,760,140}},
                  170, 620, 190, 95, 2.4, 2)
print("crownA", #crownA)
for i = 1, #crownA do
  local T = crownA[i]
  local p0 = clamp(0.28 + T.w * 0.16, 0.28, 0.95)
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {p0, 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
print("crown A filled")

--@ chunk 284
crownB = fillCrown({{330,150,720,160},{250,140,660,140},{430,120,720,130},{350,140,830,110}},
                  340, 740, 150, 80, 2.2, 2)
topA = fillCrown({{80,180,250,90},{230,180,300,95},{340,150,300,70}},
                 200, 300, 90, 75, 2.0, 2)
print("crownB", #crownB, "topA", #topA)
for i = 1, #crownB do
  local T = crownB[i]
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.28 + T.w * 0.16, 0.28, 0.95), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
for i = 1, #topA do
  local T = topA[i]
  tb:load(barkFine, 0.45)
  tb:stroke(T.pts, {pressure = {clamp(0.26 + T.w * 0.16, 0.26, 0.9), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
print("crown B and top filled")

--@ chunk 285
print(drying(655,668), drying(500,750), drying(200,400))

--@ chunk 286
sunCore2 = pile{{"lead white",20},{"chrome yellow",2.6},{"yellow ochre",0.9}}
work(ellipse(655, 668, 28, 26):blur(7), {hand="body", tool="round 5", pile=sunCore2, coverage=4.0,
      fill=true, length={10,26}, pressure={0.5,0.42}, clip=true, edge="soft"})
stipple(ellipse(655, 672, 470, 240):blur(26), {
  pile=pile{{"lead white",13},{"pale smalt",2.4},{"yellow ochre",1.0},{"chrome yellow",0.3}, medium=0.2},
  width=14, coverage=function(x, y)
    local r = ell(x, y, 655, 672, 430, 205)
    if r >= 1 then return 0 end
    return 2.6 * (1 - r) ^ 1.2
  end,
  pressure={0.3,0.46}, cluster=0.45, feather=0.85, dips={14, 0.5, 0.35}})
print("sun and glow")

--@ chunk 287
function mistCov(x, y)
  local up = clamp((y - 698) / 24, 0, 1)
  local dn = clamp((856 - y) / 150, 0, 1)
  local patch = 0.30 + 0.70 * nm:at01(x, y * 0.5)
  return 2.3 * up * dn * patch
end
stipple(mistArea, {pile=mistPile, width=9, coverage=mistCov, pressure={0.3,0.42},
                   cluster=0.6, feather=0.8, drag={7, 0}, dips={16, 0.45, 0.4}})
print("mist on the water")

--@ chunk 288
figPts = {{558,952},{567,949},{573,957},{575,967},{578,981},{581,997},{585,1011},
           {586,1021},{578,1027},{549,1027},{541,1021},{543,1008},{546,992},{549,978},
           {551,966},{552,956}}
figM = poly(figPts, true):blur(1.5)
figPile = pile{{"bone black",5},{"raw umber",3.5},{"green earth",0.6}}
work(figM, {hand="detail", pile=figPile, coverage=5.0, fill=true, length={8,20},
            pressure={0.75,0.6}, clip=true})
print("figure laid", figM:area())

--@ chunk 289
figPts2 = {{555,957},{562,949},{570,953},{573,962},{570,969},{576,975},{579,991},
            {582,1007},{583,1024},{573,1029},{548,1029},{540,1023},{542,1004},{546,988},
            {550,974},{553,967},{551,960}}
figM2 = poly(figPts2, true):blur(1.2)
work(figM2, {hand="detail", pile=figPile, coverage=5.0, fill=true, length={8,20},
             pressure={0.78,0.62}, clip=true})
-- the sun is to her right: a thin warm rim down that side
litEdgeP = pile{{"raw umber",3},{"yellow ochre",1.4},{"lead white",1.3}}
fb = brush{kind="round", width=2.0, point=1, stiffness=0.4}
fb:load(litEdgeP, 0.5)
fb:stroke({{569,953},{573,963},{572,970},{577,978},{580,995},{583,1012},{583,1024}},
          {pressure={0.85,0.12}, ramps={0.12,0.5}, shake=0.3})
fb:load(litEdgeP, 0.4)
fb:stroke({{558,951},{556,958},{554,966}}, {pressure={0.6,0.1}, ramps={0.15,0.5}})
print("figure redrawn")

--@ chunk 290
crestFix = mask(function(x, y) if y > 1004 and y < 1042 then return 1 end return 0 end):blur(11)
shoreBrown = pile{{"raw umber",5},{"bone black",1.4},{"green earth",1.6},{"yellow ochre",1.5}}
work(crestFix, {hand="body", pile=shoreBrown, coverage=4.0, fill=true, length={22,58},
                angle=-0.02, pressure={0.62,0.5}, clip=true, edge="soft"})
grassA = pile{{"yellow ochre",3},{"raw umber",3},{"lead white",0.7}}
grassB = pile{{"raw umber",4},{"bone black",1.2},{"yellow ochre",1.1}}
work(bandM(1008,1120,52) * bankZone, {hand="hatch", pile=grassA,
     tool={kind="round", width=2.2, point=1}, length={10,30}, angle=-1.30, coverage=0.55,
     pressure={0.5,0.25}, clump=0.7, clip=true, edge="soft"})
work(bankZone, {hand="hatch", pile=grassB, tool={kind="round", width=2.0, point=1},
     length={8,26}, angle=-1.25, coverage=0.45, pressure={0.45,0.2}, clump=0.75, clip=true, edge="soft"})
print("crest and grass")

--@ chunk 291
function layW2(m, p)
  work(m, {hand="body", pile=p, coverage=4.5, fill=true, length={24,62}, angle=0.3,
           pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
end
layW2(bandM(1008,1092,40) * bankZone, kCrest)
layW2(bandM(1072,1172,45) * bankZone, kMid)
layW2(bandM(1152,1262,45) * bankZone, kFore)
work(shadowM, {hand="body", pile=shadowP, coverage=2.6, fill=true, length={30,80},
               angle=0.28, pressure={0.5,0.38}, clip=true, edge="soft"})
print("bank re-laid, straw buried")

--@ chunk 292
grassA2 = pile{{"raw umber",5},{"yellow ochre",1.7},{"lead white",0.45}}
grassB2 = pile{{"raw umber",4.5},{"bone black",1.4},{"yellow ochre",0.9}}
ng2 = noise{seed=53, octaves=4, period=70}
work(bandM(1010,1120,55) * bankZone, {hand="hatch", pile=grassA2,
     tool={kind="round", width=2.0, point=1}, length={9,28}, angle=-1.28, coverage=0.5,
     pressure={0.42,0.2}, clump=0.8,
     load_at=function(x, y) return 0.2 + 0.55 * ng2:at01(x, y * 0.6) end,
     clip=true, edge="soft"})
work(bankZone, {hand="hatch", pile=grassB2, tool={kind="round", width=1.8, point=1},
     length={7,24}, angle=-1.22, coverage=0.4, pressure={0.38,0.18}, clump=0.85,
     load_at=function(x, y) return 0.18 + 0.5 * ng2:at01(x * 1.3, y * 0.5 + 300) end,
     clip=true, edge="soft"})
print("muted grass")

--@ chunk 293
print(drying(500,800), drying(500,950), drying(300,1100))
ripDark2 = pile{{"smalt",3},{"raw umber",3},{"pale smalt",1}}
ripLite2 = pile{{"lead white",6},{"pale smalt",3}}
local rb = {
 {bandM(704,782,28) * waterZone, {12,34}, 0.40,  0.012},
 {bandM(762,852,32) * waterZone, {20,56}, 0.45, -0.010},
 {bandM(832,932,34) * waterZone, {30,86}, 0.50,  0.008},
 {bandM(912,1014,30) * waterZone, {45,120},0.55, -0.007}}
local function rip2(m, p, len, cov, ang)
  work(m, {hand="hatch", tool={kind="round", width=2.6, point=1}, pile=p, length=len, angle=ang,
           coverage=cov, pressure={0.45,0.22}, ramps={0.3,0.5}, clump=0.7, clip=true, edge="soft"})
end
for i = 1, 4 do rip2(rb[i][1], ripLite2, rb[i][2], rb[i][3] * 0.8, rb[i][4] + 0.01) end
for i = 1, 4 do rip2(rb[i][1], ripDark2, rb[i][2], rb[i][3], rb[i][4]) end
print("ripples laid")

--@ chunk 294
np2 = noise{seed=31, octaves=4, period=70, stretch={0, 0.25}}
function pathCov(x, y)
  if y < 698 or y > 1014 then return 0 end
  local up = clamp((y - 700) / 30, 0, 1)
  local h = 26 + (y - 700) * 0.13
  local dx = (x - 655) / h
  local a = math.exp(-dx * dx * 2.0)
  local down = 0.25 + 0.75 * clamp((1010 - y) / 290, 0, 1)
  local shim = 0.45 + 0.55 * np2:at01(x, y * 0.6)
  return 1.9 * up * a * down * shim
end
stipple(mask(function(x, y) if y > 694 and y < 1016 then return 1 end return 0 end):blur(8),
  {pile=pile{{"lead white",9},{"pale smalt",3},{"yellow ochre",0.7},{"chrome yellow",0.15}},
   width=10, coverage=pathCov, pressure={0.3,0.44}, cluster=0.55, feather=0.8,
   drag={8, 0}, dips={16, 0.45, 0.4}})
print("light path")

--@ chunk 295
nc = noise{seed=67, octaves=4, period=130}
function gauss(x, y, cx, cy, rx, ry)
  local dx, dy = (x - cx) / rx, (y - cy) / ry
  return math.exp(-(dx * dx + dy * dy))
end
darkC = {{140,230,190,20,1.3},{330,130,210,15,1.1},{620,190,230,22,1.2},{860,120,180,14,1.0},
         {180,350,170,18,1.1},{470,300,200,16,1.0},{830,330,190,18,1.1},{60,430,150,15,0.9},
         {350,470,160,14,0.85}}
function darkCov(x, y)
  if y < 40 or y > 620 then return 0 end
  local s = 0
  for i = 1, #darkC do
    local c = darkC[i]
    s = s + c[5] * gauss(x, y, c[1], c[2], c[3], c[4])
  end
  return clamp(s * (0.45 + 0.75 * nc:at01(x, y * 0.8)), 0, 1.9)
end
skyTop = mask(function(x, y) if y > 20 and y < 640 then return 1 end return 0 end):blur(14)
stipple(skyTop, {pile=pile{{"lead white",7},{"pale smalt",4.5},{"smalt",2.4},{"raw umber",1.75}},
         width=12, coverage=darkCov, pressure={0.3,0.45}, cluster=0.5, feather=0.85,
         drag={10, 0}, dips={16, 0.45, 0.4}})
print("upper clouds")

--@ chunk 296
litC2 = {{700,472,240,11,1.3},{300,442,180,10,1.0},{910,505,170,10,1.0},
         {520,548,200,9,1.2},{760,600,180,8,1.1},{150,590,150,8,0.9}}
function litCov(x, y)
  if y < 380 or y > 660 then return 0 end
  local s = 0
  for i = 1, #litC2 do
    local c = litC2[i]
    s = s + c[5] * gauss(x, y, c[1], c[2], c[3], c[4])
  end
  return clamp(s * (0.5 + 0.8 * nc:at01(x * 1.2, y * 0.9)), 0, 2.0)
end
stipple(skyTop, {pile=pile{{"lead white",12},{"pale smalt",3},{"yellow ochre",0.55},{"chrome yellow",0.12}},
         width=10, coverage=litCov, pressure={0.3,0.42}, cluster=0.55, feather=0.85,
         drag={8, 0}, dips={16, 0.45, 0.4}})
print("horizon clouds")

--@ chunk 297
print(drying(500,200), drying(500,500), drying(700,300))

--@ chunk 298
function darkCov2(x, y)
  if y < 30 or y > 640 then return 0 end
  local s = 0
  for i = 1, #darkC do
    local c = darkC[i]
    s = s + c[5] * 1.9 * gauss(x, y, c[1], c[2], c[3] * 1.15, c[4] * 1.15)
  end
  return clamp(s * (0.5 + 0.7 * nc:at01(x, y * 0.8)), 0, 2.6)
end
stipple(skyTop, {pile=pile{{"lead white",5},{"pale smalt",4},{"smalt",3},{"raw umber",2.4}},
         width=18, coverage=darkCov2, pressure={0.32,0.48}, cluster=0.55, feather=0.9,
         drag={14, 0}, dips={12, 0.5, 0.35}})
print("clouds strengthened")

--@ chunk 299
nl = noise{seed=83, octaves=4, period=48}
function litFac(x, y)
  return clamp(0.30 + 0.70 * ((x / 520) * 0.72 + (1 - y / 1000) * 0.28), 0, 1)
end
function limbCov(x, y)
  return 1.5 * litFac(x, y) * (0.5 + 0.7 * nl:at01(x, y))
end
stipple(goodMask:blur(2), {pile=pile{{"raw umber",4},{"yellow ochre",1.5},{"lead white",0.8}},
         width=8, coverage=limbCov, pressure={0.3,0.42}, cluster=0.5, feather=0.8, dips={18,0.4,0.45}})
print("limb modelling laid")

--@ chunk 300
rimP = pile{{"raw umber",2.4},{"yellow ochre",1.2},{"lead white",1.0}}
rbr = brush{kind="round", width=1.9, point=1, stiffness=0.4}
function rimStroke(pts, w0)
  local out, n = {}, #pts
  for i = 1, n do
    local px, py = pts[i][1], pts[i][2]
    local ax, ay = pts[math.max(1, i-1)][1], pts[math.max(1, i-1)][2]
    local bx, by = pts[math.min(n, i+1)][1], pts[math.min(n, i+1)][2]
    local dx, dy = bx - ax, by - ay
    local L = math.sqrt(dx * dx + dy * dy)
    if L < 0.001 then L = 1 end
    dx, dy = dx / L, dy / L
    local nx, ny = dy, -dx
    if nx < 0 then nx, ny = -nx, -ny end
    local off = w0 * (1 - 0.72 * (i - 1) / (n - 1))
    out[#out+1] = {px + nx * off, py + ny * off}
  end
  return out
end
rbr:load(rimP, 0.5)
for i = 1, #A_limbs do
  rbr:stroke(rimStroke(A_limbs[i].pts, A_limbs[i].widths[1] * 0.5),
             {pressure={0.9,0.1}, ramps={0.1,0.5}, shake=0.3})
end
rbr:load(rimP, 0.5)
for i = 1, #B_limbs do
  rbr:stroke(rimStroke(B_limbs[i].pts, B_limbs[i].widths[1] * 0.5),
             {pressure={0.9,0.1}, ramps={0.1,0.5}, shake=0.3})
end
print("rim light on the limbs")

--@ chunk 301
print(drying(150,700), drying(300,800))
barkWarm = pile{{"raw umber",5},{"yellow ochre",1.3},{"lead white",0.55}}
work(goodMask:blur(2), {hand="scumble", tool={kind="round", width=3.4, point=0.3},
     pile=barkWarm, coverage=2.4, fill=false, length={12,30}, angle=1.1,
     pressure={0.5,0.28}, ramps={0.2,0.4},
     load_at=function(x, y) return 0.12 + 0.5 * litFac(x, y) end,
     clip=true, edge="soft"})
print("bark scumble")

--@ chunk 302
rimP2 = pile{{"raw umber",2.2},{"yellow ochre",1.3},{"lead white",1.1}}
rbr2 = brush{kind="round", width=2.2, point=1, stiffness=0.4}
rbr2:load(rimP2, 0.55)
for i = 1, #A_limbs do
  local w0 = A_limbs[i].widths[1]
  rbr2:stroke(rimStroke(A_limbs[i].pts, w0 * 0.62), {pressure={0.95,0.12}, ramps={0.08,0.45}, shake=0.3})
end
rbr2:load(rimP2, 0.5)
for i = 1, #B_limbs do
  local w0 = B_limbs[i].widths[1]
  rbr2:stroke(rimStroke(B_limbs[i].pts, w0 * 0.62), {pressure={0.95,0.12}, ramps={0.08,0.45}, shake=0.3})
end
-- and along the trunks
rbr2:load(rimP2, 0.5)
rbr2:stroke(rimStroke(A_spine, 15), {pressure={0.8,0.15}, ramps={0.06,0.35}, shake=0.3})
rbr2:load(rimP2, 0.5)
rbr2:stroke(rimStroke(B_spine, 12), {pressure={0.8,0.15}, ramps={0.06,0.35}, shake=0.3})
print("rim light redone")

--@ chunk 303
work(goodMask, {hand="detail", pile=barkDark, coverage=6.0, fill=true,
                 length={10,26}, pressure={0.75,0.6}, clip=true})
print("limbs re-darkened")

--@ chunk 304
nb = noise{seed=97, octaves=5, period=26}
function warmCov(x, y)
  return 0.95 * litFac(x, y) * (0.22 + 1.15 * nb:at01(x, y))
end
stipple(goodMask:grow(4):blur(3), {pile=pile{{"raw umber",5},{"yellow ochre",1.1},{"lead white",0.3}},
         width=7, coverage=warmCov, pressure={0.3,0.45}, cluster=0.6, feather=0.85, dips={18,0.4,0.45}})
print("subtle warm modelling")

--@ chunk 305
function bankBase(x)
  if x <= bankLine[1][1] then return bankLine[1][2] end
  for i = 1, #bankLine - 1 do
    if x <= bankLine[i+1][1] then
      local t = (x - bankLine[i][1]) / (bankLine[i+1][1] - bankLine[i][1])
      return lerp(bankLine[i][2], bankLine[i+1][2], t)
    end
  end
  return bankLine[#bankLine][2]
end
nbank = noise{seed=59, octaves=3, period=80}
function edgeY2(x)
  return math.max(bankBase(x) - 13 + 15 * nbank:at01(x, 300), 1014)
end
bankZone2 = mask(function(x, y) if y > edgeY2(x) then return 1 end return 0 end):blur(5)
print("bank area", bankZone2:area())
k2Crest = pile{{"raw umber",5},{"bone black",2.2},{"green earth",1.5},{"yellow ochre",1.0}}
k2Mid = pile{{"raw umber",5.5},{"bone black",3.0},{"green earth",1.3},{"yellow ochre",0.7}}
k2Fore = pile{{"raw umber",6},{"bone black",4.0},{"green earth",1.0},{"yellow ochre",0.4}}
print(wait(3*24*60), drying(300,1100))

--@ chunk 306
print(wait(3*24*60), drying(300,1100))

--@ chunk 307
print(wait(3*24*60), drying(300,1100), drying(300,1200))

--@ chunk 308
function layB(m, p)
  work(m, {hand="body", pile=p, coverage=3.4, fill=true, length={24,62}, angle=0.3,
           pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
end
layB(bandM(1008,1092,42) * bankZone2, k2Crest)
layB(bandM(1072,1172,45) * bankZone2, k2Mid)
layB(bandM(1152,1262,45) * bankZone2, k2Fore)
print("dark bank laid")

--@ chunk 309
rootGoodA = body_of{spine = A_spine, widths = taperW(30, #A_spine, 0.30),
                     limbs = rootsA, blend = 0.2, char = "firm"}:mask()
rootGoodB = body_of{spine = B_spine, widths = taperW(24, #B_spine, 0.30),
                     limbs = rootsB, blend = 0.2, char = "firm"}:mask()
work(rootGoodA + rootGoodB, {hand="detail", pile=barkDark, coverage=5.0, fill=true,
     length={10,24}, pressure={0.7,0.55}, clip=true})
work(shadowM * bankZone2, {hand="body", pile=shadowP, coverage=2.4, fill=true, length={30,80},
     angle=0.28, pressure={0.5,0.38}, clip=true, edge="soft"})
print("roots and shadow back")

--@ chunk 310
ng3 = noise{seed=53, octaves=4, period=70}
work(bandM(1006,1120,55) * bankZone2, {hand="hatch", pile=grassA2,
     tool={kind="round", width=2.0, point=1}, length={9,28}, angle=-1.28, coverage=0.5,
     pressure={0.42,0.2}, clump=0.8,
     load_at=function(x, y) return 0.2 + 0.55 * ng3:at01(x, y * 0.6) end,
     clip=true, edge="soft"})
work(bankZone2, {hand="hatch", pile=grassB2, tool={kind="round", width=1.8, point=1},
     length={7,24}, angle=-1.22, coverage=0.42, pressure={0.38,0.18}, clump=0.85,
     load_at=function(x, y) return 0.18 + 0.5 * ng3:at01(x * 1.3, y * 0.5 + 300) end,
     clip=true, edge="soft"})
print("grass back")

--@ chunk 311
ncw = noise{seed=113, octaves=5, period=55}
crownE = {{55,190,640,200},{200,195,520,200},{330,150,620,165},{150,160,760,140},
          {255,120,700,110},{330,150,720,160},{250,140,660,140},{430,120,720,130},
          {350,140,830,110},{140,120,430,110}}
function crownCov(x, y)
  local s = 0
  for i = 1, #crownE do
    local c = crownE[i]
    s = s + gauss(x, y, c[1], c[2], c[3], c[4])
  end
  s = s * (0.55 + 0.8 * ncw:at01(x, y))
  return clamp(s * 2.0, 0, 2.4)
end
stipple(everywhere(), {pile=barkDark, width=9, coverage=crownCov,
       pressure={0.3,0.45}, cluster=0.6, feather=0.8, dips={18, 0.45, 0.4}})
print("crown mass laid")

--@ chunk 312
function crownCov2(x, y)
  local s = 0
  for i = 1, #crownE do
    local c = crownE[i]
    s = s + gauss(x, y, c[1], c[2], c[3], c[4])
  end
  if s < 0.07 then return 0 end
  s = s * (0.55 + 0.8 * ncw:at01(x, y))
  return clamp(s * 2.0, 0, 2.4)
end
crownEll = {{40,230,640,240},{200,230,520,230},{330,190,620,200},{150,200,760,175},
            {255,160,700,140},{140,150,430,130},{230,180,380,130},{60,140,300,120},
            {330,190,720,190},{250,180,660,170},{430,160,720,160},{350,180,830,140}}
cm = mask(function(x, y) return 0 end)
for i = 1, #crownEll do
  local c = crownEll[i]
  cm = cm + ellipse(c[1], c[2], c[3], c[4])
end
crownMask = cm:blur(18)
cleanSky = mask(function(x, y) if y < 702 then return 1 end return 0 end):blur(6) - crownMask
print("crown mask", crownMask:area(), "clean sky", cleanSky:area())

--@ chunk 313
lay(b1 * cleanSky, c1)
lay(bandM(140,410,55) * cleanSky, c2)
lay(bandM(320,540,55) * cleanSky, c3)
lay(bandM(440,645,55) * cleanSky, c4)
lay(bandM(540,712,50) * cleanSky, c5)
print("sky cleaned outside the crowns")

--@ chunk 314
print(wait(3*24*60), drying(500,300), drying(500,850))

--@ chunk 315
function layW(m, p)
  work(m, {hand="body", pile=p, coverage=3.2, fill=true, length={24,62}, angle=-0.02,
           pressure={0.6,0.48}, ramps={0.12,0.3}, dips={4,0.6,0.3}, clip=true})
end
lay(b1, c1)
lay(bandM(140,410,55), c2)
lay(bandM(320,540,55), c3)
lay(bandM(440,645,55), c4)
lay(bandM(540,712,50), c5)
layW(bandM(690,760,40) * waterZone, wA)
print("sky and far water re-laid")

--@ chunk 316
work(goodMask, {hand="detail", pile=barkDark, coverage=6.0, fill=true,
                 length={10,26}, pressure={0.75,0.6}, clip=true})
tb = brush{kind="round", width=3.2, point=1, stiffness=0.45}
for i = 1, #twigsA do
  local T = twigsA[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
print("frame and twigs A back")

--@ chunk 317
for i = 1, #twigsB do
  local T = twigsB[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
for i = 1, #crownA do
  local T = crownA[i]
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.28 + T.w * 0.16, 0.28, 0.95), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
print("twigs B and crown A back")

--@ chunk 318
for i = 1, #crownB do
  local T = crownB[i]
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.28 + T.w * 0.16, 0.28, 0.95), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
for i = 1, #topA do
  local T = topA[i]
  tb:load(barkFine, 0.45)
  tb:stroke(T.pts, {pressure = {clamp(0.26 + T.w * 0.16, 0.26, 0.9), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
print("crown B and top back")

--@ chunk 319
rightSky = rect(430, -10, 580, 300)
lay(b1 * rightSky, c1)
lay(bandM(140,410,55) * rightSky, c2)
lay(bandM(320,540,55) * rect(430, -10, 580, 420), c3)
print("upper right sky cleaned")

--@ chunk 320
layS(shoreBand, shoreP, -0.02)
work(woodBand, {hand="body", pile=woodP, coverage=4.0, fill=true, length={10,26},
               angle=-0.02, pressure={0.55,0.45}, clip=true, edge="soft"})
sunCore2 = pile{{"lead white",20},{"chrome yellow",2.6},{"yellow ochre",0.9}}
work(ellipse(655, 668, 28, 26):blur(7), {hand="body", tool="round 5", pile=sunCore2, coverage=4.0,
      fill=true, length={10,26}, pressure={0.5,0.42}, clip=true, edge="soft"})
stipple(ellipse(655, 672, 470, 240):blur(26), {
  pile=pile{{"lead white",13},{"pale smalt",2.4},{"yellow ochre",1.0},{"chrome yellow",0.3}, medium=0.2},
  width=14, coverage=function(x, y)
    local r = ell(x, y, 655, 672, 430, 205)
    if r >= 1 then return 0 end
    return 2.6 * (1 - r) ^ 1.2
  end,
  pressure={0.3,0.46}, cluster=0.45, feather=0.85, dips={14, 0.5, 0.35}})
stipple(mistArea, {pile=mistPile, width=9, coverage=mistCov, pressure={0.3,0.42},
                   cluster=0.6, feather=0.8, drag={7, 0}, dips={16, 0.45, 0.4}})
print("shore, sun, glow, mist back")

--@ chunk 321
print(wait(3*24*60), drying(500,700), drying(500,850), drying(655,668))

--@ chunk 322
print(wait(3*24*60), drying(500,700), drying(655,668))

--@ chunk 323
print(wait(3*24*60), drying(500,700), drying(655,668), drying(300,300))

--@ chunk 324
lay(bandM(430,660,50), c4)
lay(bandM(560,716,46), c5)
layW(bandM(690,778,42) * waterZone, wA)
layW(bandM(752,845,42) * waterZone, wB)
layW(bandM(822,905,40) * waterZone, wC)
layW(bandM(888,966,36) * waterZone, wD)
layW(bandM(950,1014,24) * waterZone, wE)
print("horizon and lake reset")

--@ chunk 325
print(wait(3*24*60), drying(500,800), drying(500,980))

--@ chunk 326
function layL(m, p, cov)
  work(m, {hand="body", pile=p, coverage=cov, fill=true, length={24,62}, angle=-0.02,
           pressure={0.62,0.5}, ramps={0.12,0.28}, dips={4,0.62,0.28}, clip=true})
end
L1 = pile{{"smalt",4},{"raw umber",2}}
L2 = pile{{"smalt",4},{"raw umber",3.5},{"pale smalt",1.5}}
L3 = pile{{"smalt",4},{"raw umber",5},{"bone black",1},{"pale smalt",1.5}}
L4 = pile{{"smalt",4},{"raw umber",6},{"bone black",2},{"pale smalt",1.5}}
L5 = pile{{"smalt",4},{"raw umber",7},{"bone black",3},{"pale smalt",1.5}}
layL(bandM(692,768,42) * waterZone, L1, 3.4)
layL(bandM(750,830,42) * waterZone, L2, 3.6)
layL(bandM(812,892,40) * waterZone, L3, 3.8)
layL(bandM(876,956,38) * waterZone, L4, 4.0)
layL(bandM(940,1014,24) * waterZone, L5, 4.2)
print("lake laid dark")

--@ chunk 327
layL(bandM(692,772,40) * waterZone, L1, 7.0)
layL(bandM(752,836,40) * waterZone, L2, 5.5)
layL(bandM(816,896,38) * waterZone, L3, 4.4)
print("upper lake firmed")

--@ chunk 328
print(wait(3*24*60), drying(500,800), drying(500,960))

--@ chunk 329
print(wait(3*24*60), drying(500,800), drying(500,960))

--@ chunk 330
baseLake = pile{{"lead white",3},{"smalt",4},{"raw umber",6},{"bone black",2}}
work(waterZone, {hand="body", pile=baseLake, coverage=6.0, fill=true, length={24,62}, angle=-0.02,
     pressure={0.62,0.5}, ramps={0.12,0.28}, dips={4,0.62,0.28}, clip=true})
print("opaque lake base")

--@ chunk 331
local o = {}
for y = 680, 820, 10 do o[#o+1] = y .. ":" .. string.format("%.2f", waterZone:at(500, y)) end
print("waterZone ", table.concat(o, " "))
print("area", waterZone:area())

--@ chunk 332
gA = pile{{"lead white",6},{"pale smalt",3},{"smalt",1.5},{"raw umber",0.7}}
gB = pile{{"lead white",2},{"pale smalt",2.5},{"smalt",2},{"raw umber",1.6}}
gC = pile{{"smalt",2.5},{"raw umber",2.6}}
gD = pile{{"smalt",2.5},{"raw umber",3.6},{"bone black",1}}
layL(bandM(696,790,44) * waterZone, gA, 2.6)
layL(bandM(768,862,44) * waterZone, gB, 2.6)
layL(bandM(840,934,42) * waterZone, gC, 2.8)
layL(bandM(912,1016,36) * waterZone, gD, 3.2)
layS(shoreBand, shoreP, -0.02)
work(woodBand, {hand="body", pile=woodP, coverage=4.0, fill=true, length={10,26},
               angle=-0.02, pressure={0.55,0.45}, clip=true, edge="soft"})
print("lake graded, shore laid")

--@ chunk 333
print(wait(3*24*60), drying(500,800), drying(500,700))

--@ chunk 334
print(wait(3*24*60), drying(500,800))

--@ chunk 335
shoreP2 = pile{{"lead white",6},{"pale smalt",3},{"smalt",2},{"raw umber",2.2}}
layS(shoreBand, shoreP2, -0.02)
work(woodBand, {hand="body", pile=woodP, coverage=4.0, fill=true, length={10,26},
               angle=-0.02, pressure={0.55,0.45}, clip=true, edge="soft"})
stipple(mistArea, {pile=mistPile, width=9, coverage=mistCov, pressure={0.3,0.42},
                   cluster=0.6, feather=0.8, drag={7, 0}, dips={16, 0.45, 0.4}})
print("shore darkened, mist laid")

--@ chunk 336
ripDark2 = pile{{"smalt",3},{"raw umber",3},{"pale smalt",1}}
ripLite2 = pile{{"lead white",6},{"pale smalt",3}}
local function rip2(m, p, len, cov, ang)
  work(m, {hand="hatch", tool={kind="round", width=2.6, point=1}, pile=p, length=len, angle=ang,
           coverage=cov, pressure={0.45,0.22}, ramps={0.3,0.5}, clump=0.7, clip=true, edge="soft"})
end
local rb2 = {
 {bandM(716,790,26) * waterZone, {12,32}, 0.26,  0.012},
 {bandM(770,856,28) * waterZone, {20,54}, 0.30, -0.010},
 {bandM(840,930,30) * waterZone, {30,84}, 0.34,  0.008},
 {bandM(914,1012,28) * waterZone, {45,118},0.38, -0.007}}
for i = 1, 4 do rip2(rb2[i][1], ripLite2, rb2[i][2], rb2[i][3] * 0.75, rb2[i][4] + 0.012) end
for i = 1, 4 do rip2(rb2[i][1], ripDark2, rb2[i][2], rb2[i][3], rb2[i][4]) end
stipple(mask(function(x, y) if y > 696 and y < 1014 then return 1 end return 0 end):blur(8),
  {pile=pile{{"lead white",9},{"pale smalt",3},{"yellow ochre",0.7},{"chrome yellow",0.15}},
   width=10, coverage=pathCov, pressure={0.3,0.44}, cluster=0.55, feather=0.8,
   drag={8, 0}, dips={16, 0.45, 0.4}})
print("ripples and light path")

--@ chunk 337
print(wait(3*24*60), drying(500,850), drying(500,980))

--@ chunk 338
layL(bandM(696,790,44) * waterZone, gA, 2.4)
layL(bandM(768,862,44) * waterZone, gB, 2.4)
layL(bandM(840,934,42) * waterZone, gC, 2.6)
layL(bandM(912,1016,36) * waterZone, gD, 3.0)
print("ripples muted")

--@ chunk 339
nrp = noise{seed=137, octaves=4, period=90}
ripQ = pile{{"smalt",3},{"raw umber",2.6}}
local function qrip(m, len, cov)
  work(m, {hand="detail", tool={kind="round", width=2.0, point=1}, pile=ripQ, length=len,
           angle=-0.008, coverage=cov, pressure={0.4,0.2}, ramps={0.3,0.5}, clump=0.85,
           load_at=function(x, y) return 0.12 + 0.55 * nrp:at01(x, y * 1.6) end,
           clip=true, edge="soft"})
end
qrip(bandM(788,880,30) * waterZone, {18,52}, 0.16)
qrip(bandM(862,950,30) * waterZone, {28,82}, 0.20)
qrip(bandM(940,1012,26) * waterZone, {40,112}, 0.24)
print("quiet ripples")

--@ chunk 340
function pathCov2(x, y)
  if y < 698 or y > 1012 then return 0 end
  local up = clamp((y - 700) / 30, 0, 1)
  local h = 30 + (y - 700) * 0.16
  local dx = (x - 655) / h
  local a = math.exp(-dx * dx * 2.0)
  local down = 0.22 + 0.78 * clamp((1008 - y) / 290, 0, 1)
  local shim = 0.4 + 0.7 * np2:at01(x * 0.8, y * 0.4)
  return 0.95 * up * a * down * shim
end
stipple(mask(function(x, y) if y > 696 and y < 1014 then return 1 end return 0 end):blur(8),
  {pile=pile{{"lead white",8},{"pale smalt",3},{"yellow ochre",1.1},{"chrome yellow",0.2}},
   width=22, coverage=pathCov2, pressure={0.3,0.4}, cluster=0.6, feather=0.9,
   drag={16, 0}, dips={10, 0.4, 0.45}})
print("soft light path")

--@ chunk 341
work(goodMask, {hand="detail", pile=barkDark, coverage=6.0, fill=true,
                 length={10,26}, pressure={0.75,0.6}, clip=true})
tb = brush{kind="round", width=3.2, point=1, stiffness=0.45}
for i = 1, #twigsA do
  local T = twigsA[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
for i = 1, #twigsB do
  local T = twigsB[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
print("frames, roots, twigs A and B back")

--@ chunk 342
for i = 1, #crownA do
  local T = crownA[i]
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.28 + T.w * 0.16, 0.28, 0.95), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
for i = 1, #crownB do
  local T = crownB[i]
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.28 + T.w * 0.16, 0.28, 0.95), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
for i = 1, #topA do
  local T = topA[i]
  tb:load(barkFine, 0.45)
  tb:stroke(T.pts, {pressure = {clamp(0.26 + T.w * 0.16, 0.26, 0.9), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
print("crowns refilled")

--@ chunk 343
sunCore2 = pile{{"lead white",20},{"chrome yellow",2.6},{"yellow ochre",0.9}}
work(ellipse(655, 668, 27, 25):blur(9), {hand="body", tool="round 4", pile=sunCore2, coverage=5.0,
      fill=true, length={9,22}, pressure={0.45,0.38}, clip=true, edge="soft"})
stipple(ellipse(655, 672, 430, 205):blur(30), {
  pile=pile{{"lead white",12},{"pale smalt",2.6},{"yellow ochre",0.9},{"chrome yellow",0.22}, medium=0.25},
  width=24, coverage=function(x, y)
    local r = ell(x, y, 655, 672, 400, 180)
    if r >= 1 then return 0 end
    return 2.2 * (1 - r) ^ 1.15
  end,
  pressure={0.3,0.44}, cluster=0.5, feather=0.9, dips={10, 0.45, 0.4}})
print("sun and glow")

--@ chunk 344
layL(bandM(770,870,46) * waterZone, gB, 1.8)
layL(bandM(850,1016,44) * waterZone, gC, 2.2)
print("light path muted")

--@ chunk 345
function pathCov3(x, y)
  if y < 700 or y > 1010 then return 0 end
  local up = clamp((y - 700) / 26, 0, 1)
  local h = 34 + (y - 700) * 0.20
  local dx = (x - 655) / h
  local a = math.exp(-dx * dx * 1.7)
  local down = 0.20 + 0.80 * clamp((1006 - y) / 280, 0, 1)
  return 1.5 * up * a * down
end
stipple(mask(function(x, y) if y > 698 and y < 1012 then return 1 end return 0 end):blur(8),
  {pile=pile{{"lead white",7},{"pale smalt",3.4},{"yellow ochre",0.5}},
   width=26, coverage=pathCov3, pressure={0.28,0.38}, cluster=0.7, feather=0.95,
   drag={20, 0}, dips={8, 0.4, 0.5}})
print("soft shimmer")

--@ chunk 346
print(wait(3*24*60), drying(700,760), drying(400,900))

--@ chunk 347
layL(bandM(698,776,42) * waterZone, pile{{"lead white",5},{"pale smalt",2.8},{"smalt",1.8},{"raw umber",1.1}}, 4.5)
layL(bandM(756,848,40) * waterZone, pile{{"lead white",2.6},{"pale smalt",2.4},{"smalt",2.2},{"raw umber",1.9}}, 4.5)
print("confetti buried")

--@ chunk 348
kb1 = pile{{"raw umber",5},{"bone black",2.6},{"green earth",1.4},{"yellow ochre",0.8}}
kb2 = pile{{"raw umber",5.5},{"bone black",3.4},{"green earth",1.2},{"yellow ochre",0.5}}
kb3 = pile{{"raw umber",6},{"bone black",4.4},{"green earth",1.0},{"yellow ochre",0.3}}
layB(bandM(1008,1092,42) * bankZone2, kb1)
layB(bandM(1072,1172,45) * bankZone2, kb2)
layB(bandM(1152,1262,45) * bankZone2, kb3)
work(shadowM * bankZone2, {hand="body", pile=shadowP, coverage=2.2, fill=true, length={30,80},
     angle=0.28, pressure={0.5,0.38}, clip=true, edge="soft"})
print("bank darkened, shadow laid")

--@ chunk 349
work(bandM(1006,1120,55) * bankZone2, {hand="hatch", pile=grassA2,
     tool={kind="round", width=2.0, point=1}, length={9,28}, angle=-1.28, coverage=0.5,
     pressure={0.42,0.2}, clump=0.8,
     load_at=function(x, y) return 0.2 + 0.55 * ng3:at01(x, y * 0.6) end,
     clip=true, edge="soft"})
work(bankZone2, {hand="hatch", pile=grassB2, tool={kind="round", width=1.8, point=1},
     length={7,24}, angle=-1.22, coverage=0.42, pressure={0.38,0.18}, clump=0.85,
     load_at=function(x, y) return 0.18 + 0.5 * ng3:at01(x * 1.3, y * 0.5 + 300) end,
     clip=true, edge="soft"})
print("grass")

--@ chunk 350
figPts3 = {{555,944},{562,936},{570,940},{573,949},{570,956},{576,962},{579,978},
            {582,994},{583,1011},{573,1016},{548,1016},{540,1010},{542,991},{546,975},
            {550,961},{553,954},{551,947}}
figM3 = poly(figPts3, true):blur(1.2)
work(figM3, {hand="detail", pile=figPile, coverage=5.0, fill=true, length={8,20},
             pressure={0.78,0.62}, clip=true})
litEdgeP2 = pile{{"raw umber",3.2},{"yellow ochre",1.2},{"lead white",0.9}}
fb2 = brush{kind="round", width=1.8, point=1, stiffness=0.4}
fb2:load(litEdgeP2, 0.5)
fb2:stroke({{569,940},{573,950},{572,957},{577,965},{580,982},{583,999},{583,1011}},
           {pressure={0.85,0.1}, ramps={0.12,0.5}, shake=0.3})
fb2:load(litEdgeP2, 0.4)
fb2:stroke({{558,938},{556,945},{554,953}}, {pressure={0.55,0.08}, ramps={0.15,0.5}})
print("figure placed")

--@ chunk 351
crestBand2 = mask(function(x, y) if y > 1002 and y < 1036 then return 1 end return 0 end):blur(9) * bankZone2:grow(10)
layB(crestBand2, pile{{"raw umber",5},{"bone black",2.2},{"green earth",1.5},{"yellow ochre",1.2}}, 5.0)
print("crest covered")

--@ chunk 352
fg = brush{kind="round", width=1.6, point=1, stiffness=0.5}
tuftP = pile{{"raw umber",4.5},{"yellow ochre",1.6},{"lead white",0.4}}
tuftD = pile{{"raw umber",4},{"bone black",1.6},{"yellow ochre",0.8}}
for i = 1, 150 do
  local x = rand(-10, 1010)
  local y = edgeY2(x)
  local n = 2 + math.random(0, 3)
  for j = 1, n do
    local lean = randn(0, 0.45)
    local L = rand(9, 26)
    local pts = {{x + randn(0, 4), y + rand(-3, 6)}}
    for k = 1, 2 do
      local px, py = pts[k][1], pts[k][2]
      local a = -1.5708 + lean + randn(0, 0.22)
      pts[#pts+1] = {px + math.cos(a) * L * 0.55, py + math.sin(a) * L * 0.55}
    end
    fg:load(math.random() < 0.5 and tuftP or tuftD, rand(0.4, 0.65))
    fg:stroke(pts, {pressure = {0.8, 0.02}, ramps = {0.12, 0.55}, shake = 0.4})
  end
end
print("shore fringe drawn")

--@ chunk 353
cb = mask(function(x, y) return 0 end)
for i = 1, #crownE do
  local c = crownE[i]
  cb = cb + ellipse(c[1], c[2], c[3], c[4])
end
crownZone = cb:blur(26)
print("crown zone", crownZone:area())
stipple(crownZone, {pile=barkDark, width=11, coverage=crownCov2,
       pressure={0.3,0.45}, cluster=0.6, feather=0.85, dips={16, 0.45, 0.4}})
print("crown core laid")

--@ chunk 354
print("cov2 at (800,100)", crownCov2(800,100))
print("cov2 at (800,300)", crownCov2(800,300))
print("cov2 at (500,500)", crownCov2(500,500))
print("zone at (800,100)", crownZone:at(800,100), " (800,300)", crownZone:at(800,300))
print("zone at (200,600)", crownZone:at(200,600))
local mx, sum = 0, 0
for i = 1, 40 do
  for j = 1, 30 do
    local x, y = i * 25, j * 40
    local v = crownZone:at(x, y)
    mx = math.max(mx, v); sum = sum + v
  end
end
print("zone max", mx, "mean", sum / 1200)

--@ chunk 355
print(wait(3*24*60), drying(800,200), drying(300,300))

--@ chunk 356
lay(b1 * rect(-10, -10, 1015, 190), c1)
lay(bandM(140,410,55) * rect(545, -10, 470, 345), c2)
lay(bandM(320,540,55) * rect(545, -10, 470, 480), c3)
lay(bandM(430,660,50) * rect(545, -10, 470, 480), c4)
print("sky repaired")

--@ chunk 357
lay(b1 * rect(-10, -10, 572, 180), c1)
lay(bandM(140,410,55) * rect(-10, -10, 572, 340), c2)
lay(bandM(320,540,55) * rect(-10, -10, 572, 465), c3)
lay(bandM(430,660,50) * rect(-10, -10, 572, 465), c4)
print("left sky repaired")

--@ chunk 358
tb = brush{kind="round", width=3.2, point=1, stiffness=0.45}
for i = 1, #twigsA do
  local T = twigsA[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
for i = 1, #twigsB do
  local T = twigsB[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
print("twigs A B back")

--@ chunk 359
for i = 1, #crownA do
  local T = crownA[i]
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.28 + T.w * 0.16, 0.28, 0.95), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
for i = 1, #crownB do
  local T = crownB[i]
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.28 + T.w * 0.16, 0.28, 0.95), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
for i = 1, #topA do
  local T = topA[i]
  tb:load(barkFine, 0.45)
  tb:stroke(T.pts, {pressure = {clamp(0.26 + T.w * 0.16, 0.26, 0.9), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
print("crowns back")

--@ chunk 360
crownE = {{55,640,190,200},{200,520,195,200},{330,620,150,165},{150,760,160,140},
          {255,700,120,110},{330,720,150,160},{250,660,140,140},{430,720,120,130},
          {350,830,140,110},{140,430,120,110}}
function crownCov3(x, y)
  local s = 0
  for i = 1, #crownE do
    local c = crownE[i]
    s = s + gauss(x, y, c[1], c[2], c[3], c[4])
  end
  if s < 0.30 then return 0 end
  s = s * (0.55 + 0.8 * ncw:at01(x, y))
  return clamp(s * 1.5, 0, 2.0)
end
cb = mask(function(x, y) return 0 end)
for i = 1, #crownE do
  local c = crownE[i]
  cb = cb + ellipse(c[1], c[2], c[3], c[4])
end
crownZone2b = cb:blur(24)
local t = {}
for _, p in ipairs({{800,150},{750,300},{200,150},{80,100},{500,500},{200,600},{700,620},{950,900}}) do
  t[#t+1] = string.format("(%d,%d) c=%.2f m=%.2f", p[1], p[2], crownCov3(p[1],p[2]), crownZone2b:at(p[1],p[2]))
end
print(table.concat(t, "\n"))

--@ chunk 361
stipple(crownZone2b, {pile=barkDark, width=11, coverage=crownCov3,
       pressure={0.3,0.45}, cluster=0.6, feather=0.85, dips={16, 0.45, 0.4}})
print("crown core laid")

--@ chunk 362
print(drying(400,900), drying(300,600))
layL(bandM(820,916,44) * waterZone, gC, 2.4)
layL(bandM(896,1016,38) * waterZone, gD, 2.6)
print("lake speckle muted")

--@ chunk 363
nlw = noise{seed=151, octaves=4, period=110}
accL = pile{{"lead white",7},{"pale smalt",3.2}}
accD = pile{{"smalt",3},{"raw umber",2.4}}
rba = brush{kind="round", width=1.9, point=1, stiffness=0.5}
for i = 1, 220 do
  local t = rand(0, 1)
  local y = 790 + 210 * t
  local x = rand(-20, 1020)
  local L = 16 + 78 * t
  local d = nlw:at01(x, y * 1.4)
  if d > 0.52 then
    local p = d > 0.74 and accL or accD
    rba:load(p, 0.45 + 0.2 * d)
    rba:stroke({{x, y}, {x + L * 0.5, y + randn(0, 1.2)}, {x + L, y + randn(0, 1.6)}},
               {pressure = {0.7, 0.05}, ramps = {0.15, 0.55}, shake = 0.35})
  end
end
print("ripple accents")

--@ chunk 364
print(wait(3*24*60), drying(500,150), drying(500,700))

--@ chunk 365
layL(bandM(-20,300,90), pile{{"smalt",2.6},{"raw umber",1.3}}, 2.0)
layL(bandM(240,430,80), pile{{"smalt",1.8},{"raw umber",0.9}}, 1.6)
print("upper sky deepened")

--@ chunk 366
stipple(ellipse(655, 676, 430, 190):blur(34), {
  pile=pile{{"lead white",13},{"pale smalt",2.2},{"yellow ochre",1.3},{"chrome yellow",0.3}, medium=0.25},
  width=26, coverage=function(x, y)
    local r = ell(x, y, 655, 676, 400, 165)
    if r >= 1 then return 0 end
    return 2.1 * (1 - r) ^ 1.05
  end,
  pressure={0.3,0.44}, cluster=0.5, feather=0.9, dips={10, 0.45, 0.4}})
print("horizon glow")

--@ chunk 367
print(wait(3*24*60), drying(500,150), drying(800,250))

--@ chunk 368
function laySky(m, p)
  work(m, {hand="body", pile=p, coverage=5.5, fill=true, length={24,62}, angle=-0.05,
           pressure={0.7,0.58}, ramps={0.1,0.25}, dips={3,0.7,0.25}, clip=true})
end
laySky(b1, c1)
laySky(bandM(140,410,55), c2)
laySky(bandM(320,540,55), c3)
laySky(bandM(430,660,50), c4)
laySky(bandM(560,716,46), c5)
print("sky re-laid opaque")

--@ chunk 369
tb = brush{kind="round", width=3.2, point=1, stiffness=0.45}
for i = 1, #twigsA do
  local T = twigsA[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
for i = 1, #twigsB do
  local T = twigsB[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
print("twigs A B back")

--@ chunk 370
for i = 1, #crownA do
  local T = crownA[i]
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.28 + T.w * 0.16, 0.28, 0.95), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
for i = 1, #crownB do
  local T = crownB[i]
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.28 + T.w * 0.16, 0.28, 0.95), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
for i = 1, #topA do
  local T = topA[i]
  tb:load(barkFine, 0.45)
  tb:stroke(T.pts, {pressure = {clamp(0.26 + T.w * 0.16, 0.26, 0.9), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
print("crowns back")

--@ chunk 371
stipple(crownZone2b, {pile=barkDark, width=11, coverage=crownCov3,
       pressure={0.3,0.45}, cluster=0.6, feather=0.85, dips={16, 0.45, 0.4}})
sunCore2 = pile{{"lead white",20},{"chrome yellow",2.6},{"yellow ochre",0.9}}
work(ellipse(655, 668, 27, 25):blur(9), {hand="body", tool="round 4", pile=sunCore2, coverage=5.0,
      fill=true, length={9,22}, pressure={0.45,0.38}, clip=true, edge="soft"})
stipple(ellipse(655, 674, 440, 200):blur(32), {
  pile=pile{{"lead white",12},{"pale smalt",2.6},{"yellow ochre",0.9},{"chrome yellow",0.22}, medium=0.25},
  width=24, coverage=function(x, y)
    local r = ell(x, y, 655, 674, 410, 180)
    if r >= 1 then return 0 end
    return 2.2 * (1 - r) ^ 1.15
  end,
  pressure={0.3,0.44}, cluster=0.5, feather=0.9, dips={10, 0.45, 0.4}})
print("crown core, sun, glow")

--@ chunk 372
work(goodMask, {hand="detail", pile=barkDark, coverage=6.0, fill=true,
                 length={10,26}, pressure={0.75,0.6}, clip=true})
for i = 1, #twigsA do
  local T = twigsA[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
for i = 1, #twigsB do
  local T = twigsB[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
print("frames and twigs back")

--@ chunk 373
lowCrown = {}
for i = 1, 230 do
  local x = rand(-40, 540)
  local y = rand(600, 910)
  local cx, cy = 230, 720
  local a = math.atan(y - cy, x - cx) + randn(0, 1.0)
  twigline(x, y, a, 52 + 46 * math.random(), 2.0 + 1.0 * math.random(), 1, lowCrown)
end
print("low crown twigs", #lowCrown)
for i = 1, #lowCrown do
  local T = lowCrown[i]
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.28 + T.w * 0.16, 0.28, 0.9), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
print("low crown laid")

--@ chunk 374
print(wait(3*24*60), drying(300,760), drying(200,820))

--@ chunk 375
function mistCov2(x, y)
  local up = clamp((y - 696) / 18, 0, 1)
  local dn = clamp((886 - y) / 150, 0, 1)
  local patch = 0.35 + 0.65 * nm:at01(x, y * 0.5)
  return 3.4 * up * dn * patch
end
stipple(mistArea, {pile=mistPile, width=14, coverage=mistCov2, pressure={0.32,0.46},
                   cluster=0.6, feather=0.85, drag={10, 0}, dips={12, 0.5, 0.35}})
print("mist deepened over the far wood")

--@ chunk 376
print(wait(3*24*60), drying(300,780), drying(200,860))

--@ chunk 377
midWater = pile{{"lead white",5},{"pale smalt",2.8},{"smalt",1.8},{"raw umber",1.1}}
midWater2 = pile{{"lead white",3.2},{"pale smalt",2.6},{"smalt",2.2},{"raw umber",1.8}}
layL(bandM(698,790,44) * waterZone, midWater, 5.0)
layL(bandM(770,880,44) * waterZone, midWater2, 5.0)
print("waterline cleaned")

--@ chunk 378
work(goodMask, {hand="detail", pile=barkDark, coverage=6.0, fill=true,
                 length={10,26}, pressure={0.75,0.6}, clip=true})
for i = 1, #twigsA do
  local T = twigsA[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
for i = 1, #twigsB do
  local T = twigsB[i]
  tb:load(T.w > 1.6 and barkDark or barkFine, T.w > 1.6 and 0.62 or 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.30 + T.w * 0.17, 0.30, 1.0), 0.03}, ramps = {0.08, 0.5}, shake = 0.35})
end
print("frames and twigs back")

--@ chunk 379
for i = 1, #lowCrown do
  local T = lowCrown[i]
  tb:load(barkFine, 0.5)
  tb:stroke(T.pts, {pressure = {clamp(0.28 + T.w * 0.16, 0.28, 0.9), 0.03}, ramps = {0.08, 0.55}, shake = 0.4})
end
stipple(mistArea, {pile=mistPile, width=12, coverage=function(x, y)
    local up = clamp((y - 698) / 22, 0, 1)
    local dn = clamp((872 - y) / 155, 0, 1)
    return 1.5 * up * dn * (0.35 + 0.65 * nm:at01(x, y * 0.5))
  end, pressure={0.3,0.42}, cluster=0.6, feather=0.85, drag={9, 0}, dips={14, 0.45, 0.4}})
print("low crown and gentle mist")

--@ chunk 380
work(figM3, {hand="detail", pile=figPile, coverage=5.0, fill=true, length={8,20},
             pressure={0.78,0.62}, clip=true})
fb2:load(litEdgeP2, 0.5)
fb2:stroke({{569,940},{573,950},{572,957},{577,965},{580,982},{583,999},{583,1011}},
           {pressure={0.85,0.1}, ramps={0.12,0.5}, shake=0.3})
fb2:load(litEdgeP2, 0.4)
fb2:stroke({{558,938},{556,945},{554,953}}, {pressure={0.55,0.08}, ramps={0.15,0.5}})
print("figure back")

--@ chunk 381
print(wait(3*24*60), drying(500,780), drying(300,700))

--@ chunk 382
layL(bandM(700,790,44) * waterZone, pile{{"lead white",4},{"pale smalt",2.8},{"smalt",1.9},{"raw umber",1.2}}, 1.5)
layL(bandM(772,880,44) * waterZone, pile{{"lead white",2.6},{"pale smalt",2.6},{"smalt",2.3},{"raw umber",2.0}}, 1.6)
print("mist knocked back")

--@ chunk 383
layL(bandM(700,800,42) * waterZone, pile{{"lead white",3.6},{"pale smalt",2.8},{"smalt",2},{"raw umber",1.5}}, 3.2)
layL(bandM(778,886,42) * waterZone, pile{{"lead white",2.4},{"pale smalt",2.6},{"smalt",2.4},{"raw umber",2.2}}, 3.2)
print("mist reduced")

--@ chunk 384
local function probe(name, m, ys)
  local o = {}
  for _, y in ipairs(ys) do o[#o+1] = string.format("y=%d v=%.2f", y, m:at(500, y)) end
  print(name, table.concat(o, " "))
end
print("waterZone area", waterZone:area())
probe("waterZone", waterZone, {680,700,720,760,800,860,900,960,1000,1014,1030,1060})
print("shoreBand area", shoreBand and shoreBand:area(), "woodBand", woodBand and woodBand:area())
if shoreBand then probe("shoreBand", shoreBand, {690,700,706,712,720,730,740}) end
if woodBand then probe("woodBand", woodBand, {690,700,706,712,720,730,740}) end
print("bankBase(500)", bankBase and bankBase(500), "edgeY2(500)", edgeY2 and edgeY2(500))
print("edgeY2 at 0,250,500,750,1000", edgeY2(0), edgeY2(250), edgeY2(500), edgeY2(750), edgeY2(1000))
print(drying(500,800), drying(500,950), drying(300,1100))

--@ chunk 385
lakeM = mask(function(x, y)
  if y < 706 or y > edgeY2(x) - 1 then return 0 end
  return 1
end):blur(5)
function layLake(m, p, cov)
  work(m, {hand="body", pile=p, coverage=cov, fill=true, length={24,62}, angle=-0.02,
           pressure={0.62,0.5}, ramps={0.12,0.3}, dips={4,0.62,0.28}, clip=true})
end
kA = pile{{"lead white",5},{"pale smalt",3},{"smalt",2},{"raw umber",1.2}}
kB = pile{{"lead white",3.4},{"pale smalt",3},{"smalt",2.4},{"raw umber",1.9}}
kC = pile{{"lead white",2.2},{"pale smalt",2.6},{"smalt",2.8},{"raw umber",2.6}}
kD = pile{{"lead white",1.2},{"pale smalt",2.2},{"smalt",3},{"raw umber",3.6},{"bone black",0.5}}
kE = pile{{"lead white",0.8},{"pale smalt",1.8},{"smalt",3.2},{"raw umber",4.4},{"bone black",1.4}}
layLake(rect(-8, 700, 1016, 96):blur(40) * lakeM, kA, 5.0)
layLake(rect(-8, 762, 1016, 100):blur(40) * lakeM, kB, 5.0)
layLake(rect(-8, 836, 1016, 100):blur(40) * lakeM, kC, 5.0)
layLake(rect(-8, 906, 1016, 96):blur(38) * lakeM, kD, 5.0)
layLake(rect(-8, 972, 1016, 56):blur(26) * lakeM, kE, 5.0)
print("lake regraded", lakeM:area())

--@ chunk 386
print(wait(2*24*60), drying(500,850))
nrw = noise{seed=211, octaves=4, period=150, stretch={0, 0.22}}
ripLt = pile{{"lead white",6.5},{"pale smalt",3}}
ripDk = pile{{"smalt",3.2},{"raw umber",3.2},{"pale smalt",1}}
rpl = brush{kind="round", width=2.4, point=1, stiffness=0.45}
local N = 84
for i = 1, N do
  local t = i / N
  local y = 714 + 302 * (t ^ 1.75)
  local base = 20 + 430 * (t ^ 1.55)
  local m = nrw:at01(y * 3.0, x or 0)
  local d = nrw:at01(0, y * 1.0)
  local nD = 1 + math.random(0, 3)
  for j = 1, nD do
    local len = base * rand(0.18, 0.62)
    local x0 = rand(-30, 1030 - len)
    local q = nrw:at01(x0 * 0.8 + 300, y * 1.7)
    if q > 0.34 then
      local light = q > 0.62
      local fade = clamp(1.25 - (y - 720) / 420, 0.18, 1)
      rpl:load(light and ripLt or ripDk, (light and 0.5 or 0.42) * fade * (0.5 + 0.7 * q))
      local pts = {{x0, y + randn(0, 0.8)}}
      local k = 3
      for s = 1, k do
        pts[#pts+1] = {x0 + len * s / k, y + randn(0, 1.1)}
      end
      rpl:stroke(pts, {pressure = {0.55, 0.04}, ramps = {0.22, 0.5}, shake = 0.5})
    end
  end
end
print("ripples drawn", N)

--@ chunk 387
print(wait(2*24*60), drying(500,850))
layLake(rect(-8, 700, 1016, 96):blur(40) * lakeM, kA, 2.6)
layLake(rect(-8, 762, 1016, 100):blur(40) * lakeM, kB, 2.6)
layLake(rect(-8, 836, 1016, 100):blur(40) * lakeM, kC, 2.6)
layLake(rect(-8, 906, 1016, 96):blur(38) * lakeM, kD, 2.6)
layLake(rect(-8, 972, 1016, 56):blur(26) * lakeM, kE, 2.6)
print("scratches knocked back")

--@ chunk 388
nmis = noise{seed=307, octaves=4, period=110}
function mistStreak(x, y)
  local v = nmis:at01(x * 0.30, y * 1.9)
  return clamp(0.35 + 1.15 * v, 0, 1.5)
end
function mistBand(x, y)
  local up = clamp((y - 700) / 30, 0, 1)
  local dn = clamp((846 - y) / 130, 0, 1)
  if up <= 0 or dn <= 0 then return 0 end
  return 2.7 * up * dn * mistStreak(x, y)
end
stipple(lakeM, {pile=pile{{"lead white",9},{"pale smalt",3},{"yellow ochre",0.4}},
       width=13, coverage=mistBand, pressure={0.3,0.44}, cluster=0.65, feather=0.88,
       drag={11, 0}, dips={14, 0.45, 0.4}})
print("mist band on the water")

--@ chunk 389
function pathWide(x, y)
  if y < 698 or y > 1006 then return 0 end
  local up = clamp((y - 698) / 16, 0, 1)
  local h = 26 + (y - 698) * 0.30
  local dx = (x - 655) / h
  local a = math.exp(-dx * dx * 1.9)
  local down = 0.20 + 0.80 * clamp((1000 - y) / 250, 0, 1)
  local shim = 0.30 + 0.95 * nmis:at01(x * 0.55, y * 1.5)
  return 2.0 * up * a * down * shim
end
stipple(lakeM, {pile=pile{{"lead white",8},{"pale smalt",2.6},{"yellow ochre",1.1}},
       width=18, coverage=pathWide, pressure={0.28,0.42}, cluster=0.7, feather=0.9,
       drag={15, 0}, dips={12, 0.45, 0.42}})
function pathCore(x, y)
  if y < 698 or y > 860 then return 0 end
  local up = clamp((y - 698) / 12, 0, 1)
  local dn = clamp((856 - y) / 120, 0, 1)
  local h = 22 + (y - 698) * 0.20
  local dx = (x - 655) / h
  local a = math.exp(-dx * dx * 2.2)
  return 2.4 * up * dn * a * (0.45 + 0.85 * nmis:at01(x * 0.7, y * 2.4))
end
stipple(lakeM, {pile=pile{{"lead white",9},{"pale smalt",2},{"yellow ochre",1.4},{"chrome yellow",0.2}},
       width=10, coverage=pathCore, pressure={0.3,0.44}, cluster=0.6, feather=0.85,
       drag={8, 0}, dips={14, 0.45, 0.4}})
print("light path laid")
