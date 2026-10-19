-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 6}, {"red earth", 1}, {"raw umber", 1}}, texture=0.3, um=120}}, linen={18, 16}, seed=4127, size=600}

--@ chunk 2
wall_lit = pile{{"raw sienna",1},{"yellow ochre",1},{"burnt sienna",0.4},{"lead white",0.35}}
wall_mid = pile{{"burnt sienna",1},{"raw umber",0.8},{"yellow ochre",0.3}}
g1 = pile{{"raw sienna",1},{"yellow ochre",1.2},{"Naples yellow",0.8},{"lead white",0.4}}
g2 = pile{{"Naples yellow",2},{"yellow ochre",0.6},{"lead white",0.8},{"cadmium yellow",0.2}}
g3 = pile{{"Naples yellow",2},{"lead white",1.6},{"cadmium yellow",0.4}}
bulbcore = pile{{"lead white",3},{"Naples yellow",1},{"cadmium yellow",0.2}}
wire = pile{{"bone black",1},{"burnt sienna",0.5}}
local cx, cy = 200, 175
local function dd(x,y) return math.sqrt((x-cx)^2+((y-cy)*1.25)^2) end
work(rect(50,50,300,250), {hand="body", tool="flat 9", piles={{wall_lit, function(x,y) return 2*math.max(0,1-dd(x,y)/200)^1.5 end},{wall_mid, function(x,y) return 0.4 + math.min(1,dd(x,y)/200) end}}, coverage=2.5, fill=true, clip=true, angle=math.pi/2})
wait(15*24*60)
-- soft halo by hand: many short radial feathered strokes, light pressure, soft brush, low load
local hb = brush{kind="filbert", width=10, stiffness=0.25}
for i=1,60 do
  local a = rand(0, 2*math.pi)
  local r0 = rand(8, 20)
  local r1 = r0 + rand(20, 55)
  local p = (i % 3 == 0) and g2 or g1
  hb:reload(p, 0.25)
  hb:stroke({{cx+math.cos(a)*r0, cy+math.sin(a)*r0*0.8},{cx+math.cos(a)*r1, cy+math.sin(a)*r1*0.8}}, {pressure={0.5,0.0}, ramps={0.1,0.8}})
end
local sb = brush{kind="filbert", width=6, stiffness=0.3}
for i=1,24 do
  local a = rand(0, 2*math.pi)
  local r1 = rand(12, 28)
  sb:reload(g3, 0.4)
  sb:stroke({{cx+math.cos(a)*4, cy+math.sin(a)*3},{cx+math.cos(a)*r1, cy+math.sin(a)*r1*0.8}}, {pressure={0.6,0.0}, ramps={0.1,0.7}})
end
local w = brush{kind="round", width=1.6, point=0.8}
w:load(wire, 0.6)
w:gesture({{cx, 60, 0.5},{cx+1, cy-12, 0.5}})
local b = brush{kind="round", width=6, point=0.3}
b:load(bulbcore, 1)
b:gesture({{cx, cy-9, 0.6},{cx, cy-2, 1},{cx, cy+4, 0.7}})

--@ chunk 3
local cx, cy = 600, 175
local function dd(x,y) return math.sqrt((x-cx)^2+((y-cy)*1.25)^2) end
work(rect(450,50,300,250), {hand="body", tool="flat 9", piles={{wall_lit, function(x,y) return 2*math.max(0,1-dd(x,y)/200)^1.5 end},{wall_mid, function(x,y) return 0.4 + math.min(1,dd(x,y)/200) end}}, coverage=2.5, fill=true, clip=true, angle=math.pi/2})
wait(15*24*60)
-- graded wet disk, lost edge, then lightly blend the outer ring while wet
work(ellipse(cx,cy,85,68), {hand="body", tool="filbert 7", piles={
  {wall_lit, function(x,y) return clamp((dd(x,y)-55)/30,0,1)*2 end},
  {g1, function(x,y) local d=dd(x,y); return math.max(0, 1-math.abs(d-55)/30) end},
  {g2, function(x,y) local d=dd(x,y); return math.max(0, 1-math.abs(d-28)/22) end},
  {g3, function(x,y) return math.max(0, 1-dd(x,y)/22)*2 end}},
  coverage=2.0, fill=true, edge="lost", pressure={0.3,0.6}, angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end, length={10,24}, seed=4})
