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
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
local function poolw(x,y) local dx=(x-480)/230; local dy=(y-585)/55; return clamp(1-math.sqrt(dx*dx+dy*dy),0,1) end
local function gx(x) return x < 590 and x + 420 or x end
local C = rect(180, 540, 820, 127)
work(C, {hand="detail", tool={kind="filbert", width=3}, piles={
  {gf, function(x,y) x = gx(x) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
  {gm, function(x,y) x = gx(x) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) x = gx(x) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end},
  {gw, function(x,y) x = gx(x) return poolw(x,y)^1.2*1.1 end}},
  coverage=3.5, fill=true, clip=C, length={4,10}, angle=0.02, seed=41001})
print(wait(30*24*60))
function shp(pts, dx) local o = {} for i,p in ipairs(pts) do o[i] = {p[1]+dx, p[2]} end return o end
LEGPTS_F = {{770,460},{795,465},{760,590},{752,600},{756,604},{716,604},{730,596},{738,588}}
LEGPTS_R = {{800,465},{825,462},{880,590},{884,600},{852,606},{860,596},{866,588}}
SLAB = {{712,603},{893,604},{886,626},{874,667},{650,667},{690,620}}
for _, dx in ipairs({-420, 0}) do
  local L = poly(shp(LEGPTS_F, dx), true) + poly(shp(LEGPTS_R, dx), true)
  work(L, {hand="detail", tool={kind="filbert", width=3}, pile=ztrou2, coverage=3.5, fill=true, clip=L, length={4,10}, angle=1.7, seed=5})
  local zm = poly(shp(SLAB, dx), true):blur(3) - L
  work(zm, {hand="scumble", pile=shbt, coverage=1.4, fill=true, clip=zm, angle=2.0,
    load_at=function(x,y) return lerp(0.95, 0.5, smoothstep(603,667,y)) end})
end
print(wait(30*24*60))

--@ chunk 3
function zshadow_strips(dx)
  local function P(pts) local o = {} for i,p in ipairs(pts) do o[i] = {p[1]+dx, p[2]} end return o end
  local SF = poly(P{{737,603.5},{757,603.5},{758,620},{757,645},{756,672},{726,672},{727,645},{731,620}}, true)
  local SR = poly(P{{862,605},{884,605},{880,620},{866,640},{846,672},{812,672},{828,645},{848,620}}, true)
  local CT = ellipse(735+dx, 604.8, 21, 2.2) + ellipse(866+dx, 605.8, 17, 2.2)
  return SF, SR, CT
end
function zshadow_lay(dx, comp, seed, LEGS, shp_pile, sk)
  local SF, SR, CT = zshadow_strips(dx)
  local S = (SF + SR):blur(3.5) + CT:blur(1)
  local R = poly({{690+dx,598},{900+dx,598},{906+dx,672},{628+dx,672},{656+dx,632}}, true):roughen(5, 25, 17):soften(5) - LEGS:grow(0.5)
  local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
  local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
  local function depth(y) return clamp((y-485)/180,0,1) end
  local function sdir(x,y)
    local xf = 747 + dx - (y-604)*7/63
    local xr = 873 + dx - (y-605)*56/62
    if math.abs(x - xf) < math.abs(x - xr) then return 1.68 else return 2.31 end
  end
  work(R, {hand="detail", tool={kind="filbert", width=3}, piles={
    {gf, function(x,y) x = x - dx local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) + comp*0.25 end},
    {gm, function(x,y) x = x - dx local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 + comp*0.5 end},
    {gd, function(x,y) x = x - dx local d = depth(y); return (clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d) * (1 - comp*0.4) end},
    {shp_pile, function(x,y) return S:at(x,y)*sk end}},
    coverage=3.5, fill=true, clip=R:grow(10) - LEGS:grow(0.5), edge="lost", length={4,9},
    angle=function(x,y) local s = S:at(x,y) if s > 0.15 then return sdir(x,y) else return 0.02 end end, seed=seed})
end
local LA = poly(shp(LEGPTS_F, -420), true) + poly(shp(LEGPTS_R, -420), true)
local LB = poly(LEGPTS_F, true) + poly(LEGPTS_R, true)
zshadow_lay(0, 0, 60001, LB, zsh2, 8)
zshadow_lay(-420, 0.3, 60002, LA, zsh2, 8)
print(wait(15*24*60))
print(drying(740,640), drying(320,640))
