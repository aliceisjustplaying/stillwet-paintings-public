-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{size=600, aspect=4/3, linen={18,16}, seed=4127,
 ground={{pile={{"lead white",6},{"red earth",1},{"raw umber",1}}, um=120, apply="knife", texture=0.3}}}
print(W,H)

--@ chunk 2
draw_p = pile{{"burnt sienna",2},{"ultramarine blue",0.5}, turps=0.6}
local b = brush{kind="round", width=4, point=0.7}
b:load(draw_p, 0.8)
local function L(pts) b:gesture(pts, {wobble=1.5}); if b:fullness()<0.3 then b:load(draw_p,0.8) end end
-- valance bottom (scalloped), top
L({{0,72,0.5},{330,70,0.5},{670,74,0.5}})
local pts={}
for i=0,12 do local x=i*55; pts[#pts+1]={x,118,0.5}; pts[#pts+1]={x+27,128,0.5} end
L(pts)
-- post
L({{648,74,0.6},{650,400,0.6},{652,690,0.6}})
-- wire and bulb
L({{330,118,0.3},{330,150,0.3}})
L({{318,162,0.5},{330,150,0.5},{342,162,0.5},{338,182,0.5},{322,182,0.5},{318,162,0.5}})
-- crates
L({{15,305,0.5},{300,300,0.5},{625,305,0.5}})
L({{0,425,0.6},{360,420,0.6},{640,425,0.6}})
L({{0,592,0.6},{640,592,0.6}})
L({{300,300,0.5},{300,420,0.5}})
L({{360,420,0.5},{360,592,0.5}})
L({{0,690,0.6},{652,690,0.6}})
-- street
L({{652,520,0.4},{1000,505,0.4}})
L({{880,250,0.4},{882,505,0.4}})
L({{700,180,0.4},{700,420,0.4},{860,410,0.4},{860,200,0.4}})

--@ chunk 3
VPX, VPY = 2400, 380
function py(y0, x) return y0 + (VPY - y0) * (x / VPX) end
function band(y0a, y0b, x0, x1)  -- region between two receding lines
  return poly({{x0, py(y0a,x0)}, {x1, py(y0a,x1)}, {x1, py(y0b,x1)}, {x0, py(y0b,x0)}})
end
STALL_X = 662
CORNER_X = 770
-- masks (globals: used later)
m_valance = band(15, 108, -5, 690)
m_interior = band(100, 300, -5, STALL_X)
m_tier1 = band(255, 372, -5, STALL_X)
m_tier2 = band(365, 565, -5, STALL_X)
m_front = band(560, 735, -5, STALL_X+6)
m_facade_up = mask(function(x,y) if x < CORNER_X and y < py(20,x) then return 1 end return 0 end)
m_wall_side = poly({{STALL_X, py(15,STALL_X)}, {CORNER_X, py(-150,CORNER_X)}, {CORNER_X, py(740,CORNER_X)}, {STALL_X, py(740,STALL_X)}})
print(py(15,662), py(108,662), py(565,662), py(735,662), py(-150,770), py(740,770))

--@ chunk 4
night_t = pile{{"Prussian blue",1},{"ultramarine blue",1},{"burnt sienna",1.2},{"bone black",0.3}, turps=0.5, name="night_t"}
skylow_t = pile{{"ultramarine blue",1},{"lead white",1.2},{"permanent alizarin",0.25},{"raw umber",0.4}, turps=0.5, name="skylow_t"}
stalldark_t = pile{{"burnt sienna",2},{"ultramarine blue",1},{"raw umber",1}, turps=0.5, name="stalldark_t"}
glow_t = pile{{"burnt sienna",1},{"raw sienna",1},{"yellow ochre",0.6}, turps=0.5, name="glow_t"}
local sky = rect(CORNER_X-10, 0, 1000-CORNER_X+20, 340)
work(sky, {hand="broad", piles={{night_t, function(x,y) return 1.2 - y/340 end},{skylow_t, function(x,y) return 0.1 + y/300 end}}, angle=0.1, coverage=1.6})

--@ chunk 5
local sky = rect(CORNER_X-10, 0, 1000-CORNER_X+20, 340)
work(sky, {hand="body", tool="flat 16", piles={{night_t, function(x,y) return 1.2 - y/340 end},{skylow_t, function(x,y) return 0.1 + y/300 end}}, angle=0.05, coverage=2.5, length={40,110}, fill=true})

--@ chunk 6
facade_t = mix{{night_t, 0.6},{stalldark_t,0.4}, name="facade_t"}
local up = mask(function(x,y) if x < CORNER_X and y < py(22,x) then return 1 end return 0 end)
local side = poly({{STALL_X-4, py(10,STALL_X)}, {CORNER_X, py(10,CORNER_X)}, {CORNER_X, py(745,CORNER_X)}, {STALL_X-4, py(745,STALL_X)}})
m_facade = up + side
work(m_facade, {hand="body", tool="flat 16", pile=facade_t, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, coverage=2.5, length={40,110}, fill=true, clip=true})

--@ chunk 7
BX, BY = 300, 215
local inter = band(104, 266, -5, STALL_X)
local function near(x,y) local d=math.sqrt((x-BX)^2+((y-BY)*1.4)^2); return math.max(0, 1 - d/300) end
work(inter, {hand="body", tool="flat 14", piles={{glow_t, function(x,y) return 0.05+1.5*near(x,y) end},{stalldark_t, function(x,y) return 1.1 - near(x,y) end}}, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, coverage=2.5, length={30,90}, fill=true, clip=true})

--@ chunk 8
pom_t = pile{{"cadmium red",2},{"permanent alizarin",1}, turps=0.4, name="pom_t"}
lime_t = pile{{"cadmium yellow",2},{"emerald green",1.5},{"viridian",0.3}, turps=0.4, name="lime_t"}
orange_t = pile{{"cadmium yellow",2},{"cadmium red",1}, turps=0.4, name="orange_t"}
lemon_t = pile{{"lemon chrome",3},{"cadmium yellow",0.5}, turps=0.4, name="lemon_t"}
local function near(x,y) local d=math.sqrt((x-BX)^2+((y-BY)*1.1)^2); return math.max(0, 1 - d/480) end
local split1 = 330
local t1 = band(258, 372, -5, STALL_X)
local leftm = mask(function(x,y) return x < split1 + (y-300)*0.15 and 1 or 0 end)
local A = t1 * leftm
local B = t1 - leftm
local dk = function(x,y) return 0.15 + 0.9*(1-near(x,y)) end
work(A, {hand="body", tool="flat 12", piles={{pom_t, function(x,y) return 1 end},{stalldark_t, dk}}, coverage=2.2, length={20,50}, fill=true, clip=true, angle=0.2})
work(B, {hand="body", tool="flat 12", piles={{lime_t, function(x,y) return 1 end},{stalldark_t, dk}}, coverage=2.2, length={20,50}, fill=true, clip=true, angle=-0.2})
local t2 = band(368, 565, -5, STALL_X)
local leftm2 = mask(function(x,y) return x < 400 + (y-450)*0.2 and 1 or 0 end)
work(t2*leftm2, {hand="body", tool="flat 14", piles={{orange_t, function(x,y) return 1 end},{stalldark_t, dk}}, coverage=2.2, length={25,60}, fill=true, clip=true, angle=0.3})
work(t2-leftm2, {hand="body", tool="flat 14", piles={{lemon_t, function(x,y) return 1 end},{stalldark_t, dk}}, coverage=2.2, length={25,60}, fill=true, clip=true, angle=-0.3})

--@ chunk 9
wood_t = pile{{"burnt sienna",1.5},{"bone brown",1},{"ultramarine blue",0.6}, turps=0.4, name="wood_t"}
work(band(560, 738, -5, STALL_X+2), {hand="body", tool="flat 14", pile=wood_t, coverage=2.2, length={30,80}, fill=true, clip=true, angle=function(x,y) return math.atan(VPY-y, VPX-x) end})
work(band(12, 110, -5, STALL_X+28), {hand="body", tool="flat 12", piles={{glow_t,1},{pom_t,0.6}}, coverage=2.2, length={20,40}, fill=true, clip=true, angle=math.pi/2})
farb_t = mix{{night_t,0.5},{skylow_t,0.5}, name="farb_t"}
local farb = poly({{CORNER_X,335},{830,335},{830,300},{905,300},{905,345},{1005,330},{1005,500},{CORNER_X,505}})
work(farb, {hand="body", tool="flat 12", pile=farb_t, coverage=2.2, length={20,50}, fill=true, clip=true, angle=math.pi/2})

--@ chunk 10
m_pave = mask(function(x,y)
  local g
  if x < CORNER_X then g = py(733, x) else g = 498 end
  return y > g and 1 or 0 end)
local function warm(x,y) return math.max(0, 1 - math.abs(x-320)/450) * 0.9 end
work(m_pave, {hand="body", tool="flat 16", piles={{night_t, function(x,y) return 1.1 - warm(x,y) end},{glow_t, warm},{skylow_t, function(x,y) return x>CORNER_X and 0.4 or 0.05 end}}, coverage=2.2, length={40,100}, fill=true, clip=true, angle=0})

--@ chunk 11
print(wait(20*60))
for _,p in ipairs({{100,50},{300,200},{150,320},{200,450},{500,450},{300,650},{700,300},{900,150},{900,650}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 12
print(wait(48*60))
for _,p in ipairs({{100,50},{300,200},{150,320},{200,450},{500,450},{300,650},{700,300},{900,150},{900,650}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 13
print(wait(3*24*60))
for _,p in ipairs({{100,50},{300,200},{150,320},{200,450},{500,450},{300,650},{700,300},{900,150},{900,650}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 14
print(wait(2*24*60))
for _,p in ipairs({{150,320},{200,450},{300,650},{50,300}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 15
sky_top = pile{{"Prussian blue",1},{"ultramarine blue",1.2},{"burnt sienna",0.9},{"bone black",0.2},{"lead white",0.25}, name="sky_top"}
sky_mid = pile{{"ultramarine blue",1.2},{"Prussian blue",0.3},{"lead white",1},{"raw umber",0.5},{"permanent alizarin",0.1}, name="sky_mid"}
sky_low = pile{{"lead white",2},{"ultramarine blue",0.6},{"raw umber",0.6},{"yellow ochre",0.35},{"permanent alizarin",0.1}, name="sky_low"}
m_sky = rect(CORNER_X+2, 0, 240, 345)
local function t(y) return clamp(y/340,0,1) end
work(m_sky, {hand="body", tool="filbert 10", piles={
  {sky_top, function(x,y) return math.max(0, 1 - t(y)*1.6) end},
  {sky_mid, function(x,y) return math.max(0, 1 - math.abs(t(y)-0.6)*2.5) end},
  {sky_low, function(x,y) return math.max(0, (t(y)-0.6)*2.5) end}},
  coverage=3, length={30,80}, angle=function(x,y) return 0.05 + 0.1*math.sin(x/70+y/50) end, fill=true, clip=true})

--@ chunk 16
far_b = pile{{"ultramarine blue",1},{"Prussian blue",0.35},{"burnt sienna",0.8},{"lead white",0.45},{"raw umber",0.3}, name="far_b"}
far_d = pile{{"ultramarine blue",1},{"Prussian blue",0.4},{"burnt sienna",1},{"lead white",0.15},{"bone black",0.15}, name="far_d"}
m_farb = poly({{CORNER_X-2,268},{800,268},{800,255},{808,255},{808,268},{850,272},{850,300},{915,296},{915,280},{935,280},{935,298},{1005,302},{1005,505},{CORNER_X-2,505}})
work(m_farb, {hand="body", tool="flat 8", piles={{far_b, function(x,y) return 0.3 + (x-770)/300 end},{far_d, function(x,y) return 1 - (x-770)/400 end}}, coverage=3, length={15,40}, angle=math.pi/2, fill=true, clip=true})

--@ chunk 17
wall_lit = pile{{"raw sienna",1},{"yellow ochre",1},{"burnt sienna",0.4},{"lead white",0.35}, name="wall_lit"}
wall_mid = pile{{"burnt sienna",1},{"raw umber",0.8},{"yellow ochre",0.3}, name="wall_mid"}
wall_dark = pile{{"raw umber",1},{"ultramarine blue",0.6},{"burnt sienna",0.7}, name="wall_dark"}
function bulbnear(x,y,R) local d=math.sqrt((x-BX)^2+((y-BY)*1.3)^2); return math.max(0, 1 - d/(R or 300)) end
m_backwall = band(146, 266, -5, STALL_X)
work(m_backwall, {hand="body", tool="flat 9", piles={
  {wall_lit, function(x,y) return 2.2*bulbnear(x,y,260)^1.5 end},
  {wall_mid, function(x,y) return 0.2 + bulbnear(x,y,420) end},
  {wall_dark, function(x,y) return math.max(0, 1 - bulbnear(x,y,420)*1.5) end}},
  coverage=2.5, length={25,60}, angle=math.pi/2, angle_jitter=0.1, fill=true, clip=true})

--@ chunk 18
canvas_lit = pile{{"Naples yellow",2},{"lead white",1},{"cadmium yellow",0.3}, name="canvas_lit"}
canvas_mid = pile{{"yellow ochre",1.5},{"raw sienna",0.6},{"lead white",0.5}, name="canvas_mid"}
stripe_red = pile{{"cadmium red",2},{"vermilion",1},{"cadmium yellow",0.3}, name="stripe_red"}
stripe_dk = pile{{"cadmium red",1},{"permanent alizarin",1},{"burnt sienna",0.6}, name="stripe_dk"}
m_under = band(102, 150, -5, STALL_X)
work(m_under, {hand="body", tool="flat 8", piles={
  {canvas_lit, function(x,y) return 2*bulbnear(x,y,280) end},
  {canvas_mid, function(x,y) return 0.3 + 0.8*(1-bulbnear(x,y,280)) end},
  {wall_mid, function(x,y) return math.max(0, 0.8 - bulbnear(x,y,500)*1.6) end}},
  coverage=2.5, length={15,35}, angle=function(x,y) return math.atan(y-380, x+1500) end, fill=true, clip=true})
-- stripes on underside
LVX, LVY = -1500, 380
local sb = brush("flat", 10)
local x = 8
while x < STALL_X do
  local s = 1 - x/VPX
  local w = 34*s
  local y1 = py(102, x)
  local y2 = py(152, x)
  -- direction toward left VP
  local ang = math.atan(LVY - y1, LVX - x)
  local L = (y2 - y1) / math.sin(ang)
  local bri = bulbnear(x, 140, 320)
  sb:reload(bri > 0.25 and stripe_red or stripe_dk, 0.8)
  for k=0,1 do
    local ox = x + k*w*0.35
    sb:stroke({{ox, py(100,ox)}, {ox + math.cos(ang)*L, py(100,ox) + math.sin(ang)*L}}, {pressure=0.8, clip=m_under})
  end
  x = x + w*2
end

--@ chunk 19
val_cream = pile{{"Naples yellow",2},{"lead white",0.6},{"yellow ochre",0.5},{"cadmium yellow",0.3}, name="val_cream"}
val_cream_dk = pile{{"yellow ochre",1.5},{"raw sienna",0.8},{"raw umber",0.4},{"lead white",0.3}, name="val_cream_dk"}
-- scalloped valance mask
local pts = {}
local x = -5
pts[#pts+1] = {-5, py(14,-5)}
pts[#pts+1] = {STALL_X+28, py(14,STALL_X+28)}
local sx = STALL_X+28
local scal = {}
local xx = STALL_X+28
while xx > -40 do
  local s = 1 - xx/VPX
  local w = 52*s
  -- one scallop from xx to xx-w: dip
  for k=0,6 do
    local t = k/6
    local px = xx - w*t
    pts[#pts+1] = {px, py(96,px) + 12*s*math.sin(math.pi*t)}
  end
  xx = xx - w
end
m_valance = poly(pts)
print(m_valance:at(300,100), m_valance:at(300,60), m_valance:at(300,30))
-- base: graded glow
local function vglow(x,y) return math.max(0, 1 - math.abs(x-BX)/420) end
work(m_valance, {hand="body", tool="flat 9", piles={{val_cream, function(x,y) return 0.2+1.5*vglow(x,y) end},{val_cream_dk, function(x,y) return 1.2-vglow(x,y) end}}, coverage=2.5, length={20,50}, angle=math.pi/2, fill=true, clip=true})

--@ chunk 20
local sb = brush("flat", 12)
local x = 4
local i = 0
while x < STALL_X + 24 do
  local s = 1 - x/VPX
  local w = 26*s
  local bri = math.max(0, 1 - math.abs(x-BX)/400)
  local m = mask(function(px,py_) return (px > x and px < x + w) and 1 or 0 end) * m_valance
  work(m, {hand="body", tool={kind="flat", width=w*0.7}, piles={{stripe_red, function() return 0.2 + 1.4*bri end},{stripe_dk, function() return 1.1 - bri end}}, coverage=2.4, length={25,60}, angle=math.pi/2, fill=true, clip=true})
  x = x + 2*w
end

--@ chunk 21
FR = FR or {}
function fruit(x, y, r, P, opts)
  opts = opts or {}
  local sq = opts.sq or 0.95
  local rot = opts.rot or 0
  local I = opts.I or clamp(bulbnear(x, y, 560)*1.25, 0.05, 1)
  local dx, dy = BX - x, BY - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local m
  if rot ~= 0 then
    local pts = {}
    for k=0,23 do local a=k/24*2*math.pi; local ex,ey=math.cos(a)*r, math.sin(a)*r*sq
      pts[#pts+1] = {x + ex*math.cos(rot) - ey*math.sin(rot), y + ex*math.sin(rot) + ey*math.cos(rot)} end
    m = poly(pts, true)
  else m = ellipse(x, y, r, r*sq) end
  m = m:roughen(r*0.05, r*0.8, math.floor(x*7+y*3))
  local function lit(px,py_) local nx,ny=(px-x)/r,(py_-y)/r; return clamp(I*(0.45 + 0.85*(nx*dx+ny*dy)), 0, 1) end
  work(m, {hand="body", tool={kind="filbert", width=math.max(2.5,r*0.32)}, piles={
     {P[1], function(px,py_) return math.max(0, 0.5 - lit(px,py_)) * 3 end},
     {P[2], function(px,py_) return math.max(0.05, 1 - math.abs(lit(px,py_)-0.5)*1.7) end},
     {P[3], function(px,py_) return math.max(0, lit(px,py_)-0.58) * 3.5 end}},
     length={r*0.4, r*0.9}, coverage=2.2, clip=true, fill=true,
     angle=function(px,py_) return math.atan(py_-y, px-x) + math.pi/2 end})
  if P[4] and I > 0.35 then
    local b4 = brush{kind="round", width=math.max(1.8, r*0.17), point=0.6}
    b4:reload(P[4], 0.7)
    local hx, hy = x + dx*r*0.5, y + dy*r*0.5*sq
    b4:stroke({{hx - dy*r*0.09, hy + dx*r*0.09},{hx + dy*r*0.09, hy - dx*r*0.09}}, {pressure={0.65,0.15}})
  end
  FR[#FR+1] = {x=x, y=y, r=r, sq=sq, rot=rot}
end
pm_dark = pile{{"permanent alizarin",1},{"burnt sienna",0.6},{"ultramarine blue",0.3}, name="pm_dark"}
pm_body = pile{{"cadmium red",1.5},{"permanent alizarin",1},{"vermilion",0.5}, name="pm_body"}
pm_lite = pile{{"vermilion",1},{"cadmium red",1},{"orange chrome",0.3},{"lead white",0.25}, name="pm_lite"}
hi_w = pile{{"lead white",3},{"Naples yellow",1}, name="hi_w"}
-- pomegranates tier 1 left: rows back to front
local P = {pm_dark, pm_body, pm_lite, hi_w}
local rows = {{y0=272, r=19},{y0=300, r=21},{y0=330, r=23},{y0=356, r=24}}
for ri, row in ipairs(rows) do
  local x = rand(-10, 10) + (ri%2)*12
  while x < 320 do
    local s = 1 - x/VPX
    local r = row.r * s * rand(0.88, 1.1)
    local y = py(row.y0, x) + rand(-4, 4)
    fruit(x, y, r, P, {sq=rand(0.88,0.98)})
    x = x + r*1.85 + rand(-3,5)
  end
end

--@ chunk 22
gap_dk = pile{{"burnt sienna",1},{"ultramarine blue",1},{"permanent alizarin",0.4},{"bone brown",0.5}, name="gap_dk"}
local fr = nil
for _,f in ipairs(FR) do local e = ellipse(f.x, f.y, f.r*0.97, f.r*f.sq*0.97); fr = fr and (fr + e) or e end
FRUITMASK = fr
local t1a = band(262, 370, -5, 330) 
local gaps = t1a - fr
work(gaps, {hand="detail", pile=gap_dk, coverage=2.5, fill=true, clip=true})

--@ chunk 23
gap_t = pile{{"burnt sienna",1.2},{"ultramarine blue",0.8},{"permanent alizarin",0.2},{"bone brown",0.5}, turps=0.35, name="gap_t"}
T1B = band(262, 370, 330, STALL_X) 
T2 = band(372, 562, -5, STALL_X)
work(T1B + T2, {hand="body", tool="flat 12", pile=gap_t, coverage=2.2, length={20,50}, fill=true, clip=true, angle=0.1})
wait(2*24*60)
print(drying(500,300), drying(200,450), drying(500,450), drying(150,300))

--@ chunk 24
wait(2*24*60)
print(drying(500,300), drying(200,450), drying(500,450), drying(150,300), drying(100,500), drying(600,520))

--@ chunk 25
li_dark = pile{{"viridian",1},{"cadmium yellow",0.6},{"burnt sienna",0.4},{"ultramarine blue",0.2}, name="li_dark"}
li_body = pile{{"cadmium yellow",2},{"emerald green",1.5},{"viridian",0.3}, name="li_body"}
li_lite = pile{{"lemon chrome",2},{"emerald green",1},{"lead white",0.2}, name="li_lite"}
local P = {li_dark, li_body, li_lite, hi_w}
local rows = {{y0=270, r=15},{y0=292, r=16},{y0=314, r=17},{y0=336, r=18},{y0=358, r=19}}
for ri, row in ipairs(rows) do
  local x = 336 + rand(0, 8) + (ri%2)*10
  while x < STALL_X - 8 do
    local s = 1 - x/VPX
    local r = row.r * s * rand(0.88, 1.1)
    local y = py(row.y0, x) + rand(-3, 3)
    fruit(x, y, r, P, {sq=rand(0.85,0.95), rot=rand(-0.4,0.4)})
    x = x + r*1.85 + rand(-2,4)
  end
end

--@ chunk 26
o_dark = pile{{"cadmium red",1},{"burnt sienna",1},{"permanent alizarin",0.3}, name="o_dark"}
o_body = pile{{"cadmium yellow",2},{"cadmium red",1}, name="o_body"}
o_lite = pile{{"cadmium yellow",3},{"orange chrome",1},{"lead white",0.3}, name="o_lite"}
local P = {o_dark, o_body, o_lite, hi_w}
local rows = {{y0=382, r=21},{y0=410, r=23},{y0=440, r=25},{y0=472, r=27},{y0=505, r=29},{y0=538, r=30}}
for ri, row in ipairs(rows) do
  local x = rand(-12, 0) + (ri%2)*14
  local xmax = 400 + (row.y0-450)*0.2
  while x < xmax - 10 do
    local s = 1 - x/VPX
    local r = row.r * s * rand(0.9, 1.08)
    local y = py(row.y0, x) + rand(-4, 4)
    fruit(x, y, r, P, {sq=rand(0.9,0.98)})
    x = x + r*1.85 + rand(-3,5)
  end
end

--@ chunk 27
le_dark = pile{{"raw sienna",1},{"cadmium yellow",1},{"raw umber",0.3}, name="le_dark"}
le_body = pile{{"lemon chrome",3},{"cadmium yellow",0.7}, name="le_body"}
le_lite = pile{{"lemon chrome",2},{"lead white",0.6},{"lead-tin yellow",0.6}, name="le_lite"}
local P = {le_dark, le_body, le_lite, hi_w}
local rows = {{y0=382, r=17},{y0=405, r=18},{y0=430, r=19},{y0=456, r=20},{y0=483, r=21},{y0=511, r=22},{y0=540, r=23}}
for ri, row in ipairs(rows) do
  local xmin = 400 + (row.y0-450)*0.2
  local x = xmin + 8 + rand(0, 8) + (ri%2)*10
  while x < STALL_X - 10 do
    local s = 1 - x/VPX
    local r = row.r * s * rand(0.88, 1.08)
    local y = py(row.y0, x) + rand(-3, 3)
    fruit(x, y, r*1.12, P, {sq=rand(0.72,0.82), rot=rand(-0.5,0.3)})
    x = x + r*2.1 + rand(-2,4)
  end
end

--@ chunk 28
plank_lit = pile{{"burnt sienna",1},{"raw sienna",1},{"yellow ochre",0.4}, name="plank_lit"}
plank_mid = pile{{"burnt sienna",1},{"raw umber",0.8},{"bone brown",0.3}, name="plank_mid"}
plank_dk = pile{{"raw umber",1},{"ultramarine blue",0.7},{"bone brown",0.6},{"burnt sienna",0.4}, name="plank_dk"}
M_COUNTER = band(562, 736, -5, STALL_X+4)
-- planks: vertical boards, light from top
local x = -5
local i = 0
while x < STALL_X do
  local s = 1 - x/VPX
  local w = rand(42, 58)*s
  local x2 = math.min(x + w, STALL_X + 4)
  local m = M_COUNTER * poly({{x+1, 0},{x2-1,0},{x2-1,750},{x+1,750}})
  local top = py(562, x)
  local bot = py(736, x)
  local function lt(px,py_) return clamp(1 - (py_ - top)/(bot-top), 0, 1) * clamp(bulbnear(px, 380, 650)*1.3, 0, 1) end
  work(m, {hand="body", tool={kind="flat", width=w*0.5}, piles={
    {plank_lit, function(px,py_) return 2*lt(px,py_)^1.5 end},
    {plank_mid, function(px,py_) return 0.5 end},
    {plank_dk, function(px,py_) return 1.4*(1-lt(px,py_)) end}},
    coverage=2.4, length={40,90}, angle=math.pi/2 + rand(-0.03,0.03), fill=true, clip=true, mix_jitter=0.1})
  x = x2
  i = i + 1
end
-- seams between planks
local sb = brush{kind="round", width=2, point=0.5}
x = -5
while x < STALL_X do
  local s = 1 - x/VPX
  x = x + rand(42,58)*s
  if x < STALL_X then
    sb:reload(plank_dk, 0.7)
    sb:stroke({{x, py(564,x)},{x+rand(-1,1), py(734,x)}}, {pressure={0.6,0.5}})
  end
end

--@ chunk 29
BX, BY = 430, 215
bldg_dk = pile{{"ultramarine blue",1},{"Prussian blue",0.5},{"burnt sienna",1},{"bone black",0.3},{"lead white",0.12}, name="bldg_dk"}
bldg_mid = pile{{"ultramarine blue",1},{"Prussian blue",0.3},{"burnt sienna",0.8},{"lead white",0.3},{"permanent alizarin",0.1}, name="bldg_mid"}
-- far building masses: two blocks with different rooflines
local A = poly({{CORNER_X-2,250},{842,250},{842,236},{850,236},{850,250},{862,250},{862,505},{CORNER_X-2,505}})
local Bm = poly({{860,292},{906,292},{906,276},{930,276},{930,292},{1005,300},{1005,505},{860,505}})
work(A, {hand="body", tool="flat 8", piles={{bldg_dk,1},{bldg_mid,0.3}}, coverage=2.6, length={15,40}, angle=math.pi/2, fill=true, clip=true})
work(Bm, {hand="body", tool="flat 8", piles={{bldg_dk,0.5},{bldg_mid,0.8}}, coverage=2.6, length={15,40}, angle=math.pi/2, fill=true, clip=true})

--@ chunk 30
win_lit = pile{{"cadmium yellow",1},{"Naples yellow",1},{"orange chrome",0.3},{"lead white",0.3}, name="win_lit"}
win_warm = pile{{"orange chrome",1},{"raw sienna",0.6},{"Naples yellow",0.6}, name="win_warm"}
win_dk = pile{{"ultramarine blue",1},{"bone black",0.5},{"burnt sienna",0.5}, name="win_dk"}
local wins = {
 {785,275,14,22,"L"},{815,275,14,22,"D"},{845,275,10,22,"D"},
 {785,320,14,22,"D"},{815,320,14,22,"W"},{845,320,10,22,"D"},
 {785,365,14,22,"L"},{815,365,14,22,"D"},{845,365,10,22,"D"},
 {785,410,14,22,"D"},{815,410,14,22,"D"},{845,410,10,22,"W"},
 {872,315,9,16,"D"},{892,315,9,16,"L"},{940,318,9,16,"D"},{962,320,9,16,"D"},{984,321,9,16,"W"},
 {872,350,9,16,"W"},{892,350,9,16,"D"},{940,352,9,16,"L"},{962,353,9,16,"D"},{984,354,9,16,"D"},
 {872,385,9,16,"D"},{892,385,9,16,"D"},{940,387,9,16,"D"},{962,388,9,16,"L"},{984,389,9,16,"D"},
}
for _,w in ipairs(wins) do
  local p = (w[5]=="L" and win_lit) or (w[5]=="W" and win_warm) or win_dk
  local m = rect(w[1], w[2], w[3], w[4]):roughen(0.8, 6, math.floor(w[1]+w[2]))
  work(m, {hand="detail", pile=p, coverage=3, fill=true, clip=true, angle=math.pi/2})
end

--@ chunk 31
wait(6*24*60)
for _,p in ipairs({{100,300},{200,450},{500,450},{500,320},{300,650},{800,300},{780,282},{430,240}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 32
wait(5*24*60)
for _,p in ipairs({{100,300},{200,450},{500,450},{500,320},{300,650},{800,300},{780,282},{600,500}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 33
wait(4*24*60)
for _,p in ipairs({{100,300},{200,450},{500,450},{500,320},{600,500},{50,280}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 34
veil = pile{{"burnt sienna",1},{"ultramarine blue",0.5},{"permanent alizarin",0.1}, medium=0.3, thinner=0.6, name="veil"}
local inside = band(146, 562, -5, STALL_X)
local function dmask(lo, hi)
  return mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.8)^2); return (d>=lo and d<hi) and 1 or 0 end):soften(15)
end
local zones = {{200,280,1},{280,360,2},{360,450,3},{450,2000,4}}
for _,z in ipairs(zones) do
  work(inside * dmask(z[1], z[2]), {hand="body", tool={kind="filbert", width=14, stiffness=0.3}, pile=veil, coverage=z[3], length={20,50}, clip=inside, angle=0.15, seed=z[1]})
end

--@ chunk 35
print(wait(3*24*60))
for _,p in ipairs({{100,300},{200,450},{500,450},{600,500},{50,280},{600,300},{30,200}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 36
dglaze = pile{{"burnt sienna",1},{"ultramarine blue",0.5}, medium=0.88, name="dglaze"}
local m = rect(0, 460, 70, 100):soften(10)
work(m, {hand="glaze", pile=dglaze, coverage=2.5, clip=true, angle=0.2, seed=11})

--@ chunk 37
STALLALL = m_valance + band(100, 738, -5, STALL_X+4)
local function zone(lo) return STALLALL * mask(function(x,y) local d = math.sqrt((x-BX)^2 + (y-BY)^2); return d >= lo and 1 or 0 end) end
for i, lo in ipairs({200, 290, 380, 470}) do
  work(zone(lo), {hand="glaze", pile=dglaze, coverage=0.9, clip=STALLALL, angle=0.15 + 0.3*i, seed=30+i})
end

--@ chunk 38
local z = STALLALL * mask(function(x,y) local d = math.sqrt((x-BX)^2 + (y-BY)^2); return d >= 190 and 1 or 0 end)
blend(z, {angle=-0.6})
print(drying(500,450))

--@ chunk 39
for d=1,6 do wait(24*60); print(d, drying(500,450), drying(100,500), drying(300,650), drying(150,120)) end

--@ chunk 40
coat = pile{{"bone black",1},{"ultramarine blue",1},{"burnt sienna",1}, name="coat"}
coat2 = pile{{"bone black",0.6},{"ultramarine blue",1},{"Prussian blue",0.3},{"burnt sienna",0.6},{"lead white",0.2}, name="coat2"}
scarf_dk = pile{{"permanent alizarin",1},{"burnt sienna",0.8},{"ultramarine blue",0.35},{"bone black",0.15}, name="scarf_dk"}
legs_p = pile{{"bone brown",1},{"bone black",0.5},{"burnt sienna",0.4}, name="legs_p"}
FIG_BODY = poly({{526,458},{552,458},{572,466},{583,478},{585,500},{586,560},{591,630},{574,637},{540,639},{506,637},{489,631},{493,560},{495,500},{497,478},{508,466}}, true):roughen(1.2, 25, 7)
FIG_RARM = ribbon({{578,478},{592,505},{598,527}}, {17,15,13}) + ribbon({{598,527},{603,511},{605,500}}, {12,11,9})
FIG_LARM = ribbon({{501,478},{493,520},{490,568},{492,600}}, {17,16,14,12})
FIG_LEGS = ribbon({{525,634},{523,690},{525,722}}, {14,11,9}) + ribbon({{553,634},{556,690},{558,720}}, {13,11,9})
FIG_HEAD = poly({{524,412},{540,406},{554,412},{559,428},{557,445},{550,456},{530,458},{520,446},{518,428}}, true):roughen(0.8, 15, 3)
FIG_KNOT = poly({{533,452},{548,451},{551,466},{541,470},{531,464}}, true)
FIG = FIG_BODY + FIG_RARM + FIG_LARM + FIG_LEGS + FIG_HEAD + FIG_KNOT
work(FIG_BODY + FIG_RARM + FIG_LARM, {hand="body", tool="filbert 7", piles={{coat,1},{coat2,function(x,y) return 0.2 + 0.4*clamp((x-500)/80,0,1) end}}, coverage=2.6, fill=true, clip=true, angle=math.pi/2, angle_jitter=0.15, length={15,40}})
work(FIG_LEGS, {hand="body", tool="filbert 5", pile=legs_p, coverage=2.6, fill=true, clip=true, angle=math.pi/2, length={10,30}})
work(FIG_HEAD + FIG_KNOT, {hand="body", tool="filbert 6", pile=scarf_dk, coverage=2.6, fill=true, clip=true, angle=0.8, length={10,25}})
local sh = brush("filbert", 6)
sh:load(legs_p, 0.8)
sh:touch(523, 726, {pressure=0.8, drag={-6, 1}})
sh:touch(559, 724, {pressure=0.8, drag={6, 1}})

--@ chunk 41
local L2 = ribbon({{525,636},{523,662},{524,690},{525,718}}, {18,20,15,10}) + ribbon({{553,636},{556,662},{557,690},{558,716}}, {17,19,14,10})
work(L2, {hand="body", tool="filbert 5", pile=legs_p, coverage=2.4, fill=true, clip=true, angle=math.pi/2, length={10,30}})
local flare = poly({{493,600},{489,631},{484,638},{506,640},{540,641},{575,640},{596,636},{591,630},{587,600}}, true)
work(flare, {hand="body", tool="filbert 6", piles={{coat,1},{coat2,0.3}}, coverage=2.4, fill=true, clip=true, angle=math.pi/2, length={10,30}})
FIG = FIG + L2 + flare

--@ chunk 42
g1 = pile{{"raw sienna",1},{"yellow ochre",1.2},{"Naples yellow",0.8},{"lead white",0.4}, name="g1"}
g2 = pile{{"Naples yellow",2},{"yellow ochre",0.6},{"lead white",0.8},{"cadmium yellow",0.2}, name="g2"}
g3 = pile{{"Naples yellow",2},{"lead white",1.6},{"cadmium yellow",0.4}, name="g3"}
bulbcore = pile{{"lead white",3},{"Naples yellow",1},{"cadmium yellow",0.2}, name="bulbcore"}
wire = pile{{"bone black",1},{"burnt sienna",0.5}, name="wire"}
local cx, cy = 430, 213
local function dd(x,y) return math.sqrt((x-cx)^2+((y-cy)*1.25)^2) end
local area = m_backwall + m_under
work(ellipse(cx,cy,95,76)*area, {hand="body", tool="filbert 7", piles={
  {wall_lit, function(x,y) return clamp((dd(x,y)-60)/30,0,1)*2 end},
  {g1, function(x,y) local d=dd(x,y); return math.max(0, 1-math.abs(d-60)/32) end},
  {g2, function(x,y) local d=dd(x,y); return math.max(0, 1-math.abs(d-30)/24) end},
  {g3, function(x,y) return math.max(0, 1-dd(x,y)/24)*2 end}},
  coverage=2.0, fill=true, edge="lost", clip=area, pressure={0.3,0.6}, angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end, length={10,24}, seed=4})
local ring = (ellipse(cx,cy,110,88):blur(10) - ellipse(cx,cy,48,38):blur(10)) * area
blend(ring, {angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end})
local w = brush{kind="round", width=1.6, point=0.8}
w:load(wire, 0.6)
w:gesture({{cx-1, 160, 0.5},{cx, 185, 0.5},{cx, cy-11, 0.5}})
local b = brush{kind="round", width=7, point=0.3}
b:load(bulbcore, 1)
b:gesture({{cx, cy-10, 0.6},{cx, cy-2, 1},{cx, cy+5, 0.7}})

--@ chunk 43
local cx, cy = 430, 213
print(drying(430,213), drying(490,240), drying(400,165))
local r = rag{width=18}
local outer = (ellipse(cx,cy,112,90) - ellipse(cx,cy,72,58)):soften(8)
r:wipe(outer * m_backwall, {pressure=0.35, angle=0.3, passes=2, refold=0.4, seed=3})
r:refold()
r:wipe(m_under * ellipse(cx,cy,115,92), {pressure=0.5, angle=-0.25, passes=2, refold=0.3, seed=4})

--@ chunk 44
local cx, cy = 430, 213
local r = rag{width=16}
r:dip(0.6)
r:wipe(m_under * ellipse(cx,cy,118,95), {pressure=0.75, angle=-0.25, passes=3, refold=0.25, seed=5})
r:refold(); r:dip(0.5)
local outer = (ellipse(cx,cy,115,92) - ellipse(cx,cy,68,54)):soften(10) * m_backwall
r:wipe(outer, {pressure=0.6, angle=0.4, passes=2, refold=0.25, seed=6})

--@ chunk 45
local cx, cy = 430, 213
local edgeband = (ellipse(cx,cy,130,104):blur(12) - ellipse(cx,cy,80,64):blur(12)) * m_backwall
blend(edgeband, {angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end})
blend(edgeband, {angle=function(x,y) return math.atan(y-cy,x-cx) end})

--@ chunk 46
hair = pile{{"bone brown",1},{"bone black",0.6},{"burnt sienna",0.5}, name="hair"}
hat = pile{{"permanent alizarin",1},{"cadmium red",0.4},{"burnt sienna",0.6},{"bone black",0.1}, name="hat"}
rim = pile{{"orange chrome",1},{"yellow ochre",1},{"Naples yellow",1}, name="rim"}
-- hair lower head
local hairm = poly({{519,428},{558,428},{557,446},{551,457},{530,459},{520,447}}, true)
work(hairm, {hand="body", tool="filbert 5", pile=hair, coverage=2.6, fill=true, clip=true, angle=math.pi/2, length={8,18}})
-- knitted hat crown, slightly smaller rounded top
local hatm = poly({{521,430},{520,418},{528,409},{540,405},{552,409},{559,419},{558,431}}, true)
work(hatm, {hand="body", tool="filbert 5", pile=hat, coverage=2.6, fill=true, clip=true, angle=0.1, length={8,18}})
-- hat brim fold band
local brim = ribbon({{519,429},{539,432},{559,430}}, {6,6,6})
work(brim, {hand="detail", pile=scarf_dk, coverage=2.5, fill=true, clip=true, angle=0})
-- collar / scarf mass at the neck, wider, rounding the shoulder line
local collar = poly({{520,452},{560,452},{570,466},{548,474},{530,474},{510,467}}, true)
work(collar, {hand="body", tool="filbert 5", pile=coat, coverage=2.6, fill=true, clip=true, angle=0, length={8,20}})

--@ chunk 47
coat_cool = pile{{"ultramarine blue",1},{"Prussian blue",0.2},{"lead white",0.45},{"bone black",0.3},{"burnt sienna",0.3}, name="coat_cool"}
local b = brush{kind="filbert", width=4, stiffness=0.5}
local folds = {
 {{548,480,0.2},{552,540,0.5},{556,600,0.3}},
 {{566,500,0.2},{571,560,0.5},{575,625,0.3}},
 {{528,500,0.15},{525,560,0.35},{522,620,0.2}},
 {{580,485,0.3},{584,510,0.4}},
}
for _,f in ipairs(folds) do b:reload(coat_cool, 0.35); b:gesture(f, {wobble=1}) end
-- darker shadows: under the raised arm and between legs at hem
local d = brush{kind="filbert", width=5}
d:reload(coat, 0.6)
d:gesture({{576,512,0.5},{574,545,0.4}}, {wobble=0.5})
blend(FIG_BODY:shrink(3), {angle=math.pi/2})

--@ chunk 48
boot = pile{{"bone black",1},{"bone brown",0.5},{"ultramarine blue",0.2}, name="boot"}
local bl = poly({{516,694},{531,694},{532,722},{536,728},{512,729},{515,716}}, true)
local br = poly({{550,692},{564,692},{565,718},{570,726},{548,727},{549,712}}, true)
work(bl+br, {hand="body", tool="filbert 4", pile=boot, coverage=2.6, fill=true, clip=true, angle=math.pi/2, length={8,16}})
-- trouser tops slightly wider just under the hem
local tr = poly({{511,636},{536,636},{534,660},{514,660}}, true) + poly({{546,636},{570,636},{566,660},{548,660}}, true)
work(tr, {hand="body", tool="filbert 4", pile=legs_p, coverage=2.4, fill=true, clip=true, angle=math.pi/2, length={8,20}})
-- string bag of oranges hanging from left hand
local bagm = poly({{478,604},{500,604},{508,622},{504,646},{490,652},{475,645},{471,624}}, true)
local P = {o_dark, o_body, o_lite, nil}
for _,o in ipairs({{482,620,7},{496,618,7},{489,633,7.5},{479,638,6.5},{500,636,6.5}}) do
  fruit(o[1], o[2], o[3], P, {I=0.45})
end
local s = brush{kind="round", width=1, point=0.8}
s:load(boot, 0.5)
for _,ln in ipairs({{{491,600},{474,628},{484,650}},{{493,600},{506,628},{497,650}},{{490,600},{489,650}},{{474,626},{507,626}},{{475,640},{505,640}}}) do
  local pts = {}; for _,p in ipairs(ln) do pts[#pts+1] = {p[1], p[2], 0.4} end
  s:gesture(pts, {wobble=0.6})
end

--@ chunk 49
wait(24*60)
print(drying(540,520), drying(538,415), drying(430,213))
local b = brush{kind="round", width=3, point=0.7, lay=2}
local function G(pts, p) b:reload(rim, 0.8); b:gesture(pts, {wobble=0.4}) end
-- hat crown top-left
G({{522,425,0.2},{523,414,0.5},{531,407,0.6},{542,405,0.3}})
-- left shoulder top & left coat edge
G({{528,468,0.2},{512,469,0.5},{500,478,0.6},{497,495,0.3}})
G({{497,500,0.3},{494,540,0.4},{492,575,0.15}})
-- right shoulder top (less) and raised forearm top
b = brush{kind="round", width=2.2, point=0.7, lay=1.5}
G({{555,467,0.15},{570,468,0.35},{580,477,0.2}})
G({{592,503,0.15},{599,512,0.3},{603,500,0.3},{605,493,0.1}})

--@ chunk 50
local b = brush{kind="filbert", width=6}
for _,f in ipairs({{{512,470,0.6},{500,480,0.7},{497,500,0.7},{494,540,0.7},{492,575,0.6}}, {{555,468,0.6},{570,470,0.6},{580,479,0.6}}, {{592,503,0.6},{599,512,0.6},{603,500,0.5}}}) do
  b:reload(coat, 0.8); b:gesture(f, {wobble=0.3})
end
-- edge facing up-left toward bulb
local cx, cy = 430, 213
local outline_rim = FIG:rim(3, 1)
local facing = mask(function(x,y)
  local dx, dy = cx-x, cy-y
  return 1 end)
local edge = outline_rim - FIG:shrink(2.5)
local left = mask(function(x,y) return (x < 545 or y < 475) and 1 or 0 end)
print(edge:area(), (edge*left):area())

--@ chunk 51
local E = FIG - FIG:shrink(2.5)
local top = E * mask(function(x,y) return (y < 485 and x < 585) and 1 or 0 end)
local side = E * mask(function(x,y) return (y >= 485 and y < 600 and x < 520) and 1 or 0 end)
local arm = E * mask(function(x,y) return (x > 588 and y < 515 and y > 488) and 1 or 0 end)
work(top, {hand="detail", pile=rim, coverage=2, clip=true, angle=0})
work(side, {hand="detail", pile=rim, coverage=0.9, clip=true, angle=math.pi/2})
work(arm, {hand="detail", pile=rim, coverage=1.2, clip=true, angle=math.pi/2})

--@ chunk 52
local E = FIG - FIG:shrink(3.5)
local hatR = E * mask(function(x,y) return (x > 543 and y < 462) and 1 or 0 end)
work(hatR, {hand="detail", pile=hat, coverage=2.2, clip=true})
local shR = E * mask(function(x,y) return (x > 556 and x < 590 and y < 485 and y > 460) and 1 or 0 end)
work(shR, {hand="detail", pile=coat, coverage=2.2, clip=true})
blend(FIG_BODY:shrink(5) + FIG_LARM:shrink(5), {angle=math.pi/2})
blend(FIG_BODY:shrink(5), {angle=0.2})

--@ chunk 53
nglaze = pile{{"ultramarine blue",1},{"burnt sienna",0.7},{"permanent alizarin",0.15}, medium=0.85, name="nglaze"}
local keep = FIG:grow(4) + ellipse(430,213,135,108)
local V = m_valance - keep
local function zone(lo) return V * mask(function(x,y) return math.abs(x-430) >= lo and 1 or 0 end) end
work(V, {hand="glaze", pile=nglaze, coverage=1.0, clip=V, angle=math.pi/2, seed=51})
for i, lo in ipairs({90, 200, 320}) do
  work(zone(lo), {hand="glaze", pile=nglaze, coverage=0.9, clip=V, angle=math.pi/2 + 0.2*i, seed=60+i})
end
local Fa = m_facade - keep
work(Fa, {hand="glaze", pile=nglaze, coverage=1.6, clip=Fa, angle=0.1, seed=70})

--@ chunk 54
local keep = FIG:grow(4) + ellipse(430,213,135,108)
local V = m_valance - keep
blend(V, {angle=math.pi/2})
blend(V, {angle=0})
blend(m_facade - keep, {angle=0.1})
blend(m_facade - keep, {angle=math.pi/2})

--@ chunk 55
for d=1,8 do wait(24*60); print(d, drying(540,540), drying(430,213), drying(300,60), drying(700,200), drying(530,700)) end

--@ chunk 56
LEMR = (T2 * mask(function(x,y) return x >= 398 + (y-450)*0.2 and 1 or 0 end)) - FIG:grow(1.5)
gap_body = pile{{"burnt sienna",1.2},{"ultramarine blue",0.8},{"bone brown",0.5},{"raw umber",0.3}, name="gap_body"}
work(LEMR, {hand="body", tool="flat 10", pile=gap_body, coverage=2.6, fill=true, clip=true, angle=0.1, length={20,50}})
print(drying(620,450))

--@ chunk 57
for d=1,6 do wait(24*60); print(d, drying(620,450), drying(450,500), drying(560,400)) end

--@ chunk 58
wait(2*24*60); print(drying(620,450), drying(560,400), drying(640,540))

--@ chunk 59
le2_dark = pile{{"raw sienna",1},{"cadmium yellow",1},{"raw umber",0.4},{"ultramarine blue",0.05}, medium=0.12, name="le2_dark"}
le2_body = pile{{"lemon chrome",3},{"cadmium yellow",0.7}, medium=0.12, name="le2_body"}
le2_lite = pile{{"lemon chrome",2},{"lead white",0.6},{"lead-tin yellow",0.6}, medium=0.1, name="le2_lite"}
function lemon(x, y, r, P, opts)
  opts = opts or {}
  local rot = opts.rot or 0
  local sq = opts.sq or 0.78
  local I = opts.I or clamp(bulbnear(x, y, 520)*1.3, 0.28, 1)
  local ca, sa = math.cos(rot), math.sin(rot)
  local pts = {}
  for k=0,47 do
    local a = k/48*2*math.pi
    local c = math.cos(a)
    local rr = 1 + 0.13*math.abs(c)^24
    local ex, ey = c*r*rr, math.sin(a)*r*sq
    pts[#pts+1] = {x + ex*ca - ey*sa, y + ex*sa + ey*ca}
  end
  local m = poly(pts, true)
  if opts.cut then m = m - opts.cut end
  local dx, dy = BX - x, BY - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local function lit(px,py_) local nx,ny=(px-x)/r,(py_-y)/(r*sq); return clamp(I*(0.35 + 1.0*(nx*dx+ny*dy)), 0, 1) end
  work(m, {hand="body", tool={kind="filbert", width=math.max(2.5,r*0.3)}, piles={
     {P[1], function(px,py_) return math.max(0, 0.55 - lit(px,py_)) * 4 end},
     {P[2], function(px,py_) return math.max(0.05, 1 - math.abs(lit(px,py_)-0.55)*2) end},
     {P[3], function(px,py_) return math.max(0, lit(px,py_)-0.6) * 4 end}},
     length={r*0.5, r*1.2}, coverage=2.2, clip=true, fill=true,
     angle=function(px,py_) local u = ((px-x)*ca + (py_-y)*sa)/r; local v = (-(px-x)*sa + (py_-y)*ca)/(r*sq); return rot + 0.5*u*v end})
  if P[4] and I > 0.45 then
    local b4 = brush{kind="round", width=math.max(1.6, r*0.14), point=0.6}
    b4:reload(P[4], 0.6)
    local hx, hy = x + dx*r*0.45, y + dy*r*0.4*sq
    if not (opts.cut and opts.cut:at(hx,hy) > 0.3) then
      b4:stroke({{hx - ca*r*0.15, hy - sa*r*0.15},{hx + ca*r*0.15, hy + sa*r*0.15}}, {pressure={0.5,0.1}})
    end
  end
  return m
end
FIGCUT = FIG:grow(1.5)
local P = {le2_dark, le2_body, le2_lite, hi_w}
local rows = {{y0=378, r=17},{y0=398, r=18},{y0=420, r=19},{y0=444, r=20},{y0=468, r=21},{y0=494, r=22},{y0=520, r=23},{y0=545, r=24}}
local n = 0
for ri, row in ipairs(rows) do
  local xmin = 398 + (row.y0-450)*0.2
  local x = xmin + rand(-6, 10)
  while x < STALL_X - 6 do
    local s = 1 - x/VPX
    local r = row.r * s * rand(0.88, 1.1)
    -- back rows: lumpy top (skip some at the edges)
    local skip = (ri <= 2) and (rand(0,1) < 0.25)
    if not skip then
      local y = py(row.y0, x) + rand(-5, 5)
      lemon(x, y, r, P, {rot=rand(-0.7, 0.7) + ((rand(0,1) < 0.15) and 1.4 or 0), sq=rand(0.72,0.84), cut=FIGCUT})
      n = n + 1
    end
    x = x + r*rand(1.65, 2.05)
  end
end
print(n)

--@ chunk 60
local k = knife{width=30}
for i=0,3 do
  local y = 520 + i*12
  k:scrape({{600, y},{655, y-1}}, {pressure=1, angle=math.pi/2})
  k:wipe()
end

--@ chunk 61
flank = pile{{"Prussian blue",1},{"ultramarine blue",0.6},{"burnt sienna",1.5},{"bone black",0.35},{"lead white",0.15}, name="flank"}
flank_lt = pile{{"Prussian blue",0.6},{"ultramarine blue",0.8},{"burnt sienna",1},{"lead white",0.5},{"raw umber",0.3}, name="flank_lt"}
local side = m_wall_side * mask(function(x,y) return y < py(733,x)+2 and 1 or 0 end)
work(side, {hand="body", tool="flat 12", piles={{flank,1},{flank_lt,function(x,y) return 0.15 + 0.35*clamp((y-200)/400,0,1) end}}, coverage=2.6, fill=true, clip=true, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, length={30,80}})
-- upper facade band above awning too
local up = m_facade - m_wall_side
work(up, {hand="body", tool="flat 12", pile=flank, coverage=2.4, fill=true, clip=true, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, length={40,100}})

--@ chunk 62
for d=1,12 do wait(24*60) end
for _,p in ipairs({{450,500},{620,450},{700,300},{663,420},{540,520},{430,213},{530,700},{100,400}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 63
wait(3*24*60); print(drying(450,500), drying(420,520), drying(480,470))

--@ chunk 64
olv = pile{{"raw sienna",1},{"cadmium yellow",0.8},{"raw umber",0.5},{"viridian",0.08}, name="olv"}
olv2 = pile{{"raw sienna",1},{"cadmium yellow",0.5},{"raw umber",0.8},{"viridian",0.1},{"burnt sienna",0.2}, name="olv2"}
function coreshadow2(x, y, r, sq, rot, pile, load, inset, wf)
  local dx, dy = BX - x, BY - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local base = math.atan(-dy, -dx)
  local ca, sa = math.cos(rot), math.sin(rot)
  local pts = {}
  for k=-3,3 do
    local la = base + k*0.45 - rot
    local ex, ey = math.cos(la)*r*inset, math.sin(la)*r*sq*inset
    pts[#pts+1] = {x + ex*ca - ey*sa, y + ex*sa + ey*ca, math.max(0.05, 0.8 - math.abs(k)*0.22)}
  end
  local b = brush{kind="filbert", width=r*wf, stiffness=0.35}
  b:load(pile, load)
  b:gesture(pts, {wobble=0.3, clip=-FIGCUT})
end
local L = {
 {395,380},{440,378},{500,380},{405,400},{450,400},{505,400},{395,425},{430,415},{475,425},
 {400,445},{440,452},{510,440},{400,480},{445,478},{490,478},{400,510},{445,513},{490,503},
 {545,385},{590,385},{630,378},{655,388},{570,415},{605,410},{645,410},{590,445},{635,440},
 {600,465},{650,458},{620,490},{650,482},{610,515}}
for _,p in ipairs(L) do
  local far = clamp((math.abs(p[1]-BX) + (p[2]-BY)*0.5)/280, 0, 1)
  local pl = far > 0.6 and olv2 or olv
  coreshadow2(p[1], p[2], 20, 0.78, 0, pl, 0.35 + 0.25*far, 0.7, 0.5)
end

--@ chunk 65
local r = rag{width=16}
r:dip(0.7)
local area = LEMR + rect(380,360,290,60)*T1B:grow(0) 
area = (rect(375,365,295,185) - FIGCUT)
r:wipe(area, {pressure=0.75, angle=0.1, passes=3, refold=0.2, seed=9})
r:refold(); r:dip(0.6)
r:wipe(area, {pressure=0.8, angle=1.4, passes=2, refold=0.2, seed=10})

--@ chunk 66
local edge = m_wall_side * rect(658, 360, 30, 200)
work(edge, {hand="body", tool="flat 6", piles={{flank,1},{flank_lt,0.3}}, coverage=2.6, fill=true, clip=true, angle=math.pi/2, length={20,50}})
-- windows: over dry building
win_lit2 = pile{{"cadmium yellow",1},{"Naples yellow",1.2},{"orange chrome",0.35},{"lead white",0.4}, name="win_lit2"}
win_warm2 = pile{{"orange chrome",1},{"cadmium red",0.15},{"Naples yellow",0.8},{"raw sienna",0.3}, name="win_warm2"}
local wins = {
 {785,275,14,22,"L"},{815,320,14,22,"W"},{785,365,14,22,"L"},{845,410,10,22,"W"},
 {892,315,9,16,"L"},{984,321,9,16,"W"},{872,350,9,16,"W"},{940,352,9,16,"L"},{962,388,9,16,"L"},
}
for _,w in ipairs(wins) do
  local p = (w[5]=="L" and win_lit2) or win_warm2
  local m = rect(w[1]+1, w[2]+1, w[3]-2, w[4]-2)
  work(m, {hand="body", tool={kind="flat", width=w[3]*0.5}, pile=p, coverage=2.6, fill=true, clip=true, angle=math.pi/2, length={w[4]*0.6, w[4]}})
end

--@ chunk 67
local z = m_wall_side * rect(655, 340, 60, 240)
blend(z, {angle=math.pi/2})
blend(z, {angle=0})
work(m_wall_side * rect(660, 340, 50, 240):soften(12), {hand="scumble", tool="filbert 9", pile=flank, coverage=1.2, clip=m_wall_side, angle=math.pi/2, seed=4})

--@ chunk 68
local side = m_wall_side * mask(function(x,y) return y < py(733,x)+2 and 1 or 0 end)
work(side, {hand="body", tool="flat 12", piles={{flank,1},{flank_lt,function(x,y) return 0.25 + 0.35*clamp((y-200)/400,0,1) end}}, coverage=3, fill=true, clip=true, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, length={40,100}, seed=77})
blend(side:shrink(2), {angle=function(x,y) return math.atan(VPY-y, VPX-x) end})

--@ chunk 69
road_dk = pile{{"ultramarine blue",1},{"burnt sienna",0.9},{"bone black",0.3},{"lead white",0.25},{"Prussian blue",0.2}, name="road_dk"}
road_lt = pile{{"ultramarine blue",1},{"lead white",1.1},{"raw umber",0.4},{"Prussian blue",0.15}, name="road_lt"}
pave_p = pile{{"ultramarine blue",1},{"lead white",0.7},{"raw umber",0.5},{"burnt sienna",0.3}, name="pave_p"}
lampref = pile{{"lead white",2},{"Naples yellow",0.5},{"cerulean blue",0.15}, name="lampref"}
winref = pile{{"orange chrome",1},{"Naples yellow",0.6},{"raw sienna",0.4}, name="winref"}
local ground = m_pave * rect(CORNER_X-1, 495, 240, 260)
local far_pave = ground * rect(CORNER_X-1, 495, 240, 43)
local road = ground - far_pave
work(far_pave, {hand="body", tool="flat 8", piles={{pave_p,1},{road_dk,0.5}}, coverage=2.6, fill=true, clip=true, angle=0, length={30,70}})
work(road, {hand="body", tool="flat 12", piles={{road_dk,1},{road_lt,function(x,y) return 0.6*clamp(1-(y-540)/140,0,1) end}}, coverage=2.6, fill=true, clip=true, angle=0, length={40,110}})
-- kerb edge: light line
local kb = brush{kind="flat", width=3}
kb:load(road_lt, 0.6)
kb:stroke({{CORNER_X, 539},{1000, 537}}, {pressure=0.6})
-- window reflections
local b = brush{kind="flat", width=5, stiffness=0.5}
for _,wx in ipairs({792, 822, 851, 897, 945, 967, 989}) do
  for i=1,4 do
    b:reload(winref, 0.45)
    local y0 = 550 + i*13 + rand(-2,2)
    b:stroke({{wx+rand(-1,1), y0},{wx+rand(-2,2), y0+rand(6,9)}}, {pressure={0.45,0.15}, clip=road})
  end
end
-- lamp reflection
for i=1,11 do
  b:reload(lampref, 0.5)
  local y0 = 548 + i*15 + rand(-3,3)
  b:stroke({{898+rand(-2,2), y0},{898+rand(-3,3), y0+rand(8,14)}}, {pressure={0.75 - i*0.04,0.25}, clip=road})
end
blend(road * rect(880, 545, 36, 210), {angle=math.pi/2})

--@ chunk 70
local road = m_pave * rect(CORNER_X-1, 538, 240, 220)
for _,wx in ipairs({792, 822, 851, 945, 967, 989}) do
  local m = road * rect(wx-6, 548, 12, 70+rand(0,25))
  blend(m:soften(3), {angle=math.pi/2})
end
blend(road * rect(860, 545, 76, 210):soften(10), {angle=0})
blend(road * rect(860, 545, 76, 210):soften(10), {angle=math.pi/2})

--@ chunk 71
post_p = pile{{"bone black",1},{"ultramarine blue",0.8},{"burnt sienna",0.4},{"lead white",0.1}, name="post_p"}
lamp_glass = pile{{"lead white",3},{"Naples yellow",0.6},{"cerulean blue",0.1}, name="lamp_glass"}
lamp_halo = pile{{"lead white",1},{"ultramarine blue",0.25},{"Naples yellow",0.3},{"raw umber",0.1}, name="lamp_halo"}
local b = brush{kind="round", width=3, point=0.3}
b:load(post_p, 0.9)
b:gesture({{905,540,0.9},{905,480,0.75},{904,432,0.6}}, {wobble=0.3})
b:reload(post_p, 0.7)
b:gesture({{904,433,0.5},{899,427,0.5},{892,428,0.45}}, {wobble=0.2})
-- base flare
b:reload(post_p, 0.7)
b:gesture({{901,541,0.7},{909,541,0.7}})
-- small soft halo by hand: a few short light circular dabs, thin
local h = brush{kind="filbert", width=9, stiffness=0.2}
for i=1,8 do
  local a = i/8*2*math.pi
  h:reload(lamp_halo, 0.18)
  h:stroke({{892+math.cos(a)*4, 434+math.sin(a)*4},{892+math.cos(a)*14, 434+math.sin(a)*12}}, {pressure={0.45,0.0}, ramps={0.1,0.8}})
end
local g = brush{kind="round", width=4, point=0.3}
g:load(lamp_glass, 1)
g:gesture({{890,431,0.7},{892,435,1},{894,438,0.6}})

--@ chunk 72
blend(ellipse(892,434,16,14), {angle=0.5})
blend(ellipse(892,434,16,14), {angle=2.0})
local b = brush{kind="filbert", width=3.5, stiffness=0.6}
b:load(post_p, 1)
b:stroke({{905,445},{905,500},{905,541}}, {pressure=0.85})
local g = brush{kind="round", width=4, point=0.3}
g:load(lamp_glass, 1)
g:gesture({{891,432,0.7},{892,435,1},{893,438,0.6}})

--@ chunk 73
local r = rag{width=8}
r:dip(0.7)
r:wipe(ellipse(892,434,20,18), {pressure=0.8, passes=3, refold=0.2, seed=2})
r:refold(); r:dip(0.6)
r:wipe(ellipse(892,434,20,18), {pressure=0.8, passes=2, angle=1.2, refold=0.2, seed=3})

--@ chunk 74
local b = brush{kind="round", width=2.2, point=0.4}
b:load(post_p, 0.9)
b:gesture({{905,446,0.6},{905,432,0.6},{900,426,0.55},{893,426,0.5}}, {wobble=0.15})
local hood = poly({{886,431},{892,425},{898,431}})
work(hood, {hand="detail", pile=post_p, coverage=2.5, fill=true, clip=true})
local g = brush{kind="round", width=4, point=0.3}
g:load(lamp_glass, 1)
g:gesture({{889,434,0.7},{892,435,1},{895,434,0.7}})

--@ chunk 75
wait(8*24*60)
for _,p in ipairs({{900,600},{800,520},{700,700},{300,720},{540,700},{450,500},{620,450},{900,435}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 76
wetwarm = pile{{"burnt sienna",1},{"raw umber",0.6},{"ultramarine blue",0.6},{"yellow ochre",0.2}, name="wetwarm"}
NG = m_pave * mask(function(x,y) return (x < CORNER_X or y > 628) and 1 or 0 end)
local function nearstall(x,y) return clamp(1 - (x-0)/760, 0, 1) * clamp(1 - (y - 640)/140, 0.2, 1) end
work(NG, {hand="body", tool="flat 14", piles={
  {road_dk, function(x,y) return 0.6 + 0.6*(1-nearstall(x,y)) end},
  {wetwarm, function(x,y) return 1.4*nearstall(x,y) end},
  {road_lt, function(x,y) return x > 700 and 0.35 or 0.05 end}},
  coverage=2.6, fill=true, clip=true, angle=0, angle_jitter=0.05, length={50,120}, seed=81})
-- counter reflection: vertical drags of plank colour just under counter base
local b = brush{kind="flat", width=7, stiffness=0.5}
local x = 5
while x < STALL_X - 5 do
  local top = py(733, x) + 2
  b:reload((rand(0,1) < 0.5) and plank_mid or wetwarm, 0.35)
  b:stroke({{x, top},{x + rand(-1,1), top + rand(14, 30)}}, {pressure={0.6,0.1}, clip=NG})
  x = x + rand(14, 26)
end
-- figure reflection under boots
local fb = brush{kind="flat", width=8, stiffness=0.5}
for _,bx in ipairs({523, 558}) do
  fb:reload(boot, 0.45)
  fb:stroke({{bx, 729},{bx+rand(-1,1), 749}}, {pressure={0.7,0.2}, clip=NG})
end
blend(NG * rect(0, 600, CORNER_X, 150), {angle=math.pi/2})

--@ chunk 77
local r = rag{width=7}
local legs = {{{524,650},{523,690},{524,728}}, {{555,650},{557,690},{559,726}}}
for _,lg in ipairs(legs) do
  for k=1,4 do r:dip(0.7); r:wipe(lg, {pressure={0.85,0.85}}); r:refold() end
end
print(drying(524,690), drying(400,700))

--@ chunk 78
spill = pile{{"burnt sienna",1},{"raw sienna",0.8},{"yellow ochre",0.4},{"ultramarine blue",0.25}, name="spill"}
local function sp(x,y)
  local top = py(733, x)
  local t = clamp(1 - (y - top)/90, 0, 1)
  local h = clamp(1 - math.abs(x - 330)/420, 0, 1)
  return t*h
end
local zone = NG * mask(function(x,y) return sp(x,y) > 0.05 and 1 or 0 end)
work(zone, {hand="scumble", tool="filbert 12", piles={{spill, function(x,y) return 2*sp(x,y) end},{wetwarm, function(x,y) return 0.6 end},{road_dk, function(x,y) return 1 - sp(x,y) end}}, coverage=1.8, clip=NG, angle=0, length={30,70}, seed=91})
blend(NG * rect(0, 600, 760, 150), {angle=0})
blend(NG * rect(0, 600, 760, 150), {angle=math.pi/2})

--@ chunk 79
for d=1,10 do wait(24*60); if d%2==0 then print(d, drying(530,700), drying(300,720), drying(900,700)) end end

--@ chunk 80
local L2 = ribbon({{525,640},{523,662},{524,690},{525,716}}, {18,20,15,10}) + ribbon({{553,640},{556,662},{557,690},{558,714}}, {17,19,14,10})
work(L2, {hand="body", tool="filbert 5", pile=legs_p, coverage=2.6, fill=true, clip=true, angle=math.pi/2, length={10,30}})
local bl = poly({{516,710},{531,710},{532,722},{537,729},{511,730},{514,718}}, true)
local br = poly({{550,708},{564,708},{565,718},{571,727},{548,728},{549,714}}, true)
work(bl+br, {hand="body", tool="filbert 4", pile=boot, coverage=2.6, fill=true, clip=true, angle=math.pi/2, length={8,16}})
-- cast shadow toward viewer, slightly right
shadow_p = pile{{"ultramarine blue",1},{"burnt sienna",0.8},{"bone black",0.3}, medium=0.5, name="shadow_p"}
local sh = poly({{510,729},{572,727},{600,750},{535,750}}, true):soften(4)
work(sh, {hand="body", tool={kind="filbert", width=10, stiffness=0.3}, pile=shadow_p, coverage=1.4, clip=true, angle=1.2, length={15,30}})
FIG = FIG + L2 + bl + br

--@ chunk 81
legs_dk = pile{{"bone black",1},{"bone brown",0.6},{"ultramarine blue",0.4},{"burnt sienna",0.2}, name="legs_dk"}
local L2 = ribbon({{525,640},{523,662},{524,690},{525,716}}, {17,19,14,9}) + ribbon({{553,640},{556,662},{557,690},{558,714}}, {16,18,13,9})
work(L2, {hand="body", tool="filbert 5", pile=legs_dk, coverage=2.4, clip=true, angle=math.pi/2, length={15,35}})
-- slight warm edge on left of each leg (light from stall behind-left)
local b = brush{kind="round", width=1.5, point=0.7}
b:load(rim, 0.4)
b:gesture({{516,650,0.2},{515,675,0.35},{518,700,0.15}}, {wobble=0.2})
b:reload(rim, 0.3)
b:gesture({{546,652,0.15},{547,680,0.25},{550,700,0.1}}, {wobble=0.2})
blend(poly({{505,726},{580,724},{610,750},{525,750}}, true), {angle=1.2})

--@ chunk 82
wait(4*24*60); print(drying(524,690), drying(540,740), drying(300,720))

--@ chunk 83
wait(5*24*60); print(drying(524,690), drying(556,680))

--@ chunk 84
wait(6*24*60); print(drying(524,690), drying(556,680), drying(524,660))

--@ chunk 85
wait(5*24*60); print(drying(524,690), drying(556,680), drying(524,660))

--@ chunk 86
wait(8*24*60); print(drying(524,690), drying(556,680), drying(524,700), drying(520,705))

--@ chunk 87
local hem = poly({{491,620},{590,620},{596,640},{600,668},{578,673},{545,675},{512,673},{484,668},{486,640}}, true):roughen(1, 20, 3)
work(hem, {hand="body", tool="filbert 6", piles={{coat,1},{coat2,0.3}}, coverage=2.6, fill=true, clip=true, angle=math.pi/2, length={10,30}})
legglaze = pile{{"bone black",0.6},{"ultramarine blue",1},{"burnt sienna",0.6}, medium=0.75, name="legglaze"}
local L3 = ribbon({{524,672},{524,690},{525,712}}, {15,13,9}) + ribbon({{556,672},{557,690},{558,710}}, {14,12,9})
work(L3, {hand="detail", tool={kind="filbert", width=4, stiffness=0.3}, pile=legglaze, coverage=2, clip=true, angle=math.pi/2})
FIG = FIG + hem
-- a little rim on the hem's left edge
local b = brush{kind="round", width=1.8, point=0.7}
b:load(rim, 0.4)
b:gesture({{487,640,0.25},{485,665,0.15}}, {wobble=0.2})

--@ chunk 88
local j = rect(484, 600, 120, 45) * (FIG:shrink(2))
blend(j, {angle=math.pi/2})
blend(j, {angle=0.1})
-- the left hip/hem flare was wider than body: trim hem edges with pavement/plank? leave.
wait(5*24*60); print(drying(540,650), drying(500,640))

--@ chunk 89
wait(6*24*60); print(drying(540,650), drying(560,630), drying(500,660))

--@ chunk 90
local lower = (FIG_BODY + poly({{484,600},{596,600},{600,668},{578,673},{545,675},{512,673},{484,668}}, true)) * rect(480, 560, 130, 120)
work(lower, {hand="body", tool="filbert 7", piles={{coat,1},{coat2,function(x,y) return 0.2 + 0.4*clamp((x-500)/80,0,1) end}}, coverage=2.6, fill=true, clip=true, angle=math.pi/2, angle_jitter=0.1, length={25,60}, seed=101})
-- fold strokes into it, long verticals
local b = brush{kind="filbert", width=4, stiffness=0.5}
for _,f in ipairs({{{532,600,0.2},{530,640,0.4},{528,670,0.2}},{{566,600,0.2},{570,640,0.4},{574,668,0.2}}}) do b:reload(coat_cool, 0.3); b:gesture(f, {wobble=0.6}) end
-- bag of oranges: hand and string bag in front of coat, left side
local hand = ellipse(492, 603, 6, 7)
work(hand, {hand="detail", pile=legs_dk, coverage=2.5, fill=true, clip=true})
local P = {o_dark, o_body, o_lite, nil}
for _,o in ipairs({{484,625,7},{498,623,7},{491,638,7.5},{480,641,6.5},{502,639,6.5}}) do
  fruit(o[1], o[2], o[3], P, {I=0.4})
end
local s = brush{kind="round", width=1, point=0.8}
s:load(boot, 0.5)
for _,ln in ipairs({{{491,606},{476,630},{486,652}},{{493,606},{508,630},{499,652}},{{492,606},{491,652}},{{476,630},{508,630}},{{477,644},{506,644}}}) do
  local pts = {}; for _,p in ipairs(ln) do pts[#pts+1] = {p[1], p[2], 0.4} end
  s:gesture(pts, {wobble=0.6})
end

--@ chunk 91
local inner = FIG:shrink(3) * rect(484, 530, 125, 145)
blend(inner, {angle=math.pi/2})
blend(inner, {angle=math.pi/2 + 0.2})
-- re-lay upper coat slice so seam merges: scumble a bridging band of coat over y 540-580
local band_ = FIG_BODY:shrink(2) * rect(484, 535, 125, 50)
work(band_, {hand="scumble", tool="filbert 7", pile=coat, coverage=1.2, clip=true, angle=math.pi/2, seed=5})
blend(band_, {angle=math.pi/2})

--@ chunk 92
wait(10*24*60); for _,p in ipairs({{540,600},{540,560},{490,630},{540,500},{530,430}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 93
COAT = poly({{530,455},{514,462},{501,472},{494,488},{491,520},{489,560},{485,600},{481,640},{480,668},{500,676},{545,679},{580,676},{602,670},{600,640},{595,600},{591,560},{589,532},{586,500},{584,480},{574,465},{552,455}}, true):roughen(0.8, 30, 11)
COAT = COAT + ribbon({{576,476},{592,504},{599,528}}, {19,17,15}) + ribbon({{599,528},{604,512},{606,498}}, {14,12,10})
local HEAD = poly({{524,412},{540,405},{555,411},{561,428},{558,446},{551,458},{530,460},{519,447},{517,428}}, true):roughen(0.6, 15, 3)
work(COAT, {hand="body", tool="filbert 8", piles={{coat,1},{coat2,function(x,y) return 0.15 + 0.3*clamp((x-500)/90,0,1) end}}, coverage=3, fill=true, clip=true, angle=math.pi/2, angle_jitter=0.08, length={30,80}, seed=211})
work(HEAD * rect(500,400,80,32), {hand="body", tool="filbert 5", pile=hat, coverage=3, fill=true, clip=true, angle=0.1, length={8,18}, seed=212})
work(HEAD * rect(500,432,80,30), {hand="body", tool="filbert 5", pile=hair, coverage=3, fill=true, clip=true, angle=math.pi/2, length={8,18}, seed=213})
local brim = ribbon({{518,430},{539,433},{561,431}}, {6,6,6})
work(brim, {hand="detail", pile=scarf_dk, coverage=2.6, fill=true, clip=true, angle=0})
FIG2 = COAT + HEAD

--@ chunk 94
local LARM = ribbon({{503,474},{493,500},{487,540},{484,575},{486,602}}, {18,18,17,15,13})
local RFL = poly({{592,585},{604,600},{608,640},{606,670},{596,672},{595,600}}, true)
work(LARM + RFL, {hand="body", tool="filbert 7", piles={{coat,1},{coat2,0.2}}, coverage=3, fill=true, clip=true, angle=math.pi/2, length={25,60}, seed=221})
COAT = COAT + LARM + RFL
FIG2 = FIG2 + LARM + RFL
blend((LARM + RFL):grow(4) * COAT, {angle=math.pi/2})

--@ chunk 95
wait(30*60*2); print(drying(540,550), drying(540,420))

--@ chunk 96
local E = FIG2 - FIG2:shrink(2.5)
local top = E * mask(function(x,y) return (y < 478 and x < 572) and 1 or 0 end)
local lside = E * mask(function(x,y) return (y >= 478 and y < 640 and x < 505) and 1 or 0 end)
local arm = E * mask(function(x,y) return (x > 586 and y < 520 and y > 488) and 1 or 0 end)
local rsh = E * mask(function(x,y) return (x >= 560 and x < 588 and y < 482) and 1 or 0 end)
work(top, {hand="detail", pile=rim, coverage=2, clip=true, angle=0, seed=1})
work(lside, {hand="detail", pile=rim, coverage=1.0, clip=true, angle=math.pi/2, seed=2})
work(arm, {hand="detail", pile=rim, coverage=1.3, clip=true, angle=math.pi/2, seed=3})
work(rsh, {hand="detail", pile=rim, coverage=0.7, clip=true, angle=0, seed=4})
-- glove on raised hand
local glove = ellipse(605, 496, 5, 7)
work(glove, {hand="detail", pile=legs_dk, coverage=2.5, fill=true, clip=true})

--@ chunk 97
local inner = FIG2:shrink(1.1) - FIG2:shrink(4)
local sel = inner * mask(function(x,y) return ((y >= 478 and x < 510) or (x > 584 and y > 485 and y < 525) or (y > 455 and y < 480 and x > 495 and x < 590)) and 1 or 0 end)
work(sel, {hand="detail", pile=coat, coverage=2.4, clip=true, angle=math.pi/2, seed=5})

--@ chunk 98
local collar = poly({{514,466},{519,449},{528,446},{540,450},{552,446},{561,449},{566,466},{540,470}}, true)
work(collar, {hand="body", tool="filbert 4", piles={{coat,1},{coat2,0.4}}, coverage=2.8, fill=true, clip=true, angle=math.pi/2 - 0.3, length={8,16}, seed=31})
local b = brush{kind="round", width=1.6, point=0.7}
b:load(rim, 0.5)
b:gesture({{515,464,0.2},{518,452,0.4},{527,446,0.3}}, {wobble=0.2})
-- ear/cheek hint, slight warm turn on hair at left
b:reload(o_dark, 0.3)
b:gesture({{521,437,0.2},{520,444,0.3}}, {wobble=0.1})

--@ chunk 99
wait(6*24*60); print(drying(490,620), drying(540,550), drying(530,455))

--@ chunk 100
wait(4*24*60); print(drying(490,620), drying(540,550), drying(530,455))
-- hand and bag over set coat
local hand = ellipse(487, 607, 5.5, 7)
work(hand, {hand="detail", pile=legs_dk, coverage=2.5, fill=true, clip=true})
local P = {o_dark, o_body, o_lite, nil}
for _,o in ipairs({{481,627,7},{495,626,7},{488,640,7.5},{477,643,6.5},{499,642,6.5}}) do
  fruit(o[1], o[2], o[3], P, {I=0.42})
end
local s = brush{kind="round", width=1, point=0.8}
s:load(boot, 0.5)
for _,ln in ipairs({{{487,612},{472,632},{482,654}},{{489,612},{505,632},{496,654}},{{488,612},{488,654}},{{472,633},{505,633}},{{474,647},{503,647}}}) do
  local pts = {}; for _,p in ipairs(ln) do pts[#pts+1] = {p[1], p[2], 0.4} end
  s:gesture(pts, {wobble=0.6})
end

--@ chunk 101
local keep = FIG2:grow(3) + ellipse(489,632,22,26) + ellipse(430,213,150,120)
local A = STALLALL - keep
local function zone(lo) return A * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= lo and 1 or 0 end):soften(20) end
for i, lo in ipairs({250, 330, 410, 500}) do
  work(zone(lo), {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=dglaze, coverage=0.8, clip=A, angle=0.15 + 0.5*i, length={60,140}, seed=300+i})
end
blend(A * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= 240 and 1 or 0 end), {angle=0.3})
blend(A * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= 240 and 1 or 0 end), {angle=1.6})

--@ chunk 102
wait(5*24*60); for _,p in ipairs({{100,400},{600,450},{50,100},{300,650},{520,600}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 103
dglaze2 = pile{{"burnt sienna",1},{"ultramarine blue",0.6},{"permanent alizarin",0.1}, medium=0.8, name="dglaze2"}
local keep = FIG2:grow(3) + ellipse(489,632,22,26)
local A = STALLALL - keep
local function far(lo) return A * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= lo and 1 or 0 end):soften(25) end
work(far(300), {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=dglaze2, coverage=0.9, clip=A, angle=0.3, length={60,140}, seed=401})
work(far(400), {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=dglaze2, coverage=0.9, clip=A, angle=1.5, length={60,140}, seed=402})
blend(far(290), {angle=0.8})

--@ chunk 104
card_p = pile{{"lead white",2},{"Naples yellow",1},{"yellow ochre",0.2}, name="card_p"}
card_sh = pile{{"yellow ochre",1},{"raw umber",0.5},{"lead white",0.6}, name="card_sh"}
ink = pile{{"bone black",1},{"burnt sienna",0.3}, name="ink"}
local function card(cx, cy, w, h, tilt, lit, glyphs)
  local c, s = math.cos(tilt), math.sin(tilt)
  local function P(u,v) return {cx + u*c - v*s, cy + u*s + v*c} end
  local q = poly({P(-w/2,-h/2), P(w/2,-h/2), P(w/2,h/2), P(-w/2,h/2)})
  -- shadow under card
  local shm = poly({P(-w/2+2,h/2), P(w/2+2,h/2), P(w/2+3,h/2+4), P(-w/2+3,h/2+4)})
  work(shm, {hand="detail", pile=gap_dk, coverage=2, clip=true})
  work(q, {hand="detail", tool={kind="flat", width=3}, piles={{card_p, lit},{card_sh, 1-lit}}, coverage=2.6, fill=true, clip=true, angle=tilt})
  local b = brush{kind="round", width=1.3, point=0.8}
  b:load(ink, 0.6)
  for _,g in ipairs(glyphs) do
    local pts = {}
    for _,p in ipairs(g) do local pp = P(p[1]*w/2, p[2]*h/2); pts[#pts+1] = {pp[1], pp[2], 0.45} end
    b:gesture(pts, {wobble=0.15})
    b:reload(ink, 0.5)
  end
end
-- glyph sets in card-unit coords (-1..1)
local g_A = {{{-0.75,-0.4},{-0.55,-0.55},{-0.4,-0.3},{-0.75,0.4},{-0.4,0.4}}, {{-0.2,0.35},{-0.18,0.4}}, {{0.05,-0.5},{0.35,-0.5},{0.05,-0.05},{0.3,0.0},{0.3,0.35},{0.05,0.45}}, {{0.5,-0.4},{0.75,-0.4},{0.6,0.45}}}
local g_B = {{{-0.7,-0.5},{-0.7,0.45}}, {{-0.35,-0.4},{-0.15,-0.55},{0.0,-0.3},{-0.35,0.4},{0.05,0.4}}, {{0.3,-0.45},{0.55,-0.5},{0.45,0},{0.62,0.2},{0.4,0.45}}}
local g_C = {{{-0.6,-0.5},{-0.75,0},{-0.45,0.45},{-0.3,0},{-0.6,-0.1}}, {{-0.05,0.35},{-0.03,0.4}}, {{0.2,-0.5},{0.45,-0.5},{0.2,-0.05},{0.45,0.05},{0.4,0.4},{0.18,0.45}}}
card(372, 268, 34, 20, -0.08, 0.85, g_A)    -- in limes, near bulb
card(205, 372, 32, 19, 0.06, 0.45, g_B)     -- in oranges
card(150, 262, 30, 18, -0.04, 0.35, g_C)    -- in pomegranates

--@ chunk 105
local Po = {o_dark, o_body, o_lite, hi_w}
fruit(268, 566, 15, Po, {I=0.55, sq=0.95})
fruit(118, 569, 14, Po, {I=0.4, sq=0.95})
fruit(140, 561, 13, Po, {I=0.4, sq=0.95})
fruit(452, 561, 12, {li_dark, li_body, li_lite, hi_w}, {I=0.6, sq=0.9, rot=0.3})
lemon(632, 560, 14, {le2_dark, le2_body, le2_lite, hi_w}, {rot=0.4, sq=0.78, cut=FIG2:grow(1.5)})
lemon(655, 735, 11, {le2_dark, le2_body, le2_lite, hi_w}, {rot=-0.3, sq=0.78, I=0.35})

--@ chunk 106
local r = rag{width=12}
for _,c in ipairs({{268,566,18},{118,569,17},{140,561,16},{452,561,15},{632,560,17}}) do
  for k=1,3 do r:dip(0.8); r:wipe(ellipse(c[1],c[2],c[3],c[3]), {pressure=0.85, passes=2, refold=0.15, seed=k}); r:refold() end
end

--@ chunk 107
LIP = band(553, 592, -5, STALL_X+3) - FIG2:grow(1.5) - ellipse(489,632,22,26)
local LIPTOP = band(553, 561, -5, STALL_X+3) - FIG2:grow(1.5)
local function lt(x,y) return clamp(bulbnear(x, 380, 600)*1.3, 0, 1) end
work(LIP, {hand="body", tool="flat 8", piles={{plank_lit, function(x,y) return 1.2*lt(x,y) end},{plank_mid, function() return 0.6 end},{plank_dk, function(x,y) return 1.2*(1-lt(x,y)) end}}, coverage=3, fill=true, clip=true, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, length={40,100}, seed=501})
work(LIPTOP, {hand="detail", tool={kind="flat", width=3}, piles={{plank_lit, function(x,y) return 0.3+lt(x,y) end},{wall_lit, function(x,y) return lt(x,y) end},{plank_mid, function(x,y) return 1-lt(x,y) end}}, coverage=2.6, fill=true, clip=true, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, seed=502})
local b = brush{kind="round", width=1.6, point=0.5}
b:load(plank_dk, 0.7)
b:stroke({{-5, py(593,-5)},{STALL_X+3, py(593,STALL_X+3)}}, {pressure=0.6, clip=-FIG2:grow(1.5)})

--@ chunk 108
local g = (ellipse(268,568,20,19) + ellipse(452,563,16,16) + ellipse(632,562,18,17) + ellipse(118,571,18,17) + ellipse(140,563,17,17)) - LIP - FIG2:grow(1.5)
work(g, {hand="body", tool="flat 6", piles={{plank_mid,1},{plank_dk,0.8}}, coverage=3, fill=true, clip=true, angle=math.pi/2, length={15,40}, seed=511})
blend(g:grow(4) - LIP, {angle=math.pi/2})

--@ chunk 109
wait(7*24*60); for _,p in ipairs({{100,570},{400,550},{632,562},{268,575}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 110
local g = ellipse(632,563,19,18) - LIP - FIG2:grow(1.5)
work(g, {hand="body", tool="flat 5", piles={{plank_mid,1},{plank_dk,1}}, coverage=3.2, fill=true, clip=true, angle=math.pi/2, length={10,30}, seed=521})
-- darken board away from bulb
local Lb = LIP * mask(function(x,y) return math.abs(x - BX) > 120 and 1 or 0 end):soften(40)
work(Lb, {hand="glaze", tool={kind="filbert", width=14, stiffness=0.2}, pile=dglaze2, coverage=1.2, clip=LIP, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, seed=522})
local Lc = LIP * mask(function(x,y) return x < 200 and 1 or 0 end):soften(40)
work(Lc, {hand="glaze", tool={kind="filbert", width=14, stiffness=0.2}, pile=dglaze2, coverage=1.0, clip=LIP, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, seed=523})
blend(LIP, {angle=function(x,y) return math.atan(VPY-y, VPX-x) end})

--@ chunk 111
print(drying(530,500), drying(540,470))
local m = COAT:shrink(5) * rect(495,468,95,75)
work(m, {hand="scumble", tool="filbert 6", pile=coat, coverage=1.6, clip=true, angle=math.pi/2, seed=531})

--@ chunk 112
local m = COAT:shrink(5) * rect(495,468,95,75)
work(m, {hand="scumble", tool="filbert 6", pile=coat2, coverage=0.8, clip=true, angle=math.pi/2, seed=532})
local edge = (COAT:shrink(3) * rect(488,460,110,92)) - (COAT:shrink(10) * rect(503,476,80,60))
blend(edge, {angle=math.pi/2})
blend(COAT:shrink(4) * rect(490,462,105,88), {angle=0.3})

--@ chunk 113
wait(8*24*60); print(drying(530,500), drying(540,600))
coatglaze = pile{{"ultramarine blue",1},{"bone black",0.4},{"burnt sienna",0.6}, medium=0.8, name="coatglaze"}
local m = COAT:shrink(3.5)
work(m, {hand="glaze", tool={kind="filbert", width=12, stiffness=0.2}, pile=coatglaze, coverage=1.4, clip=m, angle=math.pi/2, length={40,100}, seed=541})
blend(m:shrink(1), {angle=math.pi/2})

--@ chunk 114
local r = rag{width=6}
for _,o in ipairs({{481,627},{495,626},{488,640},{477,643},{499,642}}) do
  r:dip(0.6); r:blot(o[1], o[2], {pressure=0.7}); r:refold()
end
local d = ellipse(632,563,22,21):soften(6) - FIG2:grow(2)
work(d, {hand="detail", tool={kind="filbert", width=5, stiffness=0.3}, pile=dglaze2, coverage=2.2, clip=d})
blend(ellipse(632,563,26,25) - FIG2:grow(2), {angle=math.pi/2})

--@ chunk 115
wait(8*24*60); print(drying(490,635), drying(540,600), drying(632,563))
local P = {o_dark, o_body, o_lite, hi_w}
for _,o in ipairs({{481,627,7},{495,626,7},{488,640,7.5},{477,643,6.5},{499,642,6.5}}) do
  fruit(o[1], o[2], o[3], P, {I=0.5})
end
local s = brush{kind="round", width=0.9, point=0.8}
s:load(boot, 0.5)
for _,ln in ipairs({{{487,612},{472,632},{482,654}},{{489,612},{505,632},{496,654}},{{472,633},{505,633}},{{474,647},{503,647}}}) do
  local pts = {}; for _,p in ipairs(ln) do pts[#pts+1] = {p[1], p[2], 0.35} end
  s:gesture(pts, {wobble=0.5})
end

--@ chunk 116
ORM = T2 * mask(function(x,y) return x < 401 + (y-450)*0.2 and 1 or 0 end) - LIP
work(ORM, {hand="body", tool="flat 10", pile=gap_body, coverage=2.8, fill=true, clip=true, angle=0.1, length={20,50}, seed=601})
for d=1,10 do wait(24*60) end
print(drying(100,450), drying(300,500), drying(200,400))

--@ chunk 117
o2_dark = pile{{"cadmium red",1},{"burnt sienna",1},{"permanent alizarin",0.3}, medium=0.12, name="o2_dark"}
o2_body = pile{{"cadmium yellow",2},{"cadmium red",1}, medium=0.12, name="o2_body"}
o2_lite = pile{{"cadmium yellow",3},{"orange chrome",1},{"lead white",0.3}, medium=0.1, name="o2_lite"}
function orb(x, y, r, P, opts)
  opts = opts or {}
  local sq = opts.sq or 0.95
  local I = opts.I or clamp(bulbnear(x, y, 520)*1.3, 0.25, 1)
  local m = ellipse(x, y, r, r*sq):roughen(r*0.03, r*0.8, math.floor(x*7+y*3))
  if opts.cut then m = m - opts.cut end
  local dx, dy = BX - x, BY - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local function lit(px,py_) local nx,ny=(px-x)/r,(py_-y)/(r*sq); return clamp(I*(0.35 + 1.0*(nx*dx+ny*dy)), 0, 1) end
  local base = math.atan(dy, dx) + math.pi/2
  work(m, {hand="body", tool={kind="filbert", width=math.max(2.5,r*0.32)}, piles={
     {P[1], function(px,py_) return math.max(0, 0.55 - lit(px,py_)) * 4 end},
     {P[2], function(px,py_) return math.max(0.05, 1 - math.abs(lit(px,py_)-0.55)*2) end},
     {P[3], function(px,py_) return math.max(0, lit(px,py_)-0.6) * 4 end}},
     length={r*0.5, r*1.1}, coverage=2.2, clip=true, fill=true,
     angle=function(px,py_) local nx,ny=(px-x)/r,(py_-y)/r; return base + 0.6*(nx*dx+ny*dy) end})
  if P[4] and I > 0.5 then
    local b4 = brush{kind="round", width=math.max(1.6, r*0.13), point=0.6}
    b4:reload(P[4], 0.5)
    local hx, hy = x + dx*r*0.45, y + dy*r*0.45*sq
    b4:touch(hx, hy, {pressure=0.45, drag={-dy*r*0.1, dx*r*0.1}})
  end
  return m
end
local P = {o2_dark, o2_body, o2_lite, hi_w}
local rows = {{y0=380, r=21},{y0=405, r=22},{y0=432, r=24},{y0=462, r=26},{y0=494, r=27},{y0=526, r=29},{y0=552, r=30}}
local n = 0
for ri, row in ipairs(rows) do
  local xmax = 401 + (row.y0-450)*0.2
  local x = rand(-14, 4) + (ri%2)*13
  while x < xmax + 4 do
    local s = 1 - x/VPX
    local r = row.r * s * rand(0.88, 1.1)
    local y = py(row.y0, x) + rand(-5, 5)
    local cut = (x + r > xmax) and mask(function(px,py_) return px > 401 + (py_-450)*0.2 + 3 and 1 or 0 end) or nil
    if cut then cut = cut + LIP else cut = LIP end
    orb(x, y, r, P, {sq=rand(0.9,0.98), cut=cut})
    n = n + 1
    x = x + r*rand(1.7, 2.0)
  end
end
print(n)

--@ chunk 118
for d=1,12 do wait(24*60) end
print(drying(100,450), drying(300,500), drying(380,420))

--@ chunk 119
function card(cx, cy, w, h, tilt, lit, glyphs)
  local c, s = math.cos(tilt), math.sin(tilt)
  local function P(u,v) return {cx + u*c - v*s, cy + u*s + v*c} end
  local q = poly({P(-w/2,-h/2), P(w/2,-h/2), P(w/2,h/2), P(-w/2,h/2)})
  local shm = poly({P(-w/2+2,h/2), P(w/2+2,h/2), P(w/2+3,h/2+4), P(-w/2+3,h/2+4)})
  work(shm, {hand="detail", pile=gap_dk, coverage=2, clip=true})
  work(q, {hand="detail", tool={kind="flat", width=3}, piles={{card_p, lit},{card_sh, 1-lit}}, coverage=2.6, fill=true, clip=true, angle=tilt})
  local b = brush{kind="round", width=1.3, point=0.8}
  b:load(ink, 0.6)
  for _,g in ipairs(glyphs) do
    local pts = {}
    for _,p in ipairs(g) do local pp = P(p[1]*w/2, p[2]*h/2); pts[#pts+1] = {pp[1], pp[2], 0.45} end
    b:gesture(pts, {wobble=0.15})
    b:reload(ink, 0.5)
  end
end
local x1, y1 = 401 + (372-450)*0.2, 372
local x2, y2 = 401 + (555-450)*0.2, 555
DIV = ribbon({{x1-1,y1},{x2-1,y2}}, {5,7})
work(DIV, {hand="detail", tool={kind="flat", width=3}, piles={{plank_mid,1},{plank_lit,0.6}}, coverage=2.6, fill=true, clip=true, angle=math.atan(y2-y1,x2-x1)})
local b = brush{kind="round", width=1.4, point=0.6}
b:load(plank_dk, 0.6)
b:stroke({{x1+3,y1},{x2+4,y2}}, {pressure=0.5})
b:reload(wall_lit, 0.4)
b:stroke({{x1-3,y1+2},{x2-4,y2-2}}, {pressure=0.35})
local A = ORM * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= 230 and 1 or 0 end):soften(30)
work(A, {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=dglaze2, coverage=1.0, clip=ORM, angle=0.3, length={60,140}, seed=611})
local A2 = ORM * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= 330 and 1 or 0 end):soften(30)
work(A2, {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=dglaze2, coverage=1.0, clip=ORM, angle=1.3, length={60,140}, seed=612})
blend(ORM * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= 220 and 1 or 0 end), {angle=0.6})

--@ chunk 120
local Z = ORM * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= 210 and 1 or 0 end)
blend(Z, {angle=-0.4})
blend(Z, {angle=1.1})

--@ chunk 121
for d=1,10 do wait(24*60) end
print(drying(100,450), drying(400,450))
card(205, 370, 32, 19, 0.06, 0.45, {{{-0.7,-0.5},{-0.7,0.45}}, {{-0.35,-0.4},{-0.15,-0.55},{0.0,-0.3},{-0.35,0.4},{0.05,0.4}}, {{0.3,-0.45},{0.55,-0.5},{0.45,0},{0.62,0.2},{0.4,0.45}}})
-- signature, lower right on pavement
sig = pile{{"burnt sienna",1},{"Naples yellow",0.5},{"lead white",0.3}, name="sig"}
local b = brush{kind="round", width=1.3, point=0.8}
b:load(sig, 0.6)
b:gesture({{945,728,0.4},{950,718,0.5},{954,730,0.4},{958,720,0.5},{962,728,0.3}}, {wobble=0.2})
b:reload(sig, 0.5)
b:gesture({{968,722,0.3},{972,730,0.45},{978,720,0.3}}, {wobble=0.2})

--@ chunk 122
RLEM = poly({{556,350},{668,350},{668,540},{560,540},{548,470},{552,400}}) * LEMR
print(RLEM:area(), LEMR:area())
print(drying(600,450), drying(640,400), drying(560,380))
-- bounding check
local minx, maxx, miny, maxy = 1e9, -1e9, 1e9, -1e9
for x=540,670,2 do for y=340,545,2 do if RLEM:at(x,y) > 0.5 then minx=math.min(minx,x); maxx=math.max(maxx,x); miny=math.min(miny,y); maxy=math.max(maxy,y) end end end
print(minx,maxx,miny,maxy)

--@ chunk 123
RLEM = poly({{559,362},{663,362},{663,507},{570,507},{549,445},{553,385}}) - FIGCUT
print(RLEM:area())
work(RLEM, {hand="body", tool="flat 10", pile=gap_body, coverage=2.6, fill=true, clip=true, angle=0.1, length={20,50}})
print(drying(600,450))

--@ chunk 124
for d=1,10 do wait(24*60); print(d, drying(600,450), drying(640,380), drying(560,440)) end

--@ chunk 125
local P = {le2_dark, le2_body, le2_lite, hi_w}
local CUT = FIGCUT + rect(663, 300, 60, 260) + rect(540, 507, 140, 40)
local rows = {{y0=370, r=16},{y0=390, r=17},{y0=412, r=18},{y0=436, r=19},{y0=460, r=19.5},{y0=484, r=20},{y0=500, r=20}}
local n = 0
for ri, row in ipairs(rows) do
  local x = 556 + rand(-4, 12) - (ri % 2) * 8
  while x < 668 do
    local s = 1 - x/VPX
    local r = row.r * s * rand(0.86, 1.12)
    local y = py(row.y0, x) + rand(-6, 6)
    local inside = RLEM:grow(6):at(x, y) > 0.5
    if inside and not (ri == 1 and rand(0,1) < 0.2) then
      lemon(x, y, r, P, {rot=rand(-0.8, 0.8) + ((rand(0,1) < 0.18) and 1.5 or 0), sq=rand(0.72,0.84), cut=CUT})
      n = n + 1
    end
    x = x + r*rand(1.6, 2.1)
  end
end
print(n)

--@ chunk 126
local P = {le2_dark, le2_body, le2_lite, hi_w}
local CUT = FIGCUT + rect(663, 300, 60, 260) + rect(540, 507, 140, 40)
local add = {{588,386,14},{626,404,14},{580,462,14},{657,466,13},{612,497,15},{641,496,15},{596,484,14},{657,492,13},{566,372,12},{632,440,13}}
for _,a in ipairs(add) do
  lemon(a[1]+rand(-2,2), a[2]+rand(-2,2), a[3]*rand(0.92,1.08), P, {rot=rand(-0.8,0.8), sq=rand(0.72,0.84), cut=CUT})
end

--@ chunk 127
for d=1,14 do wait(24*60); if d%2==0 then print(d, drying(600,450), drying(640,400), drying(620,495)) end end

--@ chunk 128
local A = RLEM:grow(8) - FIGCUT:grow(1)
local function zone(lo) return A * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= lo and 1 or 0 end):soften(25) end
work(zone(215), {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=dglaze, coverage=0.8, clip=A, angle=0.6, length={60,140}, seed=701})
work(zone(290), {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=dglaze2, coverage=0.8, clip=A, angle=1.6, length={60,140}, seed=702})
blend(zone(205), {angle=0.8})
blend(zone(205), {angle=-0.6})

--@ chunk 129
local A = RLEM:grow(8) - FIGCUT:grow(1)
local Z = A * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= 200 and 1 or 0 end)
blend(Z, {angle=0.2})
blend(Z, {angle=1.4})
blend(Z, {angle=-0.9})

--@ chunk 130
local card_m = rect(186, 358, 38, 26)
local S = ((ORM:grow(18) - ORM) * rect(-5, 340, 300, 45)) - card_m
print(S:area())
local function zone(lo) return S * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= lo and 1 or 0 end):soften(30) end
work(zone(230), {hand="glaze", tool={kind="filbert", width=12, stiffness=0.2}, pile=dglaze2, coverage=1.0, clip=S, angle=0.05, length={40,100}, seed=711})
work(zone(330), {hand="glaze", tool={kind="filbert", width=12, stiffness=0.2}, pile=dglaze2, coverage=1.0, clip=S, angle=-0.05, length={40,100}, seed=712})
blend(zone(220):grow(3) - card_m, {angle=0})
blend(zone(220):grow(3) - card_m, {angle=1.2})

--@ chunk 131
local card_m = rect(186, 358, 38, 26)
local S = ((ORM:grow(18) - ORM) * rect(-5, 340, 300, 45)) - card_m
local function zone(lo) return S * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= lo and 1 or 0 end):soften(30) end
work(zone(260), {hand="glaze", tool={kind="filbert", width=10, stiffness=0.2}, pile=dglaze2, coverage=1.2, clip=S, angle=0.0, length={30,80}, seed=713})
blend(zone(240):grow(2) - card_m, {angle=0.1})

--@ chunk 132
for _,y in ipairs({355,360,365,368,371,374,378}) do print(y, ORM:at(100,y), STALLALL:at(100,y), T2:at(100,y), LIP:at(100,y)) end

--@ chunk 133
print(drying(540,550), drying(540,420), drying(500,620))
coatglaze2 = pile{{"bone black",1},{"ultramarine blue",0.5},{"burnt sienna",0.5},{"raw umber",0.3}, medium=0.75, name="coatglaze2"}
local m = COAT:shrink(3.5) - ellipse(489,632,22,26)
work(m, {hand="glaze", tool={kind="filbert", width=12, stiffness=0.2}, pile=coatglaze2, coverage=1.2, clip=m, angle=math.pi/2, length={40,100}, seed=801})
blend(m:shrink(1), {angle=math.pi/2})

--@ chunk 134
local E = (COAT:shrink(0.5) - COAT:shrink(5)) * mask(function(x,y) return ((x > 560 and y > 520) or y > 600 or (x>585 and y>475 and y<500)) and 1 or 0 end) - ellipse(489,632,22,26)
print(E:area())
work(E, {hand="detail", tool={kind="filbert", width=4, stiffness=0.3}, pile=coatglaze2, coverage=2.2, clip=E, seed=802})
local B = (COAT:shrink(0.5) - COAT:shrink(8)) * mask(function(x,y) return ((x > 560 and y > 520) or y > 600) and 1 or 0 end) - ellipse(489,632,22,26)
blend(B, {angle=math.pi/2})

--@ chunk 135
for d=1,10 do wait(24*60) end
print(drying(540,550), drying(620,450), drying(100,365))

--@ chunk 136
local P = {o2_dark, o2_body, o2_lite, hi_w}
local cut = rect(184, 356, 42, 30) + LIP
local pts = {{18,371,21},{70,375,22},{118,369,21},{160,377,22},{250,373,21}}
for _,p in ipairs(pts) do
  orb(p[1]+rand(-3,3), p[2]+rand(-2,2), p[3]*rand(0.95,1.05), P, {sq=rand(0.9,0.97), cut=cut, I=0.3})
end

--@ chunk 137
for d=1,14 do wait(24*60) end
print(drying(70,375), drying(160,377), drying(250,373))

--@ chunk 138
local O = (ellipse(18,371,25,24)+ellipse(70,375,26,25)+ellipse(118,369,25,24)+ellipse(160,377,26,25)+ellipse(250,373,25,24)) - rect(184,356,42,30)
local A = O:grow(6) - rect(184,356,42,30)
work(A, {hand="glaze", tool={kind="filbert", width=12, stiffness=0.2}, pile=dglaze2, coverage=1.3, clip=A, angle=0.4, length={30,80}, seed=821})
work(A * mask(function(x,y) return x < 140 and 1 or 0 end):soften(30), {hand="glaze", tool={kind="filbert", width=12, stiffness=0.2}, pile=dglaze2, coverage=0.9, clip=A, angle=1.5, length={30,80}, seed=822})
blend(A, {angle=0.6})

--@ chunk 139
local A = (ellipse(18,371,31,30)+ellipse(70,375,32,31)+ellipse(118,369,31,30)+ellipse(160,377,32,31)) - rect(184,356,42,30)
blend(A, {angle=-0.5})
blend(A, {angle=1.2})

--@ chunk 140
for d=1,10 do wait(24*60) end
print(drying(70,375), drying(540,550))

--@ chunk 141
print(drying(600,450), drying(640,400), drying(560,380), drying(540,500))
work(RLEM, {hand="body", tool="flat 10", pile=gap_body, coverage=2.6, fill=true, clip=true, angle=0.1, length={20,50}, seed=901})
for d=1,10 do wait(24*60) end
print(drying(600,450), drying(640,380), drying(560,440))

--@ chunk 142
wait(3*24*60); print(drying(560,440), drying(600,450))

--@ chunk 143
for _,p in ipairs({{560,370},{600,420},{640,470},{660,500},{420,500}}) do print(p[1],p[2], bulbnear(p[1],p[2],520), clamp(bulbnear(p[1],p[2],520)*1.3,0.28,1)) end

--@ chunk 144
les_dark = pile{{"raw sienna",1},{"cadmium yellow",0.6},{"raw umber",0.6},{"ultramarine blue",0.08}, medium=0.15, name="les_dark"}
les_body = pile{{"lemon chrome",2.5},{"cadmium yellow",0.8},{"raw sienna",0.5},{"raw umber",0.15}, medium=0.15, name="les_body"}
les_lite = pile{{"lemon chrome",2},{"cadmium yellow",0.5},{"lead-tin yellow",0.3}, medium=0.12, name="les_lite"}
function lemon2(x, y, r, P, opts)
  opts = opts or {}
  local rot = opts.rot or 0
  local sq = opts.sq or 0.78
  local I = opts.I or clamp(bulbnear(x, y, 520)*1.3, 0.28, 1)
  local ca, sa = math.cos(rot), math.sin(rot)
  local pts = {}
  for k=0,47 do
    local a = k/48*2*math.pi
    local c = math.cos(a)
    local rr = 1 + 0.13*math.abs(c)^24
    local ex, ey = c*r*rr, math.sin(a)*r*sq
    pts[#pts+1] = {x + ex*ca - ey*sa, y + ex*sa + ey*ca}
  end
  local m = poly(pts, true)
  if opts.cut then m = m - opts.cut end
  local dx, dy = BX - x, BY - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local function lit(px,py_) local nx,ny=(px-x)/r,(py_-y)/(r*sq); return clamp(I*(0.35 + 1.0*(nx*dx+ny*dy)), 0, 1) end
  if opts.under then
    work(m, {hand="body", tool={kind="filbert", width=math.max(2.5,r*0.4)}, pile=opts.under, coverage=2.6, clip=true, fill=true, angle=rot, length={r*0.6, r*1.4}})
  end
  work(m, {hand="body", tool={kind="filbert", width=math.max(2.5,r*0.3)}, piles={
     {P[1], function(px,py_) return math.max(0, 0.55 - lit(px,py_)) * 4 end},
     {P[2], function(px,py_) return math.max(0.05, 1 - math.abs(lit(px,py_)-0.55)*2) end},
     {P[3], function(px,py_) return math.max(0, lit(px,py_)-0.6) * 4 end}},
     length={r*0.5, r*1.2}, coverage=opts.cov or 2.2, clip=true, fill=true,
     angle=function(px,py_) local u = ((px-x)*ca + (py_-y)*sa)/r; local v = (-(px-x)*sa + (py_-y)*ca)/(r*sq); return rot + 0.5*u*v end})
  if P[4] and I > 0.45 and not opts.nohi then
    local b4 = brush{kind="round", width=math.max(1.6, r*0.14), point=0.6}
    b4:reload(P[4], 0.6)
    local hx, hy = x + dx*r*0.45, y + dy*r*0.4*sq
    if not (opts.cut and opts.cut:at(hx,hy) > 0.3) then
      b4:stroke({{hx - ca*r*0.15, hy - sa*r*0.15},{hx + ca*r*0.15, hy + sa*r*0.15}}, {pressure={0.5,0.1}})
    end
  end
  return m
end
local Pnear = {le2_dark, le2_body, le2_lite, hi_w}
local Pfar = {les_dark, les_body, les_lite, hi_w}
local CUT = FIGCUT + rect(663, 300, 60, 260) + rect(540, 507, 140, 40)
local rows = {{y0=371, r=16},{y0=392, r=17},{y0=415, r=18},{y0=439, r=19},{y0=462, r=19.5},{y0=485, r=20},{y0=503, r=20}}
local n = 0
for ri, row in ipairs(rows) do
  local x = 552 + rand(-4, 14)
  while x < 670 do
    local s = 1 - x/VPX
    local r = row.r * s * rand(0.84, 1.14)
    local y = py(row.y0, x) + rand(-8, 8)
    local inside = RLEM:grow(6):at(x, y) > 0.5
    if inside then
      local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2)
      local P = (d < 255) and Pnear or Pfar
      local under = (d < 255) and le2_body or les_body
      local pointing = rand(0,1) < 0.15
      lemon2(x, y, r, P, {rot=rand(-0.9, 0.9) + ((rand(0,1) < 0.2) and 1.5 or 0), sq=pointing and rand(0.88,0.95) or rand(0.70,0.84), cut=CUT, under=under})
      n = n + 1
    end
    x = x + r*rand(1.45, 2.2)
  end
end
print(n)

--@ chunk 145
local Pnear = {le2_dark, le2_body, le2_lite, hi_w}
local Pfar = {les_dark, les_body, les_lite, hi_w}
local CUT = FIGCUT + rect(663, 300, 60, 260) + rect(540, 507, 140, 40)
local add = {{572,478,17},{604,474,18},{636,470,17},{658,482,15},{590,498,18},{622,497,19},{651,503,17},{566,500,16},{575,455,15}}
for _,a in ipairs(add) do
  local x, y = a[1]+rand(-3,3), a[2]+rand(-3,3)
  local pointing = rand(0,1) < 0.2
  lemon2(x, y, a[3]*rand(0.92,1.08), Pfar, {rot=rand(-0.9,0.9) + ((rand(0,1) < 0.2) and 1.5 or 0), sq=pointing and rand(0.88,0.95) or rand(0.70,0.84), cut=CUT, under=les_body})
end

--@ chunk 146
for d=1,16 do wait(24*60) end
print(drying(600,450), drying(640,400), drying(620,495), drying(570,380))

--@ chunk 147
lglaze = pile{{"raw sienna",1},{"transparent oxide yellow",0.5},{"burnt sienna",0.4},{"ultramarine blue",0.15}, medium=0.85, name="lglaze"}
local A = RLEM:grow(8) - FIGCUT:grow(1)
local function zone(lo) return A * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= lo and 1 or 0 end):soften(25) end
work(zone(225), {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=lglaze, coverage=1.0, clip=A, angle=0.6, length={60,140}, seed=911})
work(zone(290), {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=lglaze, coverage=0.9, clip=A, angle=1.6, length={60,140}, seed=912})
blend(zone(215), {angle=0.8})
blend(zone(215), {angle=-0.6})

--@ chunk 148
local r = rag{width=8}
for k=1,3 do
  r:dip(0.7)
  r:wipe({{548,357},{600,356},{672,355}}, {pressure=0.8})
  r:refold()
  r:dip(0.7)
  r:wipe({{668,352},{668,430},{668,515}}, {pressure=0.8})
  r:refold()
end
print(drying(600,356), drying(668,450))

--@ chunk 149
for d=1,10 do wait(24*60) end
print(drying(600,450), drying(650,490), drying(570,380))

--@ chunk 150
lglaze2 = pile{{"raw sienna",1},{"burnt sienna",0.7},{"ultramarine blue",0.3},{"transparent oxide yellow",0.3}, medium=0.85, name="lglaze2"}
local A = RLEM:grow(2) - FIGCUT:grow(1) - rect(540,300,140,57)
local function zone(lo) return A * mask(function(x,y) local d = math.sqrt((x-BX)^2 + ((y-BY)*0.9)^2); return d >= lo and 1 or 0 end):soften(30) end
work(zone(275), {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=lglaze2, coverage=1.0, clip=A, angle=0.9, length={60,140}, seed=921})
work(zone(325), {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=lglaze2, coverage=0.8, clip=A, angle=-0.4, length={60,140}, seed=922})
blend(zone(265), {angle=0.5})
blend(zone(265), {angle=-1.0})

--@ chunk 151
for _,p in ipairs({{100,700},{400,690},{600,700},{700,680},{760,700},{800,700},{900,700},{950,600},{850,560},{500,740},{530,740}}) do print(p[1],p[2],drying(p[1],p[2]), m_pave:at(p[1],p[2]), NG:at(p[1],p[2]), FIG2:at(p[1],p[2])) end

--@ chunk 152
print(CORNER_X, STALL_X, py(733,770), py(733,0), py(733,660))
print(NG:at(770,640), NG:at(765,625), FIG:at(524,700), FIG:at(540,745))
print(drying(655,735), drying(540,740))

--@ chunk 153
GCUT = (FIG + FIG2):grow(1.5) + ellipse(655,735,14,11)
GROUND = NG - GCUT
function spillf(x,y)
  local top = py(733, math.min(x, CORNER_X))
  local t = clamp(1 - (y - top)/120, 0, 1)
  local h = clamp(1 - math.abs(x - 420)/380, 0, 1)
  return (t^0.8) * (h^1.2)
end
local function farf(x,y) return clamp((x - 600)/400, 0, 1)*0.6 + clamp((y - 690)/60, 0, 1)*0.5 end
work(GROUND, {hand="body", tool="flat 14", piles={
  {spill,   function(x,y) return 1.5*spillf(x,y) end},
  {wetwarm, function(x,y) return 0.35 + 0.6*spillf(x,y) end},
  {road_dk, function(x,y) return 0.5 + 0.9*(1-spillf(x,y)) + farf(x,y) end},
  {road_lt, function(x,y) return 0.12 end}},
  coverage=2.8, fill=true, clip=true, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, angle_jitter=0.05, length={50,120}, seed=3101})
-- counter reflection: short vertical drags just under counter base
local b = brush{kind="flat", width=7, stiffness=0.5}
local x = 6
while x < STALL_X - 4 do
  local top = py(733, x) + 2
  b:reload((rand(0,1) < 0.5) and plank_mid or wetwarm, 0.35)
  b:stroke({{x, top},{x + rand(-1,1), top + rand(12, 26)}}, {pressure={0.55,0.1}, clip=GROUND})
  x = x + rand(14, 26)
end
blend(GROUND, {angle=math.pi/2})
blend(GROUND, {angle=function(x,y) return math.atan(VPY-y, VPX-x) end})

--@ chunk 154
spill2 = pile{{"raw sienna",1},{"burnt sienna",0.6},{"yellow ochre",0.6},{"Naples yellow",0.3},{"ultramarine blue",0.15}, name="spill2"}
local z = GROUND * ellipse(410, 742, 260, 52):soften(30)
work(z, {hand="scumble", tool={kind="filbert", width=12, stiffness=0.3}, pile=spill2, coverage=0.9, clip=GROUND, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, length={30,70}, seed=3102})
blend(z:grow(10) * GROUND, {angle=0.05})
-- cast shadow of the figure toward the viewer, a little right
local b = brush{kind="filbert", width=12, stiffness=0.3}
local paths = {
 {{521,729,0.8},{532,740,0.7},{545,752,0.6}},
 {{560,727,0.8},{578,739,0.7},{598,752,0.6}},
 {{540,730,0.7},{556,742,0.75},{572,752,0.7}},
}
for _,p in ipairs(paths) do b:reload(shadow_p, 0.5); b:gesture(p, {wobble=1, clip=GROUND}) end
-- contact darks under boots
local c = brush{kind="filbert", width=6, stiffness=0.4}
for _,p in ipairs({{{509,729,0.6},{524,731,0.8},{538,729,0.5}},{{547,727,0.6},{560,729,0.8},{573,727,0.5}}}) do c:reload(boot, 0.5); c:gesture(p, {wobble=0.3, clip=GROUND}) end
blend(poly({{505,726},{580,724},{615,752},{530,752}}, true):soften(3) * GROUND, {angle=0.9})

--@ chunk 155
local r = rag{width=20}
local z = GROUND * ellipse(410, 740, 290, 62)
for k=1,3 do
  r:dip(0.8)
  r:wipe(z, {pressure=0.85, angle=0.0, passes=2, refold=0.2, seed=40+k})
  r:refold()
end
print(drying(400,730), drying(540,740))

--@ chunk 156
local k = knife{width=28}
local y = 630
while y <= 752 do
  local x = -10
  while x < 790 do
    k:scrape({{x, y},{x+120, y-4}}, {pressure=1})
    k:wipe()
    x = x + 110
  end
  y = y + 22
end
print(drying(400,730), drying(540,740))

--@ chunk 157
local function farf(x,y) return clamp((x - 600)/400, 0, 1)*0.6 + clamp((y - 690)/60, 0, 1)*0.4 end
local z = GROUND * ellipse(410, 740, 320, 75):soften(20)
work(z, {hand="body", tool="flat 14", piles={
  {wetwarm, function(x,y) return 0.5 + 0.5*spillf(x,y) end},
  {road_dk, function(x,y) return 1.0 + farf(x,y) end},
  {pave_p, function(x,y) return 0.3 end}},
  coverage=3, fill=true, clip=GROUND, angle=function(x,y) return math.atan(VPY-y, VPX-x) end, angle_jitter=0.05, length={50,120}, seed=3103})
blend(GROUND, {angle=function(x,y) return math.atan(VPY-y, VPX-x) end})

--@ chunk 158
local r = rag{width=8}
for k=1,3 do
  r:dip(0.7)
  local pts = {}
  for x=150, 470, 20 do pts[#pts+1] = {x, py(733,x) - 4} end
  r:wipe(pts, {pressure={0.8,0.8}})
  r:refold()
end
-- clean smear around dropped lemon
local r2 = rag{width=6}
r2:dip(0.7)
r2:wipe(GROUND * (ellipse(655,735,22,16) - ellipse(655,735,12,9)), {pressure=0.8, passes=2, refold=0.2, seed=7})

--@ chunk 159
wait(6*24*60)
for _,p in ipairs({{300,720},{540,740},{900,700},{700,680},{655,735}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 160
wait(4*24*60)
for _,p in ipairs({{300,720},{400,740},{200,700},{100,740}}) do print(p[1],p[2],drying(p[1],p[2])) end

--@ chunk 161
print(drying(300,720))
local kb = brush{kind="flat", width=2.5, stiffness=0.5}
kb:load(road_dk, 0.5)
kb:stroke({{771, 625.5},{1002, 625}}, {pressure=0.45, shake=0.3})
kb:reload(road_lt, 0.55)
kb:stroke({{771, 628.5},{1002, 628}}, {pressure=0.5, shake=0.3})
-- contact shadows under boots: soft, short, horizontal
local c = brush{kind="filbert", width=9, stiffness=0.25}
for _,p in ipairs({{{506,731,0.5},{522,733,0.7},{540,731,0.4}},{{544,729,0.5},{560,731,0.7},{577,729,0.4}}}) do
  c:reload(shadow_p, 0.4); c:gesture(p, {wobble=0.3, clip=GROUND})
end
blend(GROUND * rect(498, 722, 90, 20):soften(4), {angle=0})

--@ chunk 162
print(drying(950,725), drying(900,627))
blend(rect(770, 621, 232, 12), {angle=0})

--@ chunk 163
local b = brush{kind="round", width=1.3, point=0.8}
b:load(sig, 0.6)
b:gesture({{945,728,0.4},{950,718,0.5},{954,730,0.4},{958,720,0.5},{962,728,0.3}}, {wobble=0.2})
b:reload(sig, 0.5)
b:gesture({{968,722,0.3},{972,730,0.45},{978,720,0.3}}, {wobble=0.2})

--@ chunk 164
wait(14*24*60); print(drying(300,720), drying(960,725), drying(540,732))

--@ chunk 165
local c = brush{kind="filbert", width=5, stiffness=0.35}
c:load(shadow_p, 0.5)
c:gesture({{545,727,0.6},{560,730,0.8},{577,727,0.5}}, {wobble=0.2})
c:reload(shadow_p, 0.4)
c:gesture({{507,730,0.5},{522,732,0.7},{538,730,0.4}}, {wobble=0.2})
-- lemon's own small shadow on the ground
c:reload(shadow_p, 0.35)
c:gesture({{646,742,0.4},{657,744,0.6},{668,742,0.3}}, {wobble=0.2})

--@ chunk 166
reflg = pile{{"burnt sienna",1},{"raw umber",0.5},{"ultramarine blue",0.3},{"transparent oxide yellow",0.3}, medium=0.8, name="reflg"}
reflc = pile{{"ultramarine blue",1},{"Prussian blue",0.3},{"burnt sienna",0.8},{"bone black",0.2}, medium=0.8, name="reflc"}
local b = brush{kind="filbert", width=14, stiffness=0.2}
local x = 2
while x < 768 do
  local top = py(733, x) + 0.5
  local p = (x < STALL_X) and reflg or reflc
  b:reload(p, rand(0.4, 0.55))
  local L = rand(28, 75)
  b:stroke({{x, top},{x + rand(-2,2), top + L}}, {pressure={0.7, 0.05}, ramps={0.05, 0.7}, clip=GROUND})
  x = x + rand(8, 20)
end
local R = GROUND * mask(function(x,y) return y < py(733, math.min(x, CORNER_X)) + 85 and 1 or 0 end)
blend(R, {angle=math.pi/2})
blend(R, {angle=0})

--@ chunk 167
local R = GROUND * mask(function(x,y) return y < py(733, math.min(x, CORNER_X)) + 85 and 1 or 0 end)
blend(R, {angle=math.pi/2 + 0.05})
wait(14*24*60); print(drying(300,740), drying(700,700))

--@ chunk 168
print(drying(820,580), drying(900,600), drying(950,560), CORNER_X)
ROADR = m_pave * rect(CORNER_X-1, 541, 240, 87)
print(ROADR:area())

--@ chunk 169
ROADR = m_pave * rect(CORNER_X-1, 541, 240, 80)
work(ROADR, {hand="body", tool="flat 12", piles={{road_dk,1},{road_lt,function(x,y) return 0.6*clamp(1-(y-540)/140,0,1) end}}, coverage=2.8, fill=true, clip=true, angle=0, angle_jitter=0.04, length={40,110}, seed=1201})

--@ chunk 170
for d=1,10 do wait(24*60) end
print(drying(820,560), drying(900,600), drying(990,615))

--@ chunk 171
rw = pile{{"orange chrome",1},{"Naples yellow",0.5},{"raw sienna",0.3},{"cadmium red",0.08}, name="rw"}
rwy = pile{{"cadmium yellow",1},{"Naples yellow",1},{"orange chrome",0.4},{"raw sienna",0.3}, name="rwy"}
rwd = pile{{"orange chrome",0.6},{"burnt sienna",0.6},{"Mars orange",0.4},{"lead white",0.15}, name="rwd"}
function refl2(wx, y0, n, wmax, bright_p, opts)
  opts = opts or {}
  local b = brush{kind="flat", width=opts.bw or 2.2, stiffness=0.5}
  local y = y0
  for i=1,n do
    local t = (i-1)/math.max(1,n-1)
    local bright = rand(0,1) > 0.2 + 0.55*t
    b:reload(bright and bright_p or (opts.dim or rwd), opts.load or 0.55)
    local len = wmax*rand(0.45,1.0)*(1-0.35*t)
    local xo = wx + rand(-1.5,1.5)
    local pr = (opts.p0 or 0.75)*(1-0.4*t)
    b:stroke({{xo-len/2, y},{xo+len/2, y+rand(-0.4,0.4)}}, {pressure={pr, pr*0.5}, ramps={0.15,0.5}, clip=opts.clip})
    y = y + rand(2.5, 5.5) * (1+0.5*t)
  end
end
local C = ROADR
-- {x, start y, n, width, pile}
local R = {
 {792, 547, 15, 12, rwy}, {822, 552, 11, 12, rw}, {850, 546, 8, 9, rw},
 {876.5, 551, 8, 8, rw}, {896.5, 556, 8, 8, rwy}, {944.5, 550, 9, 8, rwy},
 {966.5, 548, 8, 8, rwy}, {988.5, 556, 8, 8, rw},
}
for _,r in ipairs(R) do refl2(r[1], r[2], r[3], r[4], r[5], {clip=C}) end
-- post reflection: dark, thin, short broken
local pb = brush{kind="flat", width=2.2, stiffness=0.5}
local y = 543
for i=1,6 do pb:reload(post_p, 0.5); pb:stroke({{904+rand(-0.5,0.5),y},{905,y+rand(3,6)}}, {pressure={0.6-0.06*i,0.2}, clip=C}); y = y + rand(4,7) end
-- lamp reflection: pale cool dashes below the lamp
refl2(892, 566, 10, 7, lampref, {clip=C, dim=lamp_halo, p0=0.65})

--@ chunk 172
for d=1,8 do wait(24*60) end
print(drying(792,560), drying(892,580), drying(822,575))

--@ chunk 173
local z1 = ROADR * rect(760, 570, 250, 60):soften(10)
local z2 = ROADR * rect(760, 595, 250, 40):soften(10)
work(z1, {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=reflc, coverage=0.5, clip=ROADR, angle=0, length={60,140}, seed=1301})
work(z2, {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=reflc, coverage=0.5, clip=ROADR, angle=0.05, length={60,140}, seed=1302})
blend(ROADR * rect(760, 560, 250, 70), {angle=0})
blend(ROADR * rect(760, 560, 250, 70), {angle=math.pi/2})

--@ chunk 174
blend(ROADR * rect(760, 552, 250, 35), {angle=math.pi/2})
blend(ROADR * rect(940, 545, 70, 45), {angle=math.pi/2+0.4})
