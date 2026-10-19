-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box cezanne
--@ engine 5

--@ chunk 1
canvas{size=730, aspect=1.25, linen={18,16}, seed=1906,
  ground={{pile={{"lead white",10},{"yellow ochre",0.25}}, um=120, apply="knife", texture=0.3}}}
print(W,H)
print(table.concat(tubes(), ", "))

--@ chunk 2
draw = pile{{"ultramarine blue",1},{"lead white",0.3}, turps=0.7, name="draw"}
db = brush{kind="round", width=4, point=0.4}
print(db:mark_width(0.5), db:mark_width(0.8))

--@ chunk 3
local function L(pts, p, wob)
  local q = {}
  for i=1,#pts,2 do q[#q+1] = {pts[i], pts[i+1], p or 0.6} end
  db:gesture(q, {wobble=wob or 2})
  if db:fullness() < 0.35 then db:load(draw, 0.8) end
end
db:load(draw, 0.8)
-- mountain
L({330,335, 420,302, 520,252, 600,192, 650,168, 700,186, 760,214, 820,232, 900,262, 1000,286}, 0.65)
-- mountain inner planes
L({650,170, 640,230, 610,300, 600,338}, 0.45)
L({760,216, 745,270, 760,335}, 0.45)
-- plain lines
L({300,345, 600,342, 1000,338}, 0.5)
L({330,385, 600,392, 860,382, 1000,378}, 0.4)
L({600,420, 900,408, 1000,412}, 0.4)
-- road
L({600,800, 565,700, 542,625, 515,568}, 0.65)
L({800,800, 700,705, 612,622, 548,568}, 0.65)
-- ridge under village
L({380,560, 480,548, 560,560, 700,548, 860,540, 1000,520}, 0.5)
-- houses
L({420,530, 420,455, 500,455, 500,530, 420,530}, 0.6)
L({500,455, 530,445, 530,520, 500,530}, 0.6)
L({415,456, 445,436, 528,436, 535,446}, 0.6)
L({535,522, 535,420, 590,420, 590,520}, 0.6)
L({532,421, 560,400, 594,420}, 0.6)
L({600,540, 600,465, 700,465, 700,540}, 0.6)
L({596,466, 615,446, 700,446, 708,465}, 0.6)
L({710,512, 710,440, 770,440, 770,512}, 0.6)
L({706,441, 738,424, 774,441}, 0.6)
L({780,530, 780,472, 860,472, 860,530}, 0.6)
L({776,473, 800,457, 860,457, 866,472}, 0.6)
L({900,425, 900,402, 940,402, 940,425}, 0.45)
-- pines
L({118,800, 128,600, 140,400, 152,200, 165,0}, 0.8, 3)
L({144,800, 152,600, 162,400, 172,200, 184,0}, 0.8, 3)
L({245,800, 252,600, 262,420, 272,300, 284,180}, 0.7, 3)
L({262,800, 268,600, 276,420, 285,300, 294,180}, 0.7, 3)
L({168,110, 230,95, 300,90, 380,108, 470,140}, 0.55, 4)
L({290,230, 360,214, 440,238}, 0.5, 4)
L({150,260, 90,240, 30,250}, 0.5, 4)

--@ chunk 4
mtnTop = {{0,322},{150,312},{300,332},{330,335},{420,302},{520,252},{600,192},{650,168},{700,186},{760,214},{820,232},{900,262},{1000,286}}
skyM = above(mtnTop)
local mp = {}
for i,p in ipairs(mtnTop) do mp[#mp+1] = p end
mp[#mp+1] = {1000,346}; mp[#mp+1] = {0,346}
mtnM = poly(mp)
ridge = {{0,575},{200,568},{380,560},{480,548},{560,560},{700,548},{860,540},{1000,520}}
plainM = below({{0,343},{600,341},{1000,337}}) * above(ridge)
roadM = poly({{600,800},{565,700},{542,625},{515,568},{530,560},{548,568},{612,622},{700,705},{800,800}}, true)
fgM = below(ridge) - roadM
print(skyM:area(), mtnM:area(), plainM:area(), roadM:area(), fgM:area())

--@ chunk 5
wMtn = pile{{"lead white",2},{"cobalt blue",1},{"rose madder",0.3}, turps=0.8, name="wMtn"}
wGreen = pile{{"viridian",1},{"ultramarine blue",0.4},{"yellow ochre",0.4},{"lead white",0.6}, turps=0.82, name="wGreen"}
wEarth = pile{{"yellow ochre",1.5},{"lead white",1},{"red earth",0.2}, turps=0.8, name="wEarth"}
local T = {kind="flat", width=16}
work(mtnM, {hand="body", pile=wMtn, tool=T, length={40,80}, angle=-0.6, coverage=0.8, clip=true})
work(plainM, {hand="body", piles={{wEarth,1},{wGreen,function(x,y) return 0.6+0.5*math.sin(x/70)*math.cos(y/40) end}}, tool=T, length={40,90}, angle=0.05, coverage=0.7, clip=true})
work(fgM, {hand="body", piles={{wGreen,function(x,y) return x<520 and 1.2 or 0.4 end},{wEarth,function(x,y) return x<520 and 0.3 or 1 end}}, tool=T, length={50,100}, angle=-0.8, coverage=0.75, clip=true})
work(roadM, {hand="body", pile=wEarth, tool=T, length={40,80}, angle=-1.0, coverage=0.6, clip=true})

--@ chunk 6
canopy = (ellipse(250,30,280,75) + ellipse(430,112,95,32) + ellipse(335,222,95,28) + ellipse(60,255,95,45) + ellipse(70,130,110,70) + ellipse(510,55,55,40) + ellipse(200,140,80,40)):roughen(14, 60, 3)
skyOpen = skyM - canopy:grow(4)
skyA = pile{{"lead white",5},{"cobalt blue",1.6},{"ultramarine blue",0.4}, name="skyA"}
skyB = pile{{"lead white",7},{"cobalt blue",1},{"emerald green",0.25},{"yellow ochre",0.1}, name="skyB"}
skyC = pile{{"lead white",7},{"cobalt blue",0.6},{"rose madder",0.15},{"yellow ochre",0.15}, name="skyC"}
local n = noise{seed=11, period=160}
work(skyOpen, {hand="hatch", tool={kind="flat", width=12}, length={30,50}, angle=function(x,y) return -0.85 + 0.25*n(x,y) end, angle_jitter=0.08, curve={0.05,0},
  piles={{skyA, function(x,y) return clamp(1.3 - y/250,0,1) end},{skyB, function(x,y) return 0.5+0.4*n(x+300,y) end},{skyC, function(x,y) return clamp((y-180)/150,0,1) end}},
  coverage=1.4, clump=0.3, edge="soft"})

--@ chunk 7
mA = poly({{300,346},{330,335},{420,302},{520,252},{600,192},{650,168},{640,230},{610,300},{600,346}}) 
mB = poly({{600,346},{610,300},{640,230},{650,168},{700,186},{760,214},{745,270},{760,346}})
mC = poly({{760,346},{745,270},{760,214},{820,232},{900,262},{1000,286},{1000,346}})
mtLit = pile{{"lead white",6},{"yellow ochre",0.6},{"rose madder",0.35},{"cobalt blue",0.25}, name="mtLit"}
mtShd = pile{{"lead white",4},{"cobalt blue",1.2},{"rose madder",0.45},{"ultramarine blue",0.3}, name="mtShd"}
mtMid = pile{{"lead white",5},{"cobalt blue",0.8},{"yellow ochre",0.25},{"rose madder",0.2},{"emerald green",0.1}, name="mtMid"}
local T = {kind="flat", width=10}
local base = {hand="hatch", tool=T, length={24,40}, angle_jitter=0.1, curve={0.04,0}, coverage=1.5, edge="firm"}
local function W(m, o) local t = {} for k,v in pairs(base) do t[k]=v end for k,v in pairs(o) do t[k]=v end work(m, t) end
W(mA, {piles={{mtLit,1},{mtMid,0.35}}, angle=-0.55})
W(mB, {piles={{mtShd,1},{mtMid,0.3}}, angle=-1.25})
W(mC, {piles={{mtMid,1},{mtShd,0.3},{mtLit,0.2}}, angle=-0.35})

--@ chunk 8
fGold = pile{{"yellow ochre",3},{"lead white",2},{"chrome yellow",0.4},{"vermilion",0.15}, name="fGold"}
fPale = pile{{"lead white",3},{"emerald green",1},{"yellow ochre",1},{"cobalt blue",0.3}, name="fPale"}
fGreen = pile{{"emerald green",2},{"viridian",0.6},{"chrome yellow",0.5},{"lead white",1},{"yellow ochre",0.5}, name="fGreen"}
fPink = pile{{"lead white",3},{"red earth",0.5},{"yellow ochre",0.8},{"vermilion",0.15}, name="fPink"}
local c = worley{seed=5, period=90}
local function cell(x,y) return c:at(x*0.55, y*1.6) end
local function pick(k) return function(x,y) local _,_,_,id = cell(x,y); local i = math.floor(id*4); return i==k and 1 or 0.04 end end
work(plainM, {hand="hatch", tool={kind="flat", width=9}, length={22,40}, angle=function(x,y) return -0.15 + 0.3*math.sin(x/90+y/40) end, angle_jitter=0.12,
  piles={{fGold,pick(0)},{fPale,pick(1)},{fGreen,pick(2)},{fPink,pick(3)}},
  scale_at=function(x,y) return lerp(0.55,1.0,(y-343)/210) end, coverage=1.4, edge="firm"})

--@ chunk 9
wallLit = pile{{"lead white",5},{"yellow ochre",1},{"vermilion",0.08}, name="wallLit"}
wallWarm = pile{{"lead white",3},{"yellow ochre",1.6},{"red earth",0.2}, name="wallWarm"}
wallShd = pile{{"lead white",3},{"cobalt blue",0.9},{"rose madder",0.3},{"yellow ochre",0.4}, name="wallShd"}
roofLit = pile{{"vermilion",1},{"red earth",1},{"yellow ochre",0.6},{"lead white",0.6}, name="roofLit"}
roofShd = pile{{"red earth",1.5},{"rose madder",0.6},{"ultramarine blue",0.3},{"lead white",0.3}, name="roofShd"}
houses = {
 {wall={{640,426},{700,426},{700,450},{640,450}}, roof={{636,427},{660,412},{704,427}}, tone=wallWarm},
 {wall={{470,420},{535,420},{535,440},{470,440}}, roof={{466,421},{490,408},{538,408},{538,421}}, tone=wallLit},
 {wall={{900,402},{940,402},{940,425},{900,425}}, roof={{897,403},{920,394},{943,403}}, tone=wallLit},
 {wall={{535,420},{590,420},{590,522},{535,522}}, roof={{530,421},{562,402},{595,421}}, tone=wallLit},
 {wall={{710,440},{770,440},{770,512},{710,512}}, roof={{706,441},{738,424},{774,441}}, tone=wallWarm},
 {wall={{420,458},{500,458},{500,530},{420,530}}, side={{500,458},{530,447},{530,520},{500,530}}, roof={{414,459},{444,437},{532,437},{536,447},{502,459}}, tone=wallLit},
 {wall={{600,466},{700,466},{700,540},{600,540}}, roof={{596,467},{616,447},{700,447},{708,467}}, tone=wallWarm},
 {wall={{780,472},{860,472},{860,530},{780,530}}, side={{860,472},{880,466},{880,525},{860,530}}, roof={{776,473},{800,458},{860,458},{884,466},{866,473}}, tone=wallLit},
 {wall={{370,502},{420,502},{420,545},{370,545}}, roof={{365,503},{390,489},{424,489},{424,503}}, tone=wallWarm},
}
local T = {kind="flat", width=6}
for i,h in ipairs(houses) do
  local wm = poly(h.wall)
  work(wm, {hand="hatch", tool=T, piles={{h.tone,1},{wallLit,0.3}}, length={10,18}, angle=-1.5, angle_jitter=0.08, coverage=1.6, clip=true})
  if h.side then work(poly(h.side), {hand="hatch", tool=T, piles={{wallShd,1},{wallWarm,0.15}}, length={10,16}, angle=-1.45, angle_jitter=0.1, coverage=1.6, clip=true}) end
  work(poly(h.roof), {hand="hatch", tool=T, piles={{roofLit,1},{roofShd,0.25}}, length={10,18}, angle=-0.25, angle_jitter=0.12, coverage=1.6, clip=true})
end

--@ chunk 10
gDark = pile{{"viridian",2},{"ultramarine blue",1},{"bone black",0.15},{"yellow ochre",0.5},{"lead white",0.3}, name="gDark"}
gMid = pile{{"viridian",1},{"emerald green",1},{"yellow ochre",1},{"lead white",0.8}, name="gMid"}
gYel = pile{{"emerald green",1},{"chrome yellow",0.5},{"yellow ochre",1.2},{"lead white",1}, name="gYel"}
earth = pile{{"yellow ochre",2},{"red earth",0.45},{"lead white",1.5}, name="earth"}
local n = noise{seed=21, period=140}
local n2 = noise{seed=22, period=90}
local left = fgM * mask(function(x,y) return x < 560 and 1 or 0 end)
local right = fgM - left
work(left, {hand="hatch", tool={kind="flat", width=13}, length={32,58}, angle=function(x,y) return -1.0 + 0.5*n(x,y) end, angle_jitter=0.1, curve={0.06,0},
  piles={{gDark,function(x,y) return 0.8+0.6*n2(x,y) end},{gMid,function(x,y) return 0.6-0.4*n2(x,y) end},{earth,function(x,y) return clamp(0.5*n(x+400,y)+0.05,0,1) end}},
  scale_at=function(x,y) return lerp(0.7,1.15,(y-560)/240) end, coverage=1.5, edge="soft"})
work(right, {hand="hatch", tool={kind="flat", width=13}, length={30,55}, angle=function(x,y) return -0.5 + 0.4*n(x,y) end, angle_jitter=0.1, curve={0.06,0},
  piles={{gYel,function(x,y) return 0.6+0.4*n2(x,y) end},{earth,function(x,y) return 0.6-0.4*n2(x,y) end},{gMid,0.3},{gDark,function(x,y) return clamp(n(x,y+300),0,1)*0.8 end}},
  scale_at=function(x,y) return lerp(0.7,1.15,(y-540)/260) end, coverage=1.5, edge="soft"})

--@ chunk 11
road = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.2},{"rose madder",0.1}, name="road"}
roadShd = pile{{"lead white",3},{"cobalt blue",0.6},{"rose madder",0.3},{"yellow ochre",0.5}, name="roadShd"}
work(roadM, {hand="hatch", tool={kind="flat", width=11}, length={25,45}, angle=function(x,y) return -1.15 + (x-600)/600 end, angle_jitter=0.1,
  piles={{road,1},{roadShd,function(x,y) local t=(x-540)/(260*(y-560)/240+20); return clamp(0.8-t,0,1)*0.6 end}},
  scale_at=function(x,y) return lerp(0.55,1.1,(y-560)/240) end, coverage=1.6, edge="firm"})

