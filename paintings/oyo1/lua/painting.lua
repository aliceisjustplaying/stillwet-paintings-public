-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{size=900, aspect=1.35, linen={18,16}, seed=7,
 ground={{pile={{"lead white",6},{"yellow ochre",1},{"raw umber",0.35}}, um=90, apply="knife", texture=0.35}}}
print("W H", W, H)
print(table.concat(tubes(), ", "))

--@ chunk 2
-- Lay-in piles, turps-thinned washes
sky_dark = pile{{"ultramarine blue",3},{"lead white",2},{"bone black",0.5},{"cobalt violet",0.6}, turps=0.55, name="sky_dark"}
sky_pale = pile{{"lead white",6},{"cobalt blue",0.6},{"Naples yellow",0.8},{"cobalt violet",0.2}, turps=0.55, name="sky_pale"}
hill_far = pile{{"cobalt blue",1.5},{"lead white",3},{"cobalt violet",0.8},{"green earth",0.5}, turps=0.55, name="hill_far"}
tree_dark = pile{{"Prussian blue",1},{"yellow ochre",1.2},{"raw umber",1.2},{"bone black",0.4}, turps=0.5, name="tree_dark"}
field_gold = pile{{"yellow ochre",4},{"lead-tin yellow",2},{"Naples yellow",1.5},{"burnt sienna",0.4}, turps=0.55, name="field_gold"}
field_shadow = pile{{"raw umber",2},{"yellow ochre",2},{"cobalt violet",0.5},{"ultramarine blue",0.4}, turps=0.55, name="field_shadow"}
track_pale = pile{{"lead white",4},{"yellow ochre",1.5},{"raw umber",0.5}, turps=0.5, name="track_pale"}
print(sky_dark); print(sky_pale); print(field_gold); print(tree_dark)

--@ chunk 3
sky_dark:add{{"bone black",1.2},{"raw umber",1.0},{"lead white",0.4}}
sky_mid = pile{{"ultramarine blue",2},{"lead white",3.5},{"bone black",0.7},{"raw umber",0.6},{"cobalt violet",0.5}, turps=0.55, name="sky_mid"}
print(sky_dark); print(sky_mid)

--@ chunk 4
-- pencil sketch
h = pencil("2B")
h:sketch({{0,340},{250,332},{520,342},{780,330},{1000,342}}, {pressure=0.35, passes=2})
h:sketch({{0,405},{200,395},{430,410},{700,398},{1000,412}}, {pressure=0.3, passes=2})
h:sketch({{370,741},{430,620},{530,515},{625,452},{672,418}}, {pressure=0.35, passes=2})
h:sketch({{885,741},{875,560},{868,380},{862,220},{850,120}}, {pressure=0.4, passes=2})
h:line({{642,425},{642,392},{715,392},{715,425}}, {pressure=0.4})
h:line({{635,392},{678,372},{722,392}}, {pressure=0.4})

-- SKY lay-in, graded dark top-left to pale bottom-right
sky_m = poly({{0,0},{1000,0},{1000,342},{800,331},{600,342},{400,334},{200,345},{0,337}})
work(sky_m, {hand="broad", angle=0.08, coverage=1.4, fill=true,
 piles={{sky_dark, function(x,y) return clamp(1.15 - y/340*0.9 - x/1000*0.35, 0.02, 1.2) end},
        {sky_mid,  function(x,y) return 0.55 end},
        {sky_pale, function(x,y) return clamp((y/340)^2*1.1 + (x/1000)*0.35, 0.02, 1.4) end}}})

-- distant hills
hill_m = poly({{0,337},{200,345},{400,334},{600,342},{800,331},{1000,342},{1000,408},{760,396},{520,410},{280,398},{0,408}})
work(hill_m, {hand="broad", pile=hill_far, angle=0.02, coverage=1.2, fill=true})

-- field base (under trees etc) graded shadow left to gold right
field_m = poly({{0,398},{280,392},{520,404},{760,392},{1000,404},{1000,741},{0,741}})
work(field_m, {hand="broad", angle=-0.12, coverage=1.3, fill=true,
 piles={{field_shadow, function(x,y) return clamp(1.1 - x/1000*0.95 + (y-400)/340*0.25, 0.02, 1.2) end},
        {field_gold,   function(x,y) return clamp(0.25 + x/1000*0.95, 0.02, 1.3) end}}})

-- tree line, irregular top
tree_m = poly({{0,400},{60,382},{130,394},{190,376},{260,392},{330,380},{400,396},{470,384},{540,398},{600,386},{665,400},{730,388},{800,402},{870,390},{940,404},{1000,394},{1000,435},{0,438}}, true)
work(tree_m, {hand="body", pile=tree_dark, angle=0.4, coverage=1.4, fill=true, edge="soft"})

-- track
track_m = ribbon({{365,745},{425,625},{528,518},{622,455},{670,420}}, {78,52,30,17,10})
work(track_m, {hand="body", pile=track_pale, angle=1.1, coverage=1.1, fill=true, edge="soft"})
print("lay-in done", drying(500,200), drying(500,600))

--@ chunk 5
storm_dark = pile{{"ultramarine blue",2},{"bone black",1.5},{"raw umber",1},{"lead white",1.6},{"cobalt violet",0.5}, name="storm_dark"}
storm_mid = pile{{"lead white",4},{"ultramarine blue",1.2},{"bone black",0.5},{"raw umber",0.5},{"cobalt violet",0.4}, name="storm_mid"}
glow = pile{{"lead white",5},{"Naples yellow",1.6},{"cadmium yellow",0.4},{"rose madder",0.15},{"cobalt blue",0.2}, name="glow"}
field_shad2 = pile{{"raw umber",2.2},{"yellow ochre",1.6},{"ultramarine blue",0.7},{"cobalt violet",0.4},{"lead white",0.5}, name="field_shad2"}
track_mid = pile{{"lead white",2.5},{"yellow ochre",1.8},{"raw umber",1.4},{"bone black",0.25}, name="track_mid"}
hill2 = pile{{"lead white",2.2},{"cobalt blue",1.2},{"cobalt violet",1},{"green earth",0.6},{"bone black",0.2}, name="hill2"}
print(storm_dark); print(glow); print(field_shad2); print(track_mid)

--@ chunk 6
storm_dark:add{{"bone black",1.0},{"raw umber",0.8}}
gold_body = pile{{"yellow ochre",3},{"lead-tin yellow",2},{"Naples yellow",1},{"cadmium yellow",0.5},{"burnt sienna",0.3},{"lead white",0.6}, name="gold_body"}
print(storm_dark); print(gold_body)
-- SKY body, wet into wet
work(sky_m, {hand="broad", angle=0.12, coverage=1.25, fill=true,
 piles={{storm_dark, function(x,y) return clamp(1.5 - y/300*1.25 - x/1000*0.45, 0.0, 1.5) end},
        {storm_mid,  function(x,y) return clamp(0.25 + y/340*0.55, 0.0, 1.0) end},
        {glow,       function(x,y) return clamp(((y-180)/160)^2 * (0.25 + x/1000*0.95), 0.0, 1.3) end}}})
