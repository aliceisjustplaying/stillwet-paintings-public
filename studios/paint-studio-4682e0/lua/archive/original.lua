-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{size=700, aspect=4/3, linen={16, 14}, seed=1873,
  ground={
    {pile={{"lead white", 1}}, um=70, apply="knife", texture=0.25},
    {pile={{"lead white", 3}, {"yellow ochre", 1.2}, {"raw umber", 1}, {"red earth", 0.35}}, um=25, apply="brush"}
  }}
print(W, H)

--@ chunk 2
drawp = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, turps=0.5, name="draw"}
db = brush{kind="round", width=3, point=0.7}
function dl(pts, pr)
  if db:fullness() < 0.35 then db:load(drawp, 0.7) end
  db:stroke(pts, {pressure=pr or 0.45, ramps={0.1, 0.2}})
end
db:load(drawp, 0.7)
-- architecture
dl({{200, 40}, {200, 560}})            -- left back corner
dl({{880, 40}, {880, 560}})            -- right back corner
dl({{0, 631}, {200, 560}, {880, 560}, {1000, 643}})   -- floor lines
dl({{200, 52}, {880, 52}}, 0.35)       -- ceiling line
-- doorway
dl({{590, 560}, {590, 225}, {790, 225}, {790, 560}})
-- batwing leaves
dl({{592, 345}, {650, 338}, {650, 512}, {592, 492}, {592, 345}}, 0.35)
dl({{788, 345}, {745, 336}, {745, 515}, {788, 492}, {788, 345}}, 0.35)
-- bar counter
dl({{1000, 395}, {840, 395}, {840, 590}, {1000, 700}}, 0.45)
dl({{880, 180}, {1000, 150}}, 0.3)
dl({{880, 260}, {1000, 245}}, 0.3)
dl({{880, 335}, {1000, 330}}, 0.3)
-- lamp
dl({{380, 0}, {380, 135}}, 0.3)
dl({{350, 140}, {410, 140}, {395, 175}, {365, 175}, {350, 140}}, 0.4)
-- spill
dl({{590, 560}, {540, 690}, {905, 690}, {790, 560}}, 0.3)
print(db:fullness())

--@ chunk 3
db:load(drawp, 0.7)
-- zombie
local zh = outline{{700, 299}, {719, 314}, {722, 338}, {706, 352}, {688, 346}, {680, 322}, char="searching", seed=11}
zh:paint(db, {pressure=0.35, dip={drawp, 0.6}, every=3})
dl({{690, 350}, {686, 362}}, 0.35)
dl({{660, 364}, {698, 360}, {736, 370}}, 0.4)          -- shoulders
dl({{662, 366}, {632, 386}, {606, 384}}, 0.4)          -- reaching arm
dl({{606, 384}, {596, 378}}, 0.3) dl({{606, 384}, {594, 390}}, 0.3)
dl({{736, 370}, {764, 398}, {754, 368}}, 0.4)          -- arm pushing door
dl({{662, 366}, {670, 420}, {680, 462}}, 0.4)          -- torso left side
dl({{736, 372}, {722, 420}, {712, 465}}, 0.4)          -- torso right side
dl({{676, 462}, {664, 508}, {652, 572}}, 0.4)          -- forward leg
dl({{708, 465}, {716, 512}, {726, 558}}, 0.4)          -- back leg
-- cowboy hat
local hat = outline{{205, 336}, {222, 300}, {250, 290}, {282, 296}, {294, 330}, char="firm", seed=12}
hat:paint(db, {pressure=0.4, dip={drawp, 0.6}, every=3})
dl({{168, 345}, {210, 332}, {300, 328}, {345, 334}, {320, 346}, {250, 352}, {168, 345}}, 0.4)  -- brim
-- head / face turned right
dl({{232, 352}, {240, 380}, {268, 392}, {296, 382}, {306, 360}}, 0.4)
-- back and shoulders
dl({{250, 388}, {200, 395}, {172, 420}, {168, 470}, {185, 520}, {212, 548}}, 0.45)
dl({{296, 388}, {330, 400}})
-- gun arm
dl({{328, 400}, {398, 428}, {468, 420}}, 0.45)
dl({{334, 425}, {396, 448}, {462, 434}}, 0.4)
dl({{460, 412}, {536, 404}}, 0.45)    -- revolver barrel
dl({{462, 432}, {478, 448}}, 0.4)       -- grip
-- hips and legs
dl({{212, 548}, {260, 556}, {300, 545}}, 0.4)
dl({{215, 552}, {180, 640}, {150, 700}, {95, 715}}, 0.45)    -- kneeling leg, shin back
dl({{295, 548}, {345, 585}, {350, 690}}, 0.45)              -- forward leg
dl({{330, 690}, {372, 694}}, 0.45)
-- table disc (underside toward us)
local tab = outline{{440, 415}, {502, 450}, {530, 560}, {502, 672}, {440, 705}, {388, 668}, {362, 560}, {382, 455}, char="firm", amount=0.3, seed=13}
tab:paint(db, {pressure=0.4, dip={drawp, 0.6}, every=3})
dl({{432, 480}, {340, 505}}, 0.35)   -- legs pointing toward us
dl({{478, 560}, {392, 590}}, 0.35)
dl({{432, 645}, {345, 675}}, 0.35)
-- lamp chain + muzzle
dl({{540, 400}, {560, 395}}, 0.3)
print(db:fullness())

--@ chunk 4
-- architecture masks
doorM = rect(590, 210, 200, 350)
backM = poly({{200, 0}, {880, 0}, {880, 560}, {200, 560}}) - doorM
leftwallM = poly({{0, 0}, {200, 0}, {200, 560}, {0, 631}})
rightwallM = poly({{880, 0}, {1000, 0}, {1000, 643}, {880, 560}})
floorM = poly({{0, 631}, {200, 560}, {880, 560}, {1000, 643}, {1000, 750}, {0, 750}})
barM = poly({{821, 380}, {1000, 358}, {1000, 750}, {944, 750}, {821, 604}})
spillM = poly({{590, 560}, {790, 560}, {660, 690}, {297, 690}})
-- figures
zombieM = (ellipse(684, 312, 17, 22)
  + poly({{676, 330}, {694, 330}, {700, 345}, {670, 345}})
  + poly({{652, 340}, {690, 333}, {722, 342}, {732, 372}, {726, 410}, {728, 450}, {716, 468}, {700, 458}, {684, 470}, {668, 456}, {664, 410}, {656, 372}}, true)
  + ribbon({{658, 346}, {634, 366}, {610, 370}}, {20, 15, 11})
  + ribbon({{722, 350}, {740, 380}, {728, 400}}, {18, 14, 11})
  + ribbon({{686, 455}, {674, 500}, {668, 562}}, {22, 17, 13})
  + ribbon({{704, 455}, {714, 500}, {720, 552}}, {21, 16, 12}))
zombieM = zombieM:roughen(3, 14, 5)
leafL = poly({{590, 320}, {639, 313}, {639, 504}, {590, 496}})
leafR = poly({{790, 320}, {724, 315}, {724, 502}, {790, 496}})
cowboyM = (poly({{222, 334}, {226, 304}, {240, 292}, {258, 298}, {274, 289}, {290, 302}, {294, 334}}, true)
  + poly({{164, 347}, {200, 332}, {258, 327}, {318, 329}, {350, 337}, {330, 349}, {262, 355}, {196, 355}}, true)
  + poly({{236, 350}, {240, 378}, {258, 393}, {286, 395}, {306, 384}, {314, 368}, {310, 352}}, true)
  + poly({{250, 385}, {200, 392}, {172, 418}, {165, 468}, {178, 520}, {210, 552}, {300, 552}, {330, 500}, {338, 440}, {330, 400}, {300, 388}}, true)
  + ribbon({{318, 410}, {395, 434}, {462, 424}}, {36, 27, 19})
  + ellipse(472, 422, 15, 12)
  + ribbon({{225, 540}, {200, 630}, {185, 690}}, {72, 58, 46})
  + ribbon({{185, 690}, {110, 722}}, {44, 38})
  + ellipse(92, 724, 26, 22)
  + ribbon({{280, 540}, {345, 585}}, {66, 50})
  + ribbon({{345, 585}, {352, 690}}, {46, 38})
  + poly({{328, 680}, {372, 676}, {398, 700}, {392, 712}, {330, 712}}, true))
gunM = ribbon({{470, 414}, {538, 406}}, 6) + poly({{462, 410}, {490, 408}, {492, 424}, {466, 428}}) + ribbon({{468, 426}, {478, 446}}, 9)
tableM = poly({{446, 415}, {504, 440}, {532, 520}, {534, 600}, {506, 680}, {446, 707}, {392, 678}, {362, 600}, {360, 520}, {386, 445}}, true)
lampM = poly({{335, 175}, {395, 175}, {382, 200}, {348, 200}}) + rect(358, 200, 14, 22) + ellipse(365, 228, 13, 9)
print(cowboyM:area(), zombieM:area(), tableM:area())

--@ chunk 5
zombieM = (poly({{666, 270}, {682, 264}, {698, 272}, {702, 294}, {694, 314}, {680, 318}, {668, 306}, {663, 288}}, true)
  + poly({{672, 308}, {692, 308}, {698, 330}, {668, 330}})
  + poly({{646, 328}, {690, 318}, {728, 330}, {740, 366}, {732, 410}, {734, 452}, {722, 474}, {706, 466}, {688, 478}, {670, 466}, {664, 420}, {652, 372}}, true)
  + ribbon({{652, 336}, {626, 320}, {606, 298}}, {22, 16, 12})
  + ribbon({{606, 298}, {596, 286}}, 5) + ribbon({{606, 298}, {592, 292}}, 5) + ribbon({{606, 298}, {598, 302}}, 4)
  + ribbon({{728, 340}, {750, 374}, {730, 394}}, {20, 16, 12})
  + ribbon({{688, 462}, {676, 506}, {668, 566}}, {24, 18, 14})
  + ribbon({{708, 462}, {716, 506}, {722, 555}}, {22, 17, 13})
  + poly({{656, 568}, {672, 560}, {684, 570}, {660, 574}}, true))
zombieM = zombieM:roughen(3, 12, 7)
cowboyTorso = poly({{248, 386}, {205, 392}, {178, 412}, {166, 452}, {170, 495}, {190, 530}, {222, 552}, {296, 550}, {318, 520}, {334, 468}, {338, 425}, {328, 398}, {300, 388}}, true)
hatM = poly({{222, 334}, {226, 304}, {240, 292}, {258, 298}, {274, 289}, {290, 302}, {294, 334}}, true)
  + poly({{164, 347}, {200, 332}, {258, 327}, {318, 329}, {350, 337}, {330, 349}, {262, 355}, {196, 355}}, true)
headM = poly({{236, 350}, {240, 378}, {258, 393}, {286, 395}, {306, 384}, {314, 368}, {310, 352}}, true)
gunarmM = ribbon({{318, 410}, {395, 434}, {462, 424}}, {36, 27, 19}) + ellipse(472, 422, 15, 12)
legsM = ribbon({{225, 540}, {200, 630}, {185, 690}}, {72, 58, 46}) + ribbon({{185, 690}, {110, 722}}, {44, 38})
  + ellipse(92, 724, 26, 22) + ribbon({{280, 540}, {345, 585}}, {66, 50}) + ribbon({{345, 585}, {352, 690}}, {46, 38})
  + poly({{328, 680}, {372, 676}, {398, 700}, {392, 712}, {330, 712}}, true)
cowboyM = hatM + headM + cowboyTorso + gunarmM + legsM
print(zombieM:area())

--@ chunk 6
wallD = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.5}, turps=0.3, name="wallD"}
deepD = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.4}, turps=0.3, name="deepD"}
glowW = pile{{"raw umber", 1}, {"burnt sienna", 1}, {"yellow ochre", 1.4}, turps=0.3, name="glowW"}
local figs = cowboyM + tableM
local wallsM = ((backM + leftwallM + rightwallM) - doorM) - figs:shrink(4)
local function gl(x, y)
  local d = math.sqrt((x - 365)^2 + ((y - 240) * 1.2)^2)
  return 1 - smoothstep(60, 330, d)
end
local function dp(x, y)
  -- deep in the upper corners, the far left and the right wall
  local t = smoothstep(380, 0, y) * 0.6 + smoothstep(250, 0, x) * 0.5 + smoothstep(850, 1000, x) * 0.7
  return clamp(t, 0, 1) * (1 - gl(x, y))
end
work(wallsM, {hand="broad", piles={{glowW, gl}, {wallD, function(x, y) return 0.25 + (1 - gl(x, y)) end}, {deepD, dp}},
  coverage=2, fill=true, clip=wallsM, angle=function(x, y) return 0.15 * math.sin(y / 90) end})

--@ chunk 7
warmD = pile{{"raw umber", 2}, {"burnt sienna", 1.2}, {"bone black", 0.4}, turps=0.3, name="warmD"}
local figs = cowboyM + tableM
local flM = (floorM - spillM:shrink(3)) - figs:shrink(4)
local function toVP(x, y) return math.atan(400 - y, 650 - x) end
local function near(x, y) return smoothstep(600, 750, y) end
local function lampfloor(x, y)
  local d = math.sqrt((x - 330)^2 + ((y - 600) * 2.2)^2)
  return 0.9 * (1 - smoothstep(30, 260, d))
end
work(flM, {hand="broad", piles={{warmD, function(x, y) return 0.4 + lampfloor(x, y) end}, {wallD, function(x, y) return 0.5 end}, {deepD, function(x, y) return near(x, y) * 1.2 + smoothstep(850, 1000, x) * 0.8 end}},
  coverage=2, fill=true, clip=flM, angle=toVP, angle_jitter=0.05})

--@ chunk 8
local cm = cowboyM + gunM
work(cm, {hand="body", piles={{warmD, function(x, y) return 0.6 + smoothstep(450, 300, y) end}, {deepD, function(x, y) return smoothstep(380, 600, y) * 0.8 end}},
  coverage=2, fill=true, clip=cm, angle=function(x, y) return 1.3 end, angle_jitter=0.4})
work(tableM - cm, {hand="body", piles={{warmD, 1}, {deepD, function(x, y) return 0.3 + smoothstep(500, 700, y) end}},
  coverage=2, fill=true, clip=tableM - cm, angle=1.4, angle_jitter=0.2})

--@ chunk 9
skyP = pile{{"lead white", 8}, {"Naples yellow", 1}, {"lemon chrome", 0.25}, name="sky"}
facP = pile{{"lead white", 5}, {"Naples yellow", 1}, {"raw umber", 0.12}, {"ultramarine blue", 0.06}, name="facade"}
streetP = pile{{"lead white", 5}, {"Naples yellow", 1.6}, {"yellow ochre", 0.35}, name="street"}

--@ chunk 10
local reserve = (zombieM + leafL + leafR):shrink(3)
doorLightM = doorM - reserve
local function wsky(x, y) return 1 - smoothstep(282, 296, y) end
local function wfac(x, y) return smoothstep(282, 296, y) * (1 - smoothstep(446, 458, y)) end
local function wst(x, y) return smoothstep(446, 458, y) end
work(doorLightM, {hand="body", tool={kind="filbert", width=10, lay=2.5}, piles={{skyP, wsky}, {facP, wfac}, {streetP, wst}},
  coverage=2.5, fill=true, clip=doorM, angle=function(x, y) return y < 300 and 0.05 or 1.57 end, angle_jitter=0.2, length={15, 40}})

--@ chunk 11
zombD = pile{{"bone black", 1}, {"raw umber", 1}, {"green earth", 1.2}, turps=0.2, name="zombD"}
work(leafL + leafR, {hand="body", tool="filbert 6", pile=wallD, coverage=2, fill=true, clip=(leafL + leafR) - zombieM, angle=1.57, angle_jitter=0.1})
work(zombieM, {hand="body", tool="filbert 5", piles={{zombD, 1}, {deepD, 0.5}}, coverage=2, fill=true, clip=zombieM, angle=1.5, angle_jitter=0.4, length={8, 25}})

--@ chunk 12
local oldM = (zombieM + leafL + leafR):grow(2)
local r = rag{width=30}
r:dip(0.9)
r:wipe(oldM, {pressure=0.7, angle=1.57, passes=2, refold=0.5})
r:refold() r:dip(0.9)
r:wipe(oldM, {pressure=0.8, angle=0.0, passes=2, refold=0.5})
print(r)

--@ chunk 13
local oldM = (zombieM + leafL + leafR):grow(2)
for i = 1, 3 do
  local r = rag{width=30}
  r:dip(0.95)
  r:wipe(oldM, {pressure=0.85, angle=1.57 * (i % 2), passes=1, refold=0.4})
  r:dip(0.95)
  r:wipe(oldM, {pressure=0.85, angle=0.8, passes=1, refold=0.4})
end

--@ chunk 14
local r = rag{width=14}
r:dip(0.95)
r:blot(598, 292, {pressure=0.9})
r:refold() r:dip(0.95)
r:blot(602, 300, {pressure=0.9})
r:refold() r:dip(0.95)
r:wipe({{594, 286}, {610, 302}}, {pressure=0.9})
-- new silhouettes
zombieM = (poly({{644, 304}, {650, 296}, {664, 296}, {676, 304}, {680, 320}, {672, 338}, {660, 346}, {647, 346}, {641, 340}, {645, 333}, {641, 328}, {636, 321}, {640, 312}}, true)
  + poly({{652, 338}, {668, 334}, {678, 352}, {658, 356}})
  + poly({{648, 352}, {672, 340}, {705, 334}, {722, 345}, {730, 372}, {728, 405}, {724, 440}, {716, 466}, {706, 458}, {698, 470}, {688, 460}, {680, 468}, {676, 432}, {668, 398}, {655, 374}}, true)
  + ribbon({{654, 356}, {628, 368}, {603, 362}}, {18, 13, 9})
  + ribbon({{603, 362}, {588, 354}}, 3.5) + ribbon({{603, 362}, {586, 362}}, 3.5) + ribbon({{603, 362}, {590, 370}}, 3.5)
  + ribbon({{672, 344}, {640, 336}, {610, 326}}, {16, 12, 9})
  + ribbon({{610, 326}, {594, 318}}, 3.5) + ribbon({{610, 326}, {593, 326}}, 3.5) + ribbon({{610, 326}, {597, 333}}, 3.5)
  + ribbon({{688, 455}, {673, 502}, {665, 560}}, {22, 16, 12})
  + poly({{650, 567}, {668, 556}, {677, 569}, {654, 574}}, true)
  + ribbon({{706, 455}, {720, 505}, {732, 548}}, {20, 15, 11})
  + poly({{725, 545}, {743, 548}, {741, 558}, {723, 557}}, true)
  + ribbon({{628, 368}, {631, 384}}, {6, 2}) + ribbon({{714, 458}, {719, 478}}, {6, 2}) + ribbon({{694, 464}, {690, 482}}, {5, 2}))
zombieM = zombieM:roughen(2, 10, 9)
leafL = poly({{584, 312}, {596, 318}, {596, 497}, {584, 505}})
leafR = poly({{790, 312}, {770, 316}, {750, 326}, {726, 330}, {722, 500}, {790, 496}}, true)
print(zombieM:area())

--@ chunk 15
leafR = poly({{790, 311}, {778, 313}, {766, 317}, {754, 322}, {742, 327}, {730, 330}, {722, 331}, {722, 500}, {790, 496}})
local reserve = (zombieM + leafL + leafR):shrink(2)
doorLightM = doorM - reserve
local function wsky(x, y) return 1 - smoothstep(282, 296, y) end
local function wfac(x, y) return smoothstep(282, 296, y) * (1 - smoothstep(446, 458, y)) end
local function wst(x, y) return smoothstep(446, 458, y) end
work(doorLightM, {hand="body", tool={kind="filbert", width=8, lay=2.5}, piles={{skyP, wsky}, {facP, wfac}, {streetP, wst}},
  coverage=2, fill=true, clip=doorLightM:grow(1) * doorM, angle=function(x, y) return y < 300 and 0.05 or 1.57 end, angle_jitter=0.2, length={12, 30}})

--@ chunk 16
zombD2 = pile{{"bone black", 1}, {"raw umber", 1.2}, {"green earth", 1.2}, name="zombD2"}
leafP = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.6}, name="leafP"}
work(leafL + leafR - zombieM, {hand="body", tool="filbert 5", pile=leafP, coverage=2.5, fill=true, clip=(leafL + leafR) - zombieM, angle=1.57, angle_jitter=0.08, length={15, 40}})
work(zombieM, {hand="detail", tool={kind="round", width=4, point=0.3}, pile=zombD2, coverage=3, fill=true, clip=zombieM, angle=1.5, angle_jitter=0.6, length={6, 18}})

--@ chunk 17
work(barM, {hand="body", tool="filbert 12", piles={{deepD, 1}, {warmD, function(x, y) return 0.6 * smoothstep(700, 420, y) end}}, coverage=2, fill=true, clip=barM, angle=1.57, angle_jitter=0.1, length={30, 80}})
-- shelves on the right wall: darker bands
local sh = poly({{880, 345}, {1000, 322}, {1000, 334}, {880, 355}}) + poly({{880, 285}, {1000, 234}, {1000, 246}, {880, 295}}) + poly({{880, 223}, {1000, 146}, {1000, 158}, {880, 233}})
work(sh, {hand="detail", tool={kind="flat", width=5}, pile=deepD, coverage=2, fill=true, clip=sh, angle=-0.25})

--@ chunk 18
flameP = pile{{"lead white", 3}, {"lemon chrome", 1}, {"cadmium yellow", 0.2}, name="flame"}
lampGlowP = pile{{"Naples yellow", 2}, {"cadmium yellow", 1}, {"lead white", 1}, {"orange chrome", 0.35}, name="lampGlow"}
brassP = pile{{"yellow ochre", 2}, {"raw sienna", 1}, {"raw umber", 0.4}, name="brass"}
shadeM = poly({{325, 182}, {348, 168}, {382, 168}, {405, 182}, {395, 189}, {335, 189}})
chimM = poly({{358, 189}, {372, 189}, {374, 214}, {356, 214}})
fontM = ellipse(365, 224, 15, 11)
local cb = brush{kind="round", width=2, point=0.5}
cb:load(deepD, 0.8)
cb:stroke({{365, 0}, {365, 152}}, {pressure=0.5})
cb:stroke({{365, 152}, {334, 178}}, {pressure=0.35})
cb:stroke({{365, 152}, {396, 178}}, {pressure=0.35})
work(shadeM, {hand="detail", tool={kind="round", width=4}, pile=deepD, coverage=3, fill=true, clip=shadeM, angle=0})
work(fontM, {hand="detail", tool={kind="round", width=4}, pile=brassP, coverage=3, fill=true, clip=fontM, angle=0})
work(chimM, {hand="detail", tool={kind="round", width=3, lay=3}, pile=lampGlowP, coverage=3, fill=true, clip=chimM, angle=1.57})
local fb = brush{kind="round", width=5, point=0.6, lay=4}
fb:load(flameP, 0.9)
fb:gesture({{365, 210, 0.7}, {365, 203, 0.9}, {365, 194, 0.3}})
-- lit underside rim of the shade
local rb = brush{kind="flat", width=3}
rb:load(lampGlowP, 0.7)
rb:stroke({{338, 188}, {365, 190}, {392, 188}}, {pressure=0.5})

--@ chunk 19
print(wait(20 * 60))
for _, p in ipairs({{300, 100}, {100, 600}, {650, 250}, {690, 400}, {250, 450}, {900, 500}, {365, 200}}) do
  print(p[1], p[2], drying(p[1], p[2]))
end

--@ chunk 20
print(wait(30 * 60))
for _, p in ipairs({{300, 100}, {100, 600}, {650, 250}, {690, 400}, {250, 450}, {900, 500}, {365, 200}, {760, 400}}) do
  print(p[1], p[2], drying(p[1], p[2]))
end

--@ chunk 21
palette{scrape={drawp, zombD, glowW, wallD}}
wallHi = pile{{"yellow ochre", 2}, {"burnt sienna", 0.6}, {"lead white", 0.7}, {"raw umber", 0.2}, name="wallHi"}
wallMid = pile{{"raw umber", 1}, {"burnt sienna", 1}, {"yellow ochre", 1}, name="wallMid"}
wallDk = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.6}, name="wallDk"}
local protect = (cowboyM + tableM + lampM + shadeM + chimM + fontM):grow(3) + ribbon({{365, 0}, {365, 160}}, 6)
local bw = backM - protect - barM
local function boundary(x) return 150 - 0.0022 * (x - 365)^2 end
function lampLit(x, y)
  local d = math.sqrt((x - 365)^2 + ((y - 235) * 1.15)^2)
  local inten = 1 - smoothstep(40, 360, d)
  local shade = smoothstep(boundary(x) - 25, boundary(x) + 25, y)
  return inten * (0.25 + 0.75 * shade)
end
work(bw, {hand="body", tool="filbert 12", piles={
    {wallHi, function(x, y) return smoothstep(0.45, 0.85, lampLit(x, y)) * 1.5 end},
    {wallMid, function(x, y) local l = lampLit(x, y) return smoothstep(0.1, 0.4, l) * (1 - smoothstep(0.6, 0.9, l)) * 1.2 end},
    {wallDk, function(x, y) return 1 - smoothstep(0.05, 0.35, lampLit(x, y)) end}},
  coverage=2, fill=true, clip=bw, angle=0, angle_jitter=0.06, length={30, 90}, mix_jitter=0.05})

--@ chunk 22
local protect = (cowboyM + tableM):grow(3)
local lw = leftwallM - protect
local function lwLit(x, y)
  local d = math.sqrt(((x - 200) * 1.3)^2 + ((y - 300) * 0.9)^2)
  return (1 - smoothstep(20, 260, d)) * smoothstep(60, 180, y)
end
-- left wall boards run vertical; strokes vertical
work(lw, {hand="body", tool="filbert 10", piles={
    {wallMid, function(x, y) return lwLit(x, y) * 1.3 end},
    {wallDk, function(x, y) return 1 - 0.7 * lwLit(x, y) end}},
  coverage=2, fill=true, clip=lw, angle=1.57, angle_jitter=0.08, length={30, 80}, mix_jitter=0.05})
local rw = rightwallM - barM:grow(2)
work(rw, {hand="body", tool="filbert 10", piles={
    {wallMid, function(x, y) return 0.35 * (1 - smoothstep(300, 450, y)) * smoothstep(0, 200, y) end},
    {wallDk, 1}},
  coverage=2, fill=true, clip=rw, angle=1.57, angle_jitter=0.08, length={30, 80}, mix_jitter=0.05})

--@ chunk 23
floorLit = pile{{"lead white", 3}, {"yellow ochre", 2}, {"Naples yellow", 1}, {"burnt sienna", 0.2}, name="floorLit"}
floorDk = pile{{"raw umber", 2}, {"burnt sienna", 1}, {"bone black", 0.6}, name="floorDk"}
-- spill painted first, slightly beyond its edge into the floor
local protect = (cowboyM + tableM):grow(2)
local sp = spillM - protect
work(sp, {hand="body", tool={kind="filbert", width=9, lay=1.5}, pile=floorLit, coverage=2, fill=true, clip=sp,
  angle=function(x, y) return math.atan(400 - y, 650 - x) end, angle_jitter=0.04, length={20, 60}})

--@ chunk 24
local protect = (cowboyM + tableM):grow(2) + spillM:shrink(1)
local fl = floorM - protect
local function lampF(x, y)
  local d = math.sqrt(((x - 330) * 0.8)^2 + ((y - 620) * 2.0)^2)
  return 1 - smoothstep(40, 300, d)
end
local function doorF(x, y)
  -- the floor near the door threshold catches some reflected light
  local d = math.sqrt(((x - 690) * 0.9)^2 + ((y - 570) * 2.5)^2)
  return 1 - smoothstep(20, 200, d)
end
work(fl, {hand="body", tool="filbert 10", piles={
    {wallMid, function(x, y) return lampF(x, y) * 1.2 + doorF(x, y) * 0.8 end},
    {floorDk, function(x, y) return 0.4 + smoothstep(640, 750, y) * 0.6 + smoothstep(820, 1000, x) * 0.5 end}},
  coverage=2, fill=true, clip=fl, angle=function(x, y) return math.atan(400 - y, 650 - x) end, angle_jitter=0.04, length={25, 70}, mix_jitter=0.05})

--@ chunk 25
palette{scrape={facP, streetP, brassP, flameP}}
vestP = pile{{"bone black", 1}, {"raw umber", 1}, {"burnt sienna", 0.4}, name="vest"}
sleeveP = pile{{"Indian red", 1}, {"raw umber", 0.6}, {"bone black", 0.25}, name="sleeve"}
trouserP = pile{{"bone black", 1}, {"ultramarine blue", 0.4}, {"raw umber", 1}, {"lead white", 0.35}, name="trousers"}
hatP = pile{{"raw umber", 2}, {"yellow ochre", 1}, {"bone black", 0.3}, name="hat"}
skinD = pile{{"burnt sienna", 1}, {"raw umber", 1}, {"red earth", 0.5}, name="skinD"}

--@ chunk 26
for _, p in ipairs({{250, 450}, {200, 600}, {440, 550}, {300, 320}, {120, 715}, {470, 425}}) do
  print(p[1], p[2], drying(p[1], p[2]))
end
local d = cowboyTorso:distance()
print(d:at(250, 450), d:at(180, 450), d:at(100, 450))

--@ chunk 27
print(wait(24 * 60))
for _, p in ipairs({{250, 450}, {200, 600}, {440, 550}, {120, 715}, {470, 425}, {650, 250}, {690, 400}, {600, 620}, {900, 500}, {400, 300}}) do
  print(p[1], p[2], drying(p[1], p[2]))
end

--@ chunk 28
function facing(m, lx, ly, k, soft)
  local dist = m:distance()
  soft = soft or 0.5
  return function(x, y)
    local dx, dy = lx - x, ly - y
    local l = math.sqrt(dx * dx + dy * dy) + 1e-6
    local v = dist:at(x + dx / l * k, y + dy / l * k)
    return 1 - smoothstep(-k * soft, k * soft, v)
  end
end
crownM = poly({{222, 334}, {226, 304}, {240, 292}, {258, 298}, {274, 289}, {290, 302}, {294, 334}}, true)
brimM = poly({{164, 347}, {200, 332}, {258, 327}, {318, 329}, {350, 337}, {330, 349}, {262, 355}, {196, 355}}, true)
local fc = facing(crownM, 365, 205, 14)
work(crownM, {hand="detail", tool={kind="filbert", width=6}, piles={
    {wallHi, function(x, y) return fc(x, y) * 1.2 + 0.1 end},
    {hatP, 1},
    {deepD, function(x, y) return (1 - fc(x, y)) * 0.6 end}},
  coverage=3, fill=true, clip=crownM, angle=1.4, angle_jitter=0.3, length={8, 20}})
-- brim underside: dark warm, a little reflected warmth near the right
work(brimM, {hand="detail", tool={kind="filbert", width=5}, piles={
    {hatP, 0.6}, {deepD, 1},
    {skinD, function(x, y) return smoothstep(260, 340, x) * 0.6 end}},
  coverage=3, fill=true, clip=brimM, angle=0.05, angle_jitter=0.1, length={10, 30}})

--@ chunk 29
local hm = (crownM + brimM):grow(1)
for i = 1, 2 do
  local r = rag{width=16}
  r:dip(0.95)
  r:wipe(hm, {pressure=0.85, angle=(i == 1) and 0 or 1.57, passes=2, refold=0.35})
end

--@ chunk 30
palette{scrape={hatP}}
hatP = pile{{"raw umber", 1}, {"burnt sienna", 0.7}, {"yellow ochre", 0.6}, {"lead white", 0.25}, name="hat"}
brimM = poly({{158, 333}, {176, 339}, {205, 336}, {258, 332}, {315, 333}, {345, 330}, {360, 324}, {352, 338}, {330, 351}, {290, 359}, {250, 361}, {205, 357}, {178, 350}}, true)
crownM = poly({{224, 337}, {226, 306}, {238, 292}, {256, 297}, {274, 288}, {289, 300}, {295, 336}}, true)
local hm = (crownM + brimM):grow(3) - headM
local fc = facing(crownM, 365, 205, 14)
work(crownM:grow(3) - brimM:shrink(2), {hand="detail", tool={kind="filbert", width=6}, piles={
    {wallHi, function(x, y) return fc(x, y) * 1.6 + 0.15 end},
    {hatP, 1},
    {deepD, function(x, y) return (1 - fc(x, y)) * 0.25 end}},
  coverage=3, fill=true, clip=crownM:grow(3) - brimM:shrink(2), angle=1.4, angle_jitter=0.3, length={8, 20}})
work(brimM:grow(3), {hand="detail", tool={kind="filbert", width=5}, piles={
    {hatP, 1}, {warmD, 0.8},
    {skinD, function(x, y) return smoothstep(250, 340, x) * 0.5 end}},
  coverage=3, fill=true, clip=brimM:grow(3), angle=0.0, angle_jitter=0.1, length={10, 30}})

--@ chunk 31
local hm = (crownM + brimM):grow(4)
for i = 1, 3 do
  local r = rag{width=16}
  r:dip(0.95)
  r:wipe(hm, {pressure=0.9, angle=(i % 2 == 1) and 0 or 1.57, passes=2, refold=0.3})
end

--@ chunk 32
local hm = (crownM + brimM):grow(3)
work(hm, {hand="detail", tool={kind="filbert", width=6}, piles={{warmD, 1}, {deepD, function(x, y) return 0.3 + 0.5 * smoothstep(330, 360, y) end}},
  coverage=3, fill=true, clip=hm, angle=function(x, y) return y < 335 and 1.45 or 0.03 end, angle_jitter=0.15, length={10, 26}})
