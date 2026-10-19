-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
CB = {
 crown = {{198,186},{197,165},{200,150},{208,142},{216,147},{222,141},{231,144},{236,156},{238,170},{239,186}},
 brim = {{163,184},{172,187},{200,189},{240,189},{262,190},{273,187},{271,194},{250,198},{220,198},{190,196},{170,192}},
 head = {{198,190},{236,190},{238,201},{247,210},{240,214},{241,218},{239,221},{240,224},{238,231},{230,236},{212,234},{200,226},{195,205}},
 neck = {{203,228},{230,234},{236,252},{222,264},{198,258}},
 coat = {{184,258},{226,250},{246,262},{254,285},{256,320},{258,360},{260,400},{268,440},{280,490},{294,532},{262,538},{230,535},{200,540},{160,543},{120,546},{85,548},{60,544},{92,490},{120,440},{150,390},{172,340},{176,300}},
 leg_r = {{150,530},{192,530},{178,560},{164,590},{156,604},{170,608},{174,619},{112,621},{108,612},{124,602},{134,580},{140,555}},
 leg_f = {{230,530},{272,530},{280,560},{290,588},{294,602},{322,609},{328,620},{272,622},{270,606},{262,582},{244,554}},
 arm = {{196,262},{240,255},{290,251},{335,249},{362,246},{364,270},{335,273},{295,281},{258,293},{230,298}},
 fan = {{255,305},{300,290},{340,272},{366,252},{380,240},{392,238},{394,250},{380,262},{350,284},{310,304},{262,322}},
 hand = {{356,246},{372,243},{386,245},{388,262},{380,273},{360,273}},
 gun = {{376,241},{384,239},{447,240},{447,250},{404,252},{399,266},{395,283},{380,285},{382,266},{372,258}},
 crown2 = {{200,188},{199,172},{203,162},{210,157},{218,161},{224,156},{232,159},{236,168},{238,178},{239,188}},
 brim2 = {{157,174},{163,182},{176,188},{200,191},{240,192},{262,190},{274,184},{281,175},{283,181},{278,191},{262,197},{240,199},{200,199},{176,196},{162,190},{155,181}},
 gun2 = {{380,236},{386,233},{392,236},{404,236},{406,239},{450,239},{452,241},{452,249},{406,250},{405,254},{390,256}},
}
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
local old = nil
for _, k in ipairs({"crown","brim","head","neck","coat","leg_r","leg_f","arm","fan","hand","crown2","brim2"}) do local p = poly(CB[k], true); old = old and old + p or p end
old = old + poly(CB.gun,true) + poly(CB.gun2,false)
local new = nil
for _, k in ipairs({"crown","brim","head","neck","band","btail","coat","arm","hand","grip","farm","legr","legf"}) do local p = poly(C2[k], true); new = new and new + p or p end
new = new + poly(C2.gun,false)
local blk = pile{{"bone black",1}}
local red = pile{{"cadmium red",1},{"lead white",0.5}}
local grn = pile{{"emerald green",1},{"lead white",0.5}}
work(old - new, {hand="detail", pile=red, coverage=3, fill=true, clip=true})
work(old * new, {hand="detail", pile=blk, coverage=2, fill=true, clip=true})
work(new - old, {hand="detail", pile=grn, coverage=3, fill=true, clip=true})