-- low glow concentrated right of horizon, soft
glow_m = (ellipse(770,335,360,85) * sky_m):soften(28)
work(glow_m, {hand="broad", pile=glow, angle=0.0, coverage=0.85, edge="lost"})
-- distant ridge, left side only, softer/darker than glow, behind trees
ridge_m = poly({{0,352},{150,338},{300,350},{430,342},{560,358},{560,392},{0,394}}, true)
work(ridge_m, {hand="body", pile=hill2, angle=0.0, coverage=1.1, fill=true, edge="soft"})
-- field: shadow strip under trees
strip_m = (rect(0,425,1000,64) * field_m):soften(14)
work(strip_m, {hand="body", pile=field_shad2, angle=-0.05, coverage=0.9, edge="soft"})
-- big cloud shadow, lower left
cshad_m = (ellipse(90,680,520,300) * field_m):soften(45)
work(cshad_m, {hand="broad", angle=-0.25, coverage=1.05, fill=true,
 piles={{field_shad2, function(x,y) return clamp(1.25 - x/1000*0.7, 0.15, 1.25) end},
        {gold_body,   function(x,y) return clamp(x/1000*0.55, 0.0, 0.6) end}}})
-- tone track down
work(track_m, {hand="body", pile=track_mid, angle=-0.85, coverage=1.25, fill=true, edge="soft"})
print("campaign2", drying(200,80), drying(500,600))

--@ chunk 7
shadow_cool = pile{{"raw umber",2},{"ultramarine blue",1.2},{"yellow ochre",1},{"bone black",0.5},{"cobalt violet",0.4}, name="shadow_cool"}
tree_body = pile{{"ultramarine blue",1},{"yellow ochre",1.5},{"raw umber",1.5},{"bone black",0.8},{"viridian",0.5}, name="tree_body"}
tree_lit = pile{{"yellow ochre",2},{"green earth",1},{"viridian",0.6},{"lead white",0.8},{"raw umber",0.5}, name="tree_lit"}
gold_body:add{{"cadmium yellow",0.5}}
print(shadow_cool); print(tree_body); print(tree_lit)

-- 1. lower sky repainted as one graded pass, covering ridge slab down to y=398
lowsky_m = poly({{0,225},{1000,225},{1000,398},{0,398}})
work(lowsky_m, {hand="broad", angle=0.05, coverage=1.35, fill=true,
 piles={{storm_mid, function(x,y) return clamp(1.3 - (y-225)/150*0.9 - x/1000*0.35, 0.05, 1.3) end},
        {glow,      function(x,y) return clamp(((y-225)/150)^1.5 * (0.35 + x/1000*1.05), 0.0, 1.5) end},
        {storm_dark,function(x,y) return clamp(0.55 - (y-225)/150*0.55 - x/1000*0.2, 0.0, 0.6) end}}})
blend(rect(0,240,1000,150), {angle=0.0})

-- 2. whole field, one graded pass
work(field_m, {hand="broad", angle=-0.18, coverage=1.4, fill=true,
 piles={{shadow_cool, function(x,y)
            local xb = 430 + (y-430)*0.45
            local s = clamp((xb - x)/300, 0, 1)
            local strip = clamp((495 - y)/70, 0, 1)*0.55
            return 0.12 + 1.5*s + strip + (y-400)/340*0.22
          end},
        {gold_body, function(x,y)
            local xb = 430 + (y-430)*0.45
            local s = clamp((xb - x)/300, 0, 1)
            local strip = clamp((495 - y)/70, 0, 1)*0.55
            return clamp(1.4 - 1.3*s - strip*0.7, 0.05, 1.4)
          end},
        {field_shad2, function(x,y) return 0.35 end}}})

-- 3. tree line repainted full width, varied top and bottom, lit more to right
tree_m2 = poly({{0,398},{45,372},{95,388},{150,364},{215,386},{275,370},{340,392},{405,376},{465,394},{525,380},{580,396},{630,384},{690,398},{745,384},{805,400},{860,386},{920,402},{965,388},{1000,396},{1000,442},{920,430},{840,448},{760,432},{680,446},{600,430},{520,444},{440,430},{360,446},{280,432},{200,444},{120,430},{40,442},{0,436}}, true)
work(tree_m2, {hand="body", angle=0.5, coverage=1.5, fill=true, edge="soft",
 piles={{tree_body, function(x,y) return clamp(1.35 - x/1000*0.55, 0.4, 1.35) end},
        {tree_lit,  function(x,y) return clamp(0.15 + x/1000*0.6, 0.05, 0.8) end}}})

-- 4. narrower track over buried old track
track_m2 = ribbon({{365,745},{425,625},{528,518},{622,455},{670,420}}, {58,40,22,12,8})
work(track_m2, {hand="body", pile=track_mid, angle=-0.85, coverage=1.3, fill=true, edge="soft"})
print("repair done")

--@ chunk 8
oak_dark = pile{{"ultramarine blue",1},{"yellow ochre",1},{"raw umber",1.5},{"bone black",1.2},{"viridian",0.4}, name="oak_dark"}
bark = pile{{"raw umber",3},{"bone black",1},{"burnt sienna",0.5}, name="bark"}
house_wall = pile{{"lead white",5},{"Naples yellow",0.8},{"yellow ochre",0.4},{"raw umber",0.2}, name="house_wall"}
house_side = pile{{"lead white",3},{"yellow ochre",0.8},{"ultramarine blue",0.4},{"raw umber",0.6}, name="house_side"}
roof_red = pile{{"red earth",2},{"burnt sienna",1},{"vermilion",0.5},{"raw umber",0.6},{"bone black",0.2}, name="roof_red"}
print(oak_dark); print(house_wall); print(roof_red)

--@ chunk 9
-- tall crowns rising above tree line
crowns_m = ellipse(125,355,62,48) + ellipse(345,352,72,44) + ellipse(545,356,54,38) + ellipse(800,360,58,40) + ellipse(235,362,44,32)
work(crowns_m, {hand="body", pile=tree_body, angle=0.5, coverage=1.3, fill=true, edge="soft"})

