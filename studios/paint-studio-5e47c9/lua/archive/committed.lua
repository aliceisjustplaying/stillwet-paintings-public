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
--@ width 4800
--@ drain

--@ chunk 1
canvas{size=1000, aspect=1.5, linen={18,16}, seed=4127,
  ground={{pile={{"lead white",6},{"yellow ochre",2},{"red earth",1},{"raw umber",0.5}}, um=120, apply="knife", texture=0.3}}}
print(W, H)

--@ chunk 2
palette{set_out={"lead white","yellow ochre","Naples yellow","cadmium yellow","lemon chrome","orange chrome","cadmium red","Indian red","permanent alizarin","burnt sienna","raw umber","ultramarine blue","cobalt blue","viridian","green earth","bone black","raw sienna","transparent oxide yellow"}}
draw_p = pile{{"burnt sienna",2},{"ultramarine blue",1}, turps=0.6, name="draw"}
print(draw_p)

--@ chunk 3
pen = brush{kind="round", width=3, point=0.8}
pen:load(draw_p, 0.7)
local function g(pts, p)
  local t = {}
  for i,pt in ipairs(pts) do t[i] = {pt[1], pt[2], pt[3] or p or 0.5} end
  pen:gesture(t, {wobble=1.5})
  if pen:fullness() < 0.3 then pen:load(draw_p, 0.7) end
end
-- horizon and distant range
g({{0,432},{300,430},{600,433},{1000,431}}, 0.35)
g({{0,418},{120,412},{260,420},{400,416},{560,410},{600,385},{650,375},{705,378},{730,405},{850,414},{1000,410}}, 0.35)
-- cowboy hat
g({{190,170},{230,166},{270,163},{312,158}}, 0.6)
g({{232,166},{230,140},{238,127},{256,124},{274,126},{280,142},{282,162}}, 0.55)
-- head / face
g({{276,168},{280,178},{286,188},{279,194},{278,206},{268,214}}, 0.45)
g({{238,170},{236,192},{244,210},{256,218}}, 0.4)
-- body back line and coat
g({{256,218},{240,236},{230,260},{200,340},{160,420},{130,486}}, 0.5)
g({{130,486},{200,482},{250,478},{305,470}}, 0.45)
g({{272,236},{290,252},{292,300},{290,340},{298,400},{305,470}}, 0.45)
-- gun arm
g({{268,232},{305,240},{340,246},{395,252}}, 0.5)
g({{278,252},{335,262},{392,266}}, 0.45)
g({{392,250},{410,250},{446,248}}, 0.6)
g({{398,268},{402,256}}, 0.5)
-- legs
g({{285,470},{318,470},{330,520},{340,580},{365,596}}, 0.5)
g({{255,478},{298,480},{312,530},{325,598}}, 0.4)
g({{232,480},{222,500},{196,580},{215,598}}, 0.5)
g({{205,480},{200,520},{176,596}}, 0.4)
print(pen:fullness())

--@ chunk 4
pen:load(draw_p, 0.7)
local function g(pts, p)
  local t = {}
  for i,pt in ipairs(pts) do t[i] = {pt[1], pt[2], pt[3] or p or 0.5} end
  pen:gesture(t, {wobble=1.5})
  if pen:fullness() < 0.3 then pen:load(draw_p, 0.7) end