local ring = ellipse(cx,cy,100,80):blur(10) - ellipse(cx,cy,45,36):blur(10)
blend(ring, {angle=function(x,y) return math.atan(y-cy,x-cx)+math.pi/2 end})
local w = brush{kind="round", width=1.6, point=0.8}
w:load(wire, 0.6)
w:gesture({{cx, 60, 0.5},{cx+1, cy-12, 0.5}})
local b = brush{kind="round", width=6, point=0.3}
b:load(bulbcore, 1)
b:gesture({{cx, cy-9, 0.6},{cx, cy-2, 1},{cx, cy+4, 0.7}})

--@ chunk 4
coat = pile{{"bone black",1},{"ultramarine blue",1},{"burnt sienna",1}}
rim = pile{{"orange chrome",1},{"yellow ochre",1},{"Naples yellow",1}}
local F = poly({{100,350},{160,350},{180,560},{90,560}}, true)
work(F, {hand="body", tool="filbert 7", pile=coat, coverage=2.6, fill=true, clip=true, angle=math.pi/2})
wait(24*60)
local e = (F - F:shrink(2.5)) * mask(function(x,y) return x < 135 and 1 or 0 end)
work(e, {hand="detail", pile=rim, coverage=1.5, clip=true, angle=math.pi/2})