-- OAK: trunk first, leaning slightly left as it rises
trunk_m = ribbon({{908,748},{898,590},{888,430},{872,270},{858,185}}, {36,29,22,15,10})
work(trunk_m, {hand="body", pile=bark, angle=1.62, coverage=1.5, fill=true, edge="firm"})
-- two main branches reaching left/up
branch1 = ribbon({{862,205},{805,155},{745,128},{700,112}}, {11,8,5,3})
work(branch1, {hand="body", pile=bark, angle=-0.5, coverage=1.3, fill=true, edge="firm"})
branch2 = ribbon({{866,190},{920,125},{965,80}}, {10,6,3})
work(branch2, {hand="body", pile=bark, angle=-1.0, coverage=1.3, fill=true, edge="firm"})
-- canopy, top right, spilling off canvas
canopy_m = ellipse(925,85,175,115) + ellipse(820,150,135,88) + ellipse(975,205,115,82) + ellipse(745,120,80,55)
work(canopy_m, {hand="body", angle=0.6, coverage=1.4, fill=true, edge={found=0.3, soft=0.45, lost=0.25, period=55},
 piles={{oak_dark, function(x,y) return clamp(1.3 - (1000-x)/1000*0.3, 0.5, 1.3) end},
        {tree_lit, function(x,y) return clamp(0.12 + (y)/300*0.25, 0.05, 0.45) end}}})

-- FARMHOUSE at end of track
gable_m = poly({{630,430},{630,400},{656,382},{682,400},{682,430}})
work(gable_m, {hand="detail", pile=house_wall, coverage=1.6, fill=true})
side_m = poly({{682,400},{711,408},{711,429},{682,430}})
work(side_m, {hand="detail", pile=house_side, coverage=1.6, fill=true})
roof_m = poly({{656,382},{682,400},{711,408},{685,390}})
work(roof_m, {hand="detail", pile=roof_red, coverage=1.6, fill=true})
-- roof slope over gable, front-left plane darker red-brown edge
roof_front = poly({{624,402},{656,377},{662,383},{632,406}})
work(roof_front, {hand="detail", pile=bark, coverage=1.2, fill=true})
-- chimney
work(rect(688,378,8,16), {hand="detail", pile=bark, coverage=1.4, fill=true})
print("oak+house done")

--@ chunk 10
-- Integrated tree line: broad humps, house cut out
house_block = rect(618,370,100,66)
tree_m3 = poly({{0,392},{60,348},{130,366},{195,338},{275,364},{350,334},{430,366},{500,344},{575,370},{640,378},{715,376},{775,348},{850,372},{925,360},{1000,382},{1000,444},{900,432},{810,448},{720,434},{630,447},{540,433},{450,446},{360,433},{270,446},{180,433},{90,445},{0,438}}, true) - house_block
work(tree_m3, {hand="body", angle=0.55, coverage=1.45, fill=true, edge="soft", clip=true,
 piles={{tree_body, function(x,y) return clamp(1.3 - x/1000*0.45 + (y-380)/120*0.3, 0.3, 1.4) end},
        {tree_lit,  function(x,y) return clamp(0.55 - (y-330)/120*0.45 + x/1000*0.25, 0.02, 0.7) end},
        {oak_dark,  function(x,y) return clamp((y-390)/60, 0.0, 0.8) end}}})

-- OAK redrawn: thicker trunk
trunk_m2 = ribbon({{910,748},{900,590},{890,430},{874,270},{860,185}}, {54,43,33,23,15})
work(trunk_m2, {hand="body", pile=bark, angle=1.62, coverage=1.5, fill=true, edge="firm"})
-- low branch to right edge
lbranch = ribbon({{888,415},{935,385},{985,368},{1005,362}}, {13,9,6,4})
work(lbranch, {hand="body", pile=bark, angle=-0.35, coverage=1.3, fill=true, edge="firm"})
-- lobed canopy reaching down to ~320
canopy_m2 = poly({{678,150},{715,100},{782,72},{842,88},{898,48},{965,58},{1000,36},{1000,302},{962,282},{934,322},{888,288},{852,328},{812,274},{762,298},{738,242},{696,238},{712,188},{676,178}}, true)
canopy_m2 = canopy_m2 + poly({{928,392},{955,352},{985,366},{1000,348},{1000,430},{968,418},{940,430}}, true)
work(canopy_m2, {hand="body", angle=0.6, coverage=1.5, fill=true, edge={found=0.3, soft=0.45, lost=0.25, period=48},
 piles={{oak_dark, function(x,y) return 1.25 end},
        {tree_body, function(x,y) return clamp((y-150)/200*0.5, 0.0, 0.55) end},
        {tree_lit,  function(x,y) return clamp(((y-200)/140)*0.35 + (1000-x)/1000*0.12, 0.0, 0.45) end}}})
print("trees repaired")

--@ chunk 11
print(wait(4*24*60))
print(drying(200,100), drying(500,600), drying(660,410), drying(900,150))

--@ chunk 12
print(wait(3*24*60))
print(drying(660,410), drying(900,150), drying(300,400))

--@ chunk 13
print(wait(2*24*60)); print(drying(660,410))

--@ chunk 14
stook_lit = pile{{"Naples yellow",2.5},{"lead-tin yellow",2},{"cadmium yellow",0.7},{"yellow ochre",1},{"lead white",0.5}, name="stook_lit"}
win_dark = pile{{"ultramarine blue",1.5},{"bone black",1},{"raw umber",0.5}, name="win_dark"}
lamp = pile{{"cadmium yellow",2},{"orange vermilion",0.5},{"lead white",0.6}, name="lamp"}
roof_slate = pile{{"ultramarine blue",1},{"bone black",1},{"lead white",0.8},{"raw umber",0.5}, name="roof_slate"}
print(stook_lit); print(lamp)

-- grounding shadow + bushes at house base
work(ellipse(668,436,66,11), {hand="body", pile=shadow_cool, coverage=1.0, fill=true, edge="lost"})
work(ellipse(620,428,22,13)+ellipse(716,428,20,12), {hand="body", pile=tree_body, coverage=1.2, fill=true, edge="soft"})

-- small barn left of house
work(poly({{578,432},{578,410},{622,410},{622,432}}), {hand="detail", pile=roof_red, coverage=1.8, fill=true})
work(poly({{572,411},{584,398},{616,398},{628,411}}), {hand="detail", pile=roof_slate, coverage=1.8, fill=true})

-- HOUSE rebuilt: long front wall, big pitched roof plane
work(poly({{628,432},{628,402},{708,402},{708,432}}), {hand="detail", pile=house_wall, coverage=2.2, fill=true, tool="filbert 4"})
work(poly({{620,404},{640,381},{692,381},{716,404}}), {hand="detail", pile=roof_red, coverage=2.0, fill=true, tool="filbert 4"})
work(rect(683,366,9,18), {hand="detail", pile=bark, coverage=1.8, fill=true})
-- door + windows
work(rect(662,415,11,17), {hand="detail", pile=win_dark, coverage=1.8, fill=true})
work(rect(639,409,10,11), {hand="detail", pile=win_dark, coverage=1.8, fill=true})
work(rect(689,409,10,11), {hand="detail", pile=lamp, coverage=1.8, fill=true})

