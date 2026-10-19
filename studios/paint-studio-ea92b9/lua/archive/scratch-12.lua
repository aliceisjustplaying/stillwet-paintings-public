-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
s_zen  = pile{{"lead white",0.6},{"smalt",1.5},{"cobalt blue",0.8},{"Prussian blue",0.1},{"raw umber",0.15},{"bone black",0.04}, name="s_zen"}
s_top  = pile{{"lead white",1.5},{"smalt",1.2},{"cobalt blue",0.8},{"raw umber",0.08}, name="s_top"}
s_mid  = pile{{"lead white",3},{"cobalt blue",0.6},{"smalt",0.6},{"Naples yellow",0.2}, name="s_mid"}
s_grn  = pile{{"lead white",5},{"Naples yellow",1},{"cobalt blue",0.6}, name="s_grn"}
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
s_low  = pile{{"lead white",4},{"Naples yellow",1.4},{"yellow ochre",0.3},{"vermilion",0.2},{"rose madder",0.1}, name="s_low"}
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local sky = rect(0,0,1000,470)
work(sky, {hand="broad", piles={{s_zen,wgt(0,150)},{s_top,wgt(120,120)},{s_mid,wgt(235,110)},{s_grn,wgt(325,100)},{s_glow,wgt(400,80)},{s_low,wgt(465,70)}}, angle=0, coverage=2.6, fill=true, clip=sky, seed=111})
blend(sky:shrink(1), {angle=0}); blend(sky:shrink(1), {angle=0.04})
wait(3*24*60)
g_sky = pile{{"smalt",2},{"cobalt blue",0.35},{"rose madder",0.1},{"raw umber",0.16}, medium=0.75, name="g_sky"}
work(rect(0,0,1000,330), {hand="glaze", pile=g_sky, angle=0, coverage=1.8, clip=rect(0,0,1000,440), load_at=function(x,y) return clamp(1 - y/300, 0, 1)^1.2 end, seed=121})
blend(rect(0,0,1000,345), {angle=0}); blend(rect(0,0,1000,345), {angle=0.03})
blend(rect(0,0,1000,300), {angle=0.0, seed=7}); blend(rect(0,0,1000,300), {angle=-0.03, seed=8})
wait(9*24*60)
g_sky2 = pile{{"smalt",2},{"cobalt blue",0.25},{"rose madder",0.12},{"raw umber",0.3}, medium=0.78, name="g_sky2"}
work(rect(0,0,1000,230), {hand="glaze", pile=g_sky2, angle=0, coverage=1.5, clip=rect(0,0,1000,300), load_at=function(x,y) return clamp(1 - y/220, 0, 1)^1.4 end, seed=191})
for i=1,4 do blend(rect(0,0,1000,260), {angle=(i%2==0) and 0.02 or -0.02, seed=200+i}) end
wait(3*24*60)
d0 = pile{{"lead white",0.35},{"smalt",1.5},{"cobalt blue",0.8},{"raw umber",0.3},{"rose madder",0.05}, name="d0"}
d1 = pile{{"lead white",0.6},{"smalt",1.4},{"cobalt blue",0.8},{"raw umber",0.22},{"rose madder",0.04}, name="d1"}
d2 = pile{{"lead white",1.4},{"smalt",1.1},{"cobalt blue",0.7},{"raw umber",0.14}, name="d2"}
d3 = pile{{"lead white",2.4},{"smalt",0.9},{"cobalt blue",0.6},{"raw umber",0.08}, thinner=0.5, name="d3"}
work(rect(0,0,1000,262), {hand="broad", piles={{d0,wgt(0,95)},{d1,wgt(75,90)},{d2,wgt(155,85)},{d3,wgt(235,75)}}, angle=0, ruler=true, coverage=2.4, fill=true, clip=rect(0,0,1000,280),
  load_at=function(x,y) return clamp(1.25 - y/220, 0.12, 1) end, seed=211})
for i=1,3 do blend(rect(0,0,1000,275), {angle=0, seed=220+i}) end
print(wait(10*24*60))

