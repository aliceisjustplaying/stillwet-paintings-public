-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
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
canvas{size=1050, aspect=1.4, linen={15,13}, seed=6,
  ground={
    {pile={{"lead white",2},{"red earth",1},{"yellow ochre",1}}, um=90, apply="knife", texture=0.35},
    {pile={{"lead white",8},{"yellow ochre",0.25},{"raw umber",0.08}}, um=45, apply="brush", texture=0.4},
  }}
print(W, H)

--@ chunk 2
horizon = 440
-- slab faces: {points, light} ; back to front. L lit, M mid (facing viewer), S shadow, D deep edge
back = {
  {{{830,330},{875,290},{915,415},{940,505},{850,480}}, "L", "G"},
  {{{875,290},{886,300},{955,505},{940,505},{915,415}}, "S", "Ge"},
  {{{790,300},{830,262},{850,330},{820,345}}, "M", "J"},
  {{{740,225},{770,195},{790,255},{760,262}}, "L", "K"},
  {{{660,190},{705,150},{748,212},{775,215},{800,270},{860,395},{800,440},{690,420}}, "S", "C"},
  {{{578,395},{600,175},{630,90},{644,98},{652,400}}, "L", "A"},
  {{{644,98},{656,112},{676,200},{705,405},{652,400}}, "D", "Ae"},
  {{{455,430},{520,300},{575,215},{606,195},{600,290},{560,430}}, "L", "B"},
  {{{446,418},{512,292},{568,205},{606,195},{575,215},{520,300},{455,430}}, "M", "Be"},
}
front = {
  {{{285,392},{330,345},{410,362},{470,402},{455,475},{360,485},{300,455}}, "M", "Q"},
  {{{285,392},{330,345},{410,362},{470,402},{466,412},{410,374},{332,357},{292,398}}, "L", "Qe"},
  {{{430,445},{455,350},{474,356},{482,440}}, "L", "R"},
  {{{474,356},{484,364},{494,442},{482,440}}, "S", "Re"},
  {{{240,480},{255,440},{290,425},{315,450},{305,490}}, "S", "T"},
  {{{450,512},{462,430},{515,388},{556,394},{548,522}}, "L", "D1"},
  {{{548,522},{556,394},{545,368},{630,385},{625,472}}, "M", "D2"},
  {{{450,512},{548,522},{625,472},{628,486},{552,540},{446,526}}, "D", "De"},
  {{{600,545},{612,430},{640,400},{660,415},{655,548}}, "L", "H"},
  {{{660,415},{672,425},{668,550},{655,548}}, "S", "He"},
  {{{648,535},{680,430},{745,410},{830,452},{812,535}}, "M", "E"},
  {{{680,430},{745,410},{830,452},{826,462},{745,422},{684,442}}, "L", "Ee"},
  {{{820,540},{835,470},{900,455},{950,520},{930,550}}, "S", "F"},
  {{{700,714},{745,630},{1000,575},{1000,714}}, "L", "FG"},
  {{{700,714},{745,630},{756,640},{716,714}}, "D", "FGe"},
}
hull = {{300,272},{360,296},{440,334},{520,378},{532,442},{470,412},{390,372},{318,330},{300,316},{293,295}}
bowsprit = {{304,276},{212,232}}
mast = {{398,314},{446,212}}
waterlead = {{0,600},{60,606},{130,612},{180,609},{250,617},{330,612},{420,606},{500,601},{580,597},{640,594},{590,603},{520,610},{450,618},{380,626},{300,632},{240,642},{150,648},{80,658},{0,664}}
farL = {{20,440},{60,425},{110,428},{150,418},{200,430},{250,440}}
farR = {{870,440},{880,412},{990,410},{1000,415},{1000,440}}
midridge = {{40,485},{40,478},{70,462},{100,466},{130,450},{155,458},{185,447},{210,458},{225,485}}
castshadow = {{850,505},{1000,490},{1000,560},{880,565}}
local function closed(p) local q = {} for i,v in ipairs(p) do q[#q+1]=v end q[#q+1]=p[1] return q end
pen = pencil("HB")
for _,s in ipairs(back) do pen:line(closed(s[1]), {pressure=0.45, smooth=false}) end
for _,s in ipairs(front) do pen:line(closed(s[1]), {pressure=0.45, smooth=false}) end
pen:sharpen()
pen:line({{300,272},{360,296},{440,334},{520,378}}, {pressure=0.5})
pen:line({{318,330},{390,372},{470,412},{532,442}}, {pressure=0.5})
pen:line({{300,272},{293,295},{300,316},{318,330}}, {pressure=0.5})
pen:line(bowsprit, {pressure=0.5})
pen:line(mast, {pressure=0.5})
pen:rule({0,horizon},{1000,horizon},{pressure=0.3})
pen:line(closed(waterlead), {pressure=0.4, smooth=false})
pen:line(farL, {pressure=0.3})
pen:line(farR, {pressure=0.3})
pen:line(midridge, {pressure=0.35})

--@ chunk 3
local function polys(list) local m for _,s in ipairs(list) do local p = poly(s[1]); m = m and (m + p) or p end return m end
hullM = poly(hull, true) + ribbon(bowsprit, 8) + ribbon(mast, 8)
iceAll = polys(back) + polys(front)
uS = pile{{"lead white",1},{"cobalt blue",1},{"smalt",0.6},{"raw umber",0.3}, turps=0.5, name="uS"}
uM = pile{{"lead white",3},{"cobalt blue",0.5},{"smalt",0.5},{"raw umber",0.1}, turps=0.5, name="uM"}
uH = pile{{"raw umber",2},{"bone black",0.5},{"red earth",0.3}, turps=0.5, name="uH"}
uW = pile{{"Prussian blue",1},{"bone black",1},{"raw umber",0.3}, turps=0.5, name="uW"}
uP = pile{{"lead white",3},{"cobalt blue",0.4},{"smalt",0.3}, turps=0.6, name="uP"}
print(iceAll:area(), hullM:area())

--@ chunk 4
local function sel(list, kinds) local m for _,s in ipairs(list) do if kinds[s[2]] then local p = poly(s[1]); m = m and (m + p) or p end end return m end
local shM = sel(back, {S=true, D=true}) + sel(front, {S=true, D=true})
local mdM = sel(back, {M=true}) + sel(front, {M=true})
work(shM, {hand="body", pile=uS, clip=true, coverage=1.3, fill=true, seed=11})
work(mdM, {hand="body", pile=uM, clip=true, coverage=1.3, fill=true, seed=12})
work(poly(castshadow), {hand="body", pile=uM, clip=true, coverage=1.2, fill=true, angle=0})
work(poly(midridge), {hand="body", pile=uM, clip=true, coverage=1.2, fill=true})

--@ chunk 5
work(hullM, {hand="body", pile=uH, clip=true, coverage=1.5, fill=true, angle=0.45, tool="filbert 5"})
work(poly(waterlead), {hand="body", pile=uW, clip=true, coverage=1.4, fill=true, angle=-0.05})

--@ chunk 6
k1 = pile{{"lead white",1.2},{"cobalt blue",1.2},{"Prussian blue",0.08}, name="k1"}
k2 = pile{{"lead white",2.2},{"cobalt blue",1},{"Prussian blue",0.04}, name="k2"}
k3 = pile{{"lead white",5},{"cobalt blue",1},{"Prussian blue",0.02}, name="k3"}
k4 = pile{{"lead white",8},{"Naples yellow",0.35},{"cobalt blue",0.15}, name="k4"}
k5 = pile{{"lead white",8},{"Naples yellow",0.5},{"rose madder",0.08}, name="k5"}
local function band(c, w) return function(x,y) local t=y/horizon; return math.max(0, 1-math.abs(t-c)/w) end end
local function low(side) return function(x,y) local t=y/horizon; local b = math.max(0, 1-math.abs(t-1)/0.38); local s = clamp(1 - x/700, 0, 1); if side=="L" then return b*s else return b*(1-s) end end end
skypiles = {{k1, band(0,0.38)},{k2, band(0.3,0.38)},{k3, band(0.62,0.38)},{k4, low("R")},{k5, low("L")}}
skyM = above(function(x) return horizon end) - iceAll - hullM
print(skyM:at(100,100), skyM:at(620,200), skyM:at(300,300), skyM:at(500,439))
work(skyM, {hand="body", piles=skypiles, coverage=2, fill=true, angle=0, clip=true, seed=21})

--@ chunk 7
blend(skyM, {angle=0, seed=22})

--@ chunk 8
print(drying(700,300), drying(380,420), drying(400,340), drying(100,630), drying(300,100))

--@ chunk 9
print(wait(24*60))
print(drying(700,300), drying(380,420), drying(400,340), drying(100,630), drying(300,100), drying(100,400))

--@ chunk 10
print(wait(24*60))
print(drying(700,300), drying(380,420), drying(400,340), drying(100,630), drying(300,100), drying(100,400))

--@ chunk 11
palette{scrape={uS,uM,uH,uW,uP}}
iL1 = pile{{"lead white",6},{"Naples yellow",0.14}, name="iL1"}
iL2 = pile{{"lead white",6},{"Naples yellow",0.05},{"cobalt blue",0.07}, name="iL2"}
iM1 = pile{{"lead white",4},{"cobalt blue",0.3},{"smalt",0.35},{"rose madder",0.05},{"raw umber",0.05}, name="iM1"}
iM2 = pile{{"lead white",3},{"cobalt blue",0.45},{"smalt",0.5},{"Naples yellow",0.08},{"raw umber",0.1}, name="iM2"}
iS1 = pile{{"lead white",2},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.15}, name="iS1"}
iS2 = pile{{"lead white",1},{"cobalt blue",0.8},{"Prussian blue",0.12},{"green earth",0.3},{"raw umber",0.2}, name="iS2"}
iSw = pile{{"lead white",2.5},{"cobalt blue",0.55},{"smalt",0.4},{"Naples yellow",0.2},{"rose madder",0.05}, name="iSw"}
iD = pile{{"lead white",0.6},{"cobalt blue",1},{"Prussian blue",0.2},{"raw umber",0.5}, name="iD"}

--@ chunk 12
function bbox(pts) local x0,y0,x1,y1=1e9,1e9,-1e9,-1e9 for _,p in ipairs(pts) do x0=math.min(x0,p[1]);y0=math.min(y0,p[2]);x1=math.max(x1,p[1]);y1=math.max(y1,p[2]) end return x0,y0,x1,y1 end
function longest_angle(pts) local best,ang=0,0 for i=1,#pts do local a=pts[i]; local b=pts[i%#pts+1]; local dx,dy=b[1]-a[1],b[2]-a[2]; local l=dx*dx+dy*dy; if l>best then best=l; ang=math.atan(dy,dx) end end return ang end
faceP = {L={iL1,iL2}, M={iM1,iM2}, S={iS1,iSw}, D={iD,iS2}}
function paintFace(pts, kind, seed, opts)
  opts = opts or {}
  local x0,y0,x1,y1 = bbox(pts)
  local h = math.max(1, y1-y0)
  local pr = faceP[kind]
  local area = (x1-x0)*(y1-y0)
  local tool = opts.tool or (area > 15000 and "filbert 7" or (area > 4000 and "filbert 5" or "filbert 3"))
  work(poly(pts), {hand="body", piles={{pr[1], function(x,y) return clamp(1-(y-y0)/h,0,1)+0.05 end},{pr[2], function(x,y) return clamp((y-y0)/h,0,1)+0.05 end}},
    clip=true, coverage=2, fill=true, angle=opts.angle or longest_angle(pts), tool=tool, seed=seed, angle_jitter=0.15})
end
for i,s in ipairs(back) do paintFace(s[1], s[2], 100+i) end

--@ chunk 13
for i,s in ipairs(front) do if s[3] ~= "R" and s[3] ~= "Re" then paintFace(s[1], s[2], 200+i) end end

--@ chunk 14
pF = pile{{"lead white",6},{"cobalt blue",0.22},{"rose madder",0.04},{"Naples yellow",0.08}, name="pF"}
pM = pile{{"lead white",6},{"Naples yellow",0.18},{"cobalt blue",0.03}, name="pM"}
pN = pile{{"lead white",5},{"cobalt blue",0.22},{"smalt",0.2},{"Naples yellow",0.12}, name="pN"}
waterM = poly(waterlead)
plainM = below(function(x) return horizon end) - iceAll - waterM - poly(midridge) - poly(castshadow)
local function wF(x,y) return clamp(1-(y-440)/90,0,1) end
local function wM(x,y) return clamp(1-math.abs(y-570)/110,0,1) end
local function wN(x,y) return clamp((y-600)/110,0,1) end
work(plainM, {hand="broad", piles={{pF,wF},{pM,wM},{pN,wN}}, coverage=2, fill=true, clip=true, angle=function(x,y) return -0.02 + (y-440)*0.0004 end, seed=31})

