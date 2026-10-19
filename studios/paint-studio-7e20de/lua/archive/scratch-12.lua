-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
s2 = pile{{"Prussian blue",0.6},{"ultramarine blue",0.4},{"bone black",0.35},{"lead white",1.2},{"raw umber",0.15}}
gm = pile{{"raw umber",1},{"green earth",0.5},{"bone black",0.35},{"ultramarine blue",0.15},{"lead white",0.12},{"yellow ochre",0.15}}
ztrou2 = pile{{"bone black",1},{"raw umber",0.7},{"green earth",0.25},{"ultramarine blue",0.15}}
work(everywhere(), {hand="broad", coverage=2.2, fill=true, clip=true,
  piles={{s2, function(x,y) return smoothstep(500,300,y) end},{gm, function(x,y) return smoothstep(300,500,y) end}}})
wait(10*24*60)
-- leg replicas from the painting's scan (two copies: dx = -500 and -250)
FL = {{769,460},{796,470},{792,480},{787,490},{783,500},{776,520},{767,540},{760,560},{756,580},{752,600},{711,600},{730,590},{734,580},{738,560},{742,540},{747,520},{755,500},{763,480}}
RL = {{812,460},{821,470},{824,480},{844,500},{853,520},{862,540},{870,560},{878,580},{889,600},{866,600},{854,580},{844,560},{833,540},{821,520},{811,500},{804,480},{802,470}}
function sh(pts, dx, dy) local o = {} for i,p in ipairs(pts) do o[i] = {p[1]+dx, p[2]+dy} end return o end
LA = poly(sh(FL,-550,-200), true) + poly(sh(RL,-550,-200), true)
LB = poly(sh(FL,-250,-200), true) + poly(sh(RL,-250,-200), true)
LC = poly(sh(FL,50,-200), true) + poly(sh(RL,50,-200), true)
work(LA + LB + LC, {hand="body", pile=ztrou2, coverage=2.5, fill=true, clip=true, angle=1.7})
wait(20*24*60)
print(drying(230,330))

--@ chunk 3
zd_mid = pile{{"bone black",0.5},{"raw umber",0.6},{"green earth",0.6},{"yellow ochre",0.2},{"lead white",0.04}}
z_warm = pile{{"raw umber",0.4},{"yellow ochre",0.7},{"orange vermilion",0.12},{"lead white",0.25},{"red earth",0.1}}
z_moon = pile{{"lead white",1},{"Prussian blue",0.12},{"green earth",0.3},{"bone black",0.12}}
zrim_mix = mix{{ztrou2, 0.55}, {z_moon, 0.45}}
FC = {{782,470},{769,500},{755,540},{745,580},{740,596}}
RC = {{811,470},{827,500},{847,540},{866,580},{876,596}}
FW = {{13,470},{14,500},{12.5,540},{11,580},{12,596}}
RW = {{10,470},{17,500},{14.5,540},{12,580},{11,596}}
-- creases: short drawn lines {pts}, in painting coords
CRE = {
  {{752,520},{764,528},{776,522}}, {{748,536},{760,546},{770,541}},   -- front knee
  {{826,522},{838,530},{850,524}}, {{832,540},{845,548},{857,542}},   -- rear knee
  {{744,566},{752,572},{760,568}}, {{852,568},{862,574},{872,570}},
}
local function lerpw(W, y) for i=1,#W-1 do if y <= W[i+1][2] then return lerp(W[i][1], W[i+1][1], clamp((y-W[i][2])/(W[i+1][2]-W[i][2]),0,1)) end end return W[#W][1] end
function lat(x,y)  -- signed lateral -1 (left) .. 1 (right) for the nearer leg
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
function legpass(M, dx, dy, k)
  local X = function(x) return x - dx end
  local Y = function(y) return y - dy end
  work(M:shrink(1.5), {hand="body", tool="filbert 4", coverage=2.5, fill=true, clip=M:shrink(1.5), length={8,22},
    angle=function(x,y) local u, which = lat(X(x),Y(y)) return which==0 and 1.88 or 1.12 end,
    piles={{ztrou2, 1},
      {zd_mid, function(x,y) local u = lat(X(x),Y(y)) return k.lit * smoothstep(0.1, -0.7, u) end},
      {z_warm, function(x,y) local u = lat(X(x),Y(y)) return k.warm * smoothstep(-0.6, -0.95, u) * smoothstep(620, 470, Y(y)) end},
      {zrim_mix, function(x,y) local u = lat(X(x),Y(y)) return k.rim * smoothstep(0.7, 0.95, u) end},
      {zd_mid, function(x,y) local l, d = crease(X(x),Y(y)) return k.cr * l * 1.5 end},
      {pile{{"bone black",1},{"raw umber",0.5},{"ultramarine blue",0.2}}, function(x,y) local l, d = crease(X(x),Y(y)) return k.cr * d * 1.5 end}}})