-- ONE hay stook in sunlit field (trial of form): cast shadow to left, lit right face
work(ellipse(712,556,46,9), {hand="body", pile=shadow_cool, coverage=0.9, fill=true, edge="lost"})
work(poly({{728,558},{736,522},{744,558}}, true), {hand="detail", pile=field_shad2, coverage=1.8, fill=true, tool="filbert 4"})
work(poly({{736,522},{744,558},{756,558},{748,526}}, true), {hand="detail", pile=stook_lit, coverage=1.8, fill=true, tool="filbert 4"})

-- STUBBLE TRIAL patch only, lower right field: hatch strokes radiating from vanishing point near house (660,415)
trial_m = ellipse(828,618,108,72)
work(trial_m, {hand="hatch", coverage=0.55, angle=function(x,y) return math.atan(y-415, x-660) end,
 piles={{stook_lit, 0.6},{gold_body, 0.7},{field_shad2, 0.45}}})
print("house+stook+trial done")

--@ chunk 15
-- bury stubble trial + stook under broad graded field paint, wet into wet
repair_m = ellipse(805,605,185,125) + ellipse(712,548,78,38)
work(repair_m, {hand="broad", angle=-0.18, coverage=1.4, fill=true, edge="lost",
 piles={{gold_body, function(x,y) return clamp(0.6 + x/1000*0.7, 0.3, 1.4) end},
        {field_shad2, function(x,y) return clamp(0.75 - x/1000*0.45, 0.05, 0.8) end}}})
-- repaint trunk where grains spilled over it
work(ribbon({{908,748},{900,600},{892,470}}, {54,44,36}), {hand="body", pile=bark, angle=1.62, coverage=1.5, fill=true, edge="firm"})
print(wait(4*24*60)); print(drying(660,415), drying(825,618))

--@ chunk 16
print(wait(3*24*60)); print(drying(660,415), drying(825,618), drying(900,600))

--@ chunk 17
roof_mute = pile{{"red earth",1.5},{"raw umber",1.2},{"bone black",0.4},{"lead white",0.5},{"burnt sienna",0.6}, name="roof_mute"}
wall2 = pile{{"lead white",5},{"Naples yellow",0.7},{"yellow ochre",0.5},{"raw umber",0.45},{"ultramarine blue",0.15}, name="wall2"}
win2 = pile{{"bone black",2},{"ultramarine blue",0.5},{"raw umber",0.5}, name="win2"}
lamp2 = pile{{"cadmium yellow",1},{"orange vermilion",0.4},{"lead white",0.8},{"raw umber",0.2}, name="lamp2"}
midgold = pile{{"yellow ochre",3},{"Naples yellow",1.5},{"lead-tin yellow",1},{"burnt sienna",0.4}, name="midgold"}
print(roof_mute); print(wall2); print(win2); print(lamp2)

--@ chunk 18
-- remove barn: trees over it
work(rect(566,392,70,48), {hand="body", angle=0.55, coverage=1.6, fill=true, edge="lost",
 piles={{tree_body,0.9},{tree_lit,0.35},{oak_dark,0.4}}})
-- remove dark platform under house: field tones over it (below wall base y>433)
work((rect(590,433,170,26)), {hand="broad", angle=-0.1, coverage=1.3, fill=true, edge="lost",
 piles={{gold_body,0.55},{field_shad2,0.75}}})
-- HOUSE muted repaint
work(poly({{632,431},{632,404},{704,404},{704,431}}), {hand="detail", pile=wall2, coverage=2.4, fill=true, tool="filbert 6"})
work(poly({{624,405},{643,383},{690,383},{712,405}}), {hand="detail", pile=roof_mute, coverage=2.2, fill=true, tool="filbert 6"})
work(rect(684,368,8,17), {hand="detail", pile=bark, coverage=1.8, fill=true})
work(rect(642,411,6,8), {hand="detail", pile=win2, coverage=1.8, fill=true})
work(rect(688,411,6,8), {hand="detail", pile=lamp2, coverage=1.8, fill=true})
work(rect(664,417,8,14), {hand="detail", pile=win2, coverage=1.8, fill=true})
-- tuck house into foliage: bushes over bottom corners, crown over left roof tip
work(ellipse(632,430,19,10)+ellipse(707,430,18,10)+ellipse(622,400,20,13), {hand="body", pile=tree_body, coverage=1.3, fill=true, edge="soft"})

-- STOOKS, variant A revised: thin left-shifted golden-olive shadow, offset apex
-- near stook, base (735,562)
work(ellipse(712,564,44,5), {hand="body", coverage=0.85, fill=true, edge="lost", piles={{gold_body,0.55},{field_shad2,0.85}}})
work(poly({{716,562},{734,518},{742,562}}, true), {hand="detail", coverage=1.7, fill=true, tool="filbert 5", piles={{midgold,0.7},{field_shad2,0.6}}})
work(poly({{734,518},{742,562},{764,562},{748,524}}, true), {hand="detail", coverage=1.7, fill=true, tool="filbert 5", piles={{midgold,0.8},{stook_lit,0.5}}})
-- far stook, base (602,502), smaller
work(ellipse(588,504,26,4), {hand="body", coverage=0.85, fill=true, edge="lost", piles={{gold_body,0.55},{field_shad2,0.8}}})
work(poly({{592,502},{601,478},{606,502}}, true), {hand="detail", coverage=1.7, fill=true, tool="filbert 4", piles={{midgold,0.7},{field_shad2,0.6}}})
work(poly({{601,478},{606,502},{618,502},{609,482}}, true), {hand="detail", coverage=1.7, fill=true, tool="filbert 4", piles={{midgold,0.8},{stook_lit,0.5}}})
print("house muted + stooks A")

--@ chunk 19
print(wait(5*24*60)); print(drying(660,415), drying(740,540))

--@ chunk 20
print(wait(3*24*60)); print(drying(660,415), drying(740,540))

