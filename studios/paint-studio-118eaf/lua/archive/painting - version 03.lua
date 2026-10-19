-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{size=900, aspect=1.4, linen={16,14}, seed=4471,
  ground={
    {pile={{"lead white", 10}, {"bone black", 0.2}}, um=120, apply="knife", texture=0.3},
    {pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, um=40, apply="brush", texture=0.5},
  }}
print(W, H)

--@ chunk 2
draw_p = pile{{"burnt sienna", 2}, {"raw umber", 1}, turps=0.5, name="drawing"}
db = brush{kind="round", width=3.5, point=0.7, stiffness=0.5}
db:load(draw_p, 0.7)
function g(pts, pr)
  local q = {}
  for i, p in ipairs(pts) do q[i] = {p[1], p[2], p[3] or pr or 0.5} end
  if db:fullness() < 0.3 then db:load(draw_p, 0.7) end
  db:gesture(q, {wobble=1.5})
end
-- horizon & mesas
g({{0,478},{180,474},{360,480},{540,476}}, 0.4)
g({{540,476},{580,440},{640,432},{690,436},{720,470},{800,474},{840,448},{900,444},{930,470},{1000,466}}, 0.4)
-- cowboy hat
g({{178,246},{210,238},{240,240},{275,238},{304,246}}, 0.6)
g({{212,238},{214,205},{230,192},{248,198},{262,193},{268,236}}, 0.6)
-- head / jaw
g({{222,248},{224,275},{238,292},{256,288},{266,265},{266,248}}, 0.45)
-- torso & coat
g({{215,300},{248,296},{282,306}}, 0.5)
g({{212,300},{196,360},{180,450},{150,540},{118,610}}, 0.55)
g({{282,310},{290,380},{288,440},{300,520},{312,592}}, 0.55)
g({{118,610},{180,600},{240,604},{312,592}}, 0.45)
-- gun arm
g({{276,312},{320,322},{360,333},{400,340},{430,344}}, 0.55)
g({{272,338},{320,346},{360,352},{405,356},{430,356}}, 0.45)
-- hand & gun
g({{428,340},{446,336},{452,350},{440,360},{428,356}}, 0.5)
g({{446,336},{494,332}}, 0.5)
g({{446,343},{494,339}}, 0.5)
-- legs
g({{252,470},{280,530},{296,590},{305,680}}, 0.5)
g({{205,470},{190,540},{178,600},{158,682}}, 0.5)
g({{290,680},{318,684},{340,696},{290,700}}, 0.5)
g({{148,680},{176,684},{196,698},{144,700}}, 0.5)
print(db:fullness())

--@ chunk 3
-- zombie: recoiling, head thrown back, one arm reaching toward cowboy, other flung back
g({{770,296},{790,302},{796,322},{786,340},{768,342},{756,328},{758,306},{770,296}}, 0.45)   -- head tilted back
g({{770,342},{764,356}}, 0.45) -- neck
g({{742,360},{766,352},{794,358}}, 0.5)                -- shoulders
g({{742,362},{748,410},{760,460}}, 0.5)                -- front of torso
g({{794,360},{800,410},{786,462}}, 0.5)                -- back of torso
g({{746,364},{714,362},{688,352},{668,344}}, 0.5)       -- reaching arm
g({{660,336},{668,344},{662,352}}, 0.4)                -- clawed hand
g({{794,360},{820,336},{836,306},{846,290}}, 0.5)      -- flung arm
g({{764,462},{742,520},{730,560},{722,606}}, 0.5)      -- front leg
g({{784,464},{800,525},{812,560},{822,602}}, 0.5)      -- back leg
-- graves
g({{620,540},{622,598}}, 0.5) g({{606,556},{636,554}}, 0.5)
g({{880,520},{874,590}}, 0.5) g({{860,538},{896,542}}, 0.5)
g({{955,555},{946,640}}, 0.5) g({{928,578},{972,582}}, 0.5)
g({{560,575},{566,620}}, 0.4) g({{548,588},{578,586}}, 0.4)
g({{740,616},{790,600},{860,606},{900,622}}, 0.4)        -- mound of the open grave
-- flash center marker
g({{500,330},{520,322}}, 0.3) g({{502,352},{524,358}}, 0.3)
print(db:fullness())

--@ chunk 4
s_glow = pile{{"lead white", 6}, {"Naples yellow", 2}, {"cadmium yellow", 0.5}, name="glow"}
s_orange = pile{{"lead white", 3}, {"orange chrome", 1}, {"Naples yellow", 1}, name="orange"}
s_rose = pile{{"lead white", 3}, {"vermilion", 0.35}, {"rose madder", 0.6}, {"Naples yellow", 0.4}, name="rose"}
s_violet = pile{{"lead white", 2}, {"ultramarine blue", 0.7}, {"rose madder", 0.5}, {"raw umber", 0.1}, name="violet"}
s_deep = pile{{"ultramarine blue", 1}, {"Prussian blue", 0.12}, {"lead white", 0.7}, {"rose madder", 0.25}, {"raw umber", 0.25}, name="deep"}
g_dark = pile{{"raw umber", 2}, {"ultramarine blue", 1}, {"burnt sienna", 1}, {"bone black", 0.3}, name="earth_dark"}
print(palette())

--@ chunk 5
-- horizon / land shapes
horizon_pts = {{0,478},{120,474},{260,478},{400,476},{540,478},{1000,474}}
mesa_pts = {{530,480},{548,470},{566,446},{580,438},{620,434},{660,432},{690,436},{706,450},{722,470},{790,474},{820,466},{838,450},{860,444},{905,442},{922,452},{938,468},{1000,468},{1000,500},{530,500}}
land = below(horizon_pts)
mesas = poly(mesa_pts)
sky_m = -(land + mesas)
-- cowboy
cb_hat = poly({{186,250},{205,241},{221,238},{221,214},{226,202},{238,196},{252,203},{266,196},{275,205},{279,236},{296,240},{314,248},{300,255},{260,258},{220,257},{196,256}}, true)
cb_head = poly({{228,254},{270,254},{276,264},{283,272},{278,278},{279,286},{273,294},{258,298},{244,296},{234,284},{228,270}}, true)
cb_neck = poly({{238,284},{266,290},{272,312},{236,310}}, true)
cb_coat = poly({{236,296},{212,304},{200,340},{194,390},{186,440},{170,500},{150,555},{124,610},{152,616},{182,606},{212,612},{242,598},{272,602},{304,588},{300,540},{298,490},{296,450},{295,410},{292,368},{288,332},{282,312},{268,302}}, true)
cb_arm = ribbon({{272,318},{320,328},{356,336},{400,342},{430,346}}, {34,30,27,25,23})
cb_hand = poly({{428,336},{444,334},{454,338},{456,348},{450,358},{438,360},{428,356}}, true)
cb_gun = ribbon({{448,337},{474,335},{498,333}}, {7,6.5,6}) + ellipse(456,340,8,6) + poly({{440,342},{452,340},{448,364},{436,364}}, true)
cb_legF = ribbon({{262,540},{288,585},{298,630},{304,676}}, {38,34,28,25})
cb_legB = ribbon({{205,540},{192,585},{176,630},{160,676}}, {38,34,28,25})
cb_bootF = poly({{290,664},{318,666},{322,680},{344,690},{346,700},{288,702},{288,690}}, true)
cb_bootB = poly({{148,662},{176,664},{178,682},{198,692},{200,702},{140,702},{142,688}}, true)
cowboy = cb_hat + cb_head + cb_neck + cb_coat + cb_arm + cb_hand + cb_gun + cb_legF + cb_legB + cb_bootF + cb_bootB
print(cowboy:area(), sky_m:area(), land:area())

--@ chunk 6
zb_head = poly({{776,286},{792,282},{806,290},{812,304},{810,320},{800,330},{792,338},{780,336},{774,324},{770,308}}, true)
zb_jaw = poly({{772,322},{782,330},{780,344},{770,342},{766,332}}, true)
zb_neck = ribbon({{790,330},{782,350}}, {16,18})
zb_torso = poly({{758,352},{784,344},{806,348},{816,372},{818,412},{810,448},{806,474},{768,476},{766,446},{760,410},{754,374}}, true)
zb_armF = ribbon({{764,358},{740,356},{718,352},{698,344},{682,336}}, {18,16,14,12,11})
zb_handF = poly({{686,328},{672,326},{660,322},{664,330},{656,332},{666,336},{660,342},{672,342},{684,344}}, false)
zb_armB = ribbon({{804,354},{822,336},{836,316},{846,298}}, {18,15,13,11})
zb_handB = poly({{842,300},{846,284},{852,276},{850,288},{858,280},{856,292},{852,302}}, false)
zb_legF = ribbon({{776,470},{760,505},{748,540},{742,580},{738,618}}, {26,22,18,15,14})
zb_legB = ribbon({{798,470},{808,505},{816,545},{826,585},{836,614}}, {26,22,18,15,14})
zb_footF = poly({{730,612},{744,612},{746,628},{716,630},{718,622}}, true)
zb_footB = poly({{828,608},{842,608},{856,622},{852,630},{830,628}}, true)
zombie = zb_head + zb_jaw + zb_neck + zb_torso + zb_armF + zb_handF + zb_armB + zb_handB + zb_legF + zb_legB + zb_footF + zb_footB
-- graves
crosses = ribbon({{600,548},{603,606}}, 6) + ribbon({{586,562},{618,559}}, 5)
        + ribbon({{886,524},{880,598}}, 7) + ribbon({{866,542},{902,546}}, 6)
        + ribbon({{962,552},{953,648}}, 9) + ribbon({{934,576},{982,582}}, 8)
        + ribbon({{548,580},{552,616}}, 4) + ribbon({{538,592},{564,590}}, 4)
mound = poly({{700,632},{730,618},{780,604},{840,602},{890,610},{920,628},{880,640},{780,642}}, true)
print(zombie:area(), crosses:area(), mound:area())

--@ chunk 7
cb_coat = poly({{236,296},{212,304},{200,340},{194,390},{184,440},{166,495},{140,548},{100,600},{122,604},{140,598},{160,612},{184,602},{208,614},{236,600},{262,606},{290,594},{314,592},{306,540},{300,490},{296,450},{295,410},{292,368},{288,332},{282,312},{268,302}}, true)
cowboy = cb_hat + cb_head + cb_neck + cb_coat + cb_arm + cb_hand + cb_gun + cb_legF + cb_legB + cb_bootF + cb_bootB
zb_head = poly({{812,336},{817,320},{812,305},{802,298},{790,298},{782,302},{781,307},{773,307},{778,313},{776,317},{786,321},{774,330},{776,337},{788,339},{792,350},{806,348}}, true)
zb_torso = poly({{788,348},{772,362},{765,382},{772,412},{781,446},{788,478},{794,494},{800,486},{806,498},{812,484},{818,494},{825,478},{823,450},{831,420},{835,385},{827,360},{808,343}}, true)
zb_sleeveF = poly({{786,358},{770,366},{758,374},{750,386},{756,384},{760,392},{766,384},{772,386},{790,376}}, true)
zb_armF = ribbon({{768,372},{752,380},{736,374},{722,368},{710,364}}, {14,11,9,8,7}) + ellipse(752,379,6,6)
zb_armB = ribbon({{804,362},{786,356},{770,352},{752,344},{734,336},{720,330}}, {15,13,11,9,8,7}) + ellipse(770,352,6,6)
zb_handF = poly({{714,358},{702,357},{690,352},{696,360},{684,364},{696,367},{690,375},{704,371},{714,370}}, false)
zb_handB = poly({{724,323},{712,320},{700,313},{705,323},{693,327},{706,331},{700,339},{714,336},{724,336}}, false)
zb_legF = ribbon({{796,478},{786,505},{776,532},{773,572},{770,612}}, {24,19,15,12,11}) + ellipse(777,532,9,8)
zb_legB = ribbon({{816,478},{824,505},{832,530},{841,566},{850,600}}, {24,19,15,12,11}) + ellipse(832,531,9,8)
zb_feet = poly({{764,606},{778,606},{780,624},{748,628},{750,618}}, true) + poly({{844,594},{858,594},{870,610},{866,620},{844,618}}, true)
zombie = zb_head + zb_torso + zb_sleeveF + zb_armF + zb_armB + zb_handF + zb_handB + zb_legF + zb_legB + zb_feet
crosses = ribbon({{600,548},{603,606}}, 6) + ribbon({{586,562},{618,559}}, 5)
        + ribbon({{906,520},{900,596}}, 7) + ribbon({{886,538},{922,542}}, 6)
        + ribbon({{964,552},{955,648}}, 9) + ribbon({{936,576},{984,582}}, 8)
        + ribbon({{548,580},{552,616}}, 4) + ribbon({{538,592},{564,590}}, 4)
mound = poly({{716,636},{744,622},{790,610},{850,606},{896,614},{924,630},{884,644},{790,646}}, true)
figures = cowboy + zombie
print(zombie:area(), mound:area())

--@ chunk 8
li_glow = pile{{"lead white", 5}, {"Naples yellow", 2}, {"cadmium yellow", 0.8}, turps=0.4, name="li_glow"}
li_orange = pile{{"lead white", 2}, {"orange chrome", 1.2}, {"vermilion", 0.2}, {"Naples yellow", 0.6}, turps=0.4, name="li_orange"}
li_rose = pile{{"lead white", 2}, {"vermilion", 0.5}, {"rose madder", 0.5}, {"raw umber", 0.15}, turps=0.4, name="li_rose"}
li_violet = pile{{"lead white", 1.2}, {"ultramarine blue", 0.8}, {"rose madder", 0.5}, {"raw umber", 0.3}, turps=0.4, name="li_violet"}
li_deep = pile{{"ultramarine blue", 1}, {"Prussian blue", 0.15}, {"lead white", 0.35}, {"rose madder", 0.2}, {"raw umber", 0.45}, turps=0.4, name="li_deep"}
local function e(x, y) return math.sqrt(((x-760)/1.7)^2 + (y-485)^2) end
local function bump(v, a, b, c, d) return smoothstep(a, b, v) * (1 - smoothstep(c, d, v)) end
sky_piles = {
  {li_glow,   function(x, y) return 1 - smoothstep(50, 110, e(x,y)) end},
  {li_orange, function(x, y) return bump(e(x,y), 50, 110, 150, 210) end},
  {li_rose,   function(x, y) return bump(e(x,y), 150, 210, 250, 330) end},
  {li_violet, function(x, y) return bump(e(x,y), 250, 330, 360, 460) end},
  {li_deep,   function(x, y) return smoothstep(360, 460, e(x,y)) end},
}
sky_angle = function(x, y) return math.atan(-(x-760)/(1.7^2), (y-485)) end
work(sky_m - figures:shrink(4), {hand="broad", piles=sky_piles, angle=function(x,y) return math.atan((y-485)*1.7^2, -(x-760)) + math.pi/2 end, coverage=1.3, seed=11})

--@ chunk 9
sky_angle = function(x, y)
  local a = math.atan((x-760)/2.89, -(y-485))
  if a > math.pi/2 then a = a - math.pi elseif a < -math.pi/2 then a = a + math.pi end
  return clamp(a * 0.45, -0.45, 0.45)
end
print(sky_angle(200, 300), sky_angle(900, 300), sky_angle(760, 100), sky_angle(100, 470))
work(sky_m, {hand="broad", piles=sky_piles, angle=sky_angle, coverage=1.6, fill=true, clip=true, seed=12})

--@ chunk 10
li_land_dk = pile{{"raw umber", 2}, {"burnt sienna", 1}, {"ultramarine blue", 1}, {"bone black", 0.2}, turps=0.4, name="li_land_dk"}
li_land_md = pile{{"raw umber", 1.5}, {"burnt sienna", 1}, {"ultramarine blue", 0.6}, {"rose madder", 0.3}, {"lead white", 0.8}, turps=0.4, name="li_land_md"}
li_mesa = pile{{"ultramarine blue", 0.8}, {"rose madder", 0.5}, {"raw umber", 1}, {"lead white", 0.9}, turps=0.4, name="li_mesa"}
work(mesas - land, {hand="body", pile=li_mesa, coverage=2, angle=0, clip=true, seed=21})
work(land, {hand="broad", piles={{li_land_dk, function(x,y) return smoothstep(480, 600, y) + 0.2 end}, {li_land_md, function(x,y) return 1 - smoothstep(480, 600, y) end}}, angle=function(x,y) return 0.05*math.sin(x/90) end, coverage=1.8, fill=true, clip=true, seed=22})

--@ chunk 11
li_fig = pile{{"raw umber", 1.5}, {"ultramarine blue", 1}, {"bone black", 0.5}, {"burnt sienna", 0.5}, turps=0.35, name="li_fig"}
work(cowboy, {hand="body", pile=li_fig, coverage=2.2, clip=true, seed=31})
work(zombie + mound, {hand="detail", pile=li_fig, coverage=2.2, clip=true, seed=32})
work(crosses, {hand="detail", pile=li_fig, coverage=2, clip=true, seed=33})

--@ chunk 12
print(drying(100,100), drying(760,450), drying(400,600), drying(240,450), drying(800,400))

--@ chunk 13
print(wait(24*60))
print(drying(100,100), drying(760,450), drying(400,600), drying(240,450), drying(800,400), drying(600,300), drying(900,600))

--@ chunk 14
print(wait(2*24*60))
print(drying(100,100), drying(760,450), drying(400,600), drying(240,450), drying(800,400), drying(600,300), drying(900,600))

--@ chunk 15
print(wait(2*24*60))
print(drying(240,450), drying(800,400), drying(230,220), drying(300,650), drying(760,520))