-- lamp light on the crown: from upper right
local lb = brush{kind="filbert", width=7}
lb:load(wallMid, 0.7)
lb:gesture({{286, 302, 0.3}, {291, 315, 0.7}, {293, 330, 0.5}})
lb:gesture({{262, 296, 0.3}, {275, 291, 0.6}, {287, 299, 0.3}})
lb:gesture({{276, 306, 0.2}, {281, 318, 0.4}, {282, 330, 0.2}})
local hb = brush{kind="round", width=3.5, point=0.4}
hb:load(wallHi, 0.7)
hb:gesture({{280, 292, 0.2}, {287, 300, 0.5}, {291, 314, 0.4}, {292, 324, 0.1}})
-- lit far edge of the brim, right side, up the curl
local eb = brush{kind="round", width=3, point=0.5}
eb:load(wallMid, 0.7)
eb:gesture({{262, 333, 0.1}, {300, 333, 0.4}, {330, 331, 0.6}, {352, 326, 0.5}, {359, 323, 0.2}})
eb:load(wallHi, 0.5)
eb:gesture({{318, 332, 0.1}, {340, 330, 0.45}, {356, 324, 0.3}})

--@ chunk 33
leftSleeveM = ribbon({{200, 400}, {176, 440}, {170, 478}, {196, 512}}, {30, 30, 28, 24}) * cowboyTorso:grow(2)
vestM = cowboyTorso - leftSleeveM
beltM = poly({{186, 524}, {300, 534}, {306, 550}, {222, 553}, {196, 540}}, true) * cowboyTorso
-- vest: dark, warm light from the lamp along the top of the shoulders and the right side
local fv = facing(cowboyTorso, 365, 210, 22)
work(vestM - beltM, {hand="body", tool={kind="filbert", width=8}, piles={
    {vestP, 1},
    {warmD, function(x, y) return fv(x, y) * 0.9 end},
    {wallMid, function(x, y) return fv(x, y) * smoothstep(420, 395, y) * 0.9 end}},
  coverage=2.5, fill=true, clip=vestM - beltM, angle=function(x, y) return 1.2 + (x - 250) / 300 end, angle_jitter=0.2, length={15, 40}})
local fs = facing(leftSleeveM, 365, 210, 14)
work(leftSleeveM, {hand="detail", tool={kind="filbert", width=6}, piles={
    {sleeveP, 1}, {deepD, function(x, y) return 0.5 * (1 - fs(x, y)) end}},
  coverage=3, fill=true, clip=leftSleeveM, angle=1.8, angle_jitter=0.2, length={10, 25}})
work(beltM, {hand="detail", tool={kind="flat", width=5}, piles={{skinD, 0.5}, {vestP, 1}}, coverage=3, fill=true, clip=beltM, angle=0.08, length={10, 30}})

--@ chunk 34
palette{scrape={leafP, zombD2}}
hairP = pile{{"bone black", 1}, {"raw umber", 1.5}, {"burnt sienna", 0.3}, name="hair"}
headM = poly({{238, 352}, {240, 372}, {248, 386}, {262, 394}, {286, 398}, {304, 390}, {314, 378}, {320, 368}, {314, 360}, {312, 350}}, true)
local hairM = poly({{236, 350}, {270, 350}, {266, 362}, {262, 384}, {256, 394}, {244, 386}, {238, 370}}, true)
local skinM = headM - hairM
work(hairM, {hand="detail", tool={kind="round", width=4}, pile=hairP, coverage=3, fill=true, clip=hairM, angle=1.7, angle_jitter=0.3, length={6, 14}})
work(skinM, {hand="detail", tool={kind="round", width=4}, piles={{skinD, 1}, {deepD, function(x, y) return 0.6 * smoothstep(372, 352, y) end}}, coverage=3, fill=true, clip=skinM, angle=1.4, angle_jitter=0.3, length={6, 14}})
rightSleeveM = ribbon({{318, 404}, {360, 420}, {400, 430}, {448, 426}}, {34, 30, 26, 22}) * (gunarmM + cowboyTorso)
local fr = facing(rightSleeveM, 365, 200, 12)
work(rightSleeveM, {hand="detail", tool={kind="filbert", width=6}, piles={{sleeveP, 1}, {deepD, function(x, y) return 0.4 * (1 - fr(x, y)) end}},
  coverage=3, fill=true, clip=rightSleeveM, angle=0.15, angle_jitter=0.1, length={12, 30}})

--@ chunk 35
tablePts = {{446, 415}, {504, 440}, {532, 520}, {534, 600}, {506, 680}, {446, 707}, {392, 678}, {362, 600}, {360, 520}, {386, 445}}
local function shifted(pts, dx, dy)
  local o = {}
  for i, p in ipairs(pts) do o[i] = {p[1] + dx, p[2] + dy} end
  return o
end
tableFace = poly(shifted(tablePts, -11, -2), true) * tableM
tableRim = tableM - tableFace
print(tableRim:area(), tableFace:area())

--@ chunk 36
woodP = pile{{"burnt sienna", 1}, {"raw umber", 1}, {"yellow ochre", 0.5}, name="wood"}
local face = tableFace - (cowboyM + gunM):grow(1)
local fl = facing(tableM, 330, 150, 30)
work(face, {hand="body", tool={kind="flat", width=8}, piles={
    {woodP, function(x, y) return 0.5 + 0.8 * smoothstep(560, 430, y) end},
    {floorDk, function(x, y) return 0.7 * smoothstep(480, 700, y) + 0.3 end},
    {wallMid, function(x, y) return 0.8 * smoothstep(470, 420, y) end}},
  coverage=2.5, fill=true, clip=face, angle=1.57, angle_jitter=0.05, length={30, 90}, mix_jitter=0.06})
-- plank joints: thin dark verticals, slightly converging
local jb = brush{kind="round", width=1.6, point=0.6}
for _, x in ipairs({392, 418, 446, 474, 500}) do
  jb:load(deepD, 0.5)
  local top = 440 + math.abs(x - 446) * 0.6
  local bot = 690 - math.abs(x - 446) * 0.75
  jb:stroke({{x, top}, {x - 2, (top + bot) / 2}, {x - 5, bot}}, {pressure={0.5, 0.35}, ramps={0.15, 0.25}})
end

--@ chunk 37
palette{scrape={hairP, woodP}}
bootP = pile{{"bone black", 1}, {"raw umber", 1}, {"burnt sienna", 0.5}, name="boot"}
backLegM = ribbon({{225, 545}, {205, 625}, {190, 690}}, {68, 56, 44}) * legsM
frontLegM = (ribbon({{280, 540}, {345, 585}}, {66, 50}) + ribbon({{345, 585}, {352, 680}}, {46, 38})) * legsM
bootBackM = (ribbon({{185, 690}, {110, 722}}, {44, 38}) + ellipse(92, 724, 26, 22)) * legsM
bootFrontM = poly({{326, 668}, {372, 664}, {398, 700}, {392, 712}, {330, 712}}, true)
local ftL = facing(backLegM, 365, 220, 18)
work(backLegM - cowboyTorso, {hand="body", tool={kind="filbert", width=8}, piles={
    {trouserP, 1}, {wallDk, function(x, y) return 0.3 + 0.4 * ftL(x, y) end}},
  coverage=2.5, fill=true, clip=backLegM - cowboyTorso, angle=1.8, angle_jitter=0.15, length={20, 50}})
local ftF = facing(frontLegM, 365, 220, 18)
work(frontLegM - cowboyTorso, {hand="body", tool={kind="filbert", width=8}, piles={
    {trouserP, 1}, {wallMid, function(x, y) return 0.7 * ftF(x, y) end}},
  coverage=2.5, fill=true, clip=frontLegM - cowboyTorso, angle=function(x, y) return y < 585 and 0.6 or 1.57 end, angle_jitter=0.15, length={20, 45}})
work(bootBackM + bootFrontM, {hand="detail", tool={kind="filbert", width=6}, piles={{bootP, 1}, {warmD, 0.3}},
  coverage=3, fill=true, clip=bootBackM + bootFrontM, angle=0.2, angle_jitter=0.3, length={10, 25}})

--@ chunk 38
for _, p in ipairs({{650, 250}, {700, 280}, {690, 400}, {700, 520}, {760, 400}, {900, 500}, {950, 250}, {400, 300}, {250, 150}, {500, 200}, {600, 620}, {100, 650}, {800, 650}}) do
  print(p[1], p[2], drying(p[1], p[2]))
end

--@ chunk 39
print(wait(2 * 24 * 60))
for _, p in ipairs({{650, 250}, {700, 280}, {690, 400}, {700, 520}, {760, 400}, {900, 500}, {950, 250}, {400, 300}, {250, 150}, {500, 200}, {600, 620}, {100, 650}, {800, 650}, {250, 450}, {440, 550}, {200, 600}, {280, 310}}) do
  print(p[1], p[2], drying(p[1], p[2]))
end

--@ chunk 40
print(wait(6 * 24 * 60))
local pts = {{650, 250}, {700, 280}, {690, 400}, {700, 520}, {950, 250}, {400, 300}, {500, 200}, {600, 620}, {100, 650}, {800, 650}, {250, 450}, {440, 550}, {200, 600}, {280, 310}, {320, 420}, {365, 200}}
for _, p in ipairs(pts) do
  print(p[1], p[2], drying(p[1], p[2]))
end

--@ chunk 41
palette{scrape={skinD}}
gE = pile{{"bone black", 1}, {"raw umber", 1}, {"burnt sienna", 0.5}, medium=0.3, name="glazeDk"}
function lampL(x, y)
  local d = math.sqrt((x - 365)^2 + ((y - 250) * 1.1)^2)
  local up = smoothstep(150, 200, y)   -- the shade cuts the light above it
  return (1 - smoothstep(50, 260, d)) * (0.35 + 0.65 * up)
end
local keep = doorM:grow(16) + (cowboyM + tableM + gunM):grow(2) + rect(320, 160, 95, 80)
local room = (backM + leftwallM + rightwallM + barM) - keep
g1 = room * mask(function(x, y) return 1 - smoothstep(0.15, 0.35, lampL(x, y)) end)
work(g1, {hand="glaze", pile=gE, coverage=1, angle=0})

--@ chunk 42
local keep = doorM:grow(16) + (cowboyM + tableM + gunM):grow(2) + rect(320, 160, 95, 80)
local ring = mask(function(x, y) local l = lampL(x, y) return smoothstep(0.05, 0.2, l) * (1 - smoothstep(0.35, 0.5, l)) end) - keep
blend(ring, {angle=0.6})
blend(ring, {angle=-0.6})

--@ chunk 43
palette{scrape={trouserP, bootP, vestP, hatP}}
brassP = pile{{"yellow ochre", 2}, {"raw sienna", 1}, {"raw umber", 0.4}, name="brass"}
barWood = pile{{"raw umber", 1.2}, {"burnt sienna", 1}, {"bone black", 0.5}, name="barWood"}
-- the bar's front face: receding panels
local vp = {650, 400}
local function topAt(x) return 380 + (358 - 380) * (x - 821) / 179 end
local function botAt(x) return 604 + (x - 821) * 1.19 end
barFront = barM
work(barFront, {hand="body", tool={kind="filbert", width=10}, piles={{barWood, 1}, {deepD, function(x, y) return 0.4 + 0.6 * smoothstep(500, 700, y) end}},
  coverage=2, fill=true, clip=barFront, angle=1.57, angle_jitter=0.05, length={30, 70}})
-- panel stiles: verticals spaced in perspective
local sb = brush{kind="flat", width=4}
local xs = {832, 850, 874, 906, 948, 1000}
for i, x in ipairs(xs) do
  sb:load(deepD, 0.6)
  sb:stroke({{x, topAt(x) + 22}, {x, math.min(botAt(x) - 20, 748)}}, {pressure=0.6})
end
-- the counter's top lip catching warm light
local lb = brush{kind="flat", width=5}
lb:load(wallMid, 0.7)
lb:stroke({{822, 381}, {910, 370}, {1000, 358}}, {pressure=0.7})
lb:load(wallHi, 0.5)
lb:stroke({{824, 378}, {900, 369}, {990, 357}}, {pressure=0.35})
-- the shadow under the overhang
local ub = brush{kind="flat", width=8}
ub:load(deepD, 0.7)
ub:stroke({{822, 392}, {910, 382}, {1000, 371}}, {pressure=0.6})
-- brass foot rail
local rb = brush{kind="round", width=4, point=0.3}
rb:load(brassP, 0.7)
rb:stroke({{823, 575}, {900, 640}, {1000, 724}}, {pressure=0.6})
rb:load(wallHi, 0.4)
rb:stroke({{825, 573}, {870, 610}}, {pressure=0.35})

--@ chunk 44
local k = knife{width=10}
k:scrape({{823, 575}, {900, 640}, {1000, 724}}, {pressure=0.8})
k:wipe()
local sb = brush{kind="filbert", width=10}
sb:load(barWood, 0.6)
sb:stroke({{825, 572}, {900, 640}, {1000, 726}}, {pressure=0.6})
blend(barM:shrink(4) - ribbon({{822, 381}, {1000, 358}}, 30), {angle=1.57})
local rb = brush{kind="round", width=4, point=0.3}
rb:load(brassP, 0.7)
rb:stroke({{823, 578}, {900, 656}, {990, 747}}, {pressure=0.6})
rb:load(wallHi, 0.4)
rb:stroke({{825, 576}, {880, 632}}, {pressure=0.3})

--@ chunk 45
for _, p in ipairs({{600, 620}, {450, 650}, {700, 600}, {150, 700}, {800, 700}, {300, 600}, {500, 720}}) do
  print(p[1], p[2], drying(p[1], p[2]))
end

