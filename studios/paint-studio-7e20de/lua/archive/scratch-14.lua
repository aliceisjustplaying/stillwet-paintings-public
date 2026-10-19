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
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
local function poolw(x,y) local dx=(x-480)/230; local dy=(y-585)/55; return clamp(1-math.sqrt(dx*dx+dy*dy),0,1) end
local C = rect(540, 540, 460, 127)
work(C, {hand="detail", tool={kind="filbert", width=3}, piles={
  {gf, function(x,y) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end},
  {gw, function(x,y) return poolw(x,y)^1.2*1.1 end}},
  coverage=3.5, fill=true, clip=C, length={4,10}, angle=0.02, seed=41001})
print(wait(30*24*60))

--@ chunk 3
-- stand-in legs and feet
LEGF = poly({{770,460},{795,465},{760,590},{752,600},{756,604},{716,604},{730,596},{738,588}}, true)
LEGR = poly({{800,465},{825,462},{880,590},{884,600},{852,606},{860,596},{866,588}}, true)
work(LEGF + LEGR, {hand="detail", tool={kind="filbert", width=3}, pile=ztrou2, coverage=3.5, fill=true, clip=LEGF+LEGR, length={4,10}, angle=1.7, seed=5})
-- mimic the old slab: shbt scumble shapes as on the painting
local ZSHF = {{712,602},{758,603},{748,618},{724,640},{708,667},{644,667},{668,640},{696,614}}
local ZSHR = {{860,604},{893,606},{886,626},{874,667},{826,667},{842,634}}
local ZSHT = {{700,667},{718,650},{748,640},{776,634},{806,632},{838,634},{850,642},{846,667}}
local slab = poly({{712,603},{893,604},{886,626},{874,667},{650,667},{690,620}}, true)
local zm = (poly(ZSHF, true) + poly(ZSHR, true) + poly(ZSHT, true) + slab):blur(3) - (LEGF+LEGR)
work(zm, {hand="scumble", pile=shbt, coverage=1.4, fill=true, clip=zm, angle=2.0,
  load_at=function(x,y) return lerp(0.95, 0.5, smoothstep(603,667,y)) end})
print(wait(30*24*60))

--@ chunk 4
mshad = pile{{"bone black",0.7},{"ultramarine blue",0.5},{"raw umber",0.4},{"Prussian blue",0.05}, name="mshad"}
FEET = (LEGF + LEGR)
-- leg shadows streaming toward the viewer, converging off the bottom edge
SHF = poly({{716,603.5},{756,603.5},{752,612},{750,630},{753,650},{755,672},{715,672},{716,650},{719,630},{719,612}}, true)
SHR = poly({{851,605.5},{883,605},{878,615},{868,632},{856,650},{846,672},{806,672},{818,650},{832,632},{845,615}}, true)
local S = (SHF + SHR):blur(2.2)
local R = rect(636, 597, 274, 75):roughen(8, 30, 11):soften(6)
local nz = noise{seed=1201, period=110, octaves=4, stretch={0, 5}}
local nz2 = noise{seed=1202, period=40, octaves=3, stretch={0, 3}}
local function depth(y) return clamp((y-485)/180,0,1) end
local function poolw(x,y) local dx=(x-480)/230; local dy=(y-585)/55; return clamp(1-math.sqrt(dx*dx+dy*dy),0,1) end
work(R, {hand="detail", tool={kind="filbert", width=3}, piles={
  {gf, function(x,y) local d = depth(y); return clamp(1-d*3.2,0,1)*1.6 + clamp(nz(x,y)-0.15,0,1)*1.2*clamp(1-d*1.6,0,1) end},
  {gm, function(x,y) local d = depth(y); return clamp(1-math.abs(d-0.35)*3.2,0,1)*1.2 + clamp(nz2(x,y),0,1)*0.3 end},
  {gd, function(x,y) local d = depth(y); return clamp((d-0.45)*2.4,0,1)*1.5 + clamp(-nz(x,y)-0.2,0,1)*0.8*d end},
  {gw, function(x,y) return poolw(x,y)^1.2*1.1 end},
  {mshad, function(x,y) return S:at(x,y)*7 end}},
  coverage=3.5, fill=true, clip=R:grow(14) - FEET:grow(0.5), edge="lost", length={4,10}, angle=0.02, seed=50001})
print(drying(700,640))

--@ chunk 5
mshA = pile{{"bone black",0.8},{"raw umber",0.8},{"ultramarine blue",0.15},{"green earth",0.2}, name="mshA"}
mshB = pile{{"bone black",1},{"raw umber",0.6},{"ultramarine blue",0.1},{"Prussian blue",0.02}, name="mshB"}
mshC = mix{{gd, 0.6}, {mshA, 0.4}, name="mshC"}
print(wait(12*24*60))
print(drying(700,640), drying(860,640), drying(780,620))
