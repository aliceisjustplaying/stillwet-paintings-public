-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
h_dark2  = pile{{"raw umber",1.5},{"bone black",0.8},{"green earth",0.4},{"Prussian blue",0.04}, name="h_dark2"}
hb_main = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.35},{"Prussian blue",0.05}, medium=0.4, name="hb_main"}
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
work(rect(0,0,1000,300), {hand="broad", pile=s_glow, angle=0, ruler=true, coverage=2, fill=true, clip=rect(0,0,1000,300), seed=1})
local m = rect(0,300,1000,414)
work(m, {hand="body", tool="filbert 7", pile=h_dark2, angle=0.03, coverage=2.6, fill=true, clip=m, length={20,55}, seed=171})
wait(10*24*60)
work(m, {hand="body", tool="filbert 9", pile=hb_main, angle=0.02, coverage=2.2, fill=true, clip=m, length={30,80}, seed=172})
print(wait(40*24*60), drying(500,500))

--@ chunk 3
g_near = pile{{"bone black",1.2},{"raw umber",0.9},{"Prussian blue",0.08}, medium=0.7, name="g_near"}
local m = rect(0,300,500,414)
work(m, {hand="glaze", pile=g_near, angle=0.02, coverage=2, fill=true, clip=m, load_at=function(x,y) return clamp((y-440)/220, 0, 1) end, seed=5})
d2 = pile{{"lead white",1.4},{"smalt",1.1},{"cobalt blue",0.7},{"raw umber",0.14}}
cool_t = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.35},{"Prussian blue",0.05},{"lead white",0.35},{"smalt",0.3},{"cobalt blue",0.18}, thinner=0.5, name="cool_t"}
local m2 = rect(500,300,500,60)
work(m2, {hand="body", tool="filbert 7", pile=cool_t, angle=0.02, coverage=1.5, clip=m2, load_at=function(x,y) return clamp(1-(y-300)/60,0,1) end, seed=6})
local m3 = rect(500,380,500,60)
work(m3, {hand="body", tool="filbert 7", pile=cool_t, angle=0.02, coverage=3, fill=true, clip=m3, load_at=function(x,y) return clamp(1-(y-380)/60,0,1) end, seed=7})

--@ chunk 4
trg = brush{kind="rigger", width=1.4, point=1}
tuft_p = pile{{"bone black",1},{"raw umber",0.7},{"green earth",0.25},{"Prussian blue",0.06}, medium=0.2, name="tuft_p"}
function grass_clump(x, y, w, h, lean)
  local n = math.floor(w * 2.2)
  trg:reload(tuft_p, 0.6)
  for i=1,n do
    local t = rand(-1, 1)
    local bx = x + t*w/2
    local hh = h * (1 - 0.7*t*t) * rand(0.5, 1.15)
    local a = -math.pi/2 + lean + randn(0, 0.22) + t*0.25
    local bend = lean*0.6 + randn(0, 0.15)
    if trg:fullness() < 0.4 then trg:reload(tuft_p, 0.6) end
    trg:gesture({{bx, y + 1, 0.42}, {bx + math.cos(a)*hh*0.5, y + 1 + math.sin(a)*hh*0.5, 0.3}, {bx + math.cos(a+bend)*hh, y + 1 + math.sin(a+bend)*hh, 0.03}}, {wobble=0.03, ramps={0.02, 0.5}})
  end
end
local yb = function(x) return 330 + 0.04*(x-500) end
grass_clump(560, yb(560), 14, 7, 0.25)
grass_clump(620, yb(620), 9, 5, 0.3)
grass_clump(700, yb(700), 18, 8, 0.2)
grass_clump(760, yb(760), 6, 4, 0.3)

--@ chunk 5
grass_clump(560, 300, 14, 7, 0.25)
grass_clump(620, 300, 9, 5, 0.3)
grass_clump(700, 300, 18, 8, 0.2)
grass_clump(760, 300, 6, 4, 0.3)

--@ chunk 6
t_twig = pile{{"raw umber",1.2},{"bone black",0.8},{"Prussian blue",0.08},{"red earth",0.05}, medium=0.15, name="t_twig"}
d2 = pile{{"lead white",1.4},{"smalt",1.1},{"cobalt blue",0.7},{"raw umber",0.14}, name="d2"}
haze_twig = mix{{t_twig,0.55},{d2,0.45}, name="haze_twig"}
rg_s = brush{kind="rigger", width=1.6, point=1}
hr = brush{kind="rigger", width=1.0, point=1}
function zigzag(br, x, y, ang, len, p0, pl)
  local n = math.random(3, 5)
  local pts = {{x, y, p0}}
  local a = ang
  local cx, cy = x, y
  local nodes = {}
  local sgn = (math.random() < 0.5) and -1 or 1
  for i=1,n do
    a = ang + sgn*rand(0.25, 0.55) + randn(0, 0.12)
    sgn = -sgn
    local seg = len/n * rand(0.7, 1.3)
    cx, cy = cx + seg*math.cos(a), cy + seg*math.sin(a)
    pts[#pts+1] = {cx, cy, (i==n) and 0.04 or lerp(p0, 0.28, i/n)}
    nodes[#nodes+1] = {cx, cy, a}
  end
  if br:fullness() < 0.4 then br:reload(pl, 0.65) end
  br:gesture(pts, {wobble=0.05, ramps={0.02, 0.35}})
  return nodes
end
function cluster(x, y, ang, size, gens, pl, br)
  br = br or rg_s
  local nodes = zigzag(br, x, y, ang + randn(0, 0.2), size, 0.45, pl)
  if gens <= 0 then return end
  for i, nd in ipairs(nodes) do
    if i < #nodes and math.random() < 0.65 then
      local side = (math.random()<0.5) and -1 or 1
      -- wide, often near-horizontal side shoots
      local sa = nd[3] + side*rand(0.8, 1.4)
      sa = sa + 0.25*((side > 0 and 0 or math.pi) - sa) * 0 
      cluster(nd[1], nd[2], sa, size*rand(0.4, 0.65), gens-1, pl, br)
    end
  end
  local tip = nodes[#nodes]
  if math.random() < 0.7 then cluster(tip[1], tip[2], tip[3] + randn(0, 0.5), size*rand(0.4, 0.6), gens-1, pl, br) end
end
rg_s:reload(t_twig, 0.65)
cluster(100, 200, -1.3, 30, 2, t_twig)
cluster(220, 200, -0.8, 22, 2, t_twig)
cluster(320, 200, -2.0, 26, 1, t_twig)
hr:reload(haze_twig, 0.6)
cluster(450, 200, -1.3, 30, 2, haze_twig, hr)
cluster(560, 200, -1.0, 18, 2, haze_twig, hr)

--@ chunk 7
print(wait(20*24*60), drying(700,600))
g_flat = pile{{"bone black",1.2},{"raw umber",1.0},{"green earth",0.2},{"Prussian blue",0.06}, medium=0.55, name="g_flat"}
local k = knife{width=60}
-- A: firm pressure 0.9, x 500-740
for y=470,690,20 do k:load(g_flat, 1.0); k:lay({{500,y},{620,y+1},{740,y}}, {pressure={0.9,0.9}}); k:wipe() end
-- B: medium pressure 0.6, x 760-1000
for y=470,690,20 do k:load(g_flat, 1.0); k:lay({{760,y},{880,y+1},{1000,y}}, {pressure={0.6,0.6}}); k:wipe() end
print(wait(25*24*60))
