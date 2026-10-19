-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
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
canvas{size=480, aspect=0.8, linen={18, 15}, seed=4417,
  ground={
    {pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, um=120, apply="knife", texture=0.25},
  }}
print(W, H)
print(table.concat(tubes(), ", "))

--@ chunk 2
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}, name="glow"}
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
deeprust = pile{{"red earth",3},{"raw umber",2},{"yellow ochre",1}, name="deeprust"}
woods = pile{{"raw umber",2},{"red earth",1},{"Prussian blue",0.4},{"yellow ochre",0.5}, name="woods_dark"}
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
pool = pile{{"raw umber",2},{"Prussian blue",0.5},{"red earth",0.6},{"green earth",1}, name="pool_dark"}
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
print(palette())

--@ chunk 3
-- Campaign 1a: the back woods, a backlit glow behind the falls
gx, gy = 400, 330
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
back_m = above({{0,720},{300,700},{600,705},{1000,730}}):soften(10)
work(back_m, {hand="broad", coverage=3, fill=true, angle=function(x,y) return 0.25 + 0.3*math.sin(x/170) end,
  piles={
    {glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/200)^1.4 * 1.6 end},
    {haze, function(x,y) local d=dist(x,y); return math.exp(-((d-180)/110)^2) end},
    {amber, function(x,y) local d=dist(x,y); return math.exp(-((d-330)/120)^2) end},
    {deeprust, function(x,y) local d=dist(x,y); return math.exp(-((d-480)/130)^2) end},
    {woods, function(x,y) local d=dist(x,y); return math.max(0, (d-450)/250) + math.max(0,(y-560)/200) end},
  }})
print(drying(400,330), drying(50,50))

--@ chunk 4
blend(above({{0,700},{300,680},{600,685},{1000,710}}):soften(40), {angle=0.3})

--@ chunk 5
-- Campaign 1b: rock masses, ledge, banks
rockL = outline{{0,595},{70,578},{160,584},{240,598},{300,618},{338,652,"c"},{350,720},{342,800},{325,870},{200,885},{0,892}, char="broken", seed=11, amount=0.8}:mask()
ledge = poly({{325,640},{570,648},{585,760},{575,870},{330,870},{345,760}}, true)
rockR = outline{{560,662},{610,640},{680,648},{760,684},{860,694},{940,686},{1000,690},{1000,895},{860,890},{720,885},{600,876},{578,780,"c"}, char="broken", seed=12, amount=0.8}:mask()
rockF = outline{{0,1065},{70,1045},{150,1050},{230,1075},{290,1125},{320,1190},{335,1250},{0,1250}, char="broken", seed=13, amount=0.7}:mask()
rockF2 = outline{{850,1205},{920,1182},{1000,1176},{1000,1250},{830,1250}, char="broken", seed=14, amount=0.7}:mask()
local all = rockL + ledge + rockR
work(all, {hand="body", coverage=3, fill=true, length={25,60}, angle=function(x,y) return 1.2 + 0.6*math.sin(x/90 + y/70) end,
  piles={{rock, 1}, {woods, function(x,y) return 0.5 + 0.4*math.sin(x/130) end}, {deeprust, function(x,y) return math.max(0, (700-y)/200)*0.5 end}}})
work(rockF + rockF2, {hand="body", coverage=3, fill=true, length={25,60}, angle=function(x,y) return 0.4 + 0.5*math.sin(x/90 + y/70) end,
  piles={{rock, 1}, {woods, 0.8}, {deeprust, 0.25}}})

--@ chunk 6
topcurve = {{0,602},{40,590},{90,584},{140,588},{185,603},{205,615},{215,612},{260,618},{300,628},{335,642},{355,650},{460,652},{575,655},{600,646},{640,644},{690,655},{730,670},{760,670},{800,672},{860,680},{920,676},{1000,680}}
stream_up = poly({{352,654},{578,658},{548,624},{512,592},{482,566},{458,552},{438,552},{418,566},{398,598},{372,630}}, true)
local band = below(function(x) return 520 end) * above(topcurve) - stream_up
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
work(band, {hand="body", coverage=2.5, fill=true, clip=true, length={20,50}, angle=function(x,y) return 0.15*math.sin(x/60) end,
  piles={
    {haze, function(x,y) local d=dist(x,y); return math.exp(-((d-200)/110)^2) end},
    {amber, function(x,y) local d=dist(x,y); return math.exp(-((d-330)/120)^2) end},
    {deeprust, function(x,y) local d=dist(x,y); return math.exp(-((d-480)/130)^2) end},
    {woods, function(x,y) local d=dist(x,y); return 0.3 + math.max(0, (d-400)/250) + math.max(0,(y-560)/100) end},
  }})
print(drying(400, 600))

--@ chunk 7
local seam = (below(function(x) return 470 end) * above(function(x) return 575 end)):soften(30)
blend(seam, {angle=1.35})
blend(seam, {angle=1.8})

--@ chunk 8
waterline = {{0,890},{120,893},{250,888},{340,884},{470,886},{580,882},{700,890},{850,893},{1000,896}}
pool_m = below(waterline) - rockF - rockF2
work(pool_m, {hand="broad", coverage=3, fill=true, angle=function(x,y) return 0.02*math.sin(x/100) end, length={100,220},
  piles={
    {pool, function(x,y) return math.max(0, 1 - (y-890)/170) end},
    {rock, function(x,y) return math.max(0, 0.6 - (y-890)/250) end},
    {woods, function(x,y) return math.exp(-((y-1020)/90)^2) end},
    {deeprust, function(x,y) return math.max(0, (y-1000)/200) * (0.6 + 0.4*math.sin(x/140)) end},
    {amber, function(x,y) return math.max(0, (y-1100)/150) * (0.5 + 0.5*math.sin(x/110+1)) end},
  }})
print(drying(500,1000))

--@ chunk 9
fartrunk = pile{{"lead white",2},{"raw umber",1},{"red earth",0.4},{"smalt",0.8}, name="fartrunk"}
fartrunk_d = pile{{"lead white",0.8},{"raw umber",1.5},{"red earth",0.5},{"smalt",0.8},{"Prussian blue",0.1}, name="fartrunk_dark"}
trunks_far = {
  {x=58, w=17, lean=-6, top=0},  {x=148, w=9, lean=4, top=40}, {x=238, w=12, lean=-3, top=90},
  {x=302, w=6, lean=5, top=180}, {x=520, w=8, lean=-4, top=150}, {x=592, w=13, lean=3, top=60},
  {x=660, w=7, lean=-2, top=200}, {x=730, w=10, lean=6, top=120}, {x=868, w=11, lean=-5, top=30}, {x=948, w=19, lean=2, top=0}}
for i, t in ipairs(trunks_far) do
  local d = math.abs(t.x - gx)
  local p = (d > 300) and fartrunk_d or fartrunk
  local b = brush{kind="flat", width=t.w, stiffness=0.5}
  local ybase = 640
  for s = 1, 3 do
    b:reload(p, 0.6)
    local y0 = ybase - (s-1) * (ybase - t.top) / 3 + 10
    local y1 = ybase - s * (ybase - t.top) / 3 - 10
    local f0 = (ybase - y0) / ybase
    local f1 = (ybase - y1) / ybase
    b:stroke({{t.x + t.lean * f0 * 5, y0}, {t.x + t.lean * f1 * 5 + rand(-1.5,1.5), y1}}, {pressure={0.6, 0.55}, orient="across"})
  end
end

--@ chunk 10
r = rag{width=26}
for i, t in ipairs(trunks_far) do
  r:dip(0.7)
  local pts = {}
  local ybase = 650
  for s = 0, 6 do
    local y = ybase - s * (ybase - t.top + 15) / 6
    local f = (ybase - y) / ybase
    pts[#pts+1] = {t.x + t.lean * f * 5, y}
  end
  r:wipe(pts, {pressure=0.55})
  r:refold()
end
print(r.load, r.soaked)

--@ chunk 11
for i, t in ipairs(trunks_far) do
  local k = knife{width=t.w + 8}
  local pts = {}
  local ybase = 650
  for s = 0, 8 do
    local y = ybase - s * (ybase - t.top + 20) / 8
    local f = (ybase - y) / ybase
    pts[#pts+1] = {t.x + t.lean * f * 5, y}
  end
  -- scrape from top down in two halves to keep the blade clean
  local rev = {}
  for j = #pts, 1, -1 do rev[#rev+1] = pts[j] end
  k:scrape(rev, {pressure=1})
  k:wipe()
  k:scrape(rev, {pressure=1})
end

--@ chunk 12
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local m = nil
for _, i in ipairs({1,2,4,6,7,8,9}) do
  local t = trunks_far[i]
  local pts = {}
  local ybase = 640
  for s = 0, 8 do
    local y = ybase - s * (ybase - t.top + 20) / 8
    local f = (ybase - y) / ybase
    pts[#pts+1] = {t.x + t.lean * f * 5, y}
  end
  local rb = ribbon(pts, t.w + 16)
  m = m and (m + rb) or rb
end
m = m * above(topcurve)
work(m, {hand="body", coverage=3.5, fill=true, length={15,35}, angle=function(x,y) return 0.25 + 0.3*math.sin(x/170) end,
  piles={
    {glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/200)^1.4 * 1.6 end},
    {haze, function(x,y) local d=dist(x,y); return math.exp(-((d-180)/110)^2) end},
    {amber, function(x,y) local d=dist(x,y); return math.exp(-((d-330)/120)^2) end},
    {deeprust, function(x,y) local d=dist(x,y); return math.exp(-((d-480)/130)^2) end},
    {woods, function(x,y) local d=dist(x,y); return math.max(0, (d-450)/250) + math.max(0,(y-500)/150) end},
  }})

--@ chunk 13
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local m = nil
for _, i in ipairs({3,5,10}) do
  local t = trunks_far[i]
  local pts = {}
  local ybase = 640
  for s = 0, 8 do
    local y = ybase - s * (ybase - t.top + 20) / 8
    local f = (ybase - y) / ybase
    pts[#pts+1] = {t.x + t.lean * f * 5, y}
  end
  local rb = ribbon(pts, t.w + 12)
  m = m and (m + rb) or rb
end
m = m * above(topcurve)
work(m, {hand="body", coverage=3.5, fill=true, length={15,35}, angle=function(x,y) return 0.25 + 0.3*math.sin(x/170) end,
  piles={
    {glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/200)^1.4 * 1.6 end},
    {haze, function(x,y) local d=dist(x,y); return math.exp(-((d-180)/110)^2) end},
    {amber, function(x,y) local d=dist(x,y); return math.exp(-((d-330)/120)^2) end},
    {deeprust, function(x,y) local d=dist(x,y); return math.exp(-((d-480)/130)^2) end},
    {woods, function(x,y) local d=dist(x,y); return math.max(0, (d-450)/250) + math.max(0,(y-500)/150) end},
  }})
-- cover stubs on the rock top
local stubs = nil
for i, t in ipairs(trunks_far) do
  local e = ellipse(t.x, 628, t.w + 10, 26)
  stubs = stubs and (stubs + e) or e
end
stubs = stubs * below(topcurve)
work(stubs, {hand="body", pile=rock, coverage=3, fill=true, length={10,25}, angle=1.3})

--@ chunk 14
local bgm = above({{0,590},{300,610},{600,640},{1000,670}}):soften(25)
blend(bgm, {angle=math.pi/2 + 0.1})

--@ chunk 15
hazyrust = mix{{deeprust, 0.45}, {haze, 0.55}, name="hazyrust"}
hazygold = mix{{amber, 0.5}, {glow, 0.5}, name="hazygold"}
local n = noise{seed=21, period=90, octaves=4}
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
-- mid-distance crowns: soft clumps in the haze, away from the glow core
midfol = mask(function(x, y)
  local d = dist(x, y)
  if y > 640 then return 0 end
  local band = smoothstep(150, 260, d)
  local v = n:at01(x, y) + 0.25 * band - 0.45
  return clamp(v * 3, 0, 1) * band
end)
print(midfol:area())
stipple(midfol, {pile=hazyrust, width=16, coverage=0.9, cluster={0.6, 40}, feather=0.6, drag={4, -1.2}, pressure={0.3, 0.6}})
stipple(midfol * mask(function(x,y) return dist(x,y) < 380 and 1 or 0 end), {pile=hazygold, width=14, coverage=0.6, cluster={0.6, 30}, feather=0.6, drag={4, -1.2}, pressure={0.3,0.6}})

--@ chunk 16
local bgm = above({{0,590},{300,610},{600,640},{1000,670}}):soften(25)
blend(bgm, {angle=0.6})
blend(bgm, {angle=math.pi/2})

--@ chunk 17
for _, p in ipairs({{100,700},{450,750},{800,780},{500,1000},{400,300},{100,1150}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 18
palette{scrape={fartrunk, fartrunk_d, hazyrust, hazygold}}
rocklite = pile{{"lead white",2},{"raw umber",1.5},{"smalt",1},{"red earth",0.3},{"cobalt blue",0.2}, name="rocklite"}
rockwarm = pile{{"lead white",1.5},{"yellow ochre",1},{"red earth",0.8},{"raw umber",1}, name="rockwarm"}
crevice = pile{{"bone black",1},{"Prussian blue",0.4},{"raw umber",1}, name="crevice"}
mossdark = pile{{"green earth",2},{"raw umber",1},{"Prussian blue",0.2},{"yellow ochre",1}, name="mossdark"}
moss = pile{{"green earth",3},{"chrome yellow",1},{"yellow ochre",1.2},{"raw umber",0.4}, name="moss"}
mosslight = pile{{"green earth",2},{"chrome yellow",1},{"yellow ochre",1},{"lead white",1}, name="mosslight"}
print(palette())

--@ chunk 19
tops = {
  T1 = outline{{0,614},{40,598},{100,590},{160,594},{205,610},{190,630},{120,638},{50,642},{0,646}, char="broken", seed=31, amount=0.6}:mask(),
  T2 = outline{{212,626},{270,624},{330,638},{372,654},{340,666},{270,664},{220,652}, char="broken", seed=32, amount=0.6}:mask(),
  T3 = outline{{578,662},{620,650},{680,652},{732,670},{700,684},{630,686},{585,678}, char="broken", seed=33, amount=0.6}:mask(),
  T4 = outline{{742,680},{800,674},{880,684},{950,682},{1000,686},{1000,706},{900,710},{800,708},{748,698}, char="broken", seed=34, amount=0.6}:mask(),
  T5 = outline{{0,792},{80,784},{170,788},{240,802},{210,816},{100,818},{0,820}, char="broken", seed=35, amount=0.6}:mask(),
  T6 = outline{{600,824},{680,816},{760,822},{810,834},{720,846},{620,846}, char="broken", seed=36, amount=0.6}:mask(),
  T7 = outline{{232,744},{300,738},{350,750},{330,762},{250,764}, char="broken", seed=37, amount=0.6}:mask(),
  T8 = outline{{840,770},{920,762},{1000,768},{1000,786},{920,790},{850,786}, char="broken", seed=38, amount=0.6}:mask(),
}
alltops = nil
for _, k in ipairs({"T1","T2","T3","T4","T5","T6","T7","T8"}) do alltops = alltops and (alltops + tops[k]) or tops[k] end
work(alltops, {hand="body", coverage=2.5, fill=true, length={15,40}, angle=function(x,y) return 0.08*math.sin(x/40) end, tool="filbert 9",
  edge={found=0.5, soft=0.4, lost=0.1, period=40},
  piles={{rockwarm, function(x,y) return math.max(0.2, 1 - math.abs(x-420)/450) end}, {rocklite, function(x,y) return 0.3 + math.abs(x-420)/600 end}, {rock, 0.25}}})

--@ chunk 20
local nz = noise{seed=41, period=45, octaves=3}
local mossTops = (tops.T1 + tops.T4 + tops.T5 + tops.T6 + tops.T7 + tops.T8):grow(5):roughen(6, 25, 41)
-- moss creeping down below each top, in noise patches
local creep = mask(function(x, y)
  local v = nz:at01(x, y)
  return clamp((v - 0.45) * 5, 0, 1)
end) * (mossTops:grow(30) - mossTops) * below(function(x) return 0 end)
moss_m = mossTops + creep * mossTops:grow(30):blur(10)
work(moss_m, {hand="body", tool={kind="round", width=10, stiffness=0.4}, length={8,22}, angle=function(x,y) return 0.3*math.sin(x/23+y/17) end, coverage=2.5, fill=true,
  edge={found=0.2, soft=0.6, lost=0.2, period=30},
  piles={{mossdark, 1}, {moss, function(x,y) return 0.4 + 0.4*nz:at01(x+100,y) end}, {rock, 0.3}}})

--@ chunk 21
band_m = (below(function(x) return 585 end) * above(function(x) return 895 end)):soften(10) - stream_up
blend(band_m, {angle=1.25})

--@ chunk 22
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local strip = below(function(x) return 500 end) * above(topcurve):grow(6) + stream_up
work(strip, {hand="body", coverage=3, fill=true, length={20,45}, angle=function(x,y) return 1.45 + 0.2*math.sin(x/50) end,
  piles={
    {glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/220)^1.4 * 1.4 end},
    {haze, function(x,y) local d=dist(x,y); return 0.4 + math.exp(-((d-200)/110)^2) end},
    {amber, function(x,y) local d=dist(x,y); return math.exp(-((d-330)/120)^2) end},
    {deeprust, function(x,y) local d=dist(x,y); return 0.5*math.exp(-((d-480)/130)^2) end},
    {woods, function(x,y) local d=dist(x,y); return 0.15 + math.max(0, (d-400)/300) end},
  }})

--@ chunk 23
local m = (below(function(x) return 450 end) * above(topcurve):shrink(4)):soften(30)
blend(m, {angle=0.35})
blend(m, {angle=1.5})

--@ chunk 24
fallgray = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.4},{"yellow ochre",0.15}, name="fallgray"}
fallwhite = pile{{"lead white",8},{"yellow ochre",0.25},{"cobalt blue",0.08}, name="fallwhite"}
lipglass = pile{{"lead white",4},{"chrome yellow",0.5},{"yellow ochre",0.5},{"raw umber",0.15}, name="lipglass"}
-- geometry
lip_main = {{388,664},{420,660},{460,659},{500,661},{522,664}}
lip_right = {{538,672},{556,670},{574,673}}
fall_main = poly({{386,664},{524,664},{532,720},{540,800},{548,890},{372,890},{378,800},{382,720}}, true)
fall_right = poly({{536,672},{576,673},{580,760},{590,890},{552,890},{546,800},{540,740}}, true)
falls_m = fall_main + fall_right
-- 1. glassy lip band, a curving sheet
local glass = (fall_main * above(function(x) return 690 end)) + (fall_right * above(function(x) return 698 end))
work(glass, {hand="body", pile=lipglass, tool={kind="flat", width=10, stiffness=0.5}, length={20,40}, angle=math.pi/2, coverage=2.5, fill=true, clip=true})
-- 2. broken vertical strokes of fallgray down the sheet
local fl = brush{kind="flat", width=14, stiffness=0.6}
for i = 1, 34 do
  if i % 2 == 1 then fl:reload(fallgray, rand(0.25, 0.42)) end
  local right = (i % 5 == 0)
  local x = right and rand(542, 572) or rand(392, 520)
  local y0 = right and rand(680, 700) or rand(672, 690)
  local spread = (x - 455) * 0.12
  fl:stroke({{x, y0}, {x + spread*0.3 + rand(-2,2), y0 + 60}, {x + spread + rand(-6,6), y0 + rand(150, 215)}},
    {pressure={rand(0.25, 0.45), 0.08}, orient="across", ramps={0.02, 0.6}})
end
blend(falls_m:soften(8), {angle=math.pi/2})

--@ chunk 25
-- dark gaps between strands, pulled down wet into the sheet
local db = brush{kind="filbert", width=9, stiffness=0.6}
local gaps = {
  {x=396, y0=700, len=180, w=0.8}, {x=412, y0=735, len=140, w=0.4},
  {x=448, y0=720, len=160, w=0.5}, {x=471, y0=760, len=120, w=0.35},
  {x=505, y0=705, len=175, w=0.7}, {x=528, y0=672, len=215, w=1.0},
  {x=536, y0=690, len=200, w=0.8}, {x=578, y0=700, len=190, w=0.9}, {x=566, y0=780, len=100, w=0.4},
  {x=432, y0=800, len=85, w=0.4}, {x=488, y0=815, len=70, w=0.35}, {x=383, y0=760, len=125, w=0.9},
}
for i, g in ipairs(gaps) do
  db:reload(i % 3 == 0 and crevice or rock, 0.55)
  local spread = (g.x - 455) * 0.12
  local x1 = g.x + spread * (g.len/215)
  db:gesture({{g.x, g.y0, 0.15*g.w}, {g.x + rand(-1.5,1.5), g.y0 + g.len*0.3, 0.7*g.w}, {lerp(g.x, x1, 0.7) + rand(-2,2), g.y0 + g.len*0.75, 0.6*g.w}, {x1, g.y0 + g.len, 0.1}}, {wobble=1.5})
end
-- the sheet thins at its edges: drag rock in from the sides at the bottom
for i, e in ipairs({{372, 790, 385, 890}, {590, 790, 584, 890}, {377, 720, 386, 790}}) do
  db:reload(rock, 0.5)
  db:stroke({{e[1], e[2]}, {e[3], e[4]}}, {pressure={0.3, 0.7}})
end

--@ chunk 26
blend(falls_m:grow(6):soften(10), {angle=math.pi/2})
blend(falls_m:grow(6):soften(10), {angle=math.pi/2 + 0.05})

--@ chunk 27
for _, p in ipairs({{400,300},{100,100},{900,100},{200,500},{800,500},{450,760},{100,700},{500,1000},{300,1180}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 28
-- rocks breaking the falls: drawn shapes laid wet over the sheet
splitR = outline{{524,668},{536,666},{544,700},{548,760},{556,830},{560,892},{522,892},{528,830},{526,760},{522,700}, char="broken", seed=51, amount=0.5}:mask()
leftbulge = outline{{368,740},{386,752},{398,800},{404,850},{396,894},{360,894},{356,800}, char="broken", seed=52, amount=0.6}:mask()
midboulder = outline{{430,846},{452,826},{480,822},{500,836},{506,870},{498,894},{430,894}, char="broken", seed=53, amount=0.6}:mask()
rightedge = outline{{582,690},{600,690},{604,894},{586,894},{586,800}, char="broken", seed=54, amount=0.5}:mask()
local rr = splitR + leftbulge + midboulder + rightedge
work(rr, {hand="body", tool={kind="filbert", width=8, stiffness=0.6}, length={10,30}, angle=1.45, coverage=3, fill=true, clip=true,
  piles={{rock, 1}, {crevice, 0.4}, {woods, 0.3}}})
print(drying(470,760))

--@ chunk 29
local fl = brush{kind="filbert", width=7, stiffness=0.5}
-- water sliding down past rock edges: thin streaks overlapping the edges
local edges = {
  -- left bulge: its right edge around x 398-404 from y 755 to 890
  {{393,752},{399,800},{403,850},{400,890}}, {{385,748},{391,790},{396,840},{392,885}},
  -- split rock left edge x~522-528
  {{521,672},{523,720},{526,780},{527,850},{524,890}},
  -- split rock right edge x~540-560
  {{538,670},{545,720},{550,790},{556,860},{560,892}},
  -- right edge rock left edge ~583
  {{582,692},{584,760},{586,830},{588,892}},
}
for i, e in ipairs(edges) do
  fl:reload(fallgray, 0.5)
  local pts = {}
  for j, p in ipairs(e) do pts[#pts+1] = {p[1] + rand(-1,1), p[2], j == 1 and 0.2 or (j == #e and 0.15 or 0.5)} end
  fl:gesture(pts, {wobble=1.5})
end
-- water pouring over the mid boulder: arcs from its top outward and down
for i = 1, 9 do
  fl:reload(i % 3 == 0 and fallwhite or fallgray, 0.6)
  local x0 = rand(440, 498)
  local dir = (x0 < 468) and -1 or 1
  fl:gesture({{x0, 815, 0.3}, {x0 + dir*6, 828, 0.6}, {x0 + dir*14, 846, 0.5}, {x0 + dir*18 + rand(-3,3), 872, 0.3}, {x0 + dir*20 + rand(-4,4), 892, 0.05}}, {wobble=1.5})
end

--@ chunk 30
local k = knife{width=30}
for x = 360, 610, 22 do
  k:scrape({{x, 664}, {x, 780}, {x, 900}}, {pressure=1})
  k:wipe()
  k:scrape({{x+8, 664}, {x+8, 780}, {x+8, 900}}, {pressure=1})
  k:wipe()
end

--@ chunk 31
local fz = rect(355, 662, 255, 236):soften(4)
r = rag{width=40}
r:dip(0.9)
r:wipe(fz, {pressure=0.8, angle=math.pi/2, passes=2, refold=0.6})
print(r.load, r.soaked, r.damp)
r = rag{width=40}
r:dip(0.9)
r:wipe(fz, {pressure=0.8, angle=0, passes=2, refold=0.6})
print(r.load, r.soaked, r.damp)

--@ chunk 32
local wall = rect(345, 655, 275, 245):roughen(5, 20, 61)
work(wall, {hand="body", tool={kind="filbert", width=10, stiffness=0.6}, length={15,40}, angle=function(x,y) return 1.4 + 0.25*math.sin(x/30) end, coverage=3, fill=true,
  edge="soft", piles={{rock, 1}, {crevice, 0.35}, {woods, 0.45}, {mossdark, function(x,y) return (x < 375 or x > 595) and 0.5 or 0 end}}})

--@ chunk 33
palette{scrape={pool, mosslight, lipglass, rocklite}}
farbank = mix{{haze, 0.5}, {mossdark, 0.3}, {deeprust, 0.2}, name="farbank"}
farbank_d = mix{{haze, 0.3}, {woods, 0.5}, {mossdark, 0.2}, name="farbank_dark"}
local nb = noise{seed=71, period=40, octaves=3}
local function bank_top(x)
  local base
  if x < 420 then base = lerp(548, 585, x/420) else base = lerp(590, 560, (x-420)/580) end
  return base + nb(x, 0) * 14
end
farbanks = (mask(function(x, y) return y > bank_top(x) and 1 or 0 end) * above(topcurve):grow(4)):soften(6) - stream_up
work(farbanks, {hand="body", tool={kind="filbert", width=8}, length={8,20}, angle=function(x,y) return rand(-0.4, 0.4) end, coverage=2.5, fill=true, edge="soft",
  piles={{farbank, 1}, {farbank_d, function(x,y) return clamp((y - 570)/80, 0, 1) end}, {haze, function(x,y) return clamp((640 - y)/80, 0, 0.6) * (math.abs(x-420) < 200 and 1 or 0.3) end}}})
upstream_p = mix{{glow, 0.6}, {haze, 0.4}, name="upstream"}
work(stream_up:grow(3), {hand="body", tool={kind="flat", width=10}, length={20,50}, angle=0.0, coverage=2.5, fill=true, edge="soft",
  piles={{upstream_p, 1}, {haze, function(x,y) return clamp((y-600)/60, 0, 0.8) end}}})

--@ chunk 34
palette{scrape={farbank, farbank_d}}
bank_warm = mix{{amber, 0.3}, {deeprust, 0.35}, {haze, 0.35}, name="bank_warm"}
bank_shadow = mix{{woods, 0.55}, {deeprust, 0.2}, {haze, 0.25}, name="bank_shadow"}
local nb = noise{seed=72, period=35, octaves=3}
local function bank_top(x)
  local base
  if x < 420 then base = lerp(540, 590, x/420) else base = lerp(600, 555, (x-420)/580) end
  return base + nb(x, 0) * 16
end
-- sliver of upper stream just behind the lip
sliver = outline{{360,652},{400,640},{450,634},{500,636},{560,648},{590,660},{540,662},{450,660},{380,660}, char="soft", seed=73, amount=0.5}:mask()
banks2 = (mask(function(x, y) return y > bank_top(x) and 1 or 0 end) * above(topcurve):grow(4)) - sliver
work(banks2, {hand="body", tool={kind="filbert", width=9}, length={8,22}, angle=function(x,y) return rand(-0.5, 0.5) end, coverage=3, fill=true, edge="soft",
  piles={{bank_warm, function(x,y) return 0.6 + 0.4*nb(x*2, y*2) end}, {bank_shadow, function(x,y) return clamp((y - 580)/60, 0.1, 1.2) end}, {haze, function(x,y) return clamp((610 - y)/50, 0, 0.7) end}}})
work(sliver, {hand="body", tool={kind="flat", width=8}, length={20,50}, angle=0.0, coverage=2.5, fill=true, edge="soft",
  piles={{upstream_p, 1}, {glow, 0.3}}})

--@ chunk 35
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local reg = (below(function(x) return 525 end) * above(topcurve):grow(3)) - sliver
work(reg, {hand="body", coverage=3, fill=true, length={25,60}, angle=function(x,y) return 1.5 + 0.15*math.sin(x/37) end, edge="soft",
  piles={
    {glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/240)^1.4 * 1.2 end},
    {haze, function(x,y) local d=dist(x,y); return 0.5 + math.exp(-((d-200)/110)^2) end},
    {amber, function(x,y) local d=dist(x,y); return 0.6*math.exp(-((d-330)/120)^2) end},
    {deeprust, function(x,y) local d=dist(x,y); return 0.5*math.exp(-((d-450)/130)^2) end},
    {bank_shadow, function(x,y) local d=dist(x,y); return 0.2 + math.max(0, (d-350)/300) + clamp((y-590)/60, 0, 1)*0.8 end},
  }})
blend((below(function(x) return 470 end) * above(topcurve):shrink(3) - sliver):soften(25), {angle=math.pi/2})

--@ chunk 36
local seam = (below(function(x) return 395 end) * above(function(x) return 510 end)):soften(35)
blend(seam, {angle=math.pi/2 - 0.1})
blend(seam, {angle=0.5})

--@ chunk 37
local seam = (below(function(x) return 485 end) * above(function(x) return 560 end) * above(topcurve):shrink(6) - sliver:grow(6)):soften(20)
blend(seam, {angle=math.pi/2})
blend(seam, {angle=math.pi/2 + 0.2})

--@ chunk 38
palette{scrape={bank_warm, bank_shadow, upstream_p}}
leafgold = pile{{"chrome yellow",2},{"yellow ochre",1},{"lead white",0.4}, name="leafgold"}
leafrust = pile{{"red earth",2},{"vermilion",0.6},{"yellow ochre",1.2}, name="leafrust"}
leafdeep = pile{{"red earth",2},{"raw umber",1.5},{"vermilion",0.2},{"Prussian blue",0.1}, name="leafdeep"}
print(palette())

--@ chunk 39
local n1 = noise{seed=81, period=80, octaves=4, persistence=0.55}
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
function canopy_env(x, y)
  local eR = smoothstep(540, 780, x) * (1 - smoothstep(330, 480, y))
  local eL = (1 - smoothstep(170, 330, x)) * (1 - smoothstep(250, 400, y))
  local eT = (1 - smoothstep(50, 170, y)) * 0.85
  return math.max(eR, eL, eT)
end
canopy = mask(function(x, y)
  local e = canopy_env(x, y)
  if e <= 0 then return 0 end
  return clamp((n1:at01(x, y) + e - 1.0) * 4, 0, 1)
end)
print(canopy:area())
work(canopy, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, length={8,22}, angle=function(x,y) return 1.2*math.sin(x/31 + y/23) end, coverage=2, edge="loose",
  piles={{leafdeep, function(x,y) return 0.3 + clamp((dist(x,y) - 250)/250, 0, 1) end}, {deeprust, 0.6}, {leafrust, function(x,y) return 0.6*math.exp(-((dist(x,y)-260)/120)^2) end}}})

--@ chunk 40
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local n2 = noise{seed=82, period=45, octaves=3}
local n3 = noise{seed=83, period=30, octaves=3}
local cg = canopy:grow(8)
-- mid tone rust clusters
local midm = cg * mask(function(x,y) return clamp((n2:at01(x,y) - 0.38) * 4, 0, 1) end)
stipple(midm, {pile=leafrust, width=14, coverage=0.9, cluster={0.6, 35}, feather=0.6, drag={5, 1.2}, pressure={0.3, 0.7}})
-- lit gold clusters, facing the glow
local litm = cg * mask(function(x,y)
  local near = clamp(1 - (dist(x,y) - 230)/320, 0, 1)
  return clamp((n3:at01(x,y) - 0.5 + 0.4*near) * 4, 0, 1) * (0.3 + 0.7*near)
end)
stipple(litm, {pile=leafgold, width=11, coverage=0.8, cluster={0.6, 25}, feather=0.6, drag={4, 1.0}, pressure={0.3, 0.6}})

--@ chunk 41
local cb = canopy:grow(14):soften(10)
blend(cb, {angle=0.7})
blend(cb, {angle=2.2})

--@ chunk 42
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local n4 = noise{seed=84, period=55, octaves=3}
local n5 = noise{seed=85, period=35, octaves=3}
local n6 = noise{seed=86, period=25, octaves=2}
local cg = canopy:grow(6)
-- shadowed leaf clusters: the undersides of clumps (dark), away from the glow
local shm = cg * mask(function(x,y) return clamp((n4:at01(x,y+18) - 0.5) * 4, 0, 1) * clamp((dist(x,y) - 200)/200, 0.3, 1) end)
stipple(shm, {pile=leafdeep, width=9, coverage=0.7, cluster={0.5, 20}, feather=0.5, drag={3, 1.3}, pressure={0.35, 0.7}, dips={14, 0.7, 0.3}})
-- mid rust clumps, lit tops of clumps
local mm = cg * mask(function(x,y) return clamp((n4:at01(x,y) - 0.45) * 4, 0, 1) * clamp(1 - (n4:at01(x,y+18) - 0.5)*2, 0, 1) end)
stipple(mm, {pile=leafrust, width=8, coverage=0.7, cluster={0.5, 18}, feather=0.5, drag={3, 1.0}, pressure={0.3, 0.6}, dips={14, 0.7, 0.3}})
-- gold, near the glow and on the tops of clumps
local gm = cg * mask(function(x,y)
  local near = clamp(1 - (dist(x,y) - 220)/350, 0, 1)
  return clamp((n5:at01(x,y) - 0.55 + 0.35*near) * 4, 0, 1) * (0.2 + 0.8*near) * clamp((n4:at01(x,y) - 0.4)*3, 0, 1)
end)
stipple(gm, {pile=leafgold, width=7, coverage=0.6, cluster={0.6, 15}, feather=0.6, drag={3, 0.9}, pressure={0.3, 0.6}, dips={12, 0.7, 0.3}})

--@ chunk 43
for _, p in ipairs({{400,300},{100,100},{900,100},{200,450},{800,450},{450,760},{100,700},{500,1000},{300,1180},{150,200},{700,250}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 44
golden = mix{{leafgold, 0.6}, {amber, 0.4}, name="golden"}
local hn = noise{seed=95, period=110, octaves=3, persistence=0.45}
function cshade(x, y)
  local e = 4
  local dx = (hn(x+e, y) - hn(x-e, y)) / (2*e)
  local dy = (hn(x, y+e) - hn(x, y-e)) / (2*e)
  local lx, ly = gx - x, (gy - 150) - y
  local l = math.sqrt(lx*lx + ly*ly) + 1e-6
  lx, ly = lx/l, ly/l
  local d = math.sqrt((x-gx)^2 + ((y-gy)/1.15)^2)
  local near = clamp(1 - (d - 200)/450, 0, 1)
  return clamp(0.3 + 45 * (dx*lx + dy*ly) + 0.3*near + 0.12*hn(x,y), 0, 1)
end
local cm = canopy:grow(6)
work(cm, {hand="body", tool={kind="filbert", width=9, stiffness=0.5}, length={7,16}, coverage=1.3, edge="loose",
  angle=function(x,y) return 1.57 + 0.8*math.sin(x/13 + y/7) end,
  scale_at=function(x,y) local d = math.sqrt((x-gx)^2 + (y-gy)^2); return 0.9 + clamp((d-250)/500, 0, 0.6) end,
  piles={{leafdeep, function(x,y) return clamp(1 - cshade(x,y)*2.5, 0, 1) end},
         {leafrust, function(x,y) local s = cshade(x,y); return math.exp(-((s-0.5)/0.15)^2) end},
         {amber, function(x,y) local s = cshade(x,y); return math.exp(-((s-0.68)/0.1)^2) * 0.8 end},
         {golden, function(x,y) return clamp((cshade(x,y) - 0.72) * 4, 0, 1) end}}})

--@ chunk 45
falls_col = poly({{362,655},{595,655},{612,900},{345,900}})
local band = (below(topcurve) * above(waterline):grow(8)) - falls_col
faces = band - alltops:grow(2)
local nf = noise{seed=101, period=60, octaves=3}
work(faces, {hand="body", tool={kind="filbert", width=11, stiffness=0.6}, length={18,45}, coverage=2.5, fill=true, edge="soft",
  angle=function(x,y) return 1.45 + 0.35*math.sin(x/40 + y/90) end,
  piles={{rock, 1}, {woods, function(x,y) return 0.4 + 0.4*nf:at01(x,y) end}, {crevice, function(x,y) return 0.25 + clamp(1 - math.abs(x-480)/180, 0, 1) end},
         {mossdark, function(x,y) return 0.5*clamp((nf:at01(x+200,y) - 0.5)*3, 0, 1) end}}})

--@ chunk 46
print(palette())

--@ chunk 47
palette{scrape={leafgold}}
mossrim = pile{{"chrome yellow",1},{"yellow ochre",1.5},{"green earth",1.5},{"lead white",1.2}, name="mossrim"}
newtops = {
  outline{{0,600},{60,585},{140,582},{200,595},{232,612},{200,628},{120,634},{40,636},{0,640}, char="broken", seed=111, amount=0.5}:mask(),
  outline{{215,622},{270,618},{330,630},{368,652},{360,668},{300,668},{240,660},{210,645}, char="broken", seed=112, amount=0.5}:mask(),
  outline{{590,660},{630,648},{690,650},{740,664},{760,680},{720,690},{650,690},{600,684}, char="broken", seed=113, amount=0.5}:mask(),
  outline{{750,680},{820,672},{900,676},{1000,672},{1000,705},{900,712},{800,710},{755,700}, char="broken", seed=114, amount=0.5}:mask(),
  outline{{0,780},{90,770},{180,775},{250,790},{260,806},{170,812},{80,812},{0,815}, char="broken", seed=115, amount=0.5}:mask(),
  outline{{225,740},{290,733},{345,742},{372,756},{340,766},{260,766},{230,758}, char="broken", seed=116, amount=0.5}:mask(),
  outline{{600,815},{680,806},{770,812},{830,828},{790,842},{680,846},{605,840}, char="broken", seed=117, amount=0.5}:mask(),
  outline{{830,765},{910,758},{1000,762},{1000,790},{910,795},{840,788}, char="broken", seed=118, amount=0.5}:mask(),
}
ntops = nil
for i, m in ipairs(newtops) do ntops = ntops and (ntops + m) or m end
-- per-plane rim: lighter toward each plane's upper edge (y small within the plane)
local tb = {{582,640},{618,668},{648,690},{672,712},{770,815},{733,766},{806,846},{758,795}}
local function rimw(x, y)
  for i, b in ipairs(tb) do
    if newtops[i]:at(x, y) > 0.3 then return clamp(1 - (y - b[1]) / (b[2] - b[1]), 0, 1) end
  end
  return 0.3
end
work(ntops, {hand="body", tool={kind="filbert", width=8, stiffness=0.5}, length={10,28}, coverage=2.5, fill=true, edge={found=0.5, soft=0.4, lost=0.1, period=40},
  angle=function(x,y) return 0.12*math.sin(x/25) end,
  piles={{mossdark, function(x,y) return clamp(1 - rimw(x,y)*1.8, 0, 1) end}, {moss, function(x,y) return math.exp(-((rimw(x,y)-0.5)/0.25)^2) end},
         {mossrim, function(x,y) local r = rimw(x,y); local d = math.abs(x - 470); return clamp((r - 0.55)*2.5, 0, 1) * (0.5 + 0.5*clamp(1 - d/500, 0, 1)) end}}})

--@ chunk 48
palette{scrape={golden}}
moss_lit = mix{{mossrim, 0.55}, {amber, 0.25}, {haze, 0.2}, name="moss_lit"}
print(palette())

--@ chunk 49
function topy(pts, x)
  if x <= pts[1][1] then return pts[1][2] end
  for i = 1, #pts - 1 do
    local a, b = pts[i], pts[i+1]
    if x <= b[1] then return lerp(a[2], b[2], (x - a[1]) / (b[1] - a[1])) end
  end
  return pts[#pts][2]
end
boulders = {
  {name="B1", top={{-10,600},{60,584},{140,580},{200,592},{240,614},{268,640},{285,700}}, bot=895, x0=-10, x1=290, seed=121},
  {name="B6", top={{738,690},{820,674},{900,678},{1010,670}}, bot=895, x0=736, x1=1010, seed=126},
  {name="B2", top={{222,634},{290,622},{340,636},{368,660},{376,700}}, bot=895, x0=220, x1=378, seed=122},
  {name="B5", top={{590,668},{640,650},{700,652},{745,668},{772,692},{785,740}}, bot=895, x0=588, x1=788, seed=125},
  {name="B8", top={{828,780},{900,762},{1010,766}}, bot=900, x0=826, x1=1010, seed=128},
  {name="B3", top={{-10,775},{80,762},{170,766},{240,782},{275,810},{292,850}}, bot=900, x0=-10, x1=295, seed=123},
  {name="B4", top={{248,808},{310,792},{352,800},{374,830}}, bot=900, x0=246, x1=376, seed=124},
  {name="B7", top={{598,836},{680,814},{760,816},{822,834},{845,865}}, bot=900, x0=596, x1=848, seed=127},
}
function boulder_mask(b)
  local pts = {}
  for _, p in ipairs(b.top) do pts[#pts+1] = {p[1], p[2]} end
  pts[#pts+1] = {b.x1, b.bot}
  pts[#pts+1] = {b.x0, b.bot}
  return outline{pts = pts, char="broken", seed=b.seed, amount=0.45}:mask()
end
local nm = noise{seed=130, period=35, octaves=3}
function paint_boulder(b)
  local m = boulder_mask(b)
  local function depth(x, y) return y - topy(b.top, x) + 10 * (nm(x, y)) end
  local function lightness(x) return clamp(1 - math.abs(x - 470) / 520, 0.15, 1) end
  work(m, {hand="body", tool={kind="filbert", width=10, stiffness=0.6}, length={12,32}, coverage=2.2, fill=true,
    edge={found=0.55, soft=0.4, lost=0.05, period=35},
    angle=function(x,y) local d = depth(x,y); return d < 30 and 0.1*math.sin(x/20) or (1.45 + 0.3*math.sin(x/37)) end,
    piles={
      {moss_lit, function(x,y) local d = depth(x,y); return clamp(1 - d/10, 0, 1) * lightness(x) end},
      {moss, function(x,y) local d = depth(x,y); return math.exp(-((d-14)/9)^2) * (0.4 + 0.6*lightness(x)) end},
      {mossdark, function(x,y) local d = depth(x,y); return math.exp(-((d-30)/14)^2) end},
      {rock, function(x,y) local d = depth(x,y); return clamp((d-30)/30, 0, 1) end},
      {woods, function(x,y) local d = depth(x,y); return clamp((d-40)/40, 0, 1) * 0.5 * nm:at01(x+300, y) end},
      {crevice, function(x,y) return clamp((y - b.bot + 60)/60, 0, 1) * 0.8 end},
    }})
end
for i = 1, 4 do paint_boulder(boulders[i]) end

--@ chunk 50
for i = 5, 8 do paint_boulder(boulders[i]) end

--@ chunk 51
for _, p in ipairs({{400,700},{470,780},{560,850},{450,660},{200,950},{500,1000},{500,1150},{800,1100},{300,400},{450,500}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 52
palette{scrape={mossrim, rockwarm}}
lipglass = pile{{"lead white",4},{"chrome yellow",0.5},{"yellow ochre",0.6},{"raw umber",0.2}, name="lipglass"}
-- falls geometry as edge functions
local function lerpy(pts, y)
  if y <= pts[1][1] then return pts[1][2] end
  for i = 1, #pts - 1 do
    local a, b = pts[i], pts[i+1]
    if y <= b[1] then return lerp(a[2], b[2], (y - a[1]) / (b[1] - a[1])) end
  end
  return pts[#pts][2]
end
upL = {{656,398},{700,404},{760,408},{792,404}}
upR = {{656,524},{700,518},{760,516},{792,524}}
loL = {{796,386},{850,378},{898,372}}
loR = {{796,542},{850,550},{898,556}}
stR_c = {{664,560},{760,562},{840,566},{898,570}}
stR_w = {{664,14},{760,16},{898,24}}
local function curtain(y)
  if y < 794 then return lerpy(upL, y), lerpy(upR, y) else return lerpy(loL, y), lerpy(loR, y) end
end
falls_shape = mask(function(x, y)
  if y < 652 or y > 900 then return 0 end
  local l, r = curtain(y)
  local v = 0
  if x > l and x < r then v = 1 end
  local c, w = lerpy(stR_c, y), lerpy(stR_w, y)
  if y > 662 and math.abs(x - c) < w/2 then v = 1 end
  return v
end):soften(4)
-- lip glass: a curving band at the brink
lip_m = mask(function(x, y)
  local l, r = curtain(y)
  local top = 652 + 4 * ((x - 460)/70)^2
  return (y > top and y < top + 18 and x > l - 2 and x < r + 2) and 1 or 0
end):soften(3) + mask(function(x,y) return (y > 660 and y < 676 and math.abs(x - 560) < 9) and 1 or 0 end):soften(3)
work(lip_m, {hand="body", tool={kind="flat", width=8, stiffness=0.5}, length={10,24}, angle=0.05, coverage=2.5, fill=true, clip=true,
  piles={{lipglass, 1}, {glow, 0.4}}})
falls_curtain = curtain
falls_lerpy = lerpy
print(falls_shape:area())

--@ chunk 53
-- 1. broken veil of fallgray down the curtain and the right strand
local fl = brush{kind="flat", width=12, stiffness=0.6}
local n = 0
for pass = 1, 2 do
  for x = 400, 520, 7 do
    n = n + 1
    if n % 2 == 1 then fl:reload(fallgray, rand(0.28, 0.42)) end
    local xs = x + rand(-3, 3)
    local t = (xs - 398) / (524 - 398)
    local y0 = 664 + rand(-2, 6)
    local yend = (pass == 1) and rand(760, 800) or rand(700, 790)
    local pts = {}
    for k = 0, 4 do
      local y = lerp(y0, yend, k/4)
      local l, r = falls_curtain(y)
      pts[#pts+1] = {lerp(l, r, t) + rand(-1.5, 1.5), y}
    end
    fl:stroke(pts, {pressure={rand(0.3, 0.5), 0.12}, orient="across", ramps={0.02, 0.5}})
  end
end
-- lower drop
for x = 388, 545, 8 do
  n = n + 1
  if n % 2 == 1 then fl:reload(fallgray, rand(0.25, 0.4)) end
  local t = (x - 386) / (542 - 386)
  local y0 = 796 + rand(-4, 6)
  local yend = rand(860, 900)
  local pts = {}
  for k = 0, 3 do
    local y = lerp(y0, yend, k/3)
    local l, r = falls_curtain(y)
    pts[#pts+1] = {lerp(l, r, t) + rand(-2, 2), y}
  end
  fl:stroke(pts, {pressure={rand(0.3, 0.5), 0.1}, orient="across", ramps={0.02, 0.5}})
end
-- right strand
local fs = brush{kind="flat", width=9, stiffness=0.6}
for k = 1, 4 do
  fs:reload(fallgray, 0.35)
  local off = rand(-5, 5)
  local pts = {}
  for j = 0, 5 do
    local y = lerp(668, 895, j/5)
    pts[#pts+1] = {falls_lerpy(stR_c, y) + off * (0.5 + j/10) + rand(-1.5,1.5), y}
  end
  fs:stroke(pts, {pressure={0.45, 0.15}, orient="across", ramps={0.02, 0.5}})
end
blend(falls_shape:grow(3):soften(6), {angle=math.pi/2})

--@ chunk 54
local rd = brush{kind="round", width=6, point=0.6, stiffness=0.5}
local strands = {
  {t=0.08, y0=690, y1=790, p=0.5}, {t=0.22, y0=720, y1=785, p=0.35}, {t=0.37, y0=700, y1=760, p=0.3},
  {t=0.47, y0=740, y1=800, p=0.6}, {t=0.62, y0=690, y1=770, p=0.3}, {t=0.78, y0=705, y1=790, p=0.45},
  {t=0.93, y0=680, y1=792, p=0.55},
  {t=0.12, y0=830, y1=898, p=0.5}, {t=0.3, y0=815, y1=880, p=0.4}, {t=0.52, y0=820, y1=898, p=0.65},
  {t=0.7, y0=840, y1=898, p=0.4}, {t=0.88, y0=810, y1=898, p=0.5},
}
for i, s in ipairs(strands) do
  rd:reload(i % 3 == 0 and crevice or rock, 0.35)
  local pts = {}
  for k = 0, 4 do
    local y = lerp(s.y0, s.y1, k/4)
    local l, r = falls_curtain(y)
    local pr = s.p * math.sin(math.pi * (0.15 + 0.7 * k/4))
    pts[#pts+1] = {lerp(l, r, s.t) + rand(-1, 1), y, pr}
  end
  rd:gesture(pts, {wobble=1})
end
-- ragged edges: dark pulled in from the sides
for i = 1, 10 do
  rd:reload(rock, 0.4)
  local y0 = rand(680, 880)
  local l, r = falls_curtain(y0)
  local side = (i % 2 == 0) and l or r
  local dir = (i % 2 == 0) and 1 or -1
  rd:gesture({{side - dir*4, y0, 0.2}, {side + dir*3, y0 + 20, 0.6}, {side + dir*5, y0 + 50, 0.1}}, {wobble=1})
end
blend(falls_shape:grow(2):soften(5), {angle=math.pi/2})

--@ chunk 55
local fd = brush{kind="flat", width=7, stiffness=0.6}
local gaps = {
  {t=0.33, y0=672, y1=788, w=1.0}, {t=0.66, y0=690, y1=770, w=0.6}, {t=0.865, y0=675, y1=790, w=0.8},
  {t=0.2, y0=805, y1=896, w=0.8}, {t=0.45, y0=820, y1=896, w=1.0}, {t=0.74, y0=812, y1=896, w=0.7}, {t=0.97, y0=800, y1=896, w=0.9},
  {t=0.02, y0=800, y1=896, w=0.9},
}
for i, g in ipairs(gaps) do
  fd:reload(i % 2 == 0 and crevice or rock, 0.6)
  local pts = {}
  for k = 0, 5 do
    local y = lerp(g.y0, g.y1, k/5)
    local l, r = falls_curtain(y)
    pts[#pts+1] = {lerp(l, r, g.t) + rand(-1, 1), y}
  end
  fd:stroke(pts, {pressure={0.55*g.w, 0.25*g.w}, orient="across", ramps={0.15, 0.3}, swell={0.7, 1.0, 0.9, 0.6}})
end
-- the right strand: dark between it and the main curtain is already there; narrow it a little at its left edge
fd:reload(rock, 0.5)
local pts = {}
for k = 0, 5 do local y = lerp(672, 890, k/5); pts[#pts+1] = {falls_lerpy(stR_c, y) - falls_lerpy(stR_w, y)/2 - 1, y} end
fd:stroke(pts, {pressure={0.5, 0.4}, orient="across"})

--@ chunk 56
palette{scrape={glow}}
thinwhite = pile{{"lead white",8},{"yellow ochre",0.2},{"cobalt blue",0.1}, thinner=0.5, name="thinwhite"}
-- 1. restore the dark wall behind the falls
local wall = poly({{380,664},{600,664},{606,900},{372,900}}):roughen(4, 18, 141)
wall = wall - boulder_mask(boulders[3]) - boulder_mask(boulders[4]) - boulder_mask(boulders[7])
work(wall, {hand="body", coverage=3, fill=true, length={15,40}, angle=1.5, load=0.9, edge="soft", tool={kind="filbert", width=10},
  piles={{rock, 1}, {crevice, 0.5}, {woods, 0.3}}})
print(drying(470, 760))

--@ chunk 57
-- Falls by recipe F, scaled
FL = {lipL=392, lipR=528, y0=662, botL=376, botR=548, y1=896}
FR = {lipL=549, lipR=577, y0=668, botL=553, botR=592, y1=896}
function fx(F, t, y)
  local f = (y - F.y0) / (F.y1 - F.y0)
  local l = lerp(F.lipL, F.botL, f*f*0.6 + f*0.4)
  local r = lerp(F.lipR, F.botR, f*f*0.6 + f*0.4)
  return lerp(l, r, t)
end
function curtain_mask(F, grow)
  return mask(function(x, y)
    if y < F.y0 - 2 or y > F.y1 + 4 then return 0 end
    local l, r = fx(F, 0, y), fx(F, 1, y)
    return (x > l - grow and x < r + grow) and 1 or 0
  end)
end
fallsM = curtain_mask(FL, 0) + curtain_mask(FR, 0)
-- 1. lip
local lipm = mask(function(x, y)
  for _, F in ipairs({FL, FR}) do
    if x >= F.lipL and x <= F.lipR then
      local t = (x - F.lipL) / (F.lipR - F.lipL)
      local top = F.y0 - 4 + 4 * (2*t - 1)^2
      if y > top and y < top + 9 then return 1 end
    end
  end
  return 0 end):soften(2)
work(lipm, {hand="body", tool={kind="flat", width=6}, length={8,20}, angle=0.03, coverage=2.5, fill=true, clip=true, piles={{lipglass,1},{haze,0.3}}})
-- 2. thin veil, 3 passes
local fb = brush{kind="flat", width=9, stiffness=0.5}
local n = 0
for pass = 1, 3 do
  for _, F in ipairs({FL, FR}) do
    local step = (F == FL) and 6 or 7
    for x = F.lipL, F.lipR, step do
      n = n + 1
      if n % 2 == 1 then fb:reload(thinwhite, 0.6) end
      local t = (x + rand(-2, 2) - F.lipL) / (F.lipR - F.lipL)
      local yend = F.y0 + (F.y1 - F.y0) * rand(0.55, 1.0)
      local pts = {}
      for k = 0, 4 do local y = lerp(F.y0 + 4, yend, k/4); pts[#pts+1] = {fx(F, t, y) + rand(-1, 1), y} end
      fb:stroke(pts, {pressure={0.5, 0.2}, orient="across"})
    end
  end
end
-- 3. fan drags
local fan = brush{kind="fan", width=16, stiffness=0.5}
for i = 1, 26 do
  if i % 3 == 1 then fan:reload(i % 4 == 0 and fallgray or fallwhite, 0.3) end
  local F = (i % 6 == 0) and FR or FL
  local t = clamp(math.abs(randn(0.35, 0.3)), 0, 1)
  local yend = F.y0 + (F.y1 - F.y0) * rand(0.5, 1.0)
  local pts = {}
  for k = 0, 4 do local y = lerp(F.y0 + 3, yend, k/4); pts[#pts+1] = {fx(F, t, y) + rand(-1.5, 1.5), y} end
  fan:stroke(pts, {pressure={0.55, 0.1}, orient="across", ramps={0.02, 0.6}})
end
-- 4. one vertical blend over the curtain shape
blend((curtain_mask(FL, 6) + curtain_mask(FR, 5)):soften(8) * below(function(x) return FL.y0 + 8 end), {angle=math.pi/2})

--@ chunk 58
-- 6. bright fan drags in the lit (upper-left) part, 7. pointed accents
local fan = brush{kind="fan", width=13, stiffness=0.5}
for i = 1, 12 do
  if i % 3 == 1 then fan:reload(fallwhite, 0.35) end
  local F = (i % 5 == 0) and FR or FL
  local t = clamp(math.abs(randn(0.3, 0.28)), 0.03, 0.97)
  local yend = F.y0 + (F.y1 - F.y0) * rand(0.3, 0.75)
  local pts = {}
  for k = 0, 4 do local y = lerp(F.y0 + 6, yend, k/4); pts[#pts+1] = {fx(F, t, y) + rand(-1, 1), y} end
  fan:stroke(pts, {pressure={0.42, 0.05}, orient="across", ramps={0.02, 0.7}})
end
local rd = brush{kind="round", width=3.5, point=0.7}
for i = 1, 9 do
  rd:reload(fallwhite, 0.6)
  local F = (i % 4 == 0) and FR or FL
  local t = clamp(math.abs(randn(0.35, 0.3)), 0.03, 0.97)
  local ylen = rand(50, 120)
  rd:gesture({{fx(F, t, F.y0 + 6), F.y0 + 6, 0.3}, {fx(F, t, F.y0 + 30) + rand(-1,1), F.y0 + 30, 0.6}, {fx(F, t, F.y0 + ylen) + rand(-2,2), F.y0 + ylen, 0.0}}, {wobble=1})
end
-- rock rib between the two falls, and ragged dark at the outer edges
local db = brush{kind="filbert", width=9, stiffness=0.6}
db:reload(rock, 0.6)
db:gesture({{538, 664, 0.6}, {541, 720, 0.8}, {545, 800, 0.7}, {549, 896, 0.5}}, {wobble=1})
db:reload(crevice, 0.5)
db:gesture({{536, 668, 0.4}, {539, 740, 0.5}, {543, 820, 0.4}, {546, 890, 0.3}}, {wobble=1})
for i = 1, 14 do
  db:reload(rock, 0.45)
  local y0 = rand(675, 880)
  local F = (i % 2 == 0) and FL or FR
  local side = (i % 4 < 2) and 0 or 1
  if F == FR then side = 1 end
  local xe = fx(F, side, y0)
  local dir = (side == 0) and 1 or -1
  db:gesture({{xe - dir*8, y0 - 6, 0.5}, {xe + dir*rand(1,5), y0 + 25, 0.5}, {xe + dir*rand(0,6), y0 + rand(40,80), 0.05}}, {wobble=1.5})
end

--@ chunk 59
for _, p in ipairs({{815,650},{800,500},{780,300},{760,100},{870,650},{900,400},{940,100},{95,560},{90,350},{85,100}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 60
palette{scrape={lipglass, thinwhite, fallgray, fallwhite, crevice}}
birch = pile{{"lead white",8},{"yellow ochre",0.25},{"chrome yellow",0.05}, name="birch"}
bmid = pile{{"lead white",5},{"raw umber",0.4},{"yellow ochre",0.3},{"smalt",0.4}, name="birch_mid"}
bshadow = pile{{"lead white",2},{"raw umber",1},{"smalt",1},{"bone black",0.25},{"cobalt blue",0.2}, name="birch_shadow"}
bwarm = pile{{"lead white",2},{"yellow ochre",1},{"red earth",0.4},{"raw umber",0.4}, name="birch_warm"}
lent = pile{{"bone black",1},{"raw umber",1.2}, name="lenticel"}
function axis_fn(pts)
  return function(y)
    for i = 1, #pts - 1 do
      local a, b = pts[i], pts[i+1]
      if (y <= a[2] and y >= b[2]) then
        local t = (a[2] - y) / (a[2] - b[2])
        return lerp(a[1], b[1], t), lerp(a[3], b[3], t)
      end
    end
    if y > pts[1][2] then return pts[1][1], pts[1][3] end
    return pts[#pts][1], pts[#pts][3]
  end
end
function trunk_mask(pts, seed)
  local poly_pts = {}
  for i = 1, #pts do poly_pts[#poly_pts+1] = {pts[i][1] - pts[i][3]/2, pts[i][2]} end
  for i = #pts, 1, -1 do poly_pts[#poly_pts+1] = {pts[i][1] + pts[i][3]/2, pts[i][2]} end
  return poly(poly_pts, true):roughen(1.5, 12, seed)
end
function paint_birch(pts, seed, o)
  o = o or {}
  local ax = axis_fn(pts)
  local m = trunk_mask(pts, seed)
  if o.clipto then m = m * o.clipto end
  local function u(x, y) local cx, w = ax(y); return (x - cx) / (w/2) end
  local rimk = o.rim or 1
  work(m, {hand="body", tool={kind="flat", width=o.bw or 7, stiffness=0.6}, length={20,50}, coverage=3, fill=true, edge={found=0.7, soft=0.3, period=30},
    angle=-math.pi/2,
    piles={{birch, function(x,y) return rimk * clamp((-u(x,y) - 0.45) * 3, 0, 1) end},
           {bmid, function(x,y) local v = u(x,y); return math.exp(-((v + 0.15)/0.45)^2) end},
           {bshadow, function(x,y) local v = u(x,y); return (o.shadowk or 0.8) * clamp(v*1.5 + 0.1, 0, 1) * clamp((0.95 - v)*5, 0, 1) end},
           {bwarm, function(x,y) return clamp((u(x,y) - 0.75)*5, 0, 1) end}}})
  return m, ax
end
birchA = {{808,702,42},{802,560,38},{792,400,34},{778,200,29},{766,-10,25}}
birchB = {{918,706,31},{923,560,28},{932,380,25},{946,200,21},{960,-10,18}}
mA = paint_birch(birchA, 201)
mB = paint_birch(birchB, 202)

--@ chunk 61
for _, p in ipairs({{100,920},{500,920},{900,920},{300,1000},{700,1050},{200,1150},{600,1200},{900,1150},{100,1180},{950,1220}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 62
print(palette())

--@ chunk 63
palette{scrape={leafrust, leafdeep}}
rockmid = pile{{"lead white",1},{"raw umber",2},{"smalt",0.5},{"yellow ochre",0.5},{"bone black",0.2}, name="rockmid"}
rockwarm = pile{{"lead white",1.5},{"yellow ochre",1},{"red earth",0.8},{"raw umber",1}, name="rockwarm"}
crevice = lent
wcR = worley{seed=301, period=55, jitter=0.85}
nR = noise{seed=302, period=60, octaves=2}
function paint_boulder2(b, o)
  o = o or {}
  local m = boulder_mask(b)
  if o.minus then m = m - o.minus end
  local depth_scale = o.depth or 200
  local function hgt(x, y) return clamp(1 - (y - topy(b.top, x)) / depth_scale, 0, 1) end
  local function sh(x, y)
    local d1, d2, wall, id = wcR:at(x, y)
    local h = hgt(x, y)
    local s = 0.08 + 0.62 * h^2 + 0.26*(id - 0.5) + 0.08*nR(x, y)
    -- planes facing the glow (x=420) catch more
    local side = clamp((420 - x) / 300, -1, 1)
    s = s + 0.1 * side * (id - 0.5) * 2
    if wall < 0.04 then s = s - 0.3 end
    return clamp(s, 0, 1)
  end
  local function mossy(x, y)
    local h = clamp(1 - (y - topy(b.top, x)) / (o.mossdepth or 90), 0, 1)
    return clamp((h + 0.75*nR:at01(x*1.3 + 70, y*1.3) - 1.0) * 3, 0, 1)
  end
  local glowk = function(x) return clamp(1 - math.abs(x - 470) / 550, 0.2, 1) end
  work(m, {hand="body", tool={kind="flat", width=10, stiffness=0.6}, length={14,30}, coverage=3, fill=true, edge={found=0.55, soft=0.45, period=30},
    angle=function(x,y) local d1,d2,w,id = wcR:at(x,y); return 0.3 + id * 1.3 end,
    piles={{crevice, function(x,y) return clamp(1 - sh(x,y)*5, 0, 1) end},
           {rock, function(x,y) local s = sh(x,y); return math.exp(-((s-0.25)/0.15)^2) * (1 - mossy(x,y)) end},
           {rockmid, function(x,y) local s = sh(x,y); return math.exp(-((s-0.5)/0.15)^2) * (1 - mossy(x,y)) end},
           {rockwarm, function(x,y) local s = sh(x,y); return clamp((s - 0.62)*4, 0, 1) * (1 - mossy(x,y)) * glowk(x) end},
           {mossdark, function(x,y) return mossy(x,y) * clamp(1 - sh(x,y)*1.5, 0, 1) end},
           {moss, function(x,y) return mossy(x,y) * math.exp(-((sh(x,y)-0.5)/0.2)^2) end},
           {moss_lit, function(x,y) return mossy(x,y) * clamp((sh(x,y)-0.6)*3, 0, 1) * glowk(x) end}}})
  blend(m:shrink(4):soften(6), {angle=o.blend_angle or 0.6})
  return m
end
-- back boulders first (B1 left, B2, B5, B6 right)
paint_boulder2(boulders[1], {depth=240})
paint_boulder2(boulders[3], {depth=220})

--@ chunk 64
paint_boulder2(boulders[4], {depth=200, minus=mA:grow(2) + mB:grow(2)})
paint_boulder2(boulders[2], {depth=200, minus=mA:grow(2) + mB:grow(2)})

--@ chunk 65
paint_boulder2(boulders[6], {depth=120, mossdepth=60})
paint_boulder2(boulders[7], {depth=90, mossdepth=50})
paint_boulder2(boulders[8], {depth=110, mossdepth=60})
paint_boulder2(boulders[5], {depth=120, mossdepth=60})

--@ chunk 66
steps = {
  {name="L1", back={{-10,578},{150,575},{250,588},{330,622},{386,652}}, front={{-10,598},{150,596},{250,606},{330,636},{390,664}}, bot=716, seed=401},
  {name="R1", back={{576,660},{640,648},{720,652},{800,676},{900,680},{1010,676}}, front={{576,672},{640,662},{720,666},{800,690},{900,694},{1010,690}}, bot=772, seed=402},
  {name="L2", back={{-10,700},{120,698},{260,708},{360,730},{396,745}}, front={{-10,718},{120,716},{260,726},{360,748},{394,760}}, bot=808, seed=403},
  {name="R2", back={{590,762},{700,756},{820,764},{1010,758}}, front={{588,776},{700,770},{820,778},{1010,772}}, bot=900, seed=404},
  {name="L3", back={{-10,792},{90,786},{200,790},{300,812},{350,830}}, front={{-10,808},{90,802},{200,806},{300,828},{356,846}}, bot=900, seed=405},
  {name="R3", back={{598,842},{700,832},{800,836},{862,852}}, front={{596,856},{700,846},{800,850},{866,866}}, bot=900, seed=406},
}
function step_masks(s)
  local top_pts = {}
  for _, p in ipairs(s.back) do top_pts[#top_pts+1] = {p[1], p[2]} end
  for i = #s.front, 1, -1 do top_pts[#top_pts+1] = {s.front[i][1], s.front[i][2]} end
  local topm = outline{pts=top_pts, char="broken", seed=s.seed, amount=0.35}:mask()
  local face_pts = {}
  for _, p in ipairs(s.front) do face_pts[#face_pts+1] = {p[1], p[2]} end
  local xr = s.front[#s.front][1]
  local xl = s.front[1][1]
  face_pts[#face_pts+1] = {xr + (xr > 900 and 0 or 6), s.bot}
  face_pts[#face_pts+1] = {xl - (xl < 50 and 0 or 6), s.bot}
  local facem = outline{pts=face_pts, char="broken", seed=s.seed + 50, amount=0.35}:mask() - topm
  return topm, facem
end
for _, s in ipairs(steps) do s.topm, s.facem = step_masks(s) end
local allm = nil
for _, s in ipairs(steps) do allm = allm and (allm + s.topm + s.facem) or (s.topm + s.facem) end
steps_all = allm
print(allm:area())

--@ chunk 67
steps[1].bot = 752; steps[2].bot = 776; steps[3].bot = 850; steps[4].bot = 900
for _, s in ipairs(steps) do s.topm, s.facem = step_masks(s) end
nS = noise{seed=410, period=50, octaves=3}
nS2 = noise{seed=411, period=22, octaves=2}
function line_y(pts, x) return topy(pts, x) end
function paint_step(s, o)
  o = o or {}
  local face = s.facem
  local top = s.topm
  if o.minus then face = face - o.minus; top = top - o.minus end
  local glowk = function(x) return clamp(1 - math.abs(x - 480) / 560, 0.25, 1) end
  -- face
  work(face, {hand="body", tool={kind="flat", width=9, stiffness=0.6}, length={14,34}, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=30},
    angle=function(x,y) return math.pi/2 + 0.25*nS(x, y) end,
    piles={{crevice, function(x,y) local d = y - line_y(s.front, x); return clamp(1 - d/18, 0, 1) * 1.5 + 0.15 end},
           {rock, function(x,y) return 1 end},
           {woods, function(x,y) return 0.5 * nS:at01(x + 40, y) end},
           {rockmid, function(x,y) local d = y - line_y(s.front, x); return clamp((nS2:at01(x, y*0.4) - 0.6) * 3, 0, 1) * clamp((d - 15)/20, 0, 1) * 0.9 end}}})
  -- top surface
  work(top, {hand="body", tool={kind="flat", width=7, stiffness=0.6}, length={10,26}, coverage=3, fill=true, edge={found=0.5, soft=0.5, period=25},
    angle=function(x,y) return 0.08*nS(x,y) end,
    piles={{rockwarm, function(x,y) return glowk(x) * (1 - clamp((nS:at01(x*1.4, y*2) - 0.45)*3, 0, 1)) end},
           {rockmid, function(x,y) return 0.5 * (1 - glowk(x)) + 0.2 end},
           {moss, function(x,y) return clamp((nS:at01(x*1.4, y*2) - 0.45)*3, 0, 1) end},
           {moss_lit, function(x,y) return glowk(x) * clamp((nS:at01(x*1.4, y*2) - 0.55)*3, 0, 1) end},
           {mossdark, function(x,y) return 0.6 * clamp((nS:at01(x*1.4, y*2) - 0.45)*3, 0, 1) * (1 - glowk(x)) end}}})
end
paint_step(steps[1])
paint_step(steps[2], {minus=mA:grow(1) + mB:grow(1)})

--@ chunk 68
for _, p in ipairs({{100,150},{300,60},{700,200},{900,300},{100,450},{250,500},{500,450},{700,450},{150,620},{850,640},{470,760},{500,1000},{300,1150},{800,1200}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 69
print(palette())

--@ chunk 70
palette{scrape={bmid, bwarm, rockmid}}
leafrust = pile{{"red earth",2},{"vermilion",0.6},{"yellow ochre",1.2}, name="leafrust"}
leafgold = pile{{"chrome yellow",2},{"yellow ochre",1.5},{"lead white",0.4}, name="leafgold"}
brushdark = pile{{"raw umber",2},{"red earth",1.5},{"Prussian blue",0.3},{"yellow ochre",0.4}, name="brushdark"}
local oL = outline{pts={{-10,438},{40,444},{95,452},{140,470},{185,494},{225,520},{262,548},{300,578},{335,610},{365,640},{392,662},{392,760},{-10,760}}, char="soft", seed=501, amount=0.9, lobe=28}
local oR = outline{pts={{596,664},{622,650},{655,634},{695,622},{745,611},{790,602},{840,596},{890,590},{945,584},{1010,578},{1010,800},{596,800}}, char="soft", seed=502, amount=0.9, lobe=28}
bankL = oL:mask()
bankR = oR:mask()
banks = (bankL + bankR) - steps_all:shrink(3) - fallsM:grow(4)
print(palette())
print(banks:area())

--@ chunk 71
bankL_line = {{-10,438},{40,444},{95,452},{140,470},{185,494},{225,520},{262,548},{300,578},{335,610},{365,640},{392,662}}
bankR_line = {{596,664},{622,650},{655,634},{695,622},{745,611},{790,602},{840,596},{890,590},{945,584},{1010,578}}
local keepL = above({{-10,584},{150,581},{250,594},{330,628},{386,658}})
local keepR = above({{576,666},{640,654},{720,658},{800,682},{900,686},{1010,682}})
banks = (bankL * keepL + bankR * keepR) - fallsM:grow(4)
local hn = noise{seed=511, period=70, octaves=3, persistence=0.5}
local function crest(x) if x < 500 then return topy(bankL_line, x) else return topy(bankR_line, x) end end
local function bshade(x, y)
  local e = 4
  local dx = (hn(x+e, y) - hn(x-e, y)) / (2*e)
  local dy = (hn(x, y+e) - hn(x, y-e)) / (2*e)
  local lx, ly = gx - x, (gy - 100) - y
  local l = math.sqrt(lx*lx + ly*ly) + 1e-6
  lx, ly = lx/l, ly/l
  local depth = y - crest(x)
  local top = clamp(1 - depth/60, 0, 1)
  return clamp(0.15 + 35*(dx*lx + dy*ly) + 0.45*top + 0.1*hn(x,y), 0, 1)
end
local function far(x) return clamp(1 - math.abs(x - 490)/420, 0, 1) end
work(banks, {hand="body", tool={kind="filbert", width=9, stiffness=0.5}, length={7,16}, coverage=2.5, fill=true, edge="soft",
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/11 + y/7) end,
  scale_at=function(x,y) return 0.8 + 0.5*(1 - far(x)) end,
  piles={{brushdark, function(x,y) return clamp(1 - bshade(x,y)*2.6, 0, 1) end},
         {deeprust, function(x,y) local s = bshade(x,y); return math.exp(-((s-0.38)/0.14)^2) end},
         {leafrust, function(x,y) local s = bshade(x,y); return math.exp(-((s-0.55)/0.12)^2) * 0.8 end},
         {amber, function(x,y) local s = bshade(x,y); return math.exp(-((s-0.72)/0.1)^2) end},
         {leafgold, function(x,y) return clamp((bshade(x,y) - 0.78)*4, 0, 1) end},
         {haze, function(x,y) return far(x)^1.5 * 0.9 end}}})

--@ chunk 72
local fol = (canopy:grow(14) + banks:grow(6)):soften(12) - fallsM:grow(6) - mA:grow(2) - mB:grow(2)
blend(fol, {angle=0.9})
blend(fol, {angle=2.3})

--@ chunk 73
local nd = noise{seed=521, period=35, octaves=3}
local nd2 = noise{seed=522, period=90, octaves=2}
local L1b = steps[1].back
local R1b = steps[2].back
drape = mask(function(x, y)
  local t, len
  if x < 384 then
    t = topy(L1b, x) - 6
    len = 18 + 60 * nd2:at01(x, 0) + 22 * nd(x, 0)
    if x > 330 then len = len * clamp((384 - x)/54, 0, 1) end
  elseif x > 598 then
    t = topy(R1b, x) - 6
    len = 12 + 45 * nd2:at01(x, 50) + 18 * nd(x, 50)
    if x < 650 then len = len * clamp((x - 598)/52, 0, 1) end
  else return 0 end
  local d = y - t
  if d < 0 or d > len then return 0 end
  -- ragged lower edge: fronds
  local fr = nd(x * 1.8, y * 0.6)
  return clamp((len - d) / 6 + fr * 0.8, 0, 1)
end) - fallsM:grow(6)
local function far(x) return clamp(1 - math.abs(x - 490)/420, 0, 1) end
local nn = noise{seed=523, period=30, octaves=2}
work(drape, {hand="body", tool={kind="filbert", width=8, stiffness=0.5}, length={6,14}, coverage=2.5, fill=true, edge="loose",
  angle=function(x,y) return 1.57 + 0.6*math.sin(x/9 + y/5) end,
  piles={{brushdark, 1}, {deeprust, function(x,y) return 0.6 + 0.4*nn(x,y) end},
         {leafrust, function(x,y) return 0.35 * clamp(nn:at01(x,y) - 0.4, 0, 1) * 2 end},
         {mossdark, function(x,y) return 0.3 * clamp(nn:at01(x+100,y) - 0.5, 0, 1) * 2 end},
         {haze, function(x,y) return far(x)^2 * 0.5 end}}})

--@ chunk 74
local n1 = noise{seed=531, period=26, octaves=3}
local n2 = noise{seed=532, period=18, octaves=2}
local dz = drape:grow(10)
local darkm = dz * mask(function(x,y) return clamp((n1:at01(x,y) - 0.42) * 4, 0, 1) end)
stipple(darkm, {pile=woods, width=10, coverage=1.0, cluster={0.5, 18}, feather=0.5, drag={3, 1.4}, pressure={0.35, 0.7}, dips={14, 0.7, 0.3}})
local midm = drape * mask(function(x,y) return clamp((n2:at01(x,y) - 0.55) * 4, 0, 1) end)
stipple(midm, {pile=leafrust, width=7, coverage=0.6, cluster={0.6, 14}, feather=0.6, drag={3, 1.3}, pressure={0.3, 0.6}, dips={12, 0.7, 0.3}})
local litm = drape * mask(function(x,y) return clamp((n2:at01(x+70,y) - 0.68) * 5, 0, 1) end) * mask(function(x,y)
  local t = (x < 450) and topy(steps[1].back, x) or topy(steps[2].back, x)
  return clamp(1 - (y - t)/30, 0, 1) end)
stipple(litm, {pile=amber, width=6, coverage=0.6, cluster={0.6, 12}, feather=0.6, drag={2, 1.3}, pressure={0.3, 0.6}, dips={12, 0.7, 0.3}})

--@ chunk 75
local fz = (drape:grow(8) + banks):soften(8) - fallsM:grow(6) - mA:grow(2) - mB:grow(2)
blend(fz, {angle=1.2})

--@ chunk 76
for _, p in ipairs({{100,150},{700,200},{900,300},{60,450},{780,520},{150,700},{850,720},{470,760},{150,850},{700,860},{500,950},{200,1050},{500,1100},{800,1200},{100,1200}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 77
palette{scrape={rockwarm, moss}}
birchA2 = {{806,692,46},{807,670,40},{805,600,38},{802,560,38},{792,400,34}}
birchB2 = {{917,694,35},{918,672,30},{921,600,29},{923,560,28},{932,380,25}}
local band = below(function(x) return 520 end) * above(function(x) return 700 end)
mA2 = paint_birch(birchA2, 211, {clipto=band})
mB2 = paint_birch(birchB2, 212, {clipto=band})
mA = mA + mA2; mB = mB + mB2

--@ chunk 78
function birch_shade(pts, seed, m)
  local ax = axis_fn(pts)
  local sm = m * mask(function(x, y) local cx, w = ax(y); local u = (x - cx)/(w/2); return clamp((u - 0.25) * 4, 0, 1) * clamp((0.9 - u)*8, 0, 1) end)
  work(sm, {hand="body", tool={kind="flat", width=5, stiffness=0.6}, length={20,50}, coverage=1.6, angle=-math.pi/2, clip=true, pile=bshadow})
end
function birch_marks(pts, nmarks, scars, mw)
  local ax = axis_fn(pts)
  local rd = brush{kind="round", width=mw or 4, point=0.6, stiffness=0.5}
  local ytop, ybot = pts[#pts][2], pts[1][2]
  for i = 1, nmarks do
    if i % 5 == 1 then rd:reload(lent, rand(0.4, 0.6)) end
    local y = lerp(ybot - 10, math.max(ytop, 0), rand(0,1)^1.4)
    local cx, w = ax(y)
    local len = w * rand(0.12, 0.55)
    local u0 = rand(-0.95, 0.95 - 2*len/w)
    local x0 = cx + u0 * w/2
    local bow = rand(0.5, 2.5)
    rd:gesture({{x0, y, 0.15}, {x0 + len*0.5, y + bow*0.4, rand(0.35, 0.8)}, {x0 + len, y + rand(-1,1), 0.08}}, {wobble=0.5})
  end
  for _, s in ipairs(scars) do
    local cx, w = ax(s.y)
    rd:reload(lent, 0.7)
    local xm = cx + s.u * w/2
    rd:gesture({{xm - w*0.35, s.y - w*0.22, 0.3}, {xm, s.y + w*0.08, 0.9}, {xm + w*0.35, s.y - w*0.18, 0.25}}, {wobble=0.5})
    rd:gesture({{xm - w*0.18, s.y - w*0.1, 0.5}, {xm + w*0.1, s.y + w*0.04, 0.8}}, {wobble=0.5})
  end
  -- base furrows
  local rb = brush{kind="round", width=(mw or 4) + 1, point=0.4}
  for i = 1, 9 do
    rb:reload(lent, 0.5)
    local cx, w = ax(ybot - 15)
    local x = cx + rand(-0.85, 0.85) * w/2
    rb:gesture({{x, ybot, 0.7}, {x + rand(-1,1), ybot - 25, 0.5}, {x + rand(-2,2), ybot - rand(40, 80), 0.05}}, {wobble=1})
  end
end
local fullA = {{806,692,46},{807,670,40},{805,600,38},{802,560,38},{792,400,34},{778,200,29},{766,-10,25}}
local fullB = {{917,694,35},{918,672,30},{921,600,29},{923,560,28},{932,380,25},{946,200,21},{960,-10,18}}
birch_shade(fullA, 221, mA)
birch_shade(fullB, 222, mB)
birch_marks(fullA, 70, {{y=330, u=0.1}, {y=505, u=-0.2}, {y=150, u=0.2}}, 4)
birch_marks(fullB, 50, {{y=260, u=0.0}, {y=460, u=0.15}}, 3.5)
fullA_pts, fullB_pts = fullA, fullB

--@ chunk 79
bshadow2 = pile{{"lead white",1},{"raw umber",1},{"smalt",1},{"bone black",0.3},{"red earth",0.15}, name="birch_shadow2"}
local function shade2(pts, m)
  local ax = axis_fn(pts)
  local sm = m * mask(function(x, y) local cx, w = ax(y); local u = (x - cx)/(w/2); return clamp((u - 0.35) * 4, 0, 1) * clamp((0.92 - u)*8, 0, 1) end)
  work(sm, {hand="body", tool={kind="flat", width=5, stiffness=0.6}, length={25,60}, coverage=2, angle=-math.pi/2, clip=true, pile=bshadow2, pressure={0.5, 0.8}})
end
shade2(fullA_pts, mA)
shade2(fullB_pts, mB)
-- undergrowth at the feet
local feet = (ellipse(806, 690, 40, 22) + ellipse(918, 692, 32, 20)):roughen(6, 14, 231)
work(feet, {hand="body", tool={kind="filbert", width=7, stiffness=0.5}, length={6,14}, coverage=2.5, fill=true, edge="loose",
  angle=function(x,y) return -1.57 + rand(-0.7, 0.7) end,
  piles={{brushdark, 1}, {deeprust, 0.6}, {woods, 0.5}, {leafrust, 0.25}}})

--@ chunk 80
palette{scrape={bmid, bwarm, bshadow2, bshadow}}
rockgray = mix{{rock, 0.5}, {haze, 0.5}, name="rockgray"}
shelf = mix{{mossdark, 0.5}, {deeprust, 0.3}, {amber, 0.2}, name="shelf"}
print(palette())

--@ chunk 81
ledges = {
  {{-10,648},{100,644},{200,654},{300,672},{372,698}},
  {{-10,700},{90,696},{180,704},{280,716},{376,738}},
  {{-10,746},{120,742},{240,750},{340,762},{380,772}},
  {{602,700},{680,694},{780,700},{880,704},{1010,700}},
  {{598,742},{700,738},{820,744},{1010,742}},
}
local nl = noise{seed=601, period=40, octaves=2}
local function glowk(x) return clamp(1 - math.abs(x - 480) / 520, 0.2, 1) end
for i, L in ipairs(ledges) do
  local pts_top, pts_under = {}, {}
  for _, p in ipairs(L) do pts_top[#pts_top+1] = {p[1], p[2] - 6}; pts_under[#pts_under+1] = {p[1], p[2] + 6} end
  local topm = ribbon(pts_top, 11):roughen(3, 14, 610 + i) - fallsM:grow(5) - mA - mB
  local underm = ribbon(pts_under, 9):roughen(3, 12, 620 + i) - fallsM:grow(5) - mA - mB
  work(underm, {hand="body", tool={kind="flat", width=7, stiffness=0.6}, length={18,40}, coverage=2.5, fill=true, edge="soft", angle=0.0,
    piles={{lent, 1}, {rock, 0.6}}})
  work(topm, {hand="body", tool={kind="flat", width=6, stiffness=0.6}, length={12,30}, coverage=2.5, fill=true, edge={found=0.6, soft=0.4, period=25}, angle=0.0,
    piles={{shelf, 1}, {mossdark, function(x,y) return 0.5*nl:at01(x,y) end}, {moss_lit, function(x,y) return glowk(x) * clamp((nl:at01(x+90,y) - 0.45)*2.5, 0, 1) end},
           {leafrust, function(x,y) return 0.5*clamp((nl:at01(x+200,y) - 0.55)*3, 0, 1) end}}})
end

--@ chunk 82
wallL = poly({{-10,630},{380,640},{386,780},{-10,780}}) 
wallR = poly({{592,660},{1010,660},{1010,780},{592,780}})
walls = (wallL + wallR) - fallsM:grow(5) - mA:grow(2) - mB:grow(2)
-- joints
local jb = brush{kind="flat", width=6, stiffness=0.6}
local lb = brush{kind="flat", width=4, stiffness=0.6}
local function glowk(x) return clamp(1 - math.abs(x - 480) / 520, 0.2, 1) end
local xs = {}
local x = rand(10, 60)
while x < 1000 do
  if not (x > 370 and x < 600) then xs[#xs+1] = x end
  x = x + rand(45, 130)
end
for _, x0 in ipairs(xs) do
  -- which band rows does this joint cross? pick 1-2 consecutive ledges
  local side = (x0 < 500) and {1,2,3} or {4,5}
  local k = side[math.random(#side)]
  local L = ledges[k]
  local y0 = topy(L, x0) + 5
  local nextL = ledges[k+1]
  local y1 = (nextL and ((x0 < 500 and k < 3) or (x0 > 500 and k < 5))) and topy(nextL, x0) - 8 or y0 + rand(30, 45)
  local tilt = rand(-4, 4)
  jb:reload(lent, 0.6)
  jb:stroke({{x0, y0}, {x0 + tilt*0.5, (y0+y1)/2}, {x0 + tilt, y1}}, {pressure={0.6, 0.4}, orient="across"})
  -- lit edge of the block on the glow side
  local dir = (x0 < 480) and 1 or -1
  lb:reload(rockgray, 0.45)
  lb:stroke({{x0 + dir*5, y0 + 2}, {x0 + dir*5 + tilt*0.5, (y0+y1)/2}, {x0 + dir*5 + tilt, y1 - 2}}, {pressure={0.45, 0.25}, orient="across"})
end
blend(walls:soften(6), {angle=math.pi/2})

--@ chunk 83
for _, p in ipairs({{470,650},{470,700},{470,800},{560,800},{450,640},{420,600},{500,610},{200,560},{700,620},{150,680},{800,720},{150,850},{700,860}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 84
streamlight = mix{{haze, 0.5}, {birch, 0.3}, {amber, 0.2}, name="streamlight"}
upstream = outline{{448,594},{478,590},{505,600},{535,616},{565,636},{588,656},{582,666},{470,664},{386,666},{392,650},{410,630},{428,610}, char="soft", seed=701, amount=0.4}:mask()
local un = noise{seed=702, period=30, octaves=2}
work(upstream, {hand="body", tool={kind="flat", width=7, stiffness=0.5}, length={14,34}, coverage=3, fill=true, edge="soft",
  angle=function(x,y) return 0.04*un(x,y) end,
  piles={{streamlight, 1}, {haze, function(x,y) return clamp((y-600)/60, 0, 1)*0.6 end}, {birch, function(x,y) return clamp(1 - math.abs(x - 470)/70, 0, 1) * clamp((y - 620)/40, 0, 1) * 0.6 end},
         {brushdark, function(x,y) local l = math.abs(x - (470 + (y-600)*0.4)); return clamp((l - 60 - (y-600)*0.9)/30, 0, 1) * 0.7 end}}})

--@ chunk 85
local near = outline{{360,600},{420,596},{440,606},{424,626},{404,648},{388,666},{360,666}, char="soft", seed=711, amount=0.6}:mask()
            + outline{{500,592},{560,596},{610,610},{612,668},{590,668},{566,640},{536,618},{508,602}, char="soft", seed=712, amount=0.6}:mask()
near = near - fallsM:grow(3)
local hz = mix{{brushdark, 0.45}, {haze, 0.35}, {deeprust, 0.2}, name="nearbank"}
work(near, {hand="body", tool={kind="filbert", width=7, stiffness=0.5}, length={6,14}, coverage=2.5, fill=true, edge="soft",
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/11 + y/7) end,
  piles={{hz, 1}, {brushdark, function(x,y) return clamp((y - 610)/50, 0, 1) end}, {amber, function(x,y) return clamp((620 - y)/30, 0, 0.6) end}}})
-- stream reflections: horizontal strokes
local fb = brush{kind="flat", width=5, stiffness=0.5}
for i = 1, 26 do
  local y = rand(596, 662)
  local half = 14 + (y - 592) * 1.35
  local cx = 470 + (y - 592) * 0.25
  local side = (i % 2 == 0) and -1 or 1
  local x0 = cx + side * half * rand(0.45, 1.0)
  local len = rand(10, 28) * (0.5 + (y - 592)/70)
  fb:reload(i % 3 == 0 and brushdark or hz, 0.45)
  fb:stroke({{x0, y}, {x0 - side * len, y + rand(-0.5, 0.5)}}, {pressure={0.4, 0.2}, orient="across"})
end
-- a few thin bright ripple lines in the center
local rb = brush{kind="round", width=2.5, point=0.6}
for i = 1, 8 do
  local y = rand(605, 660)
  local cx = 470 + (y - 592) * 0.25 + rand(-15, 15)
  rb:reload(birch, 0.5)
  rb:gesture({{cx - rand(6, 18), y, 0.1}, {cx, y + 0.3, 0.6}, {cx + rand(6, 18), y, 0.1}}, {wobble=0.5})
end
blend(upstream:soften(4), {angle=0.0})

--@ chunk 86
palette{scrape={shelf, rockgray}}
nearbank = mix{{brushdark, 0.45}, {haze, 0.35}, {deeprust, 0.2}, name="nearbank2"}
local corners = outline{{418,588},{450,590},{462,600},{452,616},{436,628},{420,630},{410,610}, char="soft", seed=721, amount=0.5}:mask()
              + outline{{486,588},{512,590},{540,600},{548,616},{528,614},{506,606},{490,600}, char="soft", seed=722, amount=0.5}:mask()
work(corners, {hand="body", tool={kind="filbert", width=6, stiffness=0.5}, length={5,12}, coverage=2.5, fill=true, edge="soft",
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/11 + y/7) end,
  piles={{nearbank, 0.6}, {haze, 0.6}, {amber, 0.3}}})
print(palette())

--@ chunk 87
tongue = mix{{streamlight, 0.45}, {mossdark, 0.3}, {amber, 0.25}, name="tongue"}
-- tongue band: from the brink (y~662) down ~22 units, slightly convex
local function brink(x) return 661 - 3 * (1 - ((x - 485)/100)^2) end
tongue_m = mask(function(x, y)
  local inMain = x > 390 and x < 526
  local inR = x > 551 and x < 576
  if not (inMain or inR) then return 0 end
  local b = brink(x)
  local d = y - b
  local len = 18 + 8 * math.sin(x / 9)
  return (d > -3 and d < len) and 1 or 0
end):soften(3)
work(tongue_m, {hand="body", tool={kind="flat", width=6, stiffness=0.5}, length={10,22}, coverage=2.5, fill=true, clip=true,
  angle=math.pi/2, piles={{tongue, 1}, {streamlight, 0.3}}})
-- highlight at the brink: a thin curving line
local rb = brush{kind="round", width=3, point=0.5}
rb:reload(birch, 0.7)
rb:gesture({{392, brink(392)+1, 0.2}, {430, brink(430), 0.6}, {470, brink(470) - 0.5, 0.7}, {505, brink(505), 0.5}, {524, brink(524)+1, 0.15}}, {wobble=0.6})
rb:reload(birch, 0.6)
rb:gesture({{552, 664, 0.2}, {563, 663, 0.5}, {575, 664, 0.15}}, {wobble=0.4})
-- streaks emerge from the tongue: blend down
blend(tongue_m:grow(10):soften(8), {angle=math.pi/2})

--@ chunk 88
-- 1. far bank above the brink, replacing the stream blob and the corner puffs
local zone = outline{{372,578},{430,572},{480,568},{540,574},{600,584},{612,640},{596,662},{390,662},{368,640}, char="soft", seed=731, amount=0.5}:mask() - fallsM
local nz = noise{seed=732, period=40, octaves=3}
work(zone, {hand="body", tool={kind="filbert", width=8, stiffness=0.5}, length={7,16}, coverage=3, fill=true, edge="soft",
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/11 + y/7) end,
  piles={{nearbank, 1},
         {haze, function(x,y) return clamp((610 - y)/35, 0, 1) * 1.2 end},
         {brushdark, function(x,y) return clamp((y - 615)/35, 0, 1) * 1.3 end},
         {deeprust, function(x,y) return 0.4 * nz:at01(x, y) end},
         {amber, function(x,y) return 0.5 * clamp((nz:at01(x+60, y) - 0.55)*3, 0, 1) * clamp((640 - y)/40, 0, 1) end}}})

--@ chunk 89
blend(outline{{372,578},{430,572},{480,568},{540,574},{600,584},{612,640},{596,660},{390,660},{368,640}, char="soft", seed=731, amount=0.5}:mask():soften(10) - fallsM:grow(2), {angle=math.pi/2})
-- the brink: a thin glassy strip of stream surface, seen edge-on
local strip = mask(function(x, y)
  local inM = x > 386 and x < 530
  local inR = x > 548 and x < 580
  if not (inM or inR) then return 0 end
  local top = 652 + 0.0004 * (x - 470)^2 * 10
  return (y > top and y < 662) and 1 or 0
end):soften(2)
work(strip, {hand="body", tool={kind="flat", width=5}, length={12,30}, coverage=3, fill=true, clip=true, angle=0.0,
  piles={{streamlight, 1}, {nearbank, function(x,y) return clamp((658 - y)/6, 0, 1) end}}})

--@ chunk 90
for _, p in ipairs({{400,580},{480,600},{560,620},{450,650},{470,700},{470,850},{380,850},{600,800},{620,640}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 91
-- misty woods directly above the brink, merging with the background
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local zone = outline{{352,560},{430,552},{500,552},{570,560},{630,572},{628,640},{600,664},{380,664},{350,640}, char="soft", seed=741, amount=0.5}:mask()
zone = zone - fallsM:shrink(1)
local nz = noise{seed=742, period=45, octaves=3}
work(zone, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, length={14,30}, coverage=3, fill=true, edge="soft", load=0.9,
  angle=function(x,y) return 1.5 + 0.2*math.sin(x/30) end,
  piles={{haze, 1.0},
         {amber, function(x,y) return 0.35 + 0.3*nz:at01(x,y) end},
         {deeprust, function(x,y) return 0.25 * clamp((y - 600)/50, 0, 1) end},
         {brushdark, function(x,y) return clamp((y - 625)/30, 0, 1) * (0.5 + 0.6*nz:at01(x+80,y)) end}}})
blend(zone:soften(12), {angle=math.pi/2})

--@ chunk 92
palette{scrape={tongue, nearbank}}
local nb = noise{seed=751, period=22, octaves=3}
local function btop(x) return 606 + 8*math.sin(x/37) + 7*nb(x, 0) end
farband = mask(function(x, y)
  if x < 340 or x > 640 then return 0 end
  local t = btop(x)
  if y < t or y > 666 then return 0 end
  return 1
end):soften(3) - fallsM:shrink(1)
farbank_m = pile{{"raw umber",1.2},{"red earth",1.2},{"yellow ochre",0.8},{"lead white",1.6},{"smalt",0.3},{"Prussian blue",0.08}, name="farbank_m"}
work(farband, {hand="body", tool={kind="filbert", width=7, stiffness=0.5}, length={6,14}, coverage=3, fill=true, edge="loose", load=0.9,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/11 + y/7) end,
  piles={{farbank_m, 1}, {brushdark, function(x,y) return clamp((y - 625)/30, 0, 1) * 0.9 end},
         {amber, function(x,y) return 0.4*clamp((nb:at01(x*2, y*2) - 0.6)*3, 0, 1) * clamp((630 - y)/20, 0, 1) end}}})
print(palette())

--@ chunk 93
local nb = noise{seed=761, period=26, octaves=3}
local function btop(x) return 603 + 9*math.sin(x/41) + 8*nb(x, 0) + 0.0009*(x - 485)^2 end
farband2 = mask(function(x, y)
  local t = btop(x)
  if y < t or y > 668 then return 0 end
  local side = clamp(1 - (math.abs(x - 485) - 150)/60, 0, 1)
  return side
end):soften(4) - fallsM:shrink(1)
local hn = noise{seed=762, period=40, octaves=3}
work(farband2, {hand="body", tool={kind="filbert", width=7, stiffness=0.5}, length={6,14}, coverage=3, fill=true, edge="soft", load=0.9,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/11 + y/7) end,
  piles={{deeprust, function(x,y) return 0.6 + 0.4*hn(x,y) end},
         {brushdark, function(x,y) return 0.3 + clamp((y - btop(x) - 15)/25, 0, 1) end},
         {haze, function(x,y) return 0.9 * clamp(1 - (y - btop(x))/40, 0.25, 1) end},
         {amber, function(x,y) return 0.6*clamp((hn:at01(x*1.5, y*1.5) - 0.55)*3, 0, 1) * clamp(1 - (y - btop(x))/25, 0, 1) end}}})

--@ chunk 94
local up = mask(function(x, y)
  local dx = math.abs(x - 485)
  if y < 470 or y > 620 then return 0 end
  return clamp(1 - (dx - 180)/60, 0, 1) * clamp((y - 470)/40, 0, 1) * clamp((622 - y)/15, 0, 1)
end) - fallsM:grow(4)
blend(up, {angle=math.pi/2})
blend(up, {angle=math.pi/2 + 0.3})

--@ chunk 95
-- Notch 1: scrape the brown bar and the ghost curtain's lower part down
local k = knife{width=40}
for y = 600, 668, 14 do
  k:scrape({{300, y}, {480, y}, {690, y}}, {pressure=1})
  k:wipe()
end
for x = 250, 700, 30 do
  k:scrape({{x, 470}, {x, 540}, {x, 600}}, {pressure=0.8})
  k:wipe()
end
for _, p in ipairs({{450,630},{350,620},{620,640},{480,520},{300,500}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 96
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}, name="glow"}
notch_m = mask(function(x, y)
  if y > 664 then return 0 end
  local dx = math.abs(x - 485)
  local w = 200 + (664 - y) * 0.15
  return clamp((w - dx) / 30, 0, 1) * clamp((y - 455) / 50, 0, 1)
end) - fallsM:shrink(2)
local nz = noise{seed=771, period=50, octaves=3}
work(notch_m, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, length={20,50}, coverage=3, fill=true, load=0.9, hug=false,
  angle=function(x,y) return 1.5 + 0.12*math.sin(x/29) end,
  piles={{glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/260)^1.2 * 1.3 end},
         {haze, function(x,y) return 0.9 end},
         {amber, function(x,y) return 0.35 + 0.25*nz:at01(x,y) end},
         {deeprust, function(x,y) local dx = math.abs(x - 485); return clamp((dx - 90)/100, 0, 1) * 0.6 * clamp((y - 540)/80, 0, 1) end},
         {woods, function(x,y) local dx = math.abs(x - 485); return clamp((dx - 120)/80, 0, 1) * clamp((y - 600)/50, 0, 1) * 0.8 end}}})
blend(notch_m:grow(10):soften(20), {angle=math.pi/2})

--@ chunk 97
for _, p in ipairs({{300,150},{400,250},{450,350},{350,420},{600,300},{650,450},{250,350},{200,280},{500,120},{560,200},{150,300},{700,400}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 98
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
crest_pts = {{-10,446},{40,452},{95,460},{140,478},{185,502},{225,528},{262,556},{300,586},{335,616},{365,644},{392,664},{596,666},{622,656},{655,640},{695,628},{745,617},{790,608},{840,602},{890,596},{945,590},{1010,584}}
local nb = noise{seed=781, period=30, octaves=2}
glowzone = mask(function(x, y)
  local c = topy(crest_pts, x) + 6 * nb(x, 0)
  return clamp((c - y) / 6, 0, 1)
end) - canopy:shrink(5) - mA:grow(3) - mB:grow(3)
print(glowzone:area())
work(glowzone, {hand="body", tool={kind="filbert", width=14, stiffness=0.5}, length={30,80}, coverage=3, fill=true, load=0.9, clip=glowzone:grow(3),
  angle=function(x,y) return 1.45 + 0.2*math.sin(x/90) + 0.15*math.sin(y/70) end,
  piles={{glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/210)^1.4 * 1.7 end},
         {haze, function(x,y) local d=dist(x,y); return math.exp(-((d-180)/120)^2) end},
         {amber, function(x,y) local d=dist(x,y); return math.exp(-((d-330)/120)^2) end},
         {deeprust, function(x,y) local d=dist(x,y); return math.exp(-((d-470)/130)^2) end},
         {woods, function(x,y) local d=dist(x,y); return math.max(0, (d-450)/250) + 0.6*clamp((y - topy(crest_pts, x) + 70)/70, 0, 1) * clamp((math.abs(x-485) - 80)/120, 0, 1) end}}})

--@ chunk 99
local gz = glowzone:soften(12)
blend(gz, {angle=math.pi/2})
blend(gz, {angle=math.pi/2 + 0.25})
blend(gz, {angle=math.pi/2 - 0.25})

--@ chunk 100
local k = knife{width=40}
for y = 600, 900, 16 do
  k:scrape({{-10, y}, {180, y}, {370, y}}, {pressure=1}); k:wipe()
  k:scrape({{600, y}, {800, y}, {1010, y}}, {pressure=1}); k:wipe()
end
for _, p in ipairs({{100,700},{300,800},{700,700},{900,850},{150,620},{850,640}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 101
palette{scrape={streamlight, nearbank2}}
print(palette())

--@ chunk 102
rim_warm = mix{{amber, 0.5}, {glow, 0.3}, {leafrust, 0.2}, name="rim_warm"}
LA_top = {{-10,446},{40,452},{95,460},{140,478},{185,502},{225,528},{262,556},{300,586},{335,616},{365,644},{396,668}}
RA_top = {{578,668},{622,656},{655,640},{695,628},{745,617},{790,608},{840,602},{890,596},{945,590},{1010,584}}
local nb = noise{seed=801, period=30, octaves=2}
LA = outline{pts={{-10,446},{40,452},{95,460},{140,478},{185,502},{225,528},{262,556},{300,586},{335,616},{365,644},{396,668},{396,890},{-10,890}}, char="soft", seed=802, amount=0.6, lobe=18}:mask() - fallsM:shrink(2)
RA = outline{pts={{578,668},{622,656},{655,640},{695,628},{745,617},{790,608},{840,602},{890,596},{945,590},{1010,584},{1010,890},{578,890}}, char="soft", seed=803, amount=0.6, lobe=18}:mask() - fallsM:shrink(2)
-- keep birch trunks above their feet
local feetA = below(function(x) return 642 end)
local feetB = below(function(x) return 618 end)
RA = RA - (mA - feetA) - (mB - feetB)
local hn = noise{seed=804, period=55, octaves=3, persistence=0.5}
function fol_mass(m, top, o)
  local function rim(x, y) return clamp(1 - (y - topy(top, x)) / (o.rimw or 10), 0, 1) end
  local function dn(x) return clamp(math.abs(x - 485) / (o.span or 480), 0, 1) end
  local function sh(x, y)
    local e = 4
    local dx = (hn(x+e, y) - hn(x-e, y)) / (2*e)
    local dy = (hn(x, y+e) - hn(x, y-e)) / (2*e)
    local lx, ly = gx - x, (gy - 100) - y
    local l = math.sqrt(lx*lx + ly*ly) + 1e-6
    return clamp(0.25 + 30*(dx*lx/l + dy*ly/l) + 0.1*hn(x,y) + 0.25*dn(x), 0, 1)
  end
  work(m, {hand="body", tool={kind="filbert", width=9, stiffness=0.5}, length={7,16}, coverage=3, fill=true, edge="soft", load=0.9,
    angle=function(x,y) return 1.57 + 0.9*math.sin(x/11 + y/7) end,
    piles={{rock, function(x,y) return clamp(1 - dn(x)*2.5, 0, 1) * (1 - rim(x,y)) end},
           {brushdark, function(x,y) return clamp(1 - sh(x,y)*2, 0, 1) * (1 - rim(x,y)) end},
           {deeprust, function(x,y) local s = sh(x,y); return math.exp(-((s-0.45)/0.15)^2) * (0.3 + dn(x)) * (1 - rim(x,y)) end},
           {leafrust, function(x,y) local s = sh(x,y); return clamp((s - 0.55)*3, 0, 1) * dn(x) * 0.8 * (1 - rim(x,y)) end},
           {woods, function(x,y) return 0.4 * clamp((y - topy(top, x) - 60)/80, 0, 1) end},
           {rim_warm, function(x,y) return rim(x,y) * (0.5 + 0.5*nb:at01(x*3, 0)) * 1.4 end}}})
end
fol_mass(LA, LA_top, {span=480})
fol_mass(RA, RA_top, {span=520})

--@ chunk 103
local m = (LA + RA):shrink(3):soften(6)
blend(m, {angle=1.2})
blend(m, {angle=2.0})

--@ chunk 104
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
strip2 = mask(function(x, y)
  if y < 555 then return 0 end
  local c = (x < 485) and topy(LA_top, x) or topy(RA_top, x)
  return clamp((c + 4 - y) / 4, 0, 1)
end) - fallsM:grow(1) - mA:grow(2) - mB:grow(2)
work(strip2, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, length={20,50}, coverage=3, fill=true, load=0.9, clip=strip2:grow(2),
  angle=function(x,y) return 1.5 + 0.15*math.sin(x/50) end,
  piles={{glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/260)^1.2 * 1.2 end},
         {haze, 0.9},
         {amber, function(x,y) local d=dist(x,y); return 0.4 + math.exp(-((d-330)/120)^2) end},
         {deeprust, function(x,y) local d=dist(x,y); return 0.6*math.exp(-((d-470)/130)^2) end},
         {woods, function(x,y) local d=dist(x,y); return 0.3*math.max(0, (d-400)/250) end}}})
blend((strip2:grow(14) * below(function(x) return 520 end) - fallsM:grow(2) - mA:grow(2) - mB:grow(2)):soften(8), {angle=math.pi/2})

--@ chunk 105
print(nearbank, farbank_m, leafgold)

--@ chunk 106
palette{scrape={nearbank, farbank_m, leafgold}}
rockmid = pile{{"lead white",1},{"raw umber",2},{"smalt",0.5},{"yellow ochre",0.5},{"bone black",0.2}, name="rockmid"}
moss = pile{{"green earth",3},{"chrome yellow",1},{"yellow ochre",1.2},{"raw umber",0.4}, name="moss"}
local nt = noise{seed=811, period=40, octaves=3}
local nt2 = noise{seed=812, period=18, octaves=2}
local function df(x) return math.abs(x - 485) end
local banksM = (LA + RA):shrink(2)
local inner = banksM * mask(function(x, y)
  local top = (x < 485) and topy(LA_top, x) or topy(RA_top, x)
  return clamp((y - top - 12) / 10, 0, 1)
end)
work(inner, {hand="body", tool={kind="filbert", width=8, stiffness=0.5}, length={6,15}, coverage=1.4, edge="soft", load=0.8,
  angle=function(x,y) return 1.57 + 0.7*math.sin(x/9 + y/6) end,
  scale_at=function(x,y) return 0.8 + 0.5*clamp((df(x) - 100)/400, 0, 1) end,
  piles={{lent, function(x,y) return clamp(1 - (df(x) - 95)/70, 0, 1) * 1.5 end},
         {rock, function(x,y) return clamp(1 - (df(x) - 100)/160, 0, 1) end},
         {brushdark, function(x,y) return 0.7 + 0.3*nt(x,y) end},
         {woods, function(x,y) return 0.4*nt2:at01(x,y) end},
         {deeprust, function(x,y) return clamp((df(x) - 150)/250, 0, 1) * (0.4 + 0.6*nt:at01(x+40,y)) end},
         {leafrust, function(x,y) return clamp((df(x) - 250)/250, 0, 1) * clamp((nt2:at01(x+90,y) - 0.55)*3, 0, 1) end}}})
print(palette())

--@ chunk 107
local nt = noise{seed=821, period=110, octaves=3, persistence=0.45}
local nt2 = noise{seed=822, period=60, octaves=2}
local function df(x) return math.abs(x - 485) end
local banksM = (LA + RA):shrink(1)
local below_rim = banksM * mask(function(x, y)
  local top = (x < 485) and topy(LA_top, x) or topy(RA_top, x)
  return clamp((y - top - 8) / 8, 0, 1)
end)
work(below_rim, {hand="body", tool={kind="filbert", width=14, stiffness=0.5}, length={25,60}, coverage=2.6, fill=true, edge="soft", load=0.9,
  angle=function(x,y) return (x < 485 and 0.62 or -0.25) + 0.35*nt2(x,y) end,
  piles={{lent, function(x,y) return clamp(1 - (df(x) - 95)/60, 0, 1) * 1.2 end},
         {rock, function(x,y) return clamp(1 - (df(x) - 100)/200, 0, 1) * 1.2 end},
         {brushdark, function(x,y) return 0.8 end},
         {woods, function(x,y) return 0.5 + 0.4*nt(x,y) end},
         {mossdark, function(x,y) return 0.6*clamp((nt2:at01(x+33,y) - 0.55)*3, 0, 1) end},
         {deeprust, function(x,y) return clamp((df(x) - 170)/260, 0, 1) * (0.5 + 0.6*nt:at01(x+40,y)) end}}})

--@ chunk 108
rocks2 = {
  {top={{-10,692},{60,670},{140,664},{200,676},{240,700},{262,730}}, bot=905, seed=901},
  {top={{790,706},{850,688},{930,690},{1010,698}}, bot=905, seed=902},
  {top={{170,748},{240,726},{300,728},{345,746},{372,774}}, bot=905, seed=903},
  {top={{604,748},{680,728},{760,732},{812,752},{830,780}}, bot=905, seed=904},
  {top={{334,684},{364,670},{394,678},{400,700}}, bot=905, seed=905, x1=402},
  {top={{572,690},{594,676},{622,682},{634,700}}, bot=905, seed=906, x0=566},
  {top={{-10,842},{60,824},{150,828},{210,848},{236,880}}, bot=912, seed=907},
  {top={{246,878},{310,862},{370,870},{398,890}}, bot=914, seed=908},
  {top={{596,868},{680,850},{752,856},{790,880}}, bot=912, seed=909},
  {top={{836,850},{920,836},{1010,842}}, bot=916, seed=910},
}
function rock_mask(r)
  local pts = {}
  for _, p in ipairs(r.top) do pts[#pts+1] = {p[1], p[2]} end
  local x1 = r.x1 or r.top[#r.top][1]
  local x0 = r.x0 or r.top[1][1]
  pts[#pts+1] = {x1 + 4, r.bot}
  pts[#pts+1] = {x0 - 4, r.bot}
  return outline{pts=pts, char="broken", seed=r.seed, amount=0.4}:mask()
end
local nr = noise{seed=920, period=40, octaves=3}
local function df(x) return math.abs(x - 485) end
function paint_rock2(r)
  local m = rock_mask(r) - fallsM:grow(1)
  local function dep(x, y) return y - topy(r.top, x) end
  work(m, {hand="body", tool={kind="filbert", width=9, stiffness=0.6}, length={12,30}, coverage=2.6, fill=true, edge={found=0.7, soft=0.3, period=30}, load=0.9,
    angle=function(x,y) return 1.4 + 0.5*nr(x,y) end,
    piles={{lent, function(x,y) return clamp(1 - (df(x) - 100)/90, 0, 1) end},
           {rock, function(x,y) return 0.9 end},
           {woods, function(x,y) return 0.4 + 0.4*nr:at01(x,y) end},
           {mossdark, function(x,y) return clamp(1 - dep(x,y)/40, 0, 1) * 0.9 + 0.3*clamp((nr:at01(x+50,y) - 0.6)*3, 0, 1) end},
           {deeprust, function(x,y) return 0.35*clamp((dep(x,y) - 40)/60, 0, 1) * clamp((df(x) - 150)/200, 0, 1) end}}})
  -- rim light along the top contour
  local rimpts = {}
  for _, p in ipairs(r.top) do rimpts[#rimpts+1] = {p[1], p[2] + 2.5} end
  local rim = ribbon(rimpts, 5):roughen(2, 10, r.seed + 1) * mask(function(x,y) return clamp((nr:at01(x*2, y*2) - 0.3)*3, 0, 1) end)
  rim = rim - fallsM:grow(1)
  work(rim, {hand="detail", tool={kind="round", width=3, stiffness=0.5}, length={6,14}, coverage=2, fill=true, angle=0.0,
    piles={{rim_warm, 1}, {moss_lit, function(x,y) return 0.6*nr:at01(x+77,y) end}, {glow, function(x,y) return clamp(1 - df(x)/260, 0, 1) end}}})
  return m
end
for i = 1, 4 do paint_rock2(rocks2[i]) end

--@ chunk 109
local nr = noise{seed=930, period=40, octaves=3}
local function df(x) return math.abs(x - 485) end
function plane_depths(r, seed)
  local xs, ds = {}, {}
  local x0 = (r.x0 or r.top[1][1])
  local x1 = (r.x1 or r.top[#r.top][1])
  local x = x0
  math.randomseed(seed)
  while x <= x1 + 30 do
    xs[#xs+1] = x
    ds[#ds+1] = rand(7, 24)
    x = x + rand(18, 45)
  end
  return function(xx)
    if xx <= xs[1] then return ds[1] end
    for i = 1, #xs - 1 do
      if xx <= xs[i+1] then return lerp(ds[i], ds[i+1], (xx - xs[i]) / (xs[i+1] - xs[i])) end
    end
    return ds[#ds]
  end
end
function paint_plane(r)
  local dfun = plane_depths(r, r.seed)
  local x0 = (r.x0 or r.top[1][1]) - 2
  local x1 = (r.x1 or r.top[#r.top][1]) + 2
  local m = mask(function(x, y)
    if x < x0 or x > x1 then return 0 end
    local t = topy(r.top, x)
    local d = dfun(x)
    return (y >= t - 1.5 and y <= t + d) and 1 or 0
  end):soften(1.5) - fallsM:grow(1)
  local function f(x, y) return clamp((y - topy(r.top, x)) / dfun(x), 0, 1) end
  local inner = function(x) return clamp(1 - (df(x) - 100)/400, 0.15, 1) end
  work(m, {hand="body", tool={kind="flat", width=6, stiffness=0.6}, length={10,28}, coverage=2.6, fill=true, edge={found=0.75, soft=0.25, period=30}, load=0.9,
    angle=function(x,y) return 0.15*nr(x,y) end,
    piles={{rim_warm, function(x,y) return clamp(1 - f(x,y)*2.5, 0, 1) * inner(x) * 1.3 end},
           {glow, function(x,y) return clamp(1 - f(x,y)*3, 0, 1) * clamp(1 - (df(x) - 90)/200, 0, 1) end},
           {moss_lit, function(x,y) return math.exp(-((f(x,y) - 0.35)/0.25)^2) * (0.4 + 0.6*inner(x)) end},
           {moss, function(x,y) return math.exp(-((f(x,y) - 0.6)/0.25)^2) end},
           {mossdark, function(x,y) return clamp((f(x,y) - 0.55)*2.5, 0, 1) * 1.2 end},
           {rockmid, function(x,y) return 0.5*clamp((nr:at01(x*1.5, y*1.5) - 0.6)*3, 0, 1) end}}})
  return m
end
for i = 1, 4 do paint_plane(rocks2[i]) end

--@ chunk 110
local nt = noise{seed=941, period=60, octaves=2}
local function df(x) return math.abs(x - 485) end
-- cover the old caps with bank tone
local oldcaps = nil
for i = 1, 4 do
  local r = rocks2[i]
  local m = mask(function(x, y)
    local x0 = (r.x0 or r.top[1][1]) - 6
    local x1 = (r.x1 or r.top[#r.top][1]) + 6
    if x < x0 or x > x1 then return 0 end
    local t = topy(r.top, x)
    return (y >= t - 8 and y <= t + 40) and 1 or 0
  end)
  oldcaps = oldcaps and (oldcaps + m) or m
end
oldcaps = oldcaps - fallsM:grow(1)
work(oldcaps, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, length={14,34}, coverage=3, fill=true, edge="soft", load=1.0,
  angle=function(x,y) return (x < 485 and 0.6 or -0.3) + 0.3*nt(x,y) end,
  piles={{rock, function(x,y) return clamp(1 - (df(x) - 100)/200, 0, 1) * 1.2 end},
         {brushdark, 0.9}, {woods, function(x,y) return 0.5 + 0.4*nt(x,y) end},
         {deeprust, function(x,y) return clamp((df(x) - 170)/260, 0, 1) * 0.8 end}}})

--@ chunk 111
rocks3 = {
  {top={{-10,684},{60,676},{120,672},{176,676},{200,688},{222,710}}, bot=905, seed=951, x1=226},
  {top={{786,700},{812,690},{900,686},{1010,682}}, bot=905, seed=952, x0=782},
  {top={{186,740},{210,728},{280,728},{330,732},{352,746},{366,770}}, bot=905, seed=953, x0=182, x1=370},
  {top={{612,756},{632,740},{700,736},{770,734},{796,748},{806,776}}, bot=905, seed=954, x0=608, x1=808},
}
function rock_mask3(r)
  local pts = {}
  local x0 = r.x0 or r.top[1][1]
  local x1 = r.x1 or r.top[#r.top][1]
  pts[#pts+1] = {x0, r.bot}
  for i, p in ipairs(r.top) do pts[#pts+1] = {p[1], p[2], (i == 1 or i == #r.top) and "c" or nil} end
  pts[#pts+1] = {x1 + 3, r.bot}
  return outline{pts=pts, char="broken", seed=r.seed, amount=0.35}:mask()
end
local nr = noise{seed=960, period=35, octaves=3}
local function df(x) return math.abs(x - 485) end
function paint_face3(r)
  local m = rock_mask3(r) - fallsM:grow(1)
  local function dep(x, y) return y - topy(r.top, x) end
  work(m, {hand="body", tool={kind="flat", width=8, stiffness=0.6}, length={14,34}, coverage=2.8, fill=true, edge={found=0.75, soft=0.25, period=30}, load=1.0,
    angle=function(x,y) return 1.5 + 0.25*nr(x,y) end,
    piles={{lent, function(x,y) return clamp(1 - (df(x) - 100)/100, 0, 1) end},
           {rock, function(x,y) return 0.9 end},
           {rockmid, function(x,y) return 0.45*clamp((nr:at01(x, y*0.5) - 0.5)*3, 0, 1) * clamp((df(x)-120)/200, 0, 1) end},
           {woods, function(x,y) return 0.4 + 0.4*nr:at01(x+20,y) end},
           {mossdark, function(x,y) return 0.5*clamp((nr:at01(x+50,y) - 0.6)*3, 0, 1) end},
           {deeprust, function(x,y) return 0.3*clamp((dep(x,y) - 40)/80, 0, 1) * clamp((df(x) - 150)/200, 0, 1) end}}})
  return m
end
rockmasks3 = {}
for i = 1, 4 do rockmasks3[i] = paint_face3(rocks3[i]) end

--@ chunk 112
for i = 1, 4 do paint_plane(rocks3[i]) end

--@ chunk 113
for _, p in ipairs({{100,100},{300,60},{700,150},{900,350},{60,250},{750,300},{400,300},{300,450},{700,470},{500,800},{200,1000},{600,1100},{800,1200},{470,700}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 114
palette{scrape={moss}}
backlit = mix{{leafrust, 0.4}, {glow, 0.35}, {amber, 0.25}, name="backlit"}
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local cin = canopy:shrink(5)
edgeband = (cin:grow(22) - cin:shrink(28)):soften(6) - mA:grow(3) - mB:grow(3)
local nh = noise{seed=1001, period=24, octaves=3}
-- 1. backlit leaf clusters breaking the edge, both sides of it
local clumps = edgeband * mask(function(x,y) return clamp((nh:at01(x,y) - 0.42) * 4, 0, 1) end)
work(clumps, {hand="body", tool={kind="filbert", width=8, stiffness=0.5}, length={6,14}, coverage=1.6, edge="loose", load=0.8,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/9 + y/7) end,
  piles={{backlit, 1}, {leafrust, function(x,y) return 0.6*nh:at01(x+40,y) end},
         {glow, function(x,y) return clamp(1 - (dist(x,y) - 150)/150, 0, 1) end},
         {deeprust, function(x,y) return clamp((dist(x,y) - 300)/200, 0, 1) * 0.6 end}}})
-- 2. sky holes inside the canopy near the edge
local nh2 = noise{seed=1002, period=16, octaves=2}
holes = cin * mask(function(x, y)
  return clamp((nh2:at01(x, y) - 0.66) * 6, 0, 1)
end) * (cin - cin:shrink(90)):blur(20) - mA:grow(3) - mB:grow(3)
work(holes, {hand="body", tool={kind="round", width=6, stiffness=0.5}, length={4,9}, coverage=2.2, fill=true, edge="soft", load=0.8,
  angle=function(x,y) return rand(0, 3.14) end,
  piles={{glow, function(x,y) return clamp(1 - (dist(x,y) - 180)/220, 0, 1) * 1.3 end},
         {haze, 0.6}, {amber, function(x,y) return clamp((dist(x,y) - 250)/200, 0, 1) end}}})

--@ chunk 115
local eb = (canopy:shrink(5):grow(30) - canopy:shrink(70)):soften(15) - mA:grow(3) - mB:grow(3)
blend(eb, {angle=0.8})
blend(eb, {angle=2.3})

--@ chunk 116
palette{scrape={backlit, rockmid}}
goldleaf = pile{{"chrome yellow",2},{"yellow ochre",1.5},{"red earth",0.3}, name="goldleaf"}
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local cin = canopy:shrink(5)
local zone = (cin:grow(26) - cin:shrink(80)) - mA:grow(3) - mB:grow(3)
local n1 = noise{seed=1011, period=34, octaves=3}
local n2 = noise{seed=1012, period=20, octaves=2}
-- leaf clusters: denser away from the edge, sparse at it
local depth = (cin:grow(26)):blur(25)
local cl = zone * mask(function(x,y) return clamp((n1:at01(x,y) - 0.45 + 0.4*(depth:at(x,y) - 0.5)) * 4, 0, 1) end)
work(cl, {hand="body", tool={kind="filbert", width=7, stiffness=0.5}, length={5,12}, coverage=1.5, edge="loose", load=0.85,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/9 + y/7) end,
  piles={{orangeleaf, function(x,y) return 0.6 + 0.4*n2(x,y) end},
         {goldleaf, function(x,y) return clamp(1 - (dist(x,y) - 180)/250, 0, 1) * (0.5 + 0.5*n2:at01(x+30,y)) end},
         {leafrust, 0.4},
         {deeprust, function(x,y) return clamp((n1:at01(x, y - 12) - 0.55)*3, 0, 1) end}}})
print(palette())

--@ chunk 117
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local cz = canopy:grow(24) - mA:grow(3) - mB:grow(3)
local n1 = noise{seed=1021, period=55, octaves=3}
local n2 = noise{seed=1022, period=28, octaves=2}
-- shadowed undersides of clumps: noise lower slopes; plus general darkening away from glow
local sh = cz * mask(function(x,y)
  local under = clamp((n1:at01(x, y - 16) - n1:at01(x, y) + 0.08) * 8, 0, 1)
  local farw = clamp((dist(x,y) - 280)/250, 0, 1)
  return clamp(under * 0.8 + farw * 0.6 * clamp((n2:at01(x,y) - 0.35)*3, 0, 1), 0, 1)
end)
work(sh, {hand="body", tool={kind="filbert", width=8, stiffness=0.5}, length={6,14}, coverage=1.6, edge="loose", load=0.85,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/9 + y/7) end,
  piles={{deeprust, 1}, {brushdark, function(x,y) return clamp((dist(x,y) - 300)/250, 0, 1) end},
         {leafrust, function(x,y) return 0.5*clamp(1 - (dist(x,y) - 200)/200, 0, 1) end}}})
-- sparse sky holes, crisp, near (but not at) the inner edge
local cin = canopy:shrink(5)
local nh = noise{seed=1023, period=14, octaves=2}
local sky = (cin:shrink(8) - cin:shrink(100)) * mask(function(x,y) return clamp((nh:at01(x,y) - 0.74) * 8, 0, 1) end) - mA:grow(4) - mB:grow(4)
work(sky, {hand="detail", tool={kind="round", width=4, stiffness=0.5}, length={3,7}, coverage=2.5, fill=true, load=0.8,
  angle=function(x,y) return rand(0, 3.14) end,
  piles={{glow, function(x,y) return clamp(1 - (dist(x,y) - 150)/250, 0.2, 1) end}, {haze, 0.5}, {amber, function(x,y) return clamp((dist(x,y) - 300)/200, 0, 1) end}}})

--@ chunk 118
for _, p in ipairs({{150,300},{300,350},{450,300},{600,350},{700,420},{250,420},{450,470},{850,420},{100,400}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 119
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local nf = noise{seed=1031, period=60, octaves=3}
local function crestY(x) return (x < 485) and topy(LA_top, x) or topy(RA_top, x) end
fartrees = mask(function(x, y)
  local c = crestY(x)
  if y > c + 5 then return 0 end
  local d = dist(x, y)
  local side = clamp((d - 170)/200, 0, 1)
  local v = nf:at01(x, y * 1.3) + 0.35*side - 0.75 + 0.25*clamp((y - 330)/150, 0, 1)
  return clamp(v * 4, 0, 1)
end) - canopy:shrink(4) - mA:grow(3) - mB:grow(3)
print(fartrees:area())
work(fartrees, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, length={8,18}, coverage=2, edge="lost", load=0.8,
  angle=function(x,y) return 1.57 + 0.8*math.sin(x/11 + y/8) end,
  piles={{haze, function(x,y) return 0.6 + clamp(1 - (dist(x,y) - 150)/250, 0, 1) end}, {amber, function(x,y) return 0.25 + 0.3*nf:at01(x+40, y) end}, {deeprust, 0.18}}})
local ftr = {{175, 230, 7}, {262, 300, 5}, {610, 260, 6}, {690, 240, 8}, {860, 300, 7}, {55, 260, 9}, {535, 330, 4}}
for _, t in ipairs(ftr) do
  local x, ytop, w = t[1], t[2], t[3]
  local yb = crestY(x) + 4
  local fb = brush{kind="flat", width=w, stiffness=0.5}
  fb:reload(haze, 0.4)
  fb:load(deeprust, 0.25)
  fb:stroke({{x, yb}, {x + rand(-2,2), (yb + ytop)/2}, {x + rand(-4,4), ytop}}, {pressure={0.55, 0.35}, orient="across"})
end
local m = (below(function(x) return 230 end) * above(function(x) return crestY(x) - 2 end)) - canopy:shrink(10) - mA:grow(3) - mB:grow(3)
blend(m:soften(15), {angle=math.pi/2})

--@ chunk 120
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local function crestY(x) return (x < 485) and topy(LA_top, x) or topy(RA_top, x) end
gz2 = mask(function(x, y) return clamp((crestY(x) - y) / 4, 0, 1) end) - canopy:shrink(14) - mA:grow(2) - mB:grow(2) - fallsM:grow(1)
gz2 = gz2 * below(function(x) return 60 end)
local nz = noise{seed=1041, period=70, octaves=2}
work(gz2, {hand="body", tool={kind="filbert", width=14, stiffness=0.5}, length={30,80}, coverage=3, fill=true, load=1.0, clip=gz2:grow(1),
  angle=function(x,y) return 1.5 + 0.15*math.sin(x/90) + 0.12*math.sin(y/60) end,
  piles={{glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/220)^1.3 * 1.8 end},
         {haze, function(x,y) local d=dist(x,y); return math.exp(-((d-190)/120)^2) * 1.1 end},
         {amber, function(x,y) local d=dist(x,y); return math.exp(-((d-330)/120)^2) end},
         {deeprust, function(x,y) local d=dist(x,y); return math.exp(-((d-470)/130)^2) * (0.7 + 0.5*nz:at01(x,y)) end},
         {woods, function(x,y) local d=dist(x,y); return math.max(0, (d-460)/260) + 0.5*clamp((y - crestY(x) + 60)/60, 0, 1) * clamp((math.abs(x-485) - 120)/150, 0, 1) end}}})
blend(gz2:soften(10), {angle=math.pi/2})
blend(gz2:soften(10), {angle=math.pi/2 + 0.2})

--@ chunk 121
palette{scrape={woods}}
leafshade = pile{{"red earth",2},{"raw umber",2.5},{"vermilion",0.2}, name="leafshade"}
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
canopy_base = canopy:grow(10) - mA:grow(2) - mB:grow(2)
local nb = noise{seed=1101, period=70, octaves=3}
work(canopy_base, {hand="body", tool={kind="filbert", width=12, stiffness=0.5}, length={12,30}, coverage=2.5, fill=true, edge="soft", load=0.9,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/13 + y/9) end,
  piles={{leafshade, function(x,y) return 0.5 + clamp((dist(x,y) - 300)/250, 0, 1) end},
         {leafrust, function(x,y) return 0.6 * clamp(1 - (dist(x,y) - 200)/250, 0, 1) + 0.3*nb:at01(x,y) end},
         {orangeleaf, function(x,y) return 0.5 * clamp(1 - (dist(x,y) - 170)/150, 0, 1) end}}})
print(palette())

--@ chunk 122
function clump4(c, seed, gxx, gyy, o)
  o = o or {}
  local cx, cy, rx, ry = c[1], c[2], c[3], c[4]
  local pts = {}
  math.randomseed(seed)
  for i = 0, 10 do
    local a = i / 11 * 2 * math.pi + rand(-0.15, 0.15)
    local k = rand(0.8, 1.15)
    pts[#pts+1] = {cx + rx * k * math.cos(a), cy + ry * k * math.sin(a)}
  end
  local m = outline{pts=pts, char="soft", seed=seed, amount=0.9, lobe=math.min(rx, ry) * 0.35}:mask()
  if o.minus then m = m - o.minus end
  local dx, dy = gxx - cx, gyy - cy
  local dl = math.sqrt(dx*dx + dy*dy) + 1e-6
  dx, dy = dx/dl, dy/dl
  local litk = o.lit or clamp(1 - (dl - 150) / 500, 0.1, 1)
  local function P(x, y) local px, py = (x - cx)/rx, (y - cy)/ry; return px*dx + py*dy, py, math.sqrt(px*px + py*py) end
  work(m, {hand="body", tool={kind="filbert", width=9, stiffness=0.5}, length={7,16}, coverage=2.2, fill=true, edge="loose", load=0.9,
    angle=function(x,y) return 1.57 + 0.9*math.sin(x/9 + y/7) end,
    scale_at=function(x,y) return 0.8 + 0.6*(1 - litk) end,
    piles={{orangeleaf, function(x,y) local u,v,r = P(x,y); return clamp((u + 0.1)*2, 0, 1) * (0.3 + 0.7*litk) end},
           {leafrust, function(x,y) local u,v,r = P(x,y); return math.exp(-((u + 0.2)/0.45)^2) end},
           {leafshade, function(x,y) local u,v,r = P(x,y); return clamp(-u*2, 0, 1.5) + clamp((v - 0.3)*2, 0, 1) + (1 - litk)*0.8 end}}})
  local nh = noise{seed=seed + 5, period=16, octaves=2}
  local lit = m:shrink(3) * mask(function(x,y) local u,v,r = P(x,y); return clamp((u - 0.25)*4, 0, 1) * clamp((r - 0.35)*4, 0, 1) * clamp((nh:at01(x,y) - 0.3)*3, 0, 1) end)
  work(lit, {hand="body", tool={kind="filbert", width=6, stiffness=0.5, lay=2}, length={4,9}, coverage=0.9, load=0.9,
    angle=function(x,y) return 1.57 + rand(-1, 1) end,
    piles={{goldleaf, litk}, {orangeleaf, 1 - litk*0.5}, {glow, litk*litk*0.4}}})
  local rim = (m:grow(8) - m:shrink(6))
  local sm = rim * mask(function(x,y) return clamp((nh:at01(x+40,y) - 0.62)*4, 0, 1) end)
  if o.minus then sm = sm - o.minus end
  work(sm, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={4,8}, coverage=0.6, load=0.8,
    angle=function(x,y) return 1.57 + rand(-1, 1) end,
    piles={{orangeleaf, function(x,y) local u = P(x,y); return clamp(u + 0.3, 0, 1) * litk end},
           {leafshade, function(x,y) local u = P(x,y); return clamp(-u, 0, 1) + (1-litk)*0.4 end}}})
  return m
end
local protect = mA:grow(3) + mB:grow(3)
clumpsL = {{60,60,110,70},{200,40,120,60},{90,170,120,75},{230,150,90,60},{150,250,110,55},{40,300,70,50},{340,30,100,45}}
for i, c in ipairs(clumpsL) do clump4(c, 1200 + i, gx, gy - 60, {minus=protect}) end

--@ chunk 123
local protect = mA:grow(3) + mB:grow(3)
clumpsR = {{470,40,110,50},{620,30,100,50},{760,70,120,70},{910,80,110,80},{650,140,90,65},{560,200,60,50},{690,250,95,75},{880,230,110,85},{620,300,70,55},{760,360,95,60},{900,380,100,60},{975,300,50,70}}
for i, c in ipairs(clumpsR) do clump4(c, 1300 + i, gx, gy - 60, {minus=protect}) end

--@ chunk 124
palette{scrape={orangeleaf, leafshade}}
fallgray = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.4},{"yellow ochre",0.15}, name="fallgray"}
local fan = brush{kind="fan", width=14, stiffness=0.5}
for i = 1, 14 do
  if i % 3 == 1 then fan:reload(i % 2 == 0 and glow or fallwhite, 0.32) end
  local t = clamp(math.abs(randn(0.35, 0.3)), 0.02, 0.98)
  local F = (i % 7 == 0) and FR or FL
  local y0 = 680
  local yend = y0 + rand(35, 110)
  local pts = {}
  for k = 0, 4 do local y = lerp(y0, yend, k/4); pts[#pts+1] = {fx(F, t, y) + rand(-1, 1), y} end
  fan:stroke(pts, {pressure={0.45, 0.05}, orient="across", ramps={0.02, 0.7}})
end
local fb = brush{kind="filbert", width=8, stiffness=0.5}
for i = 1, 12 do
  local left = (i % 2 == 0)
  fb:reload(i % 3 == 0 and fallwhite or fallgray, 0.4)
  local x0 = left and rand(380, 396) or rand(566, 582)
  local y0 = rand(760, 830)
  local dir = left and -1 or 1
  local spread = rand(10, 26)
  fb:gesture({{x0, y0, 0.3}, {x0 + dir*spread*0.25, y0 + (905 - y0)*0.4, 0.55}, {x0 + dir*spread*0.7, y0 + (905 - y0)*0.8, 0.4}, {x0 + dir*spread, 906, 0.1}}, {wobble=1.5})
end
local rd = brush{kind="round", width=3, point=0.6}
for i = 1, 16 do
  rd:reload(fallwhite, 0.5)
  local left = (i % 2 == 0)
  local x0 = left and rand(372, 400) or rand(560, 592)
  local y0 = rand(800, 860)
  local dir = left and -1 or 1
  local s = rand(8, 26)
  rd:gesture({{x0, y0, 0.2}, {x0 + dir*s*0.4, y0 + 20, 0.5}, {x0 + dir*s, y0 + rand(35, 55), 0.0}}, {wobble=1})
end

--@ chunk 125
for _, p in ipairs({{420,760},{470,850},{500,720},{560,800},{385,860},{575,870},{470,690},{440,900}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 126
local k = knife{width=16}
for _, x in ipairs({352, 362, 372, 382, 392}) do
  k:scrape({{x + 6, 770}, {x, 840}, {x - 4, 910}}, {pressure=1}); k:wipe()
end
for _, x in ipairs({566, 576, 586, 596, 606}) do
  k:scrape({{x - 6, 770}, {x, 840}, {x + 4, 910}}, {pressure=1}); k:wipe()
end
-- the yellow streaks near the lip
for _, x in ipairs({404, 412, 438, 446}) do
  k:scrape({{x, 678}, {x, 720}, {x, 780}}, {pressure=0.7}); k:wipe()
end

--@ chunk 127
local r = rag{width=16}
local paths = {
  {{392, 775}, {384, 830}, {372, 905}}, {{382, 790}, {374, 850}, {362, 905}},
  {{574, 785}, {582, 840}, {596, 905}}, {{584, 790}, {592, 850}, {604, 905}},
  {{404, 682}, {404, 740}, {405, 790}}, {{450, 682}, {450, 730}, {450, 770}},
}
for i, p in ipairs(paths) do
  r:dip(0.9)
  r:wipe(p, {pressure=0.9})
  r:refold()
  r:dip(0.9)
  r:wipe(p, {pressure=0.9})
  r:refold()
end
print(r.load, r.soaked)

--@ chunk 128
palette{scrape={fallgray, fallwhite, moss_lit}}
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
leafshade = pile{{"red earth",2},{"raw umber",2.5},{"vermilion",0.2}, name="leafshade"}
trunkdark = pile{{"raw umber",2},{"bone black",0.4},{"red earth",0.8},{"Prussian blue",0.2}, name="trunkdark"}
print(palette())

--@ chunk 129
function paint_dark_trunk(pts, seed, o)
  o = o or {}
  local ax = axis_fn(pts)
  local m = trunk_mask(pts, seed)
  if o.minus then m = m - o.minus end
  local function u(x, y) local cx, w = ax(y); return (x - cx) / (w/2) end
  local side = o.side or 1
  local hz = o.haze or 0
  work(m, {hand="body", tool={kind="flat", width=o.bw or 7, stiffness=0.6}, length={20,50}, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=30}, load=0.95,
    angle=-math.pi/2,
    piles={{trunkdark, function(x,y) return 1 - hz end},
           {leafshade, function(x,y) return 0.4 + 0.3*clamp(-u(x,y)*side, 0, 1) end},
           {haze, function(x,y) return hz * 1.2 end},
           {rim_warm, function(x,y) return clamp((u(x,y)*side - 0.62)*5, 0, 1) * (o.rim or 1.2) end}}})
  return m
end
trunkL = {{118,520},{116,440},{112,360},{118,280},{126,200},{122,120},{116,40},{112,-10}}
for i, p in ipairs(trunkL) do p[3] = lerp(36, 22, (i-1)/(#trunkL-1)) end
limb1 = {{124,268,16},{150,236,13},{186,206,10},{226,178,8},{262,158,6}}
limb2 = {{120,200,14},{98,170,11},{72,140,9},{40,118,7}}
local protect = mA:grow(3) + mB:grow(3)
mTL = paint_dark_trunk(trunkL, 1401, {rim=1.3})
-- limbs: axis runs bottom->top in y; limb pts are ordered by decreasing y already
mL1 = paint_dark_trunk(limb1, 1402, {rim=1.0, bw=5})
mL2 = paint_dark_trunk(limb2, 1403, {rim=0.0, bw=5})
trunkL2 = {{268,575},{266,500},{262,420},{258,340},{262,270}}
for i, p in ipairs(trunkL2) do p[3] = lerp(13, 8, (i-1)/(#trunkL2-1)) end
mTL2 = paint_dark_trunk(trunkL2, 1404, {rim=0.8, haze=0.45, bw=5})

--@ chunk 130
local ne = noise{seed=1501, period=30, octaves=2}
jambs = mask(function(x, y)
  if y < 664 or y > 908 then return 0 end
  local xl = fx(FL, 0, y) + 3 + 6 * ne(0, y)
  local xr = fx(FR, 1, y) - 3 + 6 * ne(100, y)
  local inL = (x > xl - 60 and x < xl) and 1 or 0
  local inR = (x > xr and x < xr + 60) and 1 or 0
  return math.max(inL, inR)
end):soften(2)
work(jambs, {hand="body", tool={kind="filbert", width=8, stiffness=0.6}, length={14,34}, coverage=3.5, fill=true, load=1.0, clip=jambs:grow(1),
  angle=function(x,y) return 1.5 + 0.25*ne(x, y) end,
  piles={{lent, 1}, {rock, 0.8}, {brushdark, 0.3}}})
print(drying(380, 840), drying(590, 840))

--@ chunk 131
local ne = noise{seed=1511, period=20, octaves=2}
shoulders = mask(function(x, y)
  local xl = fx(FL, 0, math.max(y, FL.y0))
  local xr = fx(FR, 1, math.max(y, FR.y0))
  if x < 485 then
    if x < 300 or x > xl + 2 then return 0 end
    local top = topy(LA_top, x) + 4 * ne(x, 0)
    return (y >= top and y <= 700) and 1 or 0
  else
    if x > 690 or x < xr - 2 then return 0 end
    local top = topy(RA_top, x) + 4 * ne(x, 50)
    return (y >= top and y <= 700) and 1 or 0
  end
end):soften(2)
work(shoulders, {hand="body", tool={kind="filbert", width=8, stiffness=0.6}, length={10,26}, coverage=3.5, fill=true, load=1.0, clip=shoulders:grow(1),
  angle=function(x,y) return (x < 485 and 0.7 or -0.5) + 0.3*ne(x, y) end,
  piles={{lent, function(x,y) return clamp(1 - (math.abs(x - 485) - 90)/80, 0, 1) end}, {rock, 0.9}, {brushdark, 0.5}}})
-- rims on the shoulder tops
local rimpts = {}
for x = 300, 398, 6 do rimpts[#rimpts+1] = {x, topy(LA_top, x) + 2.5} end
local rimL = ribbon(rimpts, 4):roughen(1.5, 8, 1512)
rimpts = {}
for x = 580, 690, 6 do rimpts[#rimpts+1] = {x, topy(RA_top, x) + 2.5} end
local rimR = ribbon(rimpts, 4):roughen(1.5, 8, 1513)
local nr = noise{seed=1514, period=14, octaves=2}
local rims = (rimL + rimR) * mask(function(x,y) return clamp((nr:at01(x,y) - 0.3)*3, 0, 1) end)
work(rims, {hand="detail", tool={kind="round", width=3, stiffness=0.5}, length={5,12}, coverage=2, fill=true, angle=0.0,
  piles={{rim_warm, 1}, {glow, function(x,y) return clamp(1 - (math.abs(x - 485) - 80)/150, 0, 1) end}}})

--@ chunk 132
local nr = noise{seed=1521, period=30, octaves=3}
local function df(x) return math.abs(x - 485) end
for i = 1, 4 do
  local r = rocks3[i]
  local dfun = plane_depths(r, r.seed)
  local x0 = (r.x0 or r.top[1][1]) - 2
  local x1 = (r.x1 or r.top[#r.top][1]) + 2
  local m = mask(function(x, y)
    if x < x0 or x > x1 then return 0 end
    local t = topy(r.top, x)
    return (y >= t + 3 and y <= t + dfun(x) + 2) and 1 or 0
  end):soften(1.5) - fallsM:grow(1) - shoulders - jambs
  work(m, {hand="body", tool={kind="flat", width=6, stiffness=0.6}, length={10,26}, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=25}, load=1.0,
    angle=function(x,y) return 0.15*nr(x,y) end,
    piles={{mossdark, 1}, {brushdark, function(x,y) return 0.5 + 0.5*nr:at01(x,y) end},
           {rock, function(x,y) return 0.4*clamp((nr:at01(x+70,y) - 0.5)*3, 0, 1) end},
           {deeprust, function(x,y) return 0.35*clamp((nr:at01(x+150,y) - 0.55)*3, 0, 1) end}}})
end

--@ chunk 133
local seamL = mask(function(x, y)
  local xl = fx(FL, 0, math.max(y, FL.y0))
  if x > xl - 6 then return 0 end
  -- band around x 300-340 vertical seam and the y~700 seam
  local a = clamp(1 - math.abs(x - (xl - 62)) / 18, 0, 1) * ((y > 640 and y < 905) and 1 or 0)
  local b = clamp(1 - math.abs(y - 700) / 14, 0, 1) * ((x > 280 and x < xl - 6) and 1 or 0)
  return math.max(a, b)
end)
local seamR = mask(function(x, y)
  local xr = fx(FR, 1, math.max(y, FR.y0))
  if x < xr + 6 then return 0 end
  local a = clamp(1 - math.abs(x - (xr + 62)) / 18, 0, 1) * ((y > 640 and y < 905) and 1 or 0)
  local b = clamp(1 - math.abs(y - 700) / 14, 0, 1) * ((x > xr + 6 and x < 700) and 1 or 0)
  return math.max(a, b)
end)
blend(seamL + seamR, {angle=1.0})
blend(seamL + seamR, {angle=2.2})

--@ chunk 134
local nb = noise{seed=1531, period=40, octaves=3}
local function df(x) return math.abs(x - 485) end
local function crestY(x) return (x < 485) and topy(LA_top, x) or topy(RA_top, x) end
local function regtop(x)
  local c = crestY(x) + 3
  local flat = 694 + 10*nb(x, 0)
  local t = clamp((df(x) - 150) / 60, 0, 1)
  return lerp(c, math.max(c, flat), t)
end
rockband = mask(function(x, y)
  return (y >= regtop(x) and y <= 908) and 1 or 0
end):soften(3) - fallsM:grow(1)
rockband = rockband - mA - mB
work(rockband, {hand="body", tool={kind="filbert", width=10, stiffness=0.6}, length={14,36}, coverage=3, fill=true, load=1.0, edge="soft",
  angle=function(x,y) return 1.45 + 0.35*nb(x*2, y*2) + (x < 485 and 0.2 or -0.2) * clamp(1 - (y - 680)/120, 0, 1) end,
  piles={{lent, function(x,y) return clamp(1 - (df(x) - 95)/90, 0, 1) * 1.3 end},
         {rock, function(x,y) return 0.8 end},
         {brushdark, function(x,y) return 0.3 + 0.3*clamp((df(x) - 150)/300, 0, 1) end},
         {mossdark, function(x,y) return 0.5*clamp((nb:at01(x+30, y) - 0.55)*3, 0, 1) * clamp((df(x) - 120)/200, 0, 1) end},
         {haze, function(x,y) return 0.12*clamp((df(x) - 250)/250, 0, 1) end},
         {deeprust, function(x,y) return 0.25*clamp((df(x) - 200)/250, 0, 1) * nb:at01(x+90, y) end}}})

--@ chunk 135
rocks4 = {
  {top={{-10,700},{40,690},{110,688},{170,696},{205,712},{222,736}}, bot=915, seed=1601, x1=226},
  {top={{150,770},{200,752},{270,748},{330,756},{362,776},{372,800}}, bot=915, seed=1602, x0=146, x1=374},
  {top={{-10,812},{60,800},{120,804},{150,822}}, bot=918, seed=1603, x1=154},
  {top={{790,712},{840,700},{920,698},{1010,704}}, bot=915, seed=1604, x0=786},
  {top={{596,782},{640,764},{720,758},{790,766},{822,788},{832,812}}, bot=915, seed=1605, x0=592, x1=834},
  {top={{830,820},{900,806},{1010,810}}, bot=918, seed=1606, x0=826},
}
palette{scrape={trunkdark, goldleaf}}
mossdull = pile{{"green earth",3},{"yellow ochre",1.5},{"raw umber",0.6},{"chrome yellow",0.3}, name="mossdull"}
mosslite = pile{{"yellow ochre",2},{"green earth",1.5},{"lead white",1},{"chrome yellow",0.4},{"red earth",0.2}, name="mosslite"}
function paint_plane2(r)
  local dfun = plane_depths(r, r.seed)
  local x0 = (r.x0 or r.top[1][1]) - 2
  local x1 = (r.x1 or r.top[#r.top][1]) + 2
  local m = mask(function(x, y)
    if x < x0 or x > x1 then return 0 end
    local t = topy(r.top, x)
    local d = dfun(x)
    return (y >= t - 1.5 and y <= t + d) and 1 or 0
  end):soften(1.5) - fallsM:grow(1)
  local nr = noise{seed=r.seed + 3, period=30, octaves=3}
  local function df(x) return math.abs(x - 485) end
  local function f(x, y) return clamp((y - topy(r.top, x)) / dfun(x), 0, 1) end
  local inner = function(x) return clamp(1 - (df(x) - 100)/450, 0.15, 1) end
  work(m, {hand="body", tool={kind="flat", width=6, stiffness=0.6}, length={10,28}, coverage=2.8, fill=true, edge={found=0.7, soft=0.3, period=30}, load=1.0,
    angle=function(x,y) return 0.15*nr(x,y) end,
    piles={{rim_warm, function(x,y) return clamp(1 - f(x,y)*4, 0, 1) * inner(x) * 1.2 end},
           {mosslite, function(x,y) return math.exp(-((f(x,y) - 0.25)/0.2)^2) * inner(x) * 0.8 end},
           {mossdull, function(x,y) return math.exp(-((f(x,y) - 0.5)/0.25)^2) end},
           {mossdark, function(x,y) return clamp((f(x,y) - 0.45)*2.5, 0, 1) * 1.3 end},
           {brushdark, function(x,y) return 0.4*clamp((nr:at01(x, y) - 0.55)*3, 0, 1) end}}})
  return m
end
local nr = noise{seed=1610, period=30, octaves=3}
local function df(x) return math.abs(x - 485) end
for i, r in ipairs(rocks4) do
  local m = rock_mask3(r) - fallsM:grow(1)
  local function dep(x, y) return y - topy(r.top, x) end
  work(m, {hand="body", tool={kind="flat", width=8, stiffness=0.6}, length={14,34}, coverage=3, fill=true, edge={found=0.7, soft=0.3, period=30}, load=1.0,
    angle=function(x,y) return 1.5 + 0.3*nr(x,y) end,
    piles={{lent, function(x,y) return 0.5 + clamp(1 - (df(x) - 100)/100, 0, 1) end},
           {rock, 0.9},
           {brushdark, function(x,y) return 0.3 + 0.4*nr:at01(x+20,y) end},
           {mossdark, function(x,y) return 0.5*clamp((nr:at01(x+50,y) - 0.55)*3, 0, 1) * clamp(1 - dep(x,y)/80, 0, 1) end},
           {haze, function(x,y) return 0.12 * clamp((dep(x,y) - 10)/60, 0, 1) * clamp((df(x) - 200)/200, 0, 1) end}}})
end
for i, r in ipairs(rocks4) do paint_plane2(r) end

--@ chunk 136
for _, p in ipairs({{100,950},{480,930},{850,960},{300,1050},{700,1100},{100,1200},{500,1230},{900,1200}}) do print(p[1], p[2], drying(p[1], p[2])) end
print(palette())

--@ chunk 137
palette{scrape={mosslite, mossdull}}
waterdark = pile{{"raw umber",2},{"Prussian blue",0.5},{"red earth",0.7},{"green earth",0.4}, name="waterdark"}
fallrefl = pile{{"lead white",3},{"raw umber",0.6},{"cobalt blue",0.25},{"yellow ochre",0.35}, name="fallrefl"}
fallsReflM = poly({{368,912},{604,912},{596,980},{580,1060},{566,1150},{404,1150},{390,1060},{378,980}}, true)
glowReflM = poly({{404,1150},{566,1150},{610,1172},{700,1200},{820,1222},{1010,1244},{1010,1252},{240,1252},{300,1228},{350,1196},{380,1168}}, true)
poolM = below({{-10,906},{1010,906}})
local nz = noise{seed=1701, period=80, octaves=2}
local function inF(x, y) return fallsReflM:at(x, y) end
local function inG(x, y) return glowReflM:at(x, y) end
work(poolM, {hand="body", tool={kind="flat", width=14, stiffness=0.5}, length={40,110}, coverage=3, fill=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.04*nz(x,y) end,
  piles={{waterdark, function(x,y) return (1 - inF(x,y)) * (1 - inG(x,y)) * (0.8 + 0.4*clamp(1 - (y-912)/150, 0, 1)) end},
         {brushdark, function(x,y) return (1 - inF(x,y)) * (1 - inG(x,y)) * (0.4 + 0.5*clamp((y - 1000)/200, 0, 1)) end},
         {deeprust, function(x,y) return (1 - inF(x,y)) * (1 - inG(x,y)) * 0.5*clamp((y - 1080)/150, 0, 1) * (0.5 + nz:at01(x,y)) end},
         {fallrefl, function(x,y) return inF(x,y) * (1 - clamp((y - 1060)/90, 0, 1)) end},
         {rim_warm, function(x,y) return inF(x,y) * clamp((y - 1060)/90, 0, 1) end},
         {glow, function(x,y) return inG(x,y) * 0.6 end},
         {amber, function(x,y) return inG(x,y) * (0.5 + 0.3*clamp((math.abs(x - 485) - 100)/300, 0, 1)) end},
         {haze, function(x,y) return inG(x,y) * 0.3 end}}})

--@ chunk 138
local k = knife{width=44}
for y = 790, 1250, 18 do
  if y < 870 then
    k:scrape({{-10, y}, {170, y}, {362, y}}, {pressure=1}); k:wipe()
    k:scrape({{612, y}, {800, y}, {1010, y}}, {pressure=1}); k:wipe()
  else
    k:scrape({{-10, y}, {250, y}, {500, y}}, {pressure=1}); k:wipe()
    k:scrape({{500, y}, {750, y}, {1010, y}}, {pressure=1}); k:wipe()
  end
end

--@ chunk 139
local nr = noise{seed=1610, period=30, octaves=3}
local function df(x) return math.abs(x - 485) end
local above_water = above({{-10,906},{1010,906}})
local planes_all = nil
for i, r in ipairs(rocks4) do
  local dfun = plane_depths(r, r.seed)
  local x0 = (r.x0 or r.top[1][1]) - 2
  local x1 = (r.x1 or r.top[#r.top][1]) + 2
  local pm = mask(function(x, y)
    if x < x0 or x > x1 then return 0 end
    local t = topy(r.top, x)
    return (y >= t - 1.5 and y <= t + dfun(x)) and 1 or 0
  end)
  planes_all = planes_all and (planes_all + pm) or pm
end
rocks4_planes = planes_all
for i, r in ipairs(rocks4) do
  local m = (rock_mask3(r) - fallsM:grow(1) - planes_all) * above_water * below(function(x) return 760 end)
  local function dep(x, y) return y - topy(r.top, x) end
  work(m, {hand="body", tool={kind="flat", width=8, stiffness=0.6}, length={14,34}, coverage=3, fill=true, clip=true, load=1.0,
    angle=function(x,y) return 1.5 + 0.3*nr(x,y) end,
    piles={{lent, function(x,y) return 0.5 + clamp(1 - (df(x) - 100)/100, 0, 1) end},
           {rock, 0.9},
           {brushdark, function(x,y) return 0.3 + 0.4*nr:at01(x+20,y) end},
           {mossdark, function(x,y) return 0.5*clamp((nr:at01(x+50,y) - 0.55)*3, 0, 1) * clamp(1 - dep(x,y)/80, 0, 1) end},
           {haze, function(x,y) return 0.12 * clamp((dep(x,y) - 10)/60, 0, 1) * clamp((df(x) - 200)/200, 0, 1) end}}})
end

--@ chunk 140
palette{scrape={orangeleaf, leafshade}}
glowrefl = pile{{"lead white",3},{"yellow ochre",1.4},{"chrome yellow",0.4},{"red earth",0.25},{"raw umber",0.15}, name="glowrefl"}
local WL = 906
local function crest(x) return (x < 485) and topy(LA_top, x) or topy(RA_top, x) end
local function yr(x) return WL + 0.85 * (WL - crest(x)) end
local function fallsW(y)
  local d = (y - WL) / 0.85
  local ys = WL - d
  if ys < FL.y0 then return 0, 488 end
  local l, r = fx(FL, 0, ys), fx(FR, 1, ys)
  return (r - l) / 2, (l + r) / 2
end
local nz = noise{seed=1801, period=60, octaves=2}
local nv = noise{seed=1802, period=200, octaves=1}
function inFallsRefl(x, y)
  local hw, c = fallsW(y)
  if hw <= 0 then return 0 end
  return clamp((hw - math.abs(x - c)) / 10 + 0.5, 0, 1)
end
function inSkyRefl(x, y) return clamp((y - yr(x)) / 14 + 0.5, 0, 1) end
function birchRefl(x, y)
  local v = 0
  for _, b in ipairs({{806, 22}, {917, 16}}) do
    local bx = b[1] + (y - 1090) * 0.03
    v = math.max(v, clamp((b[2] - math.abs(x - bx)) / 5, 0, 1) * clamp((y - 1092) / 10, 0, 1))
  end
  return v
end
poolC = below({{-10,WL},{1010,WL}})
work(poolC, {hand="body", tool={kind="flat", width=12, stiffness=0.5}, length={25,70}, coverage=3, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.03*nz(x,y) end,
  piles={{waterdark, function(x,y) local f = inFallsRefl(x,y); local s = inSkyRefl(x,y); return (1-f)*(1-s)*(0.7 + 0.5*clamp(1 - (y-WL)/120, 0, 1)) + f*0.25 end},
         {rock, function(x,y) local f = inFallsRefl(x,y); local s = inSkyRefl(x,y); return (1-f)*(1-s)*0.6*clamp(1 - (y-WL)/200, 0, 1) end},
         {brushdark, function(x,y) local f = inFallsRefl(x,y); local s = inSkyRefl(x,y); return (1-f)*(1-s)*(0.3 + 0.7*clamp((y - WL - 120)/150, 0, 1)) end},
         {deeprust, function(x,y) local f = inFallsRefl(x,y); local s = inSkyRefl(x,y); return (1-f)*(1-s)*0.5*clamp((y - WL - 160)/150, 0, 1)*(0.6 + 0.6*nv:at01(x,y)) + s * 0.6*clamp((math.abs(x - 485) - 280)/200, 0, 1) end},
         {fallrefl, function(x,y) return inFallsRefl(x,y) * (1 - inSkyRefl(x,y)) * 1.2 end},
         {glowrefl, function(x,y) local s = inSkyRefl(x,y); return s * clamp(1 - (math.abs(x - 485) - 60)/260, 0, 1) * 1.3 end},
         {amber, function(x,y) local s = inSkyRefl(x,y); return s * (0.4 + 0.5*clamp((math.abs(x - 485) - 120)/250, 0, 1)) end},
         {birch, function(x,y) return birchRefl(x,y) * 0.9 end},
         {haze, function(x,y) return birchRefl(x,y) * 0.6 end}}})
print(drying(485, 1000))

--@ chunk 141
local pm = below({{-10,910},{1010,910}})
blend(pm, {angle=math.pi/2})
blend(pm, {angle=math.pi/2})

--@ chunk 142
local pm = below({{-10,912},{1010,912}})
blend(pm, {angle=0.0})

--@ chunk 143
for _, p in ipairs({{420,800},{470,880},{560,860},{485,905},{485,930},{300,930},{700,930}}) do print(p[1], p[2], drying(p[1], p[2])) end
print(palette())

--@ chunk 144
palette{scrape={fallrefl, glowrefl}}
foam = pile{{"lead white",6},{"yellow ochre",0.15},{"cobalt blue",0.06}, name="foam"}
foamsh = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.35},{"yellow ochre",0.1}, name="foamsh"}
local nf = noise{seed=1901, period=18, octaves=2}
local function ftop(x) return 884 + 10 * nf(x, 0) + 0.0012 * (x - 485)^2 end
foam_m = mask(function(x, y)
  if x < 352 or x > 618 then return 0 end
  local t = ftop(x)
  local b = 922 + 6 * nf(x, 40) - 0.0004 * (x - 485)^2 * 2
  local side = clamp((math.min(x - 352, 618 - x)) / 20, 0, 1)
  return (y > t and y < b) and side or 0
end):soften(3)
work(foam_m, {hand="body", tool={kind="filbert", width=8, stiffness=0.5}, length={8,18}, coverage=3, fill=true, edge="soft", load=1.0,
  angle=function(x,y) return 0.25*nf(x*2, y*2) end,
  piles={{foamsh, function(x,y) return 0.5 + clamp((y - ftop(x) - 8)/20, 0, 1) end},
         {foam, function(x,y) return clamp(1 - (y - ftop(x))/16, 0, 1) * 1.2 end},
         {glow, function(x,y) return 0.4*clamp(1 - (y - ftop(x))/10, 0, 1) end}}})
local rb = brush{kind="round", width=7, stiffness=0.4, lay=2}
for i = 1, 26 do
  if i % 4 == 1 then rb:reload(i % 8 == 1 and glow or foam, 0.8) end
  local x = rand(362, 608)
  local y = ftop(x) + rand(-2, 5)
  local w = rand(6, 14)
  rb:stroke({{x - w, y + 3}, {x, y - rand(1, 4)}, {x + w, y + 3}}, {pressure={0.5, 0.3}})
end
local fb = brush{kind="flat", width=5, stiffness=0.5}
for i = 1, 22 do
  fb:reload(i % 3 == 0 and foamsh or foam, 0.45)
  local y = rand(924, 1010)
  local spread = 140 + (y - 920) * 1.2
  local cx = 485 + rand(-spread, spread) * 0.8
  local len = rand(15, 50) * (1 - (y - 920)/140)
  fb:stroke({{cx - len/2, y + rand(-1,1)}, {cx, y + rand(-1, 1)}, {cx + len/2, y + rand(-1,1)}}, {pressure={0.35, 0.15}, orient="across"})
end

--@ chunk 145
-- churn: soft gray-white strokes dragged up from the foam into the bottom of the falls, covering the teeth
local fan = brush{kind="fan", width=16, stiffness=0.4}
for i = 1, 24 do
  if i % 3 == 1 then fan:reload(i % 2 == 0 and foamsh or foam, 0.35) end
  local x = rand(368, 600)
  local y0 = rand(890, 900)
  fan:stroke({{x, y0}, {x + rand(-3, 3), y0 - rand(25, 50)}}, {pressure={0.5, 0.05}, orient="across", ramps={0.05, 0.7}})
end
local fz = (foam_m:grow(6) + rect(360, 850, 250, 50)):soften(8)
blend(fz, {angle=0.0})
blend(fz, {angle=math.pi/2})
-- flecks on the pool into streaks
local pz = (rect(300, 922, 400, 100)):soften(20)
blend(pz, {angle=0.0})

--@ chunk 146
for _, p in ipairs({{806,300},{920,300},{806,600},{265,450},{150,700},{700,760},{100,820},{900,820},{350,800},{620,800},{120,300},{60,700}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 147
for _, p in ipairs({{785,300},{780,150},{938,300},{930,450},{800,500},{265,450},{262,300}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 148
print(palette())

--@ chunk 149
palette{scrape={foamsh}}
mossdull = pile{{"green earth",3},{"yellow ochre",1.5},{"raw umber",0.8},{"red earth",0.2}, name="mossdull"}
-- boulder builder: irregular rocky silhouette, lit from the glow (up and toward center), mossy top
function boulder(c, seed, o)
  o = o or {}
  local cx, cy, rx, ry = c[1], c[2], c[3], c[4]
  local pts = {}
  math.randomseed(seed)
  local n = 9
  for i = 0, n - 1 do
    local a = i / n * 2 * math.pi + rand(-0.2, 0.2)
    local k = rand(0.85, 1.12)
    local sx = math.cos(a); local sy = math.sin(a)
    -- squarer bottom
    if sy > 0.3 then sy = math.min(1, sy * 1.25) end
    pts[#pts+1] = {cx + rx * k * sx, cy + ry * k * sy}
  end
  local m = outline{pts=pts, char="broken", seed=seed, amount=0.7}:mask()
  if o.clip then m = m * o.clip end
  if o.minus then m = m - o.minus end
  local lx, ly = gx - cx, (gy - 150) - cy
  local l = math.sqrt(lx*lx + ly*ly); lx, ly = lx/l, ly/l
  local glowk = clamp(1 - (math.abs(cx - 485) - 80) / 450, 0.2, 1)
  local nm = noise{seed=seed + 11, period=22, octaves=2}
  local function P(x, y) local px, py = (x - cx)/rx, (y - cy)/ry; return px*lx + py*ly, py, math.sqrt(px*px + py*py) end
  local function mossy(x, y) local u, v, r = P(x, y); return clamp((-v - 0.25 + 0.5*(nm:at01(x, y) - 0.5)) * 3, 0, 1) end
  local function rim(x, y) local u, v, r = P(x, y); return clamp((r - 0.78) * 6, 0, 1) * clamp((u + 0.1) * 2, 0, 1) * clamp(-v * 2 + 0.3, 0, 1) end
  work(m, {hand="body", tool={kind="flat", width=8, stiffness=0.6}, length={10,26}, coverage=3, fill=true, edge={found=0.7, soft=0.3, period=25}, load=1.0,
    angle=function(x,y) local u, v = P(x,y); return (v < -0.3) and (0.2*nm(x,y)) or (1.4 + 0.4*nm(x,y)) end,
    piles={{lent, function(x,y) local u, v = P(x,y); return (1 - mossy(x,y)) * (clamp(-u, 0, 1) + clamp(v, 0, 1)*0.6 + (o.dark or 0)) end},
           {rock, function(x,y) return (1 - mossy(x,y)) * 0.8 end},
           {brushdark, function(x,y) return (1 - mossy(x,y)) * 0.35 end},
           {mossdark, function(x,y) return mossy(x,y) * 1.0 end},
           {mossdull, function(x,y) local u, v = P(x,y); return mossy(x,y) * clamp((u + 0.2)*1.5, 0, 1) * glowk end},
           {rim_warm, function(x,y) return rim(x,y) * glowk * 1.5 end},
           {glow, function(x,y) return rim(x,y) * clamp(1 - (math.abs(cx - 485) - 60)/200, 0, 1) end}}})
  return m
end
local fallsP = fallsM:grow(2)
-- back row (left), then middle, then front
boulder({250, 735, 120, 55}, 2101, {minus=fallsP, clip=above({{-10,906},{1010,906}})})
boulder({90, 760, 130, 60}, 2102, {minus=fallsP, clip=above({{-10,906},{1010,906}})})
boulder({720, 760, 120, 55}, 2103, {minus=fallsP, clip=above({{-10,906},{1010,906}})})
boulder({915, 745, 110, 60}, 2104, {minus=fallsP, clip=above({{-10,906},{1010,906}})})

--@ chunk 150
local fallsP = fallsM:grow(2) + foam_m:grow(4)
front = {}
front[1] = boulder({160, 862, 165, 62}, 2111, {minus=fallsP, dark=0.3})
front[2] = boulder({335, 886, 55, 30}, 2112, {minus=fallsP, dark=0.4})
front[3] = boulder({775, 872, 150, 58}, 2113, {minus=fallsP, dark=0.3})
front[4] = boulder({642, 893, 50, 26}, 2114, {minus=fallsP, dark=0.4})
front[5] = boulder({985, 880, 70, 50}, 2115, {minus=fallsP, dark=0.3})

--@ chunk 151
local fb = brush{kind="flat", width=10, stiffness=0.5}
local fronts = {{160, 862, 165, 62}, {335, 886, 55, 30}, {775, 872, 150, 58}, {642, 893, 50, 26}, {985, 880, 70, 50}}
for i, c in ipairs(fronts) do
  local cx, cy, rx, ry = c[1], c[2], c[3], c[4]
  local base = cy + ry * 0.95
  local x0, x1 = cx - rx * 0.85, cx + rx * 0.85
  local n = math.floor((x1 - x0) / 9)
  for k = 0, n do
    if k % 3 == 0 then fb:reload(k % 2 == 0 and lent or waterdark, 0.6) end
    local x = x0 + (x1 - x0) * k / n + rand(-2, 2)
    local edge = 1 - ((x - cx) / rx)^2
    local len = ry * 1.2 * math.sqrt(math.max(edge, 0)) * rand(0.6, 1.0)
    fb:stroke({{x, base - 4}, {x + rand(-1,1), base + len}}, {pressure={0.55, 0.15}, orient="across"})
  end
end
-- soften reflections vertically
blend(below({{-10,915},{1010,915}}) * above({{-10,1010},{1010,1010}}), {angle=math.pi/2})

--@ chunk 152
local WL = 906
local nz = noise{seed=1811, period=60, octaves=2}
local fr = nil
for i = 1, 5 do fr = fr and (fr + front[i]) or front[i] end
front_all = fr
local zone = (below({{-10,WL},{1010,WL}}) * above({{-10,1060},{1010,1060}})) - fr - foam_m:grow(2)
local fade = mask(function(x, y) return clamp((1060 - y) / 30, 0, 1) end)
zone = zone * fade
work(zone, {hand="body", tool={kind="flat", width=12, stiffness=0.5}, length={25,60}, coverage=3, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.03*nz(x,y) end,
  piles={{waterdark, function(x,y) local f = inFallsRefl(x,y); return (1-f)*(0.9 + 0.4*clamp(1 - (y-WL)/120, 0, 1)) + f*0.3 end},
         {rock, function(x,y) local f = inFallsRefl(x,y); return (1-f)*0.6*clamp(1 - (y-WL)/200, 0, 1) end},
         {brushdark, function(x,y) local f = inFallsRefl(x,y); return (1-f)*(0.3 + 0.7*clamp((y - WL - 120)/150, 0, 1)) end},
         {foam, function(x,y) return inFallsRefl(x,y) * 0.5 end},
         {haze, function(x,y) return inFallsRefl(x,y) * 0.5 end},
         {rim_warm, function(x,y) return inFallsRefl(x,y) * 0.25 end}}})
print(drying(200, 950))

--@ chunk 153
local pz = below({{-10,912},{1010,912}}) * above({{-10,1110},{1010,1110}})
blend(pz:soften(10) - front_all, {angle=math.pi/2})
blend(pz:soften(10) - front_all, {angle=math.pi/2 + 0.05})
blend(pz:soften(10) - front_all, {angle=0})

--@ chunk 154
for _, p in ipairs({{250,150},{150,230},{560,200},{530,280},{650,320},{700,150},{450,100},{80,80},{900,100}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 155
local protect = mA:grow(4) + mB:grow(4) + mTL:grow(3) + mL1:grow(3) + mL2:grow(3)
local nE = noise{seed=2201, period=50, octaves=2}
local cz = canopy:grow(30)
-- lost-edge zones along the inner edge, chosen by noise
local edgezone = ((cz - canopy:shrink(20)) * mask(function(x,y) return clamp((nE:at01(x,y) - 0.45)*3, 0, 1) end)):soften(6) - protect
blend(edgezone, {angle=0.6})
blend(edgezone, {angle=2.4})
-- fuse dabs inside the clumps a little
blend((canopy:shrink(10) - protect):soften(8), {angle=1.3})

--@ chunk 156
function clump_mask(c, seed)
  local cx, cy, rx, ry = c[1], c[2], c[3], c[4]
  local pts = {}
  math.randomseed(seed)
  for i = 0, 10 do
    local a = i / 11 * 2 * math.pi + rand(-0.15, 0.15)
    local k = rand(0.8, 1.15)
    pts[#pts+1] = {cx + rx * k * math.cos(a), cy + ry * k * math.sin(a)}
  end
  return outline{pts=pts, char="soft", seed=seed, amount=0.9, lobe=math.min(rx, ry) * 0.35}:mask()
end
local U = nil
for i, c in ipairs(clumpsL) do local m = clump_mask(c, 1200 + i); U = U and (U + m) or m end
for i, c in ipairs(clumpsR) do local m = clump_mask(c, 1300 + i); U = U and (U + m) or m end
clumpU = U
local protect = mA:grow(4) + mB:grow(4) + mTL:grow(3) + mL1:grow(3) + mL2:grow(3)
blend((U:grow(6) - protect):soften(8), {angle=1.2})
local nE = noise{seed=2202, period=40, octaves=2}
local edge = ((U:grow(14) - U:shrink(14)) * mask(function(x,y) return clamp((nE:at01(x,y) - 0.4)*3, 0, 1) end)):soften(5) - protect
blend(edge, {angle=0.4, clip=false})

--@ chunk 157
palette{scrape={foam}}
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local protect = mA:grow(4) + mB:grow(4) + mTL:grow(3) + mL1:grow(3) + mL2:grow(3)
local nL = noise{seed=2301, period=22, octaves=2}
local nL2 = noise{seed=2302, period=60, octaves=2}
local edgeb = (clumpU:grow(12) - clumpU:shrink(40)) - protect
local lit = edgeb * mask(function(x,y) return clamp((nL:at01(x,y) - 0.5)*4, 0, 1) * clamp((nL2:at01(x,y) - 0.3)*2, 0, 1) * clamp(1 - (dist(x,y) - 180)/320, 0, 1) end)
work(lit, {hand="body", tool={kind="filbert", width=5, stiffness=0.5, lay=2}, length={3,7}, coverage=0.7, load=0.9,
  angle=function(x,y) return 1.57 + rand(-1.2, 1.2) end,
  scale_at=function(x,y) return 0.7 + 0.6*nL2:at01(x+30,y) end,
  piles={{orangeleaf, 1}, {glow, function(x,y) return clamp(1 - (dist(x,y) - 160)/180, 0, 1) * 0.8 end}, {leafrust, 0.3}}})
-- dark leaf silhouettes in the interior and toward the outer canopy
local darkm = (clumpU:shrink(20) + canopy) * mask(function(x,y) return clamp((nL:at01(x+70,y) - 0.62)*4, 0, 1) * clamp((dist(x,y) - 250)/250, 0, 1) end) - protect
work(darkm, {hand="body", tool={kind="filbert", width=5, stiffness=0.5, lay=2}, length={3,7}, coverage=0.6, load=0.9,
  angle=function(x,y) return 1.57 + rand(-1.2, 1.2) end,
  scale_at=function(x,y) return 0.7 + 0.7*nL2:at01(x,y+40) end,
  piles={{leafshade, 1}, {deeprust, 0.5}}})

--@ chunk 158
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local function crestY(x) return (x < 485) and topy(LA_top, x) or topy(RA_top, x) end
local nb = noise{seed=2401, period=26, octaves=3}
local nb2 = noise{seed=2402, period=90, octaves=2}
local protect = mA:grow(3) + mB:grow(3) + mTL:grow(2) + mTL2:grow(2) + fallsM:grow(6)
-- bush tops rising above the crest: height varies, bigger on the left arm and the far right
undergrowth = mask(function(x, y)
  if x > 360 and x < 610 then return 0 end
  local c = crestY(x)
  local h = 6 + 34 * nb2:at01(x, 0) * clamp((math.abs(x - 485) - 120)/150, 0, 1) + 10 * nb(x, 0)
  local top = c - h
  return clamp((y - top) / 3, 0, 1) * clamp((c + 28 - y) / 8, 0, 1)
end) - protect
work(undergrowth, {hand="body", tool={kind="filbert", width=7, stiffness=0.5}, length={5,12}, coverage=2.6, fill=true, edge="loose", load=0.9,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/7 + y/5) end,
  piles={{leafshade, 1}, {brushdark, function(x,y) return 0.5 + 0.5*nb:at01(x+30, y) end},
         {deeprust, function(x,y) return 0.5*nb:at01(x, y+50) end}}})
-- rim light on the bush tops facing the glow
local rimU = mask(function(x, y)
  if x > 360 and x < 610 then return 0 end
  local c = crestY(x)
  local h = 6 + 34 * nb2:at01(x, 0) * clamp((math.abs(x - 485) - 120)/150, 0, 1) + 10 * nb(x, 0)
  local top = c - h
  return clamp(1 - math.abs(y - top - 2.5) / 3, 0, 1)
end) * mask(function(x,y) return clamp((nb:at01(x*3, y*3) - 0.35)*3, 0, 1) end) - protect
work(rimU, {hand="detail", tool={kind="round", width=3, stiffness=0.5}, length={4,9}, coverage=1.6, angle=0.0, load=0.8,
  piles={{rim_warm, 1}, {orangeleaf, 0.5}, {glow, function(x,y) return clamp(1 - (dist(x,y) - 200)/250, 0, 1) end}}})

--@ chunk 159
print(palette())
for _, p in ipairs({{100,1000},{300,1200},{485,1150},{700,1000},{900,1200}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 160
palette{scrape={mossdull, leafrust}}
fallrefl = pile{{"lead white",3},{"raw umber",0.6},{"cobalt blue",0.25},{"yellow ochre",0.35}, name="fallrefl"}
glowrefl = pile{{"lead white",3},{"yellow ochre",1.4},{"chrome yellow",0.4},{"red earth",0.25},{"raw umber",0.15}, name="glowrefl"}
wedgeO = outline{{468,1078},{505,1080},{528,1102},{552,1130},{576,1160},{600,1190},{628,1222},{662,1256},{340,1256},{368,1222},{392,1190},{414,1160},{434,1130},{452,1102}, char="soft", seed=2501, amount=0.8, lobe=14}
wedgeM = wedgeO:mask():soften(8)
columnO = outline{{370,918},{600,918},{590,960},{575,1010},{552,1055},{520,1090},{462,1092},{426,1060},{402,1015},{386,962}, char="soft", seed=2502, amount=0.6, lobe=12}
columnM = columnO:mask():soften(10)
birchRA = ribbon({{800,985},{803,1040},{799,1100},{805,1160},{801,1220},{804,1256}}, 20):roughen(3, 14, 2503):soften(3)
birchRB = ribbon({{912,995},{915,1050},{911,1110},{916,1170},{913,1256}}, 14):roughen(3, 14, 2504):soften(3)
print(wedgeM:area(), columnM:area(), birchRA:area(), birchRB:area())
print(palette())

--@ chunk 161
columnO = outline{{372,916},{602,916},{597,975},{590,1035},{574,1080},{522,1096},{458,1096},{404,1082},{386,1035},{378,975}, char="soft", seed=2502, amount=0.6, lobe=12}
columnM = columnO:mask():soften(10)
local WL = 906
local nz = noise{seed=2511, period=50, octaves=2}
local nw = noise{seed=2512, period=120, octaves=2}
poolArea = below({{-10,WL},{1010,WL}}) - front_all - foam_m:shrink(4)
local function C(x,y) return columnM:at(x,y) end
local function Wd(x,y) return wedgeM:at(x,y) end
local function B(x,y) return math.max(birchRA:at(x,y), birchRB:at(x,y)) end
local function D(x,y) return clamp(1 - C(x,y) - Wd(x,y) - B(x,y), 0, 1) end
work(poolArea, {hand="body", tool={kind="flat", width=12, stiffness=0.5}, length={25,70}, coverage=3, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.03*nz(x,y) end,
  piles={{waterdark, function(x,y) return D(x,y) * 0.9 + C(x,y)*0.15 end},
         {rock, function(x,y) return D(x,y) * 0.8 * clamp(1 - (y - WL)/90, 0, 1) end},
         {brushdark, function(x,y) return D(x,y) * (0.4 + 0.6*clamp((y - WL - 60)/120, 0, 1)) end},
         {deeprust, function(x,y) return D(x,y) * 0.35 * clamp((y - WL - 120)/100, 0, 1) * (0.5 + nw:at01(x,y)) + Wd(x,y)*0.3*clamp(1 - math.abs(x - 500)/170, 0, 1)*0 end},
         {fallrefl, function(x,y) return C(x,y) * 1.0 end},
         {haze, function(x,y) return C(x,y)*0.4 + B(x,y)*0.8 + Wd(x,y)*0.3 end},
         {rim_warm, function(x,y) return C(x,y) * 0.5 * clamp((y - 1020)/70, 0, 1) end},
         {glowrefl, function(x,y) return Wd(x,y) * (1.2 - 0.8*clamp(math.abs(x - 500)/150, 0, 1)) end},
         {amber, function(x,y) return Wd(x,y) * (0.3 + 0.7*clamp(math.abs(x - 500)/130, 0, 1)) end},
         {birch, function(x,y) return B(x,y) * 0.5 end},
         {fallrefl, function(x,y) return B(x,y) * 0.4 end}}})
print(drying(485,1150))

--@ chunk 162
local pz = below({{-10,912},{1010,912}}) - front_all
blend(pz, {angle=math.pi/2})
blend(pz, {angle=math.pi/2 + 0.04})

--@ chunk 163
local pz = below({{-10,914},{1010,914}}) - front_all
blend(pz, {angle=0})
-- ripple lines
local fb = brush{kind="flat", width=4, stiffness=0.5}
local rb = brush{kind="round", width=3, point=0.5, stiffness=0.5}
local ys = uneven(34, 930, 1245, 0.6, 0.4, 2521)
for i, y in ipairs(ys) do
  local spacing = (y - 906) / 340
  -- dark ripples across the light reflections
  local x0 = rand(360, 600)
  local len = rand(30, 110) * (0.6 + spacing)
  fb:reload(waterdark, 0.5)
  fb:stroke({{x0 - len/2, y}, {x0, y + rand(-0.6, 0.6)}, {x0 + len/2, y}}, {pressure={0.3, 0.15}, orient="across"})
  -- light ripples on the dark water (sky glints), sparser
  if i % 2 == 0 then
    local xs = (i % 4 == 0) and rand(20, 330) or rand(640, 990)
    local l2 = rand(20, 70) * (0.6 + spacing)
    rb:reload((math.abs(xs - 485) < 300) and glowrefl or haze, 0.45)
    rb:gesture({{xs - l2/2, y, 0.1}, {xs, y + rand(-0.5,0.5), 0.45}, {xs + l2/2, y, 0.05}}, {wobble=0.6})
  end
end
-- breaks across the birch reflections
for i = 1, 12 do
  local y = rand(990, 1245)
  for _, bx in ipairs({803, 914}) do
    fb:reload(waterdark, 0.5)
    local l = rand(18, 34)
    fb:stroke({{bx - l/2 + rand(-4,4), y}, {bx + l/2 + rand(-4,4), y + rand(-0.5,0.5)}}, {pressure={0.4, 0.2}, orient="across"})
  end
end

--@ chunk 164
local pz = below({{-10,914},{1010,914}}) - front_all
blend(pz, {angle=0})
blend(pz, {angle=0.03})

--@ chunk 165
for _, p in ipairs({{160,840},{250,720},{720,740},{775,840},{470,700},{540,700},{430,600},{300,300},{485,940}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 166
palette{scrape={glowrefl}}
fallwhite = pile{{"lead white",8},{"yellow ochre",0.25},{"cobalt blue",0.08}, name="fallwhite"}
local patches = ellipse(357, 785, 16, 30) + ellipse(600, 790, 14, 26)
work(patches, {hand="body", tool={kind="filbert", width=7, stiffness=0.6}, length={8,20}, coverage=3, fill=true, clip=true, load=1.0, angle=1.5,
  piles={{lent, 1}, {rock, 0.8}}})
local function brinkY(x) return 664 - 2.5 * (1 - ((x - 470)/90)^2) end
local strip = mask(function(x, y)
  if x < 384 or x > 582 then return 0 end
  if x > 528 and x < 548 then return 0 end
  local b = brinkY(x)
  return (y > b - 7 and y < b + 1) and 1 or 0
end):soften(1.5)
local above_strip = mask(function(x, y)
  if x < 384 or x > 590 then return 0 end
  local b = brinkY(x)
  return (y > 650 and y < b - 6) and 1 or 0
end):soften(2)
work(above_strip, {hand="body", tool={kind="flat", width=6}, length={14,30}, coverage=3, fill=true, clip=true, angle=0.0, load=1.0,
  piles={{haze, 1}, {amber, 0.5}, {deeprust, 0.25}}})
work(strip, {hand="body", tool={kind="flat", width=4}, length={12,30}, coverage=3, fill=true, clip=true, angle=0.0, load=1.0,
  piles={{glow, 1}, {haze, 0.4}}})
local rb = brush{kind="round", width=2.5, point=0.5}
rb:reload(fallwhite, 0.7)
rb:gesture({{388, brinkY(388), 0.15}, {420, brinkY(420), 0.5}, {470, brinkY(470), 0.65}, {505, brinkY(505), 0.5}, {527, brinkY(527), 0.15}}, {wobble=0.4})
rb:reload(fallwhite, 0.6)
rb:gesture({{549, 665, 0.15}, {562, 664, 0.45}, {578, 665, 0.1}}, {wobble=0.3})

--@ chunk 167
-- water spilling over the dark rib: short arcs over its top and thin strands down its face
local fb = brush{kind="filbert", width=5, stiffness=0.5}
for i = 1, 5 do
  fb:reload(fallwhite, 0.5)
  local x0 = rand(534, 552)
  local dir = (x0 < 543) and -1 or 1
  fb:gesture({{x0, 664, 0.3}, {x0 + dir*3, 672, 0.5}, {x0 + dir*6, 690, 0.35}, {x0 + dir*7, rand(710, 740), 0.05}}, {wobble=0.8})
end
local rd = brush{kind="round", width=3, point=0.6}
for i = 1, 5 do
  rd:reload(fallrefl, 0.45)
  local x = rand(538, 556)
  local y0 = rand(700, 780)
  rd:gesture({{x, y0, 0.2}, {x + rand(-1,1), y0 + 30, 0.4}, {x + rand(-2,2), y0 + rand(50, 90), 0.0}}, {wobble=0.6})
end
-- soften the acid yellow streak by dragging white-gray through it
local fan = brush{kind="fan", width=12, stiffness=0.5}
for i = 1, 4 do
  fan:reload(fallrefl, 0.3)
  local x = 452 + rand(-6, 6)
  fan:stroke({{x, 672}, {x + rand(-1,1), 720}, {x + rand(-2,2), 770}}, {pressure={0.45, 0.1}, orient="across"})
end

--@ chunk 168
local nt = noise{seed=2601, period=14, octaves=2}
local function tb(x) return 683 + 4 * nt(x, 0) + ((x > 530 and x < 556) and 10 or 0) end
tongueM = mask(function(x, y)
  if x < 386 or x > 584 then return 0 end
  if y < 655 or y > tb(x) then return 0 end
  return 1
end):soften(2)
work(tongueM, {hand="body", tool={kind="flat", width=5, stiffness=0.5}, length={12,26}, coverage=3, fill=true, clip=true, load=1.0,
  angle=math.pi/2,
  piles={{glow, function(x,y) return clamp(1 - (y - 655)/18, 0, 1) * 1.2 + 0.2 end},
         {fallwhite, function(x,y) return 0.4 end},
         {haze, 0.25},
         {fallrefl, function(x,y) return clamp((y - 666)/14, 0, 1) end}}})
blend((tongueM:grow(4) + rect(386, 680, 198, 30)):soften(5), {angle=math.pi/2})
blend((ellipse(357, 785, 26, 40) + ellipse(600, 790, 24, 36)):soften(12), {angle=1.5})
blend((ellipse(357, 785, 26, 40) + ellipse(600, 790, 24, 36)):soften(12), {angle=0.3})

--@ chunk 169
local ne = noise{seed=2701, period=12, octaves=2}
-- rock shoulders overlapping the band ends, irregular
local sh = mask(function(x, y)
  if y < 648 or y > 730 then return 0 end
  local xl = fx(FL, 0, math.max(y, FL.y0)) + 5 + 5 * ne(0, y)
  local xr = fx(FR, 1, math.max(y, FR.y0)) - 5 + 5 * ne(50, y)
  local inL = (x > 365 and x < xl) and 1 or 0
  local inR = (x > xr and x < 615) and 1 or 0
  -- rib
  local rc = 542 + 0.03 * (y - 664)
  local inRib = (y > 668 and math.abs(x - rc) < 9 + 2 * ne(x, y)) and 1 or 0
  return math.max(inL, inR, inRib)
end):soften(1.5)
work(sh, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,20}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=1.5, piles={{lent, 1}, {rock, 0.7}}})
-- break the band's bottom edge with dark gaps pulled up into it
local db = brush{kind="round", width=5, point=0.5, stiffness=0.6}
local gx_ = {398, 417, 436, 463, 488, 507, 522, 566}
for i, x in ipairs(gx_) do
  db:reload(i % 2 == 0 and rock or lent, 0.45)
  local y0 = rand(684, 696)
  db:gesture({{x, y0, 0.05}, {x + rand(-1,1), y0 + 12, 0.5}, {x + rand(-1.5,1.5), y0 + rand(40, 80), 0.3}, {x + rand(-2,2), y0 + rand(90, 130), 0.0}}, {wobble=0.8})
end
-- spill over the rib top again
local fb = brush{kind="filbert", width=4, stiffness=0.5}
for i = 1, 3 do
  fb:reload(fallwhite, 0.5)
  local x0 = 542 + rand(-5, 5)
  local dir = (x0 < 542) and -1 or 1
  fb:gesture({{x0, 668, 0.3}, {x0 + dir*4, 676, 0.5}, {x0 + dir*7, 695, 0.3}, {x0 + dir*8, rand(715, 745), 0.05}}, {wobble=0.6})
end

--@ chunk 170
for _, p in ipairs({{380,645},{600,645},{470,700},{420,760},{542,700}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 171
headL = outline{{360,656},{368,646},{380,641},{392,643},{400,651},{404,664},{405,700},{358,700}, char="broken", seed=2801, amount=0.4}:mask()
headR = outline{{576,668},{580,656},{590,648},{603,645},{614,649},{620,660},{622,700},{574,700}, char="broken", seed=2802, amount=0.4}:mask()
local behind = (rect(360, 640, 48, 32) + rect(572, 640, 52, 32)) - headL - headR - fallsM:shrink(1)
behind = behind * mask(function(x, y) local c = (x < 485) and topy(LA_top, x) or topy(RA_top, x); return clamp((c + 3 - y)/3, 0, 1) end)
work(behind, {hand="body", tool={kind="filbert", width=5}, length={6,14}, coverage=3.5, fill=true, clip=true, load=1.0, angle=1.5,
  piles={{haze, 0.8}, {amber, 0.6}, {deeprust, function(x,y) return x > 485 and 0.45 or 0.25 end}}})
work(headL + headR, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,18}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.2 + 0.3*math.sin(x/5) end, piles={{lent, 1}, {rock, 0.7}, {brushdark, 0.2}}})
-- rim light on the head tops
local rd = brush{kind="round", width=3, point=0.5}
rd:reload(rim_warm, 0.6)
rd:gesture({{362, 654, 0.1}, {370, 646, 0.45}, {381, 642, 0.55}, {392, 644, 0.4}, {399, 651, 0.1}}, {wobble=0.4})
rd:reload(rim_warm, 0.6)
rd:gesture({{579, 658, 0.1}, {589, 649, 0.45}, {602, 646, 0.5}, {612, 649, 0.2}}, {wobble=0.4})
-- soften the dark drips into gaps in the curtain (below the band)
local cur = fallsM * below(function(x) return 700 end) * above(function(x) return 880 end)
blend(cur:soften(4), {angle=math.pi/2})

--@ chunk 172
local protect = mA:grow(4) + mB:grow(4) + mTL:grow(3) + mL1:grow(3) + mL2:grow(3) + mTL2:grow(3)
local cz = (clumpU:grow(10) + canopy):soften(8) - protect
blend(cz, {angle=1.1})
-- soften the scalloped crest rims a little
local function crestY(x) return (x < 485) and topy(LA_top, x) or topy(RA_top, x) end
local crestband = mask(function(x, y) if x > 355 and x < 625 then return 0 end; return clamp(1 - math.abs(y - crestY(x) + 2)/9, 0, 1) end) - protect
blend(crestband, {angle=0.3})

--@ chunk 173
for _, y in ipairs({50, 200, 350, 500, 600}) do
  local ax = axis_fn(fullA_pts); local cx = ax(y)
  local bx = axis_fn(fullB_pts)(y)
  print(y, drying(cx, y), drying(cx - 12, y), drying(bx, y), drying(cx + 30, y))
end

--@ chunk 174
print(palette())

--@ chunk 175
palette{scrape={fallrefl, fallwhite}}
mossdeep = pile{{"green earth",2},{"raw umber",1.2},{"yellow ochre",0.8},{"Prussian blue",0.1}, name="mossdeep"}
rockgray = mix{{rock, 0.5}, {haze, 0.5}, name="rockgray"}
function boulder_m(c, seed)
  local cx, cy, rx, ry = c[1], c[2], c[3], c[4]
  local pts = {}
  math.randomseed(seed)
  for i = 0, 8 do
    local a = i / 9 * 2 * math.pi + rand(-0.2, 0.2)
    local k = rand(0.85, 1.12)
    local sx = math.cos(a); local sy = math.sin(a)
    if sy > 0.3 then sy = math.min(1, sy * 1.25) end
    pts[#pts+1] = {cx + rx * k * sx, cy + ry * k * sy}
  end
  return outline{pts=pts, char="broken", seed=seed, amount=0.7}:mask()
end
BLD = {
  {c={250,735,120,55}, s=2101, back=true}, {c={90,760,130,60}, s=2102, back=true}, {c={720,760,120,55}, s=2103, back=true}, {c={915,745,110,60}, s=2104, back=true},
  {c={160,862,165,62}, s=2111}, {c={335,886,55,30}, s=2112}, {c={775,872,150,58}, s=2113}, {c={642,893,50,26}, s=2114}, {c={985,880,70,50}, s=2115},
}
local fallsP = fallsM:grow(2) + foam_m:grow(4)
local water = below({{-10,906},{1010,906}})
function retop(b, cover)
  local cx, cy, rx, ry = b.c[1], b.c[2], b.c[3], b.c[4]
  local m = boulder_m(b.c, b.s) - fallsP
  if b.back then m = m - water end
  if cover then m = m - cover end
  local nm = noise{seed=b.s + 31, period=18, octaves=2}
  local nm2 = noise{seed=b.s + 32, period=40, octaves=2}
  local function v(x, y) return (y - cy) / ry end
  local top = m * mask(function(x, y) return clamp((-v(x,y) + 0.05) * 4, 0, 1) end)
  local glowk = clamp(1 - (math.abs(cx - 485) - 80) / 450, 0.25, 1)
  work(top, {hand="body", tool={kind="flat", width=7, stiffness=0.6}, length={8,20}, coverage=2.8, fill=true, clip=true, load=1.0,
    angle=function(x,y) return 0.12*nm(x,y) end,
    piles={{mossdeep, function(x,y) return clamp((nm2:at01(x,y) - 0.3)*2.5, 0, 1) end},
           {mossdark, function(x,y) return 0.5*clamp((nm:at01(x,y) - 0.4)*3, 0, 1) end},
           {brushdark, function(x,y) return 0.35 + 0.4*clamp((v(x,y) + 0.3)*2, 0, 1) end},
           {rock, function(x,y) return clamp((0.45 - nm2:at01(x,y))*3, 0, 1) end},
           {rockgray, function(x,y) return 0.6*clamp((0.4 - nm2:at01(x,y))*3, 0, 1) * clamp(-v(x,y) - 0.5, 0, 1) * glowk end}}})
  return m
end
bmasks = {}
for i = 1, 4 do bmasks[i] = retop(BLD[i]) end

--@ chunk 176
local cover = nil
for i = 5, 9 do
  bmasks[i] = retop(BLD[i])
end

--@ chunk 177
-- broken rim light along the upper contours, strongest near the falls
local function upper_rim(b, m)
  local cx, cy, rx, ry = b.c[1], b.c[2], b.c[3], b.c[4]
  local nr = noise{seed=b.s + 41, period=16, octaves=2}
  local edge = (m - m:shrink(5)) * mask(function(x, y)
    local v = (y - cy) / ry
    local u = (x - cx) / rx
    local towardFalls = (cx < 485) and u or -u
    return clamp((-v - 0.15) * 3, 0, 1) * clamp((nr:at01(x, y) - 0.38) * 3, 0, 1) * clamp(0.5 + towardFalls * 0.6, 0.15, 1)
  end)
  local glowk = clamp(1 - (math.abs(cx - 485) - 60) / 420, 0.15, 1)
  work(edge, {hand="detail", tool={kind="round", width=3, stiffness=0.5}, length={5,12}, coverage=1.8, angle=0.0, load=0.85,
    piles={{rim_warm, 1}, {glow, glowk * 0.8}, {mossdeep, (1 - glowk) * 0.6}}})
end
for i = 1, 9 do upper_rim(BLD[i], bmasks[i]) end
-- autumn leaves fallen on the moss
local lb = brush{kind="filbert", width=4, stiffness=0.5, lay=2}
for i = 1, 9 do
  local b = BLD[i]
  local cx, cy, rx, ry = b.c[1], b.c[2], b.c[3], b.c[4]
  local n = math.floor(rx / 12)
  for k = 1, n do
    local x = cx + rand(-0.8, 0.8) * rx
    local y = cy - ry * rand(0.25, 0.75)
    if bmasks[i]:at(x, y) > 0.8 then
      if k % 4 == 1 then lb:reload((k % 8 == 1) and orangeleaf or deeprust, 0.6) end
      local a = rand(-0.6, 0.6)
      lb:stroke({{x, y}, {x + 4*math.cos(a), y + 2*math.sin(a)}}, {pressure=rand(0.3, 0.6)})
    end
  end
end

--@ chunk 178
headL2 = poly({{322,622},{334,630},{346,640},{352,637},{361,643},{370,636},{381,633},{391,638},{399,648},{405,662},{406,705},{322,705}})
headR2 = poly({{574,668},{577,656},{584,648},{593,643},{602,645},{611,639},{622,637},{634,640},{646,635},{660,633},{676,630},{676,705},{574,705}})
local keep = fallsM:shrink(1)
local hm = (headL2 + headR2) - keep
work(hm, {hand="body", tool={kind="flat", width=6, stiffness=0.6}, length={8,20}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.1 + 0.4*math.sin(x/7 + y/9) end,
  piles={{lent, 1}, {rock, 0.8}, {brushdark, 0.3}}})
-- rim lights with a knife held along each top facet
local function rimline(pts, pile, w)
  for j = 1, #pts - 1 do
    local a, b = pts[j], pts[j+1]
    local dx, dy = b[1] - a[1], b[2] - a[2]
    local len = math.sqrt(dx*dx + dy*dy)
    local ang = math.atan(dy, dx)
    local k = knife{width=len * 0.95}
    k:load(pile, 0.35)
    local mx, my = (a[1] + b[1]) / 2, (a[2] + b[2]) / 2
    k:lay({{mx, my - 1}, {mx, my + (w or 2)}}, {pressure={0.12, 0.2}, angle=ang})
  end
end
rimline({{334,630},{346,640},{352,637},{361,643},{370,636},{381,633},{391,638},{399,648}}, rim_warm, 2)
rimline({{584,648},{593,643},{602,645},{611,639},{622,637},{634,640},{646,635},{660,633}}, rim_warm, 2)

--@ chunk 179
local edges = (rect(312, 615, 22, 92) + rect(666, 622, 22, 85)):soften(6)
blend(edges, {angle=0.0})
blend(edges, {angle=math.pi/2})
local teeth = (rect(404, 676, 128, 44) + rect(552, 676, 26, 44)):soften(5)
blend(teeth, {angle=math.pi/2})
-- darken the left leg of the arch on the rib
local db = brush{kind="round", width=4, point=0.4, stiffness=0.6}
db:reload(lent, 0.6)
db:gesture({{533, 668, 0.5}, {534, 680, 0.7}, {536, 700, 0.6}, {538, 725, 0.3}}, {wobble=0.4})
db:reload(lent, 0.6)
db:gesture({{538, 664, 0.6}, {543, 663, 0.6}, {548, 665, 0.5}}, {wobble=0.3})

--@ chunk 180
local rb = brush{kind="filbert", width=5, stiffness=0.5}
rb:reload(birch, 0.4); rb:load(glow, 0.2)
rb:gesture({{534, 662, 0.3}, {541, 663, 0.6}, {549, 664, 0.3}}, {wobble=0.3})
rb:reload(birch, 0.35)
rb:gesture({{548, 664, 0.4}, {551, 672, 0.5}, {553, 690, 0.3}, {554, 715, 0.05}}, {wobble=0.4})
-- fill the two light notches beside the heads with bank tone
local notch = (ellipse(312, 642, 10, 14) + ellipse(690, 645, 10, 14))
work(notch, {hand="body", tool={kind="filbert", width=5}, length={5,10}, coverage=3, fill=true, clip=true, load=1, angle=1.2, piles={{brushdark, 1}, {deeprust, 0.5}}})

--@ chunk 181
local rd = brush{kind="round", width=6, point=0.5, stiffness=0.6}
local rs = brush{kind="round", width=3.5, point=0.6, stiffness=0.6}
for i = 1, 9 do
  local b = BLD[i]
  local cx, cy, rx, ry = b.c[1], b.c[2], b.c[3], b.c[4]
  local m = bmasks[i]
  local ncr = (rx > 100) and 2 or 1
  for k = 1, ncr do
    local x = cx + rand(-0.55, 0.55) * rx
    -- find the top contour at x
    local ytop = cy - ry * 1.2
    for y = cy - ry * 1.3, cy, 1 do if m:at(x, y) > 0.5 then ytop = y; break end end
    local slant = rand(-0.25, 0.25)
    local len = ry * rand(1.0, 1.7)
    rd:reload(lent, 0.7)
    rd:gesture({{x - 3, ytop - 1, 0.9}, {x + slant * len * 0.3, ytop + len * 0.3, 0.7}, {x + slant * len * 0.7 + rand(-3,3), ytop + len * 0.7, 0.45}, {x + slant * len, ytop + len, 0.05}}, {wobble=1})
    -- notch: a short dark wedge on the top edge
    rd:reload(lent, 0.7)
    rd:gesture({{x - rand(6, 12), ytop - 1, 0.2}, {x, ytop + 4, 0.9}, {x + rand(6, 12), ytop - 1, 0.2}}, {wobble=0.5})
    -- lit edge on the glow side of the crack
    local side = (cx < 485) and 1 or -1
    rs:reload(rockgray, 0.5)
    rs:gesture({{x + side * 5, ytop + 4, 0.4}, {x + side * 5 + slant * len * 0.3, ytop + len * 0.3, 0.3}, {x + side * 5 + slant * len * 0.55, ytop + len * 0.55, 0.0}}, {wobble=0.5})
  end
  -- a horizontal ledge crack across the face
  local y = cy + ry * rand(0.1, 0.4)
  local x0 = cx - rx * rand(0.3, 0.7)
  local x1 = cx + rx * rand(0.2, 0.6)
  rs:reload(lent, 0.6)
  rs:gesture({{x0, y, 0.1}, {(x0 + x1)/2, y + rand(-3, 3), 0.7}, {x1, y + rand(-4, 4), 0.1}}, {wobble=1})
end

--@ chunk 182
local all = nil
for i = 1, 9 do all = all and (all + bmasks[i]) or bmasks[i] end
local bm = all:shrink(3):soften(4)
blend(bm, {angle=0.1})
blend(bm, {angle=1.4})

--@ chunk 183
function restate_boulder(b, m)
  local cx, cy, rx, ry = b.c[1], b.c[2], b.c[3], b.c[4]
  local nm = noise{seed=b.s + 51, period=20, octaves=2}
  local nm2 = noise{seed=b.s + 52, period=45, octaves=2}
  local function v(x, y) return (y - cy) / ry + 0.25 * (nm2:at01(x, y) - 0.5) end
  local function u(x, y) return (x - cx) / rx end
  local toward = (cx < 485) and 1 or -1
  work(m, {hand="body", tool={kind="flat", width=8, stiffness=0.6}, length={10,26}, coverage=3.5, fill=true, clip=true, load=1.0,
    angle=function(x,y) return (v(x,y) < -0.35) and (0.12*nm(x,y)) or (1.45 + 0.35*nm(x,y)) end,
    piles={{lent, function(x,y) return clamp((v(x,y) + 0.1) * 2, 0, 1) * (0.6 + 0.4*clamp(-u(x,y)*toward, 0, 1)) end},
           {rock, function(x,y) return clamp((v(x,y) + 0.3) * 2, 0, 1) * 0.9 end},
           {brushdark, function(x,y) return 0.3 + 0.2*nm:at01(x, y) end},
           {mossdeep, function(x,y) return clamp((-v(x,y) - 0.25) * 3, 0, 1) * (0.7 + 0.5*nm:at01(x+30, y)) end},
           {mossdark, function(x,y) return clamp((-v(x,y) - 0.3) * 3, 0, 1) * 0.5 end}}})
end
for i = 1, 9 do restate_boulder(BLD[i], bmasks[i]) end

--@ chunk 184
function top_contour(m, x0, x1, ylo, yhi, step)
  local pts = {}
  for x = x0, x1, step do
    for y = ylo, yhi do
      if m:at(x, y) > 0.5 then pts[#pts+1] = {x, y}; break end
    end
  end
  return pts
end
local nr = noise{seed=2901, period=25, octaves=2}
for i = 1, 9 do
  local b = BLD[i]
  local cx, cy, rx, ry = b.c[1], b.c[2], b.c[3], b.c[4]
  local pts = top_contour(bmasks[i], cx - rx * 0.95, cx + rx * 0.95, cy - ry * 1.3, cy + ry * 0.2, 9)
  local glowk = clamp(1 - (math.abs(cx - 485) - 60) / 420, 0.2, 1)
  for j = 1, #pts - 1 do
    local a, c = pts[j], pts[j+1]
    if nr:at01(a[1], a[2]) > 0.35 then
      local dx, dy = c[1] - a[1], c[2] - a[2]
      local len = math.sqrt(dx*dx + dy*dy)
      local ang = math.atan(dy, dx)
      -- slopes facing the falls get more light
      local facing = ((cx < 485) and (a[1] > cx - rx*0.3)) or ((cx > 485) and (a[1] < cx + rx*0.3))
      local k = knife{width=len * 1.05}
      k:load(facing and rim_warm or mossdeep, 0.35)
      local mx, my = (a[1] + c[1]) / 2, (a[2] + c[2]) / 2
      k:lay({{mx, my}, {mx, my + (facing and 3 or 2)}}, {pressure={0.12, 0.2}, angle=ang})
      if facing and glowk > 0.6 and nr:at01(a[1]+50, a[2]) > 0.55 then
        local k2 = knife{width=len * 0.7}
        k2:load(glow, 0.3)
        k2:lay({{mx, my - 0.5}, {mx, my + 1.2}}, {pressure={0.15, 0.2}, angle=ang})
      end
    end
  end
end

--@ chunk 185
for _, p in ipairs({{100,1000},{100,1200},{485,1150},{700,1100},{900,1200},{300,950},{806,1150}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 186
-- hand-drawn reflection masses of the canopy in the near water
reflL = outline{{-10,1105},{60,1098},{140,1110},{210,1128},{262,1150},{300,1180},{318,1215},{325,1256},{-10,1256}, char="soft", seed=3001, amount=0.8, lobe=18}:mask():soften(14)
reflR = outline{{560,1150},{600,1118},{650,1092},{720,1078},{790,1080},{870,1070},{1010,1060},{1010,1256},{640,1256},{610,1215}, char="soft", seed=3002, amount=0.8, lobe=18}:mask():soften(14)
print(reflL:area(), reflR:area())

--@ chunk 187
palette{scrape={rockgray}}
reflrust = mix{{leafshade, 0.45}, {orangeleaf, 0.3}, {waterdark, 0.25}, name="reflrust"}
local nz = noise{seed=3011, period=50, octaves=2}
local nv = noise{seed=3012, period=25, octaves=2}
local zone = below({{-10,1030},{1010,1030}}) - front_all
local fade = mask(function(x, y) return clamp((y - 1030) / 40, 0, 1) end)
zone = zone * fade
local function L(x,y) return reflL:at(x,y) end
local function R(x,y) return reflR:at(x,y) end
local function Wd(x,y) return wedgeM:at(x,y) end
local function B(x,y) return math.max(birchRA:at(x,y), birchRB:at(x,y)) end
work(zone, {hand="body", tool={kind="flat", width=12, stiffness=0.5}, length={25,70}, coverage=2.6, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.03*nz(x,y) end,
  piles={{reflrust, function(x,y) return (L(x,y) + R(x,y)) * (1 - B(x,y)) * (0.8 + 0.4*nv:at01(x,y)) end},
         {orangeleaf, function(x,y) return (L(x,y) + R(x,y)) * (1 - B(x,y)) * 0.35 * clamp((nv:at01(x+40,y) - 0.5)*3, 0, 1) end},
         {leafshade, function(x,y) return (L(x,y) + R(x,y)) * 0.3 end},
         {glow, function(x,y) return Wd(x,y) * (0.9 - 0.6*clamp(math.abs(x - 500)/140, 0, 1)) end},
         {amber, function(x,y) return Wd(x,y) * 0.7 end},
         {haze, function(x,y) return Wd(x,y) * 0.3 + B(x,y) * 0.7 end},
         {birch, function(x,y) return B(x,y) * 0.4 end},
         {waterdark, function(x,y) return clamp(1 - L(x,y) - R(x,y) - Wd(x,y) - B(x,y), 0, 1) * 0.8 + 0.1 end},
         {brushdark, function(x,y) return clamp(1 - L(x,y) - R(x,y) - Wd(x,y), 0, 1) * 0.5 end}}})

--@ chunk 188
local pz = below({{-10,1000},{1010,1000}}) - front_all
blend(pz:soften(20), {angle=math.pi/2})
blend(pz:soften(20), {angle=math.pi/2 + 0.03})

--@ chunk 189
local band = (below({{-10,960},{1010,960}}) * above({{-10,1090},{1010,1090}})) - front_all
blend(band:soften(25), {angle=math.pi/2})
blend(band:soften(25), {angle=math.pi/2 - 0.04})
blend(band:soften(25), {angle=math.pi/2 + 0.04})

--@ chunk 190
local WL = 906
local nz = noise{seed=3021, period=40, octaves=2}
local zone = (below({{-10,WL},{1010,WL}}) * above({{-10,1010},{1010,1010}})) - front_all - foam_m:shrink(2)
zone = zone * mask(function(x, y) return clamp((1010 - y)/30, 0, 1) end)
local function C(x,y) return columnM:at(x,y) end
work(zone, {hand="body", tool={kind="flat", width=10, stiffness=0.5}, length={20,50}, coverage=2.8, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.03*nz(x,y) end,
  piles={{lent, function(x,y) return (1 - C(x,y)) * 0.8 end},
         {waterdark, function(x,y) return (1 - C(x,y)) * 0.8 + C(x,y)*0.2 end},
         {mossdeep, function(x,y) return (1 - C(x,y)) * 0.25 * clamp((nz:at01(x,y) - 0.5)*3, 0, 1) end},
         {haze, function(x,y) return C(x,y) * 0.8 end},
         {birch, function(x,y) return C(x,y) * 0.35 * clamp(1 - (y - WL)/80, 0, 1) end}}})
blend((below({{-10,910},{1010,910}}) * above({{-10,1060},{1010,1060}}) - front_all):soften(15), {angle=math.pi/2})

--@ chunk 191
local band = (below({{-10,975},{1010,975}}) * above({{-10,1060},{1010,1060}})) - front_all
for _, a in ipairs({math.pi/2, math.pi/2 + 0.05, math.pi/2 - 0.05, 1.3, 1.85}) do blend(band:soften(25), {angle=a}) end
local colEdge = ((columnM:grow(10) - columnM:shrink(14)) * below({{-10,912},{1010,912}}) * above({{-10,1080},{1010,1080}})) - front_all
blend(colEdge:soften(6), {angle=math.pi/2})
blend(colEdge:soften(6), {angle=0.0})

--@ chunk 192
-- ripple lines: alternating dark and light thin horizontals, denser near the far edge
local fb = brush{kind="flat", width=3, stiffness=0.5}
local rb = brush{kind="round", width=2.5, point=0.6, stiffness=0.5}
local ys = uneven(46, 914, 1245, 0.5, 0.5, 3031)
for i, y in ipairs(ys) do
  local sc = 0.5 + (y - 906) / 300
  local nseg = 2 + (i % 3)
  for s = 1, nseg do
    local x0 = rand(-10, 1000)
    local len = rand(20, 90) * sc
    local inCol = columnM:at(x0, y) > 0.5 or wedgeM:at(x0, y) > 0.5
    if front_all:at(x0, y) < 0.3 then
      if inCol or (i + s) % 3 == 0 then
        fb:reload(waterdark, 0.45)
        fb:stroke({{x0 - len/2, y}, {x0, y + rand(-0.5, 0.5)}, {x0 + len/2, y}}, {pressure={0.3, 0.12}, orient="across"})
      else
        rb:reload((y < 1060) and haze or glowk_pile or amber, 0.4)
        rb:gesture({{x0 - len/2, y, 0.05}, {x0, y + rand(-0.4, 0.4), 0.4}, {x0 + len/2, y, 0.05}}, {wobble=0.5})
      end
    end
  end
end
blend((below({{-10,912},{1010,912}}) - front_all), {angle=0.0})

--@ chunk 193
local pz = below({{-10,912},{1010,912}}) - front_all
blend(pz, {angle=math.pi/2})
-- crisp ripple accents after
local rb = brush{kind="round", width=2.5, point=0.6, stiffness=0.5}
local fb = brush{kind="flat", width=3, stiffness=0.5}
local ys = uneven(30, 930, 1240, 0.5, 0.5, 3041)
for i, y in ipairs(ys) do
  local sc = 0.5 + (y - 906) / 300
  for s = 1, 2 do
    local x0 = rand(0, 1000)
    local len = rand(25, 80) * sc
    if front_all:at(x0, y) < 0.3 then
      if columnM:at(x0, y) > 0.4 or wedgeM:at(x0, y) > 0.4 then
        fb:reload(waterdark, 0.5)
        fb:stroke({{x0 - len/2, y}, {x0, y + rand(-0.5, 0.5)}, {x0 + len/2, y}}, {pressure={0.35, 0.15}, orient="across"})
      else
        rb:reload((math.abs(x0 - 485) < 260) and glow or haze, 0.45)
        rb:gesture({{x0 - len/2, y, 0.05}, {x0, y + rand(-0.4, 0.4), 0.45}, {x0 + len/2, y, 0.05}}, {wobble=0.5})
      end
    end
  end
end

--@ chunk 194
local pz = below({{-10,912},{1010,912}}) - front_all
blend(pz, {angle=0.0})
blend(pz, {angle=0.02})

--@ chunk 195
local WL = 908
local fb = brush{kind="flat", width=16, stiffness=0.6}
-- 1. dark reflections of the boulders, directly below them
for i = 5, 9 do
  local b = BLD[i]
  local cx, rx = b.c[1], b.c[3]
  local x = cx - rx * 0.85
  while x < cx + rx * 0.85 do
    if math.abs(x - 485) > 115 then
      fb:reload(rand() < 0.5 and lent or waterdark, 0.8)
      local len = rand(70, 130) * (1 - ((x - cx)/rx)^2 * 0.5)
      fb:stroke({{x, WL + 2}, {x + rand(-1,1), WL + len}}, {pressure={0.6, 0.15}, orient="across"})
    end
    x = x + rand(10, 16)
  end
end
-- 2. the falls column: pale gray-white, narrowing downward
for i = 1, 16 do
  fb:reload(i % 3 == 0 and birch or haze, 0.7)
  local t = (i - 0.5) / 16
  local x = lerp(372, 600, t) + rand(-3, 3)
  local len = 110 + 60 * (1 - math.abs(t - 0.5) * 2) + rand(-20, 20)
  local xe = lerp(x, 488, 0.35)
  fb:stroke({{x, WL + 4}, {lerp(x, xe, 0.5), WL + len*0.5}, {xe, WL + len}}, {pressure={0.55, 0.1}, orient="across"})
end
-- 3. birch reflections
local fs = brush{kind="flat", width=12, stiffness=0.6}
for _, bx in ipairs({{804, 980, 1250, 12}, {914, 990, 1250, 9}}) do
  local s = brush{kind="flat", width=bx[4], stiffness=0.6}
  local y = bx[2]
  while y < bx[3] do
    s:reload(birch, 0.6); s:load(haze, 0.3)
    local l = rand(30, 60)
    s:stroke({{bx[1] + rand(-2,2), y}, {bx[1] + rand(-3,3), y + l}}, {pressure={0.5, 0.25}, orient="across"})
    y = y + l + rand(4, 14)
  end
end

--@ chunk 196
local pz = (below({{-10,911},{1010,911}}) - front_all):soften(3)
blend(pz, {angle=math.pi/2})
blend(pz, {angle=math.pi/2 + 0.12})
blend(pz, {angle=math.pi/2 - 0.12})

--@ chunk 197
local WL = 908
local nz = noise{seed=3101, period=30, octaves=2}
-- reflections of the boulders: a dark band hugging the waterline, its lower edge ragged, absent under the falls
reflDark = mask(function(x, y)
  if y < WL - 2 then return 0 end
  local dx = math.abs(x - 486)
  if dx < 125 then return 0 end
  local len = 40 + 30 * nz:at01(x, 0) + 20 * nz(x * 3, 7)
  local fade = clamp((dx - 125) / 25, 0, 1)
  return clamp((WL + len * fade - y) / 12, 0, 1)
end) - front_all
work(reflDark, {hand="body", tool={kind="flat", width=8, stiffness=0.6}, length={20,50}, coverage=3, fill=true, clip=true, load=1.0,
  angle=math.pi/2, piles={{lent, 0.7}, {waterdark, 1}, {mossdeep, function(x,y) return 0.3*nz:at01(x, y) end}, {brushdark, 0.4}}})
blend((reflDark:grow(10)):soften(6), {angle=math.pi/2})

--@ chunk 198
palette{scrape={reflrust}}
fallwhite = pile{{"lead white",8},{"yellow ochre",0.25},{"cobalt blue",0.08}, name="fallwhite"}
for _, p in ipairs({{420,720},{470,760},{500,820},{430,860},{560,780},{400,700}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 199
local fan = brush{kind="fan", width=12, stiffness=0.5}
for i = 1, 10 do
  if i % 2 == 1 then fan:reload(i % 4 == 1 and glow or fallwhite, 0.35) end
  local t = clamp(math.abs(randn(0.3, 0.25)), 0.03, 0.97)
  local y0 = 686
  local yend = y0 + rand(60, 170)
  local pts = {}
  for k = 0, 4 do local y = lerp(y0, yend, k/4); pts[#pts+1] = {fx(FL, t, y) + rand(-1, 1), y} end
  fan:stroke(pts, {pressure={0.5, 0.05}, orient="across", ramps={0.02, 0.6}})
end

--@ chunk 200
local cur = (fallsM * below(function(x) return 684 end) * above(function(x) return 880 end)):soften(3)
blend(cur, {angle=math.pi/2})

--@ chunk 201
local cur = fallsM * mask(function(x, y) return clamp((y - 668)/8, 0, 1) * clamp((890 - y)/20, 0, 1) end)
local nz = noise{seed=3201, period=14, octaves=2}
local streak = cur * mask(function(x, y) return clamp((nz:at01(x * 1.0, y * 0.08) - 0.38) * 4, 0, 1) end)
work(streak, {hand="body", tool={kind="flat", width=7, stiffness=0.5}, length={40,110}, coverage=1.6, load=0.8,
  angle=math.pi/2, angle_jitter=0.03,
  piles={{fallwhite, 1}, {rim_warm, function(x,y) return 0.35*clamp(1 - (y - 668)/70, 0, 1) end},
         {haze, function(x,y) return 0.4*clamp((y - 740)/100, 0, 1) end}}})
blend(cur:soften(6), {angle=math.pi/2})

--@ chunk 202
local function brinkY(x) return 664 - 2.5 * (1 - ((x - 470)/90)^2) end
-- 1. above the brink: misty bank tone back over the stubs, clipped
local above_b = mask(function(x, y)
  if x < 372 or x > 600 then return 0 end
  return (y > 628 and y < brinkY(x) - 6) and 1 or 0
end):soften(1.5) - headL2 - headR2
work(above_b, {hand="body", tool={kind="flat", width=6}, length={14,30}, coverage=3.5, fill=true, clip=true, angle=0.0, load=1.0,
  piles={{haze, 1}, {amber, 0.55}, {deeprust, 0.25}}})
-- 2. the glassy strip
local strip = mask(function(x, y)
  if x < 386 or x > 582 then return 0 end
  if x > 530 and x < 550 then return 0 end
  local b = brinkY(x)
  return (y > b - 7 and y < b + 1) and 1 or 0
end):soften(1.2)
work(strip, {hand="body", tool={kind="flat", width=4}, length={12,30}, coverage=3, fill=true, clip=true, angle=0.0, load=1.0,
  piles={{glow, 1}, {haze, 0.3}}})
local rb = brush{kind="round", width=2.5, point=0.5}
rb:reload(fallwhite, 0.7)
rb:gesture({{388, brinkY(388), 0.15}, {420, brinkY(420), 0.5}, {470, brinkY(470), 0.65}, {505, brinkY(505), 0.5}, {528, brinkY(528), 0.15}}, {wobble=0.4})
-- 3. vertical blend in the curtain to merge the streaks (clip to the curtain)
local cur = fallsM * mask(function(x, y) return clamp((y - 672)/6, 0, 1) * clamp((885 - y)/10, 0, 1) end)
blend(cur, {angle=math.pi/2})

--@ chunk 203
palette{scrape={orangeleaf}}
foamsh = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.35},{"yellow ochre",0.1}, name="foamsh"}
local nf = noise{seed=3301, period=16, octaves=2}
local function ftop(x) return 880 + 8 * nf(x, 0) + 0.0012 * (x - 486)^2 end
foam2 = mask(function(x, y)
  if x < 340 or x > 632 then return 0 end
  local t = ftop(x)
  local b = 934 + 8 * nf(x, 40) - 0.0009 * (x - 486)^2
  local side = clamp((math.min(x - 340, 632 - x)) / 25, 0, 1)
  return (y > t and y < b) and side or 0
end):soften(3) - front_all
work(foam2, {hand="body", tool={kind="filbert", width=8, stiffness=0.4}, length={8,18}, coverage=3, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.3*nf(x*2, y*2) end,
  piles={{foamsh, function(x,y) return 0.4 + clamp((y - ftop(x) - 10)/25, 0, 1) end},
         {fallwhite, function(x,y) return clamp(1 - (y - ftop(x))/20, 0, 1) * 1.3 end},
         {glow, function(x,y) return 0.3*clamp(1 - (y - ftop(x))/10, 0, 1) end}}})
local rb = brush{kind="round", width=7, stiffness=0.4, lay=2}
for i = 1, 30 do
  if i % 4 == 1 then rb:reload(i % 8 == 1 and glow or fallwhite, 0.8) end
  local x = rand(352, 620)
  local y = ftop(x) + rand(-3, 4)
  local w = rand(6, 13)
  rb:stroke({{x - w, y + 3}, {x, y - rand(1, 4)}, {x + w, y + 3}}, {pressure={0.5, 0.3}})
end
blend(foam2:grow(4), {angle=0.0})

--@ chunk 204
-- 1. dissolve the rectangle above the brink and the yellow lip into their neighbours
local zoneA = rect(360, 610, 250, 50):soften(14) - headL2 - headR2
blend(zoneA, {angle=math.pi/2})
blend(zoneA, {angle=0.0})
local lipz = rect(380, 652, 210, 26):soften(5)
blend(lipz, {angle=math.pi/2})
-- 2. foam: soften its outline into the pool and dark rocks
local fz = foam2:grow(14):soften(12) - front_all
blend(fz, {angle=0.0})
blend(fz, {angle=math.pi/2})
blend(fz, {angle=0.4})

--@ chunk 205
-- dark gaps between strands, and shadowed lower curtain
local rd = brush{kind="round", width=5, point=0.5, stiffness=0.6}
local gaps = {{0.18, 700, 860}, {0.36, 690, 800}, {0.52, 720, 870}, {0.7, 700, 835}, {0.86, 730, 880}, {0.08, 760, 880}, {0.6, 800, 880}}
for i, g in ipairs(gaps) do
  rd:reload(i % 2 == 0 and waterdark or foamsh, 0.4)
  local pts = {}
  for k = 0, 4 do
    local y = lerp(g[2], g[3], k/4)
    local pr = 0.55 * math.sin(math.pi * (0.1 + 0.8 * k/4))
    pts[#pts+1] = {fx(FL, g[1], y) + rand(-1, 1), y, pr}
  end
  rd:gesture(pts, {wobble=0.6})
end
-- cooler shadow toward the bottom of the curtain
local low = fallsM * mask(function(x, y) return clamp((y - 790)/50, 0, 1) * clamp((885 - y)/10, 0, 1) end)
work(low, {hand="glaze", pile=foamsh, coverage=0.7})
local cur = fallsM * mask(function(x, y) return clamp((y - 674)/6, 0, 1) * clamp((885 - y)/10, 0, 1) end)
blend(cur, {angle=math.pi/2})

--@ chunk 206
local k = knife{width=14}
for x = 380, 600, 7 do
  local top = 668
  k:scrape({{x, top}, {x, 780}, {x, 940}}, {pressure=1}); k:wipe()
end
for _, p in ipairs({{420,720},{470,760},{500,820},{430,860},{560,780},{486,920}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 207
local jz = (rect(338, 668, 300, 236) - fallsM - front_all) * mask(function(x, y)
  local l, r = fx(FL, 0, math.max(y, FL.y0)), fx(FR, 1, math.max(y, FR.y0))
  return ((x < l and x > l - 40) or (x > r and x < r + 40)) and 1 or 0
end)
work(jz, {hand="body", tool={kind="filbert", width=7, stiffness=0.6}, length={14,30}, coverage=4, fill=true, clip=true, load=1.0,
  angle=1.5, piles={{lent, 1}, {rock, 0.7}}})
local ns = noise{seed=3401, period=18, octaves=3, stretch={math.pi/2, 9}}
local ns2 = noise{seed=3402, period=40, octaves=2, stretch={math.pi/2, 5}}
local function rib(x, y) local yy = math.max(y, FL.y0); return (x > fx(FL, 1, yy) - 1 and x < fx(FR, 0, yy) + 1) and 1 or 0 end
local function s(x, y) return clamp(0.55*ns:at01(x, y) + 0.45*ns2:at01(x, y), 0, 1) end
local function vy(y) return clamp((y - 668) / 210, 0, 1) end
curtainM = fallsM * mask(function(x, y) return clamp((y - 669)/3, 0, 1) * clamp((888 - y)/4, 0, 1) end)
work(curtainM, {hand="body", tool={kind="flat", width=6, stiffness=0.5}, length={30,80}, coverage=4, fill=true, clip=true, load=1.0,
  angle=math.pi/2,
  piles={{lent, function(x,y) return rib(x,y) * 3 + (1 - rib(x,y)) * clamp((0.3 - s(x,y)) * 4, 0, 1) * (0.3 + 0.7*vy(y)) end},
         {waterdark, function(x,y) return (1 - rib(x,y)) * math.exp(-((s(x,y) - 0.36)/0.08)^2) * (0.4 + 0.6*vy(y)) end},
         {foamsh, function(x,y) return (1 - rib(x,y)) * math.exp(-((s(x,y) - 0.5)/0.12)^2) * (0.5 + vy(y)) end},
         {fallwhite, function(x,y) return (1 - rib(x,y)) * clamp((s(x,y) - 0.5) * 4, 0, 1) * (1.2 - 0.5*vy(y)) end},
         {glow, function(x,y) return (1 - rib(x,y)) * clamp((s(x,y) - 0.55) * 3, 0, 1) * clamp(1 - vy(y)*3, 0, 1) end}}})

--@ chunk 208
blend(curtainM, {angle=math.pi/2})
blend(curtainM, {angle=math.pi/2})

--@ chunk 209
palette{scrape={nearbank}}
local fan = brush{kind="fan", width=14, stiffness=0.5}
local n = 0
for i = 1, 30 do
  n = n + 1
  if n % 2 == 1 then fan:reload((i % 5 == 0) and glow or fallwhite, rand(0.25, 0.38)) end
  local F = (i % 6 == 0) and FR or FL
  local t = clamp(math.abs(randn(0.38, 0.32)), 0.02, 0.98)
  local y0 = F.y0 + 8 + rand(0, 10)
  local yend = y0 + rand(70, 200)
  local pts = {}
  for k = 0, 4 do local y = math.min(lerp(y0, yend, k/4), 884); pts[#pts+1] = {fx(F, t, y) + rand(-1, 1), y} end
  fan:stroke(pts, {pressure={rand(0.4, 0.55), 0.05}, orient="across", ramps={0.02, 0.6}, clip=curtainM:grow(2)})
end
local rd = brush{kind="round", width=3.5, point=0.7}
for i = 1, 12 do
  rd:reload(fallwhite, 0.6)
  local F = (i % 5 == 0) and FR or FL
  local t = clamp(math.abs(randn(0.35, 0.3)), 0.03, 0.97)
  local y0 = F.y0 + 8
  local ylen = rand(40, 140)
  rd:gesture({{fx(F, t, y0), y0, 0.3}, {fx(F, t, y0 + ylen*0.3) + rand(-1,1), y0 + ylen*0.3, 0.6}, {fx(F, t, y0 + ylen) + rand(-2,2), y0 + ylen, 0.0}}, {wobble=0.8, clip=curtainM:grow(2)})
end

--@ chunk 210
-- 1. soften the outer edges of the jamb bands into the rocks
local outer = mask(function(x, y)
  if y < 668 or y > 900 then return 0 end
  local l, r = fx(FL, 0, math.max(y, FL.y0)), fx(FR, 1, math.max(y, FR.y0))
  local dl = math.abs(x - (l - 40)); local dr = math.abs(x - (r + 40))
  return clamp(1 - math.min(dl, dr) / 14, 0, 1)
end) - front_all
blend(outer, {angle=0.3})
blend(outer, {angle=2.8})
-- 2. ragged curtain edges: dark tongues in, white spray out
local rd = brush{kind="round", width=5, point=0.5, stiffness=0.6}
local rs = brush{kind="round", width=3, point=0.7, stiffness=0.5}
for i = 1, 22 do
  local left = (i % 2 == 0)
  local F = left and FL or FR
  local y0 = rand(690, 870)
  local xe = fx(F, left and 0 or 1, y0)
  local dir = left and 1 or -1
  if i % 3 ~= 0 then
    rd:reload(lent, 0.5)
    rd:gesture({{xe - dir*3, y0, 0.6}, {xe + dir*rand(2,6), y0 + rand(8, 18), 0.4}, {xe + dir*rand(1,4), y0 + rand(25, 50), 0.0}}, {wobble=0.6})
  else
    rs:reload(fallwhite, 0.55)
    rs:gesture({{xe + dir*2, y0, 0.3}, {xe - dir*rand(3,8), y0 + rand(15, 25), 0.5}, {xe - dir*rand(6,14), y0 + rand(35, 60), 0.0}}, {wobble=0.8})
  end
end
-- 3. soften the yellow in the upper curtain
local up = curtainM * mask(function(x, y) return clamp((800 - y)/40, 0, 1) end)
blend(up, {angle=math.pi/2})

--@ chunk 211
-- dark gaps as tapered wedges in curtain coordinates (t across, y down)
local function wedge(t, y0, y1, w0, w1, seed)
  local pts = {}
  local n = 6
  local nn = noise{seed=seed, period=25, octaves=2}
  for k = 0, n do
    local y = lerp(y0, y1, k/n)
    local w = lerp(w0, w1, k/n)
    pts[#pts+1] = {fx(FL, t, y) - w/2 + 2*nn(y, 0), y}
  end
  for k = n, 0, -1 do
    local y = lerp(y0, y1, k/n)
    local w = lerp(w0, w1, k/n)
    pts[#pts+1] = {fx(FL, t, y) + w/2 + 2*nn(y, 9), y}
  end
  return poly(pts, true)
end
gapsM = wedge(0.27, 735, 886, 1, 13, 3501) + wedge(0.47, 770, 886, 1, 9, 3502) + wedge(0.66, 715, 886, 1, 16, 3503)
      + wedge(0.86, 780, 886, 1, 8, 3504) + wedge(0.08, 800, 886, 1, 7, 3505)
gapsM = gapsM * curtainM
work(gapsM, {hand="body", tool={kind="flat", width=4, stiffness=0.6}, length={20,50}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=math.pi/2, piles={{lent, 0.6}, {waterdark, 1}, {foamsh, 0.25}}})
-- darker, cooler lower curtain (shadowed by spray)
local low = curtainM * mask(function(x, y) return clamp((y - 800)/60, 0, 1) end) - gapsM
work(low, {hand="glaze", pile=waterdark, coverage=0.6})
blend(curtainM, {angle=math.pi/2})

--@ chunk 212
local low = curtainM * mask(function(x, y) return clamp((y - 760)/30, 0, 1) end)
blend(low, {angle=math.pi/2})
blend(low, {angle=math.pi/2})
blend(low, {angle=math.pi/2})

--@ chunk 213
local nz = noise{seed=3601, period=13, octaves=2}
local nz2 = noise{seed=3602, period=60, octaves=2}
local streak = curtainM * mask(function(x, y)
  local v = nz:at01(x * 1.0, y * 0.07) * 0.7 + nz2:at01(x, y*0.2) * 0.3
  return clamp((v - 0.42) * 4, 0, 1)
end) - gapsM:grow(1)
work(streak, {hand="body", tool={kind="flat", width=6, stiffness=0.5}, length={40,110}, coverage=1.8, clip=true, load=0.85,
  angle=math.pi/2, angle_jitter=0.02,
  piles={{fallwhite, 1}, {glow, function(x,y) return 0.5*clamp(1 - (y - 668)/60, 0, 1) end},
         {foamsh, function(x,y) return 0.5*clamp((y - 780)/80, 0, 1) end}}})
blend(curtainM, {angle=math.pi/2})

--@ chunk 214
local fz = (rect(352, 664, 276, 280) - front_all):soften(3)
for pass = 1, 2 do
  local r = rag{width=40}
  r:dip(0.9)
  r:wipe(fz, {pressure=0.85, angle=math.pi/2, passes=2, refold=0.5})
  r = rag{width=40}
  r:dip(0.9)
  r:wipe(fz, {pressure=0.85, angle=0, passes=2, refold=0.5})
end
print(drying(470, 760))

--@ chunk 215
local nz = noise{seed=3701, period=30, octaves=3}
local face = (rect(350, 662, 280, 246) - front_all):soften(2)
work(face, {hand="body", tool={kind="filbert", width=9, stiffness=0.6}, length={14,34}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.45 + 0.35*nz(x,y) end,
  piles={{lent, 1}, {rock, 0.8}, {brushdark, function(x,y) return 0.2 + 0.3*nz:at01(x,y) end},
         {mossdeep, function(x,y) return 0.25*clamp((nz:at01(x+40,y) - 0.6)*3, 0, 1) end}}})
local wl = (rect(340, 904, 300, 45) - front_all)
work(wl, {hand="body", tool={kind="flat", width=10, stiffness=0.5}, length={20,40}, coverage=4, fill=true, clip=true, load=1.0,
  angle=math.pi/2, piles={{waterdark, 1}, {lent, 0.5}, {haze, 0.15}}})
print(drying(470, 760))

--@ chunk 216
strands = {
  {pts={{386,661},{410,659},{434,661},{438,700},{442,760},{446,830},{448,902},{366,902},{372,830},{378,760},{382,700}}, seed=3801, top=660},
  {pts={{444,660},{476,658},{508,661},{511,700},{516,760},{521,830},{524,902},{430,902},{434,830},{438,760},{441,700}}, seed=3802, top=659},
  {pts={{521,663},{529,662},{535,664},{535,720},{537,790},{540,860},{542,902},{524,902},{524,860},{522,790},{520,720}}, seed=3803, top=663},
  {pts={{549,664},{568,662},{587,665},{589,710},{594,780},{598,850},{604,902},{548,902},{546,850},{545,780},{546,710}}, seed=3804, top=663},
}
strandM = {}
local all = nil
for i, s in ipairs(strands) do
  strandM[i] = outline{pts=s.pts, char="soft", seed=s.seed, amount=0.35, lobe=8}:mask() - front_all
  all = all and (all + strandM[i]) or strandM[i]
end
strandsAll = all
print(all:area())

--@ chunk 217
strands = {
  {pts={{386,661},{408,659},{430,661},{433,700},{435,760},{437,830},{439,902},{366,902},{372,830},{378,760},{382,700}}, seed=3801},
  {pts={{446,660},{477,658},{508,661},{511,700},{516,760},{521,830},{524,902},{455,902},{453,830},{451,760},{449,700}}, seed=3802},
  {pts={{521,663},{529,662},{535,664},{535,720},{537,790},{540,860},{542,902},{526,902},{525,860},{523,790},{521,720}}, seed=3803},
  {pts={{550,664},{568,662},{587,665},{589,710},{594,780},{598,850},{604,902},{550,902},{548,850},{547,780},{548,710}}, seed=3804},
}
strandM = {}
local all = nil
for i, s in ipairs(strands) do
  strandM[i] = outline{pts=s.pts, char="soft", seed=s.seed, amount=0.35, lobe=8}:mask() - front_all
  all = all and (all + strandM[i]) or strandM[i]
end
strandsAll = all
local ns = noise{seed=3811, period=10, octaves=2, stretch={math.pi/2, 10}}
local ns2 = noise{seed=3812, period=30, octaves=2, stretch={math.pi/2, 6}}
for i, s in ipairs(strands) do
  local m = strandM[i]
  local top = 661
  local function v(x, y) return clamp((y - top) / (902 - top), 0, 1) end
  local function st(x, y) return 0.6*ns:at01(x, y) + 0.4*ns2:at01(x, y) end
  work(m, {hand="body", tool={kind="flat", width=5, stiffness=0.5}, length={25,70}, coverage=4, fill=true, clip=true, load=1.0,
    angle=math.pi/2,
    piles={{glow, function(x,y) return clamp(1 - v(x,y)/0.06, 0, 1) * 1.5 end},
           {fallwhite, function(x,y) local vv = v(x,y); return clamp(1 - vv/0.04, 0, 1) * 0.6 + clamp((vv - 0.12)/0.12, 0, 1) * clamp((st(x,y) - 0.35)*3, 0, 1) * 1.3 end},
           {haze, function(x,y) local vv = v(x,y); return math.exp(-((vv - 0.1)/0.06)^2) * 0.9 end},
           {waterdark, function(x,y) local vv = v(x,y); return math.exp(-((vv - 0.13)/0.06)^2) * 0.5 + clamp((0.35 - st(x,y))*3, 0, 1) * clamp((vv - 0.15)/0.1, 0, 1) * 0.9 end},
           {foamsh, function(x,y) local vv = v(x,y); return clamp((vv - 0.15)/0.2, 0, 1) * (0.35 + 0.6*clamp((vv - 0.6)/0.4, 0, 1)) end}}})
end

--@ chunk 218
for i = 1, 4 do blend(strandM[i], {angle=math.pi/2}) end
-- dark threads inside the wider strands
local rd = brush{kind="round", width=4, point=0.5, stiffness=0.6}
local threads = {{1, 0.35, 720, 880}, {1, 0.7, 760, 900}, {2, 0.3, 700, 860}, {2, 0.62, 740, 900}, {2, 0.85, 780, 880}, {4, 0.5, 730, 890}}
for _, t in ipairs(threads) do
  local s = strands[t[1]]
  local m = strandM[t[1]]
  rd:reload(waterdark, 0.45)
  local pts = {}
  for k = 0, 4 do
    local y = lerp(t[3], t[4], k/4)
    -- find left/right of the strand at y
    local l, r = 1000, 0
    for x = 340, 640, 2 do if m:at(x, y) > 0.5 then l = math.min(l, x); r = math.max(r, x) end end
    pts[#pts+1] = {lerp(l, r, t[2]) + rand(-1,1), y, 0.5 * math.sin(math.pi * (0.1 + 0.8*k/4))}
  end
  rd:gesture(pts, {wobble=0.5, clip=m})
end

--@ chunk 219
local sm = strandsAll:grow(2)
for pass = 1, 2 do
  local r = rag{width=30}
  r:dip(0.9)
  r:wipe(sm, {pressure=0.85, angle=math.pi/2, passes=2, refold=0.5})
  r = rag{width=30}
  r:dip(0.9)
  r:wipe(sm, {pressure=0.85, angle=0, passes=2, refold=0.5})
end
local nz = noise{seed=3901, period=30, octaves=3}
work(sm, {hand="body", tool={kind="filbert", width=7, stiffness=0.6}, length={14,34}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.5 + 0.2*nz(x,y) end,
  piles={{lent, 0.8}, {rock, 0.8}, {waterdark, 0.6}}})
print(drying(470, 760))

--@ chunk 220
print(palette())

--@ chunk 221
palette{scrape={mossdark, leafshade}}
thinwhite = pile{{"lead white",8},{"yellow ochre",0.2},{"cobalt blue",0.1}, thinner=0.5, name="thinwhite"}
lipglass = pile{{"lead white",4},{"chrome yellow",0.5},{"yellow ochre",0.6},{"raw umber",0.25}, name="lipglass"}
local function edges_at(m, y)
  local l, r = 1000, 0
  for x = 340, 640, 1.5 do if m:at(x, y) > 0.5 then if x < l then l = x end; if x > r then r = x end end end
  return l, r
end
sEdges = {}
for i = 1, 4 do
  sEdges[i] = {}
  for y = 656, 906, 4 do local l, r = edges_at(strandM[i], y); sEdges[i][#sEdges[i]+1] = {y, l, r} end
end
function sx(i, t, y)
  local E = sEdges[i]
  local k = clamp(math.floor((y - 656) / 4) + 1, 1, #E)
  local e = E[k]
  if e[3] < e[2] then e = E[math.min(k + 2, #E)] end
  return lerp(e[2], e[3], t)
end
print(sx(1, 0, 700), sx(1, 1, 700), sx(2, 0, 800), sx(2, 1, 800), sx(4, 0.5, 880))

--@ chunk 222
-- Recipe F per strand, clipped
local widths = {}
for i = 1, 4 do
  local m = strandM[i]
  local clipm = m:grow(1)
  -- 1. lip glass band
  local lipm = m * mask(function(x, y) return (y < 674) and 1 or 0 end)
  work(lipm, {hand="body", tool={kind="flat", width=5}, length={8,18}, angle=0.05, coverage=3, fill=true, clip=true, load=1.0,
    piles={{lipglass, 1}, {glow, 0.5}}})
  -- 2. thin veil, 3 passes
  local fb = brush{kind="flat", width=8, stiffness=0.5}
  local n = 0
  for pass = 1, 3 do
    for t = 0.05, 0.95, 0.14 do
      n = n + 1
      if n % 2 == 1 then fb:reload(thinwhite, 0.6) end
      local tt = t + rand(-0.04, 0.04)
      local y0 = 668 + rand(0, 6)
      local yend = rand(780, 902)
      local pts = {}
      for k = 0, 4 do local y = lerp(y0, yend, k/4); pts[#pts+1] = {sx(i, tt, y) + rand(-1, 1), y} end
      fb:stroke(pts, {pressure={0.5, 0.2}, orient="across", clip=clipm})
    end
  end
  -- 3. fan drags, concentrated by noise
  local fan = brush{kind="fan", width=(i == 3) and 8 or 14, stiffness=0.5}
  local ndr = (i == 3) and 4 or ((i == 4) and 8 or 11)
  for k = 1, ndr do
    if k % 3 == 1 then fan:reload((k % 4 == 0) and foamsh or fallwhite, 0.3) end
    local tt = clamp(math.abs(randn(0.5, 0.3)), 0.05, 0.95)
    local y0 = 670 + rand(0, 6)
    local yend = y0 + rand(110, 230)
    local pts = {}
    for j = 0, 4 do local y = math.min(lerp(y0, yend, j/4), 902); pts[#pts+1] = {sx(i, tt, y) + rand(-1, 1), y} end
    fan:stroke(pts, {pressure={0.55, 0.1}, orient="across", ramps={0.02, 0.6}, clip=clipm})
  end
  -- 4. one vertical blend
  blend(m * below(function(x) return 672 end), {angle=math.pi/2})
end

--@ chunk 223
for i = 1, 4 do
  local m = strandM[i]
  local clipm = m:grow(1)
  local fan = brush{kind="fan", width=(i == 3) and 7 or 11, stiffness=0.5}
  local nd = (i == 3) and 3 or ((i == 4) and 6 or 9)
  for k = 1, nd do
    if k % 2 == 1 then fan:reload((k % 3 == 0) and glow or fallwhite, 0.35) end
    local tt = clamp(math.abs(randn(0.42, 0.28)), 0.05, 0.95)
    local y0 = 666
    local yend = y0 + rand(50, 170)
    local pts = {}
    for j = 0, 4 do local y = lerp(y0, yend, j/4); pts[#pts+1] = {sx(i, tt, y) + rand(-1, 1), y} end
    fan:stroke(pts, {pressure={0.45, 0.05}, orient="across", ramps={0.02, 0.7}, clip=clipm})
  end
  local rd = brush{kind="round", width=3, point=0.7}
  for k = 1, ((i == 3) and 1 or 4) do
    rd:reload(fallwhite, 0.6)
    local tt = rand(0.1, 0.9)
    local ylen = rand(50, 160)
    rd:gesture({{sx(i, tt, 668), 668, 0.3}, {sx(i, tt, 668 + ylen*0.3) + rand(-1,1), 668 + ylen*0.3, 0.6}, {sx(i, tt, 668 + ylen) + rand(-2,2), 668 + ylen, 0.0}}, {wobble=0.8, clip=clipm})
  end
  -- fuse the lip into the water below
  blend(m * above(function(x) return 700 end), {angle=math.pi/2})
end

--@ chunk 224
for i = 1, 4 do
  local m = strandM[i]
  local band = m * mask(function(x, y) return clamp(1 - math.abs(y - 702) / 22, 0, 1) end)
  blend(band, {angle=math.pi/2})
  blend(band, {angle=math.pi/2})
end
-- a few bright fan drags starting above 700 to stitch the seam
for i = 1, 4 do
  local clipm = strandM[i]:grow(1)
  local fan = brush{kind="fan", width=(i == 3) and 7 or 10, stiffness=0.5}
  for k = 1, ((i == 3) and 2 or 5) do
    if k % 2 == 1 then fan:reload(fallwhite, 0.3) end
    local tt = rand(0.08, 0.92)
    local y0 = rand(676, 690)
    local yend = y0 + rand(50, 110)
    local pts = {}
    for j = 0, 4 do local y = lerp(y0, yend, j/4); pts[#pts+1] = {sx(i, tt, y) + rand(-1, 1), y} end
    fan:stroke(pts, {pressure={0.4, 0.05}, orient="across", ramps={0.02, 0.7}, clip=clipm})
  end
end

--@ chunk 225
-- 1. pool under the falls: repaint the gray slab as reflection column (vertical strokes), clipped below the waterline
local slab = (rect(336, 906, 310, 50) - front_all)
local nz = noise{seed=4001, period=12, octaves=2, stretch={math.pi/2, 6}}
work(slab, {hand="body", tool={kind="flat", width=8, stiffness=0.5}, length={20,50}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=math.pi/2,
  piles={{haze, function(x,y) return columnM:at(x, y) * (0.6 + 0.6*nz:at01(x,y)) end},
         {foamsh, function(x,y) return columnM:at(x, y) * 0.6 end},
         {waterdark, function(x,y) return (1 - columnM:at(x,y)) + 0.4*clamp((0.45 - nz:at01(x,y))*3, 0, 1) end},
         {lent, function(x,y) return (1 - columnM:at(x,y)) * 0.6 end}}})
blend((rect(330, 900, 320, 120) - front_all):soften(10), {angle=math.pi/2})
print(drying(486, 930))

--@ chunk 226
-- 2. foam where the strands hit: separate churned heads under each strand, joined by lower white water
local nf = noise{seed=4011, period=14, octaves=3}
local heads = {{404, 26}, {487, 34}, {533, 10}, {577, 28}}
foam3 = mask(function(x, y)
  local v = 0
  for _, h in ipairs(heads) do
    local dx = (x - h[1]) / (h[2] * 1.25)
    local dy = (y - 902) / 20
    local d = dx*dx + dy*dy
    v = math.max(v, clamp((1 - d) * 3 + 0.8*nf(x, y), 0, 1))
  end
  -- low skirt joining them
  local sk = clamp((math.abs(x - 490) < 140) and 1 or 0, 0, 1) * clamp(1 - math.abs(y - 912)/7 + 0.5*nf(x*2, y), 0, 1)
  return math.max(v, sk)
end) - front_all
work(foam3, {hand="body", tool={kind="filbert", width=6, stiffness=0.4}, length={6,14}, coverage=3, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.4*nf(x*3, y*3) end,
  piles={{fallwhite, function(x,y) return clamp(1 - (y - 888)/30, 0.2, 1) * 1.3 end},
         {foamsh, function(x,y) return 0.4 + clamp((y - 900)/20, 0, 1) end},
         {glow, function(x,y) return 0.25*clamp(1 - (y - 885)/14, 0, 1) end}}})
-- bumpy lit tops
local rb = brush{kind="round", width=6, stiffness=0.4, lay=2}
for i = 1, 24 do
  if i % 4 == 1 then rb:reload(fallwhite, 0.8) end
  local h = heads[(i % 4) + 1]
  local x = h[1] + rand(-1, 1) * h[2]
  local y = 892 + rand(-6, 6)
  local w = rand(4, 9)
  rb:stroke({{x - w, y + 3}, {x, y - rand(1, 3)}, {x + w, y + 3}}, {pressure={0.5, 0.3}, clip=foam3:grow(3)})
end
blend(foam3:grow(3):soften(4), {angle=0.0})

--@ chunk 227
local fz = (foam3:grow(10)):soften(10) - front_all
blend(fz, {angle=math.pi/2})
blend(fz, {angle=0.3})
blend(fz, {angle=2.8})
-- water entering the foam: gray-white streaks from the strands down into the foam top
for i = 1, 4 do
  local clipm = (strandM[i]:grow(2) + foam3):grow(1)
  local fan = brush{kind="fan", width=(i == 3) and 7 or 11, stiffness=0.5}
  for k = 1, ((i == 3) and 2 or 5) do
    if k % 2 == 1 then fan:reload((k % 3 == 0) and foamsh or fallwhite, 0.3) end
    local tt = rand(0.08, 0.92)
    local y0 = rand(780, 830)
    local yend = rand(895, 912)
    local pts = {}
    for j = 0, 4 do local y = lerp(y0, yend, j/4); pts[#pts+1] = {sx(i, tt, math.min(y, 900)) + rand(-1, 1), y} end
    fan:stroke(pts, {pressure={0.35, 0.5}, orient="across", ramps={0.4, 0.1}, clip=clipm})
  end
end

--@ chunk 228
local low = (strandsAll * mask(function(x, y) return clamp((y - 770)/15, 0, 1) end)) + foam3
blend(low:soften(3), {angle=math.pi/2})
blend(low:soften(3), {angle=math.pi/2})
blend(low:soften(3), {angle=0.0})

--@ chunk 229
local seam = strandsAll * mask(function(x, y) return clamp(1 - math.abs(y - 772) / 26, 0, 1) end)
blend(seam, {angle=math.pi/2})
blend(seam, {angle=math.pi/2})
-- a few long pointed streaks crossing into the mist
local rd = brush{kind="round", width=3, point=0.7}
for i = 1, 4 do
  for k = 1, ((i == 3) and 1 or 3) do
    rd:reload((k % 2 == 0) and foamsh or fallwhite, 0.5)
    local tt = rand(0.1, 0.9)
    local y0 = rand(700, 740)
    local y1 = y0 + rand(80, 140)
    rd:gesture({{sx(i, tt, y0), y0, 0.15}, {sx(i, tt, (y0+y1)/2) + rand(-1,1), (y0+y1)/2, 0.5}, {sx(i, tt, y1) + rand(-2,2), y1, 0.0}}, {wobble=0.6, clip=strandM[i]:grow(1)})
  end
end

--@ chunk 230
-- lip: thin bright crest line, darker glassy band just below, small rocks notching the top
local rd = brush{kind="round", width=2.5, point=0.5}
for i = 1, 4 do
  local l, r = sx(i, 0.02, 664), sx(i, 0.98, 664)
  rd:reload(fallwhite, 0.6)
  rd:gesture({{l, 663, 0.1}, {(l+r)/2, 661.5, 0.6}, {r, 663, 0.1}}, {wobble=0.3, clip=strandM[i]:grow(2)})
end
local gb = brush{kind="flat", width=4, stiffness=0.5}
for i = 1, 4 do
  local l, r = sx(i, 0.05, 672), sx(i, 0.95, 672)
  gb:reload(waterdark, 0.25); gb:load(lipglass, 0.3)
  gb:stroke({{l, 674}, {(l+r)/2, 673}, {r, 674}}, {pressure={0.3, 0.3}, orient="across", clip=strandM[i]})
end
-- notches: little dark rock tips where the lip breaks
local nb = brush{kind="round", width=4, point=0.4, stiffness=0.6}
for _, p in ipairs({{424, 662}, {463, 661}, {498, 662}, {572, 664}}) do
  nb:reload(lent, 0.6)
  nb:gesture({{p[1] - 3, p[2] - 2, 0.6}, {p[1], p[2] + 3, 0.7}, {p[1] + 1, p[2] + 10, 0.1}}, {wobble=0.3})
end
blend(strandsAll * mask(function(x, y) return clamp(1 - math.abs(y - 676)/10, 0, 1) end), {angle=math.pi/2})

--@ chunk 231
local nz = noise{seed=4101, period=14, octaves=2}
local fixL = outline{{292,612},{318,620},{336,632},{340,700},{300,710},{286,660}, char="soft", seed=4102, amount=0.5}:mask()
local fixR = outline{{664,628},{690,624},{708,630},{712,700},{668,705},{662,660}, char="soft", seed=4103, amount=0.5}:mask()
local fm = (fixL + fixR) - strandsAll:grow(2)
work(fm, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={6,14}, coverage=3.5, fill=true, edge="soft", load=1.0,
  angle=function(x,y) return 1.57 + 0.8*math.sin(x/6 + y/5) end,
  piles={{lent, 0.6}, {rock, 0.8}, {brushdark, 1}, {deeprust, function(x,y) return 0.4*nz:at01(x,y) * clamp((660 - y)/30, 0, 1) end}}})
-- lip notches: soften them
blend((strandsAll * above(function(x) return 680 end)):soften(2), {angle=0.0})

--@ chunk 232
print(palette())
for _, p in ipairs({{100,1150},{200,1220},{60,1100}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 233
palette{scrape={nearbank, thinwhite, lipglass}}
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
mosslit2 = pile{{"yellow ochre",2},{"green earth",1.5},{"lead white",0.8},{"chrome yellow",0.3},{"raw umber",0.3}, name="mosslit2"}
-- foreground rock: hand-drawn angular silhouette, lower left, rising out of the pool
fgRockTop = {{-10,1092},{30,1078},{78,1070},{120,1074,"c"},{160,1090},{196,1104},{228,1126,"c"},{256,1160},{276,1200},{288,1256}}
local pts = {}
for _, p in ipairs(fgRockTop) do pts[#pts+1] = p end
pts[#pts+1] = {-10, 1256}
fgRock = outline{pts=pts, char="broken", seed=4201, amount=0.6}:mask()
print(fgRock:area())
local nz = noise{seed=4202, period=24, octaves=3}
local nz2 = noise{seed=4203, period=60, octaves=2}
local function dep(x, y)
  local t = 1092
  for i = 1, #fgRockTop - 1 do
    local a, b = fgRockTop[i], fgRockTop[i+1]
    if x >= a[1] and x <= b[1] then t = lerp(a[2], b[2], (x - a[1]) / (b[1] - a[1])); break end
  end
  return y - t
end
work(fgRock, {hand="body", tool={kind="flat", width=10, stiffness=0.6}, length={14,34}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) local d = dep(x,y); return d < 40 and (0.15 + 0.2*nz(x,y)) or (1.3 + 0.4*nz(x,y)) end,
  piles={{lent, function(x,y) return clamp((dep(x,y) - 30)/60, 0, 1) * 1.2 end},
         {rock, 0.8},
         {brushdark, function(x,y) return 0.3 + 0.3*nz:at01(x,y) end},
         {mossdeep, function(x,y) return clamp(1 - dep(x,y)/45, 0, 1) * (0.6 + 0.6*nz2:at01(x,y)) end},
         {mosslit2, function(x,y) return clamp(1 - dep(x,y)/14, 0, 1) * clamp((nz:at01(x+30,y) - 0.35)*3, 0, 1) * 0.8 end}}})

--@ chunk 234
-- rim light along the top with the knife held along each facet, facing the glow (upper right)
local function rimline(pts, pile, w, skip)
  for j = 1, #pts - 1 do
    if not (skip and skip[j]) then
      local a, b = pts[j], pts[j+1]
      local dx, dy = b[1] - a[1], b[2] - a[2]
      local len = math.sqrt(dx*dx + dy*dy)
      local ang = math.atan(dy, dx)
      local k = knife{width=len * 0.9}
      k:load(pile, 0.35)
      local mx, my = (a[1] + b[1]) / 2, (a[2] + b[2]) / 2
      k:lay({{mx, my}, {mx, my + (w or 2)}}, {pressure={0.12, 0.2}, angle=ang})
    end
  end
end
rimline({{0,1090},{30,1078},{78,1070},{120,1074},{160,1090},{196,1104},{228,1126},{256,1160}}, rim_warm, 2.5, {[1]=true})
rimline({{78,1071},{120,1075},{160,1091}}, glow, 1.2)
-- fallen leaves on the moss
local lb = brush{kind="filbert", width=5, stiffness=0.5, lay=2}
for i = 1, 16 do
  local x = rand(10, 240)
  local y = 1080 + rand(5, 40) + ((x > 160) and (x - 160) * 0.6 or 0)
  if fgRock:at(x, y) > 0.8 then
    if i % 3 == 1 then lb:reload((i % 2 == 0) and orangeleaf or deeprust, 0.7) end
    local a = rand(-0.7, 0.7)
    lb:stroke({{x, y}, {x + 5*math.cos(a), y + 3*math.sin(a)}}, {pressure=rand(0.35, 0.6)})
  end
end
-- crack lines
local rd = brush{kind="round", width=4, point=0.5, stiffness=0.6}
for _, c in ipairs({{{120,1076},{126,1110},{120,1150},{128,1200}}, {{228,1128},{214,1170},{220,1220}}}) do
  rd:reload(lent, 0.7)
  local g = {}
  for i, p in ipairs(c) do g[#g+1] = {p[1], p[2], (i == 1) and 0.8 or (i == #c and 0.1 or 0.6)} end
  rd:gesture(g, {wobble=1})
end
-- reflection of the rock's edge in the water to its right: dark drag
local fb = brush{kind="flat", width=10, stiffness=0.5}
for x = 236, 300, 10 do
  fb:reload(waterdark, 0.6)
  fb:stroke({{x, 1180 + (x - 236) * 0.8}, {x + rand(-1, 1), 1256}}, {pressure={0.5, 0.3}, orient="across", clip=below({{-10,1100},{1010,1100}}) - fgRock})
end

--@ chunk 235
local topband = fgRock * mask(function(x, y) return clamp(1 - (y - 1070)/90, 0, 1) end)
blend(topband:shrink(3), {angle=0.2})
-- a lit facet on the upper-right face (facing the glow), and a dark recess below it
local facet = poly({{150,1090},{196,1106},{226,1128},{248,1160},{232,1172},{196,1150},{160,1120}}) * fgRock
work(facet, {hand="body", tool={kind="flat", width=6, stiffness=0.6}, length={10,24}, coverage=3, fill=true, clip=true, load=1.0,
  angle=0.6, piles={{rock, 0.7}, {rim_warm, 0.35}, {mossdeep, 0.5}, {haze, 0.15}}})
local recess = poly({{160,1122},{196,1152},{232,1174},{226,1200},{180,1185},{140,1150}}) * fgRock
work(recess, {hand="body", tool={kind="flat", width=6, stiffness=0.6}, length={10,24}, coverage=3, fill=true, clip=true, load=1.0,
  angle=0.6, piles={{lent, 1}, {rock, 0.5}}})
blend((facet + recess):soften(3) * fgRock, {angle=0.6})
-- leaves as small tapered gestures
local lb = brush{kind="round", width=5, point=0.8, stiffness=0.5}
for i = 1, 11 do
  local x = rand(15, 200)
  local y = 1078 + rand(4, 26) + ((x > 120) and (x - 120) * 0.35 or 0)
  if fgRock:at(x, y) > 0.8 then
    lb:reload((i % 3 == 0) and deeprust or orangeleaf, 0.7)
    local a = rand(-0.9, 0.9)
    local L = rand(6, 10)
    lb:gesture({{x, y, 0.15}, {x + L*0.5*math.cos(a), y + L*0.5*math.sin(a), 0.8}, {x + L*math.cos(a), y + L*math.sin(a), 0.0}}, {wobble=0.3})
  end
end

--@ chunk 236
blend(fgRock:shrink(2), {angle=0.5})
blend(fgRock:shrink(2), {angle=2.0})

--@ chunk 237
palette{scrape={mosslit2}}
leafshade = pile{{"red earth",2},{"raw umber",2.5},{"vermilion",0.2}, name="leafshade"}
local fronts = bmasks[5] + bmasks[6] + bmasks[7] + bmasks[8] + bmasks[9]
local backs = (bmasks[1] + bmasks[2] + bmasks[3] + bmasks[4]):grow(3) - fronts - strandsAll:grow(4) - foam3
backsM = backs
local nb = noise{seed=4301, period=22, octaves=3}
local nb2 = noise{seed=4302, period=70, octaves=2}
local function topOf(x)
  for y = 640, 860, 2 do if backs:at(x, y) > 0.5 then return y end end
  return 860
end
local tops = {}
for x = 0, 1000, 4 do tops[x // 4] = topOf(x) end
local function dep(x, y) return y - tops[clamp(math.floor(x / 4), 0, 250)] end
local function df(x) return math.abs(x - 486) end
work(backs, {hand="body", tool={kind="filbert", width=7, stiffness=0.5}, length={5,12}, coverage=3, fill=true, edge="soft", load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/7 + y/5) end,
  piles={{leafshade, function(x,y) return 0.6 + clamp((dep(x,y) - 20)/40, 0, 1) end},
         {brushdark, function(x,y) return 0.4 + 0.4*nb:at01(x, y) end},
         {deeprust, function(x,y) return clamp(1 - dep(x,y)/40, 0, 1) * (0.5 + 0.5*nb2:at01(x, y)) end},
         {orangeleaf, function(x,y) return clamp(1 - dep(x,y)/18, 0, 1) * clamp((nb:at01(x+50, y) - 0.4)*3, 0, 1) * clamp((df(x) - 100)/200, 0.3, 1) end},
         {mossdeep, function(x,y) return 0.3*clamp((nb2:at01(x+80, y) - 0.55)*3, 0, 1) end},
         {lent, function(x,y) return clamp((dep(x,y) - 50)/40, 0, 1) * 0.6 end}}})

--@ chunk 238
local nb = noise{seed=4401, period=30, octaves=3}
local nb2 = noise{seed=4402, period=12, octaves=2}
local function crestY(x) return (x < 486) and topy(LA_top, x) or topy(RA_top, x) end
local fronts = bmasks[5] + bmasks[6] + bmasks[7] + bmasks[8] + bmasks[9] + fgRock
-- the whole region between bank crest and front boulders, below y ~700, as one undergrowth mass that darkens downward
under = mask(function(x, y)
  if x > 340 and x < 640 then return 0 end
  local c = crestY(x)
  return (y > c + 20 and y < 880) and 1 or 0
end):soften(6) - fronts - strandsAll:grow(4) - headL2 - headR2 - mA - mB
local function df(x) return math.abs(x - 486) end
work(under, {hand="body", tool={kind="filbert", width=8, stiffness=0.5}, length={6,14}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/7 + y/5) end,
  piles={{lent, function(x,y) return clamp((y - 700)/80, 0, 1) * 0.8 + clamp(1 - (df(x) - 140)/60, 0, 1) end},
         {brushdark, function(x,y) return 0.9 end},
         {leafshade, function(x,y) return 0.5 + 0.5*nb:at01(x, y) end},
         {deeprust, function(x,y) return clamp((720 - y)/80, 0, 1) * clamp((nb:at01(x+40, y) - 0.45)*3, 0, 1) end},
         {mossdeep, function(x,y) return 0.35*clamp((nb:at01(x+90, y) - 0.55)*3, 0, 1) end}}})

--@ chunk 239
palette{scrape={foamsh}}
local x = mix{{brushdark, 0.45}, {haze, 0.35}, {deeprust, 0.2}, name="nearbank"}
print(palette())
palette{scrape={x}}
print(palette())

--@ chunk 240
palette{scrape={fallwhite}}
leafrust = pile{{"red earth",2},{"vermilion",0.6},{"yellow ochre",1.2}, name="leafrust"}
goldleaf = pile{{"chrome yellow",2},{"yellow ochre",1.5},{"red earth",0.3}, name="goldleaf"}
local feetA = below(function(x) return 660 end)
local protect = (mA - feetA) + (mB - feetA) + strandsAll:grow(5) + headL2 + headR2 + fgRock + bmasks[5] + bmasks[6] + bmasks[7] + bmasks[8] + bmasks[9]
bankClumps = {
  {{40,478,60,38}, 0.6}, {{125,505,58,40}, 0.6}, {{205,545,55,40}, 0.65}, {{272,590,50,38}, 0.7}, {{325,632,40,32}, 0.75},
  {{60,570,70,45}, 0.35}, {{165,612,65,45}, 0.35}, {{255,660,55,42}, 0.4}, {{318,700,40,36}, 0.4},
  {{40,690,75,50}, 0.18}, {{150,730,70,48}, 0.18}, {{250,770,60,45}, 0.2}, {{320,800,40,36}, 0.2},
  {{660,676,45,32}, 0.75}, {{730,650,55,36}, 0.65}, {{860,628,60,36}, 0.55}, {{950,612,60,38}, 0.5},
  {{640,730,50,40}, 0.4}, {{730,718,60,42}, 0.35}, {{840,705,65,42}, 0.3}, {{950,690,65,45}, 0.3},
  {{660,790,55,40}, 0.2}, {{770,790,65,42}, 0.18}, {{890,770,70,45}, 0.18}, {{985,760,50,45}, 0.18},
}
for i, c in ipairs(bankClumps) do clump4(c[1], 4500 + i, gx, gy - 60, {minus=protect, lit=c[2]}) end

--@ chunk 241
local feetA = below(function(x) return 660 end)
local protect = (mA - feetA) + (mB - feetA) + strandsAll:grow(5) + headL2 + headR2 + fgRock + bmasks[5] + bmasks[6] + bmasks[7] + bmasks[8] + bmasks[9]
local nd = noise{seed=4601, period=14, octaves=2}
local shadeAll = nil
for i, c in ipairs(bankClumps) do
  local cx, cy, rx, ry = c[1][1], c[1][2], c[1][3], c[1][4]
  local lit = c[2]
  local dx, dy = gx - cx, (gy - 60) - cy
  local dl = math.sqrt(dx*dx + dy*dy); dx, dy = dx/dl, dy/dl
  local keep = 0.15 + 0.5 * lit      -- how much of the glow-facing side keeps its light
  local m = clump_mask(c[1], 4500 + i) * mask(function(x, y)
    local u = ((x - cx)/rx)*dx + ((y - cy)/ry)*dy
    return clamp((1 - keep - u) * 3, 0, 1)
  end)
  shadeAll = shadeAll and (shadeAll + m) or m
end
shadeAll = shadeAll - protect
work(shadeAll, {hand="body", tool={kind="filbert", width=7, stiffness=0.5}, length={5,11}, coverage=2.2, fill=true, edge="soft", load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/7 + y/5) end,
  piles={{leafshade, 1}, {brushdark, function(x,y) return 0.4 + clamp((y - 600)/200, 0, 1) end},
         {deeprust, function(x,y) return 0.35*nd:at01(x, y) end},
         {lent, function(x,y) return 0.5*clamp((y - 700)/120, 0, 1) end}}})

--@ chunk 242
local feetA = below(function(x) return 660 end)
local protect = (mA - feetA) + (mB - feetA) + strandsAll:grow(5) + headL2 + headR2 + fgRock + bmasks[5] + bmasks[6] + bmasks[7] + bmasks[8] + bmasks[9]
local bankAll = nil
for i, c in ipairs(bankClumps) do local m = clump_mask(c[1], 4500 + i); bankAll = bankAll and (bankAll + m) or m end
bankClumpM = bankAll
blend((bankAll:shrink(4) - protect):soften(6), {angle=1.2})
-- deepen toward the water: a glaze-like darkening, lower part of the banks
local low = (bankAll - protect) * mask(function(x, y) return clamp((y - 640)/120, 0, 1) end)
work(low, {hand="glaze", pile=lent, coverage=0.8})

--@ chunk 243
local feetA = below(function(x) return 660 end)
local protect = (mA - feetA) + (mB - feetA) + strandsAll:grow(5) + headL2 + headR2 + fgRock + bmasks[5] + bmasks[6] + bmasks[7] + bmasks[8] + bmasks[9]
local low = ((bankClumpM:grow(6) - protect) * mask(function(x, y) return clamp((y - 600)/60, 0, 1) end)):soften(4)
blend(low, {angle=math.pi/2})
blend(low, {angle=1.2})
blend(low, {angle=2.0})

--@ chunk 244
for _, y in ipairs({30, 150, 300, 450, 550}) do
  local cx = axis_fn(fullA_pts)(y); local bx = axis_fn(fullB_pts)(y)
  print(y, drying(cx - 10, y), drying(cx + 10, y), drying(bx, y))
end

--@ chunk 245
local nz = noise{seed=4701, period=12, octaves=2}
-- clefts dividing the long front boulders, with the near half's top dropped
local clefts = {
  {x=118, top=812, w=14, drop=22, side=-1, b=5},   -- left boulder: left part lower
  {x=230, top=815, w=10, drop=0, side=1, b=5},
  {x=720, top=826, w=12, drop=18, side=1, b=7},   -- right boulder: right part lower
}
for _, c in ipairs(clefts) do
  local m = bmasks[c.b]
  local cm = mask(function(x, y)
    local half = c.w/2 * clamp(1 - (y - c.top)/70, 0.25, 1)
    return (math.abs(x - c.x - (y - c.top)*0.08) < half and y > c.top - 12 and y < c.top + 80) and 1 or 0
  end):soften(1.5) * m:grow(3)
  work(cm, {hand="body", tool={kind="round", width=5, stiffness=0.6}, length={8,20}, coverage=3.5, fill=true, clip=true, load=1.0, angle=1.5,
    piles={{lent, 1}, {brushdark, 0.4}}})
  if c.drop > 0 then
    -- drop the top on one side: paint background foliage-dark into the top band of that half
    local dm = m * mask(function(x, y)
      local inside = (c.side < 0) and (x < c.x) or (x > c.x)
      if not inside then return 0 end
      local t = 0
      for yy = 780, 900 do if m:at(x, yy) > 0.5 then t = yy; break end end
      return (y < t + c.drop * (1 - 0.3*nz:at01(x, 0))) and 1 or 0
    end)
    work(dm, {hand="body", tool={kind="filbert", width=6, stiffness=0.5}, length={6,12}, coverage=3.5, fill=true, clip=true, load=1.0,
      angle=function(x,y) return 1.57 + 0.9*math.sin(x/7 + y/5) end,
      piles={{leafshade, 1}, {brushdark, 0.8}, {lent, 0.4}}})
  end
end

--@ chunk 246
local nz = noise{seed=4801, period=30, octaves=3}
local nz2 = noise{seed=4802, period=12, octaves=2}
for i = 5, 9 do
  local b = BLD[i]
  local m = bmasks[i]
  local cx, cy, rx, ry = b.c[1], b.c[2], b.c[3], b.c[4]
  local tops = {}
  for x = math.floor(cx - rx*1.2), math.ceil(cx + rx*1.2), 3 do
    local t = nil
    for y = 760, 920 do if m:at(x, y) > 0.5 then t = y; break end end
    tops[x] = t
  end
  local function dep(x, y)
    local xi = math.floor(x)
    for d = 0, 3 do local t = tops[xi - ((xi - math.floor(cx - rx*1.2)) % 3) + 0] if t then return y - t end end
    return 30
  end
  local function depth(x, y)
    local x0 = math.floor(cx - rx*1.2)
    local k = x0 + math.floor((x - x0) / 3) * 3
    local t = tops[k] or tops[k + 3] or tops[k - 3]
    return t and (y - t) or 30
  end
  local glowk = clamp(1 - (math.abs(cx - 485) - 80) / 450, 0.25, 1)
  work(m, {hand="body", tool={kind="flat", width=7, stiffness=0.6}, length={8,22}, coverage=3.5, fill=true, clip=true, load=1.0,
    angle=function(x,y) local d = depth(x,y); return (d < 14) and (0.1*nz(x,y)) or (1.45 + 0.4*nz(x,y)) end,
    piles={{mossdeep, function(x,y) local d = depth(x,y); return clamp(1 - (d - 6)/14, 0, 1) * (0.7 + 0.5*nz:at01(x,y)) end},
           {rim_warm, function(x,y) local d = depth(x,y); return clamp(1 - d/4, 0, 1) * glowk * clamp((nz2:at01(x,y) - 0.3)*3, 0, 1) end},
           {rock, function(x,y) local d = depth(x,y); return clamp((d - 10)/15, 0, 1) * 0.8 end},
           {lent, function(x,y) local d = depth(x,y); return clamp((d - 25)/30, 0, 1) end},
           {brushdark, function(x,y) return 0.25 + 0.3*nz:at01(x+40, y) end}}})
end

--@ chunk 247
local nr = noise{seed=4901, period=25, octaves=2}
for i = 5, 9 do
  local b = BLD[i]
  local cx, cy, rx, ry = b.c[1], b.c[2], b.c[3], b.c[4]
  local pts = top_contour(bmasks[i], cx - rx * 0.95, cx + rx * 0.95, 760, 930, 8)
  local glowk = clamp(1 - (math.abs(cx - 485) - 60) / 420, 0.2, 1)
  for j = 1, #pts - 1 do
    local a, c = pts[j], pts[j+1]
    local facing = ((cx < 485) and (a[1] > cx - rx*0.1)) or ((cx > 485) and (a[1] < cx + rx*0.1))
    if nr:at01(a[1], a[2]) > 0.4 and (facing or nr:at01(a[1]+9, 0) > 0.7) then
      local dx, dy = c[1] - a[1], c[2] - a[2]
      local len = math.sqrt(dx*dx + dy*dy)
      local k = knife{width=len * 1.05}
      k:load(facing and rim_warm or mossdeep, 0.35)
      local mx, my = (a[1] + c[1]) / 2, (a[2] + c[2]) / 2
      k:lay({{mx, my}, {mx, my + 2}}, {pressure={0.12, 0.2}, angle=math.atan(dy, dx)})
    end
  end
end
-- small fallen leaves on the mossy tops
local lb = brush{kind="round", width=5, point=0.8, stiffness=0.5}
for i = 5, 9 do
  local b = BLD[i]
  local cx, cy, rx, ry = b.c[1], b.c[2], b.c[3], b.c[4]
  for k = 1, math.floor(rx / 25) do
    local x = cx + rand(-0.7, 0.7) * rx
    local y = cy - ry * rand(0.55, 0.8)
    if bmasks[i]:at(x, y) > 0.8 then
      lb:reload((k % 2 == 0) and deeprust or orangeleaf, 0.7)
      local a = rand(-0.9, 0.9); local L = rand(5, 8)
      lb:gesture({{x, y, 0.15}, {x + L*0.5*math.cos(a), y + L*0.5*math.sin(a), 0.8}, {x + L*math.cos(a), y + L*math.sin(a), 0.0}}, {wobble=0.3})
    end
  end
end

--@ chunk 248
local poolM2 = below({{-10,910},{1010,910}}) - front_all - fgRock
local top = poolM2 * mask(function(x, y) return clamp(1 - (y - 930)/40, 0, 1) end)
blend(top:soften(6), {angle=0.0})
-- ripple lines, crisp
local rb = brush{kind="round", width=2.2, point=0.6, stiffness=0.5}
local fb = brush{kind="flat", width=2.5, stiffness=0.5}
local ys = uneven(40, 945, 1245, 0.55, 0.45, 5001)
for i, y in ipairs(ys) do
  local sc = 0.5 + (y - 906) / 260
  for s = 1, 3 do
    local x0 = rand(0, 1000)
    local len = rand(18, 70) * sc
    if poolM2:at(x0, y) > 0.8 and poolM2:at(x0 - len/2, y) > 0.5 and poolM2:at(x0 + len/2, y) > 0.5 then
      local light = columnM:at(x0, y) > 0.4 or wedgeM:at(x0, y) > 0.4 or birchRA:at(x0, y) > 0.4 or birchRB:at(x0, y) > 0.4
      if light then
        fb:reload(waterdark, 0.45)
        fb:stroke({{x0 - len/2, y}, {x0, y + rand(-0.4, 0.4)}, {x0 + len/2, y}}, {pressure={0.3, 0.12}, orient="across", clip=poolM2})
      elseif (i + s) % 2 == 0 then
        rb:reload((math.abs(x0 - 485) < 250) and glow or haze, 0.4)
        rb:gesture({{x0 - len/2, y, 0.05}, {x0, y + rand(-0.3, 0.3), 0.4}, {x0 + len/2, y, 0.05}}, {wobble=0.4, clip=poolM2})
      end
    end
  end
end

--@ chunk 249
local poolM2 = below({{-10,915},{1010,915}}) - front_all - fgRock - foam3:grow(10)
local lb = brush{kind="round", width=6, point=0.7, stiffness=0.5}
local db = brush{kind="round", width=4, point=0.6, stiffness=0.5}
local centers = {{700, 1150, 90, 30, 14}, {320, 1215, 60, 18, 8}, {880, 1030, 60, 15, 6}, {560, 1080, 120, 40, 7}, {150, 990, 80, 20, 5}}
for _, c in ipairs(centers) do
  for k = 1, c[5] do
    local x = c[1] + randn(0, c[3] * 0.5)
    local y = c[2] + randn(0, c[4] * 0.5)
    if poolM2:at(x, y) > 0.9 then
      local sc = 0.6 + (y - 906) / 340
      local L = rand(6, 11) * sc
      local a = rand(-0.5, 0.5)
      db:reload(waterdark, 0.5)
      db:gesture({{x - L*0.4, y + 1.5, 0.1}, {x, y + 2, 0.5}, {x + L*0.4, y + 1.5, 0.1}}, {wobble=0.2})
      local p = (k % 4 == 0) and deeprust or ((k % 3 == 0) and goldleaf or orangeleaf)
      lb:reload(p, 0.75)
      lb:gesture({{x - L*0.5*math.cos(a), y - L*0.18*math.sin(a), 0.1}, {x, y, 0.7}, {x + L*0.5*math.cos(a), y + L*0.18*math.sin(a), 0.05}}, {wobble=0.2})
    end
  end
end

--@ chunk 250
local poolM2 = below({{-10,912},{1010,912}}) - front_all - fgRock
blend(poolM2, {angle=0.0})

--@ chunk 251
palette{scrape={leafrust, goldleaf}}
fallwhite = pile{{"lead white",8},{"yellow ochre",0.25},{"cobalt blue",0.08}, name="fallwhite"}
local nf = noise{seed=5101, period=10, octaves=3}
local heads = {{404, 34}, {487, 40}, {533, 14}, {577, 32}}
foam4 = mask(function(x, y)
  local v = 0
  for _, h in ipairs(heads) do
    local dx = (x - h[1]) / h[2]
    local dy = (y - 903) / 14
    v = math.max(v, clamp((1 - (dx*dx + dy*dy)) * 2.5 + 0.9*nf(x, y), 0, 1))
  end
  return v
end) - front_all
work(foam4, {hand="body", tool={kind="round", width=5, stiffness=0.4}, length={5,12}, coverage=3, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.5*nf(x*3, y*3) end,
  piles={{fallwhite, function(x,y) return clamp(1 - (y - 893)/20, 0.15, 1) * 1.4 end},
         {haze, function(x,y) return 0.3 + clamp((y - 900)/14, 0, 1) end},
         {glow, 0.12}}})
blend(foam4:grow(2), {angle=0.0})

--@ chunk 252
local fz = (foam4:grow(12)):soften(10) - front_all
for _, a in ipairs({0.0, math.pi/2, 0.5, 2.6, math.pi/2}) do blend(fz, {angle=a}) end

--@ chunk 253
glassy = mix{{haze, 0.4}, {waterdark, 0.3}, {amber, 0.3}, name="glassy"}
local ns = noise{seed=5201, period=8, octaves=2, stretch={math.pi/2, 6}}
for i = 1, 4 do
  local m = strandM[i] * mask(function(x, y) return (y < 700) and 1 or 0 end)
  local l, r = sx(i, 0, 666), sx(i, 1, 666)
  local function tt(x) return (x - l) / math.max(r - l, 1) end
  -- convex top: lip line dips at the corners
  local function lipY(x) local t = tt(x); return 660 + 7 * (2*t - 1)^2 end
  local function d(x, y) return y - lipY(x) end
  work(m, {hand="body", tool={kind="flat", width=4, stiffness=0.5}, length={10,24}, coverage=4, fill=true, clip=true, load=1.0,
    angle=math.pi/2,
    piles={{lent, function(x,y) return (d(x,y) < 0) and 3 or 0 end},
           {glow, function(x,y) local dd = d(x,y); return (dd >= 0 and dd < 3) and 2 or 0 end},
           {glassy, function(x,y) local dd = d(x,y); return (dd >= 2 and dd < 20) and (1 - clamp((dd - 12)/8, 0, 1)) * 1.4 or 0 end},
           {fallwhite, function(x,y) local dd = d(x,y); return clamp((dd - 10)/12, 0, 1) * clamp((ns:at01(x, y) - 0.25)*3, 0.2, 1) * 1.3 end},
           {haze, function(x,y) local dd = d(x,y); return clamp((dd - 12)/10, 0, 1) * 0.4 end}}})
end

--@ chunk 254
for i = 1, 4 do
  local m = strandM[i] * mask(function(x, y) return clamp((725 - y)/15, 0, 1) end)
  blend(m, {angle=math.pi/2})
  blend(m, {angle=math.pi/2})
end

--@ chunk 255
local fb = brush{kind="flat", width=9, stiffness=0.6, lay=2}
local rb = brush{kind="round", width=2.5, point=0.5}
for i = 1, 4 do
  local l, r = sx(i, 0, 668), sx(i, 1, 668)
  local clipm = strandM[i]
  -- glassy convex band: two horizontal strokes
  for k = 0, 1 do
    fb:reload(glassy, 0.9)
    local y = 667 + k * 6
    fb:stroke({{l - 2, y + 3}, {(l + r)/2, y - 1}, {r + 2, y + 3}}, {pressure={0.7, 0.7}, orient="across", clip=clipm})
  end
  -- bright crest
  rb:reload(glow, 0.7)
  rb:gesture({{l + 1, 664, 0.2}, {(l+r)/2, 661.5, 0.7}, {r - 1, 664, 0.2}}, {wobble=0.3, clip=clipm:grow(2)})
end
-- streaks emerging from the band
for i = 1, 4 do
  local clipm = strandM[i]:grow(1)
  local fan = brush{kind="fan", width=(i == 3) and 7 or 10, stiffness=0.5}
  for k = 1, ((i == 3) and 3 or 7) do
    if k % 2 == 1 then fan:reload((k % 3 == 0) and haze or fallwhite, 0.35) end
    local tt = rand(0.06, 0.94)
    local y0 = rand(674, 680)
    local yend = y0 + rand(60, 140)
    local pts = {}
    for j = 0, 4 do local y = lerp(y0, yend, j/4); pts[#pts+1] = {sx(i, tt, y) + rand(-1, 1), y} end
    fan:stroke(pts, {pressure={0.5, 0.05}, orient="across", ramps={0.05, 0.6}, clip=clipm})
  end
end

--@ chunk 256
wait(2 * 24 * 60)
local pts = {{470,750},{560,780},{400,850},{486,905},{806,300},{920,300},{806,100},{150,600},{800,620},{500,1000},{200,850},{750,850},{100,1150},{450,300},{250,150},{700,200}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 257
wait(4 * 24 * 60)
local pts = {{470,750},{560,780},{400,850},{486,905},{806,300},{920,300},{806,100},{150,600},{800,620},{500,1000},{200,850},{750,850},{100,1150},{450,300},{250,150},{700,200},{420,670}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 258
wait(6 * 24 * 60)
local pts = {{470,750},{560,780},{400,850},{806,300},{920,300},{806,100},{150,600},{200,850},{750,850},{100,1150},{250,150},{700,200},{420,670},{790,300},{820,300}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 259
wait(7 * 24 * 60)
local pts = {{806,300},{806,100},{150,600},{200,850},{750,850},{100,1150},{250,150},{700,200},{50,50},{950,1200},{300,1000}}
for _, p in ipairs(pts) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 260
print(palette())

--@ chunk 261
palette{scrape={nearbank, glassy}}
barkglaze = pile{{"raw umber",1},{"smalt",0.6}, medium=0.6, name="barkglaze"}
local function shadeMask(pts, m, ufrom)
  local ax = axis_fn(pts)
  return m * mask(function(x, y) local cx, w = ax(y); local u = (x - cx)/(w/2); return clamp((u - ufrom) * 5, 0, 1) end)
end
local gA = shadeMask(fullA_pts, mA, -0.5) * above(function(x) return 640 end)
local gB = shadeMask(fullB_pts, mB, -0.45) * above(function(x) return 618 end)
local tool = {kind="filbert", width=12, stiffness=0.3}
work(gA, {hand="glaze", pile=barkglaze, coverage=1, angle=-math.pi/2, tool=tool})
work(gB, {hand="glaze", pile=barkglaze, coverage=1, angle=-math.pi/2, tool={kind="filbert", width=9, stiffness=0.3}})
blend(gA:soften(2), {angle=-math.pi/2})
blend(gB:soften(2), {angle=-math.pi/2})

--@ chunk 262
local function shadeMask(pts, m, ufrom)
  local ax = axis_fn(pts)
  return m * mask(function(x, y) local cx, w = ax(y); local u = (x - cx)/(w/2); return clamp((u - ufrom) * 5, 0, 1) end)
end
local gA = shadeMask(fullA_pts, mA, -0.35) * above(function(x) return 640 end)
local gB = shadeMask(fullB_pts, mB, -0.3) * above(function(x) return 618 end)
work(gA, {hand="glaze", pile=barkglaze, coverage=1, angle=-math.pi/2, tool={kind="filbert", width=12, stiffness=0.3}})
work(gB, {hand="glaze", pile=barkglaze, coverage=1, angle=-math.pi/2, tool={kind="filbert", width=9, stiffness=0.3}})
blend(gA:soften(2), {angle=-math.pi/2})
blend(gB:soften(2), {angle=-math.pi/2})

--@ chunk 263
for i = 1, 4 do
  local clipm = strandM[i]:grow(1)
  local fan = brush{kind="fan", width=(i == 3) and 6 or 9, stiffness=0.5}
  local n = (i == 3) and 4 or 10
  for k = 1, n do
    if k % 2 == 1 then fan:reload((k % 3 == 0) and glow or fallwhite, 0.3) end
    local tt = (k - 0.5) / n + rand(-0.04, 0.04)
    local y0 = rand(664, 670)
    local yend = y0 + rand(40, 100)
    local pts = {}
    for j = 0, 4 do local y = lerp(y0, yend, j/4); pts[#pts+1] = {sx(i, tt, y) + rand(-0.8, 0.8), y} end
    fan:stroke(pts, {pressure={0.45, 0.05}, orient="across", ramps={0.02, 0.6}, clip=clipm})
  end
  -- a dark thread or two through the cap, so the sheet reads as separate ropes
  if i ~= 3 then
    local rd = brush{kind="round", width=2.5, point=0.6}
    for k = 1, 2 do
      rd:reload(waterdark, 0.4)
      local tt = rand(0.2, 0.8)
      rd:gesture({{sx(i, tt, 668), 668, 0.1}, {sx(i, tt, 690), 690, 0.4}, {sx(i, tt, 720) + rand(-1,1), 720, 0.0}}, {wobble=0.4, clip=clipm})
    end
  end
end

--@ chunk 264
local rg = brush{kind="rigger", width=2, point=0.9}
-- a simple monogram-style signature, lower right
local sig = {
  {{902,1228,0.2},{905,1214,0.6},{910,1226,0.5},{915,1212,0.6},{918,1228,0.2}},
  {{926,1214,0.2},{924,1222,0.6},{929,1229,0.5},{934,1220,0.3}},
  {{942,1212,0.2},{941,1229,0.6}},
  {{941,1220,0.3},{949,1216,0.5},{951,1229,0.2}},
}
for _, s in ipairs(sig) do
  rg:reload(lent, 0.6)
  rg:gesture(s, {wobble=0.3})
end

--@ chunk 265
for _, p in ipairs({{400,640},{470,700},{540,760},{580,850},{360,800},{620,700},{486,900},{450,620},{486,930}}) do print(p[1], p[2], drying(p[1], p[2])) end
print(palette())

--@ chunk 266
palette{scrape={orangeleaf}}
glassy = pile{{"lead white",2},{"yellow ochre",1.2},{"raw umber",0.5},{"red earth",0.2},{"green earth",0.3}, name="glassy"}
crestPts = {{335,630},{345,622},{352,614},{362,619},{370,612},{380,626},{385,668},
  {434,669},{436,646},{441,637},{447,641},{451,655},
  {512,655},{514,643},{518,647},{520,676},
  {537,677},{540,651},{544,647},{548,663},
  {591,663},{594,645},{602,639},{612,643},{622,634},{636,641},{646,650}}
local rp = {}
for _, p in ipairs(crestPts) do rp[#rp+1] = {p[1], p[2]} end
rp[#rp+1] = {652, 906}; rp[#rp+1] = {330, 906}
rockFace = outline{pts=rp, char="broken", seed=6001, amount=0.25}:mask()
NS = {}
NS[1] = outline{{386,671},{410,668},{433,671},{437,700},{441,760},{445,830},{448,904},{354,904},{364,830},{373,760},{381,700}, char="broken", seed=6011, amount=0.45}:mask()
NS[2] = outline{{452,656},{482,652},{512,656},{515,700},{519,765},{528,805},{560,850},{600,904},{478,904},{470,830},{462,760},{456,700}, char="broken", seed=6012, amount=0.45}:mask()
NS[3] = outline{{520,678},{528,675},{537,678},{540,720},{547,762},{562,800},{572,904},{530,904},{525,800},{522,720}, char="broken", seed=6013, amount=0.4}:mask()
NS[4] = outline{{548,664},{570,660},{591,664},{595,710},{601,780},{609,850},{620,904},{552,904},{548,800},{546,760},{547,710}, char="broken", seed=6014, amount=0.45}:mask()
newFalls = NS[1] + NS[2] + NS[3] + NS[4]
slots = (rect(380, 600, 218, 80) - rockFace)
print(rockFace:area(), newFalls:area(), slots:area())

--@ chunk 267
local rp = {}
for _, p in ipairs(crestPts) do if p[1] >= 345 and p[1] <= 640 then rp[#rp+1] = {p[1], p[2]} end end
rp[#rp+1] = {644, 660}; rp[#rp+1] = {638, 720}; rp[#rp+1] = {630, 790}; rp[#rp+1] = {636, 860}; rp[#rp+1] = {640, 906}
rp[#rp+1] = {336, 906}; rp[#rp+1] = {344, 850}; rp[#rp+1] = {338, 780}; rp[#rp+1] = {346, 700}; rp[#rp+1] = {342, 640}
rockFace = outline{pts=rp, char="broken", seed=6001, amount=0.3}:mask()
slots = (rect(382, 596, 214, 84) - rockFace)
print(rockFace:area(), slots:area())
-- Step A: slots — misty background seen through the notches, with a bright edge-on strip of upper water at each lip
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local function lipAt(x)
  if x >= 385 and x <= 434 then return 669 elseif x >= 451 and x <= 512 then return 655
  elseif x >= 520 and x <= 537 then return 676 elseif x >= 548 and x <= 591 then return 663 end
  return 640
end
work(slots, {hand="body", tool={kind="flat", width=6, stiffness=0.5}, length={12,30}, coverage=4, fill=true, clip=true, load=1.0,
  angle=0.0,
  piles={{haze, 1}, {amber, 0.5}, {glow, function(x,y) return 0.6 + clamp(1 - math.abs(lipAt(x) - 4 - y)/4, 0, 1) * 3 end},
         {deeprust, function(x,y) return 0.15 end}}})
blend(slots:grow(6):soften(4) * above(function(x) return lipAt(x) - 5 end), {angle=math.pi/2})

--@ chunk 268
-- Step B: the rock face, dark and wet, jagged crests with warm rim light
local nz = noise{seed=6101, period=26, octaves=3}
work(rockFace, {hand="body", tool={kind="filbert", width=8, stiffness=0.6}, length={12,30}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.45 + 0.35*nz(x,y) end,
  piles={{lent, 1}, {rock, 0.8}, {waterdark, function(x,y) return 0.3 + 0.4*nz:at01(x,y) end}, {mossdeep, function(x,y) return 0.25*clamp((nz:at01(x+50,y) - 0.6)*3, 0, 1) * clamp((800 - y)/100, 0, 1) end}}})
-- rim light on the crests (knife along each facet) – only on the pillar tops and shoulders, not on the lips
local function rimseg(a, b, pile)
  local dx, dy = b[1] - a[1], b[2] - a[2]
  local len = math.sqrt(dx*dx + dy*dy)
  if len < 3 then return end
  local k = knife{width=len * 0.95}
  k:load(pile, 0.35)
  local mx, my = (a[1] + b[1]) / 2, (a[2] + b[2]) / 2
  k:lay({{mx, my}, {mx, my + 2}}, {pressure={0.12, 0.2}, angle=math.atan(dy, dx)})
end
local segs = {{{345,622},{352,614}},{{352,614},{362,619}},{{362,619},{370,612}},{{370,612},{380,626}},
  {{436,646},{441,637}},{{441,637},{447,641}},{{514,643},{518,647}},{{540,651},{544,647}},
  {{594,645},{602,639}},{{602,639},{612,643}},{{612,643},{622,634}},{{622,634},{636,641}}}
for i, s in ipairs(segs) do rimseg(s[1], s[2], (i % 3 == 0) and glow or rim_warm) end

--@ chunk 269
-- soften the slot box into the misty background above
local band = (rect(370, 560, 240, 80)):soften(25) - rockFace
blend(band, {angle=math.pi/2})
blend(band, {angle=0.0})
blend(band, {angle=math.pi/2})
-- strand edge tables
local function edges_at(m, y)
  local l, r = 1000, 0
  for x = 340, 640, 1.5 do if m:at(x, y) > 0.5 then if x < l then l = x end; if x > r then r = x end end end
  return l, r
end
nEdges = {}
for i = 1, 4 do
  nEdges[i] = {}
  for y = 650, 906, 4 do local l, r = edges_at(NS[i], y); nEdges[i][#nEdges[i]+1] = {y, l, r} end
end
function nx(i, t, y)
  local E = nEdges[i]
  local k = clamp(math.floor((y - 650) / 4) + 1, 1, #E)
  local e = E[k]
  local j = k
  while e[3] < e[2] and j < #E do j = j + 1; e = E[j] end
  return lerp(e[2], e[3], t)
end
nTop = {671, 656, 678, 664}
print(nx(1,0,700), nx(1,1,700), nx(2,0.5,660), nx(4,1,890))

--@ chunk 270
palette{scrape={barkglaze, leafshade}}
thinwhite = pile{{"lead white",8},{"yellow ochre",0.2},{"cobalt blue",0.1}, thinner=0.5, name="thinwhite"}
foamsh = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.35},{"yellow ochre",0.1}, name="foamsh"}
for i = 1, 4 do
  local m = NS[i]
  local clipm = m:grow(1)
  local top = nTop[i]
  local fb = brush{kind="flat", width=7, stiffness=0.5, lay=2}
  local L, R = nx(i, 0, top + 4), nx(i, 1, top + 4)
  for k = 0, 2 do
    fb:reload(glassy, 0.9)
    local y = top + 2 + k * 4
    fb:stroke({{L - 3, y + 3}, {(L+R)/2, y - 1}, {R + 3, y + 3}}, {pressure={0.65, 0.65}, orient="across", clip=clipm})
  end
  local vb = brush{kind="flat", width=7, stiffness=0.5}
  local n = 0
  for pass = 1, 3 do
    for t = 0.04, 0.96, 0.12 do
      n = n + 1
      if n % 2 == 1 then vb:reload(thinwhite, 0.6) end
      local tt = t + rand(-0.04, 0.04)
      local y0 = top + 10 + rand(0, 8)
      local yend = rand(800, 904)
      local pts = {}
      for k = 0, 4 do local y = lerp(y0, yend, k/4); pts[#pts+1] = {nx(i, tt, y) + rand(-1, 1), y} end
      vb:stroke(pts, {pressure={0.5, 0.25}, orient="across", clip=clipm})
    end
  end
  local fan = brush{kind="fan", width=(i == 3) and 8 or 12, stiffness=0.5}
  local nd = (i == 3) and 4 or 10
  for k = 1, nd do
    if k % 3 == 1 then fan:reload((k % 4 == 0) and foamsh or fallwhite, 0.3) end
    local tt = clamp(math.abs(randn(0.5, 0.3)), 0.04, 0.96)
    local y0 = top + 12 + rand(0, 20)
    local yend = math.min(904, y0 + rand(120, 240))
    local pts = {}
    for j = 0, 4 do local y = lerp(y0, yend, j/4); pts[#pts+1] = {nx(i, tt, y) + rand(-1, 1), y} end
    fan:stroke(pts, {pressure={0.4, 0.55}, orient="across", ramps={0.3, 0.2}, clip=clipm})
  end
  blend(m * below(function(x) return top + 12 end), {angle=math.pi/2})
end

--@ chunk 271
-- bright water: several layers of fan drags, building white over the gray (each layer picks up less)
for layer = 1, 2 do
  for i = 1, 4 do
    local clipm = NS[i]:grow(1)
    local top = nTop[i]
    local fan = brush{kind="fan", width=(i == 3) and 7 or 11, stiffness=0.5}
    local nd = (i == 3) and 4 or 11
    for k = 1, nd do
      if k % 2 == 1 then fan:reload((layer == 2 and k % 3 == 0) and glow or fallwhite, 0.42) end
      local tt = clamp(rand(0, 1), 0.04, 0.96)
      local y0 = top + 14 + rand(0, 15)
      local yend = math.min(904, y0 + rand(80, 200))
      local pts = {}
      for j = 0, 4 do local y = lerp(y0, yend, j/4); pts[#pts+1] = {nx(i, tt, y) + rand(-1, 1), y} end
      fan:stroke(pts, {pressure={0.55, 0.15}, orient="across", ramps={0.05, 0.5}, clip=clipm})
    end
  end
end

--@ chunk 272
for i = 1, 4 do blend(NS[i] * below(function(x) return nTop[i] + 14 end), {angle=math.pi/2}) end
-- lip: darker glassy convex band under a thin bright crest
local gb = brush{kind="flat", width=6, stiffness=0.5, lay=2}
local rb = brush{kind="round", width=2.5, point=0.5}
for i = 1, 4 do
  local top = nTop[i]
  local clipm = NS[i]
  local L, R = nx(i, 0, top + 3), nx(i, 1, top + 3)
  for k = 0, 1 do
    gb:reload(waterdark, 0.5); gb:load(glassy, 0.5)
    local y = top + 4 + k * 5
    gb:stroke({{L - 3, y + 3}, {(L+R)/2, y - 1}, {R + 3, y + 3}}, {pressure={0.6, 0.6}, orient="across", clip=clipm})
  end
  rb:reload(glow, 0.7)
  rb:gesture({{L + 1, top + 2.5, 0.2}, {(L+R)/2, top + 0.5, 0.75}, {R - 1, top + 2.5, 0.2}}, {wobble=0.3, clip=clipm:grow(2)})
  -- where the glass turns down into white: soft blend of the band's lower edge
  blend(clipm * mask(function(x, y) return clamp(1 - math.abs(y - (top + 14))/7, 0, 1) end), {angle=math.pi/2})
end

--@ chunk 273
for i = 1, 4 do
  local clipm = NS[i]:grow(1)
  local top = nTop[i]
  local fan = brush{kind="fan", width=(i == 3) and 6 or 9, stiffness=0.5}
  local nd = (i == 3) and 5 or 13
  for k = 1, nd do
    if k % 2 == 1 then fan:reload(fallwhite, 0.35) end
    local tt = (k - 0.5) / nd + rand(-0.03, 0.03)
    local y0 = top + 13 + rand(0, 6)
    local yend = math.min(904, y0 + rand(60, 180))
    local pts = {}
    for j = 0, 4 do local y = lerp(y0, yend, j/4); pts[#pts+1] = {nx(i, tt, y) + rand(-0.8, 0.8), y} end
    fan:stroke(pts, {pressure={0.45, 0.05}, orient="across", ramps={0.02, 0.6}, clip=clipm})
  end
  -- dark threads, thin
  local rd = brush{kind="round", width=2.5, point=0.6}
  for k = 1, ((i == 3) and 1 or 4) do
    rd:reload(waterdark, 0.4)
    local tt = rand(0.15, 0.85)
    local y0 = top + rand(25, 80)
    local y1 = y0 + rand(50, 120)
    rd:gesture({{nx(i, tt, y0), y0, 0.05}, {nx(i, tt, (y0+y1)/2) + rand(-1,1), (y0+y1)/2, 0.45}, {nx(i, tt, y1), y1, 0.0}}, {wobble=0.4, clip=clipm})
  end
  -- pointed white accents
  for k = 1, ((i == 3) and 2 or 5) do
    rd:reload(fallwhite, 0.6)
    local tt = rand(0.1, 0.9)
    local y0 = top + 14
    local ylen = rand(40, 150)
    rd:gesture({{nx(i, tt, y0), y0, 0.3}, {nx(i, tt, y0 + ylen*0.35) + rand(-1,1), y0 + ylen*0.35, 0.6}, {nx(i, tt, y0 + ylen), y0 + ylen, 0.0}}, {wobble=0.6, clip=clipm})
  end
end

--@ chunk 274
-- broken bright white low, where the water hits (y 810-900), with ragged spray edges
local nn = noise{seed=6201, period=9, octaves=3}
local nn2 = noise{seed=6202, period=30, octaves=2}
lowWhite = (newFalls:grow(4)) * mask(function(x, y)
  local v = clamp((y - 800) / 40, 0, 1) * clamp((912 - y) / 10, 0, 1)
  return clamp(v * (0.4 + nn:at01(x, y)) * 1.6 - 0.3, 0, 1)
end)
local rb = brush{kind="round", width=5, stiffness=0.4, lay=2}
local fb = brush{kind="filbert", width=6, stiffness=0.4}
work(lowWhite, {hand="body", tool={kind="round", width=5, stiffness=0.4}, length={4,10}, coverage=2.2, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.8*nn(x*2, y*2) end,
  piles={{fallwhite, 1.3}, {foamsh, function(x,y) return 0.3 + 0.5*nn2:at01(x,y) end}}})
-- spray: upward-curling short marks over the strand feet, edges lost
for k = 1, 40 do
  local x = rand(350, 625)
  local y = rand(825, 895)
  if newFalls:grow(10):at(x, y) > 0.3 then
    rb:reload((k % 3 == 0) and foamsh or fallwhite, 0.5)
    local h = rand(8, 22)
    rb:gesture({{x, y, 0.5}, {x + rand(-4, 4), y - h*0.5, 0.35}, {x + rand(-6, 6), y - h, 0.0}}, {wobble=1})
  end
end

--@ chunk 275
local jz = newFalls:grow(2) * mask(function(x, y) return clamp(1 - math.abs(y - 812)/30, 0, 1) end)
blend(jz, {angle=math.pi/2})
blend(jz, {angle=math.pi/2})
-- fan drags crossing the old edge
for i = 1, 4 do
  local clipm = NS[i]:grow(2)
  local fan = brush{kind="fan", width=(i == 3) and 6 or 10, stiffness=0.5}
  for k = 1, ((i == 3) and 3 or 8) do
    if k % 2 == 1 then fan:reload((k % 3 == 0) and foamsh or fallwhite, 0.35) end
    local tt = rand(0.05, 0.95)
    local y0 = rand(740, 790)
    local yend = rand(840, 900)
    local pts = {}
    for j = 0, 4 do local y = lerp(y0, yend, j/4); pts[#pts+1] = {nx(i, tt, y) + rand(-1, 1), y} end
    fan:stroke(pts, {pressure={0.5, 0.2}, orient="across", ramps={0.1, 0.4}, clip=clipm})
  end
  -- darker threads continuing down through the white
  local rd = brush{kind="round", width=3, point=0.6}
  for k = 1, ((i == 3) and 1 or 3) do
    rd:reload(foamsh, 0.5)
    local tt = rand(0.15, 0.85)
    local y0 = rand(780, 820)
    local y1 = y0 + rand(40, 80)
    rd:gesture({{nx(i, tt, y0), y0, 0.05}, {nx(i, tt, (y0+y1)/2) + rand(-1,1), (y0+y1)/2, 0.5}, {nx(i, tt, y1), y1, 0.0}}, {wobble=0.5, clip=clipm})
  end
end

--@ chunk 276
foamO = outline{{336,880},{352,872},{372,878},{392,866},{414,874},{440,868},{462,876},{486,864},{510,872},{534,866},{556,874},{580,866},{606,874},{628,870},{648,884},{662,900},{690,912},{700,922},{660,930},{620,926},{580,934},{530,930},{486,936},{440,930},{396,934},{352,928},{310,926},{280,918},{300,906},{322,896}, char="soft", seed=6301, amount=0.8, lobe=10}
foamM = foamO:mask():soften(3) - fgRock
local nf = noise{seed=6302, period=10, octaves=3}
work(foamM, {hand="body", tool={kind="round", width=6, stiffness=0.4}, length={5,12}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.6*nf(x*2, y*2) end,
  piles={{fallwhite, function(x,y) return clamp(1 - (y - 870)/45, 0.15, 1) * 1.5 end},
         {foamsh, function(x,y) return 0.35 + clamp((y - 900)/25, 0, 1) end},
         {haze, function(x,y) return 0.25*clamp((math.abs(x - 486) - 120)/80, 0, 1) end}}})
-- lumpy lit tops
local rb = brush{kind="round", width=6, stiffness=0.4, lay=2}
for k = 1, 34 do
  local x = rand(345, 640)
  local y = 868 + rand(-4, 10)
  if foamM:at(x, y + 4) > 0.5 then
    rb:reload((k % 4 == 0) and glow or fallwhite, 0.8)
    local w = rand(4, 10)
    rb:stroke({{x - w, y + 3}, {x, y - rand(1, 3)}, {x + w, y + 3}}, {pressure={0.5, 0.3}, clip=foamM:grow(4)})
  end
end
-- lower half dissolves into the pool
blend(foamM * mask(function(x, y) return clamp((y - 905)/12, 0, 1) end):grow(6), {angle=0.0})

--@ chunk 277
local nf = noise{seed=6401, period=18, octaves=3}
-- keep a smaller core; repaint the rest of the slab with pool colour
local core = mask(function(x, y)
  local dx = (x - 488) / 150
  local dy = (y - 884) / 22
  return clamp((1 - (dx*dx + dy*dy)) * 2 + 0.7*nf(x, y), 0, 1)
end)
local outer = (foamM:grow(6) - core) * below(function(x) return 866 end)
outer = outer - fgRock - rockFace * above(function(x) return 905 end)
local function inPool(x, y) return y > 908 end
work(outer, {hand="body", tool={kind="flat", width=8, stiffness=0.5}, length={14,34}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return inPool(x,y) and math.pi/2 or 1.5 end,
  piles={{waterdark, function(x,y) return inPool(x,y) and 1 or 0.5 end},
         {lent, function(x,y) return inPool(x,y) and 0.4 or 1 end},
         {haze, function(x,y) return (inPool(x,y) and columnM:at(x, y) or 0) * 0.9 end},
         {foamsh, function(x,y) return inPool(x,y) and 0.25 or 0 end}}})
blend((foamM:grow(14)):soften(8) - fgRock, {angle=0.0})
blend((foamM:grow(14)):soften(8) - fgRock, {angle=math.pi/2})

--@ chunk 278
palette{scrape={thinwhite, nearbank}}
local WL = 906
local nz = noise{seed=6501, period=40, octaves=2}
local rz = (rect(255, 846, 470, WL - 846 + 2) - newFalls:shrink(1)) - fgRock
work(rz, {hand="body", tool={kind="filbert", width=8, stiffness=0.6}, length={10,26}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.5 + 0.3*nz(x,y) end, piles={{lent, 1}, {rock, 0.8}, {waterdark, 0.4}}})
local pz = rect(250, WL, 480, 70) - fgRock
work(pz, {hand="body", tool={kind="flat", width=10, stiffness=0.5}, length={20,50}, coverage=4, fill=true, clip=true, load=1.0,
  angle=math.pi/2,
  piles={{waterdark, function(x,y) return 1 - 0.7*columnM:at(x,y) end},
         {lent, function(x,y) return (1 - columnM:at(x,y)) * 0.6 * clamp(1 - (y - WL)/50, 0, 1) end},
         {haze, function(x,y) return columnM:at(x,y) * 0.8 end},
         {foamsh, function(x,y) return columnM:at(x,y) * 0.5 end}}})
restate_boulder(BLD[6], bmasks[6])
restate_boulder(BLD[8], bmasks[8])
print(drying(480, 880))

--@ chunk 279
restate_boulder(BLD[5], bmasks[5])
restate_boulder(BLD[7], bmasks[7])
local pz = (rect(250, 908, 480, 66) - fgRock)
blend(pz, {angle=math.pi/2})
blend(pz, {angle=0.0})
blend(pz, {angle=math.pi/2})

--@ chunk 280
palette{scrape={glassy}}
poolmid = mix{{waterdark,0.66},{amber,0.15},{haze,0.15},{deeprust,0.06}, name="poolmid"}
print(palette())

--@ chunk 281
palette{scrape={mossdark}}
colmid = mix{{haze,0.55},{amber,0.12},{waterdark,0.3},{foamsh,0.03}, name="colmid"}
local WL = 906
local ns = noise{seed=6601, period=10, octaves=2, stretch={math.pi/2, 6}}
local strip = rect(250, WL, 480, 72) - fgRock
local function C(x, y) return columnM:at(x, y) end
local function side(x) return clamp((math.abs(x - 486) - 140) / 40, 0, 1) end
work(strip, {hand="body", tool={kind="flat", width=9, stiffness=0.5}, length={20,50}, coverage=4.5, fill=true, clip=true, load=1.0,
  angle=math.pi/2,
  piles={{poolmid, function(x,y) return (1 - C(x,y)) end},
         {waterdark, function(x,y) return (1 - C(x,y)) * side(x) * clamp(1 - (y - WL)/50, 0, 1) * 1.2 end},
         {lent, function(x,y) return (1 - C(x,y)) * side(x) * clamp(1 - (y - WL)/35, 0, 1) * 0.6 end},
         {colmid, function(x,y) return C(x,y) * (0.8 + 0.4*ns:at01(x,y)) end},
         {foamsh, function(x,y) return C(x,y) * 0.35 * clamp(1 - (y - WL)/40, 0, 1) end}}})
blend(strip, {angle=math.pi/2})

--@ chunk 282
local WL = 906
local strip = rect(250, WL, 480, 72) - fgRock
local sideM = strip * mask(function(x, y) return clamp((math.abs(x - 486) - 120) / 60, 0, 1) * (1 - columnM:at(x, y)) end)
work(sideM, {hand="body", tool={kind="flat", width=8, stiffness=0.5}, length={20,45}, coverage=4, fill=true, clip=true, load=1.0,
  angle=math.pi/2,
  piles={{waterdark, 1}, {poolmid, function(x,y) return 0.3 + 0.7*clamp((y - WL - 30)/40, 0, 1) end}, {lent, function(x,y) return 0.35*clamp(1 - (y - WL)/50, 0, 1) end}}})
blend(strip, {angle=math.pi/2})

--@ chunk 283
palette{scrape={mossdeep, rock}}
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
leafshade = pile{{"red earth",2},{"raw umber",2.5},{"vermilion",0.2}, name="leafshade"}
print(palette())

--@ chunk 284
local WL = 906
local nb = noise{seed=6701, period=30, octaves=2}
local nv = noise{seed=6702, period=25, octaves=2}
poolAll = below({{-10,WL},{1010,WL}}) - (bmasks[5] + bmasks[6] + bmasks[7] + bmasks[8] + bmasks[9]) - fgRock
print(poolAll:area())
local function dB(x, y)
  local dx = math.abs(x - 486)
  if dx < 120 then return 0 end
  local len = 45 + 35 * nb:at01(x, 0) + 15 * nb(x * 3, 7)
  return clamp((WL + len * clamp((dx - 120)/30, 0, 1) - y) / 14, 0, 1)
end
local function C(x,y) return columnM:at(x,y) end
local function Wd(x,y) return wedgeM:at(x,y) end
local function LR(x,y) return math.max(reflL:at(x,y), reflR:at(x,y)) end
local function B(x,y) return math.max(birchRA:at(x,y), birchRB:at(x,y)) end
local function rest(x,y) return clamp(1 - C(x,y) - Wd(x,y) - LR(x,y) - B(x,y), 0, 1) end
work(poolAll, {hand="body", tool={kind="flat", width=11, stiffness=0.5}, length={25,70}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.03*nv(x,y) end,
  piles={{lent, function(x,y) return dB(x,y) * 0.5 end},
         {waterdark, function(x,y) return dB(x,y) + rest(x,y) * (1 - dB(x,y)) * 0.35 end},
         {poolmid, function(x,y) return rest(x,y) * (1 - dB(x,y)) end},
         {colmid, function(x,y) return C(x,y) * (1 - Wd(x,y)) * (1 - dB(x,y)) end},
         {foamsh, function(x,y) return C(x,y) * clamp(1 - (y - WL)/50, 0, 1) * 0.6 end},
         {glow, function(x,y) return Wd(x,y) * clamp(0.9 - 0.6*math.abs(x - 500)/150, 0, 1) end},
         {amber, function(x,y) return Wd(x,y) * 0.7 + LR(x,y) * 0.15 end},
         {haze, function(x,y) return Wd(x,y) * 0.3 + B(x,y) * 0.7 end},
         {birch, function(x,y) return B(x,y) * 0.35 end},
         {leafshade, function(x,y) return LR(x,y) * (1 - B(x,y)) * 0.8 end},
         {orangeleaf, function(x,y) return LR(x,y) * (1 - B(x,y)) * 0.4 * clamp((nv:at01(x+40,y) - 0.4)*3, 0, 1) end},
         {deeprust, function(x,y) return LR(x,y) * (1 - B(x,y)) * 0.5 end}}})
print(drying(486, 1000))

--@ chunk 285
blend(poolAll, {angle=math.pi/2})
blend(poolAll, {angle=math.pi/2 + 0.04})

--@ chunk 286
-- (a) rock overlapping the lip corners so each lip arches
local corners = nil
for i = 1, 4 do
  local top = nTop[i]
  local L, R = nx(i, 0, top + 2), nx(i, 1, top + 2)
  local w = R - L
  local cw = math.min(10, w * 0.25)
  local function arch(x, y)
    local t = (x - L) / w
    local yarch = top - 2 + 14 * (2*t - 1)^4
    return (x >= L - 3 and x <= R + 3 and y < yarch and y > top - 8) and 1 or 0
  end
  local m = mask(arch)
  corners = corners and (corners + m) or m
end
work(corners, {hand="body", tool={kind="round", width=4, stiffness=0.6}, length={4,10}, coverage=4, fill=true, clip=true, load=1.0,
  angle=1.5, piles={{lent, 1}, {waterdark, 0.4}}})
-- (b) merge the lip band into the falling water
for i = 1, 4 do
  local top = nTop[i]
  local band = NS[i] * mask(function(x, y) return clamp(1 - math.abs(y - (top + 12))/10, 0, 1) end)
  blend(band, {angle=math.pi/2})
end
-- (c) bright arched crest
local rb = brush{kind="round", width=2.5, point=0.5}
for i = 1, 4 do
  local top = nTop[i]
  local L, R = nx(i, 0, top + 2), nx(i, 1, top + 2)
  local w = R - L
  local pts = {}
  for k = 0, 6 do
    local t = 0.08 + 0.84 * k / 6
    pts[#pts+1] = {L + w * t, top - 1 + 14 * (2*t - 1)^4 + 1, (k == 0 or k == 6) and 0.1 or 0.6}
  end
  rb:reload(glow, 0.7)
  rb:gesture(pts, {wobble=0.3})
end

--@ chunk 287
for i = 1, 4 do print(i, nTop[i], nx(i, 0, nTop[i] + 2), nx(i, 1, nTop[i] + 2), nx(i, 0, nTop[i] + 8), nx(i, 1, nTop[i] + 8)) end

--@ chunk 288
lips = {{385,433,671},{453,511,656},{521,537,678},{548,591,664}}
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local bgm = nil
for _, l in ipairs(lips) do
  local L, R, top = l[1], l[2], l[3]
  local w = R - L
  local m = mask(function(x, y)
    local t = (x - L) / w
    if t < 0.12 or t > 0.88 then return 0 end
    local ya = top - 1 + 12 * (2*t - 1)^4
    return (y > top - 16 and y < math.min(ya, top + 6) - 0.5) and 1 or 0
  end)
  bgm = bgm and (bgm + m) or m
end
work(bgm, {hand="body", tool={kind="flat", width=4, stiffness=0.5}, length={6,14}, coverage=4, fill=true, clip=true, load=1.0, angle=0.0,
  piles={{haze, 1}, {amber, 0.45}, {glow, 0.9}}})
-- bright crest restated on the arch
local rb = brush{kind="round", width=2.5, point=0.5}
for _, l in ipairs(lips) do
  local L, R, top = l[1], l[2], l[3]
  local w = R - L
  local pts = {}
  for k = 0, 6 do
    local t = 0.12 + 0.76 * k / 6
    pts[#pts+1] = {L + w * t, top - 1 + 12 * (2*t - 1)^4 + 0.8, (k == 0 or k == 6) and 0.1 or 0.6}
  end
  rb:reload(glow, 0.7)
  rb:gesture(pts, {wobble=0.3})
end

--@ chunk 289
local slotZone = mask(function(x, y)
  for _, l in ipairs(lips) do
    if x > l[1] - 2 and x < l[2] + 2 and y > 596 and y < l[3] + 1 then return 1 end
  end
  return 0
end) - rockFace:shrink(1)
blend(slotZone:soften(2), {angle=math.pi/2})
blend(slotZone:soften(2), {angle=0.0})
blend((rect(370, 560, 240, 60)):soften(20) - rockFace, {angle=math.pi/2})

--@ chunk 290
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local above = mask(function(x, y)
  if x < 370 or x > 615 or y < 560 then return 0 end
  for _, l in ipairs(lips) do
    if x > l[1] - 1 and x < l[2] + 1 then return (y < l[3] + 0.5 - 12 * (0) ) and 1 or 0 end
  end
  return 1
end) - rockFace - newFalls
work(above, {hand="body", tool={kind="flat", width=7, stiffness=0.5}, length={14,34}, coverage=4, fill=true, clip=true, load=1.0,
  angle=math.pi/2,
  piles={{glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/260)^1.2 * 1.2 end},
         {haze, 0.9},
         {amber, function(x,y) return 0.5 end},
         {deeprust, function(x,y) return 0.12 + 0.3*clamp((y - 630)/40, 0, 1) end}}})
blend((above:grow(3) + rect(360, 540, 260, 40)):soften(6) - rockFace, {angle=math.pi/2})

--@ chunk 291
local WL = 906
local nb = noise{seed=6701, period=30, octaves=2}
local nv = noise{seed=6702, period=25, octaves=2}
local fix = (rect(330, WL, 320, 1250 - WL)) * poolAll
print(fix:area())
local function dB(x, y)
  local dx = math.abs(x - 486)
  if dx < 120 then return 0 end
  local len = 45 + 35 * nb:at01(x, 0) + 15 * nb(x * 3, 7)
  return clamp((WL + len * clamp((dx - 120)/30, 0, 1) - y) / 14, 0, 1)
end
local function C(x,y) return columnM:at(x,y) end
local function Wd(x,y) return wedgeM:at(x,y) end
local function LR(x,y) return math.max(reflL:at(x,y), reflR:at(x,y)) end
local function rest(x,y) return clamp(1 - C(x,y) - Wd(x,y) - LR(x,y), 0, 1) end
-- pillars reflect as dark verticals inside the column
local function pil(x, y)
  if y > 1000 then return 0 end
  local v = 0
  for _, p in ipairs({{445, 14}, {518, 5}, {542, 5}}) do v = math.max(v, clamp(1 - math.abs(x - p[1]) / p[2], 0, 1)) end
  return v * clamp(1 - (y - WL)/90, 0, 1)
end
work(fix, {hand="body", tool={kind="flat", width=10, stiffness=0.5}, length={25,70}, coverage=4.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.03*nv(x,y) end,
  piles={{lent, function(x,y) return dB(x,y) * 0.5 + pil(x,y) * 0.6 end},
         {waterdark, function(x,y) return dB(x,y) + rest(x,y) * (1 - dB(x,y)) * 0.35 + pil(x,y) end},
         {poolmid, function(x,y) return rest(x,y) * (1 - dB(x,y)) end},
         {colmid, function(x,y) return C(x,y) * (1 - Wd(x,y)) * (1 - dB(x,y)) * (1 - pil(x,y)) end},
         {foamsh, function(x,y) return C(x,y) * clamp(1 - (y - WL)/50, 0, 1) * 0.6 end},
         {glow, function(x,y) return Wd(x,y) * clamp(0.9 - 0.6*math.abs(x - 500)/150, 0, 1) end},
         {amber, function(x,y) return Wd(x,y) * 0.7 + LR(x,y) * 0.15 end},
         {haze, function(x,y) return Wd(x,y) * 0.3 end},
         {leafshade, function(x,y) return LR(x,y) * 0.8 end},
         {deeprust, function(x,y) return LR(x,y) * 0.5 end}}})
blend(fix:soften(6), {angle=math.pi/2})

--@ chunk 292
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local box = (rect(340, 520, 300, 150) - rockFace - bankClumpM:grow(2) - newFalls - headL2 - headR2)
print(box:area())
work(box, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, length={20,50}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.5 + 0.15*math.sin(x/37) end,
  piles={{glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/240)^1.2 * 1.3 end},
         {haze, function(x,y) local d=dist(x,y); return 0.6 + math.exp(-((d-200)/110)^2) end},
         {amber, function(x,y) local d=dist(x,y); return 0.5*math.exp(-((d-330)/120)^2) + 0.15 end},
         {deeprust, function(x,y) return 0.15*clamp((y - 600)/60, 0, 1) end}}})
local soft = (rect(320, 480, 340, 200)):soften(30) - rockFace - bankClumpM - newFalls
blend(soft, {angle=math.pi/2})
blend(soft, {angle=math.pi/2 + 0.2})

--@ chunk 293
for _, y in ipairs({460, 490, 505, 520, 540}) do print(y, drying(450, y), drying(350, y), drying(600, y)) end

--@ chunk 294
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local band = (below(function(x) return 470 end) * above(function(x) return 545 end) * rect(300, 0, 380, 1250)) - rockFace - bankClumpM:grow(2) - mTL2:grow(2)
work(band, {hand="body", tool={kind="filbert", width=10, stiffness=0.5}, length={20,50}, coverage=3.5, fill=true, clip=true, load=0.9,
  angle=function(x,y) return 1.5 + 0.15*math.sin(x/37) end,
  piles={{glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/240)^1.2 * 1.3 end},
         {haze, function(x,y) local d=dist(x,y); return 0.6 + math.exp(-((d-200)/110)^2) end},
         {amber, function(x,y) local d=dist(x,y); return 0.5*math.exp(-((d-330)/120)^2) + 0.15 end}}})
local soft = band:soften(14)
blend(soft, {angle=math.pi/2})
blend(soft, {angle=math.pi/2 - 0.2})

--@ chunk 295
local function crestY(x) return (x < 486) and topy(LA_top, x) or topy(RA_top, x) end
gz3 = (mask(function(x, y) return (y > 60 and y < crestY(x) + 10) and 1 or 0 end)
      - (canopy + clumpU):shrink(4) - bankClumpM:grow(1) - undergrowth - rockFace - newFalls
      - mA:grow(2) - mB:grow(2) - mTL:grow(2) - mL1:grow(2) - mL2:grow(2) - mTL2:grow(2) - headL2 - headR2)
print(gz3:area())

--@ chunk 296
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local function crestY(x) return (x < 486) and topy(LA_top, x) or topy(RA_top, x) end
local nz = noise{seed=6901, period=70, octaves=2}
work(gz3, {hand="body", tool={kind="filbert", width=14, stiffness=0.5}, length={30,80}, coverage=3.5, fill=true, load=1.0, clip=gz3:grow(2),
  angle=function(x,y) return 1.5 + 0.15*math.sin(x/90) + 0.12*math.sin(y/60) end,
  piles={{glow, function(x,y) local d=dist(x,y); return math.max(0, 1 - d/220)^1.3 * 1.8 end},
         {haze, function(x,y) local d=dist(x,y); return math.exp(-((d-190)/120)^2) * 1.1 end},
         {amber, function(x,y) local d=dist(x,y); return math.exp(-((d-330)/120)^2) end},
         {deeprust, function(x,y) local d=dist(x,y); return math.exp(-((d-470)/130)^2) * (0.7 + 0.5*nz:at01(x,y)) end},
         {brushdark, function(x,y) local d=dist(x,y); return 0.7*math.max(0, (d-460)/260) + 0.4*clamp((y - crestY(x) + 50)/50, 0, 1) * clamp((math.abs(x-486) - 150)/150, 0, 1) end}}})
for _, a in ipairs({math.pi/2, math.pi/2 + 0.2, math.pi/2 - 0.2}) do blend(gz3:soften(6), {angle=a}) end

--@ chunk 297
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local can = (canopy + clumpU)
local nE = noise{seed=7001, period=45, octaves=2}
local nh = noise{seed=7002, period=12, octaves=2}
local runs = mask(function(x, y) return clamp((nE:at01(x, y) - 0.4) * 4, 0, 1) end)
local fringe = (gz3 * can:grow(22) * runs) * mask(function(x,y) return clamp((nh:at01(x,y) - 0.35)*3, 0, 1) end)
print(fringe:area())
work(fringe, {hand="body", tool={kind="filbert", width=6, stiffness=0.5}, length={4,9}, coverage=1.4, load=0.8, clip=gz3:grow(3),
  angle=function(x,y) return 1.57 + rand(-1.2, 1.2) end,
  piles={{orangeleaf, 0.6}, {glow, function(x,y) return clamp(1 - (dist(x,y) - 150)/200, 0.2, 1) end}, {amber, 0.4}}})
local eb = (gz3 * can:grow(26) * runs):soften(6)
blend(eb, {angle=0.7, clip=false})
blend(eb, {angle=2.4, clip=false})

--@ chunk 298
print(palette())

--@ chunk 299
palette{scrape={colmid, poolmid}}
leafrust = pile{{"red earth",2},{"vermilion",0.6},{"yellow ochre",1.2}, name="leafrust"}
local protect = mA:grow(4) + mB:grow(4) + mTL:grow(3) + mL1:grow(3) + mL2:grow(3) + mTL2:grow(3)
local edgeClumps = {{205,95,26,18},{248,70,22,15},{300,60,18,12},{560,72,24,16},{612,110,22,16},{640,150,20,14},{600,195,26,16},
  {665,215,20,14},{700,260,18,12},{690,320,22,14},{740,345,20,13},{205,170,20,14},{180,220,22,15},{140,260,26,15},{60,280,30,16},{12,300,22,14},
  {780,380,24,14}}
for i, c in ipairs(edgeClumps) do
  local cx, cy, rx, ry = c[1], c[2], c[3], c[4]
  local m = clump_mask(c, 7100 + i) - protect
  local function v(x, y) return (y - cy) / ry end
  work(m, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={4,9}, coverage=2.5, fill=true, edge="loose", load=0.9,
    angle=function(x,y) return 1.57 + 0.9*math.sin(x/5 + y/4) end,
    piles={{goldleaf, function(x,y) return clamp(-v(x,y) + 0.2, 0, 1) end},
           {orangeleaf, 0.7},
           {leafrust, function(x,y) return clamp(v(x,y) + 0.2, 0, 1) end},
           {deeprust, function(x,y) return clamp(v(x,y) - 0.2, 0, 1) end}}})
end
local rg = brush{kind="rigger", width=2.2, point=0.9}
local twigs = {
  {{230,120,0.7},{262,108,0.5},{290,112,0.35},{318,104,0.1}},
  {{250,75,0.6},{270,92,0.4},{292,96,0.1}},
  {{595,120,0.7},{565,138,0.5},{540,150,0.3},{512,148,0.05}},
  {{640,240,0.7},{610,250,0.5},{580,246,0.3},{556,256,0.05}},
  {{170,240,0.6},{200,252,0.4},{222,250,0.1}},
}
for _, t in ipairs(twigs) do
  rg:reload(brushdark, 0.6)
  rg:gesture(t, {wobble=0.6})
end

--@ chunk 300
local protect = mA:grow(4) + mB:grow(4) + mTL:grow(3) + mL1:grow(3) + mL2:grow(3) + mTL2:grow(3)
local edgeClumps = {{205,95,26,18},{248,70,22,15},{300,60,18,12},{560,72,24,16},{612,110,22,16},{640,150,20,14},{600,195,26,16},
  {665,215,20,14},{700,260,18,12},{690,320,22,14},{740,345,20,13},{205,170,20,14},{180,220,22,15},{140,260,26,15},{60,280,30,16},{12,300,22,14},
  {780,380,24,14}}
local pm = nil
for i, c in ipairs(edgeClumps) do local m = clump_mask(c, 7100 + i); pm = pm and (pm + m) or m end
local z = (pm:grow(12)):soften(10) - protect
for _, a in ipairs({0.7, 2.3, 1.5, 0.2}) do blend(z, {angle=a}) end
-- twigs: soften
local tz = (ribbon({{230,120},{262,108},{290,112},{318,104}}, 10) + ribbon({{250,75},{270,92},{292,96}}, 10) + ribbon({{595,120},{565,138},{540,150},{512,148}}, 10)
  + ribbon({{640,240},{610,250},{580,246},{556,256}}, 10) + ribbon({{170,240},{200,252},{222,250}}, 10)):soften(4)
blend(tz, {angle=0.2})

--@ chunk 301
windowO = outline{{0,300},{40,286},{90,270},{130,250},{168,212},{196,180},{214,140},{232,104},{262,80},{300,66},{340,58},{390,62},{440,56},{486,62},{520,80},{540,112},{556,150},{572,190},{596,226},{622,262},{650,290},{690,312},{730,330},{770,342},{810,350},{860,352},{1010,350},{1010,700},{0,700}, char="soft", seed=7201, amount=0.9, lobe=22}
windowM = windowO:mask()
canopyBand = (windowM:grow(110) - windowM) * above(function(x) return 470 end)
print(canopyBand:area())

--@ chunk 302
local protect = mA:grow(4) + mB:grow(4) + mTL:grow(3) + mL1:grow(3) + mL2:grow(3) + mTL2:grow(3)
local band = canopyBand - protect
local dW = windowM:blur(40)   -- ~1 at window interior, falls off into canopy
local hn = noise{seed=7301, period=60, octaves=3, persistence=0.5}
local hn2 = noise{seed=7302, period=22, octaves=2}
local function sh(x, y)
  local e = 4
  local dx = (hn(x+e, y) - hn(x-e, y)) / (2*e)
  local dy = (hn(x, y+e) - hn(x, y-e)) / (2*e)
  local lx, ly = gx - x, (gy - 60) - y
  local l = math.sqrt(lx*lx + ly*ly) + 1e-6
  return clamp(0.5 + 30*(dx*lx/l + dy*ly/l) + 0.15*hn(x,y), 0, 1)
end
local function near(x, y) return clamp(dW:at(x, y) * 2.2, 0, 1) end
work(band, {hand="body", tool={kind="filbert", width=8, stiffness=0.5}, length={6,14}, coverage=2.8, fill=true, edge="loose", load=0.9,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/9 + y/7) end,
  piles={{goldleaf, function(x,y) return near(x,y) * clamp((sh(x,y) - 0.45)*3, 0, 1) * 1.2 end},
         {orangeleaf, function(x,y) return (0.3 + near(x,y)) * math.exp(-((sh(x,y) - 0.5)/0.25)^2) end},
         {leafrust, function(x,y) return math.exp(-((sh(x,y) - 0.4)/0.2)^2) * 0.8 end},
         {deeprust, function(x,y) return (1 - near(x,y)) * 0.6 end},
         {leafshade, function(x,y) return clamp(0.45 - sh(x,y), 0, 1) * 2 * (1 - 0.5*near(x,y)) end}}})
print("ok")

--@ chunk 303
local protect = mA:grow(4) + mB:grow(4) + mTL:grow(3) + mL1:grow(3) + mL2:grow(3) + mTL2:grow(3)
blend((canopyBand:shrink(4) - protect):soften(5), {angle=1.2})
local edge = ((windowM:grow(14) - windowM:shrink(30)) * above(function(x) return 420 end) - protect):soften(8)
blend(edge, {angle=0.7})
blend(edge, {angle=2.4})

--@ chunk 304
-- 1. veil of water crossing the left gap once, lower down
local gapZone = rect(436, 770, 40, 136) - NS[1] - NS[2]
local fan = brush{kind="fan", width=12, stiffness=0.5}
for k = 1, 6 do
  if k % 2 == 1 then fan:reload(fallwhite, 0.32) end
  local x0 = rand(432, 444)
  local y0 = rand(780, 805)
  fan:stroke({{x0, y0}, {x0 + 10, y0 + 30}, {x0 + 22, y0 + rand(70, 100)}}, {pressure={0.4, 0.15}, orient="across", clip=(gapZone + NS[1] + NS[2]):grow(1)})
end
-- 2. broken white low, irregular, with small dark breaks
local nn = noise{seed=7401, period=8, octaves=3}
local low = newFalls:grow(3) * mask(function(x, y) return clamp((y - 835)/20, 0, 1) * clamp((906 - y)/6, 0, 1) end)
local rb = brush{kind="round", width=5, stiffness=0.4, lay=2}
for k = 1, 70 do
  local x, y = rand(350, 625), rand(838, 902)
  if low:at(x, y) > 0.5 then
    if nn:at01(x, y) > 0.45 then
      rb:reload((k % 4 == 0) and glow or fallwhite, 0.7)
      local a = rand(-0.6, 0.6)
      rb:stroke({{x, y}, {x + 6*math.cos(a), y + 3*math.sin(a) - 2}}, {pressure=rand(0.4, 0.7), clip=low})
    else
      rb:reload(foamsh, 0.5)
      rb:stroke({{x, y}, {x + rand(-2,2), y + rand(4, 8)}}, {pressure=rand(0.3, 0.5), clip=low})
    end
  end
end
-- 3. spray at the outer feet, flaring out
local rs = brush{kind="round", width=3, point=0.7}
for k = 1, 18 do
  local left = (k % 2 == 0)
  local y0 = rand(820, 890)
  local x0 = left and nx(1, 0, y0) or nx(4, 1, y0)
  local dir = left and -1 or 1
  rs:reload((k % 3 == 0) and foamsh or fallwhite, 0.5)
  local s = rand(6, 18)
  rs:gesture({{x0 - dir*2, y0, 0.4}, {x0 + dir*s*0.5, y0 + rand(4, 10), 0.4}, {x0 + dir*s, y0 + rand(10, 20), 0.0}}, {wobble=1})
end

--@ chunk 305
-- 4. pool strip under the falls: vertical breaks and foam threads
local WL = 906
local ns = noise{seed=7501, period=9, octaves=2, stretch={math.pi/2, 7}}
local strip = rect(330, WL + 1, 320, 70) - fgRock
local fb = brush{kind="flat", width=5, stiffness=0.5}
for k = 1, 28 do
  local x = rand(340, 640)
  local inCol = columnM:at(x, WL + 20) > 0.5
  fb:reload(inCol and ((k % 2 == 0) and waterdark or haze) or waterdark, 0.5)
  local len = rand(20, 60)
  fb:stroke({{x, WL + 2}, {x + rand(-1, 1), WL + 2 + len}}, {pressure={0.45, 0.15}, orient="across", clip=strip})
end
-- foam threads drifting out on the surface
local rr = brush{kind="round", width=2.5, point=0.6}
for k = 1, 16 do
  local y = WL + rand(4, 60)
  local x = rand(330, 650)
  local len = rand(18, 50)
  rr:reload(fallwhite, 0.45)
  rr:gesture({{x - len/2, y, 0.05}, {x, y + rand(-1, 1), 0.45}, {x + len/2, y + rand(-1,1), 0.05}}, {wobble=0.8, clip=strip})
end
blend(strip, {angle=math.pi/2})

--@ chunk 306
local low = (newFalls:grow(14) * mask(function(x, y) return clamp((y - 830)/15, 0, 1) end) * above(function(x) return 905 end))
for _, a in ipairs({0.0, math.pi/2, 0.6, 2.5}) do blend(low, {angle=a}) end
-- pool strip edges
local se = (rect(300, 908, 70, 80) + rect(610, 908, 70, 80)):soften(10) - fgRock
blend(se, {angle=0.0})
blend(se, {angle=math.pi/2})
blend(rect(330, 908, 320, 80):soften(10) - fgRock, {angle=math.pi/2})

--@ chunk 307
local WL = 906
local nz = noise{seed=7601, period=30, octaves=2}
-- 1. dark rock back around the strand feet
local zone = rect(330, 815, 320, WL - 815 + 1)
local rockz = zone - newFalls - fgRock
work(rockz, {hand="body", tool={kind="filbert", width=7, stiffness=0.6}, length={10,24}, coverage=4.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.5 + 0.3*nz(x,y) end, piles={{lent, 1}, {waterdark, 0.6}, {brushdark, 0.25}}})
-- 2. strands continue to the foam line
for i = 1, 4 do
  local clipm = NS[i] * zone
  local fan = brush{kind="fan", width=(i == 3) and 7 or 11, stiffness=0.5}
  for k = 1, ((i == 3) and 4 or 10) do
    if k % 2 == 1 then fan:reload((k % 3 == 0) and foamsh or fallwhite, 0.4) end
    local tt = (k - 0.5) / ((i == 3) and 4 or 10)
    local y0 = 800
    local pts = {}
    for j = 0, 3 do local y = lerp(y0, WL, j/3); pts[#pts+1] = {nx(i, tt, y) + rand(-1, 1), y} end
    fan:stroke(pts, {pressure={0.5, 0.5}, orient="across", clip=clipm:grow(1)})
  end
end
print(drying(400, 880))

--@ chunk 308
local Z = rect(326, 806, 330, 104)
for pass = 1, 3 do
  local r = rag{width=30}
  r:dip(0.9)
  r:wipe(Z, {pressure=0.9, angle=math.pi/2, passes=2, refold=0.4})
  r = rag{width=30}
  r:dip(0.9)
  r:wipe(Z, {pressure=0.9, angle=0, passes=2, refold=0.4})
end
print(drying(400, 860), drying(480, 880), drying(600, 860))

--@ chunk 309
palette{scrape={goldleaf, leafrust, orangeleaf}}
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
mossdeep = pile{{"green earth",2},{"raw umber",1.2},{"yellow ochre",0.8},{"Prussian blue",0.1}, name="mossdeep"}
mossdark = pile{{"green earth",2},{"raw umber",1},{"Prussian blue",0.2},{"yellow ochre",1}, name="mossdark"}
function nxc(i, t, y) return nx(i, t, math.min(y, 898)) end
local WL = 906
local Zt = rect(326, 806, 330, WL - 806)
local nz = noise{seed=7701, period=30, octaves=2}
local rockz = Zt - newFalls
work(rockz, {hand="body", tool={kind="filbert", width=7, stiffness=0.6}, length={10,24}, coverage=4.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.5 + 0.3*nz(x,y) end, piles={{lent, 1}, {waterdark, 0.5}}})
for i = 1, 4 do
  local clipm = NS[i] * Zt
  local n = (i == 3) and 4 or 9
  local vb = brush{kind="flat", width=7, stiffness=0.5}
  for k = 1, n do
    vb:reload(foamsh, 0.6)
    local tt = (k - 0.5) / n
    local pts = {}
    for j = 0, 3 do local y = lerp(800, 904, j/3); pts[#pts+1] = {nxc(i, tt, y) + rand(-1, 1), y} end
    vb:stroke(pts, {pressure={0.5, 0.5}, orient="across", clip=clipm:grow(1)})
  end
  local fan = brush{kind="fan", width=(i == 3) and 7 or 10, stiffness=0.5}
  for k = 1, n do
    if k % 2 == 1 then fan:reload(fallwhite, 0.4) end
    local tt = clamp((k - 0.5) / n + rand(-0.05, 0.05), 0.03, 0.97)
    local pts = {}
    for j = 0, 3 do local y = lerp(796, 900, j/3); pts[#pts+1] = {nxc(i, tt, y) + rand(-1, 1), y} end
    fan:stroke(pts, {pressure={0.5, 0.3}, orient="across", clip=clipm:grow(1)})
  end
  blend(clipm, {angle=math.pi/2})
end
restate_boulder(BLD[6], bmasks[6])
restate_boulder(BLD[8], bmasks[8])

--@ chunk 310
for i = 1, 4 do
  local b = NS[i]:shrink(1) * mask(function(x, y) return clamp(1 - math.abs(y - 806)/22, 0, 1) end)
  blend(b, {angle=math.pi/2})
  blend(b, {angle=math.pi/2})
end
local rb = (rect(326, 760, 330, 146) - newFalls:grow(1) - bmasks[6] - bmasks[8])
work(rb, {hand="body", tool={kind="filbert", width=7, stiffness=0.6}, length={10,26}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=1.5, piles={{lent, 1}, {rock, 0.8}, {waterdark, 0.3}}})
blend(rb:shrink(1), {angle=math.pi/2})
-- lower strands: break the flat white with dark threads and foam-gray
local rd = brush{kind="round", width=3, point=0.6}
for i = 1, 4 do
  local clipm = NS[i]:shrink(1)
  for k = 1, ((i == 3) and 2 or 6) do
    rd:reload((k % 2 == 0) and foamsh or waterdark, 0.45)
    local tt = rand(0.1, 0.9)
    local y0 = rand(790, 840)
    local y1 = math.min(900, y0 + rand(30, 70))
    rd:gesture({{nxc(i, tt, y0), y0, 0.05}, {nxc(i, tt, (y0+y1)/2) + rand(-1,1), (y0+y1)/2, 0.5}, {nxc(i, tt, y1), y1, 0.0}}, {wobble=0.5, clip=clipm})
  end
end

--@ chunk 311
-- foam: low irregular mass along the base, a hand-drawn shape with explicit bounds
foamO2 = outline{{352,884},{368,876},{384,882},{400,872},{420,880},{440,876},{458,884},{474,874},{494,880},{514,872},{534,880},{552,874},{574,880},{596,872},{614,880},{628,892},{632,904},{600,910},{560,906},{520,912},{486,908},{446,912},{404,908},{366,910},{346,904}, char="soft", seed=7801, amount=0.7, lobe=7}
foamM2 = foamO2:mask() - bmasks[6] - bmasks[8]
print(foamM2:area())
local nf = noise{seed=7802, period=8, octaves=3}
work(foamM2, {hand="body", tool={kind="round", width=5, stiffness=0.4}, length={4,10}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.5*nf(x*2, y*2) end,
  piles={{fallwhite, function(x,y) return clamp(1 - (y - 874)/32, 0.2, 1) * 1.4 end},
         {foamsh, function(x,y) return 0.35 + clamp((y - 895)/12, 0, 1) end},
         {glow, 0.1}}})
local rbb = brush{kind="round", width=5, stiffness=0.4, lay=2}
for k = 1, 30 do
  local x = rand(355, 625)
  local y = 878 + rand(-4, 8)
  if foamM2:at(x, y + 3) > 0.5 then
    rbb:reload((k % 5 == 0) and glow or fallwhite, 0.8)
    local w = rand(3, 8)
    rbb:stroke({{x - w, y + 2}, {x, y - rand(1, 3)}, {x + w, y + 2}}, {pressure={0.5, 0.3}, clip=foamM2:grow(2)})
  end
end
blend(foamM2:shrink(2), {angle=0.0})

--@ chunk 312
local WL = 906
-- 1. flanks: repaint the rect edges into the bank tone
local flankL = outline{{318,750},{348,756},{356,800},{350,850},{344,880},{318,884},{310,820}, char="soft", seed=7901, amount=0.6}:mask() - newFalls - bmasks[6] - fgRock
local flankR = outline{{636,760},{668,752},{676,800},{672,850},{660,882},{632,880},{640,820}, char="soft", seed=7902, amount=0.6}:mask() - newFalls - bmasks[8] - bmasks[7]
local nz = noise{seed=7903, period=14, octaves=2}
work(flankL + flankR, {hand="body", tool={kind="filbert", width=6, stiffness=0.5}, length={5,12}, coverage=3.5, fill=true, edge="soft", load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{lent, function(x,y) return clamp(1 - (math.abs(x - 486) - 140)/40, 0, 1) end}, {brushdark, 0.8}, {leafshade, 0.5}, {deeprust, function(x,y) return 0.25*nz:at01(x,y) end}}})
-- 2. foam: shade its lower half gray, dissolve the bottom edge into the pool
local fl = foamM2 * mask(function(x, y) return clamp((y - 892)/10, 0, 1) end)
work(fl, {hand="body", tool={kind="round", width=5, stiffness=0.4}, length={5,12}, coverage=2, clip=true, load=0.9, angle=0.0,
  piles={{foamsh, 1}, {haze, 0.3}}})
local edgeZ = rect(350, 896, 282, 34) - bmasks[6] - bmasks[8] - fgRock
blend(edgeZ, {angle=math.pi/2})
blend(edgeZ, {angle=math.pi/2})
-- 3. pool under the falls: vertical reflection streaks
local pz = rect(340, WL + 12, 300, 110) - fgRock
local fb = brush{kind="flat", width=6, stiffness=0.5}
for k = 1, 30 do
  local x = rand(350, 625)
  local c = columnM:at(x, WL + 30)
  fb:reload((k % 3 == 0) and waterdark or ((c > 0.5) and haze or foamsh), 0.5)
  local y0 = WL + rand(10, 25)
  fb:stroke({{x, y0}, {x + rand(-1, 1), y0 + rand(40, 100)}}, {pressure={0.45, 0.15}, orient="across", clip=pz})
end
blend(pz:soften(8), {angle=math.pi/2})

--@ chunk 313
local flankL = outline{{318,750},{348,756},{356,800},{350,850},{344,880},{318,884},{310,820}, char="soft", seed=7901, amount=0.6}:mask() - newFalls - bmasks[6] - fgRock
local flankR = outline{{636,760},{668,752},{676,800},{672,850},{660,882},{632,880},{640,820}, char="soft", seed=7902, amount=0.6}:mask() - newFalls - bmasks[8] - bmasks[7]
local nz = noise{seed=8001, period=20, octaves=2}
work((flankL + flankR):grow(3) - newFalls - bmasks[6] - bmasks[7] - bmasks[8], {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,20}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.5 + 0.3*nz(x,y) end,
  piles={{lent, 1}, {rock, 0.6}, {brushdark, function(x,y) return 0.4*clamp((math.abs(x - 486) - 160)/30, 0, 1) end}}})
print(drying(300, 960), drying(500, 960), drying(700, 1000))

--@ chunk 314
local WL = 906
local nb = noise{seed=8101, period=30, octaves=2}
local nv = noise{seed=8102, period=25, octaves=2}
local ns = noise{seed=8103, period=10, octaves=2, stretch={math.pi/2, 7}}
local region = (rect(190, WL, 620, 190) * poolAll) - fgRock
local function fade(x, y)   -- 1 inside, smooth falloff to edges so weights blend into existing paint
  local fx_ = clamp(math.min(x - 190, 810 - x) / 60, 0, 1)
  local fy = clamp((1096 - y) / 60, 0, 1)
  return fx_ * fy
end
local function dB(x, y)
  local dx = math.abs(x - 486)
  if dx < 140 then return 0 end
  local len = 45 + 35 * nb:at01(x, 0) + 15 * nb(x * 3, 7)
  return clamp((WL + len * clamp((dx - 140)/30, 0, 1) - y) / 14, 0, 1)
end
-- column of falls reflection: soft width
local function col(x, y)
  local half = 140 - (y - WL) * 0.45
  return clamp((half - math.abs(x - 488)) / 30, 0, 1) * clamp((1060 - y)/50, 0, 1)
end
local function Wd(x, y) return wedgeM:at(x, y) end
work(region, {hand="body", tool={kind="flat", width=9, stiffness=0.5}, length={25,70}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.03*nv(x,y) end,
  piles={{lent, function(x,y) return dB(x,y) * 0.5 end},
         {waterdark, function(x,y) return dB(x,y) + (1 - col(x,y)) * (1 - Wd(x,y)) * 0.5 + col(x,y) * 0.3 * clamp((0.4 - ns:at01(x,y))*3, 0, 1) end},
         {foamsh, function(x,y) return col(x,y) * (0.7 + 0.5*ns:at01(x,y)) * clamp(1 - (y - WL)/90, 0.3, 1) end},
         {haze, function(x,y) return col(x,y) * 0.6 + Wd(x,y) * 0.4 end},
         {amber, function(x,y) return Wd(x,y) * 0.6 + (1 - col(x,y)) * (1 - dB(x,y)) * 0.15 end},
         {glow, function(x,y) return Wd(x,y) * 0.6 end},
         {brushdark, function(x,y) return (1 - col(x,y)) * (1 - dB(x,y)) * (1 - Wd(x,y)) * 0.4 end}}})
blend(region:shrink(2), {angle=math.pi/2})

--@ chunk 315
palette{scrape={rock, fallwhite, mossdeep, mossdark}}
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
local WL = 906
local nb = noise{seed=6701, period=30, octaves=2}
local nv = noise{seed=6702, period=25, octaves=2}
local ns = noise{seed=8203, period=10, octaves=2, stretch={math.pi/2, 7}}
poolAll2 = below({{-10,WL},{1010,WL}}) - (bmasks[5] + bmasks[6] + bmasks[7] + bmasks[8] + bmasks[9]) - fgRock
local function dB(x, y)
  local dx = math.abs(x - 486)
  if dx < 140 then return 0 end
  local len = 45 + 35 * nb:at01(x, 0) + 15 * nb(x * 3, 7)
  return clamp((WL + len * clamp((dx - 140)/30, 0, 1) - y) / 14, 0, 1)
end
local function C(x,y) return columnM:at(x,y) end
local function Wd(x,y) return wedgeM:at(x,y) end
local function LR(x,y) return math.max(reflL:at(x,y), reflR:at(x,y)) end
local function B(x,y) return math.max(birchRA:at(x,y), birchRB:at(x,y)) end
local function rest(x,y) return clamp(1 - C(x,y) - Wd(x,y) - LR(x,y) - B(x,y), 0, 1) end
work(poolAll2, {hand="body", tool={kind="flat", width=11, stiffness=0.5}, length={25,70}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.03*nv(x,y) end,
  piles={{lent, function(x,y) return dB(x,y) * 0.5 end},
         {waterdark, function(x,y) return dB(x,y) + rest(x,y) * (1 - dB(x,y)) * 0.35 + C(x,y) * 0.35 * clamp((0.4 - ns:at01(x,y))*3, 0, 1) end},
         {poolmid, function(x,y) return rest(x,y) * (1 - dB(x,y)) end},
         {colmid, function(x,y) return C(x,y) * (1 - Wd(x,y)) * (1 - dB(x,y)) end},
         {foamsh, function(x,y) return C(x,y) * clamp(1 - (y - WL)/60, 0, 1) * (0.5 + 0.5*ns:at01(x,y)) end},
         {glow, function(x,y) return Wd(x,y) * clamp(0.9 - 0.6*math.abs(x - 500)/150, 0, 1) end},
         {amber, function(x,y) return Wd(x,y) * 0.7 + LR(x,y) * 0.15 end},
         {haze, function(x,y) return Wd(x,y) * 0.3 + B(x,y) * 0.7 end},
         {birch, function(x,y) return B(x,y) * 0.35 end},
         {leafshade, function(x,y) return LR(x,y) * (1 - B(x,y)) * 0.8 end},
         {orangeleaf, function(x,y) return LR(x,y) * (1 - B(x,y)) * 0.4 * clamp((nv:at01(x+40,y) - 0.4)*3, 0, 1) end},
         {deeprust, function(x,y) return LR(x,y) * (1 - B(x,y)) * 0.5 end}}})
blend(poolAll2, {angle=math.pi/2})
blend(poolAll2, {angle=math.pi/2 + 0.04})

--@ chunk 316
for _, p in ipairs({{100,1150},{200,1120},{50,1200},{260,1200}}) do print(p[1], p[2], drying(p[1], p[2])) end
print(palette())

--@ chunk 317
palette{scrape={colmid, poolmid}}
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
mossdeep = pile{{"green earth",2},{"raw umber",1.2},{"yellow ochre",0.8},{"Prussian blue",0.1}, name="mossdeep"}
mosslit3 = pile{{"yellow ochre",2},{"green earth",1.5},{"lead white",0.7},{"chrome yellow",0.3},{"raw umber",0.4}, name="mosslit3"}
-- new silhouette
fgTop2 = {{-10,1068},{40,1058},{110,1054},{150,1062},{176,1066},{214,1088},{236,1094},{262,1112},{284,1140},{298,1186},{306,1256}}
local pts = {{-10,1068},{40,1058},{110,1054},{150,1062,"c"},{176,1066},{214,1088,"c"},{236,1094},{262,1112},{284,1140,"c"},{298,1186},{306,1256},{-10,1256}}
fgRock2 = outline{pts=pts, char="broken", seed=8301, amount=0.4}:mask()
-- planes
topA = poly({{-10,1068},{40,1058},{110,1054},{150,1062},{176,1066},{214,1088},{200,1102},{150,1094},{90,1092},{30,1098},{-10,1104}}) * fgRock2
topB = poly({{214,1088},{236,1094},{262,1112},{284,1140},{268,1150},{240,1128},{214,1112},{200,1102}}) * fgRock2
faces = fgRock2 - topA - topB
print(fgRock2:area(), topA:area(), topB:area(), faces:area())

--@ chunk 318
topA = poly({{-10,1068},{40,1058},{110,1054},{150,1062},{176,1066},{214,1088},{206,1110},{160,1112},{100,1116},{40,1122},{-10,1126}}) * fgRock2
faces = fgRock2 - topA - topB
local nz = noise{seed=8401, period=22, octaves=3}
local nz2 = noise{seed=8402, period=50, octaves=2}
local function region(x, y)
  local c1 = 95 + (y - 1120) * 0.15
  local c2 = 210 + (y - 1110) * 0.25
  if x < c1 then return 1 elseif x < c2 then return 2 else return 3 end
end
work(faces, {hand="body", tool={kind="flat", width=9, stiffness=0.6}, length={14,34}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) local r = region(x,y); return (r == 1) and (1.75 + 0.2*nz(x,y)) or ((r == 2) and (1.5 + 0.2*nz(x,y)) or (1.2 + 0.2*nz(x,y))) end,
  piles={{lent, function(x,y) local r = region(x,y); return (r == 1) and 1.2 or ((r == 2) and 0.8 or 0.4) end},
         {rock, 1},
         {waterdark, function(x,y) return 0.4*nz:at01(x,y) end},
         {haze, function(x,y) return (region(x,y) == 3) and 0.25 or 0.04 end},
         {deeprust, function(x,y) return (region(x,y) == 3) and 0.3 or 0.08 end},
         {mossdeep, function(x,y) return 0.5*clamp((nz2:at01(x,y) - 0.55)*3, 0, 1) * clamp((1180 - y)/60, 0, 1) end}}})
local rd = brush{kind="round", width=4, point=0.5, stiffness=0.6}
rd:reload(lent, 0.8)
rd:gesture({{98, 1118, 0.8}, {104, 1160, 0.7}, {100, 1200, 0.5}, {108, 1256, 0.3}}, {wobble=1.2})
rd:reload(lent, 0.8)
rd:gesture({{208, 1108, 0.8}, {218, 1150, 0.6}, {228, 1200, 0.5}, {236, 1256, 0.2}}, {wobble=1.2})
rd:reload(lent, 0.7)
rd:gesture({{20, 1170, 0.2}, {60, 1176, 0.6}, {96, 1172, 0.2}}, {wobble=1})
work(topA, {hand="body", tool={kind="filbert", width=7, stiffness=0.5}, length={8,18}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.1 + 0.4*nz(x*2,y*2) end,
  piles={{mossdeep, 1}, {mosslit3, function(x,y) local t = topy(fgTop2, x); return clamp(1 - (y - t)/22, 0, 1) * clamp((nz2:at01(x*2,y*2) - 0.35)*3, 0, 1) end},
         {brushdark, function(x,y) local t = topy(fgTop2, x); return clamp((y - t - 30)/20, 0, 1) end}}})
work(topB, {hand="body", tool={kind="flat", width=6, stiffness=0.5}, length={8,18}, coverage=4, fill=true, clip=true, load=1.0,
  angle=0.7, piles={{mosslit3, 0.7}, {rim_warm, 0.5}, {mossdeep, 0.6}}})

--@ chunk 319
local nz = noise{seed=8501, period=14, octaves=2}
-- topB: mostly moss in shadow, lit only along its upper edge
work(topB, {hand="body", tool={kind="flat", width=5, stiffness=0.5}, length={6,14}, coverage=4, fill=true, clip=true, load=1.0, angle=0.75,
  piles={{mossdeep, 1}, {brushdark, 0.5}, {mosslit3, function(x,y) local t = topy(fgTop2, x); return clamp(1 - (y - t)/6, 0, 1) end}}})
-- break the band under topA: blend the transition between top plane and face
local seam = fgRock2 * mask(function(x, y) local t = topy(fgTop2, x); return clamp(1 - math.abs(y - t - 50)/20, 0, 1) end)
blend(seam, {angle=math.pi/2})
blend((topA + topB):shrink(1), {angle=0.2})
-- rim light along the upper contour (knife along facets)
local function rimseg(a, b, pile, w)
  local dx, dy = b[1] - a[1], b[2] - a[2]
  local len = math.sqrt(dx*dx + dy*dy)
  local k = knife{width=len * 0.92}
  k:load(pile, 0.35)
  local mx, my = (a[1] + b[1]) / 2, (a[2] + b[2]) / 2
  k:lay({{mx, my}, {mx, my + (w or 2)}}, {pressure={0.12, 0.2}, angle=math.atan(dy, dx)})
end
for j = 2, #fgTop2 - 2 do
  if nz:at01(fgTop2[j][1], 0) > 0.3 then rimseg(fgTop2[j], fgTop2[j+1], (j >= 5) and rim_warm or mosslit3, 2) end
end
-- leaves on the moss
local lb = brush{kind="round", width=6, point=0.8, stiffness=0.5}
for k = 1, 14 do
  local x = rand(10, 200)
  local t = topy(fgTop2, x)
  local y = t + rand(6, 34)
  if topA:at(x, y) > 0.8 then
    lb:reload((k % 3 == 0) and deeprust or orangeleaf, 0.75)
    local a = rand(-0.8, 0.8); local L = rand(7, 12)
    lb:gesture({{x, y, 0.15}, {x + L*0.5*math.cos(a), y + L*0.4*math.sin(a), 0.85}, {x + L*math.cos(a), y + L*0.8*math.sin(a), 0.0}}, {wobble=0.3})
  end
end
-- wet contact with the water on the right edge, and a small ripple ring
local wb = brush{kind="flat", width=6, stiffness=0.5}
for y = 1150, 1250, 12 do
  local x = topy({{1140,284},{1186,298},{1256,306}}, y)
  wb:reload(lent, 0.6)
  wb:stroke({{x - 4, y}, {x + 10, y + 2}}, {pressure={0.5, 0.2}, orient="across"})
end
local rr = brush{kind="round", width=2.5, point=0.6}
for k = 0, 2 do
  rr:reload(haze, 0.5)
  local y = 1180 + k * 26
  local x = topy({{1140,284},{1186,298},{1256,306}}, y) + 6
  rr:gesture({{x, y - 4, 0.1}, {x + 14, y, 0.5}, {x + 34, y + 2, 0.05}}, {wobble=0.4})
end

--@ chunk 320
local edgeIn = fgRock2 * mask(function(x, y) local xe = topy({{1130,282},{1186,298},{1256,306}}, y); return (y > 1135 and x > xe - 22) and 1 or 0 end)
local edgeOut = (below({{-10,906},{1010,906}}) - fgRock2) * mask(function(x, y) local xe = topy({{1130,282},{1186,298},{1256,306}}, y); return (y > 1120 and x < xe + 60) and 1 or 0 end)
local nz = noise{seed=8601, period=20, octaves=2}
work(edgeIn, {hand="body", tool={kind="flat", width=7, stiffness=0.6}, length={14,30}, coverage=4, fill=true, clip=true, load=1.0,
  angle=1.3, piles={{lent, 1}, {rock, 0.8}, {waterdark, 0.3}}})
work(edgeOut, {hand="body", tool={kind="flat", width=8, stiffness=0.5}, length={20,50}, coverage=4, fill=true, clip=true, load=1.0,
  angle=math.pi/2, piles={{waterdark, function(x,y) local xe = topy({{1130,282},{1186,298},{1256,306}}, y); return 0.4 + clamp(1 - (x - xe)/30, 0, 1) end},
    {deeprust, 0.4}, {amber, function(x,y) return 0.35*nz:at01(x,y) end}, {leafshade, 0.4}}})
blend(edgeOut:shrink(1), {angle=math.pi/2})
-- leaves into the moss
blend(topA:shrink(2), {angle=0.3})
-- face: darker base, fuse cracks a little
local lowF = faces * mask(function(x, y) return clamp((y - 1180)/50, 0, 1) end)
work(lowF, {hand="body", tool={kind="flat", width=9, stiffness=0.6}, length={14,30}, coverage=2.5, clip=true, load=1.0, angle=1.5, piles={{lent, 1}, {waterdark, 0.4}}})
blend(faces:shrink(2), {angle=1.5})

--@ chunk 321
local WL = 906
local nb = noise{seed=6701, period=30, octaves=2}
local nv = noise{seed=6702, period=25, octaves=2}
local ns = noise{seed=8203, period=10, octaves=2, stretch={math.pi/2, 7}}
function poolPiles()
  local function dB(x, y)
    local dx = math.abs(x - 486)
    if dx < 140 then return 0 end
    local len = 45 + 35 * nb:at01(x, 0) + 15 * nb(x * 3, 7)
    return clamp((WL + len * clamp((dx - 140)/30, 0, 1) - y) / 14, 0, 1)
  end
  local function C(x,y) return columnM:at(x,y) end
  local function Wd(x,y) return wedgeM:at(x,y) end
  local function LR(x,y) return math.max(reflL:at(x,y), reflR:at(x,y)) end
  local function B(x,y) return math.max(birchRA:at(x,y), birchRB:at(x,y)) end
  local function rest(x,y) return clamp(1 - C(x,y) - Wd(x,y) - LR(x,y) - B(x,y), 0, 1) end
  return {{lent, function(x,y) return dB(x,y) * 0.5 end},
         {waterdark, function(x,y) return dB(x,y) + rest(x,y) * (1 - dB(x,y)) * 0.35 + C(x,y) * 0.35 * clamp((0.4 - ns:at01(x,y))*3, 0, 1) end},
         {poolmid, function(x,y) return rest(x,y) * (1 - dB(x,y)) end},
         {colmid, function(x,y) return C(x,y) * (1 - Wd(x,y)) * (1 - dB(x,y)) end},
         {foamsh, function(x,y) return C(x,y) * clamp(1 - (y - WL)/60, 0, 1) * (0.5 + 0.5*ns:at01(x,y)) end},
         {glow, function(x,y) return Wd(x,y) * clamp(0.9 - 0.6*math.abs(x - 500)/150, 0, 1) end},
         {amber, function(x,y) return Wd(x,y) * 0.7 + LR(x,y) * 0.15 end},
         {haze, function(x,y) return Wd(x,y) * 0.3 + B(x,y) * 0.7 end},
         {birch, function(x,y) return B(x,y) * 0.35 end},
         {leafshade, function(x,y) return LR(x,y) * (1 - B(x,y)) * 0.8 end},
         {orangeleaf, function(x,y) return LR(x,y) * (1 - B(x,y)) * 0.4 * clamp((nv:at01(x+40,y) - 0.4)*3, 0, 1) end},
         {deeprust, function(x,y) return LR(x,y) * (1 - B(x,y)) * 0.5 end}}
end
print(palette())

--@ chunk 322
print(nearbank)
print(tostring(nearbank.name))

--@ chunk 323
palette{scrape={nearbank}}
print(palette())

--@ chunk 324
palette{scrape={rock, mosslit3}}
poolmid = mix{{waterdark,0.66},{amber,0.15},{haze,0.15},{deeprust,0.06}, name="poolmid"}
colmid = mix{{haze,0.55},{amber,0.12},{waterdark,0.3},{foamsh,0.03}, name="colmid"}
local reg = (ellipse(340, 1190, 110, 90):soften(35)) * (below({{-10,906},{1010,906}}) - fgRock2)
local nv = noise{seed=6702, period=25, octaves=2}
work(reg, {hand="body", tool={kind="flat", width=11, stiffness=0.5}, length={25,70}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.03*nv(x,y) end, piles=poolPiles()})
blend(reg, {angle=math.pi/2})

--@ chunk 325
palette{scrape={colmid}}
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
local nz = noise{seed=8701, period=26, octaves=3}
local nz2 = noise{seed=8702, period=60, octaves=2}
local nz3 = noise{seed=8703, period=12, octaves=2}
local function dep(x, y) return y - topy(fgTop2, x) + 18 * (nz2:at01(x, 0) - 0.5) end
work(fgRock2, {hand="body", tool={kind="flat", width=9, stiffness=0.6}, length={12,30}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) local d = dep(x,y); return (d < 35) and (0.15 + 0.3*nz(x,y) + 0.4*clamp((x - 180)/80, 0, 1)) or (1.5 + 0.35*nz(x,y)) end,
  piles={{mossdeep, function(x,y) local d = dep(x,y); return clamp(1 - (d - 25)/25, 0, 1) * (0.7 + 0.5*nz:at01(x,y)) end},
         {rim_warm, function(x,y) local d = dep(x,y); return clamp(1 - d/8, 0, 1) * clamp((nz3:at01(x,y) - 0.35)*3, 0, 1) * 0.7 end},
         {leafshade, function(x,y) local d = dep(x,y); return clamp(1 - math.abs(d - 18)/14, 0, 1) * clamp((nz3:at01(x+40,y) - 0.55)*3, 0, 1) end},
         {orangeleaf, function(x,y) local d = dep(x,y); return clamp(1 - math.abs(d - 12)/10, 0, 1) * clamp((nz3:at01(x+90,y) - 0.68)*4, 0, 1) end},
         {rock, function(x,y) local d = dep(x,y); return clamp((d - 25)/25, 0, 1) end},
         {lent, function(x,y) local d = dep(x,y); return clamp((d - 50)/60, 0, 1) * (0.7 + 0.5*nz:at01(x+20,y)) end},
         {waterdark, function(x,y) return 0.2 + 0.3*nz2:at01(x,y) end}}})

--@ chunk 326
local nz = noise{seed=8801, period=18, octaves=2}
local function rimseg(a, b, pile, w)
  local dx, dy = b[1] - a[1], b[2] - a[2]
  local len = math.sqrt(dx*dx + dy*dy)
  local k = knife{width=len * 0.9}
  k:load(pile, 0.35)
  local mx, my = (a[1] + b[1]) / 2, (a[2] + b[2]) / 2
  k:lay({{mx, my + 0.5}, {mx, my + (w or 2.5)}}, {pressure={0.12, 0.2}, angle=math.atan(dy, dx)})
end
-- subdivide the top line for an irregular rim
local pts = {}
for i = 1, #fgTop2 - 1 do
  local a, b = fgTop2[i], fgTop2[i+1]
  for k = 0, 2 do
    local t = k / 3
    pts[#pts+1] = {lerp(a[1], b[1], t), lerp(a[2], b[2], t) + 1.5}
  end
end
for j = 1, #pts - 1 do
  if pts[j][1] > 60 and nz:at01(pts[j][1], 0) > 0.3 then
    rimseg(pts[j], pts[j+1], (pts[j][1] > 180) and rim_warm or mossdeep, (pts[j][1] > 180) and 3 or 2)
  end
end
-- a few large fallen leaves on the cap
local lb = brush{kind="round", width=8, point=0.8, stiffness=0.5}
local L = {{60,1072,0.3},{130,1068,-0.4},{172,1080,0.6},{230,1104,0.9},{30,1082,-0.2}}
for i, l in ipairs(L) do
  lb:reload((i % 2 == 0) and deeprust or orangeleaf, 0.8)
  local x, y, a = l[1], l[2], l[3]
  local s = 11
  lb:gesture({{x, y, 0.1}, {x + s*0.5*math.cos(a), y + s*0.35*math.sin(a), 0.9}, {x + s*math.cos(a), y + s*0.7*math.sin(a), 0.0}}, {wobble=0.3})
end

--@ chunk 327
local pts = {}
for i = 1, #fgTop2 do pts[#pts+1] = {fgTop2[i][1], fgTop2[i][2] + 2} end
local rz = ribbon(pts, 10) * fgRock2:shrink(1)
blend(rz, {angle=0.3})
blend(rz, {angle=1.2})
local cap = fgRock2 * mask(function(x, y) return clamp(1 - (y - topy(fgTop2, x) - 20)/15, 0, 1) end)
blend(cap:shrink(2), {angle=0.4})

--@ chunk 328
for _, p in ipairs({{700,830},{775,840},{850,830},{160,830},{806,640},{917,650}}) do print(p[1], p[2], drying(p[1], p[2])) end
local m = bmasks[7]
local t = top_contour(m, 630, 920, 760, 930, 20)
for _, p in ipairs(t) do io = p; print(p[1], p[2]) end

--@ chunk 329
newTopR = {{620,872},{660,866},{700,858},{740,848},{780,834},{820,822},{850,820},{880,826},{910,834}}
local m = bmasks[7]
local cut = m * mask(function(x, y) return (y < topy(newTopR, x)) and 1 or 0 end)
print(cut:area())
local nz = noise{seed=8901, period=14, octaves=2}
-- what lies behind: the undergrowth / dark bank
work(cut, {hand="body", tool={kind="filbert", width=6, stiffness=0.5}, length={5,12}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{lent, 0.7}, {brushdark, 0.9}, {leafshade, 0.6}, {deeprust, function(x,y) return 0.3*nz:at01(x,y) end}}})
-- new cap on the lowered top
local cap = m * mask(function(x, y) local d = y - topy(newTopR, x); return (d >= 0 and d < 16) and 1 or 0 end)
work(cap, {hand="body", tool={kind="flat", width=6, stiffness=0.6}, length={8,20}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.atan(-12, 40) + 0.2*nz(x,y) end,
  piles={{mossdeep, 1}, {rim_warm, function(x,y) local d = y - topy(newTopR, x); return clamp(1 - d/3, 0, 1) * clamp((nz:at01(x*2,y) - 0.3)*3, 0, 1) * clamp(1 - (x - 640)/300, 0.3, 1) end},
         {brushdark, function(x,y) local d = y - topy(newTopR, x); return clamp((d - 8)/8, 0, 1) end}}})

--@ chunk 330
local m = bmasks[7]
local cut = m * mask(function(x, y) return (y < topy(newTopR, x) - 2) and 1 or 0 end)
local zone = (cut:grow(10) * mask(function(x, y) return (y < topy(newTopR, x) - 2) and 1 or 0 end)):soften(4)
blend(zone, {angle=1.2})
blend(zone, {angle=2.0})
blend(zone, {angle=math.pi/2})

--@ chunk 331
local function dist(x, y) return math.sqrt(((x-gx)/1.0)^2 + ((y-gy)/1.15)^2) end
local halo = ((mA:grow(7) - mA:grow(0.5)) + (mB:grow(7) - mB:grow(0.5))) * above(function(x) return 600 end) - (canopy + clumpU):shrink(2)
print(halo:area())
work(halo, {hand="body", tool={kind="flat", width=5, stiffness=0.5}, length={20,50}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=-math.pi/2,
  piles={{amber, function(x,y) local d=dist(x,y); return math.exp(-((d-330)/120)^2) + 0.2 end},
         {deeprust, function(x,y) local d=dist(x,y); return math.exp(-((d-470)/130)^2) end},
         {haze, function(x,y) local d=dist(x,y); return 0.3*math.exp(-((d-250)/120)^2) end},
         {brushdark, function(x,y) local d=dist(x,y); return 0.5*math.max(0, (d-460)/260) end}}})

--@ chunk 332
palette{scrape={poolmid, rock}}
goldleaf = pile{{"chrome yellow",2},{"yellow ochre",1.5},{"red earth",0.3}, name="goldleaf"}
local feet = {
  {{796,612,34,22}, 0.5}, {{830,628,30,20}, 0.4}, {{770,630,28,18}, 0.45},
  {{912,636,28,18}, 0.4}, {{940,646,26,18}, 0.35}, {{888,650,24,16}, 0.35},
  {{806,660,44,26}, 0.25}, {{920,668,40,24}, 0.2},
}
for i, c in ipairs(feet) do clump4(c[1], 9100 + i, gx, gy - 60, {lit=c[2]}) end
local fz = nil
for i, c in ipairs(feet) do local m = clump_mask(c[1], 9100 + i); fz = fz and (fz + m) or m end
blend(fz:shrink(2), {angle=1.2})

--@ chunk 333
local zone = (rect(690, 360, 320, 250) - mA:grow(1) - mB:grow(1) - (canopy + clumpU):shrink(6)):soften(3) - mA - mB
blend(zone, {angle=math.pi/2})
blend(zone, {angle=math.pi/2 + 0.15})
-- bushes at the feet: darker, contre-jour
local feet = {
  {{796,612,34,22}, 0.5}, {{830,628,30,20}, 0.4}, {{770,630,28,18}, 0.45},
  {{912,636,28,18}, 0.4}, {{940,646,26,18}, 0.35}, {{888,650,24,16}, 0.35},
  {{806,660,44,26}, 0.25}, {{920,668,40,24}, 0.2},
}
local fz = nil
for i, c in ipairs(feet) do local m = clump_mask(c[1], 9100 + i); fz = fz and (fz + m) or m end
feetM = fz
local nz = noise{seed=9201, period=12, octaves=2}
local function topOf(x)
  for y = 580, 700, 2 do if fz:at(x, y) > 0.5 then return y end end
  return 700
end
local tops = {}
for x = 730, 990, 4 do tops[x] = topOf(x) end
local function dep(x, y) local k = 730 + math.floor((x - 730) / 4) * 4; return y - (tops[k] or 700) end
work(fz, {hand="body", tool={kind="filbert", width=6, stiffness=0.5}, length={5,11}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{leafshade, 1}, {brushdark, function(x,y) return 0.5 + clamp((dep(x,y) - 10)/30, 0, 1) end},
         {deeprust, function(x,y) return 0.6 * clamp(1 - dep(x,y)/16, 0, 1) end},
         {orangeleaf, function(x,y) return clamp(1 - dep(x,y)/7, 0, 1) * clamp((nz:at01(x,y) - 0.4)*3, 0, 1) * 0.9 end},
         {lent, function(x,y) return 0.6 * clamp((dep(x,y) - 30)/30, 0, 1) end}}})

--@ chunk 334
ugO = outline{{690,640},{712,628},{738,622},{760,612},{784,600},{800,596},{818,602},{836,612},{852,622},{870,628},{892,624},{906,630},{920,622},{936,628},{952,640},{972,632},{1010,628},{1010,720},{690,720}, char="soft", seed=9301, amount=0.9, lobe=10}
ugM = ugO:mask() - mA * above(function(x) return 590 end) - mB * above(function(x) return 590 end)
local nz = noise{seed=9302, period=10, octaves=2}
local function topOf(x) for y = 580, 700, 1 do if ugM:at(x, y) > 0.5 then return y end end; return 700 end
local tops = {}
for x = 690, 1010, 3 do tops[x] = topOf(x) end
local function dep(x, y) local k = 690 + math.floor((x - 690) / 3) * 3; return y - (tops[k] or 700) end
work(ugM, {hand="body", tool={kind="filbert", width=6, stiffness=0.5}, length={5,11}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{leafshade, 1}, {brushdark, function(x,y) return 0.4 + clamp((dep(x,y) - 10)/30, 0, 1) end},
         {deeprust, function(x,y) return 0.7 * clamp(1 - dep(x,y)/18, 0, 1) end},
         {orangeleaf, function(x,y) return clamp(1 - dep(x,y)/6, 0, 1) * clamp((nz:at01(x,y) - 0.35)*3, 0, 1) end},
         {lent, function(x,y) return 0.5 * clamp((dep(x,y) - 40)/40, 0, 1) end}}})
-- the old hard line above: blend a band
local band = (rect(690, 590, 320, 30) - ugM - mA - mB):soften(4) - mA - mB
blend(band, {angle=math.pi/2})
blend(band, {angle=math.pi/2})

--@ chunk 335
local feetA = below(function(x) return 660 end)
local protect = (mA - feetA) + (mB - feetA) + newFalls:grow(4) + rockFace + bmasks[7] + bmasks[8] + bmasks[9]
local rightClumps = {
  {{612,700,40,30}, 0.7}, {{680,668,50,34}, 0.6}, {{760,640,55,34}, 0.5}, {{852,632,50,30}, 0.45}, {{945,616,60,36}, 0.4},
  {{720,705,55,36}, 0.3}, {{830,690,60,36}, 0.28}, {{940,680,65,40}, 0.25},
  {{650,760,45,34}, 0.2}, {{770,770,60,36}, 0.15}, {{900,760,70,40}, 0.15}, {{990,740,40,40}, 0.15},
  {{806,612,30,20}, 0.45}, {{918,624,26,18}, 0.4},
}
for i, c in ipairs(rightClumps) do clump4(c[1], 9400 + i, gx, gy - 60, {minus=protect, lit=c[2]}) end
local rz = nil
for i, c in ipairs(rightClumps) do local m = clump_mask(c[1], 9400 + i); rz = rz and (rz + m) or m end
rightClumpM = rz
blend((rz:shrink(3) - protect):soften(4), {angle=1.2})

--@ chunk 336
for _, p in ipairs({{444,760},{516,740},{542,780},{400,800},{470,850},{580,850},{365,780},{610,780},{486,895}}) do print(p[1], p[2], drying(p[1], p[2])) end
mergeO = outline{{372,714},{398,722},{420,716},{440,730},{462,722},{488,734},{512,724},{534,736},{556,744},{578,728},{598,712},{604,760},{612,820},{626,872},{634,902},{344,902},{350,860},{356,800},{362,750}, char="broken", seed=9501, amount=0.6}
mergeM = mergeO:mask()
print(mergeM:area())

--@ chunk 337
print(palette())

--@ chunk 338
palette{scrape={goldleaf, leafrust, mossdeep}}
fallwhite = pile{{"lead white",8},{"yellow ochre",0.25},{"cobalt blue",0.08}, name="fallwhite"}
thinwhite = pile{{"lead white",8},{"yellow ochre",0.2},{"cobalt blue",0.1}, thinner=0.5, name="thinwhite"}
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
wedgeL = outline{{432,712},{446,706},{456,716},{458,760},{454,800},{447,842},{441,846},{436,800},{432,760}, char="broken", seed=9511, amount=0.5}:mask()
lowerC = mergeM - wedgeL
-- 1. wedge rock, dark wet
work(wedgeL, {hand="body", tool={kind="flat", width=5, stiffness=0.6}, length={10,26}, coverage=4, fill=true, clip=true, load=1.0, angle=1.5,
  piles={{lent, 1}, {rock, 0.7}, {waterdark, 0.3}}})
-- 2. base veil of the merged curtain (foamsh), strokes continuing the strands and fanning out
local function cx(t, y)  -- across the merged curtain
  local f = (y - 714) / (902 - 714)
  local L = lerp(366, 346, f)
  local R = lerp(600, 630, f)
  return lerp(L, R, t)
end
local vb = brush{kind="flat", width=8, stiffness=0.5}
local n = 0
for pass = 1, 2 do
  for t = 0.02, 0.98, 0.045 do
    n = n + 1
    if n % 2 == 1 then vb:reload(thinwhite, 0.6) end
    local tt = t + rand(-0.015, 0.015)
    local y0 = 700 + rand(0, 20)
    local pts = {}
    for k = 0, 4 do local y = lerp(y0, 902, k/4); pts[#pts+1] = {cx(tt, y) + rand(-1, 1), y} end
    vb:stroke(pts, {pressure={0.5, 0.3}, orient="across", clip=lowerC:grow(1)})
  end
end
local fan = brush{kind="fan", width=12, stiffness=0.5}
for k = 1, 30 do
  if k % 3 == 1 then fan:reload((k % 4 == 0) and foamsh or fallwhite, 0.33) end
  local tt = rand(0.02, 0.98)
  local y0 = 700 + rand(0, 30)
  local yend = math.min(902, y0 + rand(100, 200))
  local pts = {}
  for j = 0, 4 do local y = lerp(y0, yend, j/4); pts[#pts+1] = {cx(tt, y) + rand(-1, 1), y} end
  fan:stroke(pts, {pressure={0.45, 0.4}, orient="across", ramps={0.1, 0.3}, clip=lowerC:grow(1)})
end
blend(lowerC:shrink(1) * below(function(x) return 712 end), {angle=math.pi/2})

--@ chunk 339
local waterAll = (newFalls + lowerC) - wedgeL
local seam = waterAll * mask(function(x, y) return clamp(1 - math.abs(y - 722)/22, 0, 1) end)
blend(seam:shrink(1), {angle=math.pi/2})
blend(seam:shrink(1), {angle=math.pi/2})
-- continuous streaks from each strand down through the merged curtain
local function cx(t, y)
  local f = (y - 714) / (902 - 714)
  return lerp(lerp(366, 346, f), lerp(600, 630, f), t)
end
local fan = brush{kind="fan", width=10, stiffness=0.5}
for k = 1, 34 do
  if k % 2 == 1 then fan:reload((k % 5 == 0) and foamsh or fallwhite, 0.36) end
  local i = ({1, 2, 2, 4, 1, 2, 3, 4})[(k % 8) + 1]
  local tt = rand(0.08, 0.92)
  local y0 = nTop[i] + 16 + rand(0, 20)
  local xs = nx(i, tt, y0)
  -- target position in the merged curtain at the bottom: keep relative x, fan slightly outward
  local tb = clamp((xs - 366) / (600 - 366), 0, 1)
  tb = 0.5 + (tb - 0.5) * 1.08
  local pts = {}
  for j = 0, 5 do
    local y = lerp(y0, rand(840, 900), j/5)
    local xa = (y < 714) and nx(i, tt, y) or lerp(nx(i, tt, 713), cx(tb, y), clamp((y - 714)/60, 0, 1))
    pts[#pts+1] = {xa + rand(-0.8, 0.8), y}
  end
  fan:stroke(pts, {pressure={0.5, 0.25}, orient="across", ramps={0.03, 0.4}, clip=waterAll:grow(1)})
end

--@ chunk 340
foamO3 = outline{{334,890},{350,878},{368,884},{386,872},{406,880},{426,870},{448,878},{470,868},{492,876},{514,866},{536,874},{558,868},{580,876},{602,870},{622,880},{640,890},{652,902},{644,914},{620,920},{590,926},{556,922},{520,930},{486,926},{450,930},{414,924},{380,928},{350,920},{330,910}, char="soft", seed=9601, amount=0.8, lobe=8}
foamM3 = foamO3:mask() - bmasks[6] - bmasks[8] - fgRock2
print(foamM3:area())
local nf = noise{seed=9602, period=8, octaves=3}
work(foamM3, {hand="body", tool={kind="round", width=5, stiffness=0.4}, length={4,10}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.5*nf(x*2, y*2) end,
  piles={{fallwhite, function(x,y) return clamp(1 - (y - 868)/40, 0.15, 1) * 1.5 end},
         {foamsh, function(x,y) return 0.3 + clamp((y - 898)/16, 0, 1) * 1.2 end},
         {haze, function(x,y) return 0.25*clamp((y - 905)/15, 0, 1) end}}})
local rbb = brush{kind="round", width=6, stiffness=0.4, lay=2}
for k = 1, 40 do
  local x = rand(340, 640)
  local y = 872 + rand(-4, 10)
  if foamM3:at(x, y + 4) > 0.5 then
    rbb:reload((k % 5 == 0) and glow or fallwhite, 0.8)
    local w = rand(4, 9)
    rbb:stroke({{x - w, y + 3}, {x, y - rand(1, 4)}, {x + w, y + 3}}, {pressure={0.55, 0.3}, clip=foamM3:grow(3)})
  end
end
-- shadowed undersides of foam lumps
local db = brush{kind="round", width=4, stiffness=0.4}
for k = 1, 20 do
  local x = rand(345, 635)
  local y = 896 + rand(0, 14)
  if foamM3:at(x, y) > 0.6 then
    db:reload(foamsh, 0.6)
    db:stroke({{x - 6, y}, {x, y + 2}, {x + 6, y}}, {pressure={0.5, 0.3}, clip=foamM3})
  end
end
blend(foamM3:shrink(2), {angle=0.0})

--@ chunk 341
-- mist: thin veil rising from the foam over the lower curtain and the rocks beside, several light passes
local mistM = mask(function(x, y)
  local dx = (x - 488) / 190
  local dy = (y - 880) / 55
  return clamp(1 - (dx*dx + dy*dy), 0, 1)
end) - fgRock2
for pass = 1, 2 do
  work(mistM, {hand="scumble", pile=thinwhite, coverage=0.7, seed=9700 + pass})
end
-- the bottom edge: soften the line where foam meets pool
local edge = foamM3:grow(8) - foamM3:shrink(4) - fgRock2 - bmasks[6] - bmasks[8]
blend(edge * below(function(x) return 900 end), {angle=math.pi/2})

--@ chunk 342
palette{scrape={thinwhite, orangeleaf}}
mossdeep = pile{{"green earth",2},{"raw umber",1.2},{"yellow ochre",0.8},{"Prussian blue",0.1}, name="mossdeep"}
mossdark = pile{{"green earth",2},{"raw umber",1},{"Prussian blue",0.2},{"yellow ochre",1}, name="mossdark"}
local waterAll = ((newFalls + lowerC) - wedgeL + foamM3)
local zone = (waterAll * mask(function(x, y) return clamp((y - 830)/20, 0, 1) end)):shrink(1)
for _, a in ipairs({0.0, math.pi/2, 0.5, 2.6}) do blend(zone, {angle=a}) end
local sideRock = (rect(310, 830, 50, 80) + rect(612, 830, 60, 80)) - waterAll - fgRock2 - bmasks[6] - bmasks[8] - bmasks[7]
work(sideRock, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,20}, coverage=4, fill=true, clip=true, load=1.0, angle=1.5,
  piles={{lent, 1}, {rock, 0.6}}})
restate_boulder(BLD[6], bmasks[6] - waterAll)
restate_boulder(BLD[8], bmasks[8] - waterAll)

--@ chunk 343
wait(12 * 24 * 60)
for _, p in ipairs({{480,860},{400,880},{560,870},{470,760},{540,740},{340,880},{630,880},{700,830},{806,640},{100,1150},{486,1000},{800,600},{200,600}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 344
wait(10 * 24 * 60)
for _, p in ipairs({{340,880},{630,880},{700,830},{806,640},{100,1150},{486,1000},{800,600},{900,1100},{150,830}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 345
palette{scrape={mossdark}}
grayglaze = pile{{"raw umber",1},{"cobalt blue",0.4},{"lead white",0.6}, medium=0.6, name="grayglaze"}
local waterAll = ((newFalls + lowerC) - wedgeL + foamM3)
-- 1. streak glaze over the lower curtain, crossing the old slab edge
local ns = noise{seed=9801, period=7, octaves=2, stretch={math.pi/2, 10}}
local ns2 = noise{seed=9802, period=40, octaves=2}
local streak = waterAll * mask(function(x, y)
  local band = clamp((y - 740)/30, 0, 1) * clamp((880 - y)/20, 0, 1)
  return band * clamp((ns:at01(x, y) - 0.5 + 0.15*(ns2:at01(x,y) - 0.5)) * 5, 0, 1)
end)
print(streak:area())
work(streak, {hand="glaze", pile=grayglaze, coverage=1, angle=math.pi/2, tool={kind="filbert", width=5, stiffness=0.3}})

--@ chunk 346
-- 1. ropes crossing the slab's top edge (dry-brush over dry)
local function cx(t, y)
  local f = (y - 714) / (902 - 714)
  return lerp(lerp(366, 346, f), lerp(600, 630, f), t)
end
local waterAll = ((newFalls + lowerC) - wedgeL + foamM3)
local fan = brush{kind="fan", width=11, stiffness=0.5}
for k = 1, 30 do
  if k % 2 == 1 then fan:reload((k % 4 == 0) and foamsh or fallwhite, 0.38) end
  local tt = (k - 0.5) / 30 + rand(-0.01, 0.01)
  local y0 = rand(760, 800)
  local y1 = rand(860, 885)
  local pts = {}
  for j = 0, 4 do local y = lerp(y0, y1, j/4); pts[#pts+1] = {cx(tt, y) + rand(-0.8, 0.8), y} end
  fan:stroke(pts, {pressure={0.5, 0.35}, orient="across", ramps={0.05, 0.3}, clip=waterAll})
end
-- 2. dark rock over the crackled corners
local cL = poly({{334,848},{366,846},{372,872},{366,904},{330,906}})
local cR = poly({{604,846},{640,846},{652,906},{614,906},{608,876}})
local nz = noise{seed=9811, period=12, octaves=2}
work((cL + cR) - fgRock2, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,18}, coverage=4, fill=true, clip=true, load=1.0, angle=1.5,
  piles={{lent, 1}, {rock, 0.6}}})
-- 3. a little white spray spilling over the inner edges of those rocks
local rs = brush{kind="round", width=3, point=0.6}
for k = 1, 10 do
  local left = (k % 2 == 0)
  local y0 = rand(850, 895)
  local x0 = left and rand(366, 372) or rand(604, 610)
  local dir = left and -1 or 1
  rs:reload(fallwhite, 0.5)
  rs:gesture({{x0 + dir*(-2), y0, 0.4}, {x0 + dir*rand(4, 8), y0 + rand(3, 8), 0.3}, {x0 + dir*rand(8, 14), y0 + rand(8, 14), 0.0}}, {wobble=0.8})
end

--@ chunk 347
for _, p in ipairs({{444,700},{444,800},{516,700},{542,700},{360,700},{610,700}}) do print(p[1], p[2], drying(p[1], p[2])) end
local fan = brush{kind="fan", width=10, stiffness=0.5}
for k = 1, 9 do
  fan:reload((k % 3 == 0) and foamsh or fallwhite, 0.18)
  local x0 = rand(430, 458)
  local y0 = rand(720, 790)
  local dx = (x0 < 444) and rand(2, 6) or rand(-6, -2)
  fan:stroke({{x0, y0}, {x0 + dx*0.5, y0 + 25}, {x0 + dx, y0 + rand(45, 70)}}, {pressure={0.3, 0.1}, orient="across", ramps={0.1, 0.5}})
end
-- rim light on pillar tips facing the glow
local rg = brush{kind="round", width=2.5, point=0.6}
for _, t in ipairs({{{437,648},{441,637},{447,641}}, {{514,645},{516,642},{519,647}}, {{540,651},{543,646},{547,650}}}) do
  rg:reload(rim_warm, 0.6)
  rg:gesture({{t[1][1], t[1][2], 0.2}, {t[2][1], t[2][2], 0.6}, {t[3][1], t[3][2], 0.2}}, {wobble=0.3})
end

--@ chunk 348
local cL2 = outline{{326,852},{340,842},{356,846},{366,856},{372,872},{370,890},{364,906},{326,908}, char="broken", seed=9901, amount=0.5}:mask()
local cR2 = outline{{606,850},{620,842},{638,846},{650,858},{656,880},{656,906},{612,908},{606,880}, char="broken", seed=9902, amount=0.5}:mask()
-- paint over old boxes: cover box regions with either rock (inside new shapes) or foam/water (outside)
local oldBox = (poly({{334,848},{366,846},{372,872},{366,904},{330,906}}) + poly({{604,846},{640,846},{652,906},{614,906},{608,876}})):grow(4) - fgRock2
local outside = oldBox - cL2 - cR2
local nf = noise{seed=9903, period=8, octaves=2}
work(outside, {hand="body", tool={kind="round", width=5, stiffness=0.4}, length={5,12}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return math.pi/2 + 0.4*nf(x,y) end,
  piles={{foamsh, 1}, {fallwhite, function(x,y) return 0.6*nf:at01(x,y) end}, {waterdark, function(x,y) return 0.3*clamp((math.abs(x-488) - 130)/20, 0, 1) end}}})
work((cL2 + cR2) - fgRock2, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,18}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.4 + 0.4*nf(x,y) end, piles={{lent, 1}, {rock, 0.6}, {waterdark, 0.3}}})
-- rims on their tops
local rg = brush{kind="round", width=2.5, point=0.6}
rg:reload(rim_warm, 0.6)
rg:gesture({{330, 850, 0.15}, {340, 843, 0.5}, {356, 846, 0.5}, {365, 855, 0.15}}, {wobble=0.3})
rg:reload(rim_warm, 0.6)
rg:gesture({{608, 850, 0.15}, {620, 843, 0.5}, {637, 846, 0.4}, {648, 856, 0.1}}, {wobble=0.3})
-- soft splash puffs where water meets them
local rb = brush{kind="round", width=6, stiffness=0.4, lay=2}
for k = 1, 8 do
  local left = (k % 2 == 0)
  local x = left and rand(366, 378) or rand(596, 608)
  local y = rand(860, 895)
  rb:reload(fallwhite, 0.6)
  rb:stroke({{x - 3, y + 2}, {x, y - 2}, {x + 3, y + 2}}, {pressure={0.4, 0.3}})
end

--@ chunk 349
local cL2 = outline{{326,852},{340,842},{356,846},{366,856},{372,872},{370,890},{364,906},{326,908}, char="broken", seed=9901, amount=0.5}:mask()
local cR2 = outline{{606,850},{620,842},{638,846},{650,858},{656,880},{656,906},{612,908},{606,880}, char="broken", seed=9902, amount=0.5}:mask()
local edgeZ = ((cL2 + cR2):grow(6) - (cL2 + cR2):shrink(5)) - fgRock2
blend(edgeZ, {angle=1.2})
blend(edgeZ, {angle=0.3})
-- tone the orange rims down: drag rock over most of them, leaving short glints
local rg = brush{kind="round", width=3, point=0.5}
rg:reload(rock, 0.6)
rg:gesture({{330, 851, 0.4}, {336, 846, 0.5}, {344, 843, 0.3}}, {wobble=0.3})
rg:reload(rock, 0.6)
rg:gesture({{626, 843, 0.3}, {637, 846, 0.5}, {648, 856, 0.4}}, {wobble=0.3})
-- foam bottom edge: break into the pool with short horizontal drags
local fb = brush{kind="flat", width=4, stiffness=0.5}
for k = 1, 24 do
  local x = rand(350, 640)
  local y = rand(912, 930)
  fb:reload((k % 2 == 0) and waterdark or foamsh, 0.4)
  local l = rand(10, 30)
  fb:stroke({{x - l/2, y}, {x + l/2, y + rand(-0.5, 0.5)}}, {pressure={0.35, 0.15}, orient="across"})
end

--@ chunk 350
wait(20 * 24 * 60)
for _, p in ipairs({{340,870},{630,870},{480,915},{400,925},{560,920},{700,830}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 351
wait(10 * 24 * 60)
for _, p in ipairs({{340,870},{630,870},{355,860},{620,880}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 352
wait(7 * 24 * 60)
print(drying(340, 870), drying(330, 880), drying(345, 895))

--@ chunk 353
rockL3 = outline{{292,842},{316,834},{336,838},{352,846},{366,858},{376,876},{380,896},{376,910},{290,912}, char="broken", seed=9951, amount=0.5}:mask() - fgRock2
rockR3 = outline{{600,904},{602,880},{610,862},{624,850},{642,844},{664,848},{690,858},{694,912},{604,912}, char="broken", seed=9952, amount=0.5}:mask() - bmasks[7]
local nz = noise{seed=9953, period=16, octaves=2}
work(rockL3 + rockR3, {hand="body", tool={kind="filbert", width=7, stiffness=0.6}, length={10,24}, coverage=4.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.4 + 0.4*nz(x,y) end,
  piles={{lent, 1}, {rock, 0.7}, {waterdark, 0.3}, {mossdeep, function(x,y) return 0.4*clamp((870 - y)/20, 0, 1) * nz:at01(x,y) end}}})
-- blend only the new wet rock (over dry neighbours: only new paint moves)
blend((rockL3 + rockR3):shrink(2), {angle=1.4})
print(drying(340, 870))

--@ chunk 354
local rL = outline{{290,840},{316,830},{340,832},{360,842},{374,858},{382,878},{384,898},{378,912},{290,912}, char="broken", seed=9961, amount=0.5}:mask() - fgRock2
local rR = outline{{596,906},{598,880},{606,860},{620,846},{640,838},{664,842},{690,856},{694,912},{600,912}, char="broken", seed=9962, amount=0.5}:mask()
local nz = noise{seed=9963, period=16, octaves=2}
work(rL + rR, {hand="body", tool={kind="filbert", width=7, stiffness=0.6}, length={10,24}, coverage=4.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.4 + 0.4*nz(x,y) end,
  piles={{lent, 1}, {rock, 0.7}, {waterdark, 0.3}, {mossdeep, function(x,y) return 0.4*clamp((866 - y)/20, 0, 1) * nz:at01(x,y) end}}})
blend((rL + rR):shrink(2), {angle=1.4})
-- small rim glints facing the falls
local rg = brush{kind="round", width=2.5, point=0.6}
rg:reload(rim_warm, 0.5)
rg:gesture({{350, 838, 0.1}, {362, 843, 0.45}, {372, 854, 0.1}}, {wobble=0.3})
rg:reload(rim_warm, 0.5)
rg:gesture({{604, 866, 0.1}, {612, 852, 0.45}, {624, 845, 0.1}}, {wobble=0.3})
-- the dashes in the foam: soften by dragging foam over them
local fb = brush{kind="flat", width=8, stiffness=0.5}
for k = 1, 14 do
  local x = rand(350, 640)
  local y = rand(908, 926)
  fb:reload(foamsh, 0.4)
  fb:stroke({{x - 15, y}, {x + 15, y + rand(-1, 1)}}, {pressure={0.4, 0.2}, orient="across"})
end

--@ chunk 355
local strip = rect(372, 900, 230, 34)
blend(strip:soften(4), {angle=0.0})
blend(strip:soften(4), {angle=math.pi/2})
print(drying(480, 915), drying(400, 925))

--@ chunk 356
for _,p in ipairs{{340,860},{640,860},{480,880},{480,700},{460,640},{300,650},{700,700},{500,1000},{150,1100},{120,550},{850,550}} do print(p[1],p[2],drying(p[1],p[2])) end
print(palette())

--@ chunk 357
for _,p in ipairs{{480,620},{480,600},{480,560},{470,450},{360,640},{615,640},{445,645},{300,620},{680,620},{480,665},{420,668}} do print(p[1],p[2]) end

--@ chunk 358
print(gx, gy, lent, glow, haze, amber)

--@ chunk 359
newLine = {{326,676},{334,668},{346,659},{358,652},{370,649},{378,651},{383,658},{386,668},
  {410,667},{433,669},
  {437,662},{441,654},{445,651},{449,653},{452,655},
  {482,653},{512,655},
  {514,653},{517,652},{519,658},{521,676},
  {537,676},{539,666},{542,657},{545,656},{548,661},
  {570,660},{591,661},
  {596,663},{604,660},{614,658},{626,661},{640,668},{652,678},{664,692}}
brinkLine = {{384,668},{410,667},{433,668},{440,664},{447,657},{452,655},{482,653},{512,655},{516,662},{521,675},{537,676},{542,668},{548,661},{570,660},{591,661}}
function lineYf(pts, x)
  for i = 1, #pts - 1 do
    local a, b = pts[i], pts[i+1]
    if x >= a[1] and x <= b[1] then return lerp(a[2], b[2], (x - a[1]) / math.max(0.001, b[1] - a[1])) end
  end
  if x < pts[1][1] then return pts[1][2] end
  return pts[#pts][2]
end
local lineY = lineYf
aboveLine = mask(function(x, y)
  if x < 318 or x > 668 or y < 590 or y > 700 then return 0 end
  return (y < lineY(newLine, x)) and 1 or 0
end)
streamTop = {{384,660},{392,654},{408,648},{430,645},{455,642},{480,641},{505,640},{530,641},{560,644},{578,647},{590,653},{596,662}}
streamM = mask(function(x, y)
  if x < 384 or x > 596 or y < 620 or y > 700 then return 0 end
  local t = lineY(streamTop, x)
  local b = lineY(brinkLine, x)
  if y > b + 0.5 then return 0 end
  return clamp((y - t + 4) / 6, 0, 1)
end)
toeL2 = outline{{318,626},{330,629},{342,633},{356,637},{372,640},{390,641},{406,645},{420,649},{428,653},{412,655},{396,660},{386,667},{370,652},{350,660},{330,672},{318,676}, char="soft", seed=12111, amount=0.8, lobe=6}:mask() * aboveLine
toeR2 = outline{{546,653},{556,650},{572,649},{590,648},{610,647},{628,645},{644,644},{652,648},{654,676},{640,666},{626,661},{604,660},{594,663},{584,658},{566,656}, char="soft", seed=12112, amount=0.8, lobe=6}:mask() * aboveLine
oldRock = (rockFace * aboveLine):grow(2) * aboveLine
local sHard = streamM:map(function(v) return v > 0.5 and 1 or 0 end)
tanFix = oldRock - toeL2 - toeR2 - sHard
print(streamM:area(), toeL2:area(), toeR2:area(), oldRock:area(), tanFix:area())

--@ chunk 360
palette{scrape={birch, grayglaze, nearbank}}
glassy = pile{{"lead white",2},{"yellow ochre",1.2},{"raw umber",0.5},{"red earth",0.2},{"green earth",0.3}, name="glassy"}
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
toeR2 = toeR2 - rightClumpM:shrink(2)
local lineY = lineYf
local nz = noise{seed=12001, period=14, octaves=2}
-- a) tan where the old rock tops stood above the new brink
work(tanFix, {hand="body", tool={kind="flat", width=6, stiffness=0.5}, length={10,30}, coverage=4, fill=true, clip=true, load=1.0,
  angle=-math.pi/2, piles={{haze, 1}, {amber, 0.8}, {deeprust, 0.16}}})
blend(tanFix:shrink(1), {angle=math.pi/2})
-- b) the upper stream
local function depth(x, y) local t = lineY(streamTop, x); local b = lineY(brinkLine, x); return clamp((y - t) / math.max(4, b - t), 0, 1) end
local function sheen(x) return math.exp(-((x - 495)/80)^2) end
work(streamM, {hand="body", tool={kind="flat", width=4, stiffness=0.5}, length={10,30}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.03*nz(x,y) end,
  piles={{haze, function(x,y) return 0.7 + 0.8*clamp(1 - depth(x,y)*3, 0, 1) end},
         {amber, function(x,y) return 0.55*clamp(1 - depth(x,y)*3, 0, 1) end},
         {glow, function(x,y) return 0.55*clamp(depth(x,y)*2, 0, 1) end},
         {fallwhite, function(x,y) return 0.3*sheen(x)*clamp(depth(x,y)*1.5 - 0.3, 0, 1) end},
         {foamsh, function(x,y) return 0.35*clamp(depth(x,y), 0, 1) end}}})
blend(streamM:shrink(1), {angle=0.0})
-- c) far bank toes
local nz2 = noise{seed=12201, period=10, octaves=2}
work(toeL2 + toeR2, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={5,11}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{leafshade, 1}, {brushdark, function(x,y) return 0.7*clamp((y - 645)/15, 0, 1) end},
         {deeprust, function(x,y) return 0.5 * nz2:at01(x,y) end},
         {haze, function(x,y) return 0.6*clamp((650 - y)/12, 0, 1) end},
         {orangeleaf, function(x,y) return 0.5*clamp((x - 600)/45, 0, 1) * nz2:at01(x*1.5, y) end}}})
blend((toeL2 + toeR2):shrink(2), {angle=1.2})
print(drying(480, 650), drying(360, 640))

--@ chunk 361
capSpans = {{385, 435, 12}, {451, 514, 14}, {519, 538, 9}, {547, 593, 11}}
function capMask(i, extra)
  local s = capSpans[i]
  local nb = noise{seed=12300 + i, period=6, octaves=2}
  return mask(function(x, y)
    if x < s[1] - 2 or x > s[2] + 2 or y < 640 or y > 720 then return 0 end
    local b = lineYf(brinkLine, x)
    local d = s[3] + (extra or 0) + 4*nb(x, 0)
    if y < b - 0.5 or y > b + d then return 0 end
    return 1
  end) * (NS[i]:grow(2) + rect(s[1], 640, s[2] - s[1], 30))
end
capsAll = capMask(1) + capMask(2) + capMask(3) + capMask(4)
local function dB(x, y) return y - lineYf(brinkLine, x) end
capZone = mask(function(x, y) if x < 380 or x > 600 or y < 640 or y > 720 then return 0 end local d = dB(x, y); return (d >= 0 and d <= 36) and 1 or 0 end) * (NS[1] + NS[2] + NS[3] + NS[4] + capsAll)
print(capsAll:area(), capZone:area())

--@ chunk 362
local function dB(x, y) return y - lineYf(brinkLine, x) end
local nl = noise{seed=12401, period=9, octaves=2}
local allS = NS[1] + NS[2] + NS[3] + NS[4]
local zoneW = mask(function(x, y)
  if x < 380 or x > 600 or y < 640 or y > 730 then return 0 end
  local d = dB(x, y)
  local lim = 26 + 9*nl(x, 0)
  if d < 0 then return 0 end
  return clamp((lim - d)/8, 0, 1)
end) * (allS + capsAll) - capsAll
print(zoneW:area())
work(zoneW, {hand="body", tool={kind="flat", width=4, stiffness=0.5}, length={10,25}, coverage=3, fill=true, clip=true, load=0.9, angle=math.pi/2,
  piles={{fallwhite, 1}, {foamsh, 0.35}}})
work(capsAll, {hand="body", tool={kind="flat", width=3, stiffness=0.5}, length={6,14}, coverage=4, fill=true, clip=true, load=1.0, angle=0.05,
  piles={{glassy, 1}, {foamsh, 0.5}, {rock, function(x,y) return 0.16*clamp(dB(x,y)/10, 0, 1) end}, {glow, function(x,y) return 0.6*clamp(1 - dB(x,y)/5, 0, 1) end}}})
blend((capsAll + zoneW):shrink(1), {angle=math.pi/2})
local rb = brush{kind="round", width=1.8, point=0.6}
local x = 388
while x < 590 do
  local L = rand(5, 16)
  local x1 = math.min(590, x + L)
  rb:reload((rand(0,1) < 0.35) and glow or fallwhite, 0.5)
  rb:stroke({{x, lineYf(brinkLine, x) + 0.8}, {(x + x1)/2, lineYf(brinkLine, (x + x1)/2) + 0.5}, {x1, lineYf(brinkLine, x1) + 0.8}}, {pressure={0.3, 0.18}, ramps={0.25, 0.4}})
  x = x1 + rand(3, 9)
end

--@ chunk 363
rtL = {{316,722},{326,716},{338,708},{350,699},{362,693},{371,690},{377,692},{383,699}}
rtR = {{593,706},{600,700},{610,694},{620,693},{630,697},{640,704},{650,712},{660,720}}
local allS = NS[1] + NS[2] + NS[3] + NS[4]
local nv = noise{seed=12501, period=9, octaves=2}
vegL = mask(function(x, y)
  if x < 314 or x > 386 or y < 640 or y > 730 then return 0 end
  local top = 650 + 6*nv(x, 0)
  local bot = lineYf(rtL, x) + 3*nv(x*2, 50)
  return (y >= top and y <= bot) and 1 or 0
end) - allS:grow(1) - toeL2:shrink(3)
vegR = mask(function(x, y)
  if x < 592 or x > 668 or y < 640 or y > 735 then return 0 end
  local top = 655 + 6*nv(x, 0)
  local bot = lineYf(rtR, x) + 3*nv(x*2, 50)
  return (y >= top and y <= bot) and 1 or 0
end) - allS:grow(1) - toeR2:shrink(3)
print(vegL:area(), vegR:area())

--@ chunk 364
vegR = (vegR * rect(590, 640, 62, 100)) - rightClumpM:shrink(3)
local nv = noise{seed=12502, period=11, octaves=2}
-- a step of bank-dark along each jamb's outer edge, lower down
local function edgeX(m, y, fromLeft)
  if fromLeft then for x = 300, 400 do if m:at(x, y) > 0.5 then return x end end
  else for x = 690, 580, -1 do if m:at(x, y) > 0.5 then return x end end end
  return nil
end
local exL, exR = {}, {}
for y = 700, 860, 4 do exL[y] = edgeX(rockFace, y, true) or 340; exR[y] = edgeX(rockFace, y, false) or 640 end
local function ey(t, y) local k = 700 + math.floor((y - 700)/4)*4; return t[k] or t[700] end
stepL = mask(function(x, y)
  if y < 715 or y > 840 or x < 290 or x > 380 then return 0 end
  local e = ey(exL, y)
  local w = 9 + 5*nv(x*0.2, y)
  return (x >= e - 4 and x <= e + w) and 1 or 0
end) - (NS[1] + lowerC):grow(3) - fgRock2
stepR = mask(function(x, y)
  if y < 725 or y > 840 or x < 590 or x > 700 then return 0 end
  local e = ey(exR, y)
  local w = 9 + 5*nv(x*0.2, y)
  return (x <= e + 4 and x >= e - w) and 1 or 0
end) - (NS[4] + lowerC):grow(3)
print(vegR:area(), stepL:area(), stepR:area())

--@ chunk 365
stepL = (ribbon({{344,694},{340,720},{337,742},{326,748},{312,756},{304,772},{302,800},{302,838}}, 14):roughen(3, 8, 12511) ) - (NS[1] + lowerC):grow(3) - fgRock2 - vegL
stepR = stepR - vegR
print(stepL:area(), stepR:area())

--@ chunk 366
local function topsOf(m, x0, x1, y0, y1)
  local t = {}
  for x = x0, x1, 2 do
    t[x] = y1
    for y = y0, y1 do if m:at(x, y) > 0.5 then t[x] = y; break end end
  end
  return function(x, y) local k = x0 + math.floor((x - x0)/2)*2; return y - (t[k] or y1) end
end
local dL = topsOf(vegL, 310, 390, 630, 730)
local dR = topsOf(vegR, 588, 654, 630, 740)
local nz = noise{seed=12601, period=10, octaves=2}
local function dep(x, y) if x < 500 then return dL(x, y) else return dR(x, y) end end
work(vegL + vegR, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={5,11}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{leafshade, 1}, {brushdark, function(x,y) return 0.3 + clamp((dep(x,y) - 8)/25, 0, 1) end},
         {deeprust, function(x,y) return 0.7*clamp(1 - dep(x,y)/14, 0, 1) end},
         {orangeleaf, function(x,y) return 0.8*clamp(1 - dep(x,y)/6, 0, 1) * clamp((nz:at01(x,y) - 0.35)*3, 0, 1) end},
         {lent, function(x,y) return 0.5*clamp((dep(x,y) - 30)/20, 0, 1) end}}})
local nz2 = noise{seed=12602, period=8, octaves=2}
work(stepL + stepR, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={5,11}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{leafshade, 1}, {brushdark, 0.8}, {lent, 0.3},
         {deeprust, function(x,y) return 0.6*nz2:at01(x,y) end}}})
blend((vegL + vegR + stepL + stepR):shrink(2), {angle=1.2})

--@ chunk 367
local r = rag{width=14}
r:dip(0.9)
r:wipe(stepL + stepR, {pressure=0.85, angle=math.pi/2, passes=2, refold=0.5})
r:refold(); r:dip(0.9)
r:wipe(stepL + stepR, {pressure=0.85, angle=0.2, passes=2, refold=0.5})
print(r)

--@ chunk 368
for k = 1, 3 do
  local r = rag{width=36}
  r:dip(0.9)
  r:wipe(stepL + stepR, {pressure=0.9, angle=(k % 2 == 1) and math.pi/2 or 0.3, passes=2, refold=0.4})
  print(r)
end
print(drying(300, 810), drying(630, 780))

--@ chunk 369
local nz = noise{seed=12701, period=10, octaves=2}
work(stepL, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,18}, coverage=4.5, fill=true, clip=true, load=1.0, angle=1.5,
  piles={{lent, 1}, {rock, 0.6}, {brushdark, function(x,y) return 0.25 + 0.3*nz:at01(x,y) end}}})
work(stepR, {hand="body", tool={kind="filbert", width=5, stiffness=0.6}, length={6,14}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{lent, 0.6}, {brushdark, 1}, {leafshade, 0.6}, {deeprust, function(x,y) return 0.4*nz:at01(x,y) end}}})
blend((stepL + stepR):shrink(2), {angle=1.4})

--@ chunk 370
local cl = {{636,742,12,9,12801},{627,768,9,8,12802},{637,796,13,10,12803},{628,824,10,7,12804},{640,720,10,8,12805}}
local all = nil
for _, c in ipairs(cl) do
  local pts = {}
  math.randomseed(c[5])
  for i = 0, 9 do
    local a = i / 10 * 2 * math.pi + rand(-0.2, 0.2)
    local k = rand(0.75, 1.2)
    pts[#pts+1] = {c[1] + c[3]*k*math.cos(a), c[2] + c[4]*k*math.sin(a)}
  end
  local m = outline{pts=pts, char="soft", seed=c[5], amount=0.9, lobe=4}:mask() - (NS[4] + lowerC):grow(4)
  all = all and (all + m) or m
end
smallClR = all + stepR * mask(function(x, y) return 1 end)
local nz = noise{seed=12811, period=7, octaves=2}
-- lit from the upper left (glow): u = projection toward the glow
work(smallClR, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={4,9}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/5 + y/4) end,
  piles={{leafshade, 1}, {brushdark, 0.5}, {deeprust, function(x,y) return 0.6*nz:at01(x,y) end},
         {orangeleaf, function(x,y) return 0.7*clamp((nz:at01(x*1.3, y) - 0.55)*3, 0, 1) end}}})
print(smallClR:area())

--@ chunk 371
for _, p in ipairs({{340,860},{360,895},{640,860},{620,900},{480,915},{395,918},{550,920},{640,912},{700,880},{620,930},{600,950}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 372
wait(30 * 24 * 60)
for _, p in ipairs({{340,860},{360,895},{640,860},{620,900},{480,915},{395,918},{550,920},{640,912},{480,650},{360,670},{640,790},{300,800}}) do print(p[1], p[2], drying(p[1], p[2])) end

--@ chunk 373
print(palette())

--@ chunk 374
for i = 1, 9 do local b = BLD[i]; local s = ""; if type(b) == "table" then for k, v in pairs(b) do s = s .. tostring(k) .. "=" .. tostring(v) .. " " end end; print(i, s) end

--@ chunk 375
bm6 = bmasks[6]; bm7 = bmasks[7]; bm8 = bmasks[8]
for i = 5, 9 do local c = BLD[i].c; print(i, table.concat(c, ",")) end

--@ chunk 376
rockLN = outline{{284,914,"c"},{285,876},{290,844},{299,820,"c"},{314,808},{333,801,"c"},{348,806},{360,818,"c"},{368,842},{377,870},{386,898},{384,916,"c"}, char="broken", seed=13001, amount=0.5}:mask()
topLN = poly({{299,820},{314,808},{333,801},{348,806},{360,818},{350,822},{336,818},{318,822},{304,828}}) * rockLN
leftFaceLN = poly({{280,830},{299,820},{304,828},{300,850},{298,880},{300,920},{280,920}}) * rockLN
rockRN = outline{{600,920,"c"},{606,905},{620,895},{640,890,"c"},{662,891},{684,898,"c"},{700,911},{707,926},{700,940,"c"},{680,947},{652,949},{626,946},{608,937}, char="broken", seed=13002, amount=0.5}:mask()
local rRold = outline{{596,906},{598,880},{606,860},{620,846},{640,838},{664,842},{690,856},{694,912},{600,912}, char="broken", seed=9962, amount=0.5}:mask()
behindR = (rRold:grow(3) + rockR3:grow(2)) - rockRN - lowerC:shrink(2) - NS[4]:shrink(2)
print(rockLN:area(), topLN:area(), leftFaceLN:area(), rockRN:area(), behindR:area())

--@ chunk 377
rockRN = outline{{598,930,"c"},{606,918},{622,910},{644,906,"c"},{668,906},{690,910,"c"},{706,920},{712,934},{704,945,"c"},{680,950},{650,951},{622,949},{606,942}, char="broken", seed=13003, amount=0.45}:mask()
local rRold = outline{{596,906},{598,880},{606,860},{620,846},{640,838},{664,842},{690,856},{694,912},{600,912}, char="broken", seed=9962, amount=0.5}:mask()
behindR = (rRold:grow(3) + rockR3:grow(2)) * above(function(x) return 932 end) - rockRN - lowerC:shrink(2) - NS[4]:shrink(2)
sprayR = outline{{594,858},{604,856},{614,864},{626,870},{638,880},{648,892},{652,904},{644,914},{626,918},{606,916},{596,906}, char="soft", seed=13011, amount=0.8, lobe=5}:mask()
print(rockRN:area(), behindR:area(), sprayR:area())

--@ chunk 378
local nz = noise{seed=13101, period=12, octaves=2}
local function capY(x) return lineYf(newTopR, x) end
-- 1. behind the right foot: jamb dark above the bm7 cap, the cap band, bm7's face below
local upper = behindR * mask(function(x, y) if x < 620 then return 1 end; return (y < capY(x)) and 1 or 0 end)
local cap = behindR * mask(function(x, y) if x < 620 then return 0 end; local d = y - capY(x); return (d >= 0 and d < 14) and 1 or 0 end)
local face = behindR - upper - cap
print(upper:area(), cap:area(), face:area())
work(upper, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,18}, coverage=4, fill=true, clip=true, load=1.0, angle=1.5,
  piles={{lent, 0.8}, {rock, 0.7}, {brushdark, function(x,y) return 0.3 + 0.4*nz:at01(x,y) end}}})
work(cap, {hand="body", tool={kind="flat", width=5, stiffness=0.6}, length={8,18}, coverage=4, fill=true, clip=true, load=1.0,
  angle=math.atan(-10, 40),
  piles={{mossdeep, 1}, {brushdark, function(x,y) return 0.5*clamp((y - capY(x) - 6)/8, 0, 1) end},
         {rim_warm, function(x,y) return 0.5*clamp(1 - (y - capY(x))/3, 0, 1) * clamp((nz:at01(x*2, y) - 0.4)*3, 0, 1) end}}})
work(face, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,18}, coverage=4, fill=true, clip=true, load=1.0, angle=1.45,
  piles={{rock, 1}, {lent, 0.5}, {waterdark, 0.4}, {foamsh, 0.08}}})
blend(upper:shrink(1.5), {angle=1.5})
blend(face:shrink(1.5), {angle=1.45})

--@ chunk 379
for k = 1, 4 do
  local r = rag{width=30}
  r:dip(0.9)
  r:wipe(behindR, {pressure=0.9, angle=(k % 2 == 1) and math.pi/2 or 0.2, passes=2, refold=0.4})
end
print(drying(650, 860), drying(620, 880))

--@ chunk 380
local nz = noise{seed=13102, period=14, octaves=2}
work(behindR, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,20}, coverage=4.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.45 + 0.3*nz(x,y) end,
  piles={{lent, 1}, {rock, 0.7}, {brushdark, function(x,y) return 0.2 + 0.35*nz:at01(x,y) end}, {waterdark, 0.25}}})
blend(behindR:shrink(1.5), {angle=1.45})
-- bm7's mossy shoulder ends where it meets the jamb: a short soft continuation of its cap, descending
local capEnd = mask(function(x, y)
  if x < 668 or x > 704 then return 0 end
  local t = lineYf(newTopR, x) + (704 - x) * 0.25
  local d = y - t
  return (d >= 0 and d < 9 - (704 - x)*0.15) and 1 or 0
end) * behindR
print(capEnd:area())
work(capEnd, {hand="body", tool={kind="flat", width=4, stiffness=0.6}, length={6,12}, coverage=3, fill=true, clip=true, load=0.9, angle=math.atan(-10, 40),
  piles={{mossdeep, 1}, {brushdark, 0.6}}})

--@ chunk 381
local band = mask(function(x, y)
  if x < 616 or x > 700 then return 0 end
  return clamp(1 - math.abs(y - (836 + 0.002*(x - 655)^2))/10, 0, 1)
end) - sprayR:grow(4)
blend(band, {angle=1.2})
blend(band, {angle=2.0})
-- spray / white water spilling right of the curtain over the jamb foot
local nf = noise{seed=13201, period=7, octaves=2}
work(sprayR, {hand="body", tool={kind="round", width=5, stiffness=0.4}, length={5,12}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.2 + 0.5*nf(x,y) end,
  piles={{fallwhite, function(x,y) return 0.6 + 0.8*clamp(1 - (x - 596)/50, 0, 1) end}, {foamsh, 0.8},
         {rock, function(x,y) return 0.15*clamp((x - 625)/25, 0, 1) end}}})
blend(sprayR:shrink(2), {angle=1.2})
print(drying(620, 890))

--@ chunk 382
for k = 1, 4 do
  local r = rag{width=30}
  r:dip(0.9)
  r:wipe(sprayR:grow(2), {pressure=0.9, angle=(k % 2 == 1) and math.pi/2 or 0.3, passes=2, refold=0.4})
end

--@ chunk 383
local nz = noise{seed=13103, period=14, octaves=2}
local zone = (sprayR:grow(5) - lowerC:shrink(1) - NS[4]:shrink(1)) * above(function(x) return 935 end)
work(zone, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,20}, coverage=5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.45 + 0.3*nz(x,y) end,
  piles={{lent, 1}, {rock, 0.7}, {brushdark, function(x,y) return 0.2 + 0.35*nz:at01(x,y) end}, {waterdark, 0.25}}})
blend(zone:shrink(1.5), {angle=1.45})

--@ chunk 384
local edgeL = {{0,840},{604,840},{600,860},{597,880},{596,905},{1000,905}}
local nz = noise{seed=13104, period=14, octaves=2}
local zone = (sprayR:grow(6) * mask(function(x, y)
  local ex = (y < 860) and lerp(604, 600, (y - 840)/20) or ((y < 880) and lerp(600, 597, (y - 860)/20) or lerp(597, 596, (y - 880)/25))
  return (x > ex and y < 908) and 1 or 0
end))
print(zone:area())
work(zone, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,20}, coverage=5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.45 + 0.3*nz(x,y) end,
  piles={{lent, 1}, {rock, 0.7}, {brushdark, function(x,y) return 0.2 + 0.3*nz:at01(x,y) end}, {waterdark, 0.25}}})
blend(zone:shrink(1.5), {angle=1.45})

--@ chunk 385
local nz = noise{seed=13301, period=12, octaves=2}
-- left foot rock: tall, angular
local body = rockLN - topLN - leftFaceLN
work(body, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,20}, coverage=4.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.5 + 0.25*nz(x,y) end,
  piles={{lent, 1}, {rock, 0.8}, {waterdark, function(x,y) return 0.2 + 0.4*clamp((y - 880)/30, 0, 1) end},
         {brushdark, function(x,y) return 0.25*nz:at01(x,y) end}}})
work(leftFaceLN, {hand="body", tool={kind="flat", width=4, stiffness=0.6}, length={8,18}, coverage=4, fill=true, clip=true, load=1.0, angle=1.55,
  piles={{rock, 1}, {brushdark, 0.9}, {deeprust, 0.25}, {lent, 0.3}}})
work(topLN, {hand="body", tool={kind="flat", width=4, stiffness=0.6}, length={6,14}, coverage=4, fill=true, clip=true, load=1.0, angle=-0.3,
  piles={{rock, 1}, {haze, 0.9}, {amber, 0.35}, {glassy, function(x,y) return 0.4*clamp((x - 320)/30, 0, 1) end}}})
-- right foot rock: low, half-drowned slab
topRN = rockRN * mask(function(x, y)
  local t = lineYf({{598,930},{606,918},{622,910},{644,906},{668,906},{690,910},{706,920},{712,934}}, x)
  return (y < t + 6 + 2*nz(x, 3)) and 1 or 0
end)
local bodyR = rockRN - topRN
work(bodyR, {hand="body", tool={kind="filbert", width=6, stiffness=0.6}, length={8,18}, coverage=4.5, fill=true, clip=true, load=1.0, angle=0.1,
  piles={{lent, 1}, {rock, 0.8}, {waterdark, 0.5}, {brushdark, function(x,y) return 0.2*nz:at01(x,y) end}}})
work(topRN, {hand="body", tool={kind="flat", width=4, stiffness=0.6}, length={8,16}, coverage=4, fill=true, clip=true, load=1.0, angle=0.0,
  piles={{rock, 1}, {haze, 0.7}, {mossdeep, 0.35}, {amber, 0.2}}})
blend(body:shrink(1.5), {angle=1.5})
blend(bodyR:shrink(1.5), {angle=0.1})
print(topRN:area())

--@ chunk 386
local nz = noise{seed=13401, period=10, octaves=2}
-- left rock: cover the gravestone cap and most of the brown side with body dark
local capZone = (topLN:grow(2) + leftFaceLN * mask(function(x, y) return (x > 290) and 1 or 0 end)) * rockLN
work(capZone, {hand="body", tool={kind="filbert", width=5, stiffness=0.6}, length={6,14}, coverage=5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.5 + 0.3*nz(x,y) end,
  piles={{lent, 1}, {rock, 0.8}, {brushdark, function(x,y) return 0.2 + 0.4*nz:at01(x,y) end}}})
-- right rock: cover the ring; square the bottom to a level waterline at y ~948
local fillCorners = mask(function(x, y)
  if x < 600 or x > 711 or y < 925 or y > 948 then return 0 end
  return 1
end) - rockRN
local ringZone = (topRN:grow(2) * rockRN) + fillCorners
work(ringZone, {hand="body", tool={kind="filbert", width=5, stiffness=0.6}, length={6,14}, coverage=5, fill=true, clip=true, load=1.0, angle=0.1,
  piles={{lent, 1}, {rock, 0.8}, {waterdark, 0.5}}})
rockRN2 = rockRN + fillCorners
print(fillCorners:area(), ringZone:area())

--@ chunk 387
facetA = poly({{300,824},{310,814},{322,807},{333,802},{346,805},{340,811},{328,814},{316,819},{306,826}}) * rockLN:shrink(0.5)
facetB = poly({{348,806},{356,812},{363,824},{369,842},{375,862},{379,880},{372,872},{364,850},{357,830},{350,815}}) * rockLN:shrink(0.5)
facetR = mask(function(x, y)
  if x < 612 or x > 702 then return 0 end
  local t = lineYf({{606,918},{622,910},{644,906},{668,906},{690,910},{706,920}}, x)
  local th = 3 + 2.5*math.sin(x/9) + 1.5*math.sin(x/4.3)
  return (y >= t - 0.5 and y <= t + th) and 1 or 0
end) * rockRN2
print(facetA:area(), facetB:area(), facetR:area())

--@ chunk 388
local nz = noise{seed=13501, period=6, octaves=2}
work(facetA, {hand="body", tool={kind="flat", width=3, stiffness=0.6}, length={5,12}, coverage=4, fill=true, clip=true, load=1.0, angle=-0.45,
  piles={{rock, 1}, {haze, 0.55}, {amber, 0.25}, {mossdeep, function(x,y) return 0.3*nz:at01(x,y) end}}})
work(facetB, {hand="body", tool={kind="flat", width=3, stiffness=0.6}, length={6,14}, coverage=4, fill=true, clip=true, load=1.0, angle=1.2,
  piles={{rock, 1}, {haze, 0.7}, {glassy, 0.3}, {foamsh, 0.15}}})
work(facetR, {hand="body", tool={kind="flat", width=3, stiffness=0.6}, length={6,14}, coverage=4, fill=true, clip=true, load=1.0, angle=0.0,
  piles={{rock, 1}, {haze, 0.5}, {foamsh, 0.3}, {mossdeep, function(x,y) return 0.3*nz:at01(x,y) end}}})
blend(facetA:shrink(0.5), {angle=-0.45})
blend(facetB:shrink(0.5), {angle=1.2})
blend(facetR:shrink(0.5), {angle=0.0})
-- thin broken rim along the left rock's top edge, facing the glow
local rg = brush{kind="round", width=2.2, point=0.6}
rg:reload(rim_warm, 0.5)
rg:gesture({{316, 809, 0.1}, {326, 803, 0.4}, {334, 800, 0.45}, {344, 803, 0.3}, {350, 807, 0.05}}, {wobble=0.3})
rg:reload(glassy, 0.5)
rg:gesture({{352, 810, 0.1}, {358, 818, 0.35}, {364, 832, 0.25}, {368, 846, 0.05}}, {wobble=0.3})

--@ chunk 389
local zL = (facetA + facetB):grow(5) * rockLN:shrink(3)
local zR = facetR:grow(5) * rockRN2:shrink(3)
blend(zL, {angle=1.3})
blend(zL, {angle=0.2})
blend(zR, {angle=0.0})
blend(zR, {angle=1.4})

--@ chunk 390
local nz = noise{seed=13601, period=8, octaves=2}
-- darken the left end of the pale arc: the lit plane becomes a corner facing the falls
local cutA = mask(function(x, y)
  if x < 290 or x > 322 or y < 795 or y > 840 then return 0 end
  return 1
end) * rockLN:shrink(0.5)
work(cutA, {hand="body", tool={kind="filbert", width=4, stiffness=0.6}, length={5,12}, coverage=5, fill=true, clip=true, load=1.0, angle=1.0,
  piles={{lent, 1}, {rock, 0.8}, {brushdark, function(x,y) return 0.2 + 0.3*nz:at01(x,y) end}}})
-- a crack splitting the face and a dark seam under the lit corner
local rg = brush{kind="round", width=2.5, point=0.6}
rg:reload(lent, 0.6)
rg:gesture({{322, 808, 0.2}, {326, 830, 0.5}, {321, 856, 0.4}, {326, 880, 0.2}, {324, 900, 0.05}}, {wobble=0.6})
rg:reload(lent, 0.6)
rg:gesture({{334, 816, 0.3}, {346, 820, 0.5}, {356, 834, 0.3}}, {wobble=0.4})
print(cutA:area())

--@ chunk 391
grayBoxM = outline{{694,902},{712,898},{732,902},{738,914},{734,928},{716,932},{700,930},{694,918}, char="broken", seed=13701, amount=0.5}:mask() - rockRN2
local nz = noise{seed=13702, period=9, octaves=2}
reflRN = mask(function(x, y)
  if x < 596 or x > 716 or y < 944 or y > 1010 then return 0 end
  local bot = lineYf({{598,946},{606,957},{620,967},{640,973},{664,975},{688,971},{704,961},{714,948}}, x)
  if y < 945 then return 0 end
  if y <= bot then return 1 end
  -- tails: vertical streaks fading down
  local t = (y - bot) / 30
  return clamp((1 - t) * (0.5 + 0.7*nz(x*0.15, y*0.02)), 0, 1)
end) - rockRN2:shrink(1)
print(grayBoxM:area(), reflRN:area())

--@ chunk 392
local nz = noise{seed=13801, period=10, octaves=2}
work(grayBoxM, {hand="body", tool={kind="filbert", width=5, stiffness=0.6}, length={6,14}, coverage=4.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.45 + 0.3*nz(x,y) end,
  piles={{rock, 1}, {lent, 0.5}, {waterdark, 0.5}, {brushdark, function(x,y) return 0.2*nz:at01(x,y) end}}})
blend(grayBoxM:shrink(1.5), {angle=1.45})
-- reflection of the slab: vertical pulls, darkest right under the contact
work(reflRN, {hand="body", tool={kind="flat", width=5, stiffness=0.5}, length={10,30}, coverage=3.5, fill=true, clip=true, angle=math.pi/2,
  load_at=function(x,y) return clamp(1 - (y - 950)/60, 0.25, 1) end,
  piles={{waterdark, 1}, {rock, function(x,y) return 0.6*clamp(1 - (y - 948)/25, 0, 1) end}, {haze, 0.12},
         {deeprust, function(x,y) return 0.25*nz:at01(x,y) end}}})
blend(reflRN:shrink(1), {angle=math.pi/2})

--@ chunk 393
for k = 1, 4 do
  local r = rag{width=30}
  r:dip(0.9)
  r:wipe(reflRN:grow(3) - rockRN2, {pressure=0.9, angle=(k % 2 == 1) and 0 or math.pi/2, passes=2, refold=0.4})
end

--@ chunk 394
local m = reflRN:grow(3) - rockRN2
print(m:area())
for k = 1, 6 do
  local r = rag{width=24}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and math.pi/2 or 0.0, passes=3, refold=0.3})
  print(r)
end
print(drying(650, 990), drying(620, 960))

--@ chunk 395
local m = rect(588, 940, 134, 80) - rockRN2:shrink(0.5)
for k = 1, 6 do
  local r = rag{width=24}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and math.pi/2 or 0.0, passes=3, refold=0.3})
end
print(drying(650, 990), drying(620, 960), drying(700, 1000))

--@ chunk 396
local fb = brush{kind="flat", width=7, stiffness=0.5}
local xs = uneven(14, 602, 708, 0.6, 0.3, 13901)
for i, x in ipairs(xs) do
  fb:reload((i % 3 == 0) and waterdark or rock, 0.45)
  local L = 16 + 22 * math.sin(math.pi * (x - 598) / 114) + rand(-6, 6)
  fb:stroke({{x, 949}, {x + rand(-0.5, 0.5), 949 + L*0.5}, {x + rand(-1, 1), 949 + L}}, {pressure={0.6, 0.05}, orient="across", ramps={0.05, 0.6}})
end
-- one soft vertical blend just across the pulls (wet over dry: only they move)
local m = rect(596, 950, 118, 50):soften(4)
blend(m, {angle=math.pi/2})
-- horizontal breaks across the reflection
local hb = brush{kind="flat", width=3, stiffness=0.5}
for k = 1, 5 do
  local y = 958 + k * 6 + rand(-2, 2)
  local x0 = rand(600, 640)
  hb:reload(haze, 0.3)
  hb:stroke({{x0, y}, {x0 + rand(25, 60), y + rand(-0.3, 0.3)}}, {pressure={0.25, 0.1}, orient="across", ramps={0.3, 0.4}})
end

--@ chunk 397
local m = rect(588, 940, 134, 80) - rockRN2:shrink(0.5)
for k = 1, 8 do
  local r = rag{width=24}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and math.pi/2 or 0.0, passes=3, refold=0.3})
end
print(drying(650, 990), drying(620, 960))

--@ chunk 398
local m = foamM3 * mask(function(x, y) return (x > 372 and x < 600 and y > 896 and y < 930) and 1 or 0 end)
local dashes = mask(function(x, y) return 0 end)
print(m:area())
local nf = noise{seed=14001, period=8, octaves=2}
work(m, {hand="body", tool={kind="round", width=4, stiffness=0.4}, length={5,12}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.3*nf(x,y) end,
  piles={{fallwhite, function(x,y) return clamp(1 - (y - 900)/25, 0.2, 1) end}, {foamsh, function(x,y) return 0.4 + clamp((y - 905)/15, 0, 1) end},
         {haze, function(x,y) return 0.25*clamp((y - 915)/10, 0, 1) end}}})
blend(m:shrink(1.5), {angle=0.0})

--@ chunk 399
local waterAll = ((newFalls + lowerC) - wedgeL + foamM3)
local function cx(t, y)
  local f = (y - 714) / (902 - 714)
  return lerp(lerp(366, 346, f), lerp(600, 630, f), t)
end
local fan = brush{kind="fan", width=9, stiffness=0.5}
for k = 1, 26 do
  if k % 2 == 1 then fan:reload((k % 3 == 0) and foamsh or fallwhite, 0.3) end
  local tt = (k - 0.5) / 26 + rand(-0.012, 0.012)
  local y0 = rand(866, 884)
  local y1 = rand(904, 918)
  local pts = {}
  for j = 0, 3 do local y = lerp(y0, y1, j/3); pts[#pts+1] = {cx(tt, math.min(y, 900)) + rand(-0.6, 0.6), y} end
  fan:stroke(pts, {pressure={0.35, 0.2}, orient="across", ramps={0.4, 0.4}, clip=waterAll})
end
-- foam lumps at varied heights along the old seam and the side edges
local rbb = brush{kind="round", width=6, stiffness=0.4, lay=2}
for k = 1, 30 do
  local x
  if k <= 6 then x = rand(366, 380) elseif k <= 12 then x = rand(592, 606) else x = rand(380, 592) end
  local y = 896 + rand(-7, 6)
  if waterAll:at(x, y + 3) > 0.5 then
    rbb:reload((k % 4 == 0) and foamsh or fallwhite, 0.6)
    local w = rand(3, 7)
    rbb:stroke({{x - w, y + 2}, {x, y - rand(1, 3)}, {x + w, y + 2}}, {pressure={0.45, 0.25}, clip=waterAll})
  end
end

--@ chunk 400
local m = rect(340, 858, 290, 80) - rockRN2:shrink(1)
for k = 1, 8 do
  local r = rag{width=24}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and math.pi/2 or 0.0, passes=3, refold=0.3})
end
local open = 0
for x = 345, 625, 10 do for y = 862, 934, 8 do if drying(x, y) == "open" then open = open + 1 end end end
print("open samples", open)

--@ chunk 401
wait(30 * 24 * 60)
local open = 0
for x = 290, 720, 10 do for y = 800, 960, 8 do if drying(x, y) ~= "dry" then open = open + 1 end end end
print("not dry samples", open)
print(drying(340, 860), drying(620, 880), drying(650, 930))

--@ chunk 402
local d = {
  {338,355,925,929},{356,372,922,926},{380,400,911,915},{385,398,918,922},{438,452,912,916},{485,500,920,924},{505,522,916,920},
  {455,470,921,924},{548,570,908,913},{560,575,926,930},{575,592,910,915},{598,612,906,912}}
local m = nil
for _, r in ipairs(d) do local q = rect(r[1] - 3, r[3] - 3, r[2] - r[1] + 6, r[4] - r[3] + 6); m = m and (m + q) or q end
dashM = (m:soften(2) * foamM3:grow(4)) - rockRN2 - rockLN
print(dashM:area())

--@ chunk 403
local nt = noise{seed=14101, period=18, octaves=2}
foamLow = (foamM3:grow(3) * mask(function(x, y)
  if x < 330 or x > 640 or y > 940 then return 0 end
  local t = 899 + 5*nt(x, 0)
  return clamp((y - t)/7, 0, 1)
end)) - rockRN2:grow(1) - rockLN:grow(1)
print(foamLow:area())

--@ chunk 404
local nf = noise{seed=14102, period=7, octaves=2}
work(foamLow, {hand="body", tool={kind="round", width=4, stiffness=0.4}, length={5,12}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.25*nf(x,y) end,
  piles={{foamsh, 1}, {fallwhite, function(x,y) return 0.5 + 0.6*nf:at01(x,y) end},
         {haze, function(x,y) return 0.3*clamp((y - 918)/10, 0, 1) end}}})
blend(foamLow:shrink(1.5), {angle=0.0})
-- a few small lumps on the top edge to break it
local rbb = brush{kind="round", width=5, stiffness=0.4}
for k = 1, 14 do
  local x = rand(380, 600)
  local y = 899 + 5*0 + rand(-3, 3)
  if foamLow:at(x, y + 4) > 0.3 then
    rbb:reload(foamsh, 0.5)
    local w = rand(3, 6)
    rbb:stroke({{x - w, y + 2}, {x, y - 1}, {x + w, y + 2}}, {pressure={0.35, 0.2}, clip=foamLow:grow(3)})
  end
end

--@ chunk 405
local band = (foamLow:grow(4) * mask(function(x, y) return clamp(1 - math.abs(y - 899)/8, 0, 1) end)) - rockRN2:grow(2) - rockLN:grow(2)
blend(band, {angle=0.0})
blend(band, {angle=0.4})

--@ chunk 406
palette{scrape={mossdeep, glassy}}
glowrefl = pile{{"lead white",3},{"yellow ochre",1.4},{"chrome yellow",0.4},{"red earth",0.25},{"raw umber",0.15}, name="glowrefl"}
local poolOnly = below({{-10,906},{1010,906}}) - fgRock2:grow(2) - rockLN - rockRN2
local fb = brush{kind="flat", width=6, stiffness=0.5}
local xs = uneven(46, 362, 478, 0.6, 0.3, 15001)
for i, x in ipairs(xs) do
  local t = clamp((x - 372) / 95, 0, 1)
  local w = {waterdark = lerp(0.62, 0.12, t), haze = lerp(0.3, 0.13, t), amber = lerp(0.08, 0.0, t), glowrefl = lerp(0.0, 0.75, t)}
  local p = mix{{waterdark, w.waterdark}, {haze, w.haze}, {amber, w.amber + 0.001}, {glowrefl, w.glowrefl + 0.001}, name="streakmix"}
  fb:reload(p, 0.55)
  palette{scrape={p}}
  local y0 = rand(1062, 1140)
  local L = rand(45, 110)
  fb:stroke({{x, y0}, {x + rand(-0.6, 0.6), y0 + L*0.5}, {x + rand(-1, 1), y0 + L}}, {pressure={0.55, 0.45}, orient="across", ramps={0.3, 0.35}, clip=poolOnly})
end

--@ chunk 407
local m = (rect(352, 1050, 136, 130) * (below({{-10,906},{1010,906}}) - fgRock2:grow(2)))
for k = 1, 8 do
  local r = rag{width=24}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and math.pi/2 or 0.0, passes=3, refold=0.3})
end
local n = 0
for x = 355, 485, 8 do for y = 1055, 1175, 8 do if drying(x, y) == "open" then n = n + 1 end end end
print("open", n)

--@ chunk 408
local m = (rect(352, 1165, 136, 85) * (below({{-10,906},{1010,906}}) - fgRock2:grow(2)))
for k = 1, 8 do
  local r = rag{width=24}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and math.pi/2 or 0.0, passes=3, refold=0.3})
end
local n = 0
for x = 355, 485, 6 do for y = 1050, 1248, 6 do if drying(x, y) == "open" then n = n + 1 end end end
print("open", n)

--@ chunk 409
wait(20 * 24 * 60)
local n = 0
for x = 0, 1000, 20 do for y = 900, 1250, 15 do if drying(x, y) ~= "dry" then n = n + 1 end end end
print("not dry in pool", n)

--@ chunk 410
local ns = noise{seed=15101, period=10, octaves=3, stretch={math.pi/2, 10}}
local poolOnly = below({{-10,906},{1010,906}}) - fgRock2:grow(1) - rockLN - rockRN2
-- the glow reflection: one film with ragged vertical sides and a ragged top inside the column
glowGlz = mask(function(x, y)
  if y < 1040 or y > 1250 then return 0 end
  local half = 150 + 25*ns(x, y) + 0.9*(y - 1040)
  local top = 1075 + 30*ns(x*1.3, 50)
  return ((math.abs(x - 500) < half) and (y > top)) and 1 or 0
end) * poolOnly
-- the pale crumpled facets: an extra film
facetGlz = mask(function(x, y)
  if x < 385 or x > 475 or y < 1080 or y > 1195 then return 0 end
  local d = ((x - 428)/42)^2 + ((y - 1135)/52)^2
  return (d + 0.3*ns(x, y) < 1) and 1 or 0
end) * poolOnly
print(glowGlz:area(), facetGlz:area())

--@ chunk 411
local ns = noise{seed=15101, period=10, octaves=3, stretch={math.pi/2, 10}}
local poolOnly = below({{-10,906},{1010,906}}) - fgRock2:grow(1) - rockLN - rockRN2
local function G(top0, w0)
  return mask(function(x, y)
    if y < 1040 or y > 1250 then return 0 end
    local half = w0 + 18*ns(x, y) + 0.75*(y - 1080)
    local top = top0 + 25*ns(x*1.3, 50)
    return ((math.abs(x - 492) < half) and (y > top)) and 1 or 0
  end) * poolOnly
end
glowGlz = G(1085, 70)
glowGlz2 = G(1140, 55)
print(glowGlz:area(), glowGlz2:area())

--@ chunk 412
palette{scrape={glowrefl}}
gD2 = pile{{"raw umber",1},{"smalt",0.8},{"lead white",0.3},{"red earth",0.2}, medium=0.82, name="gD2"}
work(glowGlz, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool={kind="filbert", width=8, stiffness=0.3}, seed=15201})
work(glowGlz2, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool={kind="filbert", width=8, stiffness=0.3}, seed=15202})
work(facetGlz, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool={kind="filbert", width=6, stiffness=0.3}, seed=15203})

--@ chunk 413
wait(20 * 24 * 60)
print(drying(500, 1140), drying(420, 1220), drying(440, 1130))

--@ chunk 414
function wbands(x0, x1, y0, y1, gap0, gap1, L0, L1, w0, w1, seed, gapPow)
  math.randomseed(seed)
  local bands = nil
  local y = y0
  local i = 0
  while y < y1 do
    i = i + 1
    local t = (y - y0)/(y1 - y0)
    local L = lerp(L0, L1, t) * rand(0.6, 1.2)
    local xs = rand(x0 - L*0.3, x1 - L*0.7)
    local w = lerp(w0, w1, t) * rand(0.6, 1.3)
    local pts, ws = {}, {}
    for k = 0, 10 do
      local u = k/10
      pts[#pts+1] = {xs + L*u, y + lerp(0.5, 1.6, t)*math.sin(u*4 + i)}
      ws[#ws+1] = w * math.sin(math.pi * u)^0.5 * (0.7 + 0.3*math.sin(u*7 + i*2))
    end
    local r = ribbon(pts, ws)
    bands = bands and (bands + r) or r
    y = y + lerp(gap0, gap1, t^(gapPow or 1)) * rand(0.6, 1.4)
  end
  return bands
end
local poolOnly = below({{-10,908},{1010,908}}) - fgRock2:grow(2) - rockLN:grow(2) - rockRN2:grow(2)
darkB = wbands(390, 610, 930, 1245, 6, 30, 30, 200, 1.2, 7, 15301, 1.3) * poolOnly
lightBL = wbands(10, 370, 925, 1070, 7, 20, 30, 120, 1.2, 3.5, 15302) * poolOnly
lightBR = wbands(640, 990, 960, 1245, 8, 28, 40, 200, 1.5, 5, 15303, 1.3) * poolOnly
print(darkB:area(), lightBL:area(), lightBR:area())

--@ chunk 415
lightG2 = pile{{"lead white",3},{"yellow ochre",0.5},{"smalt",0.4},{"red earth",0.1}, medium=0.85, name="lightG2"}
work(darkB, {hand="glaze", pile=gD2, coverage=1, angle=0.0, tool={kind="filbert", width=6, stiffness=0.3}, clip=true, seed=15311})
work(lightBL + lightBR, {hand="glaze", pile=lightG2, coverage=1, angle=0.0, tool={kind="filbert", width=5, stiffness=0.3}, clip=true, seed=15312})

--@ chunk 416
local n = 0
for x = 300, 700, 10 do for y = 800, 950, 8 do if drying(x, y) ~= "dry" then n = n + 1 end end end
print("not dry", n)
local nm = noise{seed=15401, period=24, octaves=3, kind="billow"}
local nb = noise{seed=15402, period=12, octaves=2}
local function mv(x, y)
  if x < 290 or x > 700 or y < 800 or y > 960 then return 0 end
  local hx = clamp(1 - math.abs(x - 486)/215, 0, 1)^0.7
  local vy = (y < 905) and clamp(1 - (905 - y)/75, 0, 1) or clamp(1 - (y - 905)/40, 0, 1)
  return hx * vy * (0.35 + 0.9*nm:at01(x, y))
end
mist1 = mask(function(x, y) return clamp((mv(x, y) - 0.3) * 10, 0, 1) end):soften(3)
mist2 = mask(function(x, y) return clamp((mv(x, y) - 0.55) * 10, 0, 1) end):soften(3)
mist3 = mask(function(x, y) return clamp((mv(x, y) - 0.8) * 10, 0, 1) end):soften(3)
print(mist1:area(), mist2:area(), mist3:area())

--@ chunk 417
local nm = noise{seed=15403, period=20, octaves=3, kind="billow", stretch={0, 1.6}}
local function mv(x, y)
  if x < 285 or x > 705 or y < 790 or y > 925 then return 0 end
  local hx = clamp(1 - math.abs(x - 488)/225, 0, 1)^0.5
  local vy = (y < 898) and clamp(1 - (898 - y)/90, 0, 1)^0.8 or clamp(1 - (y - 898)/18, 0, 1)
  return hx * vy * (0.25 + 1.0*nm:at01(x, y))
end
mist1 = mask(function(x, y) return clamp((mv(x, y) - 0.28) * 10, 0, 1) end):soften(3)
mist2 = mask(function(x, y) return clamp((mv(x, y) - 0.48) * 10, 0, 1) end):soften(3)
mist3 = mask(function(x, y) return clamp((mv(x, y) - 0.68) * 10, 0, 1) end):soften(3)
print(mist1:area(), mist2:area(), mist3:area())

--@ chunk 418
palette{scrape={orangeleaf}}
mistw2 = pile{{"lead white",6},{"yellow ochre",0.15},{"cobalt blue",0.08}, medium=0.85, name="mistw2"}
work(mist1, {hand="glaze", pile=mistw2, coverage=1, angle=-0.2, seed=15411})
work(mist2, {hand="glaze", pile=mistw2, coverage=1, angle=0.1, seed=15412})
work(mist3, {hand="glaze", pile=mistw2, coverage=1, angle=-0.1, seed=15413})

--@ chunk 419
local m = mist1:grow(4)
for k = 1, 6 do
  local r = rag{width=24}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and 0.0 or math.pi/2, passes=3, refold=0.3})
end
local n = 0
for x = 290, 700, 6 do for y = 800, 930, 6 do if drying(x, y) == "open" then n = n + 1 end end end
print("open", n)

--@ chunk 420
local m = mist1:grow(12):map(function(v) return v > 0.05 and 1 or 0 end) * rect(280, 780, 440, 160)
print(m:area())
for k = 1, 8 do
  local r = rag{width=20}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and 0.0 or math.pi/2, passes=3, refold=0.3})
end
local n = 0
for x = 290, 700, 6 do for y = 790, 935, 6 do if drying(x, y) == "open" then n = n + 1 end end end
print("open", n)

--@ chunk 421
wait(20 * 24 * 60)
local n = 0
for x = 0, 1000, 20 do for y = 0, 1250, 20 do if drying(x, y) ~= "dry" then n = n + 1 end end end
print("not dry", n)

--@ chunk 422
palette{scrape={gD2, lightG2, mistw2}}
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
leafrust = pile{{"red earth",2},{"vermilion",0.6},{"yellow ochre",1.2}, name="leafrust"}
goldleaf = pile{{"chrome yellow",2},{"yellow ochre",1.5},{"red earth",0.3}, name="goldleaf"}
local protect = newFalls:grow(3) + lowerC:grow(3) + rockLN:grow(2) + rockRN2:grow(2) + foamM3:grow(3) + below({{-10,900},{1010,900}})
lowClumps = {
  {{52,822,52,24}, 0.3}, {{128,812,46,20}, 0.35}, {{24,856,34,30}, 0.2}, {{182,820,30,15}, 0.4},
  {{796,834,44,18}, 0.3}, {{862,826,50,22}, 0.3}, {{928,842,40,26}, 0.25}, {{984,858,26,30}, 0.2},
}
for i, c in ipairs(lowClumps) do clump4(c[1], 16000 + i, gx, gy - 60, {minus=protect, lit=c[2]}) end
local lz = nil
for i, c in ipairs(lowClumps) do local m = clump_mask(c[1], 16000 + i); lz = lz and (lz + m) or m end
lowClumpM = lz - protect
print(lowClumpM:area())

--@ chunk 423
local nz = noise{seed=16101, period=10, octaves=2}
local crown = nil
for i, c in ipairs(lowClumps) do
  local m = clump_mask(c[1], 16000 + i)
  local cx, cy, rx, ry = c[1][1], c[1][2], c[1][3], c[1][4]
  local cm = m * mask(function(x, y)
    local u = ((x - cx)/rx) * (-0.35) + ((y - cy)/ry) * (-0.94)
    return (u > 0.55) and 1 or 0
  end)
  crown = crown and (crown + cm) or cm
end
local protect = newFalls:grow(3) + lowerC:grow(3) + rockLN:grow(2) + rockRN2:grow(2) + foamM3:grow(3) + below({{-10,900},{1010,900}})
local shade = lowClumpM - crown - protect
work(shade, {hand="body", tool={kind="filbert", width=6, stiffness=0.5}, length={5,11}, coverage=3.5, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{leafshade, 1}, {brushdark, 0.9}, {lent, function(x,y) return 0.25*clamp((y - 830)/30, 0, 1) end},
         {deeprust, function(x,y) return 0.35*nz:at01(x,y) end}}})
blend(lowClumpM:shrink(2) - protect, {angle=1.2})

--@ chunk 424
local m = (lowClumpM:grow(14)):map(function(v) return v > 0.05 and 1 or 0 end) - below({{-10,902},{1010,902}}) - newFalls - lowerC - rockLN - rockRN2
print(m:area())
for k = 1, 10 do
  local r = rag{width=24}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and 0.0 or math.pi/2, passes=3, refold=0.3})
end
local n = 0
for x = 0, 1000, 6 do for y = 780, 900, 6 do if drying(x, y) == "open" then n = n + 1 end end end
print("open", n)

--@ chunk 425
local m = (lowClumpM:grow(14)):map(function(v) return v > 0.05 and 1 or 0 end) - below({{-10,902},{1010,902}}) - newFalls - lowerC - rockLN - rockRN2
for k = 1, 12 do
  local r = rag{width=20}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and 0.0 or math.pi/2, passes=2, refold=0.25})
end
local n = 0
for x = 0, 1000, 6 do for y = 780, 900, 6 do if drying(x, y) == "open" then n = n + 1 end end end
print("open", n)
print(probe)

--@ chunk 426
wait(10 * 24 * 60)
newTopL = {{10,862},{18,846},{34,836},{60,830},{88,828},{108,832},{118,842},{126,840},{140,826},{168,818},{196,815},{222,818},{246,826},{268,836},{284,848},{292,862}}
local oldB = bm5 or bmasks[5]
bm5 = bmasks[5]
-- region of the old boulder above the new top line → bank behind
cutL = bm5 * mask(function(x, y) if x < 0 or x > 300 then return 0 end; return (y < lineYf(newTopL, x)) and 1 or 0 end)
-- new cap band below the new top line
capL = bm5:grow(2) * mask(function(x, y) if x < 8 or x > 294 then return 0 end; local d = y - lineYf(newTopL, x); return (d >= 0 and d < 11 + 3*math.sin(x/13)) and 1 or 0 end)
-- picket band: from cap bottom to ~y 885
faceL = bm5 * mask(function(x, y) if x < 0 or x > 300 then return 0 end; local d = y - lineYf(newTopL, x); return (d >= 11 and y < 905) and 1 or 0 end) - capL
print(cutL:area(), capL:area(), faceL:area(), drying(100, 860))

--@ chunk 427
palette{scrape={leafrust, goldleaf}}
mossdeep = pile{{"green earth",2},{"raw umber",1.2},{"yellow ochre",0.8},{"Prussian blue",0.1}, name="mossdeep"}
local nz = noise{seed=16201, period=10, octaves=2}
-- 1. bank behind, where the dome stood
work(cutL, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={5,11}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{leafshade, 1}, {brushdark, 0.8}, {deeprust, function(x,y) return 0.4*nz:at01(x,y) end}, {lent, 0.15}}})
-- 2. face: dark rock, a dimly lit plane on the left half, a cleft below the notch
local function cleft(x, y) return math.exp(-((x - (118 + (y - 840)*0.15))/5)^2) end
work(faceL, {hand="body", tool={kind="flat", width=6, stiffness=0.6}, length={10,24}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.5 + 0.2*nz(x,y) end,
  piles={{rock, 1}, {lent, function(x,y) return 0.4 + 1.5*cleft(x,y) + 0.6*clamp((y - 880)/20, 0, 1) end},
         {brushdark, function(x,y) return 0.3*nz:at01(x,y) end},
         {haze, function(x,y) return 0.22*clamp((110 - x)/80, 0, 1)*clamp((885 - y)/30, 0, 1) + 0.12*clamp((x - 140)/60, 0, 1)*clamp((870 - y)/25, 0, 1) end},
         {waterdark, function(x,y) return 0.5*clamp((y - 885)/15, 0, 1) end}}})
blend(faceL:shrink(1.5), {angle=1.5})
-- 3. cap: moss band, a little lighter on the top edge
work(capL, {hand="body", tool={kind="flat", width=4, stiffness=0.6}, length={8,18}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) local a = lineYf(newTopL, x + 2) - lineYf(newTopL, x - 2); return math.atan(a, 4) end,
  piles={{mossdeep, 1}, {rock, function(x,y) return 0.6*clamp((y - lineYf(newTopL, x) - 5)/6, 0, 1) end},
         {haze, function(x,y) return 0.35*clamp(1 - (y - lineYf(newTopL, x))/3, 0, 1) end},
         {brushdark, function(x,y) return 0.3*nz:at01(x*2, y) end}}})
blend(capL:shrink(1), {angle=0.0})

--@ chunk 428
local nz = noise{seed=16301, period=9, octaves=2}
local nt = noise{seed=16302, period=16, octaves=2}
local oldTop = {}
for x = 0, 300, 3 do
  local t = 905
  for y = 780, 905 do if bm5:at(x, y) > 0.5 then t = y; break end end
  oldTop[x] = t
end
local function oT(x) local k = math.floor(clamp(x, 0, 300)/3)*3; return oldTop[k] or 905 end
bankFix = mask(function(x, y)
  if x < 0 or x > 300 or y < 780 or y > 905 then return 0 end
  local top = oT(x) - 10 - 6*nt(x, 0)
  local bot = lineYf(newTopL, x)
  return (y >= top and y < bot) and 1 or 0
end) - rockLN:grow(1)
print(bankFix:area())
work(bankFix, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={5,11}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{brushdark, 1}, {leafshade, 0.7}, {lent, function(x,y) return 0.2 + 0.3*clamp((y - 815)/20, 0, 1) end},
         {deeprust, function(x,y) return 0.35*clamp((nz:at01(x,y) - 0.4)*2.5, 0, 1) end}}})
blend(bankFix:shrink(1.5), {angle=1.2})

--@ chunk 429
local nz = noise{seed=16401, period=8, octaves=2}
-- texture into the smooth bank band: short dark foliage dabs
local tb = brush{kind="filbert", width=5, stiffness=0.5}
for k = 1, 60 do
  local x = rand(15, 285)
  local y = lineYf(newTopL, x) - rand(3, 22)
  if bankFix:at(x, y) > 0.5 then
    tb:reload((k % 3 == 0) and leafshade or brushdark, 0.5)
    local a = rand(0, math.pi)
    tb:stroke({{x, y}, {x + 4*math.cos(a), y + 4*math.sin(a)}}, {pressure={0.5, 0.3}, clip=bankFix})
  end
end
-- break the moss crust: rock dragged over stretches
local rb = brush{kind="flat", width=5, stiffness=0.6}
for _, s in ipairs({{30, 52}, {96, 112}, {150, 186}, {236, 252}, {270, 286}}) do
  rb:reload(rock, 0.6)
  local pts = {}
  for x = s[1], s[2], 4 do pts[#pts+1] = {x, lineYf(newTopL, x) + rand(5, 9)} end
  rb:stroke(pts, {pressure={0.55, 0.45}, orient="across", clip=capL})
end
-- moss tufts rising over the line
local mb = brush{kind="round", width=5, stiffness=0.4}
for _, x in ipairs({66, 82, 128, 204, 214, 224}) do
  local y = lineYf(newTopL, x)
  mb:reload(mossdeep, 0.6)
  local w = rand(4, 7)
  mb:stroke({{x - w, y + 3}, {x - w*0.3, y - rand(2, 4)}, {x + w*0.4, y - rand(1, 3)}, {x + w, y + 3}}, {pressure={0.5, 0.35}})
end
-- cracks on the face
local cb = brush{kind="round", width=2.5, point=0.6}
cb:reload(lent, 0.6); cb:gesture({{60, 848, 0.2}, {64, 866, 0.5}, {58, 884, 0.35}, {62, 900, 0.05}}, {wobble=0.6})
cb:reload(lent, 0.6); cb:gesture({{176, 836, 0.15}, {181, 850, 0.45}, {178, 868, 0.3}, {184, 890, 0.05}}, {wobble=0.6})
cb:reload(lent, 0.6); cb:gesture({{238, 842, 0.2}, {246, 858, 0.4}, {242, 876, 0.05}}, {wobble=0.6})
-- a faint ledge: a lighter broken line following the top contour ~16 below
local lb = brush{kind="round", width=2, point=0.5}
for _, s in ipairs({{24, 54}, {140, 170}, {196, 232}}) do
  lb:reload(haze, 0.3)
  local pts = {}
  for x = s[1], s[2], 5 do pts[#pts+1] = {x, lineYf(newTopL, x) + 17 + rand(-1, 1)} end
  lb:stroke(pts, {pressure={0.25, 0.1}, ramps={0.3, 0.4}, clip=faceL})
end
-- contre-jour glints on the top edge
local gb = brush{kind="round", width=2, point=0.6}
for _, s in ipairs({{132, 150}, {160, 176}, {40, 54}}) do
  gb:reload(rim_warm, 0.45)
  gb:gesture({{s[1], lineYf(newTopL, s[1]) + 0.5, 0.1}, {(s[1]+s[2])/2, lineYf(newTopL, (s[1]+s[2])/2) - 0.5, 0.35}, {s[2], lineYf(newTopL, s[2]) + 0.5, 0.05}}, {wobble=0.3})
end

--@ chunk 430
local m = ((bm5:grow(16) + bankFix:grow(6)):map(function(v) return v > 0.05 and 1 or 0 end) - rockLN - below({{-10,907},{1010,907}})) * rect(0, 770, 300, 140)
print(m:area())
for k = 1, 14 do
  local r = rag{width=22}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and 0.0 or math.pi/2, passes=2, refold=0.25})
end
local n = 0
for x = 0, 300, 5 do for y = 770, 906, 5 do if drying(x, y) == "open" then n = n + 1 end end end
print("open", n)

--@ chunk 431
local m = ((bm5:grow(16) + bankFix:grow(6)):map(function(v) return v > 0.05 and 1 or 0 end) - rockLN - below({{-10,907},{1010,907}})) * rect(0, 770, 300, 140)
for round = 1, 3 do
  for k = 1, 10 do
    local r = rag{width=18}
    r:dip(1.0)
    r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and 0.0 or math.pi/2, passes=1, refold=0.2})
  end
end
local n = 0
for x = 0, 300, 5 do for y = 770, 906, 5 do if drying(x, y) == "open" then n = n + 1 end end end
print("open", n)

--@ chunk 432
wait(20 * 24 * 60)
local n = 0
for x = 0, 1000, 20 do for y = 0, 1250, 20 do if drying(x, y) ~= "dry" then n = n + 1 end end end
print("not dry", n)

--@ chunk 433
for y = 260, 440, 6 do
  local s = ""
  for x = 770, 800, 2 do
    local v = 0
    s = s .. string.format("%s", "")
  end
end
print(mA:area(), mB:area())
-- find trunk A axis x at several y
for _, y in ipairs({20, 200, 300, 400, 500, 600}) do
  local xa0, xa1, xb0, xb1
  for x = 700, 1000 do
    if mA:at(x, y) > 0.5 then xa0 = xa0 or x; xa1 = x end
    if mB:at(x, y) > 0.5 then xb0 = xb0 or x; xb1 = x end
  end
  print(y, xa0, xa1, xb0, xb1)
end

--@ chunk 434
function axA(y) return lerp(lerp(767, 778, clamp(y/200, 0, 1)), 0, 0) end
local tA = {{20,767},{200,778},{300,785},{400,791},{500,799},{600,804}}
local tB = {{20,957},{200,945},{300,938},{400,930},{500,926},{600,921}}
local wA = {{20,29},{200,28},{300,31},{400,33},{500,36},{600,40}}
local wB = {{20,19},{200,21},{300,22},{400,23},{500,26},{600,30}}
local function tab(t, y) for i = 1, #t - 1 do if y >= t[i][1] and y <= t[i+1][1] then return lerp(t[i][2], t[i+1][2], (y - t[i][1])/(t[i+1][1] - t[i][1])) end end; return (y < t[1][1]) and t[1][2] or t[#t][2] end
function trunkX(which, y) return tab(which == "A" and tA or tB, y) end
function trunkW(which, y) return tab(which == "A" and wA or wB, y) end
print(trunkX("A", 300), trunkW("A", 300), trunkX("B", 450), trunkW("B", 450))

--@ chunk 435
palette{scrape={mossdeep}}
birch_mid = pile{{"lead white",5},{"raw umber",0.4},{"yellow ochre",0.3},{"smalt",0.4}, name="birch_mid"}
local covers = {
  {"A", 70, 0.35}, {"A", 128, 0.5}, {"A", 170, 0.3}, {"A", 248, 0.45}, {"A", 318, 0.4}, {"A", 352, 0.55}, {"A", 430, 0.4}, {"A", 470, 0.5}, {"A", 540, 0.35},
  {"B", 60, 0.5}, {"B", 112, 0.45}, {"B", 190, 0.5}, {"B", 236, 0.4}, {"B", 280, 0.55}, {"B", 330, 0.4}, {"B", 392, 0.5}, {"B", 450, 0.45}, {"B", 520, 0.5},
}
local fb = brush{kind="flat", width=7, stiffness=0.5}
for _, c in ipairs(covers) do
  local w, y, u = c[1], c[2], c[3]
  local x = trunkX(w, y) + (u - 0.5) * trunkW(w, y)
  local m = (w == "A") and mA:shrink(3) or mB:shrink(3)
  fb:reload(birch_mid, 0.55)
  fb:stroke({{x + rand(-1, 1), y - 9}, {x + rand(-1, 1), y + 9}}, {pressure={0.5, 0.4}, orient="across", clip=m})
end

--@ chunk 436
local covers = {
  {"A", 70, 0.35}, {"A", 128, 0.5}, {"A", 170, 0.3}, {"A", 248, 0.45}, {"A", 318, 0.4}, {"A", 352, 0.55}, {"A", 430, 0.4}, {"A", 470, 0.5}, {"A", 540, 0.35},
  {"B", 60, 0.5}, {"B", 112, 0.45}, {"B", 190, 0.5}, {"B", 236, 0.4}, {"B", 280, 0.55}, {"B", 330, 0.4}, {"B", 392, 0.5}, {"B", 450, 0.45}, {"B", 520, 0.5},
}
local m = nil
for _, c in ipairs(covers) do
  local w, y, u = c[1], c[2], c[3]
  local x = trunkX(w, y) + (u - 0.5) * trunkW(w, y)
  local e = rect(x - 9, y - 14, 18, 28)
  m = m and (m + e) or e
end
m = m * (mA + mB)
for k = 1, 8 do
  local r = rag{width=12}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and math.pi/2 or 0.0, passes=2, refold=0.3})
end
local n = 0
for _, c in ipairs(covers) do local x = trunkX(c[1], c[2]) + (c[3] - 0.5) * trunkW(c[1], c[2]); if drying(x, c[2]) == "open" then n = n + 1 end end
print("open", n)

--@ chunk 437
local m = (facetB:grow(2) * rockLN:shrink(0.5)) * mask(function(x, y) return clamp((y - 832)/8, 0, 1) end)
print(m:area(), drying(370, 860))
local nz = noise{seed=16501, period=8, octaves=2}
work(m, {hand="body", tool={kind="filbert", width=4, stiffness=0.6}, length={5,12}, coverage=4.5, fill=true, clip=true, load=1.0, angle=1.2,
  piles={{lent, 1}, {rock, 0.8}, {waterdark, 0.3}, {brushdark, function(x,y) return 0.2*nz:at01(x,y) end}}})
blend(m:shrink(1), {angle=1.2})

--@ chunk 438
litPlane = poly({{317,808},{328,803},{340,802},{350,806},{356,813},{344,815},{330,815}})
capDark = ((facetA:grow(3) + topLN:grow(2)) * rockLN:shrink(0.5)) - litPlane
orangeFix = rect(282, 815, 24, 95) * rockLN
print(litPlane:area(), capDark:area(), orangeFix:area())

--@ chunk 439
litPlane = poly({{321,806},{336,801},{347,805},{338,812},{326,813}})
capDark = ((facetA:grow(3) + topLN:grow(2)) * rockLN:shrink(0.5)) - litPlane
local nz = noise{seed=16601, period=8, octaves=2}
work(capDark + orangeFix, {hand="body", tool={kind="filbert", width=4, stiffness=0.6}, length={5,12}, coverage=4.5, fill=true, clip=true, load=1.0, angle=1.4,
  piles={{lent, 1}, {rock, 0.8}, {brushdark, function(x,y) return 0.25*nz:at01(x,y) end}}})
blend((capDark + orangeFix):shrink(1), {angle=1.4})
work(litPlane, {hand="body", tool={kind="flat", width=3, stiffness=0.6}, length={5,10}, coverage=4, fill=true, clip=true, load=1.0, angle=-0.35,
  piles={{rock, 1}, {haze, 0.45}, {amber, 0.2}}})

--@ chunk 440
for i, p in ipairs(fgTop2) do io.write = nil; print(i, p[1], p[2]) end

--@ chunk 441
local nt = noise{seed=17001, period=14, octaves=2}
crenM = fgRock2 * mask(function(x, y)
  if x > 300 then return 0 end
  local t = topy(fgTop2, x)
  local a = 22 + 6*nt(x, 0)
  local b = 52 + 10*nt(x, 40)
  local d = y - t
  if x > 250 then d = d * 0.8 end
  return (d >= a and d <= b) and 1 or 0
end)
print(crenM:area())

--@ chunk 442
palette{scrape={birch_mid}}
mossdeep = pile{{"green earth",2},{"raw umber",1.2},{"yellow ochre",0.8},{"Prussian blue",0.1}, name="mossdeep"}
local nt = noise{seed=17002, period=40, octaves=2}
crenM = fgRock2 * mask(function(x, y)
  if x > 300 then return 0 end
  local t = topy(fgTop2, x)
  local a = 20 + 5*nt(x, 0)
  local b = 50 + 10*nt(x, 40)
  local d = y - t
  if x > 250 then d = d * 0.8 end
  return (d >= a and d <= b) and 1 or 0
end)
local function dd(x, y) local t = topy(fgTop2, x); local d = y - t; if x > 250 then d = d*0.8 end; return d end
local function ang(x, y) local a = topy(fgTop2, x + 3) - topy(fgTop2, x - 3); return math.atan(a, 6) end
work(crenM, {hand="body", tool={kind="flat", width=7, stiffness=0.6}, length={14,34}, coverage=4.5, fill=true, clip=true, load=1.0,
  angle=ang,
  piles={{mossdeep, function(x,y) return 0.7*clamp(1 - (dd(x,y) - 20)/22, 0, 1) end},
         {rock, function(x,y) return 0.4 + 0.9*clamp((dd(x,y) - 26)/20, 0, 1) end},
         {lent, function(x,y) return 0.3*clamp((dd(x,y) - 34)/16, 0, 1) end},
         {brushdark, 0.25}}})
blend(crenM:shrink(2), {angle=0.2})

--@ chunk 443
toeFix = outline{{296,618},{312,616},{326,622},{340,630},{356,636},{372,640},{388,642},{404,646},{420,650},{428,654},{412,656},{396,661},{386,668},{372,656},{350,662},{326,676},{296,690}, char="soft", seed=17101, amount=0.9, lobe=7}:mask() * aboveLine
toeFix = toeFix - newFalls:grow(1)
print(toeFix:area())

--@ chunk 444
local o = outline{{292,616},{308,612},{326,620},{340,630},{356,636},{372,640},{388,642},{404,646},{420,650},{428,654},{412,656},{396,661},{386,668},{372,656},{350,662},{326,676},{306,686},{292,690}, char="soft", seed=17101, amount=0.9, lobe=7}:mask()
toeFix = o * mask(function(x, y) if x < 330 then return 1 end; if x > 668 or y > 700 then return 0 end; return (y < lineYf(newLine, x)) and 1 or 0 end) - newFalls:grow(1)
print(toeFix:area())

--@ chunk 445
local nz = noise{seed=17201, period=10, octaves=2}
local function tY(x) return lineYf({{292,616},{308,612},{326,620},{340,630},{356,636},{372,640},{388,642},{404,646},{420,650},{428,654}}, x) end
work(toeFix, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={5,11}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{leafshade, 1}, {brushdark, function(x,y) return 0.35 + 0.6*clamp((y - tY(x) - 8)/25, 0, 1) end},
         {deeprust, function(x,y) return 0.5*nz:at01(x,y) end},
         {haze, function(x,y) return 0.45*clamp(1 - (y - tY(x))/10, 0, 1) * clamp((x - 330)/30, 0, 1) end},
         {amber, function(x,y) return 0.35*clamp(1 - (y - tY(x))/8, 0, 1) * clamp((nz:at01(x*1.4, y) - 0.4)*3, 0, 1) end}}})
blend(toeFix:shrink(2), {angle=1.2})

--@ chunk 446
local band = rect(270, 600, 90, 110):soften(2) * mask(function(x, y) return clamp(1 - math.abs(x - 296)/22, 0, 1) end) - newFalls:grow(4)
blend(band, {angle=0.0})
blend(band, {angle=0.6})
blend(band, {angle=-0.6})

--@ chunk 447
wait(30 * 24 * 60)
local n = 0
for x = 0, 1000, 20 do for y = 0, 1250, 20 do if drying(x, y) ~= "dry" then n = n + 1 end end end
print("not dry", n)

--@ chunk 448
print(palette())
local fm = foamM3 + foamLow
eTab = {}
for x = 320, 650, 2 do
  local e = nil
  for y = 950, 880, -1 do if fm:at(x, y) > 0.5 then e = y; break end end
  eTab[x] = e
end
function eY(x) local k = 320 + math.floor((clamp(x, 320, 650) - 320)/2)*2; return eTab[k] end
local s = ""
for x = 320, 650, 20 do s = s .. x .. ":" .. tostring(eY(x)) .. " " end
print(s)

--@ chunk 449
-- the true bottom edge, sampled from the canvas: first y (scanning up from 960) whose value is > 190
-- (use the mask edge as the guide; tongue left of x 380 handled separately)
function edgeBands(x0, x1, efn, n, seed, kind)
  math.randomseed(seed)
  local m = nil
  for i = 1, n do
    local L = rand(26, 80)
    local xs = rand(x0, x1 - L)
    local xm = xs + L/2
    local y = efn(xm) + ((kind == "bite") and rand(-9, 1) or rand(-1, 7))
    local w = rand(3.5, 6.5)
    local slope = rand(-0.04, 0.04)
    local pts, ws = {}, {}
    for k = 0, 10 do
      local u = k/10
      pts[#pts+1] = {xs + L*u, y + slope*L*(u - 0.5) + 0.8*math.sin(u*4 + i)}
      ws[#ws+1] = w * math.sin(math.pi * u)^0.5
    end
    local r = ribbon(pts, ws)
    m = m and (m + r) or r
  end
  return m
end
local function ef(x) return eY(x) or 928 end
local keep = below({{-10,895},{1010,895}}) - rockLN:grow(1) - rockRN2:grow(1) - fgRock2:grow(1)
bitesM = edgeBands(380, 600, ef, 15, 18001, "bite") * keep
tonguesM = (edgeBands(372, 606, ef, 12, 18002, "tongue") - bitesM) * keep
function wb2(x0, x1, y0, y1, gap0, gap1, L0, L1, w0, w1, seed)
  math.randomseed(seed)
  local bands = nil
  local y = y0
  local i = 0
  while y < y1 do
    i = i + 1
    local t = (y - y0)/(y1 - y0)
    local L = lerp(L0, L1, t) * rand(0.6, 1.2)
    local xs = rand(x0 - L*0.3, x1 - L*0.7)
    local w = lerp(w0, w1, t) * rand(0.7, 1.3)
    local pts, ws = {}, {}
    for k = 0, 10 do
      local u = k/10
      pts[#pts+1] = {xs + L*u, y + 0.8*math.sin(u*4 + i)}
      ws[#ws+1] = w * math.sin(math.pi * u)^0.5 * (0.7 + 0.3*math.sin(u*7 + i*2))
    end
    local r = ribbon(pts, ws)
    bands = bands and (bands + r) or r
    y = y + lerp(gap0, gap1, t) * rand(0.6, 1.4)
  end
  return bands
end
driftM = (wb2(370, 610, 940, 1010, 3, 11, 75, 30, 4.5, 1.5, 18003) - (foamM3 + foamLow):shrink(1)) * keep
-- the tongue left of the falls: cover with water, keep a thin line
tongueW = (foamM3 + foamLow):grow(1) * rect(318, 905, 60, 30) * mask(function(x, y) return (x < 372) and 1 or 0 end) - rockLN:grow(1)
tongueLine = ribbon({{332,917},{344,916},{356,918},{368,917}}, {0.8, 2, 2.2, 1}) - rockLN
print(bitesM:area(), tonguesM:area(), driftM:area(), tongueW:area(), tongueLine:area())

--@ chunk 450
palette{scrape={orangeleaf, mossdeep}}
w1 = mix{{haze, 0.62}, {waterdark, 0.28}, {amber, 0.10}, name="w1"}
fp = mix{{foamsh, 0.75}, {haze, 0.25}, name="fp"}
local function ef(x) return eY(x) or 928 end
work(tongueW, {hand="body", tool={kind="round", width=3, stiffness=0.5}, length={6,16}, coverage=3.5, fill=true, clip=true, load=0.9, angle=0,
  piles={{w1, 1}, {waterdark, function(x,y) return 0.5*clamp((360 - x)/30, 0, 1) end}}})
work(bitesM, {hand="body", tool={kind="round", width=3, stiffness=0.5}, length={6,16}, coverage=3, fill=true, clip=true, load=0.9, angle=0, pile=w1})
work(tonguesM, {hand="body", tool={kind="round", width=3, stiffness=0.5}, length={6,16}, coverage=3, fill=true, clip=true, load=0.9, angle=0,
  piles={{foamsh, 1}, {fallwhite, 0.4}}})
work(driftM, {hand="body", tool={kind="round", width=3, stiffness=0.5}, length={6,16}, coverage=3, fill=true, clip=true, load=0.9, angle=0,
  piles={{fp, function(x,y) return clamp(1 - (y - 940)/70, 0.15, 1) end}, {w1, function(x,y) return clamp((y - 948)/60, 0, 0.8) end}}})
work(tongueLine, {hand="body", tool={kind="round", width=2, stiffness=0.5}, length={6,16}, coverage=3, fill=true, clip=true, load=0.8, angle=0, pile=fp})

--@ chunk 451
local nv = noise{seed=18101, period=6, octaves=2}
local zone = mask(function(x, y)
  if y < 904 or y > 932 or x < 318 then return 0 end
  local xr = 370 + 5*nv(0, y*1.5)
  return (x < xr) and 1 or 0
end) - rockLN:grow(1) - tongueLine
print(zone:area())
work(zone, {hand="body", tool={kind="round", width=3, stiffness=0.5}, length={6,14}, coverage=4, fill=true, clip=true, load=0.9, angle=0,
  piles={{w1, 1}, {waterdark, function(x,y) return 0.6*clamp((360 - x)/30, 0, 1) end}}})
local seamR = ribbon({{352,913},{362,912},{374,913},{388,914},{398,913}}, {0.5, 2.2, 3, 2.4, 0.5}) + ribbon({{360,922},{372,921},{384,922},{394,923}}, {0.5, 2.2, 2.6, 0.5})
work(seamR - rockLN, {hand="body", tool={kind="round", width=2, stiffness=0.5}, length={6,14}, coverage=3, fill=true, clip=true, load=0.8, angle=0,
  piles={{fp, 1}, {foamsh, 0.4}}})

--@ chunk 452
local m = rect(314, 900, 64, 36) - rockLN:grow(1)
for k = 1, 8 do
  local r = rag{width=14}
  r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=(k % 2 == 1) and 0.0 or math.pi/2, passes=2, refold=0.3})
end
local n = 0
for x = 316, 376, 4 do for y = 902, 934, 4 do if drying(x, y) == "open" then n = n + 1 end end end
print("open", n)

--@ chunk 453
local nv = noise{seed=18102, period=7, octaves=2}
tongueZ = ((foamM3 + foamLow):grow(3) * mask(function(x, y)
  if y < 902 or y > 936 or x < 316 then return 0 end
  local xr = 366 + 6*nv(0, y*1.3)
  return (x < xr) and 1 or 0
end)) - rockLN:grow(1)
print(tongueZ:area())
work(tongueZ, {hand="body", tool={kind="round", width=3, stiffness=0.5}, length={6,14}, coverage=4, fill=true, clip=true, load=0.9, angle=0,
  piles={{waterdark, 1}, {haze, function(x,y) return lerp(0.25, 0.9, clamp((x - 320)/50, 0, 1)) end}, {amber, 0.08}}})

--@ chunk 454
wait(30 * 24 * 60)
local n = 0
for x = 200, 800, 10 do for y = 880, 1020, 8 do if drying(x, y) ~= "dry" then n = n + 1 end end end
print("not dry", n)

--@ chunk 455
palette{scrape={fp}}
gD2 = pile{{"raw umber",1},{"smalt",0.8},{"lead white",0.3},{"red earth",0.2}, medium=0.82, name="gD2"}
labelM = outline{{246,900},{262,898},{280,899},{288,904},{286,914},{270,917},{252,916},{244,909}, char="broken", seed=18201, amount=0.6}:mask() - rockLN:grow(1)
local ns = noise{seed=18202, period=6, octaves=2, stretch={math.pi/2, 4}}
local function bottomOf(m, x, y0, y1) local b = nil; for y = y0, y1 do if m:at(x, y) > 0.5 then b = y end end; return b end
local bL, bR = {}, {}
for x = 280, 392, 2 do bL[x] = bottomOf(rockLN, x, 880, 930) end
for x = 594, 716, 2 do bR[x] = bottomOf(rockRN2, x, 920, 965) end
local function look2(t, x0, x) local k = x0 + math.floor((x - x0)/2)*2; return t[k] end
seatL = mask(function(x, y)
  if x < 282 or x > 390 then return 0 end
  local b = look2(bL, 280, x); if not b then return 0 end
  local d = 12 + 8*ns(x, 0) + 4*ns(x*3, 5)
  return (y > b and y < b + d) and 1 or 0
end)
seatR = mask(function(x, y)
  if x < 596 or x > 714 then return 0 end
  local b = look2(bR, 594, x); if not b then return 0 end
  local d = 16 + 9*ns(x, 20) + 5*ns(x*3, 25)
  return (y > b and y < b + d) and 1 or 0
end)
seatR2 = mask(function(x, y)
  if x < 606 or x > 706 then return 0 end
  local b = look2(bR, 594, x); if not b then return 0 end
  local d = 8 + 5*ns(x, 40)
  return (y > b and y < b + d) and 1 or 0
end)
print(labelM:area(), seatL:area(), seatR:area(), seatR2:area())

--@ chunk 456
local ns = noise{seed=18203, period=16, octaves=2}
local function bottomOf(m, x, y0, y1) local b = nil; for y = y0, y1 do if m:at(x, y) > 0.5 then b = y end end; return b end
local bL, bR = {}, {}
for x = 284, 390, 2 do bL[x] = bottomOf(rockLN, x, 880, 930) end
for x = 598, 714, 2 do bR[x] = bottomOf(rockRN2, x, 920, 965) end
local function look2(t, x0, x) local k = x0 + math.floor((x - x0)/2)*2; return t[k] end
local function mk(t, x0, xa, xb, d0, amp, seedOff)
  return mask(function(x, y)
    if x < xa or x > xb then return 0 end
    local b = look2(t, x0, x); if not b then return 0 end
    local d = d0 + amp*ns(x, seedOff)
    return (y > b - 1 and y < b + d) and 1 or 0
  end)
end
seatL = mk(bL, 284, 288, 380, 14, 6, 0) - foamM3 - foamLow
seatL2 = mk(bL, 284, 292, 372, 7, 3, 30) - foamM3 - foamLow
seatR = mk(bR, 598, 602, 710, 18, 7, 60)
seatR2 = mk(bR, 598, 608, 704, 9, 4, 90)
print(seatL:area(), seatL2:area(), seatR:area(), seatR2:area())

--@ chunk 457
local nz = noise{seed=18301, period=10, octaves=2}
work(labelM, {hand="body", tool={kind="filbert", width=5, stiffness=0.6}, length={6,14}, coverage=4.5, fill=true, clip=true, load=1.0, angle=1.45,
  piles={{rock, 1}, {lent, 0.6}, {waterdark, 0.4}, {brushdark, function(x,y) return 0.2*nz:at01(x,y) end}}})
work(seatL, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool={kind="filbert", width=6, stiffness=0.3}, seed=18311})
work(seatL2, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool={kind="filbert", width=6, stiffness=0.3}, seed=18312})
work(seatR, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool={kind="filbert", width=6, stiffness=0.3}, seed=18313})
work(seatR2, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool={kind="filbert", width=6, stiffness=0.3}, seed=18314})

--@ chunk 458
local nr = noise{seed=18401, period=14, octaves=2}
function farE(x) return 646 + 1.8*nr(x, 0) + 0.8*nr(x*3, 9) end
streamZ = mask(function(x, y)
  if x < 384 or x > 598 or y < 630 or y > 680 then return 0 end
  return (y < lineYf(brinkLine, x) - 1.5) and 1 or 0
end) - toeL2:shrink(1) - toeR2:shrink(1) - toeFix:shrink(1) - newFalls:grow(0)
print(streamZ:area())

--@ chunk 459
streamZ = mask(function(x, y)
  if x < 384 or x > 598 or y > 680 then return 0 end
  local top = 634 + math.max(0, 432 - x)*0.55 + math.max(0, x - 548)*0.45
  if y < top then return 0 end
  return (y < lineYf(brinkLine, x) - 1.5) and 1 or 0
end) - toeL2:shrink(1) - toeR2:shrink(1) - toeFix:shrink(1)
print(streamZ:area())

--@ chunk 460
local nz = noise{seed=18402, period=12, octaves=2}
local function d(x, y) return y - farE(x) end
local function T(x, y) return clamp(1 - (d(x, y) + 1)/3, 0, 1) end
work(streamZ, {hand="body", tool={kind="flat", width=3, stiffness=0.5}, length={10,28}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.02*nz(x,y) end,
  piles={{haze, 1},
         {amber, function(x,y) local t = T(x,y); return 0.9*t + 0.4*(1 - t)*clamp(1 - d(x,y)/10, 0, 1) end},
         {deeprust, function(x,y) return 0.2*T(x,y) end},
         {foamsh, function(x,y) return 0.35*(1 - T(x,y)) end},
         {glow, function(x,y) return 0.45*(1 - T(x,y))*clamp(d(x,y)/14, 0, 1) end}}})
blend(streamZ:shrink(1), {angle=0.0})
local topBand = streamZ * mask(function(x, y) return clamp(1 - math.abs(y - 636)/6, 0, 1) end)
blend(topBand, {angle=math.pi/2})

--@ chunk 461
wait(30 * 24 * 60)
local n = 0
for x = 0, 1000, 20 do for y = 0, 1250, 20 do if drying(x, y) ~= "dry" then n = n + 1 end end end
print("not dry", n)

--@ chunk 462
for i, l in ipairs(palette()) do print(i, l) end
print(drying(360, 780), drying(610, 780), drying(260, 400))

--@ chunk 463
local p = palette()
print(type(p))
if type(p) == "string" then print(p) else for k, v in pairs(p) do print(k, v) end end

--@ chunk 464
print(lent, rock, fallwhite, foamsh, haze, amber, glow)
print(lenticel, nearbank)

--@ chunk 465
local U = lowerC + newFalls
for y = 680, 860, 10 do
  local xl, xr2 = nil, nil
  for x = 330, 420, 0.5 do if U:at(x, y) > 0.5 then xl = x break end end
  for x = 650, 560, -0.5 do if U:at(x, y) > 0.5 then xr2 = x break end end
  print(y, xl, xr2)
end

--@ chunk 466
local U = lowerC + newFalls
eLt, eRt = {}, {}
for y = 690, 880 do
  local xl, xr = nil, nil
  for x = 330, 420, 0.5 do if U:at(x, y) > 0.5 then xl = x break end end
  for x = 660, 560, -0.5 do if U:at(x, y) > 0.5 then xr = x break end end
  eLt[y] = xl; eRt[y] = xr
end
function eL(y) local a = math.floor(y); a = clamp(a, 690, 879); local t = y - a; return lerp(eLt[a], eLt[a+1], clamp(t,0,1)) end
function eR(y) local a = math.floor(y); a = clamp(a, 690, 879); local t = y - a; return lerp(eRt[a], eRt[a+1], clamp(t,0,1)) end
function wedgeP(edgefn, side, d0, y0, y1, d1, wmax, bow)
  local pts, ws = {}, {}
  for i = 0, 16 do
    local t = i / 16
    local y = lerp(y0, y1, t)
    local d = lerp(d0, d1, t ^ 1.3) + bow * math.sin(math.pi * t)
    pts[#pts+1] = {edgefn(y) - side * d, y}
    ws[#ws+1] = math.max(wmax * (t ^ 0.8), 0.2)
  end
  return ribbon(pts, ws)
end
local WL = {
  {5, 722, 768, -3, 4, 0.6},
  {11, 746, 812, -4, 5.5, 1.2},
  {7, 772, 818, -3, 5, -0.8},
  {16, 788, 822, -2, 4, 0.5},
  {3, 734, 758, -2, 2.5, 0.3},
}
local WR = {
  {6, 712, 752, -3, 4, 0.5},
  {13, 738, 808, -4, 6, -1.2},
  {8, 772, 832, -5, 6, 1.0},
  {20, 798, 846, -3, 5, 0.8},
  {4, 758, 788, -2, 3, -0.4},
  {10, 815, 850, -4, 4, -0.6},
}
local rocks = rockLN + behindR + rockRN2
biteL, biteR = nil, nil
for _, w in ipairs(WL) do local r = wedgeP(eL, -1, table.unpack(w)); biteL = biteL and (biteL + r) or r end
for _, w in ipairs(WR) do local r = wedgeP(eR, 1, table.unpack(w)); biteR = biteR and (biteR + r) or r end
biteL = biteL:roughen(1.2, 22, 31) - rocks
biteR = biteR:roughen(1.2, 22, 37) - rocks
print("areas", biteL:area(), biteR:area())

--@ chunk 467
work(biteL, {hand="body", tool="round 3", piles={{rock,1},{lent,0.4}}, coverage=3, clip=true, fill=true, angle=math.pi/2, length={10,30}})
work(biteR, {hand="body", tool="round 3", piles={{rock,1},{lent,0.4}}, coverage=3, clip=true, fill=true, angle=math.pi/2, length={10,30}})

--@ chunk 468
local nz = noise{seed=53, period=70, octaves=2}
local rocks = rockLN + behindR + rockRN2
threadBandL = mask(function(x, y)
  if y < 728 or y > 830 then return 0 end
  local f = (y - 728) / 100
  local out = 4 + 11 * f + 3 * nz(x * 0.2, y)
  local e = eL(y)
  if x > e + 6 or x < e - out then return 0 end
  return 1
end):soften(2) - rocks
threadBandR = mask(function(x, y)
  if y < 718 or y > 850 then return 0 end
  local f = (y - 718) / 130
  local out = 3 + 7 * f + 2.5 * nz(x * 0.2 + 40, y)
  local e = eR(y)
  if x < e - 6 or x > e + out then return 0 end
  return 1
end):soften(2) - rocks
print(threadBandL:area(), threadBandR:area())

--@ chunk 469
local b = brush{kind="fan", width=11}
local function threads(edgefn, side, n, ylo, yhi, outmax, clipm)
  for i = 1, n do
    local y0 = rand(ylo, yhi)
    local y1 = y0 + rand(40, 80)
    local f = (y0 - ylo) / (yhi - ylo)
    local inside = rand(1, 5)
    local out = 3 + outmax * f + rand(0, 4)
    b:reload(fallwhite, rand(0.07, 0.14))
    local pts = {}
    for k = 0, 6 do
      local t = k / 6
      local y = lerp(y0, y1, t)
      pts[#pts+1] = {edgefn(math.min(y, 879)) + side * (-inside + (inside + out) * (t ^ 1.2)), y}
    end
    b:stroke(pts, {pressure={rand(0.25, 0.38), 0.03}, ramps={0.05, 0.5}, orient="across", clip=clipm})
  end
end
threads(eL, -1, 7, 728, 800, 10, threadBandL)
threads(eR, 1, 6, 718, 810, 6, threadBandR)

--@ chunk 470
local rocks = rockLN + behindR + rockRN2
local a = wedgeP(eR, 1, 20, 798, 846, -3, 5, 0.8)
local c = wedgeP(eR, 1, 10, 815, 850, -4, 4, -0.6)
liftR = ((a + c):grow(2.5)) - rocks
print(liftR:area())
local r = rag{width=12}
for k = 1, 3 do
  r:dip(1.0)
  r:wipe(liftR, {pressure=1.0, angle=math.pi/2, passes=2, refold=0.5})
  r = rag{width=12}
  r:dip(1.0)
  r:wipe(liftR, {pressure=1.0, angle=0, passes=2, refold=0.5})
  r = rag{width=12}
end

--@ chunk 471
local function taper(pts, w0)
  local ws = {}
  local n = #pts
  for i = 1, n do local t = (i - 1) / (n - 1); ws[i] = math.max(w0 * (1 - t) ^ 0.7, 0.25) end
  return ribbon(pts, ws)
end
tongL = taper({{381,826},{377,836},{373,847},{370,858},{368,869}}, 4.2)
     + taper({{379,846},{375,855},{372,863},{371,870}}, 2.8)
tongR = taper({{599,835},{605,840},{610,847},{613,855},{615,862}}, 4.2)
     + taper({{600,847},{603,854},{605,861}}, 2.6)
tongL = tongL:roughen(0.8, 12, 3)
tongR = tongR:roughen(0.8, 12, 4)
print(tongL:area(), tongR:area())

--@ chunk 472
work(tongL + tongR, {hand="body", tool="round 3", piles={{fallwhite,1},{foamsh,0.6}}, coverage=2, clip=true, angle=math.pi/2, length={8,20}, load=0.6})

--@ chunk 473
for y = 320, 540, 20 do
  local s = ""
  for _, x in ipairs({235, 245, 262, 280, 290}) do
    local r = probe and "" or ""
  end
end
print(type(probe))

--@ chunk 474
local bank = bankClumpM:grow(1)
trunkFade = (ribbon({{258, 385}, {260, 430}, {262, 480}, {262, 552}}, {16, 18, 18, 18}):roughen(1.5, 30, 9):soften(3)) - bank
print("area", trunkFade:area())
work(trunkFade, {hand="body", piles={{glow,0.6},{haze,1.1},{amber,0.25}}, tool="flat 4", angle=-math.pi/2, coverage=2.5, clip=true, length={30,80},
  load_at=function(x, y) return clamp((y - 390) / 130, 0.05, 0.9) end, pressure={0.2,0.45}})

--@ chunk 475
local m = trunkFade:grow(2)
for k = 1, 3 do
  local r = rag{width=14}; r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=math.pi/2, passes=2, refold=0.4})
  r = rag{width=14}; r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=0, passes=2, refold=0.4})
end

--@ chunk 476
-- find trunk edges by sampling a narrow mask? use drying-agnostic approach: sample via a mask of the trunk isn't available; print the existing masks covering x 250-272
for _, name in ipairs({"windowM","canopyBand","under","gz3"}) do
  local m = _G[name]
  if m then print(name, m:at(260, 450), m:at(260, 350)) end
end

--@ chunk 477
local bank = bankClumpM:grow(1)
trunkFade = (ribbon({{258.5, 385}, {260.5, 450}, {263, 500}, {264, 552}}, {20, 22, 22, 22}):roughen(1.2, 30, 9):soften(3)) - bank
print("area", trunkFade:area())
work(trunkFade, {hand="body", piles={{glow,0.6},{haze,1.1},{amber,function(x, y) return lerp(0.2, 0.5, clamp((y - 400) / 120, 0, 1)) end}},
  tool="flat 4", angle=-math.pi/2, coverage=2.5, clip=true, length={30,80},
  load_at=function(x, y) return clamp((y - 390) / 130, 0.05, 0.9) end, pressure={0.2,0.45}})

--@ chunk 478
local bank = bankClumpM:grow(1)
trunkFade2 = (ribbon({{257, 340}, {258.5, 400}, {260.5, 470}}, {18, 20, 22}):roughen(1.2, 30, 19):soften(3)) - bank
print("area", trunkFade2:area())
work(trunkFade2, {hand="body", piles={{glow,0.6},{haze,1.1},{amber,0.2}},
  tool="flat 4", angle=-math.pi/2, coverage=2, clip=true, length={25,60},
  load_at=function(x, y) return clamp((y - 345) / 110, 0.02, 0.6) end, pressure={0.15,0.35}})

--@ chunk 479
blend((trunkFade + trunkFade2):shrink(1), {angle=math.pi/2})

--@ chunk 480
print(wait(40 * 24 * 60))
print(drying(262, 470), drying(375, 860), drying(610, 850), drying(352, 780))

--@ chunk 481
for _, y in ipairs({790, 805, 815, 825, 835}) do print(y, string.format("%.1f", eR(y))) end

--@ chunk 482
local rocks = rockLN + rockRN2
gapA = ribbon({{609.5,788},{610.5,800},{611.5,812},{613,826},{614.5,836}}, {0.3, 1.6, 2.4, 2.4, 0.8}):roughen(0.5, 10, 3) - rocks
tCover = ribbon({{599.5,845},{602.5,852},{605,859},{606.5,864}}, {3.2, 3.6, 3.4, 2.6}) - rocks
print(gapA:area(), tCover:area())
work(gapA + tCover, {hand="body", tool="round 3", piles={{rock,1},{lent,0.4}}, coverage=3, clip=true, fill=true, angle=math.pi/2, length={8,20}})

--@ chunk 483
local m = tCover:grow(1.5)
for k = 1, 3 do
  local r = rag{width=10}; r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=math.pi/2, passes=2, refold=0.4})
  r = rag{width=10}; r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=0, passes=2, refold=0.4})
end

--@ chunk 484
print(topy, topy and topy(fgTop2, 200))
fgTop3 = {{-10,1068},{40,1058},{110,1054},{150,1061},{190,1063},{224,1068},{240,1082},{258,1104},{284,1140},{298,1186},{306,1256}}
local pts = {{-10,1068},{40,1058},{110,1054},{150,1061},{190,1063},{224,1068,"c"},{240,1082},{258,1104},{284,1140,"c"},{298,1186},{306,1256},{-10,1256}}
fgRock3 = outline{pts=pts, char="broken", seed=8311, amount=0.35}:mask() + fgRock2
shoulder = fgRock3 - fgRock2
print(fgRock3:area(), shoulder:area())
for x = 140, 300, 10 do
  local yt
  for y = 1030, 1250 do if fgRock3:at(x, y) > 0.5 then yt = y break end end
  print(x, yt, topy(fgTop2, x))
end

--@ chunk 485
palette{scrape={w1, gD2, nearbank}}
mossdeep = pile{{"green earth",2},{"raw umber",1.2},{"yellow ochre",0.8},{"Prussian blue",0.1}, name="mossdeep"}
mosslit3 = pile{{"yellow ochre",2},{"green earth",1.5},{"lead white",0.7},{"chrome yellow",0.3},{"raw umber",0.4}, name="mosslit3"}
local p = palette()
print(p)

--@ chunk 486
local nm = noise{seed=19001, period=70, octaves=2}
function top3(x) return topy(fgTop3, x) end
function mw(x)
  local base
  if x < 100 then base = lerp(36, 30, x/100)
  elseif x < 180 then base = lerp(30, 20, (x-100)/80)
  elseif x < 232 then base = lerp(20, 8, (x-180)/52)
  else base = lerp(8, -6, clamp((x-232)/16, 0, 1)) end
  return base + 5 * nm(x, 0)
end
function xeR(y) return topy({{1110,262},{1140,284},{1186,298},{1256,306}}, y) end
fgZone = fgRock3 * mask(function(x, y)
  if x > 320 or y < 1040 or y > 1256 then return 0 end
  local d = y - top3(x)
  if d <= 72 then return 1 end
  if y > 1100 and x > xeR(y) - 36 then return 1 end
  return 0
end)
print(fgZone:area())

--@ chunk 487
local nz = noise{seed=19002, period=18, octaves=2}
local function dd(x, y) return y - top3(x) end
local function mm(x, y) return clamp((mw(x) - dd(x, y)) / 9 + 0.5, 0, 1) end
local function ang(x, y) local a = top3(x + 3) - top3(x - 3); return math.atan(a, 6) + 0.15 * nz(x, y) end
work(fgZone, {hand="body", tool={kind="flat", width=7, stiffness=0.6}, length={14,34}, coverage=4.5, fill=true, clip=true, load=1.0,
  angle=ang,
  piles={{mossdeep, function(x,y) return mm(x,y) * (0.8 + 0.4*nz:at01(x,y)) end},
         {mosslit3, function(x,y) return mm(x,y) * 0.35 * clamp(1 - dd(x,y)/14, 0, 1) * clamp((x - 60)/60, 0, 1) * clamp((240 - x)/20, 0, 1) end},
         {rock, function(x,y) return 0.08 + (1 - mm(x,y)) end},
         {lent, function(x,y) return (1 - mm(x,y)) * 0.45 * clamp((dd(x,y) - mw(x))/20, 0, 1) end},
         {brushdark, 0.15}}})
blend(fgZone:shrink(2), {angle=0.15})

--@ chunk 488
local nm = noise{seed=19001, period=70, octaves=2}
function mw(x)
  local base
  if x < 100 then base = lerp(36, 30, x/100)
  elseif x < 180 then base = lerp(30, 20, (x-100)/80)
  elseif x < 232 then base = lerp(20, 8, (x-180)/52)
  elseif x < 248 then base = lerp(8, -4, (x-232)/16)
  else return -30 end
  return base + 5 * nm(x, 0)
end
local nz = noise{seed=19003, period=18, octaves=2}
local nb = noise{seed=19004, period=90, octaves=2}
local function dd(x, y) return y - top3(x) end
local function mm(x, y) return clamp((mw(x) - dd(x, y)) / 9 + 0.5, 0, 1) end
local function ang(x, y)
  local a = math.atan(top3(x + 3) - top3(x - 3), 6)
  local t = clamp((dd(x, y) - 30) / 40, 0, 1)
  if x > 250 then t = math.max(t, 0.6) end
  return lerp(a, 1.45, t) + 0.15 * nz(x, y)
end
work(fgRock3, {hand="body", tool={kind="flat", width=8, stiffness=0.6}, length={16,40}, coverage=4, fill=true, clip=true, load=1.0,
  angle=ang,
  piles={{mossdeep, function(x,y) return mm(x,y) * (0.8 + 0.4*nz:at01(x,y)) end},
         {mosslit3, function(x,y) return mm(x,y) * 0.35 * clamp(1 - dd(x,y)/14, 0, 1) * clamp((x - 60)/60, 0, 1) * clamp((240 - x)/20, 0, 1) end},
         {rock, function(x,y) return 0.08 + (1 - mm(x,y)) end},
         {lent, function(x,y) return (1 - mm(x,y)) * (0.3 + 0.25*nb:at01(x,y)) * clamp((dd(x,y) - math.max(mw(x),0))/20, 0, 1) end},
         {waterdark, function(x,y) return (1 - mm(x,y)) * 0.25 * nb:at01(x+300,y) end},
         {brushdark, 0.12}}})
blend(fgRock3:shrink(2), {angle=0.15})

--@ chunk 489
local function topAt(x)
  for y = 1040, 1250, 0.5 do if fgRock3:at(x, y) > 0.5 then return y end end
end
local x = 112
local nr = noise{seed=19005, period=30, octaves=1}
local n = 0
while x < 238 do
  local len = rand(8, 20)
  local x2 = math.min(x + len, 240)
  local y1, y2 = topAt(x), topAt(x2)
  local ang = math.atan(y2 - y1, x2 - x)
  local mx, my = (x + x2) / 2, (y1 + y2) / 2
  local k = knife{width = (x2 - x) * 1.05}
  k:load(rim_warm, rand(0.28, 0.4))
  local w = (mx > 150 and mx < 228) and rand(2, 3.2) or rand(1.2, 2.2)
  k:lay({{mx, my + 0.3}, {mx, my + w}}, {pressure={0.12, 0.2}, angle=ang})
  n = n + 1
  x = x2 + rand(3, 12)
end
print("rim segments", n)

--@ chunk 490
local pts = {}
for x = 100, 250, 5 do
  local yt
  for y = 1040, 1250, 0.5 do if fgRock3:at(x, y) > 0.5 then yt = y break end end
  pts[#pts+1] = {x, yt + 3}
end
rimZ = ribbon(pts, 8) * fgRock3:shrink(0.5)
print(rimZ:area())
blend(rimZ, {angle=0.12})
blend(rimZ, {angle=0.3})

--@ chunk 491
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
local lb = brush{kind="round", width=6, point=0.8, stiffness=0.5, lay=1.5}
local L = {{138,1071,0.35,orangeleaf,10},{150,1076,-0.5,deeprust,8}}
for i, l in ipairs(L) do
  lb:reload(l[4], 0.8)
  local x, y, a, s = l[1], l[2], l[3], l[5]
  lb:gesture({{x, y, 0.1}, {x + s*0.5*math.cos(a), y + s*0.35*math.sin(a), 0.9}, {x + s*math.cos(a), y + s*0.7*math.sin(a), 0.0}}, {wobble=0.3})
end

--@ chunk 492
-- no pixel reads in Lua; build trial ribbon from visual estimate
gl1 = ribbon({{98,993.5},{115,992.6},{130,991.8},{145,991.0},{158,990.3},{166,989.8}}, {0.6, 3.2, 3.6, 3.6, 3.0, 0.6})
print(gl1:area())

--@ chunk 493
gl1 = ribbon({{94,993.6},{110,993.2},{130,992.8},{150,992.6},{168,992.2}}, {1.5, 4.6, 4.8, 4.6, 1.5})
print(gl1:area())
work(gl1, {hand="body", tool={kind="round", width=3, stiffness=0.5}, piles={{waterdark,0.8},{haze,0.14},{amber,0.06}}, coverage=3, fill=true, clip=true, angle=0, length={15,40}})

--@ chunk 494
glC = ribbon({{24,975.8},{35,975.6},{50,975.5},{62,975.5},{70,975.4}}, {1.5, 4.4, 4.6, 4.4, 1.5})
glF = ribbon({{42,1040.2},{60,1040.6},{75,1041.3},{90,1042.0},{105,1042.6},{118,1042.9},{128,1043.0}}, {1.5, 4.2, 4.4, 4.4, 4.2, 3.0, 0.8})
print(glC:area(), glF:area())
work(glC, {hand="body", tool={kind="round", width=3, stiffness=0.5}, piles={{waterdark,0.86},{haze,0.1},{amber,0.04}}, coverage=3, fill=true, clip=true, angle=0, length={15,40}})
work(glF, {hand="body", tool={kind="round", width=3, stiffness=0.5}, piles={{waterdark,0.8},{haze,0.14},{amber,0.06}}, coverage=3, fill=true, clip=true, angle=0, length={15,40}})

--@ chunk 495
glF2 = ribbon({{115,1042.8},{128,1043.0},{140,1043.2},{152,1043.1},{160,1043.0},{166,1042.9}}, {2.5, 4.4, 4.4, 4.2, 3.0, 1.0})
work(glF2, {hand="body", tool={kind="round", width=3, stiffness=0.5}, piles={{waterdark,0.8},{haze,0.14},{amber,0.06}}, coverage=3, fill=true, clip=true, angle=0, length={15,40}})

--@ chunk 496
print(wait(45 * 24 * 60))
print(drying(150, 1150), drying(130, 993), drying(612, 815))

--@ chunk 497
rEdge = {}
for y = 1110, 1250, 2 do
  local xr
  for x = 330, 200, -0.5 do if fgRock3:at(x, y) > 0.5 then xr = x break end end
  rEdge[y] = xr
end
function rE(y) local a = math.floor(y / 2) * 2; a = clamp(a, 1110, 1248); return lerp(rEdge[a], rEdge[a+2], clamp((y - a)/2, 0, 1)) end
local nb = noise{seed=19101, period=60, octaves=2}
bounceM = fgRock3 * mask(function(x, y)
  if y < 1130 or y > 1256 or x < 180 then return 0 end
  local d = rE(math.min(y, 1250)) - x
  local reach = 26 + 14 * nb(x, y) + 20 * clamp((y - 1150)/80, 0, 1)
  return (d >= 0 and d <= reach) and 1 or 0
end)
print(bounceM:area())

--@ chunk 498
local nb = noise{seed=19101, period=60, octaves=2}
local function reach(x, y) return 26 + 14 * nb(x, y) + 20 * clamp((y - 1150)/80, 0, 1) end
local function w(x, y)
  local d = rE(math.min(math.max(y, 1110), 1250)) - x
  local t = clamp(1 - d / reach(x, y), 0, 1) ^ 1.3
  return t * clamp((y - 1132) / 34, 0, 1)
end
bounceM2 = fgRock3 * mask(function(x, y)
  if y < 1120 or y > 1256 or x < 170 then return 0 end
  local d = rE(math.min(y, 1250)) - x
  return (d >= -2 and d <= reach(x, y) + 10) and 1 or 0
end)
work(bounceM2, {hand="body", tool={kind="flat", width=7, stiffness=0.6}, length={14,34}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x, y) return 1.35 + 0.1 * nb(x*2, y) end,
  piles={{rock, 1}, {lent, function(x,y) return 0.35 * (1 - w(x,y)) end},
         {waterdark, function(x,y) return 0.85 * w(x,y) end},
         {haze, function(x,y) return 0.32 * w(x,y) end},
         {amber, function(x,y) return 0.1 * w(x,y) end}}})
blend(bounceM2:shrink(2), {angle=1.35})

--@ chunk 499
local m = bounceM2:grow(1.5) * fgRock3:grow(1.5)
for k = 1, 4 do
  local r = rag{width=18}; r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=math.pi/2, passes=2, refold=0.35})
  r = rag{width=18}; r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=0, passes=2, refold=0.35})
end

--@ chunk 500
palette{scrape={mossdeep, mosslit3}}
warmG1 = pile{{"yellow ochre",1},{"red earth",0.4},{"raw umber",0.15}, medium=0.8, name="warmG1"}
trunkG = ribbon({{257,306},{257.3,330},{257.8,355},{258.5,380},{259,392}}, {7, 7.5, 7, 5, 1.5})
print(trunkG:area())
work(trunkG, {hand="glaze", pile=warmG1, tool="filbert 6", coverage=1, angle=math.pi/2, clip=true})

--@ chunk 501
local m = trunkG:grow(2)
for k = 1, 3 do
  local r = rag{width=10}; r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=math.pi/2, passes=2, refold=0.4})
  r = rag{width=10}; r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=0, passes=2, refold=0.4})
end

--@ chunk 502
local m = trunkG:grow(2)
for k = 1, 3 do
  local r = rag{width=10}; r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=math.pi/2, passes=2, refold=0.3})
  r = rag{width=10}; r:dip(1.0)
  r:wipe(m, {pressure=1.0, angle=0.3, passes=2, refold=0.3})
end

--@ chunk 503
print(wait(30 * 24 * 60))
print(drying(257, 340), drying(250, 1150))

--@ chunk 504
print(palette())
print(waterdark, haze, amber, lent, rock)

--@ chunk 505
-- contact line for the left loaf (bm5): level, low-frequency wobble
local cn = noise{seed=811, octaves=2, period=90}
contactPts = {}
for x = -5, 300, 5 do
  local bump = 1.8 * math.exp(-((x-125)/70)^2)   -- the front bulge sits a little lower
  local y = 906 + bump + 1.4 * cn(x, 0)
  contactPts[#contactPts+1] = {x, y}
end
contactY = function(x)
  local i = math.floor((x + 5) / 5) + 1
  i = clamp(i, 1, #contactPts - 1)
  local a, b = contactPts[i], contactPts[i+1]
  local t = clamp((x - a[1]) / 5, 0, 1)
  return lerp(a[2], b[2], t)
end
local belowC = below(contactPts)
sagM = (belowC * bm5:grow(5):soften(5)) - rockLN:grow(1.5)
print("sag area", sagM:area())
for _, x in ipairs({20, 60, 100, 150, 200, 250, 280}) do
  io_s = string.format("x %d contact %.1f", x, contactY(x)) print(io_s)
end

--@ chunk 506
palette{scrape={warmG1}}
wC = mix{{waterdark,.85},{deeprust,.11},{haze,.02},{amber,.02}, name="wC"}
local sn = noise{seed=95, octaves=2, period=18, stretch={math.pi/2, 4}}
work(sagM, {hand="body", tool="flat 6", piles={{wC,1},{waterdark,function(x,y) return 0.12*math.max(0, sn(x,y)) end}},
  angle=math.pi/2, length={12,32}, coverage=3, fill=true, clip=true, load=0.7, seed=4501})
print(drying(150, 915))

--@ chunk 507
local bn = noise{seed=812, octaves=2, period=70}
reflBottom = function(x)
  local mid = 1 - ((x-150)/140)^2   -- deeper under the middle of the rock
  return 928 + 8*math.max(0, mid) + 5*bn(x, 0)
end
reflM = mask(function(x, y)
  if x < 34 or x > 292 or y < 900 or y > 960 then return 0 end
  local top = contactY(x) + 2.5
  if y < top then return 0 end
  local bot = reflBottom(x)
  local v = 1 - smoothstep(bot - 6, bot + 2, y)
  local xl = smoothstep(34, 52, x)
  return v * xl
end) - rockLN:grow(1.5)
print("refl area", reflM:area())

--@ chunk 508
reflM = reflM * rect(0, 880, 285, 100):soften(3)
rR = mix{{wC,.7},{rock,.2},{waterdark,.1}, name="rR"}
local b = brush{kind="flat", width=4, stiffness=0.5}
local xs = uneven(64, 40, 282, 0.6, 0.4, 913)
local n = 0
for i, x in ipairs(xs) do
  if n % 4 == 0 then b:reload(rR, 0.45) end
  n = n + 1
  local y0 = contactY(x) + rand(2.5, 5.5)
  local y1 = reflBottom(x) + rand(-6, 4)
  local xx = x + rand(-0.8, 0.8)
  b:stroke({{xx, y0}, {xx + rand(-0.6, 0.6), (y0+y1)/2}, {xx + rand(-1, 1), y1}},
    {pressure={rand(0.45, 0.65), 0.04}, ramps={0.08, 0.5}, orient="across", clip=reflM})
end
print(n)

--@ chunk 509
blend(reflM, {angle=math.pi/2, seed=4502})

--@ chunk 510
local liftM = (sagM + reflM):grow(2)
for k = 1, 4 do
  local r = rag{width=16}
  r:dip(1.0)
  r:wipe(liftM, {pressure=1.0, angle=(k % 2 == 0) and math.pi/2 or 0, passes=2, refold=0.5, seed=4510+k})
end
print(drying(150, 915), drying(100, 925), drying(250, 912))

--@ chunk 511
-- horizontal tapered ribbon segment mask
function segMask(x0, x1, yc, w, ph, amp)
  amp = amp or 0.6
  local top, bot = {}, {}
  local n = math.max(6, math.floor((x1 - x0) / 3))
  for i = 0, n do
    local t = i / n
    local x = lerp(x0, x1, t)
    local hw = 0.5 * w * math.sin(math.pi * t) ^ 0.5
    local yy = yc + amp * math.sin(x / 23 + ph)
    top[#top+1] = {x, yy - hw}
    table.insert(bot, 1, {x, yy + hw})
  end
  local pts = {}
  for _, p in ipairs(top) do pts[#pts+1] = p end
  for _, p in ipairs(bot) do pts[#pts+1] = p end
  return poly(pts)
end
-- extent of the old dark sag per row
function sagSpan(y)
  local xa, xb
  for x = 20, 290, 1 do
    if bm5:at(x, y) > 0.5 and rockLN:at(x, y) < 0.1 then xa = xa or x; xb = x end
  end
  return xa, xb
end
for _, y in ipairs({912, 916, 920, 924, 927}) do
  local a, b = sagSpan(y) print(y, a, b)
end

--@ chunk 512
local rows = {
  {914.5, 1.5, {{72,128},{178,236}}},
  {918.0, 2.2, {{58,116},{138,206},{226,276}}},
  {921.5, 2.8, {{60,112},{122,178}}},
  {925.0, 3.4, {{74,152}}},
  {928.5, 3.0, {{90,128}}},
}
bitesL = nil
for ri, r in ipairs(rows) do
  for si, s in ipairs(r[3]) do
    local m = segMask(s[1] + rand(-3,3), s[2] + rand(-3,3), r[1] + rand(-0.5,0.5), r[2] * rand(0.85, 1.15), rand(0, 6))
    bitesL = bitesL and (bitesL + m) or m
  end
end
bitesL = bitesL - rockLN:grow(1)
print("bites area", bitesL:area())

--@ chunk 513
work(bitesL, {hand="body", tool={kind="round", width=3}, pile=wC, angle=0, length={8,30}, coverage=3, fill=true, clip=true, load=0.6, seed=4520})

--@ chunk 514
print(wait(40*24*60))
print(drying(100,918), drying(150,925), drying(200,915))

--@ chunk 515
-- no marks: just print the column (read-only via probe isn't available in lua?)
print(contactY(150), contactY(60), contactY(250))

--@ chunk 516
for x = 10, 80, 5 do
  local top
  for y = 800, 910 do if bm5:at(x, y) > 0.5 then top = y break end end
  print(x, top)
end
for y = 830, 910, 5 do
  local lft
  for x = 0, 120 do if bm5:at(x, y) > 0.5 then lft = x break end end
  print("y", y, lft)
end

--@ chunk 517
local tn = noise{seed=4530, octaves=2, period=40}
extTop = function(x)
  -- continue the rock's top contour out of the frame: from 833 at x=20 easing to ~839 at x=0, low-freq wobble
  if x >= 20 then
    for y = 800, 910 do if bm5:at(x, y) > 0.5 then return y end end
    return 833
  end
  return 833 + (20 - x) * 0.3 + 1.2 * tn(x, 0)
end
extL = mask(function(x, y)
  if x > 70 or y < 820 or y > 915 then return 0 end
  local t = extTop(x)
  local c = contactY(x)
  if y < t or y > c then return 0 end
  return 1
end)
-- only the new part plus a soft overlap into the rock's left end
extNew = extL * (-(bm5:shrink(8))):soften(4)
print("extL", extL:area(), "extNew", extNew:area())

--@ chunk 518
palette{scrape={rR, orangeleaf, leafshade, brushdark}}
mossdeep = pile{{"green earth",2},{"raw umber",1.2},{"yellow ochre",.8},{"Prussian blue",.1}, name="mossdeep"}
xA = mix{{mossdeep,.68},{rock,.2},{amber,.12}, name="xA"}
xB = mix{{mossdeep,.42},{deeprust,.2},{rock,.3},{amber,.08}, name="xB"}
xC = mix{{rock,.48},{waterdark,.3},{deeprust,.12},{lent,.1}, name="xC"}
print(palette())

--@ chunk 519
local sn = noise{seed=4540, octaves=2, period=14, stretch={math.pi/2, 3}}
local function depth(x, y) return y - extTop(x) end
local wA = function(x, y) local d = depth(x, y); return (1 - smoothstep(3, 10, d)) * (0.35 + 0.65 * smoothstep(0, 30, x)) end
local wB = function(x, y) local d = depth(x, y); return smoothstep(3, 10, d) * (1 - smoothstep(18, 34 + 6 * sn(x, y), d)) + (1 - smoothstep(3,10,d)) * (1 - (0.35 + 0.65 * smoothstep(0, 30, x))) end
local wC2 = function(x, y) local d = depth(x, y); return smoothstep(18, 34 + 6 * sn(x, y), d) end
work(extNew, {hand="body", tool="flat 5", piles={{xA, wA}, {xB, wB}, {xC, wC2}},
  angle=function(x, y) local d = depth(x, y); return lerp(-0.3 + math.pi, math.pi/2, smoothstep(4, 14, d)) end,
  length={10, 26}, coverage=3.5, fill=true, clip=true, load=0.8, seed=4541})
print(drying(10, 860))

--@ chunk 520
-- find bm5's top at the tab locations
for _, x in ipairs({108,112,116,120,124,128,220,224,228,232,236}) do
  local top
  for y = 790, 830 do if bm5:at(x, y) > 0.5 then top = y break end end
  print(x, top)
end

--@ chunk 521
local function hump(x0, x1, ybase, h)
  local pts = {}
  local n = 14
  for i = 0, n do
    local t = i / n
    pts[#pts+1] = {lerp(x0, x1, t), ybase - h * math.sin(math.pi * t) ^ 0.8}
  end
  pts[#pts+1] = {x1, ybase + 4}
  pts[#pts+1] = {x0, ybase + 4}
  return poly(pts)
end
tabM = hump(103, 133, 806, 6.5) + hump(216, 244, 811, 6.5)
print(tabM:area())

--@ chunk 522
work(tabM, {hand="body", tool={kind="round", width=3}, pile=xA, angle=0, length={6,18}, coverage=3, fill=true, clip=true, load=0.7, seed=4550})

--@ chunk 523
for _, y in ipairs({1160,1170,1180,1190,1200,1210,1220}) do
  local s = ""
  for x = 290, 330, 4 do
    s = s .. " " .. x
  end
end
print(fgRock3:at(296,1170), fgRock3:at(300,1190), fgRock3:at(302,1210))
for _, y in ipairs({1160,1170,1180,1190,1200,1210}) do
  local xe
  for x = 280, 330 do if fgRock3:at(x, y) < 0.5 then xe = x break end end
  print(y, xe)
end

--@ chunk 524
smearG1 = (poly({{293,1158},{306,1155},{318,1162},{324,1178},{323,1198},{318,1216},{306,1222},{300,1212},{297,1190},{294,1172}}, true):roughen(2.5, 14, 4561)) - fgRock3:shrink(1)
smearG2 = (poly({{298,1166},{309,1166},{316,1178},{316,1200},{310,1212},{304,1208},{300,1190}}, true):roughen(2, 12, 4562)) - fgRock3:shrink(1)
print(smearG1:area(), smearG2:area())

--@ chunk 525
palette{scrape={xB, xC}}
work(smearG1, {hand="glaze", pile=gD2, coverage=1, seed=4563})
work(smearG2, {hand="glaze", pile=gD2, coverage=1, seed=4564})

--@ chunk 526
for k = 1, 3 do
  local r = rag{width=12}
  r:dip(1.0)
  r:wipe(smearG1:grow(2), {pressure=1.0, angle=(k%2==0) and 0 or math.pi/2, passes=2, refold=0.5, seed=4570+k})
end
print(drying(308,1185), drying(312,1162))

--@ chunk 527
palette{scrape={p3, q1}}
q4 = mix{{waterdark,.68},{haze,.16},{amber,.12},{deeprust,.04}, name="q4"}
notRock = -(fgRock3:grow(0.5))
work(smearG1, {hand="body", tool="flat 4", pile=q4, angle=math.pi/2 + 0.05, length={14,40}, coverage=2.5, fill=true,
  edge="soft", clip=notRock, load=0.55, seed=4580})
print(drying(308,1185))

--@ chunk 528
for k = 1, 4 do
  local r = rag{width=12}
  r:dip(1.0)
  r:wipe(smearG1:grow(4) * notRock, {pressure=1.0, angle=(k%2==0) and 0 or math.pi/2, passes=2, refold=0.5, seed=4590+k})
end
print(drying(308,1185))

--@ chunk 529
print(wait(40*24*60))
print(drying(10,860), drying(116,804), drying(150,925), drying(308,1185))

--@ chunk 530
print("no marks")

--@ chunk 531
loafM = (bm5 + extL) - rockLN:grow(1)
topT = {}
for x = 0, 300, 2 do
  local t
  for y = 790, 905 do if loafM:at(x, y) > 0.5 then t = y break end end
  topT[#topT+1] = t or 905
end
topAt = function(x)
  local i = clamp(x / 2, 0, #topT - 1.001)
  local i0 = math.floor(i)
  return lerp(topT[i0+1], topT[i0+2], i - i0)
end
for _, x in ipairs({0,10,30,60,100,150,200,250,280,290}) do print(x, topAt(x)) end
local zn = noise{seed=4600, octaves=2, period=60}
combBot = function(x) return topAt(x) + 66 + 5 * zn(x, 0) end
combZ = loafM * mask(function(x, y)
  if x < 0 or x > 300 or y < 780 or y > 910 then return 0 end
  return (y <= combBot(x)) and 1 or 0
end)
print("combZ", combZ:area())

--@ chunk 532
palette{scrape={gD2, q4, wC}}
xB = mix{{mossdeep,.42},{deeprust,.2},{rock,.3},{amber,.08}, name="xB"}
xC = mix{{rock,.48},{waterdark,.3},{deeprust,.12},{lent,.1}, name="xC"}
local zn2 = noise{seed=4601, octaves=2, period=55}
local function mwf(x) return math.max(3, 7 + 6 * smoothstep(0, 280, x) + 4 * zn2(x, 0)) end
local function dd(x, y) return y - topAt(x) end
local wm = function(x, y) local d, m = dd(x, y), mwf(x); return 1 - smoothstep(m - 3, m + 4, d) end
local wb = function(x, y) local d, m = dd(x, y), mwf(x); return smoothstep(m - 3, m + 4, d) * (1 - smoothstep(m + 8, m + 20, d)) end
local wc = function(x, y) local d, m = dd(x, y), mwf(x); return smoothstep(m + 8, m + 20, d) + 0.25 * (1 - smoothstep(m - 3, m + 4, d)) end
local ang = function(x, y)
  local a = math.atan((topAt(x + 3) - topAt(x - 3)) / 6)
  local d, m = dd(x, y), mwf(x)
  return lerp(a, math.pi / 2, smoothstep(m + 18, m + 32, d))
end
work(combZ, {hand="body", tool="flat 8", piles={{xA, wm}, {xB, wb}, {xC, wc}}, angle=ang,
  length={14, 40}, coverage=4, fill=true, clip=loafM, load=0.8, seed=4602})
blend(combZ:shrink(3), {angle=0.15, seed=4603})
print(drying(150, 830))

--@ chunk 533
print(wait(40*24*60))
print(drying(150,830), drying(20,850), drying(250,840))

--@ chunk 534
print(mA ~= nil, mB ~= nil)
if mA then print(mA:area(), mB:area()) end
for _, y in ipairs({2, 30, 60, 90, 120, 150, 180, 220, 250, 290, 320, 360, 390, 420}) do
  local xa0, xa1, xb0, xb1
  for x = 700, 1000 do
    if mA:at(x, y) > 0.5 then xa0 = xa0 or x; xa1 = x end
    if mB:at(x, y) > 0.5 then xb0 = xb0 or x; xb1 = x end
  end
  print(y, xa0, xa1, xb0, xb1)
end

--@ chunk 535
-- measure (no marks): trunk center values via probing isn't available in Lua; just print mask widths shrunk
for _, y in ipairs({10, 60, 120, 180, 250, 320, 380, 420, 460}) do
  print(y, string.format("A %.0f w %.0f   B %.0f w %.0f", trunkX("A", y), trunkW("A", y), trunkX("B", y), trunkW("B", y)))
end

--@ chunk 536
-- glaze masks for the upper birches (no paint yet)
local function leftRim(m, w, x0, x1)
  return m - mask(function(x, y)
    if x < x0 or x > x1 or y > 470 then return 0 end
    return m:at(x - w, y)
  end)
end
bA = mA:shrink(1.5)
bB = mB:shrink(1.2)
rimA = leftRim(bA, 3, 740, 830) * rect(700, 0, 200, 470)
rimB = leftRim(bB, 2.5, 900, 990) * rect(880, 0, 120, 470)
local function cut(yb, amp, slope, xc, seed)
  local n = noise{seed=seed, period=24, octaves=2}
  return above(function(x) return yb + amp * n(x, yb) + slope * (x - xc) end)
end
-- A: canopy ends ~390; B: ~420. Bottoms staggered between trunks.
gA1 = (bA - rimA) * cut(388, 6, 0.30, 780, 501)
gA2 = (bA - rimA) * cut(246, 5, -0.25, 780, 502)
gA3 = bA * cut(128, 5, 0.35, 770, 503)
gA4 = bA * cut(52, 4, -0.3, 768, 504)
gB1 = (bB - rimB) * cut(418, 6, -0.30, 935, 511)
gB2 = (bB - rimB) * cut(282, 5, 0.3, 942, 512)
gB3 = bB * cut(96, 5, -0.35, 952, 513)
gB4 = bB * cut(30, 4, 0.3, 956, 514)
for _, k in ipairs({"rimA", "rimB", "gA1", "gA2", "gA3", "gA4", "gB1", "gB2", "gB3", "gB4"}) do
  print(k, string.format("%.0f", _G[k]:area()))
end

--@ chunk 537
for _, l in ipairs({palette()}) do print(l) end

--@ chunk 538
bark75 = pile{{"raw umber",1},{"smalt",0.6}, medium=0.75, name="bark75"}
local tA = {kind="filbert", width=12, stiffness=0.3}
local tB = {kind="filbert", width=9, stiffness=0.3}
for i, m in ipairs({gA1, gA2, gA3, gA4}) do
  work(m, {hand="glaze", pile=bark75, coverage=1, angle=-math.pi/2, tool=tA, clip=bA, seed=600 + i})
end
for i, m in ipairs({gB1, gB2, gB3, gB4}) do
  work(m, {hand="glaze", pile=bark75, coverage=1, angle=-math.pi/2, tool=tB, clip=bB, seed=610 + i})
end
print(drying(770, 100), drying(950, 100))

--@ chunk 539
local out = {}
for y = 340, 640, 10 do
  local a = drying(trunkX("A", y), y)
  local a2 = drying(trunkX("A", y) + 6, y)
  local b = drying(trunkX("B", y), y)
  local b2 = drying(trunkX("B", y) + 4, y)
  out[#out+1] = string.format("%d A %s/%s  B %s/%s", y, a:sub(1,1), a2:sub(1,1), b:sub(1,1), b2:sub(1,1))
end
print(table.concat(out, "\n"))

--@ chunk 540
print(wait(40 * 24 * 60))
print(drying(770, 100), drying(955, 60), drying(780, 300))

--@ chunk 541
-- no marks: list right-edge x of each trunk mask at heights
for _, y in ipairs({20, 60, 100, 140, 180, 220}) do
  local xa1, xb1
  for x = 740, 1000 do
    if mA:at(x, y) > 0.5 then xa1 = x end
  end
  print("A", y, xa1)
end
for _, y in ipairs({90, 130, 170, 210, 250}) do
  local xb1
  for x = 900, 1000 do if mB:at(x, y) > 0.5 then xb1 = x end end
  print("B", y, xb1)
end

--@ chunk 542
function rightEdgeOf(m, y, x0, x1)
  local xr
  for x = x0, x1 do if m:at(x, y) > 0.5 then xr = x end end
  return xr
end
function lobeRibbon(xEdge, y0, y1, reachIn, reachOut, seed, lobe)
  local n = noise{seed=seed, period=36, octaves=2}
  local pts = {}
  local steps = 8
  for i = 0, steps do
    local t = i / steps; local y = lerp(y0, y1, t)
    local w = math.sin(math.pi * t) ^ 0.7
    pts[#pts+1] = {xEdge(y) - reachIn * w * (0.75 + 0.5 * n:at01(y, 1)), y}
  end
  for i = steps - 1, 1, -1 do
    local t = i / steps; local y = lerp(y0, y1, t)
    local w = math.sin(math.pi * t) ^ 0.7
    pts[#pts+1] = {xEdge(y) + reachOut * w, y}
  end
  local o = outline{pts=pts, char="soft", seed=seed, lobe=lobe or 5, amount=1.0, edge=1}
  return o:mask()
end
local edA, edB = {}, {}
for y = -20, 300, 2 do
  edA[y] = rightEdgeOf(mA, math.max(y, 1), 740, 830)
  edB[y] = rightEdgeOf(mB, math.max(y, 1), 900, 1000)
end
local function look(t, y) local k = math.floor(clamp(y, -20, 300) / 2 + 0.5) * 2; return t[k] or t[k - 2] or t[k + 2] end
local xA_ = function(y) return look(edA, y) end
local xB_ = function(y) return look(edB, y) end
shadeA = lobeRibbon(xA_, -8, 42, 8, 5, 701, 5) + lobeRibbon(xA_, 98, 146, 7, 5, 702, 5) + lobeRibbon(xA_, 176, 224, 8, 5, 703, 5)
shadeB = lobeRibbon(xB_, 86, 128, 6, 4, 711, 4) + lobeRibbon(xB_, 156, 196, 5, 4, 712, 4) + lobeRibbon(xB_, 226, 264, 6, 4, 713, 4)
crossA = outline{pts={{764, 396}, {772, 389}, {781, 392}, {789, 386}, {798, 390}, {806, 387}, {814, 393}, {820, 398},
  {818, 405}, {810, 410}, {801, 407}, {793, 412}, {784, 409}, {776, 411}, {768, 406}}, char="soft", seed=721, lobe=4, edge=1}:mask()
crossB = outline{pts={{904, 408}, {912, 403}, {920, 406}, {928, 401}, {936, 405}, {944, 409}, {951, 414},
  {950, 421}, {943, 425}, {935, 422}, {927, 428}, {918, 425}, {909, 429}, {903, 422}}, char="soft", seed=722, lobe=4, edge=1}:mask()
for _, k in ipairs({"shadeA", "shadeB", "crossA", "crossB"}) do print(k, string.format("%.0f", _G[k]:area())) end
print(xA_(20), xA_(120), xA_(200), xB_(100), xB_(176), xB_(246))

--@ chunk 543
palette{scrape={bark75, xA, xB, xC}}
local tool = {kind="round", width=3}
local base = {hand="body", tool=tool, length={4, 12}, angle=math.pi/2, angle_jitter=0.8, coverage=3, fill=true, clip=true}
local function with(t, extra) local r = {}; for k, v in pairs(t) do r[k] = v end; for k, v in pairs(extra) do r[k] = v end; return r end
work(shadeA, with(base, {piles={{deeprust, .55}, {leafrust, .25}, {orangeleaf, .1}, {amber, .1}}, seed=731}))
work(shadeB, with(base, {piles={{deeprust, .85}, {leafrust, .15}}, seed=732}))
work(crossA, with(base, {piles={{deeprust, function(x, y) return 0.3 + 0.012 * (x - 764) end}, {orangeleaf, .3}, {leafrust, .1}, {amber, function(x, y) return 0.3 - 0.003 * (x - 764) end}}, seed=733}))
work(crossB, with(base, {piles={{deeprust, .85}, {leafrust, .15}, {amber, function(x, y) return clamp((x - 940) / 12, 0, 1) * 0.3 end}}, seed=734}))
print(drying(800, 120), drying(930, 415))

--@ chunk 544
local function colMask(xl, xr, yTop, yBot, seed)
  local nS = noise{seed=seed, period=60, octaves=2}
  local nB = noise{seed=seed + 1, period=26, octaves=2}
  return mask(function(x, y)
    if y < yTop or y > yBot + 14 or x < xl - 8 or x > xr + 8 then return 0 end
    local l = xl + 4 * nS(y, 0)
    local r = xr + 4 * nS(y, 50)
    local b = yBot + 10 * nB(x, 0)
    if x >= l and x <= r and y <= b then return 1 end
    return 0
  end)
end
rfA1 = colMask(774, 822, 918, 1085, 801)
rfA2 = colMask(779, 817, 918, 1028, 803)
rfB1 = colMask(886, 934, 930, 1110, 811)
rfB2 = colMask(890, 929, 930, 1048, 813)
for _, k in ipairs({"rfA1", "rfA2", "rfB1", "rfB2"}) do print(k, string.format("%.0f", _G[k]:area())) end

--@ chunk 545
local tool = {kind="filbert", width=14, stiffness=0.3}
for i, m in ipairs({rfA1, rfA2, rfB1, rfB2}) do
  work(m, {hand="glaze", pile=gD2, coverage=1, angle=math.pi/2, tool=tool, clip=m, seed=820 + i})
end
print(drying(800, 980), drying(910, 1000))

--@ chunk 546
local lm = (rfA1 + rfB1):grow(4)
for k = 1, 3 do
  local r = rag{width=16}
  r:dip(1.0)
  r:wipe(lm, {pressure=1.0, angle=math.pi/2, passes=2, refold=0.5, seed=840 + k})
  local r2 = rag{width=16}
  r2:dip(1.0)
  r2:wipe(lm, {pressure=1.0, angle=0, passes=2, refold=0.5, seed=850 + k})
end
print(drying(800, 925), drying(910, 940), drying(800, 1000))

--@ chunk 547
for _, x in ipairs({765, 780, 800, 820, 840, 870, 890, 910, 930, 950}) do
  local yb
  for y = 880, 990 do if bm7:at(x, y) > 0.5 then yb = y end end
  print(x, yb)
end

--@ chunk 548
for _, x in ipairs({900, 910, 930, 950, 970}) do
  local yb
  for y = 860, 990 do if (bm8 and bm8:at(x, y) > 0.5) or (bm9 and bm9:at(x, y) > 0.5) then yb = y end end
  print(x, yb, bm9 ~= nil)
end

--@ chunk 549
function crossRibbons(cx, yTop, yEnd, seed)
  math.randomseed(seed)
  local m = nil
  local y = yTop
  local i = 0
  while y < yEnd do
    i = i + 1
    local t = (y - yTop) / (yEnd - yTop)
    local L = lerp(78, 44, t) * rand(0.8, 1.2)
    local xs = cx - L * rand(0.35, 0.65)
    local w = lerp(5.2, 1.8, t) * rand(0.7, 1.2)
    local pts, ws = {}, {}
    for k = 0, 10 do
      local u = k / 10
      pts[#pts+1] = {xs + L * u, y + 0.8 * math.sin(u * 4 + i)}
      ws[#ws+1] = w * math.sin(math.pi * u) ^ 0.5 * (0.75 + 0.25 * math.sin(u * 7 + i * 2))
    end
    local r = ribbon(pts, ws)
    m = m and (m + r) or r
    y = y + lerp(3.6, 15, t ^ 1.2) * rand(0.7, 1.3)
  end
  return m
end
local water = below({{-10, 912}, {1010, 912}}) - bm7:grow(1.5)
crA = crossRibbons(798, 934, 1040, 9101) * water
crB = crossRibbons(910, 958, 1066, 9102) * water
print(string.format("%.0f %.0f", crA:area(), crB:area()))

--@ chunk 550
local function tA(y) return clamp((y - 930) / 60, 0, 1) end
local function tB(y) return clamp((y - 950) / 60, 0, 1) end
local function piles_for(tf)
  return {
    {waterdark, function(x, y) return lerp(0.85, 0.80, tf(y)) end},
    {deeprust, function(x, y) return lerp(0.11, 0.0, tf(y)) end},
    {haze, function(x, y) return lerp(0.02, 0.14, tf(y)) end},
    {amber, function(x, y) return lerp(0.02, 0.06, tf(y)) end},
  }
end
local tool = {kind="round", width=3}
work(crA, {hand="body", tool=tool, length={10, 40}, angle=0, coverage=3, fill=true, clip=true, piles=piles_for(tA), seed=9111})
work(crB, {hand="body", tool=tool, length={10, 40}, angle=0, coverage=3, fill=true, clip=true, piles=piles_for(tB), seed=9112})
print(drying(798, 950), drying(910, 990))

--@ chunk 551
local lm = (crA + crB):grow(3)
for k = 1, 4 do
  local r = rag{width=14}
  r:dip(1.0)
  r:wipe(lm, {pressure=1.0, angle=0, passes=2, refold=0.4, seed=9200 + k})
  local r2 = rag{width=14}
  r2:dip(1.0)
  r2:wipe(lm, {pressure=1.0, angle=math.pi/2, passes=2, refold=0.4, seed=9210 + k})
end
print(drying(800, 1000), drying(800, 950))

--@ chunk 552
local function colFade(xl, xr, yTop, yBot, seed)
  local nS = noise{seed=seed, period=50, octaves=2}
  local nB = noise{seed=seed + 1, period=22, octaves=2}
  return mask(function(x, y)
    if y < yTop or y > yBot + 12 or x < xl - 6 or x > xr + 6 then return 0 end
    local l = xl + 3 * nS(y, 0)
    local r = xr + 3 * nS(y, 40)
    local b = yBot + 9 * nB(x, 0)
    if x >= l and x <= r and y <= b then return 1 end
    return 0
  end):soften(2)
end
local water = below({{-10, 912}, {1010, 912}}) - bm7:grow(1)
fdA = colFade(775, 822, 926, 1042, 9301) * water
fdB = colFade(887, 933, 950, 1068, 9311) * water
print(string.format("%.0f %.0f", fdA:area(), fdB:area()))

--@ chunk 553
local function pass(m, y0, y1, seed)
  local function t(y) return clamp((y - y0) / (y1 - y0), 0, 1) end
  work(m, {hand="body", tool="flat 4", angle=math.pi/2, coverage=2.5, clip=true, length={30, 80}, pressure={0.2, 0.45}, seed=seed,
    load_at=function(x, y) return lerp(0.9, 0.05, t(y) ^ 0.8) end,
    piles={
      {waterdark, function(x, y) return lerp(0.82, 0.52, t(y)) end},
      {deeprust, function(x, y) return lerp(0.06, 0.22, t(y)) end},
      {haze, function(x, y) return lerp(0.08, 0.10, t(y)) end},
      {amber, function(x, y) return lerp(0.04, 0.16, t(y)) end},
    }})
end
pass(fdA, 926, 1042, 9321)
pass(fdB, 950, 1068, 9322)
print(drying(798, 960), drying(910, 990))

--@ chunk 554
local lm = (fdA + fdB):grow(3)
for k = 1, 5 do
  local r = rag{width=14}
  r:dip(1.0)
  r:wipe(lm, {pressure=1.0, angle=math.pi/2, passes=2, refold=0.4, seed=9400 + k})
  local r2 = rag{width=14}
  r2:dip(1.0)
  r2:wipe(lm, {pressure=1.0, angle=0, passes=2, refold=0.4, seed=9410 + k})
end
print(drying(798, 960), drying(910, 990))

--@ chunk 555
palette{scrape={gD2, leafrust, orangeleaf}}
wgM = pile{{"raw umber",0.56},{"Prussian blue",0.12},{"red earth",0.22},{"green earth",0.11}, medium=0.7, name="wgM"}
local function colMask(xl, xr, yTop, yBot, seed)
  local nS = noise{seed=seed, period=60, octaves=2}
  local nB = noise{seed=seed + 1, period=26, octaves=2}
  return mask(function(x, y)
    if y < yTop or y > yBot + 14 or x < xl - 8 or x > xr + 8 then return 0 end
    local l = xl + 4 * nS(y, 0)
    local r = xr + 4 * nS(y, 50)
    local b = yBot + 10 * nB(x, 0)
    if x >= l and x <= r and y <= b then return 1 end
    return 0
  end)
end
local water = below({{-10, 912}, {1010, 912}}) - bm7:grow(1)
wgA1 = colMask(770, 828, 920, 1042, 9501) * water
wgA2 = colMask(774, 824, 920, 988, 9503) * water
wgB1 = colMask(882, 938, 930, 1072, 9511) * water
wgB2 = colMask(886, 934, 930, 1014, 9513) * water
local tool = {kind="filbert", width=14, stiffness=0.3}
for i, m in ipairs({wgA1, wgA2, wgB1, wgB2}) do
  work(m, {hand="glaze", pile=wgM, coverage=1, angle=math.pi/2, tool=tool, clip=m, seed=9520 + i})
end
print(drying(800, 960), drying(910, 990))

--@ chunk 556
local lm = (wgA1 + wgB1):grow(4)
for k = 1, 5 do
  local r = rag{width=14}
  r:dip(1.0)
  r:wipe(lm, {pressure=1.0, angle=math.pi/2, passes=2, refold=0.4, seed=9600 + k})
  local r2 = rag{width=14}
  r2:dip(1.0)
  r2:wipe(lm, {pressure=1.0, angle=0, passes=2, refold=0.4, seed=9610 + k})
end
print(drying(800, 960), drying(910, 990), drying(800, 1030))

--@ chunk 557
local lm = (wgA1 + wgB1):grow(4)
for k = 1, 4 do
  local r = rag{width=12}
  r:dip(1.0)
  r:wipe(lm, {pressure=1.0, angle=math.pi/2, passes=3, refold=0.3, seed=9700 + k})
end
local n = 0
for x = 766, 942, 4 do for y = 916, 1086, 4 do if lm:at(x, y) > 0.5 and drying(x, y) == "open" then n = n + 1 end end end
print("open pts", n)

--@ chunk 558
local water = below({{-10, 912}, {1010, 912}}) - bm7:grow(1)
forkA = poly({{783, 921}, {823, 921}, {820, 948}, {815, 976}, {811, 1006}, {806, 982}, {802, 970}, {798, 984}, {794, 994}, {790, 968}, {786, 946}}, true):roughen(1.2, 30, 9801) * water
forkB = poly({{888, 944}, {932, 944}, {929, 968}, {924, 996}, {920, 1024}, {915, 1000}, {910, 986}, {906, 1000}, {903, 1012}, {898, 988}, {891, 964}}, true):roughen(1.2, 30, 9811) * water
print(string.format("%.0f %.0f", forkA:area(), forkB:area()))

--@ chunk 559
local function piles_for(y0, y1)
  local function t(y) return clamp((y - y0) / (y1 - y0), 0, 1) end
  return {
    {waterdark, function(x, y) return lerp(0.84, 0.78, t(y)) end},
    {haze, function(x, y) return lerp(0.09, 0.15, t(y)) end},
    {deeprust, function(x, y) return lerp(0.05, 0.01, t(y)) end},
    {amber, function(x, y) return lerp(0.02, 0.06, t(y)) end},
  }
end
local tool = {kind="flat", width=4}
work(forkA, {hand="body", tool=tool, angle=math.pi/2, length={20, 60}, coverage=3, fill=true, clip=true, load=0.85, piles=piles_for(925, 1000), seed=9821})
work(forkB, {hand="body", tool=tool, angle=math.pi/2, length={20, 60}, coverage=3, fill=true, clip=true, load=0.85, piles=piles_for(945, 1020), seed=9822})
blend(forkA:shrink(2), {angle=math.pi/2})
blend(forkB:shrink(2), {angle=math.pi/2})
print("ok")

--@ chunk 560
local lm = (forkA + forkB):grow(3)
for k = 1, 6 do
  local r = rag{width=12}
  r:dip(1.0)
  r:wipe(lm, {pressure=1.0, angle=math.pi/2, passes=2, refold=0.35, seed=9900 + k})
  local r2 = rag{width=12}
  r2:dip(1.0)
  r2:wipe(lm, {pressure=1.0, angle=0, passes=2, refold=0.35, seed=9910 + k})
end
print("lifted")

--@ chunk 561
local r = rag{width=6}
r:dip(1.0)
for k = 1, 3 do r:blot(794.5, 992.5, {pressure=1.0}); r:refold() end
local r2 = rag{width=6}; r2:dip(1.0)
r2:wipe({{792, 989}, {797, 996}}, {pressure=1.0})
r2:refold()
r2:wipe({{797, 989}, {792, 996}}, {pressure=1.0})
print(drying(794.5, 992.5))

--@ chunk 562
print(wait(40 * 24 * 60))
local n = 0
for x = 700, 1000, 6 do for y = 0, 1250, 6 do if drying(x, y) ~= "dry" then n = n + 1 end end end
print("not dry pts (right half)", n)
