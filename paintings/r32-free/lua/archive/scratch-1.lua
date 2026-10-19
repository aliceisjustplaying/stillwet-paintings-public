-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 6}, {"red earth", 1}, {"raw umber", 1}}, texture=0.3, um=120}}, linen={18, 16}, seed=4127, size=600}

--@ chunk 2
night_t = pile{{"ultramarine blue",3},{"Prussian blue",0.5},{"permanent alizarin",0.6},{"burnt sienna",0.6}, turps=0.6}
night_b = pile{{"ultramarine blue",3},{"Prussian blue",0.5},{"permanent alizarin",0.6},{"burnt sienna",0.6}}
warmdark_t = pile{{"burnt sienna",2},{"ultramarine blue",1},{"bone brown",0.5}, turps=0.6}
orange_b = pile{{"cadmium yellow",2},{"cadmium red",1}}
orange_lt = pile{{"cadmium yellow",3},{"orange chrome",1},{"lead white",0.5}}
lemon_b = pile{{"lemon chrome",3},{"cadmium yellow",0.5}}
lime_b = pile{{"emerald green",2},{"cadmium yellow",1},{"viridian",0.5}}
pom_b = pile{{"cadmium red",2},{"permanent alizarin",1}}
bulb = pile{{"lead white",4},{"lead-tin yellow",1}}
local b = brush("flat", 30)
local list = {night_t, night_b, warmdark_t, orange_b, orange_lt, lemon_b, lime_b, pom_b, bulb}
for i,p in ipairs(list) do
  b:reload(p, 0.9)
  local x = 60 + (i-1)*100
  b:stroke({{x,100},{x,330}}, {pressure=0.7})
  b:stroke({{x+15,100},{x+15,330}}, {pressure=0.7})
end
b:reload(night_t,0.9)
b:stroke({{60,450},{900,450}},{pressure=0.8})
b:stroke({{60,480},{900,480}},{pressure=0.8})
for i,p in ipairs({orange_b, lemon_b, lime_b, pom_b, bulb}) do
  b:reload(p,0.9); local x=100+(i-1)*170
  b:stroke({{x,420},{x,520}},{pressure=0.7})
end

--@ chunk 3
night2_t = pile{{"ultramarine blue",2},{"Prussian blue",1},{"burnt sienna",1},{"permanent alizarin",0.2}, turps=0.5}
night3_t = pile{{"Prussian blue",1},{"ultramarine blue",1},{"burnt sienna",1.2},{"bone black",0.3}, turps=0.5}
stalldark_t = pile{{"burnt sienna",2},{"ultramarine blue",1},{"raw umber",1}, turps=0.5}
lime2 = pile{{"cadmium yellow",3},{"viridian",1},{"lemon chrome",1}}
local b = brush("flat", 30)
for i,p in ipairs({night2_t, night3_t, stalldark_t, lime2}) do
  b:reload(p, 0.9)
  local x = 100 + (i-1)*120
  for k=0,2 do b:stroke({{x+k*15,560},{x+k*15,720}}, {pressure=0.7}) end
end

--@ chunk 4
l1 = pile{{"lemon chrome",2},{"emerald green",1}}
l2 = pile{{"cadmium yellow",2},{"emerald green",1.5},{"viridian",0.3}}
l3 = pile{{"barium yellow",2},{"viridian",0.6},{"lemon chrome",1}}
l4 = pile{{"pale cadmium",2},{"copper green",1}}
local b = brush("flat", 30)
for i,p in ipairs({l1,l2,l3,l4}) do
  b:reload(p, 0.9)
  local x = 600 + (i-1)*90
  for k=0,1 do b:stroke({{x+k*15,560},{x+k*15,720}}, {pressure=0.7}) end
end

--@ chunk 5
local under = pile{{"burnt sienna",2},{"ultramarine blue",1},{"raw umber",1}, turps=0.5}
work(rect(0,0,1000,750), {hand="broad", pile=under, coverage=2, fill=true})
wait(5*24*60)
print(drying(500,400))

--@ chunk 6
o_dark = pile{{"cadmium red",1},{"burnt sienna",1},{"permanent alizarin",0.3}, name="o_dark"}
o_body = pile{{"cadmium yellow",2},{"cadmium red",1}, name="o_body"}
o_lite = pile{{"cadmium yellow",3},{"orange chrome",1},{"lead white",0.3}, name="o_lite"}
o_hi = pile{{"lead white",3},{"Naples yellow",1}, name="o_hi"}
BX,BY = 300,100
function fruit(x, y, r, P, opts)
  opts = opts or {}
  local dx, dy = BX - x, BY - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local b = brush{kind="round", width=r*1.9, point=0.2, stiffness=0.4}
  b:reload(P[1], 0.9)
  b:touch(x - dx*r*0.1, y - dy*r*0.1, {pressure=0.85, drag={dx*r*0.15, dy*r*0.15}})
  local b2 = brush{kind="round", width=r*1.4, point=0.2, stiffness=0.4}
  b2:reload(P[2], 0.9)
  b2:touch(x + dx*r*0.15, y + dy*r*0.15, {pressure=0.8, drag={-dy*r*0.2, dx*r*0.2}})
  local b3 = brush{kind="round", width=r*0.8, point=0.3}
  b3:reload(P[3], 0.8)
  b3:touch(x + dx*r*0.4, y + dy*r*0.4, {pressure=0.6, drag={-dy*r*0.15, dx*r*0.15}})
  if P[4] then
    local b4 = brush{kind="round", width=math.max(2, r*0.22), point=0.5}
    b4:reload(P[4], 0.8)
    b4:touch(x + dx*r*0.55, y + dy*r*0.55, {pressure=0.5})
  end