--@ chunk 46
jointWarm = pile{{"burnt sienna", 1}, {"raw umber", 1.2}, medium=0.15, name="jointWarm"}
local figs = (cowboyM + tableM + gunM):grow(1) + barM
local fl = floorM - figs
local inSpill = (spillM * fl)
local inDark = fl - spillM
local rb = brush{kind="rigger", width=2.2, point=0.6}
math.randomseed(7)
for i = 0, 31 do
  local xb = 200 + 22 * i + rand(-2, 2)
  local pts = {}
  for k = 0, 6 do
    local y = 562 + k * (750 - 562) / 6
    local x = xb + (xb - 650) * (y - 560) / 160 + randn(0, 0.6)
    pts[#pts + 1] = {x, y}
  end
  rb:load(jointWarm, 0.6)
  rb:stroke(pts, {pressure={0.35, 0.75}, ramps={0.05, 0.05}, clip=inSpill})
  rb:load(deepD, 0.5)
  rb:stroke(pts, {pressure={0.3, 0.6}, ramps={0.05, 0.05}, clip=inDark})
end

--@ chunk 47
local base = {700, 563}
local tip = {572, 643}
local function P(t, off)
  -- off: lateral offset in units (perpendicular in screen space to the axis)
  local ax, ay = tip[1] - base[1], tip[2] - base[2]
  local l = math.sqrt(ax * ax + ay * ay)
  local nx, ny = -ay / l, ax / l
  return {base[1] + ax * t + nx * off, base[2] + ay * t + ny * off}
end
local legA = ribbon({{664, 571}, P(0.25, -6), P(0.45, -4)}, {9, 8, 10})
local legB = ribbon({{734, 558}, P(0.22, 10), P(0.45, 5)}, {9, 9, 10})
local torso = ribbon({P(0.43, 0), P(0.6, 0), P(0.78, 0)}, {20, 24, 22})
local neck = ribbon({P(0.78, 0), P(0.86, -1)}, {9, 8})
local head = ribbon({P(0.86, -1), P(0.96, -2)}, {15, 13})
local arm1 = ribbon({P(0.74, -10), {562, 650}, {532, 664}}, {7, 6, 4})
local arm2 = ribbon({P(0.74, 10), {578, 630}, {541, 645}}, {7, 6, 4})
zShadow = (legA + legB + torso + neck + head + arm1 + arm2):roughen(1.5, 8, 21) * spillM
local shP = mix{{floorDk, 0.6}, {wallMid, 0.4}, name="zshadow"}
work(zShadow, {hand="detail", tool={kind="round", width=4}, pile=shP, coverage=3, fill=true, clip=zShadow, angle=-0.55, angle_jitter=0.2, length={6, 18}})

--@ chunk 48
local m = zShadow:grow(3)
for i = 1, 3 do
  local r = rag{width=14}
  r:dip(0.95)
  r:wipe(m, {pressure=0.85, angle=(i % 2 == 1) and -0.55 or 1.0, passes=2, refold=0.3})
end

--@ chunk 49
local trail = ribbon({{585, 563}, {560, 580}, {520, 610}, {470, 650}, {452, 664}}, {16, 22, 26, 24, 16}) * spillM:shrink(1)
local hip = {647, 594}
local sh = {604, 622}
local hd = {573, 641}
local legA = ribbon({{660, 569}, {652, 583}, hip}, {12, 13, 18})
local legB = ribbon({{737, 557}, {700, 572}, hip}, {12, 14, 18})
local torso = poly({{638, 584}, {664, 600}, {620, 634}, {588, 614}}, true)
local head = ellipse(574, 640, 14, 10)
local neck = ribbon({sh, {582, 636}}, 12)
local arm1 = ribbon({{596, 616}, {556, 628}, {522, 646}}, {11, 9, 7})
local arm2 = ribbon({{614, 630}, {572, 646}, {532, 664}}, {11, 9, 7})
zShadow = (legA + legB + torso + head + neck + arm1 + arm2):roughen(2, 10, 31) * spillM
local patch = trail - zShadow:grow(1)
work(patch, {hand="detail", tool={kind="round", width=5}, pile=floorLit, coverage=3, fill=true, clip=patch, angle=-0.95, length={8, 20}})
local shP2 = mix{{floorDk, 0.55}, {wallMid, 0.45}, name="zshadow2"}
local soft = zShadow:blur(1.5)
work(soft, {hand="detail", tool={kind="round", width=4}, pile=shP2, coverage=3, fill=true, clip=soft, angle=-1.0, angle_jitter=0.2, length={6, 16}})

--@ chunk 50
local trail = ribbon({{585, 563}, {560, 580}, {520, 610}, {470, 650}, {452, 664}}, {16, 22, 26, 24, 16}):grow(3)
local m = trail * tableM:grow(1)
print(m:area(), drying(500, 620), drying(470, 640))
for i = 1, 4 do
  local r = rag{width=10}
  r:dip(0.95)
  r:wipe(m, {pressure=0.9, angle=(i % 2 == 1) and -0.9 or 0.7, passes=2, refold=0.25})
end

--@ chunk 51
palette{scrape={sleeveP}}
woodP = pile{{"burnt sienna", 1}, {"raw umber", 1.2}, {"yellow ochre", 0.4}, {"bone black", 0.15}, name="wood"}
local trail = ribbon({{585, 563}, {560, 580}, {520, 610}, {470, 650}, {452, 664}}, {16, 22, 26, 24, 16}):grow(5)
local face = (trail * tableFace):soften(3)
work(face, {hand="detail", tool={kind="flat", width=6}, pile=woodP, coverage=3, fill=true, clip=face, angle=1.57, angle_jitter=0.05, length={15, 40}})
local rim = trail * tableRim:grow(2)
work(rim, {hand="detail", tool={kind="round", width=3}, piles={{deepD, 1}, {floorDk, 1}}, coverage=3, fill=true, clip=rim, angle=1.2, length={6, 15}})
-- restore the plank joints that ran through
local jb = brush{kind="round", width=1.6, point=0.6}
for _, x in ipairs({474, 500}) do
  jb:load(deepD, 0.5)
  local top = 440 + math.abs(x - 446) * 0.6
  local bot = 690 - math.abs(x - 446) * 0.75
  jb:stroke({{x, top}, {x - 2, (top + bot) / 2}, {x - 5, bot}}, {pressure={0.5, 0.35}, ramps={0.15, 0.25}, clip=trail})
end

--@ chunk 52
print(wait(3 * 24 * 60))
local pts = {{650, 250}, {690, 300}, {640, 330}, {700, 400}, {620, 420}, {600, 620}, {500, 620}, {480, 300}, {540, 380}, {300, 330}, {250, 450}, {365, 200}, {700, 500}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 53
local keep = doorM:grow(8) + (cowboyM + tableM + gunM):grow(3) + rect(320, 150, 95, 95)
local g2 = (backM - keep) * mask(function(x, y) return smoothstep(450, 520, x) end) * rect(200, 0, 680, 560)
work(g2, {hand="glaze", pile=gE, coverage=1, angle=1.57})
local g3 = (backM - keep) * mask(function(x, y) return smoothstep(515, 560, x) end) * rect(200, 0, 680, 560)
work(g3, {hand="glaze", pile=gE, coverage=1, angle=1.57})

--@ chunk 54
local keep = doorM:grow(8) + (cowboyM + tableM + gunM):grow(3) + rect(320, 150, 95, 95)
local band = (rect(440, 0, 90, 560) - keep):soften(12)
blend(band, {angle=0.0})
blend(band, {angle=0.4})
local band2 = (rect(500, 0, 75, 560) - keep):soften(10)
blend(band2, {angle=-0.3})

--@ chunk 55
-- new cowboy design (hunched, leaning into the shot)
nHat = crownM + brimM
nHead = poly({{246, 352}, {244, 368}, {250, 382}, {262, 392}, {280, 398}, {296, 396}, {306, 388}, {310, 378}, {318, 372}, {314, 364}, {314, 352}}, true)
nNeck = poly({{258, 386}, {300, 392}, {304, 410}, {262, 412}}, true)
nTorso = poly({{252, 394}, {226, 400}, {204, 414}, {190, 438}, {184, 470}, {186, 505}, {196, 532}, {210, 552}, {286, 556}, {300, 528}, {308, 494}, {316, 456}, {320, 424}, {312, 404}, {290, 396}}, true)
nArmR = ribbon({{300, 410}, {350, 418}, {400, 421}, {446, 416}}, {30, 25, 21, 17})
nHandR = poly({{438, 404}, {456, 400}, {468, 404}, {470, 414}, {462, 426}, {448, 428}, {438, 420}}, true)
nArmL = ribbon({{214, 420}, {236, 456}, {258, 482}}, {32, 28, 24}) + ribbon({{258, 482}, {306, 480}, {350, 470}}, {24, 20, 17})
nHandL = poly({{346, 458}, {362, 452}, {376, 458}, {378, 474}, {366, 484}, {350, 482}, {344, 472}}, true)
nGun = ribbon({{466, 404}, {530, 398}}, {6, 5}) + poly({{454, 398}, {482, 396}, {484, 412}, {458, 414}}, true) + ribbon({{460, 412}, {466, 432}}, {9, 8})
nLegs = legsM
newCowboy = nHat + nHead + nNeck + nTorso + nArmR + nHandR + nArmL + nHandL + nLegs
print(newCowboy:area())

--@ chunk 56
nHandL = poly({{362, 458}, {378, 452}, {390, 458}, {392, 474}, {380, 484}, {366, 482}, {360, 472}}, true)
nArmL = ribbon({{214, 420}, {236, 456}, {258, 482}}, {32, 28, 24}) + ribbon({{258, 482}, {310, 479}, {366, 470}}, {24, 20, 17})
newCowboy = nHat + nHead + nNeck + nTorso + nArmR + nHandR + nArmL + nHandL + nLegs
oldOnly = (cowboyM + gunM):grow(2) - newCowboy - nGun
for _, p in ipairs({{150, 400}, {175, 480}, {200, 385}, {330, 380}, {335, 470}, {330, 520}, {180, 570}, {150, 600}, {420, 400}, {480, 440}}) do
  print(p[1], p[2], oldOnly:at(p[1], p[2]))
end

--@ chunk 57
palette{scrape={jointWarm}}
poolMid = pile{{"raw umber", 1}, {"burnt sienna", 0.8}, {"yellow ochre", 1.4}, {"lead white", 0.15}, name="poolMid"}
local wallPart = oldOnly * (rect(0, 0, 1000, 560) + leftwallM)
local function pool(x, y)
  local d = math.sqrt((x - 365)^2 + ((y - 260) * 1.1)^2)
  return 1 - smoothstep(120, 230, d)
end
work(wallPart, {hand="detail", tool={kind="filbert", width=6}, piles={
    {poolMid, function(x, y) return pool(x, y) * 1.5 end},
    {warmD, function(x, y) return (1 - pool(x, y)) end},
    {wallDk, function(x, y) return (1 - pool(x, y)) * 0.4 end}},
  coverage=3, fill=true, clip=wallPart, angle=function(x, y) return x < 200 and 1.57 or 0 end, angle_jitter=0.1, length={10, 30}})

--@ chunk 58
palette{scrape={floorLit, brassP, barWood, woodP, poolMid, shP, shP2}}
print(#palette())

--@ chunk 59
print(palette())

--@ chunk 60
shirtDk = pile{{"Indian red", 1}, {"raw umber", 0.8}, {"bone black", 0.3}, name="shirtDk"}
shirtMid = pile{{"Indian red", 1}, {"red earth", 0.6}, {"raw umber", 0.2}, name="shirtMid"}
shirtLit = pile{{"red earth", 1}, {"vermilion", 0.4}, {"yellow ochre", 0.5}, {"lead white", 0.35}, name="shirtLit"}
trMid = pile{{"raw umber", 1}, {"bone black", 0.5}, {"lead white", 0.35}, {"ultramarine blue", 0.15}, {"yellow ochre", 0.3}, name="trMid"}
skinMid = pile{{"red earth", 1}, {"yellow ochre", 1}, {"raw umber", 0.4}, {"lead white", 0.4}, name="skinMid"}

--@ chunk 61
vestM2 = nTorso - nArmL:grow(1)
work(vestM2, {hand="body", tool={kind="filbert", width=8}, piles={{deepD, 1}, {warmD, 0.7}}, coverage=2.5, fill=true, clip=vestM2,
  angle=function(x, y) return 1.35 + (x - 250) / 400 end, angle_jitter=0.2, length={15, 40}})
-- lamp-lit plane across the top of the shoulders and down the side facing the light
vestLitM = poly({{232, 400}, {262, 394}, {292, 396}, {312, 404}, {320, 424}, {316, 456}, {308, 492}, {300, 520}, {292, 522}, {298, 484}, {300, 446}, {294, 418}, {270, 410}, {244, 410}}, true):roughen(2, 10, 3) * vestM2
work(vestLitM, {hand="detail", tool={kind="filbert", width=6}, piles={{warmD, 1}, {wallMid, 0.7}}, coverage=3, fill=true, clip=vestLitM,
  angle=function(x, y) return y < 412 and 0.1 or 1.5 end, angle_jitter=0.2, length={8, 20}})

--@ chunk 62
local m = vestM2:grow(1)
for i = 1, 3 do
  local r = rag{width=20}
  r:dip(0.95)
  r:wipe(m, {pressure=0.85, angle=(i % 2 == 1) and 1.4 or 0.2, passes=2, refold=0.3})
end

--@ chunk 63
palette{scrape={floorDk, gE}}
vestDk = pile{{"bone black", 1}, {"burnt sienna", 0.7}, {"raw umber", 1}, name="vestDk"}
work(vestM2, {hand="body", tool={kind="filbert", width=9}, piles={{vestDk, 1}, {warmD, 0.25}}, coverage=3, fill=true, clip=vestM2,
  angle=function(x, y) return 1.35 + (x - 250) / 400 end, angle_jitter=0.25, length={15, 45}})
local g = brush{kind="filbert", width=6}
g:load(warmD, 0.7)
g:gesture({{238, 404, 0.3}, {262, 398, 0.7}, {292, 399, 0.8}, {310, 408, 0.6}, {317, 424, 0.3}}, {clip=vestM2})
g:load(wallMid, 0.6)
g:gesture({{252, 400, 0.2}, {275, 397, 0.5}, {298, 400, 0.6}, {310, 409, 0.3}}, {clip=vestM2})
g:load(warmD, 0.5)
g:gesture({{300, 440, 0.2}, {305, 470, 0.4}, {298, 505, 0.1}}, {clip=vestM2})
g:gesture({{230, 430, 0.1}, {236, 455, 0.3}, {240, 476, 0.1}}, {clip=vestM2})

--@ chunk 64
-- near arm: upper arm down the side, forearm forward to the table rim
local upper = ribbon({{214, 420}, {236, 456}, {258, 482}}, {32, 28, 24})
local fore = ribbon({{258, 482}, {310, 479}, {366, 470}}, {24, 20, 17})
local armL = (upper + fore) - nHandL
work(armL, {hand="detail", tool={kind="filbert", width=6}, piles={{shirtDk, 1}, {shirtMid, 0.35}}, coverage=3, fill=true, clip=armL,
  angle=function(x, y) return x < 255 and 1.0 or 0.05 end, angle_jitter=0.2, length={8, 22}})
-- top planes catching the lamp
local g = brush{kind="filbert", width=5}
g:load(shirtMid, 0.7)
g:gesture({{206, 412, 0.3}, {222, 410, 0.6}, {236, 418, 0.5}, {248, 440, 0.3}}, {clip=armL})
g:load(shirtMid, 0.7)
g:gesture({{262, 472, 0.3}, {300, 470, 0.6}, {340, 465, 0.6}, {362, 461, 0.3}}, {clip=armL})
g:load(shirtLit, 0.5)
g:gesture({{280, 470, 0.2}, {315, 468, 0.45}, {350, 463, 0.3}}, {clip=armL})
-- extended gun arm
local armR = nArmR - nHandR - vestM2
work(armR, {hand="detail", tool={kind="filbert", width=6}, piles={{shirtMid, 1}, {shirtDk, 0.5}}, coverage=3, fill=true, clip=armR,
  angle=0.08, angle_jitter=0.1, length={10, 30}})
g:load(shirtDk, 0.7)
g:gesture({{305, 424, 0.5}, {350, 430, 0.6}, {400, 431, 0.5}, {440, 424, 0.3}}, {clip=armR})
g:load(shirtLit, 0.7)
g:gesture({{306, 400, 0.4}, {340, 406, 0.6}, {380, 410, 0.55}, {420, 410, 0.4}, {444, 408, 0.2}}, {clip=armR})

--@ chunk 65
palette{scrape={glowW}}
hairP = pile{{"bone black", 1}, {"raw umber", 1.5}, {"burnt sienna", 0.3}, name="hair"}
local hairM = poly({{244, 352}, {276, 352}, {272, 364}, {266, 380}, {262, 392}, {250, 384}, {244, 368}}, true)
local skinM = nHead - hairM
work(hairM, {hand="detail", tool={kind="round", width=4}, pile=hairP, coverage=3, fill=true, clip=hairM, angle=1.75, angle_jitter=0.3, length={6, 14}})
local fh = facing(nHead, 400, 250, 10)
work(skinM, {hand="detail", tool={kind="round", width=4}, piles={{skinMid, function(x, y) return 0.3 + fh(x, y) end}, {warmD, function(x, y) return 0.6 * (1 - fh(x, y)) + 0.6 * smoothstep(368, 354, y) end}},
  coverage=3, fill=true, clip=skinM, angle=1.4, angle_jitter=0.3, length={6, 14}})
-- neck shadow + bandana
local neckM = nNeck - nTorso:shrink(2) - nHead
work(neckM, {hand="detail", tool={kind="round", width=4}, pile=warmD, coverage=3, fill=true, clip=neckM, angle=0, length={6, 14}})
local band = poly({{266, 396}, {304, 394}, {314, 404}, {298, 412}, {270, 410}}, true)
work(band, {hand="detail", tool={kind="round", width=3}, piles={{shirtDk, 0.6}, {shirtMid, 1}}, coverage=3, fill=true, clip=band, angle=0.1, length={5, 12}})

--@ chunk 66
palette{scrape={hairP}}
woodP = pile{{"burnt sienna", 1}, {"raw umber", 1.2}, {"yellow ochre", 0.4}, {"bone black", 0.15}, name="wood"}
local front = (nHandL + bootFrontM + nArmL + nTorso):grow(1)
leg1M = (ribbon({{492, 452}, {446, 454}, {388, 458}}, {12, 13, 15}) + ellipse(495, 452, 5, 7)) - front
leg2M = (ribbon({{488, 664}, {440, 672}, {392, 682}}, {13, 15, 17}) + ellipse(491, 663, 5, 8)) - front
local legs = leg1M + leg2M
work(legs, {hand="detail", tool={kind="round", width=4}, piles={{woodP, 1}, {vestDk, 0.5}}, coverage=3, fill=true, clip=legs, angle=0.0, angle_jitter=0.05, length={10, 30}})
-- lamp catches the top of each leg; underside in shadow
local g = brush{kind="round", width=3, point=0.4}
g:load(wallMid, 0.7)
g:gesture({{488, 447, 0.2}, {450, 448, 0.6}, {398, 451, 0.6}}, {clip=leg1M})
g:load(wallHi, 0.5)
g:gesture({{470, 447, 0.1}, {440, 448, 0.4}, {404, 450, 0.3}}, {clip=leg1M})
g:load(vestDk, 0.6)
g:gesture({{490, 458, 0.3}, {440, 461, 0.6}, {398, 465, 0.6}}, {clip=leg1M})
g:load(wallMid, 0.6)
g:gesture({{484, 658, 0.2}, {440, 665, 0.5}, {402, 674, 0.5}}, {clip=leg2M})
g:load(vestDk, 0.6)
g:gesture({{486, 670, 0.3}, {440, 679, 0.6}, {404, 689, 0.6}}, {clip=leg2M})

--@ chunk 67
local ok, e = pcall(function() return pile{name="zshadow"} end)
print(ok, e)

--@ chunk 68
local ok, e = pcall(function() return palette{scrape={"zshadow"}} end)
print(ok, e)
local ok2, e2 = pcall(function() return palette{scrape={11}} end)
print(ok2, e2)
for k, v in pairs(_G) do
  if type(v) == "userdata" or type(v) == "table" then
    local s = tostring(v)
    if s:find("zshadow") then print(k, s) end
  end
end

--@ chunk 69
local t = palette()
print(type(t))
local ok, r = pcall(function() return palette{list=true} end)
print(ok, type(r), r)
local ok3, r3 = pcall(function() return piles end)
print(ok3, type(r3))

--@ chunk 70
palette{scrape={trMid, vestDk}}
gunMetal = pile{{"bone black", 1}, {"ultramarine blue", 0.2}, {"raw umber", 0.3}, name="gunMetal"}
handR = poly({{436, 404}, {452, 399}, {466, 402}, {472, 410}, {468, 422}, {456, 428}, {442, 426}, {434, 416}}, true)
work(handR, {hand="detail", tool={kind="round", width=3}, piles={{skinMid, 1}, {warmD, function(x, y) return smoothstep(410, 428, y) * 0.8 end}}, coverage=3, fill=true, clip=handR, angle=0.3, length={4, 10}})
local barrel = ribbon({{468, 402}, {532, 397}}, {5, 4.5})
local cyl = poly({{462, 397}, {480, 396}, {481, 408}, {463, 409}}, true)
local hammer = poly({{458, 395}, {464, 391}, {467, 397}}, true)
revolverM = barrel + cyl + hammer
work(revolverM, {hand="detail", tool={kind="round", width=2.2}, pile=gunMetal, coverage=4, fill=true, clip=revolverM, angle=-0.08, length={6, 20}})
local g = brush{kind="round", width=1.6, point=0.6}
g:load(wallHi, 0.6)
g:stroke({{482, 398}, {530, 394.5}}, {pressure={0.4, 0.6}})
g:load(wallMid, 0.6)
g:stroke({{464, 398}, {478, 397}}, {pressure=0.4})
g:load(shirtLit, 0.6)
g:stroke({{456, 402}, {466, 404}, {470, 412}}, {pressure=0.5})

--@ chunk 71
local oldArm = (ribbon({{318, 410}, {395, 434}, {462, 424}}, {36, 27, 19}) + ellipse(472, 422, 15, 12) + ribbon({{470, 414}, {545, 406}}, 9) + ribbon({{468, 426}, {478, 446}}, 11)):grow(2)
local front = (nArmR + handR + revolverM + leg1M + nTorso + nArmL + nHandL):grow(0.5)
residueWall = oldArm - front - tableM
residueTable = (oldArm * tableM) - front
local function lit(x, y) return 1 - smoothstep(400, 470, x) end
work(residueWall, {hand="detail", tool={kind="filbert", width=5}, piles={
    {wallMid, function(x, y) return lit(x, y) * 1.0 end},
    {wallHi, function(x, y) return lit(x, y) * 0.5 end},
    {warmD, function(x, y) return (1 - lit(x, y)) * 0.6 end},
    {wallDk, function(x, y) return (1 - lit(x, y)) * 0.8 end}},
  coverage=3, fill=true, clip=residueWall, angle=0.0, angle_jitter=0.15, length={8, 20}})
print(residueWall:area(), residueTable:area())

--@ chunk 72
local m = residueWall * rect(470, 380, 90, 80)
work(m, {hand="detail", tool={kind="filbert", width=5}, piles={{wallDk, 1}, {deepD, 0.4}, {warmD, 0.3}}, coverage=3, fill=true, clip=m, angle=0.0, angle_jitter=0.2, length={8, 20}})
local front = (nArmR + handR + revolverM + leg1M + nTorso + tableM):grow(2)
local b = (rect(470, 375, 110, 85) - front):soften(6)
blend(b, {angle=0.5})

--@ chunk 73
local oldFig = (cowboyM + gunM):grow(4)
local band = (oldFig - newCowboy:grow(0.5) - tableM - revolverM - handR) * rect(0, 280, 470, 300)
local bandL = band * mask(function(x, y) return x < 330 and 1 or 0 end)
work(bandL, {hand="detail", tool={kind="filbert", width=5}, piles={{wallDk, 1}, {deepD, 0.25}, {warmD, function(x, y) return smoothstep(380, 330, y) * 0.8 end}},
  coverage=3, fill=true, clip=bandL, angle=function(x, y) return x < 200 and 1.57 or 0 end, angle_jitter=0.15, length={8, 20}})

--@ chunk 74
local oldFig = (cowboyM + gunM):grow(4)
local band = (oldFig - newCowboy:grow(0.5) - tableM - revolverM - handR) * rect(0, 280, 330, 300)
local bm = (band:grow(6) - newCowboy:grow(1.5)):soften(5)
blend(bm, {angle=0.3})
blend(bm, {angle=-0.9})

--@ chunk 75
print(wait(4 * 24 * 60))
local pts = {{250, 470}, {300, 410}, {400, 425}, {300, 475}, {275, 380}, {260, 320}, {300, 620}, {200, 640}, {450, 550}, {470, 455}, {500, 398}, {150, 450}, {130, 720}, {360, 690}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 76
local pts = {{650, 300}, {640, 330}, {660, 320}, {600, 330}, {620, 360}, {700, 400}, {670, 500}, {730, 540}, {750, 400}, {760, 320}, {620, 250}, {700, 260}, {640, 450}, {365, 180}, {365, 205}, {365, 228}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 77
palette{scrape={gunMetal}}
zombP = pile{{"bone black", 1}, {"raw umber", 1.2}, {"green earth", 1.2}, name="zomb"}
-- carve light into the head: mouth gap under the upper jaw, the hollow under the chin, a notch at the brow
local cut = poly({{632, 333}, {645, 335}, {650, 339}, {642, 340}, {631, 338}}, true)
  + poly({{646, 351}, {652, 350}, {654, 357}, {648, 360}}, true)
  + poly({{676, 300}, {682, 304}, {684, 312}, {680, 316}, {677, 309}}, true)
local cb = brush{kind="round", width=3, point=0.3, lay=2}
work(cut, {hand="detail", tool={kind="round", width=2.5, lay=2}, pile=skyP, coverage=4, fill=true, clip=cut, angle=0, length={3, 8}})
-- add the hanging jaw, the jutting brow, nose
local add = poly({{638, 338}, {648, 340}, {652, 347}, {646, 352}, {640, 349}}, true)
  + poly({{638, 312}, {646, 310}, {646, 318}, {636, 318}}, true)
  + poly({{634, 322}, {642, 322}, {642, 330}, {632, 328}}, true)
work(add, {hand="detail", tool={kind="round", width=2.5}, pile=zombP, coverage=4, fill=true, clip=add, angle=0, length={3, 8}})
-- straggly hair: a few thin strokes off the crown
local hb = brush{kind="rigger", width=1.4, point=0.8}
local hairs = {{{668, 298}, {676, 290}, {684, 288}}, {{676, 304}, {688, 300}, {694, 304}}, {{660, 296}, {662, 286}, {668, 280}},
  {{680, 314}, {690, 318}, {694, 326}}, {{652, 298}, {648, 290}}}
for _, h in ipairs(hairs) do
  hb:load(zombP, 0.5)
  hb:stroke(h, {pressure={0.6, 0.05}, ramps={0.05, 0.6}})
end

--@ chunk 78
local m = (ribbon({{668, 298}, {676, 290}, {684, 288}}, 5) + ribbon({{676, 304}, {688, 300}, {694, 304}}, 5) + ribbon({{660, 296}, {662, 286}, {668, 280}}, 5)
  + ribbon({{680, 314}, {690, 318}, {694, 326}}, 5) + ribbon({{652, 298}, {648, 290}}, 5)
  + poly({{630, 331}, {646, 333}, {652, 340}, {642, 342}, {629, 340}}, true)
  + poly({{676, 300}, {682, 304}, {684, 312}, {680, 316}, {677, 309}}, true):grow(2))
for i = 1, 3 do
  local r = rag{width=8}
  r:dip(0.95)
  r:wipe(m, {pressure=0.9, angle=(i % 2 == 1) and 0 or 1.57, passes=2, refold=0.2})
end

--@ chunk 79
local cut = poly({{684, 317}, {692, 321}, {703, 331}, {688, 334}, {684, 328}}, true)
  + poly({{635, 292}, {652, 292}, {646, 300}, {640, 308}, {636, 310}}, true)
work(cut, {hand="detail", tool={kind="round", width=2.5, lay=2}, pile=skyP, coverage=4, fill=true, clip=cut, angle=0.5, length={3, 8}})
local add = poly({{633, 318}, {641, 315}, {642, 325}, {634, 324}}, true)
  + poly({{637, 310}, {646, 307}, {646, 314}, {637, 314}}, true)
work(add, {hand="detail", tool={kind="round", width=2.2}, pile=zombP, coverage=4, fill=true, clip=add, angle=0, length={3, 6}})
-- limp hair hanging from the back of the skull
local hb = brush{kind="rigger", width=1.6, point=0.6}
local hairs = {{{676, 300}, {684, 308}, {686, 318}}, {{680, 306}, {688, 314}, {690, 324}}, {{668, 296}, {678, 300}, {684, 306}}}
for _, h in ipairs(hairs) do
  hb:load(zombP, 0.6)
  hb:stroke(h, {pressure={0.7, 0.1}, ramps={0.05, 0.5}})
end

--@ chunk 80
local ghost = (ribbon({{668, 296}, {676, 288}, {686, 286}}, 4) + ribbon({{660, 294}, {662, 284}, {670, 278}}, 4) + ribbon({{652, 296}, {648, 288}}, 4)) - zombieM:shrink(1)
work(ghost, {hand="detail", tool={kind="round", width=2.5, lay=2}, pile=skyP, coverage=4, fill=true, clip=ghost, angle=0.3, length={3, 8}})
local arm = poly({{628, 330}, {648, 332}, {652, 340}, {640, 342}, {627, 340}}, true)
work(arm, {hand="detail", tool={kind="round", width=2.5}, pile=zombP, coverage=4, fill=true, clip=arm, angle=0, length={3, 8}})

--@ chunk 81
louverP = mix{{skyP, 0.55}, {wallHi, 0.45}, name="louver"}
local panel = poly({{729, 346}, {784, 338}, {784, 482}, {729, 486}}) - zombieM:grow(1)
local lb = brush{kind="round", width=1.8, point=0.3}
for i = 0, 19 do
  local yL = 350 + i * 6.8
  local yR = 343 + i * 7.0
  if yL < 484 then
    lb:load(louverP, 0.5)
    lb:stroke({{729, yL}, {784, yR}}, {pressure={0.55, 0.45}, ramps={0.02, 0.02}, clip=panel})
  end
end
-- frame edges catching a little light: the free edge of the leaf and the top rail
local eb = brush{kind="round", width=2, point=0.3}
eb:load(louverP, 0.5)
eb:stroke({{723, 333}, {742, 328}, {766, 318}, {789, 312}}, {pressure=0.5, clip=leafR - zombieM})
eb:load(wallMid, 0.5)
eb:stroke({{724, 340}, {724, 495}}, {pressure=0.4, clip=leafR - zombieM})

--@ chunk 82
palette{scrape={woodP, zombP}}
woodLt = pile{{"burnt sienna", 1}, {"yellow ochre", 1}, {"raw umber", 0.6}, name="woodLt"}
woodDk = pile{{"burnt sienna", 1}, {"raw umber", 1.4}, {"bone black", 0.35}, name="woodDk"}
local front = (newCowboy + handR + revolverM):grow(1)
local face = tableFace - front - leg1M - leg2M
local function lt(x, y) return smoothstep(640, 430, y) * 0.9 end
tableVP = {1500, 400}
work(face, {hand="body", tool={kind="flat", width=7}, piles={{woodLt, function(x, y) return 0.2 + lt(x, y) end}, {woodDk, function(x, y) return 0.4 + (1 - lt(x, y)) end}},
  coverage=2.5, fill=true, clip=face, angle=function(x, y) return math.atan(tableVP[2] - y, tableVP[1] - x) end, angle_jitter=0.03, length={30, 80}, mix_jitter=0.06})

--@ chunk 83
local front = (newCowboy + handR + revolverM):grow(1)
local face = tableFace - front - leg1M - leg2M
local jb = brush{kind="round", width=1.5, point=0.6}
for i = 1, 9 do
  local y0 = 430 + i * 28
  local function yat(x) return y0 + (tableVP[2] - y0) * (x - 355) / (tableVP[1] - 355) end
  jb:load(woodDk, 0.5)
  jb:stroke({{355, yat(355)}, {450, yat(450)}, {540, yat(540)}}, {pressure={0.45, 0.35}, ramps={0.05, 0.05}, clip=face})
end
local function batten(x0, x1)
  return poly({{x0, 440}, {x0 + 12, 440}, {x1 + 12, 690}, {x1, 690}})
end
battenA = batten(398, 392) * face
battenB = batten(470, 466) * face
local bm = battenA + battenB
work(bm, {hand="detail", tool={kind="flat", width=5}, piles={{woodDk, 1}, {woodLt, 0.4}}, coverage=3, fill=true, clip=bm, angle=1.6, length={15, 40}})
local eb = brush{kind="round", width=2, point=0.4}
for _, x in ipairs({398, 470}) do
  eb:load(woodLt, 0.6)
  eb:stroke({{x + 1, 445}, {x - 2, 560}, {x - 5, 680}}, {pressure={0.55, 0.3}, clip=face})
  eb:load(deepD, 0.5)
  eb:stroke({{x + 13, 445}, {x + 10, 560}, {x + 7, 680}}, {pressure={0.5, 0.35}, clip=face})
end

--@ chunk 84
palette{scrape={wallDk}}
brassP = pile{{"yellow ochre", 2}, {"raw sienna", 1}, {"raw umber", 0.5}, name="brass"}
shadeTop = poly({{348, 160}, {382, 160}, {402, 175}, {328, 175}}, true)
shadeIn = ellipse(365, 177, 39, 7)
chimM2 = poly({{361, 183}, {369, 183}, {370, 196}, {376, 203}, {376, 212}, {372, 216}, {358, 216}, {354, 212}, {354, 203}, {360, 196}}, true)
fontM2 = ellipse(365, 224, 17, 8) + rect(358, 214, 14, 5)
lampNew = shadeTop + shadeIn + chimM2 + fontM2
local old = (shadeM + chimM + fontM):grow(2) - lampNew
work(old, {hand="detail", tool={kind="filbert", width=5}, piles={{wallHi, 1}, {wallMid, function(x, y) return 0.15 + smoothstep(170, 150, y) * 1.5 end}}, coverage=3, fill=true, clip=old, angle=0, angle_jitter=0.3, length={6, 16}})
work(shadeTop, {hand="detail", tool={kind="round", width=3}, piles={{deepD, 1}, {warmD, 0.4}}, coverage=4, fill=true, clip=shadeTop, angle=0, length={6, 16}})
work(shadeIn, {hand="detail", tool={kind="round", width=3, lay=2}, piles={{lampGlowP, 1}, {skyP, 0.6}}, coverage=4, fill=true, clip=shadeIn, angle=0, length={6, 16}})
work(fontM2, {hand="detail", tool={kind="round", width=3}, piles={{brassP, 1}, {warmD, function(x, y) return smoothstep(222, 232, y) end}}, coverage=4, fill=true, clip=fontM2, angle=0, length={5, 12}})
work(chimM2, {hand="detail", tool={kind="round", width=2.5, lay=2.5}, piles={{lampGlowP, 1}, {skyP, 0.5}}, coverage=4, fill=true, clip=chimM2, angle=1.57, length={4, 10}})

--@ chunk 85
local old = (shadeM + chimM + fontM):grow(3) - lampNew:grow(1)
work(old, {hand="detail", tool={kind="filbert", width=4, lay=2}, piles={{wallHi, 1}, {lampGlowP, 0.25}}, coverage=4, fill=true, clip=old, angle=0.3, angle_jitter=0.5, length={4, 10}})
-- the flame inside the chimney
local fb = brush{kind="round", width=4, point=0.7, lay=4}
fb:load(skyP, 0.9)
fb:gesture({{365, 208, 0.7}, {365, 202, 0.9}, {365, 194, 0.2}})

--@ chunk 86
local gap = (lampM:grow(4) + shadeM:grow(3)) - lampNew:grow(0.5)
work(gap, {hand="detail", tool={kind="filbert", width=4, lay=2}, piles={{wallHi, 1}, {lampGlowP, 0.3}}, coverage=4, fill=true, clip=gap, angle=0.3, angle_jitter=0.5, length={4, 10}})

--@ chunk 87
print(wait(5 * 24 * 60))
local pts = {{250, 470}, {300, 410}, {400, 425}, {300, 475}, {275, 380}, {200, 420}, {250, 520}, {160, 450}, {300, 300}, {420, 500}, {440, 455}, {365, 200}, {340, 190}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 88
print(wait(4 * 24 * 60))
local pts = {{250, 470}, {300, 410}, {300, 475}, {200, 420}, {440, 455}, {365, 200}, {340, 190}, {230, 450}, {280, 500}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 89
for _, p in ipairs({{150, 300}, {180, 280}, {210, 270}, {260, 270}, {320, 280}, {340, 360}, {360, 400}, {150, 380}, {140, 450}, {140, 520}, {160, 560}, {330, 470}, {340, 520}}) do
  print(p[1], p[2])
end

--@ chunk 90
palette{scrape={brassP}}
wallDk = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.6}, name="wallDk"}
local fig = newCowboy:grow(0.5) + tableM:grow(0.5) + handR:grow(0.5) + revolverM:grow(1)
haloM = (((cowboyM + gunM):grow(14) + (crownM + brimM):grow(18)) - fig) - floorM:grow(1)
local function backLit(x, y)
  if x < 196 then return 0 end
  return lampLit(x, y)
end
local function leftLit(x, y)
  if x >= 200 then return 0 end
  local d = math.sqrt(((x - 200) * 1.3)^2 + ((y - 300) * 0.9)^2)
  return (1 - smoothstep(20, 260, d)) * smoothstep(60, 180, y) * 0.5
end
work(haloM, {hand="detail", tool={kind="filbert", width=6}, piles={
    {wallHi, function(x, y) return smoothstep(0.45, 0.85, backLit(x, y)) * 1.5 end},
    {wallMid, function(x, y) local l = backLit(x, y) return smoothstep(0.1, 0.4, l) * (1 - smoothstep(0.6, 0.9, l)) * 1.2 + leftLit(x, y) end},
    {wallDk, function(x, y) return 1 - smoothstep(0.05, 0.35, backLit(x, y)) end}},
  coverage=3, fill=true, clip=haloM, angle=function(x, y) return x < 200 and 1.57 or 0 end, angle_jitter=0.12, length={10, 28}, mix_jitter=0.04})

--@ chunk 91
palette{scrape={woodDk, lampGlowP}}
gE = pile{{"bone black", 1}, {"raw umber", 1}, {"burnt sienna", 0.5}, medium=0.3, name="glazeDk"}
redG = pile{{"permanent alizarin", 1}, {"bone black", 0.5}, {"burnt sienna", 0.5}, medium=0.4, name="redG"}
local front = (newCowboy + handR + revolverM):grow(1)
-- table face: all but a band along the top edge facing the lamp
local tf = (tableFace - front) * mask(function(x, y) return smoothstep(452, 478, y) end)
work(tf, {hand="glaze", tool={kind="filbert", width=12}, pile=gE, coverage=1, clip=true, angle=0.05})
local tf2 = (tableFace - front) * mask(function(x, y) return smoothstep(560, 640, y) end)
work(tf2, {hand="glaze", tool={kind="filbert", width=12}, pile=gE, coverage=1, clip=true, angle=0.05})
local legsT = (leg1M + leg2M) * mask(function(x, y) return smoothstep(452, 470, y) end)
work(legsT, {hand="glaze", tool={kind="filbert", width=6}, pile=gE, coverage=1, clip=true, angle=0})

--@ chunk 92
local ghost = (ribbon({{470, 404}, {552, 400}}, 30)):soften(6) - (revolverM + handR + tableM):grow(1.5)
print(drying(520, 410), drying(500, 390))
work(ghost, {hand="glaze", tool={kind="filbert", width=10}, pile=gE, coverage=1, clip=true, angle=0})

--@ chunk 93
print(wait(3 * 24 * 60))
local pts = {{150, 340}, {200, 300}, {330, 300}, {340, 380}, {420, 500}, {520, 410}, {365, 200}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 94
palette{scrape={louverP, redG}}
jointP = pile{{"raw umber", 1.5}, {"burnt sienna", 1}, {"bone black", 0.3}, name="joint"}
local figs = (newCowboy + tableM + handR + revolverM + leg1M + leg2M):grow(1.5) + lampNew:grow(4) + ribbon({{365, 0}, {365, 165}}, 5)
wallClip = backM - figs - barM
local rb = brush{kind="rigger", width=1.8, point=0.5}
math.randomseed(31)
local x = 214
while x < 880 do
  if x < 586 or x > 794 then
    rb:load(jointP, 0.55)
    rb:stroke({{x, 56}, {x + rand(-1, 1), 250}, {x + rand(-1, 1), 446}}, {pressure={0.45, 0.55}, ramps={0.02, 0.02}, clip=wallClip})
  end
  x = x + rand(31, 37)
end
railM = poly({{200, 444}, {880, 444}, {880, 456}, {200, 456}}) * wallClip
local bb = brush{kind="flat", width=6}
bb:load(woodLt, 0.7)
bb:stroke({{202, 447}, {588, 447}}, {pressure=0.6, clip=railM})
bb:load(woodLt, 0.7)
bb:stroke({{792, 447}, {878, 447}}, {pressure=0.6, clip=railM})
bb:load(jointP, 0.7)
bb:stroke({{202, 454}, {588, 454}}, {pressure=0.5, clip=railM})
bb:load(jointP, 0.7)
bb:stroke({{792, 454}, {878, 454}}, {pressure=0.5, clip=railM})
local tb = brush{kind="round", width=1.6, point=0.4}
tb:load(wallHi, 0.5)
tb:stroke({{202, 444.5}, {420, 444.5}, {588, 444.5}}, {pressure=0.45, clip=wallClip})

--@ chunk 95
palette{scrape={jointP, woodLt}}
trDk = pile{{"bone black", 1}, {"ultramarine blue", 0.35}, {"raw umber", 1.2}, name="trDk"}
trLit = pile{{"lead white", 1}, {"ultramarine blue", 0.25}, {"raw umber", 0.6}, {"yellow ochre", 0.5}, {"bone black", 0.15}, name="trLit"}
bootP = pile{{"burnt sienna", 1}, {"raw umber", 1.2}, {"bone black", 0.6}, name="boot"}

--@ chunk 96
local legsAll = (backLegM + frontLegM) - nTorso:shrink(1) - bootFrontM - bootBackM
local fL = facing(backLegM, 365, 200, 16)
local fF = facing(frontLegM, 365, 200, 16)
work(legsAll, {hand="body", tool={kind="filbert", width=8}, piles={
    {trDk, 1},
    {trLit, function(x, y) return math.max(fL(x, y) * 0.25, fF(x, y) * 0.7) * smoothstep(700, 560, y) end},
    {warmD, 0.3}},
  coverage=2.5, fill=true, clip=legsAll, angle=function(x, y) if frontLegM:at(x, y) > 0.5 then return (y < 590) and 0.6 or 1.6 end return 1.75 end,
  angle_jitter=0.15, length={15, 40}})
-- folds and the light on the front thigh's top plane
local g = brush{kind="filbert", width=6}
g:load(trLit, 0.6)
g:gesture({{290, 540, 0.3}, {316, 556, 0.6}, {340, 572, 0.6}, {356, 584, 0.2}}, {clip=frontLegM})
g:load(trDk, 0.6)
g:gesture({{300, 575, 0.2}, {322, 585, 0.5}, {338, 600, 0.3}}, {clip=frontLegM})
g:gesture({{214, 600, 0.2}, {220, 630, 0.5}, {214, 660, 0.2}}, {clip=backLegM})
-- cool rim from the door on the shin's forward edge
local r = brush{kind="round", width=2.5, point=0.5}
r:load(trLit, 0.5)
r:gesture({{366, 592, 0.2}, {370, 625, 0.5}, {372, 660, 0.3}}, {clip=frontLegM:grow(1)})

--@ chunk 97
local boots = bootFrontM + bootBackM
work(boots, {hand="detail", tool={kind="filbert", width=6}, piles={{bootP, 1}, {deepD, 0.3}}, coverage=3, fill=true, clip=boots, angle=0.15, angle_jitter=0.2, length={10, 25}})
local g = brush{kind="round", width=3, point=0.4}
-- leather shine on the toe facing the lamp and the door
g:load(wallMid, 0.6)
g:gesture({{350, 672, 0.2}, {372, 676, 0.5}, {390, 692, 0.3}}, {clip=bootFrontM})
g:load(wallHi, 0.4)
g:gesture({{368, 677, 0.1}, {380, 683, 0.4}, {388, 692, 0.1}}, {clip=bootFrontM})
g:load(wallMid, 0.5)
g:gesture({{120, 706, 0.2}, {150, 700, 0.4}, {178, 696, 0.2}}, {clip=bootBackM})
-- heel and sole dark
g:load(deepD, 0.6)
g:gesture({{332, 708, 0.4}, {360, 711, 0.6}, {392, 710, 0.4}}, {clip=bootFrontM:grow(1)})

--@ chunk 98
local m = (ribbon({{290, 540}, {316, 556}, {340, 572}, {356, 584}}, 16) * frontLegM):soften(3)
blend(m, {angle=0.6})
local m2 = (ribbon({{366, 592}, {370, 625}, {372, 660}}, 8) * frontLegM:grow(1)):soften(2)
blend(m2, {angle=1.57})

--@ chunk 99
local legsAll = ((backLegM + frontLegM) - nTorso:shrink(1) - bootFrontM - bootBackM):shrink(2):soften(3)
blend(legsAll, {angle=1.2})

--@ chunk 100
for _, p in ipairs({{290, 370}, {300, 380}, {700, 400}, {690, 330}, {660, 300}, {730, 360}, {670, 520}, {455, 412}, {500, 400}}) do
  print(p[1], p[2], drying(p[1], p[2]))
end

--@ chunk 101
palette{scrape={shirtDk, shirtLit, trDk, trLit, bootP}}
rimP = pile{{"lead white", 6}, {"Naples yellow", 1.5}, {"cadmium yellow", 0.3}, name="rim"}
local rb = brush{kind="round", width=2.2, point=0.6}
local zc = zombieM:grow(1.5)
local function rim(pts, ld)
  rb:load(rimP, ld or 0.5)
  rb:gesture(pts, {clip=zc})
end
rim({{641, 316, 0.1}, {643, 306, 0.35}, {650, 298, 0.5}, {661, 296, 0.55}, {671, 299, 0.4}, {678, 306, 0.15}})
rim({{684, 339, 0.1}, {698, 335, 0.5}, {712, 337, 0.6}, {721, 344, 0.55}, {726, 360, 0.35}, {727, 380, 0.1}}, 0.6)
rim({{646, 324, 0.1}, {630, 321, 0.4}, {614, 320, 0.45}, {602, 320, 0.2}})
rim({{652, 356, 0.1}, {636, 359, 0.3}, {616, 360, 0.35}, {604, 361, 0.1}})
rim({{716, 472, 0.1}, {721, 495, 0.4}, {726, 520, 0.45}, {731, 542, 0.2}})
rim({{681, 470, 0.1}, {675, 495, 0.25}, {669, 525, 0.3}, {665, 552, 0.1}}, 0.35)
rim({{658, 375, 0.05}, {664, 400, 0.25}, {670, 430, 0.3}, {676, 458, 0.05}}, 0.35)

--@ chunk 102
local paths = {
  {{641, 316}, {643, 306}, {650, 298}, {661, 296}, {671, 299}, {678, 306}},
  {{716, 472}, {721, 495}, {726, 520}, {731, 542}},
  {{681, 470}, {675, 495}, {669, 525}, {665, 552}},
  {{658, 375}, {664, 400}, {670, 430}, {676, 458}},
  {{646, 324}, {630, 321}, {614, 320}, {602, 320}},
  {{652, 356}, {636, 359}, {616, 360}, {604, 361}},
  {{684, 339}, {698, 335}, {712, 337}, {721, 344}, {726, 360}, {727, 380}}}
for i, p in ipairs(paths) do
  for k = 1, 2 do
    local r = rag{width=7}
    r:dip(0.95)
    r:wipe(p, {pressure=0.85})
  end
end

--@ chunk 103
zombP = pile{{"bone black", 1}, {"raw umber", 1.2}, {"green earth", 1.2}, name="zomb"}
local paths = {
  {{641, 316}, {643, 306}, {650, 298}, {661, 296}, {671, 299}, {678, 306}},
  {{716, 472}, {721, 495}, {726, 520}, {731, 542}},
  {{681, 470}, {675, 495}, {669, 525}, {665, 552}},
  {{658, 375}, {664, 400}, {670, 430}, {676, 458}},
  {{646, 324}, {630, 321}, {614, 320}, {602, 320}},
  {{652, 356}, {636, 359}, {616, 360}, {604, 361}},
  {{684, 339}, {698, 335}, {712, 337}, {721, 344}, {726, 360}, {727, 380}}}
local m = nil
for _, p in ipairs(paths) do
  local rbn = ribbon(p, 6)
  m = m and (m + rbn) or rbn
end
m = m * zombieM
work(m, {hand="detail", tool={kind="round", width=3}, pile=zombP, coverage=4, fill=true, clip=m, angle=1.4, angle_jitter=0.5, length={4, 10}})

--@ chunk 104
skinLit = pile{{"yellow ochre", 1}, {"lead white", 0.8}, {"vermilion", 0.3}, {"red earth", 0.2}, name="skinLit"}
local hc = nHead:grow(1)
local function g(b, pile, ld, pts) b:load(pile, ld) b:gesture(pts, {clip=hc}) end
local f = brush{kind="filbert", width=5}
local r = brush{kind="round", width=2.5, point=0.6}
local rf = brush{kind="round", width=1.6, point=0.7}
-- shadow of the brim over the brow
g(f, warmD, 0.7, {{262, 354, 0.4}, {285, 355, 0.6}, {312, 356, 0.5}})
-- cheek plane catching the lamp and the flash
g(f, skinMid, 0.7, {{286, 366, 0.3}, {296, 372, 0.6}, {303, 380, 0.4}})
g(f, skinLit, 0.5, {{291, 368, 0.2}, {299, 372, 0.45}, {304, 377, 0.2}})
-- ear
g(r, skinMid, 0.7, {{272, 362, 0.4}, {268, 370, 0.7}, {272, 378, 0.4}})
g(rf, warmD, 0.6, {{272, 366, 0.4}, {271, 372, 0.4}})
-- jaw and stubble, darker, cooler
g(f, warmD, 0.6, {{280, 388, 0.3}, {295, 390, 0.5}, {308, 386, 0.4}})
g(r, deepD, 0.4, {{288, 385, 0.2}, {300, 387, 0.4}, {309, 383, 0.2}})
-- eye socket and eye
g(r, deepD, 0.7, {{298, 360, 0.3}, {304, 361, 0.6}, {308, 361, 0.2}})
-- nose (profile), mustache
g(r, skinMid, 0.7, {{309, 358, 0.3}, {315, 364, 0.6}, {318, 369, 0.4}})
g(r, deepD, 0.7, {{306, 374, 0.3}, {312, 374, 0.6}, {316, 376, 0.4}})
-- lit profile edge: forehead below the brim, nose, chin
g(rf, skinLit, 0.6, {{313, 360, 0.2}, {318, 366, 0.6}, {319, 370, 0.3}})
g(rf, skinLit, 0.5, {{313, 380, 0.2}, {312, 386, 0.4}, {309, 390, 0.2}})

--@ chunk 105
print(wait(5 * 24 * 60))
local pts = {{150, 340}, {170, 450}, {520, 410}, {365, 200}, {300, 360}, {250, 470}, {300, 600}, {650, 330}, {700, 340}, {610, 320}, {360, 680}, {460, 500}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 106
local fig = (newCowboy + handR + revolverM):grow(1)
local lw = (leftwallM - fig) * mask(function(x, y) return y < 630 and 1 or 0 end)
work(lw, {hand="glaze", tool={kind="filbert", width=20}, pile=gE, coverage=1, clip=true, angle=1.57})

--@ chunk 107
print(palette())

--@ chunk 108
crown2 = poly({{228, 334}, {226, 314}, {231, 300}, {242, 291}, {256, 294}, {270, 290}, {286, 294}, {297, 304}, {302, 322}, {303, 342}}, true)
brim2 = poly({{158, 320}, {182, 326}, {222, 332}, {262, 338}, {306, 344}, {342, 348}, {368, 349}, {372, 355}, {352, 360}, {318, 359}, {280, 355}, {240, 349}, {204, 342}, {176, 334}}, true)
head2 = poly({{246, 346}, {240, 366}, {246, 384}, {258, 398}, {276, 406}, {296, 408}, {306, 404}, {312, 398}, {315, 392}, {320, 389}, {318, 384}, {324, 379}, {320, 372}, {320, 364}, {318, 356}}, true)
torso2 = poly({{250, 396}, {224, 402}, {204, 416}, {190, 440}, {184, 470}, {186, 505}, {196, 532}, {210, 552}, {286, 556}, {300, 528}, {308, 494}, {314, 460}, {318, 432}, {316, 414}, {304, 404}, {280, 402}}, true)
armR2 = ribbon({{306, 416}, {340, 418}, {378, 418}, {414, 414}, {438, 411}}, {26, 24, 21, 18, 16})
fist2 = poly({{432, 402}, {446, 398}, {460, 399}, {468, 404}, {470, 414}, {466, 424}, {452, 427}, {438, 424}, {432, 414}}, true)
bandana2 = poly({{262, 398}, {290, 408}, {308, 406}, {316, 412}, {306, 420}, {282, 418}, {262, 410}}, true)
newUpper = crown2 + brim2 + head2 + torso2 + armR2 + fist2
print(newUpper:area())

--@ chunk 109
palette{scrape={shirtMid, zombP}}
hatDk = pile{{"raw umber", 1}, {"burnt sienna", 0.5}, {"bone black", 0.35}, name="hatDk"}
skinSh = pile{{"burnt sienna", 1}, {"raw umber", 1}, {"red earth", 0.4}, name="skinSh"}
bandP = pile{{"yellow ochre", 1}, {"raw umber", 0.7}, {"lead white", 0.15}, name="bandana"}
sleeveDk = pile{{"Indian red", 1}, {"raw umber", 0.9}, {"bone black", 0.35}, name="sleeveDk"}
-- background where the old hat/head/arm no longer are
local oldUp = (crownM + brimM + nHead + nNeck + nArmR + nHandR + handR):grow(2)
local newUp = crown2 + brim2 + head2 + torso2 + armR2 + fist2 + bandana2 + revolverM
bgPatch = (oldUp - newUp:grow(0.5)) - tableM
local function backLit(x, y) return lampLit(x, y) end
work(bgPatch, {hand="detail", tool={kind="filbert", width=5}, piles={
    {wallHi, function(x, y) return smoothstep(0.45, 0.85, backLit(x, y)) * 1.5 end},
    {wallMid, function(x, y) local l = backLit(x, y) return smoothstep(0.1, 0.4, l) * (1 - smoothstep(0.6, 0.9, l)) * 1.2 end},
    {wallDk, function(x, y) return 1 - smoothstep(0.05, 0.35, backLit(x, y)) end}},
  coverage=3, fill=true, clip=bgPatch, angle=0, angle_jitter=0.15, length={6, 18}, mix_jitter=0.04})
print(bgPatch:area())

--@ chunk 110
-- left-wall part of the patch: dark like the left wall
local lwPatch = bgPatch * mask(function(x, y) return x < 204 and 1 or 0 end) - brim2
work(lwPatch, {hand="detail", tool={kind="filbert", width=4}, piles={{wallDk, 1}, {deepD, 0.3}}, coverage=3, fill=true, clip=lwPatch, angle=1.57, length={5, 12}})
-- the far (gun) arm in shadow, tapering, with an elbow fold and a cuff
local arm = armR2 - torso2 - fist2
work(arm, {hand="detail", tool={kind="filbert", width=5}, piles={{sleeveDk, 1}, {warmD, 0.25}}, coverage=3, fill=true, clip=arm, angle=0.02, angle_jitter=0.08, length={10, 30}})
local g = brush{kind="round", width=2.5, point=0.5}
-- underside shadow
g:load(deepD, 0.6)
g:gesture({{318, 426, 0.4}, {360, 427, 0.6}, {400, 423, 0.5}, {430, 418, 0.3}}, {clip=arm})
-- elbow fold
g:load(deepD, 0.5)
g:gesture({{372, 410, 0.1}, {378, 416, 0.5}, {384, 424, 0.2}}, {clip=arm})
g:gesture({{386, 412, 0.1}, {390, 418, 0.4}}, {clip=arm})
-- cuff
g:load(sleeveDk, 0.7)
g:gesture({{424, 404, 0.4}, {427, 412, 0.7}, {427, 419, 0.4}}, {clip=arm})
g:load(deepD, 0.5)
g:gesture({{430, 404, 0.3}, {432, 412, 0.5}, {431, 419, 0.3}}, {clip=arm:grow(1)})

--@ chunk 111
-- torso (vest), dark; the arm comes from behind its front edge
local t = torso2 - nArmL - nHandL
work(t * rect(180, 390, 145, 80), {hand="detail", tool={kind="filbert", width=6}, piles={{hatDk, 1}, {deepD, 0.4}}, coverage=3, fill=true, clip=t * rect(180, 390, 145, 80),
  angle=function(x, y) return 1.35 + (x - 250) / 400 end, angle_jitter=0.25, length={10, 30}})
-- bandana: dull ochre in shade, a knot at the side of the neck
local bd = bandana2 - head2
work(bd, {hand="detail", tool={kind="round", width=3}, piles={{bandP, 1}, {warmD, 0.3}}, coverage=4, fill=true, clip=bd, angle=0.2, angle_jitter=0.3, length={4, 10}})
local knot = poly({{262, 404}, {270, 400}, {276, 408}, {272, 418}, {262, 420}, {256, 412}}, true)
work(knot, {hand="detail", tool={kind="round", width=2.5}, piles={{bandP, 1}, {warmD, 0.5}}, coverage=4, fill=true, clip=knot, angle=1.2, length={3, 8}})
local g = brush{kind="round", width=2, point=0.6}
g:load(warmD, 0.6)
g:gesture({{266, 410, 0.3}, {262, 422, 0.6}, {258, 430, 0.2}}, {clip=torso2})
g:gesture({{272, 410, 0.3}, {274, 424, 0.5}, {272, 432, 0.2}}, {clip=torso2})

--@ chunk 112
-- hat: crown then brim
work(crown2, {hand="detail", tool={kind="filbert", width=5}, piles={{hatDk, 1}, {warmD, 0.4}}, coverage=3, fill=true, clip=crown2, angle=1.45, angle_jitter=0.25, length={8, 18}})
work(brim2, {hand="detail", tool={kind="filbert", width=5}, piles={{hatDk, 1}, {deepD, function(x, y) return 0.3 + 0.5 * smoothstep(345, 355, y) end}}, coverage=3, fill=true, clip=brim2,
  angle=function(x, y) return 0.12 end, angle_jitter=0.06, length={12, 30}})
local g = brush{kind="filbert", width=5}
local r = brush{kind="round", width=2.5, point=0.5}
-- lamp light on the front/right of the crown: the side toward the lamp
g:load(wallMid, 0.7)
g:gesture({{286, 296, 0.3}, {296, 306, 0.6}, {300, 322, 0.6}, {302, 336, 0.3}}, {clip=crown2})
r:load(wallHi, 0.6)
r:gesture({{290, 298, 0.2}, {298, 310, 0.5}, {301, 326, 0.4}, {302, 336, 0.1}}, {clip=crown2})
-- crease in the crown top
g:load(wallMid, 0.5)
g:gesture({{256, 296, 0.2}, {270, 292, 0.5}, {284, 295, 0.2}}, {clip=crown2})
r:load(deepD, 0.5)
r:gesture({{258, 300, 0.2}, {272, 298, 0.4}, {282, 302, 0.1}}, {clip=crown2})
-- hatband
r:load(deepD, 0.7)
r:gesture({{230, 330, 0.5}, {265, 336, 0.7}, {302, 340, 0.5}}, {clip=crown2:grow(1)})
-- top surface of the brim at the front, catching the lamp
r:load(wallMid, 0.6)
r:gesture({{304, 344, 0.3}, {336, 347, 0.6}, {360, 349, 0.5}, {371, 352, 0.2}}, {clip=brim2})
r:load(wallHi, 0.4)
r:gesture({{320, 346, 0.2}, {350, 348, 0.4}, {368, 351, 0.1}}, {clip=brim2})
-- the back brim tip, far from the light, a dull edge
r:load(warmD, 0.5)
r:gesture({{160, 321, 0.2}, {190, 328, 0.4}, {224, 334, 0.2}}, {clip=brim2})

--@ chunk 113
-- head: shadow side toward us; ear; hair at the nape; light only along the front edges
local hairM2 = poly({{246, 346}, {268, 350}, {266, 366}, {262, 384}, {258, 398}, {248, 388}, {241, 368}}, true) * head2
local face = head2 - hairM2
work(hairM2, {hand="detail", tool={kind="round", width=3}, pile=hatDk, coverage=4, fill=true, clip=hairM2, angle=1.75, angle_jitter=0.3, length={5, 12}})
local fh = facing(head2, 420, 300, 9, 0.6)
work(face, {hand="detail", tool={kind="round", width=3.5}, piles={{skinSh, 1}, {skinMid, function(x, y) return fh(x, y) * 0.8 end}, {hatDk, function(x, y) return 0.8 * smoothstep(364, 350, y) end}},
  coverage=4, fill=true, clip=face, angle=1.3, angle_jitter=0.3, length={5, 12}})
local hc = head2:grow(1)
local r = brush{kind="round", width=2.5, point=0.6}
local rf = brush{kind="round", width=1.5, point=0.7}
local function g(b, p, ld, pts) b:load(p, ld) b:gesture(pts, {clip=hc}) end
-- ear
g(r, skinSh, 0.7, {{276, 368, 0.4}, {272, 376, 0.7}, {275, 385, 0.4}})
g(rf, hatDk, 0.6, {{276, 372, 0.4}, {275, 380, 0.4}})
-- squinting eye in the shadow of the brim
g(rf, hatDk, 0.7, {{302, 368, 0.3}, {308, 368, 0.6}, {313, 367, 0.2}})
-- cheekbone plane, lamp-lit, warm
g(r, skinMid, 0.6, {{300, 374, 0.2}, {308, 377, 0.5}, {314, 380, 0.2}})
-- mustache and the mouth line
g(r, hatDk, 0.6, {{308, 386, 0.3}, {314, 386, 0.6}, {319, 388, 0.3}})
-- stubble on the jaw, cool dark
g(r, deepD, 0.35, {{282, 398, 0.2}, {296, 403, 0.4}, {308, 398, 0.2}})
-- door light along the profile: brow, nose, lip, chin
g(rf, skinLit, 0.6, {{318, 360, 0.2}, {320, 366, 0.5}, {323, 373, 0.6}, {324, 379, 0.3}})
g(rf, rimP, 0.45, {{322, 371, 0.2}, {324, 376, 0.4}, {324, 379, 0.1}})
g(rf, skinLit, 0.5, {{317, 390, 0.2}, {315, 395, 0.4}, {312, 399, 0.2}})

--@ chunk 114
local m = (crown2 + brim2 + head2 + bandana2):grow(2) - torso2:shrink(6)
for i = 1, 4 do
  local r = rag{width=16}
  r:dip(0.95)
  r:wipe(m, {pressure=0.9, angle=(i % 2 == 1) and 0.1 or 1.5, passes=2, refold=0.3})
end

--@ chunk 115
local m = (bandana2 + poly({{262, 404}, {270, 400}, {276, 408}, {272, 418}, {262, 420}, {256, 412}}, true)):grow(3)
for i = 1, 3 do
  local r = rag{width=10}
  r:dip(0.95)
  r:wipe(m, {pressure=0.9, angle=(i % 2 == 1) and 0.1 or 1.5, passes=2, refold=0.25})
end
-- new shapes: lost profile, head dropped toward the gun arm
hat3c = outline{{231, 338, "c"}, {234, 318}, {241, 300, "c"}, {256, 292}, {270, 298, "c"}, {286, 291}, {299, 296, "c"}, {304, 318}, {307, 342, "c"}, char="firm", amount=0.3, seed=41}:mask()
hat3b = outline{{170, 320, "c"}, {200, 329}, {240, 335}, {300, 340}, {340, 345}, {366, 351, "c"}, {362, 358, "c"}, {330, 357}, {290, 353}, {240, 349}, {205, 342}, {180, 333, "c"}, char="firm", amount=0.25, seed=42}:mask()
head3 = outline{{247, 350, "c"}, {242, 368}, {247, 387}, {258, 400}, {276, 407}, {297, 410, "c"}, {306, 405}, {310, 396}, {315, 388}, {320, 383, "c"}, {315, 378, "c"}, {316, 366}, {318, 357}, {316, 350, "c"}, char="firm", amount=0.2, seed=43}:mask()
neck3 = poly({{256, 396}, {300, 408}, {306, 418}, {262, 418}}, true)
print(hat3c:area(), hat3b:area(), head3:area())

--@ chunk 116
local oldStuff = (crownM + brimM + nHead + crown2 + brim2 + head2 + bandana2 + nNeck):grow(3)
local newShapes = hat3c + hat3b + head3 + neck3 + torso2 + armR2 + fist2
bg3 = (oldStuff - newShapes:grow(0.5)) - tableM
local bgR = bg3 * mask(function(x, y) return x >= 201 and 1 or 0 end)
local bgL = bg3 * mask(function(x, y) return x < 201 and 1 or 0 end)
work(bgR, {hand="detail", tool={kind="filbert", width=5}, piles={
    {wallHi, function(x, y) return smoothstep(0.45, 0.85, lampLit(x, y)) * 1.5 end},
    {wallMid, function(x, y) local l = lampLit(x, y) return smoothstep(0.1, 0.4, l) * (1 - smoothstep(0.6, 0.9, l)) * 1.2 end},
    {wallDk, function(x, y) return 1 - smoothstep(0.05, 0.35, lampLit(x, y)) end}},
  coverage=3, fill=true, clip=bgR, angle=0, angle_jitter=0.15, length={6, 18}, mix_jitter=0.04})
work(bgL, {hand="detail", tool={kind="filbert", width=4}, piles={{wallDk, 1}, {deepD, 0.3}, {warmD, 0.3}}, coverage=3, fill=true, clip=bgL, angle=1.57, length={5, 12}})

--@ chunk 117
-- hat crown and brim: base
work(hat3c, {hand="detail", tool={kind="filbert", width=5}, piles={{hatDk, 1}, {warmD, 0.3}}, coverage=3, fill=true, clip=hat3c, angle=1.45, angle_jitter=0.25, length={8, 18}})
work(hat3b, {hand="detail", tool={kind="filbert", width=4}, piles={{hatDk, 0.7}, {deepD, 0.6}}, coverage=3, fill=true, clip=hat3b, angle=0.1, angle_jitter=0.04, length={14, 34}})
-- head base: hair at the back, skin in shadow
hair3 = poly({{240, 348}, {270, 350}, {268, 366}, {266, 384}, {262, 400}, {250, 392}, {241, 372}}, true) * head3
skin3 = head3 - hair3
work(hair3, {hand="detail", tool={kind="round", width=3}, pile=hatDk, coverage=4, fill=true, clip=hair3, angle=1.7, angle_jitter=0.3, length={5, 12}})
work(skin3, {hand="detail", tool={kind="round", width=3.5}, piles={{skinSh, 1}, {warmD, 0.7}, {hatDk, function(x, y) return 0.9 * smoothstep(364, 352, y) end}},
  coverage=4, fill=true, clip=skin3, angle=1.3, angle_jitter=0.3, length={5, 12}})
-- neck and bandana
local nk = neck3 - head3
work(nk, {hand="detail", tool={kind="round", width=3}, piles={{skinSh, 0.5}, {warmD, 1}}, coverage=4, fill=true, clip=nk, angle=0.2, length={4, 10}})

--@ chunk 118
local hc = hat3c
local g = brush{kind="filbert", width=5}
local r = brush{kind="round", width=2.5, point=0.5}
-- the right side of the crown faces the lamp: a warm plane, brightest at the dent's ridge
g:load(warmD, 0.7)
g:gesture({{280, 300, 0.3}, {292, 310, 0.6}, {298, 326, 0.6}, {302, 340, 0.3}}, {clip=hc})
g:load(wallMid, 0.7)
g:gesture({{288, 298, 0.3}, {297, 310, 0.6}, {301, 326, 0.5}, {304, 338, 0.2}}, {clip=hc})
r:load(wallHi, 0.6)
r:gesture({{292, 296, 0.2}, {299, 306, 0.5}, {302, 320, 0.4}, {304, 332, 0.1}}, {clip=hc})
-- the dent on the top: a lit ridge on the right lobe, the dip dark
r:load(wallMid, 0.6)
r:gesture({{272, 297, 0.2}, {284, 292, 0.5}, {296, 296, 0.3}}, {clip=hc})
r:load(deepD, 0.5)
r:gesture({{262, 296, 0.2}, {270, 300, 0.4}, {276, 306, 0.2}}, {clip=hc})
-- hatband
r:load(deepD, 0.7)
r:gesture({{233, 330, 0.5}, {268, 335, 0.7}, {305, 339, 0.5}}, {clip=hc:grow(1)})
-- brim: top edge lit by the lamp near the front, the brim's curl up at the front tip
local bc = hat3b
r:load(wallMid, 0.6)
r:gesture({{290, 340, 0.2}, {320, 343, 0.5}, {348, 347, 0.6}, {364, 351, 0.3}}, {clip=bc})
r:load(wallHi, 0.4)
r:gesture({{315, 342, 0.1}, {342, 346, 0.4}, {362, 350, 0.2}}, {clip=bc})
r:load(warmD, 0.5)
r:gesture({{176, 323, 0.2}, {210, 330, 0.4}, {236, 334, 0.2}}, {clip=bc})

--@ chunk 119
local hc = head3:grow(1)
local r = brush{kind="round", width=2.5, point=0.6}
local rf = brush{kind="round", width=1.5, point=0.7}
local function g(b, p, ld, pts) b:load(p, ld) b:gesture(pts, {clip=hc}) end
-- the brim's cast shadow across the upper face
g(r, hatDk, 0.6, {{262, 356, 0.4}, {290, 358, 0.7}, {316, 360, 0.5}})
-- ear, in half-shadow
g(r, skinSh, 0.7, {{276, 368, 0.4}, {272, 377, 0.7}, {275, 386, 0.4}})
g(rf, hatDk, 0.6, {{276, 372, 0.4}, {275, 381, 0.4}})
-- the squinting eye: a dark slit, tucked under the brim
g(rf, hatDk, 0.7, {{302, 369, 0.3}, {308, 370, 0.6}, {313, 369, 0.2}})
-- cheekbone in reflected warm light, low
g(r, skinMid, 0.5, {{294, 378, 0.2}, {304, 381, 0.45}, {311, 383, 0.2}})
-- mustache
g(r, hatDk, 0.7, {{308, 389, 0.3}, {314, 389, 0.6}, {318, 391, 0.3}})
-- stubble on the jaw
g(r, deepD, 0.35, {{280, 400, 0.2}, {294, 405, 0.4}, {304, 402, 0.2}})
-- door light on the profile: brow, nose ridge, lip, chin
g(rf, skinLit, 0.55, {{316, 362, 0.2}, {318, 368, 0.5}, {320, 376, 0.6}, {321, 382, 0.3}})
g(rf, rimP, 0.4, {{319, 373, 0.2}, {321, 378, 0.4}, {321, 382, 0.1}})
g(rf, skinLit, 0.45, {{315, 393, 0.2}, {312, 399, 0.4}, {308, 404, 0.2}})

--@ chunk 120
-- bandana: dull ochre at the throat with a knot at the side of the neck
band3 = outline{{262, 404, "c"}, {282, 412}, {300, 414}, {310, 410, "c"}, {313, 418}, {304, 426}, {284, 426}, {266, 420, "c"}, char="firm", amount=0.2, seed=51}:mask() - head3
knot3 = outline{{258, 410, "c"}, {268, 406}, {274, 414, "c"}, {270, 426}, {262, 432, "c"}, {256, 422}, char="firm", amount=0.3, seed=52}:mask()
local bd = band3 + knot3
work(bd, {hand="detail", tool={kind="round", width=3}, piles={{bandP, 1}, {warmD, 0.6}}, coverage=4, fill=true, clip=bd, angle=0.2, angle_jitter=0.3, length={4, 10}})
-- the fist: a block of knuckles around the grip, thumb along the top, trigger finger forward
fist3 = outline{{436, 404, "c"}, {450, 400}, {462, 401, "c"}, {468, 408}, {469, 420, "c"}, {462, 428}, {446, 429, "c"}, {438, 422}, char="firm", amount=0.2, seed=53}:mask()
local fist3bg = (handR:grow(2) + fist2:grow(2)) - fist3 - armR2 - revolverM
work(fist3bg, {hand="detail", tool={kind="round", width=3}, piles={{wallDk, 1}, {warmD, 0.5}}, coverage=4, fill=true, clip=fist3bg, angle=0, length={4, 10}})
work(fist3, {hand="detail", tool={kind="round", width=3}, piles={{skinSh, 1}, {warmD, 0.4}}, coverage=4, fill=true, clip=fist3, angle=0.3, length={4, 10}})
-- grip butt below the hand
gripM = poly({{452, 426}, {463, 425}, {466, 434}, {455, 436}}, true)
work(gripM, {hand="detail", tool={kind="round", width=2}, piles={{hatDk, 1}, {deepD, 0.3}}, coverage=4, fill=true, clip=gripM, angle=1.2, length={3, 6}})

--@ chunk 121
print(wait(2 * 24 * 60))
local pts = {{260, 320}, {300, 345}, {290, 380}, {255, 375}, {285, 418}, {452, 414}, {380, 418}, {230, 300}, {175, 325}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 122
print(wait(3 * 24 * 60))
local pts = {{260, 320}, {300, 345}, {290, 380}, {255, 375}, {285, 418}, {452, 414}, {380, 418}, {230, 300}, {175, 325}, {440, 480}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 123
print(wait(3 * 24 * 60))
local pts = {{260, 320}, {300, 345}, {290, 380}, {255, 375}, {285, 418}, {452, 414}, {380, 418}, {230, 300}, {175, 325}, {440, 480}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 124
print(wait(2 * 24 * 60))
local pts = {{255, 375}, {285, 418}, {380, 418}, {230, 300}, {265, 420}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 125
local hc = hat3c:grow(0.5)
local g = brush{kind="filbert", width=4}
local r = brush{kind="round", width=2.2, point=0.5}
-- the crown's lamp side
g:load(warmD, 0.7)
g:gesture({{282, 300, 0.3}, {292, 312, 0.6}, {298, 326, 0.6}, {302, 340, 0.3}}, {clip=hc})
g:load(wallMid, 0.6)
g:gesture({{290, 300, 0.3}, {298, 312, 0.6}, {302, 326, 0.5}, {304, 337, 0.2}}, {clip=hc})
r:load(wallHi, 0.55)
r:gesture({{294, 299, 0.2}, {300, 309, 0.5}, {303, 322, 0.4}, {305, 333, 0.1}}, {clip=hc})
-- the dent: lit right lobe, dark dip
r:load(wallMid, 0.55)
r:gesture({{273, 298, 0.2}, {285, 293, 0.5}, {296, 297, 0.3}}, {clip=hc})
r:load(deepD, 0.5)
r:gesture({{262, 297, 0.2}, {269, 301, 0.4}, {274, 308, 0.2}}, {clip=hc})
-- the far-side lobe catches a little top light
r:load(warmD, 0.5)
r:gesture({{243, 302, 0.2}, {252, 295, 0.4}, {260, 294, 0.2}}, {clip=hc})
-- hatband
r:load(deepD, 0.7)
r:gesture({{234, 330, 0.5}, {268, 335, 0.7}, {305, 339, 0.5}}, {clip=hc:grow(1)})
-- brim: the lit upper edge toward the front, a dull edge behind
local bc = hat3b:grow(0.5)
r:load(wallMid, 0.6)
r:gesture({{290, 340, 0.2}, {320, 343, 0.5}, {348, 347, 0.6}, {364, 351, 0.3}}, {clip=bc})
r:load(wallHi, 0.45)
r:gesture({{318, 343, 0.1}, {344, 346, 0.4}, {362, 350, 0.2}}, {clip=bc})
r:load(warmD, 0.5)
r:gesture({{176, 323, 0.2}, {210, 330, 0.4}, {236, 334, 0.2}}, {clip=bc})

--@ chunk 126
local hc = head3:grow(0.5)
local f = brush{kind="filbert", width=4}
local r = brush{kind="round", width=2.2, point=0.6}
local rf = brush{kind="round", width=1.4, point=0.7}
local function g(b, p, ld, pts) b:load(p, ld) b:gesture(pts, {clip=hc}) end
-- the brim's shadow across the brow, soft lower edge
g(f, hatDk, 0.5, {{258, 356, 0.4}, {288, 358, 0.7}, {317, 360, 0.5}})
-- the ear
g(r, skinMid, 0.6, {{277, 368, 0.3}, {273, 377, 0.6}, {276, 386, 0.3}})
g(rf, hatDk, 0.6, {{278, 372, 0.4}, {276, 381, 0.4}})
-- the cheek plane: reflected warm light, low on the cheek
g(f, skinMid, 0.5, {{288, 380, 0.2}, {300, 384, 0.5}, {310, 386, 0.2}})
-- the eye: a slit under the brow, looking along the barrel
g(rf, hatDk, 0.7, {{301, 369, 0.3}, {307, 370, 0.6}, {313, 369, 0.2}})
-- brow ridge
g(rf, skinSh, 0.6, {{300, 365, 0.2}, {309, 364, 0.5}, {316, 364, 0.2}})
-- mustache and mouth
g(r, hatDk, 0.7, {{307, 390, 0.3}, {313, 390, 0.6}, {318, 392, 0.3}})
-- stubble
g(r, deepD, 0.3, {{280, 401, 0.2}, {294, 406, 0.4}, {304, 403, 0.2}})
-- the jaw line, dark against the bandana
g(rf, hatDk, 0.5, {{268, 402, 0.2}, {285, 409, 0.5}, {302, 410, 0.3}})
-- door light along the profile
g(rf, skinLit, 0.55, {{316, 361, 0.2}, {318, 368, 0.5}, {320, 376, 0.6}, {321, 382, 0.3}})
g(rf, rimP, 0.4, {{319, 373, 0.2}, {321, 378, 0.45}, {321, 382, 0.1}})
g(rf, skinLit, 0.45, {{315, 393, 0.2}, {312, 399, 0.4}, {308, 404, 0.2}})

--@ chunk 127
local m = head3:grow(1)
for i = 1, 2 do
  local r = rag{width=12}
  r:dip(0.95)
  r:wipe(m, {pressure=0.85, angle=(i % 2 == 1) and 0.1 or 1.5, passes=2, refold=0.3})
end
-- a stronger profile: brow ridge, nose out to a tip, lips, chin
face4 = outline{{247, 350, "c"}, {242, 368}, {247, 387}, {258, 400}, {276, 408}, {296, 411, "c"}, {306, 408}, {312, 402, "c"}, {316, 396}, {319, 391, "c"}, {317, 388, "c"}, {323, 386, "c"}, {328, 383, "c"}, {322, 372}, {318, 364, "c"}, {319, 358}, {317, 350, "c"}, char="firm", amount=0.15, seed=61}:mask()
print(face4:area())

--@ chunk 128
local cut = (head3 - face4) - hat3b - torso2 - band3
work(cut, {hand="detail", tool={kind="round", width=2.5}, piles={
    {wallHi, function(x, y) return smoothstep(0.45, 0.85, lampLit(x, y)) * 1.5 end},
    {wallMid, function(x, y) local l = lampLit(x, y) return smoothstep(0.1, 0.4, l) * (1 - smoothstep(0.6, 0.9, l)) * 1.2 end}},
  coverage=4, fill=true, clip=cut, angle=0, length={3, 8}})
local add = face4 - head3
work(add, {hand="detail", tool={kind="round", width=2}, piles={{skinSh, 1}, {warmD, 0.3}}, coverage=4, fill=true, clip=add, angle=0.5, length={3, 6}})
-- face planes as soft patches
local fc = face4:grow(0.5)
local f = brush{kind="filbert", width=6}
local r = brush{kind="round", width=3, point=0.5}
local rf = brush{kind="round", width=1.6, point=0.7}
local function g(b, p, ld, pts) b:load(p, ld) b:gesture(pts, {clip=fc}) end
-- brim shadow over the brow and eye: broad and dark
g(f, hatDk, 0.6, {{258, 357, 0.5}, {285, 359, 0.8}, {312, 362, 0.6}})
g(f, hatDk, 0.4, {{296, 366, 0.4}, {306, 370, 0.6}, {314, 372, 0.3}})
-- the cheekbone: a warmer patch below the eye socket, not a line
g(f, skinMid, 0.35, {{292, 379, 0.3}, {300, 381, 0.45}, {306, 384, 0.3}})
-- jaw and the side of the face falling into shadow toward the ear and nape
g(f, warmD, 0.45, {{262, 372, 0.3}, {266, 388, 0.6}, {276, 402, 0.4}})
-- the ear, a small dark-edged shape
g(r, skinSh, 0.6, {{278, 370, 0.4}, {275, 378, 0.7}, {278, 387, 0.4}})
g(rf, hatDk, 0.5, {{281, 372, 0.4}, {280, 384, 0.4}})
-- mustache
g(r, hatDk, 0.7, {{312, 388, 0.4}, {318, 388, 0.6}, {321, 390, 0.3}})
-- profile lit by the doorway: brow, nose ridge and tip, upper lip, chin
g(rf, skinLit, 0.65, {{317, 359, 0.3}, {318, 364, 0.5}, {321, 371, 0.6}, {325, 378, 0.7}, {326, 383, 0.4}})
g(rf, rimP, 0.5, {{321, 373, 0.3}, {325, 379, 0.5}, {326, 383, 0.2}})
g(rf, skinLit, 0.5, {{318, 393, 0.3}, {316, 397, 0.5}, {313, 402, 0.4}, {309, 407, 0.2}})

--@ chunk 129
local m = face4:shrink(2):soften(2)
blend(m, {angle=0.4})

--@ chunk 130
fist4 = outline{{436, 405, "c"}, {446, 400}, {458, 399, "c"}, {464, 404}, {467, 412, "c"}, {466, 421}, {458, 427, "c"}, {444, 428}, {437, 421, "c"}, char="firm", amount=0.15, seed=71}:mask()
grip4 = poly({{446, 424}, {456, 424}, {452, 436}, {443, 438}, {440, 432}}, true)
trig4 = ribbon({{464, 410}, {470, 413}, {471, 418}}, {3.5, 3, 2.5})
guard4 = ribbon({{466, 408}, {474, 412}, {474, 418}, {468, 420}}, 1.5)
local area = (fist3:grow(3) + gripM:grow(3) + rect(330, 418, 100, 18)) - armR2 - revolverM - tableM - torso2
local bg = area - fist4 - grip4 - trig4
work(bg, {hand="detail", tool={kind="round", width=3}, piles={
    {wallHi, function(x, y) return smoothstep(0.45, 0.85, lampLit(x, y)) * 1.5 end},
    {wallMid, function(x, y) local l = lampLit(x, y) return smoothstep(0.1, 0.4, l) * (1 - smoothstep(0.6, 0.9, l)) * 1.2 end},
    {wallDk, function(x, y) return 1 - smoothstep(0.05, 0.35, lampLit(x, y)) end}},
  coverage=4, fill=true, clip=bg, angle=0, angle_jitter=0.2, length={4, 10}})
work(grip4, {hand="detail", tool={kind="round", width=2}, piles={{hatDk, 1}, {skinSh, 0.3}}, coverage=4, fill=true, clip=grip4, angle=1.9, length={3, 6}})
work(fist4, {hand="detail", tool={kind="round", width=2.5}, piles={{skinSh, 1}, {warmD, 0.5}}, coverage=4, fill=true, clip=fist4, angle=0.2, length={3, 8}})
work(trig4, {hand="detail", tool={kind="round", width=2}, pile=skinSh, coverage=4, fill=true, clip=trig4, angle=0.5, length={2, 5}})
local rf = brush{kind="round", width=1.3, point=0.7}
rf:load(deepD, 0.5)
rf:stroke({{466, 408}, {474, 412}, {474, 418}, {468, 420}}, {pressure=0.5})
-- thumb along the top of the grip, toward the hammer
local r = brush{kind="round", width=2.6, point=0.5}
r:load(skinMid, 0.6)
r:gesture({{440, 404, 0.3}, {450, 401, 0.6}, {460, 401, 0.4}}, {clip=fist4})
-- knuckle row of the curled fingers
rf:load(warmD, 0.6)
rf:gesture({{447, 410, 0.3}, {449, 417, 0.5}, {448, 424, 0.3}}, {clip=fist4})
rf:gesture({{455, 409, 0.2}, {458, 416, 0.4}, {457, 423, 0.2}}, {clip=fist4})
-- door light on the front knuckles
rf:load(skinLit, 0.5)
rf:gesture({{463, 404, 0.2}, {466, 411, 0.5}, {465, 419, 0.3}}, {clip=fist4:grow(0.5)})

--@ chunk 131
palette{scrape={hatDk}}
sleeveLit = pile{{"Indian red", 1}, {"yellow ochre", 0.7}, {"lead white", 0.2}, name="sleeveLit"}
local arm = armR2 - torso2 - fist4
-- cover the bluish fold lines
local r = brush{kind="round", width=3.5, point=0.3}
r:load(sleeveDk, 0.7)
r:gesture({{370, 409, 0.5}, {378, 416, 0.7}, {385, 425, 0.5}}, {clip=arm})
r:load(sleeveDk, 0.7)
r:gesture({{384, 410, 0.5}, {390, 418, 0.6}}, {clip=arm})
r:load(sleeveDk, 0.7)
r:gesture({{318, 427, 0.5}, {360, 428, 0.6}, {400, 424, 0.6}, {430, 420, 0.4}}, {clip=arm})
-- the underside in shadow, warm-dark rather than blue
r:load(warmD, 0.6)
r:gesture({{320, 428, 0.4}, {360, 429, 0.5}, {400, 425, 0.5}, {428, 421, 0.3}}, {clip=arm})
-- the lamp catches the top of the sleeve, broken at the elbow
local f = brush{kind="filbert", width=4}
f:load(sleeveLit, 0.6)
f:gesture({{312, 407, 0.3}, {335, 407, 0.6}, {360, 408, 0.6}, {372, 409, 0.2}}, {clip=arm})
f:load(sleeveLit, 0.5)
f:gesture({{388, 407, 0.2}, {405, 406, 0.5}, {420, 404, 0.4}}, {clip=arm})
-- elbow fold: a soft dark wedge
r:load(warmD, 0.5)
r:gesture({{374, 408, 0.2}, {379, 415, 0.5}, {382, 424, 0.2}}, {clip=arm})
-- cuff: a slightly darker band, its edge catching light
r:load(warmD, 0.6)
r:gesture({{426, 404, 0.4}, {428, 412, 0.6}, {428, 420, 0.4}}, {clip=arm:grow(0.5)})
local rf = brush{kind="round", width=1.4, point=0.6}
rf:load(sleeveLit, 0.5)
rf:gesture({{422, 404, 0.3}, {424, 410, 0.5}}, {clip=arm})

--@ chunk 132
math.randomseed(7)
local xs = {}
for i = 0, 31 do
  local xb = 200 + 22 * i + rand(-2, 2)
  local pts = {}
  for k = 0, 6 do
    local y = 562 + k * (750 - 562) / 6
    local x = xb + (xb - 650) * (y - 560) / 160 + randn(0, 0.6)
    pts[#pts + 1] = {x, y}
  end
  xs[#xs + 1] = pts
end
floorJoints = xs
for i = 1, 8 do
  local p = floorJoints[i]
  print(i, string.format("%.0f,%.0f  %.0f,%.0f", p[5][1], p[5][2], p[7][1], p[7][2]))
end

--@ chunk 133
palette{scrape={bandP, sleeveLit}}
trDk = pile{{"bone black", 1}, {"ultramarine blue", 0.25}, {"raw umber", 1.2}, {"burnt sienna", 0.2}, name="trDk"}
bootP = pile{{"burnt sienna", 1}, {"raw umber", 1.2}, {"bone black", 0.6}, name="boot"}
shin5 = ribbon({{196, 682}, {160, 696}, {118, 706}}, {42, 34, 26})
boot5 = outline{{122, 694, "c"}, {102, 692}, {84, 686}, {72, 680, "c"}, {64, 688, "c"}, {63, 704}, {66, 718}, {72, 727, "c"}, {98, 729}, {120, 724, "c"}, char="firm", amount=0.2, seed=81}:mask()
heel5 = poly({{70, 676}, {84, 680}, {82, 692}, {66, 690}}, true)
local newLow = shin5 + boot5 + heel5
local oldLow = (bootBackM + ribbon({{225, 540}, {205, 625}, {190, 690}}, {68, 56, 44})):grow(2)
floorPatch = (oldLow - newLow:grow(0.5)) - (backLegM * rect(0, 0, 1000, 680)) - frontLegM - bootFrontM - nTorso
floorPatch = floorPatch * floorM
work(floorPatch, {hand="detail", tool={kind="filbert", width=5}, piles={{warmD, 1}, {wallMid, 0.45}}, coverage=3, fill=true, clip=floorPatch,
  angle=function(x, y) return math.atan(400 - y, 650 - x) end, angle_jitter=0.05, length={10, 30}})
local rb = brush{kind="rigger", width=2.2, point=0.6}
for i, pts in ipairs(floorJoints) do
  rb:load(deepD, 0.5)
  rb:stroke(pts, {pressure={0.3, 0.6}, ramps={0.05, 0.05}, clip=floorPatch})
end
print(floorPatch:area())

--@ chunk 134
local lowerFloor = floorPatch * mask(function(x, y) return y > 690 and 1 or 0 end)
work(lowerFloor, {hand="detail", tool={kind="filbert", width=5}, piles={{warmD, 1}, {deepD, 0.4}}, coverage=2, fill=true, clip=lowerFloor,
  angle=function(x, y) return math.atan(400 - y, 650 - x) end, angle_jitter=0.05, length={10, 30}})
work(shin5 - nTorso, {hand="detail", tool={kind="filbert", width=5}, piles={{trDk, 1}, {warmD, 0.3}}, coverage=3, fill=true, clip=shin5 - nTorso, angle=-0.3, angle_jitter=0.1, length={10, 25}})
work(boot5 + heel5, {hand="detail", tool={kind="round", width=3}, piles={{bootP, 1}, {deepD, 0.3}}, coverage=4, fill=true, clip=boot5 + heel5, angle=1.4, angle_jitter=0.3, length={4, 12}})
local r = brush{kind="round", width=2.5, point=0.5}
r:load(deepD, 0.6)
r:gesture({{120, 694, 0.4}, {118, 708, 0.6}, {120, 722, 0.3}})
r:load(deepD, 0.6)
r:gesture({{66, 688, 0.4}, {63, 704, 0.6}, {68, 722, 0.4}})
r:load(wallMid, 0.5)
r:gesture({{120, 692, 0.2}, {100, 690, 0.45}, {84, 685, 0.3}}, {clip=boot5})
r:load(warmD, 0.6)
r:gesture({{190, 666, 0.3}, {160, 680, 0.5}, {124, 692, 0.3}}, {clip=shin5})
local cs = brush{kind="filbert", width=6}
cs:load(deepD, 0.6)
cs:gesture({{214, 704, 0.4}, {180, 716, 0.6}, {140, 722, 0.5}, {100, 732, 0.4}, {70, 733, 0.2}})

--@ chunk 135
local m = ribbon({{214, 704}, {180, 716}, {140, 722}, {100, 732}, {66, 733}}, 14):soften(4) - shin5:shrink(3) - boot5:shrink(3)
blend(m, {angle=0.3})
local m2 = (shin5 + boot5 + heel5):shrink(2):soften(2)
blend(m2, {angle=-0.3})

--@ chunk 136
palette{scrape={trDk, bootP, sleeveDk, skinSh}}
floorLit = pile{{"lead white", 3}, {"yellow ochre", 2}, {"Naples yellow", 1}, {"burnt sienna", 0.2}, name="floorLit"}
floorSh = pile{{"raw umber", 2}, {"burnt sienna", 1}, {"yellow ochre", 0.6}, {"bone black", 0.3}, name="floorSh"}
local function xl(y) return 590 - 2.254 * (y - 560) end
local function xr(y) return 790 - (y - 560) end
local function soft(y) return 1 + 9 * clamp((y - 560) / 130, 0, 1) end
spillL = function(x, y)
  local s = soft(y)
  return smoothstep(xl(y) - s, xl(y) + s, x) * (1 - smoothstep(xr(y) - s, xr(y) + s, x)) * (1 - smoothstep(678, 702, y)) * smoothstep(558, 561, y)
end
local blockers = (tableM + newCowboy + bootFrontM + frontLegM):grow(1)
spillArea = (mask(function(x, y) return spillL(x, y) > 0.01 and 1 or 0 end) * floorM) - blockers
work(spillArea, {hand="body", tool={kind="filbert", width=8}, piles={{floorLit, function(x, y) return spillL(x, y) end}, {floorSh, function(x, y) return 1 - spillL(x, y) end}},
  coverage=2.5, fill=true, clip=spillArea, angle=function(x, y) return math.atan(400 - y, 650 - x) end, angle_jitter=0.04, length={15, 40}, mix_jitter=0.03})
print(spillArea:area())

--@ chunk 137
local blockers = (tableM + newCowboy + bootFrontM + frontLegM):grow(1)
local bandLow = (mask(function(x, y) local l = spillL(x, y) return (l > 0.01 and l < 0.97) and 1 or 0 end) * floorM - blockers):grow(4):soften(4) - blockers
blend(bandLow, {angle=-0.5})
blend(bandLow, {angle=0.4})
blend(bandLow, {angle=-0.5, clip=false})

--@ chunk 138
local blockers = (tableM + newCowboy + bootFrontM + frontLegM):grow(1)
local liftM = (mask(function(x, y) return spillL(x, y) > 0.001 and 1 or 0 end):grow(26) * rect(0, 530, 1000, 220)) - blockers
for i = 1, 6 do
  local r = rag{width=30}
  r:dip(0.95)
  r:wipe(liftM, {pressure=0.9, angle=(i % 2 == 1) and -0.6 or 0.6, passes=1, refold=0.3})
end
print(drying(650, 620), drying(560, 700), drying(700, 552))

--@ chunk 139
print(palette())

--@ chunk 140
spillLo = pile{{"lead white", 2}, {"yellow ochre", 2}, {"Naples yellow", 0.6}, {"burnt sienna", 0.5}, {"raw umber", 0.25}, name="spillLo"}
zsh3 = pile{{"raw umber", 2}, {"burnt sienna", 1}, {"yellow ochre", 1.4}, {"lead white", 0.5}, name="zsh3"}

--@ chunk 141
local function xl(y) return 590 - 2.254 * (y - 560) end
local function xr(y) return 790 - (y - 560) end
local function w(y) return 1.5 + 14 * clamp((y - 560) / 130, 0, 1) end
spillXL, spillXR, spillW = xl, xr, w
local blockers = (tableM + newCowboy + bootFrontM + frontLegM):grow(1)
spillBlockers = blockers
spillIn = (mask(function(x, y)
  if y < 560 or y > 690 then return 0 end
  return (x > xl(y) and x < xr(y)) and 1 or 0
end) * floorM) - blockers
spillOut = (mask(function(x, y)
  if y < 560 or y > 712 then return 0 end
  local ww = w(y) * 1.3
  local left = (x <= xl(y) and x > xl(y) - ww) and 1 or 0
  local right = (x >= xr(y) and x < xr(y) + ww) and 1 or 0
  local bottom = (y > 690 and x > xl(math.min(y, 690)) - ww and x < xr(math.min(y, 690)) + ww) and 1 or 0
  return math.max(left, right, bottom)
end) * floorM) - blockers
work(spillIn, {hand="body", tool={kind="filbert", width=8}, piles={{floorLit, function(x, y) return 1 - smoothstep(565, 640, y) end}, {spillLo, function(x, y) return smoothstep(565, 640, y) end}},
  coverage=2.5, fill=true, clip=spillIn, angle=function(x, y) return math.atan(400 - y, 650 - x) end, angle_jitter=0.04, length={15, 40}, mix_jitter=0.03})
work(spillOut, {hand="detail", tool={kind="filbert", width=5}, pile=floorSh, coverage=3, fill=true, clip=spillOut, angle=function(x, y) return math.atan(400 - y, 650 - x) end, length={8, 20}})

--@ chunk 142
local xl, xr, w = spillXL, spillXR, spillW
local band = (mask(function(x, y)
  if y < 556 or y > 716 then return 0 end
  local ww = w(y)
  local d = math.min(math.abs(x - xl(y)), math.abs(x - xr(y)))
  local e1 = (1 - smoothstep(ww * 0.7, ww, d)) * smoothstep(564, 575, y)
  local inx = (x > xl(690) - 20 and x < xr(690) + 20) and 1 or 0
  local e2 = (1 - smoothstep(12, 20, math.abs(y - 690))) * inx
  return math.max(e1, e2)
end) * floorM) - spillBlockers
blend(band, {angle=-0.6})
blend(band, {angle=0.4})
blend(band, {angle=-0.6})

--@ chunk 143
local xl, xr = spillXL, spillXR
local below = (mask(function(x, y)
  if y < 697 or y > 722 then return 0 end
  return (x > 250 and x < xr(690) + 30) and 1 or 0
end) * floorM) - spillBlockers
work(below, {hand="detail", tool={kind="filbert", width=5}, piles={{floorSh, 1}, {warmD, 0.4}}, coverage=3, fill=true, clip=below, angle=function(x, y) return math.atan(400 - y, 650 - x) end, length={8, 20}})
local band = (mask(function(x, y)
  if y < 684 or y > 706 then return 0 end
  return (x > xl(690) - 5 and x < xr(690) + 5) and (1 - smoothstep(6, 11, math.abs(y - 695))) or 0
end) * floorM) - spillBlockers
blend(band, {angle=1.57})

--@ chunk 144
print(wait(5 * 24 * 60))
local pts = {{650, 600}, {600, 660}, {720, 580}, {560, 705}, {280, 380}, {300, 345}, {380, 418}, {450, 414}, {150, 700}, {230, 360}, {330, 300}, {200, 330}, {420, 430}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 145
local keep = doorM:grow(6) + (newCowboy + hat3c + hat3b + head3 + face4 + armR2 + fist4 + revolverM + tableM + leg1M):grow(1) + lampNew:grow(3) + barM
local wall = (backM + leftwallM) - keep
local function d(x, y) return math.sqrt((x - 365)^2 + ((y - 210) * 1.05)^2) end
local function above(x, y)
  local b = 172 - 0.9 * math.max(0, math.abs(x - 365) - 30)
  return 1 - smoothstep(b - 12, b + 12, y)
end
ringA = wall * mask(function(x, y) return math.max(smoothstep(70, 115, d(x, y)), above(x, y)) end)
ringB = wall * mask(function(x, y) return math.max(smoothstep(150, 200, d(x, y)), above(x, y) * smoothstep(40, 90, d(x, y))) end)
ringC = wall * mask(function(x, y) return smoothstep(230, 290, d(x, y)) end)
work(ringA, {hand="glaze", pile=gE, coverage=1, clip=true, angle=0.3})

--@ chunk 146
figNow = hat3c + hat3b + head3 + face4 + neck3 + torso2 + armR2 + fist4 + grip4 + trig4 + band3 + knot3 + revolverM + nArmL + nHandL + backLegM + frontLegM + bootFrontM + shin5 + boot5 + heel5 + nTorso
local keep = doorM:grow(6) + (figNow + tableM + leg1M):grow(1) + lampNew:grow(3) + barM
local wall = (backM + leftwallM) - keep
local function d(x, y) return math.sqrt((x - 365)^2 + ((y - 210) * 1.05)^2) end
ghostM = (newCowboy:grow(2) * wall) * mask(function(x, y) return smoothstep(70, 115, d(x, y)) end)
print(ghostM:area())
work(ghostM, {hand="glaze", tool={kind="filbert", width=8, kind2=nil}, pile=gE, coverage=1, clip=true, angle=0.3})

--@ chunk 147
print(wait(3 * 24 * 60))
for _, p in ipairs({{500, 300}, {250, 150}, {220, 300}, {100, 400}, {560, 200}, {650, 600}, {560, 705}, {450, 414}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 148
palette{scrape={spillLo, zsh3}}
jointP = pile{{"raw umber", 1.5}, {"burnt sienna", 1}, {"bone black", 0.3}, name="joint"}
local function d(x, y) return math.sqrt((x - 365)^2 + ((y - 210) * 1.05)^2) end
local function wts(x, y)
  local dd = d(x, y)
  local hi, mid, dk
  if dd <= 80 then hi, mid, dk = 0.75, 0.25, 0
  elseif dd <= 105 then local t = (dd - 80) / 25; hi, mid, dk = lerp(0.75, 0.3, t), lerp(0.25, 0.7, t), 0
  elseif dd <= 160 then local t = (dd - 105) / 55; hi, mid, dk = lerp(0.3, 0, t), lerp(0.7, 0.6, t), lerp(0, 0.4, t)
  else hi, mid, dk = 0, 0.6, 0.4 end
  return hi, mid, dk
end
headWall = ((poly({{204, 262}, {390, 258}, {456, 300}, {456, 366}, {420, 438}, {204, 438}}, true):roughen(6, 30, 3)) * backM) - figNow:grow(0.3) - tableM:grow(0.5) - lampNew:grow(2) - railM:grow(1)
work(headWall, {hand="detail", tool={kind="filbert", width=6}, piles={
    {wallHi, function(x, y) local a = wts(x, y) return a + 0.001 end},
    {wallMid, function(x, y) local _, b = wts(x, y) return b + 0.001 end},
    {warmD, function(x, y) local _, _, c = wts(x, y) return c + 0.001 end}},
  coverage=3, fill=true, clip=headWall, angle=0, angle_jitter=0.12, length={10, 28}, mix_jitter=0.03})
local lwPart = (rect(150, 288, 52, 74) * leftwallM) - figNow:grow(0.3)
work(lwPart, {hand="detail", tool={kind="filbert", width=5}, piles={{warmD, 1}, {wallDk, 0.8}, {deepD, 0.3}}, coverage=3, fill=true, clip=lwPart, angle=1.57, length={8, 20}})

--@ chunk 149
print(wait(3 * 24 * 60))
for _, p in ipairs({{230, 300}, {170, 320}, {410, 320}, {300, 280}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 150
print(wait(3 * 24 * 60))
for _, p in ipairs({{230, 300}, {170, 320}, {410, 320}, {300, 280}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 151
local clipW = (backM - figNow:grow(1) - tableM:grow(1) - lampNew:grow(3) - railM - barM - doorM)
local rb = brush{kind="rigger", width=1.8, point=0.5}
for _, x in ipairs({213, 249, 281, 313, 350, 381, 413, 443}) do
  rb:load(jointP, 0.55)
  rb:stroke({{x, 250}, {x + 0.5, 340}, {x, 446}}, {pressure={0.45, 0.5}, ramps={0.02, 0.02}, clip=clipW * rect(196, 250, 270, 196)})
end

--@ chunk 152
for _, p in ipairs({{230, 470}, {300, 470}, {250, 600}, {340, 600}, {360, 640}, {160, 690}, {100, 710}, {260, 500}, {200, 440}, {380, 470}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 153
upperL = ribbon({{212, 418}, {232, 452}, {250, 484}}, {30, 27, 24})
foreL = ribbon({{250, 486}, {300, 478}, {350, 464}}, {24, 20, 17})
handL = outline{{346, 452, "c"}, {358, 446}, {372, 446, "c"}, {382, 452}, {386, 462, "c"}, {382, 472}, {370, 477, "c"}, {354, 475}, {346, 466, "c"}, char="firm", amount=0.15, seed=91}:mask()
local newArm = upperL + foreL + handL
local oldArm = (nArmL + nHandL):grow(2)
local exposed = oldArm - newArm:grow(0.3) - torso2 - nTorso
exposedWall = exposed - tableM
exposedTable = exposed * tableM
print(exposedWall:area(), exposedTable:area())

--@ chunk 154
palette{scrape={floorSh, jointP, floorLit}}
sleeveDk = pile{{"Indian red", 1}, {"raw umber", 0.9}, {"bone black", 0.35}, name="sleeveDk"}
skinSh = pile{{"burnt sienna", 1}, {"raw umber", 1}, {"red earth", 0.4}, name="skinSh"}
woodDk = pile{{"burnt sienna", 1}, {"raw umber", 1.4}, {"bone black", 0.35}, name="woodDk"}
sleeveLit = pile{{"Indian red", 1}, {"yellow ochre", 0.7}, {"lead white", 0.2}, name="sleeveLit"}
work(exposedWall, {hand="detail", tool={kind="round", width=3}, piles={{wallDk, 1}, {warmD, 0.6}}, coverage=4, fill=true, clip=exposedWall, angle=0, length={4, 10}})
work(exposedTable, {hand="detail", tool={kind="round", width=3}, piles={{woodDk, 1}, {warmD, 0.5}}, coverage=4, fill=true, clip=exposedTable, angle=0.1, length={4, 10}})
local arm = (upperL + foreL) - handL
work(arm, {hand="detail", tool={kind="filbert", width=5}, piles={{sleeveDk, 1}, {warmD, 0.35}}, coverage=3, fill=true, clip=arm,
  angle=function(x, y) return x < 248 and 1.05 or -0.18 end, angle_jitter=0.1, length={10, 28}})
local f = brush{kind="filbert", width=4}
local r = brush{kind="round", width=2.5, point=0.5}
-- the top of the shoulder and the top plane of the forearm catch the lamp
f:load(sleeveLit, 0.5)
f:gesture({{204, 414, 0.3}, {216, 410, 0.55}, {226, 418, 0.4}}, {clip=arm})
f:load(sleeveLit, 0.5)
f:gesture({{266, 474, 0.2}, {300, 468, 0.5}, {332, 459, 0.5}, {344, 455, 0.2}}, {clip=arm})
-- underside of the forearm and the inside of the elbow, warm dark
r:load(warmD, 0.6)
r:gesture({{258, 496, 0.4}, {300, 488, 0.6}, {340, 474, 0.4}}, {clip=arm})
r:load(deepD, 0.4)
r:gesture({{238, 470, 0.2}, {246, 484, 0.5}, {258, 494, 0.3}}, {clip=arm})
-- cuff
r:load(warmD, 0.6)
r:gesture({{338, 456, 0.4}, {341, 464, 0.6}, {343, 472, 0.4}}, {clip=arm:grow(0.5)})
-- the hand gripping the rim: knuckles over the edge, thumb along the face
work(handL, {hand="detail", tool={kind="round", width=2.5}, piles={{skinSh, 1}, {warmD, 0.35}}, coverage=4, fill=true, clip=handL, angle=0.4, length={3, 8}})
local rf = brush{kind="round", width=1.4, point=0.7}
rf:load(warmD, 0.6)
rf:gesture({{362, 452, 0.2}, {364, 461, 0.5}, {362, 470, 0.2}}, {clip=handL})
rf:gesture({{372, 450, 0.2}, {375, 459, 0.4}, {373, 468, 0.2}}, {clip=handL})
r:load(skinMid, 0.5)
r:gesture({{350, 452, 0.2}, {360, 448, 0.45}, {372, 448, 0.3}}, {clip=handL})
rf:load(skinLit, 0.45)
rf:gesture({{378, 451, 0.2}, {384, 459, 0.4}, {382, 468, 0.2}}, {clip=handL:grow(0.5)})

--@ chunk 155
local protect = (figNow + upperL + foreL + handL + tableM + leg1M + leg2M):grow(0.5) + lampNew:grow(3) + ribbon({{365, 0}, {365, 165}}, 6) + railM + barM + doorM:grow(4)
poolWall = (rect(150, 52, 440, 392) * (backM + leftwallM)) - protect
function lampLit2(x, y)
  local d = math.sqrt((x - 365)^2 + ((y - 222) * 1.1)^2)
  local fall = 1 / (1 + (d / 125)^2)
  local ax = math.abs(x - 365)
  local bnd = (ax < 39) and 177 or (177 - 0.59 * (ax - 39))
  local cone = 0.18 + 0.82 * smoothstep(bnd - 18, bnd + 18, y)
  local side = (x < 200) and 0.65 or 1
  return fall * cone * side
end
local function hat(v, a, b, c)
  if v <= a or v >= c then return 0 end
  if v <= b then return (v - a) / (b - a) end
  return (c - v) / (c - b)
end
work(poolWall, {hand="body", tool={kind="filbert", width=8}, piles={
    {wallHi, function(x, y) local l = lampLit2(x, y) return (l >= 0.8) and 1 or hat(l, 0.5, 0.8, 2) + 0.001 end},
    {wallMid, function(x, y) return hat(lampLit2(x, y), 0.25, 0.5, 0.8) + 0.001 end},
    {warmD, function(x, y) return hat(lampLit2(x, y), 0.08, 0.25, 0.5) + 0.001 end},
    {wallDk, function(x, y) local l = lampLit2(x, y) return (l <= 0.08) and 1 or hat(l, -1, 0.08, 0.25) + 0.001 end}},
  coverage=2.5, fill=true, clip=poolWall, angle=function(x, y) return x < 200 and 1.57 or 1.57 end, angle_jitter=0.06, length={18, 50}, mix_jitter=0.03})

--@ chunk 156
local bm = poolWall:shrink(2):soften(3)
blend(bm, {angle=0.785})
blend(bm, {angle=-0.785})

--@ chunk 157
local protect = (figNow + upperL + foreL + handL + tableM):grow(0.5) + lampNew:grow(3) + ribbon({{365, 0}, {365, 165}}, 6) + railM + doorM:grow(4)
local outerStrip = ((rect(118, 30, 34, 420) + rect(118, 26, 472, 28)) * (backM + leftwallM + rect(0, 0, 1000, 60))) - protect
work(outerStrip, {hand="detail", tool={kind="filbert", width=6}, piles={{wallDk, 1}, {warmD, 0.35}}, coverage=3, fill=true, clip=outerStrip, angle=1.57, angle_jitter=0.1, length={10, 30}})
local seam = (mask(function(x, y)
  local a = (1 - smoothstep(14, 26, math.abs(x - 150))) * ((y > 30 and y < 446) and 1 or 0)
  local b = (1 - smoothstep(12, 22, math.abs(y - 52))) * ((x > 120 and x < 588) and 1 or 0)
  return math.max(a, b)
end)) - protect
blend(seam, {angle=0.785})
blend(seam, {angle=-0.785})

--@ chunk 158
local tr = ((backLegM + frontLegM + shin5) - nTorso:shrink(1) - bootFrontM - boot5 - tableM)
print(drying(250, 600), drying(330, 620), drying(160, 690), drying(300, 560))
work(tr, {hand="glaze", tool={kind="filbert", width=10}, pile=gE, coverage=1, clip=true, angle=1.4})

--@ chunk 159
local spot = ellipse(290, 538, 9, 7)
work(spot, {hand="detail", tool={kind="round", width=3}, piles={{deepD, 1}, {warmD, 1}}, coverage=4, fill=true, clip=spot, angle=0.6, length={3, 8}})

--@ chunk 160
print(wait(4 * 24 * 60))
for _, p in ipairs({{135, 200}, {300, 40}, {250, 200}, {450, 300}, {300, 470}, {360, 460}, {380, 415}, {290, 538}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 161
print(wait(3 * 24 * 60))
for _, p in ipairs({{250, 200}, {450, 300}, {300, 470}, {360, 460}, {290, 538}, {200, 400}, {520, 120}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 162
local protect = (figNow + upperL + foreL + handL + tableM + leg1M + leg2M):grow(1) + lampNew:grow(4) + ribbon({{365, 0}, {365, 165}}, 6) + railM + barM + doorM:grow(3)
local roomUp = (backM + leftwallM + rect(0, 0, 1000, 56)) - protect
ringA2 = roomUp * mask(function(x, y)
  local inbox = smoothstep(96, 122, x) * (1 - smoothstep(588, 600, x)) * smoothstep(6, 30, y) * (1 - smoothstep(446, 456, y))
  local dark = 1 - smoothstep(0.22, 0.42, lampLit2(x, y))
  return inbox * dark
end)
work(ringA2, {hand="glaze", tool={kind="filbert", width=24}, pile=gE, coverage=1, clip=true, angle=1.57})

--@ chunk 163
for _, p in ipairs({{650, 580}, {600, 640}, {700, 600}, {540, 680}, {640, 690}, {530, 590}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 164
zShadow3 = (poly({{737, 557}, {729, 557}, {682, 584}, {696, 585}}, true)
  + poly({{670, 566}, {660, 566}, {636, 585}, {652, 586}}, true)
  + poly({{626, 584}, {688, 584}, {664, 604}, {642, 625}, {596, 628}, {540, 626}, {566, 610}, {598, 596}}, true)
  + ellipse(532, 633, 30, 9)
  + poly({{560, 622}, {540, 622}, {440, 624}, {438, 630}, {540, 632}}, true)
  + poly({{560, 630}, {540, 632}, {455, 634}, {453, 640}, {540, 640}}, true)):roughen(1.5, 8, 61)
zShadow3 = zShadow3 * spillIn
local soft = zShadow3:soften(1.5)
work(soft, {hand="detail", tool={kind="round", width=4}, piles={{zshadow2 or warmD, 1}, {warmD, function(x, y) return 0.5 * smoothstep(600, 570, y) end}}, coverage=4, fill=true, clip=soft,
  angle=function(x, y) return math.atan(400 - y, 949 - x) end, angle_jitter=0.1, length={6, 16}})
print(zShadow3:area())

--@ chunk 165
-- soften the shadow's far end (penumbra grows with distance from the feet)
local edgeBand = (zShadow3:grow(3) - zShadow3:shrink(3)) * mask(function(x, y) return smoothstep(590, 620, y) end) * spillIn
blend(edgeBand:soften(2), {angle=-0.6})
-- the pale blob on the table rim near the floor
local blob = ellipse(531, 588, 12, 18) * tableM:grow(4) - spillIn:shrink(1)
work(blob, {hand="detail", tool={kind="round", width=3}, piles={{woodDk, 1}, {deepD, 0.5}}, coverage=4, fill=true, clip=blob, angle=1.4, length={4, 10}})
-- the stepped notch at the end of the lintel band
local notch = rect(655, 676, 50, 30) * floorM - spillBlockers
blend(notch:soften(6), {angle=0.3})
blend(notch:soften(6), {angle=-0.6})

--@ chunk 166
local lb = (mask(function(x, y) return smoothstep(680, 692, y) * (1 - smoothstep(712, 720, y)) end) * rect(280, 670, 440, 60) * floorM) - spillBlockers
work(lb, {hand="glaze", tool={kind="filbert", width=10}, pile=gE, coverage=1, clip=true, angle=0.2})
local nt = (mask(function(x, y) return smoothstep(655, 668, x) end) * rect(640, 676, 60, 30) * floorM) - spillBlockers
work(nt, {hand="glaze", tool={kind="filbert", width=8}, pile=gE, coverage=1, clip=true, angle=-0.8})

--@ chunk 167
local m = rect(276, 666, 450, 66)
for i = 1, 3 do
  local r = rag{width=20}
  r:dip(0.95)
  r:wipe(m, {pressure=0.85, angle=(i % 2 == 1) and 0 or 1.57, passes=2, refold=0.3})
end

--@ chunk 168
local notch = (rect(663, 680, 24, 22):blur(3) * floorM) - spillBlockers
work(notch, {hand="detail", tool={kind="round", width=3}, piles={{warmD, 1}, {wallDk, 0.3}}, coverage=4, fill=true, clip=notch, angle=-0.8, length={4, 10}})

--@ chunk 169
local m = (ellipse(668, 692, 26, 18):blur(6) * floorM) - spillBlockers
blend(m, {angle=0.0})
blend(m, {angle=-0.8})
blend(m, {angle=0.8})

--@ chunk 170
print(palette())

--@ chunk 171
palette{scrape={sleeveLit}}
facP = pile{{"lead white", 5}, {"Naples yellow", 1}, {"raw umber", 0.12}, {"ultramarine blue", 0.06}, name="facade"}
local sliver = (rect(716, 331, 16, 167) - zombieM:grow(0.8)) * doorM
work(sliver, {hand="detail", tool={kind="round", width=2.5, lay=2}, pile=facP, coverage=4, fill=true, clip=sliver, angle=1.57, length={6, 16}})
local stile = poly({{731, 331}, {738, 329}, {738, 497}, {731, 497}})
work(stile, {hand="detail", tool={kind="round", width=2.5}, piles={{wallDk, 1}, {wallMid, 0.2}}, coverage=4, fill=true, clip=stile, angle=1.57, length={10, 30}})
local eb = brush{kind="round", width=1.4, point=0.5}
eb:load(wallMid, 0.5)
eb:stroke({{731.5, 334}, {731.5, 495}}, {pressure=0.4})

--@ chunk 172
-- paint the horizontal upper leg out, into the table face (above the face) and the wall (outside it)
local oldLeg = leg1M:grow(2.5) - handL - foreL - fist4 - armR2
local onFace = oldLeg * tableFace
local offFace = oldLeg - tableFace
work(onFace, {hand="detail", tool={kind="flat", width=4}, piles={{woodDk, 1}, {warmD, 0.5}}, coverage=4, fill=true, clip=onFace,
  angle=function(x, y) return math.atan(tableVP[2] - y, tableVP[1] - x) end, length={8, 20}})
work(offFace, {hand="detail", tool={kind="round", width=3}, piles={{wallDk, 1}, {warmD, 0.4}}, coverage=4, fill=true, clip=offFace, angle=0, length={4, 10}})
-- the new upper leg, sloping down to the left (it points toward us)
leg1N = ribbon({{494, 450}, {440, 466}, {392, 482}}, {10, 11, 13}) - handL - foreL
work(leg1N, {hand="detail", tool={kind="round", width=3.5}, piles={{woodDk, 1}, {warmD, 0.4}}, coverage=4, fill=true, clip=leg1N, angle=-0.32, length={8, 24}})
local g = brush{kind="round", width=2.2, point=0.4}
g:load(wallMid, 0.6)
g:gesture({{490, 446, 0.2}, {444, 461, 0.5}, {398, 476, 0.4}}, {clip=leg1N})
g:load(deepD, 0.5)
g:gesture({{492, 455, 0.2}, {444, 471, 0.5}, {398, 488, 0.4}}, {clip=leg1N})

--@ chunk 173
local m = (leg1M:grow(6) * tableFace) - leg1N:grow(1) - handL
blend(m:soften(3), {angle=-0.3})
blend(m:soften(3), {angle=1.2})

--@ chunk 174
local rb = brush{kind="round", width=2, point=0.6}
local tc = tableM:grow(0.5)
rb:load(wallHi, 0.5)
rb:gesture({{478, 426, 0.1}, {500, 438, 0.35}, {518, 468, 0.45}, {528, 505, 0.4}, {532, 540, 0.2}}, {clip=tc})
rb:load(rimP, 0.45)
rb:gesture({{531, 548, 0.1}, {533, 580, 0.45}, {530, 615, 0.5}, {522, 650, 0.4}, {508, 678, 0.25}, {494, 694, 0.05}}, {clip=tc})

--@ chunk 175
print(wait(5 * 24 * 60))
for _, p in ipairs({{650, 600}, {600, 650}, {560, 690}, {720, 580}, {300, 470}, {440, 465}, {300, 380}, {722, 400}, {530, 600}, {150, 200}, {300, 100}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 176
print(wait(4 * 24 * 60))
for _, p in ipairs({{650, 600}, {440, 465}, {530, 600}, {600, 600}, {680, 640}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 177
palette{scrape={facP}}
gW2b = pile{{"burnt sienna", 1}, {"raw umber", 0.6}, medium=0.75, name="gWarm"}
local sp = (spillIn:grow(4) * floorM) - spillBlockers
work(sp, {hand="glaze", tool={kind="filbert", width=16}, pile=gW2b, coverage=1, clip=true, angle=function(x, y) return math.atan(400 - y, 949 - x) end})
local sp2 = sp * mask(function(x, y) return smoothstep(600, 640, y) end)
work(sp2, {hand="glaze", tool={kind="filbert", width=16}, pile=gW2b, coverage=1, clip=true, angle=function(x, y) return math.atan(400 - y, 949 - x) end})
-- lift a little back near the threshold, along the boards
local near = sp * mask(function(x, y) return 1 - smoothstep(575, 610, y) end)
local r = rag{width=24}
r:dip(0.4)
r:wipe(near, {pressure=0.35, angle=function() return 0 end and 0, passes=1})

--@ chunk 178
for _, p in ipairs({{220, 430}, {300, 475}, {350, 412}, {285, 415}, {270, 380}, {300, 395}, {365, 462}, {450, 412}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 179
-- glaze the near arm (shadow side toward us) and the bandana down a step
local nearArm = (upperL + foreL) - handL
local bd = (band3 + knot3) - head3
work(nearArm, {hand="glaze", tool={kind="filbert", width=8}, pile=gE, coverage=1, clip=true, angle=0})
work(bd, {hand="glaze", tool={kind="filbert", width=6}, pile=gE, coverage=1, clip=true, angle=0})
-- the jaw/neck side of the face away from the light
local faceSh = face4 * mask(function(x, y) return 1 - smoothstep(290, 312, x) end)
work(faceSh, {hand="glaze", tool={kind="filbert", width=6}, pile=gE, coverage=1, clip=true, angle=1.3})

--@ chunk 180
palette{scrape={sleeveDk, gW2b}}
glassG = pile{{"viridian", 1}, {"bone black", 0.6}, {"raw umber", 0.4}, name="glassG"}
glassA = pile{{"burnt sienna", 1}, {"raw sienna", 0.6}, {"bone black", 0.35}, name="glassA"}
local function shelfY(y0, x) return 400 + (y0 - 400) * (x - 650) / (880 - 650) end
shelfYf = shelfY
-- shelves: thin board with lit top edge
local sb = brush{kind="flat", width=4}
local rb = brush{kind="round", width=1.4, point=0.5}
local barClip = rightwallM - barM:grow(1)
for _, y0 in ipairs({232, 292, 342}) do
  sb:load(woodDk, 0.7)
  sb:stroke({{882, shelfY(y0, 882) + 2}, {1000, shelfY(y0, 1000) + 3}}, {pressure=0.7, clip=barClip})
  rb:load(wallMid, 0.5)
  rb:stroke({{882, shelfY(y0, 882)}, {1000, shelfY(y0, 1000)}}, {pressure=0.45, clip=barClip})
end
-- bottles standing on each shelf
math.randomseed(77)
bottleList = {}
local function bottle(x, base, s, kind)
  local h = s * rand(0.85, 1.15)
  local w = s * (kind == "squat" and 0.42 or 0.3)
  local body = poly({{x - w / 2, base}, {x + w / 2, base}, {x + w / 2, base - h * 0.62}, {x + w * 0.2, base - h * 0.72}, {x - w * 0.2, base - h * 0.72}, {x - w / 2, base - h * 0.62}}, true)
  local neck = rect(x - w * 0.14, base - h, w * 0.28, h * 0.3)
  return body + neck, h, w
end
for _, y0 in ipairs({232, 292, 342}) do
  local x = 888 + rand(0, 6)
  while x < 996 do
    local base = shelfY(y0, x)
    local s = 26 * (1 + (x - 880) / 200)
    local kind = (rand(0, 1) < 0.25) and "squat" or "tall"
    local m, h, w = bottle(x, base, s, kind)
    bottleList[#bottleList + 1] = {m = m, x = x, base = base, h = h, w = w, green = rand(0, 1) < 0.45}
    x = x + w + rand(3, 9)
  end
end
print(#bottleList)

--@ chunk 181
local barClip = rightwallM - barM:grow(1)
local rf = brush{kind="round", width=1.2, point=0.7}
for i, b in ipairs(bottleList) do
  local m = b.m * barClip
  work(m, {hand="detail", tool={kind="round", width=2}, piles={{b.green and glassG or glassA, 1}, {deepD, 0.5}}, coverage=4, fill=true, clip=m, angle=1.57, length={3, 10}})
end
-- glints: a thin highlight down the left side of the body (door light), a dot at the shoulder
for i, b in ipairs(bottleList) do
  local x0 = b.x - b.w * 0.32
  if (i % 3) ~= 0 then
    rf:load(rimP, 0.4)
    rf:stroke({{x0, b.base - b.h * 0.12}, {x0, b.base - b.h * 0.55}}, {pressure={0.25, 0.5}, clip=b.m})
  end
  rf:load((i % 2 == 0) and wallHi or rimP, 0.4)
  rf:stroke({{b.x - b.w * 0.15, b.base - b.h * 0.68}, {b.x - b.w * 0.08, b.base - b.h * 0.7}}, {pressure=0.5, clip=b.m:grow(0.5)})
end

--@ chunk 182
palette{scrape={woodDk}}
gunMetal = pile{{"bone black", 1}, {"ultramarine blue", 0.2}, {"raw umber", 0.3}, name="gunMetal"}
local newBarrel = ribbon({{478, 401}, {529, 385}}, {5.2, 4.6})
local oldBarrel = ribbon({{480, 400}, {534, 396}}, 9) - newBarrel:grow(0.3) - fist4 - revolverM * rect(440, 380, 42, 40)
work(oldBarrel, {hand="detail", tool={kind="round", width=2.5}, piles={{wallDk, 1}, {warmD, 0.8}}, coverage=4, fill=true, clip=oldBarrel, angle=0, length={4, 10}})
work(newBarrel, {hand="detail", tool={kind="round", width=2.2}, pile=gunMetal, coverage=4, fill=true, clip=newBarrel, angle=-0.3, length={6, 20}})
local g = brush{kind="round", width=1.4, point=0.6}
g:load(wallHi, 0.55)
g:stroke({{482, 397.5}, {528, 383}}, {pressure={0.45, 0.6}})
-- front sight
g:load(gunMetal, 0.6)
g:stroke({{525, 383}, {526, 380.5}}, {pressure=0.6})
gunTip = {530, 385}
newBarrelM = newBarrel

--@ chunk 183
palette{scrape={glassA, gunMetal, cardP}}
floorDk = pile{{"raw umber", 2}, {"burnt sienna", 1}, {"bone black", 0.6}, name="floorDk"}
local strip = (rect(268, 698, 600, 52) * floorM) - (bootFrontM + boot5 + shin5 + tableM):grow(1)
stripM = strip
work(strip, {hand="body", tool={kind="filbert", width=8}, piles={{floorDk, 1}, {warmD, 1}}, coverage=2.5, fill=true, clip=strip,
  angle=function(x, y) return math.atan(400 - y, 650 - x) end, angle_jitter=0.04, length={20, 50}, mix_jitter=0.04})
local rb = brush{kind="rigger", width=2.2, point=0.6}
for i, pts in ipairs(floorJoints) do
  rb:load(deepD, 0.5)
  rb:stroke(pts, {pressure={0.3, 0.6}, ramps={0.05, 0.05}, clip=strip})
end

--@ chunk 184
local band = (rect(268, 684, 600, 22) * floorM) - (bootFrontM + boot5 + shin5 + tableM):grow(1)
work(band, {hand="detail", tool={kind="filbert", width=6}, piles={{warmD, function(x, y) return 0.4 + smoothstep(686, 704, y) end}, {wallMid, function(x, y) return (1 - smoothstep(684, 700, y)) * 0.8 * (1 - smoothstep(700, 760, x)) end}},
  coverage=3, fill=true, clip=band, angle=function(x, y) return math.atan(400 - y, 650 - x) end, length={10, 25}})
local bm = ((rect(268, 678, 600, 40) * floorM) - (bootFrontM + boot5 + shin5 + tableM):grow(2)):soften(4)
blend(bm, {angle=1.4})
blend(bm, {angle=0.3})
local rb = brush{kind="rigger", width=2.2, point=0.6}
for i, pts in ipairs(floorJoints) do
  rb:load(deepD, 0.45)
  rb:stroke(pts, {pressure={0.3, 0.6}, ramps={0.05, 0.05}, clip=band:grow(4) * mask(function(x, y) return y > 694 and 1 or 0 end)})
end

--@ chunk 185
local blk = (bootFrontM + boot5 + shin5 + tableM):grow(1)
local outside = ((rect(262, 680, 610, 32) * floorM) * mask(function(x, y)
  local xl, xr = spillXL(math.min(y, 690)), spillXR(math.min(y, 690))
  return (x < xl - 10 or x > xr + 14) and 1 or 0
end)) - blk
work(outside, {hand="detail", tool={kind="filbert", width=6}, piles={{floorDk, 1}, {warmD, 1}}, coverage=3, fill=true, clip=outside,
  angle=function(x, y) return math.atan(400 - y, 650 - x) end, length={10, 25}})
local inside = ((rect(262, 674, 610, 40) * floorM) * mask(function(x, y)
  local xl, xr = spillXL(690), spillXR(690)
  return (x >= xl - 10 and x <= xr + 14) and 1 or 0
end)) - blk
work(inside, {hand="detail", tool={kind="filbert", width=6}, piles={
    {wallHi, function(x, y) return (1 - smoothstep(676, 690, y)) + 0.001 end},
    {wallMid, function(x, y) local t = (y - 676) / 30 return math.max(0, 1 - math.abs(t - 0.4) * 2.5) + 0.001 end},
    {warmD, function(x, y) return smoothstep(690, 704, y) * (1 - smoothstep(704, 712, y)) + 0.001 end},
    {floorDk, function(x, y) return smoothstep(702, 712, y) + 0.001 end}},
  coverage=3, fill=true, clip=inside, angle=function(x, y) return math.atan(400 - y, 650 - x) end, length={8, 20}})
local bm = ((rect(262, 672, 610, 46) * floorM) - blk:grow(1)):soften(5)
blend(bm, {angle=1.3})
blend(bm, {angle=1.8})
blend(bm, {angle=0.2})

--@ chunk 186
local blk = (bootFrontM + boot5 + shin5 + tableM):grow(1)
local zone = (rect(262, 670, 612, 80) * floorM) - blk
for i = 1, 5 do
  local r = rag{width=26}
  r:dip(0.95)
  r:wipe(zone, {pressure=0.9, angle=(i % 2 == 1) and 0 or 1.3, passes=1, refold=0.3})
end

--@ chunk 187
local blk = (bootFrontM + boot5 + shin5 + tableM):grow(1)
lowFloor = (rect(262, 676, 612, 74) * floorM) - blk
local function lightW(x, y)
  local xl, xr = spillXL(690), spillXR(690)
  local inx = smoothstep(xl - 14, xl + 6, x) * (1 - smoothstep(xr - 6, xr + 16, x))
  return inx * (1 - smoothstep(678, 700, y))
end
work(lowFloor, {hand="body", tool={kind="filbert", width=6}, piles={
    {wallHi, function(x, y) return lightW(x, y) * 1.4 + 0.001 end},
    {wallMid, function(x, y) local l = lightW(x, y) return math.max(0, 1 - math.abs(l - 0.45) * 2.6) * 0.8 + 0.001 end},
    {warmD, function(x, y) return (1 - lightW(x, y)) * 0.8 + 0.001 end},
    {floorDk, function(x, y) return (1 - lightW(x, y)) * smoothstep(690, 720, y) + 0.001 end}},
  coverage=3, fill=true, clip=lowFloor, angle=function(x, y) return math.atan(400 - y, 650 - x) end, angle_jitter=0.03, length={10, 28}, mix_jitter=0.03})

--@ chunk 188
local blk = (bootFrontM + boot5 + shin5 + tableM):grow(2)
local tb = ((rect(262, 672, 612, 36) * floorM) - blk):soften(5)
blend(tb, {angle=1.57})
blend(tb, {angle=1.2})
blend(tb, {angle=1.9})
blend(tb, {angle=1.57})

--@ chunk 189
local blk = (bootFrontM + boot5 + shin5 + tableM):grow(1)
local zone = (rect(258, 664, 620, 86) * floorM) - blk
print(drying(500, 720), drying(600, 690), drying(300, 740))
for i = 1, 8 do
  local r = rag{width=26}
  r:dip(0.95)
  r:wipe(zone, {pressure=0.95, angle=(i % 2 == 1) and 0 or 1.3, passes=1, refold=0.25})
end

--@ chunk 190
print(wait(3 * 24 * 60))
for _, p in ipairs({{400, 720}, {600, 700}, {700, 740}, {300, 690}, {560, 640}, {578, 668}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 191
local blk = (bootFrontM + boot5 + shin5 + tableM):grow(1)
local function lampfloor(x, y)
  local d = math.sqrt((x - 330)^2 + ((y - 600) * 2.2)^2)
  return 0.9 * (1 - smoothstep(30, 260, d))
end
local function spillFade(x, y)
  local xl, xr = spillXL(688), spillXR(688)
  local inx = smoothstep(xl - 10, xl + 8, x) * (1 - smoothstep(xr - 8, xr + 12, x))
  return inx * (1 - smoothstep(672, 700, y))
end
floorZone = (rect(240, 662, 650, 88):blur(6) * floorM)
work(floorZone, {hand="body", tool={kind="filbert", width=7}, piles={
    {wallMid, function(x, y) return spillFade(x, y) * 1.6 + 0.001 end},
    {warmD, function(x, y) return (0.4 + lampfloor(x, y)) * (1 - spillFade(x, y)) + 0.001 end},
    {wallDk, function(x, y) return 0.5 * (1 - spillFade(x, y)) + 0.001 end},
    {deepD, function(x, y) return smoothstep(640, 750, y) * 0.5 * (1 - spillFade(x, y)) + 0.001 end}},
  coverage=2.5, fill=true, edge="soft", clip=-blk, angle=function(x, y) return math.atan(400 - y, 650 - x) end, angle_jitter=0.04, length={18, 45}, mix_jitter=0.03})

--@ chunk 192
local blk = (bootFrontM + boot5 + shin5 + tableM):grow(1)
local zone = (rect(232, 655, 666, 95) * floorM) - blk
for i = 1, 8 do
  local r = rag{width=30}
  r:dip(0.95)
  r:wipe(zone, {pressure=0.95, angle=(i % 2 == 1) and 0 or 1.3, passes=1, refold=0.25})
end

--@ chunk 193
print(wait(3 * 24 * 60))
for _, p in ipairs({{400, 720}, {600, 700}, {700, 740}, {300, 690}, {560, 670}, {100, 720}, {900, 720}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 194
local blk = (bootFrontM + boot5 + shin5 + tableM + frontLegM + backLegM):grow(1) + barM:grow(1)
local function lampfloor(x, y)
  local d = math.sqrt((x - 300)^2 + ((y - 610) * 2.0)^2)
  return 0.9 * (1 - smoothstep(30, 280, d))
end
local function sf(x, y)
  local xl, xr = spillXL(690), spillXR(690)
  local inx = smoothstep(xl - 12, xl + 8, x) * (1 - smoothstep(xr - 8, xr + 14, x))
  return inx * (1 - smoothstep(674, 704, y))
end
bandZone = rect(0, 668, 1000, 82):blur(5) * floorM
work(bandZone, {hand="body", tool={kind="filbert", width=7}, piles={
    {wallHi, function(x, y) local s = sf(x, y) return s * s * 1.3 + 0.001 end},
    {wallMid, function(x, y) local s = sf(x, y) return 3.2 * s * (1 - s) + lampfloor(x, y) * 0.7 * (1 - s) + 0.001 end},
    {warmD, function(x, y) return (1 - sf(x, y)) * (0.6 + lampfloor(x, y) * 0.4) + 0.001 end},
    {wallDk, function(x, y) return (1 - sf(x, y)) * 0.35 * (1 - lampfloor(x, y)) + 0.001 end},
    {deepD, function(x, y) return (1 - sf(x, y)) * smoothstep(700, 750, y) * 0.45 + 0.001 end}},
  coverage=2.5, fill=true, edge="soft", clip=-blk, angle=function(x, y) return math.atan(400 - y, 650 - x) end, angle_jitter=0.04, length={14, 36}, mix_jitter=0.03})

--@ chunk 195
local blk = (bootFrontM + boot5 + shin5 + tableM + frontLegM + backLegM):grow(2) + barM:grow(2)
local bm = (rect(0, 664, 1000, 86):blur(6) * floorM) - blk
blend(bm, {angle=0.0})
blend(bm, {angle=1.3})
blend(bm, {angle=0.0})

--@ chunk 196
print(palette())

--@ chunk 197
print(wait(4 * 24 * 60))
for _, p in ipairs({{400, 720}, {600, 700}, {700, 740}, {300, 690}, {100, 720}, {900, 720}, {50, 680}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 198
jointP = pile{{"raw umber", 1.5}, {"burnt sienna", 1}, {"bone black", 0.3}, name="joint"}
local blk = (bootFrontM + boot5 + shin5 + heel5 + tableM + frontLegM + backLegM):grow(1) + barM:grow(1)
local band = (rect(0, 664, 1000, 86) * floorM) - blk
local rb = brush{kind="rigger", width=2.2, point=0.6}
for i, pts in ipairs(floorJoints) do
  rb:load(jointP, 0.5)
  rb:stroke(pts, {pressure={0.3, 0.65}, ramps={0.05, 0.05}, clip=band})
end
-- board joints further left (beyond the original set)
for k = 1, 8 do
  local xb = 200 - 22 * k
  local pts = {}
  for j = 0, 6 do
    local y = 562 + j * (750 - 562) / 6
    pts[#pts + 1] = {xb + (xb - 650) * (y - 560) / 160, y}
  end
  rb:load(jointP, 0.5)
  rb:stroke(pts, {pressure={0.3, 0.65}, ramps={0.05, 0.05}, clip=band})
end

--@ chunk 199
palette{scrape={glassG, jointP}}
cardP = pile{{"lead white", 3}, {"Naples yellow", 0.6}, {"yellow ochre", 0.3}, name="card"}
cardDim = pile{{"lead white", 1}, {"yellow ochre", 0.8}, {"raw umber", 0.7}, {"burnt sienna", 0.2}, name="cardDim"}
local function quad(cx, cy, w, h, a, fs)
  local pts = {}
  for _, c in ipairs({{-1, -1}, {1, -1}, {1, 1}, {-1, 1}}) do
    local x, y = c[1] * w / 2, c[2] * h / 2
    local xr = x * math.cos(a) - y * math.sin(a)
    local yr = x * math.sin(a) + y * math.cos(a)
    pts[#pts + 1] = {cx + xr, cy + yr * fs}
  end
  return poly(pts)
end
cards = {
  {m = quad(574, 664, 14, 19, 0.7, 0.42), p = cardP},
  {m = quad(612, 676, 14, 19, -0.35, 0.42), p = cardP},
  {m = quad(470, 728, 18, 25, 1.15, 0.5), p = cardDim},
  {m = quad(705, 718, 17, 23, -0.8, 0.5), p = cardDim},
  {m = quad(268, 738, 18, 26, 0.3, 0.5), p = cardDim},
}
for _, c in ipairs(cards) do
  work(c.m, {hand="detail", tool={kind="round", width=2}, pile=c.p, coverage=4, fill=true, clip=c.m, angle=0.5, length={3, 8}})
end
local t = brush{kind="round", width=1.8, point=0.3}
t:load(skinLit, 0.6) t:touch(572, 663, {pressure=0.6})
t:load(deepD, 0.6) t:touch(613, 676, {pressure=0.5})
t:load(deepD, 0.6) t:touch(466, 726, {pressure=0.6})
t:load(deepD, 0.6) t:touch(475, 731, {pressure=0.5})
t:load(skinLit, 0.6) t:touch(705, 716, {pressure=0.6})
t:load(deepD, 0.6) t:touch(268, 737, {pressure=0.6})

--@ chunk 200
palette{scrape={cardP, cardDim}}
glassA = pile{{"burnt sienna", 1}, {"raw sienna", 0.6}, {"bone black", 0.35}, name="glassA"}
puddleP = pile{{"burnt sienna", 1}, {"raw sienna", 1}, {"raw umber", 0.5}, medium=0.4, name="puddle"}
local function rot(cx, cy, a, pts)
  local o = {}
  for i, p in ipairs(pts) do
    o[i] = {cx + p[1] * math.cos(a) - p[2] * math.sin(a), cy + p[1] * math.sin(a) + p[2] * math.cos(a)}
  end
  return o
end
local cx, cy, a = 448, 712, -0.22
bottleBody = poly(rot(cx, cy, a, {{-22, -8}, {-14, -9}, {-8, -6}, {-3, -9}, {18, -8}, {24, -5}, {24, 5}, {18, 8}, {-6, 8}, {-12, 5}, {-19, 8}, {-24, 3}, {-20, -2}}))
bottleNeck = poly(rot(cx, cy, a, {{23, -4}, {32, -3}, {44, -3}, {46, -4}, {48, -4}, {48, 4}, {46, 4}, {44, 3}, {32, 3}, {23, 4}}))
puddleM = outline{{470, 718, "c"}, {500, 712}, {540, 714}, {570, 722}, {560, 731}, {520, 734}, {480, 731}, {462, 726}, char="soft", amount=0.6, seed=99}:mask()
work(puddleM, {hand="detail", tool={kind="round", width=4}, piles={{puddleP, 1}, {warmD, 0.6}}, coverage=3, fill=true, clip=puddleM, angle=0.05, length={8, 20}})
work(bottleBody + bottleNeck, {hand="detail", tool={kind="round", width=2.2}, piles={{glassA, 1}, {deepD, 0.4}}, coverage=4, fill=true, clip=bottleBody + bottleNeck, angle=a, length={4, 12}})

--@ chunk 201
local g = brush{kind="round", width=1.6, point=0.7}
local function R(p) local cx, cy, a = 448, 712, -0.22 return cx + p[1] * math.cos(a) - p[2] * math.sin(a), cy + p[1] * math.sin(a) + p[2] * math.cos(a) end
local function pt(p, pr) local x, y = R(p) return {x, y, pr} end
g:load(rimP, 0.5)
g:gesture({pt({-16, -5}, 0.2), pt({4, -5.5}, 0.55), pt({20, -4.5}, 0.3)})
g:load(rimP, 0.5)
g:gesture({pt({28, -1.5}, 0.3), pt({44, -1.5}, 0.4)})
g:load(wallHi, 0.5)
g:gesture({pt({-10, 4}, 0.3), pt({12, 4.5}, 0.5)})
g:load(rimP, 0.5)
local x1, y1 = R({-22, -7})
local x2, y2 = R({-24, 2})
g:stroke({{x1, y1}, {x2, y2}}, {pressure=0.4})
math.randomseed(5)
shardList = {{402, 718, 0.5}, {414, 728, -0.6}, {392, 708, 1.1}, {426, 732, 0.2}, {496, 700, -0.3}, {380, 726, 0.9}, {438, 738, -1.0}, {512, 742, 0.4}}
for _, s in ipairs(shardList) do
  local L = rand(3, 6)
  local p1 = {s[1] - math.cos(s[3]) * L, s[2] - math.sin(s[3]) * L}
  local p2 = {s[1] + math.cos(s[3]) * L, s[2] + math.sin(s[3]) * L}
  g:load(glassA, 0.6)
  g:stroke({p1, p2}, {pressure=0.7})
  g:load((rand(0, 1) < 0.6) and rimP or wallHi, 0.5)
  g:stroke({p1, {s[1], s[2]}}, {pressure=0.45})
end
local rb = brush{kind="round", width=2.2, point=0.5}
rb:load(wallHi, 0.5)
rb:gesture({{492, 718, 0.2}, {520, 719, 0.6}, {548, 722, 0.3}}, {clip=puddleM})
rb:load(rimP, 0.45)
rb:gesture({{506, 719, 0.2}, {522, 720, 0.45}, {536, 721, 0.2}}, {clip=puddleM})

--@ chunk 202
local m = (bottleBody + bottleNeck):grow(3)
for _, s in ipairs(shardList) do m = m + ellipse(s[1], s[2], 8, 8) end
for i = 1, 3 do
  local r = rag{width=12}
  r:dip(0.95)
  r:wipe(m, {pressure=0.9, angle=(i % 2 == 1) and 0 or 1.57, passes=2, refold=0.25})
end

--@ chunk 203
local m = puddleM:grow(4) + ellipse(410, 712, 14, 8)
for i = 1, 3 do
  local r = rag{width=14}
  r:dip(0.95)
  r:wipe(m, {pressure=0.9, angle=(i % 2 == 1) and 0 or 1.57, passes=2, refold=0.25})
end

--@ chunk 204
print(wait(2 * 24 * 60))
for _, p in ipairs({{450, 712}, {520, 720}, {470, 728}, {574, 664}, {268, 738}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 205
-- cover lift residues with floor tone, board lines resumed
local zone = (rect(370, 696, 210, 54):blur(4) * floorM) - (tableM + bootFrontM):grow(1)
work(zone, {hand="detail", tool={kind="filbert", width=6}, piles={{warmD, 1}, {floorDk, 0.5}, {wallMid, 0.25}}, coverage=3, fill=true, clip=zone,
  angle=function(x, y) return math.atan(400 - y, 650 - x) end, angle_jitter=0.04, length={12, 30}, mix_jitter=0.03})
local rb = brush{kind="rigger", width=2.2, point=0.6}
for i, pts in ipairs(floorJoints) do
  rb:load(deepD, 0.45)
  rb:stroke(pts, {pressure={0.3, 0.6}, ramps={0.05, 0.05}, clip=zone})
end

--@ chunk 206
local seam = (mask(function(x, y) return (1 - smoothstep(4, 12, math.abs(y - 697))) * smoothstep(365, 385, x) * (1 - smoothstep(565, 585, x)) end) * floorM) - (tableM + bootFrontM):grow(2)
blend(seam, {angle=1.3})
blend(seam, {angle=1.8})
local sides = (mask(function(x, y) return (1 - smoothstep(4, 12, math.abs(x - 372))) + (1 - smoothstep(4, 12, math.abs(x - 578))) end) * rect(360, 696, 230, 54) * floorM) - (tableM + bootFrontM):grow(2)
blend(sides, {angle=0.3})

--@ chunk 207
palette{scrape={floorDk, skinMid}}
amberGlow = pile{{"orange chrome", 1}, {"raw sienna", 1}, {"Naples yellow", 0.6}, name="amberGlow"}
local cx, cy, a = 652, 636, -0.3
local function R(p) return {cx + p[1] * math.cos(a) - p[2] * math.sin(a), cy + p[1] * math.sin(a) + p[2] * math.cos(a)} end
local function RP(list) local o = {} for i, p in ipairs(list) do o[i] = R(p) end return o end
pool2 = outline{{606, 646, "c"}, {622, 640}, {650, 643}, {678, 641}, {694, 647}, {686, 656}, {658, 659}, {626, 660}, {608, 656}, char="soft", amount=0.5, seed=123}:mask()
work(pool2, {hand="detail", tool={kind="round", width=4}, piles={{puddleP, 1}, {warmD, 0.5}}, coverage=3, fill=true, clip=pool2, angle=0.0, length={8, 20}})
shadowB = poly(RP({{-22, 4}, {20, 4}, {24, 14}, {-18, 16}}), true):roughen(1, 6, 7)
work(shadowB, {hand="detail", tool={kind="round", width=3}, piles={{warmD, 1}, {deepD, 0.3}}, coverage=4, fill=true, clip=shadowB, angle=a, length={5, 12}})
bBody = poly(RP({{-24, -7}, {14, -8}, {20, -6}, {24, -3}, {24, 3}, {20, 6}, {14, 7}, {-24, 7}}), true)
bNeck = poly(RP({{-44, -3}, {-32, -3}, {-30, -1}, {-30, 3}, {-44, 3}}), true)
work(bBody + bNeck, {hand="detail", tool={kind="round", width=2.2}, piles={{glassA, 1}, {deepD, 0.25}}, coverage=4, fill=true, clip=bBody + bNeck, angle=a, length={4, 12}})
local g = brush{kind="round", width=3, point=0.6}
g:load(amberGlow, 0.7)
local p1, p2, p3 = R({-20, 3}), R({0, 3.5}), R({18, 3})
g:gesture({{p1[1], p1[2], 0.3}, {p2[1], p2[2], 0.7}, {p3[1], p3[2], 0.4}}, {clip=bBody})
local f = brush{kind="round", width=1.5, point=0.7}
f:load(rimP, 0.55)
local q1, q2, q3 = R({-22, -6}), R({4, -7}), R({20, -5})
f:gesture({{q1[1], q1[2], 0.3}, {q2[1], q2[2], 0.6}, {q3[1], q3[2], 0.3}})
f:load(rimP, 0.5)
f:stroke({R({-24, -6}), R({-22, -1}), R({-24, 6})}, {pressure=0.45})
f:load(rimP, 0.45)
f:stroke({R({-43, -2}), R({-31, -2})}, {pressure=0.4})
g:load(amberGlow, 0.5)
local c1, c2 = R({-6, 10}), R({8, 10})
g:gesture({{c1[1], c1[2], 0.2}, {c2[1], c2[2], 0.4}}, {clip=shadowB})
f:load(rimP, 0.45)
f:gesture({{616, 652, 0.2}, {636, 653, 0.5}, {660, 654, 0.3}}, {clip=pool2})
bottleSpot = {cx, cy}

--@ chunk 208
local m = pool2:grow(2) - bBody:grow(1) - bNeck:grow(1)
for i = 1, 3 do
  local r = rag{width=10}
  r:dip(0.95)
  r:wipe(m, {pressure=0.9, angle=(i % 2 == 1) and 0 or 1.57, passes=2, refold=0.25})
end
glareP = pile{{"lead white", 3}, {"Naples yellow", 1}, {"raw sienna", 0.5}, name="glare"}
local inner = pool2:shrink(1) - bBody:grow(1) - bNeck:grow(1) - shadowB
work(inner, {hand="detail", tool={kind="round", width=3, lay=2}, piles={{glareP, 1}, {amberGlow, 0.6}}, coverage=3, fill=true, clip=inner, angle=0.0, length={6, 16}})
local f = brush{kind="round", width=1.6, point=0.7}
f:load(rimP, 0.5)
f:gesture({{612, 650, 0.2}, {640, 651, 0.6}, {668, 650, 0.3}}, {clip=pool2})
f:load(puddleP, 0.5)
f:gesture({{610, 657, 0.2}, {640, 659, 0.45}, {672, 655, 0.2}}, {clip=pool2})

--@ chunk 209
for _, p in ipairs({{530, 385}, {560, 360}, {600, 300}, {650, 350}, {700, 400}, {560, 450}, {500, 330}, {620, 560}, {700, 600}, {480, 450}, {450, 300}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 210
print(wait(4 * 24 * 60))
for _, p in ipairs({{530, 385}, {505, 393}, {652, 636}, {640, 650}, {574, 664}, {470, 728}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 211
palette{scrape={glassA, puddleP, amberGlow, glareP, wallDk, skinSh}}
smokeG = pile{{"lead white", 3}, {"Naples yellow", 0.8}, {"yellow ochre", 0.6}, medium=0.85, name="smokeG"}
local mx, my, rot = 530, 385, -0.42
local nz = noise{seed=131, octaves=4, period=34, kind="billow", warp={60, 22}}
local protect = (figNow + upperL + foreL + handL + fist4 + newBarrelM):grow(2)
local function env(x, y)
  local dx, dy = x - mx, y - my
  local u = dx * math.cos(rot) + dy * math.sin(rot)
  local v = -dx * math.sin(rot) + dy * math.cos(rot)
  if u < -10 then return 0 end
  local w = 9 + u * 0.42
  -- the cloud is densest a little ahead of the muzzle, then thins and spreads
  return math.exp(-(v / w)^2) * math.exp(-((u - 46) / 78)^2) * smoothstep(-10, 8, u)
end
local function den(x, y) return env(x, y) * (0.3 + 0.9 * nz:at01(x, y)) end
gunSmokeM = mask(function(x, y) return den(x, y) > 0.05 and 1 or 0 end) - protect
stipple(gunSmokeM, {pile=smokeG, width=8, coverage=function(x, y) return 2.6 * den(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
local bm = gunSmokeM:grow(8):blur(8) - protect
blend(bm, {angle=rot})
blend(gunSmokeM:grow(6):blur(6) - protect, {angle=rot + 1.4})
blend(gunSmokeM:grow(6):blur(6) - protect, {angle=rot})

--@ chunk 212
flashY = pile{{"lead white", 2}, {"cadmium yellow", 1.5}, {"lemon chrome", 0.5}, name="flashY"}
flashO = pile{{"cadmium yellow", 1}, {"orange chrome", 1.2}, {"lead white", 0.6}, name="flashO"}
flashR = pile{{"orange chrome", 1}, {"vermilion", 0.6}, {"cadmium yellow", 0.3}, name="flashR"}
glowP = pile{{"cadmium red", 0.4}, {"orange chrome", 1}, {"lead white", 0.5}, {"cadmium yellow", 0.3}, name="glowP"}
local mx, my, rot = 531, 384, -0.30
local protect = (fist4 + newBarrelM + armR2):grow(1)
local function hot(x, y)
  local dx, dy = x - mx, y - my
  local u = dx * math.cos(rot) + dy * math.sin(rot) - 16
  local v = -dx * math.sin(rot) + dy * math.cos(rot)
  local d = math.sqrt((u * 0.8)^2 + v * v)
  return 1 - smoothstep(4, 46, d)
end
flashGlowM = mask(function(x, y) return hot(x, y) > 0.02 and 1 or 0 end) - protect - doorM
stipple(flashGlowM, {pile=glowP, width=7, coverage=function(x, y) return 3.0 * hot(x, y) ^ 2 end, feather=1, pressure={0.3, 0.6}, dips={30, 0.5, 0}})
blend(flashGlowM:grow(3):blur(5) - protect - doorM, {angle=rot})
blend(flashGlowM:grow(3):blur(5) - protect - doorM, {angle=rot + 1.5})

--@ chunk 213
function flash4(mx, my, sc, rot)
  local function P(a, L) return mx + math.cos(a + rot) * L, my + math.sin(a + rot) * L end
  local r = brush{kind="round", width=6 * sc, point=0.95, lay=3}
  local tongues = {{-0.5, 34}, {-0.22, 58}, {0.0, 70}, {0.2, 56}, {0.48, 36}, {-0.95, 22}, {0.9, 24}, {-1.5, 12}, {1.45, 13}}
  for _, j in ipairs(tongues) do
    local a, L = j[1], j[2] * sc
    local x1, y1 = P(a, L * 0.25)
    local x2, y2 = P(a + 0.04, L * 0.65)
    local x3, y3 = P(a - 0.02, L)
    r:reload(flashR, 0.75)
    r:gesture({{mx, my, 1.0}, {x1, y1, 0.9}, {x2, y2, 0.45}, {x3, y3, 0.0}})
  end
  local o = brush{kind="round", width=7 * sc, point=0.9, lay=4}
  for _, j in ipairs({{-0.35, 30}, {-0.1, 44}, {0.12, 48}, {0.35, 30}, {-0.8, 16}, {0.75, 17}}) do
    local a, L = j[1], j[2] * sc
    local x1, y1 = P(a, L * 0.3)
    local x2, y2 = P(a, L)
    o:reload(flashO, 0.85)
    o:gesture({{mx, my, 1.0}, {x1, y1, 0.85}, {x2, y2, 0.0}})
  end
  local y = brush{kind="round", width=9 * sc, point=0.8, lay=6}
  for _, j in ipairs({{-0.15, 26}, {0.05, 34}, {0.25, 22}}) do
    local a, L = j[1], j[2] * sc
    local x1, y1 = P(a, L * 0.4)
    local x2, y2 = P(a, L)
    y:reload(flashY, 0.95)
    y:gesture({{mx, my, 1.0}, {x1, y1, 0.9}, {x2, y2, 0.0}})
  end
  local c = brush{kind="round", width=11 * sc, point=0.5, lay=9}
  local cx1, cy1 = P(0, 10 * sc)
  local cx2, cy2 = P(0, 22 * sc)
  c:reload(skyP, 1.0)
  c:gesture({{mx, my, 1.0}, {cx1, cy1, 1.0}, {cx2, cy2, 0.0}})
  local tx, ty = P(0, 7 * sc)
  c:reload(skyP, 1.0)
  c:touch(tx, ty, {pressure=1.0})
end
flash4(533, 383, 0.75, -0.30)

--@ chunk 214
palette{scrape={glowP, flashR}}
goreP = pile{{"bone black", 1}, {"raw umber", 1}, {"Indian red", 0.6}, medium=0.45, name="gore"}
local b = brush{kind="round", width=4}
local clipZone = doorM * mask(function(x, y) return (x > 712) and 1 or 0 end) - leafR:shrink(0) - zombieM
b:load(goreP, 0.8)
print(b:spatter{at={724, 334}, toward={70, -22}, spread=0.38, force=0.55, clip=clipZone})
b:load(goreP, 0.6)
print(b:spatter{at={724, 338}, toward={45, -8}, spread=0.5, force=0.35, clip=clipZone})

--@ chunk 215
local b = brush{kind="round", width=5}
local clipZone = doorM - zombieM
b:load(goreP, 0.9)
print(b:spatter{at={722, 332}, toward={55, -38}, spread=0.45, force=0.3, clip=clipZone})
b:load(goreP, 0.9)
print(b:spatter{at={724, 336}, toward={65, -20}, spread=0.35, force=0.4, clip=clipZone})
b:load(goreP, 0.7)
print(b:spatter{at={718, 328}, toward={30, -45}, spread=0.4, force=0.25, clip=clipZone})

--@ chunk 216
local r = brush{kind="round", width=2.5, point=0.8}
local strokes = {{{724, 334}, {736, 326}}, {{725, 338}, {739, 333}}, {{723, 330}, {731, 318}}, {{726, 342}, {735, 340}}}
for _, s in ipairs(strokes) do
  r:load(goreP, 0.6)
  r:gesture({{s[1][1], s[1][2], 0.9}, {s[2][1], s[2][2], 0.0}})
end

--@ chunk 217
print(wait(6 * 24 * 60))
for _, p in ipairs({{760, 300}, {735, 330}, {550, 380}, {560, 360}, {652, 636}, {580, 400}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 218
palette{scrape={goreP}}
smokeLit2 = pile{{"lead white", 2}, {"yellow ochre", 1.5}, {"Naples yellow", 1}, {"raw sienna", 0.4}, medium=0.85, name="smokeLit2"}
local protect = (figNow + upperL + foreL + handL + fist4 + newBarrelM + tableM + leg1N):grow(2) + ellipse(548, 378, 34, 22) + doorM + zombieM:grow(2)
local function tri(x, y)
  local xl = 590 - (y - 210) * (293 / 480)
  local s1 = smoothstep(xl - 4, xl + 22, x)
  local s2 = 1 - smoothstep(589, 592, x)
  local s3 = smoothstep(206, 226, y) * (1 - smoothstep(640, 690, y))
  return s1 * s2 * s3
end
local function nearDoor(x, y) return 0.25 + 0.75 * (1 - smoothstep(0, 240, 590 - x)) end
local nz = noise{seed=211, octaves=4, period=55, kind="billow", warp={90, 30}, stretch={2.12, 2.2}}
local function den(x, y) return tri(x, y) * nearDoor(x, y) * (0.2 + 1.0 * nz:at01(x, y)) end
hazeM = mask(function(x, y) return den(x, y) > 0.05 and 1 or 0 end) - protect
stipple(hazeM, {pile=smokeLit2, width=10, coverage=function(x, y) return 2.0 * den(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}})
blend(hazeM:grow(10):blur(10) - protect, {angle=2.12})
blend(hazeM:grow(6):blur(8) - protect, {angle=0.5})

--@ chunk 219
for _, p in ipairs({{290, 380}, {300, 395}, {260, 380}, {320, 380}, {230, 450}, {300, 470}, {365, 462}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 220
palette{scrape={smokeG, smokeLit2, flashY}}
hairP = pile{{"bone black", 1}, {"raw umber", 1.5}, {"burnt sienna", 0.3}, name="hair"}
flashLit = pile{{"Naples yellow", 1}, {"orange chrome", 0.5}, {"lead white", 0.5}, {"red earth", 0.2}, name="flashLit"}
local fc = face4:grow(0.3) - hat3b
work(fc, {hand="detail", tool={kind="filbert", width=5}, piles={{skinSh, 1}, {warmD, 0.6}}, coverage=3, fill=true, clip=fc,
  angle=function(x, y) return 0.35 end, angle_jitter=0.15, length={8, 18}})
hairM5 = poly({{242, 350}, {272, 352}, {270, 368}, {264, 386}, {262, 402}, {250, 396}, {243, 375}}, true) * face4
work(hairM5, {hand="detail", tool={kind="round", width=3}, piles={{hairP, 1}, {warmD, 0.3}}, coverage=4, fill=true, clip=hairM5, angle=1.75, angle_jitter=0.25, length={5, 12}})
blend(fc:shrink(2):soften(2) - hairM5:shrink(2), {angle=0.35})

--@ chunk 221
local fc = face4:grow(0.5) - hat3b
local function G(b, p, ld, pts) b:load(p, ld) b:gesture(pts, {clip=fc}) end
local f = brush{kind="filbert", width=6}
local r = brush{kind="round", width=2.6, point=0.6}
local rf = brush{kind="round", width=1.5, point=0.75}
-- brim shadow across the brow and eye
G(f, warmD, 0.6, {{250, 357, 0.5}, {285, 358, 0.8}, {316, 360, 0.6}})
G(f, warmD, 0.4, {{288, 366, 0.3}, {305, 369, 0.5}, {316, 370, 0.3}})
-- the lit lower cheek and jaw plane (lamp and flash from the right)
G(f, skinMid, 0.45, {{296, 380, 0.3}, {306, 384, 0.55}, {312, 392, 0.4}})
-- ear: a C-shape with a lit rim
G(r, skinSh, 0.7, {{279, 368, 0.4}, {274, 377, 0.7}, {277, 388, 0.4}})
G(rf, skinMid, 0.5, {{276, 369, 0.3}, {272, 377, 0.5}, {275, 386, 0.3}})
G(rf, hairP, 0.6, {{279, 374, 0.4}, {278, 382, 0.4}})
-- eye: a squint under the brow ridge
G(rf, hairP, 0.7, {{302, 370, 0.3}, {308, 371, 0.6}, {313, 370, 0.2}})
G(rf, warmD, 0.6, {{300, 365, 0.2}, {309, 364, 0.5}, {316, 365, 0.2}})
-- nostril and the nasolabial fold
G(rf, warmD, 0.6, {{316, 385, 0.3}, {319, 387, 0.5}})
G(rf, warmD, 0.45, {{312, 384, 0.2}, {313, 391, 0.4}, {311, 397, 0.2}})
-- mustache, mouth
G(r, hairP, 0.7, {{309, 390, 0.3}, {315, 390, 0.6}, {320, 392, 0.3}})
G(rf, warmD, 0.6, {{311, 396, 0.3}, {316, 396, 0.4}})
-- stubble along the jaw (cool dark)
G(f, deepD, 0.3, {{278, 404, 0.2}, {294, 408, 0.45}, {306, 404, 0.3}})
-- flash light on the profile: brow, nose, upper lip, chin
G(rf, flashLit, 0.6, {{317, 356, 0.2}, {318, 362, 0.45}})
G(rf, flashLit, 0.65, {{319, 366, 0.3}, {323, 373, 0.6}, {327, 380, 0.7}, {327, 384, 0.3}})
G(rf, flashLit, 0.5, {{318, 391, 0.3}, {317, 395, 0.4}})
G(rf, flashLit, 0.5, {{313, 401, 0.3}, {309, 406, 0.4}, {304, 409, 0.2}})
G(r, flashLit, 0.35, {{308, 380, 0.2}, {313, 384, 0.35}})

--@ chunk 222
local fc = (face4 - hat3b):shrink(1.5):soften(2) - hairM5:shrink(1)
blend(fc, {angle=0.4})
blend(fc, {angle=1.6})

--@ chunk 223
print(wait(5 * 24 * 60))
for _, p in ipairs({{290, 380}, {300, 395}, {260, 380}, {315, 375}, {250, 370}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 224
local fc = face4:grow(0.5) - hat3b
local function G(b, p, ld, pts) b:load(p, ld) b:gesture(pts, {clip=fc}) end
local f = brush{kind="filbert", width=7}
local r = brush{kind="round", width=3, point=0.5}
local rf = brush{kind="round", width=1.8, point=0.7}
-- broad shadow under the brim: brow and eye socket (a soft wide stroke)
G(f, warmD, 0.45, {{262, 359, 0.4}, {290, 361, 0.75}, {316, 363, 0.6}})
-- the eye socket a touch darker
G(r, hairP, 0.35, {{298, 368, 0.3}, {306, 370, 0.6}, {313, 369, 0.3}})
-- warm lit cheek: wide, low pressure
G(f, skinMid, 0.35, {{294, 381, 0.2}, {304, 385, 0.45}, {312, 391, 0.3}})
-- ear (soft)
G(r, skinMid, 0.4, {{278, 369, 0.3}, {275, 377, 0.55}, {278, 386, 0.3}})
-- mustache
G(r, hairP, 0.55, {{309, 390, 0.3}, {315, 391, 0.6}, {320, 393, 0.3}})
-- stubble shadow on jaw
G(f, warmD, 0.35, {{276, 403, 0.3}, {292, 408, 0.5}, {306, 405, 0.3}})
-- flash-lit profile edge, firm and thin, broken
G(rf, flashLit, 0.55, {{319, 366, 0.25}, {323, 373, 0.5}, {326, 380, 0.6}, {326, 384, 0.25}})
G(rf, flashLit, 0.4, {{317, 395, 0.2}, {313, 401, 0.35}, {308, 406, 0.2}})

--@ chunk 225
for _, p in ipairs({{560, 300}, {560, 500}, {570, 600}, {545, 380}, {600, 330}, {640, 340}, {300, 400}, {290, 540}, {320, 600}}) do print(p[1], p[2], drying(p[1], p[2])) end
print(palette())

--@ chunk 226
palette{scrape={flashO}}
zombP = pile{{"bone black", 1}, {"raw umber", 1.2}, {"green earth", 1.2}, name="zomb"}
facP = pile{{"lead white", 5}, {"Naples yellow", 1}, {"raw umber", 0.12}, {"ultramarine blue", 0.06}, name="facade"}
armUp = ribbon({{668, 334}, {646, 330}, {626, 323}, {608, 320}}, {16, 13, 11, 9})
armLo = ribbon({{672, 352}, {650, 358}, {628, 362}, {610, 362}}, {16, 13, 10, 8})
fingers = ribbon({{610, 318}, {600, 313}}, {4, 1.5}) + ribbon({{609, 321}, {599, 321}}, {4, 1.5}) + ribbon({{609, 324}, {601, 329}}, {3.5, 1.5})
  + ribbon({{611, 360}, {601, 355}}, {4, 1.5}) + ribbon({{611, 363}, {600, 363}}, {4, 1.5}) + ribbon({{611, 366}, {602, 371}}, {3.5, 1.5})
newArms = (armUp + armLo + fingers):roughen(1, 6, 13)
local oldA = (zombieM * rect(586, 300, 70, 85)):grow(1.5)
local lightBack = (oldA - newArms - zombieM * mask(function(x, y) return x > 640 and 1 or 0 end)) * doorM
work(lightBack, {hand="detail", tool={kind="round", width=2.5, lay=2}, piles={{skyP, 1}, {facP, 0.3}}, coverage=4, fill=true, clip=lightBack, angle=0.2, length={3, 8}})
local jambFix = (oldA - doorM) * rect(570, 300, 22, 85)
work(jambFix, {hand="detail", tool={kind="round", width=2.5}, piles={{warmD, 1}, {deepD, 0.5}}, coverage=4, fill=true, clip=jambFix, angle=1.57, length={3, 8}})
work(newArms, {hand="detail", tool={kind="round", width=3}, piles={{zombP, 1}, {deepD, 0.4}}, coverage=4, fill=true, clip=newArms, angle=0.15, angle_jitter=0.2, length={4, 12}})

--@ chunk 227
local strip = (rect(590, 296, 10, 96) * doorM) - newArms
work(strip, {hand="detail", tool={kind="round", width=2.5, lay=2}, piles={{skyP, 1}, {facP, 0.3}}, coverage=4, fill=true, clip=strip, angle=1.57, length={3, 8}})
local jamb = rect(578, 296, 12, 96) - newArms
work(jamb, {hand="detail", tool={kind="round", width=2.5}, piles={{warmD, 1}, {deepD, 0.5}}, coverage=4, fill=true, clip=jamb, angle=1.57, length={4, 10}})

--@ chunk 228
for _, p in ipairs({{584, 250}, {584, 450}, {584, 540}, {700, 204}, {796, 300}, {796, 500}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 229
palette{scrape={zombP, facP, hairP}}
gW2b = pile{{"burnt sienna", 1}, {"raw umber", 0.6}, medium=0.75, name="gWarm"}
local protect = (tableM + leg1N + fist4 + newBarrelM + armR2):grow(1.5) + doorM + rect(574, 300, 18, 210)
local flashZone = ellipse(553, 377, 42, 30)
colM = (rect(500, 225, 92, 440) * (backM + floorM)) - protect - flashZone
local colSoft = colM * mask(function(x, y) return smoothstep(500, 525, x) end)
work(colSoft, {hand="glaze", tool={kind="filbert", width=14}, pile=gW2b, coverage=1, clip=true, angle=1.57})
local low = colSoft * mask(function(x, y) return smoothstep(430, 480, y) end)
work(low, {hand="glaze", tool={kind="filbert", width=14}, pile=gE, coverage=1, clip=true, angle=1.57})

--@ chunk 230
print(wait(4 * 24 * 60))
for _, p in ipairs({{560, 300}, {560, 500}, {570, 600}, {548, 378}, {600, 330}, {630, 360}, {595, 340}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 231
print(wait(4 * 24 * 60))
for _, p in ipairs({{548, 378}, {600, 330}, {630, 360}, {595, 340}, {584, 340}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 232
print(wait(5 * 24 * 60))
for _, p in ipairs({{548, 378}, {600, 330}, {630, 360}, {595, 340}, {540, 384}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 233
palette{scrape={gW2b}}
smokeW3 = pile{{"lead white", 3}, {"Naples yellow", 0.8}, {"yellow ochre", 0.8}, {"orange chrome", 0.12}, medium=0.6, name="smokeW3"}
smokeHot3 = pile{{"lead white", 2}, {"Naples yellow", 1}, {"orange chrome", 0.5}, {"yellow ochre", 0.5}, medium=0.6, name="smokeHot3"}
local mx, my, rot = 532, 384, -0.55
local nz = noise{seed=161, octaves=4, period=30, kind="billow", warp={50, 18}}
local protect = (fist4 + newBarrelM + armR2 + tableM):grow(2) + doorM:grow(-4)
local function env(x, y)
  local dx, dy = x - mx, y - my
  local u = dx * math.cos(rot) + dy * math.sin(rot)
  local v = -dx * math.sin(rot) + dy * math.cos(rot)
  if u < -6 then return 0 end
  local w = 8 + u * 0.5
  return math.exp(-(v / w)^2) * math.exp(-((u - 26) / 62)^2) * smoothstep(-6, 6, u)
end
local function den(x, y) return env(x, y) * (0.35 + 0.85 * nz:at01(x, y)) end
local function hot(x, y) local d = math.sqrt((x - mx - 12)^2 + (y - my + 5)^2) return 1 - smoothstep(10, 42, d) end
cloudM = (mask(function(x, y) return den(x, y) > 0.05 and 1 or 0 end) * rect(0, 0, 594, 750)) - protect
stipple(cloudM, {pile=smokeW3, width=8, coverage=function(x, y) return 3.4 * den(x, y) * (1 - 0.7 * hot(x, y)) end, feather=1, pressure={0.25, 0.55}, dips={30, 0.45, 0}})
stipple(cloudM, {pile=smokeHot3, width=8, coverage=function(x, y) return 3.4 * den(x, y) * hot(x, y) end, feather=1, pressure={0.25, 0.55}, dips={30, 0.45, 0}})
blend(cloudM:grow(6):blur(7) - protect, {angle=rot})
blend(cloudM:grow(4):blur(5) - protect, {angle=rot + 1.4})

--@ chunk 234
palette{scrape={smokeHot3}}
veilD = pile{{"raw umber", 1}, {"burnt sienna", 0.5}, {"yellow ochre", 0.5}, {"lead white", 0.5}, medium=0.75, name="veilD"}
local nz = noise{seed=171, octaves=4, period=26, kind="billow", warp={40, 14}}
local function env(x, y)
  -- the drifting cloud continues from the muzzle up and right across the doorway's left edge
  local dx, dy = x - 592, y - 352
  local u = dx * math.cos(-0.5) + dy * math.sin(-0.5)
  local v = -dx * math.sin(-0.5) + dy * math.cos(-0.5)
  return math.exp(-((u - 4) / 40)^2) * math.exp(-(v / 34)^2)
end
local function den(x, y) return env(x, y) * (0.3 + 0.9 * nz:at01(x, y)) end
doorVeilM = (mask(function(x, y) return den(x, y) > 0.06 and 1 or 0 end) * doorM)
stipple(doorVeilM, {pile=veilD, width=8, coverage=function(x, y) return 2.4 * den(x, y) end, feather=1, pressure={0.2, 0.45}, dips={30, 0.4, 0}})
blend(doorVeilM:grow(6):blur(6) * doorM, {angle=-0.5})
blend(doorVeilM:grow(4):blur(5) * doorM, {angle=1.0})

--@ chunk 235
veilE = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, {"yellow ochre", 0.4}, {"lead white", 0.25}, medium=0.7, name="veilE"}
local nz = noise{seed=173, octaves=4, period=28, kind="billow", warp={40, 14}}
local function env(x, y)
  local dx, dy = x - 590, y - 360
  local u = dx * math.cos(-0.5) + dy * math.sin(-0.5)
  local v = -dx * math.sin(-0.5) + dy * math.cos(-0.5)
  return math.exp(-((u - 6) / 46)^2) * math.exp(-(v / 40)^2)
end
local function den(x, y) return env(x, y) * (0.3 + 0.9 * nz:at01(x, y)) end
local m = (mask(function(x, y) return den(x, y) > 0.06 and 1 or 0 end) * doorM)
stipple(m, {pile=veilE, width=9, coverage=function(x, y) return 3.2 * den(x, y) end, feather=1, pressure={0.25, 0.5}, dips={30, 0.45, 0}})
blend(m:grow(6):blur(6) * doorM, {angle=-0.5})
blend(m:grow(4):blur(5) * doorM, {angle=1.0})

--@ chunk 236
local m = rect(588, 290, 90, 140):blur(10) * doorM
blend(m, {angle=0.3})
blend(m, {angle=-1.2})
blend(m, {angle=2.0})

--@ chunk 237
local r = rag{width=36}
r:wipe({{596, 420}, {630, 380}, {664, 336}, {690, 300}}, {pressure=0.3})
r:refold()
r:wipe({{596, 380}, {640, 340}, {672, 300}}, {pressure=0.25})
r:refold()
r:wipe({{600, 300}, {612, 360}, {606, 420}}, {pressure=0.25})

--@ chunk 238
palette{scrape={smokeW3, veilD, veilE, skinLit, skinSh, skinMid}}
sleeveDk = pile{{"Indian red", 1}, {"raw umber", 0.9}, {"bone black", 0.35}, name="sleeveDk"}
sleeveLit = pile{{"Indian red", 1}, {"yellow ochre", 0.7}, {"lead white", 0.2}, name="sleeveLit"}
flashSleeve = pile{{"Indian red", 1}, {"orange chrome", 1}, {"lead white", 0.2}, name="flashSleeve"}
brassP = pile{{"yellow ochre", 2}, {"raw sienna", 1}, {"raw umber", 0.5}, name="brass"}
trDk = pile{{"bone black", 1}, {"ultramarine blue", 0.25}, {"raw umber", 1.2}, {"burnt sienna", 0.2}, name="trDk"}
trMid = pile{{"raw umber", 1}, {"bone black", 0.5}, {"lead white", 0.35}, {"ultramarine blue", 0.15}, {"yellow ochre", 0.3}, name="trMid"}
-- 1. trousers: front leg repainted opaque, the translucent band gone
local front = upperL + foreL + handL + tableM + bootFrontM
thighM = (frontLegM - torso2:shrink(2) - front):grow(0)
work(thighM, {hand="detail", tool={kind="filbert", width=6}, piles={{trDk, 1}, {warmD, 0.35}}, coverage=3, fill=true, clip=thighM,
  angle=function(x, y) return (y < 585) and 0.6 or 1.6 end, angle_jitter=0.12, length={12, 30}})
local f = brush{kind="filbert", width=6}
-- the top plane of the thigh, faintly lit by the lamp
f:load(trMid, 0.45)
f:gesture({{286, 542, 0.2}, {310, 556, 0.45}, {334, 571, 0.4}, {348, 580, 0.15}}, {clip=thighM})
-- the knee
f:load(trMid, 0.35)
f:gesture({{338, 578, 0.2}, {350, 588, 0.4}, {354, 600, 0.15}}, {clip=thighM})
-- the table's cast shadow on the shin (the table stands between the shin and the door)
f:load(deepD, 0.4)
f:gesture({{354, 610, 0.3}, {356, 640, 0.5}, {356, 670, 0.3}}, {clip=thighM})

--@ chunk 239
-- 2. vest front edge, shirt strip, belt, holster, buckle
local front = upperL + foreL + handL
shirtStrip = poly({{284, 418}, {316, 416}, {318, 440}, {314, 470}, {308, 500}, {302, 530}, {298, 540}, {292, 540}, {290, 510}, {288, 480}, {286, 450}}, true) * torso2 - front - band3 - knot3
work(shirtStrip, {hand="detail", tool={kind="round", width=3}, piles={{sleeveDk, 1}, {warmD, 0.3}}, coverage=4, fill=true, clip=shirtStrip, angle=1.5, length={6, 14}})
local r = brush{kind="round", width=2.2, point=0.5}
r:load(deepD, 0.6)
r:gesture({{285, 424, 0.4}, {287, 450, 0.6}, {289, 465, 0.4}}, {clip=torso2 - front})
r:load(deepD, 0.6)
r:gesture({{290, 496, 0.4}, {293, 520, 0.6}, {295, 538, 0.4}}, {clip=torso2 - front})
-- door rim down the chest front under the gun arm
local rf = brush{kind="round", width=1.5, point=0.7}
rf:load(rimP, 0.4)
rf:gesture({{317, 428, 0.2}, {316, 445, 0.45}, {312, 468, 0.4}, {307, 490, 0.15}}, {clip=torso2:grow(1) - front})
-- gunbelt, dipping toward the front
beltM = ribbon({{196, 528}, {230, 535}, {265, 542}, {300, 546}}, {11, 11, 11, 10}) * torso2:grow(3)
work(beltM, {hand="detail", tool={kind="round", width=3}, piles={{warmD, 1}, {deepD, 0.6}}, coverage=4, fill=true, clip=beltM, angle=0.18, length={8, 20}})
r:load(wallMid, 0.5)
r:gesture({{200, 524, 0.2}, {232, 530, 0.45}, {268, 537, 0.4}, {290, 541, 0.2}}, {clip=beltM})
-- cartridge loops: tiny warm dots
local t = brush{kind="round", width=1.6, point=0.4}
for i = 0, 6 do
  local x = 205 + i * 10
  local y = 530 + (x - 196) * 0.19
  t:load(brassP, 0.5)
  t:touch(x, y + 1, {pressure=0.45})
end
-- buckle
buckleM = rect(286, 539, 13, 11)
work(buckleM, {hand="detail", tool={kind="round", width=2}, pile=brassP, coverage=4, fill=true, clip=buckleM, angle=0, length={3, 6}})
t:load(flashLit, 0.6) t:touch(295, 542, {pressure=0.5})
-- empty holster on the near hip, over the back thigh
holsterM = poly({{214, 538}, {244, 542}, {248, 588}, {238, 604}, {222, 600}, {216, 580}}, true)
work(holsterM, {hand="detail", tool={kind="round", width=3}, piles={{warmD, 1}, {brassP, 0.2}, {deepD, 0.3}}, coverage=4, fill=true, clip=holsterM, angle=1.5, length={6, 16}})
r:load(wallMid, 0.5)
r:gesture({{240, 545, 0.2}, {245, 568, 0.45}, {244, 590, 0.2}}, {clip=holsterM})
r:load(deepD, 0.5)
r:gesture({{218, 548, 0.2}, {218, 575, 0.4}, {224, 598, 0.2}}, {clip=holsterM})

--@ chunk 240
local paths = {
  {{286, 542}, {310, 556}, {334, 571}, {348, 580}},
  {{338, 578}, {350, 588}, {354, 600}},
}
for _, p in ipairs(paths) do
  for k = 1, 2 do
    local r = rag{width=9}
    r:dip(0.95)
    r:wipe(p, {pressure=0.9})
  end
end
local m = buckleM:grow(3) + holsterM:grow(2)
for i = 1, 3 do
  local r = rag{width=12}
  r:dip(0.95)
  r:wipe(m, {pressure=0.9, angle=(i % 2 == 1) and 0 or 1.57, passes=2, refold=0.25})
end

--@ chunk 241
local f = brush{kind="filbert", width=7}
local clipT = thighM:grow(0.5)
local paths = {
  {{284, 541}, {310, 555}, {334, 570}, {349, 581}},
  {{338, 577}, {350, 588}, {355, 601}},
  {{356, 592}, {358, 625}, {358, 660}, {356, 680}},
  {{362, 592}, {364, 625}, {364, 660}},
}
for _, p in ipairs(paths) do
  f:reload(trDk, 0.8)
  local g = {}
  for i, q in ipairs(p) do g[i] = {q[1], q[2], 0.75} end
  f:gesture(g, {clip=clipT})
end
-- the faint warm lamp light on the thigh's top plane
f:reload(warmD, 0.5)
f:gesture({{290, 545, 0.2}, {312, 557, 0.4}, {332, 569, 0.35}, {344, 577, 0.1}}, {clip=clipT})
-- holster, dark leather
work(holsterM, {hand="detail", tool={kind="round", width=3}, piles={{warmD, 1}, {deepD, 0.7}}, coverage=4, fill=true, clip=holsterM, angle=1.5, length={6, 16}})
local r = brush{kind="round", width=1.8, point=0.5}
r:load(warmD, 0.5)
r:gesture({{241, 546, 0.2}, {245, 568, 0.4}, {243, 588, 0.2}}, {clip=holsterM})
-- buckle: a dark-centred brass frame
work(buckleM, {hand="detail", tool={kind="round", width=2}, piles={{brassP, 1}, {warmD, 0.6}}, coverage=4, fill=true, clip=buckleM, angle=0, length={3, 6}})
local t = brush{kind="round", width=2.4, point=0.3}
t:load(deepD, 0.6) t:touch(292, 545, {pressure=0.5})
local tf = brush{kind="round", width=1.4, point=0.5}
tf:load(flashLit, 0.5) tf:touch(297, 541, {pressure=0.5})

--@ chunk 242
deltoidM = poly({{196, 412}, {210, 402}, {226, 404}, {236, 416}, {240, 436}, {236, 452}, {222, 446}, {206, 432}}, true) * (torso2:grow(2) + upperL)
work(deltoidM, {hand="detail", tool={kind="filbert", width=5}, piles={{sleeveDk, 1}, {warmD, 0.3}}, coverage=3, fill=true, clip=deltoidM, angle=1.0, angle_jitter=0.3, length={6, 16}})
local f = brush{kind="filbert", width=6}
local r = brush{kind="round", width=2.6, point=0.5}
local armC = deltoidM + upperL + foreL
-- lamp light over the shoulder cap and down the top of the upper arm
f:load(sleeveLit, 0.5)
f:gesture({{200, 414, 0.2}, {212, 405, 0.5}, {226, 406, 0.5}, {235, 416, 0.25}}, {clip=armC})
r:load(sleeveLit, 0.4)
r:gesture({{230, 420, 0.2}, {238, 440, 0.4}, {246, 462, 0.3}, {252, 476, 0.1}}, {clip=armC})
-- elbow: the inside crease dark, the outer bend turning
r:load(deepD, 0.5)
r:gesture({{252, 470, 0.2}, {256, 480, 0.5}, {262, 488, 0.2}}, {clip=armC})
r:load(warmD, 0.5)
r:gesture({{232, 486, 0.2}, {242, 496, 0.45}, {256, 498, 0.2}}, {clip=armC})
-- lamp band along the top of the hunched back (vest)
local vc = torso2 - armC - band3 - knot3 - shirtStrip
f:load(wallMid, 0.45)
f:gesture({{238, 401, 0.2}, {252, 397, 0.45}, {268, 398, 0.3}}, {clip=vc})
f:load(warmD, 0.5)
f:gesture({{198, 430, 0.2}, {194, 450, 0.3}, {192, 470, 0.15}}, {clip=vc})
-- flash light on the gun forearm: front half glows, fades toward the elbow
local fa = armR2 - torso2 - fist4
f:load(flashSleeve, 0.55)
f:gesture({{392, 409, 0.15}, {410, 406, 0.4}, {424, 405, 0.55}, {430, 406, 0.4}}, {clip=fa})
r:load(flashSleeve, 0.5)
r:gesture({{404, 418, 0.15}, {420, 417, 0.4}, {430, 416, 0.3}}, {clip=fa})
r:load(flashLit, 0.45)
r:gesture({{418, 405, 0.15}, {428, 404, 0.4}, {432, 407, 0.2}}, {clip=fa})
-- and on the top of the fist
r:load(flashLit, 0.45)
r:gesture({{446, 401, 0.15}, {458, 400, 0.45}, {465, 404, 0.2}}, {clip=fist4})

--@ chunk 243
print(wait(6 * 24 * 60))
for _, p in ipairs({{300, 380}, {310, 370}, {470, 400}, {500, 393}, {365, 175}, {350, 200}, {900, 650}, {290, 545}, {220, 420}, {420, 408}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 244
local profileBand = face4 - face4:offset(-5)
local inner = (face4 - hat3b) * mask(function(x, y) return (x > 284 and y > 374) and 1 or 0 end) - profileBand
print(inner:area())
work(inner, {hand="glaze", tool={kind="filbert", width=6}, pile=gE, coverage=1, clip=true, angle=0.4})

--@ chunk 245
local m = face4:grow(1) - hat3b
for i = 1, 3 do
  local r = rag{width=12}
  r:dip(0.95)
  r:wipe(m, {pressure=0.9, angle=(i % 2 == 1) and 0.4 or 1.8, passes=2, refold=0.3})
end

--@ chunk 246
print(palette())

--@ chunk 247
palette{scrape={trMid, flashSleeve, sleeveLit}}
faceHalf = pile{{"burnt sienna", 1}, {"raw umber", 1}, {"red earth", 0.5}, {"yellow ochre", 0.3}, name="faceHalf"}
faceDk = pile{{"raw umber", 1.2}, {"burnt sienna", 0.6}, {"bone black", 0.5}, name="faceDk"}
local fc = face4 - hat3b
local profileBand = face4 - face4:offset(-4)
-- lower face halftone (covers the pink bars), keeping the lit profile edge
local lower = fc * mask(function(x, y) return (y > 372) and 1 or 0 end) - profileBand - hairM5
work(lower, {hand="detail", tool={kind="filbert", width=5}, piles={{faceHalf, 1}, {faceDk, 0.35}}, coverage=3, fill=true, clip=lower, angle=0.3, angle_jitter=0.2, length={6, 14}})
-- the brim's shadow over the upper face: dark, with a soft lower edge
local upper = fc * mask(function(x, y) return 1 - smoothstep(366, 374, y) end) - hairM5
work(upper, {hand="detail", tool={kind="filbert", width=5}, piles={{faceDk, 1}, {faceHalf, 0.3}}, coverage=3, fill=true, clip=upper, angle=0.1, angle_jitter=0.15, length={8, 16}})

--@ chunk 248
print(wait(5 * 24 * 60))
print(drying(300, 385), drying(300, 362), drying(255, 380))

--@ chunk 249
print(wait(3 * 24 * 60))
print(drying(300, 385), drying(300, 362), drying(255, 380), drying(316, 375))

--@ chunk 250
hairP = pile{{"bone black", 1}, {"raw umber", 1.5}, {"burnt sienna", 0.3}, name="hair"}
local fc = face4:grow(0.5) - hat3b
local function G(b, p, ld, pts) b:load(p, ld) b:gesture(pts, {clip=fc}) end
local f = brush{kind="filbert", width=5}
local r = brush{kind="round", width=2.4, point=0.6}
local rf = brush{kind="round", width=1.3, point=0.8}
-- the brow: a hard angle down toward the nose over a dark socket
G(r, hairP, 0.7, {{296, 364, 0.3}, {306, 367, 0.6}, {314, 371, 0.5}})
-- socket
G(f, faceDk, 0.5, {{298, 371, 0.3}, {306, 373, 0.5}, {312, 374, 0.3}})
-- the narrow slit of the eye, with a tiny warm glint from the flash
G(rf, hairP, 0.75, {{302, 374, 0.3}, {308, 375, 0.6}, {313, 374, 0.3}})
local t = brush{kind="round", width=1.2, point=0.5}
t:load(flashLit, 0.6) t:touch(311, 374, {pressure=0.4})
-- cheekbone just behind the nose: the widest light, small
G(f, faceHalf, 0.5, {{304, 380, 0.2}, {310, 382, 0.4}, {314, 384, 0.2}})
G(rf, flashLit, 0.35, {{308, 379, 0.2}, {313, 381, 0.4}})
-- the ear in shadow, a C with a faint lit rim
G(r, faceHalf, 0.6, {{279, 370, 0.4}, {275, 378, 0.65}, {278, 387, 0.4}})
G(rf, faceDk, 0.6, {{280, 374, 0.3}, {279, 383, 0.3}})
-- mustache and a firm closed mouth
G(r, hairP, 0.65, {{309, 390, 0.3}, {315, 390, 0.6}, {320, 392, 0.3}})
G(rf, faceDk, 0.6, {{311, 397, 0.3}, {316, 397, 0.45}})
-- stubble and jaw shadow
G(f, faceDk, 0.35, {{274, 401, 0.2}, {290, 407, 0.45}, {304, 405, 0.25}})
-- the profile light: brow ridge, nose, mustache tip, chin (narrow, broken)
G(rf, flashLit, 0.6, {{318, 362, 0.2}, {319, 367, 0.4}})
G(rf, flashLit, 0.65, {{320, 370, 0.3}, {324, 376, 0.55}, {327, 381, 0.6}, {327, 384, 0.2}})
G(rf, flashLit, 0.45, {{320, 391, 0.2}, {321, 393, 0.35}})
G(rf, flashLit, 0.5, {{314, 400, 0.25}, {310, 405, 0.4}, {305, 408, 0.2}})

--@ chunk 251
palette{scrape={brassP, trDk, sleeveDk}}
gunMetal = pile{{"bone black", 1}, {"ultramarine blue", 0.2}, {"raw umber", 0.3}, name="gunMetal"}
local ax, ay = math.cos(-0.30), math.sin(-0.30)
local function P(u, v) return {470 + u * ax - v * ay, 398 + u * ay + v * ax} end
cylM = poly({P(-6, -6), P(10, -7), P(12, -4), P(12, 4), P(10, 6), P(-6, 6), P(-8, 0)}, true)
hammerM = poly({P(-12, -4), P(-8, -6), P(-14, -12), P(-17, -11), P(-12, -6)}, true)
local gm = cylM + hammerM
work(gm, {hand="detail", tool={kind="round", width=2}, pile=gunMetal, coverage=4, fill=true, clip=gm, angle=-0.3, length={3, 8}})
local rf = brush{kind="round", width=1.2, point=0.7}
rf:load(flashLit, 0.5)
rf:stroke({P(-3, -5), P(9, -5.5)}, {pressure=0.45})
rf:load(deepD, 0.5)
rf:stroke({P(-2, 1), P(9, 1)}, {pressure=0.4})
rf:load(wallHi, 0.4)
rf:stroke({P(-15, -11), P(-12, -8)}, {pressure=0.4})
rf:load(deepD, 0.6)
rf:stroke({{486, 395.5}, {500, 391.5}}, {pressure=0.5})
rf:load(flashLit, 0.6)
rf:stroke({{514, 387.3}, {527, 383.2}}, {pressure=0.55})

--@ chunk 252
local ring = lampNew:grow(10) - lampNew:grow(0.3) - ribbon({{365, 0}, {365, 162}}, 3)
local above = ring * mask(function(x, y) return 1 - smoothstep(174, 180, y) end)
local below = ring * mask(function(x, y) return smoothstep(174, 180, y) end)
work(above, {hand="detail", tool={kind="round", width=3}, piles={{warmD, 1}, {wallMid, 0.25}}, coverage=4, fill=true, clip=above, angle=0, length={4, 10}})
work(below, {hand="detail", tool={kind="round", width=3}, piles={{wallHi, 1}, {wallMid, 0.35}}, coverage=4, fill=true, clip=below, angle=1.0, angle_jitter=0.5, length={4, 10}})
blend((lampNew:grow(14) - lampNew:grow(1)):soften(3), {angle=0.8})
blend((lampNew:grow(14) - lampNew:grow(1)):soften(3), {angle=-0.8})

--@ chunk 253
local band = (lampNew:grow(24) - lampNew:grow(6)):blur(6) - lampNew:grow(1)
blend(band, {angle=0.6})
blend(band, {angle=-0.6})
blend(band, {angle=1.57})

--@ chunk 254
print(drying(900, 655), drying(960, 715))
local railZone = ribbon({{835, 588}, {900, 656}, {995, 752}}, 16) * mask(function(x, y) return smoothstep(850, 930, x) end)
work(railZone, {hand="glaze", tool={kind="filbert", width=10}, pile=gE, coverage=1, clip=true, angle=0.8})
local railZone2 = ribbon({{900, 656}, {995, 752}}, 16) * mask(function(x, y) return smoothstep(910, 970, x) end)
work(railZone2, {hand="glaze", tool={kind="filbert", width=10}, pile=gE, coverage=1, clip=true, angle=0.8})

--@ chunk 255
for _, p in ipairs({{620, 340}, {600, 350}, {548, 378}, {560, 360}, {595, 300}}) do print(p[1], p[2], drying(p[1], p[2])) end
print(palette())

--@ chunk 256
flashY = pile{{"lead white", 2}, {"cadmium yellow", 1.5}, {"lemon chrome", 0.5}, name="flashY"}
flashO = pile{{"cadmium yellow", 1}, {"orange chrome", 1.2}, {"lead white", 0.6}, name="flashO"}
local mx, my, rot = 533, 383, -0.30
local function P(a, L) return {mx + math.cos(a + rot) * L, my + math.sin(a + rot) * L} end
local o = brush{kind="round", width=9, point=0.8, lay=4}
for _, j in ipairs({{-0.42, 26}, {-0.16, 40}, {0.06, 46}, {0.3, 34}, {0.62, 20}, {-0.8, 16}}) do
  local a, L = j[1], j[2]
  local p1, p2, p3 = P(a, L * 0.3), P(a + 0.03, L * 0.65), P(a, L)
  o:reload(flashO, 0.9)
  o:gesture({{mx + 1, my, 1.0}, {p1[1], p1[2], 0.95}, {p2[1], p2[2], 0.6}, {p3[1], p3[2], 0.0}})
end
local y = brush{kind="round", width=11, point=0.7, lay=6}
for _, j in ipairs({{-0.12, 30}, {0.1, 34}, {-0.4, 16}, {0.38, 18}}) do
  local a, L = j[1], j[2]
  local p1, p2 = P(a, L * 0.4), P(a, L)
  y:reload(flashY, 1.0)
  y:gesture({{mx, my, 1.0}, {p1[1], p1[2], 0.9}, {p2[1], p2[2], 0.0}})
end
local c = brush{kind="round", width=12, point=0.5, lay=10}
local c1, c2 = P(0, 9), P(0, 20)
c:reload(skyP, 1.0)
c:gesture({{mx, my, 1.0}, {c1[1], c1[2], 1.0}, {c2[1], c2[2], 0.0}})
local t = P(0, 6)
c:reload(skyP, 1.0)
c:touch(t[1], t[2], {pressure=1.0})

--@ chunk 257
palette{scrape={flashY, flashO, gunMetal}}
gW2b = pile{{"burnt sienna", 1}, {"raw umber", 0.6}, medium=0.75, name="gWarm"}
local cloud = (ellipse(612, 352, 34, 46) + ellipse(640, 318, 30, 26) + ellipse(600, 408, 22, 30)):roughen(4, 20, 9)
local vm = cloud * doorM - zombieM - newArms
doorGlazeM = vm
work(vm, {hand="glaze", tool={kind="filbert", width=12}, pile=gW2b, coverage=1, clip=true, angle=-0.5})
blend((vm:grow(6) - vm:shrink(10)):blur(4) * doorM - zombieM:grow(1) - newArms:grow(1), {angle=-0.5})
blend((vm:grow(6) - vm:shrink(10)):blur(4) * doorM - zombieM:grow(1) - newArms:grow(1), {angle=1.0})

--@ chunk 258
local m = doorGlazeM:grow(8):blur(6) * doorM - zombieM:grow(1) - newArms:grow(1)
blend(m, {angle=-0.5})
blend(m, {angle=1.07})
blend(m, {angle=-0.5})

--@ chunk 259
for _, p in ipairs({{193, 440}, {194, 460}, {196, 425}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 260
local m = ribbon({{196, 426}, {194, 446}, {192, 464}}, 9)
local r = brush{kind="round", width=5, point=0.3}
r:load(warmD, 0.7)
r:gesture({{196, 426, 0.6}, {194, 446, 0.7}, {192, 464, 0.6}}, {clip=m})
r:load(hairP, 0.5)
r:gesture({{196, 428, 0.4}, {194, 446, 0.5}, {192, 462, 0.4}}, {clip=m})

--@ chunk 261
print(wait(10 * 24 * 60))
local pts = {{300, 380}, {548, 378}, {560, 350}, {612, 352}, {290, 545}, {230, 570}, {350, 600}, {365, 200}, {470, 398}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 262
palette{scrape={gW2b}}
floorLit = pile{{"lead white", 3}, {"yellow ochre", 2}, {"Naples yellow", 1}, {"burnt sienna", 0.2}, name="floorLit"}
local excl = zShadow3:grow(0.6) + tableM:grow(1) + bBody:grow(1) + bNeck:grow(1) + pool2:grow(1) + shadowB:grow(1)
for _, c in ipairs(cards) do excl = excl + c.m:grow(1) end
local soft = mask(function(x, y) return 1 - smoothstep(596, 610, x) end)
spillFix = (spillIn * rect(470, 558, 142, 114) * soft) - excl
work(spillFix, {hand="detail", tool={kind="filbert", width=5}, piles={
    {floorLit, function(x, y) return 1 - smoothstep(562, 580, y) + 0.001 end},
    {wallHi, function(x, y) return smoothstep(562, 580, y) + 0.001 end}},
  coverage=3, fill=true, clip=spillFix, angle=function(x, y) return math.atan(400 - y, 949 - x) end, angle_jitter=0.05, length={10, 26}, mix_jitter=0.03})

--@ chunk 263
print(wait(4 * 24 * 60))
print(drying(540, 600), drying(580, 640), drying(560, 570))

--@ chunk 264
print(wait(4 * 24 * 60))
print(drying(540, 600), drying(580, 640), drying(560, 570), drying(548, 378))

--@ chunk 265
print(wait(4 * 24 * 60))
print(drying(540, 600), drying(580, 640), drying(560, 570), drying(548, 378))

--@ chunk 266
gW2b = pile{{"burnt sienna", 1}, {"raw umber", 0.6}, medium=0.75, name="gWarm"}
local excl = tableM:grow(1) + bBody:grow(1) + bNeck:grow(1) + pool2:grow(1)
local g1 = (spillIn * rect(470, 558, 160, 114) * mask(function(x, y) return 1 - smoothstep(598, 618, x) end)) - excl
work(g1, {hand="glaze", tool={kind="filbert", width=10}, pile=gW2b, coverage=1, clip=true, angle=function(x, y) return math.atan(400 - y, 949 - x) end})

--@ chunk 267
local band = (spillIn * mask(function(x, y) return 1 - smoothstep(4, 14, math.abs(x - 603)) end) * rect(560, 558, 80, 114)) - (bBody + bNeck + pool2):grow(1)
blend(band, {angle=-0.6})
blend(band, {angle=0.4})

--@ chunk 268
veilDk = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, {"bone black", 0.15}, medium=0.6, name="veilDk"}
local excl = (tableM + bBody + bNeck + pool2 + shadowB):grow(1)
for _, c in ipairs(cards) do excl = excl + c.m:grow(1.5) end
local zone = (rect(466, 640, 190, 50) * floorM) - excl
local function cov(x, y)
  local xr = spillXR(math.min(y, 690))
  return 2.6 * smoothstep(648, 676, y) * (1 - smoothstep(xr - 30, xr, x))
end
stipple(zone, {pile=veilDk, width=8, coverage=cov, feather=1, pressure={0.25, 0.5}, dips={30, 0.4, 0}})
blend(zone:grow(4):blur(5) - excl, {angle=1.4})
blend(zone:grow(4):blur(5) - excl, {angle=0.2})

--@ chunk 269
palette{scrape={faceHalf, faceDk, gW2b, veilDk}}
sigP = pile{{"Indian red", 1}, {"raw umber", 0.5}, medium=0.2, name="sig"}
local s = brush{kind="rigger", width=1.6, point=0.8}
s:load(sigP, 0.6)
s:gesture({{958, 722, 0.2}, {950, 719, 0.5}, {945, 726, 0.6}, {948, 734, 0.5}, {957, 735, 0.2}})
s:load(sigP, 0.6)
s:gesture({{962, 735, 0.5}, {966, 723, 0.5}, {970, 735, 0.5}, {974, 723, 0.4}})

--@ chunk 270
print(wait(20 * 24 * 60))
local pts = {{548, 378}, {540, 660}, {960, 728}, {612, 352}, {300, 380}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 271
print(drying(620,350), drying(650,400), drying(300,380), drying(560,620), drying(500,720), drying(700,400))
print(palette())

--@ chunk 272
for _, n in ipairs({"zombieM","newArms","fingers","doorM","doorLightM","skyP","facP","streetP","wallDk","warmD","deepD","wallHi","wallMid","glazeDk","doorVeilM","doorGlazeM","hazeM","gunSmokeM","cloudM","zombP","flashGlowM","leafM","leafR","tableM"}) do
  local v = _G[n]
  local s = tostring(v)
  if v ~= nil and type(v) ~= "table" and v.area then s = s .. " area=" .. string.format("%.0f", v:area()) end
  print(n, s)
end

--@ chunk 273
for _, p in ipairs({{595,350},{595,420},{595,480},{610,420},{620,450},{640,300},{612,300},{630,420},{600,520},{584,350},{575,390}}) do
  local c = probe and nil
end
print("x")

--@ chunk 274
headNew = outline{
  {657, 289}, {665, 291}, {670, 296}, {672, 304}, {670, 311}, {668, 316, "c"},
  {673, 322}, {681, 328, "c"}, {686, 342}, {650, 344}, {634, 328},
  {628, 319, "c"}, {632, 317}, {645, 314, "c"}, {632, 310, "c"}, {634, 307, "c"},
  {628, 304, "c"}, {635, 300}, {638, 298, "c"}, {635, 295, "c"}, {642, 291}, 
  char="firm", amount=0.4, seed=41}:mask()
print(headNew:area())

--@ chunk 275
headNew = outline{
  {674, 318, "c"}, {676, 304}, {671, 292}, {660, 284}, {647, 282}, {636, 286}, {629, 292},
  {625, 297, "c"}, {628, 300, "c"}, {624, 304}, {618, 308, "c"}, {625, 309, "c"}, {626, 311, "c"},
  {637, 313, "c"}, {629, 317, "c"}, {627, 322, "c"}, {642, 328}, {660, 331}, 
  char="firm", amount=0.35, seed=41}:mask()
print(headNew:area())

--@ chunk 276
headNew = outline{
  {683, 313}, {682, 302}, {676, 293}, {667, 288}, {656, 287}, {647, 290}, {641, 296},
  {639, 301, "c"}, {642, 304, "c"}, {637, 311, "c"}, {642, 313, "c"}, {643, 316, "c"},
  {651, 318, "c"}, {644, 321, "c"}, {643, 328}, {650, 332}, {664, 332}, {676, 327},
  char="firm", amount=0.3, seed=43}:mask()
print(headNew:area())

--@ chunk 277
headNew = outline{
  {683, 314}, {683, 303}, {678, 294}, {669, 289}, {657, 288}, {648, 291}, {642, 297},
  {640, 301, "c"}, {643, 304, "c"}, {638, 310, "c"}, {643, 312, "c"}, {644, 315, "c"},
  {651, 318, "c"}, {643, 323, "c"}, {642, 329, "c"}, {648, 333}, {662, 333}, {676, 328},
  char="firm", amount=0.3, seed=43}:mask()
-- the leaf sliver at the door's left edge below y~390, and the body
leafSliver = rect(588, 388, 11, 120)
zBody = zombieM * mask(function(x, y) return (x > 645 and y > 330) and 1 or 0 end)
hazeZone = ((doorVeilM + doorGlazeM):grow(5) + rect(625, 280, 40, 50)) * doorM - newArms - headNew - zBody - leafSliver
print(hazeZone:area(), newArms:area())

--@ chunk 278
palette{scrape={sigP, hairP}}
zombP = pile{{"bone black", 1}, {"raw umber", 1.2}, {"green earth", 1.2}, name="zomb"}
facP = pile{{"lead white", 5}, {"Naples yellow", 1}, {"raw umber", 0.12}, {"ultramarine blue", 0.06}, name="facade"}
veilA = pile{{"lead white", 2}, {"raw umber", 0.5}, {"yellow ochre", 0.6}, {"burnt sienna", 0.2}, medium=0.6, name="veilA"}
-- 1. arms: dark at the shoulder, veiled toward the fingertips
local function tv(x, y) return 1.4 * (1 - smoothstep(598, 662, x)) end
work(newArms, {hand="detail", tool={kind="round", width=3}, piles={{zombP, 1}, {deepD, 0.3}, {veilA, tv}}, coverage=4, fill=true, clip=newArms, angle=0.15, angle_jitter=0.2, length={4, 12}})
-- 2. head: new ragged skull with a hanging jaw
work(headNew, {hand="detail", tool={kind="round", width=3}, piles={{zombP, 1}, {deepD, 0.4}}, coverage=4, fill=true, clip=headNew, angle=0.5, angle_jitter=0.4, length={4, 10}})
-- 3. door light repainted around the head and over the old lace
headAround = (rect(632, 282, 64, 50) * doorM) - headNew - zBody - newArms
lightZone = hazeZone + headAround
local function wsky(x, y) return 1 - smoothstep(282, 296, y) end
local function wfac(x, y) return smoothstep(282, 296, y) end
work(lightZone, {hand="body", tool={kind="filbert", width=8, lay=2.5}, piles={{skyP, wsky}, {facP, wfac}, {skyP, 0.6}}, coverage=2.5, fill=true, clip=lightZone, angle=1.57, angle_jitter=0.2, length={10, 26}})
print(drying(620, 400), drying(660, 310))

--@ chunk 279
headNew2 = outline{
  {686, 316}, {686, 304}, {681, 295}, {672, 289}, {661, 287}, {651, 290}, {645, 295},
  {642, 301, "c"}, {645, 304, "c"}, {638, 311, "c"}, {644, 313, "c"}, {642, 317, "c"},
  {649, 320, "c"}, {644, 324, "c"}, {645, 334, "c"}, {652, 335}, {662, 336}, {668, 342},
  {676, 336}, {684, 328},
  char="broken", amount=0.45, seed=47}:mask()
print(headNew2:area())

--@ chunk 280
headNew2 = outline{
  {688, 312}, {688, 302}, {684, 295}, {676, 289}, {666, 286.5}, {656, 288}, {648, 292}, {643, 297},
  {640, 302, "c"}, {644, 305, "c"}, {636, 312, "c"}, {642, 314, "c"}, {641, 317, "c"},
  {649, 319, "c"}, {643, 325, "c"}, {645, 335, "c"}, {653, 336}, {661, 337}, {667, 344},
  {677, 338}, {684, 326},
  char="firm", amount=0.5, seed=53}:mask()
print(headNew2:area())

--@ chunk 281
local liftM = ((headNew - headNew2) + (headNew2 - headNew)):grow(1) * doorM
for i = 1, 3 do
  local r = rag{width=8}
  r:dip(0.95)
  r:wipe(liftM, {pressure=0.9, angle=(i == 2) and 1.57 or 0.2, passes=1})
end
print(drying(690, 305), drying(640, 312))

--@ chunk 282
local liftM = ((headNew - headNew2) + (headNew2 - headNew)):grow(1) * doorM
for i = 1, 4 do
  local r = rag{width=8}
  r:dip(0.95)
  r:wipe(liftM, {pressure=0.95, angle=({0.2, 1.57, 0.9, -0.6})[i], passes=1, refold=0.4})
end

--@ chunk 283
headF = outline{
  {664, 289}, {675, 292}, {683, 299}, {686, 309}, {684, 320}, {679, 329}, {678, 338}, {684, 346, "c"},
  {664, 350, "c"}, {661, 341}, {655, 342, "c"}, {646, 340, "c"}, {644, 333}, {646, 327, "c"},
  {652, 321, "c"}, {643, 316, "c"}, {644, 313, "c"}, {636, 311, "c"}, {642, 305, "c"}, {640, 302, "c"},
  {645, 296}, {652, 291},
  char="firm", amount=0.3, seed=59}:mask()
print(headF:area())

--@ chunk 284
local a = (headNew - headF) * doorM
local b = (headF - headNew) * doorM
print(a:area(), b:area())

--@ chunk 285
local addDark = ((headF - headNew) * doorM):grow(0.5)
for i = 1, 3 do
  local r = rag{width=6}
  r:dip(0.95)
  r:wipe(addDark, {pressure=0.95, angle=({0.2, 1.57, -0.7})[i], passes=1, refold=0.35})
end
local cutLight = ((headNew - headF) * doorM)
for i = 1, 2 do
  local r = rag{width=6}
  r:dip(0.95)
  r:wipe(cutLight, {pressure=0.95, angle=({0.2, 1.57})[i], passes=1, refold=0.35})
end
work(cutLight:grow(0.5) - headF, {hand="detail", tool={kind="round", width=2.5, lay=2.5}, piles={{skyP, 1}, {facP, 1}}, coverage=5, fill=true, clip=cutLight:grow(0.5) - headF, angle=1.57, length={3, 8}})
work(headF, {hand="detail", tool={kind="round", width=2.5}, piles={{zombP, 1}, {deepD, 0.4}}, coverage=5, fill=true, clip=headF, angle=0.5, angle_jitter=0.4, length={3, 9}})

--@ chunk 286
local armBody = newArms * mask(function(x, y) return x > 618 and 1 or 0 end)
for i = 1, 4 do
  local r = rag{width=8}
  r:dip(0.95)
  r:wipe(armBody, {pressure=0.95, angle=({0.15, 1.57, 0.6, -0.5})[i], passes=1, refold=0.35})
end

--@ chunk 287
local function tv(x, y) return 0.7 * (1 - smoothstep(600, 628, x)) end
work(newArms, {hand="detail", tool={kind="round", width=2.5}, piles={{zombP, 1}, {deepD, 0.3}, {veilA, tv}}, coverage=5, fill=true, clip=newArms, angle=0.15, angle_jitter=0.15, length={4, 12}})

--@ chunk 288
rimZ = mix{{facP, 1}, {zombP, 0.5}, name="rimZ"}
local b = brush{kind="round", width=2, point=0.9}
b:load(rimZ, 0.5)
-- skull rim: just inside the top/back contour
b:gesture({{651, 293, 0.1}, {659, 290, 0.35}, {669, 290.5, 0.4}, {678, 295, 0.35}, {683, 302, 0.25}, {685, 310, 0.1}}, {clip=headF:shrink(0.3)})
b:load(rimZ, 0.4)
-- shoulder rim (right shoulder top)
b:gesture({{690, 352, 0.05}, {702, 347, 0.25}, {716, 344, 0.3}, {730, 347, 0.2}, {737, 352, 0.05}}, {clip=zombieM:shrink(0.3)})
print(drying(700, 346))

--@ chunk 289
local p1 = {{651, 293}, {659, 290}, {669, 290.5}, {678, 295}, {683, 302}, {685, 310}}
local p2 = {{690, 352}, {702, 347}, {716, 344}, {730, 347}, {737, 352}}
for i = 1, 3 do
  local r = rag{width=5}; r:dip(0.95)
  r:wipe(p1, {pressure=0.9})
  local r2 = rag{width=5}; r2:dip(0.95)
  r2:wipe(p2, {pressure=0.9})
end
local band1 = ribbon(p1, 5) * headF
work(band1, {hand="detail", tool={kind="round", width=2}, piles={{zombP, 1}, {deepD, 0.4}}, coverage=5, fill=true, clip=band1, angle=0.5, length={3, 7}})

--@ chunk 290
local b = brush{kind="rigger", width=1.6, point=0.9}
b:load(zombP, 0.6)
local tufts = {
  {{676, 294, 0.6}, {683, 293, 0.4}, {689, 296, 0.0}},
  {{680, 299, 0.6}, {687, 301, 0.35}, {692, 306, 0.0}},
  {{682, 305, 0.6}, {689, 310, 0.3}, {691, 317, 0.0}},
  {{682, 311, 0.6}, {687, 318, 0.3}, {688, 325, 0.0}},
  {{670, 290, 0.5}, {677, 287, 0.3}, {683, 287.5, 0.0}},
  {{679, 316, 0.5}, {683, 324, 0.25}, {682, 331, 0.0}},
}
for i, t in ipairs(tufts) do
  b:gesture(t, {wobble=0.6})
  if i % 3 == 0 then b:load(zombP, 0.6) end
end

--@ chunk 291
-- torn shirt flaps hanging at the waist and a ragged sleeve stub, in the door light
flaps = poly({{668, 440}, {663, 452}, {661, 466}, {664, 470}, {667, 458}, {671, 450}}) 
      + poly({{671, 452}, {669, 470}, {672, 478}, {674, 466}, {676, 455}})
      + poly({{667, 362}, {659, 366}, {655, 373}, {660, 372}, {664, 369}, {668, 368}})
flaps = flaps:roughen(0.8, 5, 61) * doorM
work(flaps, {hand="detail", tool={kind="round", width=2}, piles={{zombP, 1}, {deepD, 0.4}}, coverage=5, fill=true, clip=flaps, angle=1.57, length={3, 8}})
-- flash light glancing on the chest's front edge (dim orange half-tone)
flashZ = mix{{flashLit, 1}, {zombP, 1.2}, name="flashZ"}
local b = brush{kind="round", width=2.2, point=0.9}
b:load(flashZ, 0.45)
b:gesture({{671, 366, 0.05}, {670, 378, 0.35}, {669, 392, 0.35}, {669, 405, 0.2}, {670, 414, 0.0}}, {clip=zombieM:shrink(0.6), wobble=0.4})
b:load(flashZ, 0.35)
b:gesture({{646, 324, 0.05}, {647, 330, 0.3}, {650, 336, 0.2}, {655, 340, 0.0}}, {clip=headF:shrink(0.6), wobble=0.3})

--@ chunk 292
local l1 = {{671, 366}, {670, 378}, {669, 392}, {669, 405}, {670, 414}}
local l2 = {{646, 324}, {647, 330}, {650, 336}, {655, 340}}
local l3 = {{690, 352}, {702, 347}, {716, 344}, {730, 347}, {737, 352}}
for i = 1, 3 do
  for _, l in ipairs({l1, l2, l3}) do
    local r = rag{width=5}; r:dip(0.95)
    r:wipe(l, {pressure=0.95})
  end
end
print(drying(670, 390), drying(710, 346))

--@ chunk 293
local fix = (ribbon({{646, 322}, {647, 330}, {650, 336}, {656, 341}}, 5) * headF) + (ribbon({{688, 353}, {702, 347}, {716, 344}, {730, 347}, {739, 353}}, 5) * zombieM) + (ribbon({{671, 364}, {670, 378}, {669, 392}, {669, 405}, {670, 416}}, 5) * zombieM)
work(fix, {hand="detail", tool={kind="round", width=2}, piles={{zombP, 1}, {deepD, 0.4}}, coverage=5, fill=true, clip=fix, angle=0.4, length={3, 7}})

--@ chunk 294
print(drying(610, 350), drying(600, 300), drying(620, 430), drying(585, 350))
local nz = noise{seed=71, period=40, octaves=3, kind="billow"}
local cx, cy, a = 596, 352, -0.55
smokeDoor = function(x, y)
  local u, v = x - cx, y - cy
  local along = u * math.cos(a) + v * math.sin(a)
  local across = -u * math.sin(a) + v * math.cos(a)
  local e = math.exp(-((along / 85)^2 + (across / 55)^2) * 1.6)
  return e * (0.55 + 0.6 * nz:at01(x, y))
end
local figure = (headF + zombieM + newArms + flaps):grow(1)
doorHaze = (rect(588, 270, 110, 200) * doorM) - figure - leafSliver
stipple(doorHaze, {pile=veilA, width=10, coverage=function(x, y) return 2.6 * smokeDoor(x, y) end, feather=1, pressure={0.2, 0.5}, dips={30, 0.4, 0}, clip=doorHaze})
local bl = doorHaze:shrink(1.5)
blend(bl, {angle=-0.55}); blend(bl, {angle=1.0})

--@ chunk 295
local rows = {}
for y = 270, 470, 8 do
  local s = string.format("%3d ", y)
  for x = 584, 704, 4 do
    local d = drying(x, y)
    s = s .. (d == "open" and "." or d == "setting" and "S" or d == "tacky" and "t" or "d")
  end
  print(s)
end

--@ chunk 296
kS = knife{width=8}
kS:scrape({{612, 392}, {612, 450}}, {pressure=1, angle=0})
print(drying(612, 410), drying(612, 440))

--@ chunk 297
local b = brush{kind="round", width=4}
b:load(facP, 0.8)
b:touch(609, 392, {pressure=0.7})
print(drying(609, 392))

--@ chunk 298
local b = brush{kind="round", width=3}
b:load(facP, 0.6)
b:stroke({{625, 400}, {625, 440}}, {pressure=0.5})
print(drying(625, 420))

--@ chunk 299
local r = rag{width=12}
r:wipe({{612, 388}, {612, 455}}, {pressure=0.9})
print(r, drying(612, 420))

--@ chunk 300
local m = rect(620, 400, 10, 10)
work(m, {hand="detail", tool={kind="round", width=2.5}, pile=facP, coverage=3, fill=true, clip=m, angle=1.57, length={3, 6}})
print(drying(625, 405))

--@ chunk 301
print(dry, glaze, fix, erase)
local names = {}
for k, v in pairs(_G) do if type(v) == "function" then names[#names+1] = k end end
table.sort(names)
print(table.concat(names, " "))

--@ chunk 302
print("no-op")

--@ chunk 303
print(type(dry), type(glaze), type(drying), type(wait))
print(drying(609,392), drying(400,300))