end
-- zombie head snapped back
g({{742,262},{752,254},{768,258},{776,272},{770,288},{756,294},{744,286}}, 0.45)
-- jaw open, face up-left
g({{744,286},{738,276},{742,262}}, 0.4)
-- torso leaning back
g({{742,294},{722,305},{712,340},{700,385},{698,425}}, 0.5)
g({{756,296},{758,320},{748,360},{732,400},{720,428}}, 0.45)
-- front arm flung toward cowboy
g({{722,305},{700,288},{680,275},{660,256},{646,242}}, 0.5)
g({{728,316},{700,300},{682,290},{662,266},{650,250}}, 0.4)
g({{646,242},{636,232}},0.4); g({{648,244},{640,236}},0.35); g({{650,248},{638,248}},0.35)
-- back arm flung up
g({{752,300},{775,284},{795,272},{812,252},{822,236}}, 0.5)
g({{758,312},{782,296},{800,282},{818,258},{828,240}}, 0.4)
-- legs stumbling
g({{698,425},{684,455},{670,488},{660,525},{648,555}}, 0.5)
g({{708,430},{692,470},{680,500},{668,552}}, 0.4)
g({{712,428},{735,460},{748,490},{760,525},{778,558}}, 0.5)
g({{722,428},{752,470},{770,520},{790,556}}, 0.4)
-- grave crosses
g({{872,448},{866,380}},0.5); g({{850,398},{892,394}},0.5)
g({{935,455},{940,410}},0.45); g({{924,422},{956,424}},0.45)
g({{580,442},{584,410}},0.4); g({{570,420},{596,418}},0.4)
-- muzzle flash center mark
g({{458,246},{482,258}},0.3); g({{458,258},{482,246}},0.3)
print(pen:fullness())

--@ chunk 5
-- cowboy masks (globals)
cb_crown = poly({{234,166},{232,138},{240,126},{258,122},{276,126},{282,142},{285,164}})
cb_brim  = poly({{186,173},{230,163},{285,157},{318,154},{314,163},{285,168},{232,174}})
cb_head  = poly({{236,170},{282,168},{283,178},{290,190},{283,195},{285,201},{279,211},{268,218},{250,218},{240,206},{236,188}})
cb_neck  = poly({{246,208},{272,210},{278,234},{242,236}})
cb_coat  = poly({{238,228},{280,228},{294,248},{296,300},{293,350},{299,410},{310,472},{250,482},{126,492},{158,420},{196,330},{220,258}}, true)
cb_arm   = ribbon({{280,240},{336,252},{390,258}}, {24,19,15})
cb_hand  = ellipse(398,259,10,10)
cb_gun   = ribbon({{398,250},{447,247}}, 6) + poly({{396,250},{410,250},{408,262},{402,272},{394,270},{398,258}})
cb_legF  = ribbon({{282,470},{322,520},{337,578}}, {34,25,20}) + poly({{326,570},{350,578},{368,592},{368,601},{322,602}})
cb_legB  = ribbon({{240,478},{216,540},{196,582}}, {34,25,20}) + poly({{184,572},{206,576},{220,594},{219,602},{168,602},{172,588}})
cowboy = cb_crown + cb_brim + cb_head + cb_neck + cb_coat + cb_arm + cb_hand + cb_gun + cb_legF + cb_legB
-- zombie
zb_head  = ellipse(724,263,17,20)
zb_torso = poly({{698,292},{740,289},{753,320},{749,370},{741,432},{706,434},{694,382},{689,322}}, true)
zb_armF  = ribbon({{702,302},{660,304},{618,293}}, {19,14,11})
zb_armB  = ribbon({{716,292},{676,280},{640,263}}, {17,13,10})
zb_legF  = ribbon({{712,430},{685,490},{662,550}}, {28,21,16}) + poly({{668,544},{676,560},{640,563},{640,554}})
zb_legB  = ribbon({{730,430},{756,492},{785,556}}, {28,21,15}) + poly({{776,550},{800,560},{804,568},{776,568}})
zombie = zb_head + zb_torso + zb_armF + zb_armB + zb_legF + zb_legB
figures = cowboy + zombie
print(cowboy:area(), zombie:area())

--@ chunk 6
zb_head  = ellipse(716,264,16,19)
zb_torso = poly({{688,296},{730,289},{746,322},{746,372},{742,432},{708,434},{696,385},{683,326}}, true)
zb_armF  = ribbon({{694,304},{655,306},{614,295}}, {19,14,11})
zb_armB  = ribbon({{708,294},{670,281},{634,264}}, {17,13,10})
zombie = zb_head + zb_torso + zb_armF + zb_armB + zb_legF + zb_legB
figures = cowboy + zombie
horizon_y = 431
sky_m = above(function(x) return horizon_y + 2*math.sin(x/90) end)
ground_m = -sky_m
print(sky_m:at(500,100), sky_m:at(500,500))