--@ chunk 3
ZB = {
 head = {{752,252},{748,240},{756,234},{760,224},{772,216},{788,218},{800,230},{804,248},{798,264},{786,272},{772,280},{762,284},{756,276},{760,264}},
 neck = {{770,268},{792,262},{792,298},{764,300}},
 torso = {{728,312},{742,298},{766,290},{792,294},{812,312},{826,345},{832,385},{828,420},{815,448},{790,452},{776,430},{762,395},{748,360},{734,335}},
 tails = {{820,400},{838,428},{852,456},{866,480},{852,476},{846,492},{834,472},{824,484},{816,460},{805,448}},
 arm1 = {{752,308},{725,316},{698,326},{668,330},{640,326},{616,318},{610,326},{638,338},{668,344},{700,342},{730,334},{756,330}},
 arm2 = {{770,296},{742,289},{712,282},{682,274},{658,264},{638,258},{634,267},{656,278},{684,290},{716,300},{746,309}},
 leg1 = {{778,436},{806,446},{792,480},{776,520},{762,556},{754,590},{752,600},{716,606},{712,598},{730,590},{738,556},{748,516},{764,476}},
 leg2 = {{800,444},{824,440},{834,476},{850,512},{866,548},{880,584},{890,603},{872,608},{864,598},{856,584},{838,550},{818,516},{804,480}},
 hunch = {{786,292},{806,296},{822,308},{834,330},{838,352},{830,360},{818,338},{802,316}},
 jaw = {{758,262},{750,270},{744,280},{746,290},{756,292},{764,284},{768,272}},
 arm1b = {{752,306},{725,312},{698,320},{668,322},{640,318},{618,312},{612,322},{638,334},{668,341},{700,342},{730,338},{758,334}},
 arm2b = {{768,293},{742,285},{712,277},{682,268},{658,259},{638,254},{632,265},{654,277},{684,289},{716,300},{748,308}},
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
local old = nil
for _, k in ipairs({"head","neck","torso","tails","arm1","arm2","leg1","leg2","hunch","jaw","arm1b","arm2b"}) do local p = poly(ZB[k], true); old = old and old + p or p end
local new = nil
for _, k in ipairs({"head","neck","torso","tails","armn","armf","handn","handf","leg1","leg2"}) do local p = poly(Z2[k], true); new = new and new + p or p end
local blk = pile{{"bone black",1}}
local red = pile{{"cadmium red",1},{"lead white",0.5}}
local grn = pile{{"emerald green",1},{"lead white",0.5}}
work(old - new, {hand="detail", pile=red, coverage=3, fill=true, clip=true})
work(old * new, {hand="detail", pile=blk, coverage=2, fill=true, clip=true})
work(new - old, {hand="detail", pile=grn, coverage=3, fill=true, clip=true})

--@ chunk 4
s2 = pile{{"Prussian blue",0.6},{"ultramarine blue",0.4},{"bone black",0.35},{"lead white",1.2},{"raw umber",0.15}, name="s2"}
hot = pile{{"lead white",3},{"Naples yellow",1},{"cadmium yellow",0.5}, name="hot"}
warm = pile{{"lead white",2},{"yellow ochre",0.7},{"orange vermilion",0.25},{"Naples yellow",0.4}, name="warm"}
mgray = mix{{warm,0.5},{s2,0.5}, name="mgray"}
work(rect(500,20,480,280), {hand="broad", pile=s2, coverage=2.2, fill=true, angle=0.03})
wait(3*24*60)
GLOW = {x=700, y=160}
local gx, gy = GLOW.x, GLOW.y
local function d(x,y) return math.sqrt(((x-gx)/1.25)^2+(y-gy)^2) end
work(ellipse(gx, gy, 125, 100):soften(10), {hand="body", tool="filbert 12", piles={
   {hot, function(x,y) return clamp(1-d(x,y)/34,0,1)*3 end},
   {warm, function(x,y) return clamp(1-math.abs(d(x,y)-38)/25,0,1)*1.5 end},
   {mgray, function(x,y) return clamp(1-math.abs(d(x,y)-66)/24,0,1) end},
   {s2, function(x,y) return clamp((d(x,y)-74)/18,0,1)*2 end}},
   coverage=2.2, fill=true, length={15,40}, angle=function(x,y) return math.atan(y-gy, x-gx) + 1.57 end, curve={0.3,0.1}, pressure={0.4,0.7}})
wait(10*24*60)
print(drying(700,160), drying(640,160))

--@ chunk 5
flame_w = pile{{"lead white",3},{"lemon chrome",0.5}, name="flame_w"}
flame_y = pile{{"lead white",1},{"cadmium yellow",1},{"lemon chrome",0.3}, name="flame_y"}
flame_o = pile{{"cadmium yellow",1},{"orange vermilion",0.6},{"lead white",0.2}, name="flame_o"}
gunm = pile{{"bone black",1},{"raw umber",1},{"Prussian blue",0.3}, name="gunm"}
-- a stand-in gun barrel ending at the muzzle
local mx, my = 668, 159
work(rect(600,154,68,10), {hand="detail", pile=gunm, coverage=3, fill=true, clip=true})
function flame_at(mx, my, seed)
  local P = function(dx, dy, c) local t = {mx+dx, my+dy}; if c then t[3] = "c" end; return t end
  local o = outline{P(0,-5), P(10,-11), P(22,-21,true), P(30,-14), P(46,-19,true), P(55,-9), P(90,-3,true), P(60,4), P(74,15,true), P(48,11), P(33,22,true), P(19,11), P(0,5), closed=true, char="soft", seed=seed, amount=0.5, edge=2.5}
  local fm = o:mask()
  local function df(x,y) return math.sqrt(((x-mx-4)/1.9)^2+(y-my)^2) end
  local ang = function(x,y) return math.atan(y-my, x-mx+6) end
  work(fm, {hand="body", tool={kind="filbert", width=6}, pile=flame_o, coverage=2, fill=true, length={10,24}, angle=ang, clip=true, pressure={0.5,0.8}})
  work(fm * ellipse(mx+28, my, 46, 15):soften(6), {hand="body", tool={kind="filbert", width=6, lay=2}, pile=flame_y, coverage=2, fill=true, length={10,26}, angle=ang, clip=true, pressure={0.5,0.8}})
  local bw = brush{kind="filbert", width=9, lay=6, stiffness=0.6}
  bw:load(flame_w, 1.0)
  bw:gesture({{mx+1, my, 1.0},{mx+14, my-1, 0.95},{mx+28, my, 0.5},{mx+40, my, 0.0}})
  bw:load(flame_w, 0.8)
  bw:gesture({{mx+1, my+2, 0.8},{mx+14, my+3, 0.6},{mx+24, my+4, 0.0}})
  return fm
end
FLM = flame_at(mx, my, 9)
sparks = pile{{"cadmium yellow",1},{"lead white",1},{"lemon chrome",0.4}, medium=0.4, name="sparks"}
local sb = brush{kind="round", width=6}
sb:load(sparks, 0.9)
print(sb:spatter{at={mx+20, my}, toward={110, 0}, spread=0.45, force=0.7})
sb:load(sparks, 0.6)
print(sb:spatter{at={mx+10, my}, toward={70, -20}, spread=0.6, force=0.4})

--@ chunk 6
work(rect(480,320,500,330), {hand="broad", pile=s2, coverage=2.6, fill=true, angle=0.03})
wait(3*24*60)
local gx, gy = 720, 480
local function d(x,y) return math.sqrt(((x-gx)/1.25)^2+(y-gy)^2) end
work(ellipse(gx, gy, 125, 100):soften(10), {hand="body", tool="filbert 12", piles={
   {hot, function(x,y) return clamp(1-d(x,y)/34,0,1)*3 end},
   {warm, function(x,y) return clamp(1-math.abs(d(x,y)-38)/25,0,1)*1.5 end},
   {mgray, function(x,y) return clamp(1-math.abs(d(x,y)-66)/24,0,1) end},
   {s2, function(x,y) return clamp((d(x,y)-74)/18,0,1)*2 end}},
   coverage=2.2, fill=true, length={15,40}, angle=function(x,y) return math.atan(y-gy, x-gx) + 1.57 end, curve={0.3,0.1}, pressure={0.4,0.7}})
wait(10*24*60)
print(drying(720,480))
work(rect(620,474,68,10), {hand="detail", pile=gunm, coverage=3, fill=true, clip=true})

--@ chunk 7
flame_p = pile{{"lead white",2},{"cadmium yellow",1},{"orange vermilion",0.25}, name="flame_p"}
function flame2_at(mx, my, seed)
  local P = function(dx, dy, c) local t = {mx+dx, my+dy}; if c then t[3] = "c" end; return t end
  local o = outline{P(0,-6), P(12,-13), P(24,-22,true), P(32,-14), P(48,-18,true), P(58,-8), P(92,-2,true), P(62,5), P(76,15,true), P(50,12), P(34,22,true), P(20,12), P(0,6), closed=true, char="soft", seed=seed, amount=0.5, edge=3}
  local fm = o:mask()
  local nz = noise{seed=seed, period=14, octaves=2}
  local function df(x,y) return math.sqrt(((x-mx-6)/2.0)^2+(y-my)^2) * (1+0.2*nz(x,y)) end
  local ang = function(x,y) return math.atan(y-my, x-mx+6) end
  work(fm, {hand="body", tool={kind="filbert", width=5}, piles={
     {flame_o, function(x,y) return clamp((df(x,y)-13)/6,0,1)*1.5 end},
     {flame_p, function(x,y) return clamp(1-math.abs(df(x,y)-12)/6,0,1) end},
     {flame_y, function(x,y) return clamp(1-(df(x,y)-4)/8,0,1)*1.5 end}},
     coverage=2.4, fill=true, length={8,22}, angle=ang, clip=true, pressure={0.5,0.8}})
  local bw = brush{kind="filbert", width=10, lay=7, stiffness=0.6}
  bw:load(flame_w, 1.0)
  bw:gesture({{mx+1, my, 1.0},{mx+16, my-1, 1.0},{mx+34, my, 0.6},{mx+50, my-1, 0.0}})
  bw:load(flame_w, 1.0)
  bw:gesture({{mx+1, my+3, 0.9},{mx+14, my+5, 0.7},{mx+26, my+7, 0.0}})
  bw:gesture({{mx+1, my-3, 0.9},{mx+14, my-6, 0.7},{mx+24, my-9, 0.0}})
  return fm
end
flame2_at(688, 479, 9)
local sb = brush{kind="round", width=6}
sb:load(sparks, 0.9)
sb:spatter{at={708, 479}, toward={120, 0}, spread=0.4, force=0.5}
sb:load(sparks, 0.6)
sb:spatter{at={700, 479}, toward={80, -25}, spread=0.6, force=0.3}

--@ chunk 8
work(rect(480,320,500,330) - rect(0,0,1000,0), {hand="broad", pile=s2, coverage=2.6, fill=true, angle=0.03})
wait(3*24*60)
local gx, gy = 720, 480
local function d(x,y) return math.sqrt(((x-gx)/1.25)^2+(y-gy)^2) end
work(ellipse(gx, gy, 125, 100):soften(10), {hand="body", tool="filbert 12", piles={
   {hot, function(x,y) return clamp(1-d(x,y)/34,0,1)*3 end},
   {warm, function(x,y) return clamp(1-math.abs(d(x,y)-38)/25,0,1)*1.5 end},
   {mgray, function(x,y) return clamp(1-math.abs(d(x,y)-66)/24,0,1) end},
   {s2, function(x,y) return clamp((d(x,y)-74)/18,0,1)*2 end}},
   coverage=2.2, fill=true, length={15,40}, angle=function(x,y) return math.atan(y-gy, x-gx) + 1.57 end, curve={0.3,0.1}, pressure={0.4,0.7}})
wait(10*24*60)
work(rect(620,474,68,10), {hand="detail", pile=gunm, coverage=3, fill=true, clip=true})
flame_y2 = pile{{"lead white",2.2},{"cadmium yellow",1},{"lemon chrome",0.4}, name="flame_y2"}
function flame3_at(mx, my, seed)
  local P = function(dx, dy, c) local t = {mx+dx, my+dy}; if c then t[3] = "c" end; return t end
  local o = outline{P(0,-6), P(12,-13), P(24,-22,true), P(32,-14), P(48,-18,true), P(58,-8), P(92,-2,true), P(62,5), P(76,15,true), P(50,12), P(34,22,true), P(20,12), P(0,6), closed=true, char="soft", seed=seed, amount=0.5, edge=3}
  local fm = o:mask()
  local ang = function(x,y) return math.atan(y-my, x-mx+6) end
  work(fm, {hand="body", tool={kind="filbert", width=5, lay=2}, pile=flame_y2, coverage=2.4, fill=true, length={8,22}, angle=ang, clip=true, pressure={0.5,0.8}})
  work(fm - fm:shrink(3.5) - ellipse(mx+10, my, 22, 9), {hand="detail", tool={kind="round", width=2.5}, pile=flame_o, coverage=2, fill=true, length={4,10}, angle=ang, clip=true})
  local bw = brush{kind="filbert", width=10, lay=7, stiffness=0.6}
  bw:load(flame_w, 1.0)
  bw:gesture({{mx+1, my, 1.0},{mx+16, my-1, 1.0},{mx+34, my, 0.6},{mx+50, my-1, 0.0}})
  bw:load(flame_w, 1.0)
  bw:gesture({{mx+1, my+3, 0.9},{mx+14, my+5, 0.7},{mx+26, my+7, 0.0}})
  bw:gesture({{mx+1, my-3, 0.9},{mx+14, my-6, 0.7},{mx+24, my-9, 0.0}})
  return fm
end
flame3_at(688, 479, 9)
local sb = brush{kind="round", width=6}
sb:load(sparks, 0.9)
sb:spatter{at={708, 479}, toward={120, 0}, spread=0.4, force=0.5}

--@ chunk 9
ichor = pile{{"bone black",1},{"green earth",0.6},{"Indian red",0.35},{"raw umber",0.3}, medium=0.45, name="ichor"}
ichor_l = pile{{"green earth",1},{"yellow ochre",0.4},{"bone black",0.3},{"lead white",0.25}, medium=0.4, name="ichor_l"}
-- dark head-ish blob to emit from
work(ellipse(600, 200, 30, 35), {hand="detail", pile=gunm, coverage=3, fill=true, clip=true})
local b = brush{kind="round", width=8}
b:load(ichor, 0.9)
print(b:spatter{at={630, 195}, toward={110, -45}, spread=0.45, force=0.6})
b:load(ichor, 0.9)
print(b:spatter{at={630, 200}, toward={70, -20}, spread=0.6, force=0.3})
local b2 = brush{kind="round", width=5}
b2:load(ichor_l, 0.8)
print(b2:spatter{at={630, 192}, toward={90, -50}, spread=0.35, force=0.5})

--@ chunk 10
sand_far = pile{{"lead white",1.2},{"green earth",0.4},{"yellow ochre",0.35},{"raw umber",0.3},{"Prussian blue",0.12},{"bone black",0.1}, name="sand_far"}
sand_mid = pile{{"lead white",0.6},{"raw umber",0.6},{"green earth",0.4},{"yellow ochre",0.25},{"bone black",0.25},{"ultramarine blue",0.15}, name="sand_mid"}
local m = rect(50, 400, 400, 220)
work(m, {hand="body", tool="filbert 12", piles={{sand_far, function(x,y) return clamp((450-y)/100+0.5,0,1) end},{sand_mid, function(x,y) return clamp((y-480)/100,0,1)+0.3 end}}, coverage=2.2, fill=true, angle=0.02, length={25,70}})
wait(10*24*60)
nglaze = pile{{"ultramarine blue",0.5},{"raw umber",0.6},{"bone black",0.35}, medium=0.8, name="nglaze"}
nglaze2 = pile{{"ultramarine blue",0.5},{"raw umber",0.6},{"bone black",0.35}, medium=0.7, name="nglaze2"}
work(rect(60,410,180,200), {hand="glaze", pile=nglaze, coverage=1.2, angle=0.0})
work(rect(260,410,180,200), {hand="glaze", pile=nglaze2, coverage=2.0, angle=0.0})

--@ chunk 11
local m = rect(50, 640-0, 400, 0)
work(rect(500, 400, 450, 220), {hand="body", tool="filbert 12", piles={{sand_far, function(x,y) return clamp((450-y)/100+0.5,0,1) end},{sand_mid, function(x,y) return clamp((y-480)/100,0,1)+0.3 end}}, coverage=2.2, fill=true, angle=0.02, length={25,70}})
wait(10*24*60)
nglaze3 = pile{{"raw umber",0.7},{"ultramarine blue",0.25},{"bone black",0.25},{"green earth",0.3}, medium=0.82, name="nglaze3"}
work(rect(510,410,200,200), {hand="glaze", pile=nglaze3, coverage=2.2, fill=true, angle=0.0})
blend(rect(515,415,190,190), {angle=0.0})
-- body darker repaint alternative
gn_dk = pile{{"raw umber",1},{"bone black",0.45},{"green earth",0.4},{"ultramarine blue",0.2},{"lead white",0.18},{"yellow ochre",0.1}, name="gn_dk"}
work(rect(730,410,200,200), {hand="body", tool="filbert 10", piles={{gn_dk,1},{sand_mid,0.35}}, coverage=1.8, fill=true, angle=0.02, length={25,60}, pressure={0.4,0.7}})

--@ chunk 12
work(rect(40, 20, 920, 150), {hand="body", tool="filbert 12", piles={{sand_far,1},{sand_mid,0.6}}, coverage=2.2, fill=true, angle=0.02, length={25,70}})
wait(10*24*60)
gf = pile{{"lead white",1},{"green earth",0.4},{"raw umber",0.45},{"Prussian blue",0.1},{"bone black",0.18},{"yellow ochre",0.2}, name="gf"}
gm = pile{{"raw umber",1},{"green earth",0.5},{"bone black",0.35},{"ultramarine blue",0.15},{"lead white",0.12},{"yellow ochre",0.15}, name="gm"}
gd = pile{{"raw umber",1},{"bone black",0.6},{"ultramarine blue",0.3},{"green earth",0.3},{"lead white",0.04}, name="gd"}
gw = pile{{"raw umber",0.8},{"yellow ochre",0.6},{"red earth",0.15},{"lead white",0.22},{"green earth",0.2}, name="gw"}
local x = 60
for i, p in ipairs({gf, gm, gd, gw}) do
  work(rect(x, 40, 180, 110), {hand="body", tool="filbert 10", pile=p, coverage=2.0, fill=true, angle=0.02, length={25,60}, clip=true})
  x = x + 220
end

--@ chunk 13
coat_dk = pile{{"raw umber",1},{"bone black",1},{"red earth",0.15},{"ultramarine blue",0.15},{"lead white",0.08}, name="coat_dk"}
coat_dk2 = pile{{"bone black",1},{"raw umber",0.6},{"ultramarine blue",0.3}, name="coat_dk2"}
coat_m = pile{{"raw umber",1},{"bone black",0.45},{"red earth",0.2},{"yellow ochre",0.15},{"lead white",0.1}, name="coat_m"}
coat_moon = pile{{"raw umber",0.6},{"lead white",0.45},{"Prussian blue",0.1},{"bone black",0.2},{"yellow ochre",0.1}, name="coat_moon"}
-- dry underlayer: brown coat
local tent = poly({{200,200},{240,200},{300,480},{60,480}}, true)
work(tent, {hand="body", tool="filbert 8", pile=pile{{"raw umber",1},{"bone black",0.6},{"red earth",0.2},{"lead white",0.15}}, coverage=2.2, fill=true, clip=true, angle=1.6})
wait(10*24*60)
-- fresh wet base, value graded across
local function xr(y) return 240 + (y-200)*(60/280) end
work(tent, {hand="body", tool="filbert 8", piles={{coat_dk, function(x,y) return clamp((xr(y)-x)/60,0,1)*1.5+0.2 end},{coat_m, function(x,y) return clamp(1-(xr(y)-x)/60,0,1) end}},
  coverage=1.6, fill=true, clip=true, length={20,50}, angle=1.65, pressure={0.4,0.7}})
local b = brush{kind="filbert", width=7, stiffness=0.4}
local function G(p, ld, pts) b:load(p, ld); b:gesture(pts, {wobble=2, clip=tent}) end
G(coat_dk2, 0.7, {{200,250,0.3},{170,350,0.8},{120,470,0.9}})
G(coat_dk2, 0.7, {{215,260,0.3},{200,360,0.8},{170,475,0.9}})
G(coat_dk2, 0.7, {{228,280,0.3},{230,370,0.7},{225,475,0.8}})
G(coat_moon, 0.6, {{208,260,0.2},{186,355,0.6},{145,472,0.7}})
G(coat_moon, 0.6, {{222,275,0.2},{216,365,0.6},{198,475,0.7}})
G(coat_moon, 0.6, {{236,290,0.2},{244,375,0.6},{252,476,0.7}})

--@ chunk 14
local tent = poly({{200,200},{240,200},{300,480},{60,480}}, true)
local function xr(y) return 240 + (y-200)*(60/280) end
-- shift trial right: a new tent at x+400 
local tent2 = poly({{600,200},{640,200},{700,480},{460,480}}, true)
work(tent2, {hand="body", tool="filbert 8", pile=pile{{"raw umber",1},{"bone black",0.6},{"red earth",0.2},{"lead white",0.15}}, coverage=2.2, fill=true, clip=true, angle=1.6})
wait(10*24*60)
work(tent2, {hand="body", tool="filbert 8", piles={{coat_dk, function(x,y) return clamp((xr(y)+400-x)/60,0,1)*1.5+0.2 end},{coat_m, function(x,y) return clamp(1-(xr(y)+400-x)/60,0,1) end}},
  coverage=1.6, fill=true, clip=true, length={20,50}, angle=1.65, pressure={0.4,0.7}})
local b = brush{kind="filbert", width=16, stiffness=0.4}
local function G(p, ld, pts) b:load(p, ld); b:gesture(pts, {wobble=3, clip=tent2}) end
G(coat_moon, 0.5, {{622,270,0.1},{612,360,0.5},{590,472,0.7}})
G(coat_dk2, 0.6, {{606,260,0.2},{570,360,0.7},{520,472,0.9}})
G(coat_dk2, 0.6, {{632,290,0.2},{636,380,0.6},{640,474,0.8}})
G(coat_moon, 0.4, {{640,300,0.1},{652,385,0.5},{668,476,0.6}})
blend(tent2:shrink(3), {angle=1.65})

--@ chunk 15
wait(10*24*60)
cglaze = pile{{"bone black",0.6},{"raw umber",0.8},{"ultramarine blue",0.3}, medium=0.78, name="cglaze"}
local tent2 = poly({{600,200},{640,200},{700,480},{460,480}}, true)
local half = tent2 * mask(function(x,y) return x < 600 + (y-200)*0.15 and 1 or 0 end)
work(half, {hand="glaze", pile=cglaze, coverage=1.5, fill=true, angle=1.65, clip=half})
