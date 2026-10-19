-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 6}, {"red earth", 1}, {"raw umber", 1}}, texture=0.3, um=120}}, linen={18, 16}, seed=4127, size=600}

--@ chunk 2
BX, BY = 430, 215
gap_body = pile{{"burnt sienna",1.2},{"ultramarine blue",0.8},{"bone brown",0.5},{"raw umber",0.3}, name="gap_body"}
le2_dark = pile{{"raw sienna",1},{"cadmium yellow",1},{"raw umber",0.4},{"ultramarine blue",0.05}, medium=0.12, name="le2_dark"}
le2_body = pile{{"lemon chrome",3},{"cadmium yellow",0.7}, medium=0.12, name="le2_body"}
le2_lite = pile{{"lemon chrome",2},{"lead white",0.6},{"lead-tin yellow",0.6}, medium=0.1, name="le2_lite"}
dglaze = pile{{"burnt sienna",1},{"ultramarine blue",0.5}, medium=0.88, name="dglaze"}
hi_w = pile{{"lead white",3},{"Naples yellow",1}, name="hi_w"}
function lemon(x, y, r, P, opts)
  opts = opts or {}
  local rot = opts.rot or 0
  local sq = opts.sq or 0.78
  local I = opts.I or 0.5
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
work(rect(500,350,200,160), {hand="body", tool="flat 10", pile=gap_body, coverage=2.6, fill=true, clip=true, angle=0.1, length={20,50}})
for d=1,10 do wait(24*60) end
local P = {le2_dark, le2_body, le2_lite, hi_w}
for i=0,4 do lemon(520+i*34, 380, 16, P, {I=0.55, rot=rand(-0.5,0.5)}) end
print(drying(550,380))

--@ chunk 3
les_dark = pile{{"raw sienna",1},{"cadmium yellow",0.6},{"raw umber",0.6},{"ultramarine blue",0.08}, medium=0.15, name="les_dark"}
les_body = pile{{"lemon chrome",2.5},{"cadmium yellow",0.8},{"raw sienna",0.5},{"raw umber",0.15}, medium=0.15, name="les_body"}
les_lite = pile{{"lemon chrome",2},{"cadmium yellow",0.5},{"lead-tin yellow",0.3}, medium=0.12, name="les_lite"}
local P = {les_dark, les_body, les_lite, hi_w}
for i=0,4 do lemon(520+i*34, 430, 16, P, {I=0.5, rot=rand(-0.5,0.5)}) end
lesm_dark = pile{{"raw sienna",1},{"cadmium yellow",0.6},{"raw umber",0.6},{"ultramarine blue",0.08}, medium=0.3, name="lesm_dark"}
lesm_body = pile{{"lemon chrome",2.5},{"cadmium yellow",0.8},{"raw sienna",0.5},{"raw umber",0.15}, medium=0.3, name="lesm_body"}
lesm_lite = pile{{"lemon chrome",2},{"cadmium yellow",0.5},{"lead-tin yellow",0.3}, medium=0.25, name="lesm_lite"}
local P2 = {lesm_dark, lesm_body, lesm_lite, hi_w}
for i=0,4 do lemon(520+i*34, 478, 16, P2, {I=0.5, rot=rand(-0.5,0.5)}) end
for d=1,14 do wait(24*60) end
print(drying(550,380), drying(550,430), drying(550,478))

--@ chunk 4
local A = rect(495,360,190,42)
work(A, {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=dglaze, coverage=0.8, clip=A, angle=0.6, length={60,140}, seed=701})
blend(A, {angle=0.8}); blend(A, {angle=-0.6})

--@ chunk 5
function lemon(x, y, r, P, opts)
  opts = opts or {}
  local rot = opts.rot or 0
  local sq = opts.sq or 0.78
  local I = opts.I or 0.5
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
work(rect(500,520,200,120), {hand="body", tool="flat 10", pile=gap_body, coverage=2.6, fill=true, clip=true, angle=0.1, length={20,50}})
for d=1,10 do wait(24*60) end
local P = {les_dark, les_body, les_lite, hi_w}
-- row D: single pass coverage 3.5
for i=0,4 do lemon(520+i*34, 545, 16, P, {I=0.5, rot=0.2*(i-2), cov=3.5}) end
-- row E: wet underlayer of les_body then lemon pass (same chunk, wet-in-wet)
for i=0,4 do lemon(520+i*34, 595, 16, P, {I=0.5, rot=0.2*(i-2), under=les_body}) end
for d=1,14 do wait(24*60) end
print(drying(550,545), drying(550,595))

--@ chunk 6
-- textured gap_body first (as painting has), let dry, then knife slab over it
work(rect(500,650,200,90), {hand="body", tool="flat 10", pile=gap_body, coverage=2.6, fill=true, clip=true, angle=0.1, length={20,50}})
for d=1,10 do wait(24*60) end
local k = knife{width=30}
for i=0,3 do
  k:load(gap_body, 0.8)
  local y = 662 + i*22
  k:lay({{505,y},{600,y+1},{695,y}}, {pressure={0.7,0.7}})
end
for d=1,12 do wait(24*60) end
print(drying(550,670), drying(600,700))

--@ chunk 7
local A = rect(495,570,190,50)
work(A, {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=dglaze, coverage=0.8, clip=A, angle=0.6, length={60,140}, seed=701})
blend(A, {angle=0.8}); blend(A, {angle=-0.6})

--@ chunk 8
work(rect(500,250,200,60), {hand="body", tool="flat 10", pile=gap_body, coverage=2.6, fill=true, clip=true, angle=0.1, length={20,50}})
for d=1,12 do wait(24*60) end
local P = {les_dark, les_body, les_lite, hi_w}
for i=0,4 do lemon(520+i*34, 280, 16, P, {I=0.5, rot=0.2*(i-2), under=les_body}) end
for d=1,16 do wait(24*60) end
print(drying(550,280))
lglaze = pile{{"raw sienna",1},{"transparent oxide yellow",0.5},{"burnt sienna",0.4},{"ultramarine blue",0.15}, medium=0.85, name="lglaze"}
local A = rect(495,255,95,50)
work(A, {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=lglaze, coverage=1.0, clip=A, angle=0.6, length={60,140}, seed=703})
blend(A, {angle=0.8}); blend(A, {angle=-0.6})
local B = rect(590,255,100,50)
work(B, {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=dglaze, coverage=0.8, clip=B, angle=0.6, length={60,140}, seed=704})
blend(B, {angle=0.8}); blend(B, {angle=-0.6})