--@ chunk 21
roof_glaze = pile{{"raw umber",2},{"burnt sienna",1},{"bone black",0.3}, medium=0.6, name="roof_glaze"}
-- trees back over gold spill right of house眉
bump_m = (poly({{712,402},{800,394},{815,430},{790,450},{720,448}}, true))
work(bump_m, {hand="body", angle=0.55, coverage=1.4, fill=true, edge="soft", piles={{tree_body,0.9},{tree_lit,0.3},{oak_dark,0.35}}})
-- dull roof with transparent umber glaze, clipped to roof
roof_m2 = poly({{624,405},{643,383},{690,383},{712,405}})
work(roof_m2, {hand="glaze", pile=roof_glaze, coverage=0.7, clip=true})
-- foliage texture over dark blob left of house and bush corners
stipple(ellipse(624,406,30,20)+ellipse(632,430,20,10)+ellipse(707,430,19,10), {pile=tree_lit, width=3.2, coverage=0.55, seed=11})
stipple(ellipse(624,406,26,17), {pile=oak_dark, width=3.2, coverage=0.4, seed=12})
-- windows + door as single short strokes of a pointed round
wb = brush{kind="round", width=6, point=0.5}
wb:load(win2, 0.9)
wb:stroke({{645,411},{645,419}}, {pressure=0.85})
wb:stroke({{646,411},{646,419}}, {pressure=0.8})
wb:load(win2, 0.9)
wb:stroke({{668,417},{668,431}}, {pressure=0.9})
wb:stroke({{669,417},{669,431}}, {pressure=0.85})
wb:reload(lamp2, 0.9)
wb:stroke({{691,411},{691,419}}, {pressure=0.85})
wb:stroke({{692,411},{692,419}}, {pressure=0.8})
print("house touches done")

--@ chunk 22
cb = brush("filbert", 24)
function cloud(pile, pts)
  cb:reload(pile, 0.95)
  cb:gesture(pts, {wobble=2})
end
-- dark bank, long arcs swelling in the middle
cloud(storm_dark, {{-20,52,0.35},{180,38,0.85},{420,48,0.8},{620,66,0.25}})
cloud(storm_dark, {{-20,105,0.3},{220,88,0.9},{470,100,0.85},{700,122,0.2}})
cloud(storm_dark, {{30,158,0.25},{260,140,0.85},{520,152,0.7},{760,178,0.15}})
cloud(storm_dark, {{-20,205,0.3},{180,188,0.75},{380,198,0.6},{560,220,0.12}})
cloud(storm_dark, {{260,42,0.2},{520,26,0.8},{800,40,0.7},{1010,60,0.25}})
cloud(storm_dark, {{420,120,0.15},{640,104,0.6},{850,118,0.45},{1010,138,0.15}})
-- mid bellies under the bank
cloud(storm_mid, {{-20,240,0.25},{200,222,0.7},{430,234,0.6},{620,256,0.12}})
cloud(storm_mid, {{180,190,0.15},{400,176,0.6},{620,188,0.5},{820,210,0.12}})
cloud(storm_mid, {{520,240,0.12},{720,226,0.55},{920,238,0.45},{1010,252,0.2}})
cloud(storm_mid, {{-20,150,0.2},{160,138,0.55},{340,148,0.4},{500,166,0.1}})
-- pale light breaking low, right and centre
cloud(glow, {{420,318,0.1},{640,304,0.55},{860,312,0.6},{1010,322,0.25}})
cloud(glow, {{240,292,0.08},{460,280,0.4},{680,290,0.35},{880,304,0.08}})
cloud(glow, {{620,268,0.08},{800,258,0.38},{980,268,0.25}})
print("cloud gestures laid")

--@ chunk 23
r = rag{width=55}
r:dip(0.35)
r:wipe(rect(0,0,1000,345), {pressure=0.65, angle=0.0, passes=2, refold=0.55})
print(r); print(drying(300,100))

--@ chunk 24
r2 = rag{width=55}
sky_only = rect(0,0,1000,345) - canopy_m2:grow(12)
r2:wipe(sky_only, {pressure=0.6, angle=0.15, passes=1, refold=0.5})
print(r2)

--@ chunk 25
print(wait(6*24*60)); print(drying(300,100), drying(850,220))

--@ chunk 26
bark_lit = pile{{"raw umber",2},{"lead white",1},{"burnt sienna",0.5},{"yellow ochre",0.5}, name="bark_lit"}
-- new low limb reaching left from trunk
work(ribbon({{884,338},{832,306},{788,284},{758,272}}, {13,9,6,4}), {hand="body", pile=bark, angle=-0.45, coverage=1.4, fill=true, edge="firm"})
-- canopy repaint, including new cluster at end of low limb
canopy_m3 = canopy_m2 + ellipse(772,272,58,36)
work(canopy_m3, {hand="body", angle=0.6, coverage=1.6, fill=true, edge={found=0.3, soft=0.45, lost=0.25, period=46},
 piles={{oak_dark, function(x,y) return clamp(1.35 - (y)/340*0.45, 0.5, 1.35) end},
        {tree_body, function(x,y) return clamp(0.25 + y/340*0.5, 0.1, 0.8) end},
        {tree_lit,  function(x,y) return clamp((y-170)/170*0.4 + (880-x)/1000*0.25, 0.0, 0.55) end}}})
-- foliage modelling stippled INTO the wet canopy so touches fuse
stipple(canopy_m3:shrink(8), {pile=tree_lit, width=4.6, coverage=function(x,y) return clamp((y-140)/220*0.32 + (880-x)/1000*0.12, 0.0, 0.4) end, cluster={0.65, 26}, seed=21})
stipple(canopy_m3:shrink(8), {pile=oak_dark, width=4.6, coverage=function(x,y) return clamp(0.34 - (y)/340*0.18, 0.05, 0.35) end, cluster={0.6, 22}, seed=22})
-- lit edge on trunk, right side, one gesture
tb = brush{kind="filbert", width=5}
tb:load(bark_lit, 0.75)
tb:gesture({{922,735,0.55},{915,590,0.5},{905,440,0.45},{894,300,0.3}}, {wobble=1.5})
print("canopy repainted")

--@ chunk 27
topband = canopy_m3 + rect(672,0,328,95) + ellipse(930,35,180,85)
work(topband, {hand="body", angle=0.6, coverage=1.35, fill=true, edge="soft",
 piles={{oak_dark, function(x,y) return clamp(1.35 - (y)/340*0.45, 0.5, 1.35) end},
        {tree_body, function(x,y) return clamp(0.25 + y/340*0.5, 0.1, 0.8) end},
        {tree_lit,  function(x,y) return clamp((y-170)/170*0.4 + (880-x)/1000*0.25, 0.0, 0.55) end}}})
blend(topband, {angle=0.5})
blend(trunk_m2, {angle=1.6})
print("top band + blends done")

--@ chunk 28
notch = poly({{630,0},{772,0},{746,34},{764,64},{718,86},{734,120},{700,140},{714,174},{680,192},{642,150},{630,80}}, true)
work(notch, {hand="broad", angle=0.1, coverage=1.35, fill=true, clip=true,
 piles={{storm_dark, function(x,y) return clamp(1.2 - y/200*0.8, 0.1, 1.2) end},
        {storm_mid,  function(x,y) return clamp(0.3 + y/200*0.8, 0.2, 1.2) end}}})
-- small sky hole through canopy
work(ellipse(798,118,17,10), {hand="body", pile=storm_mid, coverage=1.1, fill=true, clip=true})
print("sky carved")