--@ chunk 16
palette{clean=true}
sk_glow = pile{{"lead white", 6}, {"Naples yellow", 2}, {"cadmium yellow", 0.35}, name="sk_glow"}
sk_gold = pile{{"lead white", 3}, {"Naples yellow", 1.5}, {"orange chrome", 0.5}, {"yellow ochre", 0.3}, name="sk_gold"}
sk_apricot = pile{{"lead white", 2}, {"orange chrome", 0.8}, {"vermilion", 0.25}, {"yellow ochre", 0.3}, name="sk_apricot"}
sk_rose = pile{{"lead white", 2}, {"vermilion", 0.35}, {"rose madder", 0.3}, {"raw umber", 0.12}, {"Naples yellow", 0.3}, name="sk_rose"}
sk_mauve = pile{{"lead white", 1.5}, {"ultramarine blue", 0.4}, {"rose madder", 0.35}, {"raw umber", 0.2}, name="sk_mauve"}
sk_dusk = pile{{"ultramarine blue", 0.8}, {"lead white", 0.8}, {"raw umber", 0.35}, {"rose madder", 0.12}, {"Prussian blue", 0.05}, name="sk_dusk"}
sk_deep = pile{{"ultramarine blue", 1}, {"raw umber", 0.6}, {"lead white", 0.3}, {"rose madder", 0.15}, {"bone black", 0.1}, name="sk_deep"}
print(palette())

--@ chunk 17
local function e(x, y) return math.sqrt(((x-760)/1.7)^2 + (y-485)^2) end
local function bump(v, a, b, c, d) return smoothstep(a, b, v) * (1 - smoothstep(c, d, v)) end
sky_piles2 = {
  {sk_glow,    function(x, y) return 1 - smoothstep(70, 130, e(x,y)) end},
  {sk_gold,    function(x, y) return bump(e(x,y), 70, 130, 150, 210) end},
  {sk_apricot, function(x, y) return bump(e(x,y), 150, 210, 220, 280) end},
  {sk_rose,    function(x, y) return bump(e(x,y), 220, 280, 290, 350) end},
  {sk_mauve,   function(x, y) return bump(e(x,y), 290, 350, 360, 430) end},
  {sk_dusk,    function(x, y) return bump(e(x,y), 360, 430, 450, 540) end},
  {sk_deep,    function(x, y) return smoothstep(450, 540, e(x,y)) end},
}
sky_paint_m = sky_m - figures:shrink(2)
work(sky_paint_m, {hand="broad", piles=sky_piles2, angle=sky_angle, coverage=2, fill=true, clip=true, mix_jitter=0.08, seed=41})

--@ chunk 18
cl_dark = pile{{"ultramarine blue", 0.7}, {"raw umber", 0.6}, {"lead white", 0.9}, {"rose madder", 0.3}, name="cl_dark"}
cl_mid = pile{{"ultramarine blue", 0.4}, {"raw umber", 0.3}, {"lead white", 1.4}, {"rose madder", 0.35}, {"vermilion", 0.1}, name="cl_mid"}
cb1 = brush{kind="filbert", width=14, stiffness=0.4}
local function cloud(pts, pile, load, br)
  br = br or cb1
  br:reload(pile, load or 0.6)
  br:gesture(pts, {wobble=3, orient="across"})
end
-- band 1, upper left
cloud({{-10,118,0.5},{80,124,0.7},{200,138,0.8},{330,150,0.7},{450,160,0.5},{540,166,0.2}}, cl_dark, 0.7)
cloud({{-10,140,0.4},{100,146,0.6},{230,156,0.6},{360,166,0.5},{470,172,0.2}}, cl_dark, 0.5)
cloud({{20,100,0.3},{130,106,0.5},{250,118,0.4},{330,128,0.2}}, cl_mid, 0.5)
-- band 2, thin across the rose
cloud({{380,232,0.15},{470,226,0.4},{600,218,0.5},{740,212,0.4},{860,206,0.35},{1010,200,0.3}}, cl_mid, 0.5)
-- high streaks right
cloud({{620,92,0.2},{720,84,0.45},{850,76,0.45},{1010,70,0.35}}, cl_dark, 0.5)
cloud({{700,112,0.15},{800,106,0.35},{930,100,0.3},{1010,98,0.2}}, cl_mid, 0.45)
print(cb1:fullness())

--@ chunk 19
cl_pink = pile{{"lead white", 2}, {"rose madder", 0.4}, {"vermilion", 0.15}, {"ultramarine blue", 0.15}, {"raw umber", 0.1}, name="cl_pink"}
cl_gray = pile{{"lead white", 1.2}, {"ultramarine blue", 0.5}, {"rose madder", 0.35}, {"raw umber", 0.35}, name="cl_gray"}
cb2 = brush{kind="filbert", width=26, stiffness=0.35}
local function cloud(pts, pile, load, br, wob)
  br = br or cb2
  br:reload(pile, load or 0.5)
  br:gesture(pts, {wobble=wob or 5, orient="across"})
end
-- upper-left cloud bank: gray body above, pink-lit underside
cloud({{-20,92,0.25},{60,98,0.45},{160,108,0.5},{260,120,0.45},{360,132,0.3},{430,140,0.1}}, cl_gray, 0.5)
cloud({{-20,128,0.3},{90,134,0.5},{200,144,0.45},{300,154,0.35},{400,163,0.2},{480,170,0.05}}, cl_gray, 0.45)
cloud({{10,150,0.2},{120,156,0.35},{230,165,0.35},{340,174,0.2},{420,180,0.05}}, cl_pink, 0.45)
cloud({{40,112,0.15},{150,120,0.3},{250,131,0.25},{330,140,0.1}}, cl_pink, 0.35)
-- right high cloud
cloud({{560,96,0.1},{660,86,0.3},{780,78,0.4},{900,72,0.35},{1020,66,0.3}}, cl_gray, 0.45)
cloud({{640,110,0.1},{740,104,0.25},{860,98,0.3},{1020,94,0.25}}, cl_pink, 0.4)
-- mid band across rose: thin, darker since near glow
cloud({{420,236,0.05},{520,228,0.2},{640,220,0.3},{780,213,0.25},{900,208,0.2},{1020,204,0.15}}, cl_gray, 0.35)

--@ chunk 20
local m1 = poly({{-10,80},{300,95},{540,150},{540,195},{300,190},{-10,175}}, true) - figures:grow(6)
blend(m1, {angle=0.1})
local m2 = poly({{540,60},{1010,50},{1010,120},{560,125}}, true)
blend(m2, {angle=-0.05})
local m3 = poly({{400,195},{1010,185},{1010,225},{400,250}}, true) - figures:grow(6)
blend(m3, {angle=-0.03})

--@ chunk 21
ld_far = pile{{"raw umber", 1}, {"ultramarine blue", 0.6}, {"rose madder", 0.35}, {"lead white", 0.7}, {"burnt sienna", 0.3}, name="ld_far"}
ld_mid = pile{{"raw umber", 1.5}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.7}, {"lead white", 0.25}, name="ld_mid"}
ld_near = pile{{"raw umber", 1.2}, {"bone black", 0.4}, {"ultramarine blue", 0.6}, {"burnt sienna", 0.5}, name="ld_near"}
mesa_p = pile{{"ultramarine blue", 0.6}, {"rose madder", 0.4}, {"raw umber", 0.8}, {"lead white", 0.9}, name="mesa_p"}
print(palette())

--@ chunk 22
protect_fig = (figures + crosses + mound):grow(1)
work(mesas - land, {hand="body", pile=mesa_p, angle=0, coverage=2.2, fill=true, clip=true, seed=51})
local land_paint = land - protect_fig
work(land_paint, {hand="broad", piles={
    {ld_far,  function(x,y) return 1 - smoothstep(478, 540, y) end},
    {ld_mid,  function(x,y) local t = smoothstep(478, 540, y) return t * (1 - smoothstep(560, 650, y)) end},
    {ld_near, function(x,y) return smoothstep(560, 650, y) end}},
  angle=function(x,y) return 0.04*math.sin(x/120 + y/50) end,
  scale_at=function(x,y) return 0.5 + 0.6*smoothstep(480, 700, y) end,
  coverage=2, fill=true, clip=true, mix_jitter=0.06, seed=52})

--@ chunk 23
-- refined cowboy parts
cb_head2 = poly({{232,256},{268,256},{272,262},{276,266},{279,271},{286,277},{280,280},{282,284},{279,287},{280,292},{275,296},{264,298},{258,302},{242,302},{236,292},{231,278}}, false):soften(0.8)
cb_band = poly({{238,294},{258,300},{270,298},{274,306},{262,314},{244,314},{234,308},{220,306},{206,300},{214,298},{226,300}}, true)
cb_gun2 = ribbon({{452,333},{470,332},{488,331}}, {5.5,5,5}) + ellipse(457,336,8,6) + poly({{446,330},{452,327},{455,332}}, true)
cb_hand2 = poly({{426,337},{438,333},{450,335},{454,342},{452,350},{446,356},{438,358},{430,356},{426,348}}, true)
cb_trig = ribbon({{446,342},{454,344},{458,341}}, 3)
cb_sleeve = ribbon({{268,320},{300,326},{340,334},{380,340},{410,344},{428,346}}, {38,33,29,27,25,22})
cw_dark = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.5}, name="cw_dark"}
cw_coat = pile{{"raw umber", 1.5}, {"burnt sienna", 0.6}, {"bone black", 0.35}, {"lead white", 0.15}, name="cw_coat"}
cw_jeans = pile{{"ultramarine blue", 0.8}, {"bone black", 0.5}, {"raw umber", 0.6}, {"lead white", 0.15}, name="cw_jeans"}
cw_skin = pile{{"burnt sienna", 1}, {"raw umber", 1}, {"bone black", 0.15}, {"vermilion", 0.15}, name="cw_skin"}
cw_bandana = pile{{"Indian red", 1}, {"vermilion", 0.4}, {"bone black", 0.12}, name="cw_bandana"}
-- sky color to trim the old head blob where the profile doesn't reach
local trim = (cb_head - cb_head2 - cb_hat - cb_neck - cb_coat):shrink(0.5)
print(trim:area())

--@ chunk 24
local coat_m = (cb_coat + cb_sleeve + cb_arm) - cb_hand2 - cb_head2
work(coat_m, {hand="body", tool={kind="filbert", width=10, stiffness=0.5},
  piles={{cw_coat, function(x,y) return 0.3 + smoothstep(220, 300, x + (y-300)*0.3) end},
         {cw_dark, function(x,y) return 1 - smoothstep(180, 280, x + (y-300)*0.3) end}},
  angle=function(x,y) if y < 360 and x > 290 then return 0.12 end return 1.45 + 0.25*smoothstep(300,600,y)*(-1) end,
  coverage=2.2, fill=true, clip=true, seed=61})
local legs_m = (cb_legF + cb_legB) - cb_coat
work(legs_m, {hand="body", tool={kind="filbert", width=8}, pile=cw_jeans, angle=1.4, coverage=2.2, fill=true, clip=true, seed=62})
work(cb_bootF + cb_bootB, {hand="detail", pile=cw_dark, coverage=2.5, clip=true, seed=63})
work(cb_hat, {hand="detail", tool={kind="filbert", width=5}, pile=cw_dark, angle=0, coverage=2.5, clip=true, seed=64})

--@ chunk 25
work(cb_head2 - cb_hat, {hand="detail", tool={kind="round", width=3}, pile=cw_skin, coverage=2.5, clip=true, seed=65})
work(cb_band - cb_head2, {hand="detail", tool={kind="round", width=3}, pile=cw_bandana, angle=0.2, coverage=2.5, clip=true, seed=66})
work(cb_hand2, {hand="detail", tool={kind="round", width=3}, pile=cw_coat, coverage=2.5, clip=true, seed=67})
work(cb_gun2 + cb_trig, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3, clip=true, seed=68})
-- trim the old head blob with sky
local trim = (cb_head + cb_gun) - cb_head2 - cb_hat - cb_neck - cb_coat - cb_band - cb_gun2 - cb_hand2 - cb_sleeve - cb_arm
work(trim, {hand="detail", tool={kind="round", width=2.5}, piles=sky_piles2, coverage=2.5, clip=true, seed=69})

--@ chunk 26
cw_skin_dk = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, {"bone black", 0.3}, {"ultramarine blue", 0.15}, name="cw_skin_dk"}
local fb = brush{kind="filbert", width=9, stiffness=0.5}
local coat_clip = (cb_coat + cb_sleeve + cb_arm) - cb_head2 - cb_hand2
local function fold(pts, pile, load, br)
  br = br or fb
  br:reload(pile, load or 0.6)
  br:gesture(pts, {wobble=2, clip=coat_clip})
end
-- back of coat in shadow
fold({{214,318,0.6},{204,380,0.8},{190,440,0.9},{168,500,0.9},{140,555,0.8},{110,598,0.6}}, cw_dark, 0.7)
fold({{226,330,0.4},{218,400,0.7},{204,470,0.8},{184,540,0.7},{160,600,0.4}}, cw_dark, 0.6)
-- folds flaring from waist
fold({{238,430,0.2},{232,480,0.6},{222,540,0.8},{210,600,0.5}}, cw_dark, 0.6)
fold({{262,450,0.2},{262,500,0.5},{258,550,0.7},{252,605,0.4}}, cw_dark, 0.5)
fold({{284,470,0.2},{288,520,0.5},{292,560,0.6},{296,594,0.3}}, cw_dark, 0.5)
-- shadow under the arm across the chest
fold({{276,352,0.7},{282,380,0.6},{288,420,0.4},{292,450,0.2}}, cw_dark, 0.6)
fold({{250,350,0.3},{262,360,0.5},{280,362,0.5}}, cw_dark, 0.4)
-- underside of sleeve
local sb = brush{kind="filbert", width=6, stiffness=0.5}
sb:reload(cw_dark, 0.6)
sb:gesture({{290,340,0.5},{330,348,0.6},{370,352,0.6},{410,354,0.5},{428,356,0.3}}, {wobble=1.5, clip=coat_clip})
-- face darker
local fbr = brush{kind="round", width=4, stiffness=0.5}
fbr:reload(cw_skin_dk, 0.7)
for i = 0, 5 do
  fbr:gesture({{236 + i*3, 258, 0.6},{234 + i*3, 278, 0.7},{238 + i*3, 298, 0.5}}, {wobble=1, clip=cb_head2})
end
fbr:reload(cw_skin_dk, 0.6)
fbr:gesture({{240,258,0.8},{256,260,0.8},{270,261,0.6}}, {wobble=0.5, clip=cb_head2})
fbr:gesture({{242,264,0.8},{258,266,0.8},{272,266,0.5}}, {wobble=0.5, clip=cb_head2})

--@ chunk 27
local fb = brush{kind="filbert", width=9, stiffness=0.5}
print(fb:mark_width(0.3), fb:mark_width(0.6), fb:mark_width(0.9))
local r = brush{kind="round", width=4, stiffness=0.5}
print(r:mark_width(0.6))
print(drying(250,280), drying(250,400))

--@ chunk 28
cw_shadow = pile{{"raw umber", 1}, {"ultramarine blue", 0.7}, {"bone black", 0.4}, {"rose madder", 0.2}, name="cw_shadow"}
cw_lit = pile{{"burnt sienna", 1}, {"Naples yellow", 0.8}, {"orange chrome", 0.35}, {"raw umber", 0.4}, {"lead white", 0.3}, name="cw_lit"}
cw_lit_hi = pile{{"Naples yellow", 1}, {"orange chrome", 0.5}, {"lead white", 0.6}, {"vermilion", 0.15}, {"burnt sienna", 0.3}, name="cw_lit_hi"}
cw_skin_lit = pile{{"vermilion", 0.5}, {"Naples yellow", 0.8}, {"burnt sienna", 0.6}, {"lead white", 0.3}, name="cw_skin_lit"}
-- shadow side of coat: the left/back 45%
cb_shadow = poly({{236,300},{212,304},{200,340},{194,390},{184,440},{166,495},{140,548},{100,600},{122,604},{140,598},{160,612},{184,602},{208,614},{236,600},{238,560},{236,520},{240,470},{246,420},{248,380},{252,340},{252,312}}, true) * cb_coat
-- lit band down the front of the coat
cb_litband = poly({{282,312},{288,332},{292,368},{295,410},{296,450},{300,490},{306,540},{314,592},{298,594},{292,540},{286,490},{283,450},{281,410},{279,370},{276,340},{270,318}}, true) * cb_coat
-- lit top of sleeve and shoulder
cb_sleevetop = ribbon({{262,304},{290,312},{330,320},{370,328},{404,334},{426,336}}, {10,9,8,7,7,6}) * (cb_sleeve + cb_coat)
print(cb_shadow:area(), cb_litband:area(), cb_sleevetop:area())

--@ chunk 29
work(cb_shadow, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, pile=cw_shadow, angle=1.5, coverage=1.6, edge="soft", clip=cb_coat, seed=71})
work(cb_litband, {hand="body", tool={kind="filbert", width=6, stiffness=0.5}, pile=cw_lit, angle=1.5, coverage=1.6, edge="soft", clip=cb_coat, seed=72})
work(cb_sleevetop, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, pile=cw_lit, angle=0.15, coverage=1.6, edge="soft", clip=cb_sleeve + cb_coat, seed=73})

--@ chunk 30
local front_band = poly({{284,312},{290,332},{294,368},{297,410},{298,450},{302,490},{308,540},{316,592},{304,594},{298,540},{292,490},{289,450},{287,410},{285,370},{282,340},{276,318}}, true)
local body_m = (cb_coat - front_band - cb_head2 - cb_band)
work(body_m, {hand="body", tool={kind="filbert", width=12, stiffness=0.5},
  piles={{cw_shadow, function(x,y) return 1 - smoothstep(200, 290, x + (y-300)*0.25) + 0.15 end},
         {cw_coat, function(x,y) return 0.3*smoothstep(220, 290, x + (y-300)*0.25) end}},
  angle=1.5, coverage=1.4, clip=cb_coat, seed=81})