end
legpass(LA, -550, -200, {lit=0.8, warm=0, rim=0, cr=0})
legpass(LB, -250, -200, {lit=0.8, warm=0.4, rim=0.6, cr=1})
legpass(LC, 50, -200, {lit=1.3, warm=0.6, rim=0.9, cr=1.4})
wait(20*24*60)

--@ chunk 4
zsuit2 = pile{{"bone black",0.8},{"raw umber",0.6},{"green earth",0.5},{"lead white",0.04}}
shirt = pile{{"lead white",0.5},{"yellow ochre",0.35},{"raw umber",0.4},{"green earth",0.3},{"bone black",0.12}}
shirt_lit = pile{{"lead white",0.8},{"yellow ochre",0.5},{"Naples yellow",0.2},{"raw umber",0.15},{"orange vermilion",0.04}}
shirt_sh = pile{{"raw umber",0.6},{"green earth",0.4},{"bone black",0.35},{"lead white",0.12}}
cavity = pile{{"bone black",1},{"raw umber",0.5},{"green earth",0.3}}
SH_PTS = {{750,334},{773,338},{777,350},{773,360},{780,370},{780,390},{787,400},{785,412},{784,420},{788,430},{787,442},{775,442},{771,420},{765,400},{758,380},{753,360},{749,345}}
function shp(pts, dx, dy) local o = {} for i,p in ipairs(pts) do o[i] = {p[1]+dx, p[2]+dy} end return o end
for _,dx in ipairs({-600, -480, -360}) do
  local T = rect(730+dx, 320+100, 80, 135)
  work(T, {hand="body", pile=zsuit2, coverage=2.5, fill=true, clip=true, angle=1.7})
end
wait(15*24*60)
for _,dx in ipairs({-600, -480, -360}) do
  local P = poly(shp(SH_PTS, dx, 100), true)
  work(P, {hand="body", tool="filbert 5", coverage=2.4, fill=true, clip=true, angle=1.9,
    piles={{shirt, 1},{shirt_lit, function(x,y) return smoothstep(768+dx, 752+dx, x - (y-430)*0.25) end},{shirt_sh, function(x,y) return smoothstep(772+dx, 786+dx, x - (y-430)*0.25) end}}})
end
wait(20*24*60)
print(drying(170,480))