--@ chunk 7
li_skyhi = pile{{"ultramarine blue",2},{"Indian red",0.6},{"lead white",2}, turps=0.5, name="li_skyhi"}
li_skymid = pile{{"lead white",3},{"Indian red",0.5},{"ultramarine blue",0.6},{"cadmium red",0.3}, turps=0.5, name="li_skymid"}
li_glow = pile{{"Naples yellow",2},{"orange chrome",1},{"lead white",1},{"cadmium yellow",0.5}, turps=0.5, name="li_glow"}
li_ground = pile{{"burnt sienna",2},{"ultramarine blue",1},{"raw umber",1}, turps=0.6, name="li_ground"}
li_hills = pile{{"ultramarine blue",1},{"Indian red",0.5},{"lead white",1.5}, turps=0.5, name="li_hills"}
li_dark = pile{{"burnt sienna",1},{"ultramarine blue",1.2},{"raw umber",0.5}, turps=0.5, name="li_dark"}

--@ chunk 8
local m = sky_m - figures:grow(2)
work(m, {hand="broad", piles={
   {li_skyhi, function(x,y) return 1 - smoothstep(120, 320, y) end},
   {li_skymid, function(x,y) return smoothstep(120,280,y) * (1 - smoothstep(300, 380, y)) end},
   {li_glow, function(x,y) return smoothstep(320, 400, y) end}},
  angle=function(x,y) return 0.04*math.sin(x/200) end, angle_jitter=0.08, coverage=1.3, clip=m})

--@ chunk 9
local m = sky_m - figures:grow(2)
work(m, {hand="broad", piles={
   {li_skyhi, function(x,y) return 1 - smoothstep(100, 300, y) end},
   {li_skymid, function(x,y) return smoothstep(100,260,y) * (1 - smoothstep(300, 370, y)) end},
   {li_glow, function(x,y) return smoothstep(310, 390, y) end}},
  angle=function(x,y) return 0.04*math.sin(x/200) end, angle_jitter=0.08, coverage=1.0, fill=true, clip=m, seed=22})