--@ chunk 29
work(ellipse(798,118,26,17), {hand="body", coverage=1.3, fill=true, edge="lost", piles={{oak_dark,0.9},{tree_body,0.4}}})
work(rect(552,0,205,235), {hand="body", length={25,55}, angle=0.1, coverage=1.35, fill=true, edge="lost",
 piles={{storm_dark, function(x,y) return clamp(1.25 - y/230*0.95 - (x-550)/1000*0.2, 0.05, 1.25) end},
        {storm_mid,  function(x,y) return clamp(0.25 + y/230*0.9, 0.15, 1.2) end},
        {glow,       function(x,y) return clamp(((y-150)/85)^2*0.35, 0.0, 0.4) end}}})
print("sky edge repaired")

--@ chunk 30
-- A. whole upper-right sky in one graded pass, edges lost
work(rect(480,0,520,255), {hand="broad", angle=0.08, coverage=1.35, fill=true, edge="lost",
 piles={{storm_dark, function(x,y) return clamp(1.35 - y/250*1.15 - (x-480)/1000*0.25, 0.02, 1.35) end},
        {storm_mid,  function(x,y) return clamp(0.25 + y/250*0.75, 0.1, 1.1) end},
        {glow,       function(x,y) return clamp(((y-140)/115)^2 * (0.3 + (x-480)/520*0.6), 0.0, 0.95) end}}})
-- B. canopy from a newly drawn irregular silhouette, over wet sky
canopy_m4 = poly({{745,0},{1000,0},{1000,300},{968,278},{940,318},{905,282},{872,322},{838,272},{800,300},{772,252},{730,268},{718,222},{682,214},{700,166},{664,140},{692,96},{708,58},{724,24}}, true)
work(canopy_m4, {hand="body", angle=0.6, coverage=1.55, fill=true, edge={found=0.3, soft=0.45, lost=0.25, period=44},
 piles={{oak_dark, function(x,y) return clamp(1.35 - y/340*0.5, 0.45, 1.35) end},
        {tree_body, function(x,y) return clamp(0.2 + y/340*0.55, 0.1, 0.85) end},
        {tree_lit,  function(x,y) return clamp((y-180)/160*0.38 + (860-x)/1000*0.22, 0.0, 0.5) end}}})
-- foliage touches into wet canopy, no blend after
stipple(canopy_m4:shrink(10), {pile=tree_lit, width=5.2, coverage=function(x,y) return clamp((y-150)/190*0.26 + (860-x)/1000*0.1, 0.0, 0.32) end, cluster={0.65, 30}, seed=31})
stipple(canopy_m4:shrink(10), {pile=oak_dark, width=5.2, coverage=function(x,y) return clamp(0.3 - y/340*0.16, 0.04, 0.3) end, cluster={0.6, 26}, seed=32})
print("upper right rebuilt")

--@ chunk 31
field_trial = ellipse(798,622,112,76) - trunk_m2:grow(5)
work(field_trial, {hand="body", tool="filbert 14", length={50,110}, coverage=0.5,
 angle=function(x,y) return math.atan(y-415, x-660) end,
 scale_at=function(x,y) return 0.5 + (y-400)/340*0.85 end,
 piles={{gold_body,0.8},{midgold,0.7},{stook_lit,0.3},{field_shad2,0.5}}})
print("field trial laid", drying(800,620))

--@ chunk 32
blend(field_trial, {angle=0.97})
print("trial blended")

--@ chunk 33
stook_keep = ellipse(740,540,34,30) + ellipse(605,490,20,18)
fieldpass_m = field_m - track_m2:grow(4) - trunk_m2:grow(5) - stook_keep - (house_block:grow(6)) - tree_m3:grow(2)
work(fieldpass_m, {hand="body", tool="filbert 11", length={35,80}, coverage=0.75, clip=fieldpass_m,
 angle=function(x,y) return math.atan(y-415, x-660) end,
 scale_at=function(x,y) return 0.5 + (y-400)/340*0.85 end,
 piles={{shadow_cool, function(x,y)
            local xb = 430 + (y-430)*0.45
            local s = clamp((xb - x)/300, 0, 1)
            local strip = clamp((495 - y)/70, 0, 1)*0.55
            return 0.12 + 1.5*s + strip + (y-400)/340*0.22
          end},
        {gold_body, function(x,y)
            local xb = 430 + (y-430)*0.45
            local s = clamp((xb - x)/300, 0, 1)
            local strip = clamp((495 - y)/70, 0, 1)*0.55
            return clamp(1.4 - 1.3*s - strip*0.7, 0.05, 1.4)
          end},
        {field_shad2, function(x,y) return 0.35 end}}})
print("full field directional pass done")

--@ chunk 34
print(wait(6*24*60)); print(drying(500,600), drying(300,360), drying(740,540))

--@ chunk 35
-- transparent versions of trusted sky piles (same pigment ratios, medium 0.35)
sdark_v = pile{{"ultramarine blue",2},{"bone black",2.5},{"raw umber",1.8},{"lead white",1.6},{"cobalt violet",0.5}, medium=0.35, name="sdark_v"}
smid_v = pile{{"lead white",4},{"ultramarine blue",1.2},{"bone black",0.5},{"raw umber",0.5},{"cobalt violet",0.4}, medium=0.35, name="smid_v"}
glow_v = pile{{"lead white",5},{"Naples yellow",1.6},{"cadmium yellow",0.4},{"rose madder",0.15},{"cobalt blue",0.2}, medium=0.35, name="glow_v"}
tree_glaze = pile{{"viridian",1.5},{"raw umber",1.5},{"ultramarine blue",0.8},{"yellow ochre",0.5}, medium=0.55, name="tree_glaze"}

-- 1. unified veiling pass over whole sky, off the canopy
sky_veil_m = sky_m - canopy_m4:grow(3)
work(sky_veil_m, {hand="glaze", angle=0.06, coverage=0.85, clip=sky_veil_m, edge="lost",
 piles={{sdark_v, function(x,y) return clamp(1.35 - y/330*1.2 - x/1000*0.4, 0.02, 1.35) end},
        {smid_v,  function(x,y) return clamp(0.3 + y/330*0.6, 0.1, 1.0) end},
        {glow_v,  function(x,y) return clamp(((y-150)/190)^2 * (0.3 + x/1000*0.85), 0.0, 1.2) end}}})

-- 2. tone down frosty tree tops with transparent green glaze
work(tree_m3, {hand="glaze", pile=tree_glaze, coverage=0.55, clip=true, angle=0.4})