end
local P = {o_dark, o_body, o_lite, o_hi}
for row=0,3 do
  for i=0,7 do
    local r = 26 - row*3
    local x = 100 + i*r*1.8 + (row%2)*r*0.9 + rand(-4,4)
    local y = 520 - row*r*1.3 + rand(-4,4)
    fruit(x, y, r, P)
  end
end

--@ chunk 7
function fruit2(x, y, r, P, opts)
  opts = opts or {}
  local dx, dy = BX - x, BY - y
  local d = math.sqrt(dx*dx+dy*dy); dx, dy = dx/d, dy/d
  local m = ellipse(x, y, r, r*(opts.sq or 0.95)):roughen(r*0.06, r*0.8, math.floor(x*7+y))
  local function lit(px,py_) local nx,ny=(px-x)/r,(py_-y)/r; return clamp(0.35 + 0.9*(nx*dx+ny*dy), 0, 1) end
  work(m, {hand="body", tool={kind="filbert", width=math.max(3,r*0.32)}, piles={
     {P[1], function(px,py_) return math.max(0, 0.7 - lit(px,py_)) * 2 end},
     {P[2], function(px,py_) return 1 - math.abs(lit(px,py_)-0.55)*1.6 end},
     {P[3], function(px,py_) return math.max(0, lit(px,py_)-0.6) * 3 end}},
     length={r*0.4, r*0.9}, coverage=2.2, clip=true, fill=true,
     angle=function(px,py_) return math.atan(py_-y, px-x) + math.pi/2 end})
  if P[4] then
    local b4 = brush{kind="round", width=math.max(2, r*0.18), point=0.6}
    b4:reload(P[4], 0.7)
    local hx, hy = x + dx*r*0.5, y + dy*r*0.5
    b4:stroke({{hx - dy*r*0.08, hy + dx*r*0.08},{hx + dy*r*0.08, hy - dx*r*0.08}}, {pressure={0.6,0.2}})
  end
end
local P = {o_dark, o_body, o_lite, o_hi}
for row=0,2 do
  for i=0,6 do
    local r = 26 - row*3
    local x = 560 + i*r*2.0 + (row%2)*r*0.9 + rand(-4,4)
    local y = 520 - row*r*1.35 + rand(-4,4)
    fruit2(x, y, r, P)
  end
end

--@ chunk 8
wait(20*24*60)
shade_g = pile{{"burnt sienna",1},{"ultramarine blue",0.6},{"permanent alizarin",0.3}, medium=0.8}
shade_g2 = pile{{"burnt sienna",1},{"ultramarine blue",0.6},{"permanent alizarin",0.3}, medium=0.65}
work(rect(500,380,250,220), {hand="glaze", pile=shade_g, coverage=1.2})
work(rect(750,380,250,220), {hand="glaze", pile=shade_g2, coverage=1.2})

--@ chunk 9
wait(20*24*60)
g3 = pile{{"burnt sienna",1},{"ultramarine blue",0.5}, medium=0.88}
g4 = pile{{"burnt sienna",1},{"ultramarine blue",0.4},{"raw umber",0.3}, medium=0.85}
work(rect(80,40,400,300), {hand="glaze", pile=g3, coverage=2.5, length={60,140}})
work(rect(520,40,400,300), {hand="glaze", pile=g4, coverage=2.5, length={60,140}, tool={kind="badger", width=30}})

--@ chunk 10
g5 = pile{{"burnt sienna",1},{"ultramarine blue",0.5},{"permanent alizarin",0.1}, medium=0.3, thinner=0.6}
work(rect(420,330,180,130), {hand="body", tool={kind="filbert", width=14, stiffness=0.3}, pile=g5, coverage=2, length={20,50}, clip=true, angle=0.2})
work(rect(600,330,140,130), {hand="body", tool={kind="filbert", width=14, stiffness=0.3}, pile=g5, coverage=4, length={20,50}, clip=true, angle=0.2})

--@ chunk 11
work(rect(560,450,140,90), {hand="body", tool={kind="filbert", width=14, stiffness=0.3}, pile=g5, coverage=2, length={20,50}, clip=true, angle=0.2})
work(rect(700,450,160,90), {hand="body", tool={kind="filbert", width=14, stiffness=0.3}, pile=g5, coverage=4, length={20,50}, clip=true, angle=0.2})