--@ chunk 10
hills_top = {{0,417},{90,413},{180,418},{280,414},{380,419},{470,414},{540,408},{575,396},{600,391},{640,392},{662,399},{690,410},{780,415},{880,411},{1000,415}}
local pts = {}
for i,p in ipairs(hills_top) do pts[#pts+1] = p end
pts[#pts+1] = {1000, horizon_y+3}; pts[#pts+1] = {0, horizon_y+3}
hills_m = poly(pts) - figures:grow(2)
work(hills_m, {hand="body", pile=li_hills, angle=0, angle_jitter=0.1, coverage=1.5, fill=true, clip=hills_m})
local gm = ground_m - figures:grow(2)
work(gm, {hand="broad", pile=li_ground, angle=function(x,y) return 0.05*math.sin(x/150) end, angle_jitter=0.1, coverage=1.3, fill=true, clip=gm})

--@ chunk 11
work(cowboy, {hand="body", pile=li_dark, angle=function(x,y) return 1.4 end, angle_jitter=0.3, coverage=1.6, fill=true, clip=cowboy})
work(zombie, {hand="body", pile=li_dark, angle=1.3, angle_jitter=0.4, coverage=1.6, fill=true, clip=zombie, tool="filbert 6"})

--@ chunk 12
print(drying(500,80), drying(500,380), drying(500,550), drying(240,350))
print(wait(240))
print(drying(500,80), drying(500,380), drying(500,550), drying(240,350))

--@ chunk 13
print(wait(18*60))
print(drying(500,80), drying(500,380), drying(500,550), drying(240,350), drying(710,350))

--@ chunk 14
print(wait(24*60))
print(drying(500,80), drying(500,380), drying(500,550), drying(240,350), drying(710,350), drying(600,420))

--@ chunk 15
sk_zen = pile{{"ultramarine blue",2},{"Indian red",0.7},{"lead white",1.3}, name="sk_zen"}
sk_mid = pile{{"ultramarine blue",1.5},{"Indian red",0.6},{"lead white",2.2},{"cobalt blue",0.3}, name="sk_mid"}
sk_rose = pile{{"lead white",3},{"Indian red",0.6},{"ultramarine blue",0.45},{"cadmium red",0.25}, name="sk_rose"}
sk_orng = pile{{"orange chrome",1},{"cadmium red",0.25},{"Naples yellow",1},{"lead white",0.8}, name="sk_orng"}
sk_core = pile{{"lead white",2},{"cadmium yellow",1},{"Naples yellow",1},{"orange chrome",0.25}, name="sk_core"}
palette{scrape={li_skyhi, li_skymid, li_glow, li_hills}}

--@ chunk 16
sk_zen:add{{"raw umber",0.35},{"Indian red",0.2}}
sk_mid:add{{"Indian red",0.15},{"raw umber",0.1}}
print(sk_zen, sk_mid)

--@ chunk 17
local pts = {}
for i,p in ipairs(hills_top) do pts[#pts+1] = p end
pts[#pts+1] = {1000, horizon_y+3}; pts[#pts+1] = {0, horizon_y+3}
hills_shape = poly(pts)
sky_body = sky_m - figures:shrink(2) - hills_shape:shrink(3)
local function bell(y, a, b, c, d) return smoothstep(a,b,y) * (1 - smoothstep(c,d,y)) end
local upper = sky_body * above(function(x) return 300 end)
work(upper, {hand="broad", piles={
   {sk_zen, function(x,y) return 1 - smoothstep(50, 210, y) end},
   {sk_mid, function(x,y) return bell(y, 40, 170, 230, 300) end},
   {sk_rose, function(x,y) return smoothstep(220, 300, y) end}},
  angle=function(x,y) return -0.03 + 0.05*math.sin(x/230 + y/80) end, angle_jitter=0.06, coverage=1.4, fill=true, clip=sky_body, seed=31})

--@ chunk 18
local function bell(y, a, b, c, d) return smoothstep(a,b,y) * (1 - smoothstep(c,d,y)) end
local lower = sky_body * below(function(x) return 270 end)
local function core(x,y) local dx=(x-545)/230; return math.exp(-dx*dx) * smoothstep(320, 410, y) end
work(lower, {hand="body", tool="filbert 12", length={40,110}, piles={
   {sk_rose, function(x,y) return 1 - smoothstep(300, 365, y) end},
   {sk_orng, function(x,y) return bell(y, 310, 360, 500, 600) * (1 - 0.8*core(x,y)) end},
   {sk_core, function(x,y) return core(x,y) * 1.6 end}},
  angle=function(x,y) return 0.02*math.sin(x/170) end, angle_jitter=0.05, coverage=1.5, fill=true, clip=sky_body, seed=32})

--@ chunk 19
print(drying(300,425), drying(620,405), drying(900,425), drying(710,350), drying(240,350))

--@ chunk 20
gr_near = pile{{"raw umber",1},{"ultramarine blue",0.6},{"Indian red",0.5},{"lead white",0.45}, name="gr_near"}
gr_mid  = pile{{"burnt sienna",0.8},{"raw umber",0.6},{"lead white",1},{"ultramarine blue",0.45},{"Indian red",0.2}, name="gr_mid"}
gr_far  = pile{{"lead white",2},{"Indian red",0.5},{"yellow ochre",0.5},{"ultramarine blue",0.45}, name="gr_far"}
palette{scrape={li_ground}}

--@ chunk 21
gr_far:add{{"raw umber",0.2},{"orange chrome",0.15}}
ground_body = ground_m - figures:shrink(2)
local function t(y) return clamp((y-431)/236, 0, 1) end
work(ground_body, {hand="body", tool="filbert 12", length={40,120}, piles={
   {gr_far, function(x,y) return 1 - smoothstep(0.0, 0.25, t(y)) end},
   {gr_mid, function(x,y) local u=t(y); return smoothstep(0.05,0.25,u)*(1-smoothstep(0.45,0.7,u)) end},
   {gr_near, function(x,y) return smoothstep(0.45, 0.75, t(y)) end}},
  scale_at=function(x,y) return lerp(0.4, 1.4, t(y)) end,
  angle=function(x,y) return 0.03*math.sin(x/120+y/40) end, angle_jitter=0.07, coverage=1.5, fill=true, clip=ground_body, seed=41})