--@ chunk 15
print(wait(2*24*60))
for _,p in ipairs({{620,200},{720,300},{380,420},{700,470},{880,500},{300,600},{900,650},{100,630},{400,340}}) do io = nil; print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 16
print(wait(3*24*60))
for _,p in ipairs({{620,200},{720,300},{380,420},{700,470},{880,500},{300,600},{900,650},{100,630},{400,340},{200,100}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 17
print(wait(24*60))
print(drying(720,300), drying(760,350), drying(670,250))

--@ chunk 18
palette{scrape={iM1,iM2,iS1,iS2,iSw,iD,pF,pN}}
sDeep = pile{{"lead white",0.6},{"cobalt blue",1},{"Prussian blue",0.12},{"raw umber",0.4}, name="sDeep"}
sDeepG = pile{{"lead white",0.7},{"cobalt blue",0.8},{"Prussian blue",0.12},{"green earth",0.4},{"raw umber",0.25}, name="sDeepG"}
sC1 = pile{{"lead white",1},{"cobalt blue",0.9},{"smalt",0.6},{"raw umber",0.2}, name="sC1"}
sC2 = pile{{"lead white",1.6},{"cobalt blue",0.8},{"smalt",0.5},{"Naples yellow",0.15},{"rose madder",0.08},{"raw umber",0.1}, name="sC2"}
sG = pile{{"lead white",1},{"cobalt blue",0.7},{"Prussian blue",0.06},{"green earth",0.3},{"raw umber",0.15}, name="sG"}
mA = pile{{"lead white",2},{"cobalt blue",0.6},{"smalt",0.4},{"Naples yellow",0.1},{"raw umber",0.08}, name="mA"}
mB = pile{{"lead white",2.5},{"cobalt blue",0.5},{"smalt",0.3},{"Naples yellow",0.2},{"rose madder",0.05}, name="mB"}
function face(name) for _,s in ipairs(back) do if s[3]==name then return s[1] end end for _,s in ipairs(front) do if s[3]==name then return s[1] end end end
function paintFace2(pts, piles, opts)
  opts = opts or {}
  local x0,y0,x1,y1 = bbox(pts)
  local area = (x1-x0)*(y1-y0)
  local tool = opts.tool or (area > 15000 and "filbert 7" or (area > 4000 and "filbert 5" or "filbert 3"))
  work(poly(pts), {hand="body", piles=piles, clip=true, coverage=opts.coverage or 2, fill=true, angle=opts.angle or longest_angle(pts), tool=tool, seed=opts.seed, angle_jitter=0.15})
end
local gn = noise{seed=7, period=60, stretch={1.1, 4}}
local C = face("C"); local _,cy0,_,cy1 = bbox(C)
paintFace2(C, {{sC1, function(x,y) return clamp(1-(y-cy0)/(cy1-cy0),0,1)*0.9+0.1 end},
               {sC2, function(x,y) return clamp((y-cy0)/(cy1-cy0),0,1)*0.9 end},
               {sG, function(x,y) return math.max(0, gn(x,y))*0.9 end}}, {seed=301, angle=1.0})

--@ chunk 19
order = {}
for _,s in ipairs(back) do order[#order+1] = s end
for _,s in ipairs(front) do order[#order+1] = s end
idx = {}
for i,s in ipairs(order) do idx[s[3]] = i end
function infront(name)
  local i = idx[name]; local m
  for j = i+1, #order do local p = poly(order[j][1]); m = m and (m + p) or p end
  return m
end
function visible(name)
  local m = poly(order[idx[name]][1])
  local f = infront(name)
  if f then m = m - f end
  return m
end
local occ = infront("C") * poly(face("C"))
print(occ:area())
r = rag()
r:dip(0.8)
r:wipe(occ, {pressure=0.7, angle=1.2, passes=2, refold=0.6})
print(r)

--@ chunk 20
print(wait(20*60))
print(drying(700,300), drying(680,250), drying(760,380), drying(700,200))

--@ chunk 21
print(wait(24*60))
print(drying(700,300), drying(680,250), drying(760,380), drying(700,200))

--@ chunk 22
function grad(p1, p2, pts, extra)
  local _,y0,_,y1 = bbox(pts); local h = math.max(1, y1-y0)
  local t = {{p1, function(x,y) return clamp(1-(y-y0)/h,0,1)*0.9+0.1 end},{p2, function(x,y) return clamp((y-y0)/h,0,1)*0.9+0.1 end}}
  if extra then t[#t+1] = extra end
  return t
end
function restate(name, piles, opts)
  opts = opts or {}
  local pts = face(name)
  local m = visible(name)
  local x0,y0,x1,y1 = bbox(pts)
  local area = (x1-x0)*(y1-y0)
  local tool = opts.tool or (area > 15000 and "filbert 6" or (area > 4000 and "filbert 4" or "filbert 3"))
  work(m, {hand="body", piles=piles, clip=true, coverage=opts.coverage or 1.6, fill=true, angle=opts.angle or longest_angle(pts), tool=tool, seed=opts.seed, angle_jitter=0.15})
end
local gn = noise{seed=9, period=50, stretch={1.4, 4}}
restate("Ge", grad(sC1, sC2, face("Ge")), {seed=401})
restate("J", grad(mA, mB, face("J")), {seed=402})
restate("Ae", grad(sDeep, sDeepG, face("Ae"), {sC1, function(x,y) return math.max(0,gn(x,y))*0.6 end}), {seed=403, angle=1.45})
restate("Be", grad(mA, mB, face("Be")), {seed=404})

--@ chunk 23
local gn = noise{seed=13, period=45, stretch={0.3, 3}}
restate("Q", grad(mA, mB, face("Q"), {sG, function(x,y) return math.max(0,gn(x,y))*0.5 end}), {seed=411, angle=0.25})
restate("T", grad(sC1, sC2, face("T")), {seed=412})
restate("D2", grad(mA, mB, face("D2")), {seed=413, angle=1.4})
restate("De", grad(sDeep, sC1, face("De")), {seed=414})
restate("He", grad(sC1, sDeepG, face("He")), {seed=415, angle=1.5})
restate("E", grad(mA, mB, face("E"), {sG, function(x,y) return math.max(0,gn(x,y))*0.4 end}), {seed=416, angle=0.15})
restate("F", grad(sC1, sC2, face("F")), {seed=417})
restate("FGe", grad(sDeep, sDeepG, face("FGe")), {seed=418})
work(poly(castshadow) - iceAll, {hand="body", piles={{sC2,1},{mB,0.6}}, clip=true, coverage=1.6, fill=true, angle=-0.05, tool="filbert 6", seed=419})

--@ chunk 24
palette{scrape={k1,k2,k3,k4,k5,iL2}}
fs1 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.45},{"rose madder",0.06},{"raw umber",0.06}, name="fs1"}
fs2 = pile{{"lead white",2},{"cobalt blue",0.6},{"smalt",0.5},{"rose madder",0.08},{"raw umber",0.12}, name="fs2"}
fshadow = outline{{0,548},{90,556},{150,571},{230,566},{300,588},{390,594},{470,610},{540,606},{610,628},{690,640},{760,660},{830,668},{900,690},{1000,698}, open=true, char="broken", amount=0.8, seed=5}
local fsM = fshadow:below() - iceAll - waterM
print(fsM:at(100,690), fsM:at(500,600), fsM:at(900,650), fsM:at(800,700))
work(fsM, {hand="broad", piles={{fs1, function(x,y) return clamp(1-(y-560)/150,0,1)+0.1 end},{fs2, function(x,y) return clamp((y-560)/150,0,1)+0.1 end}}, clip=true, coverage=1.6, fill=true, angle=function(x,y) return 0.05 end, seed=501})

--@ chunk 25
palette{scrape={fs1, fs2}}
hD2 = pile{{"raw umber",2},{"bone black",1.4},{"red earth",0.15},{"Prussian blue",0.05}, name="hD2"}
hL2 = pile{{"raw umber",2},{"bone black",0.6},{"lead white",0.35},{"red earth",0.2},{"yellow ochre",0.2}, name="hL2"}
local fr
for _,s in ipairs(front) do local p = poly(s[1]); fr = fr and (fr + p) or p end
frontM = fr
hullVis = poly(hull, true) - frontM
print(hullVis:at(400,350), hullVis:at(350,340), hullVis:at(500,400))
work(hullVis, {hand="body", piles={{hL2, function(x,y) return clamp(1-(x-290)/180,0,1)*0.9+0.05 end},{hD2, function(x,y) return clamp((x-290)/180,0,1)+0.25 end}}, clip=true, coverage=2, fill=true, angle=0.45, tool="filbert 4", seed=601})

--@ chunk 26
sf1 = pile{{"lead white",3.4},{"cobalt blue",1},{"Prussian blue",0.032}, name="sf1"}
local c = {446,212}; local u = {0.426,-0.905}; local n = {0.905,0.426}
local function P(a,b) return {c[1]+a*u[1]+b*n[1], c[2]+a*u[2]+b*n[2]} end
mastBreakSky = poly({P(3,-6),P(3,-4.2),P(-2,-1),P(0,1.5),P(-5,4.2),P(-5,6),P(8,6),P(8,-6)})
local b = brush("filbert", 3)
b:reload(sf1, 0.7)
work(mastBreakSky, {hand="detail", pile=sf1, coverage=3, clip=true, fill=true, tool={kind="filbert", width=2.5}, seed=611})

--@ chunk 27
local wedge = poly(hull, true) * (poly(face("B")) + poly(face("Be")))
print(wedge:area())
r = rag{width=14}
r:dip(0.9)
r:wipe(wedge, {pressure=0.8, angle=0.45, passes=2, refold=0.5})
r:dip(0.9)
r:wipe(wedge, {pressure=0.8, angle=-1.1, passes=2, refold=0.5})
print(r)

--@ chunk 28
local wedge = poly(hull, true) * (poly(face("B")) + poly(face("Be")))
r = rag{width=10}
r:dip(0.9)
r:wipe({{500,372},{528,392}}, {pressure=0.8})
r:wipe({{528,386},{500,366}}, {pressure=0.8})
r:refold(); r:dip(0.9)
r:wipe({{490,360},{525,384}}, {pressure=0.8})
r = rag{width=16}
r:dip(0.9)
r:wipe(wedge, {pressure=0.9, angle=0.2, passes=3, refold=0.4})
print(r)

--@ chunk 29
palette{scrape={iL1, pM}}
pl1 = pile{{"lead white",6},{"cobalt blue",0.9},{"rose madder",0.1},{"Naples yellow",0.15},{"raw umber",0.08}, name="pl1"}
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}, name="pl2"}
pl3 = pile{{"lead white",6},{"cobalt blue",0.55},{"Naples yellow",0.45},{"raw umber",0.08}, name="pl3"}
plain2M = plainM - fshadow:below()
print(plain2M:at(100,520), plain2M:at(900,650), plain2M:at(600,580), plain2M:at(300,690))
local function w1(x,y) return clamp(1-(y-440)/80,0,1)+0.05 end
local function w2(x,y) return clamp(1-math.abs(y-540)/90,0,1)*0.9+0.05 end
local function w3(x,y) return clamp((y-560)/90,0,1)+0.05 end
work(plain2M, {hand="broad", piles={{pl1,w1},{pl2,w2},{pl3,w3}}, coverage=1.6, fill=true, clip=true, angle=function(x,y) return 0.02 + (x-500)*0.00005 end, seed=701})

--@ chunk 30
print(wait(20*60))
print(drying(505,380), drying(495,370), drying(400,340), drying(300,520), drying(460,370))

--@ chunk 31
litW = pile{{"lead white",6},{"Naples yellow",0.14}, name="litW"}
litC = pile{{"lead white",6},{"Naples yellow",0.06},{"cobalt blue",0.1},{"raw umber",0.02}, name="litC"}
for _,s in ipairs(front) do
  if s[3]=="R" then s[1] = {{432,445},{448,330},{470,322},{480,440}} end
  if s[3]=="Re" then s[1] = {{470,322},{478,330},{492,442},{480,440}} end
end
local fr
for _,s in ipairs(front) do local p = poly(s[1]); fr = fr and (fr + p) or p end
frontM = fr
local ia
for _,s in ipairs(back) do local p = poly(s[1]); ia = ia and (ia + p) or p end
iceAll = ia + frontM
-- restore B over the wiped wedge (only where B is visible)
local wedge = (poly(hull, true) * poly(face("B"))) - frontM
work(wedge:grow(1), {hand="body", piles={{litW,1},{litC,0.3}}, clip=true, coverage=2, fill=true, angle=longest_angle(face("B")), tool="filbert 3", seed=801})
local wedgeE = (poly(hull, true) * poly(face("Be"))) - frontM - poly(face("B"))
work(wedgeE, {hand="body", piles=grad(mA, mB, face("Be")), clip=true, coverage=2, fill=true, angle=longest_angle(face("Be")), tool="filbert 2", seed=802})
local R = poly(face("R")) - infront("R")
work(R, {hand="body", piles={{litC,1},{litW,0.5}}, clip=true, coverage=2, fill=true, angle=-1.45, tool="filbert 3", seed=803})
local Re = poly(face("Re")) - (infront("Re") or poly({{0,0},{1,0},{1,1}}))
work(Re, {hand="body", piles={{sC1,1},{sG,0.4}}, clip=true, coverage=2, fill=true, angle=-1.45, tool="filbert 2", seed=804})

--@ chunk 32
print(wait(4*24*60))
for _,p in ipairs({{460,400},{400,340},{300,520},{600,560},{100,680},{900,650},{720,300},{100,630},{470,350}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 33
palette{scrape={pl1,pl2,pl3,sf1}}
wD = pile{{"bone black",1},{"Prussian blue",0.35},{"raw umber",0.4},{"lead white",0.7},{"green earth",0.3}, name="wD"}
wM = pile{{"bone black",0.6},{"Prussian blue",0.25},{"raw umber",0.2},{"lead white",2},{"cobalt blue",0.4}, name="wM"}
wL = pile{{"lead white",4},{"cobalt blue",0.6},{"bone black",0.15},{"Naples yellow",0.1}, name="wL"}

--@ chunk 34
work(waterM, {hand="body", piles={{wD, function(x,y) return clamp(1-(x-200)/450,0,1)+0.15 end},{wM, function(x,y) return clamp((x-250)/400,0,1)*0.8 end}}, clip=true, coverage=2, fill=true, angle=-0.03, tool="filbert 5", length={30,80}, seed=901})

--@ chunk 35
palette{scrape={wL}}
bL = pile{{"lead white",6},{"cobalt blue",0.55},{"rose madder",0.1},{"Naples yellow",0.2},{"raw umber",0.04}, name="bL"}
bS = pile{{"lead white",4},{"cobalt blue",0.8},{"rose madder",0.12},{"smalt",0.3},{"raw umber",0.06}, name="bS"}
farBerg = {
  {{{58,441},{60,429},{68,425},{132,423},{146,426},{150,441}}, "L"},
  {{{146,426},{152,429},{158,441},{150,441}}, "S"},
  {{{176,441},{180,431},{190,428},{200,431},{203,441}}, "L"},
  {{{200,431},{206,435},{208,441},{203,441}}, "S"},
  {{{958,441},{960,431},{972,426},{1000,427},{1000,441}}, "L"},
}
local occl = iceAll + poly(midridge)
for i,b in ipairs(farBerg) do
  local m = poly(b[1]) - occl
  work(m, {hand="detail", pile=(b[2]=="L" and bL or bS), clip=true, coverage=3, fill=true, angle=0, tool={kind="filbert", width=2.5}, seed=1000+i})
end

--@ chunk 36
palette{scrape={bL, bS}}
gz2 = pile{{"cobalt blue",1},{"Prussian blue",0.04},{"raw umber",0.06}, medium=0.8, name="gz2"}
clear = pile{{"lead white",0.3},{"cobalt blue",0.05}, medium=0.95, name="clear"}
local skyG = (skyM + mastBreakSky) * rect(0,0,1000,300)
local function wt(x,y) return clamp(1-y/260,0,1) end
local function wc(x,y) return clamp(y/260,0,1)+0.02 end
work(skyG, {hand="glaze", piles={{gz2, wt},{clear, wc}}, coverage=1, angle=0, clip=true, seed=1101})
blend(skyG, {angle=0.2, seed=1102})
blend(skyG, {angle=-0.2, seed=1103})

--@ chunk 37
local skyG = (skyM + mastBreakSky) * rect(0,0,1000,300)
blend(skyG, {angle=0, seed=1104})

--@ chunk 38
for _,p in ipairs({{620,250},{560,300},{700,300},{750,450},{640,480},{500,480},{880,400},{460,400},{350,420}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 39
palette{scrape={gz2, clear}}
litWarm = pile{{"lead white",6},{"Naples yellow",0.26},{"red earth",0.006}, name="litWarm"}
litCool = pile{{"lead white",6},{"cobalt blue",0.3},{"smalt",0.15},{"Naples yellow",0.04},{"rose madder",0.02}, name="litCool"}
function litGrad(name, topP, botP, power)
  local pts = face(name); local _,y0,_,y1 = bbox(pts); local h = math.max(1,y1-y0)
  power = power or 1
  return {{topP, function(x,y) return clamp(1-(y-y0)/h,0,1)^power+0.05 end},{botP, function(x,y) return clamp((y-y0)/h,0,1)^power*0.85+0.03 end}}
end
restate("A", litGrad("A", litWarm, litC, 1.2), {seed=1201, angle=-1.33, tool="filbert 6"})
restate("B", litGrad("B", litW, litCool, 1.3), {seed=1202, angle=-1.0})
restate("D1", litGrad("D1", litW, litCool, 1.0), {seed=1203, angle=-1.45})
restate("H", litGrad("H", litWarm, litCool, 1.0), {seed=1204, angle=-1.5})
restate("G", litGrad("G", litWarm, litC, 1.2), {seed=1205, angle=-1.25})
restate("R", litGrad("R", litW, litCool, 1.0), {seed=1206, angle=-1.45})
restate("K", litGrad("K", litWarm, litW, 1.0), {seed=1207})

--@ chunk 40
palette{scrape={wD, wM, litC}}
strataL = pile{{"lead white",1.6},{"cobalt blue",0.9},{"smalt",0.5},{"green earth",0.2},{"raw umber",0.1}, name="strataL"}
strataD = pile{{"lead white",1},{"cobalt blue",1},{"smalt",0.5},{"raw umber",0.25}, name="strataD"}
rg = brush{kind="rigger", width=1.2, point=1}
function L2(a,b,t) return {a[1]+(b[1]-a[1])*t, a[2]+(b[2]-a[2])*t} end
function strata(p1,p2,q1,q2,n,pileX,seed,clipm)
  local ts = uneven(n, 0.1, 0.9, 0.6, 0.4, seed)
  for _,t in ipairs(ts) do
    local a = L2(p1,p2,t); local b = L2(q1,q2,t)
    local s0 = rand(0, 0.25); local s1 = rand(0.7, 1.0)
    local A = L2(a,b,s0); local B = L2(a,b,s1); local M = L2(a,b,(s0+s1)/2)
    M = {M[1]+rand(-0.8,0.8), M[2]+rand(-0.8,0.8)}
    rg:reload(pileX, rand(0.3,0.5))
    rg:stroke({A, M, B}, {pressure={rand(0.15,0.3), rand(0.05,0.15)}, shake=0.5, clip=clipm})
  end
end
strata({644,98},{656,112},{652,400},{705,405}, 7, strataL, 1301, visible("Ae"))
strata({875,290},{886,300},{940,505},{955,505}, 5, strataL, 1302, visible("Ge"))
strata({660,415},{672,425},{655,548},{668,550}, 3, strataL, 1303, visible("He"))
strata({470,322},{478,330},{480,440},{492,442}, 3, strataL, 1304, visible("Re"))
strata({745,630},{756,640},{700,714},{716,714}, 3, strataL, 1305, visible("FGe"))
strata({450,512},{446,526},{625,472},{628,486}, 4, strataL, 1306, visible("De"))
strata({606,195},{575,215},{455,430},{446,418}, 4, strataD, 1307, visible("Be"))

--@ chunk 41
for _,p in ipairs({{850,650},{950,700},{300,690},{600,680},{100,700},{720,690}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 42
fs1 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.45},{"rose madder",0.06},{"raw umber",0.06}, name="fs1"}
fsDeep = pile{{"lead white",1.7},{"cobalt blue",0.65},{"smalt",0.45},{"rose madder",0.08},{"raw umber",0.14}, name="fsDeep"}
local band = fshadow:below() * below(function(x) return 625 end) - iceAll - waterM
work(band, {hand="broad", piles={{fs1, function(x,y) return clamp(1-(y-630)/75,0,1)+0.05 end},{fsDeep, function(x,y) return clamp((y-630)/75,0,1)^1.3 end}}, clip=true, coverage=1.6, fill=true, angle=0.04, seed=1401})
local FGv = visible("FG")
local _,y0,_,y1 = bbox(face("FG"))
work(FGv, {hand="body", piles={{mB, function(x,y) return clamp(1-(y-575)/120,0,1)+0.05 end},{sC2, function(x,y) return clamp((y-590)/110,0,1) end}}, clip=true, coverage=1.8, fill=true, angle=-0.2, tool="filbert 7", seed=1402})

--@ chunk 43
print(wait(5*24*60))
for _,p in ipairs({{100,630},{300,690},{850,650},{500,530},{600,620},{720,300},{470,350},{460,400}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 44
print(wait(3*24*60))
for _,p in ipairs({{100,630},{50,650},{300,620},{460,400},{470,350},{445,380}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 45
-- De and He become snow: rebuild occlusion order without them
front2 = {}
for _,s in ipairs(front) do if s[3] ~= "De" and s[3] ~= "He" then front2[#front2+1] = s end end
order = {}
for _,s in ipairs(back) do order[#order+1] = s end
for _,s in ipairs(front2) do order[#order+1] = s end
idx = {}
for i,s in ipairs(order) do idx[s[3]] = i end
local ia
for _,s in ipairs(order) do local p = poly(s[1]); ia = ia and (ia + p) or p end
iceAll = ia
leadO = outline{{0,604},{70,597},{150,587},{230,576},{300,565},{360,554},{410,543},{448,530},{474,516},{482,514},{470,530},{448,546},{420,560},{380,576},{320,597},{250,621},{170,647},{90,673},{0,700}, char="broken", amount=0.6, seed=77}
leadM = leadO:mask() - iceAll
print(leadM:at(30,650), leadM:at(400,560), leadM:at(470,522), leadM:at(300,640), leadM:area())
oldWater = poly(waterlead):grow(3)
deHe = (poly(face("De")) + poly(face("He"))):grow(1.5) - iceAll
repaintM = (oldWater + deHe) - leadM - iceAll
print(repaintM:area())

--@ chunk 46
palette{scrape={hD2, hL2, strataD, sDeepG}}
pl1 = pile{{"lead white",6},{"cobalt blue",0.9},{"rose madder",0.1},{"Naples yellow",0.15},{"raw umber",0.08}, name="pl1"}
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}, name="pl2"}
pl3 = pile{{"lead white",6},{"cobalt blue",0.55},{"Naples yellow",0.45},{"raw umber",0.08}, name="pl3"}
bandM = fshadow:below()
local up = repaintM - bandM
local dn = repaintM * bandM
local function w1(x,y) return clamp(1-(y-440)/80,0,1)+0.05 end
local function w2(x,y) return clamp(1-math.abs(y-540)/90,0,1)*0.9+0.05 end
local function w3(x,y) return clamp((y-560)/90,0,1)+0.05 end
work(up, {hand="broad", piles={{pl1,w1},{pl2,w2},{pl3,w3}}, coverage=2.5, fill=true, clip=true, angle=0.03, seed=1501})
work(up, {hand="body", piles={{pl1,w1},{pl2,w2},{pl3,w3}}, coverage=1.5, fill=true, clip=true, angle=0.05, seed=1502})
work(dn, {hand="broad", piles={{fs1, function(x,y) return clamp(1-(y-630)/75,0,1)+0.05 end},{fsDeep, function(x,y) return clamp((y-630)/75,0,1)^1.3 end}}, coverage=2.5, fill=true, clip=true, angle=0.04, seed=1503})
work(dn, {hand="body", piles={{fs1, function(x,y) return clamp(1-(y-630)/75,0,1)+0.05 end},{fsDeep, function(x,y) return clamp((y-630)/75,0,1)^1.3 end}}, coverage=1.5, fill=true, clip=true, angle=0.06, seed=1504})

--@ chunk 47
palette{scrape={pl1}}
wD = pile{{"bone black",1},{"Prussian blue",0.35},{"raw umber",0.4},{"lead white",0.7},{"green earth",0.3}, name="wD"}
wM = pile{{"bone black",0.6},{"Prussian blue",0.25},{"raw umber",0.2},{"lead white",2},{"cobalt blue",0.4}, name="wM"}
work(leadM, {hand="body", piles={{wD, function(x,y) return clamp(1-(x-100)/350,0,1)+0.1 end},{wM, function(x,y) return clamp((x-150)/300,0,1)*0.9 end}}, clip=true, coverage=2.2, fill=true, angle=function(x,y) return -0.17 end, tool="filbert 5", length={30,80}, seed=1601})

--@ chunk 48
palette{scrape={pl2, pl3}}
cs1 = pile{{"lead white",1.8},{"cobalt blue",0.65},{"smalt",0.45},{"Naples yellow",0.12},{"rose madder",0.06},{"raw umber",0.07}, name="cs1"}
cs2 = pile{{"lead white",2.2},{"cobalt blue",0.6},{"smalt",0.4},{"Naples yellow",0.18},{"rose madder",0.06},{"raw umber",0.05}, name="cs2"}
castO = outline{{625,548},{700,557},{780,561},{860,560},{930,556},{1000,550},{1012,550},{1012,470},{1000,474},{975,486},{955,500},{900,470},{820,440},{700,430},{620,500}, char="soft", amount=0.5, seed=88}
castM = castO:mask() - iceAll
print(castM:at(700,550), castM:at(980,520), castM:at(990,460), castM:at(700,570), castM:area())
work(castM, {hand="body", piles={{cs1, function(x,y) return clamp(1-(x-640)/300,0,1)+0.1 end},{cs2, function(x,y) return clamp((x-680)/300,0,1) end}}, clip=true, coverage=2, fill=true, angle=0.02, tool="filbert 6", seed=1701})

--@ chunk 49
palette{scrape={cs2, wD, wM}}
cs0 = pile{{"lead white",1.1},{"cobalt blue",0.7},{"smalt",0.5},{"Naples yellow",0.08},{"rose madder",0.08},{"raw umber",0.12}, name="cs0"}
work(castM, {hand="body", piles={{cs0, function(x,y) return clamp(1-(x-660)/260,0,1)+0.15 end},{cs1, function(x,y) return clamp((x-700)/250,0,1) end}}, clip=true, coverage=1.6, fill=true, angle=0.02, tool="filbert 6", seed=1702})

--@ chunk 50
for _,p in ipairs({{700,480},{750,500},{880,500},{620,250},{600,300}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 51
castEdge = outline{{612,552,"c"},{640,556},{668,553,"c"},{700,559},{735,556,"c"},{772,562},{805,558,"c"},{846,563},{880,559,"c"},{920,560},{955,555,"c"},{1000,552}, open=true, char="broken", amount=0.5, seed=91}
local below_ = castEdge:below(720)
local wipeM = castM * below_
print(wipeM:area())
r = rag{width=12}
r:dip(0.9)
r:wipe(wipeM, {pressure=0.8, angle=0, passes=2, refold=0.4})
r:dip(0.9)
r:wipe(wipeM, {pressure=0.8, angle=0.3, passes=1, refold=0.4})
print(r)

--@ chunk 52
local gn = noise{seed=21, period=40, stretch={0.2, 3}}
restate("E", {{cs1, function(x,y) return 0.6 end},{cs0, function(x,y) return 0.5 end},{sG, function(x,y) return math.max(0,gn(x,y))*0.5 end}}, {seed=1801, angle=0.12, coverage=1.8})

--@ chunk 53
for _,p in ipairs({{520,330},{600,300},{620,250},{500,450},{590,450},{460,400},{520,250},{350,420}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 54
csI = pile{{"lead white",1.4},{"cobalt blue",0.85},{"smalt",0.5},{"rose madder",0.04},{"raw umber",0.08}, name="csI"}
local Bv = visible("B")
local _,y0,_,y1 = bbox(face("B"))
work(Bv, {hand="body", piles={{litCool, function(x,y) return clamp(1-(y-y0)/(y1-y0),0,1)+0.3 end},{mB, function(x,y) return clamp((y-y0)/(y1-y0),0,1)*0.7 end},{litW, function(x,y) return 0.25 end}}, clip=true, coverage=1.8, fill=true, angle=-1.0, tool="filbert 5", seed=1901})
local Bev = visible("Be")
work(Bev, {hand="body", piles={{litWarm,1},{litW,0.5}}, clip=true, coverage=2, fill=true, angle=-0.95, tool="filbert 3", seed=1902})

--@ chunk 55
local shBA = poly({{606,196},{622,206},{628,240},{620,300},{604,360},{588,432},{558,432},{598,292}}) * visible("A")
print(shBA:area())
work(shBA, {hand="body", piles={{csI,1},{cs1,0.6}}, clip=true, coverage=2, fill=true, angle=-1.4, tool="filbert 3", seed=2001})

--@ chunk 56
local wedgeDH = poly({{546,523},{580,500},{606,484},{604,544},{575,536}}) - iceAll
print(wedgeDH:area())
work(wedgeDH, {hand="body", piles={{cs0,1},{cs1,0.5}}, clip=true, coverage=2, fill=true, angle=0.05, tool="filbert 3", seed=2101})

--@ chunk 57
ctD = pile{{"lead white",0.9},{"cobalt blue",0.9},{"smalt",0.5},{"rose madder",0.06},{"raw umber",0.25}, name="ctD"}
cb = brush{kind="round", width=3.2, point=0.6}
function contact(pts, p, load, pr, seed)
  math.randomseed(seed)
  -- broken: split polyline into 2-3 overlapping runs
  local n = #pts
  cb:reload(p, load)
  cb:stroke(pts, {pressure=pr, shake=0.6, ramps={0.15,0.3}})
end
contact({{452,513},{480,515},{500,518},{530,521},{547,523}}, ctD, 0.6, {0.55,0.7}, 1)
contact({{601,545},{630,547},{655,549}}, ctD, 0.6, {0.6,0.5}, 2)
contact({{300,456},{318,465},{340,477},{360,486},{390,484},{420,480},{455,477}}, ctD, 0.6, {0.5,0.7}, 3)
contact({{240,481},{262,485},{285,488},{305,491}}, ctD, 0.6, {0.6,0.5}, 4)
contact({{650,536},{700,537},{760,536},{812,536}}, sDeep, 0.6, {0.6,0.5}, 5)
contact({{821,541},{860,544},{900,548},{930,551}}, sDeep, 0.6, {0.5,0.6}, 6)
contact({{433,446},{445,444},{458,443}}, ctD, 0.5, {0.5,0.4}, 7)

--@ chunk 58
hullShadowQ = poly({{322,342},{345,349},{380,362},{420,372},{442,378},{442,398},{415,392},{385,386},{352,378},{330,370},{316,356}}) - hullM - frontM + (poly({{322,342},{345,349},{380,362},{420,372},{442,378},{442,398},{415,392},{385,386},{352,378},{330,370},{316,356}}) * poly(face("Q")) - hullM)
hullShadowQ = poly({{322,342},{345,349},{380,362},{420,372},{442,378},{442,398},{415,392},{385,386},{352,378},{330,370},{316,356}}) - hullM - poly(face("R"))
print(hullShadowQ:area(), hullShadowQ:at(380,372), hullShadowQ:at(380,340))
work(hullShadowQ, {hand="body", piles={{cs0,1},{csI,0.6}}, clip=true, coverage=2, fill=true, angle=0.35, tool="filbert 3", seed=2201})

--@ chunk 59
print(wait(24*60))
for _,p in ipairs({{380,370},{560,520},{700,480},{750,545},{500,250},{600,300},{300,620},{470,520}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 60
print(wait(2*24*60))
for _,p in ipairs({{380,370},{560,520},{700,480},{750,545},{600,300},{300,620},{470,520},{100,640}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 61
print(wait(2*24*60))
for _,p in ipairs({{380,370},{560,520},{700,480},{750,545},{600,300},{300,620},{470,520},{100,640}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 62
print(wait(2*24*60))
for _,p in ipairs({{560,520},{700,480},{750,545},{600,300},{470,520},{100,640}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 63
newSlabs = {
  {{{346,398},{351,356},{364,330},{379,315},{390,352},{394,400}}, "L", "S1"},
  {{{379,315},{390,321},{409,396},{394,400},{390,352}}, "S", "S1e"},
  {{{412,392},{417,374},{430,365},{441,383},{437,397}}, "L", "S2"},
  {{{430,365},{437,368},{446,386},{441,383}}, "S", "S2e"},
}
for _,s in ipairs(newSlabs) do order[#order+1] = s; idx[s[3]] = #order end
iceAll = iceAll + poly(newSlabs[1][1]) + poly(newSlabs[2][1]) + poly(newSlabs[3][1]) + poly(newSlabs[4][1])
work(visible("S1"), {hand="body", piles={{litWarm, function(x,y) return clamp(1-(y-315)/85,0,1)+0.1 end},{litCool, function(x,y) return clamp((y-330)/70,0,1) end}}, clip=true, coverage=2.2, fill=true, angle=-1.35, tool="filbert 3", seed=2301})
work(visible("S1e"), {hand="body", piles={{sC1,1},{sG,0.5}}, clip=true, coverage=2.2, fill=true, angle=1.33, tool="filbert 2", seed=2302})
work(visible("S2"), {hand="body", piles={{litWarm,1},{litCool,0.4}}, clip=true, coverage=2.2, fill=true, angle=-0.6, tool="filbert 2", seed=2303})
work(visible("S2e"), {hand="body", pile=sC1, clip=true, coverage=2.2, fill=true, angle=1.1, tool="filbert 2", seed=2304})

--@ chunk 64
-- R's cast shadow onto B
local shRB = poly({{478,330},{494,336},{508,372},{516,420},{505,444},{492,442}}) * visible("B")
print(shRB:area())
work(shRB, {hand="body", piles={{csI,1},{cs0,0.5}}, clip=true, coverage=2, fill=true, angle=-1.35, tool="filbert 2", seed=2401})
-- contact under shards on Q
cb = brush{kind="round", width=2.6, point=0.6}
cb:reload(ctD, 0.55); cb:stroke({{346,399},{360,401},{378,401},{394,401},{408,397}}, {pressure={0.55,0.45}, shake=0.5})
cb:reload(ctD, 0.5); cb:stroke({{412,393},{425,397},{437,398},{446,388}}, {pressure={0.45,0.4}, shake=0.5})
-- crevice darks along tops of front slabs where they overlap slabs behind
cb:reload(ctD, 0.55); cb:stroke({{463,428},{480,414},{498,401},{515,388},{534,391},{556,394}}, {pressure={0.4,0.5}, shake=0.5})
cb:reload(sDeep, 0.5); cb:stroke({{612,429},{625,415},{640,401},{652,409},{660,415}}, {pressure={0.4,0.35}, shake=0.5})

--@ chunk 65
for _,p in ipairs({{100,700},{300,690},{500,680},{600,650},{850,690},{200,600},{50,610}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 66
palette{scrape={cs1, csI}}
fg1 = pile{{"lead white",1.6},{"cobalt blue",0.6},{"smalt",0.4},{"raw umber",0.22},{"Naples yellow",0.12},{"rose madder",0.04}, name="fg1"}
fg2 = pile{{"lead white",1.2},{"cobalt blue",0.55},{"smalt",0.4},{"raw umber",0.3},{"red earth",0.05},{"Naples yellow",0.1}, name="fg2"}
local bm = fshadow:below() - iceAll - leadM
local function wTop(x,y) return clamp(1-(y-560)/70,0,1)+0.05 end
local function wMid(x,y) return clamp(1-math.abs(y-650)/60,0,1)*0.9 end
local function wBot(x,y) return clamp((y-640)/60,0,1)*clamp(1-(x-200)/600,0.15,1) end
work(bm, {hand="broad", piles={{fs1,wTop},{fg1,wMid},{fg2,wBot}}, clip=true, coverage=2.2, fill=true, angle=0.05, seed=2501})
work(bm, {hand="body", piles={{fs1,wTop},{fg1,wMid},{fg2,wBot}}, clip=true, coverage=1.2, fill=true, angle=0.08, length={40,90}, seed=2502})

--@ chunk 67
palette{scrape={sDeep, fs1, fsDeep}}
plankD = pile{{"bone black",1.5},{"raw umber",1}, medium=0.15, name="plankD"}
plankL = pile{{"raw umber",1},{"lead white",0.6},{"yellow ochre",0.3},{"red earth",0.1}, name="plankL"}
hullClip = poly(hull, true) - iceAll - ribbon(mast, 9)
stemP = {{300,272},{293,292},{297,312},{318,330}}
topP = {{300,272},{360,296},{440,334},{520,378}}
botP = {{318,330},{390,372},{470,412},{532,442}}
function stemAt(s) local n=#stemP-1; local f=s*n; local i=math.min(n, math.floor(f)+1); local t=f-(i-1); return L2(stemP[i], stemP[i+1], t) end
function hullLine(s) local pts = {stemAt(s)} for j=2,4 do pts[#pts+1] = L2(topP[j], botP[j], s) end return pts end
rb = brush{kind="round", width=1.3, point=1}
lb = brush{kind="round", width=1.1, point=1}
local ss = {0.07, 0.13, 0.19, 0.27, 0.36, 0.45, 0.55, 0.65, 0.76, 0.87}
for k,s in ipairs(ss) do
  local pts = hullLine(s)
  rb:reload(plankD, rand(0.5,0.7))
  rb:stroke(pts, {pressure={rand(0.35,0.5), rand(0.4,0.55)}, shake=0.4, clip=hullClip})
  if s < 0.6 then
    local lp = {}
    for i=1,#pts do lp[i] = {pts[i][1]+0.6, pts[i][2]-1.6} end
    lb:reload(plankL, rand(0.2,0.3))
    lb:stroke({lp[1], lp[2], lp[3]}, {pressure={0.3*(1-s), 0.03}, shake=0.6, clip=hullClip})
  end
end
local w1 = hullLine(0.215); local w2 = hullLine(0.25)
local wb = brush{kind="round", width=3, point=0.3}
local mid = {} for i=1,#w1 do mid[i] = L2(w1[i], w2[i], 0.5) end
wb:reload(plankD, 0.8)
wb:stroke(mid, {pressure={0.65,0.7}, clip=hullClip})
local wl = {} for i=1,#w1 do wl[i] = {w1[i][1]+0.3, w1[i][2]-0.8} end
lb:reload(plankL, 0.4)
lb:stroke({wl[1], wl[2], wl[3]}, {pressure={0.4,0.1}, clip=hullClip})

--@ chunk 68
palette{scrape={fg1, fg2}}
woodD = pile{{"raw umber",2},{"bone black",1.2},{"red earth",0.12}, name="woodD"}
woodL = pile{{"raw umber",1},{"lead white",0.9},{"yellow ochre",0.35},{"red earth",0.08}, name="woodL"}
local function unit(a,b) local dx,dy=b[1]-a[1],b[2]-a[2]; local l=math.sqrt(dx*dx+dy*dy); return dx/l,dy/l,l end
-- mast: dark core
mb = brush{kind="round", width=7, point=0.2}
mb:reload(woodD, 0.9)
mb:stroke({{398,316},{422,263},{445,214}}, {pressure={0.95,0.85}, clip=-(iceAll)})
-- bowsprit: dark core tapering
bb2 = brush{kind="round", width=7, point=0.4}
bb2:reload(woodD, 0.9)
bb2:stroke({{306,277},{260,255},{213,233}}, {pressure={0.95,0.7}})
-- lit edges: mast left side; bowsprit top side
lb2 = brush{kind="round", width=2, point=0.8}
local ux,uy = unit({398,316},{445,214})
local nx,ny = uy, -ux  -- left normal? for vector (0.42,-0.9): (-0.9,-0.42) -> left-up
lb2:reload(woodL, 0.5)
lb2:stroke({{398-2.2,316-0.6},{422-2.2,263-0.8},{444-2.0,216-0.8}}, {pressure={0.5,0.35}, shake=0.4, clip=-(iceAll)})
lb2:reload(woodL, 0.5)
lb2:stroke({{300,272.5},{258,251.3},{216,231}}, {pressure={0.45,0.25}, shake=0.4})

--@ chunk 69
snowW = pile{{"lead white",6},{"Naples yellow",0.2}, name="snowW"}
rg2 = brush{kind="rigger", width=1.0, point=1}
hb = brush{kind="round", width=2.2, point=0.7}
-- rail shadow line just under the cap
hb:reload(woodD, 0.6)
hb:stroke({{302,275},{340,291},{380,309},{420,328},{438,337}}, {pressure={0.45,0.4}, shake=0.3, clip=-(iceAll)})
-- snow / light on rail cap: broken runs
local runs = {{{299,271.5},{318,278.5},{334,285}}, {{342,288},{360,295.5},{378,304}}, {{386,307.5},{404,316},{420,323.5}}}
for i,r in ipairs(runs) do
  hb:reload(snowW, 0.55)
  hb:stroke(r, {pressure={0.55,0.3}, shake=0.5, clip=-(iceAll)})
end
-- snow lumps on cap
for _,p in ipairs({{312,276},{351,291},{395,311},{368,299}}) do
  hb:reload(snowW, 0.5); hb:touch(p[1], p[2]-0.6, {pressure=0.5, drag={3,1.2}})
end
-- lit stem
sb = brush{kind="round", width=2.4, point=0.8}
sb:reload(woodL, 0.5)
sb:stroke({{300.5,274},{295.5,286},{294.5,296},{297,308},{303,318}}, {pressure={0.5,0.1}, shake=0.3})
-- slack stay from bowsprit tip
rg2:reload(woodD, 0.4)
rg2:stroke({{214,234},{216,248},{220,262},{226,274},{231,282}}, {pressure={0.3,0.12}, shake=0.6})
-- forestay remnant from bowsprit up toward the broken mast, slack
rg2:reload(woodD, 0.4)
rg2:stroke({{240,246},{290,250},{340,248},{390,236},{438,222}}, {pressure={0.18,0.22}, shake=0.5})
-- shrouds from mast to rail
rg2:reload(woodD, 0.4)
rg2:stroke({{432,240},{412,268},{392,304}}, {pressure={0.22,0.18}, shake=0.4})
rg2:reload(woodD, 0.4)
rg2:stroke({{432,240},{420,272},{410,312}}, {pressure={0.22,0.18}, shake=0.4})
-- rope hanging from mast stump to the right over the ice
rg2:reload(woodD, 0.4)
rg2:stroke({{441,224},{452,238},{458,256},{460,272}}, {pressure={0.22,0.08}, shake=0.6})

--@ chunk 70
palette{scrape={plankD, plankL, strataL}}
shTop = pile{{"lead white",2.2},{"cobalt blue",0.6},{"smalt",0.4},{"Naples yellow",0.18},{"rose madder",0.06},{"raw umber",0.05}, name="shTop"}
shDeep = pile{{"lead white",0.7},{"cobalt blue",0.9},{"smalt",0.5},{"rose madder",0.06},{"raw umber",0.3}, name="shDeep"}
function blockShapes(x, y, w, h, seed)
  math.randomseed(seed)
  local t = rand(-0.3, 0.3)
  local ux, uy = math.cos(t), math.sin(t)
  local vx, vy = math.sin(t), -math.cos(t)
  local function P(a,b) return {x + a*ux + b*vx, y + a*uy + b*vy} end
  local hl, hr = h*rand(0.55,1.0), h*rand(0.55,1.0)
  local lean = rand(-0.1,0.2)*h
  local bl, br = P(-w/2, 0), P(w/2, 0)
  local tl = P(-w/2 + lean*0.5, hl)
  local tr = P(w/2 + lean, hr)
  local f1, f2 = rand(0.2,0.45), rand(0.55,0.85)
  local j1 = P(lerp(-w/2, w/2, f1) + lean*0.7, lerp(hl, hr, f1) + h*rand(-0.18,0.08))
  local j2 = P(lerp(-w/2, w/2, f2) + lean*0.8, lerp(hl, hr, f2) + h*rand(-0.12,0.1))
  local front = {bl, tl, j1, j2, tr, br}
  local dep = w*rand(0.2,0.5)
  local d = {dep*0.8, -dep*0.3}
  local function D(p) return {p[1]+d[1], p[2]+d[2]} end
  local top = {tl, D(tl), D(j1), D(j2), D(tr), tr, j2, j1}
  local right = {br, tr, D(tr), D(br)}
  for _,list in ipairs({front, top, right}) do for _,p in ipairs(list) do if p[2] > y + 1 then p[2] = y + 1 end end end
  local rxp = math.max(br[1], tr[1]) + d[1]
  local shadow = {{br[1]-w*0.2, y+1}, {rxp, y - math.min(dep*0.3, h*0.3)}, {rxp + h*rand(0.7,1.3), y - h*0.06}, {br[1] + h*rand(0.5,0.9), y + h*0.12}, {x, y + h*0.1}}
  return front, top, right, shadow
end
rubbleM = nil
function paintBlock(x, y, w, h, seed, inShadow, avoid)
  local front, top, right, shadow = blockShapes(x, y, w, h, seed)
  local fm, tm, rm = poly(front), poly(top), poly(right)
  tm = tm - fm; rm = rm - fm - tm
  if avoid then fm = fm - avoid; tm = tm - avoid; rm = rm - avoid end
  local all = fm + tm + rm
  rubbleM = rubbleM and (rubbleM + all) or all
  local tool = {kind="filbert", width=math.max(1.2, math.min(4, w*0.12))}
  if not inShadow then
    local sm = poly(shadow) - all
    if avoid then sm = sm - avoid end
    work(sm, {hand="detail", pile=cs0, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed})
    work(fm, {hand="detail", piles={{mB,1},{mA,0.6}}, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+1})
    work(tm, {hand="detail", pile=litWarm, clip=true, coverage=3, fill=true, tool=tool, angle=-0.3, seed=seed+2})
    work(rm, {hand="detail", pile=sC1, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+3})
  else
    work(fm, {hand="detail", piles={{cs0,1},{shTop,0.6}}, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+1})
    work(tm, {hand="detail", pile=shTop, clip=true, coverage=3, fill=true, tool=tool, angle=-0.3, seed=seed+2})
    work(rm, {hand="detail", pile=shDeep, clip=true, coverage=3, fill=true, tool=tool, angle=-1.5, seed=seed+3})
  end
end
-- base rubble, lit side (in front of T, Q, D1, H); back first
baseLit = {
  {262,492,20,12},{238,497,12,7},{290,499,14,8},{326,494,26,15},{356,497,12,7},{388,491,18,11},{420,489,14,8},{445,487,10,6},
  {512,532,22,13},{537,529,12,7},{556,536,26,14},{588,548,12,8},{603,556,18,10},
}
local k = 0
for _,b in ipairs(baseLit) do k = k + 1; paintBlock(b[1], b[2], b[3], b[4], 3000 + k*7, false, leadM) end

--@ chunk 71
function slabPiece(faces, seed, avoid)
  -- faces: list of {pts, kind}; kinds: top (lit warm), lit, half, shade, deep
  local P = {top={{litWarm,1},{litW,0.5}}, lit={{litW,1},{litCool,0.5}}, half={{mB,1},{mA,0.6}}, shade={{sC1,1},{cs0,0.5}}, deep={{shDeep,1},{sC1,0.3}}}
  local acc
  for i,f in ipairs(faces) do
    local m = poly(f[1])
    if acc then m = m - acc end
    if avoid then m = m - avoid end
    local x0,y0,x1,y1 = bbox(f[1])
    local tool = {kind="filbert", width=math.max(1.2, math.min(4, (x1-x0)*0.1))}
    work(m, {hand="detail", piles=P[f[2]], clip=true, coverage=3, fill=true, tool=tool, angle=f[3] or longest_angle(f[1]), seed=seed+i})
    acc = acc and (acc + poly(f[1])) or poly(f[1])
  end
  rubbleM = rubbleM + acc
  return acc
end
-- 1: big tilted plate lying in front of Q (front faces painted first so later = in front? no: list order front-most first, acc protects)
slabPiece({
  {{{330,500},{346,486},{392,481},{405,491},{381,504}}, "top", -0.1},
  {{{330,500},{381,504},{405,491},{406,497},{382,511},{331,506}}, "half", -0.1},
}, 3100, leadM)
-- shadow of plate to its right on the snow
work(poly({{404,492},{424,494},{430,503},{404,510},{382,511}}) - rubbleM - leadM, {hand="detail", pile=cs0, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, seed=3110})
-- 2: upright shard at the lead's tip
slabPiece({
  {{{457,514},{461,494},{468,481},{476,513}}, "lit", -1.4},
  {{{468,481},{474,485},{481,511},{476,513}}, "shade", -1.4},
}, 3120, nil)
-- 3: fallen slab between D1 and H at the base
slabPiece({
  {{{561,549},{574,538},{604,540},{599,555}}, "top", 0},
  {{{561,549},{599,555},{604,540},{605,545},{600,560},{561,554}}, "half", 0},
}, 3130, nil)
work(poly({{605,545},{622,548},{626,556},{600,560}}) - rubbleM, {hand="detail", pile=cs0, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, seed=3140})

--@ chunk 72
baseSh = {
  {668,552,16,9},{690,556,24,12},{716,553,12,7},{742,558,20,10},{770,556,14,8},{796,560,26,13},{826,556,12,6},{852,561,22,11},{880,559,14,7},{905,561,18,9},{934,557,24,12},{962,553,14,7},
}
local k = 0
for _,b in ipairs(baseSh) do k = k + 1; paintBlock(b[1], b[2], b[3], b[4], 3200 + k*7, true, nil) end
-- a couple of lit blocks standing at the outer edge of the shadow (catching light on top)
paintBlock(985, 566, 22, 12, 3301, false, nil)

--@ chunk 73
-- extend shadow forward/right of the shadowed rubble: broken tongues past the shadow edge
local tongues = {
  {{676,556},{700,558},{712,566},{684,566}},
  {{700,560},{740,562},{752,569},{712,568}},
  {{752,561},{790,563},{800,570},{760,569}},
  {{806,566},{846,566},{858,573},{816,574}},
  {{860,566},{900,567},{912,573},{870,574}},
  {{915,566},{948,563},{962,569},{925,573}},
}
local tm
for _,t in ipairs(tongues) do local p = poly(t); tm = tm and (tm + p) or p end
tm = tm - rubbleM - iceAll
work(tm, {hand="detail", piles={{cs0,1},{shTop,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=0.02, seed=3401})
-- second row of scattered lit blocks forward of the base
local scat = {{640,574,12,8},{724,581,18,10},{775,577,10,6},{845,586,16,9},{915,582,10,6},{962,590,20,10},{498,560,10,6},{430,522,12,7},{300,520,10,6},{372,528,8,5},{205,505,10,6}}
local k=0
for _,b in ipairs(scat) do k=k+1; paintBlock(b[1], b[2], b[3], b[4], 3500 + k*7, false, leadM) end

--@ chunk 74
local tongues = {
  {{676,556},{700,558},{712,566},{684,566}},
  {{700,560},{740,562},{752,569},{712,568}},
  {{752,561},{790,563},{800,570},{760,569}},
  {{806,566},{846,566},{858,573},{816,574}},
  {{860,566},{900,567},{912,573},{870,574}},
  {{915,566},{948,563},{962,569},{925,573}},
}
local tm
for _,t in ipairs(tongues) do local p = poly(t); tm = tm and (tm + p) or p end
tm = (tm - rubbleM - iceAll):grow(1.5) - rubbleM
r = rag{width=10}
for pass=1,3 do
  r:dip(0.9)
  r:wipe(tm, {pressure=0.85, angle=0.02 + pass*0.4, passes=1, refold=0.3})
end
print(r)

--@ chunk 75
local tongues = {
  {{676,556},{700,558},{712,566},{684,566}},
  {{700,560},{740,562},{752,569},{712,568}},
  {{752,561},{790,563},{800,570},{760,569}},
  {{806,566},{846,566},{858,573},{816,574}},
  {{860,566},{900,567},{912,573},{870,574}},
  {{915,566},{948,563},{962,569},{925,573}},
}
local tm
for _,t in ipairs(tongues) do local p = poly(t); tm = tm and (tm + p) or p end
tm = (tm - rubbleM - iceAll):grow(2) - rubbleM
for pass=1,4 do
  r = rag{width=8}
  r:dip(1.0)
  r:wipe(tm, {pressure=0.95, angle=pass*0.7, passes=2, refold=0.2})
end
print(r)

--@ chunk 76
local m = ellipse(205,503,10,7) + ellipse(300,518,10,7) + ellipse(372,527,9,6) + ellipse(498,559,9,6)
for pass=1,3 do
  local rr = rag{width=8}
  rr:dip(1.0)
  rr:wipe(m, {pressure=0.95, angle=pass*0.9, passes=2, refold=0.2})
end

--@ chunk 77
print(wait(4*24*60))
for _,p in ipairs({{100,650},{300,640},{600,660},{850,690},{850,640},{720,690},{560,545},{380,495},{900,560},{50,620}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 78
bankTop = {}
for x = 0, 480, 4 do
  local yb = nil
  for y = 500, 714, 0.5 do if leadM:at(x, y) > 0.5 then yb = y; break end end
  if yb then bankTop[#bankTop+1] = {x, yb} end
end
bankBot = {}
for x = 0, 470, 4 do
  local yb = nil
  for y = 714, 500, -0.5 do if leadM:at(x, y) > 0.5 then yb = y; break end end
  if yb then bankBot[#bankBot+1] = {x, yb} end
end
print(#bankTop, bankTop[1][2], bankTop[#bankTop][1], bankTop[#bankTop][2], #bankBot, bankBot[1][2], bankBot[#bankBot][2])
for i=1,#bankTop,10 do io=nil; print(bankTop[i][1], bankTop[i][2]) end

--@ chunk 79
palette{scrape={woodL}}
edgeG = pile{{"lead white",2},{"cobalt blue",0.6},{"green earth",0.45},{"Prussian blue",0.05},{"smalt",0.2}, name="edgeG"}
reflW = pile{{"bone black",0.6},{"Prussian blue",0.25},{"raw umber",0.25},{"lead white",1.4},{"green earth",0.4},{"cobalt blue",0.3}, name="reflW"}
local i = 2
while i < #bankTop - 1 do
  local n = math.random(2, 4)
  local seg = {}
  local x0 = bankTop[i][1]
  local hgt = lerp(5.5, 2.0, x0/480) * rand(0.7, 1.2)
  for j = i, math.min(i+n, #bankTop) do seg[#seg+1] = {bankTop[j][1], bankTop[j][2] + hgt*0.5 + 0.3} end
  if #seg >= 2 then
    local b = brush{kind="round", width=math.max(1.4, hgt), point=0.3}
    b:reload(edgeG, rand(0.5,0.75))
    b:stroke(seg, {pressure={rand(0.55,0.8), rand(0.5,0.8)}, shake=0.4, clip=leadM})
  end
  i = i + n
end
local rb = brush{kind="round", width=2.4, point=0.5}
for k=1,40 do
  local j = math.random(2, #bankTop-4)
  local x0 = bankTop[j][1]; local y0 = bankTop[j][2]
  local hgt = lerp(5.5, 2.0, x0/480)
  local len = rand(8, 26)
  local slope = (bankTop[j+3][2] - bankTop[j][2]) / math.max(1,(bankTop[j+3][1] - x0))
  local y = y0 + hgt + rand(1.0, hgt*1.6)
  rb:reload(reflW, rand(0.3,0.55))
  rb:stroke({{x0, y}, {x0+len, y + slope*len}}, {pressure={rand(0.3,0.55), 0.1}, shake=0.3, clip=leadM})
end

--@ chunk 80
local pts = {}
for j=2,#bankTop do local x = bankTop[j][1]; local h = lerp(5.5,2.0,x/480); pts[#pts+1] = {x, bankTop[j][2] + h*0.6} end
wallBand = ribbon(pts, 7) * leadM
blend(wallBand, {angle=-0.2, seed=3601})

--@ chunk 81
palette{scrape={reflW, edgeG}}
fgA = pile{{"lead white",2.4},{"cobalt blue",0.55},{"smalt",0.35},{"Naples yellow",0.2},{"rose madder",0.06},{"raw umber",0.04}, name="fgA"}
fgB = pile{{"lead white",1.5},{"cobalt blue",0.6},{"smalt",0.4},{"raw umber",0.2},{"Naples yellow",0.12},{"rose madder",0.05}, name="fgB"}
local FGm = poly(face("FG"))
work(FGm, {hand="body", piles={{fgA, function(x,y) return clamp(1-(y-575)/110,0,1)+0.1 end},{fgB, function(x,y) return clamp((y-600)/100,0,1) end}}, clip=true, coverage=2, fill=true, angle=-0.22, tool="filbert 7", seed=3701})
blend(FGm:shrink(1), {angle=-0.22, seed=3702})

--@ chunk 82
print(palette())

--@ chunk 83
palette{scrape={fgA, fgB, snowW}}
pl1 = pile{{"lead white",6},{"cobalt blue",0.9},{"rose madder",0.1},{"Naples yellow",0.15},{"raw umber",0.08}, name="pl1"}
cs1 = pile{{"lead white",1.8},{"cobalt blue",0.65},{"smalt",0.45},{"Naples yellow",0.12},{"rose madder",0.06},{"raw umber",0.07}, name="cs1"}
-- gap between C, E and G: in shadow, crisp
local gap = poly({{790,440},{862,392},{852,484},{780,472}}) - iceAll - rubbleM
work(gap, {hand="detail", piles={{cs0,1},{cs1,0.6}}, clip=true, coverage=3, fill=true, angle=0, tool={kind="filbert", width=3}, seed=3801})
-- far right: lit far plain above a jagged shadow edge, shadow below
farEdge = {{946,506},{956,500},{961,494},{969,497},{977,489},{985,491},{992,484},{1000,486},{1006,483}}
local region = poly({{944,442},{1006,442},{1006,560},{944,560}}) - iceAll - rubbleM
local abv = region * above(farEdge)
local blw = region * below(farEdge)
work(abv, {hand="detail", piles={{pl1,1},{litCool,0.3}}, clip=true, coverage=3, fill=true, angle=0, tool={kind="filbert", width=3}, seed=3802})
work(blw * above(function(x) return 545 end), {hand="detail", piles={{cs1,1},{cs0,0.5}}, clip=true, coverage=3, fill=true, angle=0, tool={kind="filbert", width=3}, seed=3803})

--@ chunk 84
local sl = poly({{928,503},{950,503},{950,562},{924,562}}) - iceAll - rubbleM
work(sl, {hand="detail", piles={{cs1,1},{cs0,0.5}}, clip=true, coverage=3, fill=true, angle=1.5, tool={kind="filbert", width=2}, seed=3804})

--@ chunk 85
for _,p in ipairs({{760,300},{380,420},{740,480},{820,300},{880,520}}) do print(p[1],p[2],drying(p[1],p[2])) end
print(visible("C"):area(), visible("Q"):area(), visible("E"):area())

--@ chunk 86
local gn = noise{seed=17, period=80, stretch={1.0, 5}}
local Cv = visible("C") - rubbleM
local _,y0,_,y1 = bbox(face("C"))
work(Cv, {hand="broad", piles={{sC1, function(x,y) return clamp(1-(y-y0)/(y1-y0),0,1)*0.9+0.1 end},{sC2, function(x,y) return clamp((y-y0)/(y1-y0),0,1)*0.9 end},{sG, function(x,y) return math.max(0, gn(x,y))*0.7 end}}, clip=true, coverage=2, fill=true, angle=1.0, tool="filbert 10", seed=3901})
blend(Cv:shrink(1), {angle=1.0, seed=3902})

--@ chunk 87
local gn = noise{seed=23, period=60, stretch={0.2, 4}}
local protectQ = hullShadowQ + ribbon({{346,399},{360,401},{378,401},{394,401},{408,397}}, 4) + ribbon({{412,393},{425,397},{437,398},{446,388}}, 4) + ribbon({{300,456},{318,465},{340,477},{360,486},{390,484},{420,480},{455,477}}, 4) + rubbleM
local Qv = visible("Q") - protectQ
local _,y0,_,y1 = bbox(face("Q"))
work(Qv, {hand="broad", piles={{mA, function(x,y) return clamp(1-(y-y0)/(y1-y0),0,1)*0.8+0.2 end},{mB, function(x,y) return clamp((y-y0)/(y1-y0),0,1)*0.9+0.1 end},{sG, function(x,y) return math.max(0, gn(x,y))*0.35 end}}, clip=true, coverage=2, fill=true, angle=0.25, tool="filbert 8", seed=4001})
blend(Qv:shrink(1), {angle=0.25, seed=4002})
local protectE = ribbon({{650,536},{700,537},{760,536},{812,536}}, 4) + rubbleM
local Ev = visible("E") - protectE
local gn2 = noise{seed=29, period=50, stretch={0.1, 4}}
work(Ev, {hand="broad", piles={{cs1, function(x,y) return 0.6 end},{cs0, function(x,y) return 0.5 end},{sG, function(x,y) return math.max(0,gn2(x,y))*0.4 end}}, clip=true, coverage=2, fill=true, angle=0.12, tool="filbert 8", seed=4003})
blend(Ev:shrink(1), {angle=0.12, seed=4004})
local D2v = visible("D2") - rubbleM
work(D2v, {hand="broad", piles=grad(mA, mB, face("D2")), clip=true, coverage=2, fill=true, angle=1.4, tool="filbert 7", seed=4005})
blend(D2v:shrink(1), {angle=1.4, seed=4006})

--@ chunk 88
palette{scrape={pl1, woodD, ctD}}
fg1 = pile{{"lead white",1.6},{"cobalt blue",0.6},{"smalt",0.4},{"raw umber",0.22},{"Naples yellow",0.12},{"rose madder",0.04}, name="fg1"}
fg2 = pile{{"lead white",1.2},{"cobalt blue",0.55},{"smalt",0.4},{"raw umber",0.3},{"red earth",0.05},{"Naples yellow",0.1}, name="fg2"}
fs1 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.45},{"rose madder",0.06},{"raw umber",0.06}, name="fs1"}
local bm = (fshadow:below() - iceAll - leadM - rubbleM - poly(face("FG")))
local function wTop(x,y) return clamp(1-(y-560)/70,0,1)+0.05 end
local function wMid(x,y) return clamp(1-math.abs(y-650)/60,0,1)*0.9 end
local function wBot(x,y) return clamp((y-640)/60,0,1)*clamp(1-(x-200)/600,0.15,1) end
work(bm, {hand="broad", piles={{fs1,wTop},{fg1,wMid},{fg2,wBot}}, clip=true, coverage=2, fill=true, angle=0.05, tool="filbert 12", seed=4101})
blend(bm:shrink(1), {angle=0.05, seed=4102})

--@ chunk 89
palette{scrape={fs1}}
wD = pile{{"bone black",1},{"Prussian blue",0.35},{"raw umber",0.4},{"lead white",0.7},{"green earth",0.3}, name="wD"}
wM = pile{{"bone black",0.6},{"Prussian blue",0.25},{"raw umber",0.2},{"lead white",2},{"cobalt blue",0.4}, name="wM"}
local pts = {}
for j=1,#bankTop do local x = bankTop[j][1]; local h = lerp(5.5,2.0,x/480); pts[#pts+1] = {x, bankTop[j][2] + h*0.5} end
wallKeep = ribbon(pts, 9)
waterBody = leadM - wallKeep
work(waterBody, {hand="broad", piles={{wD, function(x,y) return clamp(1-(x-100)/350,0,1)+0.1 end},{wM, function(x,y) return clamp((x-150)/300,0,1)*0.9 end}}, clip=true, coverage=2, fill=true, angle=-0.15, tool="filbert 10", seed=4201})
blend(waterBody:shrink(0.5), {angle=-0.12, seed=4202})

--@ chunk 90
palette{scrape={fg1, fg2}}
reflW = pile{{"bone black",0.6},{"Prussian blue",0.25},{"raw umber",0.25},{"lead white",1.4},{"green earth",0.4},{"cobalt blue",0.3}, name="reflW"}
local rb = brush{kind="round", width=3, point=0.3}
for k=1,36 do
  local j = math.random(2, #bankTop-4)
  local x0 = bankTop[j][1]; local y0 = bankTop[j][2]
  local hgt = lerp(5.5, 2.0, x0/480)
  local len = rand(14, 34)
  local slope = (bankTop[j+3][2] - bankTop[j][2]) / math.max(1,(bankTop[j+3][1] - x0))
  local y = y0 + hgt + rand(1.5, hgt*1.4)
  rb:reload(reflW, rand(0.35,0.6))
  rb:stroke({{x0, y}, {x0+len, y + slope*len}}, {pressure={rand(0.35,0.6), 0.15}, shake=0.2, clip=waterBody})
end
ripple = pile{{"lead white",2},{"cobalt blue",0.6},{"bone black",0.12},{"green earth",0.1}, name="ripple"}
local rr = brush{kind="round", width=1.6, point=0.6}
for i=1,14 do
  local x0 = rand(0, 330)
  local jt = math.floor(x0/4)+1; jt = math.max(1, math.min(#bankTop, jt))
  local jb = math.max(1, math.min(#bankBot, jt))
  local ya, yb2 = bankTop[jt][2] + 14, bankBot[jb][2] - 4
  if yb2 > ya then
    local y = rand(ya, yb2)
    local len = rand(25, 90)
    rr:reload(ripple, rand(0.2,0.35))
    rr:stroke({{x0, y}, {x0+len*0.5, y - len*0.5*0.25 + rand(-0.6,0.6)}, {x0+len, y - len*0.25}}, {pressure={0.12,0.04}, shake=0.3, clip=waterBody})
  end
end

--@ chunk 91
blend(waterBody:shrink(0.5), {angle=-0.24, seed=4301})

--@ chunk 92
print(wait(5*24*60))
for _,p in ipairs({{760,300},{380,430},{740,480},{580,470},{100,650},{200,620},{500,690},{900,690},{620,420},{960,520}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 93
palette{scrape={wD, wM, reflW, ripple}}
crk2 = pile{{"lead white",1.4},{"cobalt blue",0.7},{"smalt",0.45},{"raw umber",0.12}, name="crk2"}
crkL = pile{{"lead white",3},{"cobalt blue",0.5},{"smalt",0.3}, name="crkL"}
sDeep = pile{{"lead white",0.6},{"cobalt blue",1},{"Prussian blue",0.12},{"raw umber",0.4}, name="sDeep"}
snowW = pile{{"lead white",6},{"Naples yellow",0.2}, name="snowW"}
rg = brush{kind="rigger", width=1.0, point=1}
function fracture2(pts, dk, lt, s, opts)
  opts = opts or {}
  local pr = opts.pr or 0.3
  for i=1,#pts-1 do
    local a, b = pts[i], pts[i+1]
    rg:reload(dk, opts.load or 0.45)
    local p0 = (i==1) and pr*0.5 or pr
    local p1 = (i==#pts-1) and pr*0.3 or pr
    rg:stroke({a, b}, {pressure={p0, p1}, shake=0.15, clip=opts.clip})
    if lt then
      local dx, dy = b[1]-a[1], b[2]-a[2]; local L = math.sqrt(dx*dx+dy*dy)
      local ox, oy = dy/L*s*1.4, -dx/L*s*1.4
      rg:reload(lt, (opts.load or 0.45)*0.9)
      rg:stroke({{a[1]+ox,a[2]+oy},{b[1]+ox,b[2]+oy}}, {pressure={p0*0.9, p1*0.9}, shake=0.15, clip=opts.clip})
    end
  end
end
local litFr = {
  {"A", {{590,330},{604,322},{618,327},{633,318},{648,322}}},
  {"A", {{612,170},{617,200},{614,222},{621,250}}},
  {"A", {{596,250},{606,262},{604,280}}},
  {"B", {{500,360},{520,352},{538,358},{556,349},{575,353}}},
  {"B", {{545,250},{550,275},{546,295},{553,318}}},
  {"G", {{860,380},{878,372},{895,378},{910,371}}},
  {"G", {{880,330},{884,355},{881,370}}},
  {"D1", {{470,470},{490,462},{507,467},{528,458},{545,462}}},
  {"H", {{612,480},{625,474},{640,478},{652,472}}},
  {"R", {{440,400},{452,395},{466,399},{476,394}}},
  {"S1", {{355,370},{366,365},{378,368},{389,363}}},
}
for _,f in ipairs(litFr) do fracture2(f[2], crk2, nil, 1, {clip=visible(f[1]), pr=0.26}) end
local shFr = {
  {"C", {{720,210},{714,250},{726,300},{719,350}}, -1},
  {"C", {{740,340},{775,325},{800,333},{830,318}}, 1},
  {"C", {{760,240},{770,280},{766,300}}, -1},
  {"E", {{700,470},{730,462},{760,468},{790,460}}, 1},
}
for _,f in ipairs(shFr) do fracture2(f[2], sDeep, crkL, f[3], {clip=visible(f[1])}) end

--@ chunk 94
function teeth(a, b, s, p, seed, opts)
  opts = opts or {}
  local n = opts.n or 6
  local dmax = opts.depth or 3.5
  local wmax = opts.width or 9
  local dx, dy = b[1]-a[1], b[2]-a[2]; local L = math.sqrt(dx*dx+dy*dy)
  local ux, uy = dx/L, dy/L
  local nx, ny = uy*s, -ux*s
  local ts = uneven(n, 0.05, 0.95, 0.7, 0.5, seed)
  local m
  for i,t in ipairs(ts) do
    local w = rand(wmax*0.35, wmax)
    local d = rand(dmax*0.3, dmax)
    local c = L2(a,b,t)
    local p1 = {c[1] - ux*w/2 - nx*0.8, c[2] - uy*w/2 - ny*0.8}
    local p2 = {c[1] + ux*w/2 - nx*0.8, c[2] + uy*w/2 - ny*0.8}
    local off = rand(-0.35,0.35)*w
    local p3 = {c[1] + ux*off + nx*d, c[2] + uy*off + ny*d}
    local tri
    if rand(0,1) < 0.5 then tri = poly({p1, p3, p2})
    else
      local p4 = {c[1] + ux*(off + w*0.3) + nx*d*0.6, c[2] + uy*(off + w*0.3) + ny*d*0.6}
      tri = poly({p1, p3, p4, p2})
    end
    m = m and (m + tri) or tri
  end
  if opts.avoid then m = m - opts.avoid end
  work(m, {hand="detail", pile=p, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.5}, seed=seed})
  return m
end
local nA = infront("A")
teeth({578,395},{600,175}, 1, litWarm, 5001, {n=9, avoid=nA})
teeth({600,175},{630,90}, 1, litWarm, 5002, {n=4, avoid=nA})
-- C's top edges (shadow face against sky): outward = up-right
local nC = infront("C")
teeth({705,150},{748,212}, 1, sC1, 5003, {n=4, depth=3, avoid=nC})
teeth({775,215},{800,270}, 1, sC1, 5004, {n=3, depth=3, avoid=nC})
teeth({800,270},{860,395}, 1, sC1, 5005, {n=7, depth=3, avoid=nC})
teeth({660,190},{705,150}, 1, sC1, 5006, {n=3, depth=2.5, avoid=nC})
-- G right edge (Ge) against sky: outward right
local nGe = infront("Ge")
teeth({886,300},{955,505}, 1, sC1, 5007, {n=7, depth=3, avoid=nGe})
-- G's top-left edge (lit) outward up-left: direction (875,290)->(830,330) -> normal s?
teeth({875,290},{830,330}, 1, litWarm, 5008, {n=3, depth=2.5, avoid=infront("G")})
-- Be left edge against sky: outward = left; direction up (446,418)->(512,292): normal (dy,-dx)*s = (-126,-66)*s -> s=1 left-up
local nBe = infront("Be")
teeth({446,418},{512,292}, 1, litWarm, 5009, {n=6, depth=3, avoid=nBe + hullM})
teeth({512,292},{568,205}, 1, litWarm, 5010, {n=5, depth=3, avoid=nBe + hullM})

--@ chunk 95
local protect = poly(hull, true) + hullShadowQ + visible("S1") + visible("S1e") + visible("S2") + visible("S2e") + rubbleM + visible("R") + visible("Re")
local Qv = visible("Q") - protect
-- lit facet tilted to the light (upper-left of Q)
LQ1 = {{286,393},{330,346},{356,352},{340,398},{318,420},{296,446}}
local lq = poly(LQ1) * Qv
work(lq, {hand="detail", piles={{litWarm, function(x,y) return clamp(1-(y-346)/100,0,1)+0.2 end},{litCool, function(x,y) return clamp((y-360)/90,0,1) end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=-0.9, seed=5101})
-- second lit facet lower right (top of a plate)
LQ2 = {{392,442},{420,418},{466,412},{462,432},{430,446}}
local lq2 = poly(LQ2) * Qv
work(lq2, {hand="detail", piles={{litWarm,1},{litW,0.6}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=-0.2, seed=5102})
-- T: lit top-left face
LT = {{240,480},{255,440},{290,425},{298,433},{263,449},{249,478}}
work(poly(LT) - rubbleM, {hand="detail", piles={{litWarm,1},{litCool,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=-1.2, seed=5103})

--@ chunk 96
local protect = poly(hull, true) + hullShadowQ + visible("S1") + visible("S1e") + visible("S2") + visible("S2e") + rubbleM + visible("R") + visible("Re")
local Qv = visible("Q") - protect
local e1 = poly({{356,352},{364,356},{348,402},{326,427},{305,452},{296,446},{318,420},{340,398}}) * Qv
work(e1, {hand="detail", piles={{sC1,1},{sG,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=1.9, seed=5201})
local sh1 = poly({{364,356},{384,366},{372,410},{346,440},{318,470},{305,452},{326,427},{348,402}}) * Qv
work(sh1, {hand="detail", piles={{cs1,1},{mA,0.6}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=1.9, seed=5202})
local e2 = poly({{392,442},{430,446},{462,432},{461,439},{431,453},{394,449}}) * Qv
work(e2, {hand="detail", piles={{sC1,1},{sG,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.8}, angle=0, seed=5203})
-- shadow cast below LQ2 plate onto Q front
local sh2 = poly({{394,449},{431,453},{461,439},{458,458},{430,464},{398,460}}) * Qv
work(sh2, {hand="detail", piles={{cs1,1},{mA,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=0, seed=5204})
-- LT thickness: right of T's lit face is T's shadow face already; add dark crevice line between LT and T
cb = brush{kind="round", width=1.8, point=0.6}
cb:reload(sDeep, 0.5)
cb:stroke({{298,433},{263,449},{249,478}}, {pressure={0.4,0.3}, shake=0.3})

--@ chunk 97
local Hm = poly(face("H"))
local Hedge = {{612,430},{640,400},{660,415}}
-- shaded crevice strip on A just above H's top edge
local strip = ribbon({{606,431},{625,410},{641,393},{655,401},{664,410}}, 7) - Hm - poly(face("Ae")) 
strip = strip * (poly(face("A")) + poly(face("D2")))
work(strip, {hand="detail", piles={{mA,1},{cs1,0.6}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=-0.8, seed=5301})
-- lit top band inside H covering the dark arch line
local cap = ribbon({{614,431},{628,416},{640,404},{651,409},{659,416}}, 6) * Hm
work(cap, {hand="detail", piles={{litWarm,1},{litW,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=-0.8, seed=5302})

--@ chunk 98
local line = ribbon({{622,418},{631,408},{640,400.5},{648,405},{656,411},{662,416}}, 3.6)
work(line, {hand="detail", piles={{litCool,1},{mA,0.7}}, clip=true, coverage=4, fill=true, tool={kind="round", width=2}, angle=-0.8, seed=5303})

--@ chunk 99
palette{scrape={crkL, shTop}}
crevD = pile{{"lead white",0.35},{"cobalt blue",1},{"Prussian blue",0.15},{"raw umber",0.55},{"rose madder",0.05}, name="crevD"}
local cv = poly({{652,398},{705,404},{700,412},{676,409},{660,414},{652,408}}) - infront("Ae")
work(cv, {hand="detail", piles={{crevD,1},{sDeep,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=0.1, seed=5401})
local seam = poly({{656,112},{664,120},{684,205},{712,405},{705,405},{676,200}}) * visible("C")
print(seam:area())
work(seam, {hand="detail", piles={{sDeep,1},{crevD,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=1.45, seed=5402})

--@ chunk 100
local cv = poly({{652,398},{705,404},{700,412},{676,409},{660,414},{652,408}}) - infront("Ae")
for pass=1,3 do
  local rr = rag{width=8}
  rr:dip(1.0)
  rr:wipe(cv:grow(1), {pressure=0.95, angle=pass*0.8, passes=2, refold=0.2})
end

--@ chunk 101
local sh = poly({{652,399},{712,404},{718,416},{702,428},{676,433},{662,426},{660,415}}) - poly(face("H")) - (poly(face("Ae")):shrink(0.8))
work(sh, {hand="detail", piles={{cs1,1},{sC2,0.6},{cs0,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=0.15, seed=5501})

--@ chunk 102
print(wait(5*24*60))
for _,p in ipairs({{680,415},{630,415},{600,300},{720,250},{380,420},{420,450},{960,520},{750,300}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 103
print(wait(3*24*60))
for _,p in ipairs({{590,450},{600,500},{700,550},{800,560},{900,560},{640,574},{724,581},{680,415},{630,415},{420,450},{500,470},{620,440}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 104
palette{scrape={crk2}}
bounceW = pile{{"lead white",2.2},{"cobalt blue",0.55},{"smalt",0.35},{"Naples yellow",0.3},{"rose madder",0.07},{"raw umber",0.04}, name="bounceW"}
function segDist(x, y, p, q)
  local dx, dy = q[1]-p[1], q[2]-p[2]
  local t = clamp(((x-p[1])*dx + (y-p[2])*dy) / (dx*dx+dy*dy), 0, 1)
  local cx, cy = p[1]+t*dx, p[2]+t*dy
  return math.sqrt((x-cx)^2 + (y-cy)^2)
end
function nearEdge(p, q, r) return function(x,y) return clamp(1 - segDist(x,y,p,q)/r, 0, 1) end end
function restateBroad(m, piles, angle, tool, seed)
  work(m, {hand="broad", piles=piles, clip=true, coverage=2, fill=true, angle=angle, tool=tool, seed=seed})
  blend(m:shrink(1), {angle=angle, seed=seed+1})
end
shBAm = poly({{606,196},{622,206},{628,240},{620,300},{604,360},{588,432},{558,432},{598,292}}) * visible("A")
shRBm = poly({{478,330},{494,336},{508,372},{516,420},{505,444},{492,442}}) * visible("B")
-- A: lightest; warm top, slight cool turn toward its right edge
local Am = visible("A") - shBAm - rubbleM
restateBroad(Am, {{litWarm, function(x,y) return clamp(1-(y-90)/320,0,1)*0.8+0.3 end},{litW, function(x,y) return clamp((y-150)/250,0,1)*0.7+0.1 end},{litCool, nearEdge({644,98},{652,400}, 14)}}, -1.35, "filbert 12", 6001)

--@ chunk 105
local Bm = visible("B") - shRBm - rubbleM
restateBroad(Bm, {{litW, function(x,y) return clamp(1-(y-195)/235,0,1)*0.8+0.3 end},{litCool, function(x,y) return clamp((y-260)/170,0,1)*0.8+0.1 end},{mB, nearEdge({600,290},{560,430}, 12)}}, -1.05, "filbert 10", 6011)
-- G right pillar: lit, lightest but a hair cooler (farther)
local Gm = visible("G") - rubbleM
restateBroad(Gm, {{litWarm, function(x,y) return clamp(1-(y-290)/215,0,1)*0.8+0.2 end},{litCool, function(x,y) return clamp((y-330)/175,0,1)*0.7+0.15 end}}, -1.25, "filbert 10", 6021)
-- R, S1, S2: small lit shards, smoothed (remove fracture and ticks)
restateBroad(visible("R") - rubbleM, {{litWarm,1},{litCool, function(x,y) return clamp((y-330)/110,0,1)*0.8 end}}, -1.45, "filbert 5", 6031)
restateBroad(visible("S1") - rubbleM, {{litWarm,1},{litCool, function(x,y) return clamp((y-320)/80,0,1)*0.8 end}}, -1.35, "filbert 5", 6041)
restateBroad(visible("S2") - rubbleM, {{litWarm,1},{litCool,0.4}}, -0.6, "filbert 4", 6051)

--@ chunk 106
local D1m = visible("D1") - rubbleM
restateBroad(D1m, {{litCool, function(x,y) return clamp(1-(y-390)/130,0,1)*0.6+0.4 end},{mB, function(x,y) return clamp((y-400)/120,0,1)*0.7+0.35 end},{mA, nearEdge({548,522},{556,394}, 10)}}, -1.45, "filbert 8", 6101)
local Hm = visible("H") - rubbleM
restateBroad(Hm, {{litCool, function(x,y) return clamp(1-(y-400)/150,0,1)*0.6+0.45 end},{mB, function(x,y) return clamp((y-410)/140,0,1)*0.6+0.3 end},{mA, nearEdge({660,415},{655,548}, 8)}}, -1.52, "filbert 6", 6111)
local D2m = visible("D2") - rubbleM - poly(face("H"))
restateBroad(D2m, {{cs1, function(x,y) return clamp(1-(y-370)/150,0,1)*0.8+0.3 end},{sC2, function(x,y) return 0.25 end},{bounceW, function(x,y) return clamp((y-440)/80,0,1)*0.9 end}}, 1.4, "filbert 7", 6121)

--@ chunk 107
local lb = brush{kind="filbert", width=3}
lb:reload(litWarm, 0.6)
lb:stroke({{463,429},{490,407},{515,389.5},{536,391},{555,395}}, {pressure={0.6,0.5}, shake=0.3, clip=visible("D1")})
lb:reload(litWarm, 0.6)
lb:stroke({{613,429},{627,413},{640,401.5},{651,409},{659,415}}, {pressure={0.55,0.45}, shake=0.3, clip=visible("H")})
-- C: restate with warm bounce in the lower third, no fractures
local gn = noise{seed=17, period=80, stretch={1.0, 5}}
local seamC = poly({{656,112},{664,120},{684,205},{712,405},{705,405},{676,200}})
local Cm = visible("C") - rubbleM - seamC
local _,y0,_,y1 = bbox(face("C"))
restateBroad(Cm, {{sC1, function(x,y) return clamp(1-(y-y0)/(y1-y0),0,1)*0.9+0.15 end},{sC2, function(x,y) return clamp((y-y0)/(y1-y0),0,1)*0.6 end},{sG, function(x,y) return math.max(0, gn(x,y))*0.6 end},{bounceW, function(x,y) return clamp((y-340)/100,0,1)*0.8 end}}, 1.0, "filbert 12", 6201)
-- E: shadow front with warm bounce at its foot
local gn2 = noise{seed=29, period=50, stretch={0.1, 4}}
local Em = visible("E") - rubbleM
restateBroad(Em, {{cs1, function(x,y) return 0.6 end},{cs0, function(x,y) return clamp(1-(y-410)/100,0,1)*0.6 end},{sG, function(x,y) return math.max(0,gn2(x,y))*0.35 end},{bounceW, function(x,y) return clamp((y-470)/60,0,1)*0.9 end}}, 0.12, "filbert 10", 6211)
-- J: commit as a shadowed back slab, a step lighter than C
restateBroad(visible("J") - rubbleM, {{cs1,1},{sC2,0.5}}, 1.2, "filbert 5", 6221)

--@ chunk 108
palette{scrape={snowW, sDeep}}
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}, name="pl2"}
pl3 = pile{{"lead white",6},{"cobalt blue",0.55},{"Naples yellow",0.45},{"raw umber",0.08}, name="pl3"}
-- restate F (shadow block) smooth with warm foot
local Fm = visible("F") - rubbleM
restateBroad(Fm, {{cs1,1},{cs0,0.5},{bounceW, function(x,y) return clamp((y-500)/50,0,1)*0.9 end}}, 0.9, "filbert 8", 6301)
-- rebuild masks of the dice rubble
local function blockMask(x,y,w,h,seed)
  local f,t,r,s = blockShapes(x,y,w,h,seed)
  return poly(f) + poly(t) + poly(r) + poly(s)
end
diceM = nil
local function addM(m) diceM = diceM and (diceM + m) or m end
local k=0
for _,b in ipairs(baseLit) do k=k+1; addM(blockMask(b[1],b[2],b[3],b[4],3000+k*7)) end
k=0
for _,b in ipairs(baseSh) do k=k+1; addM(blockMask(b[1],b[2],b[3],b[4],3200+k*7)) end
addM(blockMask(985,566,22,12,3301))
local scat = {{640,574,12,8},{724,581,18,10},{775,577,10,6},{845,586,16,9},{915,582,10,6},{962,590,20,10},{498,560,10,6},{430,522,12,7},{300,520,10,6},{372,528,8,5},{205,505,10,6}}
k=0
for _,b in ipairs(scat) do k=k+1; addM(blockMask(b[1],b[2],b[3],b[4],3500+k*7)) end
print(diceM:area())

--@ chunk 109
keepM = poly({{330,500},{346,486},{392,481},{405,491},{381,504}}) + poly({{330,500},{381,504},{405,491},{406,497},{382,511},{331,506}}) + poly({{404,492},{424,494},{430,503},{404,510},{382,511}})
  + poly({{457,514},{461,494},{468,481},{476,513}}) + poly({{468,481},{474,485},{481,511},{476,513}})
  + poly({{561,549},{574,538},{604,540},{599,555}}) + poly({{561,549},{599,555},{604,540},{605,545},{600,560},{561,554}}) + poly({{605,545},{622,548},{626,556},{600,560}})
shadowZone = castM - castEdge:below(720)
local outM = diceM:grow(2) - iceAll - keepM - leadM - poly(face("FG")) - fshadow:below()
local outSh = outM * shadowZone
local outLit = outM - shadowZone
print(outSh:area(), outLit:area())
work(outLit, {hand="body", piles={{pl2,1},{pl3, function(x,y) return clamp((y-540)/60,0,1) end}}, clip=true, coverage=2.5, fill=true, angle=0.03, tool="filbert 4", seed=6401})
work(outSh, {hand="body", piles={{cs0,1},{cs1,0.6}}, clip=true, coverage=2.5, fill=true, angle=0.03, tool="filbert 4", seed=6402})

--@ chunk 110
shTop2 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.35},{"Naples yellow",0.15},{"rose madder",0.05},{"raw umber",0.04}, name="shTop2"}
function plateShapes(cx, cy, w, d, th, rot, tiltUp, seed)
  math.randomseed(seed)
  local ux, uy = math.cos(rot), math.sin(rot)
  local vx, vy = d*0.45, -d*(1 + tiltUp)
  local FL = {cx - ux*w/2, cy - uy*w/2}
  local FR = {cx + ux*w/2, cy + uy*w/2}
  local fm = rand(0.3,0.7)
  local FM = {lerp(FL[1],FR[1],fm), lerp(FL[2],FR[2],fm) + rand(-0.3,0.3)*th}
  local BL = {FL[1] + vx*rand(0.7,1.1), FL[2] + vy*rand(0.7,1.1)}
  local BR = {FR[1] + vx*rand(0.7,1.1), FR[2] + vy*rand(0.6,1.0)}
  local bm = rand(0.25,0.75)
  local BM = {lerp(BL[1],BR[1],bm) + rand(-0.1,0.1)*w, lerp(BL[2],BR[2],bm) + vy*rand(-0.35,0.3)}
  local top = {FL, BL, BM, BR, FR, FM}
  local front = {FL, FM, FR, {FR[1], FR[2]+th}, {FM[1], FM[2]+th*rand(0.8,1.1)}, {FL[1], FL[2]+th*rand(0.7,1.0)}}
  local rightF = {FR, BR, {BR[1], BR[2]+th*0.9}, {FR[1], FR[2]+th}}
  local sl = (d+th)*rand(0.8,1.4)
  local shadow = {{FR[1], FR[2]+th}, {BR[1], BR[2]+th*0.9}, {BR[1]+sl, BR[2]+th*0.9+1}, {FR[1]+sl*0.8, FR[2]+th+1.5}}
  return top, front, rightF, shadow
end
talusM = nil
function paintPlate(cx, cy, w, d, th, rot, tiltUp, seed, mode, avoid)
  local top, front, rightF, shadow = plateShapes(cx, cy, w, d, th, rot, tiltUp, seed)
  local tm, fm, rm = poly(top), poly(front), poly(rightF)
  fm = fm - tm; rm = rm - tm - fm
  if avoid then tm = tm - avoid; fm = fm - avoid; rm = rm - avoid end
  if not mode then
    if shadowZone:at(cx + d*0.3, cy - d) < 0.5 then mode = "lit"
    elseif shadowZone:at(cx, cy + th + 1) < 0.5 then mode = "edge"
    else mode = "shade" end
  end
  local tool = {kind="filbert", width=math.max(1.2, math.min(3.5, w*0.1))}
  local P
  if mode == "lit" then
    local sm = poly(shadow) - tm - fm - rm
    if avoid then sm = sm - avoid end
    work(sm, {hand="detail", pile=cs0, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed})
    P = {top={{litWarm,1},{litW,0.5}}, front={{mA,1},{mB,0.6}}, right={{sC1,1},{cs0,0.4}}}
  elseif mode == "edge" then
    P = {top={{litWarm,1},{litW,0.4}}, front={{cs0,1},{cs1,0.5}}, right={{shDeep,1},{cs0,0.4}}}
  else
    P = {top={{shTop2,1},{cs1,0.4}}, front={{cs0,1},{shDeep,0.4}}, right={{shDeep,1},{crevD,0.3}}}
  end
  work(tm, {hand="detail", piles=P.top, clip=true, coverage=3, fill=true, tool=tool, angle=rot, seed=seed+1})
  work(fm, {hand="detail", piles=P.front, clip=true, coverage=3, fill=true, tool=tool, angle=rot, seed=seed+2})
  work(rm, {hand="detail", piles=P.right, clip=true, coverage=3, fill=true, tool=tool, angle=-1.2, seed=seed+3})
  local all = tm + fm + rm
  talusM = talusM and (talusM + all) or all
  return mode
end
-- drifts first (in shadow, banked against E and F)
local drifts = {
  outline{{733,558},{741,546},{752,536},{765,531},{779,534},{790,545},{797,557}, char="soft", amount=0.4, seed=61},
  outline{{895,560},{901,549},{910,542},{920,541},{929,548},{934,560}, char="soft", amount=0.4, seed=62},
}
for i,dO in ipairs(drifts) do
  local m = dO:mask() - rubbleM
  local _,y0,_,y1 = bbox({{0,530},{0,560}})
  work(m, {hand="detail", piles={{shTop2, function(x,y) return clamp(1-(y-530)/25,0,1)+0.1 end},{cs1, function(x,y) return clamp((y-538)/20,0,1) end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=0, seed=6500+i})
  blend(m:shrink(1), {angle=0, seed=6510+i})
end
plates = {
  -- shadow side clump S1
  {680,540,46,12,6,0.05,1.6},{712,546,30,8,5,-0.1,0.5},{666,553,22,6,4,0.15,0.2},{700,560,14,4,3,-0.15,0.1},{728,558,10,3,2,0.2,0},{690,566,9,3,2,0.1,0},
  -- S2
  {822,545,50,14,7,-0.08,2.2},{858,550,36,9,5,0.1,0.6},{800,556,26,6,4,0.12,0.2},{884,556,22,6,4,-0.12,0.3},{840,563,14,4,3,0.05,0.1},{868,566,10,3,2,-0.2,0},{815,568,8,3,2,0.1,0},
  -- S3
  {955,548,30,8,5,-0.05,0.8},{985,552,26,7,4,0.1,0.4},{940,560,14,4,3,0.1,0.1},{975,563,10,3,2,-0.1,0},
  -- lit side L1
  {262,492,34,9,5,0.1,1.4},{296,498,26,7,4,-0.08,0.5},{245,502,18,5,3,0.15,0.2},{318,506,14,4,3,0.1,0.1},{278,510,10,3,2,-0.1,0},
  -- L2
  {437,486,20,6,4,-0.1,0.6},{447,499,10,3,2,0,0},
  -- L3
  {520,526,36,9,5,0.08,1.6},{552,534,22,6,4,-0.1,0.4},{498,532,16,4,3,0.15,0.2},{535,545,10,3,2,0,0},
  -- under H
  {628,556,22,6,4,0.05,0.4},{650,561,12,4,2.5,-0.1,0.1},
}
table.sort(plates, function(a,b) return a[2] < b[2] end)
local modes = {}
for i,p in ipairs(plates) do modes[#modes+1] = paintPlate(p[1],p[2],p[3],p[4],p[5],p[6],p[7], 7000+i*5, nil, leadM + keepM) end
print(table.concat(modes, ","))

--@ chunk 111
local R = rect(640,470,360,110)
local wipeM = (talusM * R):grow(1.2) - keepM - leadM
for pass=1,3 do
  local rr = rag{width=10}
  rr:dip(1.0)
  rr:wipe(wipeM, {pressure=0.9, angle=pass*0.7, passes=2, refold=0.25})
end
print(drying(830,530), drying(700,545))

--@ chunk 112
local R = rect(640,470,360,110)
local wipeM = (talusM * R):grow(1.2) - keepM - leadM
for pass=1,8 do
  local rr = rag{width=8}
  rr:dip(1.0)
  rr:wipe(wipeM, {pressure=0.95, angle=pass*0.45, passes=1, refold=0.3})
end

--@ chunk 113
local platesR = {
  {680,540,46,12,6,0.05,0.9,"shade"},{712,546,30,8,5,-0.1,0.4,"shade"},{666,553,22,6,4,0.15,0.2,"shade"},{700,560,14,4,3,-0.15,0.1,"shade"},{728,561,10,3,2,0.2,0,"edge"},{690,568,9,3,2,0.1,0,"edge"},
  {826,543,50,13,7,-0.08,1.0,"shade"},{860,550,36,9,5,0.1,0.5,"shade"},{800,555,26,6,4,0.12,0.2,"shade"},{884,556,22,6,4,-0.12,0.3,"shade"},{840,564,14,4,3,0.05,0.1,"edge"},{868,567,10,3,2,-0.2,0,"edge"},{815,569,8,3,2,0.1,0,"edge"},
  {955,548,30,8,5,-0.05,0.6,"shade"},{985,552,26,7,4,0.1,0.4,"shade"},{940,560,14,4,3,0.1,0.1,"shade"},{975,564,10,3,2,-0.1,0,"edge"},
}
table.sort(platesR, function(a,b) return a[2] < b[2] end)
for i,p in ipairs(platesR) do paintPlate(p[1],p[2],p[3],p[4],p[5],p[6],p[7], 7400+i*5, p[8], leadM + keepM) end

--@ chunk 114
local drifts = {
  outline{{733,558},{741,546},{752,536},{765,531},{779,534},{790,545},{797,557}, char="soft", amount=0.4, seed=61},
  outline{{895,560},{901,549},{910,542},{920,541},{929,548},{934,560}, char="soft", amount=0.4, seed=62},
}
local dm = (drifts[1]:mask() + drifts[2]:mask()):grow(1.5) - talusM
for pass=1,6 do
  local rr = rag{width=8}
  rr:dip(1.0)
  rr:wipe(dm, {pressure=0.95, angle=pass*0.5, passes=1, refold=0.3})
end
-- ghost of the house plate on E/F
ghostM = poly({{793,488},{858,488},{858,546},{793,546}}) - talusM - poly(face("G")) - poly(face("Ge"))
work(ghostM, {hand="detail", piles={{cs1,1},{cs0,0.6},{bounceW, function(x,y) return clamp((y-500)/40,0,1)*0.7 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=0.12, seed=7601})
blend(ghostM:shrink(1), {angle=0.12, seed=7602})

--@ chunk 115
local ramp = mask(function(x,y) return smoothstep(455, 485, y) end)
local region = ((visible("E") + visible("F") + ghostM) - talusM - rubbleM) * ramp
work(region, {hand="broad", piles={{cs1,1},{cs0,0.5},{bounceW, function(x,y) return clamp((y-505)/40,0,1)*0.8 end}}, clip=true, coverage=1.6, fill=true, angle=0.1, tool="filbert 8", seed=7701})
blend(region, {angle=0.1, seed=7702})
blend(region, {angle=-0.3, seed=7703})

--@ chunk 116
palette{scrape={pl2, pl3}}
woodD = pile{{"raw umber",2},{"bone black",1.2},{"red earth",0.12}, name="woodD"}
woodL = pile{{"raw umber",1},{"lead white",0.9},{"yellow ochre",0.35},{"red earth",0.08}, name="woodL"}
-- deepest dark: crushed seam under the keel where the bow presses into Q
crushM = poly({{316,333},{330,341},{346,351},{352,358},{340,362},{326,356},{314,346}}) - poly(hull, true) - visible("S1") - visible("S1e")
print(crushM:area())
work(crushM, {hand="detail", piles={{crevD,1},{woodD,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=0.5, seed=8001})

--@ chunk 117
local chips = {{322,356,10,4,2.5,0.4,0.6},{336,360,12,4,3,0.3,0.4},{348,362,7,3,2,0.5,0.2},{312,349,7,3,2,0.6,0.3},{330,364,6,2,1.5,0.2,0}}
for i,c in ipairs(chips) do paintPlate(c[1],c[2],c[3],c[4],c[5],c[6],c[7], 8100+i*5, "lit", poly(hull,true) + visible("S1")) end

--@ chunk 118
-- small leaning shard against the hull's bow, left edge of the crushed pocket
slabPiece({
  {{{312,358},{316,341},{324,333},{331,356}}, "lit", -1.2},
  {{{324,333},{329,336},{336,357},{331,356}}, "shade", -1.2},
}, 8201, poly(hull, true))
-- ice slab riding over the gunwale (lying across the rail), lit top with thickness
slabPiece({
  {{{372,302},{386,292},{414,301},{420,309},{400,313}}, "top", 0.4},
  {{{372,302},{400,313},{420,309},{421,314},{401,318},{372,306}}, "half", 0.4},
}, 8211, nil)
-- its shadow on the hull side just below
local shOnHull = poly({{374,307},{401,318},{421,314},{424,322},{402,327},{376,316}}) * poly(hull, true) - iceAll
work(shOnHull, {hand="detail", piles={{woodD,1},{crevD,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=0.4, seed=8221})
-- sprung planks near S1's tip
local pb = brush{kind="round", width=1.6, point=0.7}
pb:reload(woodD, 0.6)
pb:stroke({{362,327},{369,320},{373,311}}, {pressure={0.55,0.2}, shake=0.2})
pb:reload(woodL, 0.4)
pb:stroke({{361,326},{367,318.5},{371,310}}, {pressure={0.3,0.08}, shake=0.2})
pb:reload(woodD, 0.6)
pb:stroke({{392,345},{398,336},{399,326}}, {pressure={0.5,0.15}, shake=0.2})
pb:reload(woodD, 0.6)
pb:stroke({{355,333},{349,327},{347,320}}, {pressure={0.45,0.12}, shake=0.2})

--@ chunk 119
local pm = (poly({{372,302},{386,292},{414,301},{420,309},{400,313}}) + poly({{372,302},{400,313},{420,309},{421,314},{401,318},{372,306}})):grow(1.5) - poly(hull, true)
for pass=1,5 do
  local rr = rag{width=8}
  rr:dip(1.0)
  rr:wipe(pm, {pressure=0.95, angle=pass*0.6, passes=1, refold=0.3})
end

--@ chunk 120
behindRidge = {{336,288},{340,280},{346,275},{351,272},{357,279},{362,276},{368,268},{375,261},{381,266},{386,276},{391,283},{398,279},{404,284},{410,293},{416,297},{423,306},{429,318},{436,333},{420,326},{400,316},{380,306},{360,297},{340,289}}
local mastM = ribbon({{398,316},{422,263},{445,214}}, 8.5)
local ridgeM = poly(behindRidge) - poly(hull, true) - mastM
-- base: lit warm with cool lower band
work(ridgeM, {hand="detail", piles={{litWarm, function(x,y) return 1 end},{litCool, function(x,y) return clamp((y-290)/25,0,1) end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=0.4, seed=8301})
-- shadow facets on right-facing slopes
local shF = poly({{351,272},{357,279},{356,292},{350,290}}) + poly({{375,261},{381,266},{386,276},{391,283},{388,302},{380,304},{378,284}}) + poly({{398,279},{404,284},{410,293},{416,297},{414,318},{404,316}}) + poly({{423,306},{429,318},{436,333},{428,330}})
shF = shF * ridgeM
work(shF, {hand="detail", piles={{sC1,1},{cs1,0.6}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=1.2, seed=8302})

--@ chunk 121
local rg2 = brush{kind="rigger", width=1.0, point=1}
rg2:reload(woodD, 0.4)
rg2:stroke({{432,240},{412,268},{392,304}}, {pressure={0.22,0.18}, shake=0.4})
rg2:reload(woodD, 0.4)
rg2:stroke({{432,240},{420,272},{410,312}}, {pressure={0.22,0.18}, shake=0.4})
-- small snow lumps on the ridge tops near the rail, and a couple of lumps on the rail cap
local hb = brush{kind="round", width=2.2, point=0.7}
for _,p in ipairs({{345,289},{366,297},{386,306}}) do hb:reload(litWarm, 0.5); hb:touch(p[1], p[2], {pressure=0.45, drag={3,1.2}}) end

--@ chunk 122
palette{scrape={shTop2}}
skyM2 = pile{{"lead white",4.2},{"cobalt blue",1},{"Prussian blue",0.03},{"Naples yellow",0.1}, name="skyM2"}
local function bandPoly(a, b, nrm, t0, t1, inner0, inner1, outer, n)
  local pts = {}
  for i=0,n do local t = lerp(t0,t1,i/n); local c = {a[1]+(b[1]-a[1])*t, a[2]+(b[2]-a[2])*t}; local o = lerp(inner0, inner1, i/n); pts[#pts+1] = {c[1]+nrm[1]*o, c[2]+nrm[2]*o} end
  for i=n,0,-1 do local t = lerp(t0,t1,i/n); local c = {a[1]+(b[1]-a[1])*t, a[2]+(b[2]-a[2])*t}; pts[#pts+1] = {c[1]+nrm[1]*outer, c[2]+nrm[2]*outer} end
  return poly(pts)
end
local m1 = bandPoly({306,277}, {213,233}, {-0.428, 0.904}, 0.5, 1.04, 3.6, 0.6, 7, 12)
local tip = poly({{214,226},{209,229},{208,238},{214,240},{217,236},{215,233},{218,230}})
local m2 = bandPoly({398,316}, {445,214}, {0.908, 0.419}, 0.62, 1.03, 3.6, 1.2, 7, 10)
local mm = (m1 + tip + m2) - (iceAll + rubbleM)
work(mm, {hand="detail", pile=skyM2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-2.7, seed=8401})

--@ chunk 123
local function bandPoly(a, b, nrm, t0, t1, inner0, inner1, outer, n)
  local pts = {}
  for i=0,n do local t = lerp(t0,t1,i/n); local c = {a[1]+(b[1]-a[1])*t, a[2]+(b[2]-a[2])*t}; local o = lerp(inner0, inner1, i/n); pts[#pts+1] = {c[1]+nrm[1]*o, c[2]+nrm[2]*o} end
  for i=n,0,-1 do local t = lerp(t0,t1,i/n); local c = {a[1]+(b[1]-a[1])*t, a[2]+(b[2]-a[2])*t}; pts[#pts+1] = {c[1]+nrm[1]*outer, c[2]+nrm[2]*outer} end
  return poly(pts)
end
local m1 = bandPoly({306,277}, {213,233}, {-0.428, 0.904}, 0.5, 1.04, 3.6, 0.6, 7, 12)
local tip = poly({{214,226},{209,229},{208,238},{214,240},{217,236},{215,233},{218,230}})
local m2 = bandPoly({398,316}, {445,214}, {0.908, 0.419}, 0.62, 1.03, 3.6, 1.2, 7, 10)
spMask = ((m1 + tip + m2) - (iceAll + rubbleM)):grow(2)
for pass=1,4 do
  local rr = rag{width=6}
  rr:dip(1.0)
  rr:wipe(spMask, {pressure=0.95, angle=pass*0.8, passes=1, refold=0.3})
end

--@ chunk 124
palette{scrape={skyM2, bounceW}}
skyT1 = pile{{"lead white",3.4},{"cobalt blue",1},{"Prussian blue",0.032}, name="skyT1"}
skyT3 = pile{{"lead white",4.6},{"cobalt blue",1},{"Prussian blue",0.03},{"Naples yellow",0.12}, name="skyT3"}
local function bandPoly(a, b, nrm, t0, t1, inner0, inner1, outer, n)
  local pts = {}
  for i=0,n do local t = lerp(t0,t1,i/n); local c = {a[1]+(b[1]-a[1])*t, a[2]+(b[2]-a[2])*t}; local o = lerp(inner0, inner1, i/n); pts[#pts+1] = {c[1]+nrm[1]*o, c[2]+nrm[2]*o} end
  for i=n,0,-1 do local t = lerp(t0,t1,i/n); local c = {a[1]+(b[1]-a[1])*t, a[2]+(b[2]-a[2])*t}; pts[#pts+1] = {c[1]+nrm[1]*outer, c[2]+nrm[2]*outer} end
  return poly(pts)
end
local m1 = bandPoly({306,277}, {213,233}, {-0.428, 0.904}, 0.5, 1.04, 3.6, 0.6, 6, 12)
local tip = poly({{214,226},{209,229},{208,238},{214,240},{217,236},{215,233},{218,230}})
local m2 = bandPoly({398,316}, {445,214}, {0.908, 0.419}, 0.62, 1.03, 3.6, 1.2, 6, 10)
local mm = (m1 + tip + m2) - (iceAll + rubbleM)
local function wA(x,y) return clamp(1-(y-225)/40,0,1)+0.02 end
local function wB(x,y) return clamp((y-225)/40,0,1)+0.02 end
work(mm, {hand="detail", piles={{skyT1,wA},{skyT3,wB}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-2.7, seed=8501})

--@ chunk 125
palette{scrape={skyT1, skyT3, woodL, woodD}}
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}, name="pl2"}
pl3 = pile{{"lead white",6},{"cobalt blue",0.55},{"Naples yellow",0.45},{"raw umber",0.08}, name="pl3"}
fs1 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.45},{"rose madder",0.06},{"raw umber",0.06}, name="fs1"}
fg1 = pile{{"lead white",1.6},{"cobalt blue",0.6},{"smalt",0.4},{"raw umber",0.22},{"Naples yellow",0.12},{"rose madder",0.04}, name="fg1"}
shEdge = {{-5,571},{60,572.5},{118,574},{124,578},{205,580.5},{262,582},{268,587},{330,592},{410,595.5},{455,597},{461,601},{540,604},{600,606.5},{606,611},{660,615},{702,619},{760,624}}
local Lmask = above(shEdge) * below(function(x) return 540 end) - leadM - iceAll - rubbleM - talusM - poly(face("FG")) - keepM
local Smask = below(shEdge) * above(function(x) return 640 end) - leadM - iceAll - rubbleM - talusM - poly(face("FG"))
work(Lmask, {hand="broad", piles={{pl2,1},{pl3, function(x,y) return clamp((y-540)/60,0,1) end}}, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 10", seed=9001})
work(Smask, {hand="broad", piles={{fs1,1},{fg1, function(x,y) return clamp((y-590)/60,0,1) end}}, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 10", seed=9002})

--@ chunk 126
palette{scrape={sC2}}
fg2 = pile{{"lead white",1.2},{"cobalt blue",0.55},{"smalt",0.4},{"raw umber",0.3},{"red earth",0.05},{"Naples yellow",0.1}, name="fg2"}
local Smask = below(shEdge) - leadM - iceAll - rubbleM - talusM - poly(face("FG"))
local function wTop(x,y) return clamp(1-(y-585)/60,0,1)+0.05 end
local function wMid(x,y) return clamp(1-math.abs(y-650)/50,0,1)*0.9 end
local function wBot(x,y) return clamp((y-640)/60,0,1)*clamp(1-(x-200)/600,0.15,1) end
work(Smask, {hand="broad", piles={{fs1,wTop},{fg1,wMid},{fg2,wBot}}, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 12", seed=9101})
blend(Smask:shrink(1), {angle=0.02, seed=9102})

--@ chunk 127
print(wait(5*24*60))
for _,p in ipairs({{100,650},{300,640},{600,660},{650,690},{200,560},{700,545},{330,355},{380,300},{250,250}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 128
for i=1,#bankBot,6 do print(bankBot[i][1], bankBot[i][2], shadowZone:at(bankBot[i][1], bankBot[i][2]+3), below(shEdge):at(bankBot[i][1], bankBot[i][2]+3)) end

--@ chunk 129
palette{scrape={pl2, pl3}}
shTop2 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.35},{"Naples yellow",0.15},{"rose madder",0.05},{"raw umber",0.04}, name="shTop2"}
edgeG = pile{{"lead white",2},{"cobalt blue",0.6},{"green earth",0.45},{"Prussian blue",0.05},{"smalt",0.2}, name="edgeG"}
function piece(faces, seed, avoid)
  local P = {top={{litWarm,1},{litW,0.5}}, lit={{litW,1},{litCool,0.5}}, half={{mB,1},{mA,0.6}}, shade={{sC1,1},{cs0,0.5}}, deep={{shDeep,1},{sC1,0.3}},
             stop={{shTop2,1},{cs1,0.3}}, sfront={{cs0,1},{shDeep,0.4}}, refl={{edgeG,1},{sC1,0.5}}, green={{edgeG,1},{sG,0.6}}}
  local acc
  for i,f in ipairs(faces) do
    local m = poly(f[1])
    if acc then m = m - acc end
    if avoid then m = m - avoid end
    local x0,y0,x1,y1 = bbox(f[1])
    local tool = {kind="filbert", width=math.max(1.2, math.min(3.5, (x1-x0)*0.1))}
    work(m, {hand="detail", piles=P[f[2]], clip=true, coverage=3, fill=true, tool=tool, angle=f[3] or longest_angle(f[1]), seed=seed+i})
    acc = acc and (acc + poly(f[1])) or poly(f[1])
  end
  nearM = nearM and (nearM + acc) or acc
  return acc
end
-- near bank pieces in the shadow band (x<350), front-most listed first in each piece
piece({
  {{{62,676},{96,655},{150,652},{144,667},{104,683}}, "stop", -0.3},
  {{{62,676},{104,683},{144,667},{146,674},{106,691},{63,684}}, "sfront", -0.2},
  {{{63,684},{106,691},{146,674},{144,684},{106,699},{64,692}}, "refl", -0.2},
}, 9201)
piece({
  {{{196,640},{204,612},{214,600},{222,636}}, "lit", -1.3},
  {{{214,600},{219,604},{228,634},{222,636}}, "deep", -1.3},
  {{{196,640},{222,636},{228,634},{226,645},{198,648}}, "refl", 0},
}, 9211)
piece({
  {{{150,656},{170,644},{196,646},{188,656},{160,662}}, "stop", -0.3},
  {{{150,656},{160,662},{188,656},{189,660},{161,667},{151,661}}, "sfront", -0.2},
}, 9221)
piece({
  {{{262,617},{280,605},{306,604},{300,614},{272,621}}, "stop", -0.3},
  {{{262,617},{272,621},{300,614},{301,618},{273,625},{263,621}}, "sfront", -0.2},
}, 9231)

--@ chunk 130
palette{scrape={shTop2}}
reflW = pile{{"bone black",0.6},{"Prussian blue",0.25},{"raw umber",0.25},{"lead white",1.4},{"green earth",0.4},{"cobalt blue",0.3}, name="reflW"}
local top, mid, bot = {}, {}, {}
for j=2,#bankTop do
  local x = bankTop[j][1]; local h = lerp(6, 2.2, x/480)
  top[#top+1] = {x, bankTop[j][2]}
  mid[#mid+1] = {x, bankTop[j][2] + h*0.5}
  bot[#bot+1] = {x, bankTop[j][2] + h}
end
local wall = nil
for j=1,#mid-1 do
  local h = lerp(6, 2.2, mid[j][1]/480)
  local seg = ribbon({mid[j], mid[j+1]}, h)
  wall = wall and (wall + seg) or seg
end
wall = wall * leadM
wallM = wall
work(wall, {hand="detail", piles={{mA, function(x,y) return 1 end},{edgeG, function(x,y) return 0.7 end},{sC1, function(x,y) return 0.3 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=-0.15, seed=9301})
blend(wall, {angle=-0.15, seed=9302})

--@ chunk 131
local rgL = brush{kind="round", width=1.3, point=0.8}
-- lit lip: broken runs along top
local j = 2
while j < #bankTop - 2 do
  local n = math.random(3, 7)
  local seg = {}
  for k = j, math.min(j+n, #bankTop) do seg[#seg+1] = {bankTop[k][1], bankTop[k][2] + 0.4} end
  if #seg >= 2 and rand(0,1) < 0.75 then
    rgL:reload(litWarm, rand(0.45,0.6))
    rgL:stroke(seg, {pressure={rand(0.35,0.55), rand(0.2,0.4)}, shake=0.3})
  end
  j = j + n + math.random(0, 2)
end
-- dark waterline at wall foot
local rgD = brush{kind="rigger", width=1.0, point=1}
j = 2
while j < #bankTop - 2 do
  local n = math.random(4, 8)
  local seg = {}
  for k = j, math.min(j+n, #bankTop) do local x = bankTop[k][1]; local h = lerp(6,2.2,x/480); seg[#seg+1] = {x, bankTop[k][2] + h + 0.2} end
  if #seg >= 2 then
    rgD:reload(crevD, rand(0.35,0.5))
    rgD:stroke(seg, {pressure={rand(0.25,0.4), rand(0.15,0.3)}, shake=0.2, clip=leadM})
  end
  j = j + n + math.random(0, 3)
end
-- strata lines on the wall
j = 3
while j < #bankTop - 3 do
  local n = math.random(3, 6)
  local seg = {}
  local f = rand(0.35, 0.7)
  for k = j, math.min(j+n, #bankTop) do local x = bankTop[k][1]; local h = lerp(6,2.2,x/480); seg[#seg+1] = {x, bankTop[k][2] + h*f} end
  if #seg >= 2 and bankTop[j][1] < 380 and rand(0,1) < 0.6 then
    rgD:reload(sC1, rand(0.3,0.45))
    rgD:stroke(seg, {pressure={0.18, 0.1}, shake=0.2, clip=wallM})
  end
  j = j + n + math.random(1, 4)
end

--@ chunk 132
-- FG slab's left thickness edge faces the sun: lit
local FGeM = poly({{699,714},{744,631},{757,640},{717,714}})
work(FGeM, {hand="detail", piles={{litW, function(x,y) return clamp(1-(y-630)/90,0,1)+0.2 end},{litCool, function(x,y) return clamp((y-640)/70,0,1)*0.8 end},{mB, function(x,y) return clamp((y-670)/40,0,1)*0.6 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=-1.1, seed=9401})
-- lit lip along the top edge, in broken runs
local a, b = {748,630}, {1000,575}
local ts = uneven(9, 0.0, 1.0, 0.6, 0.5, 9402)
local lip = brush{kind="filbert", width=2.6}
for i=1,#ts-1 do
  if rand(0,1) < 0.8 then
    local t0, t1 = ts[i] + 0.008, ts[i+1] - 0.008
    local p0, p1 = L2(a,b,t0), L2(a,b,t1)
    lip:reload(litWarm, rand(0.5,0.7))
    lip:stroke({{p0[1], p0[2]+1.0}, {p1[1], p1[2]+1.0}}, {pressure={rand(0.5,0.7), rand(0.4,0.6)}, shake=0.4})
  end
end
-- strata on the lit thickness edge
local rgD = brush{kind="rigger", width=1.0, point=1}
for _,f in ipairs({0.3, 0.55, 0.8}) do
  local p = L2({744,631},{757,640}, f); local q = L2({699,714},{717,714}, f)
  rgD:reload(sC1, 0.35)
  rgD:stroke({L2(p,q,0.05), L2(p,q,0.5), L2(p,q,rand(0.7,0.95))}, {pressure={0.18,0.08}, shake=0.3, clip=FGeM})
end

--@ chunk 133
local a, b = {748,630}, {1000,575}
local lipM = ribbon({{746,631},{1001,574}}, 6)
local FGeM = poly({{699,714},{744,631},{757,640},{717,714}}):grow(1.5)
local m = lipM + FGeM
for pass=1,6 do
  local rr = rag{width=8}
  rr:dip(1.0)
  rr:wipe(m, {pressure=0.95, angle=pass*0.5, passes=1, refold=0.3})
end

--@ chunk 134
print(palette())

--@ chunk 135
palette{scrape={fg2, reflW, fs1, fg1}}
pl1 = pile{{"lead white",6},{"cobalt blue",0.9},{"rose madder",0.1},{"Naples yellow",0.15},{"raw umber",0.08}, name="pl1"}
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}, name="pl2"}
-- low snow swell in front of the far-left ridge: irregular crest covering its ruled base
swellCrest = {{25,492},{45,482},{62,478},{80,481},{96,477},{118,479},{140,476},{160,480},{182,477},{205,481},{222,479},{238,486},{252,494}}
local sw = below(swellCrest) * above(function(x) return 500 end) * rect(0,440,255,80) - iceAll - rubbleM - talusM
work(sw, {hand="detail", piles={{pl2,1},{pl1, function(x,y) return clamp(1-(y-476)/14,0,1)*0.5 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=0.0, seed=9501})
-- lit crest line, broken
local cr = brush{kind="round", width=1.6, point=0.6}
local i = 1
while i < #swellCrest do
  local n = math.random(1,3)
  local seg = {}
  for k=i, math.min(i+n, #swellCrest) do seg[#seg+1] = {swellCrest[k][1], swellCrest[k][2]+0.6} end
  if #seg >= 2 and rand(0,1) < 0.7 then cr:reload(litWarm, 0.45); cr:stroke(seg, {pressure={0.35,0.2}, shake=0.4}) end
  i = i + n
end
-- soften the old seam across the plain at y~484 (x 225..330)
local seamM = rect(222, 478, 30, 14) - iceAll - rubbleM - talusM
work(seamM, {hand="detail", pile=pl2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3}, angle=0, seed=9502})

--@ chunk 136
shTop2 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.35},{"Naples yellow",0.15},{"rose madder",0.05},{"raw umber",0.04}, name="shTop2"}
local function floe(cx, cy, w, d, seed, lit)
  math.randomseed(seed)
  local pts = {}
  local n = 6
  for i=1,n do
    local a = (i-1)/n*2*math.pi + rand(-0.3,0.3)
    pts[i] = {cx + math.cos(a)*w/2*rand(0.7,1.05), cy + math.sin(a)*d/2*rand(0.7,1.05)}
  end
  local top = poly(pts)
  local th = math.max(1.2, d*0.25)
  local sidePts = {}
  for i,p in ipairs(pts) do sidePts[i] = {p[1], p[2] + th} end
  local side = (poly(sidePts) - top)
  local refl = {}
  for i,p in ipairs(pts) do refl[i] = {p[1], p[2] + th + d*0.5} end
  local rm = (poly(refl) - top - side) * leadM
  local tool = {kind="filbert", width=math.max(1.2, math.min(3, w*0.12))}
  work(rm, {hand="detail", piles={{mA,1},{edgeG,0.6}}, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed+1})
  work(side * leadM, {hand="detail", piles={{edgeG,1},{sC1,0.5}}, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed+2})
  work(top * leadM, {hand="detail", piles=(lit and {{litWarm,1},{litW,0.5}} or {{shTop2,1},{mB,0.5}}), clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed+3})
  floatM = floatM and (floatM + top + side) or (top + side)
end
local fl = {
  {452,532,10,3,9601,true},{438,543,7,2.5,9602,true},{416,553,14,4,9603,true},{396,566,9,3,9604,true},{380,561,5,2,9605,true},
  {352,580,18,5,9606,false},{326,590,8,3,9607,false},{298,602,12,4,9608,false},{250,622,22,6,9609,false},
}
for _,f in ipairs(fl) do floe(f[1],f[2],f[3],f[4],f[5],f[6]) end

--@ chunk 137
farEdge2 = {{944,507},{949,500},{953,501},{958,494},{962,490},{965,492},{969,499},{976,500},{981,496},{986,486},{990,481},{993,482},{997,489},{1003,492}}
local region = poly({{944,466},{1006,466},{1006,512},{944,512}}) - iceAll - rubbleM - talusM
local abv = region * above(farEdge2)
local blw = region * below(farEdge2)
work(abv, {hand="detail", piles={{pl1,1},{litCool,0.3}}, clip=true, coverage=3, fill=true, angle=0, tool={kind="filbert", width=2.5}, seed=9701})
work(blw, {hand="detail", piles={{cs1,1},{cs0,0.4}}, clip=true, coverage=3, fill=true, angle=0, tool={kind="filbert", width=2.5}, seed=9702})
-- lit tops of the hummocks (sun from left catches their left slopes)
local lt = poly({{958,494},{962,490},{965,492},{963,496}}) + poly({{986,486},{990,481},{993,482},{990,487}})
work(lt, {hand="detail", pile=litW, clip=true, coverage=3, fill=true, angle=-0.8, tool={kind="filbert", width=1.5}, seed=9703})

--@ chunk 138
print(palette())

--@ chunk 139
slabTop = mix{{cs1,0.5},{mB,0.5}, name="slabTop"}
local a, b = {748,630}, {1000,575}
-- direction a->b = (252,-55); normal (dy,-dx)*s = (-55,-252)*s -> s=+1 points up (into the plain)
local up = teeth(a, b, 1, slabTop, 9801, {n=10, depth=3, width=10})
local dn = teeth(a, b, -1, pl2, 9802, {n=7, depth=2.5, width=9, avoid=up})
FGteeth = up + dn

--@ chunk 140
palette{scrape={slabTop, pl1}}
turq = pile{{"Prussian blue",0.25},{"cobalt blue",0.6},{"green earth",0.6}, medium=0.75, name="turq"}
clr = pile{{"lead white",0.2},{"cobalt blue",0.05}, medium=0.95, name="clr"}
local AeV = visible("Ae")
local function wt(x,y) return clamp(1-(y-100)/230,0,1)^1.3 end
local function wc(x,y) return 1 - wt(x,y) + 0.02 end
work(AeV, {hand="glaze", piles={{turq,wt},{clr,wc}}, coverage=1, clip=true, angle=1.45, seed=9901})
blend(AeV:shrink(0.8), {angle=1.45, seed=9902})

--@ chunk 141
for _,p in ipairs{{720,660},{230,620},{205,630},{100,670},{300,605},{826,550},{700,545},{760,690},{480,540},{560,520}} do print(p[1],p[2],drying(p[1],p[2])) end
print(table.concat(tubes(), ", "))
for _,l in ipairs(palette()) do print(l) end

--@ chunk 142
local pts = {{100,600},{300,605},{300,640},{300,700},{500,620},{500,700},{650,650},{650,705},{780,640},{850,620},{850,690},{950,600},{950,700},{600,580},{800,590},{900,530},{720,480},{760,500},{120,560},{40,640}}
for _,p in ipairs(pts) do print(p[1],p[2],drying(p[1],p[2])) end
print(palette())

--@ chunk 143
print(wait(6*24*60))
for _,p in ipairs{{205,630},{100,670},{300,605},{700,545},{760,600},{850,590},{452,532},{250,622},{960,495}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 144
print(iceAll:at(850,650), iceAll:at(720,690), iceAll:at(300,680), nearM:at(100,670), leadM:at(100,640), rubbleM:area(), talusM:area())
local fg = poly(face("FG"))
print(fg:at(720,700), fg:at(705,705))
local x0,y0,x1,y1 = bbox(nearM)
print(x0,y0,x1,y1)

--@ chunk 145
palette{scrape={turq, clr, shTop2, sG}}
fgT2 = pile{{"lead white",1.0},{"cobalt blue",0.55},{"smalt",0.35},{"raw umber",0.24},{"Naples yellow",0.14},{"rose madder",0.05}, name="fgT2"}
fgB2 = pile{{"lead white",0.65},{"cobalt blue",0.42},{"smalt",0.3},{"raw umber",0.42},{"green earth",0.25},{"Naples yellow",0.14},{"red earth",0.04}, name="fgB2"}
function edgeY(x)
  for i=1,#shEdge-1 do
    local a, b = shEdge[i], shEdge[i+1]
    if x >= a[1] and x <= b[1] then return lerp(a[2], b[2], (x-a[1])/(b[1]-a[1])) end
  end
  return shEdge[#shEdge][2]
end
bandM2 = below(shEdge) - leadM - iceAll - rubbleM - talusM - nearM - floatM
print(bandM2:area())
local function tdown(x,y) local e = edgeY(x); return clamp((y-e)/(714-e),0,1) end
local function wT(x,y) return clamp(1 - tdown(x,y)*1.4,0,1) + 0.04 end
local function wB(x,y) local t = tdown(x,y); return clamp(t*1.3 - 0.15,0,1) * clamp(1.15 - x/900, 0.35, 1) end
local function wM(x,y) local t = tdown(x,y); return clamp(1 - math.abs(t-0.55)*2.2,0,1)*0.6 end
work(bandM2, {hand="broad", piles={{fgT2,wT},{fgB2,wB},{fs1 and fs1 or fgT2, function() return 0 end}}, clip=true, coverage=2.5, fill=true, angle=0.02, tool="filbert 12", seed=10101})
blend(bandM2:shrink(1), {angle=0.02, seed=10102})

--@ chunk 146
print(palette())

--@ chunk 147
palette{scrape={fs1, edgeG}}
slabG3 = pile{{"lead white",0.6},{"cobalt blue",0.35},{"smalt",0.1},{"green earth",0.6},{"raw umber",0.35},{"yellow ochre",0.08},{"Prussian blue",0.02}, name="slabG3"}
wedgeL2 = pile{{"lead white",3},{"cobalt blue",0.35},{"smalt",0.1},{"Naples yellow",0.3},{"raw umber",0.1}, name="wedgeL2"}
farE = {{744,629},{758,627.5},{771,622},{786,621},{797,617},{812,616.5},{826,611},{838,610},{849,607},{853,609.5},{858,605},{866,603},{880,601},{893,596},{905,595.5},{921,592},{930,589},{934,584.5},{938,588},{950,586.5},{962,582},{977,580},{990,576},{1003,574}}
wedgeOut = {{744,629},{738,641},{735,643},{729,655},{724,664},{721,665},{715,678},{710,688},{707,690},{703,700},{699,716}}
arris = {{748,632},{744,645},{740,658},{736,671},{733,680},{729,692},{726,703},{723,716}}
local pts = {}
for _,p in ipairs(farE) do pts[#pts+1] = p end
pts[#pts+1] = {1003,716}
for i=#arris,1,-1 do pts[#pts+1] = arris[i] end
slabTopM = poly(pts)
local wp = {}
for _,p in ipairs(wedgeOut) do wp[#wp+1] = p end
for i=#arris,1,-1 do wp[#wp+1] = arris[i] end
wedgeM = poly(wp)
-- 1. lit plain strip above the new far edge (covers the old teeth)
local up = {}
for _,p in ipairs(farE) do up[#up+1] = {p[1], p[2]-0.2} end
local stripM = below(function(x) return 630 - 0.218*(x-745) - 9 end) * above(up) * rect(736,560,270,80) - talusM - rubbleM
work(stripM, {hand="detail", pile=pl2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=-0.21, seed=10201})
-- 2. notches left of the wedge: band colour
local notchM = (poly(face("FG")):grow(1.5) - slabTopM - wedgeM) * below(function(x) return 625 end) * rect(690,600,80,120)
local function tdown(x,y) local e = edgeY(x); return clamp((y-e)/(714-e),0,1) end
work(notchM, {hand="detail", piles={{fgT2, function(x,y) return clamp(1-tdown(x,y)*1.4,0,1)+0.04 end},{fgB2, function(x,y) return clamp(tdown(x,y)*1.3-0.15,0,1)*0.4 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=-1.1, seed=10202})
print(stripM:area(), notchM:area(), slabTopM:area(), wedgeM:area())

--@ chunk 148
slabL = mix{{slabG3,0.5},{fgT2,0.5}, name="slabL"}
local function farT(x,y) local e = 630 - 0.218*(x-745); return clamp((y-e)/(716-e),0,1) end
local gn = noise{seed=303, period=60, stretch={-0.25, 4}}
restateBroad(slabTopM, {{slabL, function(x,y) return clamp(1-farT(x,y)*2.2,0,1)+0.08 end},{slabG3, function(x,y) return clamp(farT(x,y)*1.6,0,1)*0.9 + math.max(0,gn(x,y))*0.3 end},{fgB2, function(x,y) return clamp((farT(x,y)-0.5)*1.6,0,1)*0.5 end}}, -0.24, "filbert 10", 10301)
-- wedge: lit at the top (sun at the shadow's edge), dimming into half-tone lower down
work(wedgeM, {hand="detail", piles={{wedgeL2, function(x,y) return clamp(1-(y-630)/70,0,1)+0.15 end},{mB, function(x,y) return clamp((y-650)/50,0,1)*0.8 end},{mA, function(x,y) return clamp((y-680)/35,0,1)*0.6 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=-1.25, seed=10302})

--@ chunk 149
local function interpX(line, y)
  for i=1,#line-1 do
    local a, b = line[i], line[i+1]
    if y >= a[2] and y <= b[2] then return lerp(a[1], b[1], (y-a[2])/(b[2]-a[2])) end
  end
  return line[#line][1]
end
function wedgeQuad(yo0, ya0, ya1, yo1)
  return {{interpX(wedgeOut, yo0)-1.5, yo0}, {interpX(arris, ya0)+0.5, ya0}, {interpX(arris, ya1)+0.5, ya1}, {interpX(wedgeOut, yo1)-1.5, yo1}}
end
local seg2 = poly(wedgeQuad(654, 648, 671, 676)) * wedgeM
local seg4 = poly(wedgeQuad(694, 688, 717, 717)) * wedgeM
local seg3lo = poly({{interpX(wedgeOut,684)-1, 684},{interpX(arris,680)-3, 680},{interpX(arris,688)+0.5, 688},{interpX(wedgeOut,694)-1.5, 694}}) * wedgeM
work(seg2, {hand="detail", piles={{mA,1},{cs1,0.7},{mB,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=-1.25, seed=10401})
work(seg4, {hand="detail", piles={{cs1,1},{mA,0.6},{cs0,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=-1.25, seed=10402})
work(seg3lo, {hand="detail", piles={{mA,1},{cs1,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-1.25, seed=10403})
-- bites out of the wedge's outer edge (band colour)
local bites = {
  {{735,643},{741,646},{739,651},{733,651}},
  {{720,666},{728,669},{727,676},{722,679},{716,676}},
  {{706,692},{713,694},{716,700},{710,705},{704,702}},
}
local bm
for _,b in ipairs(bites) do bm = bm and (bm + poly(b)) or poly(b) end
bm = bm * (wedgeM:grow(1))
work(bm, {hand="detail", piles={{fgT2,1},{fgB2,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=0, seed=10404})

--@ chunk 150
local out = {}
for _,p in ipairs(wedgeOut) do out[#out+1] = {p[1]-3.5, p[2]} end
local stripL = ribbon(out, 9) * rect(680,615,80,105) - wedgeM - slabTopM
local function tdown(x,y) local e = edgeY(x); return clamp((y-e)/(714-e),0,1) end
work(stripL, {hand="detail", piles={{fgT2, function(x,y) return clamp(1-tdown(x,y)*1.4,0,1)+0.04 end},{fgB2, function(x,y) return clamp(tdown(x,y)*1.3-0.15,0,1)*0.75 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=-1.1, seed=10501})
print(stripL:area())

--@ chunk 151
print(wait(2*24*60))
for _,p in ipairs{{850,650},{900,690},{730,660},{720,700},{300,650},{100,700},{760,620},{900,595}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 152
-- E: the right-hand eave strip goes into shadow, so E's top is one long slant lost against C
local eR = poly({{756,414},{834,450},{830,466},{756,429}}) - infront("Ee")
work(eR, {hand="detail", piles={{cs1,1},{cs0,0.55}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=0.45, seed=10601})
-- H: knock the right shoulder off the point
local Hcut = poly({{641,399},{663,412},{663,428},{653,425},{647,420},{645,410}}) - infront("H")
work(Hcut, {hand="detail", piles={{cs1,1},{cs0,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=0.3, seed=10602})
-- broken face of the break (faces right: shadow) and the deeper accent where it meets the back
local brk = poly({{639.5,400.5},{643.5,401},{647.5,417.5},{645.5,419}})
work(brk, {hand="detail", piles={{sC1,1},{mA,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.4}, angle=1.3, seed=10603})
local acc = poly({{647,420},{653,424.5},{662,427},{662,429.5},{652,427.5},{646,422}})
work(acc, {hand="detail", piles={{shDeep,1},{crevD,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.3}, angle=0.25, seed=10604})
-- D1: lean its right vertical: D2's shadow takes a wedge off D1's top-right corner
local wedge = poly({{537,397},{558,392},{554,523},{550,523}}) * (visible("D1") + visible("D2"))
work(wedge, {hand="detail", piles={{cs1,1},{mB, function(x,y) return clamp((y-460)/60,0,1)*0.3 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=1.48, seed=10605})
-- a soft rolling half-tone just inside D1's new edge
local roll = poly({{531,400},{537,397},{550,523},{544,523}}) * visible("D1") - wedge
work(roll, {hand="detail", piles={{mB,1},{mA,0.5}}, clip=true, coverage=2, fill=true, tool={kind="filbert", width=2}, angle=1.48, seed=10606})
blend(roll:grow(1.5) - wedge, {angle=1.48, seed=10607})

--@ chunk 153
palette{scrape={slabL, wedgeL2, slabG3}}
skyT1 = pile{{"lead white",3.4},{"cobalt blue",1},{"Prussian blue",0.032}, name="skyT1"}
skyT3 = pile{{"lead white",4.6},{"cobalt blue",1},{"Prussian blue",0.03},{"Naples yellow",0.12}, name="skyT3"}
woodD = pile{{"raw umber",2},{"bone black",1.2},{"red earth",0.12}, name="woodD"}
-- 1. paint out the bowed rope right of the masthead and the bowed stay from the bowsprit tip
local r1 = ribbon({{445,229},{452,238},{458,256},{460,272},{461,276}}, 4.2)
local r2 = ribbon({{216,243},{216,248},{220,262},{226,274},{231,282},{233,285}}, 4.2)
local mm = (r1 + r2) - hullM:shrink(0.5) - iceAll
local function wA(x,y) return clamp(1-(y-225)/40,0,1)+0.02 end
local function wB(x,y) return clamp((y-225)/40,0,1)+0.02 end
work(mm, {hand="detail", piles={{skyT1,wA},{skyT3,wB}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=1.3, seed=10701})
print(mm:area())

--@ chunk 154
-- a loose rope end hanging plumb from the masthead
local rgp = brush{kind="rigger", width=1.0, point=1}
rgp:reload(woodD, 0.35)
rgp:stroke({{443.5,221},{444.2,232},{444.6,246},{444.8,258},{445.2,266}}, {pressure={0.2,0.06}, shake=0.15})
-- grey the light 'bandage' strip at the mast foot and break it into lumps
local mastR = ribbon({{398,316},{422,263},{445,214}}, 9)
local strip = poly({{366,297},{378,299},{404,310},{407,318},{398,321},{369,307}}) - mastR
work(strip, {hand="detail", piles={{mA,1},{mB,0.7},{cs1,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=0.45, seed=10801})
local hb = brush{kind="round", width=2.0, point=0.7}
for _,p in ipairs({{371,300.5,2.5},{383,305.5,1.8},{391,309,2.6}}) do
  hb:reload(litWarm, 0.45); hb:touch(p[1], p[2], {pressure=0.4, drag={p[3],1.0}})
end
print(strip:area())

--@ chunk 155
palette{scrape={skyT1, skyT3}}
woodL = pile{{"raw umber",1},{"lead white",0.9},{"yellow ochre",0.35},{"red earth",0.08}, name="woodL"}
local function gy(x) return 296 + (x-360)*0.475 end
local mastR = ribbon({{398,316},{422,263},{445,214}}, 9)
local strip = poly({{366,297},{378,299},{404,310},{407,318},{398,321},{369,307}}) - mastR
local hullPart = strip * below(function(x) return gy(x) + 0.8 end)
work(hullPart, {hand="detail", piles={{woodD,1},{woodL,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.4}, angle=0.45, seed=10901})
local icePart = strip - hullPart
work(icePart, {hand="detail", piles={{litCool,1},{mB,0.6}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.4}, angle=0.45, seed=10902})
local rb2 = brush{kind="round", width=1.3, point=0.8}
rb2:reload(woodL, 0.45)
rb2:stroke({{366,299.3},{378,305},{388,309.8}}, {pressure={0.35,0.25}, shake=0.2})
rb2:reload(woodL, 0.4)
rb2:stroke({{391,311},{398,314.4}}, {pressure={0.3,0.2}, shake=0.2})
local rgs = brush{kind="rigger", width=1.0, point=1}
rgs:reload(woodD, 0.4)
rgs:stroke({{368,304.5},{384,312},{399,319}}, {pressure={0.2,0.15}, shake=0.2})
local hb = brush{kind="round", width=2.0, point=0.7}
for _,p in ipairs({{370,298.6,2.2},{385.5,305.6,1.6},{394,310,2.4}}) do
  hb:reload(litWarm, 0.45); hb:touch(p[1], p[2], {pressure=0.4, drag={p[3],1.0}})
end

--@ chunk 156
local hm = poly(hull, true)
for _,x in ipairs{350,360,370,380,390,400,410} do
  local top
  for y=260,340,0.5 do if hm:at(x,y) > 0.5 then top = y break end end
  print(x, top)
end

--@ chunk 157
for _,x in ipairs{350,372,385} do
  local s = {}
  for y=280,326,2 do local c = probe and nil; s[#s+1] = string.format("%d", y) end
end
print("ok")

--@ chunk 158
for i,b in ipairs(baseSh) do print(i, b[1], b[2], b[3], b[4]) end

--@ chunk 159
local top, front, rightF, shadow = plateShapes(826,543,50,13,7,-0.08,1.0, 7400 + 0)
-- we don't know the seed index after sort; print shapes for each plausible index
local platesR = {
  {680,540,46,12,6,0.05,0.9,"shade"},{712,546,30,8,5,-0.1,0.4,"shade"},{666,553,22,6,4,0.15,0.2,"shade"},{700,560,14,4,3,-0.15,0.1,"shade"},{728,561,10,3,2,0.2,0,"edge"},{690,568,9,3,2,0.1,0,"edge"},
  {826,543,50,13,7,-0.08,1.0,"shade"},{860,550,36,9,5,0.1,0.5,"shade"},{800,555,26,6,4,0.12,0.2,"shade"},{884,556,22,6,4,-0.12,0.3,"shade"},{840,564,14,4,3,0.05,0.1,"edge"},{868,567,10,3,2,-0.2,0,"edge"},{815,569,8,3,2,0.1,0,"edge"},
  {955,548,30,8,5,-0.05,0.6,"shade"},{985,552,26,7,4,0.1,0.4,"shade"},{940,560,14,4,3,0.1,0.1,"shade"},{975,564,10,3,2,-0.1,0,"edge"},
}
table.sort(platesR, function(a,b) return a[2] < b[2] end)
for i,p in ipairs(platesR) do
  if p[1] == 826 or p[1] == 860 or p[1]==955 then
    local t,f = plateShapes(p[1],p[2],p[3],p[4],p[5],p[6],p[7], 7400+i*5)
    local s = {}
    for _,q in ipairs(f) do s[#s+1] = string.format("(%.1f,%.1f)", q[1], q[2]) end
    print(p[1], table.concat(s, " "))
  end
end

--@ chunk 160
palette{scrape={woodD, woodL}}
pl3 = pile{{"lead white",6},{"cobalt blue",0.55},{"Naples yellow",0.45},{"raw umber",0.08}, name="pl3"}
-- deeper accent under the big shadow plate at 826,550
local acc = poly({{802,550.4},{820,549.9},{835.5,549.8},{842,551.6},{840.5,554.2},{828,553.4},{814,554.6},{803.5,553.2}})
work(acc, {hand="detail", piles={{crevD,1},{shDeep,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.4}, angle=0, seed=11001})
-- low wind-cut drifts of lit snow rising over the foot of the talus
local drifts = {
  {crest={{684,569},{692,563.5},{702,559},{713,556.2},{722,555.6},{730,557},{736,558.8}}, lee={{730,557},{736,558.8},{744,562.5},{751,567},{745,568.5},{737,564}}},
  {crest={{786,569},{795,563.5},{806,559.3},{816,557.2},{827,556.6},{836,557.6},{841,559.6}}, lee={{836,557.6},{841,559.6},{849,564},{855,569},{846,569.5},{839,564}}},
  {crest={{900,569},{909,564},{920,560.6},{932,558.4},{943,558.6},{949,560.6}}, lee={{943,558.6},{949,560.6},{957,565},{962,569.5},{953,569.8},{947,564.5}}},
}
for i,d in ipairs(drifts) do
  local pts = {}
  for _,p in ipairs(d.crest) do pts[#pts+1] = p end
  local last = d.crest[#d.crest]
  pts[#pts+1] = {last[1]+12, 574}
  pts[#pts+1] = {d.crest[1][1]-6, 574}
  local dm = poly(pts) - poly(d.lee)
  local cy = d.crest[#d.crest-2][2]
  work(dm, {hand="detail", piles={{pl2,1},{pl3, function(x,y) return clamp((y-cy)/12,0,1)*0.6 end},{litW, function(x,y) return clamp(1-(y-cy)/7,0,1)*0.9 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.2}, angle=-0.08, seed=11010+i})
  blend(dm * below(function(x) return cy + 6 end), {angle=0, seed=11020+i})
  work(poly(d.lee), {hand="detail", piles={{cs1,1},{mB,0.6},{shTop2 or cs1, 0}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=0.5, seed=11030+i})
end

--@ chunk 161
local function blockMask(x,y,w,h,seed)
  local f,t,r,s = blockShapes(x,y,w,h,seed)
  return poly(f) + poly(t) + poly(r)
end
for k,b in ipairs(baseSh) do
  local m = blockMask(b[1],b[2],b[3],b[4],3200+k*7)
  local x0,y0,x1,y1 = bbox(m)
  print(k, b[1], b[2], string.format("%.0f %.0f %.0f %.0f", x0,y0,x1,y1), string.format("%.0f", (m - talusM):area()))
end

--@ chunk 162
local function blockMask(x,y,w,h,seed)
  local f,t,r,s = blockShapes(x,y,w,h,seed)
  return poly(f) + poly(t) + poly(r)
end
local outM
for _,k in ipairs{4, 8, 10} do
  local b = baseSh[k]
  local m = blockMask(b[1],b[2],b[3],b[4],3200+k*7):grow(1.5)
  outM = outM and (outM + m) or m
end
outM = outM - talusM - iceAll
local sz = outM * shadowZone
local lt = outM - shadowZone
print(sz:area(), lt:area())
work(lt, {hand="detail", piles={{pl2,1},{pl3,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.2}, angle=0, seed=11101})
work(sz, {hand="detail", piles={{cs1,1},{cs0,0.6}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.2}, angle=0, seed=11102})

--@ chunk 163
print("columns: y of min value along x for y in 450..495")
for x=300,368,6 do
  local best, by = 999, nil
  for y=448,498,0.5 do
    local v = value_at and value_at(x,y) or nil
  end
end
print(type(value_at), type(probe), type(color_at), type(sample))

--@ chunk 164
-- lose the pen line along T's top (keep the value step lit LT / shadow T)
local tl = ribbon({{298,433.5},{281,440.5},{263,449.5},{255,462},{249,478}}, 3.4) - poly(LT)
work(tl, {hand="detail", piles={{cs0,1},{sC1,0.5},{cs1,0.2}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-0.6, seed=11201})
-- lose the diagonal pen line on Q: a soft value step instead
local a, b = {300,457}, {360,483}
local dx, dy = b[1]-a[1], b[2]-a[2]; local L = math.sqrt(dx*dx+dy*dy)
local nx, ny = -dy/L, dx/L  -- points down-left (toward the lighter side)
local dl = ribbon({a, b}, 4.2) - keepM
local function side(x,y) return ((x-a[1])*nx + (y-a[2])*ny) end
work(dl, {hand="detail", piles={{mA, function(x,y) return clamp(0.5 - side(x,y)/4,0,1)+0.02 end},{mB, function(x,y) return clamp(0.5 + side(x,y)/4,0,1)+0.02 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=math.atan(dy,dx), seed=11202})
blend(dl:grow(1), {angle=math.atan(dy,dx), seed=11203})

--@ chunk 165
local a, b = {300,457}, {360,483}
local dl = ribbon({a, b}, 7) - keepM
blend(dl, {angle=math.atan(b[2]-a[2], b[1]-a[1]), seed=11301})
blend(dl, {angle=math.atan(b[2]-a[2], b[1]-a[1]) + 0.4, seed=11302})

--@ chunk 166
local a, b = {300,457}, {360,483}
local dl = ribbon({a, b}, 4.2):grow(2) - keepM
for pass=1,4 do
  local rr = rag{width=6}
  rr:dip(1.0)
  rr:wipe(dl, {pressure=0.95, angle=pass*0.7, passes=1, refold=0.3})
end
-- now a value step without a line: Q's front above, lighter snow below
local dx, dy = b[1]-a[1], b[2]-a[2]
local function f(x,y) return (x-a[1])*(-dy) + (y-a[2])*dx end   -- >0 below/left side
local band = ribbon({{a[1]-2,a[2]-1},{b[1]+2,b[2]+1}}, 6) - keepM
local upper = band * mask(function(x,y) return f(x,y) < -10 and 1 or 0 end)
local lower = band * mask(function(x,y) return f(x,y) >= -10 and 1 or 0 end)
work(upper, {hand="detail", piles={{mA,1},{mB,0.9}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.5}, angle=math.atan(dy,dx), seed=11401})
work(lower, {hand="detail", piles={{mB,1},{litCool,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.5}, angle=math.atan(dy,dx), seed=11402})

--@ chunk 167
local a, b = {300,457}, {360,483}
local dl = ribbon({a, b}, 6):grow(2) - keepM
for pass=1,5 do
  local rr = rag{width=6}
  rr:dip(1.0)
  rr:wipe(dl, {pressure=0.95, angle=pass*0.7, passes=1, refold=0.3})
end

--@ chunk 168
local function Ly(x) return 455.5 + 0.43*(x-300) end
local function seg(x0, x1) return ribbon({{x0, Ly(x0)},{x1, Ly(x1)}}, 3.2) end
local m = (seg(306, 333) + seg(339, 358)) - keepM
work(m, {hand="detail", piles={{mA,1},{mB,0.9}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.3}, angle=math.atan(0.43,1), seed=11501})

--@ chunk 169
local a, b = {300,457}, {360,483}
local dl = ribbon({a, b}, 9) - keepM
blend(dl, {angle=math.atan(26,60)+0.5, seed=11601})
blend(dl, {angle=math.atan(26,60)-0.5, seed=11602})

--@ chunk 170
print(wait(2*24*60))
for _,p in ipairs{{350,650},{450,690},{560,640},{330,700},{850,650},{730,660},{900,600}} do print(p[1],p[2],drying(p[1],p[2])) end
print(leadM:at(330,625), leadM:at(320,615), nearM:at(320,630))

--@ chunk 171
palette{scrape={pl3}}
sDeepG = pile{{"lead white",0.7},{"cobalt blue",0.8},{"Prussian blue",0.12},{"green earth",0.4},{"raw umber",0.25}, name="sDeepG"}
print(palette())

--@ chunk 172
palette{scrape={shTop2, litW}}
edgeG = pile{{"lead white",2},{"cobalt blue",0.6},{"green earth",0.45},{"Prussian blue",0.05},{"smalt",0.2}, name="edgeG"}
wedgeL2 = pile{{"lead white",3},{"cobalt blue",0.35},{"smalt",0.1},{"Naples yellow",0.3},{"raw umber",0.1}, name="wedgeL2"}
palette{scrape={pl2}}
npDark = mix{{fgB2,0.5},{sDeepG,0.25},{fgT2,0.25}, name="npDark"}
local ox, oy = -380, 2
local function S(list) local o = {} for i,p in ipairs(list) do o[i] = {p[1]+ox+380, math.min(716, p[2]+oy)} end return o end
-- (plate drawn in local coords: x 300..592 maps to 300..592 on canvas)
npBack = S{{330,626},{356,620},{358,616},{392,609},{398,612},{404,607},{446,601},{450,605},{470,604},{474,608},{512,617},{530,616},{550,624}}
for _,p in ipairs(npBack) do p[2] = p[2] + 18 end
local function T(list) local o = S(list); for _,p in ipairs(o) do p[2] = math.min(716, p[2] + 18) end; return o end
local pts = {}
for _,p in ipairs(npBack) do pts[#pts+1] = p end
for _,p in ipairs(T{{586,672},{566,716},{318,716},{322,666}}) do pts[#pts+1] = p end
npTopM = poly(pts)
local x0,y0,x1,y1 = bbox(npTopM)
print(x0,y0,x1,y1)

--@ chunk 173
local function T(list) local o = {} for i,p in ipairs(list) do o[i] = {p[1], math.min(716, p[2]+20)} end return o end
local oy = 20
local top = npTopM - leadM - nearM
local gn = noise{seed=71, period=35, stretch={-0.1, 5}}
work(top, {hand="detail", piles={{npDark,1},{fgT2, function(x,y) return clamp(1-(y-605-oy)/45,0,1)*0.6 + math.max(0,gn(x,y))*0.3 end},{fgB2, function(x,y) return clamp((x-430)/150,0,1)*0.5 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=3.5}, angle=-0.2, seed=12001})
blend(top:shrink(1), {angle=-0.2, seed=12002})
local thk = T{{330,626},{356,620},{358,616},{392,609},{398,612},{404,607},{446,601},{450,605},{470,604},{474,608},{512,617},{530,616},{550,624},
              {550,622},{530,613},{512,614},{474,604},{470,600},{450,601},{446,596},{404,601},{398,606},{392,603},{358,609},{356,613},{330,620}}
npThkM = poly(thk) - npTopM
work(npThkM, {hand="detail", piles={{wedgeL2, function(x,y) return clamp(1-(x-330)/150,0,1)+0.05 end},{edgeG, function(x,y) return clamp((x-440)/60,0,1) end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.5}, angle=-0.15, seed=12003})
npEndM = poly(T{{330,620},{330,626},{322,666},{318,716},{302,716},{308,668},{320,626}}) - npTopM
work(npEndM, {hand="detail", piles={{sDeepG,1},{edgeG, function(x,y) return clamp(1-(y-620-oy)/50,0,1)*0.8 end},{fgB2,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=1.5, seed=12004})
npFrontM = poly(T{{586,672},{592,680},{576,716},{566,716}}) - npTopM
work(npFrontM, {hand="detail", piles={{sDeepG,1},{crevD,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=2.2, seed=12005})
local rg = brush{kind="rigger", width=1, point=1}
rg:reload(crevD, 0.45)
rg:stroke(T{{320,626},{308,668},{302,716}}, {pressure={0.3,0.35}, shake=0.15})
rg:reload(crevD, 0.45)
rg:stroke(T{{446,601},{441,626},{445,640},{438,668},{441,690},{436,716}}, {pressure={0.18,0.4}, shake=0.05})
local lb = brush{kind="round", width=1.6, point=0.6}
lb:reload(fgT2, 0.5)
lb:stroke(T{{439,630},{443,641},{437,666}}, {pressure={0.35,0.2}, shake=0.1})
for i,f in ipairs({0.2,0.42,0.6,0.82}) do
  local y0 = lerp(628, 716, f)
  rg:reload(edgeG, 0.35)
  rg:stroke({{lerp(320,330,1-f)+0.5, math.min(716,y0+oy-1)},{lerp(308,320,1-f)+rand(3,7), math.min(716,y0+oy+rand(1,3))}}, {pressure={0.2,0.06}, shake=0.2, clip=npEndM})
end
nearM = nearM + npTopM + npThkM + npEndM + npFrontM

--@ chunk 174
-- snow lodged in hollows of the plate's top: low, elongated lighter patches, and a second short crack
local sn = brush{kind="filbert", width=3}
local spots = {{352,668,14,-0.15},{372,690,22,-0.2},{405,655,10,-0.18},{478,672,16,-0.22},{512,700,24,-0.2},{532,662,9,-0.25},{455,705,12,-0.2},{392,710,18,-0.18}}
for _,s in ipairs(spots) do
  sn:reload(fgT2, 0.5)
  local dx, dy = math.cos(s[4])*s[3], math.sin(s[4])*s[3]
  sn:stroke({{s[1]-dx/2, s[2]-dy/2},{s[1]+dx/2, s[2]+dy/2}}, {pressure={0.35,0.25}, shake=0.4, clip=npTopM})
end
blend(npTopM:shrink(2) * rect(330,640,240,80), {angle=-0.2, seed=12101})
local rg = brush{kind="rigger", width=1, point=1}
rg:reload(crevD, 0.4)
rg:stroke({{442,668},{458,676},{471,679},{486,690}}, {pressure={0.2,0.06}, shake=0.05, clip=npTopM})
local lb = brush{kind="round", width=1.3, point=0.6}
lb:reload(fgT2, 0.4)
lb:stroke({{445,666.5},{458,673.5},{470,676.5}}, {pressure={0.25,0.1}, shake=0.1, clip=npTopM})

--@ chunk 175
local m = ribbon({{444,666},{458,673},{471,676.2}}, 2.4) * npTopM - ribbon({{442,668},{458,676},{471,679},{486,690}}, 1.0)
work(m, {hand="detail", piles={{npDark,1},{fgT2,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.2}, angle=0.4, seed=12201})

--@ chunk 176
palette{scrape={npDark}}
slabG3 = pile{{"lead white",0.6},{"cobalt blue",0.35},{"smalt",0.1},{"green earth",0.6},{"raw umber",0.35},{"yellow ochre",0.08},{"Prussian blue",0.02}, name="slabG3"}
slabD = pile{{"lead white",0.42},{"cobalt blue",0.32},{"smalt",0.1},{"green earth",0.6},{"raw umber",0.48},{"yellow ochre",0.05},{"Prussian blue",0.03}, name="slabD"}
print(palette())

--@ chunk 177
for _,p in ipairs{{760,640},{780,700},{850,620},{900,700},{990,600},{960,660},{745,690}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 178
local function farT(x,y) local e = 630 - 0.218*(x-745); return clamp((y-e)/(716-e),0,1) end
local gn = noise{seed=313, period=55, stretch={-0.25, 4}}
local m = slabTopM - nearM
restateBroad(m, {{slabG3, function(x,y) return clamp(1-farT(x,y)*2.0,0,1)+0.06 end},{slabD, function(x,y) return clamp(farT(x,y)*1.6-0.1,0,1)*0.9 + math.max(0,gn(x,y))*0.25 end},{sDeepG, function(x,y) return clamp(farT(x,y)*1.4-0.3,0,1)*0.45 end}}, -0.24, "filbert 10", 12301)

--@ chunk 179
palette{scrape={slabD, slabG3}}
litW = pile{{"lead white",6},{"Naples yellow",0.14}, name="litW"}
local avoid = leadM + keepM + nearM + slabTopM + wedgeM + talusM
spray = {
  {505,566,9,3,2,-0.1,0},
  {566,572,16,5,3,0.06,0.3},
  {590,579,24,7,4,-0.08,0.5},
  {552,585,10,3,2,0.1,0},
  {622,591,34,9,5,0.04,0.8},
  {703,576,8,3,2,0.1,0},
  {776,571,12,4,2.5,-0.05,0.2},
  {812,583,28,8,5,0.08,0.7},
  {842,589,12,4,2.5,-0.1,0.1},
  {682,606,22,6,4,0.1,0.3},
}
table.sort(spray, function(a,b) return a[2] < b[2] end)
for i,p in ipairs(spray) do paintPlate(p[1],p[2],p[3],p[4],p[5],p[6],p[7], 12500+i*5, "lit", avoid) end

--@ chunk 180
local mm
for i,p in ipairs(spray) do
  local top, front, rightF, shadow = plateShapes(p[1],p[2],p[3],p[4],p[5],p[6],p[7], 12500+i*5)
  local m = poly(top) + poly(front) + poly(rightF) + poly(shadow)
  mm = mm and (mm + m) or m
end
sprayM = (mm:grow(1.5)) - leadM - keepM - nearM - slabTopM - wedgeM - talusM
for pass=1,8 do
  local rr = rag{width=8}
  rr:dip(1.0)
  rr:wipe(sprayM, {pressure=0.95, angle=pass*0.45, passes=1, refold=0.3})
end

--@ chunk 181
for pass=1,10 do
  local rr = rag{width=6}
  rr:dip(1.0)
  rr:wipe(sprayM, {pressure=1.0, angle=pass*0.6+0.2, passes=1, refold=0.15})
end
print(drying(622,588), drying(812,580))

--@ chunk 182
local k = knife{width=10}
local x0,y0,x1,y1 = bbox(sprayM)
print(x0,y0,x1,y1)
for y = 563, 612, 4 do
  local row = {}
  local inside = false
  local xs, xe
  for x = 495, 870, 1 do
    local v = sprayM:at(x, y) + sprayM:at(x, y-3) + sprayM:at(x, y+3)
    if v > 0.05 and not inside then inside = true; xs = x
    elseif v <= 0.05 and inside then inside = false; xe = x; row[#row+1] = {xs, xe} end
  end
  for _,r in ipairs(row) do
    k:scrape({{r[1]-2, y}, {r[2]+2, y}}, {pressure=1.0, angle=math.pi/2, lift=0})
    k:wipe()
  end
end

--@ chunk 183
palette{scrape={wedgeL2, sDeepG}}
pl2 = pile{{"lead white",6},{"cobalt blue",0.7},{"Naples yellow",0.35},{"rose madder",0.06},{"raw umber",0.1}, name="pl2"}
pl3 = pile{{"lead white",6},{"cobalt blue",0.55},{"Naples yellow",0.45},{"raw umber",0.08}, name="pl3"}
local m = sprayM:grow(1)
work(m, {hand="detail", piles={{pl2,1},{pl3, function(x,y) return clamp((y-560)/50,0,1) end}}, clip=true, coverage=4, fill=true, tool={kind="filbert", width=3}, angle=0.02, seed=12601})
blend(m:grow(1), {angle=0.02, seed=12602})

--@ chunk 184
function drawnPlate(P, seed, avoid)
  local top = P.top
  local nf, nr = P.nf, P.nr or 1
  local tm = poly(top)
  local fpts = {}
  for i=1,nf do fpts[#fpts+1] = top[i] end
  for i=nf,1,-1 do fpts[#fpts+1] = {top[i][1], top[i][2] + P.th[i]} end
  local fm = poly(fpts) - tm
  local thR = P.th[nf]
  local rpts = {}
  for i=nf, nf+nr do rpts[#rpts+1] = top[i] end
  for i=nf+nr, nf, -1 do local f = (i-nf)/math.max(1,nr); rpts[#rpts+1] = {top[i][1], top[i][2] + thR*(1-0.25*f)} end
  local rm = poly(rpts) - tm - fm
  local sl = P.sl
  local spts = {}
  for i=nf, nf+nr do local f = (i-nf)/math.max(1,nr); spts[#spts+1] = {top[i][1], top[i][2] + thR*(1-0.25*f)} end
  local last, first = spts[#spts], spts[1]
  spts[#spts+1] = {last[1] + sl*0.85, last[2] + 0.6}
  spts[#spts+1] = {first[1] + sl, first[2] + 1.2}
  local sm = poly(spts) - tm - fm - rm
  if avoid then tm = tm - avoid; fm = fm - avoid; rm = rm - avoid; sm = sm - avoid end
  local tool = {kind="filbert", width=1.6}
  work(sm, {hand="detail", piles={{cs1,1},{pl2, P.shL or 0.4}}, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed})
  work(tm, {hand="detail", piles={{pl2,1},{litWarm,P.lit or 0.7}}, clip=true, coverage=3, fill=true, tool=tool, angle=P.rot or 0, seed=seed+1})
  work(fm, {hand="detail", piles={{mB,1},{mA,0.6}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.3}, angle=P.rot or 0, seed=seed+2})
  work(rm, {hand="detail", piles={{sC1,1},{cs1,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.3}, angle=-1.2, seed=seed+3})
  return tm + fm + rm + sm
end
local avoid = slabTopM + wedgeM + nearM + talusM + leadM + keepM
local plist = {
  {top={{514,575},{520,576},{526,575.5},{528,573},{522,572},{516,572.5}}, nf=3, nr=1, th={0.3,1.0,1.4}, sl=6},
  {top={{589,585},{597,586.5},{604,586},{611,587},{613,583.5},{606,580.5},{598,580},{591,581.5}}, nf=4, nr=1, th={0.3,1.2,1.8,2.2}, sl=10},
  {top={{632,600},{643,602},{652,601},{662,603.5},{668,602.5},{671,598},{664,593},{652,592},{641,593.5},{634,596}}, nf=5, nr=2, th={0.5,2,2.8,3.4,3.5}, sl=16},
  {top={{786,581},{794,582.5},{801,582},{805,579},{799,576},{790,576.5}}, nf=3, nr=1, th={0.3,1.4,2}, sl=9},
  {top={{857,588},{866,590},{874,589},{882,590.5},{886,587},{880,583},{869,582},{860,583.5}}, nf=4, nr=1, th={0.3,1.5,2.2,2.6}, sl=11},
}
plainPlatesM = nil
for i,P in ipairs(plist) do
  local m = drawnPlate(P, 13000+i*7, avoid)
  plainPlatesM = plainPlatesM and (plainPlatesM + m) or m
end

--@ chunk 185
print(palette())

--@ chunk 186
palette{scrape={pl3}}
sDeepG = pile{{"lead white",0.7},{"cobalt blue",0.8},{"Prussian blue",0.12},{"green earth",0.4},{"raw umber",0.25}, name="sDeepG"}
aeM = mix{{sDeepG,0.55},{sC1,0.45}, name="aeM"}
local function P(f,t)
  local tx, ty = 644 + 12*f, 98 + 14*f
  local bx, by = 652 + 53*f, 400 + 5*f
  return {lerp(tx,bx,t), lerp(ty,by,t)}
end
local breaks = {{0.05,0.35,0.30,0.37},{0.4,0.7,0.12,0.19},{0.55,0.95,0.45,0.51},{0.1,0.5,0.62,0.69},{0.6,0.92,0.76,0.85},{0.2,0.45,0.86,0.94},{0.7,1.0,0.25,0.31},{0.0,0.22,0.5,0.55},{0.35,0.6,0.38,0.43},{0.45,0.75,0.58,0.62}}
local AeV = visible("Ae"):shrink(1.5)
local bm
for _,b in ipairs(breaks) do
  local q = poly({P(b[1],b[3]), P(b[2],b[3]+0.01), P(b[2],b[4]), P(b[1],b[4]-0.01)})
  bm = bm and (bm + q) or q
end
bm = bm * AeV
work(bm, {hand="detail", piles={{aeM,1},{sDeepG, function(x,y) return clamp(1-(y-100)/200,0,1)*0.5 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.8}, angle=1.39, seed=13101})

--@ chunk 187
palette{scrape={litW}}
sDeep = pile{{"lead white",0.6},{"cobalt blue",1},{"Prussian blue",0.12},{"raw umber",0.4}, name="sDeep"}
local AeV = visible("Ae")
local gn = noise{seed=41, period=60, stretch={1.39, 5}}
restateBroad(AeV, {{aeM,1},{sDeepG, function(x,y) return clamp(1-(y-100)/220,0,1)*0.8 end},{sDeep, function(x,y) return clamp((y-200)/200,0,1)*0.5 + math.max(0,gn(x,y))*0.3 end}}, 1.39, "filbert 7", 13201)

--@ chunk 188
palette{scrape={sDeep}}
strataL = pile{{"lead white",1.6},{"cobalt blue",0.9},{"smalt",0.5},{"green earth",0.2},{"raw umber",0.1}, name="strataL"}
local function P(f,t)
  local tx, ty = 644 + 12*f, 98 + 14*f
  local bx, by = 652 + 53*f, 400 + 5*f
  return {lerp(tx,bx,t), lerp(ty,by,t)}
end
local AeV = visible("Ae"):shrink(0.8)
local rg = brush{kind="rigger", width=1.0, point=1}
-- broken strata: {f, t0, t1, f drift}
local S = {
  {0.18,0.04,0.31,0.02},{0.2,0.36,0.55,-0.03},{0.31,0.1,0.22,0.0},{0.33,0.48,0.86,0.04},
  {0.45,0.02,0.40,0.05},{0.5,0.58,0.72,0.0},{0.62,0.2,0.34,-0.02},{0.66,0.43,0.97,0.06},
  {0.78,0.08,0.18,0.0},{0.8,0.3,0.62,0.03},{0.88,0.7,0.9,-0.04},{0.25,0.75,0.95,0.02},
}
for _,s in ipairs(S) do
  local a, m, b = P(s[1], s[2]), P(s[1]+s[4]*0.5, (s[2]+s[3])/2), P(s[1]+s[4], s[3])
  rg:reload(strataL, rand(0.3,0.42))
  rg:stroke({a, {m[1]+rand(-0.4,0.4), m[2]}, b}, {pressure={rand(0.14,0.22), rand(0.05,0.1)}, shake=0.25, clip=AeV})
end

--@ chunk 189
palette{scrape={aeM, strataL}}
local tool = {kind="filbert", width=2}
-- P1: top darkened into the shadow family
local t1 = poly({{62,676},{96,655},{150,652},{144,667},{104,683}})
work(t1, {hand="detail", piles={{fgT2,1},{cs1,0.55},{edgeG,0.15}}, clip=true, coverage=3, fill=true, tool=tool, angle=-0.25, seed=13301})
-- P1: one thick face instead of two stacked layers
local f1 = poly({{62,676},{104,683},{144,667},{146,674},{144,684},{106,699},{64,692},{63,684}}) - t1
work(f1, {hand="detail", piles={{cs0, function(x,y) return clamp(1-(y-670)/16,0,1)+0.1 end},{edgeG, function(x,y) return 0.45 end},{sDeepG, function(x,y) return clamp((y-678)/16,0,1) end}}, clip=true, coverage=3, fill=true, tool=tool, angle=-0.3, seed=13302})
blend(f1:shrink(0.6), {angle=-0.3, seed=13303})
-- P3 and P4 tops into the shadow family
local t3 = poly({{150,656},{170,644},{196,646},{188,656},{160,662}})
work(t3, {hand="detail", piles={{fgT2,1},{cs1,0.6}}, clip=true, coverage=3, fill=true, tool=tool, angle=-0.25, seed=13304})
local t4 = poly({{262,617},{280,605},{306,604},{300,614},{272,621}})
work(t4, {hand="detail", piles={{cs1,1},{fgT2,0.5}}, clip=true, coverage=3, fill=true, tool=tool, angle=-0.2, seed=13305})
-- shard: only its upper third catches the sun; lower part in half-shadow; foot in shadow
local s1 = poly({{196,640},{204,612},{214,600},{222,636}})
work(s1 * below(function(x) return 614 end), {hand="detail", piles={{mB, function(x,y) return clamp(1-(y-614)/12,0,1)+0.05 end},{cs1, function(x,y) return clamp((y-618)/16,0,1) end},{cs0, function(x,y) return clamp((y-628)/12,0,1)*0.6 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-1.3, seed=13306})
blend(s1 * below(function(x) return 610 end) * above(function(x) return 622 end), {angle=-1.3, seed=13307})
local s3 = poly({{196,640},{222,636},{228,634},{226,645},{198,648}})
work(s3, {hand="detail", piles={{cs0,1},{edgeG,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=0, seed=13308})

--@ chunk 190
local function tdown(x,y) local e = edgeY(x); return clamp((y-e)/(714-e),0,1) end
local function wT(x,y) return clamp(1 - tdown(x,y)*1.4,0,1) + 0.04 end
local function wB(x,y) local t = tdown(x,y); return clamp(t*1.3 - 0.15,0,1) * clamp(1.15 - x/900, 0.35, 1) end
local notches = poly({{121,652.4},{126,656.5},{131,652}}) + poly({{140,651.6},{144,656},{148,655},{151,651.5}}) + poly({{145,664},{141,669},{144,674.5},{148,672}})
  + poly({{184,645.6},{189,649.5},{193,649},{197,645.6}}) + poly({{294,603.6},{298,607.5},{302,606.8},{307,603.5}})
work(notches, {hand="detail", piles={{fgT2,wT},{fgB2,wB}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.3}, angle=0, seed=13401})

--@ chunk 191
wM4 = pile{{"bone black",0.8},{"Prussian blue",0.25},{"raw umber",0.38},{"lead white",1.3},{"cobalt blue",0.3},{"green earth",0.15}, name="wM4"}
-- drop two of the evenly spaced floes back into the water
local function floeArea(cx, cy, w, d)
  local th = math.max(1.2, d*0.25)
  return poly({{cx-w/2-1.5, cy-d/2-1},{cx+w/2+1.5, cy-d/2-1},{cx+w/2+1.5, cy+d/2+th+d*0.5+1.5},{cx-w/2-1.5, cy+d/2+th+d*0.5+1.5}})
end
local drop = (floeArea(438,543,7,2.5) + floeArea(326,590,8,3)) * leadM - wallM
work(drop, {hand="detail", pile=wM4, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-0.2, seed=13501})
blend(drop:grow(1.5) * leadM - wallM, {angle=-0.2, seed=13502})
print(drop:area())

--@ chunk 192
palette{scrape={edgeG}}
shTop2 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.35},{"Naples yellow",0.15},{"rose madder",0.05},{"raw umber",0.04}, name="shTop2"}
edgeG = pile{{"lead white",2},{"cobalt blue",0.6},{"green earth",0.45},{"Prussian blue",0.05},{"smalt",0.2}, name="edgeG"}
function floeP(pts, lit, seed, th)
  local top = poly(pts)
  local ys = 0; for _,p in ipairs(pts) do ys = math.max(ys, p[2]) end
  local d = 0; local ymin = 1e9; for _,p in ipairs(pts) do ymin = math.min(ymin, p[2]) end; d = ys - ymin
  th = th or math.max(0.9, d*0.3)
  local sp = {}; for i,p in ipairs(pts) do sp[i] = {p[1], p[2]+th} end
  local side = (poly(sp) - top) * leadM
  local rp = {}; for i,p in ipairs(pts) do rp[i] = {p[1], p[2]+th+d*0.6} end
  local rm = (poly(rp) - top - side) * leadM - wallM
  local tool = {kind="filbert", width=1.2}
  work(rm, {hand="detail", piles={{mA,1},{edgeG,0.6},{wM4,0.5}}, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed+1})
  work(side, {hand="detail", piles={{edgeG,1},{sC1,0.5}}, clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed+2})
  work(top * leadM, {hand="detail", piles=(lit and {{litWarm,1},{litCool,0.4}} or {{shTop2,1},{mB,0.5}}), clip=true, coverage=3, fill=true, tool=tool, angle=0, seed=seed+3})
  floatM = floatM + top + side
end
-- a cluster around the larger floe at 352,580: two chips and a sliver
floeP({{361,584.2},{365.5,582.8},{369,583.6},{366,585.6},{362,585.8}}, false, 13601)
floeP({{341,575.4},{344,574.6},{346.5,575.6},{343.5,576.6}}, false, 13611)
floeP({{370,588.6},{372,588},{373.5,588.8},{371.5,589.6}}, false, 13621)
-- a long thin sliver near the middle of the narrow part
floeP({{398,559.8},{405,558.2},{413,558.6},{416,559.6},{408,561}}, true, 13631)
-- tiny brash bits near the far wall and near the tip
floeP({{462,525.6},{464.5,525},{466,525.8},{464,526.6}}, true, 13641)
floeP({{426,545.8},{428.5,545.2},{430,546},{428,546.8}}, true, 13651)
-- an angular, larger tilted floe in the wide part (left), half its top in shadow
floeP({{268,612.5},{278,609},{291,610},{296,613.5},{286,616.5},{272,616.8}}, false, 13661, 1.6)

--@ chunk 193
local Jv = visible("J")
local rim = poly({{804,285},{829.5,261.5},{831.5,265},{808,287.5}}) * Jv
work(rim, {hand="detail", piles={{litWarm,1},{litCool,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.4}, angle=-0.72, seed=13701})
-- foot of J darker (in C's shadow), graded
local foot = Jv * below(function(x) return 318 end)
work(foot, {hand="detail", piles={{cs1, function(x,y) return 1 end},{cs0, function(x,y) return clamp((y-318)/27,0,1)*0.8 end}}, clip=true, coverage=2, fill=true, tool={kind="filbert", width=2.5}, angle=1.2, seed=13702})
blend(Jv * below(function(x) return 312 end), {angle=1.2, seed=13703})

--@ chunk 194
print(wait(3*24*60))
for _,p in ipairs{{850,650},{900,600},{730,660},{715,700},{450,680},{320,690},{622,592},{100,670},{205,625},{820,300}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 195
for _,l in ipairs({palette()}) do print(l) end

--@ chunk 196
local slabV = slabTopM - nearM
local rg = brush{kind="rigger", width=1.0, point=1}
-- crack 1: runs toward us, straight segments, widening with nearness
local c1 = {{872,602.5},{868,624},{876,645},{871,668},{884,692},{889,716.5}}
local function wAt(y) return lerp(0.5, 4.2, clamp((y-602)/114,0,1)) end
local L, R = {}, {}
for _,p in ipairs(c1) do local w = wAt(p[2]); L[#L+1] = {p[1]-w*0.45, p[2]}; R[#R+1] = {p[1]+w*0.55, p[2]} end
local gp = {}
for _,p in ipairs(L) do gp[#gp+1] = p end
for i=#R,1,-1 do gp[#gp+1] = R[i] end
local gap = poly(gp) * slabV
work(gap, {hand="detail", piles={{crevD,1},{sDeepG,0.7}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.2}, angle=1.35, seed=13801})
-- snow lodged in the near, wider part (irregular, not a line)
local lodged = (poly({{872.5,671},{876,668.6},{879,676},{877.5,680}}) + poly({{880,689},{884.5,691},{888,702},{886,707},{883,699}}) + poly({{886.5,709},{889,711},{890.5,716.5},{887.5,716.5}})) * gap:grow(0.6)
work(lodged, {hand="detail", piles={{fgT2,1},{cs1,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.1}, angle=1.35, seed=13802})
-- crack 2: transverse branch toward the right: far wall seen as a thin greenish band above a dark line
local c2 = {{876,645},{903,642},{906,644.5},{936,638.5},{962,634},{967,636},{1001,629.5}}
local wall = {}
for _,p in ipairs(c2) do wall[#wall+1] = {p[1], p[2]-1.6} end
local wp = {}
for _,p in ipairs(wall) do wp[#wp+1] = p end
for i=#c2,1,-1 do wp[#wp+1] = c2[i] end
local wallM2 = poly(wp) * slabV
work(wallM2, {hand="detail", piles={{edgeG,1},{fgT2,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.1}, angle=-0.18, seed=13803})
rg:reload(crevD, 0.45)
rg:stroke({c2[1],c2[2],c2[3],c2[4]}, {pressure={0.3,0.22}, shake=0.05, clip=slabV})
rg:reload(crevD, 0.45)
rg:stroke({c2[4],c2[5],c2[6],c2[7]}, {pressure={0.22,0.16}, shake=0.05, clip=slabV})
-- wedge strata: broken lines along the wedge's length
local function interpX(line, y)
  for i=1,#line-1 do local a, b = line[i], line[i+1]; if y >= a[2] and y <= b[2] then return lerp(a[1], b[1], (y-a[2])/(b[2]-a[2])) end end
  return line[#line][1]
end
local function W(f, y) local xo, xa = interpX(wedgeOut, y), interpX(arris, y); return {lerp(xa, xo, f), y} end
local S = {{0.3,640,662},{0.35,668,690},{0.55,652,676},{0.62,684,712},{0.25,696,715},{0.8,672,688},{0.45,700,716}}
local wv = wedgeM:shrink(0.5)
for _,s in ipairs(S) do
  rg:reload(sC1, rand(0.3,0.4))
  rg:stroke({W(s[1], s[2]), W(s[1]+rand(-0.04,0.04), (s[2]+s[3])/2), W(s[1], s[3])}, {pressure={0.16,0.07}, shake=0.15, clip=wv})
end

--@ chunk 197
local slabV = slabTopM - nearM
local c2 = {{876,645},{903,642},{906,644.5},{936,638.5},{962,634},{967,636},{1001,629.5}}
local wp = {}
for _,p in ipairs(c2) do wp[#wp+1] = {p[1], p[2]-1.9} end
for i=#c2,1,-1 do wp[#wp+1] = {c2[i][1], c2[i][2]+0.6} end
local wallM2 = poly(wp) * slabV
work(wallM2, {hand="detail", piles={{sDeepG,1},{fgB2,0.6},{crevD,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.1}, angle=-0.18, seed=13901})
-- near lip of the cross crack catches a little sky: a faint broken light below it
local rb = brush{kind="round", width=1.1, point=0.7}
rb:reload(fgT2, 0.4)
rb:stroke({{880,646.6},{902,643.6}}, {pressure={0.22,0.12}, shake=0.1, clip=slabV})
rb:reload(fgT2, 0.4)
rb:stroke({{938,640.2},{960,636.2}}, {pressure={0.2,0.1}, shake=0.1, clip=slabV})
-- the long crack: greener, less blue
local c1 = {{872,602.5},{868,624},{876,645},{871,668},{884,692},{889,716.5}}
local function wAt(y) return lerp(0.5, 4.2, clamp((y-602)/114,0,1)) end
local gp = {}
for _,p in ipairs(c1) do local w = wAt(p[2]); gp[#gp+1] = {p[1]-w*0.45, p[2]} end
for i=#c1,1,-1 do local p = c1[i]; local w = wAt(p[2]); gp[#gp+1] = {p[1]+w*0.55, p[2]} end
local gap = poly(gp) * slabV
local lodged = (poly({{872.5,671},{876,668.6},{879,676},{877.5,680}}) + poly({{880,689},{884.5,691},{888,702},{886,707},{883,699}}) + poly({{886.5,709},{889,711},{890.5,716.5},{887.5,716.5}}))
work(gap - lodged, {hand="detail", piles={{sDeepG,1},{fgB2,0.5},{crevD,0.35}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.1}, angle=1.35, seed=13902})

--@ chunk 198
palette{scrape={shTop2, wM4}}
slabDD = pile{{"lead white",0.28},{"cobalt blue",0.25},{"green earth",0.6},{"raw umber",0.6},{"Prussian blue",0.04},{"yellow ochre",0.04}, name="slabDD"}
local slabV = slabTopM - nearM
local c2 = {{876,645},{903,642},{906,644.5},{936,638.5},{962,634},{967,636},{1001,629.5}}
local wp = {}
for _,p in ipairs(c2) do wp[#wp+1] = {p[1], p[2]-1.9} end
for i=#c2,1,-1 do wp[#wp+1] = {c2[i][1], c2[i][2]+0.6} end
local wallM2 = poly(wp) * slabV
work(wallM2, {hand="detail", piles={{slabDD,1},{sDeepG,0.25}}, clip=true, coverage=4, fill=true, tool={kind="filbert", width=1.1}, angle=-0.18, seed=14001})
local c1 = {{872,602.5},{868,624},{876,645},{871,668},{884,692},{889,716.5}}
local function wAt(y) return lerp(0.5, 4.2, clamp((y-602)/114,0,1)) end
local gp = {}
for _,p in ipairs(c1) do local w = wAt(p[2]); gp[#gp+1] = {p[1]-w*0.45, p[2]} end
for i=#c1,1,-1 do local p = c1[i]; local w = wAt(p[2]); gp[#gp+1] = {p[1]+w*0.55, p[2]} end
local gap = poly(gp) * slabV
local lodged = (poly({{872.5,671},{876,668.6},{879,676},{877.5,680}}) + poly({{880,689},{884.5,691},{888,702},{886,707},{883,699}}) + poly({{886.5,709},{889,711},{890.5,716.5},{887.5,716.5}}))
work(gap - lodged, {hand="detail", piles={{slabDD,1},{sDeepG,0.3}}, clip=true, coverage=4, fill=true, tool={kind="filbert", width=1.1}, angle=1.35, seed=14002})

--@ chunk 199
local gn = noise{seed=77, period=25}
work(npThkM, {hand="detail", piles={{mB, function(x,y) return clamp(1-(x-330)/110,0,1)*0.9+0.1 end},{mA, function(x,y) return clamp(1-math.abs(x-450)/90,0,1)*0.9 + math.max(0,gn(x,y))*0.4 end},{edgeG, function(x,y) return clamp((x-470)/60,0,1) end},{cs1, function(x,y) return 0.25 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.4}, angle=-0.12, seed=14101})

--@ chunk 200
for _,p in ipairs{{340,630},{450,622},{310,680},{450,680},{880,650},{930,640},{300,465},{330,470},{622,595},{590,583},{520,574}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 201
local function tdown(x,y) local e = edgeY(x); return clamp((y-e)/(714-e),0,1) end
local function wT(x,y) return clamp(1 - tdown(x,y)*1.4,0,1) + 0.04 end
local function wB(x,y) local t = tdown(x,y); return clamp(t*1.3 - 0.15,0,1) * clamp(1.15 - x/900, 0.35, 1) end
local back = {{330,646},{356,640},{358,636},{392,629},{398,632},{404,627},{446,621},{450,625},{470,624},{474,628},{512,637},{530,636},{550,644}}
-- 1. lose the far edge outside x 342..432: band colour over the rim and the first units of the top
local edgeZone = (npThkM:grow(1.2) + ribbon(back, 7))
local loseZ = edgeZone * (rect(432,600,170,60) + rect(290,600,52,60))
work(loseZ, {hand="detail", piles={{fgT2,wT},{fgB2,wB}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=-0.15, seed=14201})
-- the kept stretch: rim brought down to one step above the band
local keepZ = npThkM * rect(342,600,90,60)
work(keepZ, {hand="detail", piles={{cs1,0.5},{fgT2,0.5},{edgeG,0.1}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.4}, angle=-0.15, seed=14202})
-- 2. end face: outer part into the band, inner part greyed, lower half lost
local endZ = npEndM:grow(1)
local function inner(x,y) return clamp((x-311)/4,0,1) * clamp(1-(y-668)/16,0,1) end
work(endZ, {hand="detail", piles={{fgT2, function(x,y) return wT(x,y)*(1-inner(x,y)) + 0.02 end},{fgB2, function(x,y) return wB(x,y)*(1-inner(x,y)) end},{cs1, function(x,y) return inner(x,y)*0.6 end},{edgeG, function(x,y) return inner(x,y)*0.25 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.8}, angle=1.5, seed=14203})
blend(endZ:grow(1.5) * below(function(x) return 664 end), {angle=1.5, seed=14204})
-- 3. take the crack out
local crack = {{446,621},{441,646},{445,660},{438,688},{441,710},{436,717}}
local cz = (ribbon(crack, 5) + ribbon({{439,650},{443,661},{437,686}}, 4) + ribbon({{442,668},{458,676},{471,679},{486,690}}, 4.5)) * npTopM
work(cz, {hand="detail", piles={{fgB2,0.5},{sDeepG,0.25},{fgT2,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=-0.2, seed=14205})
blend(cz:grow(2) * npTopM, {angle=-0.2, seed=14206})
-- 4. the right sliver: a slight step only
local fz = npFrontM:grow(1)
work(fz, {hand="detail", piles={{fgB2,1},{sDeepG,0.2},{fgT2,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.8}, angle=2.2, seed=14207})
blend(fz:grow(1.5), {angle=2.2, seed=14208})
blend(loseZ:grow(2), {angle=-0.15, seed=14209})

--@ chunk 202
local function tdown(x,y) local e = edgeY(x); return clamp((y-e)/(714-e),0,1) end
local function wT(x,y) return clamp(1 - tdown(x,y)*1.4,0,1) + 0.04 end
local function wB(x,y) local t = tdown(x,y); return clamp(t*1.3 - 0.15,0,1) * clamp(1.15 - x/900, 0.35, 1) end
-- taper the kept rim's ends into the band
local function endW(x,y) return math.max(clamp((x-412)/20,0,1), clamp(1-(x-340)/22,0,1)) end
local rimEnds = npThkM:grow(1.2) * (rect(408,600,30,50) + rect(326,600,40,60))
work(rimEnds, {hand="detail", piles={{fgT2, function(x,y) return wT(x,y)*endW(x,y)*0.9 + 0.02 end},{cs1, function(x,y) return (1-endW(x,y))*0.5 end},{fgB2, function(x,y) return wB(x,y)*endW(x,y)*0.6 + 0.01 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.4}, angle=-0.15, seed=14301})
blend(rimEnds:grow(1.5), {angle=-0.15, seed=14302})
-- end face: outer part into band, inner sliver darker
local endZ = npEndM:grow(1.2)
local function inner(x,y) return clamp((x-316)/4,0,1) * clamp(1-(y-664)/14,0,1) end
work(endZ, {hand="detail", piles={{fgT2, function(x,y) return wT(x,y)*(1-inner(x,y)) + inner(x,y)*0.7 + 0.02 end},{fgB2, function(x,y) return wB(x,y)*(1-inner(x,y)) end},{cs1, function(x,y) return inner(x,y)*0.3 end},{edgeG, function(x,y) return inner(x,y)*0.15 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=1.5, seed=14303})
blend(endZ:grow(2), {angle=1.5, seed=14304})
-- the pale dash left of the crack branch
local dash = poly({{440,662},{462,668},{488,672},{488,679},{462,676},{440,670}}) * npTopM
work(dash, {hand="detail", piles={{fgB2,0.5},{sDeepG,0.25},{fgT2,0.35}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=0.25, seed=14305})
blend(dash:grow(1.5) * npTopM, {angle=0.25, seed=14306})

--@ chunk 203
local function tdown(x,y) local e = edgeY(x); return clamp((y-e)/(714-e),0,1) end
local function wT(x,y) return clamp(1 - tdown(x,y)*1.4,0,1) + 0.04 end
local function wB(x,y) local t = tdown(x,y); return clamp(t*1.3 - 0.15,0,1) * clamp(1.15 - x/900, 0.35, 1) end
-- right end of the kept rim: band colour, a faint taper
local rz = (npThkM:grow(1.5) + ribbon({{398,632},{404,627},{446,621},{450,625}}, 5)) * rect(404,612,40,22) - npTopM:shrink(2)
work(rz, {hand="detail", piles={{fgT2, function(x,y) return wT(x,y) + 0.02 end},{fgB2, function(x,y) return wB(x,y) + 0.01 end},{cs1, function(x,y) return clamp(1-(x-404)/14,0,1)*0.3 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.3}, angle=-0.14, seed=14401})
-- left end: the end face lost into the band but for a slim inner edge
local lz = (npEndM:grow(1.5) + npThkM * rect(320,630,26,22)) * rect(296,630,40,90) - npTopM:shrink(1.5)
local function sliver(x,y) return clamp(1-math.abs(x-(330 - (y-640)*0.18))/2.2,0,1) * clamp(1-(y-642)/22,0,1) end
work(lz, {hand="detail", piles={{fgT2, function(x,y) return wT(x,y)*(1-sliver(x,y)) + sliver(x,y)*0.8 + 0.02 end},{fgB2, function(x,y) return wB(x,y)*(1-sliver(x,y)) end},{cs1, function(x,y) return sliver(x,y)*0.25 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.3}, angle=1.45, seed=14402})

--@ chunk 204
local slabV = slabTopM - nearM
local c1 = {{872,602.5},{868,624},{876,645},{871,668},{884,692},{889,716.5}}
local c2 = {{876,645},{903,642},{906,644.5},{936,638.5},{962,634},{967,636},{1001,629.5}}
crackWipe = (ribbon(c1, 7) + ribbon(c2, 6)) * slabV:grow(0.5)
for pass=1,6 do
  local rr = rag{width=6}
  rr:dip(1.0)
  rr:wipe(crackWipe, {pressure=0.95, angle=pass*0.55, passes=1, refold=0.3})
end
print(drying(872,640), drying(930,640), drying(884,695))

--@ chunk 205
palette{scrape={shDeep, crevD}}
slabCool = pile{{"lead white",0.9},{"cobalt blue",0.5},{"smalt",0.25},{"green earth",0.35},{"raw umber",0.25},{"rose madder",0.03}, name="slabCool"}
slabG3 = pile{{"lead white",0.6},{"cobalt blue",0.35},{"smalt",0.1},{"green earth",0.6},{"raw umber",0.35},{"yellow ochre",0.08},{"Prussian blue",0.02}, name="slabG3"}
slabD = pile{{"lead white",0.42},{"cobalt blue",0.32},{"smalt",0.1},{"green earth",0.6},{"raw umber",0.48},{"yellow ochre",0.05},{"Prussian blue",0.03}, name="slabD"}
fgCrack = {{858,606},{855,626},{866,648},{862,669},{878,694},{884,717}}
local function crackX(y)
  for i=1,#fgCrack-1 do local a,b = fgCrack[i], fgCrack[i+1]; if y >= a[2] and y <= b[2] then return lerp(a[1],b[1],(y-a[2])/(b[2]-a[2])) end end
  return fgCrack[#fgCrack][1]
end
local pts = {}
for _,p in ipairs(fgCrack) do pts[#pts+1] = p end
pts[#pts+1] = {1003,717}; pts[#pts+1] = {1003,570}; pts[#pts+1] = {858,598}
local slabV = slabTopM - nearM
planeR = poly(pts) * slabV
local function farT(x,y) local e = 630 - 0.218*(x-745); return clamp((y-e)/(716-e),0,1) end
local function dc(x,y) return x - crackX(clamp(y,606,717)) end
local function wCool(x,y) return clamp(1 - dc(x,y)/90,0,1)*0.55 + 0.2 end
local function wG3(x,y) return (1-wCool(x,y)) * clamp(1-farT(x,y)*2.0,0,1) + 0.03 end
local function wD(x,y) return (1-wCool(x,y)) * clamp(farT(x,y)*1.6-0.1,0,1)*0.9 end
local function wSG(x,y) return clamp(farT(x,y)*1.4-0.3,0,1)*0.3 end
restateBroad(planeR, {{slabCool,wCool},{slabG3,wG3},{slabD,wD},{sDeepG,wSG}}, -0.24, "filbert 9", 14501)
-- also cover the residue left of the new crack (old crack path)
local resid = crackWipe * slabV - planeR
work(resid, {hand="detail", piles={{slabG3, function(x,y) return clamp(1-farT(x,y)*2.0,0,1)+0.05 end},{slabD, function(x,y) return clamp(farT(x,y)*1.6-0.1,0,1)*0.9 end},{sDeepG, wSG}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=1.3, seed=14502})
blend(resid:grow(1.5) * slabV - planeR, {angle=1.3, seed=14503})

--@ chunk 206
local slabV = slabTopM - nearM
-- lose the step in one stretch
local lz = ribbon({{866,648},{862,669},{868,679}}, 10) * slabV
blend(lz, {angle=1.4, seed=14601})
blend(lz, {angle=0.2, seed=14602})
-- the gap: tapered dark stretches in the slab's own dark hue
local g = brush{kind="round", width=2.2, point=1}
g:reload(slabDD, 0.55)
g:gesture({{858.5,607,0.12},{857,616,0.3},{855.8,626,0.4},{860,637,0.45},{864,645,0.25},{865,650,0.0}}, {clip=slabV})
g:reload(slabDD, 0.6)
g:gesture({{866,676,0.0},{870,682,0.35},{875,689,0.6},{878.5,695,0.75},{881,704,0.9},{883,712,0.6}}, {clip=slabV})

--@ chunk 207
Tm_ = visible("T") - rubbleM - talusM
Qm_ = visible("Q") - rubbleM - talusM - keepM
LTm_ = poly(LT)
print(Tm_:area(), Qm_:area())

--@ chunk 208
palette{scrape={slabCool}}
shDeep = pile{{"lead white",0.7},{"cobalt blue",0.9},{"smalt",0.5},{"rose madder",0.06},{"raw umber",0.3}, name="shDeep"}
local protect = poly(hull, true) + hullShadowQ + visible("S1") + visible("S1e") + visible("S2") + visible("S2e") + rubbleM + visible("R") + visible("Re") + keepM + talusM
local e1 = poly({{356,352},{364,356},{348,402},{326,427},{305,452},{296,446},{318,420},{340,398}})
local sh1 = poly({{364,356},{384,366},{372,410},{346,440},{318,470},{305,452},{326,427},{348,402}})
local e2 = poly({{392,442},{430,446},{462,432},{461,439},{431,453},{394,449}})
local sh2 = poly({{394,449},{431,453},{461,439},{458,458},{430,464},{398,460}})
QfaceM = visible("Q") - protect - poly(LQ1) - poly(LQ2) - e1 - sh1 - e2 - sh2
print(QfaceM:area())
local x0,y0,x1,y1 = 300, 400, 470, 490
restateBroad(QfaceM, {{mA, function(x,y) return clamp(1-(y-400)/90,0,1)*0.6+0.4 end},{mB, function(x,y) return clamp((y-420)/70,0,1)*0.5+0.1 end},{cs1, function(x,y) return clamp((y-455)/30,0,1)*0.45 end}}, 0.3, "filbert 8", 14701)
TfaceM = visible("T") - rubbleM - talusM - poly(LT) - keepM
restateBroad(TfaceM, {{cs0, function(x,y) return 0.7 end},{sC1, function(x,y) return clamp(1-(y-430)/40,0,1)*0.6 end},{cs1, function(x,y) return clamp((y-460)/30,0,1)*0.7 end}}, 1.25, "filbert 6", 14702)

--@ chunk 209
-- T's top: one deliberate lit plane, wider than the old sliver, with a soft turn into the shadow face
LT2 = {{240,481},{249,452},{256,440},{272,431},{290,424},{299,432},{286,437},{272,444},{262,452},{255,466},{251,481}}
local topM = poly(LT2)
work(topM, {hand="detail", piles={{litWarm, function(x,y) return 1 end},{litCool, function(x,y) return clamp((y-440)/40,0,1)*0.7 end},{mB, function(x,y) return 0.12 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=-1.0, seed=14801})
-- the turn: a narrow band of half-tone just inside T along the plane's inner edge, blended both ways
local turn = ribbon({{299,433.5},{286,438.5},{272,445.5},{262,453.5},{255,467},{251.5,481}}, 3.2) - topM
work(turn, {hand="detail", piles={{mA,1},{cs1,0.6}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.5}, angle=-1.0, seed=14802})
blend(ribbon({{299,433.5},{286,438.5},{272,445.5},{262,453.5},{255,467},{251.5,481}}, 4.5), {angle=-1.0, seed=14803})

--@ chunk 210
for _,p in ipairs{{600,585},{622,585},{812,580},{870,588},{650,598},{520,574}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 211
palette{scrape={slabD}}
pl3 = pile{{"lead white",6},{"cobalt blue",0.55},{"Naples yellow",0.45},{"raw umber",0.08}, name="pl3"}
local keep = rect(508,567,32,15) + rect(626,587,68,22)
local driftZone = rect(680,530,320,44)
plainOut = rect(495,562,410,52) * above(shEdge) - keep - talusM - leadM - nearM - slabTopM - wedgeM - iceAll - rubbleM - driftZone
print(plainOut:area())
-- lift what is still open first
for pass=1,4 do
  local rr = rag{width=8}
  rr:dip(1.0)
  rr:wipe(plainOut * (rect(560,565,95,40) + rect(840,575,60,25)), {pressure=0.95, angle=pass*0.6, passes=1, refold=0.3})
end
work(plainOut, {hand="broad", piles={{pl2,1},{pl3, function(x,y) return clamp((y-540)/60,0,1) end}}, clip=true, coverage=3, fill=true, angle=0.02, tool="filbert 8", seed=14901})
blend(plainOut:shrink(1), {angle=0.02, seed=14902})

--@ chunk 212
local sp
for i,p in ipairs(spray) do
  local top, front, rightF, shadow = plateShapes(p[1],p[2],p[3],p[4],p[5],p[6],p[7], 12500+i*5)
  local m = poly(top) + poly(front) + poly(rightF) + poly(shadow)
  sp = sp and (sp + m) or m
end
sprayPlates = sp:grow(1.5)
talusM = talusM - sprayPlates
local keep = rect(508,567,32,15) + rect(626,587,68,22)
local cover = sprayPlates * above(shEdge) - keep - leadM - nearM - slabTopM - wedgeM - iceAll - rubbleM - talusM
print(cover:area())
work(cover, {hand="detail", piles={{pl2,1},{pl3, function(x,y) return clamp((y-540)/60,0,1) end}}, clip=true, coverage=4, fill=true, tool={kind="filbert", width=3}, angle=0.02, seed=15001})
blend(cover:grow(2), {angle=0.02, seed=15002})

--@ chunk 213
local stray = ribbon({{662.5,591.5},{666,595},{669.5,598.5}}, 1.8) - ribbon({{669,600},{671,603}}, 2) 
local dot = ellipse(627.5,589.5,2,2)
local m = (stray + dot) * above(shEdge)
work(m, {hand="detail", piles={{pl2,1},{pl3,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.2}, angle=0, seed=15101})

--@ chunk 214
palette{scrape={slabG3, slabDD}}
shTop2 = pile{{"lead white",2.6},{"cobalt blue",0.55},{"smalt",0.35},{"Naples yellow",0.15},{"rose madder",0.05},{"raw umber",0.04}, name="shTop2"}
-- paint out two more plates of the row into shadow snow
local outP = poly({{695,538},{728,535},{733,548},{728,553},{697,553}}) + poly({{871,549},{897,547},{901,557},{896,562},{872,561}})
outP = outP - iceAll - leadM
work(outP, {hand="detail", piles={{cs1,1},{cs0,0.6}}, clip=true, coverage=4, fill=true, tool={kind="filbert", width=2.2}, angle=0, seed=15201})
blend(outP:grow(1.5), {angle=0, seed=15202})
-- one clump pushed up E's foot: a broken slab leaning against E (front face in shadow, top catching sky)
local m = piece({
  {{{731,546},{733,524},{744,527},{757,515},{768,511},{781,501},{790,544},{760,550}}, "sfront", 1.4},
  {{{733,524},{746,506},{760,499},{774,496},{781,501},{768,511},{757,515},{744,527}}, "stop", -0.4},
}, 15210, iceAll * rect(0,0,1000,440))
-- contact dark at its foot
local cb2 = brush{kind="round", width=1.8, point=0.6}
cb2:reload(shDeep, 0.5)
cb2:stroke({{732,547},{760,551},{790,545}}, {pressure={0.35,0.3}, shake=0.3})

--@ chunk 215
local bm = (poly({{731,546},{733,524},{744,527},{757,515},{768,511},{781,501},{790,544},{760,550}}) + poly({{733,524},{746,506},{760,499},{774,496},{781,501},{768,511},{757,515},{744,527}}) + ribbon({{732,547},{760,551},{790,545}}, 3)):grow(1.5)
bm = bm - iceAll * rect(0,0,1000,440)
boulderM = bm
for pass=1,8 do
  local rr = rag{width=8}
  rr:dip(1.0)
  rr:wipe(bm, {pressure=0.95, angle=pass*0.5, passes=1, refold=0.25})
end

--@ chunk 216
local crest = {{690,557},{702,551},{716,543},{731,534},{744,526},{756,520},{766,516.5},{775,516},{783,519.5},{792,527},{801,537},{810,546},{818,553}}
local pts = {}
for _,p in ipairs(crest) do pts[#pts+1] = p end
pts[#pts+1] = {818,562}; pts[#pts+1] = {690,562}
local keepPlates = talusM - (poly({{695,538},{728,535},{733,548},{728,553},{697,553}}):grow(2))
bankM = poly(pts) - keepPlates - leadM
local function fromCrest(x,y)
  local cy = 560
  for i=1,#crest-1 do local a,b = crest[i], crest[i+1]; if x >= a[1] and x <= b[1] then cy = lerp(a[2],b[2],(x-a[1])/(b[1]-a[1])) end end
  return y - cy
end
-- windward (left) slope faces the sky and a little of the sun's direction: lighter; lee (right of 775) darker
work(bankM, {hand="detail", piles={{shTop2, function(x,y) return clamp(1-fromCrest(x,y)/20,0,1)*clamp((785-x)/30,0,1)+0.05 end},{cs1, function(x,y) return 0.6 end},{cs0, function(x,y) return clamp((x-778)/20,0,1)*0.8 + clamp(fromCrest(x,y)/30,0,1)*0.3 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=-0.45, seed=15301})
blend(bankM:shrink(0.5), {angle=-0.45, seed=15302})
-- soften the crest against E: lose it in places
blend(ribbon({{716,543},{744,526},{766,516.5}}, 4), {angle=-0.5, seed=15303})

--@ chunk 217
local crest = {{684,569},{694,563.5},{705,559.5},{716,556.5},{726,556},{736,558.5},{745,562.5},{753,563},{763,559.5},{774,557.5},{786,558},{797,561},{806,565},{814,569}}
local pts = {}
for _,p in ipairs(crest) do pts[#pts+1] = p end
pts[#pts+1] = {814,575}; pts[#pts+1] = {684,575}
local dm = poly(pts) - talusM - leadM - plainPlatesM
local function cy(x) for i=1,#crest-1 do local a,b = crest[i], crest[i+1]; if x >= a[1] and x <= b[1] then return lerp(a[2],b[2],(x-a[1])/(b[1]-a[1])) end end return 570 end
work(dm, {hand="detail", piles={{pl2,1},{litW, function(x,y) return clamp(1-(y-cy(x))/5,0,1)*0.8 end},{pl3, function(x,y) return clamp((y-cy(x))/10,0,1)*0.5 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.2}, angle=-0.05, seed=15401})
-- the lee of two humps: short soft shadow lines just right of their crests
local lee = poly({{726,556},{736,558.5},{745,562.5},{742,564.5},{734,561},{727,558}}) + poly({{786,558},{797,561},{806,565},{803,567},{795,563.5},{787,560}})
work(lee, {hand="detail", piles={{cs1,1},{mB,0.6}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.4}, angle=0.3, seed=15402})
blend(lee:grow(1), {angle=0.3, seed=15403})

--@ chunk 218
function softEdge(line, half, pilesA, pilesB, seed, opts)
  opts = opts or {}
  -- signed distance to a polyline: negative on the left of travel direction (A side), positive on the right (B side)
  local function sd(x, y)
    local best, sgn = 1e9, 1
    for i=1,#line-1 do
      local p, q = line[i], line[i+1]
      local dx, dy = q[1]-p[1], q[2]-p[2]
      local L2_ = dx*dx+dy*dy
      local t = clamp(((x-p[1])*dx + (y-p[2])*dy)/L2_, 0, 1)
      local cx, cy = p[1]+t*dx, p[2]+t*dy
      local d = math.sqrt((x-cx)^2 + (y-cy)^2)
      if d < best then best = d; sgn = ((dx*(y-p[2]) - dy*(x-p[1])) > 0) and 1 or -1 end
    end
    return best*sgn
  end
  local soft = opts.soft or half*0.8
  local function wB(x,y) return smoothstep(-soft, soft, sd(x,y)) end
  local function wA(x,y) return 1 - wB(x,y) end
  local piles = {}
  for _,pw in ipairs(pilesA) do piles[#piles+1] = {pw[1], function(x,y) return wA(x,y)*pw[2] + 0.005 end} end
  for _,pw in ipairs(pilesB) do piles[#piles+1] = {pw[1], function(x,y) return wB(x,y)*pw[2] + 0.005 end} end
  local band = ribbon(line, half*2)
  if opts.clip then band = band * opts.clip end
  local ang = math.atan(line[#line][2]-line[1][2], line[#line][1]-line[1][1])
  work(band, {hand="detail", piles=piles, clip=true, coverage=3, fill=true, tool={kind="filbert", width=opts.tool or 2}, angle=ang, seed=seed})
  blend(band:shrink(0.5), {angle=ang + math.pi/2, seed=seed+1})
  blend(band:shrink(0.5), {angle=ang, seed=seed+2})
  return band
end
-- L1: far (right) edge of B's shadow on A, lower half: a penumbra
softEdge({{620,300},{612,330},{604,360},{596,396},{590,425}}, 5, {{mA,0.6},{cs1,0.6}}, {{litCool,1},{litW,0.5}}, 15501, {clip=visible("A") - rubbleM})
-- L5: D1's top-left slope against B: lit against lit, lost over one stretch
softEdge({{470,425},{482,415},{494,405},{506,396}}, 4, {{litW,1},{litCool,0.5}}, {{litCool,0.8},{mB,0.5}}, 15511, {clip=(visible("B") + visible("D1")) - rubbleM})

--@ chunk 219
local band = ribbon({{620,300},{612,330},{604,360},{596,396},{590,425}}, 10):grow(1.5) * (visible("A") - rubbleM)
for pass=1,8 do
  local rr = rag{width=7}
  rr:dip(1.0)
  rr:wipe(band, {pressure=0.95, angle=pass*0.5, passes=1, refold=0.25})
end
local band2 = ribbon({{470,425},{482,415},{494,405},{506,396}}, 8):grow(1.5) * ((visible("B") + visible("D1")) - rubbleM)
for pass=1,6 do
  local rr = rag{width=7}
  rr:dip(1.0)
  rr:wipe(band2, {pressure=0.95, angle=pass*0.5, passes=1, refold=0.25})
end

--@ chunk 220
for _,y in ipairs{300,320,340,360} do
  local s = {}
  for x=580,626,3 do s[#s+1] = string.format("%d:%.2f", x, shBAm:at(x,y)) end
  print(y, table.concat(s, " "))
end

--@ chunk 221
print(palette())

--@ chunk 222
function softEdge3(line, refA, pilesA, pilesB, seed, mask, tool)
  local function sd(x, y)
    local best, sgn = 1e9, 1
    for i=1,#line-1 do
      local p, q = line[i], line[i+1]
      local dx, dy = q[1]-p[1], q[2]-p[2]
      local t = clamp(((x-p[1])*dx + (y-p[2])*dy)/(dx*dx+dy*dy), 0, 1)
      local cx, cy = p[1]+t*dx, p[2]+t*dy
      local d = math.sqrt((x-cx)^2 + (y-cy)^2)
      if d < best then best = d; sgn = ((dx*(y-p[2]) - dy*(x-p[1])) > 0) and 1 or -1 end
    end
    return best*sgn
  end
  local flip = (sd(refA[1], refA[2]) > 0) and -1 or 1
  -- half-width of the gradient taken from the mask: the distance to its edge on each side is unknown; use a local function supplied in line[i][3]? keep a fixed ramp from the caller
  local ramp = line.ramp or 5
  local function wB(x,y) return clamp(0.5 + sd(x,y)*flip/(2*ramp), 0, 1) end
  local piles = {}
  for _,pw in ipairs(pilesA) do piles[#piles+1] = {pw[1], function(x,y) return (1-wB(x,y))*pw[2] + 0.001 end} end
  for _,pw in ipairs(pilesB) do piles[#piles+1] = {pw[1], function(x,y) return wB(x,y)*pw[2] + 0.001 end} end
  local ang = math.atan(line[#line][2]-line[1][2], line[#line][1]-line[1][1])
  work(mask, {hand="detail", piles=piles, clip=true, coverage=3, fill=true, tool={kind="filbert", width=tool or 1.6}, angle=ang, seed=seed})
end
-- 1. B's shadow on A: far edge softened in the lower half (penumbra widening downward)
local line = {{611,312},{604,336},{596,362}}; line.ramp = 5
local m = poly({{608,312},{614,312},{603,362},{590,362}}) * visible("A") - rubbleM
softEdge3(line, {590,340}, {{cs1,1},{sC1,0.25}}, {{litW,0.63},{litWarm,0.48}}, 15601, m, 1.6)

--@ chunk 223
local m = (poly({{606,300},{622,300},{612,368},{586,368}}) + ribbon({{620,300},{612,330},{604,360},{596,396},{590,425}}, 10)) * visible("A") - rubbleM
redoA = m
for pass=1,10 do
  local rr = rag{width=6}
  rr:dip(1.0)
  rr:wipe(m, {pressure=0.95, angle=pass*0.45, passes=1, refold=0.2})
end
print(drying(610,330), drying(600,350), drying(615,320))

--@ chunk 224
for _,p in ipairs{{160,705},{175,708},{190,704},{150,710}} do print(p[1],p[2],drying(p[1],p[2]), leadM:at(p[1],p[2]), nearM:at(p[1],p[2])) end

--@ chunk 225
palette{scrape={shTop2}}
sigD = pile{{"raw umber",1},{"bone black",0.6},{"Prussian blue",0.04}, medium=0.2, name="sigD"}
local function sign(x, y, s)
  local rg = brush{kind="rigger", width=0.9, point=1}
  rg:reload(sigD, 0.35)
  rg:gesture({{x+3.2*s,y-4.2*s,0.15},{x+1.2*s,y-4.6*s,0.3},{x,y-2.6*s,0.35},{x+0.6*s,y-0.2*s,0.3},{x+2.8*s,y,0.15}}, {wobble=0.1})
  rg:reload(sigD, 0.35)
  rg:gesture({{x+5*s,y-5.2*s,0.15},{x+4.6*s,y-2.4*s,0.32},{x+4.4*s,y-0.1*s,0.35},{x+6.6*s,y+0.1*s,0.25},{x+7.6*s,y-0.4*s,0.1}}, {wobble=0.1})
  local d = brush{kind="round", width=0.9, point=0.8}
  d:reload(sigD, 0.3)
  d:touch(x+9.2*s, y-0.3*s, {pressure=0.3})
end
sign(152, 707, 1.2)

--@ chunk 226
print(wait(7*24*60))
for _,p in ipairs{{850,650},{900,660},{450,680},{320,690},{330,460},{280,450},{760,530},{740,565},{600,580},{155,705}} do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 227
palette{scrape={sigD}}
woodL = pile{{"raw umber",1},{"lead white",0.9},{"yellow ochre",0.35},{"red earth",0.08}, name="woodL"}
local function gy(x) return 296 + (x-360)*0.475 end
local mastR = ribbon({{398,316},{422,263},{445,214}}, 8.5)
local zone = rect(358,286,56,34) * mask(function(x,y) return (y < gy(x) - 0.4) and 1 or 0 end) - mastR - poly(hull, true)
-- base: the ridge's lit ice
work(zone, {hand="detail", piles={{litWarm,1},{litCool, function(x,y) return clamp((y-(gy(x)-6))/6,0,1)*0.5 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-1.1, seed=15701})
-- shadow facets continuing the ridge's right-facing slopes down to the rail
local f1 = poly({{380,284},{391,283},{388,304},{385,307},{380,305}}) * zone
local f2 = poly({{405,286},{412,294},{414,320},{405,316}}) * zone
local f3 = poly({{364,290},{368,289},{369,300},{366,299}}) * zone
work(f1 + f2 + f3, {hand="detail", piles={{sC1,1},{cs1,0.6}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.3}, angle=1.3, seed=15702})
-- the rail cap: thin, broken, same as the rest of the gunwale
local rb2 = brush{kind="round", width=1.2, point=0.8}
rb2:reload(woodL, 0.45)
rb2:stroke({{361,296.6},{372,301.8}}, {pressure={0.3,0.2}, shake=0.2})
rb2:reload(woodL, 0.4)
rb2:stroke({{377,304.3},{389,310}}, {pressure={0.28,0.18}, shake=0.2})
-- a couple of lumps of snow lodged on the rail
local hb = brush{kind="round", width=2.0, point=0.7}
for _,p in ipairs({{374,302.4,2.0},{392,310.6,2.4}}) do hb:reload(litWarm, 0.45); hb:touch(p[1], p[2], {pressure=0.4, drag={p[3],1.0}}) end

--@ chunk 228
print("no-op")

--@ chunk 229
palette{scrape={pl3, fgB2, edgeG}}
hL2 = pile{{"raw umber",2},{"bone black",0.6},{"lead white",0.35},{"red earth",0.2},{"yellow ochre",0.2}, name="hL2"}
woodD = pile{{"raw umber",2},{"bone black",1.2},{"red earth",0.12}, name="woodD"}
local hm = poly(hull, true)
local br = (ribbon({{361,326},{367,318.5},{371,310}}, 3.2) + ribbon({{362,327},{369,320},{373,311}}, 3.2)) * hm - visible("S1") - visible("S1e")
work(br, {hand="detail", piles={{hL2,1},{woodD,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.3}, angle=0.45, seed=15801})
local lumps = {
  {{366,295.5},{371,293.5},{376,296.5},{378,301.5},{374,304.5},{368,302}},
  {{383,301},{388,299},{394,303.5},{396,309.5},{390,311},{385,307}},
  {{398,307},{401,306},{403,311},{400,313.5}},
}
local lm
for _,l in ipairs(lumps) do lm = lm and (lm + poly(l)) or poly(l) end
local mastR = ribbon({{398,316},{422,263},{445,214}}, 8.5)
lm = lm - mastR
work(lm, {hand="detail", piles={{litWarm,1},{litCool,0.3}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.4}, angle=-0.6, seed=15802})
local und = poly({{368,302},{374,304.5},{378,301.5},{378,304},{373,306.5},{367,304}}) + poly({{385,307},{390,311},{396,309.5},{395,312},{389,313.5},{384,309.5}})
work(und - mastR, {hand="detail", piles={{sC1,1},{cs0,0.5}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.1}, angle=0.4, seed=15803})

--@ chunk 230
local function pp(name, t) local s={} for i,p in ipairs(t) do s[#s+1]=string.format("(%.0f,%.0f)", p[1], p[2]) end print(name, table.concat(s," ")) end
pp("wedgeOut", wedgeOut) pp("arris", arris) pp("farE", farE) pp("fgCrack", fgCrack)
print(drying(720,650), drying(740,630), drying(800,650), drying(280,460), drying(300,500))
print(edgeY and edgeY(720), edgeY(740))

--@ chunk 231
for _,p in ipairs{{725,618},{730,622},{735,620},{740,617},{745,620},{748,624},{752,626},{740,628},{735,628},{730,628},{728,632},{745,632},{750,632}} do
 local x,y=p[1],p[2]
 print(x,y, wedgeM:at(x,y), slabTopM:at(x,y), bandM2:at(x,y))
end

--@ chunk 232
-- no marks; just list shEdge to know band top
local s={} for i,p in ipairs(shEdge) do s[#s+1]=string.format("(%.0f,%.0f)", p[1], p[2]) end print(table.concat(s," "))

--@ chunk 233
for _,l in ipairs(palette()) do print(l) end

--@ chunk 234
print(palette())

--@ chunk 235
-- no marks
print(edgeY(744), edgeY(730))

--@ chunk 236
print(type(interpX), type(face), type(restateBroad))
local k = wedgeM:area()
local s = 0 for _,p in ipairs(wedgeOut) do end
print(slabTopM:at(746,631), slabTopM:at(749,633), wedgeM:at(746,631))

--@ chunk 237
palette{scrape={woodL, hL2, woodD, litW, shDeep}}
wedgeL2 = pile{{"lead white",3},{"cobalt blue",0.35},{"smalt",0.1},{"Naples yellow",0.3},{"raw umber",0.1}, name="wedgeL2"}
edgeG = pile{{"lead white",2},{"cobalt blue",0.6},{"green earth",0.45},{"Prussian blue",0.05},{"smalt",0.2}, name="edgeG"}
slabCool = pile{{"lead white",0.9},{"cobalt blue",0.5},{"smalt",0.25},{"green earth",0.35},{"raw umber",0.25},{"rose madder",0.03}, name="slabCool"}
fgB2 = pile{{"lead white",0.65},{"cobalt blue",0.42},{"smalt",0.3},{"raw umber",0.42},{"green earth",0.25},{"Naples yellow",0.14},{"red earth",0.04}, name="fgB2"}
-- new wedge outline: squared top (two straight runs), then the old outer edge and the arris
local wp = {{741,628},{750,631}}
for i=#arris,1,-1 do end
wp = {}
wp[#wp+1] = {750,631.5}
for i=2,#arris do wp[#wp+1] = {arris[i][1]+0.3, arris[i][2]} end
for i=#wedgeOut,2,-1 do wp[#wp+1] = wedgeOut[i] end
wp[#wp+1] = {741,628}
newWedgeM = poly(wp)
wedgeCut = function(x) return 649 + (x-731)*0.6 end
-- 1. paint out the knob: lit plain above the band's edge, band below
local K = poly{{731,615},{753,617},{754,626},{751,630.5},{741,627.5},{737,640},{731,638}} - newWedgeM - slabTopM
local Kp = K * above(edgeY)
local Kb = K * below(edgeY)
work(Kp, {hand="detail", pile=pl2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=0.06, seed=17001})
work(Kb, {hand="detail", pile=fgT2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=0.06, seed=17002})
print(K:area(), Kp:area(), Kb:area(), newWedgeM:area(), wedgeM:area())

--@ chunk 238
local lit = newWedgeM * above(wedgeCut)
local sh = newWedgeM * below(wedgeCut)
work(lit, {hand="detail", piles={{wedgeL2,0.5},{mB,0.3},{mA,0.2}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=-1.25, seed=17011})
local t = function(x,y) return clamp((y-650)/66,0,1) end
work(sh, {hand="detail", piles={{fgT2,0.35},{edgeG, function(x,y) return 0.3*(1-t(x,y))+0.1 end},{slabCool, function(x,y) return 0.25+0.15*t(x,y) end},{fgB2, function(x,y) return 0.25*t(x,y) end}}, clip=true, coverage=3.5, fill=true, tool={kind="filbert", width=2.5}, angle=-1.25, seed=17012})
print(lit:area(), sh:area())

--@ chunk 239
local b1 = poly{{740.2,632.5},{744,636.5},{743,641.5},{737.6,645.5},{735.5,643.2}}
local b2 = poly{{711.5,682.5},{715.5,686},{713.8,691.5},{709.5,690.5}}
work(b1, {hand="detail", pile=fgT2, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-0.4, seed=17021})
work(b2, {hand="detail", piles={{fgT2,0.6},{fgB2,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-0.4, seed=17022})

--@ chunk 240
local f = back[1]
for k,v in pairs(f) do print(k, type(v)) end
print(type(order[1])) if type(order[1])=="table" then for k,v in pairs(order[1]) do print(" ",k,type(v)) end else print(order[1]) end

--@ chunk 241
for _,f in ipairs(order) do
  local m = poly(f[1])
  local h = {}
  for _,p in ipairs{{280,460},{260,470},{300,440},{250,485},{290,480}} do if m:at(p[1],p[2])>0.5 then h[#h+1]=p[1]..","..p[2] end end
  if #h>0 then print(f[3], f[2], table.concat(h," ")) end
end

--@ chunk 242
local function pp(name, t) local s={} for i,p in ipairs(t) do s[#s+1]=string.format("(%.0f,%.0f)", p[1], p[2]) end print(name, table.concat(s," ")) end
for _,f in ipairs(order) do if f[3]=="T" or f[3]=="Q" then pp(f[3], f[1]) end end
pp("LT2", LT2) pp("LT", LT) pp("LQ1", LQ1) pp("LQ2", LQ2)
print(TfaceM:area(), Tm_:area(), LTm_:area())

--@ chunk 243
-- no marks: sample colours by probing is via probe tool; here check masks
for _,p in ipairs{{250,435},{262,446},{268,452},{246,456},{235,450},{235,470},{230,430},{275,437}} do
  print(p[1],p[2], skyM:at(p[1],p[2]), plainM:at(p[1],p[2]), iceAll:at(p[1],p[2]), TfaceM:at(p[1],p[2]), LTm_:at(p[1],p[2]), Tm_:at(p[1],p[2]))
end

--@ chunk 244
palette{scrape={wedgeL2, slabCool}}
k45b = pile{{"lead white",8},{"Naples yellow",0.45},{"cobalt blue",0.12},{"rose madder",0.05},{"raw umber",0.02}, name="k45b"}
local Tpts
for _,f in ipairs(order) do if f[3]=="T" then Tpts = f[1] end end
newTpts = {{293,424},{315,450},{305,490},{240,481},{241,466},{244,450.5},{251.5,447.5},{254,441}}
local newT = poly(newTpts)
local hidden = poly(Tpts) - visible("T")
newTM = newT - hidden - rubbleM - talusM - keepM
topS = {{293,424},{254,441},{255.5,447},{291.5,426.4}}
tierTop = {{251.5,447.5},{244,450.5},{244.6,453.2},{252,450.2}}
local faceM = newTM - poly(topS) - poly(tierTop)
print(newTM:area(), faceM:area(), hidden:area())
local function ty(y) return clamp((y-430)/60,0,1) end
restateBroad(faceM, {{cs0, function(x,y) return 0.55 end},{sC1, function(x,y) return clamp(1-(y-432)/30,0,1)*0.55 end},{cs1, function(x,y) return clamp((y-455)/30,0,1)*0.35 + clamp(1-(x-241)/14,0,1)*0.3 end},{bounceW, function(x,y) return clamp((y-466)/22,0,1)*0.8 end}}, 1.2, "filbert 6", 18001)

--@ chunk 245
local tS = poly(topS)
work(tS, {hand="detail", piles={{litWarm, function(x,y) return clamp(1-(x-262)/22,0,1)+0.05 end},{litCool, function(x,y) return clamp((x-262)/18,0,1)*0.6 end},{mB, function(x,y) return clamp((x-276)/14,0,1)*0.9 end},{mA, function(x,y) return clamp((x-284)/8,0,1)*0.8 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2}, angle=-0.41, seed=18011})
work(poly(tierTop), {hand="detail", piles={{mA,1},{mB,0.4}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-0.38, seed=18012})
-- the sliver of the old rim above the new straight top: sky
local topLine = function(x) return 424 + (293-x)*(17/39) - 0.3 end
local sliver = (poly(LT2):grow(1.5) + poly(Tpts or {{0,0},{1,0},{1,1}})) * above(topLine) * rect(250,418,42,23) * above(function(x) return 441 end)
print(sliver:area())
work(sliver, {hand="detail", pile=k45b, clip=true, coverage=3, fill=true, tool={kind="filbert", width=1.6}, angle=-0.41, seed=18013})

--@ chunk 246
local faceM = newTM - poly(topS) - poly(tierTop)
local leftM = faceM * rect(238,440,24,52)
work(leftM, {hand="detail", piles={{cs0, function(x,y) return 0.55 end},{sC1, function(x,y) return clamp(1-(y-432)/30,0,1)*0.55 end},{cs1, function(x,y) return clamp((y-455)/30,0,1)*0.35 + clamp(1-(x-241)/14,0,1)*0.3 end},{bounceW, function(x,y) return clamp((y-466)/22,0,1)*0.8 end}}, clip=true, coverage=3, fill=true, tool={kind="filbert", width=2.5}, angle=1.25, seed=18021})

--@ chunk 247
for i,p in ipairs(plates) do
  local s = {}
  for k,v in pairs(p) do if type(v)~="table" and type(v)~="function" and type(v)~="userdata" then s[#s+1]=k.."="..tostring(v) end end
  print(i, table.concat(s," "))
end

--@ chunk 248
local function pp(name, t) local s={} for i,p in ipairs(t) do s[#s+1]=string.format("(%.1f,%.1f)", p[1], p[2]) end print(name, table.concat(s," ")) end
for _,i in ipairs{2,3,5,6,7} do
  local p = plates[i]
  local top, front, rightF, shadow = plateShapes(p[1],p[2],p[3],p[4],p[5],p[6],p[7], 7000+i*5)
  print("plate", i, p[1], p[2]) pp(" top", top) pp(" front", front) pp(" right", rightF) pp(" shadow", shadow)
end

--@ chunk 249
local p3, p6 = plates[3], plates[6]
local t3, f3, r3, s3 = plateShapes(p3[1],p3[2],p3[3],p3[4],p3[5],p3[6],p3[7], 7015)
local t6, f6, r6, s6 = plateShapes(p6[1],p6[2],p6[3],p6[4],p6[5],p6[6],p6[7], 7030)
local p2 = plates[2]
local t2, f2, r2, s2 = plateShapes(p2[1],p2[2],p2[3],p2[4],p2[5],p2[6],p2[7], 7010)
local protect = newTM + poly(t2) + poly(f2) + poly(r2) + keepM + leadM
local drift3 = poly{{281.5,497.6},{286,495.6},{291,494.6},{297,495.4},{302,494.0},{307,493.4},{313.5,493.2},{323,494.5},{318,504},{296,503.5},{281.5,503.2}}
local drift6 = poly{{309.5,506.8},{314,505.6},{319,505.9},{324,505.0},{328,505.3},{337,507},{333.5,512},{318,511},{309.5,509.5}}
local cover = (drift3 + poly(s3) + poly(r3) + drift6 + poly(s6) + poly(r6)) - protect
print(cover:area())
work(cover, {hand="detail", piles={{pl2,1},{pl3,0.25}}, clip=true, coverage=3.5, fill=true, tool={kind="filbert", width=1.8}, angle=-0.05, seed=18101})

--@ chunk 250
local function pp(name, t, step) local s={} for i=1,#t,step do local p=t[i] s[#s+1]=string.format("(%.0f,%.1f)", p[1], p[2]) end print(name, table.concat(s," ")) end
pp("bankTop", bankTop, 6) pp("bankBot", bankBot, 6)
print(wallM:area(), wallKeep:area(), wallBand:area())

--@ chunk 251
print(palette())

--@ chunk 252
local function bt(x) -- bankTop y at x
  for j=1,#bankTop-1 do local a,b = bankTop[j], bankTop[j+1]; if x>=a[1] and x<=b[1] then return lerp(a[2], b[2], (x-a[1])/math.max(1e-6,b[1]-a[1])) end end
  return bankTop[#bankTop][2]
end
bankTopY = bt
local function hh(x) return lerp(6, 2.2, x/480) end
-- 1. gap: snow straight down to the water, x 150..196 with broken (slanting) ends
local gp = {}
local x0, x1 = 150, 196
gp[#gp+1] = {x0-2, bt(x0-2)-1.2}
for x = x0, x1, 2 do gp[#gp+1] = {x, bt(x)-1.0} end
gp[#gp+1] = {x1+3, bt(x1+3)-1.0}
gp[#gp+1] = {x1+1, bt(x1)+hh(x1)+1.3}
for x = x1, x0, -2 do gp[#gp+1] = {x, bt(x)+hh(x)+1.3 + (x>165 and x<180 and 0.6 or 0)} end
gp[#gp+1] = {x0+2, bt(x0)+hh(x0)+1.3}
gapM = poly(gp)
work(gapM, {hand="detail", piles={{pl2,1},{mB,0.3},{cs1,0.08}}, clip=true, coverage=3.5, fill=true, tool={kind="filbert", width=1.6}, angle=-0.14, seed=18201})
print(gapM:area())

--@ chunk 253
local bt = bankTopY
local function hh(x) return lerp(6, 2.2, x/480) end
-- tall wall: x 292..338, wall foot pushed down to ~2.3h, with an irregular foot
local tp = {}
local x0, x1 = 292, 338
for x = x0, x1, 2 do tp[#tp+1] = {x, bt(x)+hh(x)-0.4} end
local function extra(x) local t = (x-x0)/(x1-x0); return hh(x)*1.4*math.sin(math.pi*clamp(t*1.25,0,1))^0.6 * (t>0.8 and clamp((1-t)/0.2,0,1) or 1) end
for x = x1, x0, -2 do tp[#tp+1] = {x, bt(x)+hh(x)+extra(x) + ((x%6==0) and 0.4 or 0)} end
tallM = poly(tp)
work(tallM, {hand="detail", piles={{mA,1},{edgeG,0.7},{sC1, function(x,y) return 0.3 + clamp((y-bt(x)-hh(x))/4,0,1)*0.5 end}}, clip=true, coverage=3.5, fill=true, tool={kind="filbert", width=1.5}, angle=1.45, seed=18211})
-- strata in it: two short lines
local rgS = brush{kind="rigger", width=0.8, point=1}
rgS:reload(sC1, 0.35)
rgS:stroke({{298, bt(298)+hh(298)+1.6}, {312, bt(312)+hh(312)+1.9}, {322, bt(322)+hh(322)+1.7}}, {pressure={0.2,0.12}})
-- waterline at the new foot
local rgD = brush{kind="rigger", width=1.0, point=1}
rgD:reload(sDeepG, 0.45)
local wl = {}
for x = x0+1, x1-2, 3 do wl[#wl+1] = {x, bt(x)+hh(x)+extra(x)+0.2} end
rgD:stroke(wl, {pressure={0.3,0.18}, shake=0.2})
print(tallM:area())

--@ chunk 254
for y=576,592,1 do local s={} for _,x in ipairs{155,170,185} do s[#s+1]=string.format("%d:g%.2f l%.2f w%.2f", x, gapM:at(x,y), leadM:at(x,y), wallM:at(x,y)) end print(y, table.concat(s,"  ")) end
print(bankTopY(170), lerp(6,2.2,170/480))

--@ chunk 255
print("no marks")

--@ chunk 256
for pass=1,6 do
  local rr = rag{width=6}
  rr:dip(1.0)
  rr:wipe(gapM, {pressure=0.95, angle=-0.14 + pass*0.5, passes=1})
end
print(drying(172,586))

--@ chunk 257
for pass=1,6 do
  local rr = rag{width=6}
  rr:dip(1.0)
  rr:wipe(gapM, {pressure=0.95, angle=0.3 + pass*0.6, passes=1, refold=0.4})
end
local k = knife{width=8}
for _,y in ipairs{0} do end
print(drying(172,586))

--@ chunk 258
local k = knife{width=7}
local bt = bankTopY
for i=0,2 do
  local pts = {}
  for x=148,198,5 do pts[#pts+1] = {x, bt(x) + 1.5 + i*2.2} end
  k:scrape(pts, {pressure=1.0, angle=1.45})
  k:wipe()
end
print(drying(172,586))

--@ chunk 259
work(gapM, {hand="detail", piles={{fgT2,1},{cs1,0.25},{edgeG,0.08}}, clip=true, coverage=3.5, fill=true, tool={kind="filbert", width=1.6}, angle=-0.14, seed=18221})

--@ chunk 260
print(wait(7*24*60))
print(drying(720,670), drying(270,460), drying(172,586), drying(310,580))

--@ chunk 261
print(bankTopY(60), bankTopY(10), bankTopY(120), bankTopY(4))
for y=592,606 do print(y, string.format("%.2f %.2f", wallM:at(65,y), leadM:at(65,y))) end

--@ chunk 262
local bt = bankTopY
local function hh(x) return lerp(6, 2.2, x/480) end
local up, dn = {}, {}
for x = -2, 152, 2 do
  local xx = math.max(0, x)
  up[#up+1] = {x, bt(xx) - 1.6}
  dn[#dn+1] = {x, bt(xx) + hh(xx) - 0.25}
end
local pts = {}
for _,p in ipairs(up) do pts[#pts+1] = p end
for i=#dn,1,-1 do pts[#pts+1] = dn[i] end
leftBankM = poly(pts) - gapM
local function tf(x,y) return clamp((y - bt(math.max(0,x))) / hh(math.max(0,x)), 0, 1) end
work(leftBankM, {hand="detail", piles={{fgT2,1},{cs1, function(x,y) return 0.3*(1-tf(x,y)) end},{edgeG, function(x,y) return 0.06 + 0.2*tf(x,y) end}}, clip=true, coverage=4, fill=true, tool={kind="filbert", width=1.6}, angle=-0.14, seed=18301})
print(leftBankM:area())

--@ chunk 263
print(wait(6*24*60)) print(drying(65,600))