-- 3. stooks repainted (variant A revised, as before)
work(ellipse(712,564,44,5), {hand="body", coverage=0.85, fill=true, edge="lost", piles={{gold_body,0.55},{field_shad2,0.85}}})
work(poly({{716,562},{734,518},{742,562}}, true), {hand="detail", coverage=1.7, fill=true, tool="filbert 5", piles={{midgold,0.7},{field_shad2,0.6}}})
work(poly({{734,518},{742,562},{764,562},{748,524}}, true), {hand="detail", coverage=1.7, fill=true, tool="filbert 5", piles={{midgold,0.8},{stook_lit,0.5}}})
work(ellipse(588,504,26,4), {hand="body", coverage=0.85, fill=true, edge="lost", piles={{gold_body,0.55},{field_shad2,0.8}}})
work(poly({{592,502},{601,478},{606,502}}, true), {hand="detail", coverage=1.7, fill=true, tool="filbert 4", piles={{midgold,0.7},{field_shad2,0.6}}})
work(poly({{601,478},{606,502},{618,502},{609,482}}, true), {hand="detail", coverage=1.7, fill=true, tool="filbert 4", piles={{midgold,0.8},{stook_lit,0.5}}})
print("veil+glaze+stooks done")

--@ chunk 36
r3 = rag{width=55}
r3:dip(0.3)
r3:wipe(rect(0,312,1000,152), {pressure=0.62, angle=0.4, passes=2, refold=0.5})
print(r3)

--@ chunk 37
print(wait(7*24*60)); print(drying(300,360), drying(800,320), drying(500,150))

--@ chunk 38
tree_m4 = poly({{0,390},{55,350},{120,368},{185,342},{265,366},{340,338},{425,368},{495,346},{565,372},{625,380},{720,378},{770,330},{830,322},{885,342},{935,318},{985,340},{1000,352},{1000,446},{900,434},{815,450},{725,436},{635,449},{545,435},{455,448},{365,435},{275,448},{185,435},{95,447},{0,440}}, true)
  - rect(616,364,104,72) - trunk_m2:grow(3) - canopy_m4:grow(2)
work(tree_m4, {hand="body", angle=0.5, coverage=1.5, fill=true, edge="soft", clip=true,
 piles={{tree_body, function(x,y) return 1.15 end},
        {oak_dark,  function(x,y) return clamp((y-365)/85*0.75 + (1-x/1000)*0.15, 0.0, 0.9) end},
        {tree_lit,  function(x,y) return clamp(0.3 - (y-330)/120*0.27 + x/1000*0.1, 0.02, 0.36) end}}})
stipple(tree_m4, {pile=tree_lit, width=4.2, coverage=function(x,y) return clamp(0.2 - (y-330)/120*0.18, 0.0, 0.2) end, cluster={0.6,24}, seed=41})
stipple(tree_m4, {pile=oak_dark, width=4.2, coverage=function(x,y) return clamp((y-380)/70*0.22, 0.0, 0.22) end, cluster={0.6,24}, seed=42})
print("tree line final repaint")

--@ chunk 39
distant_tree = pile{{"lead white",1.6},{"green earth",1.5},{"ultramarine blue",0.7},{"yellow ochre",0.7},{"raw umber",0.4},{"cobalt violet",0.2}, name="distant_tree"}
-- old frosty crown arcs above new wood -> deliberate pale distant woodland
old_crowns = ellipse(125,355,62,48) + ellipse(345,352,72,44) + ellipse(545,356,54,38) + ellipse(800,360,58,40) + ellipse(235,362,44,32)
far_m = old_crowns - tree_m4 - canopy_m4:grow(2) - rect(616,364,104,72)
work(far_m, {hand="body", pile=distant_tree, angle=0.4, coverage=1.3, fill=true, clip=true})
-- fill white teeth under oak lobes with nearer distant foliage
teeth_m = (ellipse(772,304,18,16) + ellipse(843,306,23,19) + ellipse(970,308,21,17) + ellipse(908,310,16,14)) - canopy_m4:grow(1) - trunk_m2:grow(2)
work(teeth_m, {hand="body", angle=0.5, coverage=1.4, fill=true, edge="soft", piles={{tree_body,0.75},{distant_tree,0.55}}})
print("far wood + teeth filled")

--@ chunk 40
crowns_dark_m = old_crowns - rect(616,364,104,72)
work(crowns_dark_m, {hand="body", angle=0.5, coverage=1.45, fill=true, edge={found=0.25, soft=0.4, lost=0.35, period=30},
 piles={{tree_body, function(x,y) return 1.1 end},
        {oak_dark,  function(x,y) return clamp((y-365)/85*0.7, 0.0, 0.8) end},
        {tree_lit,  function(x,y) return clamp(0.26 - (y-330)/120*0.22 + x/1000*0.08, 0.02, 0.3) end}}})
teeth2_m = (ellipse(772,304,22,19) + ellipse(843,306,27,22) + ellipse(970,308,25,20) + ellipse(908,310,20,17)) - trunk_m2:grow(2)
work(teeth2_m, {hand="body", angle=0.5, coverage=1.45, fill=true, edge="soft",
 piles={{tree_body,0.95},{tree_lit,0.22},{oak_dark,0.3}}})
print("crowns merged dark")

--@ chunk 41
-- rooks: tiny two-stroke birds, slate not black
bb = brush{kind="rigger", width=3.2, point=1}
bb:load(storm_dark, 0.8)
function bird(x, y, s)
  bb:stroke({{x-s, y+s*0.35},{x-s*0.2, y-s*0.25},{x, y}}, {pressure={0.15,0.75}})
  bb:stroke({{x, y},{x+s*0.2, y-s*0.25},{x+s, y+s*0.35}}, {pressure={0.75,0.15}})
end
bird(210,150,9); bird(255,128,7); bird(300,162,11); bird(365,118,6); bird(150,190,8); bird(430,175,7)
-- lose track edges with field colours dragged in from outside
lose(track_m2, {pile=gold_body, where=0.85, load=0.28, seed=51})
lose(track_m2, {pile=field_shad2, where=0.7, load=0.22, seed=52})
-- root shadow at oak base, thin and golden-olive like stook shadows
work(ellipse(868,740,78,9), {hand="body", coverage=0.85, fill=true, edge="lost", piles={{gold_body,0.5},{field_shad2,0.9}}})
work(ellipse(906,736,30,8), {hand="body", pile=shadow_cool, coverage=0.7, fill=true, edge="lost"})
print("birds+track+roots done")

--@ chunk 42
blend(track_m2:grow(8), {angle=-0.85})
print("track beads blended")

--@ chunk 43
print(wait(5*24*60)); print(drying(450,620), drying(300,380))

