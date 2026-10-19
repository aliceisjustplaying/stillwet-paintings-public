-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
d2 = pile{{"lead white",1.4},{"smalt",1.1},{"cobalt blue",0.7},{"raw umber",0.14}, name="d2"}
s_mid  = pile{{"lead white",3},{"cobalt blue",0.6},{"smalt",0.6},{"Naples yellow",0.2}, name="s_mid"}
local m = rect(0,0,400,300)
work(m, {hand="broad", piles={{d2, function(x,y) return 1-y/300 end},{s_mid, function(x,y) return y/300 end}}, angle=0, ruler=true, coverage=2.4, fill=true, clip=m, seed=5})
for i=1,3 do blend(m, {angle=0, seed=10+i}) end
print(wait(6*24*60))
print(drying(100,100), drying(200,250))

--@ chunk 3
t_dark = pile{{"raw umber",1.3},{"bone black",0.8},{"Prussian blue",0.1},{"red earth",0.1}, name="t_dark"}
t_twig = pile{{"raw umber",1.2},{"bone black",0.8},{"Prussian blue",0.08},{"red earth",0.05}, medium=0.15, name="t_twig"}
rg_s = brush{kind="rigger", width=1.6, point=1}
rd_m = brush{kind="round", width=4, point=1}
function angular_pts(x, y, ang, len, nseg, jit, upb)
  local nodes = {{x, y, ang}}
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
  local nodes = angular_pts(x, y, ang, len, math.random(2, 3), 0.45, 0.1)
  draw_angular(br, nodes, w, pl)
  if depth > 0 then
    local tip = nodes[#nodes]
    local wc = math.max(0.8, w*0.62)
    oak_spray(tip[1], tip[2], tip[3] + randn(0, 0.25), len*rand(0.55, 0.8), wc, depth-1, pl)
    for j=1,math.random(1, 2) do
      local s = (math.random()<0.5) and -1 or 1
      oak_spray(tip[1], tip[2], tip[3] + s*rand(0.5, 1.0), len*rand(0.45, 0.7), wc, depth-1, pl)
    end
  end
end
-- limbs
local limbs = ribbon({{20,250},{80,200},{140,160},{200,120}}, {9,6,4,2}) + ribbon({{200,250},{260,190},{320,150},{380,110}}, {9,6,4,2})
work(limbs:roughen(1,5,3), {hand="detail", pile=t_dark, coverage=2.6, fill=true, seed=21})
rg_s:reload(t_twig, 0.75); rd_m:reload(t_twig, 0.75)
spr = {}
for i=1,6 do
  local x, y = 60 + i*20, 205 - i*14
  if i > 3 then x, y = 200 + (i-3)*45, 230 - (i-3)*30 end
  oak_spray(x, y, -1.2 + randn(0,0.3), rand(11,18), 1.4, 1, t_twig)
end
print(rg_s:mark_width(0.05), rg_s:mark_width(0.1), rg_s:mark_width(0.2), rg_s:mark_width(0.3))
local hr = brush{kind="rigger", width=1.0, point=1}
print(hr:mark_width(0.05), hr:mark_width(0.1), hr:mark_width(0.2), hr:mark_width(0.3))
print(wait(5*24*60))

--@ chunk 4
local variants = {
  {kind="rigger", width=1.6, p={0.4,0.25,0.03}, ramps={0.02,0.5}},
  {kind="rigger", width=1.0, p={0.4,0.25,0.03}, ramps={0.02,0.5}},
  {kind="rigger", width=1.0, p={0.6,0.3,0.0}, ramps={0.02,0.7}},
  {kind="rigger", width=1.6, p={0.25,0.12,0.0}, ramps={0.02,0.7}},
  {kind="round", width=1.2, p={0.5,0.25,0.0}, ramps={0.02,0.6}},
  {kind="rigger", width=1.0, p={0.3,0.15,0.0}, ramps={0.1,0.8}},
}
for i, v in ipairs(variants) do
  local b = brush{kind=v.kind, width=v.width, point=1}
  b:load(t_twig, 0.7)
  local x0 = 20 + i*55
  for j=0,2 do
    local x = x0 + j*14
    local y = 30
    local L = 8 + j*4
    b:gesture({{x, y+L, v.p[1]}, {x+1.5, y+L*0.45, v.p[2]}, {x-0.5, y, v.p[3]}}, {wobble=0.05, ramps=v.ramps})
  end
  -- reverse: tip to base
  for j=0,1 do
    local x = x0 + j*14
    local y = 60
    local L = 10 + j*4
    b:gesture({{x, y, 0.0}, {x+1.5, y+L*0.55, v.p[2]}, {x-0.5, y+L, v.p[1]}}, {wobble=0.05, ramps={0.7, 0.02}})
  end
end

--@ chunk 5
haze_twig = mix{{t_twig,0.55},{d2,0.45}, name="haze_twig"}
local hb = brush{kind="rigger", width=1.6, point=1}
hb:reload(haze_twig, 0.6)
for i=0,7 do
  local x, y = 230 + i*16, 225 - i*11
  hb:gesture({{x-8, y-6, 0.35}, {x, y+1, 0.3}, {x+6, y+9, 0.04}}, {wobble=0.05, ramps={0.02,0.4}})
  hb:gesture({{x+4, y-10, 0.35}, {x+1, y, 0.3}, {x-3, y+8, 0.04}}, {wobble=0.05, ramps={0.02,0.4}})
end
print(wait(5*24*60))

--@ chunk 6
g_tree = pile{{"bone black",1},{"raw umber",1.1},{"Prussian blue",0.07}, medium=0.72, name="g_tree"}
limb2 = ribbon({{200,250},{260,190},{320,150},{380,110}}, {9,6,4,2}):roughen(1,5,3)
local m = limb2:shrink(0.4) * rect(200, 100, 100, 160)
work(m, {hand="glaze", pile=g_tree, coverage=2, fill=true, clip=m, seed=31})
local m2 = limb2:shrink(0.4) * rect(300, 100, 100, 160)
work(m2, {hand="detail", tool={kind="filbert", width=4}, pile=g_tree, coverage=2, fill=true, clip=m2, angle=-0.6, seed=32})

--@ chunk 7
for _, w in ipairs({0.8, 1.0, 1.2, 1.6}) do
  local b = brush{kind="rigger", width=w, point=1}
  local t = {}
  for _, p in ipairs({0.02, 0.1, 0.3, 0.45, 0.6, 0.8, 1.0}) do t[#t+1] = string.format("%.2f", b:mark_width(p)) end
  print("rigger", w, table.concat(t, " "))
end
local r = brush{kind="round", width=1.2, point=1}
local t = {}
for _, p in ipairs({0.02, 0.1, 0.3, 0.45, 0.6, 0.8, 1.0}) do t[#t+1] = string.format("%.2f", r:mark_width(p)) end
print("round 1.2", table.concat(t, " "))

--@ chunk 8
-- forks as on the painting: rigger 1.6, p 0.42 constant then 0.08 at the tip
local b = brush{kind="rigger", width=1.6, point=1}
b:reload(t_twig, 0.75)
forks = {}
for i=0,5 do
  local x, y = 40 + i*30, 270
  -- stem
  local sx, sy = x, y - 10
  b:gesture({{x, y, 0.45}, {x+0.5, y-5, 0.42}, {sx, sy, 0.4}}, {wobble=0.05, ramps={0.02,0.25}})
  local a1, a2 = -math.pi/2 - 0.45, -math.pi/2 + 0.4
  local e1 = {sx + 7*math.cos(a1), sy + 7*math.sin(a1)}
  local e2 = {sx + 6*math.cos(a2), sy + 6*math.sin(a2)}
  b:gesture({{sx, sy, 0.4}, {(sx+e1[1])/2, (sy+e1[2])/2, 0.35}, {e1[1], e1[2], 0.08}}, {wobble=0.05, ramps={0.02,0.25}})
  if b:fullness() < 0.45 then b:reload(t_twig, 0.75) end
  b:gesture({{sx, sy, 0.4}, {(sx+e2[1])/2, (sy+e2[2])/2, 0.35}, {e2[1], e2[2], 0.08}}, {wobble=0.05, ramps={0.02,0.25}})
  forks[#forks+1] = {e1, a1, e2, a2}
end
print(wait(6*24*60))

--@ chunk 9
tb = brush{kind="round", width=1.2, point=1}
tb:reload(t_twig, 0.7)
function seg_pts(pts_in, p0, p1)
  -- pts_in: polyline nodes; pressure falls p0 -> p1 along the length; densified to keep corners
  local L = 0
  for i=2,#pts_in do L = L + math.sqrt((pts_in[i][1]-pts_in[i-1][1])^2 + (pts_in[i][2]-pts_in[i-1][2])^2) end
  local out, acc = {}, 0
  for i=1,#pts_in-1 do
    local a, b = pts_in[i], pts_in[i+1]
    local d = math.sqrt((b[1]-a[1])^2 + (b[2]-a[2])^2)
    local n = math.max(2, math.floor(d/1.5))
    for k=0,n-1 do
      local t = k/n
      local s = (acc + d*t)/L
      out[#out+1] = {lerp(a[1], b[1], t), lerp(a[2], b[2], t), lerp(p0, p1, s^0.8)}
    end
    acc = acc + d
  end
  out[#out+1] = {pts_in[#pts_in][1], pts_in[#pts_in][2], p1}
  return out
end
function tail(x, y, a, len, bend, spur, p0)
  p0 = p0 or 0.55
  local bx, by = x - 1.5*math.cos(a), y - 1.5*math.sin(a)
  local l1 = len * rand(0.35, 0.5)
  local mx, my = x + l1*math.cos(a), y + l1*math.sin(a)
  local a2 = a + bend
  local l2 = len - l1
  local ex, ey = mx + l2*math.cos(a2), my + l2*math.sin(a2)
  if tb:fullness() < 0.4 then tb:reload(t_twig, 0.7) end
  tb:gesture(seg_pts({{bx,by},{x,y},{mx,my},{ex,ey}}, p0, 0.02), {wobble=0.03, ramps={0.02, 0.15}})
  if spur then
    local sa = a + spur
    local sl = rand(3, 5)
    tb:gesture(seg_pts({{mx,my},{mx + sl*math.cos(sa), my + sl*math.sin(sa)}}, 0.45, 0.02), {wobble=0.02, ramps={0.02, 0.2}})
  end
end
local f = forks
-- 1 control
tail(f[2][1][1], f[2][1][2], f[2][2], 9, 0.6)
tail(f[3][3][1], f[3][3][2], f[3][4], 10, -0.5, 1.3)
-- 4: offset 1 unit perpendicular
local a = f[4][2]
tail(f[4][1][1] + math.cos(a+math.pi/2), f[4][1][2] + math.sin(a+math.pi/2), a, 9, 0.6)
-- 5: third shoot from the joint + tail
local sx, sy = 40 + 4*30, 260
tail(sx, sy, -math.pi/2 + 0.05, 8, -0.5, nil, 0.5)
tail(f[5][3][1], f[5][3][2], f[5][4], 7, 0.7)
-- 6: both
tail(f[6][1][1], f[6][1][2], f[6][2], 8, -0.6, -1.2)
tail(f[6][3][1], f[6][3][2], f[6][4], 11, 0.5)

--@ chunk 10
local b = brush{kind="rigger", width=1.6, point=1}
b:reload(t_twig, 0.75)
forks2 = {}
for i=0,5 do
  local x, y = 40 + i*30, 330
  local sx, sy = x, y - 10
  b:gesture({{x, y, 0.45}, {x+0.5, y-5, 0.42}, {sx, sy, 0.4}}, {wobble=0.05, ramps={0.02,0.25}})
  local a1, a2 = -math.pi/2 - 0.45, -math.pi/2 + 0.4
  local e1 = {sx + 7*math.cos(a1), sy + 7*math.sin(a1)}
  local e2 = {sx + 6*math.cos(a2), sy + 6*math.sin(a2)}
  b:gesture({{sx, sy, 0.4}, {(sx+e1[1])/2, (sy+e1[2])/2, 0.35}, {e1[1], e1[2], 0.08}}, {wobble=0.05, ramps={0.02,0.25}})
  if b:fullness() < 0.45 then b:reload(t_twig, 0.75) end
  b:gesture({{sx, sy, 0.4}, {(sx+e2[1])/2, (sy+e2[2])/2, 0.35}, {e2[1], e2[2], 0.08}}, {wobble=0.05, ramps={0.02,0.25}})
  forks2[#forks2+1] = {e1, a1, e2, a2}
end
print(wait(6*24*60))
local f = forks2
tail(f[2][1][1], f[2][1][2], f[2][2], 10, 0.6, nil, 0.75)
tail(f[3][3][1], f[3][3][2], f[3][4], 12, -0.55, 1.3, 0.75)
tail(f[4][1][1], f[4][1][2], f[4][2], 14, 0.7, -1.3, 0.8)
tail(f[4][3][1], f[4][3][2], f[4][4], 6, -0.4, nil, 0.7)
tail(f[5][3][1], f[5][3][2], f[5][4], 9, 0.8, nil, 0.75)
tail(f[6][1][1], f[6][1][2], f[6][2], 8, -0.6, -1.2, 0.75)
tail(f[6][3][1], f[6][3][2], f[6][4], 13, 0.5, 1.2, 0.75)

--@ chunk 11
print(type(math.randomseed), math.random(), rand(0,1))

--@ chunk 12
hb_main = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.35},{"Prussian blue",0.05}, medium=0.4, name="hb_main"}
hb_rim  = pile{{"raw umber",1.3},{"green earth",0.7},{"yellow ochre",0.25},{"bone black",0.45},{"lead white",0.06}, medium=0.4, name="hb_rim"}
local m = rect(400, 400, 560, 280)
work(m, {hand="body", tool="filbert 9", piles={{hb_main, function(x,y) return x < 680 and 1 or 0.02 end},{hb_rim, function(x,y) return x >= 680 and 0.85 or 0.02 end},{hb_main, function(x,y) return x >= 680 and 0.15 or 0 end}}, angle=0.02, coverage=2.2, fill=true, clip=m, length={30,80}, seed=41})
print(wait(20*24*60))
print(drying(500,500), drying(800,600))

--@ chunk 13
g_front = pile{{"bone black",1.2},{"raw umber",0.7},{"Prussian blue",0.12}, medium=0.75, name="g_front"}
g_warm = pile{{"red earth",0.5},{"yellow ochre",0.5},{"raw umber",0.3}, medium=0.85, name="g_warm"}
local core = rect(400, 470, 160, 220)
local soft = core:blur(20) * rect(400,400,280,280)
work(soft, {hand="glaze", pile=g_front, angle=0.02, coverage=1.6, fill=true, clip=soft, seed=51})
local w = rect(700, 400, 260, 140):blur(12) * rect(680,400,280,280)
work(w, {hand="glaze", pile=g_warm, angle=0.4, coverage=1.4, fill=true, clip=w, seed=52})

--@ chunk 14
local m = rect(20, 380, 360, 300)
work(m, {hand="body", tool="filbert 9", pile=hb_main, angle=0.02, coverage=2.2, fill=true, clip=m, length={30,80}, seed=61})
print(wait(20*24*60))
print(drying(100,500))

--@ chunk 15
-- front glaze with load_at feathering (fade up over 45 units from y 420, fade out over 40 units toward x 260)
local m = rect(20, 380, 360, 300)
work(m, {hand="glaze", pile=g_front, angle=0.02, coverage=1.6, fill=true, clip=m,
  load_at=function(x,y) return smoothstep(420, 465, y) * clamp((260 - x)/40, 0, 1) end, seed=71})
-- very weak warm glaze on the right strip x 270-380, top half
g_warm2 = pile{{"red earth",0.12},{"yellow ochre",0.15},{"raw umber",0.5},{"bone black",0.08}, medium=0.9, name="g_warm2"}
local w = rect(270, 380, 110, 150)
work(w, {hand="glaze", pile=g_warm2, angle=0.4, coverage=1.3, fill=true, clip=w, seed=72})

--@ chunk 16
pool_sky = pile{{"lead white",3},{"cobalt blue",0.75},{"smalt",0.85},{"raw umber",0.75},{"Naples yellow",0.3}, name="pool_sky"}
local m = rect(450, 50, 200, 40)
work(m, {hand="detail", tool={kind="flat", width=3}, pile=pool_sky, coverage=3.5, fill=true, angle=0, clip=m, seed=81})
print(wait(20*24*60))
g_pool = pile{{"smalt",0.6},{"raw umber",0.45},{"cobalt blue",0.15},{"bone black",0.05}, medium=0.8, name="g_pool"}
local a = rect(450, 50, 70, 40)
work(a, {hand="detail", tool={kind="filbert", width=3}, pile=g_pool, coverage=2, fill=true, angle=0, clip=a, seed=82})
g_pool2 = pile{{"smalt",0.6},{"raw umber",0.45},{"cobalt blue",0.15},{"bone black",0.05}, medium=0.88, name="g_pool2"}
local b2 = rect(520, 50, 60, 40)
work(b2, {hand="detail", tool={kind="filbert", width=3}, pile=g_pool2, coverage=1.5, fill=true, angle=0, clip=b2, seed=83})

--@ chunk 17
pool_dk = mix{{pool_sky,0.8},{g_pool,0.2}, name="pool_dk"}
pool_dk:add{{"raw umber",0.05}}
print(pool_dk)
local m = rect(590, 50, 50, 40)
work(m, {hand="detail", tool={kind="flat", width=3}, pile=pool_dk, coverage=3.5, fill=true, angle=0, clip=m, seed=84})
