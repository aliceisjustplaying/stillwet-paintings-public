-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 6}, {"red earth", 1}, {"raw umber", 1}}, texture=0.3, um=120}}, linen={18, 16}, seed=4127, size=600}

--@ chunk 2
road_dk = pile{{"ultramarine blue",1},{"burnt sienna",0.9},{"bone black",0.3},{"lead white",0.25},{"Prussian blue",0.2}, name="road_dk"}
pave_p = pile{{"ultramarine blue",1},{"lead white",0.7},{"raw umber",0.5},{"burnt sienna",0.3}, name="pave_p"}
wetwarm = pile{{"burnt sienna",1},{"raw umber",0.6},{"ultramarine blue",0.6},{"yellow ochre",0.2}, name="wetwarm"}
local m = rect(50,50,700,300)
work(m, {hand="body", tool="flat 14", piles={{road_dk,1.2},{wetwarm,0.5},{pave_p,0.3}}, coverage=2.8, fill=true, clip=true, angle=0, length={50,120}})
blend(m, {angle=math.pi/2})
wait(12*24*60)
print(drying(200,200))

--@ chunk 3
warmg = pile{{"burnt sienna",1},{"transparent oxide yellow",0.6}, medium=0.85, name="warmg"}
warmg2 = pile{{"transparent oxide yellow",1},{"burnt sienna",0.5},{"raw sienna",0.5}, medium=0.85, name="warmg2"}
shadow_p = pile{{"ultramarine blue",1},{"burnt sienna",0.8},{"bone black",0.3}, medium=0.5, name="shadow_p"}
local g = {kind="filbert", width=18, stiffness=0.2}
work(rect(60,60,180,200), {hand="glaze", tool=g, pile=warmg, coverage=0.8, clip=true, angle=0.1, length={60,140}})
work(rect(260,60,180,200), {hand="glaze", tool=g, pile=warmg, coverage=1.4, clip=true, angle=0.1, length={60,140}})
work(rect(460,60,180,200), {hand="glaze", tool=g, pile=warmg2, coverage=1.0, clip=true, angle=0.1, length={60,140}})
blend(rect(60,60,580,200), {angle=0.1})
local b = brush{kind="filbert", width=12, stiffness=0.3}
for i,x in ipairs({120, 320, 520}) do
  b:reload(shadow_p, 0.5)
  b:gesture({{x,200,0.8},{x+25,250,0.7},{x+50,320,0.6}}, {wobble=1})
end
blend(rect(60,180,640,160), {angle=1.0})

--@ chunk 4
wait(12*24*60)
local m = rect(60,380,700,300)
work(m, {hand="body", tool="flat 14", piles={{road_dk,1.2},{wetwarm,0.5},{pave_p,0.3}}, coverage=2.8, fill=true, clip=true, angle=0, length={50,120}, seed=5})
blend(m, {angle=math.pi/2})
wait(12*24*60)
local z = ellipse(400, 690, 300, 110):soften(60) * m
work(z, {hand="glaze", tool={kind="filbert", width=26, stiffness=0.15}, pile=warmg2, coverage=0.6, clip=m, angle=0.05, length={150,300}, seed=6})
blend(m, {angle=0.05}); blend(m, {angle=1.0}); blend(m, {angle=-0.6})

--@ chunk 5
plank_mid = pile{{"burnt sienna",1},{"raw umber",0.8},{"bone brown",0.3}, name="plank_mid"}
local m = rect(60,700-0,700,45)
local m2 = rect(60,560,700,180)
work(rect(60,450,700,100), {hand="body", tool="flat 10", pile=plank_mid, coverage=2.8, fill=true, clip=true, angle=0})
work(m2, {hand="body", tool="flat 14", piles={{road_dk,1.2},{wetwarm,0.5},{pave_p,0.3}}, coverage=2.8, fill=true, clip=true, angle=0, length={50,120}, seed=8})
blend(m2, {angle=math.pi/2})
wait(12*24*60)
reflg = pile{{"burnt sienna",1},{"raw umber",0.5},{"ultramarine blue",0.3},{"transparent oxide yellow",0.3}, medium=0.8, name="reflg"}
local b = brush{kind="filbert", width=14, stiffness=0.2}
local x = 70
while x < 740 do
  b:reload(reflg, 0.5)
  local L = rand(40, 80)
  b:stroke({{x, 562},{x + rand(-2,2), 562 + L}}, {pressure={0.7, 0.05}, ramps={0.05, 0.7}, clip=m2})
  x = x + rand(10, 16)
end
blend(rect(60,560,700,110), {angle=math.pi/2})
blend(rect(60,560,700,110), {angle=0})