--@ chunk 5
le_dark = pile{{"raw sienna",1},{"cadmium yellow",1},{"raw umber",0.4},{"ultramarine blue",0.05}, medium=0.12}
le_body = pile{{"lemon chrome",3},{"cadmium yellow",0.7}, medium=0.12}
le_lite = pile{{"lemon chrome",2},{"lead white",0.6},{"lead-tin yellow",0.6}, medium=0.1}
hi_w = pile{{"lead white",3},{"Naples yellow",1}}
gap = pile{{"burnt sienna",1.2},{"ultramarine blue",0.8},{"bone brown",0.5}}
work(rect(400,350,300,200), {hand="body", pile=gap, coverage=2.5, fill=true, clip=true})
wait(10*24*60)
LX, LY = 450, 250   -- light source for trial (up-left)
function lemon(x, y, r, P, opts)
  opts = opts or {}
  local rot = opts.rot or 0
  local sq = opts.sq or 0.74
  local I = opts.I or 1
  local ca, sa = math.cos(rot), math.sin(rot)
  local pts = {}
  for k=0,35 do
    local a = k/36*2*math.pi
    local c = math.cos(a)
    local rr = 1 + 0.16*math.max(0,math.abs(c))^14
    local ex, ey = c*r*rr, math.sin(a)*r*sq*(1 - 0.08*c*c)
    pts[#pts+1] = {x + ex*ca - ey*sa, y + ex*sa + ey*ca}
  end
  local m = poly(pts, true)
  local dx, dy = (opts.lx or LX) - x, (opts.ly or LY) - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local function lit(px,py_) local nx,ny=(px-x)/r,(py_-y)/(r*sq); return clamp(I*(0.45 + 0.8*(nx*dx+ny*dy)), 0, 1) end
  work(m, {hand="body", tool={kind="filbert", width=math.max(2.5,r*0.3)}, piles={
     {P[1], function(px,py_) return math.max(0, 0.5 - lit(px,py_)) * 3 end},
     {P[2], function(px,py_) return math.max(0.05, 1 - math.abs(lit(px,py_)-0.5)*1.7) end},
     {P[3], function(px,py_) return math.max(0, lit(px,py_)-0.58) * 3.5 end}},
     length={r*0.5, r*1.2}, coverage=2.2, clip=true, fill=true,
     angle=function(px,py_) local u = ((px-x)*ca + (py_-y)*sa)/r; local v = (-(px-x)*sa + (py_-y)*ca)/(r*sq); return rot + 0.5*u*v end})
  if P[4] and I > 0.4 then
    local b4 = brush{kind="round", width=math.max(1.6, r*0.14), point=0.6}
    b4:reload(P[4], 0.6)
    local hx, hy = x + dx*r*0.45, y + dy*r*0.4*sq
    b4:stroke({{hx - ca*r*0.15, hy - sa*r*0.15},{hx + ca*r*0.15, hy + sa*r*0.15}}, {pressure={0.5,0.1}})
  end
  return m
end
local P = {le_dark, le_body, le_lite, hi_w}
lemon(470, 400, 26, P, {rot=0.2})
lemon(530, 395, 24, P, {rot=-0.4, I=0.8})
lemon(500, 440, 27, P, {rot=0.6})
lemon(580, 430, 25, P, {rot=-0.1, I=0.6})
lemon(560, 480, 26, P, {rot=1.2, I=0.5})

--@ chunk 6
function lemon(x, y, r, P, opts)
  opts = opts or {}
  local rot = opts.rot or 0
  local sq = opts.sq or 0.78
  local I = opts.I or 1
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
  local dx, dy = (opts.lx or LX) - x, (opts.ly or LY) - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local function lit(px,py_) local nx,ny=(px-x)/r,(py_-y)/(r*sq); return clamp(I*(0.35 + 1.0*(nx*dx+ny*dy)), 0, 1) end
  work(m, {hand="body", tool={kind="filbert", width=math.max(2.5,r*0.3)}, piles={
     {P[1], function(px,py_) return math.max(0, 0.55 - lit(px,py_)) * 4 end},
     {P[2], function(px,py_) return math.max(0.05, 1 - math.abs(lit(px,py_)-0.55)*2) end},
     {P[3], function(px,py_) return math.max(0, lit(px,py_)-0.6) * 4 end}},
     length={r*0.5, r*1.2}, coverage=2.2, clip=true, fill=true,
     angle=function(px,py_) local u = ((px-x)*ca + (py_-y)*sa)/r; local v = (-(px-x)*sa + (py_-y)*ca)/(r*sq); return rot + 0.5*u*v end})
  if P[4] and I > 0.4 then
    local b4 = brush{kind="round", width=math.max(1.6, r*0.14), point=0.6}
    b4:reload(P[4], 0.6)
    local hx, hy = x + dx*r*0.45, y + dy*r*0.4*sq
    b4:stroke({{hx - ca*r*0.15, hy - sa*r*0.15},{hx + ca*r*0.15, hy + sa*r*0.15}}, {pressure={0.5,0.1}})
  end
  return m
end
local P = {le_dark, le_body, le_lite, hi_w}
lemon(470, 500, 26, P, {rot=0.2})
lemon(530, 495, 24, P, {rot=-0.4, I=0.8})
lemon(620, 500, 25, P, {rot=-0.1, I=0.6})
lemon(675, 505, 23, P, {rot=1.2, I=0.4})

--@ chunk 7
le_sh = pile{{"raw umber",1},{"raw sienna",1},{"viridian",0.15},{"burnt sienna",0.3}, medium=0.1}
local cut = nil
local function crescent(x, y, r, sq, rot, lx, ly, amt)
  local dx, dy = lx - x, ly - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local ca, sa = math.cos(rot), math.sin(rot)
  local pts = {}
  for k=0,47 do local a=k/48*2*math.pi; local c=math.cos(a); local rr=1+0.13*math.abs(c)^24
    local ex,ey=c*r*rr, math.sin(a)*r*sq; pts[#pts+1]={x+ex*ca-ey*sa, y+ex*sa+ey*ca} end
  local m = poly(pts, true)
  local sh = m * mask(function(px,py_) local nx,ny=(px-x)/r,(py_-y)/(r*sq); local t = -(nx*dx+ny*dy); return clamp((t+0.1)/0.6,0,1) end)
  work(sh, {hand="body", tool={kind="filbert", width=math.max(2.5,r*0.25)}, pile=le_sh, coverage=amt, clip=m, length={r*0.4,r*0.9}, angle=function(px,py_) return math.atan(py_-y,px-x)+math.pi/2 end})
end
-- bottom row lemons from earlier: (470,500,26,0.2),(530,495,24,-0.4),(620,500,25,-0.1),(675,505,23,1.2)
crescent(470,500,26,0.78,0.2, 450,250, 1.2)
crescent(530,495,24,0.78,-0.4, 450,250, 2)
crescent(620,500,25,0.78,-0.1, 450,250, 2.8)

--@ chunk 8
blend(ellipse(470,500,30,22) + ellipse(530,495,28,22) + ellipse(620,500,29,22), {angle=0.2})
blend(ellipse(470,500,30,22) + ellipse(530,495,28,22) + ellipse(620,500,29,22), {angle=1.5})

--@ chunk 9
wait(15*24*60)
lsh_g = pile{{"transparent oxide yellow",0.6},{"burnt sienna",0.5},{"ultramarine blue",0.45},{"viridian",0.2}, medium=0.8}
function crescentmask(x, y, r, sq, rot, lx, ly, w)
  local dx, dy = lx - x, ly - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local ca, sa = math.cos(rot), math.sin(rot)
  local pts = {}
  for k=0,47 do local a=k/48*2*math.pi; local c=math.cos(a); local rr=1+0.13*math.abs(c)^24
    local ex,ey=c*r*rr, math.sin(a)*r*sq; pts[#pts+1]={x+ex*ca-ey*sa, y+ex*sa+ey*ca} end
  local m = poly(pts, true)
  return m, m * mask(function(px,py_) local nx,ny=(px-x)/r,(py_-y)/(r*sq); local t = -(nx*dx+ny*dy); return clamp((t+w)/0.7,0,1) end)
end
local trials = {{530,395,24,0.78,-0.4},{470,400,26,0.74,0.2},{580,430,25,0.74,-0.1}}
for i,t in ipairs(trials) do
  local m, sh = crescentmask(t[1],t[2],t[3],t[4],t[5],450,250, 0.1*i)
  work(sh, {hand="detail", tool={kind="filbert", width=4, stiffness=0.3}, pile=lsh_g, coverage=1.5 + 0.5*i, clip=m})
end

--@ chunk 10
local P = {le_dark, le_body, le_lite, hi_w}
lemon(470, 600, 26, P, {rot=0.2})
lemon(540, 600, 24, P, {rot=-0.4})
lemon(610, 600, 25, P, {rot=-0.1})
lemon(680, 600, 25, P, {rot=0.5})
wait(15*24*60)
local function grad(x, y, r, sq, rot, lx, ly, w)
  local dx, dy = lx - x, ly - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local m = crescentmask(x,y,r,sq,rot,lx,ly,w)
  return m, m:times(function(px,py_) local nx,ny=(px-x)/r,(py_-y)/(r*sq); local t = -(nx*dx+ny*dy); return clamp((t+w)/0.9,0,1) end)
end
local cases = {{470,0.2,1.0,"glaze"},{540,-0.4,1.6,"glaze"},{610,-0.1,1.0,"scumble"},{680,0.5,0.7,"body"}}
for i,c in ipairs(cases) do
  local m, sh = grad(c[1],600,25,0.78,c[2],450,450, 0.15)
  local tool = c[4]=="glaze" and {kind="filbert", width=10, stiffness=0.2} or {kind="filbert", width=5, stiffness=0.3}
  work(sh, {hand=c[4], tool=tool, pile=lsh_g, coverage=c[3], clip=m, angle=c[2], length={10,30}, seed=i})
end

--@ chunk 11
local P = {le_dark, le_body, le_lite, hi_w}
lemon(470, 680, 26, P, {rot=0.2})
lemon(540, 680, 24, P, {rot=-0.4})
lemon(610, 680, 25, P, {rot=-0.1})
wait(15*24*60)
olv = pile{{"raw sienna",1},{"cadmium yellow",0.8},{"raw umber",0.5},{"viridian",0.08}, name="olv"}
olv2 = pile{{"raw sienna",1},{"cadmium yellow",0.5},{"raw umber",0.8},{"viridian",0.1},{"burnt sienna",0.2}, name="olv2"}
function coreshadow(x, y, r, sq, rot, lx, ly, pile, load, wid)
  local dx, dy = lx - x, ly - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local base = math.atan(-dy, -dx)   -- direction away from light
  local ca, sa = math.cos(rot), math.sin(rot)
  local pts = {}
  for k=-3,3 do
    local a = base + k*0.42
    -- point on ellipse at screen angle a, in local coords then inset
    local la = a - rot
    local ex, ey = math.cos(la)*r*0.7, math.sin(la)*r*sq*0.62
    local pr = 0.75 - math.abs(k)*0.2
    pts[#pts+1] = {x + ex*ca - ey*sa, y + ex*sa + ey*ca, math.max(0.05, pr)}
  end
  local b = brush{kind="filbert", width=wid or r*0.35, stiffness=0.4}
  b:load(pile, load or 0.5)
  b:gesture(pts, {wobble=0.3})
end
coreshadow(470,680,26,0.78,0.2,450,450, olv, 0.5)
coreshadow(540,680,24,0.78,-0.4,450,450, olv2, 0.5)
coreshadow(610,680,25,0.78,-0.1,450,450, olv2, 0.3, 6)

--@ chunk 12
local P = {le_dark, le_body, le_lite, hi_w}
local L = {}
for i,x in ipairs({470,540,610}) do L[i] = lemon(x, 740, 25, P, {rot=({0.2,-0.4,-0.1})[i]}) end
wait(15*24*60)
function coreshadow2(x, y, r, sq, rot, lx, ly, pile, load, inset, wf)
  local dx, dy = lx - x, ly - y
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
  b:gesture(pts, {wobble=0.3})
end
coreshadow2(470,740,25,0.78,0.2,450,450, olv, 0.45, 0.72, 0.5)
coreshadow2(540,740,25,0.78,-0.4,450,450, olv, 0.45, 0.72, 0.5)
coreshadow2(610,740,25,0.78,-0.1,450,450, olv, 0.45, 0.72, 0.5)
blend(L[2]:shrink(1), {angle=-0.4})
local bb = brush{kind="filbert", width=8, stiffness=0.2}
-- soft dry brush sweep across shadow edge on third
for k=1,5 do bb:wipe(0.95); bb:stroke({{595,733+k*2},{625,736+k*2}}, {pressure=0.3}) end

--@ chunk 13
wglaze = pile{{"burnt sienna",1},{"raw umber",0.6},{"ultramarine blue",0.25}, medium=0.88}
local m = rect(600,560,140,110):soften(6)
work(m, {hand="glaze", pile=wglaze, coverage=1.0, clip=true, angle=0.2, seed=3})
work(rect(670,560,70,110), {hand="glaze", pile=wglaze, coverage=1.0, clip=true, angle=1.2, seed=4})
blend(rect(600,560,140,110), {angle=0.3})

--@ chunk 14
road_dk = pile{{"ultramarine blue",1},{"burnt sienna",0.9},{"bone black",0.3},{"lead white",0.25},{"Prussian blue",0.2}, name="road_dk"}
road_lt = pile{{"ultramarine blue",1},{"lead white",1.1},{"raw umber",0.4},{"Prussian blue",0.15}, name="road_lt"}
lampref = pile{{"lead white",2},{"Naples yellow",0.5},{"cerulean blue",0.15}, name="lampref"}
winref = pile{{"orange chrome",1},{"Naples yellow",0.6},{"raw sienna",0.4}, name="winref"}
local R = rect(50,800,300,180)
work(R, {hand="body", tool="flat 12", piles={{road_dk,1},{road_lt,function(x,y) return 0.5*clamp(1-(y-800)/120,0,1) end}}, coverage=2.6, fill=true, clip=true, angle=0, length={40,100}})
local b = brush{kind="flat", width=5, stiffness=0.5}
for i=1,10 do
  b:reload(lampref, 0.5)
  local y0 = 805 + i*15 + rand(-3,3)
  b:stroke({{150+rand(-2,2), y0},{150+rand(-3,3), y0+rand(8,14)}}, {pressure={0.7,0.3}})
end
for i=1,6 do
  b:reload(winref, 0.35)
  local y0 = 810 + i*14
  b:stroke({{260+rand(-1,1), y0},{260+rand(-2,2), y0+rand(6,10)}}, {pressure={0.5,0.2}})
end
blend(rect(130,800,150,180), {angle=math.pi/2})

--@ chunk 15
local R = rect(760,420,230,200)
work(R, {hand="body", tool="flat 12", piles={{road_dk,1},{road_lt,function(x,y) return 0.5*clamp(1-(y-420)/120,0,1) end}}, coverage=2.6, fill=true, clip=true, angle=0, length={40,100}})
local b = brush{kind="flat", width=5, stiffness=0.5}
for i=1,10 do
  b:reload(lampref, 0.5)
  local y0 = 425 + i*16 + rand(-3,3)
  b:stroke({{830+rand(-2,2), y0},{830+rand(-3,3), y0+rand(8,14)}}, {pressure={0.7,0.3}})
end
for i=1,6 do
  b:reload(winref, 0.35)
  local y0 = 430 + i*14
  b:stroke({{930+rand(-1,1), y0},{930+rand(-2,2), y0+rand(6,10)}}, {pressure={0.5,0.2}})
end
blend(rect(800,420,160,200), {angle=math.pi/2})

--@ chunk 16
work(rect(50,420,300,200), {hand="body", pile=gap, coverage=2.5, fill=true, clip=true})
wait(10*24*60)
o2_dark = pile{{"cadmium red",1},{"burnt sienna",1},{"permanent alizarin",0.3}, medium=0.12}
o2_body = pile{{"cadmium yellow",2},{"cadmium red",1}, medium=0.12}
o2_lite = pile{{"cadmium yellow",3},{"orange chrome",1},{"lead white",0.3}, medium=0.1}
function orb(x, y, r, P, opts)
  opts = opts or {}
  local sq = opts.sq or 0.95
  local I = opts.I or 1
  local m = ellipse(x, y, r, r*sq):roughen(r*0.03, r*0.8, math.floor(x*7+y*3))
  if opts.cut then m = m - opts.cut end
  local dx, dy = (opts.lx or LX) - x, (opts.ly or LY) - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local function lit(px,py_) local nx,ny=(px-x)/r,(py_-y)/(r*sq); return clamp(I*(0.35 + 1.0*(nx*dx+ny*dy)), 0, 1) end
  local base = math.atan(dy, dx) + math.pi/2
  work(m, {hand="body", tool={kind="filbert", width=math.max(2.5,r*0.32)}, piles={
     {P[1], function(px,py_) return math.max(0, 0.55 - lit(px,py_)) * 4 end},
     {P[2], function(px,py_) return math.max(0.05, 1 - math.abs(lit(px,py_)-0.55)*2) end},
     {P[3], function(px,py_) return math.max(0, lit(px,py_)-0.6) * 4 end}},
     length={r*0.5, r*1.1}, coverage=2.2, clip=true, fill=true,
     angle=function(px,py_) local nx,ny=(px-x)/r,(py_-y)/r; return base + 0.6*(nx*dx+ny*dy) end})
  if P[4] and I > 0.45 then
    local b4 = brush{kind="round", width=math.max(1.6, r*0.14), point=0.6}
    b4:reload(P[4], 0.55)
    local hx, hy = x + dx*r*0.45, y + dy*r*0.45*sq
    b4:touch(hx, hy, {pressure=0.5, drag={-dy*r*0.12, dx*r*0.12}})
  end
  return m
end
local P = {o2_dark, o2_body, o2_lite, hi_w}
LX, LY = 250, 300
for i,c in ipairs({{100,460,24},{150,455,23},{200,462,25},{125,500,26},{180,505,25},{235,500,24},{150,550,27},{210,548,26}}) do
  orb(c[1], c[2], c[3], P, {I=1 - i*0.06})
end