--@ chunk 3
-- simulate the damage: a mismatched patch, wiped
local bad = pile{{"lead white",2},{"smalt",0.9},{"cobalt blue",0.6},{"raw umber",0.08}, name="bad"}
work(rect(120,70,50,50), {hand="detail", tool={kind="filbert", width=3}, pile=bad, coverage=3, fill=true, clip=rect(120,70,50,50), seed=1})
for pass=1,3 do local r = rag{width=14}; r:dip(0.95); r:wipe(rect(118,66,60,60), {pressure=0.95, angle=0, refold=0.15, seed=850+pass}) end
print(wait(4*24*60), drying(140,90))
-- repair A (left area): full-width-ish band of ruler strokes, graded piles, load fading at band edges
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local band = rect(20,40,300,110)
work(band, {hand="broad", piles={{d0,wgt(40,70)},{d1,wgt(85,60)},{d2,wgt(150,70)}}, angle=0, ruler=true, coverage=2.2, fill=true, clip=band,
  load_at=function(x,y) return clamp(1 - math.abs(y-95)/60, 0.1, 1) * clamp(math.min(x-20, 320-x)/60, 0.15, 1) end, seed=31})
for i=1,2 do blend(band, {angle=0, seed=40+i}) end

--@ chunk 4
t_twig = pile{{"raw umber",1.2},{"bone black",0.8},{"Prussian blue",0.08},{"red earth",0.05}, medium=0.15, name="t_twig"}
local rb = brush{kind="round", width=4, point=1}
rb:load(t_twig, 0.8)
rb:gesture({{600,200,0.7},{610,150,0.5},{605,110,0.3},{615,90,0.05}})
rb:gesture({{700,200,0.7},{690,140,0.5},{700,100,0.05}})
local rg = brush{kind="rigger", width=1.6, point=1}
rg:load(t_twig, 0.7)
rg:gesture({{615,90,0.4},{622,80,0.3},{620,72,0.05}})
rg:gesture({{605,110,0.4},{595,100,0.3},{598,92,0.05}})
print(wait(5*24*60))
-- restatement across x 400..1000 (scratch), y 0..160, clip excluding regions near the twigs
local keepz = ellipse(612,100,22,30) + ellipse(697,130,14,40) + rect(590,150,30,60) + rect(685,150,25,60)
local clipm = rect(400,0,600,165) - keepz
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
work(clipm, {hand="broad", piles={{d0,wgt(0,95)},{d1,wgt(75,90)},{d2,wgt(155,85)}}, angle=0, ruler=true, coverage=2.4, fill=true, clip=clipm,
  load_at=function(x,y) return clamp(1.1 - y/150, 0.05, 1) end, seed=61})
for i=1,3 do blend(clipm, {angle=0, seed=70+i}) end

--@ chunk 5
-- recreate similar damage at x 560-640 (sky area near y 40-125); first remove twig test strokes are at 590-710: put damage at 820-900 instead
local light = pile{{"lead white",2},{"smalt",0.9},{"cobalt blue",0.6},{"raw umber",0.08}, name="light"}
work(rect(820,60,50,50), {hand="detail", tool={kind="filbert", width=3}, pile=light, coverage=3, fill=true, clip=rect(820,60,50,50), seed=91})
for pass=1,3 do local r = rag{width=14}; r:dip(0.95); r:wipe(rect(816,56,60,60), {pressure=0.95, angle=0, refold=0.15, seed=92+pass}) end
wait(4*24*60)
local dark = pile{{"lead white",0.35},{"smalt",1.5},{"cobalt blue",0.8},{"raw umber",0.3}}
work(rect(810,48,76,78):blur(3), {hand="detail", tool={kind="filbert", width=3}, pile=dark, coverage=3.5, fill=true, clip=rect(810,48,76,78):blur(3), seed=96})
local k = knife{width=12}
for y=46,128,4 do k:scrape({{888,y},{808,y}}, {pressure=1, angle=math.pi/2}); k:wipe() end
for pass=1,3 do local r = rag{width=14}; r:dip(0.95); r:wipe(rect(808,44,80,82), {pressure=0.95, angle=(pass%2==0) and 0 or math.pi/2, refold=0.15, seed=97+pass}) end
print(wait(5*24*60))