--@ chunk 5
XL = {{340,750},{350,752},{360,753},{370,757},{380,758},{390,761},{400,765},{410,767},{420,771},{430,773},{440,775}}
XR = {{340,773},{350,777},{360,773},{370,780},{380,780},{390,780},{400,787},{410,785},{420,784},{430,788},{440,787}}
function edgex(T, y) for i=1,#T-1 do if y <= T[i+1][1] then return lerp(T[i][2], T[i+1][2], clamp((y-T[i][1])/(T[i+1][1]-T[i][1]),0,1)) end end return T[#T][2] end
function ribslits(dx, dy, th, ys)
  local m = nil
  for _,y0 in ipairs(ys) do
    local y1 = y0 + 7
    local xr, xl = edgex(XR, y0) + 2, edgex(XL, y1) + 3
    local xm, ym = (xr + xl)/2, (y0 + y1)/2 + 1.2
    local t = th * (0.85 + 0.3*math.random())
    local pts = {{xr+dx, y0+dy}, {xm+dx+3, ym - t*0.45+dy}, {xl+dx, y1+dy}, {xm+dx-2, ym + t*0.55+dy}}
    local s = poly(pts, true)
    m = m and (m + s) or s
  end
  return m
end
ys = {350, 362, 374, 386, 398, 411}
local A = ribslits(-600, 100, 3.0, ys)
local B = ribslits(-480, 100, 4.5, ys)
local C = ribslits(-360, 100, 3.5, ys)
work(A + B + C, {hand="detail", tool={kind="round", width=2, point=0.5}, pile=cavity, coverage=2.5, fill=true, clip=true, angle=0.3})
wait(15*24*60)
-- C: a pale top edge on each rib (just under each slit)
local Cl = (ribslits(-360, 102.5, 2.0, ys) - C):shrink(0.3)
work(Cl * poly(shp(SH_PTS, -360, 100), true), {hand="detail", tool={kind="round", width=1.6, point=0.5}, pile=shirt_lit, coverage=1.5, fill=true, clip=true, angle=0.3})
wait(15*24*60)

--@ chunk 6
LD = poly(sh(FL,250,-200), true) + poly(sh(RL,250,-200), true)
LE = poly(sh(FL,250,-430), true) + poly(sh(RL,250,-430), true)
work(LD + LE, {hand="body", pile=ztrou2, coverage=2.5, fill=true, clip=true, angle=1.7})
wait(20*24*60)
legpass(LD, 250, -200, {lit=1.3, warm=0.6, rim=0, cr=1.4})
print(drying(1000-60, 300))

--@ chunk 7
LF = poly(sh(FL,-260,30), true) + poly(sh(RL,-260,30), true)
work(LF, {hand="body", pile=ztrou2, coverage=2.5, fill=true, clip=true, angle=1.7})
wait(20*24*60)
legpass(LF, -260, 30, {lit=1.3, warm=0.6, rim=0, cr=1.4})
print(drying(510, 560))

--@ chunk 8
LG = poly(sh(FL,-500,30), true) + poly(sh(RL,-500,30), true)
work(LG, {hand="body", pile=ztrou2, coverage=2.5, fill=true, clip=true, angle=1.7})
wait(20*24*60)
legpass(LG, -500, 30, {lit=1.3, warm=0.6, rim=0, cr=1.4})
print(drying(270, 560))

--@ chunk 9
zd = pile{{"bone black",1},{"raw umber",0.5},{"green earth",0.4},{"Prussian blue",0.1}}
zsuit_lit = pile{{"raw umber",0.6},{"yellow ochre",0.45},{"green earth",0.35},{"lead white",0.25},{"orange vermilion",0.05}}
legdk = pile{{"bone black",1},{"raw umber",0.5},{"ultramarine blue",0.2}}
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
ZF0 = {
  {{{784,330},{800,352},{822,372}}, 2, 5, 0.9},
  {{{786,380},{804,398},{826,416}}, 2, 5, 0.9},
  {{{800,420},{812,446},{824,476}}, 2, 5, 0.8},
  {{{826,430},{838,452},{850,474}}, 2, 4, 0.6},
}
TOR = {{780,312},{830,322},{838,345},{835,400},{846,446},{862,478},{840,480},{800,470},{790,430},{781,380},{776,340}}
function shf(F, dx, dy) local o = {} for i,f in ipairs(F) do local p = {} for j,q in ipairs(f[1]) do p[j] = {q[1]+dx, q[2]+dy} end o[i] = {p, f[2], f[3], f[4]} end return o end
TA = {dx=-680, dy=-300}  TB = {dx=-530, dy=-300}  TC = {dx=-380, dy=-300}
for _,t in ipairs({TA, TB, TC}) do
  t.m = poly(sh(TOR, t.dx, t.dy), true)
  t.f = shf(ZF0, t.dx, t.dy)
  work(t.m, {hand="body", pile=zd, coverage=2.5, fill=true, clip=true, angle=1.7})