-- sleeve: dark underside half
local sleeve_under = (cb_sleeve + cb_arm) - cb_sleevetop:grow(3) - cb_coat - cb_hand2
work(sleeve_under, {hand="body", tool={kind="filbert", width=7, stiffness=0.5}, pile=cw_shadow, angle=0.12, coverage=1.3, clip=(cb_sleeve + cb_arm) - cb_hand2, seed=82})

--@ chunk 31
-- face: shadowed under brim, lit profile edge
work(cb_head2 - cb_hat, {hand="detail", tool={kind="round", width=4}, pile=cw_skin_dk, coverage=2, clip=cb_head2, seed=83})
cb_face_lit = poly({{270,262},{276,266},{279,271},{286,277},{280,280},{282,284},{279,287},{280,292},{275,296},{266,298},{270,290},{272,280},{270,270}}, true) * cb_head2
work(cb_face_lit, {hand="detail", tool={kind="round", width=2.5}, pile=cw_skin_lit, coverage=2, clip=cb_head2, seed=84})

--@ chunk 32
print(wait(3*24*60))
local out = {}
for _, p in ipairs({{100,100},{760,450},{600,300},{250,400},{290,450},{250,280},{200,650},{800,400},{500,600},{630,450},{230,220}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 33
print(wait(4*24*60))
local out = {}
for _, p in ipairs({{100,100},{630,450},{250,400},{290,450},{250,280},{230,220},{180,500},{350,330},{180,650}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 34
print(wait(4*24*60))
local out = {}
for _, p in ipairs({{250,400},{290,450},{250,280},{230,220},{180,500},{180,650},{150,560},{200,450}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 35
print(wait(2*24*60))
print(drying(180,500), drying(200,450), drying(120,590))

--@ chunk 36
local out = {}
for _, p in ipairs({{100,520},{400,600},{600,690},{900,500},{700,560},{620,580},{820,620}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))
gd_hz = pile{{"raw umber", 1}, {"rose madder", 0.35}, {"ultramarine blue", 0.35}, {"lead white", 0.8}, {"orange chrome", 0.12}, name="gd_hz"}
gd_mid = pile{{"raw umber", 1.5}, {"burnt sienna", 0.5}, {"ultramarine blue", 0.6}, {"rose madder", 0.15}, {"lead white", 0.12}, name="gd_mid"}
gd_near = pile{{"raw umber", 1}, {"bone black", 0.6}, {"ultramarine blue", 0.6}, {"burnt sienna", 0.35}, name="gd_near"}
gd_warm = pile{{"raw umber", 1}, {"burnt sienna", 1}, {"Naples yellow", 0.5}, {"orange chrome", 0.2}, {"lead white", 0.3}, name="gd_warm"}

--@ chunk 37
local land_paint = land - protect_fig
work(land_paint, {hand="body", tool={kind="flat", width=14, stiffness=0.6},
  piles={{gd_hz, function(x,y) return 1 - smoothstep(485, 545, y) end},
         {gd_warm, function(x,y) local d = math.sqrt(((x-720)/3)^2 + (y-490)^2) return 0.7*(1 - smoothstep(10, 45, d)) end},
         {gd_mid, function(x,y) return smoothstep(485, 545, y) * (1 - smoothstep(580, 660, y)) end},
         {gd_near, function(x,y) return smoothstep(580, 660, y) end}},
  angle=function(x,y) return 0.06*math.sin(x/70 + y/40) end, length={30, 90},
  scale_at=function(x,y) return 0.45 + 0.9*smoothstep(475, 714, y) end,
  coverage=1.6, fill=true, clip=true, mix_jitter=0.08, seed=91})

--@ chunk 38
local out = {}
for _, p in ipairs({{250,400},{290,450},{250,280},{230,220},{180,500},{120,590},{200,450},{300,620},{180,640},{350,340},{440,345}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 39
print(wait(24*60), drying(180,500))
cw_coat_dk = pile{{"raw umber", 1}, {"bone black", 0.35}, {"ultramarine blue", 0.45}, {"burnt sienna", 0.4}, {"lead white", 0.05}, name="cw_coat_dk"}
cw_coat_md = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.3}, {"rose madder", 0.12}, {"lead white", 0.18}, name="cw_coat_md"}
cw_rim = pile{{"Naples yellow", 1}, {"orange chrome", 0.4}, {"burnt sienna", 0.5}, {"lead white", 0.35}, {"vermilion", 0.12}, name="cw_rim"}
cw_rim_cool = pile{{"lead white", 0.6}, {"ultramarine blue", 0.3}, {"rose madder", 0.25}, {"raw umber", 0.5}, name="cw_rim_cool"}
cw_jeans2 = pile{{"ultramarine blue", 0.6}, {"bone black", 0.4}, {"raw umber", 0.5}, {"lead white", 0.08}, name="cw_jeans2"}
-- rim bands (narrow, along right-facing edges)
rim_coat = poly({{283,314},{289,334},{293,370},{296,410},{297,450},{301,490},{307,540},{315,592},{307,594},{300,542},{294,492},{290,452},{289,412},{287,372},{283,338},{277,318}}, true) * cb_coat
rim_sleeve_cool = ribbon({{262,304},{290,311},{330,319},{370,327},{404,333},{424,335}}, {7,6,5.5,5,4.5,4}) * (cb_sleeve + cb_coat)
print(rim_coat:area(), rim_sleeve_cool:area())

--@ chunk 40
local coat_all = cb_coat - cb_head2 - cb_band - cb_hand2
work(coat_all - rim_coat:grow(1), {hand="body", tool={kind="filbert", width=11, stiffness=0.55},
  piles={{cw_coat_dk, function(x,y) return 0.25 + (1 - smoothstep(190, 290, x + (y-300)*0.28)) end},
         {cw_coat_md, function(x,y) return 0.8*smoothstep(220, 300, x + (y-300)*0.28) end}},
  angle=function(x,y) return 1.5 + 0.35*smoothstep(400, 600, y)*(1 - smoothstep(150, 300, x)) end,
  coverage=2, fill=true, clip=coat_all - rim_coat, mix_jitter=0.06, seed=101})
local sleeve_all = (cb_sleeve + cb_arm) - cb_coat - cb_hand2
work(sleeve_all - rim_sleeve_cool, {hand="body", tool={kind="filbert", width=8, stiffness=0.55},
  piles={{cw_coat_dk, function(x,y) return 0.6 end}, {cw_coat_md, function(x,y) return 0.4 end}},
  angle=0.13, coverage=2, fill=true, clip=sleeve_all - rim_sleeve_cool, seed=102})

--@ chunk 41
work(rim_coat, {hand="detail", tool={kind="filbert", width=4, stiffness=0.5}, pile=cw_rim, angle=1.5, coverage=2, clip=cb_coat, seed=103})
work(rim_sleeve_cool, {hand="detail", tool={kind="filbert", width=4, stiffness=0.5}, pile=cw_rim_cool, angle=0.13, coverage=1.8, clip=cb_sleeve + cb_coat, seed=104})
-- legs
local legs = (cb_legF + cb_legB) - cb_coat
work(legs, {hand="body", tool={kind="filbert", width=8, stiffness=0.55}, pile=cw_jeans2, angle=1.4, coverage=2, fill=true, clip=legs, seed=105})

--@ chunk 42
zb_skin_dk = pile{{"green earth", 1}, {"raw umber", 0.8}, {"bone black", 0.15}, {"lead white", 0.15}, {"rose madder", 0.08}, name="zb_skin_dk"}
zb_cloth = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.3}, {"burnt sienna", 0.2}, {"lead white", 0.08}, name="zb_cloth"}
zb_shirt = pile{{"raw umber", 0.6}, {"lead white", 0.5}, {"yellow ochre", 0.3}, {"ultramarine blue", 0.15}, {"bone black", 0.1}, name="zb_shirt"}
-- zombie parts for painting
zb_skin_m = zb_head + zb_handF + zb_handB + ribbon({{740,376},{722,368},{710,364}}, {10,8,7}) + ribbon({{752,344},{734,336},{720,330}}, {10,8,7})
zb_pants_m = (zb_legF + zb_legB + zb_feet) - zb_torso:shrink(0) 
zb_coat_m = (zb_torso + zb_sleeveF + zb_armF + zb_armB) - zb_skin_m - zb_head
-- ragged shirt front (lighter dirty shirt showing in the open coat)
zb_shirt_m = poly({{786,356},{796,350},{804,356},{802,390},{798,420},{794,446},{788,452},{784,430},{780,400},{782,372}}, true):roughen(2, 10, 5) * zb_torso
print(zb_skin_m:area(), zb_pants_m:area(), zb_coat_m:area(), zb_shirt_m:area())

--@ chunk 43
work(zb_coat_m - zb_shirt_m, {hand="detail", tool={kind="filbert", width=5, stiffness=0.5}, pile=zb_cloth, coverage=2.5, clip=zombie, angle=function(x,y) if y < 380 and x < 790 then return 0.3 end return 1.4 end, seed=111})
work(zb_shirt_m, {hand="detail", tool={kind="round", width=3}, pile=zb_shirt, coverage=2.2, clip=zb_torso, angle=1.4, seed=112})
work(zb_pants_m, {hand="detail", tool={kind="filbert", width=5, stiffness=0.5}, pile=zb_cloth, coverage=2.5, clip=zombie, angle=1.3, seed=113})
work(zb_skin_m, {hand="detail", tool={kind="round", width=3}, pile=zb_skin_dk, coverage=2.5, clip=zombie, seed=114})

--@ chunk 44
sm_out = pile{{"lead white", 1.5}, {"ultramarine blue", 0.25}, {"raw umber", 0.3}, {"rose madder", 0.15}, name="sm_out"}
sm_mid = pile{{"lead white", 1.5}, {"raw umber", 0.15}, {"rose madder", 0.12}, {"orange chrome", 0.25}, {"ultramarine blue", 0.08}, name="sm_mid"}
sm_in = pile{{"lead white", 2}, {"orange chrome", 0.6}, {"cadmium yellow", 0.3}, name="sm_in"}
muzzle = {492, 331}
function smoke_body(cx, cy, s, seed, clipm)
  math.randomseed(seed)
  local m = ellipse(cx + 22*s, cy - 2*s, 26*s, 18*s)
  for i = 1, 9 do
    local t = rand(0, 1)
    m = m + ellipse(cx + (20 + 75*t)*s + rand(-8,8)*s, cy - (4 + 30*t)*s + rand(-10,10)*s, (13 + 12*t)*s, (10 + 9*t)*s)
  end
  m = m:roughen(4*s, 18*s, seed):soften(2*s)
  if clipm then m = m * clipm end
  local function d(x, y) return math.sqrt(((x-cx-14*s)/1.3)^2 + (y-cy)^2) end
  work(m, {hand="body", tool={kind="filbert", width=8*s, stiffness=0.35},
    piles={{sm_in,  function(x,y) return 1 - smoothstep(14*s, 34*s, d(x,y)) end},
           {sm_mid, function(x,y) local v = d(x,y) return smoothstep(14*s, 34*s, v) * (1 - smoothstep(40*s, 70*s, v)) end},
           {sm_out, function(x,y) return smoothstep(40*s, 70*s, d(x,y)) end}},
    coverage=2.2, fill=true, angle=function(x,y) return math.atan(y-cy, x-cx) + 1.57 end, curve={0.4, 0.2}, edge="soft", clip=clipm, seed=seed})
  blend(m:shrink(2*s), {angle=-0.3})
  return m
end
smoke_m = smoke_body(muzzle[1], muzzle[2], 1.15, 21, -(cowboy:grow(2)))
print(smoke_m:area())

--@ chunk 45
print(wait(3*24*60))
local out = {}
for _, p in ipairs({{520,330},{560,310},{600,300},{250,400},{290,450},{180,500},{300,330},{795,320},{800,420},{780,560},{200,640}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 46
print(wait(3*24*60))
local out = {}
for _, p in ipairs({{520,330},{600,300},{250,400},{290,450},{180,500},{300,330},{795,320},{800,420},{780,560},{200,640},{440,345}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 47
print(wait(3*24*60))
local out = {}
for _, p in ipairs({{290,450},{180,500},{300,330},{795,320},{800,420},{780,560},{740,370}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 48
zb_head2 = poly({{800,294},{810,298},{816,308},{816,322},{810,336},{802,346},{792,345},{783,343},{780,336},{780,327},{779,321},{781,318},{776,314},{780,309},{782,304},{787,298}}, true)
zb_tatters = poly({{748,378},{756,382},{754,396},{750,390},{747,400},{744,386}}, true)
           + poly({{770,354},{776,356},{774,366},{770,362},{768,370},{766,358}}, true)
           + poly({{782,478},{790,484},{788,500},{784,494},{781,504},{778,488}}, true)
           + poly({{814,480},{822,478},{824,494},{820,490},{818,500},{814,490}}, true)
sk_patch = pile{{"lead white", 2.5}, {"Naples yellow", 0.8}, {"orange chrome", 0.45}, {"yellow ochre", 0.3}, {"vermilion", 0.06}, name="sk_patch"}
old_only = zb_head - zb_head2 - zb_torso
print(old_only:area(), (zb_head2 - zb_head):area())
print(old_only:at(775,308), old_only:at(776,334), old_only:at(800,320))

--@ chunk 49
sk_patch:add{{"orange chrome", 0.15}, {"vermilion", 0.05}, {"raw umber", 0.03}}
print(sk_patch)

--@ chunk 50
local patch = old_only:grow(1.5) - zb_head2:shrink(0.5)
work(patch, {hand="detail", tool={kind="round", width=3}, pile=sk_patch, coverage=3.5, clip=patch, seed=121})
work((zb_head2 - zb_head) + zb_tatters, {hand="detail", tool={kind="round", width=2.5}, pile=zb_cloth, coverage=3, clip=zb_head2 + zb_tatters, seed=122})

--@ chunk 51
fl_white_b = pile{{"lead white", 4}, {"lemon chrome", 0.3}, blot=0.25, name="fl_white_b"}
fl_yel = pile{{"cadmium yellow", 1}, {"lead white", 0.8}, {"lemon chrome", 0.3}, name="fl_yel"}
fl_org = pile{{"orange chrome", 1}, {"cadmium yellow", 0.4}, {"vermilion", 0.15}, name="fl_org"}
fl_red = pile{{"vermilion", 1}, {"orange chrome", 0.5}, name="fl_red"}
function flame(cx, cy, s, seed)
  math.randomseed(seed or 1)
  local cb = brush{kind="filbert", width=9*s, stiffness=0.7, lay=6}
  cb:reload(fl_white_b, 1)
  cb:gesture({{cx + 2*s, cy, 0.6}, {cx + 10*s, cy - 0.5*s, 1.0}, {cx + 22*s, cy - 1.5*s, 0.7}, {cx + 30*s, cy - 2*s, 0.1}}, {wobble=0.8})
  cb:reload(fl_white_b, 0.8)
  cb:touch(cx + 12*s, cy + 3*s, {pressure=0.7, drag={6*s, -1*s}})
  local rb = brush{kind="round", width=5.5*s, point=0.85, stiffness=0.5, lay=2.5}
  local function tongue(pile, ang, r0, len, w0, bend)
    rb:reload(pile, 0.85)
    local x0, y0 = cx + 14*s + math.cos(ang)*r0, cy + math.sin(ang)*r0*0.8
    local a2 = ang + (bend or 0)
    local x1, y1 = x0 + math.cos(ang)*len*0.5, y0 + math.sin(ang)*len*0.5
    local x2, y2 = x1 + math.cos(a2)*len*0.5, y1 + math.sin(a2)*len*0.5
    rb:gesture({{x0, y0, w0}, {x1, y1, w0*0.9}, {x2, y2, 0}}, {wobble=1})
  end
  for i = 1, 7 do local a = rand(-0.75, 0.75) tongue(fl_org, a, 11*s, rand(24, 44)*s, 0.9, rand(-0.3, 0.3)) end
  -- cylinder-gap side jets, at the gun's cylinder (behind the muzzle)
  rb:reload(fl_org, 0.7)
  rb:gesture({{cx - 30*s, cy + 4*s, 0.6}, {cx - 28*s, cy - 6*s, 0.5}, {cx - 24*s, cy - 16*s, 0}}, {wobble=0.6})
  rb:reload(fl_org, 0.7)
  rb:gesture({{cx - 30*s, cy + 10*s, 0.6}, {cx - 31*s, cy + 18*s, 0.4}, {cx - 28*s, cy + 26*s, 0}}, {wobble=0.6})
  for i = 1, 3 do local a = rand(-0.6, 0.6) tongue(fl_red, a, 26*s, rand(14, 22)*s, 0.55, rand(-0.3,0.3)) end
  for i = 1, 5 do local a = rand(-0.45, 0.45) tongue(fl_yel, a, 12*s, rand(16, 30)*s, 0.85, rand(-0.2, 0.2)) end
end
flame(muzzle[1], muzzle[2], 1.1, 42)

--@ chunk 52
fl_halo = pile{{"lead white", 3}, {"Naples yellow", 1}, {"cadmium yellow", 0.6}, name="fl_halo"}
spark_p = pile{{"orange chrome", 1}, {"cadmium yellow", 0.5}, {"lead white", 0.3}, medium=0.5, name="spark2"}
function flame_big2(cx, cy, s, seed, clipm)
  math.randomseed(seed or 1)
  local halo = (ellipse(cx + 30*s, cy - 1*s, 44*s, 24*s) + ellipse(cx + 8*s, cy, 18*s, 16*s)):soften(8*s)
  if clipm then halo = halo * clipm end
  work(halo, {hand="body", tool={kind="filbert", width=8*s, stiffness=0.35}, pile=fl_halo, coverage=1.4, fill=true,
     angle=function(x,y) return math.atan(y-cy, x-cx) end, edge="lost", clip=clipm, seed=seed})
  blend(halo:rim(10*s, 4*s) * (clipm or everywhere()), {angle=0})
  local cb = brush{kind="filbert", width=10*s, stiffness=0.7, lay=6}
  cb:reload(fl_white_b, 1)
  cb:gesture({{cx + 1*s, cy, 0.7}, {cx + 14*s, cy - 0.5*s, 1.0}, {cx + 32*s, cy - 1.5*s, 0.8}, {cx + 50*s, cy - 2.5*s, 0.05}}, {wobble=1, clip=clipm})
  cb:reload(fl_white_b, 0.8)
  cb:gesture({{cx + 6*s, cy + 4*s, 0.5}, {cx + 20*s, cy + 7*s, 0.6}, {cx + 32*s, cy + 10*s, 0.0}}, {wobble=1, clip=clipm})
  cb:reload(fl_white_b, 0.8)
  cb:gesture({{cx + 6*s, cy - 4*s, 0.5}, {cx + 20*s, cy - 8*s, 0.6}, {cx + 30*s, cy - 12*s, 0.0}}, {wobble=1, clip=clipm})
  local rb = brush{kind="round", width=6.5*s, point=0.85, stiffness=0.5, lay=2.5}
  local function tongue(pile, ang, r0, len, w0, bend, load)
    rb:reload(pile, load or 0.85)
    local ox, oy = cx + 18*s, cy
    local x0, y0 = ox + math.cos(ang)*r0, oy + math.sin(ang)*r0*0.7
    local a2 = ang + (bend or 0)
    local x1, y1 = x0 + math.cos(ang)*len*0.5, y0 + math.sin(ang)*len*0.5
    local x2, y2 = x1 + math.cos(a2)*len*0.5, y1 + math.sin(a2)*len*0.5
    rb:gesture({{x0, y0, w0}, {x1, y1, w0*0.9}, {x2, y2, 0}}, {wobble=1.2, clip=clipm})
  end
  for i = 1, 8 do local a = (i % 2 == 0 and -1 or 1) * rand(0.15, 1.0) tongue(fl_org, a, 18*s, rand(34, 58)*s, 0.9, rand(-0.3, 0.3)) end
  for i = 1, 3 do local a = rand(-0.2, 0.2) tongue(fl_org, a, 46*s, rand(24, 40)*s, 0.7, rand(-0.25, 0.25)) end
  for i = 1, 5 do local a = rand(-0.9, 0.9) tongue(fl_red, a, 44*s, rand(12, 24)*s, 0.5, rand(-0.3,0.3), 0.6) end
  local sb = brush{kind="round", width=4*s, stiffness=0.4}
  sb:reload(spark_p, 1)
  sb:spatter{at={cx + 30*s, cy}, toward={120*s, -4*s}, spread=0.3, force=0.5, clip=clipm}
  sb:reload(spark_p, 1)
  sb:spatter{at={cx + 30*s, cy}, toward={90*s, 4*s}, spread=0.4, force=0.4, clip=clipm}
end
flame_big2(muzzle[1], muzzle[2], 1.2, 52, -(cowboy:grow(1.5)))

--@ chunk 53
print(palette())

--@ chunk 54
sk_patch_lo = mix{{sk_patch, 0.8}, {fl_halo, 0.2}, name="sk_patch_lo"}
-- new hands as palm masks
zb_palmB = poly({{724,327},{716,328},{708,332},{704,338},{708,342},{716,340},{724,337}}, true)
zb_palmF = poly({{714,359},{705,360},{697,362},{694,368},{698,371},{706,370},{714,369}}, true)
local oldhands = (zb_handB + zb_handF):grow(2.5)
local keep = zb_armB + zb_armF + zb_palmB + zb_palmF
local cover = oldhands - keep:grow(0.5)
cover_hands = cover
work(cover * below(function(x) return 350 end), {hand="detail", tool={kind="round", width=3}, pile=sk_patch_lo, coverage=3.5, clip=cover, seed=131})
work(cover * above(function(x) return 350 end), {hand="detail", tool={kind="round", width=3}, pile=sk_patch, coverage=3.5, clip=cover, seed=132})
local rb = brush{kind="round", width=3, point=0.8, stiffness=0.5}
print(rb:mark_width(0.3), rb:mark_width(0.6), rb:mark_width(0.9))

--@ chunk 55
work(zb_palmB + zb_palmF, {hand="detail", tool={kind="round", width=2.5}, pile=zb_skin_dk, coverage=3, clip=zb_palmB + zb_palmF + zb_armB + zb_armF, seed=133})
local rb = brush{kind="round", width=3.6, point=0.8, stiffness=0.5}
local function f(pts) rb:reload(zb_skin_dk, 0.7) rb:gesture(pts, {wobble=0.3}) end
-- hand B: drooping fingers
f({{709,337,0.85},{704,344,0.8},{702,350,0.6},{704,354,0.2}})
f({{712,339,0.85},{708,346,0.8},{707,352,0.6},{709,356,0.2}})
f({{716,339,0.8},{713,346,0.75},{713,352,0.5},{715,355,0.15}})
f({{706,335,0.8},{700,340,0.75},{697,346,0.55},{698,350,0.15}})
f({{719,336,0.7},{719,342,0.5},{717,346,0.1}})  -- thumb
-- hand F: clawing, fingers hooked toward the cowboy
f({{699,364,0.85},{690,361,0.8},{684,362,0.6},{682,367,0.2}})
f({{698,366,0.85},{689,366,0.8},{684,369,0.55},{684,373,0.15}})
f({{699,368,0.85},{692,371,0.8},{688,376,0.5},{689,380,0.15}})
f({{702,370,0.8},{698,375,0.7},{696,381,0.45},{698,384,0.1}})
f({{708,370,0.7},{706,376,0.5},{702,379,0.1}})  -- thumb

--@ chunk 56
local rb = brush{kind="round", width=6, point=0.7, stiffness=0.5}
local function s(pts, w, load) rb:reload(zb_cloth, load or 0.7) rb:gesture(pts, {wobble=0.6}) end
-- hunched shoulder/back
s({{806,346,0.9},{820,348,1.0},{831,356,1.0},{836,368,0.9},{837,380,0.6}})
s({{828,352,0.8},{835,362,0.9},{838,374,0.7},{838,390,0.3}})
-- coat tail flaring back, torn
s({{828,420,0.9},{836,440,1.0},{842,460,0.9},{846,478,0.5},{848,486,0.05}})
s({{830,440,0.8},{838,462,0.8},{840,480,0.6},{838,496,0.1}})
s({{824,470,0.8},{830,486,0.7},{830,500,0.4},{827,510,0.05}})
s({{772,470,0.6},{774,488,0.5},{776,502,0.05}})
-- straggly hair at back of head
local hb = brush{kind="round", width=2, point=0.9, stiffness=0.4}
local function h(pts) hb:reload(zb_cloth, 0.6) hb:gesture(pts, {wobble=0.4}) end
h({{806,300,0.8},{814,298,0.6},{822,300,0.1}})
h({{810,306,0.8},{818,306,0.6},{826,310,0.1}})
h({{812,312,0.8},{819,316,0.5},{824,322,0.1}})
h({{800,296,0.7},{806,290,0.5},{810,286,0.1}})

--@ chunk 57
zb_hump = poly({{804,344},{820,345},{832,352},{839,366},{841,384},{837,398},{826,400},{818,380},{808,360}}, true)
zb_tail = poly({{824,404},{834,424},{842,448},{848,470},{850,488},{845,486},{842,500},{837,492},{832,510},{827,496},{820,500},{818,470},{820,440}}, true)
zb_extra = zb_hump + zb_tail
work(zb_extra, {hand="detail", tool={kind="filbert", width=4, stiffness=0.5}, pile=zb_cloth, coverage=3, clip=zb_extra, angle=1.3, seed=141})
zombie = zombie + zb_head2 + zb_extra + zb_tatters + zb_palmB + zb_palmF

--@ chunk 58
zb_skin_md = pile{{"green earth", 1}, {"raw umber", 0.5}, {"lead white", 0.35}, {"yellow ochre", 0.15}, {"bone black", 0.05}, name="zb_skin_md"}
zb_flashlit = pile{{"Naples yellow", 0.8}, {"green earth", 0.6}, {"orange chrome", 0.25}, {"lead white", 0.3}, {"raw umber", 0.15}, name="zb_flashlit"}
-- head skin: dark, greenish
local head_skin = zb_head2 - zb_tatters
work(zb_head2, {hand="detail", tool={kind="round", width=3}, piles={{zb_skin_dk, function(x,y) return 0.5 + smoothstep(790, 812, x) end}, {zb_skin_md, function(x,y) return 0.7*(1 - smoothstep(782, 800, x)) end}}, coverage=2.5, clip=zb_head2, seed=151})
print(drying(800,320))

--@ chunk 59
wait(2*24*60)
print(drying(800,320), drying(790,330))
local rb = brush{kind="round", width=3, point=0.8, stiffness=0.5}
local function s(p, pts, load) rb:reload(p, load or 0.7) rb:gesture(pts, {wobble=0.3}) end
-- flash-lit profile: brow, nose, cheek, chin
s(zb_flashlit, {{786,300,0.3},{783,305,0.6},{781,311,0.7},{778,315,0.6},{780,319,0.4}})
s(zb_flashlit, {{782,322,0.4},{781,328,0.6},{782,336,0.6},{785,343,0.4}})
-- dark eye socket and open mouth
s(zb_cloth, {{789,309,0.9},{793,310,0.9}}, 0.8)
s(zb_cloth, {{782,323,0.9},{788,327,1.0},{790,333,0.8},{786,336,0.6}}, 0.8)
-- cheekbone light
s(zb_skin_md, {{790,316,0.5},{796,320,0.5},{800,326,0.3}}, 0.6)

--@ chunk 60
wait(4*24*60)
print(drying(800,320), drying(790,330), drying(784,312), drying(830,450), drying(700,365))

--@ chunk 61
wait(4*24*60)
print(drying(800,320), drying(790,330), drying(784,312), drying(830,450), drying(700,365))

--@ chunk 62
wait(3*24*60)
print(drying(800,320), drying(790,330), drying(784,312), drying(700,365))

--@ chunk 63
zb_flashlit2 = pile{{"Naples yellow", 1}, {"green earth", 0.4}, {"orange chrome", 0.3}, {"lead white", 0.5}, {"raw umber", 0.08}, name="zb_flashlit2"}
local rb = brush{kind="round", width=3, point=0.8, stiffness=0.55}
local function s(p, pts, load) rb:reload(p, load or 0.7) rb:gesture(pts, {wobble=0.2, clip=zb_head2:grow(0.5)}) end
-- mid-tone plane behind the lit edge
s(zb_skin_md, {{790,298,0.6},{786,304,0.8},{784,310,0.8},{783,316,0.8},{785,321,0.7}})
s(zb_skin_md, {{786,332,0.7},{788,338,0.8},{790,343,0.6}})
-- lit profile edge
s(zb_flashlit2, {{786,296,0.4},{782,301,0.7},{780,307,0.8},{777,312,0.8},{778,316,0.7},{780,320,0.6}}, 0.8)
s(zb_flashlit2, {{781,331,0.6},{782,336,0.8},{784,341,0.7},{788,344,0.3}}, 0.8)
-- eye socket, mouth
s(zb_cloth, {{787,307,0.9},{791,308,1.0},{792,311,0.7}}, 0.9)
s(zb_cloth, {{780,323,0.9},{786,325,1.0},{791,328,0.9},{784,330,0.8}}, 0.9)
-- a few teeth
local tb = brush{kind="round", width=1.4, point=0.9, stiffness=0.6}
tb:reload(zb_shirt, 0.6)
tb:gesture({{781,322,0.6},{782,325,0.3}}) tb:gesture({{784,323,0.6},{785,326,0.3}}) tb:gesture({{782,331,0.5},{783,328,0.2}})

--@ chunk 64
gore = pile{{"Indian red", 1}, {"bone black", 0.45}, {"permanent alizarin", 0.35}, medium=0.5, name="gore"}
gore_thick = pile{{"Indian red", 1}, {"bone black", 0.4}, {"permanent alizarin", 0.3}, name="gore_thick"}
local sb = brush{kind="round", width=6, stiffness=0.4}
sb:reload(gore, 1)
print(sb:spatter{at={812,312}, toward={110,-30}, spread=0.4, force=0.75})
sb:reload(gore, 1)
print(sb:spatter{at={814,308}, toward={80,-55}, spread=0.35, force=0.45})
sb:reload(gore, 0.8)
print(sb:spatter{at={814,316}, toward={90,5}, spread=0.3, force=0.4})
-- streaks of the main jet, tapering out
local rb = brush{kind="round", width=4, point=0.85, stiffness=0.5}
local function st(pts) rb:reload(gore_thick, 0.7) rb:gesture(pts, {wobble=0.5}) end
st({{812,309,0.9},{826,304,0.7},{842,298,0.3},{852,295,0}})
st({{813,314,0.8},{828,312,0.6},{846,309,0.2},{856,308,0}})
st({{811,304,0.7},{822,296,0.5},{832,288,0.1}})

--@ chunk 65
gore_dk = pile{{"Indian red", 1}, {"bone black", 0.9}, {"permanent alizarin", 0.3}, {"raw umber", 0.3}, name="gore_dk"}
gore_dk_m = pile{{"Indian red", 1}, {"bone black", 0.9}, {"permanent alizarin", 0.3}, {"raw umber", 0.3}, medium=0.45, name="gore_dk_m"}
local cx, cy = 813, 309
local cone = mask(function(x, y)
  local dx, dy = x - cx, y - cy
  if dx < -2 then return 0 end
  local ang = math.atan(dy, dx)
  local r = math.sqrt(dx*dx + dy*dy)
  local a0 = -0.28
  local half = 0.42
  local t = 1 - smoothstep(half*0.6, half, math.abs(ang - a0))
  return t * (1 - smoothstep(14, 46, r))
end):roughen(3, 10, 7)
stipple(cone, {pile=gore_dk, width=3.5, coverage=function(x,y) local r = math.sqrt((x-cx)^2 + (y-cy)^2) return 2.2*(1 - smoothstep(6, 46, r)) end, cluster=0.6, pressure={0.4,0.8}, feather=1, seed=161})
local sb = brush{kind="round", width=5, stiffness=0.4}
sb:reload(gore_dk_m, 1)
print(sb:spatter{at={cx+2,cy}, toward={45,-12}, spread=0.45, force=0.3})
sb:reload(gore_dk_m, 1)
print(sb:spatter{at={cx+2,cy-2}, toward={70,-24}, spread=0.35, force=0.5})

--@ chunk 66
coat_hi = pile{{"raw umber", 1}, {"burnt sienna", 0.7}, {"Naples yellow", 0.4}, {"lead white", 0.35}, {"rose madder", 0.1}, name="coat_hi"}
coat_vdk = pile{{"bone black", 0.6}, {"raw umber", 1}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.3}, name="coat_vdk"}
coat_all = cb_coat - cb_head2 - cb_band - cb_hand2
work(coat_all, {hand="body", tool={kind="filbert", width=11, stiffness=0.55},
  piles={{cw_coat_dk, function(x,y) return 0.3 + (1 - smoothstep(200, 300, x + (y-300)*0.28)) end},
         {cw_coat_md, function(x,y) return 0.7*smoothstep(240, 310, x + (y-300)*0.28) end}},
  angle=function(x,y) return 1.5 + 0.35*smoothstep(400, 600, y)*(1 - smoothstep(150, 300, x)) end,
  coverage=1.6, fill=true, clip=coat_all, mix_jitter=0.05, seed=171})
local fb = brush{kind="filbert", width=14, stiffness=0.45}
local nb = brush{kind="filbert", width=8, stiffness=0.45}
local function fold(pts, p, load, br) br:reload(p, load) br:gesture(pts, {wobble=2.5, clip=coat_all}) end
fold({{252,330,0.05},{246,400,0.45},{232,490,0.7},{214,560,0.6},{200,610,0.3}}, coat_hi, 0.4, fb)
fold({{272,380,0.05},{270,450,0.45},{266,530,0.7},{262,600,0.5}}, coat_hi, 0.45, fb)
fold({{226,360,0.05},{212,430,0.35},{190,510,0.6},{160,580,0.5},{140,605,0.2}}, coat_hi, 0.35, fb)
fold({{290,430,0.1},{294,500,0.5},{300,560,0.7},{306,600,0.4}}, coat_hi, 0.5, fb)
fold({{238,370,0.0},{228,450,0.6},{214,530,0.8},{196,612,0.7}}, coat_vdk, 0.55, nb)
fold({{258,410,0.0},{256,480,0.5},{250,550,0.75},{240,612,0.6}}, coat_vdk, 0.5, nb)
fold({{212,380,0.0},{196,460,0.6},{170,540,0.8},{132,606,0.6}}, coat_vdk, 0.55, nb)
fold({{280,460,0.0},{280,530,0.4},{284,600,0.5}}, coat_vdk, 0.4, nb)
blend(coat_all:shrink(1), {angle=1.55})

--@ chunk 67
skin_sh = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.2}, {"rose madder", 0.12}, {"lead white", 0.15}, name="skin_sh"}
skin_lt = pile{{"Naples yellow", 1}, {"burnt sienna", 0.5}, {"vermilion", 0.3}, {"orange chrome", 0.12}, {"lead white", 0.35}, name="skin_lt"}
skin_md = mix{{skin_sh, 0.5}, {skin_lt, 0.5}, name="skin_md"}
work(cb_head2 - cb_hat, {hand="detail", tool={kind="round", width=3}, pile=skin_sh, coverage=3, clip=cb_head2 - cb_hat, seed=181})
print(drying(260,280), drying(250,350))

--@ chunk 68
jeans_dk = pile{{"ultramarine blue", 0.5}, {"bone black", 0.45}, {"raw umber", 0.8}, {"burnt sienna", 0.15}, {"lead white", 0.05}, name="jeans_dk"}
jeans_lt = pile{{"ultramarine blue", 0.5}, {"raw umber", 0.5}, {"lead white", 0.35}, {"rose madder", 0.12}, {"burnt sienna", 0.1}, name="jeans_lt"}
sleeve_all = (cb_sleeve + cb_arm) - cb_coat - cb_hand2
work(sleeve_all, {hand="body", tool={kind="filbert", width=9, stiffness=0.55},
  piles={{cw_coat_dk, function(x,y) return 1 end}, {cw_coat_md, function(x,y) return 0.35 end}},
  angle=0.13, coverage=1.6, fill=true, clip=sleeve_all, seed=182})
local fb = brush{kind="filbert", width=7, stiffness=0.45}
local function cr(pts, p, load) fb:reload(p, load) fb:gesture(pts, {wobble=1, clip=sleeve_all}) end
-- creases: diagonal at elbow and wrist
cr({{340,330,0.1},{346,338,0.5},{350,350,0.3}}, coat_hi, 0.35)
cr({{362,334,0.1},{368,343,0.5},{370,354,0.2}}, coat_hi, 0.3)
cr({{352,333,0.0},{357,342,0.6},{360,354,0.3}}, coat_vdk, 0.5)
cr({{404,338,0.1},{408,346,0.5},{410,355,0.2}}, coat_vdk, 0.4)
cr({{300,322,0.1},{340,330,0.4},{390,338,0.4},{420,342,0.1}}, coat_hi, 0.3)
cr({{300,345,0.1},{340,352,0.6},{390,357,0.6},{424,358,0.2}}, coat_vdk, 0.5)
blend(sleeve_all:shrink(1), {angle=0.13})
local legs = (cb_legF + cb_legB) - cb_coat
work(legs, {hand="body", tool={kind="filbert", width=8, stiffness=0.55},
  piles={{jeans_dk, function(x,y) return 1 end}, {jeans_lt, function(x,y) if x > 280 then return 0.6*smoothstep(290, 305, x + (y-600)*(-0.15)) end return 0.25*smoothstep(185, 200, x - (y-600)*0.3) end}},
  angle=1.4, coverage=2, fill=true, clip=legs, seed=183})

--@ chunk 69
zb_keep = zb_head2 + zb_torso + zb_sleeveF + zb_armF + zb_armB + zb_palmB + zb_palmF + zb_legF + zb_legB + zb_feet + zb_extra
ld_hz2 = pile{{"lead white", 1}, {"raw umber", 0.6}, {"rose madder", 0.3}, {"ultramarine blue", 0.25}, {"orange chrome", 0.12}, {"Naples yellow", 0.25}, name="ld_hz2"}
ld_glow = pile{{"lead white", 1}, {"Naples yellow", 0.45}, {"raw umber", 0.45}, {"rose madder", 0.2}, {"orange chrome", 0.2}, name="ld_glow"}
ld_mid2 = pile{{"raw umber", 1}, {"rose madder", 0.25}, {"ultramarine blue", 0.4}, {"lead white", 0.4}, {"burnt sienna", 0.2}, name="ld_mid2"}
ld_near2 = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.35}, {"rose madder", 0.1}, name="ld_near2"}
land_m = land - cowboy - zb_keep
local function gl(x, y) local d = math.sqrt(((x-760)/2.6)^2 + ((y-478)*1.2)^2) return 1 - smoothstep(20, 90, d) end
work(land_m, {hand="body", tool={kind="flat", width=12, stiffness=0.6},
  piles={{ld_hz2, function(x,y) return (1 - smoothstep(482, 530, y)) * (1 - gl(x,y)) end},
         {ld_glow, function(x,y) return gl(x,y) * (1 - smoothstep(484, 540, y)) end},
         {ld_mid2, function(x,y) local t = smoothstep(482, 530, y) return t * (1 - smoothstep(570, 650, y)) end},
         {ld_near2, function(x,y) return smoothstep(570, 650, y) end}},
  angle=function(x,y) return 0.05*math.sin(x/60 + y/35) end, length={25, 80},
  scale_at=function(x,y) return 0.4 + 1.0*smoothstep(476, 714, y) end,
  coverage=1.7, fill=true, clip=land_m, mix_jitter=0.08, seed=191})

--@ chunk 70
wait(5*24*60)
local out = {}
for _, p in ipairs({{830,305},{845,300},{250,400},{290,450},{260,280},{350,340},{180,650},{300,520},{600,500},{700,600},{900,650},{400,690}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 71
sk_peach = pile{{"lead white", 2.5}, {"Naples yellow", 0.6}, {"orange chrome", 0.5}, {"vermilion", 0.16}, {"yellow ochre", 0.2}, {"rose madder", 0.06}, name="sk_peach"}

--@ chunk 72
local streaks = ribbon({{824,305},{842,298},{854,294}}, 7) + ribbon({{826,312},{846,309},{858,308}}, 7) + ribbon({{818,298},{826,292},{834,286}}, 6)
local hair = ribbon({{812,299},{816,298},{824,300}}, 5) + ribbon({{814,305},{820,307},{828,311}}, 5) + ribbon({{814,312},{820,317},{826,324}}, 5) + ribbon({{802,295},{806,290},{812,284}}, 5)
local cov = (streaks + hair) - zb_head2:grow(0.5)
work(cov, {hand="detail", tool={kind="round", width=3}, pile=sk_peach, coverage=4, clip=cov, seed=201})

--@ chunk 73
sk_peach2 = mix{{sk_peach, 0.85}, {cw_rim_cool, 0.05}, {sk_patch, 0.1}, name="sk_peach2"}
sk_peach2:add{{"vermilion", 0.03}, {"rose madder", 0.03}}
print(sk_peach2)

--@ chunk 74
local streaks = ribbon({{824,305},{842,298},{856,293}}, 9) + ribbon({{826,312},{846,309},{860,308}}, 9) + ribbon({{818,298},{826,292},{836,284}}, 8)
local hair = ribbon({{812,299},{816,298},{824,300}}, 6) + ribbon({{814,305},{820,307},{828,311}}, 6) + ribbon({{814,312},{820,317},{826,324}}, 6) + ribbon({{802,295},{806,290},{812,284}}, 6)
local cov = (streaks + hair):soften(2) - zb_head2:grow(0.5)
work(cov, {hand="detail", tool={kind="round", width=3}, pile=sk_peach2, coverage=3, clip=cov, edge="soft", seed=202})

--@ chunk 75
wait(4*24*60)
local out = {}
for _, p in ipairs({{840,300},{850,308},{250,400},{260,280},{180,650},{300,520},{900,650},{400,690},{800,400},{790,330}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 76
coat_glaze4 = pile{{"burnt sienna", 1}, {"ultramarine blue", 0.55}, {"bone black", 0.2}, medium=0.75, name="coat_glaze4"}
local cm = coat_all + sleeve_all
print(drying(200,500), drying(380,345), drying(150,580), drying(240,330))
work(cm, {hand="glaze", pile=coat_glaze4, coverage=2, fill=true, clip=true, angle=function(x,y) if y < 365 and x > 290 then return 0.13 end return 1.5 end, seed=211})
blend(coat_all:shrink(1.5), {angle=1.5})
blend(sleeve_all:shrink(1.5), {angle=0.13})

--@ chunk 77
cr_dk = pile{{"raw umber", 1}, {"bone black", 0.3}, {"burnt sienna", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 0.08}, name="cr_dk"}
cr_lt = pile{{"Naples yellow", 0.8}, {"burnt sienna", 0.5}, {"raw umber", 0.3}, {"lead white", 0.4}, {"rose madder", 0.08}, name="cr_lt"}
function cross_shape(bx, by, h, lean, barTilt)
  local w = h * 0.075
  local ux, uy = math.sin(lean), -math.cos(lean)       -- up direction
  local tx, ty = math.cos(lean + barTilt), math.sin(lean + barTilt)  -- bar direction
  local top = {bx + ux*h, by + uy*h}
  local post = ribbon({{bx, by}, {bx + ux*h*0.5, by + uy*h*0.5}, top}, {w*1.05, w, w*0.95})
  local cx, cy = bx + ux*h*0.74, by + uy*h*0.74
  local L = h * 0.29
  local bar = ribbon({{cx - tx*L, cy - ty*L}, {cx + tx*L, cy + ty*L*1.0}}, {w*0.85, w*0.9})
  return post + bar, {bx=bx, by=by, ux=ux, uy=uy, tx=tx, ty=ty, h=h, w=w, cx=cx, cy=cy, L=L}
end
crosses_def = {
  {612, 548, 104, -0.10, 0.06},
  {690, 515, 56, 0.05, -0.04},
  {902, 592, 158, 0.16, -0.10},
  {972, 528, 74, -0.06, 0.03},
  {522, 530, 76, 0.08, 0.0},
}
crosses2 = nil
crosses_geo = {}
for i, c in ipairs(crosses_def) do
  local m, g = cross_shape(c[1], c[2], c[3], c[4], c[5])
  crosses2 = crosses2 and (crosses2 + m) or m
  crosses_geo[i] = g
end
crosses_paint = crosses2 - zb_keep - cowboy
print(crosses_paint:area())

--@ chunk 78
work(crosses_paint, {hand="detail", tool={kind="round", width=2.5}, pile=cr_dk, coverage=3, clip=crosses_paint, angle=function(x,y) return 1.5 end, seed=221})
-- warm rim along the glow-facing edge of each post and the top of each bar
local rb = brush{kind="round", width=2, point=0.8, stiffness=0.55}
for i, g in ipairs(crosses_geo) do
  local side = (g.bx < 760) and 1 or -1
  local ox, oy = -g.uy * side * g.w * 0.35, g.ux * side * g.w * 0.35   -- offset toward the glow side
  rb:reload(cr_lt, 0.6)
  local p0 = {g.bx + g.ux*g.h*0.05 + ox, g.by + g.uy*g.h*0.05 + oy}
  local p1 = {g.bx + g.ux*g.h*0.98 + ox, g.by + g.uy*g.h*0.98 + oy}
  rb:gesture({{p0[1], p0[2], 0.15}, {(p0[1]+p1[1])/2, (p0[2]+p1[2])/2, 0.45}, {p1[1], p1[2], 0.3}}, {wobble=0.3, clip=crosses_paint})
  rb:reload(cr_lt, 0.5)
  local bx0, by0 = g.cx - g.tx*g.L*0.95, g.cy - g.ty*g.L*0.95 - g.w*0.3
  local bx1, by1 = g.cx + g.tx*g.L*0.95, g.cy + g.ty*g.L*0.95 - g.w*0.3
  rb:gesture({{bx0, by0, 0.2}, {bx1, by1, 0.35}}, {wobble=0.3, clip=crosses_paint})
end

--@ chunk 79
local caps = nil
local function addq(q) local m = poly(q) caps = caps and (caps + m) or m end
for i, g in ipairs(crosses_geo) do
  local px, py = -g.uy, g.ux   -- perpendicular to post
  local tx, ty = g.bx + g.ux*g.h, g.by + g.uy*g.h
  local hw, e = g.w*0.5, g.w*0.45
  addq({{tx + px*hw, ty + py*hw}, {tx - px*hw, ty - py*hw}, {tx - px*hw + g.ux*e, ty - py*hw + g.uy*e}, {tx + px*hw + g.ux*e, ty + py*hw + g.uy*e}})
  local bw = g.w*0.45
  local qx, qy = -g.ty, g.tx
  for _, sgn in ipairs({-1, 1}) do
    local ex, ey = g.cx + sgn*g.tx*g.L, g.cy + sgn*g.ty*g.L
    addq({{ex + qx*bw, ey + qy*bw}, {ex - qx*bw, ey - qy*bw}, {ex - qx*bw + sgn*g.tx*bw, ey - qy*bw + sgn*g.ty*bw}, {ex + qx*bw + sgn*g.tx*bw, ey + qy*bw + sgn*g.ty*bw}})
  end
end
caps = caps - zb_keep - cowboy
crosses_paint = crosses_paint + caps
work(caps, {hand="detail", tool={kind="round", width=1.5}, pile=cr_dk, coverage=3.5, clip=caps, seed=222})
-- grave mounds and base dirt
gm_dk = pile{{"raw umber", 1}, {"ultramarine blue", 0.35}, {"rose madder", 0.15}, {"bone black", 0.15}, {"lead white", 0.15}, name="gm_dk"}
gm_lt = pile{{"lead white", 1}, {"raw umber", 0.6}, {"rose madder", 0.25}, {"Naples yellow", 0.3}, {"ultramarine blue", 0.15}, name="gm_lt"}
graves = {}
for i, g in ipairs(crosses_geo) do
  local s = g.h / 100
  -- a long low mound lying toward the viewer, slightly in front of the cross
  local cx, cy = g.bx + 6*s, g.by + 9*s
  local m = poly({{cx - 26*s, cy - 2*s}, {cx - 12*s, cy - 9*s}, {cx + 14*s, cy - 9*s}, {cx + 30*s, cy - 1*s}, {cx + 34*s, cy + 9*s}, {cx - 30*s, cy + 9*s}}, true):roughen(1.5*s, 6*s, i)
  graves[i] = {m=m, cx=cx, cy=cy, s=s}
end
print(#graves)

--@ chunk 80
-- zombie's open grave
zg_heap = poly({{884,606},{892,590},{906,582},{920,584},{934,590},{948,598},{962,606},{968,618},{940,622},{900,620}}, true):roughen(3, 8, 31)
         + poly({{774,612},{786,602},{800,600},{812,604},{806,612},{790,616}}, true):roughen(2, 6, 32)
zg_hole = poly({{796,606},{820,602},{850,601},{876,602},{892,606},{886,613},{850,615},{812,614}}, true)
local mounds = nil
for i, gr in ipairs(graves) do if i ~= 3 then mounds = mounds and (mounds + gr.m) or gr.m end end
mounds_all = (mounds + zg_heap) - zb_keep - cowboy - crosses_paint
work(mounds_all, {hand="detail", tool={kind="round", width=2.5}, pile=gm_dk, coverage=3, clip=mounds_all, angle=0, seed=231})
work(zg_hole - zb_keep, {hand="detail", tool={kind="round", width=2.5}, pile=cw_dark, coverage=3.5, clip=zg_hole - zb_keep, angle=0, seed=232})

--@ chunk 81
print(drying(255,280), drying(240,220), drying(440,346), drying(205,300), drying(260,305))

--@ chunk 82
fc_dk2 = pile{{"raw umber", 1}, {"bone black", 0.22}, {"burnt sienna", 0.3}, {"ultramarine blue", 0.3}, {"rose madder", 0.08}, name="fc_dk2"}
fc_lt2 = pile{{"Naples yellow", 1}, {"orange chrome", 0.55}, {"vermilion", 0.25}, {"burnt sienna", 0.15}, {"lead white", 0.2}, name="fc_lt2"}
fc_hot = pile{{"Naples yellow", 1}, {"lead white", 0.7}, {"orange chrome", 0.35}, {"cadmium yellow", 0.2}, name="fc_hot"}
hat_rim = pile{{"lead white", 0.6}, {"ultramarine blue", 0.4}, {"rose madder", 0.2}, {"raw umber", 0.4}, {"bone black", 0.1}, name="hat_rim"}
hat_glow = pile{{"burnt sienna", 1}, {"orange chrome", 0.5}, {"raw umber", 0.5}, {"bone black", 0.1}, name="hat_glow"}
cb_head3 = poly({{232,256},{270,257},{272,262},{274,266},{273,270},{278,273},{285,278},{280,281},{282,284},{279,287},{281,289},{278,292},{281,296},{276,300},{264,301},{258,303},{242,302},{236,292},{231,278}}, false):soften(0.6)
-- cover old face bits outside the new profile with sky (tiny)
local outside = (cb_head2 - cb_head3 - cb_hat - cb_coat):shrink(0.3)
print("outside", outside:area())
face3 = cb_head3 - cb_hat
work(face3, {hand="detail", tool={kind="round", width=3}, pile=fc_dk2, coverage=2.5, clip=face3, seed=241})

--@ chunk 83
local rb = brush{kind="round", width=3.6, point=0.8, stiffness=0.55}
local function g(p, pts, load) rb:reload(p, load or 0.75) rb:gesture(pts, {wobble=0.2, clip=face3}) end
g(fc_lt2, {{268,259,0.35},{270,264,0.65},{271,268,0.5}})
g(fc_lt2, {{274,272,0.5},{278,275,0.75},{282,278,0.65}})
g(fc_lt2, {{277,282,0.55},{278,286,0.6},{277,290,0.6},{276,294,0.65},{273,298,0.6},{266,300,0.45},{258,301,0.2}})
g(fc_hot, {{281,278,0.5},{282,279.5,0.4}}, 0.6)
g(fc_hot, {{276,296,0.45},{270,299,0.4}}, 0.5)
g(fc_lt2, {{266,284,0.3},{268,290,0.45},{266,296,0.3}}, 0.45)
g(cw_dark, {{263,267,0.9},{268,268,0.8}}, 0.9)
local hb = brush{kind="round", width=3, point=0.6, stiffness=0.55}
local function h(p, pts, load) hb:reload(p, load or 0.6) hb:gesture(pts, {wobble=0.3, clip=cb_hat}) end
h(hat_glow, {{266,256,0.3},{288,254,0.7},{304,252,0.6},{313,249,0.2}}, 0.7)
h(hat_rim, {{224,236,0.35},{223,220,0.5},{227,206,0.5},{237,198,0.4}}, 0.5)
h(hat_rim, {{190,251,0.3},{204,244,0.5},{218,241,0.3}}, 0.45)

--@ chunk 84
bn_dk = pile{{"Indian red", 1}, {"bone black", 0.3}, {"raw umber", 0.3}, name="bn_dk"}
bn_lt = pile{{"vermilion", 1}, {"orange chrome", 0.3}, {"Indian red", 0.3}, {"lead white", 0.1}, name="bn_lt"}
cb_neckband = poly({{240,298},{256,302},{266,301},{274,300},{280,304},{286,312},{282,318},{270,320},{256,318},{242,314},{232,308}}, true)
work(cb_neckband, {hand="detail", tool={kind="round", width=3}, pile=bn_dk, coverage=3, clip=cb_neckband, angle=0.2, seed=251})
local rb = brush{kind="round", width=3, point=0.8, stiffness=0.55}
rb:reload(bn_lt, 0.6)
rb:gesture({{272,302,0.4},{280,306,0.6},{284,312,0.4}}, {wobble=0.2, clip=cb_neckband})
rb:reload(bn_lt, 0.5)
rb:gesture({{266,304,0.3},{270,310,0.5},{268,317,0.3}}, {wobble=0.2, clip=cb_neckband})
cowboy = cowboy + cb_head3 + cb_neckband

--@ chunk 85
print(drying(400,600), drying(600,520), drying(900,650), drying(100,690), drying(612,540))
sage_dk = pile{{"raw umber", 1}, {"bone black", 0.35}, {"ultramarine blue", 0.4}, {"green earth", 0.5}, name="sage_dk"}
sage_lt = pile{{"green earth", 0.6}, {"Naples yellow", 0.5}, {"lead white", 0.4}, {"raw umber", 0.3}, {"orange chrome", 0.1}, name="sage_lt"}
fig_all = cowboy + zb_keep + crosses_paint + mounds_all + zg_hole
function scrub(x, y, s, seed)
  math.randomseed(seed)
  local m = nil
  for i = 1, 5 do
    local e = ellipse(x + rand(-10, 10)*s, y - rand(2, 7)*s, rand(5, 9)*s, rand(3, 6)*s)
    m = m and (m + e) or e
  end
  m = (m * above({{x-40*s, y+1*s},{x+40*s, y+1*s}})):roughen(2*s, 4*s, seed) - fig_all
  stipple(m, {pile=sage_dk, width=1.8*s, coverage=2.5, cluster={0.4, 3*s}, pressure={0.4, 0.8}, clip=m, seed=seed})
  local top = m * above({{x-40*s, y-6*s},{x+40*s, y-6*s}})
  stipple(top, {pile=sage_lt, width=1.2*s, coverage=0.5, cluster={0.6, 2*s}, pressure={0.3, 0.5}, feather=1, clip=m, seed=seed+1})
end
-- scale by distance below horizon: s ~ (y-474)/60
local spots = {{40,560},{120,505},{330,500},{420,530},{470,640},{560,505},{650,580},{720,498},{860,520},{940,560},{990,500},{380,488},{60,492},{250,486},{760,488}}
for i, p in ipairs(spots) do
  local s = math.max(0.3, (p[2] - 474) / 55)
  scrub(p[1], p[2], s, 300 + i)
end

--@ chunk 86
local out = {}
for _, p in ipairs({{795,400},{790,330},{820,320},{760,560},{830,560},{740,370},{830,440},{850,300},{880,320}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 87
zb_shirt2 = pile{{"raw umber", 1}, {"yellow ochre", 0.35}, {"green earth", 0.4}, {"lead white", 0.18}, {"bone black", 0.12}, name="zb_shirt2"}
zb_rim = pile{{"Naples yellow", 1}, {"orange chrome", 0.35}, {"lead white", 0.5}, {"raw umber", 0.12}, name="zb_rim"}
zb_flash = pile{{"orange chrome", 1}, {"Naples yellow", 0.6}, {"burnt sienna", 0.3}, {"lead white", 0.2}, name="zb_flash"}
work(zb_shirt_m, {hand="detail", tool={kind="round", width=2.5}, pile=zb_shirt2, coverage=2.5, clip=zb_shirt_m, angle=1.4, seed=261})

--@ chunk 88
local Zc = zb_keep
local rb = brush{kind="round", width=3.2, point=0.85, stiffness=0.55}
local function r(p, pts, load) rb:reload(p, load or 0.65) rb:gesture(pts, {wobble=0.3, clip=Zc}) end
-- flash-lit front edges (left-facing), warm orange
r(zb_flash, {{786,349,0.2},{772,346,0.6},{756,340,0.75},{738,333,0.8},{722,327,0.6}})       -- top of upper arm
r(zb_flash, {{770,370,0.2},{754,374,0.6},{738,369,0.7},{722,363,0.6},{712,360,0.3}})       -- top of lower arm
r(zb_flash, {{786,350,0.3},{776,358,0.6},{769,368,0.7},{766,382,0.6},{768,398,0.5},{772,412,0.3}})  -- chest front
r(zb_flash, {{784,480,0.2},{778,500,0.5},{771,525,0.6},{768,550,0.5},{767,575,0.4},{765,600,0.2}}) -- front of front leg
r(zb_flash, {{774,446,0.2},{776,462,0.4},{779,476,0.2}}, 0.5)  -- coat front lower
-- backlit edges, pale gold, thinner
local tb = brush{kind="round", width=2.2, point=0.9, stiffness=0.55}
local function t(pts, load) tb:reload(zb_rim, load or 0.55) tb:gesture(pts, {wobble=0.3, clip=Zc}) end
t({{806,345,0.3},{820,346,0.6},{832,353,0.7},{839,366,0.6},{841,380,0.4}})
t({{801,296,0.4},{810,299,0.5},{815,307,0.3}})
t({{840,446,0.2},{846,466,0.5},{849,484,0.3}})
t({{829,480,0.2},{834,505,0.5},{840,530,0.5},{846,560,0.4},{852,590,0.2}})

--@ chunk 89
wait(6*24*60)
local out = {}
for _, p in ipairs({{795,400},{790,380},{830,305},{845,300},{850,310},{770,350},{612,540},{600,580},{40,555}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 90
wait(5*24*60)
local out = {}
for _, p in ipairs({{795,400},{790,380},{830,305},{845,300},{850,310},{612,540},{790,430}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))
sk_apricot_r = pile{{"lead white", 2}, {"orange chrome", 0.8}, {"vermilion", 0.25}, {"yellow ochre", 0.3}, name="sk_apricot_r"}
sk_gold_r = pile{{"lead white", 3}, {"Naples yellow", 1.5}, {"orange chrome", 0.5}, {"yellow ochre", 0.3}, name="sk_gold_r"}
sk_match = mix{{sk_apricot_r, 0.75}, {sk_gold_r, 0.25}, name="sk_match"}

--@ chunk 91
-- tiny trial dab inside the streak zone
local tb = brush{kind="round", width=5, stiffness=0.5}
tb:reload(sk_match, 0.7)
tb:touch(866, 300, {pressure=0.7, drag={4, 0}})
tb:reload(sk_gold_r, 0.7)
tb:touch(866, 290, {pressure=0.7, drag={4, 0}})
tb:reload(sk_apricot_r, 0.7)
tb:touch(866, 310, {pressure=0.7, drag={4, 0}})

--@ chunk 92
local streaks = ribbon({{824,305},{842,298},{858,293}}, 12) + ribbon({{826,312},{846,309},{862,308}}, 12) + ribbon({{818,298},{826,292},{838,283}}, 11)
local hair = ribbon({{812,299},{816,298},{826,300}}, 8) + ribbon({{814,305},{820,307},{830,311}}, 8) + ribbon({{814,312},{820,317},{828,326}}, 8) + ribbon({{802,295},{806,290},{814,282}}, 8)
local cov = (streaks + hair):soften(3) - zb_head2:grow(0.3)
work(cov, {hand="detail", tool={kind="round", width=3.5}, pile=sk_match, coverage=3.5, clip=cov, edge="soft", seed=271})

--@ chunk 93
sh_glaze2 = pile{{"raw umber", 1}, {"ultramarine blue", 0.35}, {"bone black", 0.2}, {"rose madder", 0.1}, medium=0.85, name="sh_glaze2"}
S = {760, 478}
local function dir(bx, by) local dx, dy = bx - S[1], by - S[2] local n = math.sqrt(dx*dx + dy*dy) return dx/n, dy/n end
local shadows = nil
local function add(m) shadows = shadows and (shadows + m) or m end
-- crosses
for i, c in ipairs(crosses_def) do
  local bx, by, h = c[1], c[2], c[3]
  local ux, uy = dir(bx, by)
  local L = 1.3 * h * (0.6 + 0.4*smoothstep(500, 620, by))
  local w = h * 0.075
  local ex, ey = bx + ux*L, by + uy*L
  add(ribbon({{bx, by}, {bx + ux*L*0.5, by + uy*L*0.5}, {ex, ey}}, {w*1.0, w*1.15, w*1.3}))
  local cx, cy = bx + ux*L*0.74, by + uy*L*0.74
  local bl = h*0.27
  add(ribbon({{cx - bl, cy + 1}, {cx + bl, cy - 1}}, {w*0.9, w*0.9}))
end
-- zombie legs
add(poly({{752,622},{770,622},{774,714},{742,714}}, true))
local ux, uy = dir(850, 615)
add(poly({{840,616},{862,612},{862 + ux*130 + 10, 612 + uy*130},{840 + ux*130 - 8, 616 + uy*130}}, true))
-- cowboy feet shadows going left
add(poly({{140,700},{200,700},{120,714},{40,714}}, true))
add(poly({{290,702},{346,700},{250,714},{180,714}}, true))
shadow_m = (shadows:soften(5) * land) - fig_all
work(shadow_m, {hand="body", tool={kind="filbert", width=8, stiffness=0.35}, pile=sh_glaze2, coverage=1.6, fill=true,
  angle=function(x,y) local a, b = dir(x, y + 0.001) return math.atan(b, a) end, edge="soft", clip=land - fig_all, seed=281})
blend(shadow_m:grow(5) - fig_all:grow(1), {angle=0.3})

--@ chunk 94
local function dir(bx, by) local dx, dy = bx - S[1], by - S[2] local n = math.sqrt(dx*dx + dy*dy) return dx/n, dy/n end
local r = rag{width=16}
local function lift(pts, passes)
  for p = 1, passes do
    r:refold() r:dip(1.0)
    r:wipe(pts, {pressure=1.0})
  end
end
for i, c in ipairs(crosses_def) do
  local bx, by, h = c[1], c[2], c[3]
  local ux, uy = dir(bx, by)
  local L = 1.3 * h * (0.6 + 0.4*smoothstep(500, 620, by))
  local s0 = 6
  lift({{bx + ux*s0, by + uy*s0}, {bx + ux*(L+6), by + uy*(L+6)}}, 3)
  local cx, cy = bx + ux*L*0.74, by + uy*L*0.74
  local bl = h*0.27
  lift({{cx - bl - 6, cy + 1}, {cx + bl + 6, cy - 1}}, 3)
end
-- zombie leg shadows
lift({{760,630},{760,714}}, 3)
local ux, uy = dir(850, 615)
lift({{851 + ux*8, 614 + uy*8}, {851 + ux*135, 614 + uy*135}}, 3)
print(r)

--@ chunk 95
wait(5*24*60)
local out = {}
for _, p in ipairs({{500,540},{560,580},{650,535},{770,680},{880,680},{100,705},{300,707}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 96
wait(3*24*60)
local out = {}
for _, p in ipairs({{500,540},{560,580},{650,535},{770,680},{880,680},{300,707},{475,560},{530,590}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 97
fig_all = cowboy + zb_keep + crosses_paint + mounds_all + zg_hole
local land_m2 = land - fig_all
local function gl(x, y) local d = math.sqrt(((x-760)/2.6)^2 + ((y-478)*1.2)^2) return 1 - smoothstep(20, 90, d) end
work(land_m2, {hand="body", tool={kind="flat", width=12, stiffness=0.6},
  piles={{ld_hz2, function(x,y) return (1 - smoothstep(482, 530, y)) * (1 - gl(x,y)) end},
         {ld_glow, function(x,y) return gl(x,y) * (1 - smoothstep(484, 540, y)) end},
         {ld_mid2, function(x,y) local t = smoothstep(482, 530, y) return t * (1 - smoothstep(575, 660, y)) end},
         {ld_near2, function(x,y) return smoothstep(575, 660, y) + 0.4*smoothstep(150, 0, x)*smoothstep(520, 640, y) end}},
  angle=function(x,y) return 0.05*math.sin(x/60 + y/35) end, length={25, 80},
  scale_at=function(x,y) return 0.4 + 1.0*smoothstep(476, 714, y) end,
  coverage=1.7, fill=true, clip=land_m2, mix_jitter=0.06, seed=291})

--@ chunk 98
print(drying(200,450), drying(150,580), drying(280,400), drying(440,346))
coat_glaze6 = pile{{"burnt sienna", 0.6}, {"ultramarine blue", 0.8}, {"bone black", 0.25}, {"raw umber", 0.3}, medium=0.8, name="coat_glaze6"}
coat_back = (cb_coat - cb_head3 - cb_neckband) * mask(function(x, y) return 1 - smoothstep(225, 262, x + (y - 300)*0.12) end)
print(coat_back:area(), coat_back:at(200, 450), coat_back:at(280, 450))

--@ chunk 99
local coat_m = cb_coat - cb_head3 - cb_neckband - cb_hand2
work(coat_back, {hand="glaze", pile=coat_glaze6, coverage=2, fill=true, clip=coat_m, angle=1.5, seed=301})
blend(coat_m * mask(function(x, y) return 1 - smoothstep(245, 285, x + (y - 300)*0.12) end), {angle=1.5})

--@ chunk 100
print(drying(180,640), drying(300,640), drying(300,560), drying(310,500))
local legs = (cb_legF + cb_legB) - cb_coat
jeans_dk2 = pile{{"ultramarine blue", 0.5}, {"bone black", 0.5}, {"raw umber", 0.9}, {"burnt sienna", 0.2}, {"rose madder", 0.08}, name="jeans_dk2"}
work(legs, {hand="body", tool={kind="filbert", width=8, stiffness=0.55}, pile=jeans_dk2, angle=1.4, coverage=2, fill=true, clip=legs, seed=311})
local rb = brush{kind="round", width=3, point=0.8, stiffness=0.55}
local function r(p, pts, load, clipm) rb:reload(p, load or 0.6) rb:gesture(pts, {wobble=0.4, clip=clipm}) end
-- warm rim down the front edges (glow on the right)
r(cw_rim, {{313,592,0.3},{312,620,0.5},{316,650,0.5},{318,676,0.3}}, 0.5, legs)
r(cw_rim, {{214,610,0.2},{205,630,0.35},{196,650,0.35},{186,672,0.2}}, 0.4, legs)

--@ chunk 101
wait(5*24*60)
local out = {}
for _, p in ipairs({{200,450},{150,580},{240,400},{180,640},{300,640},{500,600}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 102
local gunhand = cb_gun2 + cb_trig + cb_hand2 + cb_sleeve + cb_arm
local halo2 = (ellipse(474, 333, 30, 26):soften(8) + ribbon({{466,310},{460,330},{458,350},{455,360}}, 9):soften(2)) - gunhand:grow(0.8)
work(halo2, {hand="body", tool={kind="filbert", width=6, stiffness=0.35},
  piles={{fl_halo, function(x,y) return 1 end}, {sk_patch, function(x,y) return 0.6*smoothstep(462, 445, x) end}},
  coverage=2.2, fill=true, angle=function(x,y) return math.atan(y-333, x-474) + 1.57 end, edge="soft", clip=-(gunhand:grow(0.5)), seed=321})

--@ chunk 103
wait(60)
local hand = cb_hand2
work(hand, {hand="detail", tool={kind="round", width=2.5}, pile=fc_dk2, coverage=2.5, clip=hand, seed=331})
local rb = brush{kind="round", width=3, point=0.8, stiffness=0.55}
local function g(p, pts, load, clipm) rb:reload(p, load or 0.7) rb:gesture(pts, {wobble=0.15, clip=clipm or hand}) end
-- lit front of the curled fingers (facing the flash)
g(fc_lt2, {{447,337,0.4},{451,341,0.6},{452,346,0.6},{450,351,0.5},{446,355,0.3}}, 0.75)
g(fc_hot, {{450,341,0.35},{451,346,0.4}}, 0.6)
-- knuckle row
g(fc_lt2, {{430,338,0.3},{437,335,0.5},{444,335,0.45}}, 0.55)
-- finger separations
local tb = brush{kind="round", width=1.4, point=0.9, stiffness=0.6}
local function t(pts) tb:reload(fc_dk2, 0.7) tb:gesture(pts, {wobble=0.1, clip=hand}) end
t({{437,342,0.6},{445,342,0.6},{451,343,0.4}})
t({{436,347,0.6},{444,347,0.6},{451,348,0.4}})
t({{435,352,0.6},{443,352,0.6},{449,353,0.4}})
-- thumb along the top toward the hammer
g(fc_md or fc_lt2, {{432,337,0.5},{440,334,0.5},{446,333,0.3}}, 0.5)

--@ chunk 104
-- gun: restate dark, then flash-lit glints
local gun = cb_gun2 + cb_trig
work(gun - cb_hand2, {hand="detail", tool={kind="round", width=1.5}, pile=cw_dark, coverage=3, clip=gun - cb_hand2, seed=332})
gun_glint = pile{{"lead white", 1}, {"Naples yellow", 0.6}, {"cadmium yellow", 0.25}, name="gun_glint"}
local tb = brush{kind="round", width=1.3, point=0.9, stiffness=0.6}
tb:reload(gun_glint, 0.7)
tb:gesture({{456,330,0.3},{468,329.6,0.6},{480,329,0.7},{488,328.8,0.5}}, {wobble=0.05, clip=gun:grow(0.4)})
tb:reload(fl_org, 0.6)
tb:gesture({{456,339,0.5},{460,338,0.6},{463,336,0.3}}, {wobble=0.05, clip=gun:grow(0.3)})
tb:reload(fl_org, 0.6)
tb:gesture({{459,333,0.4},{463,333,0.5}}, {wobble=0.05, clip=gun:grow(0.3)})

--@ chunk 105
wait(5*24*60)
print(drying(440,345), drying(450,345), drying(470,330), drying(150,580), drying(500,600))

--@ chunk 106
wait(4*24*60)
print(drying(440,345), drying(450,345), drying(470,330), drying(474,345), drying(458,320))

--@ chunk 107
local hand = cb_hand2
local rb = brush{kind="round", width=3, point=0.8, stiffness=0.55}
local function g(p, pts, load, clipm) rb:reload(p, load or 0.7) rb:gesture(pts, {wobble=0.15, clip=clipm or hand}) end
g(fc_lt2, {{448,337,0.5},{452,341,0.7},{453,346,0.7},{451,351,0.6},{447,356,0.4}}, 0.8)
g(fc_hot, {{451,341,0.4},{452,346,0.45}}, 0.7)
g(fc_lt2, {{432,337,0.35},{439,334,0.55},{446,334,0.5}}, 0.6)
local tb = brush{kind="round", width=1.4, point=0.9, stiffness=0.6}
local function t(p, pts, load, clipm) tb:reload(p, load or 0.7) tb:gesture(pts, {wobble=0.05, clip=clipm or hand}) end
t(fc_dk2, {{440,342,0.6},{446,342,0.6},{451,343,0.4}})
t(fc_dk2, {{439,347,0.6},{445,347,0.6},{451,348,0.4}})
t(fc_dk2, {{438,352,0.6},{444,352,0.6},{449,353,0.4}})
local gun = cb_gun2 + cb_trig
t(gun_glint, {{458,330,0.4},{470,329.5,0.7},{481,329,0.7},{489,328.8,0.4}}, 0.8, gun:grow(0.6))
t(fl_org, {{456,339,0.6},{460,338,0.7},{463,336,0.4}}, 0.7, gun:grow(0.4))

--@ chunk 108
zb_shirt3 = pile{{"raw umber", 1}, {"green earth", 0.5}, {"bone black", 0.25}, {"yellow ochre", 0.15}, name="zb_shirt3"}
print(drying(792,400))
work(zb_shirt_m, {hand="detail", tool={kind="round", width=2.5}, pile=zb_shirt3, coverage=3, clip=zb_shirt_m, angle=1.4, seed=341})

--@ chunk 109
local fringe = (zb_shirt_m:grow(3) - zb_shirt_m:shrink(1.2)) * zb_torso
work(fringe, {hand="detail", tool={kind="round", width=2}, pile=zb_cloth, coverage=3, clip=fringe, angle=1.4, seed=342})

--@ chunk 110
print(drying(180,640), drying(300,640), drying(170,690), drying(320,690))
legs_glaze = pile{{"bone black", 0.6}, {"ultramarine blue", 0.6}, {"raw umber", 0.6}, {"rose madder", 0.1}, medium=0.75, name="legs_glaze"}

--@ chunk 111
-- new boots: pointed toe, underslung heel, shaft under the jeans
cb_bootF2 = poly({{292,668},{314,668},{318,684},{330,688},{348,694},{352,700},{318,702},{314,708},{300,708},{298,702},{290,700}}, true)
cb_bootB2 = poly({{150,664},{174,664},{178,682},{190,688},{206,694},{208,701},{176,702},{170,708},{156,708},{153,700},{144,698}}, true)
local legs = (cb_legF + cb_legB) - cb_coat - cb_bootF2 - cb_bootB2
work(legs, {hand="glaze", pile=legs_glaze, coverage=2, fill=true, clip=legs, angle=1.4, seed=351})
blend(legs:shrink(1), {angle=1.4})
local boots = cb_bootF2 + cb_bootB2
work(boots, {hand="detail", tool={kind="round", width=2.5}, pile=cw_dark, coverage=3, clip=boots, angle=0, seed=352})
-- cover the old boot shapes that stick out beyond the new ones with ground color
local oldb = (cb_bootF + cb_bootB) - boots:grow(0.3) - (cb_legF + cb_legB)
print(oldb:area())

--@ chunk 112
gnd_patch = mix{{ld_near2, 0.65}, {ld_mid2, 0.35}, name="gnd_patch"}
local boots = cb_bootF2 + cb_bootB2
local legs = cb_legF + cb_legB
local oldb = ((cb_bootF + cb_bootB):grow(1.5) - boots:grow(0.2) - legs:grow(0.2))
work(oldb, {hand="detail", tool={kind="round", width=2.5}, pile=gnd_patch, coverage=3.5, clip=oldb, angle=0, seed=361})

--@ chunk 113
gnd_patch2 = mix{{ld_near2, 0.92}, {ld_mid2, 0.08}, name="gnd_patch2"}
local boots = cb_bootF2 + cb_bootB2
local legs = cb_legF + cb_legB
local oldb = ((cb_bootF + cb_bootB):grow(2.5) - boots:grow(0.2) - legs:grow(0.2))
work(oldb, {hand="detail", tool={kind="round", width=2.5}, pile=gnd_patch2, coverage=4, clip=oldb, angle=0, seed=362})

--@ chunk 114
print(drying(520,330), drying(560,320), drying(600,300))
local cb = brush{kind="filbert", width=9, stiffness=0.7, lay=6}
cb:reload(fl_white_b, 1)
cb:gesture({{491,331,0.35},{500,331,0.8},{512,330,1.0},{526,329,0.8},{540,328,0.3}}, {wobble=0.5})
cb:reload(fl_white_b, 0.9)
cb:gesture({{496,333,0.4},{508,336,0.7},{522,340,0.5},{534,344,0.05}}, {wobble=0.5})
cb:reload(fl_white_b, 0.9)
cb:gesture({{496,329,0.4},{508,325,0.7},{522,320,0.5},{532,315,0.05}}, {wobble=0.5})
-- yellow inner flames beside the core, starting outside the white so they don't drag it
local rb = brush{kind="round", width=5, point=0.85, stiffness=0.5, lay=2.5}
local function t(p, pts, load) rb:reload(p, load or 0.8) rb:gesture(pts, {wobble=0.6}) end
t(fl_yel, {{530,322,0.7},{545,316,0.6},{560,311,0.0}})
t(fl_yel, {{532,338,0.7},{548,343,0.6},{562,348,0.0}})
t(fl_yel, {{540,329,0.7},{556,328,0.6},{574,327,0.0}})
t(fl_yel, {{520,317,0.6},{530,308,0.5},{538,300,0.0}})
t(fl_yel, {{520,344,0.6},{530,352,0.5},{537,360,0.0}})

--@ chunk 115
print(drying(830,305), drying(850,300), drying(815,310))
gore_dk = pile{{"Indian red", 1}, {"bone black", 0.9}, {"permanent alizarin", 0.3}, {"raw umber", 0.3}, name="gore_dk"}
gore_m = pile{{"Indian red", 1}, {"bone black", 0.6}, {"permanent alizarin", 0.35}, medium=0.5, name="gore_m"}
local cx, cy = 815, 309
-- a dense burst right behind the skull: irregular clots
local burst = (ellipse(822, 308, 8, 6) + ellipse(829, 303, 5, 4) + ellipse(828, 314, 4, 3) + ellipse(834, 308, 3.5, 3)):roughen(2, 4, 77)
stipple(burst - zb_head2:shrink(1), {pile=gore_dk, width=2.5, coverage=2.2, cluster={0.5, 3}, pressure={0.5, 0.9}, seed=371})
local sb = brush{kind="round", width=4, stiffness=0.4}
sb:reload(gore_m, 1)
print(sb:spatter{at={cx+8,cy}, toward={60,-14}, spread=0.35, force=0.35})
sb:reload(gore_m, 1)
print(sb:spatter{at={cx+8,cy-3}, toward={50,-30}, spread=0.3, force=0.3})
sb:reload(gore_m, 0.8)
print(sb:spatter{at={cx+8,cy+3}, toward={55,6}, spread=0.3, force=0.3})

--@ chunk 116
zb_skin_gr = pile{{"green earth", 1}, {"raw umber", 0.35}, {"Naples yellow", 0.25}, {"lead white", 0.15}, {"bone black", 0.05}, name="zb_skin_gr"}
local H = zb_head2
-- back of skull in shadow + hair
local back = H * mask(function(x, y) return smoothstep(796, 806, x - (y - 320)*0.25) end)
work(back, {hand="detail", tool={kind="round", width=2.5}, pile=zb_skin_dk, coverage=2.5, clip=H, edge="soft", seed=381})
local rb = brush{kind="round", width=2.6, point=0.85, stiffness=0.55}
local function s(p, pts, load) rb:reload(p, load or 0.7) rb:gesture(pts, {wobble=0.15, clip=H:grow(0.3)}) end
-- cheek/temple mid plane, sickly green
s(zb_skin_gr, {{792,300,0.6},{790,306,0.7},{794,314,0.8},{797,322,0.7},{795,330,0.5}}, 0.7)
-- hair: lank dark strands from crown down the back
s(zb_cloth, {{794,296,0.7},{804,296,0.9},{812,302,0.8},{815,312,0.6}}, 0.8)
s(zb_cloth, {{806,300,0.8},{811,310,0.8},{813,322,0.6},{812,332,0.3}}, 0.8)
-- deep eye socket
s(zb_cloth, {{785,306,0.8},{789,307,1.0},{792,309,0.8},{790,312,0.5}}, 0.9)
-- open mouth: jaw hanging
s(zb_cloth, {{780,322,0.9},{785,323,1.0},{789,326,1.0},{789,331,0.9},{785,334,0.7},{781,331,0.5}}, 0.9)
-- lower jaw, lit from the flash
s(zb_flash, {{779,335,0.4},{782,338,0.6},{787,341,0.6},{792,343,0.4}}, 0.7)

--@ chunk 117
wait(9*24*60)
print(drying(795,310), drying(805,305), drying(785,328), drying(822,308))

--@ chunk 118
wait(2*24*60)
local H = zb_head2
local rb = brush{kind="round", width=2.2, point=0.9, stiffness=0.55}
local function s(p, pts, load, clipm) rb:reload(p, load or 0.75) rb:gesture(pts, {wobble=0.15, clip=clipm}) end
-- lank hair hanging off the back of the skull, past the silhouette (dark against sky)
s(zb_cloth, {{800,295,0.8},{808,297,0.8},{815,302,0.7},{820,310,0.5},{822,318,0.2}}, 0.85)
s(zb_cloth, {{806,299,0.8},{813,306,0.8},{817,316,0.6},{818,326,0.3},{816,332,0.05}}, 0.85)
s(zb_cloth, {{810,304,0.7},{815,314,0.6},{814,326,0.4},{811,336,0.05}}, 0.8)
s(zb_cloth, {{796,294,0.7},{800,290,0.5},{804,288,0.1}}, 0.7)
-- brow ridge (lit) over the socket, sunken cheek (dark)
s(zb_flashlit2, {{783,302,0.4},{787,303,0.6},{791,305,0.4}}, 0.7, H)
s(zb_skin_dk, {{792,316,0.6},{793,322,0.7},{791,328,0.5}}, 0.8, H)
-- lit cheekbone
s(zb_skin_gr, {{787,313,0.5},{790,316,0.6}}, 0.7, H)

--@ chunk 119
s2_deep = pile{{"ultramarine blue", 1}, {"raw umber", 0.6}, {"lead white", 0.3}, {"rose madder", 0.15}, {"bone black", 0.1}, name="s2_deep"}
s2_dusk = pile{{"ultramarine blue", 0.8}, {"lead white", 0.8}, {"raw umber", 0.35}, {"rose madder", 0.12}, {"Prussian blue", 0.05}, name="s2_dusk"}
s2_mauve = pile{{"lead white", 1.5}, {"ultramarine blue", 0.4}, {"rose madder", 0.35}, {"raw umber", 0.2}, name="s2_mauve"}
s2_rose = pile{{"lead white", 2}, {"vermilion", 0.35}, {"rose madder", 0.3}, {"raw umber", 0.12}, {"Naples yellow", 0.3}, name="s2_rose"}
cl_gray = pile{{"lead white", 1.2}, {"ultramarine blue", 0.5}, {"rose madder", 0.35}, {"raw umber", 0.35}, name="cl_gray"}
cl_pink = pile{{"lead white", 2}, {"rose madder", 0.4}, {"vermilion", 0.15}, {"ultramarine blue", 0.15}, {"raw umber", 0.1}, name="cl_pink"}
local function e(x, y) return math.sqrt(((x-760)/1.7)^2 + (y-485)^2) end
local function bump(v, a, b, c, d) return smoothstep(a, b, v) * (1 - smoothstep(c, d, v)) end
sky_piles3 = {
  {s2_rose,  function(x, y) return bump(e(x,y), 220, 280, 290, 350) end},
  {s2_mauve, function(x, y) return bump(e(x,y), 290, 350, 360, 430) end},
  {s2_dusk,  function(x, y) return bump(e(x,y), 360, 430, 450, 540) end},
  {s2_deep,  function(x, y) return smoothstep(450, 540, e(x,y)) end},
}
SB = poly({{-10,38},{1010,30},{1010,200},{600,215},{-10,212}}, true) - cowboy:grow(3)
work(SB, {hand="broad", piles=sky_piles3, angle=sky_angle, coverage=2, fill=true, edge="lost", clip=-(cowboy:grow(2)), mix_jitter=0.05, seed=391})
print(drying(200,120))

--@ chunk 120
local cb2 = brush{kind="filbert", width=22, stiffness=0.35}
local cb3 = brush{kind="filbert", width=14, stiffness=0.35}
local function c(br, p, pts, load) br:reload(p, load or 0.45) br:gesture(pts, {wobble=6, orient="across", clip=-(cowboy:grow(2))}) end
-- left cloud bank: a long, drifting band rising slightly to the right, lit pink underneath
c(cb2, cl_gray, {{-20,96,0.15},{80,100,0.45},{200,110,0.55},{330,122,0.45},{450,134,0.2},{520,140,0.0}}, 0.45)
c(cb2, cl_gray, {{-20,130,0.2},{100,136,0.5},{230,146,0.5},{360,156,0.35},{470,164,0.1}}, 0.45)
c(cb3, cl_pink, {{0,154,0.15},{110,160,0.4},{240,168,0.35},{360,176,0.15},{420,180,0.0}}, 0.4)
c(cb3, cl_pink, {{60,118,0.05},{160,124,0.3},{270,134,0.25},{360,142,0.05}}, 0.35)
c(cb3, cl_gray, {{120,76,0.05},{220,82,0.3},{330,92,0.25},{420,100,0.05}}, 0.35)
-- right high cloud: thinner, broken
c(cb2, cl_gray, {{560,90,0.05},{660,82,0.35},{780,76,0.45},{900,70,0.4},{1020,66,0.3}}, 0.45)
c(cb3, cl_pink, {{640,104,0.05},{740,100,0.3},{860,94,0.35},{1020,90,0.25}}, 0.4)
c(cb3, cl_gray, {{600,150,0.05},{700,146,0.25},{820,140,0.3},{950,134,0.2},{1020,132,0.1}}, 0.35)
c(cb3, cl_pink, {{680,168,0.05},{780,164,0.25},{900,160,0.25},{1020,156,0.1}}, 0.35)
blend(SB:shrink(22):soften(22), {angle=0.04})

--@ chunk 121
wait(7*24*60)
local out = {}
for _, p in ipairs({{200,120},{100,150},{700,90},{215,200},{300,195},{232,195}}) do
  out[#out+1] = p[1] .. "," .. p[2] .. "=" .. drying(p[1], p[2])
end
print(table.concat(out, "  "))

--@ chunk 122
local ring = (cb_hat:grow(2.8) - cb_hat:shrink(0.3)) * above({{0,262},{1000,262}})
work(ring, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3.5, clip=ring, seed=401})
cb_hat_big = cb_hat:grow(2.8)
cowboy = cowboy + cb_hat_big

--@ chunk 123
print(drying(780,550), drying(830,560), drying(760,615), drying(850,610))
zb_legs_m = (zb_legF + zb_legB) - zb_torso - zb_extra
zb_feet2 = poly({{760,604},{776,604},{780,616},{778,626},{766,628},{748,630},{744,624},{752,618}}, true)
         + poly({{842,594},{856,594},{862,606},{872,614},{868,622},{850,622},{840,612}}, true)

--@ chunk 124
work(zb_legs_m, {hand="glaze", pile=legs_glaze, coverage=2, fill=true, clip=zb_legs_m, angle=1.4, seed=411})
blend(zb_legs_m:shrink(1), {angle=1.4})
-- feet: replace blobs; patch old blob excess with ground color
local oldf = zb_feet:grow(1.5) - zb_feet2 - zb_legs_m - zg_hole
work(oldf, {hand="detail", tool={kind="round", width=2.5}, pile=gnd_patch, coverage=3.5, clip=oldf, angle=0, seed=412})
work(zb_feet2, {hand="detail", tool={kind="round", width=2}, pile=cw_dark, coverage=3, clip=zb_feet2, angle=0, seed=413})

--@ chunk 125
function land_piles()
  local function gl(x, y) local d = math.sqrt(((x-760)/2.6)^2 + ((y-478)*1.2)^2) return 1 - smoothstep(20, 90, d) end
  return {{ld_hz2, function(x,y) return (1 - smoothstep(482, 530, y)) * (1 - gl(x,y)) end},
         {ld_glow, function(x,y) return gl(x,y) * (1 - smoothstep(484, 540, y)) end},
         {ld_mid2, function(x,y) local t = smoothstep(482, 530, y) return t * (1 - smoothstep(575, 660, y)) end},
         {ld_near2, function(x,y) return smoothstep(575, 660, y) + 0.4*smoothstep(150, 0, x)*smoothstep(520, 640, y) end}}
end
local zone = (zb_feet:grow(5) + zb_feet2:grow(4)) - zb_feet2 - zb_legs_m - zg_hole - mounds_all - crosses_paint
work(zone, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=land_piles(), angle=0, coverage=3, clip=zone, seed=421})

--@ chunk 126
print(drying(800,400), drying(790,420), drying(820,380))
zb_cloth_lt = pile{{"raw umber", 1}, {"lead white", 0.35}, {"ultramarine blue", 0.2}, {"rose madder", 0.12}, {"burnt sienna", 0.15}, name="zb_cloth_lt"}
local T = zb_torso + zb_extra + zb_sleeveF
local rb = brush{kind="round", width=3, point=0.8, stiffness=0.55}
local function s(p, pts, load) rb:reload(p, load or 0.65) rb:gesture(pts, {wobble=0.4, clip=T}) end
-- lapel edges framing the shirt (left lapel lit by flash, right one in shade)
s(zb_flash, {{784,358,0.3},{781,372,0.5},{780,390,0.55},{782,410,0.5},{785,430,0.4},{788,448,0.2}}, 0.55)
s(zb_cloth, {{800,358,0.6},{803,378,0.8},{802,400,0.8},{798,425,0.7},{794,450,0.4}}, 0.8)
-- folds: from armpit diagonally down to waist, and along the hunched back
s(zb_cloth_lt, {{812,372,0.2},{818,392,0.5},{820,414,0.5},{818,436,0.3}}, 0.5)
s(zb_cloth, {{824,380,0.3},{828,402,0.7},{826,428,0.6},{822,452,0.3}}, 0.7)
s(zb_cloth_lt, {{774,400,0.2},{776,420,0.45},{780,440,0.4},{784,460,0.2}}, 0.45)
-- rope belt
s(zb_cloth_lt, {{778,448,0.4},{792,452,0.6},{806,452,0.6},{820,448,0.4}}, 0.6)

--@ chunk 127
zb_half = pile{{"raw umber", 1}, {"burnt sienna", 0.35}, {"orange chrome", 0.2}, {"lead white", 0.25}, {"green earth", 0.2}, name="zb_half"}
local T = zb_torso + zb_extra + zb_sleeveF
local side = T * mask(function(x, y) return 1 - smoothstep(774, 790, x - (y - 400)*0.12) end)
work(side, {hand="detail", tool={kind="filbert", width=4, stiffness=0.5}, pile=zb_half, coverage=1.6, clip=T, angle=1.45, edge="soft", seed=431})
blend(T:shrink(1.5), {angle=1.45})

--@ chunk 128
print(drying(780,420), drying(800,400))
local T = zb_torso + zb_extra + zb_sleeveF
local r = rag{width=12}
local inner = T:shrink(6)
r:dip(1.0)
r:wipe(inner, {pressure=0.9, angle=1.45, passes=2, refold=0.4})
print(r, r.damp)

--@ chunk 129
local T = zb_torso + zb_extra + zb_sleeveF
local r = rag{width=7}
r:dip(1.0)
r:wipe(T:shrink(3), {pressure=1.0, angle=1.45, passes=2, refold=0.3})
r:refold() r:dip(1.0)
r:wipe(T:shrink(3), {pressure=1.0, angle=0.2, passes=1, refold=0.3})
print(r)

--@ chunk 130
wait(6*24*60)
print(drying(772,420), drying(790,400), drying(770,360), drying(830,420))

--@ chunk 131
local T = zb_torso + zb_extra + zb_sleeveF
-- cover everything except a thin rim on the flash-facing (left) silhouette edge
local leftEdge = (T - T:shrink(1.8)) * mask(function(x, y) return 1 - smoothstep(785, 795, x - (y - 400)*0.12) end)
local cover = T - leftEdge
local leftZone = cover * mask(function(x, y) return 1 - smoothstep(800, 812, x - (y - 400)*0.12) end)
work(leftZone, {hand="detail", tool={kind="round", width=2.5}, pile=zb_cloth, coverage=3, clip=cover, angle=1.45, seed=441})
-- a dim, close-valued warm plane just inside the rim (one value step)
zb_half2 = pile{{"raw umber", 1}, {"bone black", 0.2}, {"burnt sienna", 0.35}, {"orange chrome", 0.08}, {"lead white", 0.06}, name="zb_half2"}
print("ok")

--@ chunk 132
local s = zb_shirt_m:shrink(1.5)
work(s, {hand="detail", tool={kind="round", width=2}, pile=zb_shirt3, coverage=2, clip=s, angle=1.45, seed=451})

--@ chunk 133
print(drying(295,450), drying(350,330), drying(300,640))
local function edge_right(m, y0, y1, step, inset)
  local pts = {}
  for y = y0, y1, step do
    local xr = nil
    for x = 360, 100, -1 do if m:at(x, y) > 0.5 then xr = x break end end
    if xr then pts[#pts+1] = {xr - inset, y} end
  end
  return pts
end
coat_edge = edge_right(cb_coat - cb_sleeve - cb_arm, 362, 596, 6, 2.2)
print(#coat_edge, coat_edge[1][1], coat_edge[#coat_edge][1])

--@ chunk 134
rim_warm = pile{{"burnt sienna", 1}, {"Naples yellow", 0.9}, {"orange chrome", 0.35}, {"vermilion", 0.12}, {"lead white", 0.2}, name="rim_warm"}
local rb = brush{kind="round", width=3, point=0.8, stiffness=0.55}
local clipm = cb_coat - cb_sleeve - cb_arm
-- coat front: rim, strongest mid-height (facing the glow), fading down
local n = #coat_edge
local pts = {}
for i, p in ipairs(coat_edge) do
  local t = (i - 1) / (n - 1)
  pts[i] = {p[1], p[2], 0.25 + 0.4*math.sin(math.pi * math.min(1, t*1.4))}
end
pts[n][3] = 0.1
-- split into two strokes, as a hand would reload
local a, b = {}, {}
for i = 1, math.floor(n/2) + 1 do a[#a+1] = pts[i] end
for i = math.floor(n/2), n do b[#b+1] = pts[i] end
a[1][3] = 0.1
rb:reload(rim_warm, 0.7) rb:gesture(a, {wobble=0.3, clip=clipm})
rb:reload(rim_warm, 0.6) rb:gesture(b, {wobble=0.3, clip=clipm})

--@ chunk 135
local rb = brush{kind="round", width=2.4, point=0.8, stiffness=0.55}
local clipm = cb_coat - cb_sleeve - cb_arm
local n = #coat_edge
local a = {}
for i = 1, n do
  local p = coat_edge[i]
  local t = (i - 1) / (n - 1)
  a[i] = {p[1] + 1.4, p[2], 0.2 + 0.35*math.sin(math.pi * math.min(1, t*1.4))}
end
a[1][3] = 0.05 a[n][3] = 0.05
local h1, h2 = {}, {}
for i = 1, math.floor(n/2) + 1 do h1[#h1+1] = a[i] end
for i = math.floor(n/2), n do h2[#h2+1] = a[i] end
rb:reload(rim_warm, 0.6) rb:gesture(h1, {wobble=0.2, clip=clipm})
rb:reload(rim_warm, 0.5) rb:gesture(h2, {wobble=0.2, clip=clipm})
-- soft half-tone just inside, a filbert dragged lightly, to turn the edge
coat_half = pile{{"raw umber", 1}, {"burnt sienna", 0.8}, {"Naples yellow", 0.35}, {"vermilion", 0.08}, {"lead white", 0.12}, name="coat_half"}
local fb = brush{kind="filbert", width=6, stiffness=0.45}
local c = {}
for i = 1, n do local p = coat_edge[i] c[i] = {p[1] - 4, p[2], 0.25 + 0.2*math.sin(math.pi * (i-1)/(n-1))} end
c[1][3] = 0.05 c[n][3] = 0.05
fb:reload(coat_half, 0.35) fb:gesture(c, {wobble=0.6, clip=clipm})

--@ chunk 136
local clipm = cb_coat - cb_sleeve - cb_arm
local band = (clipm - clipm:shrink(10)) * mask(function(x, y) return smoothstep(250, 270, x) end) * below({{0,355},{1000,355}})
blend(band, {angle=1.5})

--@ chunk 137
local r = rag{width=9}
local n = #coat_edge
local path = {}
for i = 1, n do local p = coat_edge[i] path[i] = {p[1] - 3, p[2]} end
for k = 1, 3 do
  r:refold() r:dip(1.0)
  r:wipe(path, {pressure=1.0})
end
local path2 = {}
for i = 1, n do local p = coat_edge[i] path2[i] = {p[1] - 7, p[2]} end
r:refold() r:dip(1.0)
r:wipe(path2, {pressure=1.0})
print(r)

--@ chunk 138
wait(6*24*60)
print(drying(283,357), drying(296,585), drying(290,450))

--@ chunk 139
coat_fix = mix{{cw_coat_md, 0.55}, {coat_vdk, 0.25}, {coat_glaze4, 0.2}, name="coat_fix"}

--@ chunk 140
local clipm = cb_coat - cb_sleeve - cb_arm
-- band mask from the edge polyline: points (edge-1.8) and (edge-13)
local outer, inner = {}, {}
for i, p in ipairs(coat_edge) do outer[#outer+1] = {p[1] + 2.2 - 2.0, p[2]} inner[#inner+1] = {p[1] + 2.2 - 13, p[2]} end
local pts = {}
for i = 1, #outer do pts[#pts+1] = outer[i] end
for i = #inner, 1, -1 do pts[#pts+1] = inner[i] end
fix_band = poly(pts) * clipm
work(fix_band, {hand="detail", tool={kind="filbert", width=3, stiffness=0.5}, pile=coat_fix, coverage=3, clip=fix_band, angle=1.5, seed=461})

--@ chunk 141
wait(7*24*60)
print(drying(280,450), drying(285,360), drying(296,590))

--@ chunk 142
local clipm = cb_coat - cb_sleeve - cb_arm
-- cover the leftover yellow tabs at the band's ends first, with coat_fix
local tabs = (ellipse(285, 359, 6, 4) + ellipse(285, 592, 6, 5)) * clipm - (clipm - clipm:shrink(1.8))
work(tabs, {hand="detail", tool={kind="round", width=2}, pile=coat_fix, coverage=3.5, clip=tabs, seed=471})
-- glaze the band and its surroundings so it sinks into the coat
local zone = (fix_band:grow(6) * clipm) - (clipm - clipm:shrink(1.8))
work(zone, {hand="glaze", tool={kind="filbert", width=8, stiffness=0.3}, pile=coat_glaze4, coverage=2, fill=true, clip=zone, angle=1.5, seed=472})
blend(zone:shrink(1), {angle=1.5})

--@ chunk 143
print(drying(150,700), drying(330,705))
local boots = cb_bootF2 + cb_bootB2
local legs = cb_legF + cb_legB
local zone = ((cb_bootF + cb_bootB):grow(6) + boots:grow(5)) - boots - legs - cb_coat
work(zone, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=land_piles(), angle=0, coverage=3.5, clip=zone, seed=481})
-- contact darks right under the soles (soft occlusion, not cast shadow)
contact_dk = pile{{"raw umber", 1}, {"bone black", 0.5}, {"ultramarine blue", 0.4}, name="contact_dk"}
local soles = ellipse(178, 707, 34, 3.5):soften(2) + ellipse(322, 708, 34, 3.5):soften(2) + ellipse(762, 629, 22, 3):soften(2) + ellipse(858, 623, 18, 3):soften(2)
soles = soles - boots - zb_feet2
work(soles, {hand="detail", tool={kind="round", width=2.5}, pile=contact_dk, coverage=2, clip=soles, angle=0, edge="soft", seed=482})

--@ chunk 144
gnd_fg = pile{{"raw umber", 1}, {"ultramarine blue", 0.55}, {"rose madder", 0.28}, {"bone black", 0.2}, {"lead white", 0.4}, name="gnd_fg"}

--@ chunk 145
gnd_mix = mix{{gnd_fg, 0.55}, {ld_near2, 0.45}, name="gnd_mix"}

--@ chunk 146
local boots = cb_bootF2 + cb_bootB2
local legs = cb_legF + cb_legB
local zone = ((cb_bootF + cb_bootB):grow(7) + boots:grow(6)) - boots - legs - cb_coat
work(zone, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, pile=gnd_mix, angle=0, coverage=3, clip=zone, edge="soft", seed=491})

--@ chunk 147
wait(6*24*60)
print(drying(150,700), drying(330,705), drying(100,690), drying(600,690))

--@ chunk 148
wait(6*24*60)
print(drying(150,700), drying(330,705), drying(140,670), drying(350,690))

--@ chunk 149
wait(5*24*60)
print(drying(150,700), drying(330,705), drying(140,670), drying(350,690), drying(320,700))

--@ chunk 150
fg_dark = pile{{"raw umber", 1}, {"bone black", 0.45}, {"ultramarine blue", 0.55}, {"rose madder", 0.15}, {"lead white", 0.08}, name="fg_dark"}
fig_all = cowboy + zb_keep + zb_feet2 + crosses_paint + mounds_all + zg_hole + cb_bootF2 + cb_bootB2
local fg = land * below({{0,600},{1000,600}}) - fig_all
work(fg, {hand="body", tool={kind="flat", width=14, stiffness=0.6},
  piles={{ld_mid2, function(x,y) return 1 - smoothstep(600, 650, y) end},
         {ld_near2, function(x,y) return smoothstep(600, 650, y) * (1 - smoothstep(660, 714, y)) + 0.3 end},
         {fg_dark, function(x,y) return smoothstep(650, 714, y) end}},
  angle=function(x,y) return 0.04*math.sin(x/70 + y/30) end, length={30, 90},
  scale_at=function(x,y) return 0.6 + 0.8*smoothstep(600, 714, y) end,
  coverage=1.8, fill=true, clip=fg, edge={lost=1}, mix_jitter=0.05, seed=501})

--@ chunk 151
local boots = cb_bootF2 + cb_bootB2
local legs = cb_legF + cb_legB
local zone = ((cb_bootF + cb_bootB):grow(1.5)) - boots - legs - cb_coat
local pz = {{ld_mid2, function(x,y) return 1 - smoothstep(600, 650, y) end},
         {ld_near2, function(x,y) return smoothstep(600, 650, y) * (1 - smoothstep(660, 714, y)) + 0.3 end},
         {fg_dark, function(x,y) return smoothstep(650, 714, y) end}}
work(zone, {hand="detail", tool={kind="flat", width=4, stiffness=0.6}, piles=pz, angle=0, coverage=3, clip=zone, seed=511})
cowboy = cowboy - ((cb_bootF + cb_bootB) - boots - legs - cb_coat)

--@ chunk 152
wait(10*24*60)
print(drying(940,700), drying(500,690), drying(100,650))

--@ chunk 153
sig_p = pile{{"red earth", 1}, {"lead white", 0.3}, {"raw umber", 0.35}, medium=0.2, name="sig"}
function sign(x0, yb, s)
  local rb = brush{kind="rigger", width=1.3*s, point=0.9, stiffness=0.5}
  local function L(pts) local q = {} for i, p in ipairs(pts) do q[i] = {x0 + p[1]*s, yb + p[2]*s, p[3] or 0.6} end rb:reload(sig_p, 0.6) rb:gesture(q, {wobble=0.1}) end
  L({{4,-8.5,0.4},{1.5,-9,0.6},{0,-5,0.7},{0.6,-1,0.7},{3,0,0.6},{5,-1.2,0.3}})
  L({{7.5,-11,0.5},{7,-5,0.7},{7.2,0,0.6},{8.4,-0.6,0.3}})
  L({{13.6,-5.2,0.5},{11.5,-6,0.6},{10,-3.5,0.7},{11,-0.2,0.7},{13.5,-1.4,0.6},{13.7,-5.5,0.6},{13.8,-0.5,0.6},{15,-0.3,0.3}})
  L({{16.5,-6,0.5},{16.6,-2,0.7},{18,0,0.7},{20,-1.5,0.6},{20.3,-6,0.6},{20.4,-1,0.6},{21.6,-0.3,0.3}})
  L({{26.8,-5.2,0.5},{24.5,-6,0.6},{23,-3.5,0.7},{24,-0.2,0.7},{26.6,-1.4,0.6},{27,-11,0.6},{27.1,-0.5,0.6},{28.3,-0.3,0.3}})
  L({{29.8,-2.8,0.5},{32.6,-3.6,0.6},{32.3,-5.8,0.6},{30.2,-5.6,0.6},{29.6,-2.6,0.7},{31,-0.1,0.6},{33.4,-0.8,0.3}})
end
sign(912, 701, 1.3)