--@ chunk 44
work(track_m2, {hand="body", tool="filbert 9", length={30,60}, coverage=1.35, fill=true, edge="soft",
 angle=function(x,y) return -1.15 + (741-y)/320*0.55 end,
 scale_at=function(x,y) return 0.55 + (y-400)/340*0.7 end,
 piles={{track_mid, function(x,y)
            local xb = 430 + (y-430)*0.45
            local s = clamp((xb - x)/300, 0, 1)
            return clamp(1.25 - s*0.55, 0.4, 1.25) end},
        {field_shad2, function(x,y)
            local xb = 430 + (y-430)*0.45
            local s = clamp((xb - x)/300, 0, 1)
            return 0.12 + s*0.7 end},
        {midgold, function(x,y) return 0.22 end}}})
print("track repainted")

--@ chunk 45
-- trunk repainted clean, modelled across its width (dark left, lit right)
work(trunk_m2, {hand="body", tool="filbert 10", length={25,55}, angle=1.62, coverage=1.55, fill=true, clip=true,
 piles={{bark, function(x,y) return 1.0 end},
        {oak_dark, function(x,y) return clamp((905-x)/35, 0, 1)*0.55 end},
        {bark_lit, function(x,y) return clamp((x-898)/35, 0, 1)*0.6 end}}})
-- far stook repainted, shifted clear of track: base (638,514)
work(ellipse(624,516,25,4), {hand="body", coverage=0.85, fill=true, edge="lost", piles={{gold_body,0.55},{field_shad2,0.8}}})
work(poly({{628,514},{637,491},{642,514}}, true), {hand="detail", coverage=1.7, fill=true, tool="filbert 4", piles={{midgold,0.7},{field_shad2,0.6}}})
work(poly({{637,491},{642,514},{654,514},{645,495}}, true), {hand="detail", coverage=1.7, fill=true, tool="filbert 4", piles={{midgold,0.8},{stook_lit,0.5}}})
print("trunk + far stook redone")

--@ chunk 46
-- foliage back over trunk above the fork (y<335)
spike_m = (trunk_m2:grow(7) * rect(820,120,180,215))
work(spike_m, {hand="body", angle=0.6, coverage=1.5, fill=true, edge="lost",
 piles={{oak_dark,0.95},{tree_body,0.45},{tree_lit,0.18}}})
stipple(spike_m, {pile=tree_lit, width=4.6, coverage=0.16, cluster={0.6,20}, seed=61})
-- break up flat lower trunk with fused touches
stipple(trunk_m2 * rect(850,330,150,411), {pile=oak_dark, width=4.4, coverage=0.2, cluster={0.55,18}, seed=62})
stipple(trunk_m2 * rect(850,330,150,411), {pile=bark_lit, width=4.4, coverage=function(x,y) return clamp((x-898)/35,0,1)*0.22 end, cluster={0.55,18}, seed=63})
print("spike covered")

--@ chunk 47
sb = brush{kind="rigger", width=2.2, point=1}
sb:load(wall2, 0.85)
sb:stroke({{22,730},{28,712},{36,724},{44,712},{50,730}}, {pressure=0.65})
sb:stroke({{57,712},{63,730},{71,718},{79,730},{85,712}}, {pressure=0.65})
print("signed MW")

--@ chunk 48
print(wait(3*24*60)); print(drying(125,340), drying(345,340))
tree_opaque = pile{{"yellow ochre",2.2},{"Prussian blue",0.7},{"raw umber",1.1},{"bone black",0.5},{"lead white",0.35},{"red earth",0.25}, name="tree_opaque"}
work(old_crowns - rect(616,364,104,72), {hand="body", angle=0.5, coverage=1.5, fill=true, edge="soft",
 piles={{tree_opaque, function(x,y) return 1.15 end},
        {oak_dark, function(x,y) return clamp((y-365)/85*0.6, 0.0, 0.7) end},
        {tree_lit, function(x,y) return clamp(0.2 - (y-330)/120*0.16 + x/1000*0.06, 0.02, 0.24) end}}})
stipple(old_crowns, {pile=tree_lit, width=4.2, coverage=function(x,y) return clamp(0.14 - (y-330)/120*0.12, 0.0, 0.14) end, cluster={0.6,22}, seed=71})
print("crowns repainted opaque on dry")

--@ chunk 49
blend((old_crowns:grow(6) * rect(0,352,1000,52)), {angle=1.2})
print("crown seams blended")

--@ chunk 50
stipple(old_crowns, {pile=oak_dark, width=4.4, coverage=function(x,y) return clamp((y-352)/55*0.38, 0.0, 0.38) end, cluster={0.6,22}, seed=81})
stipple(old_crowns:grow(10) * rect(0,372,1000,48), {pile=tree_opaque, width=4.4, coverage=0.18, cluster={0.6,22}, seed=82})
print("crown modelling stippled")

--@ chunk 51
print(wait(14*24*60)); print(drying(300,350), drying(500,600), drying(200,100))

--@ chunk 52
print(drying(125,340), drying(345,340), drying(300,400), drying(500,150), drying(660,400))
print(tree_opaque); print(tree_body); print(oak_dark); print(tree_lit)
print("old_crowns area", old_crowns:area(), "tree_m4", tree_m4:area())

--@ chunk 53
-- Whole wood in one graded pass: crowns and tree line unified
wood_m5 = (tree_m4 + old_crowns) - rect(614,360,108,78) - trunk_m2:grow(3) - canopy_m4:grow(2)
print("wood area", wood_m5:area())
work(wood_m5, {hand="body", angle=0.5, coverage=1.5, fill=true, edge="soft", clip=true,
 piles={{tree_opaque, function(x,y) return 1.05 end},
        {oak_dark,  function(x,y) return clamp((y-335)/105*0.95, 0.0, 0.95) end},
        {tree_lit,  function(x,y) return clamp(0.30 - (y-300)/85*0.30 + x/1000*0.06, 0.0, 0.34) end}}})
-- foliage modelling stippled into the still-wet wood so touches fuse
stipple(wood_m5, {pile=tree_lit, width=4.6, coverage=function(x,y) return clamp(0.20 - (y-300)/110*0.20, 0.0, 0.20) end, cluster={0.6,24}, seed=91})
stipple(wood_m5, {pile=oak_dark, width=4.6, coverage=function(x,y) return clamp((y-370)/75*0.26, 0.0, 0.26) end, cluster={0.6,24}, seed=92})
print("wood unified", drying(200,340), drying(300,410))

--@ chunk 54
print("wood_m5 area", wood_m5 and wood_m5:area() or "nil")
print("dry crowns", drying(120,340), drying(330,340), drying(560,340))
print("dry sky/field/house", drying(300,100), drying(700,600), drying(665,405))
print("tree_opaque", tree_opaque)
print("tree_lit", tree_lit)
print("oak_dark", oak_dark)

--@ chunk 55
print(wait(8*24*60))
print("wood", drying(120,340), drying(330,340), drying(560,340), drying(800,360))
print("elsewhere", drying(300,100), drying(700,600), drying(665,405), drying(900,200))