--@ chunk 6
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local m = rect(720,0,280,262)
work(m, {hand="broad", piles={{d0,wgt(0,95)},{d1,wgt(75,90)},{d2,wgt(155,85)},{d3,wgt(235,75)}}, angle=0, ruler=true, coverage=2.4, fill=true, clip=rect(720,0,280,280),
  load_at=function(x,y) return clamp(1.25 - y/220, 0.12, 1) end, seed=311})
for i=1,3 do blend(rect(720,0,280,275), {angle=0, seed=320+i}) end

--@ chunk 7
print(wait(5*24*60))
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local m = rect(0,0,700,178)
work(m, {hand="broad", piles={{d0,wgt(0,95)},{d1,wgt(75,90)},{d2,wgt(155,85)}}, angle=0, ruler=true, coverage=2.4, fill=true, clip=m,
  load_at=function(x,y) return clamp(1 - (y-125)/50, 0.0, 1) end, seed=881})
for i=1,3 do blend(m, {angle=0, seed=890+i}) end
-- A: x 0-350: blurred-mask blend across the seam
local bmA = (rect(0,120,350,100)):blur(25) * rect(0,0,350,714)
for i=1,3 do blend(bmA, {angle=0, seed=900+i}) end
-- B: x 350-700: lay a lighter intermediate (d3 thinner) band across the seam then blend with blurred mask
local bandB = rect(350,150,350,60)
work(bandB, {hand="broad", piles={{d2,wgt(150,30)},{d3,wgt(195,40)}}, angle=0, ruler=true, coverage=1.6, fill=true, clip=bandB, load_at=function(x,y) return clamp(1 - (y-160)/50, 0.0, 0.6) end, seed=910})
local bmB = (rect(350,130,350,90)):blur(25) * rect(350,0,350,714)
for i=1,3 do blend(bmB, {angle=0, seed=920+i}) end

