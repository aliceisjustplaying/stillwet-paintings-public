-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
gf = pile{{"lead white",1},{"green earth",0.4},{"raw umber",0.45},{"Prussian blue",0.1},{"bone black",0.18},{"yellow ochre",0.2}, name="gf"}
gm = pile{{"raw umber",1},{"green earth",0.5},{"bone black",0.35},{"ultramarine blue",0.15},{"lead white",0.12},{"yellow ochre",0.15}, name="gm"}
gd = pile{{"raw umber",1},{"bone black",0.6},{"ultramarine blue",0.3},{"green earth",0.3},{"lead white",0.04}, name="gd"}
gw = pile{{"raw umber",0.8},{"yellow ochre",0.6},{"red earth",0.15},{"lead white",0.22},{"green earth",0.2}, name="gw"}
shad = pile{{"raw umber",0.8},{"bone black",0.7},{"ultramarine blue",0.45},{"green earth",0.2},{"lead white",0.1}, name="shad"}
shbt = pile{{"bone black",0.8},{"raw umber",0.8},{"ultramarine blue",0.5},{"green earth",0.3}, thinner=0.6, name="shbt"}
ztrou2 = pile{{"bone black",1},{"raw umber",0.7},{"green earth",0.25},{"ultramarine blue",0.15}, name="ztrou2"}
mshB = pile{{"bone black",1},{"raw umber",0.6},{"ultramarine blue",0.1},{"Prussian blue",0.02}, name="mshB"}
zsh2 = mix{{shad, 0.5}, {mshB, 0.5}, name="zsh2"}
zsh3 = pile{{"bone black",1},{"ultramarine blue",0.35},{"raw umber",0.45},{"green earth",0.1}, name="zsh3"}
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
local function poolw(x,y) local dx=(x-480)/230; local dy=(y-585)/55; return clamp(1-math.sqrt(dx*dx+dy*dy),0,1) end
local function gx(x) return x < 590 and x + 420 or x end
local C = rect(200, 540, 800, 127)
work(C, {hand="detail", tool={kind="filbert", width=3}, piles={
  {gf, function(x,y) x = gx(x) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
  {gm, function(x,y) x = gx(x) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) x = gx(x) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end},
  {gw, function(x,y) x = gx(x) return poolw(x,y)^1.2*1.1 end}},
  coverage=3.5, fill=true, clip=C, length={4,10}, angle=0.02, seed=41001})
print(wait(30*24*60))
function shp(pts, dx) local o = {} for i,p in ipairs(pts) do o[i] = {p[1]+dx, p[2]} end return o end
LEGF = {{758.5,540},{750.5,510},{744.5,530},{739.5,550},{735.5,570},{734,580},{730,590},{723,595},{711,600},{711.5,604},{757,604},{756.5,590},{756,580},{758,570},{764,550},{771.5,530},{779.5,510},{787.5,540}}
LEGR = {{807,540},{815.5,510},{826,530},{838,550},{849,570},{854,580},{859.5,590},{855.5,600},{848,604},{889,604},{889.5,600},{884,590},{878,580},{874,570},{866.5,550},{858,530},{849,510},{839.5,540}}
LEGS = {}
for i, dx in ipairs({-420, 0}) do
  local L = poly(shp(LEGF, dx)) + poly(shp(LEGR, dx))
  LEGS[i] = L
  work(L, {hand="detail", tool={kind="filbert", width=3}, pile=ztrou2, coverage=3.5, fill=true, clip=L, length={4,10}, angle=1.7, seed=5})
  local slab = poly(shp({{712,603},{893,604},{886,626},{874,667},{650,667},{690,620}}, dx), true)
  local zm = slab:blur(3) - L
  work(zm, {hand="scumble", pile=shbt, coverage=1.4, fill=true, clip=zm, angle=2.0,
    load_at=function(x,y) return lerp(0.95, 0.5, smoothstep(603,667,y)) end})
end
print(wait(30*24*60))

--@ chunk 3
SF = {{710,604},{712,606.5},{719,608.5},{724,611},{723,617},{720.5,627},{717.5,638},{714.5,649},{712.5,660},{711.5,672},{754.5,672},{752.5,661},{750,648},{748,635},{747.8,624},{749.5,615},{752.5,610},{755.5,606.5},{757,604}}
SR = {{847,605.5},{852,607.5},{858,609},{861,611.5},{856,617},{849,623},{841,630},{831,639},{820,649},{810,658},{801,666},{794,673},{841,673},{847,666},{854,657},{860.5,648},{866,640},{870.5,633},{875,625},{880,618},{885,612.5},{889.5,608},{890,605.5}}
function zshadow3(dx, LEGS_X, seed, sp, sk)
  local base = poly(shp(SF, dx), true) + poly(shp(SR, dx), true)
  local S = base:blur(1.2):times(function(x,y) return 1 - smoothstep(608,660,y) end) + base:blur(4.5):times(function(x,y) return smoothstep(608,660,y) end)
  local R = poly(shp({{693,597},{900,598},{904,630},{899,667},{628,667},{660,635}}, dx), true):roughen(5, 25, 17):soften(5) - LEGS_X:grow(0.5)
  local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
  local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
  local function depth(y) return clamp((y-485)/180,0,1) end
  local function poolw(x,y) local dx=(x-480)/230; local dy=(y-585)/55; return clamp(1-math.sqrt(dx*dx+dy*dy),0,1) end
  local function sdir(x,y) if x - dx < 785 then return 1.6 end return 2.3 end
  work(R, {hand="detail", tool={kind="filbert", width=3}, piles={
    {gf, function(x,y) x = x - dx local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
    {gm, function(x,y) x = x - dx local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
    {gd, function(x,y) x = x - dx local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end},
    {gw, function(x,y) x = x - dx return poolw(x,y)^1.2*1.1 end},
    {sp, function(x,y) return S:at(x,y)*sk end}},
    coverage=3.5, fill=true, clip=R:grow(10) - LEGS_X:grow(0.5), edge="lost", length={4,9},
    angle=function(x,y) if S:at(x,y) > 0.15 then return sdir(x,y) else return 0.02 end end, seed=seed})
end
zshadow3(-420, LEGS[1], 62001, zsh3, 10)
zshadow3(0, LEGS[2], 62002, mshB, 12)
print(wait(15*24*60))
