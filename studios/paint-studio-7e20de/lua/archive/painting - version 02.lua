-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{size=900, aspect=1.5, linen={16,14}, seed=4417,
  ground={
    {pile={{"lead white",8},{"yellow ochre",0.3}}, um=110, apply="knife", texture=0.25},
    {pile={{"lead white",3},{"red earth",1.2},{"raw umber",1.0},{"yellow ochre",0.6}}, um=22, apply="brush"},
  }}
print(W, H)

--@ chunk 2
-- the drawing: key contours as globals
D = {}
D.horizon = {{0,455},{200,452},{420,457},{600,452},{1000,455}}
D.mesa = {{0,412},{40,404},{70,398},{230,396},{262,402},{300,420},{340,440},{380,455}}
D.hill = {{520,457},{600,440},{700,428},{820,420},{920,424},{1000,432}}
D.moon = {150,110,30}
-- cowboy
D.hat = {{210,262},{232,260},{236,236},{246,224},{258,228},{268,222},{276,232},{278,258},{302,266}}
D.face = {{272,266},{276,276},{283,285},{277,290},{278,296},{272,302},{256,304},{246,296}}
D.cb_back = {{238,272},{232,300},{226,330},{210,380},{185,440},{150,505},{122,560}}
D.cb_hem = {{122,560},{180,568},{240,566},{298,562}}
D.cb_front = {{268,318},{286,340},{290,400},{292,470},{298,562}}
D.gunarm_top = {{258,326},{300,322},{340,320},{384,316}}
D.gunarm_bot = {{282,348},{330,342},{386,334}}
D.gun = {{386,312},{450,312},{450,322},{420,324},{412,346},{398,346},{396,330},{386,334}}
D.farhand = {{300,370},{350,352},{394,326}}
D.leg_rear = {{232,560},{210,590},{186,606},{166,620},{212,622},{212,606},{232,575}}
D.leg_front = {{262,562},{290,590},{302,604},{334,620},{290,622},{286,606},{266,580}}
-- zombie
D.z_head = {{700,312},{706,296},{722,292},{734,302},{736,320},{726,336},{712,340},{700,330}}
D.z_back = {{732,336},{752,370},{768,420},{772,470}}
D.z_front = {{702,342},{690,372},{700,420},{712,470}}
D.z_arm1 = {{700,370},{650,374},{600,366},{586,360}}
D.z_arm2 = {{712,358},{662,350},{620,338},{604,332}}
D.z_leg_rear = {{760,470},{775,530},{790,596},{760,604}}
D.z_leg_front = {{725,470},{712,530},{705,600},{676,606}}
D.cross1 = {870,480,870,580,846,505,896,505}
D.grave = {{800,606},{840,582},{920,584},{970,600},{940,616},{830,616}}
D.flash = {470,318}
c = chalk()
local function L(pts, pr) c:line(pts, {pressure=pr or 0.35}) end
L(D.horizon, 0.25); L(D.mesa, 0.3); L(D.hill, 0.3)
c:line({{120,110},{150,80},{180,110},{150,140},{120,110}}, {pressure=0.25})
L(D.hat); L(D.face); L(D.cb_back); L(D.cb_hem); L(D.cb_front)
L(D.gunarm_top); L(D.gunarm_bot); c:line(D.gun, {pressure=0.4, smooth=false}); L(D.farhand, 0.3)
c:line(D.leg_rear, {pressure=0.35, smooth=false}); c:line(D.leg_front, {pressure=0.35, smooth=false})
L(D.z_head); L(D.z_back); L(D.z_front); L(D.z_arm1); L(D.z_arm2); L(D.z_leg_rear); L(D.z_leg_front)
c:line({{870,480},{870,580}}, {pressure=0.3}); c:line({{846,505},{896,505}}, {pressure=0.3})
L(D.grave, 0.3)

--@ chunk 3
erase(everywhere(), {strength=0.9})
local s, cx, cy = 1.2, 480, 640
function T(pts)
  local o = {}
  for i, p in ipairs(pts) do o[i] = {cx + (p[1]-cx)*s, cy + (p[2]-cy)*s} end
  return o
end
for _, k in ipairs({"hat","face","cb_back","cb_hem","cb_front","gunarm_top","gunarm_bot","gun","farhand","leg_rear","leg_front",
  "z_head","z_back","z_front","z_arm1","z_arm2","z_leg_rear","z_leg_front"}) do D[k] = T(D[k]) end
D.horizon = {{0,500},{300,497},{600,502},{1000,498}}
D.mesa = {{0,470},{30,462},{60,458},{170,456},{200,462},{230,478},{270,492},{300,500}}
D.hill = {{560,503},{650,488},{760,476},{880,472},{1000,480}}
D.moon = {850,118,34}
D.cross1 = {890,515,890,600,868,535,912,535}
D.grave = {{820,612},{860,594},{935,596},{985,608},{955,624},{850,624}}
D.flash = T({{470,318}})[1]
local c2 = chalk()
local function L(pts, pr) c2:line(pts, {pressure=pr or 0.35}) end
L(D.horizon, 0.25); L(D.mesa, 0.3); L(D.hill, 0.3)
c2:line({{816,118},{850,84},{884,118},{850,152},{816,118}}, {pressure=0.25})
L(D.hat); L(D.face); L(D.cb_back); L(D.cb_hem); L(D.cb_front)
L(D.gunarm_top); L(D.gunarm_bot); c2:line(D.gun, {pressure=0.4, smooth=false}); L(D.farhand, 0.3)
c2:line(D.leg_rear, {pressure=0.35, smooth=false}); c2:line(D.leg_front, {pressure=0.35, smooth=false})
L(D.z_head); L(D.z_back); L(D.z_front); L(D.z_arm1); L(D.z_arm2); L(D.z_leg_rear); L(D.z_leg_front)
c2:line({{890,515},{890,600}}, {pressure=0.3}); c2:line({{868,535},{912,535}}, {pressure=0.3})
L(D.grave, 0.3)
print(D.flash[1], D.flash[2])

--@ chunk 4
CB = {
 crown = {{198,186},{197,165},{200,150},{208,142},{216,147},{222,141},{231,144},{236,156},{238,170},{239,186}},
 brim = {{163,184},{172,187},{200,189},{240,189},{262,190},{273,187},{271,194},{250,198},{220,198},{190,196},{170,192}},
 head = {{198,190},{236,190},{238,201},{247,210},{240,214},{241,218},{239,221},{240,224},{238,231},{230,236},{212,234},{200,226},{195,205}},
 neck = {{203,228},{230,234},{236,252},{222,264},{198,258}},
 coat = {{184,258},{226,250},{246,262},{254,285},{256,320},{258,360},{260,400},{268,440},{280,490},{294,532},{262,538},{230,535},{200,540},{160,543},{120,546},{85,548},{60,544},{92,490},{120,440},{150,390},{172,340},{176,300}},
 leg_r = {{150,530},{192,530},{178,560},{164,590},{156,604},{170,608},{174,619},{112,621},{108,612},{124,602},{134,580},{140,555}},
 leg_f = {{230,530},{272,530},{280,560},{290,588},{294,602},{322,609},{328,620},{272,622},{270,606},{262,582},{244,554}},
 arm = {{196,262},{240,255},{290,251},{335,249},{362,246},{364,270},{335,273},{295,281},{258,293},{230,298}},
 fan = {{250,300},{290,287},{330,273},{362,262},{378,250},{388,247},{392,258},{374,270},{338,289},{298,305},{258,318}},
 hand = {{356,246},{372,243},{386,245},{388,262},{380,273},{360,273}},
 gun = {{376,241},{384,239},{447,240},{447,250},{404,252},{399,266},{395,283},{380,285},{382,266},{372,258}},
}
ZB = {
 head = {{742,236},{748,224},{762,218},{778,222},{788,234},{790,250},{784,266},{772,276},{760,280},{750,276},{744,268},{740,256},{746,250}},
 neck = {{752,268},{776,268},{780,300},{752,302}},
 torso = {{730,300},{760,292},{795,298},{808,330},{812,370},{815,420},{800,442},{770,442},{758,410},{748,370},{738,335}},
 tails = {{805,380},{830,410},{852,452},{842,472},{815,456},{800,440}},
 arm1 = {{742,304},{720,310},{690,316},{660,316},{632,312},{610,305},{604,313},{632,323},{662,329},{692,331},{722,327},{746,323}},
 arm2 = {{760,296},{735,289},{705,283},{675,277},{650,269},{630,264},{628,273},{650,282},{680,292},{712,301},{742,307}},
 leg1 = {{770,430},{792,440},{776,480},{766,520},{756,560},{749,590},{744,601},{712,607},{708,598},{728,592},{738,560},{748,515},{758,470}},
 leg2 = {{790,430},{815,430},{818,470},{828,520},{842,560},{851,594},{860,607},{830,609},{826,598},{830,592},{818,560},{805,520},{796,470}},
}
function partmask(T, keys)
  local m = nil
  for _, k in ipairs(keys) do
    local pm = poly(T[k], true)
    m = m and (m + pm) or pm
  end
  return m
end
function cowboy_mask() return partmask(CB, {"crown","brim","head","neck","coat","leg_r","leg_f","arm","fan","hand","gun"}) end
function zombie_mask() return partmask(ZB, {"head","neck","torso","tails","arm1","arm2","leg1","leg2"}) end
local cm, zm = cowboy_mask(), zombie_mask()
print(cm:area(), zm:area(), cm:at(220,400), zm:at(780,380), cm:at(400,400))

--@ chunk 5
ZB.head = {{752,252},{748,240},{756,234},{760,224},{772,216},{788,218},{800,230},{804,248},{798,264},{786,272},{772,280},{762,284},{756,276},{760,264}}
ZB.neck = {{770,268},{792,262},{792,298},{764,300}}
ZB.torso = {{728,312},{742,298},{766,290},{792,294},{812,312},{826,345},{832,385},{828,420},{815,448},{790,452},{776,430},{762,395},{748,360},{734,335}}
ZB.tails = {{820,400},{838,428},{852,456},{866,480},{852,476},{846,492},{834,472},{824,484},{816,460},{805,448}}
ZB.arm1 = {{752,308},{725,316},{698,326},{668,330},{640,326},{616,318},{610,326},{638,338},{668,344},{700,342},{730,334},{756,330}}
ZB.arm2 = {{770,296},{742,289},{712,282},{682,274},{658,264},{638,258},{634,267},{656,278},{684,290},{716,300},{746,309}}
ZB.leg1 = {{778,436},{806,446},{792,480},{776,520},{762,556},{754,590},{752,600},{716,606},{712,598},{730,590},{738,556},{748,516},{764,476}}
ZB.leg2 = {{800,444},{824,440},{834,476},{850,512},{866,548},{880,584},{890,603},{872,608},{864,598},{856,584},{838,550},{818,516},{804,480}}
CB.crown = {{200,188},{199,172},{203,162},{210,157},{218,161},{224,156},{232,159},{236,168},{238,178},{239,188}}
CB.brim = {{158,183},{172,187},{200,190},{240,190},{264,191},{279,186},{276,194},{252,199},{220,199},{190,197},{166,192}}
CB.fan = {{255,305},{300,290},{340,272},{366,252},{380,240},{392,238},{394,250},{380,262},{350,284},{310,304},{262,322}}
D.horizon = {{0,500},{300,497},{600,502},{1000,498}}
-- land line: mesa on left, plain, Boot Hill rise on right
LAND = {{0,470},{30,462},{60,458},{170,456},{200,462},{230,478},{270,492},{300,498},{450,500},{560,500},{650,488},{760,476},{880,472},{1000,480}}
MESA = {{0,470},{30,462},{60,458},{170,456},{200,462},{230,478},{270,492},{300,498},{0,500}}
print("ok")

--@ chunk 6
sky_top = pile{{"Prussian blue",1},{"bone black",1},{"raw umber",0.5},{"lead white",0.6}, turps=0.5, name="sky_top"}
sky_mid = pile{{"Prussian blue",0.8},{"bone black",0.4},{"yellow ochre",0.5},{"lead white",1.2}, turps=0.5, name="sky_mid"}
sky_low = pile{{"Prussian blue",0.5},{"yellow ochre",1},{"lead white",2.5},{"bone black",0.2}, turps=0.5, name="sky_low"}
local cm, zm = cowboy_mask(), zombie_mask()
local figs = (cm + zm)
local sky = above(LAND) - figs:shrink(2) - ellipse(468,248,30,26):soften(10) - ellipse(850,118,36,36)
local function wtop(x,y) return clamp(1-(y-20)/260,0,1) end
local function wmid(x,y) local d = math.sqrt((x-850)^2+(y-118)^2); return clamp(1-math.abs((y-300)/180),0,1) + clamp(1-d/170,0,1)*0.8 end
local function wlow(x,y) local d = math.sqrt((x-850)^2+(y-118)^2); return clamp((y-330)/160,0,1) + clamp(1-d/110,0,1)*0.7 end
work(sky, {hand="broad", piles={{sky_top, wtop},{sky_mid, wmid},{sky_low, wlow}}, coverage=2.6, fill=true, angle=0.04, clip=true})

--@ chunk 7
gnd_far = pile{{"raw umber",1},{"yellow ochre",0.5},{"green earth",1},{"bone black",0.4},{"lead white",0.9},{"Prussian blue",0.1}, turps=0.5, name="gnd_far"}
gnd_near = pile{{"raw umber",1.4},{"yellow ochre",0.4},{"green earth",0.8},{"bone black",0.8},{"lead white",0.25}, turps=0.5, name="gnd_near"}
mesa_p = pile{{"ultramarine blue",1},{"bone black",0.6},{"red earth",0.5},{"lead white",1.4}, turps=0.5, name="mesa"}
local cm, zm = cowboy_mask(), zombie_mask()
local figs = (cm + zm)
local mesa = (below(LAND) * poly(MESA)) - figs:shrink(2)
work(mesa, {hand="body", pile=mesa_p, coverage=2.5, fill=true, angle=0.0, clip=true})
local land = below(LAND) - poly(MESA) - figs:shrink(2)
work(land, {hand="broad", piles={{gnd_far, function(x,y) return clamp(1-(y-480)/140,0,1) end},{gnd_near, function(x,y) return clamp((y-500)/140,0,1) end}},
   coverage=2.6, fill=true, angle=0.02, clip=true})

--@ chunk 8
fig = pile{{"bone black",1},{"raw umber",1},{"Prussian blue",0.3}, turps=0.5, name="fig"}
local cm, zm = cowboy_mask(), zombie_mask()
work(cm, {hand="body", pile=fig, coverage=2.5, fill=true, clip=true, angle=function(x,y) return 1.4 end})
work(zm, {hand="body", pile=fig, coverage=2.5, fill=true, clip=true, angle=function(x,y) return 1.3 end})