--@ chunk 8
t_twig = pile{{"raw umber",1.2},{"bone black",0.8},{"Prussian blue",0.08},{"red earth",0.05}, medium=0.15, name="t_twig"}
rg_s = brush{kind="rigger", width=1.6, point=1}
rd_m = brush{kind="round", width=4, point=1}
function angular_pts(x, y, ang, len, nseg, jit, upb)
  local nodes = {{x, y}}
  local a = ang
  local cx, cy = x, y
  for i=1,nseg do
    local seg = len/nseg * rand(0.7, 1.3)
    a = a + randn(0, jit)
    a = a + upb*((-math.pi/2) - a) + 0.3*(ang - a)
    cx, cy = cx + seg*math.cos(a), cy + seg*math.sin(a)
    nodes[#nodes+1] = {cx, cy, a}
  end
  return nodes
end
function draw_angular(br, nodes, w0, pl)
  -- densify each straight segment so the smooth gesture stays angular
  local pts = {}
  local n = #nodes
  for i=1,n-1 do
    local a, b = nodes[i], nodes[i+1]
    for k=0,2 do
      local t = k/3
      local tt = ((i-1) + t)/(n-1)
      local w = w0*(1 - 0.75*tt)
      local p = math.max(0.3, br:pressure_for(math.max(w, 0.7)))
      pts[#pts+1] = {lerp(a[1], b[1], t), lerp(a[2], b[2], t), p}
    end
  end
  pts[#pts+1] = {nodes[n][1], nodes[n][2], 0.08}
  if br:fullness() < 0.45 then br:reload(pl, 0.75) end
  br:gesture(pts, {wobble=0.1, ramps={0.02, 0.25}})
end
function oak_spray(x, y, ang, len, w, depth, pl)
  local br = (w > 1.7) and rd_m or rg_s
  local nodes = angular_pts(x, y, ang, len, math.random(2, 4), 0.55, 0.12)
  draw_angular(br, nodes, w, pl)
  if depth > 0 then
    -- shoots cluster at the tip and at one node
    local tip = nodes[#nodes]
    local k = math.random(2, 3)
    for j=1,k do
      oak_spray(tip[1], tip[2], tip[3] + randn(0, 0.7), len*rand(0.35, 0.6), math.max(0.8, w*0.6), depth-1, pl)
    end
    if #nodes > 2 and math.random() < 0.6 then
      local nd = nodes[math.random(2, #nodes-1)]
      local s = (math.random()<0.5) and -1 or 1
      oak_spray(nd[1], nd[2], nd[3] + s*rand(0.5, 1.1), len*rand(0.35, 0.55), math.max(0.8, w*0.55), depth-1, pl)
    end
  end
end
rg_s:reload(t_twig, 0.75); rd_m:reload(t_twig, 0.75)
oak_spray(100, 300, -1.4, 50, 2.6, 2, t_twig)
oak_spray(250, 300, -1.8, 40, 2.2, 2, t_twig)
oak_spray(400, 300, -1.0, 35, 1.8, 1, t_twig)
oak_spray(520, 300, -2.2, 30, 1.6, 1, t_twig)

--@ chunk 9
function oak_spray(x, y, ang, len, w, depth, pl)
  local br = (w > 1.7) and rd_m or rg_s
  local nodes = angular_pts(x, y, ang, len, math.random(2, 3), 0.45, 0.1)
  draw_angular(br, nodes, w, pl)
  if depth > 0 then
    local tip = nodes[#nodes]
    local wc = math.max(0.8, w*0.62)
    -- leader continues
    oak_spray(tip[1], tip[2], tip[3] + randn(0, 0.25), len*rand(0.55, 0.8), wc, depth-1, pl)
    -- one or two divergent shoots from the same point
    for j=1,math.random(1, 2) do
      local s = (math.random()<0.5) and -1 or 1
      oak_spray(tip[1], tip[2], tip[3] + s*rand(0.5, 1.0), len*rand(0.45, 0.7), wc, depth-1, pl)
    end
    if #nodes > 2 and math.random() < 0.5 then
      local nd = nodes[2]
      local s = (math.random()<0.5) and -1 or 1
      oak_spray(nd[1], nd[2], nd[3] + s*rand(0.6, 1.1), len*rand(0.4, 0.6), wc, depth-1, pl)
    end
  end
end
rg_s:reload(t_twig, 0.75); rd_m:reload(t_twig, 0.75)
oak_spray(620, 330, -1.4, 34, 2.4, 2, t_twig)
oak_spray(760, 330, -1.8, 28, 2.0, 2, t_twig)
oak_spray(880, 330, -1.0, 24, 1.6, 1, t_twig)
oak_spray(960, 330, -2.0, 20, 1.4, 1, t_twig)

--@ chunk 10
print(wait(5*24*60))
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local band = rect(0,160,500,180)
work(band, {hand="broad", piles={{s_top,wgt(120,120)},{s_mid,wgt(235,110)},{s_grn,wgt(325,100)},{s_glow,wgt(400,80)}}, angle=0, ruler=true, coverage=2.2, fill=true, clip=band,
  load_at=function(x,y) return clamp(1 - math.abs(y-250)/90, 0.0, 1)^0.7 * clamp((500-x)/80, 0, 1) end, seed=331})
local bz = rect(0,150,520,200):blur(20)
for i=1,3 do blend(bz, {angle=0, seed=340+i}) end

--@ chunk 11
haze_twig = mix{{t_twig,0.55},{d2,0.45}, name="haze_twig"}
rg_s:reload(t_twig, 0.75); rd_m:reload(t_twig, 0.75)
oak_spray(150, 140, -1.3, 22, 1.8, 2, t_twig)
oak_spray(300, 140, -1.6, 22, 1.8, 2, t_twig)
local hr = brush{kind="rigger", width=1.0, point=1}
function hair(x, y, ang, len, pl)
  local nodes = angular_pts(x, y, ang, len, 2, 0.35, 0.08)
  local pts = {}
  for i, nd in ipairs(nodes) do pts[#pts+1] = {nd[1], nd[2], (i==#nodes) and 0.05 or 0.3} end
  if hr:fullness() < 0.4 then hr:reload(pl, 0.6) end
  hr:gesture(pts, {wobble=0.05, ramps={0.02, 0.4}})
end
hr:reload(haze_twig, 0.6)
for i=1,14 do hair(300 + rand(-25,25), 110 + rand(-20, 15), -1.5 + randn(0,0.6), rand(6, 14), haze_twig) end
for _,p in ipairs({0.1,0.2,0.3,0.4,0.5}) do print(p, hr:mark_width(p)) end