end
wait(20*24*60)
-- the olive pass as laid on the painting
for _,t in ipairs({TA, TB, TC}) do
  local M = t.m:shrink(3)
  work(M, {hand="body", tool="filbert 4", coverage=2.5, fill=true, clip=M, length={8,22},
    angle=function(x,y) return y-t.dy < 420 and 0.85 or 1.25 end,
    piles={{zsuit2, 1},
      {zd_mid, function(x,y) local l = foldw2(t.f,x,y) return l*1.4 end},
      {legdk, function(x,y) local l, d = foldw2(t.f,x,y) return d*1.2 end}}})
end
print(drying(120, 100))

--@ chunk 10
cavity = pile{{"bone black",1},{"raw umber",0.5},{"green earth",0.3}}
-- B: dark wet-in-wet pass, coverage 2.5, ridges keep zsuit2
local M = TB.m:shrink(3)
work(M, {hand="body", tool="filbert 4", coverage=2.5, fill=true, clip=M, length={8,22},
  angle=function(x,y) return y-TB.dy < 420 and 0.85 or 1.25 end,
  piles={{cavity, 1},
    {zsuit2, function(x,y) local l = foldw2(TB.f,x,y) return l*1.6 end},
    {legdk, function(x,y) local l, d = foldw2(TB.f,x,y) return d*1.0 end}}})
-- C: same but coverage 3.5 and filbert 6
local M2 = TC.m:shrink(3)
work(M2, {hand="body", tool="filbert 6", coverage=3.5, fill=true, clip=M2, length={8,22},
  angle=function(x,y) return y-TC.dy < 420 and 0.85 or 1.25 end,
  piles={{cavity, 1},
    {zsuit2, function(x,y) local l = foldw2(TC.f,x,y) return l*1.6 end},
    {legdk, function(x,y) local l, d = foldw2(TC.f,x,y) return d*1.0 end}}})
print(drying(270,100))

--@ chunk 11
sky_dk = pile{{"Prussian blue",0.227},{"ultramarine blue",0.2225},{"bone black",0.2787},{"lead white",0.2444},{"raw umber",0.0275}}
skyhalo = mix{{s2, 0.6}, {pile{{"lead white",1},{"Prussian blue",0.1}}, 0.4}}
local disc = ellipse(600, 470, 40, 50)
local ring = disc:grow(7) - disc
work(rect(520,390,320,160), {hand="body", pile=sky_dk, coverage=2.2, fill=true, clip=true})
wait(10*24*60)
work(ring + ellipse(800,470,40,50):grow(7) - ellipse(800,470,40,50), {hand="detail", pile=skyhalo, coverage=2, fill=true, clip=true})
work(disc + ellipse(800,470,40,50), {hand="body", pile=cavity, coverage=2.5, fill=true, clip=true})
wait(20*24*60)
sky_dkt = pile{{"Prussian blue",0.227},{"ultramarine blue",0.2225},{"bone black",0.2787},{"lead white",0.2444},{"raw umber",0.0275}, thinner=0.6}
local R2 = (ellipse(800,470,40,50):grow(12) - ellipse(800,470,40,50)):blur(2)
work(R2, {hand="scumble", tool="filbert 5", pile=sky_dkt, coverage=1.4, fill=true, clip=R2 - ellipse(800,470,40,50):grow(0.5)})
wait(20*24*60)