--@ chunk 12
trLit = pile{{"red earth",1},{"yellow ochre",1.2},{"lead white",1.2},{"vermilion",0.15}, name="trLit"}
trShd = pile{{"ultramarine blue",1},{"red earth",1},{"rose madder",0.4},{"lead white",0.3}, name="trShd"}
function cxAt(pts, y)
  for i=1,#pts-1 do local a,b=pts[i],pts[i+1]
    if (y<=a[2] and y>=b[2]) then local t=(a[2]-y)/(a[2]-b[2]); return lerp(a[1],b[1],t), lerp(a[3],b[3],t) end end
  return pts[#pts][1], pts[#pts][3]
end
t1 = {{131,805,26},{140,600,23},{151,400,20},{162,200,17},{175,-5,15}}
t2 = {{253,805,17},{260,600,15},{269,420,13},{278,300,11},{289,175,9}}
function trunkMask(t) local pts, ws = {}, {} for i,p in ipairs(t) do pts[#pts+1]={p[1],p[2]}; ws[#ws+1]=p[3] end return ribbon(pts, ws) end
trunk1M = trunkMask(t1); trunk2M = trunkMask(t2)
for _,t in ipairs({t1,t2}) do
  local m = trunkMask(t)
  work(m, {hand="hatch", tool={kind="flat", width=6}, length={14,26}, angle=-1.45, angle_jitter=0.1, clip=true, coverage=2,
    piles={{trLit,function(x,y) local cx,w=cxAt(t,y); return clamp(0.6-(x-cx)/w*1.6,0,1) end},{trShd,function(x,y) local cx,w=cxAt(t,y); return clamp(0.2+(x-cx)/w*2.0,0,1) end}}})
end

--@ chunk 13
cDark = pile{{"viridian",2},{"ultramarine blue",1.2},{"bone black",0.2},{"emerald green",0.3},{"lead white",0.25}, name="cDark"}
cMid = pile{{"viridian",1.2},{"emerald green",1},{"cobalt blue",0.4},{"yellow ochre",0.4},{"lead white",0.7}, name="cMid"}
cLit = pile{{"emerald green",1},{"yellow ochre",0.8},{"chrome yellow",0.25},{"lead white",1.2},{"viridian",0.3}, name="cLit"}
-- branches first
bb = brush{kind="round", width=7, point=0.5}
local function br(pts) bb:load(trShd, 0.8); bb:gesture(pts, {wobble=2}) end
br({{165,112,0.9},{230,98,0.7},{300,92,0.6},{380,108,0.5},{470,140,0.2}})
br({{282,232,0.8},{360,214,0.6},{440,238,0.2}})
br({{150,262,0.8},{90,242,0.6},{30,252,0.2}})
br({{170,60,0.8},{120,40,0.5},{60,30,0.2}})
br({{286,190,0.7},{320,150,0.5},{350,128,0.2}})
local n = noise{seed=31, period=70}
work(canopy, {hand="hatch", tool={kind="flat", width=10}, length={22,40}, angle=function(x,y) return -0.7 + 0.5*n(x,y) end, angle_jitter=0.12, curve={0.05,0},
  piles={{cDark,function(x,y) return 0.7 + 0.5*n(x+200,y) end},{cMid,0.6},{cLit,function(x,y) return clamp(-0.2 - 0.9*n(x+200,y) ,0,1) end}},
  coverage=1.3, clump=0.4, edge={found=0.3, soft=0.5, lost=0.2, period=50}})

--@ chunk 14
print(wait(3*24*60))
for _,p in ipairs({{600,100},{500,250},{700,300},{300,450},{450,500},{300,700},{800,700},{650,700},{300,150}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 15
print(wait(4*24*60))
for _,p in ipairs({{600,100},{500,250},{700,300},{300,450},{450,500},{300,700},{800,700},{650,700},{300,150}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 16
housesM = nil
for _,h in ipairs(houses) do
  local m = poly(h.wall) + poly(h.roof)
  if h.side then m = m + poly(h.side) end
  housesM = housesM and (housesM + m) or m
end
treeBack = (ellipse(615,425,28,30) + ellipse(590,440,20,18) + ellipse(790,452,26,20) + ellipse(885,450,28,18) + ellipse(455,412,30,16) + ellipse(400,470,40,32) + ellipse(350,490,30,24) + ellipse(705,425,14,18) + ellipse(945,415,40,14) + ellipse(860,445,22,16)):roughen(6,25,7) 
cyp = poly({{612,470},{606,440},{608,410},{614,385},{619,410},{622,440},{620,470}}, true)
treeBack = treeBack + cyp
ridgeBush = (ellipse(420,555,70,18) + ellipse(560,560,40,14) + ellipse(680,552,70,15) + ellipse(820,545,80,16) + ellipse(950,532,70,16) + ellipse(300,565,70,14)):roughen(6,30,8)
hedges = (ribbon({{0,392},{200,390},{420,392}}, 6) + ribbon({{620,404},{800,398},{1000,394}}, 5) + ribbon({{0,440},{150,436},{330,442}}, 8) + ribbon({{0,488},{120,482},{300,486}}, 10) + ribbon({{860,438},{1000,432}}, 7) + ribbon({{350,360},{600,358}}, 4) + ribbon({{720,365},{1000,362}}, 4)):roughen(4,20,9)
local midDark = (treeBack + ridgeBush + hedges) - housesM
local n = noise{seed=41, period=40}
work(midDark, {hand="hatch", tool={kind="flat", width=5}, length={8,15}, angle=function(x,y) return -1.3 + 0.4*n(x,y) end, angle_jitter=0.15,
  piles={{cDark,1},{cMid,function(x,y) return 0.5+0.4*n(x+100,y) end},{gDark,0.5}},
  scale_at=function(x,y) return lerp(0.7,1.1,(y-350)/220) end, coverage=1.8, edge="soft"})

--@ chunk 17
r = rag{width=14}
r:wipe(hedges:grow(3), {pressure=0.6, angle=0, passes=2, refold=0.3})
print(r)

--@ chunk 18
r = rag{width=16}
r:dip(0.6)
local hm = (ribbon({{0,392},{200,390},{420,392}}, 10) + ribbon({{0,440},{150,436},{330,442}}, 12) + ribbon({{0,488},{120,482},{300,486}}, 14))
r:wipe(hm, {pressure=0.7, angle=0, passes=3, refold=0.4})
print(r)

--@ chunk 19
k = knife{width=16}
local lines = {
 {{0,392},{200,390},{420,392}},
 {{0,440},{150,436},{330,442}},
 {{0,488},{120,482},{300,486}},
}
for _,l in ipairs(lines) do
  k:scrape(l, {pressure=0.95, angle=math.pi/2})
  k:wipe()
end

--@ chunk 20
local hm = hedges:grow(3)
local n = noise{seed=51, period=60}
work(hm, {hand="hatch", tool={kind="flat", width=6}, length={10,20}, angle=function(x,y) return -0.1+0.3*n(x,y) end, angle_jitter=0.15,
  piles={{fGreen,0.6},{cMid,0.8},{fGold,function(x,y) return clamp(0.4+0.6*n(x+50,y),0,1) end},{fPale,0.4}}, coverage=1.0, clip=true})
-- lit sides of village trees and ridge bushes
local lit = (treeBack + ridgeBush) - housesM
work(lit * mask(function(x,y) return 1 end), {hand="hatch", tool={kind="flat", width=5}, length={7,13}, angle=-1.0, angle_jitter=0.2,
  piles={{cLit,1},{cMid,0.7},{gYel,0.3}}, coverage=0.55, clip=true, load=0.5,
  scale_at=function(x,y) return lerp(0.7,1.1,(y-350)/220) end})

--@ chunk 21
skyD = pile{{"lead white",4},{"cobalt blue",2},{"ultramarine blue",0.5},{"emerald green",0.1}, name="skyD"}
skyE = pile{{"lead white",6},{"cobalt blue",1.2},{"viridian",0.3},{"yellow ochre",0.1}, name="skyE"}
local n = noise{seed=61, period=180}
local n2 = noise{seed=62, period=120}
local sk = skyOpen - mtnM:grow(2)
work(sk, {hand="hatch", tool={kind="flat", width=12}, length={28,46}, angle=function(x,y) return -1.0 + 0.35*n(x,y) end, angle_jitter=0.1, curve={0.04,0},
  piles={{skyD, function(x,y) return clamp(1.1 - y/260 + 0.3*n2(x,y),0,1.2) end},{skyE, function(x,y) return 0.5+0.4*n2(x+300,y) end},{skyC, function(x,y) return clamp((y-170)/160,0,1)*0.9 end},{skyB,0.3}},
  coverage=1.3, fill=true, clump=0.3, edge="firm", pressure={0.5,0.8}})

--@ chunk 22
print(wait(3*24*60))
print(drying(500,100), drying(300,420), drying(400,555))

--@ chunk 23
trMid = pile{{"red earth",1},{"yellow ochre",0.5},{"ultramarine blue",0.3},{"lead white",0.6}, name="trMid"}
trDk = pile{{"ultramarine blue",1},{"red earth",0.8},{"rose madder",0.4},{"bone black",0.1},{"lead white",0.2}, name="trDk"}
t1 = {{128,805,27},{136,640,24},{146,470,21},{156,330,18},{166,210,16},{178,100,14},{190,-5,12}}
t2 = {{250,805,18},{256,640,16},{264,480,14},{272,350,12},{280,260,10},{294,180,8}}
for _,t in ipairs({t1,t2}) do
  local m = trunkMask(t)
  work(m, {hand="hatch", tool={kind="flat", width=5}, length={12,24}, angle=-1.5, angle_jitter=0.12, clip=true, coverage=2.2,
    piles={{trLit,function(x,y) local cx,w=cxAt(t,y); return clamp(0.7-(x-cx)/w*1.8,0,1) end},
           {trMid,function(x,y) local cx,w=cxAt(t,y); return clamp(0.7-math.abs((x-cx)/w)*2,0,1) end},
           {trDk,function(x,y) local cx,w=cxAt(t,y); return clamp(0.1+(x-cx)/w*2.2,0,1) end}}})
end

--@ chunk 24
clusters = {
 {250,30,280,75},{430,112,95,32},{335,222,95,28},{60,255,95,45},{70,130,110,70},{510,55,55,40},{200,140,80,40}}
local function rel(x,y)
  local best, bv = nil, 1e9
  for _,c in ipairs(clusters) do local d = ((x-c[1])/c[3])^2 + ((y-c[2])/c[4])^2; if d < bv then bv, best = d, c end end
  return (y-best[2])/best[4], (x-best[1])/best[3]
end
cBlue = pile{{"ultramarine blue",1},{"viridian",1},{"lead white",0.8},{"cobalt blue",0.4}, name="cBlue"}
cOlive = pile{{"viridian",0.6},{"emerald green",0.6},{"yellow ochre",1.2},{"red earth",0.15},{"lead white",0.5}, name="cOlive"}
local n = noise{seed=71, period=50}
work(canopy, {hand="hatch", tool={kind="flat", width=9}, length={18,34}, angle=function(x,y) return -0.6 + 0.6*n(x,y) end, angle_jitter=0.15, curve={0.05,0},
  piles={{cDark,function(x,y) local v=rel(x,y); return clamp(0.4+v,0,1.2) end},
         {cBlue,function(x,y) return clamp(0.4+0.6*n(x+90,y),0,1) end},
         {cOlive,function(x,y) return clamp(0.5+0.6*n(x,y+70),0,1)*0.8 end},
         {cLit,function(x,y) local v,u=rel(x,y); return clamp(-0.1-v-0.4*u,0,1.2) end}},
  coverage=1.5, fill=true, clump=0.4, edge={found=0.35, soft=0.45, lost=0.2, period=40}})

--@ chunk 25
for _,p in ipairs({{300,700},{450,650},{800,700},{650,700},{100,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 26
shadeV = pile{{"ultramarine blue",1},{"rose madder",0.35},{"viridian",0.5},{"lead white",1.0}, name="shadeV"}
earthW = pile{{"yellow ochre",1.5},{"red earth",0.7},{"vermilion",0.15},{"lead white",1}, name="earthW"}
local n = noise{seed=81, period=110}
local n2 = noise{seed=82, period=70}
local trunkAll = trunk1M + trunk2M
local left = (fgM * mask(function(x,y) return x < 545 and 1 or 0 end)) - trunkAll:grow(1) - ridgeBush
work(left, {hand="hatch", tool={kind="flat", width=12}, length={28,52}, angle=function(x,y) return -1.1 + 0.55*n(x,y) end, angle_jitter=0.12, curve={0.06,0},
  piles={{gDark,function(x,y) return 0.7+0.4*n2(x,y) end},
         {shadeV,function(x,y) return clamp(0.5+0.6*n(x+300,y),0,1) end},
         {gMid,function(x,y) return clamp(0.3-0.7*n2(x,y),0,1) end},
         {earthW,function(x,y) return clamp(0.8*n(x,y+500)-0.1,0,1) end}},
  scale_at=function(x,y) return lerp(0.7,1.2,(y-560)/240) end, coverage=1.3, fill=true, clump=0.35, edge="soft"})

--@ chunk 27
local n = noise{seed=91, period=120}
local n2 = noise{seed=92, period=60}
local trunkAll = trunk1M + trunk2M
local right = (fgM - (fgM * mask(function(x,y) return x < 545 and 1 or 0 end))) - ridgeBush
-- cast shadows of trunks: bands running from trunk bases rightward-down... light from left: shadows to right
shadowBands = (ribbon({{150,800},{420,742},{560,712}}, {22,16,10}) + ribbon({{262,800},{500,770},{560,758}}, {16,12,8})):roughen(5,30,4)
work(right, {hand="hatch", tool={kind="flat", width=12}, length={28,50}, angle=function(x,y) return -0.6 + 0.5*n(x,y) end, angle_jitter=0.12, curve={0.06,0},
  piles={{gYel,function(x,y) return clamp(0.5+0.5*n2(x,y),0,1) end},
         {fGold,function(x,y) return clamp(0.4-0.6*n2(x,y),0,1) end},
         {earthW,function(x,y) return clamp(0.6*n(x+200,y)+0.1,0,1) end},
         {gMid,function(x,y) return clamp(0.6*n(x,y+300),0,1) end},
         {shadeV,function(x,y) return clamp((x-940)/60,0,1)*0.5 end}},
  scale_at=function(x,y) return lerp(0.7,1.2,(y-540)/260) end, coverage=1.3, fill=true, clump=0.35, edge="soft"})

--@ chunk 28
print(wait(5*24*60))
for _,p in ipairs({{300,700},{450,650},{800,700},{650,700},{100,600},{560,780},{300,100}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 29
print(wait(7*24*60))
for _,p in ipairs({{300,700},{450,650},{800,700},{650,700},{100,600},{560,780},{300,100},{900,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 30
local c = worley{seed=101, period=70}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.3); return id end
local function ang(base, spread) return function(x,y) local id=cid(x,y); return base + spread*(id-0.5) + 0.25*math.sin(id*37) end end
local function sel(lo,hi,w) return function(x,y) local id = cid(x,y); local f=(id*7.31)%1; return (f>=lo and f<hi) and (w or 1) or 0.03 end end
local trunkAll = trunk1M + trunk2M
local left = (fgM * mask(function(x,y) return x < 540 and 1 or 0 end)) - trunkAll:grow(1) - ridgeBush:shrink(4)
work(left, {hand="hatch", tool={kind="flat", width=11}, length={26,46}, angle=ang(-1.0,1.4), angle_jitter=0.07, curve={0.04,0},
  piles={{gDark,sel(0,0.32)},{cBlue,sel(0.32,0.52)},{shadeV,sel(0.52,0.68)},{gMid,sel(0.68,0.84)},{earthW,sel(0.84,0.93)},{cOlive,sel(0.93,1.0)}},
  scale_at=function(x,y) return lerp(0.7,1.2,(y-560)/240) end, coverage=1.0, clump=0.5, mix_jitter=0.1, edge="soft"})

--@ chunk 31
orangeE = pile{{"yellow ochre",1.5},{"vermilion",0.5},{"red earth",0.3},{"lead white",0.8}, name="orangeE"}
local c = worley{seed=111, period=75}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.3); return id end
local function ang(base, spread) return function(x,y) local id=cid(x,y); return base + spread*(id-0.5) + 0.25*math.sin(id*37) end end
local function sel(lo,hi,w) return function(x,y) local id = cid(x,y); local f=(id*7.31)%1; return (f>=lo and f<hi) and (w or 1) or 0.03 end end
local right = (fgM - (fgM * mask(function(x,y) return x < 540 and 1 or 0 end))) - ridgeBush:shrink(4)
work(right, {hand="hatch", tool={kind="flat", width=11}, length={26,46}, angle=ang(-0.7,1.5), angle_jitter=0.07, curve={0.04,0},
  piles={{gYel,sel(0,0.25)},{fGold,sel(0.25,0.42)},{gMid,sel(0.42,0.56)},{orangeE,sel(0.56,0.68)},{cMid,sel(0.68,0.78)},{fPale,sel(0.78,0.9)},{shadeV,sel(0.9,1.0)}},
  scale_at=function(x,y) return lerp(0.7,1.2,(y-540)/260) end, coverage=1.0, clump=0.5, mix_jitter=0.1, edge="soft"})

--@ chunk 32
cDeep = pile{{"viridian",2},{"ultramarine blue",1.5},{"bone black",0.3},{"red earth",0.15},{"lead white",0.15}, name="cDeep"}
local function rel(x,y)
  local best, bv = nil, 1e9
  for _,c in ipairs(clusters) do local d = ((x-c[1])/c[3])^2 + ((y-c[2])/c[4])^2; if d < bv then bv, best = d, c end end
  return (y-best[2])/best[4], (x-best[1])/best[3]
end
local n = noise{seed=121, period=45}
local under = canopy:shrink(3) * mask(function(x,y) local v,u = rel(x,y); return clamp((v + 0.15*u + 0.25*n(x,y) + 0.05)*3, 0, 1) end)
work(under, {hand="hatch", tool={kind="flat", width=8}, length={16,30}, angle=function(x,y) return -0.5 + 0.6*n(x+40,y) end, angle_jitter=0.15, curve={0.05,0},
  piles={{cDeep,1},{cDark,0.4},{cBlue,0.25}}, coverage=1.1, clump=0.4, edge="soft"})

--@ chunk 33
local function rel(x,y)
  local best, bv = nil, 1e9
  for _,c in ipairs(clusters) do local d = ((x-c[1])/c[3])^2 + ((y-c[2])/c[4])^2; if d < bv then bv, best = d, c end end
  return (y-best[2])/best[4], (x-best[1])/best[3]
end
local n = noise{seed=131, period=40}
local band = canopy:shrink(3) * mask(function(x,y) local v,u = rel(x,y); local t = v + 0.15*u + 0.25*n(x,y); return clamp(1 - math.abs(t+0.05)*4, 0, 1) end)
work(band, {hand="hatch", tool={kind="flat", width=8}, length={14,26}, angle=function(x,y) return -0.4 + 0.6*n(x+40,y) end, angle_jitter=0.15,
  piles={{cMid,1},{cOlive,0.5},{cBlue,0.5}}, coverage=0.7, clump=0.5, edge="soft", load=0.6})
-- cover trunk-2 stub with a small tuft
local tuft = ellipse(300,178,32,14):roughen(6,20,12)
canopy = canopy + tuft
work(tuft, {hand="hatch", tool={kind="flat", width=7}, length={12,22}, angle=-0.4, angle_jitter=0.2, piles={{cMid,1},{cLit,0.5},{cDark,0.4}}, coverage=1.4, edge="soft"})

--@ chunk 34
local tl = ellipse(302,186,30,7):roughen(4,14,13)
work(tl, {hand="hatch", tool={kind="flat", width=6}, length={10,18}, angle=-0.3, angle_jitter=0.2, piles={{cDark,1},{cBlue,0.5}}, coverage=1.0, edge="soft"})
sb = brush{kind="flat", width=7}
sb:load(skyE, 0.6)
for _,s in ipairs({{{268,170},{282,160}},{{318,160},{334,170}},{{290,162},{300,158}},{{322,186},{334,190}}}) do sb:stroke(s, {pressure=0.6}) end

--@ chunk 35
-- houses: shadow sides and gable planes; light from upper left.
hs = {
 -- shadow side planes (right sides) of main houses
 {{560,420},{590,420},{590,522},{560,522}},
 {{745,440},{770,440},{770,512},{745,512}},
 {{675,466},{700,466},{700,540},{675,540}},
 {{405,502},{420,502},{420,545},{405,545}},
}
for _,p in ipairs(hs) do
  work(poly(p), {hand="hatch", tool={kind="flat", width=5}, length={9,16}, angle=-1.5, angle_jitter=0.1, piles={{wallShd,1},{wallWarm,0.3},{shadeV,0.15}}, coverage=1.5, clip=true})
end
-- shadow under eaves
local eaves = ribbon({{422,463},{498,463}},5) + ribbon({{602,471},{698,471}},5) + ribbon({{712,445},{768,445}},4) + ribbon({{537,425},{588,425}},4) + ribbon({{782,477},{858,477}},5) + ribbon({{372,507},{418,507}},4)
work(eaves, {hand="detail", tool={kind="flat", width=3}, length={8,14}, angle=0, piles={{shadeV,1},{roofShd,0.4}}, coverage=1.5})

--@ chunk 36
winP = pile{{"ultramarine blue",1},{"red earth",0.7},{"lead white",0.5}, name="winP"}
wb = brush{kind="flat", width=4}
local wins = {{440,480},{470,480},{440,505},{550,445},{550,480},{625,490},{655,490},{625,515},{725,465},{725,490},{800,495},{830,495},{385,520},{485,428},{660,434}}
for _,w in ipairs(wins) do
  wb:load(winP, 0.5)
  wb:stroke({{w[1],w[2]},{w[1],w[2]+math.random(6,9)}}, {pressure=0.7})
end

--@ chunk 37
shdWarm = pile{{"lead white",2},{"yellow ochre",1.2},{"cobalt blue",0.35},{"red earth",0.25},{"rose madder",0.1}, name="shdWarm"}
for _,p in ipairs(hs) do
  work(poly(p), {hand="hatch", tool={kind="flat", width=5}, length={8,14}, angle=-1.45, angle_jitter=0.15, piles={{shdWarm,1},{wallShd,0.3}}, coverage=0.9, clip=true, load=0.7})
end
for _,h in ipairs(houses) do
  if h.side then work(poly(h.side), {hand="hatch", tool={kind="flat", width=5}, length={8,14}, angle=-1.45, angle_jitter=0.15, piles={{shdWarm,1},{wallShd,0.4}}, coverage=0.9, clip=true, load=0.7}) end
end
-- break the eave lines: drag roof color across them here and there
local rb = brush{kind="flat", width=4}
local eav = {{422,463,498},{602,471,698},{712,445,768},{537,425,588},{782,477,858},{372,507,418}}
for _,e in ipairs(eav) do
  local x = e[1] + rand(4,12)
  while x < e[3]-6 do
    rb:load(roofLit, 0.4)
    local l = rand(6,14)
    rb:stroke({{x, e[2]-2},{x+l, e[2]-1}}, {pressure=0.6})
    x = x + l + rand(8,20)
  end
end

--@ chunk 38
mLit2 = pile{{"lead white",5},{"yellow ochre",1},{"rose madder",0.4},{"vermilion",0.08}, name="mLit2"}
mPale = pile{{"lead white",7},{"yellow ochre",0.6},{"rose madder",0.2},{"cobalt blue",0.1}, name="mPale"}
mViol = pile{{"lead white",3},{"cobalt blue",1.2},{"rose madder",0.6},{"ultramarine blue",0.3}, name="mViol"}
mDeep = pile{{"lead white",2},{"ultramarine blue",1},{"cobalt blue",0.6},{"rose madder",0.5},{"viridian",0.15}, name="mDeep"}
mGreen = pile{{"lead white",3},{"viridian",0.6},{"cobalt blue",0.6},{"yellow ochre",0.5}, name="mGreen"}
local mclip = mtnM:grow(1)
local F = {
 {pts={{330,335},{420,302},{520,252},{560,232},{540,290},{500,330},{480,346},{300,346}}, piles={{mLit2,1},{mPale,0.5},{mViol,0.2}}, a=-0.45},
 {pts={{560,232},{600,192},{650,168},{628,232},{600,280},{560,300},{540,290}}, piles={{mPale,1},{mLit2,0.6}}, a=-0.75},
 {pts={{650,168},{665,200},{650,260},{620,310},{600,346},{500,346},{560,300},{600,280},{628,232}}, piles={{mViol,1},{mLit2,0.3},{mGreen,0.15}}, a=-1.15},
 {pts={{665,200},{700,186},{760,214},{740,260},{730,300},{720,346},{600,346},{620,310},{650,260}}, piles={{mDeep,1},{mViol,0.7},{mGreen,0.25}}, a=-1.35},
 {pts={{760,214},{820,232},{900,262},{1000,286},{1000,346},{720,346},{730,300},{740,260}}, piles={{mLit2,0.7},{mViol,0.6},{mPale,0.4}}, a=-0.3},
}
for i,f in ipairs(F) do
  work(poly(f.pts), {hand="hatch", tool={kind="flat", width=8}, length={18,32}, angle=f.a, angle_jitter=0.12, curve={0.04,0}, piles=f.piles, coverage=1.3, clump=0.4, edge="soft", clip=mclip})
end
local gully = (ribbon({{800,240},{815,280},{838,320},{850,346}}, {6,10,14,16}) + ribbon({{880,262},{900,300},{905,346}}, {5,9,12})):roughen(4,20,3)
work(gully, {hand="hatch", tool={kind="flat", width=6}, length={12,22}, angle=-1.2, angle_jitter=0.15, piles={{mViol,1},{mDeep,0.5}}, coverage=1.2, edge="soft", clip=mclip})

--@ chunk 39
print(wait(2*24*60))
print(drying(450,320), drying(700,280), drying(500,470), drying(570,480))

--@ chunk 40
print(wait(3*24*60))
print(drying(450,320), drying(700,280), drying(500,470), drying(570,480), drying(880,300))

--@ chunk 41
hillTop = {{0,326},{70,317},{150,322},{240,314},{330,324},{410,316},{490,325},{570,311},{650,321},{730,314},{810,326},{890,317},{960,322},{1000,320}}
hillM = (below(hillTop) * above({{0,352},{1000,350}})):roughen(3,18,21)
hBlue = pile{{"lead white",3},{"cobalt blue",1},{"viridian",0.5},{"rose madder",0.15},{"yellow ochre",0.3}, name="hBlue"}
hViol = pile{{"lead white",3},{"cobalt blue",0.8},{"rose madder",0.4},{"ultramarine blue",0.2}, name="hViol"}
hOch = pile{{"lead white",3},{"yellow ochre",1},{"rose madder",0.2},{"cobalt blue",0.2}, name="hOch"}
local n = noise{seed=141, period=60}
work(hillM, {hand="hatch", tool={kind="flat", width=6}, length={10,20}, angle=function(x,y) return -0.5 + 0.6*n(x,y) end, angle_jitter=0.15,
  piles={{hBlue,function(x,y) return 0.7+0.4*n(x+70,y) end},{hViol,0.5},{hOch,function(x,y) return clamp(-0.6*n(x+70,y),0,1) end}}, coverage=1.5, clump=0.4, edge="soft"})

--@ chunk 42
pOch = pile{{"yellow ochre",2},{"lead white",2},{"vermilion",0.1},{"cobalt blue",0.1}, name="pOch"}
pOlive = pile{{"yellow ochre",1},{"viridian",0.5},{"emerald green",0.3},{"lead white",1.5},{"red earth",0.1}, name="pOlive"}
pSage = pile{{"lead white",3},{"viridian",0.5},{"yellow ochre",0.8},{"cobalt blue",0.3}, name="pSage"}
pRose = pile{{"lead white",3},{"red earth",0.4},{"yellow ochre",0.8},{"rose madder",0.15}, name="pRose"}
pCool = pile{{"lead white",4},{"cobalt blue",0.6},{"yellow ochre",0.6},{"viridian",0.2}, name="pCool"}
local plain2 = (below({{0,346},{1000,344}}) * above(ridge)) - hillM:shrink(3) - treeBack:grow(1) - ridgeBush:grow(1) - housesM:grow(1)
local c = worley{seed=151, period=80}
local function persp(y) return lerp(0.25, 1.0, clamp((y-345)/200,0,1)) end
local function cid(x,y) local s = persp(y); local _,_,_,id = c:at(x*0.5, 345 + (y-345)/s*1.2); return id end
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.77)%1; return (f>=lo and f<hi) and 1 or 0.04 end end
local function dist(x,y) return clamp(1-(y-345)/120,0,1) end
work(plain2, {hand="hatch", tool={kind="flat", width=8}, length={18,34}, angle=function(x,y) local id=cid(x,y); return -0.1 + 0.5*(id-0.5) end, angle_jitter=0.1,
  piles={{pOch,sel(0,0.28)},{pOlive,sel(0.28,0.48)},{pSage,sel(0.48,0.66)},{pRose,sel(0.66,0.82)},{fGold,sel(0.82,0.92)},{pCool,function(x,y) return sel(0.92,1)(x,y) + 1.2*dist(x,y) end}},
  scale_at=function(x,y) return lerp(0.45,1.0,clamp((y-345)/200,0,1)) end, coverage=1.3, clump=0.4, edge="soft", mix_jitter=0.08})

--@ chunk 43
print(wait(5*24*60))
print(drying(300,450), drying(700,380), drying(100,500), drying(500,330))

--@ chunk 44
print(wait(3*24*60))
print(drying(300,450), drying(700,380), drying(100,500), drying(500,330))

--@ chunk 45
local rows = {346, 354, 366, 382, 404, 432, 468, 512, 575}
local vx, vy = 560, 300
local function xAt(x0, y) -- x on line through vanishing pt and (x0, 575)
  return vx + (x0 - vx) * (y - vy) / (575 - vy)
end
local cols = {}
local plainClip = (below({{0,346},{1000,344}}) * above(ridge)) - hillM:shrink(3) - treeBack:grow(1) - ridgeBush:grow(1) - housesM:grow(1)
local pl = {pOch, pOlive, pSage, pRose, fGold, pOch, pSage, pOlive}
fields = {}
for r=1,#rows-1 do
  local y0, y1 = rows[r], rows[r+1]
  local bx = {-900}
  local x = -900
  while x < 2000 do x = x + rand(250, 700) * (1 + (8-r)*0.25); bx[#bx+1] = x end
  for i=1,#bx-1 do
    local a, b = bx[i], bx[i+1]
    local poly4 = {{xAt(a,y0),y0},{xAt(b,y0),y0},{xAt(b,y1),y1},{xAt(a,y1),y1}}
    local p = pl[math.random(#pl)]
    local along = math.random() < 0.5
    local midx = (xAt(a,(y0+y1)/2)+xAt(b,(y0+y1)/2))/2
    local ang = along and (rand(-0.12,0.12)) or math.atan(y1-y0, xAt((a+b)/2,y1)-xAt((a+b)/2,y0))
    if math.abs(ang) > 1.4 then ang = ang*0.8 end
    fields[#fields+1] = {pts=poly4, pile=p, ang=ang, r=r}
  end
end
local n=0
for _,f in ipairs(fields) do
  local m = poly(f.pts) * plainClip
  if m:area() > 30 then
    n = n + 1
    local far = clamp(1 - (f.r-1)/4, 0, 1)
    work(m, {hand="hatch", tool={kind="flat", width=lerp(8,4,far)}, length={lerp(18,8,far), lerp(32,14,far)}, angle=f.ang, angle_jitter=0.1,
      piles={{f.pile,1},{pCool,far*1.2+0.05}}, coverage=1.25, clump=0.3, edge="soft", clip=plainClip})
  end
end
print(#fields, n)

--@ chunk 46
local ca = canopy:shrink(6)
for _,t in ipairs({t1,t2}) do
  local m = trunkMask(t) - ca
  work(m, {hand="hatch", tool={kind="flat", width=5}, length={12,24}, angle=-1.5, angle_jitter=0.1, clip=true, coverage=2.4,
    piles={{trLit,function(x,y) local cx,w=cxAt(t,y); return clamp(0.7-(x-cx)/w*1.8,0,1) end},
           {trMid,function(x,y) local cx,w=cxAt(t,y); return clamp(0.7-math.abs((x-cx)/w)*2,0,1) end},
           {trDk,function(x,y) local cx,w=cxAt(t,y); return clamp(0.1+(x-cx)/w*2.2,0,1) end}}})
end

--@ chunk 47
local vx, vy = 560, 300
local function xAt(x0, y) return vx + (x0 - vx) * (y - vy) / (575 - vy) end
local plainClip = (below({{0,346},{1000,344}}) * above(ridge)) - treeBack:grow(1) - ridgeBush:grow(1) - housesM:grow(2) - (trunk1M+trunk2M):grow(1)
local tm = nil
local function add(m) tm = tm and (tm + m) or m end
-- broken hedgerows along row lines
for _,row in ipairs({{366,2.5},{382,3.5},{404,4.5},{432,6},{468,7.5},{512,9}}) do
  local y, w = row[1], row[2]
  local x = rand(-20, 60)
  while x < 1000 do
    local l = rand(40, 160)
    if math.random() < 0.6 then add(ribbon({{x, y + rand(-1,1)}, {x + l, y + rand(-1.5,1.5)}}, w)) end
    x = x + l + rand(20, 120)
  end
end
-- a few converging lines (field edges toward the vanishing point), as tree rows
for _,x0 in ipairs({-200, 150, 980, 1250}) do
  local pts = {}
  for y=372,540,24 do pts[#pts+1] = {xAt(x0,y), y} end
  add(ribbon(pts, 4))
end
-- clumps
for _,c in ipairs({{60,395,22,9},{230,418,18,8},{330,375,14,6},{820,388,16,7},{960,450,26,11},{120,470,30,13},{900,500,20,10},{690,372,12,5},{430,360,10,4},{760,410,14,6}}) do
  add(ellipse(c[1],c[2],c[3],c[4]))
end
plainTrees = (tm:roughen(3,14,31)) * plainClip
tDarkF = pile{{"viridian",1.5},{"ultramarine blue",0.8},{"yellow ochre",0.3},{"lead white",0.8}, name="tDarkF"}
tFar = pile{{"viridian",1},{"cobalt blue",0.8},{"lead white",1.8},{"rose madder",0.1}, name="tFar"}
local n = noise{seed=161, period=50}
work(plainTrees, {hand="hatch", tool={kind="flat", width=4}, length={5,10}, angle=function(x,y) return -1.2+0.5*n(x,y) end, angle_jitter=0.2,
  piles={{tDarkF,function(x,y) return clamp((y-350)/120,0,1) end},{tFar,function(x,y) return clamp(1-(y-350)/120,0,1)+0.1 end},{cMid,0.25}},
  scale_at=function(x,y) return lerp(0.5,1.2,clamp((y-350)/180,0,1)) end, coverage=1.5, clump=0.4, edge="soft"})

--@ chunk 48
for _,p in ipairs({{300,700},{450,650},{800,700},{650,650},{100,600},{900,750}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 49
shadeL = pile{{"lead white",2},{"cobalt blue",0.8},{"viridian",0.4},{"rose madder",0.15},{"yellow ochre",0.4}, name="shadeL"}
gDeepW = pile{{"viridian",1.5},{"ultramarine blue",0.7},{"yellow ochre",0.8},{"red earth",0.2},{"lead white",0.3}, name="gDeepW"}
local c = worley{seed=171, period=110}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.2); return id end
local function ang(base, spread) return function(x,y) local id=cid(x,y); return base + spread*(((id*3.17)%1)-0.5) end end
local function sel(lo,hi,w) return function(x,y) local f=(cid(x,y)*7.31)%1; return (f>=lo and f<hi) and (w or 1) or 0.12 end end
local trunkAll = (trunk1M + trunk2M):grow(1)
local left = (fgM * mask(function(x,y) return x < 535 and 1 or 0 end)) - trunkAll - ridgeBush:shrink(4)
work(left, {hand="hatch", tool={kind="flat", width=12}, length={28,48}, angle=ang(-0.9,1.1), angle_jitter=0.06, curve={0.03,0},
  piles={{gDark,sel(0,0.4)},{gDeepW,sel(0.4,0.7)},{cBlue,sel(0.7,0.9)},{cOlive,sel(0.9,1.0)}},
  scale_at=function(x,y) return lerp(0.75,1.2,(y-560)/240) end, coverage=1.15, clump=0.5, mix_jitter=0.06, edge="soft"})

--@ chunk 50
local c = worley{seed=181, period=105}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.2); return id end
local function ang(base, spread) return function(x,y) local id=cid(x,y); return base + spread*(((id*3.17)%1)-0.5) end end
local function sel(lo,hi,w) return function(x,y) local f=(cid(x,y)*7.31)%1; return (f>=lo and f<hi) and (w or 1) or 0.12 end end
local right = (fgM - (fgM * mask(function(x,y) return x < 535 and 1 or 0 end))) - ridgeBush:shrink(4)
work(right, {hand="hatch", tool={kind="flat", width=12}, length={28,48}, angle=ang(-0.6,1.3), angle_jitter=0.06, curve={0.03,0},
  piles={{gYel,sel(0,0.3)},{fGold,sel(0.3,0.5)},{gMid,sel(0.5,0.68)},{earthW,sel(0.68,0.8)},{pOlive,sel(0.8,0.92)},{shadeL,sel(0.92,1.0)}},
  scale_at=function(x,y) return lerp(0.75,1.2,(y-540)/260) end, coverage=1.15, clump=0.5, mix_jitter=0.06, edge="soft"})

--@ chunk 51
print(wait(8*24*60))
for _,p in ipairs({{300,700},{450,650},{800,700},{650,650},{100,600},{900,750},{300,450}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 52
t1 = {{126,805,30},{131,700,28},{142,560,25},{150,440,22},{153,330,20},{162,230,18},{176,150,16},{186,90,14}}
t2 = {{247,805,22},{254,700,20},{262,580,18},{265,470,16},{273,370,14},{283,280,12},{292,210,10},{296,185,9}}
trunk1M = trunkMask(t1); trunk2M = trunkMask(t2)
trGreen = pile{{"viridian",0.6},{"yellow ochre",0.8},{"red earth",0.3},{"lead white",0.6}, name="trGreen"}
local ca = canopy:shrink(6)
for _,t in ipairs({t1,t2}) do
  local m = trunkMask(t) - ca
  work(m, {hand="hatch", tool={kind="flat", width=6}, length={10,22}, angle=function(x,y) return -1.5 + 0.35*math.sin(y/23) end, angle_jitter=0.15, clip=true, coverage=2.4,
    piles={{trLit,function(x,y) local cx,w=cxAt(t,y); return clamp(0.8-(x-cx)/w*2.2,0,1) end},
           {trMid,function(x,y) local cx,w=cxAt(t,y); return clamp(0.6-math.abs((x-cx)/w)*1.6,0,1) end},
           {trGreen,function(x,y) local cx,w=cxAt(t,y); return clamp(0.3-math.abs((x-cx)/w-0.15)*1.5,0,1)*(0.5+0.5*math.sin(y/37)) end},
           {trDk,function(x,y) local cx,w=cxAt(t,y); return clamp(0.05+(x-cx)/w*2.4,0,1) end}}})
end

--@ chunk 53
bb = brush{kind="round", width=6, point=0.6}
local function br(pts) bb:load(trMid, 0.7); bb:gesture(pts, {wobble=1.5}) end
br({{183,175,0.9},{205,150,0.7},{240,128,0.4},{270,118,0.15}})
br({{180,170,0.8},{160,150,0.6},{120,140,0.3},{90,138,0.1}})
br({{294,205,0.8},{310,190,0.5},{340,178,0.2}})
br({{291,200,0.7},{278,186,0.4},{262,178,0.15}})
local tops = (ellipse(180,168,26,9) + ellipse(293,200,16,7) + ellipse(292,180,10,9)):roughen(4,12,41)
work(tops, {hand="hatch", tool={kind="flat", width=6}, length={9,16}, angle=-0.3, angle_jitter=0.2, piles={{cDark,1},{cBlue,0.4},{cMid,0.3}}, coverage=1.4, edge="soft"})

--@ chunk 54
local arcs = ribbon({{205,150},{240,128},{272,117}}, 10) + ribbon({{160,150},{120,140},{88,138}}, 10) + ribbon({{310,190},{342,178}},8) + ribbon({{278,186},{260,178}},8) + ellipse(174,102,10,14)
local n = noise{seed=191, period=20}
local cov = arcs * mask(function(x,y) return n(x,y) > -0.35 and 1 or 0 end)
work(cov, {hand="hatch", tool={kind="flat", width=6}, length={8,14}, angle=-0.5, angle_jitter=0.3, piles={{cMid,1},{cDark,0.8},{cOlive,0.3}}, coverage=1.6, edge="soft"})
-- darken the remaining branch bits
bb = brush{kind="round", width=4, point=0.5}
bb:load(trDk, 0.5)
bb:gesture({{186,170,0.7},{205,152,0.5},{222,140,0.2}})
bb:load(trDk, 0.5)
bb:gesture({{176,168,0.6},{150,150,0.4},{132,144,0.1}})
local t2top = (ellipse(292,242,22,9) + ellipse(305,236,14,6)):roughen(3,10,43)
work(t2top, {hand="hatch", tool={kind="flat", width=5}, length={8,14}, angle=-0.3, angle_jitter=0.2, piles={{cDark,1},{cDeep,0.4}}, coverage=1.4, edge="soft"})

--@ chunk 55
local mclip = mtnM:grow(1) - hillM:shrink(2)
local r1 = poly({{770,222},{830,236},{860,300},{870,330},{790,330},{770,280}})
local r2 = poly({{830,236},{900,262},{960,278},{1000,287},{1000,330},{870,330},{860,300}})
work(r1, {hand="hatch", tool={kind="flat", width=8}, length={16,28}, angle=-0.95, angle_jitter=0.12, piles={{mViol,0.7},{mLit2,0.6},{mGreen,0.2}}, coverage=1.4, clump=0.4, edge="soft", clip=mclip})
work(r2, {hand="hatch", tool={kind="flat", width=8}, length={16,28}, angle=-0.3, angle_jitter=0.12, piles={{mLit2,1},{mPale,0.4},{mViol,0.3}}, coverage=1.4, clump=0.4, edge="soft", clip=mclip})

--@ chunk 56
-- mint strip left of village: rows ~512-575
local vx, vy = 560, 300
local strip = (below({{0,508},{360,512}}) * above(ridge) * mask(function(x,y) return x < 380 and 1 or 0 end)) - (trunk1M+trunk2M):grow(1) - ridgeBush:grow(1) - housesM:grow(2) - treeBack:grow(1)
bankO = pile{{"yellow ochre",2},{"red earth",0.3},{"lead white",1.5},{"vermilion",0.1}, name="bankO"}
work(strip, {hand="hatch", tool={kind="flat", width=9}, length={18,34}, angle=function(x,y) return -0.1 + 0.15*math.sin(x/50) end, angle_jitter=0.12,
  piles={{bankO,1},{pOlive,0.7},{gYel,0.3}}, coverage=1.3, clump=0.4, edge="soft", clip=below({{0,505},{380,508}})})

--@ chunk 57
bushR = outline{{1005,560},{975,566},{945,590},{915,585},{885,612},{870,650},{858,700},{845,745},{850,805},{1005,805}, char="soft", seed=7, closed=true, lobe=22}:mask()
local cx, cy = 960, 640
local n = noise{seed=201, period=35}
work(bushR, {hand="hatch", tool={kind="flat", width=11}, length={22,40}, angle=function(x,y) return -1.0 + 0.6*n(x,y) end, angle_jitter=0.12, curve={0.05,0},
  piles={{cDark,function(x,y) return clamp(0.4 + (y-cy)/150 + 0.4*n(x+50,y),0,1.2) end},
         {cBlue,0.4},
         {cMid,function(x,y) return clamp(0.6 - (y-cy)/200 + 0.3*n(x,y+80),0,1) end},
         {cLit,function(x,y) return clamp(0.2 - (y-590)/120 - (x-900)/400,0,1) end}},
  coverage=1.4, clump=0.45, edge={found=0.4, soft=0.4, lost=0.2, period=40}})

--@ chunk 58
print(wait(6*24*60))
for _,p in ipairs({{300,700},{200,620},{600,700},{700,650},{900,700},{200,530}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 59
-- sunlit ground openings in the left foreground: warm earth and yellow-green clearing
sunL = outline{{20,700},{70,672},{140,676},{205,690},{250,720},{300,745},{330,790},{320,805},{10,805}, char="soft", seed=11, closed=true, lobe=26}:mask()
sunL2 = outline{{330,610},{380,598},{450,604},{500,620},{525,650},{490,668},{420,664},{350,650}, char="soft", seed=12, closed=true, lobe=20}:mask()
local m = (sunL + sunL2) - (trunk1M + trunk2M):grow(1)
local n = noise{seed=211, period=60}
work(m, {hand="hatch", tool={kind="flat", width=12}, length={26,44}, angle=function(x,y) return -0.6 + 0.6*n(x,y) end, angle_jitter=0.08, curve={0.03,0},
  piles={{earthW,function(x,y) return clamp(0.6+0.6*n(x+30,y),0,1) end},{gYel,function(x,y) return clamp(0.5-0.6*n(x+30,y),0,1) end},{fGold,0.35},{orangeE,function(x,y) return clamp(n(x,y+90),0,1)*0.6 end}},
  coverage=1.2, clump=0.5, mix_jitter=0.06, edge={found=0.2, soft=0.5, lost=0.3, period=40}})

--@ chunk 60
-- shadows: cast from pines across road and right meadow, cool blue-violet, laid in patches
shadow1 = outline{{300,698},{420,690},{540,690},{640,682},{760,668},{850,662},{852,700},{760,712},{640,726},{540,735},{420,736},{300,742}, char="soft", seed=21, closed=true, lobe=24}:mask()
shadow2 = outline{{270,780},{430,764},{560,768},{700,760},{820,750},{840,805},{270,805}, char="soft", seed=22, closed=true, lobe=24}:mask()
shRoad = pile{{"lead white",2.5},{"cobalt blue",0.9},{"rose madder",0.35},{"yellow ochre",0.35}, name="shRoad"}
shGrass = pile{{"lead white",1},{"cobalt blue",0.6},{"viridian",0.7},{"yellow ochre",0.5},{"rose madder",0.1}, name="shGrass"}
local sh = (shadow1 + shadow2) - (trunk1M + trunk2M):grow(1) - bushR:shrink(2)
local inRoad = function(x,y) return roadM:at(x,y) end
local n = noise{seed=221, period=50}
work(sh, {hand="hatch", tool={kind="flat", width=11}, length={24,40}, angle=function(x,y) return -0.25 + 0.4*n(x,y) end, angle_jitter=0.1,
  piles={{shRoad,function(x,y) return roadM:at(x,y)*1.2 + 0.05 end},{shGrass,function(x,y) return (1-roadM:at(x,y))*1.0 + 0.05 end},{shadeL,0.3}},
  coverage=1.1, clump=0.5, edge={soft=0.6, lost=0.4, period=40}})

--@ chunk 61
print(wait(5*24*60))
for _,p in ipairs({{400,720},{650,720},{200,740},{450,630},{900,700}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 62
print(wait(3*24*60))
for _,p in ipairs({{400,720},{650,720},{600,780},{450,630}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 63
shR3 = pile{{"lead white",1.5},{"cobalt blue",0.8},{"ultramarine blue",0.2},{"rose madder",0.25},{"yellow ochre",0.5}, name="shR3"}
shG2 = pile{{"viridian",1},{"ultramarine blue",0.6},{"yellow ochre",0.5},{"lead white",0.4},{"rose madder",0.1}, name="shG2"}
local sh = (shadow1 + shadow2) - (trunk1M + trunk2M):grow(1) - bushR:shrink(2)
local n = noise{seed=231, period=50}
local rm = roadM:soften(6)
work(sh, {hand="hatch", tool={kind="flat", width=11}, length={24,40}, angle=function(x,y) return -0.2 + 0.35*n(x,y) end, angle_jitter=0.08,
  piles={{shR3,function(x,y) return rm:at(x,y)*1.3 + 0.02 end},{shG2,function(x,y) return (1-rm:at(x,y))*1.0 + 0.02 end},{cBlue,function(x,y) return (1-rm:at(x,y))*0.3 end}},
  coverage=1.05, clump=0.5, edge={soft=0.6, lost=0.4, period=40}})

--@ chunk 64
earthD = pile{{"yellow ochre",1.2},{"red earth",0.6},{"viridian",0.3},{"lead white",0.6}, name="earthD"}
local m = sunL + sunL2
local n = noise{seed=241, period=45}
local sel = mask(function(x,y) return n(x,y) > -0.1 and 1 or 0 end)
work(m * sel - (trunk1M+trunk2M):grow(1) - shadow2:grow(2), {hand="hatch", tool={kind="flat", width=11}, length={22,40}, angle=function(x,y) return -0.9 + 0.5*n(x+20,y) end, angle_jitter=0.08,
  piles={{earthD,1},{gMid,0.6},{gDeepW,0.4}}, coverage=0.9, clump=0.5, edge="soft"})

--@ chunk 65
print(wait(8*24*60))
for _,p in ipairs({{400,720},{650,720},{600,780},{450,630},{200,700}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 66
local sh = (shadow1 + shadow2) - (trunk1M + trunk2M):grow(1) - bushR:shrink(2)
local n = noise{seed=251, period=50}
local rm = roadM:soften(6)
shG3 = mix{{shG2,1},{gDeepW,0.5}, name="shG3"}
work(sh, {hand="hatch", tool={kind="flat", width=12}, length={26,44}, angle=function(x,y) return -0.15 + 0.3*n(x,y) end, angle_jitter=0.06,
  piles={{shR3,function(x,y) return rm:at(x,y)*1.3 + 0.02 end},{shG3,function(x,y) return (1-rm:at(x,y))*1.0 + 0.02 end},{mViol,function(x,y) return rm:at(x,y)*0.3 end}},
  coverage=0.85, clump=0.3, edge={soft=0.5, lost=0.5, period=40}})

--@ chunk 67
print(drying(700,80), drying(400,300))
skyF = pile{{"lead white",3},{"cobalt blue",1.6},{"ultramarine blue",0.3},{"viridian",0.15}, name="skyF"}
skyG = pile{{"lead white",4},{"cobalt blue",1},{"viridian",0.5},{"yellow ochre",0.15}, name="skyG"}
skyH = pile{{"lead white",6},{"cobalt blue",0.5},{"rose madder",0.12},{"yellow ochre",0.2}, name="skyH"}
local c = worley{seed=261, period=95}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.4); return id end
local function sel(lo,hi,w) return function(x,y) local f=(cid(x,y)*6.13)%1; return (f>=lo and f<hi) and (w or 1) or 0.05 end end
local sk = skyM - canopy:grow(3) - mtnM:grow(6)
local dens = mask(function(x,y) local f=(cid(x,y)*3.71)%1; return (f < clamp(0.95 - y/380, 0.2, 0.9)) and 1 or 0 end)
work(sk * dens, {hand="hatch", tool={kind="flat", width=12}, length={26,44}, angle=function(x,y) local id=cid(x,y); return -0.95 + 0.6*(((id*2.3)%1)-0.5) end, angle_jitter=0.06, curve={0.03,0},
  piles={{skyF,sel(0,0.45)},{skyG,sel(0.45,0.7)},{skyH,sel(0.7,1.0)}}, coverage=1.0, clump=0.5, mix_jitter=0.06, edge="soft", load=0.8})

--@ chunk 68
local seg = ribbon({{280,272},{284,252},{288,236}}, {12,11,10})
work(seg, {hand="hatch", tool={kind="flat", width=5}, length={10,18}, angle=-1.5, angle_jitter=0.1, clip=true, coverage=2.4,
  piles={{trLit,function(x,y) return clamp(0.8-(x-284)/11*2.2,0,1) end},{trMid,0.5},{trDk,function(x,y) return clamp(0.05+(x-284)/11*2.4,0,1) end}}})
local under = (ellipse(330,238,80,12) + ellipse(260,236,30,8)):roughen(5,16,51) 
local n = noise{seed=271, period=25}
work(under, {hand="hatch", tool={kind="flat", width=6}, length={10,18}, angle=function(x,y) return -0.3+0.5*n(x,y) end, angle_jitter=0.2, piles={{cDark,1},{cDeep,0.4},{cBlue,0.4}}, coverage=1.3, edge={found=0.3, soft=0.5, lost=0.2, period=30}})

--@ chunk 69
print(wait(6*24*60))
print(drying(800,100), drying(600,60), drying(300,240), drying(900,150))

--@ chunk 70
skyK = pile{{"lead white",4},{"cobalt blue",1.1},{"ultramarine blue",0.15},{"emerald green",0.1}, name="skyK"}
local sk = (skyM - canopy:grow(4) - mtnM:grow(6)) * mask(function(x,y) return x > 470 and 1 or 0 end)
local c = worley{seed=281, period=70}
local dens = mask(function(x,y) local _,_,_,id = c:at(x,y*1.3); return ((id*4.7)%1) < 0.55 and 1 or 0 end)
work(sk * dens, {hand="hatch", tool={kind="flat", width=12}, length={26,42}, angle=function(x,y) return -1.1 + 0.3*math.sin(x/120) end, angle_jitter=0.08,
  piles={{skyK,1},{skyE,0.5},{skyB,0.2}}, coverage=0.9, clump=0.4, edge="soft", load=0.7, clip=skyM - mtnM:grow(3)})

--@ chunk 71
line = pile{{"ultramarine blue",1},{"cobalt blue",0.6},{"lead white",0.35},{"rose madder",0.1}, medium=0.2, name="line"}
lb = brush{kind="round", width=4.5, point=0.5}
local function seg(pts, load)
  lb:load(line, load or 0.55)
  lb:gesture(pts, {wobble=1})
end
-- mountain ridge, broken
seg({{425,301,0.1},{470,280,0.5},{515,256,0.5},{540,240,0.1}})
seg({{566,215,0.2},{600,192,0.6},{640,170,0.5},{652,168,0.1}})
seg({{668,176,0.1},{700,187,0.5},{740,204,0.3}})
seg({{800,227,0.1},{840,240,0.4},{880,256,0.2}})
seg({{652,170,0.4},{646,200,0.3},{638,232,0.1}})
-- trunks shadow side (right)
seg({{170,180,0.2},{164,300,0.5},{158,420,0.6},{150,540,0.3}}, 0.6)
seg({{146,600,0.3},{140,700,0.6},{138,790,0.4}}, 0.6)
seg({{289,280,0.2},{280,380,0.5},{273,470,0.4}}, 0.6)
seg({{268,560,0.4},{263,680,0.6},{260,790,0.3}}, 0.6)
-- houses
seg({{590,423,0.4},{590,470,0.5},{591,520,0.2}})
seg({{535,425,0.3},{535,470,0.2}})
seg({{770,445,0.4},{770,510,0.3}})
seg({{700,470,0.4},{700,538,0.3}})
seg({{422,462,0.2},{421,500,0.4},{421,528,0.2}})
seg({{860,476,0.3},{861,528,0.2}})
seg({{604,468,0.1},{650,468,0.4},{698,468,0.1}})
seg({{372,503,0.1},{395,504,0.4},{418,504,0.1}})
-- road left edge
seg({{543,620,0.1},{555,660,0.4},{568,700,0.2}})
seg({{520,570,0.1},{532,595,0.3},{540,615,0.1}})

--@ chunk 72
print(drying(200,450), drying(150,530), drying(300,380))
local ca = canopy:shrink(6)
for _,t in ipairs({t1,t2}) do
  local m = trunkMask(t) * rect(0,480,400,110)
  work(m, {hand="hatch", tool={kind="flat", width=6}, length={10,22}, angle=function(x,y) return -1.5 + 0.35*math.sin(y/23) end, angle_jitter=0.15, clip=true, coverage=2.4,
    piles={{trLit,function(x,y) local cx,w=cxAt(t,y); return clamp(0.8-(x-cx)/w*2.2,0,1) end},
           {trMid,function(x,y) local cx,w=cxAt(t,y); return clamp(0.6-math.abs((x-cx)/w)*1.6,0,1) end},
           {trDk,function(x,y) local cx,w=cxAt(t,y); return clamp(0.05+(x-cx)/w*2.4,0,1) end}}})
end

--@ chunk 73
local plainClip = (below({{0,346},{1000,344}}) * above(ridge)) - treeBack:grow(2) - ridgeBush:grow(1) - housesM:grow(3) - (trunk1M+trunk2M):grow(2)
local n = noise{seed=291, period=40}
for _,f in ipairs(fields) do
  local m = poly(f.pts) * plainClip * mask(function(x,y) return n(x,y) > 0.0 and 1 or 0 end)
  if m:area() > 30 then
    local far = clamp(1 - (f.r-1)/4, 0, 1)
    work(m, {hand="hatch", tool={kind="flat", width=lerp(9,5,far)}, length={lerp(22,10,far), lerp(38,18,far)}, angle=f.ang, angle_jitter=0.1,
      piles={{f.pile,1},{pCool,far*1.0+0.05}}, coverage=0.8, clump=0.3, edge="soft", clip=plainClip, load=0.7})
  end
end

--@ chunk 74
print(wait(6*24*60))
print(drying(200,450), drying(150,530), drying(700,380), drying(500,400))

--@ chunk 75
-- deliberate dotted rows of olive/almond trees and a couple of hedges, sizes falling with distance
oliveD = pile{{"viridian",1},{"ultramarine blue",0.5},{"yellow ochre",0.6},{"lead white",0.7},{"red earth",0.1}, name="oliveD"}
oliveF = pile{{"viridian",0.8},{"cobalt blue",0.7},{"lead white",1.6},{"rose madder",0.1},{"yellow ochre",0.2}, name="oliveF"}
local excl = housesM:grow(3) + treeBack:grow(1) + (trunk1M+trunk2M):grow(3) + ridgeBush
local tb = brush{kind="filbert", width=6}
local vx, vy = 560, 300
local count = 0
local function tree(x, y, s)
  if excl:at(x,y) > 0.1 or y < 350 then return end
  local far = clamp(1-(y-350)/150,0,1)
  local p = mix{{oliveD, 1-far*0.8},{oliveF, 0.2+far}} 
  tb:load(p, 0.5)
  local w = s
  tb:stroke({{x - w*0.8, y + rand(-0.3,0.3)*w}, {x + w*0.8, y + rand(-0.3,0.3)*w}}, {pressure=clamp(0.25+ s/14,0.2,0.9)})
  count = count + 1
end
-- rows: lines across the plain, slightly tilted, trees spaced by perspective
local rowsDef = {{372, 0.004, 0, 1000}, {398, -0.01, 0, 520}, {418, 0.008, 640, 1000}, {446, -0.005, 0, 380}, {488, 0.01, 0, 330}, {470, -0.006, 880, 1000}}
for _,r in ipairs(rowsDef) do
  local y0, slope, xa, xb = r[1], r[2], r[3], r[4]
  local s = lerp(2.5, 9, clamp((y0-350)/150,0,1))
  local x = xa + rand(0, s*2)
  while x < xb do
    if math.random() < 0.82 then tree(x, y0 + slope*(x-500) + rand(-1,1), s*rand(0.8,1.2)) end
    x = x + s * rand(2.0, 3.4)
  end
end
print(count)

--@ chunk 76
r = rag{width=12}
r:dip(0.7)
local rowsDef = {{372, 0.004, 0, 1000}, {398, -0.01, 0, 520}, {418, 0.008, 640, 1000}, {446, -0.005, 0, 380}, {488, 0.01, 0, 330}, {470, -0.006, 880, 1000}}
for _,rw in ipairs(rowsDef) do
  local y0, slope, xa, xb = rw[1], rw[2], rw[3], rw[4]
  for pass=1,3 do
    local x = xa
    while x < xb do
      local x2 = math.min(x+120, xb)
      r:wipe({{x, y0+slope*(x-500)},{x2, y0+slope*(x2-500)}}, {pressure=0.7})
      x = x2
      if r.load > 0.3 then r:refold() end
    end
    r:dip(0.5)
  end
end
print(r)

--@ chunk 77
local rowsDef = {{372, 0.004, 0, 1000}, {398, -0.01, 0, 520}, {418, 0.008, 640, 1000}, {446, -0.005, 0, 380}, {488, 0.01, 0, 330}, {470, -0.006, 880, 1000}}
local band = nil
for _,rw in ipairs(rowsDef) do
  local y0, slope, xa, xb = rw[1], rw[2], rw[3], rw[4]
  local s = lerp(2.5, 9, clamp((y0-350)/150,0,1))
  local b = ribbon({{xa, y0+slope*(xa-500)},{xb, y0+slope*(xb-500)}}, s*1.8+3)
  band = band and (band + b) or b
end
local plainClip = (below({{0,346},{1000,344}}) * above(ridge)) - treeBack:grow(2) - ridgeBush:grow(1) - housesM:grow(3) - (trunk1M+trunk2M):grow(2)
local n = noise{seed=301, period=28}
local gate = mask(function(x,y) return n(x,y) > -0.05 and 1 or 0 end)
for _,f in ipairs(fields) do
  local m = poly(f.pts) * plainClip * band * gate
  if m:area() > 20 then
    local far = clamp(1 - (f.r-1)/4, 0, 1)
    work(m, {hand="hatch", tool={kind="flat", width=lerp(8,4,far)}, length={lerp(14,8,far), lerp(24,14,far)}, angle=f.ang + 0.2, angle_jitter=0.15,
      piles={{f.pile,1},{pCool,far*0.8+0.05}}, coverage=1.2, clump=0.2, edge="soft", clip=plainClip})
  end
end

--@ chunk 78
print(wait(8*24*60))
print(drying(200,450), drying(150,530), drying(700,380), drying(500,400), drying(60,370))

--@ chunk 79
print(wait(7*24*60))
print(drying(200,450), drying(150,530), drying(700,380), drying(500,400), drying(60,370))

--@ chunk 80
print(wait(5*24*60))
print(drying(200,450), drying(250,470), drying(100,460))

--@ chunk 81
local plainClip = (below({{0,346},{1000,344}}) * above(ridge)) - treeBack:grow(2) - ridgeBush:grow(1) - housesM:grow(3) - (trunk1M+trunk2M):grow(2)
local P = {
 {pts={{0,450},{120,445},{250,447},{350,452},{340,474},{200,478},{0,482}}, piles={{gMid,1},{pOlive,0.6},{cMid,0.3}}, a=0.05, w=7},
 {pts={{0,410},{140,406},{300,408},{290,424},{120,428},{0,430}}, piles={{orangeE,0.7},{pOch,1},{pRose,0.4}}, a=-0.1, w=6},
 {pts={{430,378},{620,376},{800,378},{790,390},{600,392},{440,392}}, piles={{pOlive,1},{pSage,0.6},{oliveF,0.3}}, a=0.0, w=5},
 {pts={{880,430},{1000,424},{1000,462},{885,470}}, piles={{gMid,1},{pOlive,0.8}}, a=-0.3, w=7},
 {pts={{780,398},{1000,392},{1000,410},{790,416}}, piles={{pRose,1},{pOch,0.6}}, a=0.05, w=5},
 {pts={{0,358},{300,356},{560,357},{560,364},{300,366},{0,368}}, piles={{pSage,1},{pCool,1},{hBlue,0.4}}, a=0.0, w=4},
}
for _,f in ipairs(P) do
  work(poly(f.pts):roughen(2,15,5) * plainClip, {hand="hatch", tool={kind="flat", width=f.w}, length={f.w*2.4, f.w*4.2}, angle=f.a, angle_jitter=0.12, piles=f.piles, coverage=1.3, clump=0.3, edge="soft", clip=plainClip})
end
-- hedgerow clumps of dark trees along field divisions
local hl = {{{0,392},{120,389},{260,391},{430,394}}, {{0,436},{180,433},{340,438}}, {{620,400},{780,396},{1000,388}}, {{0,492},{150,488},{340,494}}, {{880,474},{1000,468}}}
local n = noise{seed=311, period=24}
local gate = mask(function(x,y) return n(x,y) > -0.15 and 1 or 0 end)
for i,l in ipairs(hl) do
  local y = l[1][2]
  local w = lerp(3, 8, clamp((y-370)/130,0,1))
  local m = ribbon(l, w):roughen(2, 10, 60+i) * gate * plainClip
  work(m, {hand="hatch", tool={kind="flat", width=math.max(3,w*0.7)}, length={w*1.4, w*2.6}, angle=-0.25, angle_jitter=0.3, piles={{tDarkF,1},{oliveD,0.6},{cDark,0.4}}, coverage=1.4, clump=0.5, edge="soft"})
end

--@ chunk 82
mOchG = pile{{"lead white",4},{"yellow ochre",1},{"viridian",0.25},{"cobalt blue",0.2},{"rose madder",0.1}, name="mOchG"}
mPink = pile{{"lead white",5},{"rose madder",0.5},{"yellow ochre",0.6},{"vermilion",0.06}, name="mPink"}
local mclip = mtnM - hillM:shrink(2)
local c = worley{seed=321, period=34}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.5); return id end
local function inA(x,y) return mA:at(x,y) end
local function inB(x,y) return mB:at(x,y) end
local function inC(x,y) return mC:at(x,y) end
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.3)%1; return (f>=lo and f<hi) and 1 or 0.06 end end
local gate = mask(function(x,y) local f=(cid(x,y)*2.9)%1; return f < 0.6 and 1 or 0 end)
work(mclip * gate, {hand="hatch", tool={kind="flat", width=7}, length={14,26}, angle=function(x,y) local id=cid(x,y); return -0.9*inB(x,y) - 0.5*inA(x,y) - 0.35*inC(x,y) + 0.7*(((id*3.3)%1)-0.5) end, angle_jitter=0.08,
  piles={{mLit2,function(x,y) return sel(0,0.3)(x,y)*(inA(x,y)+inC(x,y)+0.2) end},
         {mViol,function(x,y) return sel(0.3,0.55)(x,y)*(inB(x,y)+0.3) end},
         {mOchG,function(x,y) return sel(0.55,0.72)(x,y)*clamp((y-250)/60,0.1,1) end},
         {mPink,function(x,y) return sel(0.72,0.88)(x,y)*(inA(x,y)+inC(x,y)+0.1) end},
         {mDeep,function(x,y) return sel(0.88,1)(x,y)*(inB(x,y)+0.15) end}},
  coverage=0.9, clump=0.4, edge="soft", clip=mtnM:grow(1), load=0.75})

--@ chunk 83
print(wait(6*24*60))
print(drying(600,250), drying(700,280), drying(500,300), drying(450,450), drying(800,450))

--@ chunk 84
local mclip = mtnM:grow(1) - hillM:shrink(2)
local n = noise{seed=331, period=40}
local gate = mask(function(x,y) return n(x,y) > -0.25 and 1 or 0 end)
-- restate shadow plane B (inset from its edges so lit plane reads)
local Bm = poly({{652,172},{668,200},{652,262},{625,312},{608,346},{722,346},{732,300},{742,260},{758,218},{700,190}})
work(Bm * gate, {hand="hatch", tool={kind="flat", width=8}, length={16,30}, angle=-1.25, angle_jitter=0.12, piles={{mViol,1},{mDeep,0.5},{mGreen,0.12}}, coverage=1.0, clump=0.4, edge="soft", clip=mclip, load=0.8})
-- a secondary shaded plane on the left flank (a ravine) to break the cone
local Am = poly({{470,282},{520,256},{540,262},{515,300},{490,346},{450,346},{462,315}})
work(Am * gate, {hand="hatch", tool={kind="flat", width=7}, length={14,26}, angle=-1.1, angle_jitter=0.12, piles={{mViol,1},{mLit2,0.3}}, coverage=1.0, clump=0.4, edge="soft", clip=mclip, load=0.7})

--@ chunk 85
line2 = pile{{"ultramarine blue",1},{"cobalt blue",1},{"lead white",0.8},{"rose madder",0.2}, medium=0.15, name="line2"}
lb = brush{kind="round", width=4, point=0.5}
local function seg(pts, load) lb:load(line2, load or 0.5); lb:gesture(pts, {wobble=1.2}) end
seg({{440,293,0.1},{480,275,0.45},{520,253,0.35},{545,238,0.05}})
seg({{575,208,0.1},{610,186,0.5},{645,170,0.3}})
seg({{672,180,0.05},{705,190,0.4},{735,203,0.1}})
seg({{830,238,0.1},{870,252,0.35},{905,264,0.05}})
seg({{652,174,0.3},{648,205,0.25},{640,235,0.05}})

--@ chunk 86
print(drying(100,435), drying(100,490), drying(60,380))
local tr = (trunk1M + trunk2M):grow(2)
local band = (below({{0,312},{300,326},{450,322}}) * above({{0,352},{450,350}})) * rect(0,300,430,60) - tr
local n = noise{seed=341, period=60}
work(band, {hand="hatch", tool={kind="flat", width=6}, length={10,20}, angle=function(x,y) return -0.4 + 0.6*n(x,y) end, angle_jitter=0.15,
  piles={{hBlue,function(x,y) return 0.7+0.4*n(x+70,y) end},{hViol,0.6},{hOch,0.2},{tFar,0.25}}, coverage=1.5, clump=0.4, edge="soft", clip=rect(0,300,430,52) - tr})
for _,t in ipairs({t1,t2}) do
  local m = trunkMask(t) * (rect(0,295,400,90))
  work(m, {hand="hatch", tool={kind="flat", width=5}, length={10,20}, angle=-1.5, angle_jitter=0.15, clip=true, coverage=2.4,
    piles={{trLit,function(x,y) local cx,w=cxAt(t,y); return clamp(0.8-(x-cx)/w*2.2,0,1) end},
           {trMid,function(x,y) local cx,w=cxAt(t,y); return clamp(0.6-math.abs((x-cx)/w)*1.6,0,1) end},
           {trDk,function(x,y) local cx,w=cxAt(t,y); return clamp(0.05+(x-cx)/w*2.4,0,1) end}}})
end

--@ chunk 87
for _,p in ipairs({{700,600},{800,620},{650,720},{100,740},{200,700},{300,525},{950,700}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 88
-- right meadow: a field edge running diagonally, a cooler fallow patch, a few warm earth patches
local right = (fgM - (fgM * mask(function(x,y) return x < 545 and 1 or 0 end))) - ridgeBush:shrink(3) - bushR:shrink(3) - shadow1:shrink(4) - shadow2:shrink(4) - roadM:grow(2)
local fallow = poly({{620,575},{760,560},{880,552},{930,566},{900,600},{780,612},{660,612}}, true):roughen(8,40,71)
local warm = poly({{700,620},{820,612},{880,632},{850,660},{740,664},{690,648}}, true):roughen(8,40,72)
cGreenGrey = pile{{"lead white",2.5},{"viridian",0.6},{"cobalt blue",0.4},{"yellow ochre",0.7},{"rose madder",0.1}, name="cGreenGrey"}
local n = noise{seed=351, period=45}
work(fallow * right, {hand="hatch", tool={kind="flat", width=10}, length={22,38}, angle=function(x,y) return -0.15+0.4*n(x,y) end, angle_jitter=0.08,
  piles={{cGreenGrey,1},{pSage,0.6},{shadeL,0.3},{fPale,0.3}}, coverage=1.1, clump=0.5, edge="soft"})
work(warm * right, {hand="hatch", tool={kind="flat", width=10}, length={22,38}, angle=function(x,y) return -0.8+0.4*n(x,y) end, angle_jitter=0.08,
  piles={{orangeE,1},{earthW,0.8},{fGold,0.3}}, coverage=1.1, clump=0.5, edge="soft"})
-- field edge with low wall: warm stone line + shadow beneath
local wallL = ribbon({{560,622},{640,616},{720,608}}, 5)
wallStone = pile{{"lead white",3},{"yellow ochre",1},{"rose madder",0.15},{"cobalt blue",0.1}, name="wallStone"}
local wb2 = brush{kind="flat", width=5}
wb2:load(wallStone, 0.6)
wb2:stroke({{562,621},{600,618},{640,615}}, {pressure=0.6})
wb2:load(wallStone, 0.6)
wb2:stroke({{648,614},{690,610},{722,606}}, {pressure=0.55})
wb2:load(shG2, 0.5)
wb2:stroke({{566,627},{610,624},{650,620}}, {pressure=0.45})
wb2:load(shG2, 0.5)
wb2:stroke({{655,620},{700,616},{730,612}}, {pressure=0.4})

--@ chunk 89
-- tone down the bright sunlit patch bottom-left: olive/green-grey patches over parts
local tr = (trunk1M + trunk2M):grow(2)
local n = noise{seed=361, period=40}
local gate = mask(function(x,y) return n(x,y) > -0.05 and 1 or 0 end)
work((sunL * gate) - tr, {hand="hatch", tool={kind="flat", width=12}, length={24,42}, angle=function(x,y) return -1.0+0.5*n(x+11,y) end, angle_jitter=0.08,
  piles={{cOlive,1},{gMid,0.6},{gDeepW,0.4},{earthD,0.4}}, coverage=1.0, clump=0.5, edge="soft"})
-- road shadow: lighter gaps (sun flecks) and broken edge
local flecks = (ellipse(640,700,22,6) + ellipse(600,742,30,7) + ellipse(690,735,18,5) + ellipse(660,775,26,6)):roughen(4,14,73) * roadM
work(flecks, {hand="hatch", tool={kind="flat", width=9}, length={18,30}, angle=-0.15, angle_jitter=0.1, piles={{road,1},{earthW,0.25}}, coverage=1.0, clump=0.4, edge="soft"})

--@ chunk 90
local fallow = poly({{620,575},{760,560},{880,552},{930,566},{900,600},{780,612},{660,612}}, true):roughen(8,40,71)
local warm = poly({{700,620},{820,612},{880,632},{850,660},{740,664},{690,648}}, true):roughen(8,40,72)
local n = noise{seed=371, period=30}
local gate = mask(function(x,y) return n(x,y) > -0.2 and 1 or 0 end)
work(fallow:grow(4) * gate - bushR:shrink(3) - roadM:grow(2), {hand="hatch", tool={kind="flat", width=10}, length={22,38}, angle=function(x,y) return -0.5+0.4*n(x+5,y) end, angle_jitter=0.1,
  piles={{gMid,1},{gYel,0.8},{pOlive,0.5}}, coverage=0.9, clump=0.5, edge="soft"})
work(warm * mask(function(x,y) return n(x+200,y) > 0.05 and 1 or 0 end), {hand="hatch", tool={kind="flat", width=10}, length={22,38}, angle=function(x,y) return -0.7+0.4*n(x,y) end, angle_jitter=0.1,
  piles={{gYel,1},{fGold,0.6}}, coverage=0.8, clump=0.5, edge="soft"})
-- soften the wall rod
local wl = ribbon({{560,622},{640,616},{730,610}}, 9)
work(wl * mask(function(x,y) return n(x,y+50) > -0.1 and 1 or 0 end), {hand="hatch", tool={kind="flat", width=7}, length={12,20}, angle=-0.6, angle_jitter=0.2, piles={{gYel,1},{gMid,0.6}}, coverage=0.9, clump=0.4, edge="soft"})
-- road flecks: tie them with shadow color edges
local flecks = (ellipse(640,700,22,6) + ellipse(600,742,30,7) + ellipse(690,735,18,5) + ellipse(660,775,26,6)):roughen(4,14,73) * roadM
work(flecks:rim(6, 3), {hand="hatch", tool={kind="flat", width=7}, length={12,22}, angle=-0.15, angle_jitter=0.1, piles={{shR3,1},{earthW,0.3},{road,0.3}}, coverage=0.9, clump=0.4, edge="soft"})

--@ chunk 91
print(wait(10*24*60))
for _,p in ipairs({{700,600},{800,640},{650,720},{100,740},{200,320},{600,250},{620,700}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 92
local sk = (skyM - canopy:grow(3) - mtnM:grow(5) - hillM - (trunk1M+trunk2M):grow(3)) * mask(function(x,y) return x < 560 and 1 or 0 end)
local c = worley{seed=381, period=60}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.3); return id end
local dens = mask(function(x,y) return ((cid(x,y)*4.1)%1) < 0.5 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*6.7)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(sk * dens, {hand="hatch", tool={kind="flat", width=11}, length={22,38}, angle=function(x,y) return -1.0 + 0.5*(((cid(x,y)*2.3)%1)-0.5) end, angle_jitter=0.07,
  piles={{skyK,sel(0,0.4)},{skyG,sel(0.4,0.65)},{skyH,sel(0.65,1)}}, coverage=0.9, clump=0.4, edge="soft", load=0.7, clip=skyM - mtnM:grow(3) - (trunk1M+trunk2M):grow(2)})

--@ chunk 93
-- passage at canopy edges: short strokes of canopy greens into sky and sky into canopy, sparse
local rim = canopy:rim(10, 4)
local n = noise{seed=391, period=22}
local g1 = mask(function(x,y) return n(x,y) > 0.35 and 1 or 0 end)
local g2 = mask(function(x,y) return n(x,y) < -0.45 and 1 or 0 end)
work(rim * g1 - (trunk1M+trunk2M):grow(2), {hand="hatch", tool={kind="flat", width=7}, length={12,22}, angle=-0.6, angle_jitter=0.25, piles={{cMid,1},{cBlue,0.6},{cOlive,0.3}}, coverage=0.8, clump=0.5, edge="soft", load=0.6})
work(rim * g2 - (trunk1M+trunk2M):grow(2), {hand="hatch", tool={kind="flat", width=7}, length={12,22}, angle=-0.9, angle_jitter=0.25, piles={{skyE,1},{skyK,0.6}}, coverage=0.8, clump=0.5, edge="soft", load=0.6})
-- blue drawing under canopy masses, broken
local lb2 = brush{kind="round", width=4, point=0.5}
local function seg(pts) lb2:load(line2, 0.45); lb2:gesture(pts, {wobble=2}) end
seg({{350,95,0.1},{400,108,0.4},{450,118,0.4},{500,108,0.1}})
seg({{230,250,0.1},{280,256,0.35},{330,252,0.3},{380,246,0.1}})
seg({{20,290,0.1},{70,300,0.4},{120,296,0.1}})
seg({{60,190,0.1},{120,198,0.35},{170,194,0.1}})

--@ chunk 94
r = rag{width=8}
r:dip(0.8)
local L = {
 {{230,250},{280,256},{330,252},{380,246}},
 {{20,290},{70,300},{120,296}},
 {{60,190},{120,198},{170,194}},
 {{350,95},{400,108},{450,118},{500,108}},
}
for _,l in ipairs(L) do
  for i=1,3 do r:wipe(l, {pressure=0.8}); r:refold() end
  r:dip(0.6)
end
print(r)

--@ chunk 95
print(wait(7*24*60))
print(drying(258,100), drying(160,290), drying(300,250))

--@ chunk 96
-- trunk seam fix
for _,t in ipairs({t1}) do
  local m = trunkMask(t) * rect(0,262,400,60)
  work(m, {hand="hatch", tool={kind="flat", width=5}, length={14,26}, angle=-1.5, angle_jitter=0.15, clip=true, coverage=2.2,
    piles={{trLit,function(x,y) local cx,w=cxAt(t,y); return clamp(0.8-(x-cx)/w*2.2,0,1) end},
           {trMid,function(x,y) local cx,w=cxAt(t,y); return clamp(0.6-math.abs((x-cx)/w)*1.6,0,1) end},
           {trDk,function(x,y) local cx,w=cxAt(t,y); return clamp(0.05+(x-cx)/w*2.4,0,1) end}}})
end
-- tint the brightest sky holes in the canopy
local holes = ellipse(425,146,22,12) + ellipse(258,100,14,8) + ellipse(330,200,22,14) + ellipse(395,195,14,10) + ellipse(560,85,10,8)
local sb2 = brush{kind="flat", width=8}
work(holes * canopy:grow(10), {hand="hatch", tool={kind="flat", width=7}, length={10,18}, angle=-1.0, angle_jitter=0.2, piles={{skyK,1},{skyE,0.5}}, coverage=0.8, clump=0.4, edge="soft", load=0.6})

--@ chunk 97
local tr = (trunk1M + trunk2M):grow(2)
local strip = (below({{0,506},{380,510}}) * above({{0,572},{200,566},{380,560}})) * rect(0,500,372,80) - tr - housesM:grow(2) - ridgeBush
local n = noise{seed=401, period=50}
work(strip, {hand="hatch", tool={kind="flat", width=9}, length={18,32}, angle=function(x,y) return -0.35 + 0.5*n(x,y) end, angle_jitter=0.1,
  piles={{pOlive,1},{bankO,function(x,y) return clamp(0.5+0.6*n(x+40,y),0,1) end},{gMid,0.5},{oliveD,function(x,y) return clamp((y-540)/25,0,1)*0.8 end}},
  coverage=1.3, clump=0.4, edge="soft", clip=rect(0,505,374,75) - tr})

--@ chunk 98
local tr = (trunk1M + trunk2M):grow(2)
local c = worley{seed=411, period=40}
local function cid(x,y) local _,_,_,id = c:at(x,y*2.5); return id end
local gate = mask(function(x,y) return ((cid(x,y)*3.9)%1) < 0.55 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*6.1)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(hillM * gate - tr - canopy, {hand="hatch", tool={kind="flat", width=6}, length={10,20}, angle=function(x,y) return -0.4 + 0.8*(((cid(x,y)*2.7)%1)-0.5) end, angle_jitter=0.1,
  piles={{hOch,sel(0,0.3)},{hBlue,sel(0.3,0.55)},{mGreen,sel(0.55,0.8)},{mViol,sel(0.8,1)}}, coverage=1.0, clump=0.4, edge="soft", clip=hillM:grow(2) - tr, load=0.7})

--@ chunk 99
cWarm = pile{{"viridian",0.5},{"yellow ochre",1},{"emerald green",0.4},{"red earth",0.1},{"lead white",0.4}, name="cWarm"}
local n = noise{seed=421, period=30}
local g = mask(function(x,y) return n(x,y) > 0.4 and 1 or 0 end)
work(canopy:shrink(8) * g, {hand="hatch", tool={kind="flat", width=7}, length={12,22}, angle=function(x,y) return -0.5+0.6*n(x+30,y) end, angle_jitter=0.2,
  piles={{cWarm,1},{cOlive,0.6},{cMid,0.4}}, coverage=0.7, clump=0.5, edge="soft", load=0.6})

--@ chunk 100
local n = noise{seed=421, period=30}
local g = mask(function(x,y) return (n(x,y) > 0.28) and 1 or 0 end)
work(canopy:shrink(8) * g, {hand="hatch", tool={kind="flat", width=8}, length={14,24}, angle=function(x,y) return -0.5+0.6*n(x+30,y) end, angle_jitter=0.2,
  piles={{cMid,1},{cBlue,0.4},{cOlive,0.3}}, coverage=0.6, clump=0.3, edge="soft", load=0.5})

--@ chunk 101
print(wait(8*24*60))
print(drying(130,700), drying(255,700), drying(200,540), drying(300,100))

--@ chunk 102
for _,t in ipairs({t1,t2}) do
  local m = trunkMask(t) * rect(0,560,400,250)
  work(m, {hand="hatch", tool={kind="flat", width=6}, length={12,24}, angle=function(x,y) return -1.5 + 0.3*math.sin(y/19) end, angle_jitter=0.15, clip=true, coverage=2.2,
    piles={{trLit,function(x,y) local cx,w=cxAt(t,y); return clamp(0.8-(x-cx)/w*2.2,0,1) end},
           {trMid,function(x,y) local cx,w=cxAt(t,y); return clamp(0.6-math.abs((x-cx)/w)*1.6,0,1) end},
           {trGreen,function(x,y) local cx,w=cxAt(t,y); return clamp(0.4-math.abs((x-cx)/w-0.1)*1.4,0,1)*(0.5+0.5*math.sin(y/29)) end},
           {trDk,function(x,y) local cx,w=cxAt(t,y); return clamp(0.05+(x-cx)/w*2.4,0,1) end}}})
end
-- trunk contour: a muted dark violet-blue on the shadow side, broken, replacing the electric blue
lineT = pile{{"ultramarine blue",1},{"red earth",0.6},{"rose madder",0.3},{"lead white",0.3}, medium=0.15, name="lineT"}
lb = brush{kind="round", width=4.5, point=0.5}
local function seg(pts) lb:load(lineT, 0.5); lb:gesture(pts, {wobble=1}) end
seg({{168,200,0.1},{164,290,0.5},{159,380,0.45},{155,450,0.1}})
seg({{153,500,0.2},{148,600,0.5},{143,700,0.5},{141,800,0.3}})
seg({{290,270,0.1},{283,350,0.4},{278,430,0.1}})
seg({{272,500,0.2},{268,600,0.45},{265,700,0.5},{263,800,0.3}})

--@ chunk 103
print(drying(700,580), drying(650,750), drying(560,650))
local n = noise{seed=431, period=40}
-- warm the chalky pale green band
local band = poly({{600,560},{760,548},{900,545},{935,566},{900,604},{780,612},{640,615},{600,600}}, true) - bushR:shrink(2) - roadM:grow(2)
work(band, {hand="hatch", tool={kind="flat", width=10}, length={22,38}, angle=function(x,y) return -0.3+0.45*n(x,y) end, angle_jitter=0.08,
  piles={{gYel,1},{fGold,function(x,y) return clamp(0.4+0.6*n(x+70,y),0,1) end},{gMid,0.5},{pOlive,0.4}}, coverage=1.0, clump=0.5, edge="soft", load=0.8})
-- temper the hot orange patch
local warm = poly({{690,612},{830,606},{890,632},{860,668},{740,670},{680,650}}, true)
work(warm * mask(function(x,y) return n(x+300,y) > -0.15 and 1 or 0 end), {hand="hatch", tool={kind="flat", width=10}, length={22,38}, angle=function(x,y) return -0.8+0.4*n(x,y) end, angle_jitter=0.08,
  piles={{fGold,1},{gYel,0.7},{earthD,0.4}}, coverage=0.8, clump=0.5, edge="soft", load=0.7})

--@ chunk 104
-- road: rebuild the near road as one plane: warm light far, cool shadow near, with broken transitions
local n = noise{seed=441, period=35}
local rm = roadM
local nearRoad = rm * below({{500,676},{850,670}})
roadW = pile{{"lead white",3},{"yellow ochre",1.2},{"red earth",0.25},{"rose madder",0.1}, name="roadW"}
work(nearRoad, {hand="hatch", tool={kind="flat", width=12}, length={26,44}, angle=function(x,y) return -0.12+0.3*n(x,y) end, angle_jitter=0.06,
  piles={{shR3,1},{mViol,0.35},{roadW,function(x,y) return clamp(n(x+40,y*1.5)-0.25,0,1)*1.2 end},{shG2,0.1}}, coverage=1.1, clump=0.5, edge="soft", clip=rm:grow(6)})
-- soften the left road edge line with earth/green strokes along it
local edgeL = ribbon({{520,570},{540,615},{555,660},{568,700}}, 10)
work(edgeL, {hand="hatch", tool={kind="flat", width=7}, length={12,22}, angle=-1.1, angle_jitter=0.2, piles={{earthD,1},{gMid,0.6},{roadW,0.3}}, coverage=1.0, clump=0.4, edge="soft", load=0.7})

--@ chunk 105
print(wait(6*24*60))
print(drying(650,750), drying(545,640), drying(700,580))

--@ chunk 106
print(palette())

--@ chunk 107
earthW = pile{{"yellow ochre",1.5},{"red earth",0.7},{"vermilion",0.15},{"lead white",1}, name="earthW"}
shR2 = pile{{"lead white",1},{"cobalt blue",1},{"ultramarine blue",0.4},{"rose madder",0.4},{"yellow ochre",0.2}, name="shR2"}
mDeep = pile{{"lead white",2},{"ultramarine blue",1},{"cobalt blue",0.6},{"rose madder",0.5},{"viridian",0.15}, name="mDeep"}
pRose = pile{{"lead white",3},{"red earth",0.4},{"yellow ochre",0.8},{"rose madder",0.15}, name="pRose"}
gDeepW = pile{{"viridian",1.5},{"ultramarine blue",0.7},{"yellow ochre",0.8},{"red earth",0.2},{"lead white",0.3}, name="gDeepW"}
local c = worley{seed=451, period=32}
local function cid(x,y) local _,_,_,id = c:at(x,y*2); return id end
local gate = mask(function(x,y) return ((cid(x,y)*4.3)%1) < 0.4 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*6.7)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
local nearRoad = roadM * below({{500,680},{850,672}})
work(nearRoad * gate, {hand="hatch", tool={kind="flat", width=10}, length={20,36}, angle=function(x,y) return -0.15+0.5*(((cid(x,y)*2.1)%1)-0.5) end, angle_jitter=0.06,
  piles={{roadW,sel(0,0.35)},{earthW,sel(0.35,0.5)},{shR2,sel(0.5,0.75)},{mDeep,sel(0.75,0.88)},{pRose,sel(0.88,1)}}, coverage=1.0, clump=0.4, edge="soft", clip=roadM:grow(3), load=0.75})
local edgeL = ribbon({{515,572},{536,615},{552,660},{566,700}}, 14)
work(edgeL, {hand="hatch", tool={kind="flat", width=9}, length={20,34}, angle=-1.25, angle_jitter=0.12, piles={{gDeepW,1},{gMid,0.6},{earthD,0.5}}, coverage=1.1, clump=0.3, edge="soft"})

--@ chunk 108
wallPink = pile{{"lead white",4},{"yellow ochre",0.8},{"rose madder",0.25},{"vermilion",0.08}, name="wallPink"}
wallCool = pile{{"lead white",4},{"yellow ochre",0.6},{"cobalt blue",0.25},{"viridian",0.08}, name="wallCool"}
wallLit = pile{{"lead white",5},{"yellow ochre",1},{"vermilion",0.08}, name="wallLit"}
local n = noise{seed=461, period=14}
local wins = mask(function() return 1 end)
for i,h in ipairs(houses) do
  local wm = poly(h.wall):shrink(1.5)
  local g = mask(function(x,y) return n(x+i*50,y) > -0.1 and 1 or 0 end)
  work(wm * g, {hand="hatch", tool={kind="flat", width=4}, length={7,12}, angle=-1.5, angle_jitter=0.15,
    piles={{wallPink,function(x,y) return clamp(0.5+n(x,y+30),0,1) end},{wallCool,function(x,y) return clamp(0.4-n(x,y+30),0,1) end},{wallLit,0.4}},
    coverage=0.8, clump=0.3, clip=wm, load=0.6})
end
roofP = pile{{"vermilion",1},{"red earth",1.2},{"yellow ochre",0.8},{"lead white",0.9}, name="roofP"}
roofD = pile{{"red earth",1.5},{"rose madder",0.5},{"ultramarine blue",0.35},{"lead white",0.4}, name="roofD"}
for i,h in ipairs(houses) do
  local rm2 = poly(h.roof):shrink(1)
  local g = mask(function(x,y) return n(x+i*70,y*2) > 0.0 and 1 or 0 end)
  work(rm2 * g, {hand="hatch", tool={kind="flat", width=4}, length={7,12}, angle=-0.2, angle_jitter=0.2,
    piles={{roofP,1},{roofD,function(x,y) return clamp(-n(x,y*2),0,1) end}}, coverage=0.8, clump=0.3, clip=rm2, load=0.6})
end

--@ chunk 109
print(wait(4*24*60))
print(drying(570,470), drying(460,490), drying(650,500))

--@ chunk 110
shdWarm = pile{{"lead white",2},{"yellow ochre",1.2},{"cobalt blue",0.35},{"red earth",0.25},{"rose madder",0.1}, name="shdWarm"}
wallShd = pile{{"lead white",3},{"cobalt blue",0.9},{"rose madder",0.3},{"yellow ochre",0.4}, name="wallShd"}
for _,p in ipairs(hs) do
  work(poly(p), {hand="hatch", tool={kind="flat", width=5}, length={9,15}, angle=-1.5, angle_jitter=0.1, piles={{shdWarm,1},{wallShd,0.5}}, coverage=1.5, clip=true})
end
for _,h in ipairs(houses) do
  if h.side then work(poly(h.side), {hand="hatch", tool={kind="flat", width=5}, length={9,15}, angle=-1.45, angle_jitter=0.1, piles={{shdWarm,1},{wallShd,0.5}}, coverage=1.5, clip=true}) end
end
winP = pile{{"ultramarine blue",1},{"red earth",0.7},{"lead white",0.5}, name="winP"}
local wb = brush{kind="flat", width=4}
local wins = {{440,480},{470,480},{440,505},{550,445},{550,480},{625,490},{655,490},{625,515},{725,465},{725,490},{800,495},{830,495},{385,520},{485,428},{660,434}}
for _,w in ipairs(wins) do
  wb:load(winP, 0.5)
  wb:stroke({{w[1],w[2]},{w[1],w[2]+8}}, {pressure=0.7})
end
-- eaves shadow, short and broken
local eav = {{422,463,498},{602,471,698},{712,445,768},{537,425,588},{782,477,858},{372,507,418}}
local eb = brush{kind="flat", width=3}
for _,e in ipairs(eav) do
  local x = e[1]
  while x < e[3]-4 do
    local l = rand(10,22)
    eb:load(wallShd, 0.5)
    eb:stroke({{x, e[2]-1},{math.min(x+l, e[3]), e[2]-1}}, {pressure=0.6})
    x = x + l + rand(2,8)
  end
end

--@ chunk 111
print(wait(5*24*60))
print(drying(570,470), drying(460,465), drying(650,500))
shdDeep = pile{{"lead white",1.5},{"yellow ochre",0.8},{"cobalt blue",0.6},{"rose madder",0.25},{"red earth",0.15}, name="shdDeep"}
local n = noise{seed=471, period=16}
for _,p in ipairs(hs) do
  work(poly(p), {hand="hatch", tool={kind="flat", width=4}, length={8,14}, angle=-1.5, angle_jitter=0.12, piles={{shdDeep,1},{shdWarm,function(x,y) return clamp(0.4+n(x,y),0,1) end}}, coverage=1.2, clip=true})
end
for _,h in ipairs(houses) do
  if h.side then work(poly(h.side), {hand="hatch", tool={kind="flat", width=4}, length={8,14}, angle=-1.45, angle_jitter=0.12, piles={{shdDeep,1},{shdWarm,function(x,y) return clamp(0.4+n(x,y),0,1) end}}, coverage=1.2, clip=true}) end
end
eaveD = pile{{"red earth",1},{"ultramarine blue",0.6},{"rose madder",0.3},{"lead white",0.6}, name="eaveD"}
local eav = {{422,463,498},{602,471,698},{712,445,768},{537,425,588},{782,477,858},{372,507,418}}
local eb = brush{kind="flat", width=3}
for _,e in ipairs(eav) do
  local x = e[1]
  while x < e[3]-4 do
    local l = rand(12,26)
    eb:load(eaveD, 0.45)
    eb:stroke({{x, e[2]-1},{math.min(x+l, e[3]), e[2]-0.5}}, {pressure=0.55})
    x = x + l + rand(1,5)
  end
end

--@ chunk 112
shdDeep2 = pile{{"lead white",1},{"yellow ochre",0.7},{"cobalt blue",0.8},{"ultramarine blue",0.2},{"rose madder",0.3}, name="shdDeep2"}
local n = noise{seed=481, period=12}
for _,p in ipairs(hs) do
  local m = poly(p):shrink(1)
  work(m * mask(function(x,y) return n(x,y) > -0.3 and 1 or 0 end), {hand="hatch", tool={kind="flat", width=4}, length={8,14}, angle=-1.5, angle_jitter=0.12, pile=shdDeep2, coverage=1.0, clip=m, load=0.7})
end
for _,h in ipairs(houses) do
  if h.side then local m = poly(h.side):shrink(1); work(m * mask(function(x,y) return n(x,y) > -0.3 and 1 or 0 end), {hand="hatch", tool={kind="flat", width=4}, length={8,14}, angle=-1.45, angle_jitter=0.12, pile=shdDeep2, coverage=1.0, clip=m, load=0.7}) end
end

--@ chunk 113
print(drying(150,420), drying(200,490))
local tr = (trunk1M + trunk2M):grow(2)
local area = rect(0,372,425,135) * (below({{0,372},{430,372}})) - tr - treeBack:grow(2) - housesM:grow(2)
local c = worley{seed=491, period=45}
local function cid(x,y) local _,_,_,id = c:at(x,y*2.2); return id end
local gate = mask(function(x,y) return ((cid(x,y)*3.3)%1) < 0.45 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.9)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(area * gate, {hand="hatch", tool={kind="flat", width=7}, length={14,26}, angle=function(x,y) return -0.3 + 1.0*(((cid(x,y)*2.7)%1)-0.5) end, angle_jitter=0.08,
  piles={{pOlive,sel(0,0.25)},{fGold,sel(0.25,0.4)},{gMid,sel(0.4,0.55)},{pRose,sel(0.55,0.7)},{oliveD,sel(0.7,0.82)},{hBlue,sel(0.82,1)}},
  scale_at=function(x,y) return lerp(0.7,1.1,clamp((y-372)/135,0,1)) end, coverage=0.9, clump=0.4, edge="soft", load=0.75, clip=rect(0,370,428,140) - tr})

--@ chunk 114
local area = (rect(560,362,440,115) - housesM:grow(3) - treeBack:grow(2) - ridgeBush) * (below({{560,360},{1000,358}}))
local c = worley{seed=501, period=45}
local function cid(x,y) local _,_,_,id = c:at(x,y*2.2); return id end
local gate = mask(function(x,y) return ((cid(x,y)*3.3)%1) < 0.45 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.9)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(area * gate, {hand="hatch", tool={kind="flat", width=7}, length={14,26}, angle=function(x,y) return -0.3 + 1.0*(((cid(x,y)*2.7)%1)-0.5) end, angle_jitter=0.08,
  piles={{pOlive,sel(0,0.25)},{fGold,sel(0.25,0.4)},{gMid,sel(0.4,0.55)},{pRose,sel(0.55,0.7)},{oliveD,sel(0.7,0.82)},{hBlue,sel(0.82,1)}},
  scale_at=function(x,y) return lerp(0.6,1.0,clamp((y-362)/115,0,1)) end, coverage=0.9, clump=0.4, edge="soft", load=0.75, clip=area:grow(1)})
-- mid-left flat green band y 500-545: break it with olive/ochre patches
local tr = (trunk1M + trunk2M):grow(2)
local band = rect(0,498,372,50) - tr - housesM:grow(2) - treeBack:grow(2)
local c2 = worley{seed=502, period=55}
local function cid2(x,y) local _,_,_,id = c2:at(x,y*2); return id end
local gate2 = mask(function(x,y) return ((cid2(x,y)*3.7)%1) < 0.5 and 1 or 0 end)
local function sel2(lo,hi) return function(x,y) local f=(cid2(x,y)*5.3)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(band * gate2, {hand="hatch", tool={kind="flat", width=9}, length={18,32}, angle=function(x,y) return -0.2 + 0.9*(((cid2(x,y)*2.7)%1)-0.5) end, angle_jitter=0.08,
  piles={{bankO,sel2(0,0.3)},{oliveD,sel2(0.3,0.5)},{gYel,sel2(0.5,0.75)},{cOlive,sel2(0.75,1)}}, coverage=0.9, clump=0.4, edge="soft", load=0.75, clip=band:grow(1)})

--@ chunk 115
print(wait(6*24*60))
for _,p in ipairs({{300,620},{100,700},{450,600},{700,580},{750,640},{950,700}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 116
local tr = (trunk1M + trunk2M):grow(2)
local rim = (rect(0,555,520,38)) - tr - roadM
local n = noise{seed=511, period=26}
local gUp = mask(function(x,y) return n(x,y) > 0.15 and 1 or 0 end)
local gDn = mask(function(x,y) return n(x,y) < -0.25 and 1 or 0 end)
work(rim * gUp, {hand="hatch", tool={kind="flat", width=9}, length={18,32}, angle=-1.15, angle_jitter=0.2, piles={{gDeepW,1},{gDark,0.6},{cBlue,0.3}}, coverage=0.9, clump=0.4, edge="soft", load=0.7})
work(rim * gDn, {hand="hatch", tool={kind="flat", width=9}, length={16,28}, angle=-0.9, angle_jitter=0.2, piles={{pOlive,1},{bankO,0.5},{gYel,0.4}}, coverage=0.8, clump=0.4, edge="soft", load=0.6})
-- warm flecks of light in the cast shadow at bottom right of left half
local sh = (shadow1 + shadow2) - roadM:grow(2) - bushR - tr
local g3 = mask(function(x,y) return n(x*1.3,y*1.3+100) > 0.45 and 1 or 0 end)
work(sh * g3, {hand="hatch", tool={kind="flat", width=9}, length={18,30}, angle=-0.25, angle_jitter=0.15, piles={{gYel,1},{fGold,0.5},{earthD,0.3}}, coverage=0.8, clump=0.4, edge="soft", load=0.6})

--@ chunk 117
local tr = (trunk1M + trunk2M):grow(2)
local n = noise{seed=511, period=26}
local sh = (shadow1 + shadow2) - roadM:grow(2) - bushR - tr
local g3 = mask(function(x,y) return n(x*1.3,y*1.3+100) > 0.45 and 1 or 0 end)
r = rag{width=14}
r:dip(0.8)
r:wipe((sh*g3):grow(6), {pressure=0.75, angle=-0.25, passes=3, refold=0.25})
print(r)
print(drying(400,740))

--@ chunk 118
local tr = (trunk1M + trunk2M):grow(2)
local n = noise{seed=511, period=26}
local sh = (shadow1 + shadow2) - roadM:grow(2) - bushR - tr
local g3 = mask(function(x,y) return n(x*1.3,y*1.3+100) > 0.45 and 1 or 0 end)
work((sh*g3):grow(5), {hand="hatch", tool={kind="flat", width=11}, length={26,42}, angle=-0.2, angle_jitter=0.08, piles={{shG2,1},{gDeepW,0.6},{gMid,0.3}}, coverage=1.0, clump=0.3, edge="soft", load=0.7})

--@ chunk 119
local tr = (trunk1M + trunk2M):grow(2)
local band = (below({{0,347},{1000,345}}) * above({{0,362},{1000,360}})) - tr
local c = worley{seed=521, period=30}
local function cid(x,y) local _,_,_,id = c:at(x,y*3); return id end
local gate = mask(function(x,y) return ((cid(x,y)*3.1)%1) < 0.55 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.7)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(band * gate, {hand="hatch", tool={kind="flat", width=4}, length={7,14}, angle=function(x,y) return -0.1 + 0.8*(((cid(x,y)*2.3)%1)-0.5) end, angle_jitter=0.1,
  piles={{tFar,sel(0,0.4)},{hBlue,sel(0.4,0.65)},{pSage,sel(0.65,0.85)},{hOch,sel(0.85,1)}}, coverage=1.1, clump=0.4, edge="soft", load=0.7, clip=band:grow(2)})

--@ chunk 120
print(drying(580,620))
roadLit2 = pile{{"lead white",4},{"yellow ochre",1},{"vermilion",0.06},{"rose madder",0.08}, name="roadLit2"}
roadPk = pile{{"lead white",3.5},{"red earth",0.3},{"yellow ochre",0.7},{"rose madder",0.15}, name="roadPk"}
local m = roadM * rect(500,560,300,125)
local c = worley{seed=531, period=24}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.6); return id end
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.1)%1; return (f>=lo and f<hi) and 1 or 0.08 end end
work(m, {hand="hatch", tool={kind="flat", width=8}, length={14,26}, angle=function(x,y) return -1.0 + (x-560)/400 + 0.5*(((cid(x,y)*2.9)%1)-0.5) end, angle_jitter=0.08,
  piles={{roadLit2,sel(0,0.45)},{roadPk,sel(0.45,0.7)},{fGold,sel(0.7,0.82)},{shR3,sel(0.82,1)}},
  scale_at=function(x,y) return lerp(0.7,1.0,(y-560)/120) end, coverage=1.3, clump=0.4, edge="soft", clip=roadM:grow(2)})

--@ chunk 121
local m = roadM * rect(500,555,300,130)
local leftSide = m * mask(function(x,y) return x < 545 + (y-560)*0.25 and 1 or 0 end)
local rightSide = m - leftSide
print(lose(leftSide, {pile=gDeepW, where=0.7, tool="filbert 5", reach={10,8}, load=0.35, seed=3}))
print(lose(rightSide, {pile=gYel, where=0.6, tool="filbert 5", reach={10,7}, load=0.3, seed=4}))

--@ chunk 122
local m = roadM:shrink(9) * rect(500,560,300,125)
local c = worley{seed=541, period=22}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.6); return id end
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.1)%1; return (f>=lo and f<hi) and 1 or 0.08 end end
work(m, {hand="hatch", tool={kind="flat", width=8}, length={14,24}, angle=function(x,y) return -1.0 + (x-560)/400 + 0.4*(((cid(x,y)*2.9)%1)-0.5) end, angle_jitter=0.08,
  piles={{roadLit2,sel(0,0.55)},{roadPk,sel(0.55,0.8)},{shR3,sel(0.8,1)}},
  scale_at=function(x,y) return lerp(0.7,1.0,(y-560)/120) end, coverage=1.1, clump=0.4, edge="soft", clip=roadM:shrink(6)})

--@ chunk 123
print(drying(750,580))
local area = (rect(560,548,380,70) - roadM:grow(4) - bushR:shrink(2)) * above({{560,620},{940,612}})
local c = worley{seed=551, period=40}
local function cid(x,y) local _,_,_,id = c:at(x,y*2); return id end
local gate = mask(function(x,y) return ((cid(x,y)*3.7)%1) < 0.5 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.3)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(area * gate, {hand="hatch", tool={kind="flat", width=9}, length={18,30}, angle=function(x,y) return -0.3 + 0.9*(((cid(x,y)*2.7)%1)-0.5) end, angle_jitter=0.08,
  piles={{pOlive,sel(0,0.3)},{fGold,sel(0.3,0.5)},{gMid,sel(0.5,0.7)},{bankO,sel(0.7,0.85)},{shG2,sel(0.85,1)}}, coverage=0.9, clump=0.4, edge="soft", load=0.75})

--@ chunk 124
sig = pile{{"red earth",1},{"ultramarine blue",0.4},{"lead white",0.2}, medium=0.2, name="sig"}
local sb = brush{kind="round", width=2.5, point=0.7}
sb:load(sig, 0.5)
-- a simple "P" style monogram-ish signature: short strokes bottom left
sb:gesture({{30,778,0.3},{31,762,0.5},{32,752,0.3}})
sb:load(sig, 0.4)
sb:gesture({{32,752,0.3},{40,751,0.4},{43,757,0.3},{38,763,0.3},{31,763,0.2}})
sb:load(sig, 0.4)
sb:gesture({{52,764,0.3},{49,770,0.4},{53,776,0.3},{60,775,0.2}})
sb:load(sig, 0.4)
sb:gesture({{66,762,0.2},{68,776,0.4},{72,766,0.3},{76,776,0.3},{79,762,0.2}})

--@ chunk 125
print(wait(14*24*60))

--@ chunk 126
local s="" for i,p in ipairs(mtnTop) do s=s..string.format("(%.0f,%.0f) ", p[1], p[2]) end print(s) s="" for i,p in ipairs(ridge) do s=s..string.format("(%.0f,%.0f) ", p[1], p[2]) end print(s) print(drying(700,250), drying(900,150))

--@ chunk 127
newRidge = {{648,167},{672,170},{708,179},{748,189},{784,192},{800,186},{816,190},{852,202},{900,213},{950,223},{1001,231}}
local pts = {}
for _,p in ipairs(newRidge) do pts[#pts+1] = {p[1], p[2]} end
-- down along old slope, offset 18 into the old mountain
local old = {{1001,286},{900,262},{820,232},{760,214},{700,186},{650,168}}
for _,p in ipairs(old) do pts[#pts+1] = {p[1], p[2] + (p[1] > 660 and 18 or 0)} end
mtnNew = poly(pts):roughen(1.5, 14, 7)
print(mtnNew:area(), drying(800,220), drying(900,240))
mtnM2 = mtnM + mtnNew

--@ chunk 128
local c = worley{seed=511, period=30}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.5); return id end
local function topDist(x,y)
  -- distance below new ridge (approx)
  local ry = 167 + (x-648)*0.18
  return y - ry
end
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.3)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(mtnNew, {hand="hatch", tool={kind="flat", width=8}, length={14,30},
  angle=function(x,y) local id=cid(x,y); return 0.2 - 0.5*((id*7.1)%1) end, angle_jitter=0.08,
  piles={{mtLit, function(x,y) return sel(0,0.35)(x,y) end},
         {mPale, function(x,y) return sel(0.35,0.55)(x,y)*clamp(1.4 - topDist(x,y)/40,0.2,1.4) end},
         {mPink, function(x,y) return sel(0.55,0.75)(x,y) end},
         {mOchG, function(x,y) return sel(0.75,0.85)(x,y) end},
         {mViol, function(x,y) return sel(0.85,1)(x,y)*clamp(topDist(x,y)/30,0.2,1.5) end}},
  coverage=1.35, clump=0.4, edge="firm", clip=mtnNew:grow(1), load=0.8})

--@ chunk 129
for i,h in ipairs(houses) do local s="" for k,v in pairs(h) do if type(v)=="table" then s=s..k.."=tbl("..#v..") " else s=s..k.."="..tostring(v).." " end end print(i,s) end
print(hs and #hs) for k,v in pairs(hs[1]) do print(k,v) end

--@ chunk 130
baseSh = mix{{shG2,0.5},{shadeL,0.8},{gMid,0.3}, name="baseSh"}
local hb = brush{kind="flat", width=4}
hb:load(baseSh, 0.7)
-- trial: house A cast shadow to the right along ground, and contact strip under its front
local m = poly({{532,521},{560,522},{572,527},{556,532},{500,533},{498,529}}):roughen(1,8,3) - housesM
work(m, {hand="hatch", tool=hb, length={8,16}, angle=0.05, angle_jitter=0.1, pile=baseSh, coverage=1.2, clip=true, load=0.7})
hb:load(baseSh,0.5)
hb:stroke({{422,531},{460,532},{498,531}}, {pressure={0.5,0.3}, clip=-housesM})

--@ chunk 131
local hb = brush{kind="flat", width=4}
local function sh(pts, ang)
  local m = poly(pts):roughen(1,8,math.random(1,99)) - housesM
  work(m, {hand="hatch", tool=hb, length={8,16}, angle=ang or 0.05, angle_jitter=0.1, pile=baseSh, coverage=1.2, clip=true, load=0.7})
end
sh({{700,530},{722,531},{738,537},{725,543},{690,543},{688,538}})
sh({{880,519},{900,521},{918,527},{905,533},{870,533},{868,528}})
sh({{590,516},{600,517},{600,524},{585,525}})
sh({{770,506},{780,507},{780,514},{768,515}})
local function strip(a,b,y)
  hb:load(baseSh,0.5)
  hb:stroke({{a,y},{(a+b)/2,y+0.8},{b,y}}, {pressure={0.5,0.3}, clip=-housesM})
end
strip(374,418,546) strip(536,590,523) strip(708,770,513)

--@ chunk 132
shSides = {
 poly({{405,503},{418,503},{418,544},{405,544}}),
 poly({{501,458},{531,446},{531,521},{501,528}}),
 poly({{560,421},{590,421},{590,521},{560,521}}),
 poly({{676,468},{700,468},{700,539},{676,539}}),
 poly({{745,441},{770,441},{770,511},{745,511}}),
 poly({{860,470},{880,468},{880,528},{860,528}}),
}
local all = shSides[2] + shSides[3]
local c = worley{seed=533, period=9}
local gate = mask(function(x,y) local _,_,_,id=c:at(x,y*0.7); return id < 0.45 and 1 or 0 end)
work(all:shrink(1)*gate, {hand="hatch", tool={kind="flat", width=3}, length={6,12}, angle=-1.45, angle_jitter=0.15,
  piles={{shdDeep2,1},{hViol,0.6},{earthW,function(x,y) return clamp((y-470)/50,0,0.8) end}}, coverage=0.9, clip=all, load=0.7})

--@ chunk 133
local all = shSides[1] + shSides[4] + shSides[5] + shSides[6]
local c = worley{seed=541, period=9}
local gate = mask(function(x,y) local _,_,_,id=c:at(x,y*0.7); return id < 0.45 and 1 or 0 end)
work(all:shrink(1)*gate, {hand="hatch", tool={kind="flat", width=3}, length={6,12}, angle=-1.45, angle_jitter=0.15,
  piles={{shdDeep2,1},{hViol,0.6},{earthW,function(x,y) return clamp((y-470)/50,0,0.8) end}}, coverage=0.9, clip=all, load=0.7})

--@ chunk 134
local trees = treeBack + ridgeBush
local ring = (trees:grow(6) - trees:shrink(1)) - housesM:grow(2) - (trunk1M+trunk2M):grow(3)
ring = ring * rect(300, 380, 700, 180)
print(ring:area())
work(ring, {hand="hatch", tool={kind="flat", width=4}, length={7,13}, angle=-0.2, angle_jitter=0.4,
  piles={{gMid,1},{pOlive,0.8},{cMid,0.5},{tDarkF,0.3}}, coverage=1.0, clump=0.3, edge="soft", load=0.7, clip=ring:grow(2) - housesM})

--@ chunk 135
for _,y in ipairs({180,220,260,300,350,400,450,500,600,700}) do local cx,w=cxAt(t1,y); local cx2,w2=cxAt(t2,y); print(y, string.format("%.1f %.1f | %.1f %.1f", cx,w,cx2,w2)) end

--@ chunk 136
local m = poly({{165,174},{176,174},{170,240},{164,305},{157,305},{160,240}})
work(m, {hand="hatch", tool={kind="flat", width=4}, length={14,26}, angle=1.65, angle_jitter=0.05,
  piles={{trDk,1},{trMid,0.7},{trShd,0.4}}, coverage=1.6, clip=m:grow(0.5), load=0.8})

--@ chunk 137
local m = poly({{164,174},{170,174},{164,240},{158,305},{155,305},{159,240}})
work(m, {hand="hatch", tool={kind="flat", width=4}, length={12,22}, angle=1.65, angle_jitter=0.05,
  piles={{trMid,1},{trLit,0.6}}, coverage=1.3, clip=m:grow(0.5), load=0.7})

--@ chunk 138
local w1 = ribbon({{58,191},{100,193},{130,195},{162,194}}, 7)
local w2 = ribbon({{18,286},{60,290},{100,293},{130,292}}, 7)
local w3 = ribbon({{240,252},{270,256},{305,255}}, 6)
local wires = (w1 + w2 + w3) - (trunk1M + trunk2M):grow(2)
local cn = canopy:shrink(2)
work(wires * cn, {hand="hatch", tool={kind="flat", width=5}, length={8,14}, angle=-0.6, angle_jitter=0.4, piles={{cDark,1},{cMid,0.6}}, coverage=1.3, clip=wires*cn:grow(1), load=0.7})
work(wires - cn, {hand="hatch", tool={kind="flat", width=6}, length={10,18}, angle=-1.1, angle_jitter=0.2, piles={{skyB,1},{skyH,0.8},{skyC,0.6}}, coverage=1.3, clip=wires - cn:shrink(1), load=0.7})

--@ chunk 139
local w1 = ribbon({{58,191},{100,193},{130,195},{162,194}}, 10)
local w2 = ribbon({{18,286},{60,290},{100,293},{130,292}}, 10)
local w3 = ribbon({{240,252},{270,256},{305,255}}, 9)
local zone = ((w1 + w2 + w3) - canopy:shrink(1)) - (trunk1M + trunk2M):grow(2)
work(zone, {hand="hatch", tool={kind="flat", width=8}, length={16,28}, angle=-1.1, angle_jitter=0.15, piles={{skyE,1},{skyK,0.7},{skyG,0.5}}, coverage=1.0, clip=skyM - canopy:shrink(1) - (trunk1M+trunk2M):grow(1), edge="soft", load=0.6})

--@ chunk 140
print(drying(700,570), drying(800,580))
local m = poly({{585,548},{700,544},{860,540},{940,548},{930,590},{880,615},{760,620},{640,612},{600,590}}):roughen(3,20,8) - roadM:grow(2) - bushR:grow(1) - housesM:grow(2)
local c = worley{seed=611, period=40}
local function cid(x,y) local _,_,_,id=c:at(x,y*2); return id end
local gate = mask(function(x,y) return ((cid(x,y)*3.7)%1) < 0.55 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.3)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(m*gate, {hand="hatch", tool={kind="flat", width=8}, length={16,32}, angle=function(x,y) return -0.25 + 0.6*(((cid(x,y)*2.3)%1)-0.5) end, angle_jitter=0.08,
  piles={{gMid,sel(0,0.3)},{cOlive,sel(0.3,0.5)},{shadeL,sel(0.5,0.65)},{earthW,sel(0.65,0.78)},{gDeepW,sel(0.78,0.9)},{pRose,sel(0.9,1)}},
  coverage=0.9, clump=0.4, edge="soft", load=0.75, clip=m:grow(2)})

--@ chunk 141
print(wait(6*24*60)) print(drying(800,200), drying(700,570), drying(165,240), drying(540,480))

--@ chunk 142
local pl = poly({{788,196},{800,192},{830,206},{880,222},{870,262},{830,268},{800,250},{790,225}}):roughen(2,12,4) * mtnM2
local c = worley{seed=621, period=22}
local gate = mask(function(x,y) local _,_,_,id=c:at(x,y*1.4); return id < 0.6 and 1 or 0 end)
work(pl*gate, {hand="hatch", tool={kind="flat", width=7}, length={12,24}, angle=-0.95, angle_jitter=0.1, piles={{mViol,1},{mtShd,0.7},{mOchG,0.3}}, coverage=1.0, clump=0.4, edge="soft", load=0.7, clip=mtnM2})
lb = brush{kind="round", width=4.5, point=0.5}
local function seg(pts) lb:load(line2, 0.45) lb:gesture(pts, {wobble=1}) end
seg({{676,171,0.1},{705,179,0.35},{735,186,0.1}})
seg({{772,191,0.1},{786,191,0.3},{800,187,0.2},{812,190,0.05}})
seg({{860,204,0.05},{900,213,0.25},{930,219,0.05}})
seg({{800,190,0.2},{806,215,0.25},{812,240,0.05}})

--@ chunk 143
local rr = rag{width=8}
rr:dip(0.8)
for i=1,3 do rr:wipe({{800,192},{806,216},{812,242}}, {pressure=0.6}) rr:refold() end
print(rr)

--@ chunk 144
local m = ribbon({{799,194},{806,216},{813,244}}, 9)
work(m*mtnM2, {hand="hatch", tool={kind="flat", width=6}, length={10,18}, angle=-0.95, angle_jitter=0.1, piles={{mViol,1},{mtShd,0.5}}, coverage=1.2, clip=m*mtnM2, load=0.6})

--@ chunk 145
print(wait(14*24*60)) print(drying(800,220), drying(165,240), drying(700,570), drying(810,215))

--@ chunk 146
for y=550,690,10 do local a,b=nil,nil for x=480,820 do if roadM:at(x,y)>0.5 then a=a or x b=x end end print(y,a,b, drying(a and (a+b)/2 or 600,y)) end

--@ chunk 147
-- trial: re-draw the road's right edge (upper part only, y 560-615) with meadow patches biting in and road patches pushing out
local edgeR = mask(function(x,y)
  if y < 556 or y > 615 then return 0 end
  local xr = 520 + (y-560)*1.1 + 15   -- approx right edge
  local d = x - xr
  return (d > -14 and d < 12) and 1 or 0 end)
local c = worley{seed=701, period=13}
local function cid(x,y) local _,_,_,id=c:at(x,y*1.3); return id end
local inner = mask(function(x,y) return ((cid(x,y)*3.3)%1) < 0.45 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.7)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
local bite = edgeR * inner * roadM
local push = edgeR * (-inner) * (-roadM)
work(bite, {hand="hatch", tool={kind="flat", width=6}, length={10,18}, angle=-1.0, angle_jitter=0.15,
  piles={{pOlive,sel(0,0.4)},{cOlive,sel(0.4,0.7)},{gMid,sel(0.7,1)}}, coverage=1.1, clump=0.3, edge="soft", load=0.75})
work(push * mask(function(x,y) return ((cid(x,y)*7.1)%1) < 0.5 and 1 or 0 end), {hand="hatch", tool={kind="flat", width=6}, length={10,18}, angle=-1.0, angle_jitter=0.15,
  piles={{roadPk,1},{roadLit2,0.6},{earthW,0.3}}, coverage=1.0, clump=0.3, edge="soft", load=0.7})

--@ chunk 148
local edgeR = mask(function(x,y)
  if y < 612 or y > 692 then return 0 end
  local xr = 612 + (y-620)*1.08
  local d = x - xr
  return (d > -16 and d < 14) and 1 or 0 end)
local c = worley{seed=711, period=15}
local function cid(x,y) local _,_,_,id=c:at(x,y*1.3); return id end
local inner = mask(function(x,y) return ((cid(x,y)*3.3)%1) < 0.42 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.7)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
local bite = edgeR * inner * roadM
local push = edgeR * (-inner) * (-roadM) * mask(function(x,y) return ((cid(x,y)*7.1)%1) < 0.5 and 1 or 0 end)
work(bite, {hand="hatch", tool={kind="flat", width=7}, length={12,20}, angle=-0.9, angle_jitter=0.15,
  piles={{pOlive,sel(0,0.35)},{cOlive,sel(0.35,0.6)},{gMid,sel(0.6,0.85)},{shG2,sel(0.85,1)}}, coverage=1.1, clump=0.3, edge="soft", load=0.75})
work(push, {hand="hatch", tool={kind="flat", width=7}, length={12,20}, angle=-0.9, angle_jitter=0.15,
  piles={{roadPk,1},{roadLit2,0.5},{earthW,0.4}}, coverage=1.0, clump=0.3, edge="soft", load=0.7})

--@ chunk 149
print(wait(7*24*60)) print(drying(600,600), drying(650,660), drying(560,570))

--@ chunk 150
print(wait(5*24*60)) print(drying(600,600), drying(650,660), drying(560,570), drying(680,690))

--@ chunk 151
for i,p in ipairs(t1) do print('t1',i,p[1],p[2],p[3]) end
for i,p in ipairs(t2) do print('t2',i,p[1],p[2],p[3]) end
print(type(trunkMask), type(cxAt))

--@ chunk 152
print(string.format("%.1f %.1f", cxAt(t1,500)))
print(trunk1M:area(), trunk2M:area(), trunkMask(t1):area())

--@ chunk 153
nt1 = {{116,805,31},{131,710,29},{148,615,27},{160,535,25},{165,465,23},{164,395,21},{163,325,20},{167,262,18},{176,205,17},{186,150,15},{193,100,14}}
nt2 = {{244,805,23},{250,700,21},{256,600,19},{262,500,17},{268,420,16},{278,350,14},{290,290,13},{298,240,11},{302,205,10},{304,185,9}}
-- smooth centerline (Catmull-Rom) sampled densely; returns list of {x,y,w}
function smoothTrunk(t, step)
  local out = {}
  local n = #t
  local function P(i) i = math.max(1, math.min(n, i)) return t[i] end
  for i=1,n-1 do
    local p0,p1,p2,p3 = P(i-1),P(i),P(i+1),P(i+2)
    local seg = math.max(2, math.floor(math.abs(p2[2]-p1[2])/step))
    for s=0,seg-1 do
      local u = s/seg
      local u2,u3 = u*u, u*u*u
      local function cr(a,b,c,d) return 0.5*((2*b) + (-a+c)*u + (2*a-5*b+4*c-d)*u2 + (-a+3*b-3*c+d)*u3) end
      out[#out+1] = {cr(p0[1],p1[1],p2[1],p3[1]), cr(p0[2],p1[2],p2[2],p3[2]), cr(p0[3],p1[3],p2[3],p3[3])}
    end
  end
  out[#out+1] = {t[n][1], t[n][2], t[n][3]}
  return out
end
function trunkPoly(t)
  local c = smoothTrunk(t, 6)
  local L, R = {}, {}
  for i=1,#c do
    local a = c[math.max(1,i-1)]; local b = c[math.min(#c,i+1)]
    local dx, dy = b[1]-a[1], b[2]-a[2]
    local l = math.sqrt(dx*dx+dy*dy)
    local nx, ny = -dy/l, dx/l
    local hw = c[i][3]/2
    L[#L+1] = {c[i][1]+nx*hw, c[i][2]+ny*hw}
    R[#R+1] = {c[i][1]-nx*hw, c[i][2]-ny*hw}
  end
  local pts = {}
  for i=1,#L do pts[#pts+1] = L[i] end
  for i=#R,1,-1 do pts[#pts+1] = R[i] end
  return poly(pts)
end
-- center and width of a smooth trunk at y
function ncx(t, y)
  local c = smoothTrunk(t, 6)
  for i=1,#c-1 do
    local a, b = c[i], c[i+1]
    if (a[2]-y)*(b[2]-y) <= 0 then
      local u = (y-a[2])/((b[2]-a[2]) ~= 0 and (b[2]-a[2]) or 1)
      return lerp(a[1],b[1],u), lerp(a[3],b[3],u)
    end
  end
  return c[#c][1], c[#c][3]
end
local m1 = trunkPoly(nt1); local m2 = trunkPoly(nt2)
print(m1:area(), m2:area())
for _,y in ipairs({800,700,600,500,400,300,200,150}) do local a,w = ncx(nt1,y); local b,w2 = ncx(nt2,y); local oa = cxAt(t1,y); local ob = cxAt(t2,y); print(y, string.format("%.1f(%.1f) w%.1f | %.1f(%.1f) w%.1f", a, oa, w, b, ob, w2)) end
local ex = (trunk1M + trunk2M) - (m1 + m2)
print('exposed', ex:area())

--@ chunk 154
ntM1 = trunkPoly(nt1)
ntM2 = trunkPoly(nt2)
local newT = ntM1 + ntM2
local ex = ((trunk1M + trunk2M):grow(2) - newT:shrink(2)) * rect(0, 140, 400, 670)
local houseX = housesM:grow(2)
ex = ex - houseX
local zC = canopy * ex
local zS = (ex - canopy) * mask(function(x,y) return y < 308 and 1 or 0 end)
local zH = ex * mask(function(x,y) return (y >= 308 and y < 352) and 1 or 0 end)
local zP = ex * mask(function(x,y) return (y >= 352 and y < 500) and 1 or 0 end)
local zP2 = ex * mask(function(x,y) return (y >= 500 and y < 562) and 1 or 0 end)
local zF = ex * mask(function(x,y) return y >= 562 and 1 or 0 end)
print(zC:area(), zS:area(), zH:area(), zP:area(), zP2:area(), zF:area())
local c = worley{seed=801, period=16}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.8); return id end
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.3)%1; return (f>=lo and f<hi) and 1 or 0.06 end end
local base = {hand="hatch", tool={kind="flat", width=6}, length={10,20}, angle_jitter=0.15, coverage=1.4, clump=0.3, edge="soft", load=0.8, fill=true}
local function go(m, piles, ang)
  if m:area() < 5 then return end
  local o = {} for k,v in pairs(base) do o[k]=v end
  o.piles = piles; o.angle = ang; o.clip = m:grow(1)
  work(m, o)
end
go(zC, {{cMid,sel(0,0.45)},{cDark,sel(0.45,0.8)},{cBlue,sel(0.8,1)}}, -0.6)
go(zS, {{skyE,sel(0,0.5)},{skyK,sel(0.5,0.8)},{skyG,sel(0.8,1)}}, -1.1)
go(zH, {{hBlue,sel(0,0.4)},{hViol,sel(0.4,0.7)},{hOch,sel(0.7,0.85)},{tFar,sel(0.85,1)}}, -0.4)
go(zP, {{pOlive,sel(0,0.25)},{fGold,sel(0.25,0.4)},{pSage,sel(0.4,0.55)},{pRose,sel(0.55,0.72)},{gMid,sel(0.72,0.86)},{hBlue,sel(0.86,1)}}, -0.3)
go(zP2, {{pOlive,sel(0,0.35)},{gMid,sel(0.35,0.6)},{bankO,sel(0.6,0.75)},{oliveD,sel(0.75,1)}}, -0.3)
go(zF, {{gDeepW,sel(0,0.3)},{shG2,sel(0.3,0.5)},{cOlive,sel(0.5,0.75)},{gMid,sel(0.75,0.9)},{gYel,sel(0.9,1)}}, -1.0)

--@ chunk 155
print(wait(5*24*60))
for _,p in ipairs({{150,250},{150,450},{150,530},{140,700},{285,300},{270,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 156
print(wait(5*24*60))
for _,p in ipairs({{150,250},{150,450},{150,530},{140,700},{285,300},{270,600},{150,330}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 157
local newT = ntM1 + ntM2
local ex = ((trunk1M + trunk2M):grow(2) - newT:shrink(2)) * rect(0, 140, 400, 670)
local band = (ex:grow(14) - newT:shrink(3) - housesM:grow(2)) * rect(0,140,400,670)
local c = worley{seed=811, period=30}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.8); return id end
local gate = mask(function(x,y) return ((cid(x,y)*3.7)%1) < 0.62 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.9)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
local function Y(a,b) return mask(function(x,y) return (y>=a and y<b) and 1 or 0 end) end
local zC = band * canopy
local zS = (band - canopy) * Y(0,308)
local zH = band * Y(308,352)
local zP = band * Y(352,500)
local zP2 = band * Y(500,562)
local zF = band * Y(562,820)
local function go(m, piles, ang, w, len, sc)
  if m:area() < 5 then return end
  work(m * gate, {hand="hatch", tool={kind="flat", width=w}, length=len, angle=function(x,y) return ang + 0.7*(((cid(x,y)*2.3)%1)-0.5) end, angle_jitter=0.1,
    piles=piles, coverage=1.0, clump=0.4, edge="soft", load=0.75, clip=m:grow(3)})
end
go(zC, {{cMid,sel(0,0.4)},{cDark,sel(0.4,0.75)},{cOlive,sel(0.75,0.88)},{cBlue,sel(0.88,1)}}, -0.6, 7, {12,22})
go(zS, {{skyK,sel(0,0.35)},{skyE,sel(0.35,0.65)},{skyG,sel(0.65,0.85)},{skyH,sel(0.85,1)}}, -1.05, 10, {20,34})
go(zH, {{hBlue,sel(0,0.35)},{hViol,sel(0.35,0.65)},{hOch,sel(0.65,0.85)},{tFar,sel(0.85,1)}}, -0.3, 6, {10,18})
go(zP, {{pOlive,sel(0,0.25)},{fGold,sel(0.25,0.4)},{pSage,sel(0.4,0.55)},{pRose,sel(0.55,0.7)},{gMid,sel(0.7,0.85)},{hBlue,sel(0.85,1)}}, -0.25, 7, {14,24})
go(zP2, {{pOlive,sel(0,0.3)},{gMid,sel(0.3,0.55)},{bankO,sel(0.55,0.7)},{oliveD,sel(0.7,1)}}, -0.25, 8, {16,28})
go(zF, {{gDeepW,sel(0,0.3)},{shG2,sel(0.3,0.5)},{cOlive,sel(0.5,0.72)},{gMid,sel(0.72,0.88)},{gYel,sel(0.88,1)}}, -1.0, 11, {22,40})

--@ chunk 158
local s="" for y=100,320,10 do s=s..y..":"..string.format("%.1f",canopy:at(182,y)).." " end print(s)
s="" for y=150,320,10 do s=s..y..":"..string.format("%.1f",canopy:at(298,y)).." " end print(s)
s="" for y=150,320,10 do s=s..y..":"..string.format("%.1f",canopy:at(160,y)).." " end print(s)

--@ chunk 159
barkV = pile{{"lead white",0.9},{"ultramarine blue",0.7},{"rose madder",0.4},{"red earth",0.3},{"cobalt blue",0.3}, name="barkV"}
barkL = pile{{"lead white",2},{"yellow ochre",1.2},{"red earth",0.6},{"vermilion",0.1}, name="barkL"}
-- lookup tables for the new trunks
function buildLUT(t)
  local L = {}
  for y=60,820 do local c,w = ncx(t,y); L[y] = {c,w} end
  return L
end
LUT1 = buildLUT(nt1); LUT2 = buildLUT(nt2)
function lu(L, x, y) local yi = clamp(math.floor(y+0.5),60,820); local e = L[yi]; return (x-e[1])/e[2] end
function axisAng(L, y) local a = L[clamp(math.floor(y-6),60,820)]; local b = L[clamp(math.floor(y+6),60,820)]; return math.atan(-12, a[1]-b[1]) end
print(axisAng(LUT1,700), axisAng(LUT1,400), axisAng(LUT2,300))
ntR1 = (ntM1:roughen(1.5, 18, 11)) * rect(0,166,400,650)
ntR2 = (ntM2:roughen(1.2, 16, 12)) * rect(0,234,400,580)
for i,spec in ipairs({{ntR1,LUT1},{ntR2,LUT2}}) do
  local m, L = spec[1], spec[2]
  local function u(x,y) return lu(L,x,y) end
  work(m, {hand="hatch", tool={kind="flat", width=i==1 and 5 or 4}, length={12,24}, angle=function(x,y) return axisAng(L,y) end, angle_jitter=0.12, clip=m:grow(1), edge="firm", coverage=2.2, fill=true,
    piles={{barkL,function(x,y) return clamp(1-(u(x,y)+0.35)/0.25,0,1) end},
           {trLit,function(x,y) return clamp(1-math.abs(u(x,y)+0.15)/0.25,0,1) end},
           {trMid,function(x,y) return clamp(1-math.abs(u(x,y)-0.1)/0.22,0,1) end},
           {trShd,function(x,y) return clamp((u(x,y)-0.05)/0.2,0,1) end}}})
end

--@ chunk 160
print(wait(3*24*60))
print(drying(150,600), drying(165,400), drying(270,500))
for i,spec in ipairs({{ntR1,LUT1,904},{ntR2,LUT2,905}}) do
  local m, L = spec[1], spec[2]
  local function u(x,y) return lu(L,x,y) end
  local c = worley{seed=spec[3], period=i==1 and 13 or 10}
  local function cid(x,y) local _,_,_,id = c:at(x*1.6,y*0.55); return id end
  local g = mask(function(x,y) return ((cid(x,y)*3.1)%1) < 0.5 and 1 or 0 end)
  local function S(lo,hi) return function(x,y) local f=(cid(x,y)*5.3)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
  work(m:shrink(1)*g, {hand="hatch", tool={kind="flat", width=i==1 and 5 or 4}, length={10,18}, angle=function(x,y) return axisAng(L,y) end, angle_jitter=0.12, clip=m, coverage=1.0, load=0.7,
    piles={{pRose,function(x,y) return S(0,0.3)(x,y)*clamp(0.5-u(x,y)*2,0,1) end},
           {earthW,function(x,y) return S(0.3,0.55)(x,y)*clamp(0.8-math.abs(u(x,y)+0.05)*2.5,0,1) end},
           {trGreen,function(x,y) return S(0.55,0.75)(x,y)*clamp(0.6-math.abs(u(x,y)-0.1)*2,0,1)*clamp((y-300)/200,0.3,1) end},
           {barkV,function(x,y) return S(0.75,1)(x,y)*clamp(u(x,y)*2.5,0,1) end}}})
end

--@ chunk 161
print(wait(6*24*60))
print(drying(150,600), drying(165,400), drying(270,500), drying(185,175), drying(300,240))

--@ chunk 162
limbs = {
 {pts={{184,172},{170,155},{150,140},{122,126},{95,118}}, w={13,10,8,6,4}},
 {pts={{189,170},{200,152},{218,138},{242,126},{265,120}}, w={12,9,7,5,3}},
 {pts={{301,238},{292,222},{280,210},{262,200}}, w={8,6,5,3}},
 {pts={{306,237},{314,220},{328,208},{348,198}}, w={8,6,5,3}},
 {pts={{304,236},{306,215},{309,198}}, w={6,5,3}},
}
limbM = nil
for _,l in ipairs(limbs) do local m = ribbon(l.pts, l.w); limbM = limbM and (limbM + m) or m end
print(limbM:area())
local m = limbM:roughen(0.8, 10, 21)
work(m, {hand="hatch", tool={kind="flat", width=3}, length={8,16}, angle=-0.6, angle_jitter=0.25, clip=m, coverage=2.0, fill=true,
  piles={{trMid,1},{trShd,0.7},{trLit,function(x,y) return 0.3 end}}})

--@ chunk 163
print(wait(4*24*60))
print(drying(150,140), drying(230,130), drying(330,210), drying(186,170))

--@ chunk 164
print(wait(5*24*60))
print(drying(150,140), drying(230,130), drying(330,210), drying(186,170), drying(150,600))

--@ chunk 165
print(wait(4*24*60))
print(drying(150,140), drying(186,170), drying(196,160))

--@ chunk 166
-- lit upper edges on limbs (light from upper left): a thin barkL/trLit stroke along the upper edge of each limb, partial length
local lb3 = brush{kind="flat", width=3}
local function edge(pts, p)
  lb3:load(p, 0.5)
  lb3:stroke(pts, {pressure={0.5,0.2}, ramps={0.1,0.4}})
end
edge({{183,166},{168,150},{148,135},{124,122}}, barkL)
edge({{188,164},{198,147},{214,134}}, trLit)
edge({{300,233},{291,218},{279,206}}, barkL)
edge({{305,232},{306,214}}, trLit)
-- foliage over the limbs: dark undersides near forks, mid greens out along the limbs; gated so only fragments of limb stay
local zone = limbM:grow(7)
local c = worley{seed=931, period=14}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.4); return id end
local gate = mask(function(x,y) return ((cid(x,y)*3.3)%1) < 0.58 and 1 or 0 end)
local function S(lo,hi) return function(x,y) local f=(cid(x,y)*5.7)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(zone * gate - (ntR1 + ntR2):shrink(1), {hand="hatch", tool={kind="flat", width=7}, length={12,20}, angle=function(x,y) return -0.5 + 0.8*(((cid(x,y)*2.1)%1)-0.5) end, angle_jitter=0.15,
  piles={{cDark,S(0,0.4)},{cMid,S(0.4,0.7)},{cBlue,S(0.7,0.85)},{cOlive,S(0.85,1)}}, coverage=1.2, clump=0.4, edge="soft", load=0.8, clip=zone:grow(4)})

--@ chunk 167
print(wait(5*24*60))
print(drying(150,600), drying(165,400), drying(270,500), drying(160,250), drying(290,300), drying(186,170))

--@ chunk 168
for i,spec in ipairs({{ntR1,LUT1,941},{ntR2,LUT2,942}}) do
  local m, L = spec[1], spec[2]
  local function u(x,y) return lu(L,x,y) end
  local c = worley{seed=spec[3], period=i==1 and 14 or 11}
  local function cid(x,y) local _,_,_,id = c:at(x*1.6,y*0.55); return id end
  local g = mask(function(x,y) local dens = clamp((y-380)/300, 0, 0.75); return ((cid(x,y)*3.7)%1) < dens and 1 or 0 end)
  work(m:shrink(1)*g, {hand="hatch", tool={kind="flat", width=i==1 and 5 or 4}, length={10,20}, angle=function(x,y) return axisAng(L,y) end, angle_jitter=0.12, clip=m, coverage=1.3, load=0.75,
    piles={{earthW,function(x,y) return clamp(1-(u(x,y)+0.3)/0.3,0,1) end},
           {trMid,function(x,y) return clamp(1-math.abs(u(x,y)-0.05)/0.25,0,1) end},
           {trDk,function(x,y) return clamp((u(x,y)-0.1)/0.2,0,1) end}}})
end

--@ chunk 169
print(drying(130,450), drying(250,420))
local newT = ntR1 + ntR2
local ex = ((trunk1M + trunk2M):grow(2) - newT:shrink(2))
local zone = (ex:grow(10) - newT:grow(1) - housesM:grow(2)) * rect(0,300,400,262)
local c = worley{seed=951, period=18}
local function cid(x,y) local _,_,_,id = c:at(x,y*2); return id end
local gate = mask(function(x,y) return ((cid(x,y)*4.1)%1) < 0.55 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*6.3)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
local function Y(a,b) return mask(function(x,y) return (y>=a and y<b) and 1 or 0 end) end
local function go(m, piles, ang, w, len)
  work(m * gate, {hand="hatch", tool={kind="flat", width=w}, length=len, angle=function(x,y) return ang + 0.5*(((cid(x,y)*2.3)%1)-0.5) end, angle_jitter=0.1,
    piles=piles, coverage=1.0, clump=0.4, edge="soft", load=0.75, clip=(m:grow(4)) - newT:grow(1)})
end
go(zone*Y(300,352), {{hBlue,sel(0,0.35)},{hViol,sel(0.35,0.65)},{hOch,sel(0.65,0.85)},{pSage,sel(0.85,1)}}, -0.15, 6, {12,20})
go(zone*Y(352,500), {{pOlive,sel(0,0.25)},{fGold,sel(0.25,0.4)},{pSage,sel(0.4,0.55)},{pRose,sel(0.55,0.7)},{gMid,sel(0.7,0.85)},{oliveD,sel(0.85,1)}}, -0.1, 7, {14,24})
go(zone*Y(500,562), {{pOlive,sel(0,0.3)},{gMid,sel(0.3,0.55)},{bankO,sel(0.55,0.7)},{oliveD,sel(0.7,1)}}, -0.15, 8, {16,26})

--@ chunk 170
local newT = ntR1 + ntR2
local ex = ((trunk1M + trunk2M):grow(2) - newT:shrink(2))
local zone = (ex:grow(30) - ex:grow(3) - newT:grow(2) - housesM:grow(2) - treeBack:grow(1)) * rect(0,300,400,262)
local c = worley{seed=961, period=20}
local function cid(x,y) local _,_,_,id = c:at(x,y*2.2); return id end
local gate = mask(function(x,y) return ((cid(x,y)*3.9)%1) < 0.42 and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*6.1)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
local function Y(a,b) return mask(function(x,y) return (y>=a and y<b) and 1 or 0 end) end
local function go(m, piles, ang, w, len)
  work(m * gate, {hand="hatch", tool={kind="flat", width=w}, length=len, angle=function(x,y) return ang + 0.4*(((cid(x,y)*2.3)%1)-0.5) end, angle_jitter=0.1,
    piles=piles, coverage=0.9, clump=0.4, edge="soft", load=0.7, clip=(m:grow(6)) - newT:grow(1)})
end
go(zone*Y(300,352), {{hBlue,sel(0,0.4)},{hViol,sel(0.4,0.7)},{hOch,sel(0.7,1)}}, -0.1, 6, {14,24})
go(zone*Y(352,500), {{gMid,sel(0,0.25)},{pOlive,sel(0.25,0.45)},{fGold,sel(0.45,0.6)},{oliveD,sel(0.6,0.75)},{cOlive,sel(0.75,0.9)},{pRose,sel(0.9,1)}}, -0.08, 7, {16,28})
go(zone*Y(500,562), {{gMid,sel(0,0.35)},{oliveD,sel(0.35,0.6)},{bankO,sel(0.6,0.75)},{cOlive,sel(0.75,1)}}, -0.12, 8, {18,30})

--@ chunk 171
print(wait(6*24*60))
print(drying(115,370), drying(240,380), drying(115,470), drying(150,600))

--@ chunk 172
local newT = ntR1 + ntR2
local ex = ((trunk1M + trunk2M):grow(2) - newT:shrink(2))
local zone = (ex:grow(34) - newT:grow(1.5) - housesM:grow(2) - treeBack:grow(1)) * rect(0,344,400,76)
local c = worley{seed=971, period=16}
local function cid(x,y) local _,_,_,id = c:at(x,y*2.4); return id end
local gate = mask(function(x,y) local f=((cid(x,y)*3.3)%1); local d = clamp((420-y)/60,0.35,0.8); return f < d and 1 or 0 end)
local function sel(lo,hi) return function(x,y) local f=(cid(x,y)*5.9)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
work(zone * gate, {hand="hatch", tool={kind="flat", width=6}, length={12,22}, angle=function(x,y) return -0.05 + 0.4*(((cid(x,y)*2.3)%1)-0.5) end, angle_jitter=0.1,
  piles={{pSage,sel(0,0.3)},{pCool,sel(0.3,0.5)},{hOch,sel(0.5,0.68)},{pRose,sel(0.68,0.82)},{pOlive,sel(0.82,1)}},
  scale_at=function(x,y) return lerp(0.75,1.0,clamp((y-344)/76,0,1)) end, coverage=1.0, clump=0.4, edge="soft", load=0.75, clip=zone:grow(5) - newT:grow(1)})

--@ chunk 173
print(wait(14*24*60))
for _,p in ipairs({{150,600},{165,400},{270,500},{120,380},{245,380},{186,170},{300,230},{140,720}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 174
for _,p in ipairs({{300,170},{360,190},{250,215},{400,210},{300,140},{420,250},{280,165},{330,175},{390,240},{230,235}}) do print(p[1],p[2], string.format("%.2f", canopy:at(p[1],p[2])), drying(p[1],p[2])) end

--@ chunk 175
local crown = poly({{262,200},{265,178},{276,163},{296,156},{320,158},{338,167},{350,180},{372,180},{396,186},{414,198},{412,212},{380,210},{350,206},{320,204},{290,206}}, true):roughen(2,14,31)
local zone = crown * canopy:shrink(3) - (ntR2 + limbM):grow(1)
local c = worley{seed=1011, period=13}
local function cid(x,y) local _,_,_,id = c:at(x,y*1.4); return id end
local gate = mask(function(x,y) return ((cid(x,y)*3.7)%1) < 0.6 and 1 or 0 end)
local function S(lo,hi) return function(x,y) local f=(cid(x,y)*5.3)%1; return (f>=lo and f<hi) and 1 or 0.05 end end
print(zone:area(), (zone*gate):area())
work(zone*gate, {hand="hatch", tool={kind="flat", width=6}, length={10,18}, angle=function(x,y) return -0.35 + 0.7*(((cid(x,y)*2.1)%1)-0.5) end, angle_jitter=0.15,
  piles={{cLit,S(0,0.3)},{cWarm,S(0.3,0.55)},{cMid,S(0.55,0.8)},{cOlive,S(0.8,1)}}, coverage=1.1, clump=0.4, edge="soft", load=0.75, clip=canopy:shrink(1)})

--@ chunk 176
print(wait(8*24*60)) print(drying(300,175), drying(380,195), drying(320,190))