--@ chunk 9
print(wait(24*60))
for _, p in ipairs({{100,100},{600,200},{500,450},{200,400},{780,380},{500,600},{100,480}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 10
print(wait(36*60))
for _, p in ipairs({{100,100},{600,200},{500,450},{200,400},{780,380},{500,600},{100,480}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 11
s1 = pile{{"Prussian blue",0.6},{"ultramarine blue",0.7},{"bone black",0.8},{"lead white",0.45}, name="s1"}
s2 = pile{{"Prussian blue",0.6},{"ultramarine blue",0.4},{"bone black",0.35},{"lead white",1.2},{"raw umber",0.15}, name="s2"}
s3 = pile{{"Prussian blue",0.45},{"viridian",0.2},{"yellow ochre",0.35},{"lead white",2},{"bone black",0.2}, name="s3"}
s4 = pile{{"lead white",3},{"yellow ochre",0.7},{"Prussian blue",0.22},{"viridian",0.1}, name="s4"}
halo = pile{{"lead white",2.5},{"Prussian blue",0.3},{"yellow ochre",0.35},{"bone black",0.08}, name="halo"}
dusk = pile{{"lead white",2.5},{"red earth",0.35},{"yellow ochre",0.5},{"Prussian blue",0.08}, name="dusk"}
print(palette())

--@ chunk 12
local cm, zm = cowboy_mask(), zombie_mask()
local figs = cm + zm
SKY = above(LAND)
local sky = SKY - figs:shrink(1) - ellipse(850,118,33,33)
local function dmoon(x,y) return math.sqrt((x-850)^2+(y-118)^2) end
local W1 = function(x,y) return clamp(1-(y-10)/220,0,1)*clamp(dmoon(x,y)/150,0,1) end
local W2 = function(x,y) return clamp(1-math.abs(y-230)/150,0,1)*clamp(dmoon(x,y)/110,0.2,1) end
local W3 = function(x,y) return clamp(1-math.abs(y-390)/110,0,1) + clamp(1-math.abs(dmoon(x,y)-95)/60,0,1)*0.8 end
local W4 = function(x,y) return clamp((y-430)/60,0,1) end
local WH = function(x,y) return clamp(1-(dmoon(x,y)-34)/55,0,1)*1.5 end
work(sky, {hand="broad", piles={{s1,W1},{s2,W2},{s3,W3},{s4,W4},{halo,WH}}, coverage=2.2, fill=true,
  angle=function(x,y) return 0.03 + 0.05*math.sin(x/170) end, clip=true, pressure={0.5,0.8}})

--@ chunk 13
g_far = pile{{"lead white",1.2},{"green earth",0.6},{"raw umber",0.5},{"Prussian blue",0.15},{"yellow ochre",0.4},{"bone black",0.15}, name="g_far"}
g_mid = pile{{"raw umber",1},{"green earth",0.6},{"yellow ochre",0.3},{"bone black",0.4},{"lead white",0.55},{"Prussian blue",0.1}, name="g_mid"}
g_near = pile{{"raw umber",1},{"bone black",0.7},{"ultramarine blue",0.3},{"green earth",0.4},{"lead white",0.2}, name="g_near"}
mesa2 = pile{{"ultramarine blue",0.5},{"bone black",0.5},{"raw umber",0.3},{"lead white",1.2},{"Prussian blue",0.1}, name="mesa2"}
local cm, zm = cowboy_mask(), zombie_mask()
FIGS = cm + zm
local mesa = (below(LAND) * poly(MESA)) - FIGS:shrink(1)
work(mesa, {hand="body", pile=mesa2, coverage=2.2, fill=true, angle=0.0, clip=true, length={20,50}})
local land = below(LAND) - poly(MESA) - FIGS:shrink(1)
work(land, {hand="broad", piles={
   {g_far, function(x,y) return clamp(1-(y-485)/70,0,1)*1.5 end},
   {g_mid, function(x,y) return clamp(1-math.abs(y-560)/60,0,1) end},
   {g_near, function(x,y) return clamp((y-560)/70,0,1)*1.3 end}},
   coverage=2.4, fill=true, angle=function(x,y) return 0.03*math.sin(x/90) end, clip=true,
   scale_at=function(x,y) return 0.35 + 0.65*clamp((y-470)/190,0,1) end, pressure={0.5,0.8}})

--@ chunk 14
print(wait(60*60))
for _, p in ipairs({{468,248},{400,200},{550,300},{850,180},{100,100},{300,560},{600,640},{50,480}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 15
hot = pile{{"lead white",3},{"Naples yellow",1},{"cadmium yellow",0.5}, name="hot"}
warm = pile{{"lead white",2},{"yellow ochre",0.7},{"orange vermilion",0.25},{"Naples yellow",0.4}, name="warm"}
mgray = mix{{warm,0.5},{s2,0.5}, name="mgray"}
GLOW = {x=485, y=244}
local gx, gy = GLOW.x, GLOW.y
local function d(x,y) return math.sqrt(((x-gx)/1.25)^2+(y-gy)^2) end
local R = 100
local m = (ellipse(gx, gy, R*1.25, R):soften(10)) - FIGS
work(m, {hand="body", tool="filbert 12", piles={
   {hot, function(x,y) return clamp(1-d(x,y)/34,0,1)*3 end},
   {warm, function(x,y) return clamp(1-math.abs(d(x,y)-38)/25,0,1)*1.5 end},
   {mgray, function(x,y) return clamp(1-math.abs(d(x,y)-66)/24,0,1) end},
   {s2, function(x,y) return clamp((d(x,y)-74)/18,0,1)*2 end}},
   coverage=2.2, fill=true, length={15,40}, angle=function(x,y) return math.atan(y-gy, x-gx) + 1.57 end, curve={0.3,0.1}, pressure={0.4,0.7}, clip=-FIGS})

--@ chunk 16
local gx, gy = GLOW.x, GLOW.y
local nz = noise{seed=31, period=70, octaves=3}
local function dn(x,y) local d = math.sqrt(((x-gx)/1.25)^2+(y-gy)^2); return d * (1 + 0.32*nz(x,y)) end
local m = (ellipse(gx, gy, 150, 125):soften(15) - ellipse(gx, gy, 45, 36)) - FIGS
work(m, {hand="body", tool="filbert 10", piles={
   {warm, function(x,y) return clamp(1-math.abs(dn(x,y)-42)/18,0,1)*1.2 end},
   {mgray, function(x,y) return clamp(1-math.abs(dn(x,y)-64)/20,0,1) end},
   {s2, function(x,y) return clamp((dn(x,y)-74)/16,0,1)*2*clamp((310-y)/110,0,1) end},
   {s3, function(x,y) return clamp((dn(x,y)-74)/16,0,1)*2*clamp((y-200)/110,0,1) end}},
   coverage=1.8, fill=true, length={18,45}, angle=function(x,y) return 0.25*nz(x*1.3,y*1.3) + math.atan(y-gy, x-gx) + 1.57 + 0.5 end,
   curve={0.4,0.2}, pressure={0.35,0.65}, clip=-FIGS, edge="lost"})

--@ chunk 17
moon_l = pile{{"lead white",4},{"Naples yellow",0.6},{"yellow ochre",0.08}, name="moon_l"}
moon_m = pile{{"lead white",3},{"Naples yellow",0.4},{"bone black",0.08},{"Prussian blue",0.05},{"yellow ochre",0.15}, name="moon_m"}
local mx, my, mr = 850, 118, 31
local mm = ellipse(mx, my, mr, mr)
work(mm, {hand="detail", tool={kind="filbert", width=6, lay=2}, piles={
  {moon_l, function(x,y) return 1 end},
  {moon_m, function(x,y) local n = math.sin((x-mx)/7)*math.cos((y-my)/9); return clamp(n,0,1)*0.8 + clamp(((x-mx)+(y-my))/40,0,1)*0.6 end}},
  coverage=3, fill=true, length={5,12}, angle=0.8, clip=true})
-- edge of the moon: soften slightly into halo
local rim = ellipse(mx, my, mr+4, mr+4) - ellipse(mx, my, mr-3, mr-3)
blend(rim, {angle=0.5})

--@ chunk 18
local mx, my, mr = 850, 118, 31
maria = pile{{"lead white",2},{"Naples yellow",0.3},{"bone black",0.12},{"Prussian blue",0.06},{"yellow ochre",0.2}, name="maria"}
local b = brush{kind="filbert", width=7, stiffness=0.4}
b:load(maria, 0.5)
b:gesture({{mx-14,my-10,0.4},{mx-4,my-12,0.5},{mx+6,my-6,0.3}})
b:gesture({{mx-8,my+2,0.5},{mx+2,my+6,0.4},{mx+12,my+2,0.2}})
b:gesture({{mx+8,my-16,0.3},{mx+14,my-10,0.3}})
b:gesture({{mx-18,my+10,0.25},{mx-10,my+16,0.25}})
-- the edge, laid as a ring of halo paint and a clean blend
local ring = ellipse(mx, my, mr+7, mr+7) - ellipse(mx, my, mr, mr)
work(ring, {hand="detail", pile=halo, coverage=2.5, fill=true, length={4,10}, angle=function(x,y) return math.atan(y-my,x-mx)+1.57 end, clip=true})
blend(ellipse(mx, my, mr+5, mr+5) - ellipse(mx, my, mr-6, mr-6), {angle=0.3})

--@ chunk 19
local mx, my, mr = 850, 118, 31
blend(ellipse(mx, my, mr-2, mr-2), {angle=0.9})
blend(ellipse(mx, my, mr-2, mr-2), {angle=-0.7})
blend(ellipse(mx, my, mr+16, mr+16) - ellipse(mx, my, mr+1, mr+1), {angle=0.2})

--@ chunk 20
local mx, my, mr = 850, 118, 31
local nz = noise{seed=77, period=50, octaves=3}
local function dn(x,y) return math.sqrt((x-mx)^2+(y-my)^2) * (1 + 0.25*nz(x,y)) end
local m = (ellipse(mx, my, 82, 78):soften(10) - ellipse(mx, my, mr+1, mr+1))
work(m, {hand="body", tool="filbert 7", piles={
   {halo, function(x,y) return clamp(1-(dn(x,y)-32)/14,0,1)*1.5 end},
   {s3, function(x,y) return clamp(1-math.abs(dn(x,y)-50)/16,0,1) end},
   {s2, function(x,y) return clamp((dn(x,y)-56)/14,0,1)*1.5 end}},
   coverage=1.8, fill=true, length={10,26}, angle=function(x,y) return math.atan(y-my, x-mx)+1.57 + 0.3*nz(x,y) end,
   curve={0.3,0.1}, pressure={0.35,0.6}, edge="lost", clip=-ellipse(mx,my,mr,mr)})

--@ chunk 21
local mx, my = 850, 118
sky_cl = mix{{s2,0.45},{s3,0.55}, name="sky_cl"}
local nz = noise{seed=78, period=60, octaves=3}
local m = (ellipse(mx, my, 95, 90):soften(12) - ellipse(mx, my, 54, 52):soften(8))
work(m, {hand="body", tool="filbert 9", piles={{sky_cl, function(x,y) return 1 end},{s3, function(x,y) return clamp(0.5+0.5*nz(x,y),0,1) end}},
   coverage=1.4, fill=true, length={20,50}, angle=function(x,y) return 0.05 + 0.15*nz(x,y) end, pressure={0.35,0.6}, edge="lost", clip=-ellipse(mx,my,46,46)})

--@ chunk 22
local b = brush{kind="filbert", width=14, stiffness=0.4}
local function band(pile, pts, pr, ld)
  b:reload(pile, ld or 0.5)
  b:gesture(pts, {wobble=4})
end
-- lit cloud bands leading out of the halo
band(sky_cl, {{760,60,0.0},{700,64,0.4},{620,70,0.3},{560,72,0.0}})
band(sky_cl, {{940,150,0.0},{975,148,0.4},{1000,146,0.3}})
band(sky_cl, {{770,205,0.0},{700,210,0.45},{640,214,0.35},{590,212,0.0}})
band(sky_cl, {{930,90,0.0},{970,86,0.4},{1000,84,0.3}})
-- darker cloud wisps across the halo's edge
band(s2, {{740,165,0.0},{790,160,0.45},{835,158,0.4},{880,160,0.0}}, nil, 0.4)
band(s2, {{800,192,0.0},{860,186,0.5},{920,184,0.45},{970,188,0.0}}, nil, 0.4)
band(s2, {{780,52,0.0},{830,46,0.4},{900,48,0.35},{950,52,0.0}}, nil, 0.4)
band(s2, {{720,128,0.0},{760,124,0.35},{790,126,0.0}}, nil, 0.35)
band(s2, {{915,118,0.0},{950,114,0.35},{990,116,0.0}}, nil, 0.35)

--@ chunk 23
local r1 = ribbon({{550,72},{620,70},{700,64},{775,60}}, 26):soften(8)
local r2 = ribbon({{580,212},{640,214},{700,210},{780,205}}, 26):soften(8)
local r3 = ribbon({{930,150},{975,148},{1000,146}}, 22):soften(6) + ribbon({{925,90},{970,86},{1000,84}}, 22):soften(6)
blend(r1 + r2 + r3, {angle=0.05})
blend(r1 + r2, {angle=0.6})

--@ chunk 24
r = rag{width=30}
r:dip(0.9)
r:wipe({{545,72},{620,70},{700,64},{780,60}}, {pressure={0.7,0.7}})
r:refold(); r:dip(0.9)
r:wipe({{780,62},{700,66},{620,72},{545,74}}, {pressure={0.7,0.7}})
r:refold(); r:dip(0.9)
r:wipe({{545,58},{620,58},{700,54},{770,52}}, {pressure={0.6,0.6}})
r:refold(); r:dip(0.9)
r:wipe({{545,86},{620,84},{700,78},{770,74}}, {pressure={0.6,0.6}})
print(r)

--@ chunk 25
local nz = noise{seed=79, period=80, octaves=3}
local m = ellipse(660, 70, 135, 30):soften(14)
work(m, {hand="body", tool="filbert 12", piles={{s1, function(x,y) return 0.6 + 0.4*nz(x,y) end},{s2, function(x,y) return 1 end}},
  coverage=1.8, fill=true, length={30,70}, angle=function(x,y) return -0.04 + 0.08*nz(x,y) end, pressure={0.4,0.7}, edge="lost", clip=-ellipse(850,118,95,90)})

--@ chunk 26
print(wait(3*24*60))
for _, p in ipairs({{485,244},{560,250},{620,300},{850,118},{780,140},{660,70},{300,560},{50,480}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 27
print(wait(4*24*60))
for _, p in ipairs({{485,244},{560,250},{620,300},{850,118},{780,140},{660,70},{900,470},{50,480}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 28
print(wait(3*24*60))
for _, p in ipairs({{560,250},{780,140},{660,70},{700,90},{600,60}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 29
figd = pile{{"bone black",1},{"raw umber",1},{"Prussian blue",0.3}, name="figd"}
-- cowboy hat: new crown and curled brim
CB.crown2 = {{199,191},{197,174},{200,161},{207,154},{214,156},{220,160},{227,155},{235,157},{240,166},{242,178},{242,191}}
CB.brim2 = {{157,174},{163,182},{176,188},{200,191},{240,192},{262,190},{274,184},{281,175},{283,181},{278,191},{262,197},{240,199},{200,199},{176,196},{162,190},{155,181}}
-- gun: cylinder, hammer, square muzzle
CB.gun2 = {{380,236},{386,233},{392,236},{404,236},{406,239},{450,239},{452,241},{452,249},{406,250},{405,254},{390,256}}
local hm = poly(CB.crown2, true) + poly(CB.brim2, true) + poly(CB.gun2, false)
-- zombie additions
ZB.hunch = {{786,292},{806,296},{822,308},{834,330},{838,352},{830,360},{818,338},{802,316}}
ZB.jaw = {{758,262},{750,270},{744,280},{746,290},{756,292},{764,284},{768,272}}
ZB.arm1b = {{752,306},{725,312},{698,320},{668,322},{640,318},{618,312},{612,322},{638,334},{668,341},{700,342},{730,338},{758,334}}
ZB.arm2b = {{768,293},{742,285},{712,277},{682,268},{658,259},{638,254},{632,265},{654,277},{684,289},{716,300},{748,308}}
ZB.hem = {{776,444},{784,452},{792,446},{800,458},{806,448},{814,462},{820,450},{828,456},{830,440},{818,430},{790,436}}
local zm = poly(ZB.hunch, true) + poly(ZB.jaw, true) + poly(ZB.arm1b, true) + poly(ZB.arm2b, true) + poly(ZB.hem, false)
work(hm + zm, {hand="detail", tool={kind="round", width=3, point=0.3}, pile=figd, coverage=3, fill=true, clip=true, length={4,12}})

--@ chunk 30
rig = brush{kind="rigger", width=3.2, point=1}
local function g(pts) rig:gesture(pts, {wobble=0.6}) end
-- arm2 (upper) hand at ~ (634,260): claws reaching left
rig:reload(figd, 0.9)
g({{640,258,0.95},{628,252,0.8},{616,247,0.5},{608,248,0.2},{604,252,0.0}})
g({{638,262,0.95},{624,259,0.8},{612,258,0.5},{604,262,0.15},{602,266,0.0}})
g({{636,266,0.95},{624,268,0.75},{614,271,0.45},{608,276,0.1},{608,280,0.0}})
g({{640,270,0.9},{632,277,0.6},{626,284,0.3},{627,289,0.0}})
-- arm1 (lower) hand at ~ (612,318)
rig:reload(figd, 0.9)
g({{618,314,0.95},{604,308,0.8},{592,304,0.5},{584,306,0.2},{581,310,0.0}})
g({{616,318,0.95},{602,316,0.8},{590,317,0.5},{583,322,0.15},{582,326,0.0}})
g({{616,322,0.95},{604,326,0.75},{594,331,0.45},{589,337,0.1},{590,341,0.0}})
g({{620,327,0.9},{612,335,0.6},{606,342,0.3},{608,347,0.0}})
-- ragged sleeves hanging from forearms
rig:reload(figd, 0.9)
for i, s in ipairs({{652,330,646,352},{664,336,660,360},{676,338,674,354},{690,340,692,366},{704,340,700,352}}) do
  g({{s[1],s[2],1.0},{(s[1]+s[3])/2+rand(-2,2),(s[2]+s[4])/2,0.7},{s[3],s[4],0.0}})
end
for i, s in ipairs({{668,283,664,300},{682,289,680,310},{696,294,698,306},{712,299,708,316}}) do
  g({{s[1],s[2],1.0},{(s[1]+s[3])/2+rand(-2,2),(s[2]+s[4])/2,0.7},{s[3],s[4],0.0}})
end
-- stringy hair flung back from the impact
rig:reload(figd, 0.9)
for i, s in ipairs({{790,232,826,220,846,222},{796,242,830,238,856,244},{798,252,826,256,846,268},{794,260,816,272,828,288},{786,226,812,212,826,204},{792,266,806,284,808,300}}) do
  g({{s[1],s[2],1.0},{s[3],s[4],0.55},{s[5],s[6],0.0}})
end
-- coat tatters
rig:reload(figd, 0.9)
for i, s in ipairs({{786,448,782,470},{800,452,804,478},{814,456,812,474},{826,452,836,470},{846,474,852,494},{836,486,834,500}}) do
  g({{s[1],s[2],1.0},{(s[1]+s[3])/2+rand(-2,2),(s[2]+s[4])/2,0.6},{s[3],s[4],0.0}})
end

--@ chunk 31
kn = knife{width=12}
local function sc(pts) kn:scrape(pts, {pressure=1}); kn:wipe() end
-- claws
sc({{640,258},{628,252},{616,247},{608,248},{602,252}})
sc({{638,262},{624,259},{612,258},{604,262},{601,267}})
sc({{636,266},{624,268},{614,271},{608,276},{607,281}})
sc({{640,270},{632,277},{626,284},{627,290}})
sc({{618,314},{604,308},{592,304},{584,306},{580,311}})
sc({{616,318},{602,316},{590,317},{583,322},{581,327}})
sc({{616,322},{604,326},{594,331},{589,337},{590,342}})
sc({{620,327},{612,335},{606,342},{608,348}})
for i, s in ipairs({{652,330,646,352},{664,336,660,360},{676,338,674,354},{690,340,692,366},{704,340,700,352},{668,283,664,300},{682,289,680,310},{696,294,698,306},{712,299,708,316},
  {786,448,782,470},{800,452,804,478},{814,456,812,474},{826,452,836,470},{846,474,852,494},{836,486,834,500}}) do
  sc({{s[1],s[2]-2},{s[3],s[4]+3}})
end
for i, s in ipairs({{790,232,826,220,846,222},{796,242,830,238,856,244},{798,252,826,256,846,268},{794,260,816,272,828,288},{786,226,812,212,826,204},{792,266,806,284,808,300}}) do
  sc({{s[1],s[2]},{s[3],s[4]},{s[5]+3,s[6]}})
end

--@ chunk 32
print(drying(830,238), drying(612,258), drying(660,345))
local rr = rag{width=14}
local function rw(pts)
  rr:dip(0.95)
  rr:wipe(pts, {pressure={0.85,0.85}})
  rr:refold()
end
for i, s in ipairs({{790,232,826,220,846,222},{796,242,830,238,856,244},{798,252,826,256,846,268},{794,260,816,272,828,288},{786,226,812,212,826,204},{792,266,806,284,808,300}}) do
  rw({{s[1]+6,s[2]},{s[3],s[4]},{s[5]+4,s[6]}})
  rw({{s[5]+4,s[6]},{s[3],s[4]},{s[1]+6,s[2]}})
end
print(rr)

--@ chunk 33
local rr = rag{width=12}
local function rw(pts)
  rr:dip(0.95)
  rr:wipe(pts, {pressure={0.85,0.85}})
  rr:refold()
end
local claws = {
 {{640,258},{628,252},{616,247},{608,248},{602,252}},
 {{638,262},{624,259},{612,258},{604,262},{601,267}},
 {{636,266},{624,268},{614,271},{608,276},{607,281}},
 {{640,270},{632,277},{626,284},{627,290}},
 {{618,314},{604,308},{592,304},{584,306},{580,311}},
 {{616,318},{602,316},{590,317},{583,322},{581,327}},
 {{616,322},{604,326},{594,331},{589,337},{590,342}},
 {{620,327},{612,335},{606,342},{608,348}}}
for _, c in ipairs(claws) do
  local rev = {}
  for i = #c, 1, -1 do rev[#rev+1] = c[i] end
  rw(rev); rw(c)
end
for i, s in ipairs({{652,330,646,352},{664,336,660,360},{676,338,674,354},{690,340,692,366},{704,340,700,352},{668,283,664,300},{682,289,680,310},{696,294,698,306},{712,299,708,316},
  {786,448,782,470},{800,452,804,478},{814,456,812,474},{826,452,836,470},{846,474,852,494},{836,486,834,500}}) do
  rw({{s[3],s[4]+4},{s[1],s[2]+4}}); rw({{s[3],s[4]+4},{s[1],s[2]+4}})
end

--@ chunk 34
print(palette())

--@ chunk 35
C2 = {
 crown = {{201,190},{199,176},{201,164},{207,156},{214,155},{220,160},{226,154},{234,156},{240,165},{242,178},{243,190}},
 brim = {{158,178},{166,184},{182,189},{205,191},{240,191},{262,189},{276,184},{282,179},{284,184},{279,192},{264,198},{240,201},{205,201},{180,198},{165,192},{157,185}},
 head = {{200,191},{240,191},{243,199},{240,204},{246,208},{251,215},{245,218},{247,222},{241,225},{244,230},{241,236},{230,240},{218,240},{206,234},{198,222},{196,205}},
 neck = {{206,232},{224,238},{232,244},{234,258},{204,260},{200,244}},
 band = {{202,244},{220,246},{236,246},{242,252},{240,262},{226,266},{204,264},{198,254}},
 btail = {{204,248},{190,244},{176,246},{166,252},{178,254},{186,258},{200,260}},
 coat = {{184,254},{214,250},{238,252},{250,262},{254,285},{257,320},{260,360},{263,400},{270,445},{280,490},{293,530},{297,541},{270,545},{240,541},{205,547},{170,549},{130,551},{95,553},{60,549},{80,518},{102,478},{126,436},{150,392},{166,350},{174,305},{178,272}},
 arm = {{205,252},{240,249},{290,247},{335,245},{352,243},{355,256},{354,268},{335,272},{300,279},{262,291},{232,301},{214,298}},
 hand = {{350,244},{366,240},{382,242},{390,248},{392,258},{388,270},{378,276},{362,276},{352,268}},
 gun = {{372,236},{378,232},{386,236},{398,235},{404,237},{452,237},{453,240},{453,249},{404,250},{402,256},{394,258}},
 grip = {{372,270},{384,272},{388,284},{380,289},{370,285}},
 farm = {{252,296},{290,286},{328,272},{356,260},{372,252},{386,250},{390,258},{376,266},{350,280},{316,296},{280,310},{254,318}},
 legr = {{150,532},{194,532},{186,556},{174,580},{166,600},{170,608},{180,612},{186,620},{124,622},{122,612},{134,604},{140,580},{144,556}},
 legf = {{230,532},{274,532},{280,560},{288,586},{296,602},{316,608},{330,614},{332,622},{276,623},{272,606},{262,584},{248,558}},
}
Z2 = {
 head = {{762,216},{780,218},{794,230},{802,246},{798,262},{788,274},{772,282},{760,290},{746,290},{742,284},{746,272},{748,264},{743,258},{739,249},{745,242},{744,235},{750,225}},
 neck = {{770,276},{790,270},{794,300},{766,302}},
 torso = {{744,306},{764,294},{790,292},{812,300},{830,318},{838,345},{836,385},{828,422},{816,448},{790,454},{776,440},{764,400},{752,360},{740,328}},
 tails = {{816,420},{834,436},{852,462},{866,486},{854,480},{850,494},{838,478},{830,490},{820,468},{808,452}},
 armn = {{752,306},{725,312},{698,320},{668,322},{640,318},{620,312},{614,322},{638,334},{668,341},{700,342},{730,338},{758,334}},
 armf = {{768,293},{742,285},{712,277},{682,268},{658,259},{640,254},{634,265},{654,277},{684,289},{716,300},{748,308}},
 handn = {{622,312},{606,310},{598,316},{600,328},{612,334},{624,332}},
 handf = {{642,252},{626,248},{618,254},{620,264},{634,268},{644,266}},
 leg1 = {{778,436},{806,446},{792,480},{776,520},{762,556},{754,590},{752,600},{716,606},{712,598},{730,590},{738,556},{748,516},{764,476}},
 leg2 = {{800,444},{824,440},{834,476},{850,512},{866,548},{880,584},{890,603},{872,608},{864,598},{856,584},{838,550},{818,516},{804,480}},
}
function PM(T, k) return poly(T[k], true) end
local old = cowboy_mask() + poly(CB.crown2,true) + poly(CB.brim2,true) + poly(CB.gun2,false)
local new = PM(C2,"crown")+PM(C2,"brim")+PM(C2,"head")+PM(C2,"neck")+PM(C2,"band")+PM(C2,"btail")+PM(C2,"coat")+PM(C2,"arm")+PM(C2,"hand")+poly(C2.gun,false)+PM(C2,"grip")+PM(C2,"farm")+PM(C2,"legr")+PM(C2,"legf")
local diff = old - new
print("cowboy old-new area", diff:area(), "new-old", (new-old):area())
local zold = zombie_mask() + poly(ZB.hunch,true)+poly(ZB.jaw,true)+poly(ZB.arm1b,true)+poly(ZB.arm2b,true)+poly(ZB.hem,false)
local znew = PM(Z2,"head")+PM(Z2,"neck")+PM(Z2,"torso")+PM(Z2,"tails")+PM(Z2,"armn")+PM(Z2,"armf")+PM(Z2,"handn")+PM(Z2,"handf")+PM(Z2,"leg1")+PM(Z2,"leg2")
print("zombie old-new", (zold-znew):area(), "new-old", (znew-zold):area())
OLDFIG = old + zold
NEWFIG = new + znew

--@ chunk 36
-- final silhouettes: union of the laid-in shapes and the revised drawing (legs from the revision)
C2.crown = {{198,186},{197,165},{200,150},{208,142},{216,147},{222,141},{231,144},{236,156},{238,170},{239,186}}
C2.farm = {{255,305},{300,290},{340,272},{366,252},{380,240},{392,238},{394,250},{380,262},{350,284},{310,304},{262,322}}
Z2.head = {{762,212},{778,212},{794,222},{802,238},{800,256},{792,270},{780,280},{768,288},{756,290},{748,284},{742,274},{737,266},{743,261},{746,254},{741,248},{744,242},{737,236},{735,230},{743,226},{750,218}}
function cowboy_final()
  local old = nil
  for _, k in ipairs({"crown","brim","head","neck","coat","arm","fan","hand"}) do local p = poly(CB[k], true); old = old and old + p or p end
  old = old + poly(CB.crown2,true) + poly(CB.brim2,true) + poly(CB.gun,true) + poly(CB.gun2,false)
  old = old * above({{0,548},{1000,548}})
  local new = nil
  for _, k in ipairs({"crown","brim","head","neck","band","btail","coat","arm","hand","grip","farm","legr","legf"}) do local p = poly(C2[k], true); new = new and new + p or p end
  return old + new + poly(C2.gun,false)
end
function zombie_final()
  local old = nil
  for _, k in ipairs({"neck","torso","tails","arm1","arm2","hunch","arm1b","arm2b"}) do local p = poly(ZB[k], true); old = old and old + p or p end
  old = old + poly(ZB.hem,false)
  local new = nil
  for _, k in ipairs({"head","neck","torso","tails","armn","armf","handn","handf","leg1","leg2"}) do local p = poly(Z2[k], true); new = new and new + p or p end
  return old + new
end
local cf, zf = cowboy_final(), zombie_final()
local prev = cowboy_mask() + zombie_mask() + poly(CB.crown2,true) + poly(CB.brim2,true) + poly(CB.gun2,false)
  + poly(ZB.hunch,true)+poly(ZB.jaw,true)+poly(ZB.arm1b,true)+poly(ZB.arm2b,true)+poly(ZB.hem,false)
PREVFIG = prev
local add = (cf + zf) - prev
print("to add", add:area(), "to remove", (prev - cf - zf):area())
work(add, {hand="detail", tool={kind="round", width=3, point=0.3}, pile=figd, coverage=3, fill=true, clip=true, length={4,12}})

--@ chunk 37
sand_far = pile{{"lead white",1.2},{"green earth",0.4},{"yellow ochre",0.35},{"raw umber",0.3},{"Prussian blue",0.12},{"bone black",0.1}, name="sand_far"}
sand_mid = pile{{"lead white",0.6},{"raw umber",0.6},{"green earth",0.4},{"yellow ochre",0.25},{"bone black",0.25},{"ultramarine blue",0.15}, name="sand_mid"}
earth_dk = pile{{"raw umber",1},{"bone black",0.5},{"ultramarine blue",0.3},{"green earth",0.3},{"lead white",0.22}, name="earth_dk"}
near_dk = pile{{"raw umber",1},{"bone black",0.8},{"ultramarine blue",0.4},{"lead white",0.1}, name="near_dk"}
pool = pile{{"lead white",1},{"yellow ochre",0.6},{"raw umber",0.3},{"orange vermilion",0.1},{"green earth",0.2}, name="pool"}
FIG2 = cowboy_final() + zombie_final()
local land = below(LAND) - poly(MESA)
local nz = noise{seed=101, period=120, octaves=4, stretch={0, 4}}
local function depth(y) return clamp((y-470)/195,0,1) end
local function poolw(x,y) local dx = (x-470)/190; local dy = (y-596)/42; return clamp(1 - math.sqrt(dx*dx+dy*dy),0,1) end
work(land, {hand="body", tool="filbert 12", piles={
  {sand_far, function(x,y) return clamp(1-depth(y)*2.2,0,1)*1.4 + clamp(nz(x,y),0,1)*0.6*clamp(1-depth(y)*1.5,0,1) end},
  {sand_mid, function(x,y) return clamp(1-math.abs(depth(y)-0.45)*3,0,1) end},
  {earth_dk, function(x,y) return clamp(1-math.abs(depth(y)-0.7)*3.5,0,1) + clamp(-nz(x,y),0,1)*0.7 end},
  {near_dk, function(x,y) return clamp((depth(y)-0.75)*4,0,1)*1.5 end},
  {pool, function(x,y) return poolw(x,y)*2.2 end}},
  coverage=2.2, fill=true, angle=function(x,y) return 0.02*math.sin(x/70) + 0.04*nz(x*0.7,y*0.7) end,
  length={25,70}, scale_at=function(x,y) return 0.3 + 0.9*depth(y) end, pressure={0.45,0.75}, clip=-FIG2, seed=2201})

--@ chunk 38
local poolm = ellipse(470, 596, 230, 60):soften(20) - FIG2:grow(3)
blend(poolm, {angle=0.0})
blend(poolm, {angle=0.15})

--@ chunk 39
for _, p in ipairs({{460,243},{500,240},{540,250},{480,260},{520,228}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 40
flame_w = pile{{"lead white",3},{"lemon chrome",0.5}, name="flame_w"}
flame_y2 = pile{{"lead white",2.2},{"cadmium yellow",1},{"lemon chrome",0.4}, name="flame_y2"}
flame_o = pile{{"cadmium yellow",1},{"orange vermilion",0.6},{"lead white",0.2}, name="flame_o"}
sparks = pile{{"cadmium yellow",1},{"lead white",1},{"lemon chrome",0.4}, medium=0.4, name="sparks"}
MUZ = {x=455, y=243}
local mx, my, seed = MUZ.x, MUZ.y, 9
local P = function(dx, dy, c) local t = {mx+dx, my+dy}; if c then t[3] = "c" end; return t end
local o = outline{P(0,-6), P(12,-13), P(24,-22,true), P(32,-14), P(48,-18,true), P(58,-8), P(92,-2,true), P(62,5), P(76,15,true), P(50,12), P(34,22,true), P(20,12), P(0,6), closed=true, char="soft", seed=seed, amount=0.5, edge=3}
FLM = o:mask()
local ang = function(x,y) return math.atan(y-my, x-mx+6) end
work(FLM, {hand="body", tool={kind="filbert", width=5, lay=2}, pile=flame_y2, coverage=2.4, fill=true, length={8,22}, angle=ang, clip=true, pressure={0.5,0.8}})
work(FLM - FLM:shrink(3.5) - ellipse(mx+10, my, 22, 9), {hand="detail", tool={kind="round", width=2.5}, pile=flame_o, coverage=2, fill=true, length={4,10}, angle=ang, clip=true})
blend(FLM:grow(2), {angle=0.0})
local bw = brush{kind="filbert", width=10, lay=7, stiffness=0.6}
bw:load(flame_w, 1.0)
bw:gesture({{mx+1, my, 1.0},{mx+16, my-1, 1.0},{mx+34, my, 0.6},{mx+50, my-1, 0.0}})
bw:load(flame_w, 1.0)
bw:gesture({{mx+1, my+3, 0.9},{mx+14, my+5, 0.7},{mx+26, my+7, 0.0}})
bw:gesture({{mx+1, my-3, 0.9},{mx+14, my-6, 0.7},{mx+24, my-9, 0.0}})

--@ chunk 41
local mx, my = MUZ.x, MUZ.y
local sb = brush{kind="round", width=6}
sb:load(sparks, 0.9)
print(sb:spatter{at={mx+20, my}, toward={120, 2}, spread=0.38, force=0.5, clip=-FIG2})
sb:load(sparks, 0.5)
print(sb:spatter{at={mx+14, my-2}, toward={85, -30}, spread=0.5, force=0.35, clip=-FIG2})

--@ chunk 42
print(wait(2*24*60))
for _, p in ipairs({{500,520},{900,500},{400,640},{470,600},{50,480},{500,243},{470,243}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 43
print(wait(2*24*60))
for _, p in ipairs({{500,520},{900,500},{400,640},{470,600},{700,560},{500,243},{470,243}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 44
print(wait(36*60))
for _, p in ipairs({{500,520},{900,500},{400,640},{470,600},{700,560},{600,580},{300,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 45
mesa_far = pile{{"Prussian blue",0.35},{"ultramarine blue",0.3},{"bone black",0.25},{"lead white",1.7},{"raw umber",0.1},{"yellow ochre",0.15}, name="mesa_far"}
pool2 = pile{{"lead white",0.8},{"yellow ochre",0.6},{"raw umber",0.35},{"orange vermilion",0.08},{"green earth",0.25}, name="pool2"}
-- mesa, restated as a distant atmospheric table with a lower ledge
MESA2 = {{0,500},{0,466},{20,461},{48,456},{150,455},{170,458},{188,466},{214,472},{236,474},{262,482},{300,492},{350,499},{350,505},{0,505}}
local mm = poly(MESA2, true) * above(LAND):grow(3) - FIG2
work(mm, {hand="body", tool="filbert 8", pile=mesa_far, coverage=2.2, fill=true, angle=0.0, length={20,50}, clip=true})
-- ground around the pool, re-stated; pool smaller, centered under the flash at the figures' depth
local nz = noise{seed=303, period=90, octaves=3, stretch={0, 4}}
local region = ellipse(480, 590, 290, 72):soften(25) * below(LAND) - FIG2:grow(1)
local function pw(x,y) local dx=(x-490)/175; local dy=(y-606)/30; return clamp(1-math.sqrt(dx*dx+dy*dy),0,1) end
work(region, {hand="body", tool="filbert 10", piles={
  {sand_mid, function(x,y) return clamp(1-(y-540)/60,0,1)*1.2 + 0.3 end},
  {earth_dk, function(x,y) return clamp((y-560)/50,0,1)*1.2 + clamp(-nz(x,y),0,1)*0.5 end},
  {pool2, function(x,y) return pw(x,y)^0.7*2.4 end}},
  coverage=2, fill=true, angle=function(x,y) return 0.03*nz(x,y) end, length={25,60}, pressure={0.45,0.75}, edge="soft", clip=-FIG2:grow(1), seed=3301})

--@ chunk 46
local region = ellipse(480, 590, 300, 80):soften(30) * below(LAND) - FIG2:grow(2)
blend(region, {angle=0.0})
blend(region, {angle=0.08})

--@ chunk 47
local nz = noise{seed=404, period=60, octaves=3, stretch={0, 5}}
local band = (below(LAND) * above({{0,565},{1000,565}})):soften(10) - FIG2:grow(1)
local function depth(y) return clamp((y-480)/90,0,1) end
work(band, {hand="body", tool="filbert 9", piles={
  {sand_far, function(x,y) return clamp(1-depth(y)*1.6,0,1)*1.3 + clamp(nz(x,y),0,1)*0.5 end},
  {sand_mid, function(x,y) return clamp(depth(y),0,1)*1.0 + 0.2 end},
  {earth_dk, function(x,y) return clamp(-nz(x,y),0,1)*0.6*depth(y) end}},
  coverage=1.6, fill=false, angle=function(x,y) return 0.015*math.sin(x/50) + 0.03*nz(x,y) end,
  length={30,90}, scale_at=function(x,y) return 0.4 + 0.6*depth(y) end, pressure={0.4,0.7}, clip=-FIG2:grow(1), seed=4401})

--@ chunk 48
sky_patch = mix{{s1,0.4},{s2,0.6}, name="sky_patch"}
print(sky_patch)
for _, p in ipairs({{150,170},{290,175},{220,140},{200,300},{780,200}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 49
local b = brush{kind="filbert", width=6}
b:load(sky_patch, 0.6)
b:stroke({{140,160},{165,161}}, {pressure=0.6})

--@ chunk 50
sky_patch = pile{{"Prussian blue",0.22},{"ultramarine blue",0.18},{"bone black",0.25},{"lead white",0.30},{"raw umber",0.05}, name="sky_patch"}
local b = brush{kind="filbert", width=6}
b:load(sky_patch, 0.6)
b:stroke({{140,150},{165,151}}, {pressure=0.6})

--@ chunk 51
HAT = {
 crown = {{202,191},{201,178},{203,164},{207,155},{213,151},{219,154},{226,150},{234,152},{239,160},{242,174},{243,191}},
 brim = {{156,180},{166,186},{190,190},{220,191},{250,190},{270,186},{283,179},{287,181},{281,188},{266,195},{245,199},{220,201},{192,200},{172,196},{160,190},{154,184}},
}
local oldhat = poly(CB.crown,true) + poly(CB.crown2,true) + poly(CB.brim,true) + poly(CB.brim2,true) + poly(C2.crown,true) + poly(C2.brim,true)
local newhat = poly(HAT.crown,true) + poly(HAT.brim,true)
local head = poly(C2.head, true)
local cut = (oldhat - newhat - head) * above({{0,200},{1000,200}})
print(cut:area())
work(cut:grow(1.5) - newhat, {hand="detail", tool={kind="filbert", width=4}, pile=sky_patch, coverage=3, fill=true, clip=true, length={4,10}, angle=0.05})

--@ chunk 52
local oldhat = poly(CB.crown,true) + poly(CB.crown2,true) + poly(CB.brim,true) + poly(CB.brim2,true) + poly(C2.crown,true) + poly(C2.brim,true)
local newhat = poly(HAT.crown,true) + poly(HAT.brim,true)
local head = poly(C2.head, true)
local cut = (oldhat - newhat - head) * above({{0,200},{1000,200}})
work(cut:grow(1.5) - newhat, {hand="detail", tool={kind="filbert", width=4, lay=2.5}, pile=sky_patch, coverage=4, fill=true, clip=true, length={4,10}, angle=0.05, load=1.0})

--@ chunk 53
for _, p in ipairs({{220,400},{230,220},{780,380},{640,320},{770,250},{170,580},{800,550}}) do print(p[1],p[2],drying(p[1],p[2])) end
coat_d = pile{{"raw umber",1},{"bone black",0.7},{"red earth",0.25},{"lead white",0.25},{"ultramarine blue",0.1}, name="coat_d"}
trou_d = pile{{"bone black",1},{"ultramarine blue",0.4},{"raw umber",0.5},{"lead white",0.2}, name="trou_d"}
hat_d = pile{{"raw umber",1},{"bone black",0.6},{"yellow ochre",0.2},{"lead white",0.25}, name="hat_d"}
skin_cd = pile{{"red earth",0.6},{"raw umber",0.8},{"bone black",0.2},{"lead white",0.25}, name="skin_cd"}
band_d = pile{{"Indian red",1},{"bone black",0.3},{"raw umber",0.2}, name="band_d"}
zsuit = pile{{"bone black",0.8},{"raw umber",0.6},{"green earth",0.6},{"lead white",0.25}, name="zsuit"}
zskin_d = pile{{"green earth",1},{"raw umber",0.5},{"bone black",0.35},{"lead white",0.3},{"yellow ochre",0.2}, name="zskin_d"}
print(palette())

--@ chunk 54
print(wait(2*24*60))
for _, p in ipairs({{640,320},{170,580},{800,550},{180,150},{230,220}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 55
HEAD3 = {{203,197},{240,199},{243,204},{245,208},{243,211},{247,214},{251,218},{252,221},{247,223},{247,226},{245,228},{247,231},{246,236},{241,240},{235,243},{235,252},{206,256},{202,240},{200,220}}
GAP = {{232,292},{262,286},{300,277},{335,268},{354,258},{358,268},{332,282},{300,298},{262,314},{236,318}}
local ARMS = poly(C2.arm,true)+poly(C2.farm,true)+poly(CB.arm,true)+poly(CB.fan,true)
local HANDG = poly(C2.hand,true)+poly(CB.hand,true)+poly(C2.gun,false)+poly(CB.gun,true)+poly(CB.gun2,false)+poly(C2.grip,true)
local HATM = poly(HAT.crown,true)+poly(HAT.brim,true)
local HEADM = poly(HEAD3,true)
local BANDM = poly(C2.band,true)+poly(C2.btail,true)
local LEGM = (poly(C2.legr,true)+poly(C2.legf,true)) * below({{0,538},{1000,538}})
local all = cowboy_final() + poly(GAP,true)
COATM = all - ARMS - HANDG - HATM - HEADM - BANDM - LEGM - above({{0,248},{1000,248}})
print(COATM:area(), ARMS:area(), LEGM:area())
coat_dk = pile{{"raw umber",1},{"bone black",1},{"red earth",0.15},{"ultramarine blue",0.15},{"lead white",0.08}, name="coat_dk"}
coat_lit = pile{{"yellow ochre",0.7},{"raw umber",0.4},{"red earth",0.25},{"orange vermilion",0.08},{"lead white",0.5}, name="coat_lit"}
local fx, fy = 470, 243
local function xr(y) return 250 + (y-262)*(47/279) end
local function lightf(x,y) local d = math.sqrt((x-fx)^2+(y-fy)^2); return 1/(1+(d/150)^2) end
work(COATM, {hand="body", tool={kind="filbert", width=7}, piles={
  {coat_dk, function(x,y) return 1.2 end},
  {coat_d, function(x,y) return clamp(1-(xr(y)-x)/45,0,1)*0.9 end},
  {coat_lit, function(x,y) return clamp(1-(xr(y)-x)/14,0,1)*lightf(x,y)*3.5 end}},
  coverage=2.2, fill=true, clip=true, length={18,45}, angle=function(x,y) return 1.75 - (y-260)/1400 end, pressure={0.5,0.8}, seed=5101})

--@ chunk 56
coat_dk2 = pile{{"bone black",1},{"raw umber",0.6},{"ultramarine blue",0.3}, name="coat_dk2"}
local b = brush{kind="flat", width=16, stiffness=0.5}
local function fold(x0,y0,x1,y1,bend,pr)
  local mx, my = (x0+x1)/2 + bend, (y0+y1)/2
  b:gesture({{x0,y0,pr*0.6},{mx,my,pr},{x1,y1,pr*0.8}}, {wobble=3, clip=COATM})
end
-- back (left) shadow side: broad dark sweeps
b:load(coat_dk2, 0.9)
fold(186,300, 80,540, -6, 0.9)
fold(196,300, 110,545, -4, 0.9)
b:load(coat_dk2, 0.9)
fold(205,300, 140,545, -2, 0.85)
fold(214,330, 170,545, 4, 0.8)
b:load(coat_dk2, 0.8)
fold(222,340, 205,545, 6, 0.75)
fold(240,360, 248,540, 4, 0.6)
b:load(coat_dk2, 0.8)
fold(230,330, 230,520, -4, 0.7)
fold(176,300, 64,546, -8, 0.95)
fold(250,400, 268,540, 2, 0.5)

--@ chunk 57
local function xr(y) return 250 + (y-262)*(47/279) end
work(COATM, {hand="body", tool={kind="filbert", width=9}, piles={
  {coat_dk2, function(x,y) return clamp((xr(y)-x)/40,0,1)*1.5 + 0.3 end},
  {coat_dk, function(x,y) return 0.8 end}},
  coverage=1.6, fill=true, clip=true, length={25,60}, angle=function(x,y) return 1.75 - (y-260)/1400 + 0.08*math.sin(x/20) end, pressure={0.5,0.8}, seed=5102})

--@ chunk 58
local ARMS = poly(C2.arm,true)+poly(C2.farm,true)+poly(CB.arm,true)+poly(CB.fan,true)
local HANDG = poly(C2.hand,true)+poly(CB.hand,true)+poly(C2.gun,false)+poly(CB.gun,true)+poly(CB.gun2,false)+poly(C2.grip,true)
local HATM = poly(HAT.crown,true)+poly(HAT.brim,true)
local HEADM = poly(HEAD3,true)
local BANDM = poly(C2.band,true)+poly(C2.btail,true)
local LEGM = (poly(C2.legr,true)+poly(C2.legf,true)) * below({{0,538},{1000,538}})
CBP = {ARMS = ARMS - HANDG - HEADM - BANDM, HANDG = HANDG, HATM = HATM, HEADM = HEADM - HATM, BANDM = BANDM - HEADM, LEGM = LEGM}
-- sleeves & shoulders: coat color, strokes along the arm
work(CBP.ARMS:grow(1.2) - HANDG - HEADM - BANDM - HATM, {hand="body", tool={kind="filbert", width=6}, piles={{coat_dk2,1.2},{coat_dk,1}},
  coverage=2.2, fill=true, clip=true, length={15,40}, angle=function(x,y) if y > 270 and x > 250 then return -0.42 end return -0.05 end, pressure={0.5,0.8}, seed=5201})
-- hat
work(HATM:grow(1.2), {hand="body", tool={kind="filbert", width=5}, piles={{hat_d,1},{coat_dk2,0.5}}, coverage=2.2, fill=true, clip=true, length={8,25}, angle=0.0, seed=5202})
-- head in shadow
work(CBP.HEADM:grow(1.2) - HATM, {hand="detail", tool={kind="filbert", width=4}, piles={{skin_cd,1},{coat_dk2,0.6}}, coverage=2.5, fill=true, clip=true, length={5,12}, angle=1.4, seed=5203})
-- bandana
work(CBP.BANDM:grow(1.2) - HEADM, {hand="detail", tool={kind="filbert", width=4}, pile=band_d, coverage=2.5, fill=true, clip=true, length={5,12}, angle=0.2, seed=5204})
-- trousers and boots
local boots = LEGM * below({{0,592},{1000,592}})
work((LEGM - boots):grow(1.2) - COATM, {hand="body", tool={kind="filbert", width=5}, pile=trou_d, coverage=2.2, fill=true, clip=true, length={10,25}, angle=1.45, seed=5205})
work(boots:grow(1.2), {hand="detail", tool={kind="filbert", width=4}, piles={{coat_dk2,1},{hat_d,0.4}}, coverage=2.5, fill=true, clip=true, length={5,14}, angle=0.2, seed=5206})

--@ chunk 59
hat2 = pile{{"raw umber",1},{"bone black",1.1},{"yellow ochre",0.12},{"ultramarine blue",0.1}, name="hat2"}
face2 = pile{{"red earth",0.45},{"raw umber",1},{"bone black",0.55}, name="face2"}
band2 = pile{{"Indian red",0.7},{"bone black",0.6},{"raw umber",0.4}, name="band2"}
trou2 = pile{{"bone black",1},{"ultramarine blue",0.35},{"raw umber",0.6}, name="trou2"}
work(CBP.HATM:grow(1.2), {hand="body", tool={kind="filbert", width=5}, pile=hat2, coverage=3, fill=true, clip=true, length={8,25}, angle=0.0, seed=5302, load=0.9})
work(CBP.HEADM:grow(1.2) - CBP.HATM, {hand="detail", tool={kind="filbert", width=4}, pile=face2, coverage=3, fill=true, clip=true, length={5,12}, angle=1.4, seed=5303})
work(CBP.BANDM:grow(1.2) - CBP.HEADM, {hand="detail", tool={kind="filbert", width=4}, pile=band2, coverage=3, fill=true, clip=true, length={5,12}, angle=0.2, seed=5304})
local boots = CBP.LEGM * below({{0,592},{1000,592}})
work((CBP.LEGM - boots):grow(1.2) - COATM, {hand="body", tool={kind="filbert", width=5}, pile=trou2, coverage=3, fill=true, clip=true, length={10,25}, angle=1.45, seed=5305})

--@ chunk 60
zsuit2 = pile{{"bone black",0.8},{"raw umber",0.6},{"green earth",0.5},{"lead white",0.04}, name="zsuit2"}
zsuit_lit = pile{{"raw umber",0.6},{"yellow ochre",0.45},{"green earth",0.35},{"lead white",0.25},{"orange vermilion",0.05}, name="zsuit_lit"}
zskin_sh = pile{{"green earth",1},{"raw umber",0.5},{"bone black",0.5},{"yellow ochre",0.15},{"lead white",0.05}, name="zskin_sh"}
zskin_lit = pile{{"lead white",1},{"green earth",0.6},{"yellow ochre",0.5},{"Naples yellow",0.3},{"raw umber",0.1}, name="zskin_lit"}
ztrou = pile{{"bone black",1},{"raw umber",0.5},{"ultramarine blue",0.2},{"lead white",0.03}, name="ztrou"}
function rimw(M, ux, uy, depth)
  return function(x,y)
    if M:at(x,y) < 0.5 then return 0 end
    local s = 0
    for _, d in ipairs({depth*0.5, depth, depth*1.7}) do s = s + (1 - M:at(x+ux*d, y+uy*d)) end
    return s/3
  end
end
function lightf(x,y) local d = math.sqrt((x-470)^2+(y-243)^2); return 1/(1+(d/170)^2) end
ZALL = zombie_final()
local P = function(k) return poly(Z2[k], true) end
local headm = P("head") + P("neck") + poly(ZB.jaw,true)
local armsall = P("armn") + P("armf") + poly(ZB.arm1,true) + poly(ZB.arm2,true) + poly(ZB.arm1b,true) + poly(ZB.arm2b,true)
local fore = armsall * mask(function(x,y) return x < 700 + (y-300)*0.15 and 1 or 0 end)
local hands = P("handn") + P("handf")
local skin = (headm + fore + hands) * ZALL
local legs = (P("leg1") + P("leg2")) * below({{0,452},{1000,452}}) - P("tails")
local suit = ZALL - skin - legs
ZP = {skin=skin, legs=legs, suit=suit, head=headm*ZALL, fore=fore*ZALL, hands=hands}
local fx, fy = -0.945, -0.326
local rimF = rimw(ZALL, fx, fy, 7)
work(suit:grow(1.2) - skin, {hand="body", tool={kind="filbert", width=6}, piles={{zsuit2, 1},{zsuit_lit, function(x,y) return rimF(x,y)*lightf(x,y)*4 end}},
  coverage=2.2, fill=true, clip=true, length={12,30}, angle=function(x,y) return 1.25 + 0.15*math.sin(y/25) end, pressure={0.5,0.8}, seed=6101})
work(skin:grow(1.2), {hand="detail", tool={kind="filbert", width=4}, piles={{zskin_sh, 1},{zskin_lit, function(x,y) return rimF(x,y)*lightf(x,y)*5 end}},
  coverage=2.5, fill=true, clip=true, length={5,14}, angle=function(x,y) if x < 720 then return 0.12 end return 1.6 end, seed=6102})
work(legs:grow(1.2), {hand="body", tool={kind="filbert", width=5}, piles={{ztrou, 1},{zsuit2, 0.4}}, coverage=2.2, fill=true, clip=true, length={10,25}, angle=1.35, seed=6103})

--@ chunk 61
print(wait(3*24*60))
for _, p in ipairs({{780,380},{640,320},{770,250},{760,540},{200,400},{225,220},{240,180},{420,180},{560,330}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 62
SMOKE = {{438,226},{430,204},{442,180},{466,162},{498,150},{530,138},{566,132},{600,140},{626,160},{642,186},{652,212},{648,238},{634,262},{608,282},{576,294},{546,298},{516,292},{490,282},{466,268},{446,258}}
local keep = poly(SMOKE, true):soften(8)
local disc = ellipse(485, 244, 200, 160):soften(10)
local cover = (disc - keep) - FIG2:grow(2)
s_mid2 = mix{{s2,0.5},{s3,0.5}, name="s_mid2"}
local nz = noise{seed=511, period=90, octaves=3}
work(cover, {hand="body", tool="filbert 12", piles={
  {sky_patch, function(x,y) return clamp(1-(y-90)/120,0,1)*1.5 end},
  {s2, function(x,y) return clamp(1-math.abs(y-220)/90,0,1) + 0.15*nz(x,y) end},
  {s_mid2, function(x,y) return clamp(1-math.abs(y-320)/70,0,1) end},
  {s3, function(x,y) return clamp((y-330)/50,0,1)*1.3 end}},
  coverage=2.4, fill=true, length={30,70}, angle=function(x,y) return 0.03 + 0.08*nz(x,y) end, pressure={0.5,0.8}, clip=-FIG2:grow(1), seed=7101})

--@ chunk 63
local cx, cy = 512, 232
local nz = noise{seed=612, period=55, octaves=3}
local function d(x,y)
  local dx, dy = (x-cx)/1.35, (y-cy)
  return math.sqrt(dx*dx+dy*dy) * (1 + 0.28*nz(x,y))
end
local function dc(x,y) return math.sqrt(((x-478)/1.3)^2 + (y-243)^2) end
local region = ellipse(cx, cy, 175, 130):soften(15) - FIG2:grow(1)
work(region, {hand="body", tool="filbert 11", piles={
   {hot, function(x,y) return clamp(1-dc(x,y)/34,0,1)*3.5 end},
   {warm, function(x,y) return clamp(1-math.abs(d(x,y)-42)/24,0,1)*1.5 + clamp(1-dc(x,y)/40,0,1)*0.6 end},
   {mgray, function(x,y) return clamp(1-math.abs(d(x,y)-72)/26,0,1) end},
   {s2, function(x,y) return clamp((d(x,y)-82)/20,0,1)*2*clamp((300-y)/80,0.2,1) end},
   {s_mid2, function(x,y) return clamp((d(x,y)-82)/20,0,1)*2*clamp((y-240)/80,0,1) end}},
   coverage=2.2, fill=true, length={15,40}, angle=function(x,y) return math.atan(y-cy, x-cx) + 1.57 + 0.3*nz(x*1.5,y*1.5) end,
   curve={0.35,0.15}, pressure={0.4,0.7}, clip=-FIG2, seed=7201})

--@ chunk 64
print(wait(6*24*60))
for _, p in ipairs({{512,232},{480,243},{600,300},{400,200},{780,380},{640,320},{770,250},{225,220},{200,400},{760,540}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 65
print(wait(3*24*60))
for _, p in ipairs({{512,232},{480,243},{600,300},{400,200},{780,380},{640,320},{620,260},{770,250},{225,220},{240,190}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 66
print(wait(5*24*60))
for _, p in ipairs({{512,232},{480,243},{600,300},{400,200},{640,320},{620,260},{240,190},{350,150},{560,350}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 67
LOBES = {
 {470,222,14},{478,240,20},{500,258,18},{505,230,26},{520,192,18},{535,215,30},{540,250,24},
 {570,200,28},{575,238,22},{600,190,22},{605,222,16},
}
local cl = nil
for _, L in ipairs(LOBES) do local e = ellipse(L[1],L[2],L[3],L[3]*0.92); cl = cl and cl + e or e end
CLOUD = cl
local outer = ellipse(512,232,205,160):soften(20)
local cover = outer - CLOUD:grow(3) - FIG2:grow(1.5)
COVER = cover
print(cover:at(400,240), cover:at(520,230), cover:at(650,180), cover:at(360,240))
local nz = noise{seed=811, period=90, octaves=3}
work(cover, {hand="body", tool="filbert 10", piles={
  {sky_patch, function(x,y) return clamp(1-(y-90)/110,0,1)*1.5 end},
  {s2, function(x,y) return clamp(1-math.abs(y-215)/90,0,1) + 0.15*nz(x,y) end},
  {s_mid2, function(x,y) return clamp(1-math.abs(y-315)/70,0,1) end},
  {s3, function(x,y) return clamp((y-330)/50,0,1)*1.3 end}},
  coverage=2.6, fill=true, length={20,50}, angle=function(x,y) return 0.03 + 0.08*nz(x,y) end, pressure={0.5,0.8}, clip=cover, seed=8101})

--@ chunk 68
smoke_hot = pile{{"lead white",3},{"Naples yellow",1},{"cadmium yellow",0.6}, name="smoke_hot"}
smoke_warm = pile{{"lead white",2.5},{"yellow ochre",0.8},{"orange vermilion",0.15},{"bone black",0.05}, name="smoke_warm"}
smoke_cool = pile{{"lead white",2},{"bone black",0.25},{"Prussian blue",0.15},{"yellow ochre",0.2}, name="smoke_cool"}
smoke_sh = pile{{"lead white",0.9},{"bone black",0.3},{"Prussian blue",0.15},{"ultramarine blue",0.15},{"raw umber",0.15}, name="smoke_sh"}
local function nearest(x,y)
  local best, bi = 1e9, 1
  for i, L in ipairs(LOBES) do local d = math.sqrt((x-L[1])^2+(y-L[2])^2)/L[3]; if d < best then best, bi = d, i end end
  local L = LOBES[bi]
  local nx, ny = (x-L[1])/L[3], (y-L[2])/L[3]
  return nx, ny, L
end
local function dm(x,y) return math.sqrt(((x-460)/1.2)^2+(y-243)^2) end
local mdx, mdy = 0.944, -0.33
local nz = noise{seed=901, period=18, octaves=2}
local function moonlit(x,y) local nx, ny = nearest(x,y); return clamp((nx*mdx + ny*mdy)*1.3 + 0.25*nz(x,y),0,1) end
local function under(x,y) local nx, ny = nearest(x,y); return clamp(ny*0.9 + 0.3*nx + 0.25*nz(x,y),0,1) end
local m = CLOUD:grow(3) - FIG2:grow(1)
work(m, {hand="body", tool="filbert 7", piles={
  {smoke_hot, function(x,y) return clamp(1-dm(x,y)/42,0,1)*3 end},
  {smoke_warm, function(x,y) return clamp(1-math.abs(dm(x,y)-60)/38,0,1)*1.3*(1-0.5*under(x,y)) end},
  {smoke_cool, function(x,y) return moonlit(x,y)*clamp((dm(x,y)-50)/40,0,1)*1.6 end},
  {smoke_sh, function(x,y) return under(x,y)*clamp((dm(x,y)-40)/40,0,1)*1.4 + 0.15 end}},
  coverage=2.4, fill=true, length={8,20}, angle=function(x,y) local _,_,L = nearest(x,y); return math.atan(y-L[2], x-L[1]) + 1.57 end,
  curve={0.4,0.1}, pressure={0.45,0.75}, edge="soft", seed=9101})

--@ chunk 69
for _, p in ipairs({{780,380},{640,320},{770,250},{760,540},{700,300},{820,350}}) do print(p[1],p[2],drying(p[1],p[2])) end
zd = pile{{"bone black",1},{"raw umber",0.5},{"green earth",0.4},{"Prussian blue",0.1}, name="zd"}
zd_mid = pile{{"bone black",0.5},{"raw umber",0.6},{"green earth",0.6},{"yellow ochre",0.2},{"lead white",0.04}, name="zd_mid"}
z_warm = pile{{"raw umber",0.4},{"yellow ochre",0.7},{"orange vermilion",0.12},{"lead white",0.25},{"red earth",0.1}, name="z_warm"}
z_moon = pile{{"lead white",1},{"Prussian blue",0.12},{"green earth",0.3},{"bone black",0.12}, name="z_moon"}
zs_d = pile{{"green earth",1},{"bone black",0.45},{"raw umber",0.4}, name="zs_d"}
zs_m = pile{{"green earth",1},{"raw umber",0.3},{"yellow ochre",0.3},{"lead white",0.3},{"bone black",0.15}, name="zs_m"}
zs_l = pile{{"lead white",1},{"yellow ochre",0.5},{"green earth",0.4},{"Naples yellow",0.3},{"orange vermilion",0.06}, name="zs_l"}

--@ chunk 70
function rimdir(M, tx, ty, depths)
  return function(x,y)
    if M:at(x,y) < 0.5 then return 0 end
    local dx, dy = tx - x, ty - y
    local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
    local s = 0
    for _, k in ipairs(depths) do s = s + (1 - M:at(x+dx*k, y+dy*k)) end
    return s/#depths
  end
end
local FX, FY = 470, 243
local MX, MY = 850, 118
local Z = ZALL
local fl = rimdir(Z, FX, FY, {3,7,12,18})
local mn = rimdir(Z, MX, MY, {2,4,7})
local function fall(x,y) local d = math.sqrt((x-FX)^2+(y-FY)^2); return 1/(1+((d-100)/160)^2) end
-- coat & trousers (not skin)
local body = (ZP.suit + ZP.legs):grow(1) - ZP.skin
work(body, {hand="body", tool={kind="filbert", width=5}, piles={
  {zd, function(x,y) return 1.0 end},
  {zd_mid, function(x,y) return clamp(fl(x,y)*1.6,0,1)*0.8 end},
  {z_warm, function(x,y) return clamp(fl(x,y)*1.6-0.35,0,1)*fall(x,y)*2.5 end},
  {z_moon, function(x,y) return clamp(mn(x,y)*1.5-0.4,0,1)*1.8*(1-fl(x,y)) end}},
  coverage=2.5, fill=true, clip=true, length={8,22}, angle=function(x,y) if y > 450 then return 1.4 end return 1.25 + 0.2*math.sin(y/30) end,
  pressure={0.5,0.8}, seed=9201})
print("body done")

--@ chunk 71
local FX, FY = 470, 243
local MX, MY = 850, 118
local Z = ZALL
local fl = rimdir(Z, FX, FY, {3,6,10,15})
local mn = rimdir(Z, MX, MY, {2,4,7})
local function fall(x,y) local d = math.sqrt((x-FX)^2+(y-FY)^2); return 1/(1+((d-100)/160)^2) end
local nz = noise{seed=933, period=12, octaves=2}
work(ZP.skin:grow(1), {hand="detail", tool={kind="filbert", width=3.5}, piles={
  {zs_d, function(x,y) return 1.0 end},
  {zs_m, function(x,y) return clamp(fl(x,y)*1.5,0,1)*0.9 + 0.2*clamp(nz(x,y),0,1) end},
  {zs_l, function(x,y) return clamp(fl(x,y)*1.7-0.45,0,1)*fall(x,y)*3 end},
  {z_moon, function(x,y) return clamp(mn(x,y)*1.5-0.4,0,1)*1.5*(1-fl(x,y)) end}},
  coverage=3, fill=true, clip=true, length={4,11}, angle=function(x,y) if x < 735 then return 0.15 end return 1.3 end, seed=9301})

--@ chunk 72
wood_d = pile{{"raw umber",1},{"bone black",0.6},{"ultramarine blue",0.15},{"lead white",0.05}, name="wood_d"}
wood_l = pile{{"lead white",1},{"raw umber",0.5},{"Prussian blue",0.08},{"yellow ochre",0.2},{"bone black",0.1}, name="wood_l"}
function cross(x, base, h, lean, wbar, pw)
  local top = {x + math.sin(lean)*h, base - math.cos(lean)*h}
  local post = ribbon({{x, base+2}, {top[1], top[2]}}, pw)
  local by = 0.72
  local bc = {x + math.sin(lean)*h*by, base - math.cos(lean)*h*by}
  local ca, sa = math.cos(lean), math.sin(lean)
  local tilt = rand(-0.08, 0.08)
  local bar = ribbon({{bc[1]-ca*wbar/2, bc[2]-sa*wbar/2 + tilt*wbar}, {bc[1]+ca*wbar/2, bc[2]+sa*wbar/2 - tilt*wbar}}, pw*0.85)
  local m = (post + bar)
  work(m, {hand="detail", tool={kind="flat", width=math.max(2, pw*0.7)}, pile=wood_d, coverage=3, fill=true, clip=true, length={4,10}, angle=-1.57+lean})
  -- moonlit right edge
  local edge = m - m:offset(-1.2):shrink(0) 
  local lit = m * (m:offset(-0.1) - m:shrink(1.3)) * mask(function(px,py) return (1 - m:at(px+1.8, py-0.7)) end)
  work(lit, {hand="detail", tool={kind="round", width=1.2}, pile=wood_l, coverage=2, fill=true, clip=true, length={3,8}, angle=-1.57+lean})
  return m
end
CROSSES = {}
CROSSES[#CROSSES+1] = cross(905, 503, 48, 0.07, 28, 5)
CROSSES[#CROSSES+1] = cross(962, 499, 38, -0.13, 22, 4.5)
CROSSES[#CROSSES+1] = cross(868, 494, 28, 0.04, 16, 3.2)
CROSSES[#CROSSES+1] = cross(44, 497, 30, 0.18, 18, 3.5)
CROSSES[#CROSSES+1] = cross(992, 492, 24, 0.02, 14, 3)

--@ chunk 73
mound_d = pile{{"raw umber",1},{"bone black",0.35},{"green earth",0.3},{"ultramarine blue",0.1},{"lead white",0.12}, name="mound_d"}
mound_l = pile{{"lead white",1},{"green earth",0.35},{"yellow ochre",0.3},{"raw umber",0.3},{"Prussian blue",0.06}, name="mound_l"}
function mound(x, y, rx, ry)
  local m = (ellipse(x, y, rx, ry) * above({{0,y+ry*0.3},{1000,y+ry*0.3}})):roughen(1.5, 8, math.floor(x)):soften(1)
  m = m - FIG2:grow(1)
  work(m, {hand="detail", tool={kind="filbert", width=3}, piles={{mound_d, 1},{mound_l, function(px,py) return clamp((y-py)/ry*1.3 + (px-x)/rx*0.6 - 0.1,0,1)*1.8 end}},
    coverage=3, fill=true, clip=true, length={4,10}, angle=0.0})
end
mound(905, 506, 24, 7)
mound(962, 501, 18, 6)
mound(868, 496, 13, 4)
mound(44, 499, 15, 5)
mound(992, 494, 11, 4)
mound(935, 486, 10, 3)
mound(840, 489, 8, 2.5)

--@ chunk 74
for _, p in ipairs({{770,240},{760,260},{650,270},{620,320},{780,350}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 75
shad = pile{{"raw umber",0.8},{"bone black",0.7},{"ultramarine blue",0.45},{"green earth",0.2},{"lead white",0.1}, name="shad"}
ZSH = {{714,606},{752,601},{748,612},{738,624},{770,624},{820,614},{866,604},{890,605},{880,614},{846,628},{800,642},{752,654},{700,664},{640,667},{588,667},{604,656},{640,645},{676,634},{700,620}}
CSH = {{122,620},{186,620},{196,626},{226,628},{276,622},{332,622},{326,632},{290,646},{250,667},{60,667},{84,648},{104,632}}
local m = (poly(ZSH, true) + poly(CSH, true)):soften(3) - FIG2:grow(0.5)
work(m, {hand="body", tool={kind="filbert", width=7}, pile=shad, coverage=2.4, fill=true, clip=true, length={12,30}, angle=function(x,y) if x > 500 then return 2.6 end return 2.2 end, pressure={0.4,0.7}, edge="soft", seed=9501})

--@ chunk 76
CALL = cowboy_final()
local FX, FY = 470, 243
local fl = rimdir(CALL, FX, FY, {3,6,10,15})
local t0 = os and os.clock and os.clock() or 0
LITC = mask(function(x,y)
  if x < 50 or x > 460 or y < 140 or y > 630 then return 0 end
  return clamp(fl(x,y)*1.6 - 0.25, 0, 1)
end)
print(LITC:area())

--@ chunk 77
coat_lit2 = pile{{"raw umber",0.5},{"yellow ochre",0.6},{"red earth",0.3},{"orange vermilion",0.1},{"lead white",0.3}, name="coat_lit2"}
skin_lit = pile{{"lead white",0.6},{"red earth",0.3},{"yellow ochre",0.3},{"orange vermilion",0.15},{"Naples yellow",0.2}, name="skin_lit"}
hat_lit = pile{{"raw umber",0.6},{"yellow ochre",0.5},{"orange vermilion",0.08},{"lead white",0.25}, name="hat_lit"}
local FX, FY = 470, 243
local fl = rimdir(CALL, FX, FY, {3,6,10,15})
local function fall(x,y) local d = math.sqrt((x-FX)^2+(y-FY)^2); return clamp(1/(1+((d-80)/170)^2),0,1) end
local W = function(x,y) return clamp(fl(x,y)*1.8-0.5,0,1)*fall(x,y)*2.2 end
local coatlit = LITC * (COATM + CBP.ARMS)
work(coatlit, {hand="detail", tool={kind="filbert", width=3.5}, piles={{coat_dk, 1},{coat_lit2, W}}, coverage=2.5, fill=true, clip=COATM + CBP.ARMS, length={5,14},
  angle=function(x,y) if y < 300 and x > 240 then return -0.1 end return 1.7 end, seed=9601})
work(LITC * CBP.HEADM, {hand="detail", tool={kind="filbert", width=2.5}, piles={{face2, 1},{skin_lit, W}}, coverage=3, fill=true, clip=CBP.HEADM, length={3,8}, angle=1.5, seed=9602})
work(LITC * CBP.HATM, {hand="detail", tool={kind="filbert", width=2.5}, piles={{hat2, 1},{hat_lit, W}}, coverage=3, fill=true, clip=CBP.HATM, length={3,9}, angle=0.0, seed=9603})
work(LITC * CBP.BANDM, {hand="detail", tool={kind="filbert", width=2.5}, piles={{band2, 1},{band_d, W}}, coverage=3, fill=true, clip=CBP.BANDM, length={3,8}, angle=0.2, seed=9604})

--@ chunk 78
print(wait(2*24*60))
for _, p in ipairs({{770,240},{750,260},{650,270},{520,230},{470,240},{560,200},{225,215},{300,260}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 79
print(wait(3*24*60))
for _, p in ipairs({{770,240},{750,260},{650,270},{520,230},{470,240},{460,243},{560,200},{230,215},{350,280}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 80
print(wait(3*24*60))
for _, p in ipairs({{770,240},{750,260},{650,270},{520,230},{470,240},{460,243},{790,350},{230,215}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 81
print(wait(2*24*60))
for _, p in ipairs({{770,240},{750,260},{650,270},{470,240},{480,250},{500,240},{620,320}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 82
local mx, my, seed = MUZ.x, MUZ.y, 21
local P = function(dx, dy, c) local t = {mx+dx, my+dy}; if c then t[3] = "c" end; return t end
local o = outline{P(0,-6), P(12,-14), P(22,-24,true), P(32,-15), P(50,-19,true), P(60,-8), P(98,-2,true), P(64,5), P(80,16,true), P(52,12), P(36,23,true), P(20,12), P(0,6), closed=true, char="soft", seed=seed, amount=0.5, edge=3}
FLM2 = o:mask()
local ang = function(x,y) return math.atan(y-my, x-mx+6) end
work(FLM2, {hand="body", tool={kind="filbert", width=5, lay=2}, pile=flame_y2, coverage=2.6, fill=true, length={8,22}, angle=ang, clip=true, pressure={0.5,0.8}})
work(FLM2 - FLM2:shrink(3.5) - ellipse(mx+12, my, 26, 10), {hand="detail", tool={kind="round", width=2.5}, pile=flame_o, coverage=2, fill=true, length={4,10}, angle=ang, clip=true})
local bw = brush{kind="filbert", width=10, lay=7, stiffness=0.6}
bw:load(flame_w, 1.0)
bw:gesture({{mx+1, my, 1.0},{mx+18, my-1, 1.0},{mx+36, my, 0.6},{mx+54, my-1, 0.0}})
bw:load(flame_w, 1.0)
bw:gesture({{mx+1, my+3, 0.9},{mx+15, my+6, 0.7},{mx+28, my+9, 0.0}})
bw:gesture({{mx+1, my-3, 0.9},{mx+15, my-7, 0.7},{mx+26, my-11, 0.0}})
local sb = brush{kind="round", width=6}
sb:load(sparks, 0.8)
sb:spatter{at={mx+30, my}, toward={110, 4}, spread=0.35, force=0.5, clip=-FIG2}

--@ chunk 83
blend(FLM2:grow(4) - FLM2:shrink(5), {angle=0.0})

--@ chunk 84
face_sh = pile{{"raw umber",1},{"bone black",0.7},{"red earth",0.25},{"ultramarine blue",0.1}, name="face_sh"}
moonrim = pile{{"lead white",1},{"Prussian blue",0.15},{"bone black",0.12},{"yellow ochre",0.1}, name="moonrim"}
local H = CBP.HEADM
-- shadowed back of the head
local back = H * mask(function(x,y) return clamp((228 - x)/10, 0, 1) end)
work(back, {hand="detail", tool={kind="filbert", width=3}, pile=face_sh, coverage=2.5, fill=true, clip=H, length={4,9}, angle=1.5, seed=9701})
local r = brush{kind="round", width=2.6, point=0.8}
r:load(face_sh, 0.8)
-- ear
r:gesture({{224,210,0.5},{219,213,0.8},{218,220,0.8},{222,225,0.4}})
-- eye socket / brow shadow
r:gesture({{235,205,0.6},{240,206,0.7},{244,205,0.2}})
-- mustache, drooping
r:load(face_sh, 0.8)
r:gesture({{246,222,0.3},{242,223,0.9},{237,226,0.8},{234,231,0.3}})
-- jaw line
r:gesture({{238,238,0.2},{230,240,0.5},{222,238,0.3}})
-- lit touches along the profile
local l = brush{kind="round", width=2.2, point=0.7}
l:load(skin_lit, 0.7)
l:gesture({{246,209,0.3},{249,213,0.7},{250,218,0.4}})
l:gesture({{240,212,0.4},{243,216,0.6},{241,220,0.3}})
l:gesture({{244,229,0.4},{244,233,0.5},{241,236,0.2}})
-- brim underside catches the flash
local h = brush{kind="filbert", width=3}
h:load(hat_lit, 0.6)
h:gesture({{226,198,0.3},{248,197,0.6},{268,193,0.6},{282,186,0.2}})
-- moonlight on hat crown's right side and brim top
local m = brush{kind="round", width=2.2, point=0.6}
m:load(moonrim, 0.6)
m:gesture({{232,154,0.3},{238,160,0.6},{241,172,0.5},{242,186,0.2}})
m:gesture({{250,189,0.3},{266,186,0.5},{280,180,0.4},{285,178,0.1}})

--@ chunk 85
print(wait(3*24*60))
for _, p in ipairs({{770,240},{750,260},{650,270},{620,320},{780,380},{800,240},{200,400},{150,500},{480,243}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 86
print(wait(2*24*60))
for _, p in ipairs({{770,240},{760,230},{785,255},{480,243},{500,250}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 87
-- redraw the zombie head as a skull tilted back, face up-left
ZH = {{752,214},{768,208},{786,211},{798,222},{804,238},{802,254},{794,266},{782,276},{768,284},{758,292},{748,290},{742,282},{742,274},{738,268},{742,262},{746,258},{742,252},{737,247},{740,242},{735,238},{737,232},{741,229},{743,222}}
local hm = poly(ZH, true)
local old = poly(Z2.head, true)
print("new-old", (hm-old):area(), "old-new", (old-hm-poly(Z2.neck,true)):area())
-- base: dark skin over whole head
work(hm, {hand="detail", tool={kind="filbert", width=3}, piles={{zs_d,1},{zd,0.4}}, coverage=3, fill=true, clip=true, length={4,10}, angle=0.6, seed=9801})
-- sky back where the old head stuck out
local outside = (old - hm - poly(Z2.neck,true)) 
work(outside:grow(1) - hm, {hand="detail", tool={kind="filbert", width=3}, pile=s2, coverage=3, fill=true, clip=true, length={4,8}, angle=0.05, seed=9802})
ZHM = hm

--@ chunk 88
teeth = pile{{"lead white",1},{"yellow ochre",0.35},{"raw umber",0.2},{"green earth",0.1}, name="teeth"}
maw = pile{{"bone black",1},{"Indian red",0.4},{"raw umber",0.3}, name="maw"}
local f = brush{kind="filbert", width=4}
local r = brush{kind="round", width=2.4, point=0.8}
local function G(b, pile, ld, pts) b:load(pile, ld); b:gesture(pts, {clip=ZHM}) end
-- lit planes facing the flash (left/up-left)
G(f, zs_l, 0.6, {{746,222,0.5},{752,216,0.7},{762,212,0.5},{772,211,0.2}})      -- forehead top
G(f, zs_l, 0.6, {{742,231,0.6},{745,226,0.7},{750,221,0.4}})                     -- brow
G(f, zs_m, 0.6, {{756,226,0.4},{762,222,0.5},{770,220,0.3}})                     -- forehead turning
G(f, zs_l, 0.6, {{750,244,0.5},{755,242,0.7},{760,244,0.4}})                     -- cheekbone
G(f, zs_m, 0.5, {{758,250,0.4},{764,252,0.5},{770,256,0.3}})                     -- cheek hollow edge
G(r, zs_l, 0.6, {{737,237,0.7},{740,239,0.8},{742,242,0.4}})                     -- nose stub
G(f, zs_l, 0.5, {{741,268,0.5},{744,274,0.7},{746,281,0.6},{750,288,0.3}})        -- chin & jaw front
-- dark: eye socket, nasal hole, maw
G(r, maw, 0.8, {{746,233,0.6},{750,232,1.0},{754,234,0.8},{752,237,0.4}})
G(r, maw, 0.6, {{741,241,0.5},{743,243,0.4}})
G(f, maw, 0.9, {{740,250,0.7},{746,252,1.0},{752,256,0.9},{756,260,0.4}})
G(f, maw, 0.8, {{742,256,0.7},{748,258,0.9},{754,262,0.5}})
-- teeth: upper row, lower row
r:reload(teeth, 0.6)
for i, t in ipairs({{740,247},{743,248},{746,249},{749,250}}) do r:gesture({{t[1],t[2]-1,0.6},{t[1]+0.5,t[2]+1.5,0.3}}, {clip=ZHM}) end
for i, t in ipairs({{741,262},{744,262},{747,263},{750,264}}) do r:gesture({{t[1],t[2]+1,0.6},{t[1]+0.5,t[2]-1.5,0.3}}, {clip=ZHM}) end
-- dead eye glint
local g = brush{kind="round", width=1.6, point=0.7}
g:load(pile{{"lead white",1},{"green earth",0.25},{"yellow ochre",0.1}}, 0.5)
g:touch(749.5, 233.5, {pressure=0.5})
-- moonlit rim on top-right of skull
G(r, z_moon, 0.6, {{776,210,0.3},{788,213,0.6},{798,222,0.7},{803,236,0.5},{803,248,0.2}})

--@ chunk 89
local fl = rimdir(ZHM, 470, 243, {4,8,13,19,26})
local nz = noise{seed=991, period=10, octaves=2}
local face = ZHM * mask(function(x,y) return clamp(fl(x,y)*1.4,0,1) end)
work(face, {hand="detail", tool={kind="filbert", width=3}, piles={
   {zs_m, function(x,y) return clamp(fl(x,y)*1.5,0,1) + 0.2 end},
   {zs_d, function(x,y) return clamp(1-fl(x,y)*1.5,0,1) end},
   {zs_l, function(x,y) return clamp(fl(x,y)*2-1.1,0,1)*1.5 + clamp(nz(x,y),0,0.3) end}},
   coverage=2, fill=false, clip=ZHM, length={4,9}, angle=function(x,y) return math.atan(y-243, x-470) + 1.57 end, seed=9901})
blend(ZHM:shrink(1), {angle=0.5})

--@ chunk 90
local r = brush{kind="round", width=3, point=0.8}
local r2 = brush{kind="round", width=2, point=0.9}
local function G(b, pile, ld, pts) b:load(pile, ld); b:gesture(pts, {clip=ZHM, wobble=0.4}) end
-- eye socket: a deep dark almond under the brow
G(r, maw, 0.8, {{746,234,0.5},{750,232,0.9},{755,233,1.0},{758,236,0.6}})
G(r, maw, 0.6, {{748,237,0.5},{753,237,0.6}})
-- cheek hollow
G(r, zs_d, 0.7, {{756,247,0.4},{762,252,0.8},{766,258,0.7},{767,264,0.3}})
-- mouth cavity: open, jaw dropped
G(r, maw, 0.9, {{741,250,0.7},{746,251,1.0},{752,254,1.0},{756,258,0.6}})
G(r, maw, 0.9, {{742,255,0.8},{747,257,1.0},{752,259,0.7}})
G(r, maw, 0.7, {{743,259,0.6},{748,261,0.6}})
-- teeth tips, small
r2:reload(teeth, 0.5)
for _, t in ipairs({{742,249},{745,249.5},{748,250.5}}) do r2:touch(t[1], t[2], {pressure=0.45, drag={0.3,1.6}}) end
for _, t in ipairs({{743,262},{746,262.5}}) do r2:touch(t[1], t[2], {pressure=0.45, drag={0.3,-1.6}}) end
-- lit brow ridge and cheekbone, chin
G(r2, zs_l, 0.6, {{742,229,0.4},{746,228,0.8},{751,229,0.5}})
G(r2, zs_l, 0.6, {{749,243,0.4},{754,244,0.8},{759,246,0.4}})
G(r2, zs_l, 0.5, {{738,238,0.5},{740,241,0.7}})
G(r2, zs_l, 0.6, {{743,270,0.4},{745,276,0.8},{748,282,0.5}})
-- moonlit rim on skull back
G(r2, z_moon, 0.5, {{780,212,0.3},{791,216,0.6},{800,228,0.6},{803,242,0.3}})

--@ chunk 91
local r = brush{kind="round", width=2.6, point=0.9}
r:load(zd, 0.8)
for _, s in ipairs({{770,214,786,208,800,212},{778,220,794,218,808,226},{786,232,800,236,812,244},{790,246,804,254,812,264},{772,226,788,228,800,238}}) do
  r:gesture({{s[1],s[2],0.9},{s[3],s[4],0.6},{s[5],s[6],0.0}}, {wobble=0.6})
end
r:load(z_moon, 0.4)
r:gesture({{784,210,0.6},{796,212,0.4},{806,218,0.0}})
r:gesture({{794,226,0.5},{806,230,0.3},{814,238,0.0}})

--@ chunk 92
ichor = pile{{"bone black",1},{"green earth",0.6},{"Indian red",0.35},{"raw umber",0.3}, medium=0.45, name="ichor"}
ichor_l = pile{{"green earth",1},{"yellow ochre",0.4},{"bone black",0.3},{"lead white",0.25}, medium=0.4, name="ichor_l"}
local protect = -(CLOUD:grow(6) + FLM2:grow(4))
local b = brush{kind="round", width=8}
b:load(ichor, 0.9)
print(b:spatter{at={800, 236}, toward={95, -40}, spread=0.42, force=0.6, clip=protect})
b:load(ichor, 0.7)
print(b:spatter{at={802, 242}, toward={60, -12}, spread=0.55, force=0.3, clip=protect})
local b2 = brush{kind="round", width=5}
b2:load(ichor_l, 0.7)
print(b2:spatter{at={798, 232}, toward={80, -50}, spread=0.35, force=0.5, clip=protect})

--@ chunk 93
local protect = -(CLOUD:grow(6) + FLM2:grow(4))
local b = brush{kind="round", width=7, point=0.85}
b:load(ichor, 0.9)
local jets = {
 {{798,232,1.0},{812,226,0.8},{830,218,0.45},{852,208,0.0}},
 {{800,238,1.0},{816,234,0.75},{836,230,0.4},{860,226,0.0}},
 {{797,226,0.9},{808,218,0.6},{822,206,0.3},{836,196,0.0}},
 {{801,244,0.8},{814,244,0.5},{828,246,0.2},{840,248,0.0}},
 {{794,222,0.7},{802,212,0.4},{810,200,0.0}},
}
for i, j in ipairs(jets) do
  b:gesture(j, {wobble=1.5, clip=protect})
  if i % 2 == 0 then b:load(ichor, 0.8) end
end
local g = brush{kind="round", width=5, point=0.4}
g:load(ichor, 0.9)
for _, t in ipairs({{866,204},{874,222},{850,190},{882,212},{846,236},{892,196}}) do g:touch(t[1], t[2], {pressure=rand(0.5,0.9), drag={rand(2,5), rand(-2,0)}, clip=protect}) end

--@ chunk 94
local rr = rag{width=9}
local jets = {
 {{798,232},{812,226},{830,218},{852,208}},
 {{800,238},{816,234},{836,230},{860,226}},
 {{797,226},{808,218},{822,206},{836,196}},
 {{801,244},{814,244},{828,246},{840,248}},
 {{794,222},{802,212},{810,200}},
}
for _, j in ipairs(jets) do
  local rev = {}
  for i = #j, 1, -1 do rev[#rev+1] = {j[i][1]+3, j[i][2]} end
  local fwd = {}
  for i = 1, #j do fwd[#fwd+1] = {j[i][1]+3, j[i][2]} end
  for k = 1, 3 do rr:dip(0.95); rr:wipe(rev, {pressure={0.9,0.9}}); rr:refold(); rr:dip(0.95); rr:wipe(fwd, {pressure={0.9,0.9}}); rr:refold() end
end
for _, t in ipairs({{866,204},{874,222},{850,190},{882,212},{846,236},{892,196}}) do
  for k = 1, 2 do rr:dip(0.95); rr:blot(t[1]+2, t[2], {pressure=0.9}); rr:refold() end
end
print(rr)

--@ chunk 95
gore = pile{{"bone black",1},{"green earth",0.5},{"raw umber",0.4},{"Indian red",0.15}, medium=0.2, name="gore"}
local o = outline{{798,224},{806,219},{814,214,"c"},{816,221},{828,216,"c"},{824,226},{840,224,"c"},{828,232},{842,240,"c"},{826,239},{830,248,"c"},{816,244},{808,250},{800,246},{796,236}, closed=true, char="broken", seed=17, amount=0.7, edge=1.5}
BURST = o:mask() - ZHM:shrink(3)
work(BURST, {hand="detail", tool={kind="round", width=3}, pile=gore, coverage=3, fill=true, clip=true, length={3,8}, angle=-0.3, seed=10101})
-- a few torn shreds trailing out, short and irregular
local r = brush{kind="round", width=3.5, point=0.5}
r:load(gore, 0.8)
r:gesture({{838,226,0.8},{846,223,0.6},{851,219,0.2}}, {wobble=1})
r:gesture({{836,238,0.7},{846,240,0.5},{852,238,0.1}}, {wobble=1})
r:touch(858, 214, {pressure=0.7, drag={4,-1}})
r:touch(862, 232, {pressure=0.6, drag={3,0}})
r:touch(849, 205, {pressure=0.6, drag={2,-2}})
-- a lit edge on the burst where the flash catches it (left/top)
local l = brush{kind="round", width=1.8, point=0.8}
l:load(ichor_l, 0.5)
l:gesture({{806,219,0.5},{813,215,0.6},{818,218,0.2}})

--@ chunk 96
blend(BURST:grow(3), {angle=-0.35})
local protect = -(CLOUD:grow(6) + FLM2:grow(4) + ZHM:shrink(1))
local b = brush{kind="round", width=7}
b:load(ichor, 0.8)
print(b:spatter{at={812, 232}, toward={70, -25}, spread=0.5, force=0.25, clip=protect})
b:load(gore, 0.8)
print(b:spatter{at={815, 230}, toward={55, -30}, spread=0.6, force=0.8, clip=protect})

--@ chunk 97
local armN = (poly(Z2.armn,true)+poly(ZB.arm1,true)+poly(ZB.arm1b,true)+poly(Z2.handn,true)) * ZALL
local armF = (poly(Z2.armf,true)+poly(ZB.arm2,true)+poly(ZB.arm2b,true)+poly(Z2.handf,true)) * ZALL
local cuffN = mask(function(x,y) return x > 684 + 5*math.sin(y*1.3) + 4*math.sin(y*0.37) and 1 or 0 end)
local cuffF = mask(function(x,y) return x > 678 + 5*math.sin(y*1.1+1) + 4*math.sin(y*0.41) and 1 or 0 end)
local sleeveN = armN * cuffN * mask(function(x,y) return x < 760 and 1 or 0 end)
local sleeveF = armF * cuffF * mask(function(x,y) return x < 768 and 1 or 0 end)
local foreN = armN - cuffN
local foreF = armF - cuffF
ZARM = {sleeveN=sleeveN, sleeveF=sleeveF, foreN=foreN, foreF=foreF}
local function cN(x) return 318 + (x-615)*(16/85) end
local function cF(x) return 260 + (x-640)*(26/80) end
local function topN(x,y) return clamp((cN(x) - y)/11 + 0.5, 0, 1) end
local function topF(x,y) return clamp((cF(x) - y)/10 + 0.5, 0, 1) end
-- sleeves
work(sleeveN, {hand="detail", tool={kind="filbert", width=4}, piles={{zd,1},{zd_mid, function(x,y) return topN(x,y)*0.8 end},{z_warm, function(x,y) return clamp(topN(x,y)-0.6,0,1)*clamp((720-x)/40,0,1)*2 end}},
  coverage=3, fill=true, clip=true, length={6,16}, angle=0.2, seed=11001})
work(sleeveF, {hand="detail", tool={kind="filbert", width=4}, piles={{zd,1},{zd_mid, function(x,y) return topF(x,y)*0.8 end},{z_warm, function(x,y) return clamp(topF(x,y)-0.6,0,1)*clamp((715-x)/40,0,1)*2 end}},
  coverage=3, fill=true, clip=true, length={6,16}, angle=0.35, seed=11002})
-- forearms: bony skin
work(foreN, {hand="detail", tool={kind="filbert", width=3.5}, piles={{zs_d,1},{zs_m, function(x,y) return topN(x,y)*1.3 end},{zs_l, function(x,y) return clamp(topN(x,y)*1.6-0.9,0,1)*2 end}},
  coverage=3, fill=true, clip=true, length={5,12}, angle=0.18, seed=11003})
work(foreF, {hand="detail", tool={kind="filbert", width=3.5}, piles={{zs_d,1},{zs_m, function(x,y) return topF(x,y)*1.3 end},{zs_l, function(x,y) return clamp(topF(x,y)*1.6-0.9,0,1)*2 end}},
  coverage=3, fill=true, clip=true, length={5,12}, angle=0.32, seed=11004})

--@ chunk 98
local fb = brush{kind="filbert", width=4.6, stiffness=0.5}
local lb = brush{kind="round", width=1.8, point=0.8}
local db = brush{kind="round", width=1.6, point=0.8}
local function finger(pts)
  fb:load(zs_m, 0.7)
  fb:gesture({{pts[1][1],pts[1][2],0.95},{pts[2][1],pts[2][2],0.8},{pts[3][1],pts[3][2],0.55},{pts[4][1],pts[4][2],0.25}}, {wobble=0.3})
end
local function litedge(pts)
  lb:load(zs_l, 0.6)
  lb:gesture({{pts[1][1]-1,pts[1][2]-1.6,0.3},{pts[2][1],pts[2][2]-1.8,0.7},{pts[3][1],pts[3][2]-1.6,0.6},{pts[4][1]-0.5,pts[4][2]-0.5,0.2}})
end
local near = {
 {{612,312},{598,309},{586,311},{580,317}},
 {{612,317},{597,316},{585,319},{581,325}},
 {{612,322},{598,322},{588,326},{586,331}},
 {{613,326},{602,328},{595,332},{594,337}},
}
local far = {
 {{634,252},{620,248},{608,249},{602,254}},
 {{634,257},{619,255},{607,257},{603,263}},
 {{634,262},{620,262},{611,265},{609,270}},
 {{635,266},{624,268},{618,272},{617,277}},
}
-- back of hands first (a wedge of mid skin)
fb:load(zs_m, 0.8)
fb:gesture({{628,320,0.9},{618,318,1.0},{608,318,0.9}})
fb:gesture({{648,260,0.9},{638,258,1.0},{628,258,0.9}})
for i = #near, 1, -1 do finger(near[i]) end
for i = #far, 1, -1 do finger(far[i]) end
for _, f in ipairs(near) do litedge(f) end
for _, f in ipairs(far) do litedge(f) end
-- thumbs
fb:load(zs_d, 0.7)
fb:gesture({{620,330,0.9},{610,334,0.6},{602,336,0.2}})
fb:gesture({{642,270,0.9},{632,275,0.6},{625,277,0.2}})
-- dark nails at tips
db:load(maw, 0.6)
for _, f in ipairs(near) do db:gesture({{f[4][1]+1,f[4][2]-2,0.5},{f[4][1],f[4][2]+1,0.3}}) end
for _, f in ipairs(far) do db:gesture({{f[4][1]+1,f[4][2]-2,0.5},{f[4][1],f[4][2]+1,0.3}}) end

--@ chunk 99
for _, p in ipairs({{500,520},{900,550},{400,640},{470,600},{700,560},{150,640},{850,620}}) do print(p[1],p[2],drying(p[1],p[2])) end
gf = pile{{"lead white",1},{"green earth",0.4},{"raw umber",0.45},{"Prussian blue",0.1},{"bone black",0.18},{"yellow ochre",0.2}, name="gf"}
gm = pile{{"raw umber",1},{"green earth",0.5},{"bone black",0.35},{"ultramarine blue",0.15},{"lead white",0.12},{"yellow ochre",0.15}, name="gm"}
gd = pile{{"raw umber",1},{"bone black",0.6},{"ultramarine blue",0.3},{"green earth",0.3},{"lead white",0.04}, name="gd"}
gw = pile{{"raw umber",0.8},{"yellow ochre",0.6},{"red earth",0.15},{"lead white",0.22},{"green earth",0.2}, name="gw"}
local mounds = ellipse(905,506,26,9)+ellipse(962,501,20,8)+ellipse(868,496,15,6)+ellipse(44,499,17,7)+ellipse(992,494,13,6)+ellipse(935,486,12,5)+ellipse(840,489,10,4)
local cr = nil
for _, c in ipairs(CROSSES) do cr = cr and cr + c or c end
PROT_G = FIG2:grow(0.5) + mounds + cr:grow(1)
GROUND = below(LAND) - poly(MESA2, true) - PROT_G
print(GROUND:area())

--@ chunk 100
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
local function poolw(x,y) local dx=(x-480)/230; local dy=(y-585)/55; return clamp(1-math.sqrt(dx*dx+dy*dy),0,1) end
work(GROUND, {hand="body", tool="filbert 12", piles={
  {gf, function(x,y) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) + clamp((x-600)/300,0,1)*0.4*clamp(1-d*2.5,0,1) end},
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end},
  {gw, function(x,y) return poolw(x,y)^1.2*1.1 end}},
  coverage=2.3, fill=true, clip=GROUND, angle=function(x,y) return 0.02*math.sin(x/80) + 0.03*nz2(x,y) end,
  length={25,75}, scale_at=function(x,y) return 0.3 + 0.9*depth(y) end, pressure={0.45,0.8}, seed=12001})

--@ chunk 101
for _, p in ipairs({{200,400},{150,500},{240,300},{270,520}}) do print(p[1],p[2],drying(p[1],p[2])) end
local function xr(y) return 250 + (y-262)*(47/279) end
coat_m = pile{{"raw umber",1},{"bone black",0.45},{"red earth",0.2},{"yellow ochre",0.15},{"lead white",0.1}, name="coat_m"}
coat_moon = pile{{"raw umber",0.6},{"lead white",0.45},{"Prussian blue",0.1},{"bone black",0.2},{"yellow ochre",0.1}, name="coat_moon"}
local C = COATM
work(C, {hand="body", tool="filbert 8", piles={{coat_dk, function(x,y) return 1.2 end},{coat_m, function(x,y) return clamp(1-(xr(y)-x)/50,0,1)*0.8 end}},
  coverage=1.5, fill=true, clip=C, length={20,50}, angle=function(x,y) return 1.75 - (y-260)/1400 end, pressure={0.4,0.7}, seed=13001})
local b = brush{kind="filbert", width=11, stiffness=0.4}
local function G(p, ld, pts) b:load(p, ld); b:gesture(pts, {wobble=3, clip=C}) end
-- valleys
G(coat_dk2, 0.65, {{196,300,0.05},{160,400,0.6},{100,500,0.85},{82,545,0.9}})
G(coat_dk2, 0.65, {{210,330,0.05},{192,420,0.6},{165,500,0.85},{152,546,0.9}})
G(coat_dk2, 0.6, {{226,350,0.05},{224,430,0.55},{222,500,0.8},{220,544,0.85}})
G(coat_dk2, 0.55, {{244,380,0.05},{256,450,0.5},{268,510,0.7},{276,540,0.75}})
-- ridges catching moonlight on their right flanks
G(coat_moon, 0.45, {{206,320,0.05},{180,410,0.4},{140,500,0.6},{122,546,0.65}})
G(coat_moon, 0.45, {{220,345,0.05},{210,430,0.4},{196,500,0.6},{188,546,0.6}})
G(coat_moon, 0.4, {{236,370,0.05},{240,440,0.35},{246,505,0.5},{250,542,0.5}})

--@ chunk 102
local r1 = ribbon({{206,320},{180,410},{140,500},{122,546}}, 14)
local r2 = ribbon({{220,345},{210,430},{196,500},{188,546}}, 14)
local r3 = ribbon({{236,370},{240,440},{246,505},{250,542}}, 14)
blend((r1 + r2 + r3) * COATM, {angle=1.75})

--@ chunk 103
boot = pile{{"raw umber",1},{"bone black",0.5},{"red earth",0.35},{"lead white",0.06}, name="boot"}
boot_lit = pile{{"raw umber",0.5},{"red earth",0.35},{"yellow ochre",0.4},{"orange vermilion",0.08},{"lead white",0.3}, name="boot_lit"}
BOOTR = {{136,590},{160,596},{168,604},{176,609},{185,613},{189,620},{168,622},{132,622},{122,621},{122,613},{130,606}}
BOOTF = {{264,590},{288,592},{294,600},{306,605},{320,609},{331,614},{333,621},{300,623},{276,623},{270,612}}
local bm = poly(BOOTR, true) + poly(BOOTF, true)
BOOTS = bm
work(bm, {hand="detail", tool={kind="filbert", width=3}, pile=boot, coverage=3, fill=true, clip=true, length={4,10}, angle=0.1, seed=13101})
local r = brush{kind="round", width=2.2, point=0.8}
r:load(boot_lit, 0.6)
r:gesture({{168,605,0.3},{178,609,0.7},{186,614,0.6},{189,619,0.2}}, {clip=bm})
r:gesture({{300,606,0.3},{314,608,0.7},{326,612,0.6},{332,618,0.2}}, {clip=bm})
r:load(coat_moon, 0.5)
r:gesture({{136,592,0.3},{150,594,0.5},{160,597,0.3}}, {clip=bm})
r:gesture({{266,592,0.3},{278,591,0.5},{288,593,0.3}}, {clip=bm})
-- soles
local s = brush{kind="round", width=2.4, point=0.4}
s:load(coat_dk2, 0.7)
s:gesture({{122,621,0.6},{160,622,0.7},{189,621,0.5}})
s:gesture({{272,622,0.6},{300,623,0.7},{333,621,0.5}})
-- spurs: rowel glints at the heels
local g = brush{kind="round", width=1.6, point=0.8}
g:load(pile{{"lead white",1},{"Prussian blue",0.1},{"bone black",0.1}}, 0.5)
g:gesture({{120,612,0.5},{112,611,0.3}})
g:touch(110, 611, {pressure=0.6})
g:gesture({{268,612,0.5},{260,611,0.3}})
g:touch(258, 611, {pressure=0.6})

--@ chunk 104
local b = brush{kind="filbert", width=9, stiffness=0.5}
-- hem lobes: drop a little at ridge ends, catch moonlight on the turned edge
b:load(coat_dk, 0.7)
for _, s in ipairs({{100,544,130,550},{170,546,198,551},{232,542,256,547}}) do
  b:gesture({{s[1],s[2],0.5},{(s[1]+s[3])/2,s[4]+4,0.8},{s[3],s[2],0.4}})
end
local r = brush{kind="round", width=2.4, point=0.7}
r:load(coat_moon, 0.5)
for _, s in ipairs({{104,549,128,553},{172,551,196,554},{234,546,254,549}}) do
  r:gesture({{s[1],s[2],0.3},{(s[1]+s[3])/2,s[4]+2,0.6},{s[3],s[2],0.2}})
end

--@ chunk 105
local rr = rag{width=8}
for _, s in ipairs({{100,544,130,550},{170,546,198,551},{232,542,256,547}}) do
  for k = 1, 3 do
    rr:dip(0.95); rr:wipe({{s[1]-2,s[2]+3},{(s[1]+s[3])/2,s[4]+5},{s[3]+2,s[2]+3}}, {pressure={0.9,0.9}}); rr:refold()
  end
end
-- boots: darker, wet into wet
boot2 = pile{{"bone black",1},{"raw umber",0.8},{"red earth",0.15}, name="boot2"}
BOOTR2 = {{138,590},{160,596},{166,603},{176,608},{186,612},{191,617},{186,620},{150,620},{140,621},{140,626},{128,626},{126,616},{130,604}}
BOOTF2 = {{266,590},{288,592},{294,600},{306,605},{320,608},{332,613},{334,618},{326,620},{290,621},{282,621},{282,626},{270,626},{268,610}}
local bm = poly(BOOTR2, true) + poly(BOOTF2, true)
work(bm + BOOTS, {hand="detail", tool={kind="filbert", width=3}, pile=boot2, coverage=3.5, fill=true, clip=true, length={4,10}, angle=0.1, seed=13201})

--@ chunk 106
local legs = CBP.LEGM - COATM
local under = legs * below({{0,543},{1000,543}}) * above({{0,562},{1000,562}})
work(under:grow(0.5) * legs, {hand="detail", tool={kind="filbert", width=3}, piles={{trou2,1},{coat_dk2,0.8}}, coverage=3.5, fill=true, clip=legs, length={4,9}, angle=0.0, seed=13301})
local gnd = (ellipse(115,553,16,6) + ellipse(200,552,8,5)) - legs - COATM
work(gnd, {hand="detail", tool={kind="filbert", width=3}, piles={{gm,1},{gd,0.4}}, coverage=3.5, fill=true, clip=gnd:grow(1) - legs - COATM, length={4,9}, angle=0.0, seed=13302})

--@ chunk 107
local legs = CBP.LEGM - COATM
blend(legs * below({{0,552},{1000,552}}) * above({{0,585},{1000,585}}), {angle=1.45})
local spots = ellipse(199,553,9,6) + ellipse(229,548,6,4) + ellipse(118,553,14,5)
local gnd = spots - legs:grow(0.5) - COATM
work(gnd, {hand="detail", tool={kind="round", width=2.5}, piles={{gm,1},{gd,0.5}}, coverage=4, fill=true, clip=gnd, length={3,7}, angle=0.0, seed=13401})

--@ chunk 108
GUN = {
 barrel = {{404,237},{450,237.5},{452,239},{452,246},{432,246.5},{432,250},{404,250}},
 cyl = {{389,236},{406,235},{408,239},{408,250},{406,253},{389,253}},
 frame = {{380,236},{390,235},{392,253},{384,254},{380,248}},
 hammer = {{378,239},{376,233},{379,230},{384,231},{386,236}},
 guard = {{390,252},{402,252},{404,257},{400,263},{393,263},{390,258}},
 grip = {{380,250},{390,252},{388,266},{384,280},{374,282},{372,272},{376,260}},
 sight = {{445,234.5},{449,234.5},{449,238},{445,238}},
}
local gm_ = nil
for _, k in ipairs({"barrel","cyl","frame","hammer","guard","grip","sight"}) do local p = poly(GUN[k], false); gm_ = gm_ and gm_ + p or p end
GUNM = gm_
HANDR = {{350,246},{362,240},{376,239},{386,242},{390,249},{392,256},{392,264},{388,272},{380,277},{368,277},{358,272},{352,262}}
HANDM = poly(HANDR, true)
local old = poly(C2.hand,true)+poly(CB.hand,true)+poly(C2.gun,false)+poly(CB.gun,true)+poly(CB.gun2,false)+poly(C2.grip,true)
-- far (supporting) hand: cupped under, from the far forearm
FARH = {{364,262},{376,258},{388,262},{394,270},{392,280},{384,286},{372,286},{364,280},{360,272}}
FARHM = poly(FARH, true)
local keep = GUNM + HANDM + FARHM + CBP.ARMS + COATM
local sky = old - keep
print("sky to restore", sky:area())
work(sky:grow(1) - keep, {hand="detail", tool={kind="filbert", width=3}, piles={{s2,1},{s_mid2,0.4}}, coverage=3.5, fill=true, clip=sky:grow(1) - keep, length={3,8}, angle=0.05, seed=14001})
gunm2 = pile{{"bone black",1},{"Prussian blue",0.25},{"raw umber",0.3},{"lead white",0.03}, name="gunm2"}
hand_d = pile{{"raw umber",1},{"red earth",0.35},{"bone black",0.35},{"lead white",0.04}, name="hand_d"}
work(GUNM, {hand="detail", tool={kind="round", width=2.4}, pile=gunm2, coverage=3.5, fill=true, clip=true, length={3,8}, angle=0.0, seed=14002})
work(FARHM - HANDM - GUNM, {hand="detail", tool={kind="round", width=2.4}, pile=face_sh, coverage=3.5, fill=true, clip=true, length={3,8}, angle=0.5, seed=14003})
work(HANDM - GUNM*poly(GUN.barrel,false), {hand="detail", tool={kind="round", width=2.4}, pile=hand_d, coverage=3.5, fill=true, clip=true, length={3,8}, angle=0.3, seed=14004})

--@ chunk 109
for _, p in ipairs({{300,640},{700,640},{760,610},{150,630}}) do print(p[1],p[2],drying(p[1],p[2])) end
ZSH2 = {{716,604},{752,600},{756,606},{748,614},{770,618},{820,610},{866,603},{890,604},{886,612},{850,626},{800,640},{752,652},{700,664},{650,667},{604,667},{620,656},{652,644},{684,630},{704,616}}
CSH2 = {{124,622},{188,620},{200,624},{230,626},{276,624},{334,621},{330,630},{296,644},{256,667},{70,667},{92,648},{110,632}}
local m = (poly(ZSH2, true) + poly(CSH2, true)):soften(4) - FIG2:grow(0.5) - BOOTS - poly(BOOTR2,true) - poly(BOOTF2,true)
work(m, {hand="body", tool={kind="filbert", width=7}, piles={{shad,1},{gd,0.5}}, coverage=2, fill=true, clip=m:grow(2) - FIG2 - BOOTS - poly(BOOTR2,true) - poly(BOOTF2,true), length={12,30}, angle=function(x,y) if x > 500 then return 2.6 end return 2.2 end, pressure={0.4,0.7}, seed=14101})

--@ chunk 110
local mounds = ellipse(905,506,26,9)+ellipse(962,501,20,8)+ellipse(868,496,15,6)+ellipse(44,499,17,7)+ellipse(992,494,13,6)+ellipse(935,486,12,5)+ellipse(840,489,10,4)
local inner = nil
for _, t in ipairs({{905,506,24,7},{962,501,18,6},{868,496,13,4},{44,499,15,5},{992,494,11,4},{935,486,10,3},{840,489,8,2.5}}) do
  local e = ellipse(t[1], t[2], t[3], t[4]) * above({{0,t[2]+t[4]*0.3},{1000,t[2]+t[4]*0.3}})
  inner = inner and inner + e or e
end
local cr = nil
for _, c in ipairs(CROSSES) do cr = cr and cr + c or c end
local ring = (mounds:grow(2) - inner - cr:grow(0.5) - FIG2) * below(LAND)
work(ring, {hand="detail", tool={kind="round", width=2.5}, piles={{gf,1},{gm,0.6}}, coverage=3.5, fill=true, clip=ring, length={3,8}, angle=0.0, seed=14201})

--@ chunk 111
ztrou2 = pile{{"bone black",1},{"raw umber",0.7},{"green earth",0.25},{"ultramarine blue",0.15}, name="ztrou2"}
local legs = ZP.legs
local MX, MY = 850, 118
local mn = rimdir(ZALL, MX, MY, {2,4,7})
local fl = rimdir(ZALL, 470, 243, {3,6,10})
work(legs, {hand="detail", tool={kind="filbert", width=4}, piles={
  {ztrou2, 1},
  {z_moon, function(x,y) return clamp(mn(x,y)*1.6-0.5,0,1)*0.9 end},
  {zd_mid, function(x,y) return clamp(fl(x,y)*1.5-0.4,0,1)*0.7 end}},
  coverage=3, fill=true, clip=legs, length={6,16}, angle=function(x,y) if x < 790 then return 1.85 end return 1.2 end, seed=14301})

--@ chunk 112
local mounds = ellipse(905,506,26,9)+ellipse(962,501,20,8)+ellipse(868,496,15,6)+ellipse(44,499,17,7)+ellipse(992,494,13,6)+ellipse(935,486,12,5)+ellipse(840,489,10,4)
local inner = nil
for _, t in ipairs({{905,506,24,7},{962,501,18,6},{868,496,13,4},{44,499,15,5},{992,494,11,4},{935,486,10,3},{840,489,8,2.5}}) do
  local e = ellipse(t[1], t[2], t[3], t[4]) * above({{0,t[2]+t[4]*0.3},{1000,t[2]+t[4]*0.3}})
  inner = inner and inner + e or e
end
MOUNDS_IN = inner
local cr = nil
for _, c in ipairs(CROSSES) do cr = cr and cr + c or c end
CROSSM = cr
local zone = (mounds:grow(6) - inner:shrink(0) - cr:grow(0.5) - FIG2:grow(1)) * below(LAND)
blend(zone, {angle=0.0})
-- ankles and feet
local r = brush{kind="round", width=2.4, point=0.8}
local function G(p, ld, pts) r:load(p, ld); r:gesture(pts) end
-- front foot (left): ragged cuff + bony ankle
G(zd, 0.8, {{728,586,0.6},{734,590,0.8},{740,588,0.6},{746,592,0.4}})
G(zs_m, 0.6, {{736,592,0.5},{738,598,0.7},{735,603,0.4}})
G(zs_d, 0.7, {{716,604,0.5},{726,602,0.8},{740,603,0.7},{750,601,0.4}})
G(zs_l, 0.5, {{718,601,0.3},{726,599,0.5},{734,599,0.3}})
-- rear foot (right)
G(zd, 0.8, {{852,582,0.6},{858,586,0.8},{864,584,0.6},{870,589,0.4}})
G(z_moon, 0.5, {{864,588,0.4},{868,594,0.6},{870,599,0.3}})
G(zs_d, 0.7, {{862,604,0.5},{872,606,0.8},{884,605,0.7},{890,603,0.4}})

--@ chunk 113
print(drying(820,230), drying(835,240))
local rr = rag{width=10}
local paths = {
 {{800,222},{820,218},{844,222}}, {{800,230},{822,228},{846,232}}, {{800,238},{822,238},{846,242}},
 {{800,246},{820,246},{836,250}}, {{806,214},{816,210},{830,214}}, {{826,220},{838,226},{846,236}},
}
for k = 1, 3 do
  for _, p in ipairs(paths) do
    rr:dip(0.95); rr:wipe(p, {pressure={0.9,0.9}}); rr:refold()
    local rev = {}
    for i = #p, 1, -1 do rev[#rev+1] = p[i] end
    rr:dip(0.95); rr:wipe(rev, {pressure={0.9,0.9}}); rr:refold()
  end
end
print(rr)

--@ chunk 114
local rr = rag{width=14}
for k = 1, 3 do
  for x = 804, 846, 6 do
    rr:dip(0.95); rr:wipe({{x,208},{x+2,232},{x,256}}, {pressure={0.95,0.95}}); rr:refold()
  end
end
rr = rag{width=12}
for k = 1, 2 do
  for _, y in ipairs({214,222,230,238,246}) do
    rr:dip(0.95); rr:wipe({{850,y},{826,y},{804,y}}, {pressure={0.95,0.95}}); rr:refold()
  end
end

--@ chunk 115
-- ragged exit wound at the back of the skull
local o = outline{{794,224},{800,226},{806,229,"c"},{803,233},{808,237,"c"},{802,240},{805,246,"c"},{798,246},{792,242},{790,234}, closed=true, char="broken", seed=23, amount=0.6, edge=1}
EXIT = o:mask()
work(EXIT, {hand="detail", tool={kind="round", width=2.4}, piles={{maw,1},{gore,0.5}}, coverage=3.5, fill=true, clip=true, length={3,6}, angle=-0.4, seed=15001})
local protect = -(CLOUD:grow(6) + FLM2:grow(4) + ZHM:shrink(2))
local b = brush{kind="round", width=7}
b:load(ichor, 0.9)
print(b:spatter{at={804, 234}, toward={45, -18}, spread=0.35, force=0.2, clip=protect})
b:load(ichor, 0.8)
print(b:spatter{at={804, 234}, toward={75, -30}, spread=0.3, force=0.55, clip=protect})
b:load(gore, 0.8)
print(b:spatter{at={804, 232}, toward={35, -14}, spread=0.45, force=0.35, clip=protect})
-- bone fragments
local g = brush{kind="round", width=1.8, point=0.6}
g:load(teeth, 0.5)
for _, t in ipairs({{816,226},{829,220},{822,236},{841,214}}) do g:touch(t[1], t[2], {pressure=0.55, drag={1.5,-0.6}, clip=protect}) end

--@ chunk 116
local r = brush{kind="round", width=2.2, point=0.7}
r:load(pile{{"bone black",1},{"raw umber",0.3}}, 0.7)
r:gesture({{797,230,0.6},{800,235,0.9},{798,241,0.5}}, {clip=EXIT})

--@ chunk 117
print(drying(370,265), drying(380,255), drying(420,243))
local rr = rag{width=10}
local paths = {
 {{346,258},{372,258},{396,260}}, {{346,266},{372,266},{396,268}}, {{348,274},{372,274},{396,276}},
 {{350,282},{372,282},{396,284}}, {{356,290},{376,290},{394,290}}, {{348,250},{360,248},{372,250}},
}
for k = 1, 3 do
  for _, p in ipairs(paths) do
    rr:dip(0.95); rr:wipe(p, {pressure={0.9,0.9}}); rr:refold()
  end
  for x = 350, 394, 7 do rr:dip(0.95); rr:wipe({{x,252},{x,272},{x,292}}, {pressure={0.9,0.9}}); rr:refold() end
end

--@ chunk 118
print(wait(7*24*60))
for _, p in ipairs({{370,265},{380,285},{420,243},{800,235},{300,640},{700,640},{720,600},{850,590},{620,320},{905,500}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 119
-- gun hand: gloved fist wrapped round the grip (drawn to sit around the grip, below the cylinder)
FIST = {{352,247},{362,243},{372,242},{380,246},{384,252},{390,256},{392,262},{390,270},{384,274},{374,276},{364,275},{356,270},{352,262}}
SUPP = {{366,268},{378,268},{388,270},{392,276},{388,284},{378,287},{368,285},{362,279}}
FISTM = poly(FIST, true) + poly(SUPP, true)
-- sky to repaint around: the smear zone minus arm, gun, fist
local zone = rect(338, 236, 70, 66) - FISTM - GUNM - CBP.ARMS
local cleanup = zone * mask(function(x,y) return 1 end)
work(cleanup, {hand="detail", tool={kind="filbert", width=4}, piles={{s2,1},{s_mid2,function(x,y) return clamp((y-240)/80,0,1) end}}, coverage=3.5, fill=true, clip=cleanup, length={4,10}, angle=0.05, seed=16001})
glove = pile{{"raw umber",1},{"bone black",0.6},{"red earth",0.2},{"yellow ochre",0.1}, name="glove"}
glove_lit = pile{{"raw umber",0.5},{"yellow ochre",0.6},{"red earth",0.25},{"orange vermilion",0.1},{"lead white",0.35}, name="glove_lit"}
work(FISTM - GUNM, {hand="detail", tool={kind="round", width=2.4}, pile=glove, coverage=3.5, fill=true, clip=FISTM - GUNM, length={3,7}, angle=0.4, seed=16002})

--@ chunk 120
glove2 = pile{{"bone black",1},{"raw umber",0.9},{"red earth",0.15}, name="glove2"}
work(FISTM - GUNM, {hand="detail", tool={kind="round", width=2.4}, pile=glove2, coverage=4, fill=true, clip=FISTM - GUNM, length={3,7}, angle=0.4, seed=16003})
local r = brush{kind="round", width=2.2, point=0.8}
local function G(p, ld, pts, cl) r:load(p, ld); r:gesture(pts, {clip=cl or FISTM}) end
-- knuckles & front of fist catching the flash
G(glove_lit, 0.6, {{376,246,0.3},{383,250,0.7},{389,256,0.8},{391,263,0.5}})
G(glove_lit, 0.5, {{385,265,0.3},{389,270,0.6},{386,275,0.3}})
G(glove_lit, 0.5, {{386,276,0.3},{390,280,0.6},{386,285,0.3}})
-- finger divisions
G(glove2, 0.7, {{378,258,0.5},{386,259,0.7}})
G(glove2, 0.7, {{377,265,0.5},{386,266,0.7}})
G(glove2, 0.7, {{374,272,0.5},{384,274,0.6}})
-- trigger finger along the guard
G(glove2, 0.8, {{386,254,0.7},{394,255,0.8},{398,258,0.4}}, FISTM + poly(GUN.guard,false):grow(2))
G(glove_lit, 0.5, {{388,253,0.3},{394,253.5,0.5},{397,256,0.2}}, FISTM + poly(GUN.guard,false):grow(2))
-- cuff of the glove (gauntlet) at the wrist
G(glove_lit, 0.4, {{356,248,0.3},{358,258,0.5},{357,268,0.3}})

--@ chunk 121
local box = rect(338, 236, 70, 66)
local seam = (box:grow(8) - box:shrink(8)) - FISTM:grow(2) - GUNM:grow(2) - CBP.ARMS:grow(2) - COATM:grow(2)
blend(seam, {angle=0.05})
blend(seam, {angle=1.5})

--@ chunk 122
print(wait(8*24*60))
for _, p in ipairs({{370,265},{360,290},{420,243},{800,235},{300,640},{700,640},{720,600},{150,600},{200,400},{780,380},{620,320},{180,500}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 123
cglaze = pile{{"bone black",0.6},{"raw umber",0.8},{"ultramarine blue",0.3}, medium=0.78, name="cglaze"}
local function xr(y) return 250 + (y-262)*(47/279) end
local C = COATM - FISTM - GUNM
local back = C * mask(function(x,y) return clamp((xr(y) - 28 - x)/20, 0, 1) end)
work(back, {hand="glaze", pile=cglaze, coverage=1.5, fill=true, angle=1.7, clip=C})
local backer = C * mask(function(x,y) return clamp((xr(y) - 70 - x)/25, 0, 1) end)
work(backer, {hand="glaze", pile=cglaze, coverage=1.0, fill=true, angle=1.7, clip=C})
-- boots
local bm = BOOTS + poly(BOOTR2,true) + poly(BOOTF2,true)
work(bm, {hand="glaze", tool={kind="filbert", width=6, stiffness=0.3}, pile=cglaze, coverage=2, fill=true, angle=0.1, clip=bm})

--@ chunk 124
hair = pile{{"bone black",1},{"raw umber",0.8},{"yellow ochre",0.12}, name="hair"}
hair_l = pile{{"raw umber",1},{"bone black",0.3},{"yellow ochre",0.3},{"lead white",0.12}, name="hair_l"}
local r = brush{kind="round", width=3.2, point=0.85}
local hm = poly({{198,197},{216,198},{218,206},{215,214},{214,224},{216,236},{214,248},{206,252},{198,250},{196,230}}, true)
work(hm, {hand="detail", tool={kind="round", width=3}, pile=hair, coverage=3, fill=true, clip=hm, length={6,14}, angle=1.65, seed=17001})
r:load(hair, 0.8)
for i, s in ipairs({{200,198,197,226,195,250},{205,198,203,228,200,254},{210,199,209,226,206,252},{214,200,213,224,211,248},{203,205,199,232,197,256}}) do
  r:gesture({{s[1],s[2],0.9},{s[3],s[4],0.8},{s[5],s[6],0.0}}, {wobble=0.8})
end
r:load(hair_l, 0.5)
for i, s in ipairs({{208,203,206,228,204,248},{213,204,212,224,210,242}}) do
  r:gesture({{s[1],s[2],0.4},{s[3],s[4],0.5},{s[5],s[6],0.0}}, {wobble=0.6})
end
-- the ear again in front of the hair
local e = brush{kind="round", width=2.4, point=0.8}
e:load(face2, 0.7)
e:gesture({{221,209,0.5},{218,213,0.9},{218,220,0.9},{221,225,0.5}})
e:load(skin_lit, 0.4)
e:gesture({{222,211,0.3},{223,216,0.5},{222,222,0.2}})

--@ chunk 125
for _, p in ipairs({{300,290},{340,280},{360,262},{395,268},{330,300},{345,250}}) do print(p[1],p[2],drying(p[1],p[2])) end
local farm = (poly(C2.farm,true) + poly(CB.fan,true)) - poly(C2.arm,true) - poly(CB.arm,true) - FISTM - GUNM
print(farm:area())

--@ chunk 126
local nearArm = (poly(C2.arm,true) + poly(CB.arm,true)) - COATM
local farm = ((poly(C2.farm,true) + poly(CB.fan,true)) - nearArm - FISTM - GUNM) * mask(function(x,y) return x > 225 and 1 or 0 end)
FARM = farm
NEARARM = nearArm - FISTM - GUNM
sleeve_m = pile{{"raw umber",1},{"bone black",0.55},{"red earth",0.2},{"yellow ochre",0.12},{"lead white",0.05}, name="sleeve_m"}
-- far arm: dark sleeve, warming toward the hands
work(farm, {hand="detail", tool={kind="filbert", width=4}, piles={{coat_dk2,1},{sleeve_m, function(x,y) return clamp((x-290)/80,0,1)*0.9 end}},
  coverage=3.5, fill=true, clip=farm, length={8,20}, angle=-0.42, seed=17101})
-- a single warm edge along the far forearm's upper side where it shows under the near arm
local r = brush{kind="round", width=2.4, point=0.7}
r:load(glove_lit, 0.5)
r:gesture({{300,292,0.1},{330,280,0.4},{352,271,0.6},{364,266,0.3}}, {clip=farm:grow(1)})
-- near arm underside: thin warm reflected edge toward the hand
r:load(sleeve_m, 0.6)
r:gesture({{290,276,0.1},{320,272,0.5},{350,268,0.6}}, {clip=NEARARM})

--@ chunk 127
local ring = (FISTM:grow(3.5) - FISTM:shrink(0.3)) - GUNM - NEARARM - FARM - COATM - FISTM
work(ring, {hand="detail", tool={kind="round", width=2}, piles={{s2,1},{s_mid2,0.4}}, coverage=4, fill=true, clip=ring, length={2,5}, angle=0.0, seed=17201})

--@ chunk 128
local wrist = poly({{344,246},{356,244},{362,248},{362,270},{356,276},{344,276}}, true) - GUNM
work(wrist, {hand="detail", tool={kind="round", width=2.4}, piles={{glove2,1},{coat_dk2,0.5}}, coverage=4, fill=true, clip=wrist, length={3,7}, angle=1.5, seed=17301})
FISTM = FISTM + wrist

--@ chunk 129
print(wait(6*24*60))
for _, p in ipairs({{345,295},{400,290},{370,265},{360,240},{230,230},{300,280},{205,225}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 130
local prot = FIG2:grow(1.5) + FISTM:grow(1.5) + GUNM:grow(1.5) + FARM:grow(1.5) + CLOUD:grow(4) + FLM2:grow(4)
local zone = ellipse(372, 272, 80, 58):soften(18) - prot
local nz = noise{seed=1801, period=40, octaves=3}
work(zone, {hand="body", tool="filbert 9", piles={
  {s2, function(x,y) return 1 + 0.3*nz(x,y) end},
  {s_mid2, function(x,y) return clamp((y-250)/60,0,1)*0.7 + clamp(-nz(x,y),0,1)*0.3 end},
  {sky_patch, function(x,y) return clamp((250-y)/40,0,1)*0.4 + clamp(nz(x,y),0,1)*0.25 end}},
  coverage=2, fill=true, clip=-prot, edge="lost", length={15,40}, angle=function(x,y) return 0.03 + 0.1*nz(x*1.3,y*1.3) end, pressure={0.4,0.7}, seed=18001})

--@ chunk 131
local function edgeband(M, dx, dy, d)
  return mask(function(x,y)
    local a = M:at(x,y)
    if a < 0.5 then return 0 end
    return clamp((1 - M:at(x+dx*d, y+dy*d)) + 0.5*(1 - M:at(x+dx*d*1.8, y+dy*d*1.8)), 0, 1)
  end)
end
local ux, uy = 0.29, -0.96
local ZR = edgeband(ZALL, ux, uy, 3) * mask(function(x,y) return x > 742 and 1 or 0 end) - ZHM:shrink(1) - EXIT
ZRIM = ZR
print("zrim area", ZR:area())
local CR = edgeband(cowboy_final(), 0.55, -0.83, 2.5) * mask(function(x,y) return (y < 300 and x > 160) and 1 or 0 end) - CBP.HEADM - FISTM - GUNM
CRIM = CR
print("crim area", CR:area())

--@ chunk 132
for _, p in ipairs({{812,302},{830,320},{760,295},{300,248},{240,250}}) do print(p[1],p[2],drying(p[1],p[2])) end
moon_rim2 = pile{{"lead white",1},{"Prussian blue",0.12},{"green earth",0.2},{"bone black",0.1},{"raw umber",0.08}, name="moon_rim2"}
moon_rimc = pile{{"lead white",0.8},{"Prussian blue",0.12},{"raw umber",0.3},{"bone black",0.12}, name="moon_rimc"}
work(ZRIM, {hand="detail", tool={kind="round", width=2}, piles={{moon_rim2, function(x,y) return clamp(1-(y-290)/200,0.15,1) end},{zd, function(x,y) return clamp((y-330)/150,0,1) end}},
  coverage=2, fill=false, clip=ZRIM, length={4,12}, angle=function(x,y) return 1.2 end, pressure={0.3,0.6}, seed=19001})
work(CRIM, {hand="detail", tool={kind="round", width=2}, pile=moon_rimc, coverage=1.6, fill=false, clip=CRIM, length={4,12}, angle=-0.05, pressure={0.3,0.6}, seed=19002})

--@ chunk 133
local z = ZRIM:grow(2.5) * ZALL:grow(1)
blend(z, {angle=1.25})

--@ chunk 134
local k = knife{width=10}
local path = {{786,262},{796,282},{812,298},{828,316},{836,340},{836,370},{832,400},{826,425},{818,448},{826,470},{840,486}}
local function off(p, d)
  local o = {}
  for i = 1, #p do
    local a = p[math.max(1,i-1)]; local b = p[math.min(#p,i+1)]
    local tx, ty = b[1]-a[1], b[2]-a[2]; local L = math.sqrt(tx*tx+ty*ty)
    o[i] = {p[i][1] - ty/L*d, p[i][2] + tx/L*d}
  end
  return o
end
for _, d in ipairs({-2, 3, 8}) do
  k:scrape(off(path, d), {pressure=1})
  k:wipe()
end
-- neck/shoulder rim pieces near arm
k:scrape({{742,300},{760,292},{776,290}}, {pressure=1}); k:wipe()
k:scrape({{744,306},{760,298},{778,294}}, {pressure=1}); k:wipe()

--@ chunk 135
print(wait(3*24*60))
for _, p in ipairs({{837,360},{830,330},{300,248},{240,170},{270,186}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 136
print(wait(2*24*60))
for _, p in ipairs({{300,248},{240,170},{330,247},{250,250}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 137
zglaze = pile{{"bone black",0.8},{"green earth",0.5},{"raw umber",0.6},{"Prussian blue",0.1}, medium=0.75, name="zglaze"}
local side = mask(function(x,y) return x > 742 and 1 or 0 end) - ZHM:grow(2) - EXIT:grow(2)
local inner = (ZALL:shrink(1.6) - ZALL:shrink(8)) * side
local outer = (ZALL - ZALL:shrink(1.6)) * side
local tool = {kind="filbert", width=4, stiffness=0.3}
work(inner, {hand="glaze", tool=tool, pile=zglaze, coverage=2.5, fill=true, clip=inner, angle=1.25, length={10,30}, seed=19101})
work(outer, {hand="glaze", tool=tool, pile=zglaze, coverage=1.0, fill=true, clip=outer, angle=1.25, length={10,30}, seed=19102})

--@ chunk 138
local CF = cowboy_final() + FISTM + GUNM
local band = CRIM:grow(2.5) * CF - CBP.HEADM - FISTM - GUNM
local inner = band * CF:shrink(1.4)
local outer = band - CF:shrink(1.4)
local tool = {kind="filbert", width=4, stiffness=0.3}
work(inner, {hand="glaze", tool=tool, pile=cglaze, coverage=2.5, fill=true, clip=inner, angle=-0.05, length={10,30}, seed=19201})
work(outer, {hand="glaze", tool=tool, pile=cglaze, coverage=0.8, fill=true, clip=outer, angle=-0.05, length={10,30}, seed=19202})

--@ chunk 139
HAT2crown = {{203,190},{202,178},{204,167},{208,159},{214,156},{221,159},{229,156},{236,158},{240,166},{242,178},{242,190}}
local newc = poly(HAT2crown, true)
local brim = poly(HAT.brim, true)
local oldc = poly(CB.crown,true) + poly(CB.crown2,true) + poly(C2.crown,true) + poly(HAT.crown,true)
local region = ((oldc:grow(5) + CRIM:grow(4)) * above({{0,186},{1000,186}}) * mask(function(x,y) return (x > 190 and x < 256) and 1 or 0 end)) - newc - brim
work(region, {hand="detail", tool={kind="filbert", width=3, lay=2.5}, pile=sky_patch, coverage=4, fill=true, clip=region, length={3,8}, angle=0.05, load=1.0, seed=20001})
work(newc, {hand="detail", tool={kind="filbert", width=3.5}, pile=hat2, coverage=4, fill=true, clip=newc, length={5,12}, angle=1.5, seed=20002})
-- crease shadow and moonlit right flank
local r = brush{kind="round", width=2.2, point=0.8}
r:load(coat_dk2, 0.6)
r:gesture({{221,161,0.6},{222,170,0.5},{221,178,0.2}}, {clip=newc})
r:load(moon_rimc, 0.5)
r:gesture({{230,158,0.2},{237,161,0.6},{241,170,0.6},{242,182,0.3}}, {clip=newc})
-- hat band
r:load(coat_dk2, 0.8)
r:gesture({{203,186,0.7},{222,187,0.8},{242,186,0.7}}, {clip=newc})

--@ chunk 140
sky_dk = mix{{sky_patch,0.55},{s1,0.45}, name="sky_dk"}
local newc = poly(HAT2crown, true)
local brim = poly(HAT.brim, true)
local oldc = poly(CB.crown,true) + poly(CB.crown2,true) + poly(C2.crown,true) + poly(HAT.crown,true)
local region = ((oldc:grow(7) + CRIM:grow(5)) * above({{0,184},{1000,184}}) * mask(function(x,y) return (x > 188 and x < 258) and 1 or 0 end)) - newc:grow(0.8) - brim:grow(0.8)
work(region, {hand="detail", tool={kind="filbert", width=3}, piles={{sky_dk, function(x,y) return clamp((175-y)/30,0.3,1) end},{sky_patch, function(x,y) return clamp((y-150)/30,0,1) end}}, coverage=3, fill=true, clip=region, length={3,8}, angle=0.05, seed=20101})
blend(region:grow(4) - newc:grow(1) - brim:grow(1), {angle=0.05})

--@ chunk 141
for _, p in ipairs({{300,290},{330,282},{280,300},{320,262},{240,300}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 142
-- far arm ochre streaks still open: knock them back by working dark sleeve paint wet-into-wet along the arm
local farm = FARM
work(farm, {hand="detail", tool={kind="filbert", width=4}, piles={{coat_dk2,1},{sleeve_m, function(x,y) return clamp((x-320)/60,0,1)*0.6 end}},
  coverage=2.5, fill=true, clip=farm, length={10,24}, angle=-0.42, seed=20201})
-- the lit stripe along the near arm's underside: a single subdued warm line only near the hand
local under = NEARARM * mask(function(x,y) return 1 end)
local r = brush{kind="round", width=2.2, point=0.7}
r:load(sleeve_m, 0.5)
r:gesture({{320,268,0.1},{338,266,0.4},{352,264,0.5}}, {clip=NEARARM})

--@ chunk 143
for _, p in ipairs({{330,276},{300,282},{350,272},{260,296},{250,305}}) do
  print(p[1],p[2], "near", NEARARM:at(p[1],p[2]), "far", FARM:at(p[1],p[2]), "coat", COATM:at(p[1],p[2]), "fig", FIG2:at(p[1],p[2]), drying(p[1],p[2]))
end

--@ chunk 144
local strip = COATM * rect(252,255,125,52) - NEARARM - FISTM - GUNM
print(strip:area())
work(strip, {hand="detail", tool={kind="filbert", width=3.5}, piles={{coat_dk2,1},{coat_dk,0.6}}, coverage=3.5, fill=true, clip=strip, length={8,20}, angle=-0.3, seed=20301})
local r = brush{kind="round", width=2, point=0.7}
r:load(sleeve_m, 0.45)
r:gesture({{300,284,0.1},{330,276,0.35},{356,270,0.4},{366,266,0.1}}, {clip=strip:grow(0.5)})

--@ chunk 145
local k = knife{width=14}
for y = 128, 186, 6 do
  k:scrape({{184,y},{222,y},{262,y}}, {pressure=1})
  k:wipe()
end
skymatch = mix{{s1,0.45},{s2,0.55}, name="skymatch"}
print(skymatch)

--@ chunk 146
print(wait(7*24*60))
for _, p in ipairs({{222,150},{200,170},{245,165},{222,175},{300,290},{330,280}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 147
print(wait(5*24*60))
for _, p in ipairs({{222,150},{200,170},{245,165},{222,175},{300,290},{330,280},{215,140}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 148
local hat = poly(HAT2crown,true):grow(0.8) + poly(HAT.brim,true):grow(0.8) + FIG2:grow(1)
local ghost = ellipse(222, 158, 46, 40):soften(14) * above({{0,190},{1000,190}})
local m = ghost - hat
work(m, {hand="body", tool="filbert 7", piles={{s1, function(x,y) return clamp((175-y)/40,0.25,1)*1.2 end},{s2, function(x,y) return clamp((y-120)/60,0.2,1) end}},
  coverage=2.4, fill=true, clip=-hat, edge="lost", length={12,30}, angle=0.04, pressure={0.45,0.75}, seed=21001})

--@ chunk 149
local hat = poly(HAT2crown,true) + poly(HAT.brim,true) + FIG2
local oldc = (poly(CB.crown,true) + poly(CB.crown2,true) + poly(C2.crown,true) + poly(HAT.crown,true)):grow(6) * above({{0,188},{1000,188}})
local band = oldc - hat:grow(0.3)
work(band, {hand="detail", tool={kind="filbert", width=2.5}, piles={{s1, function(x,y) return clamp((175-y)/40,0.25,1)*1.2 end},{s2, function(x,y) return clamp((y-120)/60,0.2,1) end}},
  coverage=4, fill=true, clip=band, length={3,7}, angle=0.04, seed=21101})
local ghost = ellipse(222, 158, 56, 48) * above({{0,190},{1000,190}}) - hat:grow(1.5)
blend(ghost, {angle=0.04})

--@ chunk 150
for _, p in ipairs({{222,150},{205,160},{240,160},{222,135}}) do print(p[1],p[2],drying(p[1],p[2])) end
TALLC = {{200,191},{198,176},{198,162},{201,151},{206,143},{213,139},{219,142},{222,145},{226,141},{233,140},{239,145},{243,155},{245,168},{245,180},{245,191}}
local tc = poly(TALLC, true)
work(tc, {hand="detail", tool={kind="filbert", width=3.5}, piles={{hat2,1},{coat_dk2,0.3}}, coverage=4, fill=true, clip=tc, length={5,12}, angle=1.5, seed=22001})
local r = brush{kind="round", width=2.2, point=0.8}
-- crease (pinch) shadow and dents
r:load(coat_dk2, 0.7)
r:gesture({{221,146,0.6},{222,158,0.6},{221,170,0.3}}, {clip=tc})
r:gesture({{207,150,0.4},{205,160,0.5},{205,170,0.2}}, {clip=tc})
-- moonlit right flank of crown
r:load(moon_rimc, 0.55)
r:gesture({{232,141,0.2},{239,146,0.6},{243,156,0.6},{245,170,0.4},{245,182,0.1}}, {clip=tc})
r:load(moon_rimc, 0.4)
r:gesture({{214,140,0.2},{218,142,0.4},{221,145,0.1}}, {clip=tc})
-- hat band
r:load(coat_dk2, 0.9)
r:gesture({{200,186,0.8},{222,187,0.9},{245,186,0.8}}, {clip=tc})
r:load(glove_lit, 0.35)
r:gesture({{236,185,0.3},{242,185,0.5},{245,184,0.2}}, {clip=tc})

--@ chunk 151
print(wait(8*24*60))
for _, p in ipairs({{222,150},{240,160},{222,135},{180,140},{270,130},{165,170}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 152
local hat = poly(TALLC,true):grow(1) + poly(HAT.brim,true):grow(1) + FIG2:grow(1.5)
local cl = ribbon({{40,100},{110,112},{180,132},{240,150},{300,160},{360,158},{410,150}}, {26,34,42,46,38,26,14})
cl = cl:roughen(10, 40, 7):soften(10)
local nz = noise{seed=2301, period=60, octaves=3}
work(cl - hat, {hand="body", tool="filbert 9", piles={
  {s1, function(x,y) return 1.0 + 0.3*nz(x,y) end},
  {sky_dk, function(x,y) return 0.8 end},
  {s2, function(x,y) return clamp(0.3 - nz(x,y),0,1) end}},
  coverage=2.2, fill=true, clip=-hat, edge="lost", length={20,50}, angle=function(x,y) return 0.18 - (x-40)/2400 + 0.08*nz(x,y) end, pressure={0.45,0.75}, seed=23001})

--@ chunk 153
for _, p in ipairs({{770,520},{830,520},{760,560},{850,570},{780,380},{760,400}}) do print(p[1],p[2],drying(p[1],p[2])) end
local legs = ZP.legs
local tool = {kind="filbert", width=4, stiffness=0.3}
work(legs:shrink(1), {hand="glaze", tool=tool, pile=zglaze, coverage=2.2, fill=true, clip=legs, angle=function(x,y) if x < 790 then return 1.85 end return 1.2 end, length={12,30}, seed=24001})

--@ chunk 154
shirt = pile{{"lead white",0.5},{"yellow ochre",0.35},{"raw umber",0.4},{"green earth",0.3},{"bone black",0.12}, name="shirt"}
shirt_sh = pile{{"raw umber",0.6},{"green earth",0.4},{"bone black",0.35},{"lead white",0.12}, name="shirt_sh"}
shirt_lit = pile{{"lead white",0.8},{"yellow ochre",0.5},{"Naples yellow",0.2},{"raw umber",0.15},{"orange vermilion",0.04}, name="shirt_lit"}
local o = outline{{750,336},{760,334},{772,338},{778,350,"c"},{774,362},{782,372,"c"},{780,388},{788,402,"c"},{784,418},{790,432,"c"},{786,444},{776,442},{770,420},{764,400},{758,380},{752,358}, closed=true, char="broken", seed=31, amount=0.5, edge=1}
SHIRT = o:mask() * ZALL - ZARM.sleeveN - ZARM.foreN
local function lw(x,y) local fx = 752 + (y-336)*0.24; return clamp(1-(x-fx)/12,0,1) end
work(SHIRT, {hand="detail", tool={kind="filbert", width=3}, piles={{shirt_sh, function(x,y) return clamp((x-760-(y-336)*0.24)/14,0,1)*1.2 + 0.3 end},{shirt, 1},{shirt_lit, function(x,y) return lw(x,y)*1.4 end}},
  coverage=3, fill=true, clip=SHIRT, length={5,12}, angle=1.35, seed=25001})

--@ chunk 155
local function fx(y) return 752 + (y-336)*0.24 end
local inner = SHIRT * mask(function(x,y) return clamp((x - fx(y) - 5)/6, 0, 1) end)
work(inner, {hand="detail", tool={kind="filbert", width=3}, piles={{shirt_sh, 1.3},{zd, function(x,y) return clamp((x-fx(y)-14)/10,0,1) end}},
  coverage=2.5, fill=true, clip=SHIRT, length={5,12}, angle=1.35, seed=25101})
-- ribs showing through a tear (skin lit from the left)
local r = brush{kind="round", width=2.2, point=0.8}
for i, y in ipairs({364, 373, 382, 391}) do
  local x0 = fx(y) + 2
  r:load(zs_m, 0.6)
  r:gesture({{x0, y-1, 0.5},{x0+7, y+1, 0.7},{x0+13, y+4, 0.3}}, {clip=SHIRT})
  r:load(maw, 0.6)
  r:gesture({{x0+1, y+3.5, 0.4},{x0+7, y+5, 0.6},{x0+13, y+8, 0.2}}, {clip=SHIRT})
end
-- lit front edge of shirt (flash)
r:load(shirt_lit, 0.6)
r:gesture({{753,340,0.3},{757,356,0.6},{762,376,0.5},{767,396,0.5},{772,416,0.4},{776,436,0.2}}, {clip=SHIRT})

--@ chunk 156
local function fx(y) return 752 + (y-336)*0.24 end
work(SHIRT, {hand="detail", tool={kind="filbert", width=3}, piles={{shirt_sh, 1.2},{zd, function(x,y) return clamp((x-fx(y)-6)/14,0,1)*1.2 end},{zs_m, function(x,y) return clamp(1-(x-fx(y))/8,0,1)*0.6 end}},
  coverage=3, fill=true, clip=SHIRT, length={6,14}, angle=1.35, seed=25201})
local r = brush{kind="round", width=2, point=0.8}
r:load(zs_l, 0.55)
r:gesture({{754,342,0.3},{758,358,0.5},{763,378,0.45},{768,398,0.45},{773,418,0.3},{776,434,0.1}}, {clip=SHIRT})
-- two ribs, subtle, catching the flash on their upper edges
for i, y in ipairs({366, 378}) do
  local x0 = fx(y) + 1
  r:load(zs_m, 0.5)
  r:gesture({{x0, y, 0.3},{x0+6, y+1.5, 0.5},{x0+11, y+4, 0.15}}, {clip=SHIRT})
end

--@ chunk 157
for _, p in ipairs({{750,240},{770,250},{800,235},{746,288},{760,270}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 158
local r = brush{kind="round", width=2.6, point=0.8}
local s = brush{kind="round", width=1.8, point=0.85}
local f = brush{kind="filbert", width=3.5}
local function G(b, p, ld, pts) b:load(p, ld); b:gesture(pts, {clip=ZHM, wobble=0.3}) end
-- lit planes first (flash from the left)
G(f, zs_l, 0.7, {{748,218,0.4},{754,214,0.7},{764,212,0.5},{772,212,0.2}})     -- top of forehead
G(f, zs_l, 0.7, {{741,228,0.5},{744,223,0.8},{750,219,0.5}})                     -- forehead front
G(f, zs_l, 0.6, {{749,242,0.4},{755,243,0.8},{762,246,0.5}})                     -- cheekbone
G(f, zs_m, 0.6, {{756,250,0.4},{762,254,0.6},{768,258,0.3}})                     -- cheek below
G(f, zs_l, 0.6, {{738,270,0.4},{741,276,0.8},{745,283,0.5}})                     -- chin
-- darks
G(r, maw, 0.9, {{745,232,0.6},{750,230,1.0},{756,232,1.0},{759,236,0.5}})        -- eye socket
G(r, maw, 0.7, {{748,236,0.6},{754,237,0.6}})
G(s, maw, 0.8, {{739,241,0.7},{742,243,0.5}})                                    -- nasal hole
G(r, maw, 1.0, {{739,250,0.8},{744,251,1.0},{750,254,1.0},{755,259,0.6}})        -- maw
G(r, maw, 1.0, {{740,255,0.9},{745,257,1.0},{751,260,0.8}})
G(r, maw, 0.9, {{740,260,0.8},{745,262,0.8},{749,264,0.4}})
G(r, zs_d, 0.8, {{745,286,0.4},{756,280,0.7},{768,272,0.7},{778,264,0.3}})        -- under-jaw shadow
-- teeth
s:load(teeth, 0.6)
for _, t in ipairs({{740.5,249.5},{743.5,250},{746.5,251},{749.5,252.5}}) do s:touch(t[1], t[2], {pressure=0.5, drag={0.4,2.0}, clip=ZHM}) end
for _, t in ipairs({{741,265},{744,265.5},{747,265.5}}) do s:touch(t[1], t[2], {pressure=0.5, drag={0.3,-2.0}, clip=ZHM}) end
-- eye glint
s:load(pile{{"lead white",1},{"green earth",0.2},{"yellow ochre",0.15}}, 0.4)
s:touch(751, 233.5, {pressure=0.45, clip=ZHM})
-- ear
G(r, zs_d, 0.7, {{778,244,0.4},{781,248,0.8},{780,254,0.6},{776,256,0.2}})
G(s, zs_m, 0.5, {{777,246,0.3},{779,250,0.5},{778,253,0.2}})

--@ chunk 159
work(ZHM:shrink(1), {hand="blend", tool={kind="badger", width=7}, angle=0.6, coverage=1.2})
work(ZHM:shrink(1), {hand="blend", tool={kind="badger", width=7}, angle=-0.9, coverage=1.0})

--@ chunk 160
local k = knife{width=12}
for y = 210, 292, 5 do
  k:scrape({{730,y},{770,y},{810,y}}, {pressure=1}); k:wipe()
end
for x = 734, 806, 5 do
  k:scrape({{x,208},{x,250},{x,294}}, {pressure=1}); k:wipe()
end

--@ chunk 161
print(wait(6*24*60))
for _, p in ipairs({{750,240},{770,250},{745,255},{760,220},{746,282},{780,260}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 162
local fl = rimdir(ZHM, 470, 243, {4,8,13,19,26})
local nz = noise{seed=2601, period=9, octaves=2}
work(ZHM, {hand="detail", tool={kind="filbert", width=3}, piles={
   {zs_d, function(x,y) return clamp(1-fl(x,y)*1.4,0,1)*1.2 + 0.15 end},
   {zs_m, function(x,y) return clamp(1-math.abs(fl(x,y)-0.45)*2.6,0,1) + 0.15*clamp(nz(x,y),0,1) end},
   {zs_l, function(x,y) return clamp(fl(x,y)*2-1.05,0,1)*1.8 end}},
   coverage=3.5, fill=true, clip=ZHM, length={4,9}, angle=function(x,y) return math.atan(y-243, x-470) + 1.57 end, seed=26001})

--@ chunk 163
print(wait(3*24*60))
for _, p in ipairs({{750,240},{770,250},{745,255},{760,220},{746,282}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 164
print(wait(6*24*60))
for _, p in ipairs({{750,240},{770,250},{745,255},{760,220},{746,282}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 165
print(wait(3*24*60))
for _, p in ipairs({{750,240},{770,250},{745,255},{760,220},{746,282}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 166
print(wait(3*24*60))
for _, p in ipairs({{750,240},{770,250},{745,255},{760,220},{746,282}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 167
local r = brush{kind="round", width=2.4, point=0.85}
local s = brush{kind="round", width=1.7, point=0.9}
local function G(b, p, ld, pts) b:load(p, ld); b:gesture(pts, {clip=ZHM, wobble=0.2}) end
-- eye socket: deep almond under the brow
G(r, maw, 0.8, {{746,233,0.5},{750,231,0.9},{755,232,0.9},{758,235,0.4}})
-- nasal cavity
G(s, maw, 0.7, {{739.5,240,0.6},{741.5,242.5,0.5}})
-- open maw
G(r, maw, 0.9, {{740,250,0.7},{745,251,1.0},{750,254,0.9},{754,258,0.4}})
G(r, maw, 0.9, {{741,255,0.8},{746,257,0.9},{750,260,0.5}})
-- cheek hollow / jaw muscle shadow
G(r, zs_d, 0.6, {{758,248,0.3},{763,254,0.6},{766,262,0.4}})
-- under-jaw shadow
G(r, zs_d, 0.7, {{748,288,0.3},{758,281,0.6},{770,273,0.5},{778,266,0.2}})
-- teeth
s:load(teeth, 0.5)
for _, t in ipairs({{741,249.5},{744,250.3},{747,251.5}}) do s:touch(t[1], t[2], {pressure=0.45, drag={0.4,1.8}, clip=ZHM}) end
for _, t in ipairs({{742,262},{745,262.5}}) do s:touch(t[1], t[2], {pressure=0.45, drag={0.3,-1.8}, clip=ZHM}) end
-- eye glint
s:load(pile{{"lead white",1},{"green earth",0.2},{"yellow ochre",0.15}}, 0.4)
s:touch(751, 233, {pressure=0.4, clip=ZHM})
-- ear
G(r, zs_d, 0.6, {{779,243,0.4},{782,248,0.7},{781,254,0.5},{777,256,0.2}})

--@ chunk 168
cavity = pile{{"bone black",1},{"raw umber",0.5},{"green earth",0.3}, name="cavity"}
EYE = poly({{745,232},{749,229},{755,229},{760,232},{758,237},{752,238},{747,236}}, true)
MOUTH = poly({{739,248},{745,248},{751,251},{756,256},{756,261},{750,263},{744,263},{740,260},{742,256},{739,252}}, true)
NOSE = poly({{739,239},{742,238},{743,242},{740,243}}, true)
local m = (EYE + MOUTH + NOSE) * ZHM
work(m, {hand="detail", tool={kind="round", width=1.8}, pile=cavity, coverage=4, fill=true, clip=m, length={2,5}, angle=0.5, seed=27001})
local s = brush{kind="round", width=1.7, point=0.9}
s:load(teeth, 0.55)
for _, t in ipairs({{741,249},{744,249.5},{747,250.5},{750,252}}) do s:touch(t[1], t[2], {pressure=0.5, drag={0.4,2.2}, clip=ZHM}) end
for _, t in ipairs({{742,262},{745,262.3},{748,262}}) do s:touch(t[1], t[2], {pressure=0.5, drag={0.3,-2.2}, clip=ZHM}) end
s:load(pile{{"lead white",1},{"green earth",0.25},{"yellow ochre",0.2}}, 0.45)
s:touch(752.5, 233, {pressure=0.5, clip=ZHM})
-- brow ridge light just above the socket
s:load(zs_l, 0.5)
s:gesture({{744,228,0.3},{750,226.5,0.6},{757,227.5,0.3}}, {clip=ZHM})

--@ chunk 169
local s = brush{kind="flat", width=1.6}
s:load(teeth, 0.7)
for _, t in ipairs({{742,249.5},{745,250},{748,251.2},{751,252.8}}) do s:stroke({{t[1], t[2]-0.5},{t[1]+0.3, t[2]+2.3}}, {pressure=0.7, clip=ZHM}) end
for _, t in ipairs({{743,261.5},{746,261.8},{749,261.3}}) do s:stroke({{t[1], t[2]+0.5},{t[1]+0.2, t[2]-2.2}}, {pressure=0.7, clip=ZHM}) end

--@ chunk 170
for _, p in ipairs({{250,400},{280,500},{160,580},{280,580},{770,520},{840,540},{200,553},{44,499},{740,120},{760,160}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 171
mesa_n = pile{{"ultramarine blue",0.35},{"bone black",0.3},{"raw umber",0.25},{"Prussian blue",0.08},{"lead white",0.9},{"green earth",0.1}, name="mesa_n"}
mesa_nl = pile{{"ultramarine blue",0.25},{"bone black",0.18},{"raw umber",0.15},{"Prussian blue",0.08},{"lead white",1.3},{"yellow ochre",0.08}, name="mesa_nl"}
local cr = CROSSM:grow(1) + MOUNDS_IN
local M = poly(MESA2, true) * above({{0,502},{360,502}}) - FIG2:grow(1) - cr
MESAM = M
-- lit faces: right-facing slopes (x>165) and top rim
local function lit(x,y)
  local top = 456 + (x > 170 and (x-170)*0.25 or 0)
  return clamp(1 - (y-top)/8, 0, 1)*0.6 + (x > 175 and clamp((x-175)/60,0,1)*0.6 or 0)
end
work(M, {hand="body", tool="filbert 6", piles={{mesa_n, 1},{mesa_nl, lit}}, coverage=2.6, fill=true, clip=M, length={12,30}, angle=0.0, pressure={0.5,0.8}, seed=28001})

--@ chunk 172
for _, p in ipairs({{760,100},{770,140},{740,160},{790,70}}) do print(p[1],p[2],drying(p[1],p[2])) end
local b = brush{kind="filbert", width=9, stiffness=0.35}
local protect = -(ellipse(850,118,40,40) + FIG2:grow(2))
local function S(p, ld, pts) b:load(p, ld); b:gesture(pts, {clip=protect, wobble=2.5}) end
-- light strata running out of the halo to the left
S(sky_cl, 0.45, {{800,78,0.5},{770,80,0.4},{735,84,0.2},{705,86,0.0}})
S(sky_cl, 0.45, {{796,112,0.5},{760,114,0.4},{725,118,0.2},{690,120,0.0}})
S(sky_cl, 0.4, {{790,150,0.45},{752,153,0.35},{716,156,0.15},{690,157,0.0}})
-- darker strata cutting in from outside
S(s2, 0.45, {{700,96,0.0},{735,97,0.35},{770,96,0.4},{800,94,0.0}})
S(s2, 0.45, {{690,134,0.0},{725,133,0.4},{765,132,0.4},{795,134,0.0}})
S(s2, 0.4, {{705,62,0.0},{740,61,0.35},{775,62,0.3},{805,64,0.0}})
S(s2, 0.4, {{700,170,0.0},{735,170,0.35},{770,171,0.3},{800,172,0.0}})

--@ chunk 173
local m = (rect(688, 52, 125, 128) - ellipse(850,118,60,60)):soften(6) - FIG2:grow(2)
blend(m, {angle=0.02})

--@ chunk 174
local nz = noise{seed=3101, period=50, octaves=3}
local m = ellipse(728, 116, 95, 80):roughen(14, 45, 5):soften(16) - ellipse(850,118,44,44) - FIG2:grow(2)
local function dmoon(x,y) return math.sqrt((x-850)^2+(y-118)^2) end
work(m, {hand="body", tool="filbert 9", piles={
  {s2, function(x,y) return clamp((dmoon(x,y)-90)/50,0,1)*1.3 + 0.2 end},
  {sky_cl, function(x,y) return clamp(1-(dmoon(x,y)-60)/70,0,1)*1.2 + clamp(nz(x,y),0,1)*0.4 end},
  {s1, function(x,y) return clamp((60-y)/30,0,1)*0.8 + clamp((y-170)/30,0,1)*0.5 end}},
  coverage=2.2, fill=true, clip=-(ellipse(850,118,40,40) + FIG2:grow(2)), edge="lost", length={18,45}, angle=function(x,y) return 0.02 + 0.07*nz(x,y) end, pressure={0.4,0.7}, seed=31001})

--@ chunk 175
sage_d = pile{{"raw umber",0.8},{"bone black",0.6},{"green earth",0.6},{"ultramarine blue",0.15}, name="sage_d"}
sage_l = pile{{"lead white",0.6},{"green earth",0.6},{"raw umber",0.3},{"Prussian blue",0.08},{"yellow ochre",0.15}, name="sage_l"}
function sage(cx, cy, w, h, seed)
  local m = ellipse(cx, cy - h*0.45, w*0.5, h*0.55):roughen(w*0.12, w*0.3, seed):soften(1.5) * above({{0,cy},{1000,cy}})
  stipple(m, {pile=sage_d, width=w*0.12, coverage=2.2, cluster=0.5, pressure={0.4,0.8}, seed=seed})
  -- moonlit top-right
  local top = m * mask(function(x,y) return clamp(((x-cx)/w*0.8 - (y-(cy-h*0.6))/h) , 0, 1) end)
  stipple(top, {pile=sage_l, width=w*0.08, coverage=0.7, cluster=0.6, pressure={0.3,0.6}, feather=0.5, seed=seed+1})
  -- a few stems at the base
  local r = brush{kind="round", width=1.4, point=0.8}
  r:load(sage_d, 0.6)
  for i = 1, 3 do
    local x0 = cx + rand(-w*0.15, w*0.15)
    r:gesture({{x0, cy+1, 0.7},{x0 + rand(-3,3), cy - h*0.25, 0.3}})
  end
  return m
end
SAGE1 = sage(560, 646, 30, 16, 41)

--@ chunk 176
function sage2(cx, cy, w, h, seed)
  local m = ellipse(cx, cy - h*0.45, w*0.5, h*0.55):roughen(w*0.1, w*0.25, seed):soften(1.5) * above({{0,cy},{1000,cy}})
  stipple(m, {pile=sage_d, width=w*0.1, coverage=2.4, cluster=0.5, pressure={0.4,0.8}, seed=seed})
  local top = m * mask(function(x,y) return clamp(((x-cx)/w*0.9 - (y-(cy-h*0.55))/h*1.2) + 0.2, 0, 1) end)
  stipple(top, {pile=sage_l, width=w*0.07, coverage=1.3, cluster=0.6, pressure={0.35,0.65}, seed=seed+1})
  local r = brush{kind="round", width=1.6, point=0.8}
  r:load(sage_d, 0.6)
  for i = 1, 4 do
    local x0 = cx + rand(-w*0.2, w*0.2)
    r:gesture({{x0, cy+1, 0.8},{x0 + rand(-4,4), cy - h*0.3, 0.3}})
  end
  return m
end
SAGE2 = sage2(455, 660, 56, 26, 43)

--@ chunk 177
stone_l = pile{{"lead white",0.7},{"raw umber",0.4},{"yellow ochre",0.25},{"green earth",0.15},{"bone black",0.1}, name="stone_l"}
stone_d = pile{{"raw umber",0.8},{"bone black",0.5},{"ultramarine blue",0.2}, name="stone_d"}
function stone(cx, cy, w, h, seed)
  local m = ellipse(cx, cy, w/2, h/2):roughen(w*0.08, w*0.3, seed) * above({{0,cy+h*0.3},{1000,cy+h*0.3}})
  work(m, {hand="detail", tool={kind="filbert", width=math.max(2, w*0.25)}, piles={{stone_d,1},{stone_l, function(x,y) return clamp((cy-y)/h*2 + (x-cx)/w*0.5 + 0.3,0,1)*1.5 end}},
    coverage=3, fill=true, clip=m, length={3,8}, angle=0.0, seed=seed})
  -- cast shadow to lower-left (moon up-right)
  local sh = ellipse(cx - w*0.3, cy + h*0.32, w*0.55, h*0.18) - m
  work(sh, {hand="detail", tool={kind="round", width=2}, pile=shad, coverage=2.5, fill=true, clip=sh, length={3,8}, angle=0.0, seed=seed+1})
end
stone(612, 616, 14, 7, 51)
stone(338, 640, 20, 9, 52)
stone(940, 640, 26, 11, 53)
stone(690, 560, 9, 4, 54)
stone(410, 548, 8, 3.5, 55)
stone(985, 585, 12, 5, 56)

--@ chunk 178
for _, p in ipairs({{240,215},{230,225},{245,230},{235,205}}) do print(p[1],p[2],drying(p[1],p[2])) end
face_hi = pile{{"lead white",0.8},{"Naples yellow",0.3},{"orange vermilion",0.12},{"yellow ochre",0.2},{"red earth",0.08}, name="face_hi"}

--@ chunk 179
local H = CBP.HEADM
local s = brush{kind="round", width=1.8, point=0.85}
local function G(p, ld, pts) s:load(p, ld); s:gesture(pts, {clip=H, wobble=0.2}) end
G(face_hi, 0.55, {{239,201,0.2},{241,205,0.5},{243,209,0.4}})          -- brow/forehead front
G(face_hi, 0.6, {{244,210,0.3},{247,213,0.6},{249,216,0.6},{247,218,0.2}}) -- nose ridge and tip
G(face_hi, 0.5, {{241,219,0.3},{243,220,0.4}})                          -- nostril wing
G(face_hi, 0.5, {{245,229,0.3},{246,232,0.5},{245,235,0.3}})            -- lower lip
G(face_hi, 0.5, {{243,238,0.3},{244,241,0.5},{241,243,0.2}})            -- chin
G(skin_lit, 0.5, {{236,213,0.2},{238,216,0.5},{237,219,0.2}})           -- cheekbone
-- the eye: a dark squint line under the brow
G(face_sh, 0.7, {{234,207,0.3},{238,208,0.6},{241,208,0.3}})

--@ chunk 180
local function rightedge(M, y, x0, x1)
  for x = x1, x0, -0.5 do if M:at(x, y) > 0.5 then return x end end
  return nil
end
EDGEPTS = {}
local out = {}
for y = 300, 540, 8 do
  local x = rightedge(COATM, y, 150, 320)
  if x then EDGEPTS[#EDGEPTS+1] = {x, y}; out[#out+1] = string.format("(%.0f,%.0f)", x, y) end
end
print(table.concat(out, " "))
LEGPTS = {}
out = {}
for y = 548, 600, 6 do
  local x = rightedge(CBP.LEGM, y, 230, 320)
  if x then LEGPTS[#LEGPTS+1] = {x, y}; out[#out+1] = string.format("(%.0f,%.0f)", x, y) end
end
print(table.concat(out, " "))

--@ chunk 181
coat_m = pile{{"raw umber",1},{"bone black",0.45},{"red earth",0.2},{"yellow ochre",0.15},{"lead white",0.1}, name="coat_m"}
coat_warm = pile{{"raw umber",0.75},{"yellow ochre",0.4},{"red earth",0.25},{"orange vermilion",0.05},{"bone black",0.2},{"lead white",0.2}, name="coat_warm"}
coat_rim = pile{{"raw umber",0.5},{"lead white",0.5},{"Prussian blue",0.1},{"bone black",0.15},{"yellow ochre",0.12}, name="coat_rim"}
local C = COATM
local r = brush{kind="round", width=2.6, point=0.7, stiffness=0.4}
local rp = {}
for i, p in ipairs(EDGEPTS) do if p[2] >= 316 then
  local t = (p[2]-316)/224
  rp[#rp+1] = {p[1]-1.3, p[2], 0.15 + 0.35*math.sin(math.pi*t)}
end end
r:load(coat_rim, 0.6)
r:gesture(rp, {clip=C, wobble=0.3})
local lp = {}
for i, p in ipairs(LEGPTS) do lp[#lp+1] = {p[1]-1.2, p[2], 0.2 + 0.25*math.sin(math.pi*(i-1)/(#LEGPTS-1))} end
r:load(coat_rim, 0.5)
r:gesture(lp, {clip=CBP.LEGM, wobble=0.3})

--@ chunk 182
sig = pile{{"red earth",1},{"yellow ochre",0.5},{"lead white",0.25}, name="sig"}
local r = brush{kind="rigger", width=1.6, point=1}
r:load(sig, 0.6)
-- "C"
r:gesture({{948,644,0.3},{943,642,0.6},{939,646,0.7},{939,652,0.7},{943,656,0.6},{948,655,0.3}})
-- "l"
r:gesture({{952,640,0.3},{951,648,0.6},{951,656,0.5},{953,657,0.2}})
-- short flourish underline
r:load(sig, 0.4)
r:gesture({{938,661,0.2},{950,660,0.5},{964,658,0.2}})

--@ chunk 183
print(wait(30*24*60))
for _, p in ipairs({{480,243},{750,240},{240,215},{560,646},{950,650},{728,116}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 184
local function pp(t) local s={} for i,p in ipairs(t) do s[#s+1]=string.format("(%.0f,%.0f)",p[1],p[2]) end return table.concat(s," ") end
print("CSH2", pp(CSH2))
print("ZSH2", pp(ZSH2))
print(drying(200,600), drying(780,600), drying(500,200), drying(820,450))
print(LAND and #LAND)
print(type(EDGEPTS[1]), type(LEGPTS[1]))

--@ chunk 185
shbt = pile{{"bone black",0.8},{"raw umber",0.8},{"ultramarine blue",0.5},{"green earth",0.3}, thinner=0.6, name="shbt"}
-- cowboy's moon shadow: a wedge from the boot soles toward the lower-left corner
CSH3 = {{338,625},{312,630},{272,640},{228,652},{190,662},{170,667},{0,667},{0,652},{36,642},{82,632},{116,624},{150,623},{190,624},{230,626},{262,625},{300,626}}
local cm = poly(CSH3, true):blur(3)
work(cm, {hand="scumble", pile=shbt, coverage=1.4, fill=true, clip=cm, angle=2.76,
  load_at=function(x,y) return lerp(0.95, 0.45, clamp((330-x)/330,0,1)) end})
-- zombie's leg shadows, falling toward the viewer, a little left
ZSHF = {{712,602},{758,603},{748,618},{724,640},{708,667},{644,667},{668,640},{696,614}}
ZSHR = {{860,604},{893,606},{886,626},{874,667},{826,667},{842,634}}
local zm = (poly(ZSHF, true) + poly(ZSHR, true)):blur(3)
work(zm, {hand="scumble", pile=shbt, coverage=1.4, fill=true, clip=zm, angle=function(x,y) return x<800 and 2.3 or 1.97 end,
  load_at=function(x,y) return lerp(0.95, 0.5, smoothstep(603,667,y)) end})
print(drying(700,630))

--@ chunk 186
ZSHT = {{700,667},{718,650},{748,640},{776,634},{806,632},{838,634},{850,642},{846,667}}
local tm = poly(ZSHT, true):blur(4)
work(tm, {hand="scumble", pile=shbt, coverage=1.3, fill=true, clip=tm, angle=1.95,
  load_at=function(x,y) return lerp(0.75, 0.55, smoothstep(634,667,y)) end})
print(drying(776,650))

--@ chunk 187
print(s1) print(s2) print(s3) print(s4) print(halo) print(smoke_cool) print(smoke_sh) print(smoke_warm)
local function pp(t) local s={} for i,p in ipairs(t) do s[#s+1]=string.format("(%.0f,%.0f,%s)",p[1],p[2],tostring(p[3])) end return table.concat(s," ") end
print(pp(LOBES))

--@ chunk 188
sky_edge = mix{{s2, 0.7}, {pile{{"lead white",1.2},{"bone black",0.3},{"Prussian blue",0.18},{"ultramarine blue",0.15},{"raw umber",0.1},{"yellow ochre",0.1}}, 0.3}, name="sky_edge"}
print(sky_edge)
local fd = FLM2:distance()
print(fd:at(455,243), fd:at(520,243), fd:at(560,243), fd:at(600,243))
local cd = CLOUD:distance()
print(cd:at(530,220), cd:at(625,210), cd:at(450,222))

--@ chunk 189
smoke_mid = pile{{"lead white",1.2},{"bone black",0.3},{"Prussian blue",0.18},{"ultramarine blue",0.15},{"raw umber",0.1},{"yellow ochre",0.1}, name="smoke_mid"}
local fd = FLM2:distance()
local cd = CLOUD:distance()
local function dfl(x,y) return math.max(0, -fd:at(x,y)) end
local function nearest(x,y) local best, bl = 1e9, LOBES[1] for _,l in ipairs(LOBES) do local d = math.sqrt((x-l[1])^2+(y-l[2])^2)/l[3] if d < best then best, bl = d, l end end return bl end
local excl = FLM2:grow(10) + GUNM:grow(4) + ZALL:grow(3) + FISTM:grow(3)
local fall = function(x,y) return smoothstep(10, 28, dfl(x,y)) end
local R = (CLOUD - excl):times(fall)
local CLIPM = (CLOUD:grow(12) - excl):times(fall)
work(R, {hand="body", tool="filbert 6", coverage=2.4, fill=true, length={8,22},
  angle=-0.45, angle_jitter=0.6, edge="loose", clip=CLIPM,
  piles={{smoke_warm, function(x,y) return smoothstep(75, 15, dfl(x,y)) * 1.3 end},
         {smoke_cool, function(x,y) local l = nearest(x,y) local a,b = (y-l[2])/l[3], (x-l[1])/l[3] return clamp(-a*0.7 + b*0.3, 0, 1) * 0.6 end},
         {smoke_mid, function(x,y) return 0.7 end},
         {smoke_sh, function(x,y) local l = nearest(x,y) local a = (y-l[2])/l[3] return clamp(a*0.9, 0, 1) end},
         {sky_edge, function(x,y) return smoothstep(9, 1, cd:at(x,y)) * 2.0 * smoothstep(30, 70, dfl(x,y)) end}}})
print(drying(590,200))

--@ chunk 190
local function pp(t) local s={} for i,p in ipairs(t) do s[#s+1]=string.format("(%.0f,%.0f)",p[1],p[2]) end return table.concat(s," ") end
print("EDGE", pp(EDGEPTS))
print("LEG", pp(LEGPTS))
-- coat extent by rows
for y=250,560,20 do local x0,x1=nil,nil for x=40,340,2 do if COATM:at(x,y)>0.5 then x0 = x0 or x; x1 = x end end print(y, x0, x1) end
print(coat_dk, coat_m, coat_warm, coat_rim)

--@ chunk 191
FOLDS = {
  {{{203,325},{195,400},{182,470},{165,552}}, 3, 9, 1.0},
  {{{228,350},{229,430},{224,490},{214,552}}, 3, 10, 1.0},
  {{{248,405},{254,470},{259,552}}, 2, 7, 0.8},
  {{{176,400},{150,460},{122,505},{100,550}}, 3, 9, 0.75},
  {{{192,455},{168,505},{140,552}}, 2, 6, 0.55},
}
local function segd(px,py, ax,ay,bx,by)
  local vx,vy = bx-ax, by-ay local L2 = vx*vx+vy*vy
  local t = clamp(((px-ax)*vx+(py-ay)*vy)/L2, 0, 1)
  local qx,qy = ax+t*vx, ay+t*vy
  local cross = vx*(py-ay) - vy*(px-ax)
  return math.sqrt((px-qx)^2+(py-qy)^2), t, cross
end
function foldw(x, y)
  local light, dark = 0, 0
  for _,f in ipairs(FOLDS) do
    local pts, w0, w1, st = f[1], f[2], f[3], f[4]
    local best, bt, bs, acc, total = 1e9, 0, 1, 0, 0
    local lens = {}
    for i=1,#pts-1 do local l = math.sqrt((pts[i+1][1]-pts[i][1])^2+(pts[i+1][2]-pts[i][2])^2) lens[i]=l total=total+l end
    for i=1,#pts-1 do
      local d,t,c = segd(x,y, pts[i][1],pts[i][2],pts[i+1][1],pts[i+1][2])
      if d < best then best = d bt = (acc + t*lens[i])/total bs = (c < 0) and 1 or -1 end
      acc = acc + lens[i]
    end
    local w = lerp(w0, w1, bt)
    local fade = smoothstep(0, 0.35, bt) * st
    local sd = best * bs
    light = light + fade * math.exp(-((sd - 0.6*w)/w)^2)
    dark = dark + fade * math.exp(-((sd + 1.1*w)/(1.1*w))^2)
  end
  return light, dark
end
local function xr(y)
  for i=1,#EDGEPTS-1 do local a,b = EDGEPTS[i], EDGEPTS[i+1]
    if y >= a[2] and y <= b[2] then return lerp(a[1], b[1], (y-a[2])/(b[2]-a[2])) end end
  return y < EDGEPTS[1][2] and EDGEPTS[1][1] or EDGEPTS[#EDGEPTS][1]
end
local front = mask(function(x,y) return (x > xr(y) - 16) and 1 or 0 end)
COATIN = ((COATM:shrink(4) - front - CRIM:grow(3)) * below(function(x) return 300 end)):blur(2)
print(COATIN:area())
local function ang(x,y) return 1.72 + (x-200)*0.0015 end
work(COATIN, {hand="body", tool="filbert 6", coverage=2.5, fill=true, clip=COATIN, length={12,35},
  angle=ang,
  piles={{coat_dk2, 0.7},{coat_dk, 0.5},
         {coat_m, function(x,y) local l,d = foldw(x,y) return l*2.2 end},
         {coat_dk2, function(x,y) local l,d = foldw(x,y) return d*1.2 end}}})
print(drying(200,450))

--@ chunk 192
print(palette())

--@ chunk 193
print(wait(7*24*60))
print(drying(200,450), drying(560,210), drying(200,640), drying(760,640))

--@ chunk 194
for k,v in pairs(ZP) do print(k, type(v), type(v)=="userdata" and v:area() or (type(v)=="table" and #v or "")) end
for k,v in pairs(ZARM) do print("ZARM",k, type(v)) end
-- shirt extent
for y=300,440,10 do local x0,x1=nil,nil for x=700,820,1 do if SHIRT:at(x,y)>0.5 then x0 = x0 or x; x1 = x end end print(y, x0, x1) end

--@ chunk 195
local L = ZP.legs
for y=450,610,10 do local segs, inside, x0 = {}, false, nil
  for x=680,900,1 do local v = L:at(x,y) > 0.5
    if v and not inside then x0 = x inside = true elseif not v and inside then segs[#segs+1] = x0.."-"..(x-1) inside = false end end
  if inside then segs[#segs+1] = x0.."-900" end
  print(y, table.concat(segs, " ")) end

--@ chunk 196
FC = {{782,470},{769,500},{755,540},{745,580},{740,596}}
RC = {{811,470},{827,500},{847,540},{866,580},{876,596}}
FW = {{13,470},{14,500},{12.5,540},{11,580},{12,596}}
RW = {{10,470},{17,500},{14.5,540},{12,580},{11,596}}
CRE = {
  {{752,520},{764,528},{776,522}}, {{748,536},{760,546},{770,541}},
  {{826,522},{838,530},{850,524}}, {{832,540},{845,548},{857,542}},
  {{744,566},{752,572},{760,568}}, {{852,568},{862,574},{872,570}},
}
local function lerpw(W, y) for i=1,#W-1 do if y <= W[i+1][2] then return lerp(W[i][1], W[i+1][1], clamp((y-W[i][2])/(W[i+1][2]-W[i][2]),0,1)) end end return W[#W][1] end
function lat(x,y)
  local fx, rx = lerpw(FC,y), lerpw(RC,y)
  local fw, rw = lerpw(FW,y), lerpw(RW,y)
  local uf, ur = (x-fx)/fw, (x-rx)/rw
  if math.abs(uf) < math.abs(ur) then return uf, 0 else return ur, 1 end
end
local function segd(px,py, ax,ay,bx,by)
  local vx,vy = bx-ax, by-ay local L2 = vx*vx+vy*vy
  local t = clamp(((px-ax)*vx+(py-ay)*vy)/L2, 0, 1)
  local qx,qy = ax+t*vx, ay+t*vy
  return math.sqrt((px-qx)^2+(py-qy)^2), (py-qy)
end
function crease(x,y)
  local lt, dk = 0, 0
  for _,c in ipairs(CRE) do
    local best, sy = 1e9, 0
    for i=1,#c-1 do local d, s = segd(x,y,c[i][1],c[i][2],c[i+1][1],c[i+1][2]) if d < best then best, sy = d, s end end
    if best < 6 then
      if sy < 0 then lt = lt + math.exp(-((best-2)/2)^2) else dk = dk + math.exp(-(best/1.8)^2) end
    end
  end
  return lt, dk
end
legdk = pile{{"bone black",1},{"raw umber",0.5},{"ultramarine blue",0.2}, name="legdk"}
local LM = (ZP.legs:shrink(2.5) - below(function(x) return 597 end)):blur(1)
work(LM, {hand="body", tool="filbert 4", coverage=2.5, fill=true, clip=LM, length={8,22},
  angle=function(x,y) local u, which = lat(x,y) return which==0 and 1.88 or 1.12 end,
  piles={{ztrou2, 1},
    {zd_mid, function(x,y) local u = lat(x,y) return 1.3 * smoothstep(0.1, -0.7, u) end},
    {z_warm, function(x,y) local u = lat(x,y) return 0.6 * smoothstep(-0.6, -0.95, u) * smoothstep(620, 470, y) end},
    {zd_mid, function(x,y) local l, d = crease(x,y) return 1.4 * l * 1.5 end},
    {legdk, function(x,y) local l, d = crease(x,y) return 1.4 * d * 1.5 end}}})
-- ribs through the torn shirt (filled slits over the dry shirt)
XL = {{340,750},{350,752},{360,753},{370,757},{380,758},{390,761},{400,765},{410,767},{420,771},{430,773},{440,775}}
XR = {{340,773},{350,777},{360,773},{370,780},{380,780},{390,780},{400,787},{410,785},{420,784},{430,788},{440,787}}
local function edgex(T, y) for i=1,#T-1 do if y <= T[i+1][1] then return lerp(T[i][2], T[i+1][2], clamp((y-T[i][1])/(T[i+1][1]-T[i][1]),0,1)) end end return T[#T][2] end
local m = nil
for _,y0 in ipairs({350, 362, 374, 386, 398, 411}) do
  local y1 = y0 + 7
  local xr, xl = edgex(XR, y0) + 2, edgex(XL, y1) + 3
  local xm, ym = (xr + xl)/2, (y0 + y1)/2 + 1.2
  local t = 3.2 * (0.85 + 0.3*math.random())
  local s = poly({{xr, y0}, {xm+3, ym - t*0.45}, {xl, y1}, {xm-2, ym + t*0.55}}, true)
  m = m and (m + s) or s
end
RIBS = m * SHIRT:grow(1)
work(RIBS, {hand="detail", tool={kind="round", width=2, point=0.5}, pile=cavity, coverage=2.5, fill=true, clip=true, angle=0.3})
print(drying(760,540), drying(770,380))

--@ chunk 197
print(ztrou2) print(zd_mid) print(z_warm) print(legdk)
print(drying(760,540), drying(850,560))
print(palette())

--@ chunk 198
print(wait(12*24*60))
print(drying(760,540), drying(850,560), drying(770,380), drying(200,450))

--@ chunk 199
local T = ZP.suit - SHIRT - ZARM.sleeveN - ZARM.sleeveF - ZP.head
for y=290,500,10 do local segs, inside, x0 = {}, false, nil
  for x=690,900,1 do local v = T:at(x,y) > 0.5
    if v and not inside then x0 = x inside = true elseif not v and inside then segs[#segs+1] = x0.."-"..(x-1) inside = false end end
  if inside then segs[#segs+1] = x0.."-900" end
  print(y, table.concat(segs, " ")) end
print(T:area(), ZRIM:area())

--@ chunk 200
local function segd(px,py, ax,ay,bx,by)
  local vx,vy = bx-ax, by-ay local L2 = vx*vx+vy*vy
  local t = clamp(((px-ax)*vx+(py-ay)*vy)/L2, 0, 1)
  local qx,qy = ax+t*vx, ay+t*vy
  local cross = vx*(py-ay) - vy*(px-ax)
  return math.sqrt((px-qx)^2+(py-qy)^2), t, cross
end
function foldw2(FL, x, y)
  local light, dark = 0, 0
  for _,f in ipairs(FL) do
    local pts, w0, w1, st = f[1], f[2], f[3], f[4]
    local best, bt, bs, acc, total = 1e9, 0, 1, 0, 0
    local lens = {}
    for i=1,#pts-1 do local l = math.sqrt((pts[i+1][1]-pts[i][1])^2+(pts[i+1][2]-pts[i][2])^2) lens[i]=l total=total+l end
    for i=1,#pts-1 do
      local d,t,c = segd(x,y, pts[i][1],pts[i][2],pts[i+1][1],pts[i+1][2])
      if d < best then best = d bt = (acc + t*lens[i])/total bs = (c < 0) and 1 or -1 end
      acc = acc + lens[i]
    end
    local w = lerp(w0, w1, bt)
    local fade = smoothstep(0, 0.3, bt) * smoothstep(1.05, 0.8, bt) * st
    local sd = best * bs
    light = light + fade * math.exp(-((sd - 0.6*w)/w)^2)
    dark = dark + fade * math.exp(-((sd + 1.1*w)/(1.1*w))^2)
  end
  return light, dark
end
ZFOLDS = {
  {{{784,330},{800,352},{822,372}}, 2, 5, 0.9},
  {{{786,380},{804,398},{826,416}}, 2, 5, 0.9},
  {{{800,420},{812,446},{824,476}}, 2, 5, 0.8},
  {{{826,430},{838,452},{850,474}}, 2, 4, 0.6},
}
local T = ZP.suit - SHIRT - ZARM.sleeveN - ZARM.sleeveF - ZP.head
ZTORSO = ((T:shrink(3) - ZRIM:grow(2)) * below(function(x) return 312 end)):blur(1)
local sd = SHIRT:distance()
print(ZTORSO:area())
work(ZTORSO, {hand="body", tool="filbert 4", coverage=2.5, fill=true, clip=ZTORSO, length={8,22},
  angle=function(x,y) return y < 420 and 0.85 or 1.25 end,
  piles={{zsuit2, 1},
    {zd_mid, function(x,y) local l = foldw2(ZFOLDS,x,y) return l*1.4 end},
    {legdk, function(x,y) local l, d = foldw2(ZFOLDS,x,y) return d*1.2 end},
    {zsuit_lit, function(x,y) local d = -sd:at(x,y) return smoothstep(7, 1, d) * 0.9 end}}})
print(drying(805,400))

--@ chunk 201
local k = knife{width=12}
-- horizontal passes, then diagonal ones, across the torso; only the fresh paint is wet
for y=306,494,7 do
  k:scrape({{752,y},{868,y}}, {pressure=1})
  k:wipe()
end
for i=0,26 do
  local x0 = 700 + i*7
  k:scrape({{x0,300},{x0+90,500}}, {pressure=1})
  k:wipe()
end
for x=770,860,7 do
  k:scrape({{x,300},{x,500}}, {pressure=1})
  k:wipe()
end
print(drying(805,400), drying(790,350), drying(830,460))

--@ chunk 202
print(palette())
print(zsuit2, zsuit_lit)

--@ chunk 203
local sd = SHIRT:distance()
work(ZTORSO, {hand="body", tool="filbert 5", coverage=3.0, fill=true, clip=ZTORSO, length={8,22},
  angle=function(x,y) return y < 420 and 0.85 or 1.25 end,
  piles={{cavity, 1},
    {zsuit2, function(x,y) local l = foldw2(ZFOLDS,x,y) return l*1.6 end},
    {legdk, function(x,y) local l, d = foldw2(ZFOLDS,x,y) return d*1.0 end},
    {zsuit_lit, function(x,y) local d = -sd:at(x,y) return smoothstep(6, 1, d) * 0.8 end}}})
print(drying(805,400))

--@ chunk 204
print(drying(780,480), drying(830,490))
local HB = (ZP.legs * mask(function(x,y) return smoothstep(520, 470, y) end)):blur(2)
work(HB, {hand="scumble", pile=shbt, coverage=1.3, fill=true, clip=ZP.legs:shrink(1), angle=1.7,
  load_at=function(x,y) return lerp(0.9, 0.35, smoothstep(462, 515, y)) end})
print(drying(780,480))

--@ chunk 205
print(wait(15*24*60))
print(drying(805,400), drying(780,480), drying(770,380))

--@ chunk 206
local function pr(t,n) local s={} for i,p in ipairs(t) do s[#s+1]=type(p)=="table" and string.format("(%.1f,%.1f)",p[1],p[2] or 0) or tostring(p) end print(n, table.concat(s," ")) end
pr(FW,"FW") pr(RW,"RW")
for _, p in ipairs({{715,600},{880,600},{740,560},{860,560},{455,645},{560,645}}) do print(p[1],p[2],drying(p[1],p[2])) end
-- leg extents near bottom
for _, y in ipairs({560,575,585,595,600,605}) do
  local xs = {}
  for x = 690, 910, 1 do if ZP.legs:at(x,y) > 0.5 then xs[#xs+1]=x end end
  if #xs>0 then
    local runs, s0, prev = {}, xs[1], xs[1]
    for i=2,#xs do if xs[i] ~= prev+1 then runs[#runs+1]=s0.."-"..prev; s0=xs[i] end prev=xs[i] end
    runs[#runs+1]=s0.."-"..prev
    print(y, table.concat(runs," "))
  else print(y,"none") end
end

--@ chunk 207
function zfeet_shapes(OLDLEG, dx)
  dx = dx or 0
  local function P(pts) local o = {} for i,p in ipairs(pts) do o[i] = {p[1]+dx, p[2]} end return o end
  local hemF = P{{724,586},{731,585},{735,589},{738,584},{742,590},{746,585},{749,589},{752,583},{756,586},{764,585}}
  local hemR = P{{850,586},{855,586},{859,590},{862,585},{866,591},{870,586},{874,589},{878,584},{882,588},{892,586}}
  local function under(h) local pts = {} for _,p in ipairs(h) do pts[#pts+1]=p end; pts[#pts+1]={h[#h][1],640}; pts[#pts+1]={h[1][1],640}; return poly(pts) end
  ZF = {hemF=hemF, hemR=hemR, dx=dx}
  ZF.below = under(hemF) + under(hemR)
  ZF.ankF = poly(P{{739.5,584},{749.5,584},{751,591},{752,595},{740,595},{739,590}}, true)
  ZF.footF = poly(P{{740,592.5},{733,596},{725,598.6},{718,600.6},{714,602.4},{715,604},{728,604.2},{742,603.6},{752,604},{756.5,601.5},{756,597},{752,593.5}}, true)
  ZF.ragF = poly(P{{751,585},{756,585},{756.5,592},{754.5,596.5},{752.5,591}}, true)
  ZF.ankR = poly(P{{862.5,584},{872.5,584},{875,591},{876,594},{866,595},{863.5,590}}, true)
  ZF.footR = poly(P{{866,592},{876,592},{880.5,594.5},{881.5,598.5},{876,601},{866,603.4},{858,604.8},{850,605},{848,603.6},{852,601.5},{858,598.5}}, true)
  ZF.ragR = poly(P{{876,585},{882,586},{885.5,595},{883.5,599},{879.5,593}}, true)
  ZF.skin = (ZF.ankF + ZF.footF + ZF.ankR + ZF.footR) * ZF.below
  ZF.rags = (ZF.ragF + ZF.ragR) * ZF.below - ZF.skin
  ZF.rest = (OLDLEG * ZF.below) - ZF.skin - ZF.rags
end
function zfeet_lay3()
  local dx = ZF.dx
  local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
  local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
  local function depth(y) return clamp((y-485)/180,0,1) end
  work(ZF.rest, {hand="detail", tool={kind="filbert", width=3}, piles={
    {gf, function(x,y) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x-dx,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
    {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x-dx,y),0,1)*0.3 end},
    {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x-dx,y)-0.2,0,1)*0.8*d end}},
     coverage=3.5, fill=true, clip=ZF.rest, length={4,10}, angle=0.02, seed=40001})
  local S = ZF.skin
  local function lit(x,y)
    local a = 0
    for _, d in ipairs({1.0, 2.0}) do a = a + (1 - S:at(x - 0.55*d, y - 0.83*d)) end
    return a/2
  end
  local function lower(x,y)
    local a = 0
    for _, d in ipairs({1.5, 3}) do a = a + (1 - S:at(x + 0.2*d, y + d)) end
    return a/2
  end
  local function hemdark(x,y) return clamp(1 - (y - 586)/5, 0, 1) end
  work(S, {hand="detail", tool={kind="filbert", width=2.2}, piles={
     {zs_d, 1},
     {cavity, function(x,y) return hemdark(x,y)*2.5 + lower(x,y)*1.0 + 0.4 end},
     {zs_m, function(x,y) local l = lit(x,y); return clamp(l*1.6-0.4,0,1)*1.3*(1-hemdark(x,y)) end}},
     coverage=3.5, fill=true, clip=S, length={3,6}, angle=function(x,y) return (y > 593) and 3.0 or 1.7 end, seed=40002})
  work(ZF.rags, {hand="detail", tool={kind="filbert", width=2}, piles={{ztrou2,1},{legdk,0.4}}, coverage=3.5, fill=true, clip=ZF.rags, length={3,8}, angle=1.6, seed=40003})
end
zfeet_shapes(ZP.legs:grow(2), 0)
print(ZF.rest:area(), ZF.skin:area(), ZF.rags:area())
zfeet_lay3()

--@ chunk 208
for _, p in ipairs({{712,602},{716,601},{720,603},{708,603},{728,592},{732,590},{760,600},{884,602},{890,603},{856,606}}) do
  print(p[1],p[2], "legs", string.format("%.2f", ZP.legs:at(p[1],p[2])), "FIG2", string.format("%.2f", FIG2:at(p[1],p[2])), "ZALL", ZALL and string.format("%.2f", ZALL:at(p[1],p[2])) or "-", "skin", string.format("%.2f", ZF.skin:at(p[1],p[2])), "rest", string.format("%.2f", ZF.rest:at(p[1],p[2])), drying(p[1],p[2]))
end

--@ chunk 209
local hem = {{600,586}}
for _,p in ipairs(ZF.hemF) do hem[#hem+1] = p end
for _,p in ipairs(ZF.hemR) do hem[#hem+1] = p end
hem[#hem+1] = {1000,586}
local BEL = below(hem)
local skinAll = (ZF.ankF + ZF.footF + ZF.ankR + ZF.footR) * BEL
local skin2 = skinAll - ZF.skin
local ragsAll = (ZF.ragF + ZF.ragR) * BEL - skinAll
local OLD = ZP.legs:grow(2)
local rest2 = OLD * BEL - skinAll - ragsAll - ZF.rest
print("skin2", skin2:area(), "rest2", rest2:area())
ZF.skin = skinAll; ZF.rags = ragsAll; ZF.rest2 = rest2; ZF.BEL = BEL
local S = skinAll
local function lit(x,y)
  local a = 0
  for _, d in ipairs({1.0, 2.0}) do a = a + (1 - S:at(x - 0.55*d, y - 0.83*d)) end
  return a/2
end
local function lower(x,y)
  local a = 0
  for _, d in ipairs({1.5, 3}) do a = a + (1 - S:at(x + 0.2*d, y + d)) end
  return a/2
end
work(skin2:grow(1) * S, {hand="detail", tool={kind="filbert", width=2.2}, piles={
   {zs_d, 1},
   {cavity, function(x,y) return lower(x,y)*1.0 + 0.4 end},
   {zs_m, function(x,y) local l = lit(x,y); return clamp(l*1.6-0.4,0,1)*1.3 end}},
   coverage=3.5, fill=true, clip=S, length={3,6}, angle=3.0, seed=40012})
-- old toe and old trouser flare: shadowed ground, darker than the open ground
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local R = rest2 + ZF.rest
work(R, {hand="detail", tool={kind="filbert", width=3}, piles={
   {gm, function(x,y) return 0.8 + clamp(nz2(x,y),0,1)*0.3 end},
   {gd, function(x,y) return 0.6 + smoothstep(596, 606, y)*1.2 end}},
   coverage=3, fill=true, clip=R, length={4,9}, angle=0.02, seed=40013})

--@ chunk 210
-- campaign: foreground. Step 1: paint ground over the old pale stones and speckled sage blobs
gshad = mix{{gd, 0.55}, {shad, 0.25}, {pile{{"bone black",1},{"raw umber",0.6}}, 0.2}, name="gshad"}
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
local function poolw(x,y) local dx=(x-480)/230; local dy=(y-585)/55; return clamp(1-math.sqrt(dx*dx+dy*dy),0,1) end
-- signature strokes, to keep clear
local sig = ribbon({{948,644},{943,642},{939,646},{939,652},{943,656},{948,655}}, 3) + ribbon({{952,640},{951,648},{951,656},{953,657}}, 3) + ribbon({{938,661},{950,660},{964,658}}, 3)
local old = ellipse(560, 646-16*0.45, 17, 10):roughen(3, 9, 41) * above({{0,647},{1000,647}})
          + ellipse(455, 660-26*0.45, 30, 16):roughen(5.6, 14, 43) * above({{0,661},{1000,661}})
          + ellipse(612, 616, 9, 5) + ellipse(608, 618.5, 9, 2.5)
          + ellipse(338, 640, 12, 6) + ellipse(332, 643, 13, 2.8)
          + ellipse(940, 640, 15, 7) + ellipse(932, 643.5, 15, 2.8)
local C = (old:grow(1.5) - sig:grow(1.5) - FIG2:grow(1)):soften(1)
print("cover area", C:area())
work(C, {hand="detail", tool={kind="filbert", width=3}, piles={
  {gf, function(x,y) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end},
  {gw, function(x,y) return poolw(x,y)^1.2*1.1 end}},
  coverage=3.5, fill=true, clip=C, length={4,10}, angle=0.02, seed=41001})

--@ chunk 211
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local C = (ellipse(948, 648, 22, 15):roughen(3, 12, 7) - FIG2:grow(1)):soften(1.5)
work(C, {hand="detail", tool={kind="filbert", width=3.5}, piles={{gd, 1},{gm, function(x,y) return 0.45 + clamp(nz2(x,y),0,1)*0.4 end}},
  coverage=3.5, fill=true, clip=C, length={5,12}, angle=0.02, seed=41002})

--@ chunk 212
sage_g = pile{{"lead white",0.35},{"green earth",0.6},{"raw umber",0.45},{"bone black",0.25},{"Prussian blue",0.04}, name="sage_g"}
sage_dg = mix{{sage_d, 0.6}, {sage_g, 0.4}, name="sage_dg"}
sage_w = mix{{sage_d, 0.55}, {gw, 0.45}, name="sage_w"}
stone_m = mix{{stone_d, 0.6}, {stone_l, 0.4}, name="stone_m"}
stone_dd = mix{{stone_d, 0.6}, {shad, 0.4}, name="stone_dd"}
function tuft(cx, cy, w, h, seed, mdx, mdy, warm)
  math.randomseed(seed)
  warm = warm or 0
  local sh = (ellipse(cx - w*0.2, cy + h*0.05, w*0.48, h*0.12)):blur(1.5) * below({{0, cy - h*0.1},{1000, cy - h*0.1}}) - FIG2:grow(1)
  work(sh, {hand="detail", tool={kind="round", width=2.2}, pile=gshad, coverage=2, fill=true, clip=sh, length={3,8}, angle=0.05, seed=seed+2})
  local base = ellipse(cx, cy - h*0.15, w*0.3, h*0.2):roughen(w*0.06, w*0.12, seed)
  stipple(base, {pile=sage_d, width=math.max(2, w*0.07), coverage=3.5, cluster=0.3, pressure={0.5,0.9}, seed=seed})
  local r = brush{kind="round", width=math.max(1.5, w*0.028), point=0.9}
  local n = math.floor(w*0.8)
  local blades = {}
  for i = 1, n do
    local t = math.random()
    local spread = (t - 0.5)*2
    local a = -math.pi/2 + spread*1.15 + (math.random()-0.5)*0.5
    local L = h*(0.5 + math.random()*0.75) * (1 - 0.35*math.abs(spread))
    local x0 = cx + spread*w*0.2 + (math.random()-0.5)*w*0.1
    local y0 = cy - h*0.02
    local droop = spread*0.5 + (math.random()-0.5)*0.3
    local x1, y1 = x0 + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5
    local a2 = a + droop
    local x2, y2 = x1 + math.cos(a2)*L*0.5, y1 + math.sin(a2)*L*0.5 + math.abs(spread)*L*0.12
    local up = clamp(-math.sin(a), 0, 1)
    blades[#blades+1] = {x0,y0,x1,y1,x2,y2, clamp(math.cos(a)*mdx + math.sin(a)*mdy, 0, 1), up}
  end
  table.sort(blades, function(p, q) return p[7] < q[7] end)
  for _, b in ipairs(blades) do
    local p
    if warm > 0 and b[8] > 0.85 and math.random() < warm then p = sage_w
    elseif b[7] > 0.75 and math.random() < 0.6 then p = sage_g
    elseif b[7] > 0.4 then p = sage_dg
    else p = sage_d end
    r:load(p, 0.6)
    r:gesture({{b[1], b[2], 0.75},{b[3], b[4], 0.5},{b[5], b[6], 0.0}}, {wobble=0.3})
  end
end
function rock2(cx, cy, w, h, seed, mdx, mdy)
  math.randomseed(seed)
  local pts = {}
  local n = 9
  for i = 0, n do
    local a = math.pi + i/n*math.pi
    local r = 1 + (math.random()-0.5)*0.35
    pts[#pts+1] = {cx + math.cos(a)*w/2*r, cy + math.sin(a)*h*r}
  end
  pts[#pts+1] = {cx + w/2*0.9, cy + h*0.12}
  pts[#pts+1] = {cx - w/2*0.9, cy + h*0.15}
  local m = poly(pts, true)
  local sh = (ellipse(cx - w*0.25, cy + h*0.2, w*0.6, h*0.28) - m):blur(1) - FIG2:grow(1)
  work(sh, {hand="detail", tool={kind="round", width=2}, pile=gshad, coverage=2.5, fill=true, clip=sh, length={3,7}, angle=0.05, seed=seed+1})
  local function lit(x,y)
    local a = 0
    for _, d in ipairs({1, 2, 3.5}) do a = a + (1 - m:at(x + mdx*d, y + mdy*d)) end
    return a/3
  end
  work(m, {hand="detail", tool={kind="filbert", width=math.max(2, w*0.18)}, piles={
     {stone_dd, function(x,y) return 0.6 + smoothstep(cy - h*0.3, cy + h*0.1, y)*1.2 end},
     {stone_d, 0.8},
     {stone_m, function(x,y) return clamp(lit(x,y)*1.8 - 0.3, 0, 1)*1.6 end}},
     coverage=3.5, fill=true, clip=m, length={2,6}, angle=0.2, seed=seed})
  local r = brush{kind="round", width=1.3, point=0.85}
  r:load(stone_l, 0.45)
  local best = {}
  for i = 1, #pts - 2 do
    local p = pts[i]
    if ((p[1]-cx)*mdx + (p[2]-cy)*mdy) > 0 then best[#best+1] = {p[1] - mdx*0.8, p[2] - mdy*0.8 + 0.6} end
  end
  if #best >= 2 then
    local g = {}
    for i, p in ipairs(best) do g[#g+1] = {p[1], p[2], (i == 1 or i == #best) and 0.1 or 0.45} end
    r:gesture(g, {clip=m:grow(0.5)})
  end
  return m
end
rock2(338, 643, 30, 8, 91, 0.6, -0.8)
rock2(612, 619, 22, 6, 92, 0.6, -0.8)
rock2(929, 641, 26, 7, 93, 0.6, -0.8)
tuft(455, 663, 74, 34, 94, 0.6, -0.8, 0.35)
tuft(562, 649, 40, 19, 95, 0.6, -0.8, 0.25)

--@ chunk 213
print(wait(2*24*60))
for _, p in ipairs({{455,650},{450,640},{562,640},{338,640},{612,617},{929,638},{740,600},{870,598},{720,592}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 214
print(wait(5*24*60))
for _, p in ipairs({{455,650},{450,640},{562,640},{338,640},{612,617},{929,638},{740,600},{870,598},{948,648}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 215
print(wait(4*24*60))
for _, p in ipairs({{455,650},{450,640},{562,640},{338,640},{612,617},{929,638},{740,600},{870,598},{948,648},{728,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 216
print(wait(5*24*60))
for _, p in ipairs({{455,650},{450,640},{562,640},{560,636},{612,617},{929,638},{740,600},{870,598},{728,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 217
local feet = ZF.skin + ZF.rags
local halo = ((ZF.rest + ZF.rest2):grow(2.5) - feet:grow(0.5)):blur(2.5) - feet
local contact = (ellipse(733, 604.5, 22, 2.6) + ellipse(864, 605.5, 17, 2.6)):blur(1.2) - feet
local M = halo + contact
print(M:area())
work(M, {hand="scumble", tool={kind="filbert", width=5}, pile=shbt, coverage=1.4, fill=true, clip=M, angle=0.05, length={6,12}, seed=42001})

--@ chunk 218
print(wait(3*24*60))
for _, p in ipairs({{722,592},{760,596},{850,594},{884,594},{733,606},{455,650},{562,640}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 219
local feet = ZF.skin + ZF.rags
local ring = ((ZF.rest + ZF.rest2):grow(4.5) - feet:grow(0.5)):blur(2)
local keep = poly(ZSHF, true) + poly(ZSHR, true) + ellipse(733, 604.5, 22, 2.6) + ellipse(864, 605.5, 17, 2.6)
local C = (ring - keep:blur(1.5)) - feet:grow(0.3)
print(C:area())
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
work(C, {hand="detail", tool={kind="filbert", width=3}, piles={
    {gf, function(x,y) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
    {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
    {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end}},
  coverage=3.5, fill=true, clip=C, length={4,10}, angle=0.02, seed=42101})

--@ chunk 220
local k = knife{width=10}
for _, box in ipairs({{702,574,772,608},{836,574,904,609}}) do
  for y = box[2], box[4], 4 do k:scrape({{box[1],y},{box[3],y}}, {pressure=1}); k:wipe() end
  for x = box[1], box[3], 4 do k:scrape({{x,box[2]},{x,box[4]}}, {pressure=1}); k:wipe() end
end
for _, p in ipairs({{715,590},{760,592},{846,590},{892,592},{745,580}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 221
local feet = ZF.skin + ZF.rags
local band = (ZP.legs * below(function(x) return 568 end) - ZF.BEL - feet:grow(0.3))
print(band:area())
work(band, {hand="detail", tool={kind="filbert", width=3}, piles={
    {ztrou2, 1},
    {legdk, 0.5},
    {zd_mid, function(x,y) local u = lat(x,y) return 1.1 * smoothstep(0.1, -0.7, u) end}},
  coverage=3.5, fill=true, clip=band, length={4,9}, angle=function(x,y) local u, w = lat(x,y) return w==0 and 1.88 or 1.12 end, seed=42201})

--@ chunk 222
local seam = ZP.legs:shrink(1) * below(function(x) return 563 end) * above(function(x) return 574 end)
work(seam, {hand="blend", tool={kind="badger", width=6}, angle=1.6, coverage=1.0})

--@ chunk 223
local feet = ZF.skin + ZF.rags
local band = (ZP.legs * below(function(x) return 565 end) * above(function(x) return 582 end) - feet:grow(0.3))
work(band, {hand="detail", tool={kind="filbert", width=3}, piles={
    {ztrou2, 1},
    {zd_mid, function(x,y) local u = lat(x,y) return 0.6 + 1.2 * smoothstep(0.2, -0.7, u) end},
    {legdk, function(x,y) return smoothstep(572, 582, y)*0.6 end}},
  coverage=2.5, fill=true, clip=band, length={4,9}, angle=function(x,y) local u, w = lat(x,y) return w==0 and 1.88 or 1.12 end, seed=42301})
work(ZP.legs:shrink(1) * below(function(x) return 560 end) * above(function(x) return 584 end), {hand="blend", tool={kind="badger", width=6}, angle=1.6, coverage=1.2})

--@ chunk 224
gnear = mix{{gd, 0.7}, {shad, 0.3}, name="gnear"}
local M = (rect(905, 622, 100, 50):roughen(6, 20, 3) - FIG2:grow(2)):soften(5)
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
work(M, {hand="body", tool={kind="filbert", width=5}, piles={{gnear, 1},{gd, function(x,y) return 0.3 + clamp(nz2(x,y),0,1)*0.3 end}},
  coverage=2.5, fill=true, clip=M, edge="lost", length={10,25}, angle=0.02, pressure={0.4,0.7}, seed=42401})

--@ chunk 225
boot_m = pile{{"raw umber",0.8},{"bone black",0.5},{"red earth",0.2},{"yellow ochre",0.15},{"lead white",0.12}, name="boot_m"}
boot_rim = pile{{"raw umber",0.5},{"lead white",0.45},{"Prussian blue",0.08},{"bone black",0.2},{"yellow ochre",0.12}, name="boot_rim"}
local bm = poly(BOOTR2, true) + poly(BOOTF2, true) + BOOTS
BOOTALL = bm
local function lit(x,y)
  local a = 0
  for _, d in ipairs({1, 2, 3}) do a = a + (1 - bm:at(x + 0.5*d, y - 0.85*d)) end
  return a/3
end
work(bm, {hand="detail", tool={kind="filbert", width=3}, piles={
    {boot2, 1},
    {boot_m, function(x,y) return clamp(lit(x,y)*1.5 - 0.2, 0, 1)*1.2 end},
    {boot_rim, function(x,y) return clamp(lit(x,y)*2 - 1.1, 0, 1)*1.0 end}},
  coverage=3.5, fill=true, clip=bm, length={3,8}, angle=0.12, seed=43001})
print(drying(300,610))

--@ chunk 226
print(palette())

--@ chunk 227
print(drying(150,610), drying(300,612))

--@ chunk 228
print(wait(5*24*60))
for _, p in ipairs({{150,610},{300,612},{180,612},{320,615},{455,650},{745,580},{760,592}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 229
print(wait(10*24*60))
for _, p in ipairs({{150,610},{300,612},{180,612},{320,615},{745,575},{870,576},{930,640},{455,650},{733,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 230
print(drying(150,610), drying(300,612))
work(BOOTALL, {hand="detail", tool={kind="filbert", width=3, lay=6}, pile=boot2, coverage=3, fill=true, clip=BOOTALL, length={3,8}, angle=0.12, seed=43101})
-- moonlit top edges (instep and toe), thin
local r = brush{kind="round", width=1.8, point=0.8}
r:load(boot_rim, 0.45)
r:gesture({{140,591,0.2},{152,594,0.45},{162,598,0.45},{172,606,0.4},{184,611,0.3},{190,615,0.1}}, {clip=BOOTALL})
r:load(boot_rim, 0.45)
r:gesture({{268,591,0.2},{282,592,0.45},{292,598,0.45},{306,604,0.4},{320,608,0.35},{331,613,0.1}}, {clip=BOOTALL})
-- dark soles
local s = brush{kind="round", width=2.2, point=0.4}
s:load(legdk, 0.7)
s:gesture({{128,624,0.6},{160,621,0.7},{189,619,0.4}}, {clip=BOOTALL:grow(1)})
s:gesture({{272,624,0.6},{300,622,0.7},{333,619,0.4}}, {clip=BOOTALL:grow(1)})

--@ chunk 231
for _, p in ipairs({{455,645},{470,640},{562,640},{575,635}}) do print(p[1],p[2],drying(p[1],p[2])) end
local m = (ellipse(456, 645, 44, 24) + ellipse(564, 638, 26, 15)):blur(5) - BOOTALL
work(m, {hand="scumble", tool={kind="filbert", width=6}, pile=shbt, coverage=1.4, fill=true, clip=m, angle=1.4, length={6,14}, seed=43201,
  load_at=function(x,y) return 0.85 end})

--@ chunk 232
local r = rag{width=14}
for k = 1, 2 do
  for y = 614, 667, 6 do r:dip(0.9); r:wipe({{404,y},{510,y}}, {pressure={0.85,0.85}}); r:refold() end
  for y = 616, 660, 6 do r:dip(0.9); r:wipe({{530,y},{600,y}}, {pressure={0.85,0.85}}); r:refold() end
end
print(r)

--@ chunk 233
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
local function poolw(x,y) local dx=(x-480)/230; local dy=(y-585)/55; return clamp(1-math.sqrt(dx*dx+dy*dy),0,1) end
local C = (ellipse(455, 646, 56, 30) + ellipse(560, 638, 33, 18)):roughen(4, 15, 9):soften(2)
print(C:area())
work(C, {hand="detail", tool={kind="filbert", width=3.5}, piles={
  {gf, function(x,y) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end},
  {gw, function(x,y) return poolw(x,y)^1.2*1.1 end}},
  coverage=3.5, fill=true, clip=C, length={5,12}, angle=0.02, seed=43301})

--@ chunk 234
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local C = (ellipse(455, 646, 56, 30) + ellipse(560, 638, 33, 18)):roughen(4, 15, 9):soften(2)
local R = C:grow(4):soften(6)
work(R, {hand="body", tool={kind="filbert", width=5}, piles={
  {gm, function(x,y) return 1.0 + clamp(nz2(x,y),0,1)*0.3 end},
  {gw, function(x,y) return smoothstep(650, 615, y)*0.9 end},
  {gd, function(x,y) return smoothstep(630, 667, y)*0.9 end}},
  coverage=2.2, fill=true, clip=C:grow(9), edge="lost", length={8,18}, angle=0.02, pressure={0.4,0.7}, seed=43401})

--@ chunk 235
local k = knife{width=10}
for y = 610, 667, 4 do k:scrape({{392,y},{604,y}}, {pressure=1}); k:wipe() end
for x = 392, 604, 4 do k:scrape({{x,608},{x,667}}, {pressure=1}); k:wipe() end
print(drying(455,640), drying(560,635))

--@ chunk 236
print(drying(455,640), drying(560,635), drying(420,620))
for k = 1, 2 do
  for y = 602, 667, 5 do
    for _, seg in ipairs({{385,500},{495,615}}) do
      local r = rag{width=14}
      r:dip(0.9); r:wipe({{seg[2],y},{seg[1],y}}, {pressure={0.85,0.85}}); r:refold(); r:dip(0.9); r:wipe({{seg[1],y},{seg[2],y}}, {pressure={0.85,0.85}})
    end
  end
end

--@ chunk 237
function darkblades(cx, cy, w, h, seed, n, lean)
  math.randomseed(seed)
  local r = brush{kind="round", width=math.max(1.5, w*0.026), point=0.9}
  for i = 1, n do
    local spread = math.random()*2 - 1
    local a = -math.pi/2 + lean + spread*1.0 + (math.random()-0.5)*0.4
    local L = h*(0.45 + math.random()*0.6) * (1 - 0.3*math.abs(spread))
    local x0 = cx + spread*w*0.18
    local y0 = cy - h*0.02
    local a2 = a + spread*0.4 + (math.random()-0.5)*0.3
    local x1, y1 = x0 + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5
    local x2, y2 = x1 + math.cos(a2)*L*0.5, y1 + math.sin(a2)*L*0.5
    r:load((math.random() < 0.75) and sage_d or sage_dg, 0.6)
    r:gesture({{x0, y0, 0.8},{x1, y1, 0.5},{x2, y2, 0.0}}, {wobble=0.3})
  end
  local base = ellipse(cx, cy - h*0.1, w*0.24, h*0.14):roughen(w*0.04, w*0.1, seed)
  stipple(base, {pile=sage_d, width=math.max(2, w*0.06), coverage=3, cluster=0.3, pressure={0.5,0.9}, seed=seed})
end
darkblades(455, 663, 74, 34, 181, 40, 0.15)
darkblades(562, 649, 40, 19, 182, 22, 0.15)

--@ chunk 238
print(wait(10*24*60))
for _, p in ipairs({{150,610},{300,612},{455,650},{562,640},{500,640},{455,655}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 239
print(wait(20*24*60))
for _, p in ipairs({{150,610},{300,612},{455,655},{180,612},{320,615}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 240
print(wait(6*24*60))
for _, p in ipairs({{320,615},{300,600},{150,605},{185,614}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 241
local r = brush{kind="round", width=1.6, point=0.85}
r:load(boot_rim, 0.4)
r:gesture({{140,591.5,0.15},{152,594.5,0.4},{161,598.5,0.4},{171,605.5,0.35},{183,610.8,0.3},{189,614.5,0.1}}, {clip=BOOTALL})
r:load(boot_rim, 0.4)
r:gesture({{268,591.5,0.15},{282,592.8,0.4},{291,598,0.4},{304,603.8,0.35},{318,607.8,0.3},{329,612.6,0.1}}, {clip=BOOTALL})
-- warm flash catch on the toe caps (they face the muzzle)
local g = brush{kind="round", width=1.6, point=0.85}
g:load(boot_lit, 0.35)
g:gesture({{326,612,0.1},{331,615,0.35},{332,619,0.15}}, {clip=BOOTALL})
g:load(boot_lit, 0.3)
g:gesture({{185,612,0.1},{189,615,0.3},{190,618,0.1}}, {clip=BOOTALL})

--@ chunk 242
print(wait(10*24*60))
for _, p in ipairs({{150,595},{300,598},{455,650},{562,640},{745,598},{870,598},{930,640},{948,648},{960,640}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 243
print(palette())

--@ chunk 244
for _, n in ipairs({"BOOTF2","BOOTR2","BOOTF","BOOTR"}) do
  local t = _G[n]
  local s = {}
  for i,p in ipairs(t) do s[#s+1] = string.format("(%.0f,%.0f)", p[1], p[2]) end
  print(n, table.concat(s, " "))
end
print(drying(150,610), drying(300,612), drying(745,598))

--@ chunk 245
-- find any spur-related code? print leg masks near boots
print(CBP and CBP.LEGM and CBP.LEGM:at(150,585), CBP.LEGM:at(280,585))
for _, p in ipairs({{118,612},{265,612},{125,612}}) do print(p[1],p[2], BOOTALL:at(p[1],p[2]), FIG2:at(p[1],p[2])) end

--@ chunk 246
local L = ZP.legs + ZF.skin + ZF.rags
for _, y in ipairs({490,500,510,520,530,540,550,560,570,580,590,595,600,604}) do
  local xs = {}
  for x = 690, 910, 0.5 do if L:at(x,y) > 0.5 then xs[#xs+1]=x end end
  if #xs>0 then
    local runs, s0, prev = {}, xs[1], xs[1]
    for i=2,#xs do if xs[i] > prev+0.6 then runs[#runs+1]=s0.."-"..prev; s0=xs[i] end prev=xs[i] end
    runs[#runs+1]=s0.."-"..prev
    print(y, table.concat(runs," "))
  else print(y,"none") end
end
-- coat hem lowest points
for _, x in ipairs({760,780,800,820,840,860,880}) do
  local yl = nil
  for y = 440, 620 do if ZALL:at(x,y) > 0.5 and ZP.legs:at(x,y) < 0.5 then yl = y end end
  print("coat bottom at x", x, yl)
end

--@ chunk 247
mshB = pile{{"bone black",1},{"raw umber",0.6},{"ultramarine blue",0.1},{"Prussian blue",0.02}, name="mshB"}
-- zombie leg shadows: from each ankle toward the viewer, converging toward the hip's shadow below the frame
ZSF = {{739,604},{757,604},{761,620},{767,640},{773,656},{778,672},{748,672},{746,656},{743,640},{740,620}}
ZSR = {{860,605},{887,605},{881,620},{867,640},{853,656},{843,672},{806,672},{816,656},{830,640},{846,620}}
local FEET = ZF.skin + ZF.rags
local LEGSX = FIG2 + FEET + BOOTALL
local base = poly(ZSF, true) + poly(ZSR, true)
local CT = ellipse(735, 604.8, 22, 2.3) + ellipse(867, 605.8, 18, 2.3)
local S = base:blur(1.2):times(function(x,y) return 1 - smoothstep(608,660,y) end) + base:blur(4.5):times(function(x,y) return smoothstep(608,660,y) end) + CT:blur(1)
ZSHAD = S
local rocks = ellipse(929, 639, 17, 9) + ellipse(612, 618, 13, 7)
local R = poly({{693,597},{900,598},{904,630},{899,667},{628,667},{660,635}}, true):roughen(5, 25, 17):soften(5) - LEGSX:grow(0.5) - rocks
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
local function poolw(x,y) local dx=(x-480)/230; local dy=(y-585)/55; return clamp(1-math.sqrt(dx*dx+dy*dy),0,1) end
local function sdir(x,y) if x < 795 then return 1.36 end return 2.21 end
work(R, {hand="detail", tool={kind="filbert", width=3}, piles={
  {gf, function(x,y) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end},
  {gw, function(x,y) return poolw(x,y)^1.2*1.1 end},
  {mshB, function(x,y) return S:at(x,y)*10 end}},
  coverage=3.5, fill=true, clip=R:grow(10) - LEGSX:grow(0.5) - rocks, edge="lost", length={4,9},
  angle=function(x,y) if S:at(x,y) > 0.03 then return sdir(x,y) else return 0.02 end end, seed=63001})
print(drying(760,640))

--@ chunk 248
local FEET = ZF.skin + ZF.rags
for _, p in ipairs({{885,603},{890,604},{880,606},{715,602},{712,603},{725,605},{745,606},{870,607}}) do
  print(p[1],p[2], "FIG2", string.format("%.2f", FIG2:at(p[1],p[2])), "feet", string.format("%.2f", FEET:at(p[1],p[2])), "legs", string.format("%.2f", ZP.legs:at(p[1],p[2])), "BOOT", BOOTALL:at(p[1],p[2]), drying(p[1],p[2]))
end

--@ chunk 249
local FEET = ZF.skin + ZF.rags
local OLDR = (ZP.legs:grow(2.5) * ZF.BEL) - FEET:grow(0.3)
print(OLDR:area())
local S = ZSHAD
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
local function sdir(x,y) if x < 795 then return 1.36 end return 2.21 end
work(OLDR, {hand="detail", tool={kind="filbert", width=2.2}, piles={
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end},
  {mshB, function(x,y) return S:at(x,y)*10 end}},
  coverage=3.5, fill=true, clip=OLDR, length={3,7},
  angle=function(x,y) if S:at(x,y) > 0.03 then return sdir(x,y) else return 0.02 end end, seed=63002})

--@ chunk 250
print(drying(700,630), drying(800,620), drying(880,640), drying(745,606))
local k = knife{width=10}
local box = {624, 594, 912, 667}
for y = box[2], box[4], 4 do k:scrape({{box[1],y},{box[3],y}}, {pressure=1}); k:wipe() end
for x = box[1], box[3], 4 do k:scrape({{x,box[2]},{x,box[4]}}, {pressure=1}); k:wipe() end
print(drying(700,630), drying(800,620), drying(880,640), drying(745,606))

--@ chunk 251
local FEET = ZF.skin + ZF.rags
local LEGSX = FIG2 + FEET + BOOTALL
local rocks = ellipse(929, 639, 17, 9) + ellipse(612, 618, 13, 7)
local R = poly({{693,596},{902,597},{906,630},{901,667},{624,667},{656,633}}, true):roughen(5, 25, 17):soften(5) - LEGSX:grow(0.5) - rocks
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
local function poolw(x,y) local dx=(x-480)/230; local dy=(y-585)/55; return clamp(1-math.sqrt(dx*dx+dy*dy),0,1) end
work(R, {hand="detail", tool={kind="filbert", width=3}, piles={
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 + 0.25 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end},
  {gw, function(x,y) return poolw(x,y)^1.2*1.1 end}},
  coverage=3.5, fill=true, clip=R:grow(12) - LEGSX:grow(0.5) - rocks, edge="lost", length={4,10}, angle=0.02, seed=63101})

--@ chunk 252
local FEET = ZF.skin + ZF.rags
local LEGSX = FIG2 + FEET + BOOTALL
local base = poly(ZSF, true) + poly(ZSR, true)
local CT = ellipse(735, 604.8, 22, 2.3) + ellipse(867, 605.8, 18, 2.3)
local function t(y) return smoothstep(606, 662, y) end
local Sm = (base:blur(1.0):times(function(x,y) return 1 - t(y) end) + base:blur(3.5):times(t) + CT:blur(0.8)) - LEGSX:grow(0.3)
ZSHAD2 = Sm
local function sdir(x,y) if x < 795 then return 1.56 end return 2.19 end
work(Sm, {hand="detail", tool={kind="filbert", width=3}, piles={
  {mshB, function(x,y) return 1.0 - 0.45*t(y) end},
  {gd, function(x,y) return 0.45 + 0.5*t(y) end}},
  coverage=3, fill=true, clip=Sm, length={5,12}, angle=sdir, seed=63201})

--@ chunk 253
local function t(y) return smoothstep(606, 662, y) end
local Sm = ZSHAD2
local function sdir(x,y) if x < 795 then return 1.56 end return 2.19 end
work(Sm:shrink(0.8), {hand="detail", tool={kind="filbert", width=3}, pile=mshB,
  load_at=function(x,y) return 0.8 - 0.45*t(y) end,
  coverage=1.8, fill=true, clip=Sm, length={5,12}, angle=sdir, seed=63301})

--@ chunk 254
-- cowboy's moon shadow, opaque like the zombie's: ground repaint wet, then shadow piles into it
CSR = {{191,622},{150,622},{127,624},{90,632},{50,640},{0,651},{0,664},{50,654},{95,644},{130,634},{170,627},{191,625}}
CSF = {{334,620},{300,621},{273,624},{240,634},{205,645},{170,656},{140,668},{188,668},{215,656},{250,644},{285,633},{320,626}}
CSC = {{0,654},{60,644},{120,640},{170,645},{210,652},{196,668},{0,668}}
local CB = BOOTALL + FIG2
local rock = ellipse(338, 641, 19, 9)
local R = poly({{0,610},{352,612},{356,640},{346,667},{0,667}}, true):roughen(5, 25, 21):soften(5) - CB:grow(0.5) - rock
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
work(R, {hand="detail", tool={kind="filbert", width=3}, piles={
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 + 0.25 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end}},
  coverage=3.5, fill=true, clip=R:grow(12) - CB:grow(0.5) - rock, edge="lost", length={4,10}, angle=0.02, seed=64001})
local base = poly(CSR, true) + poly(CSF, true) + poly(CSC, true)
local CT = ellipse(158, 623.5, 33, 2.4) + ellipse(303, 622, 32, 2.4)
local function t(x,y) return smoothstep(10, 90, math.sqrt((x-230)^2 + ((y-622)*3)^2) - 70) end
local Sm = (base:blur(1.0):times(function(x,y) return 1 - t(x,y) end) + base:blur(3.5):times(t) + CT:blur(0.8)) - CB:grow(0.3) - rock
CSHAD = Sm
work(Sm, {hand="detail", tool={kind="filbert", width=3}, piles={
  {mshB, function(x,y) return 1.0 - 0.45*t(x,y) end},
  {gd, function(x,y) return 0.45 + 0.5*t(x,y) end}},
  coverage=3, fill=true, clip=Sm, length={5,12}, angle=2.86, seed=64002})
work(Sm:shrink(0.8), {hand="detail", tool={kind="filbert", width=3}, pile=mshB,
  load_at=function(x,y) return 0.8 - 0.45*t(x,y) end,
  coverage=1.8, fill=true, clip=Sm, length={5,12}, angle=2.86, seed=64003})
print(drying(150,640))

--@ chunk 255
print(wait(6*24*60))
for _, p in ipairs({{150,640},{300,630},{760,640},{840,640},{700,610},{880,615},{40,655}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 256
print(wait(8*24*60))
for _, p in ipairs({{150,640},{300,630},{760,640},{840,640},{700,610},{880,615},{40,655}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 257
local CB = BOOTALL + FIG2
local rock = ellipse(338, 641, 19, 9)
-- the coat's shadow: everything left of the hem's shadow line, merging the rear-leg strip and the coat band
local EXT = poly({{0,607},{40,609},{90,613},{128,618},{150,623},{168,630},{184,641},{196,654},{204,668},{0,668}}, true)
local M = (EXT:blur(2.5) - CB:grow(0.3) - rock)
local function t(x,y) return smoothstep(10, 90, math.sqrt((x-230)^2 + ((y-622)*3)^2) - 70) end
work(M, {hand="detail", tool={kind="filbert", width=3}, piles={
  {mshB, function(x,y) return 1.0 - 0.45*t(x,y) end},
  {gd, function(x,y) return 0.45 + 0.5*t(x,y) end}},
  coverage=3, fill=true, clip=M, length={5,12}, angle=2.86, seed=64101})
work(M:shrink(1.5), {hand="detail", tool={kind="filbert", width=3}, pile=mshB,
  load_at=function(x,y) return 0.8 - 0.45*t(x,y) end,
  coverage=1.8, fill=true, clip=M, length={5,12}, angle=2.86, seed=64102})

--@ chunk 258
print(drying(60,630), drying(150,640))
local k = knife{width=10}
local box = {0, 600, 212, 667}
for y = box[2], box[4], 4 do k:scrape({{box[1],y},{box[3],y}}, {pressure=1}); k:wipe() end
for x = box[1], box[3], 4 do k:scrape({{x,box[2]},{x,box[4]}}, {pressure=1}); k:wipe() end

--@ chunk 259
for k = 1, 2 do
  for y = 603, 667, 5 do
    local r = rag{width=14}
    r:dip(0.9); r:wipe({{208,y},{0,y}}, {pressure={0.85,0.85}})
    r = rag{width=14}
    r:dip(0.9); r:wipe({{0,y},{208,y}}, {pressure={0.85,0.85}})
  end
end
print(drying(60,630), drying(150,640))

--@ chunk 260
print(wait(10*24*60))
for _, p in ipairs({{60,630},{150,640},{100,650},{250,640},{300,630}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 261
local CB = BOOTALL + FIG2
local Mx = poly({{0,588},{120,592},{150,606},{140,618},{100,626},{50,636},{0,644}}, true):roughen(4, 20, 31):soften(4) - CB:grow(0.5) - CSHAD:grow(1.5)
print(Mx:area())
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
work(Mx, {hand="detail", tool={kind="filbert", width=3}, piles={
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 + 0.25 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end}},
  coverage=3.5, fill=true, clip=Mx:grow(6) - CB:grow(0.5) - CSHAD:grow(1.5), edge="lost", length={4,10}, angle=0.02, seed=64201})

--@ chunk 262
print(wait(10*24*60))
for _, p in ipairs({{60,610},{100,600},{60,640},{760,640},{840,640}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 263
print(wait(6*24*60))
for _, p in ipairs({{60,610},{30,615},{120,600},{10,630}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 264
print(drying(948,650), drying(940,645))
local r = brush{kind="rigger", width=1.6, point=1}
r:load(sig, 0.6)
r:gesture({{948,644,0.3},{943,642,0.6},{939,646,0.7},{939,652,0.7},{943,656,0.6},{948,655,0.3}})
r:gesture({{952,640,0.3},{951,648,0.6},{951,656,0.5},{953,657,0.2}})
r:load(sig, 0.4)
r:gesture({{938,661,0.2},{950,660,0.5},{964,658,0.2}})

--@ chunk 265
print(wait(10*24*60))
for _, p in ipairs({{943,650},{951,648},{60,610},{760,640},{150,640}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 266
local function dump(n, t) local s = {} for i, p in ipairs(t) do s[#s+1] = string.format("(%.0f,%.0f)", p[1], p[2]) end print(n, table.concat(s, " ")) end
dump("BOOTF2", BOOTF2) dump("BOOTR2", BOOTR2)
print(drying(150,610), drying(300,610), drying(750,640))

--@ chunk 267
print(cavity, boot2, boot_m, boot_rim, boot_lit)
print(BOOTALL:area(), BOOTS:area())

--@ chunk 268
print(trou2, legdk)
-- trouser leg extents near the boots
for _, y in ipairs({550, 570, 585, 592}) do
  local xs = {}
  local inside = false
  for x = 100, 360, 0.5 do local v = CBP.LEGM:at(x,y) > 0.5; if v ~= inside then xs[#xs+1] = x; inside = v end end
  print(y, table.concat(xs, " "))
end

--@ chunk 269
for _, y in ipairs({600, 605, 610, 615, 618, 620, 622, 624, 626, 628}) do
  local xs = {}
  local inside = false
  for x = 100, 360, 0.5 do local v = BOOTALL:at(x,y) > 0.5; if v ~= inside then xs[#xs+1] = x; inside = v end end
  print(y, table.concat(xs, " "))
end

--@ chunk 270
spur_l = pile{{"lead white",0.6},{"bone black",0.18},{"Prussian blue",0.05},{"raw umber",0.12}, name="spur_l"}
spur_m = pile{{"lead white",0.25},{"bone black",0.4},{"Prussian blue",0.05},{"raw umber",0.3}, name="spur_m"}
HEELR = poly({{121.5,618.5},{142,619.2},{143.5,621},{140,627},{128,627},{124.5,622.5}})
HEELF = poly({{268.5,620.5},{284,620.5},{285.5,622},{282.5,627},{271,627},{269,624}})
local H = HEELR + HEELF
work(H, {hand="detail", tool={kind="filbert", width=2.4, lay=3}, pile=boot2, coverage=3, fill=true, clip=H, length={2,5}, angle=0.0, seed=70001})
print(drying(130,623), drying(276,623))

--@ chunk 271
-- dark welt along each sole, heel front to toe
local s = brush{kind="round", width=1.6, point=0.6}
s:load(legdk, 0.6)
s:gesture({{143,621.6,0.5},{160,621.4,0.6},{178,620.6,0.5},{189,619.6,0.2}})
s:load(legdk, 0.6)
s:gesture({{286,622,0.5},{305,621.6,0.6},{323,621,0.5},{334,619.6,0.2}})
-- spurs: heel band, shank, star rowel; moon catching the top
local function spur(x0, x1, y, sx, sy, cx, cy, R, rot)
  local b = brush{kind="round", width=1.6, point=0.8}
  b:load(spur_m, 0.55)
  b:gesture({{x0,y+0.2,0.3},{(x0+x1)/2,y-0.2,0.6},{x1,y,0.65},{sx,sy,0.55},{cx+1.5,cy-0.2,0.4}})
  local r = brush{kind="round", width=1.0, point=0.9}
  for i = 0, 7 do
    local a = i * math.pi/4 + rot
    r:load(spur_m, 0.45)
    r:gesture({{cx + math.cos(a)*0.8, cy + math.sin(a)*0.8, 0.6}, {cx + math.cos(a)*R, cy + math.sin(a)*R, 0.05}})
  end
  local w = brush{kind="round", width=1.8, point=0.3}
  w:load(spur_m, 0.5)
  w:touch(cx, cy, {pressure=0.6})
  local g = brush{kind="round", width=1.0, point=0.9}
  g:load(spur_l, 0.45)
  g:gesture({{cx+0.3, cy-0.6, 0.4}, {cx+1.6, cy-3.6, 0.05}})
  g:load(spur_l, 0.45)
  g:gesture({{cx-0.4, cy-0.6, 0.4}, {cx-2.6, cy-3.0, 0.05}})
  g:load(spur_l, 0.3)
  g:gesture({{x1+2,y-0.1,0.1},{x1+6,y-0.6,0.35},{x1+10,y-0.7,0.1}})
end
spur(143, 123, 617.2, 115.5, 619.4, 110.5, 620.3, 4.6, 0.35)
spur(285.5, 269.5, 619.0, 262.5, 620.6, 257.5, 621.5, 4.6, 0.2)
print(drying(110,620), drying(257,621))

--@ chunk 272
print(wait(12*24*60))
for _, p in ipairs({{110,620},{257,621},{130,623},{276,623},{160,621},{305,621}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 273
print(wait(20*24*60))
for _, p in ipairs({{130,623},{276,623},{135,625},{280,625}}) do print(p[1],p[2],drying(p[1],p[2])) end
