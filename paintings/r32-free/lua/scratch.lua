-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 6}, {"red earth", 1}, {"raw umber", 1}}, texture=0.3, um=120}}, linen={18, 16}, seed=4127, size=600}

--@ chunk 2
road_dk = pile{{"ultramarine blue",1},{"burnt sienna",0.9},{"bone black",0.3},{"lead white",0.25},{"Prussian blue",0.2}, name="road_dk"}
road_lt = pile{{"ultramarine blue",1},{"lead white",1.1},{"raw umber",0.4},{"Prussian blue",0.15}, name="road_lt"}
winref = pile{{"orange chrome",1},{"Naples yellow",0.6},{"raw sienna",0.4}, name="winref"}
local road = rect(100,100,400,200)
work(road, {hand="body", tool="flat 12", piles={{road_dk,1},{road_lt,0.45}}, coverage=2.6, fill=true, clip=true, angle=0, length={40,110}})
local b = brush{kind="flat", width=5, stiffness=0.5}
for _,wx in ipairs({150, 250}) do
  for i=1,4 do
    b:reload(winref, 0.45)
    local y0 = 120 + i*13
    b:stroke({{wx, y0},{wx, y0+8}}, {pressure={0.45,0.15}, clip=road})
  end
  blend(rect(wx-6,115,12,80), {angle=math.pi/2})
end
wait(40*24*60)
print(drying(150,140), drying(400,200))

--@ chunk 3
rw = pile{{"orange chrome",1},{"Naples yellow",0.5},{"raw sienna",0.3},{"cadmium red",0.08}, name="rw"}
rglz = pile{{"orange chrome",0.6},{"raw sienna",1},{"burnt sienna",0.3}, medium=0.75, name="rglz"}
function refl(wx, y0, n, w, pile_, opts)
  opts = opts or {}
  local b = brush{kind="flat", width=w, stiffness=0.5}
  local y = y0
  for i=1,n do
    b:reload(pile_, opts.load or 0.5)
    local t = (i-1)/math.max(1,n-1)
    local len = w*rand(1.0,1.8)*(1-0.4*t)
    local xo = wx + rand(-1.2,1.2)
    local pr = (opts.p0 or 0.7)*(1-0.6*t)
    b:stroke({{xo-len/2, y},{xo+len/2, y+rand(-0.5,0.5)}}, {pressure={pr, pr*0.6}, ramps={0.2,0.4}})
    y = y + rand(4.5, 8) * (1+0.3*t)
  end
  return y
end
refl(350, 120, 9, 4, rw)
refl(420, 120, 9, 4, rw)
blend(rect(412,115,16,75), {angle=math.pi/2})
refl(150, 120, 9, 4, rw)
blend(rect(142,115,16,75), {angle=math.pi/2})
local g = brush{kind="filbert", width=7, stiffness=0.2}
for i=1,3 do g:reload(rglz, 0.5); g:stroke({{250+rand(-2,2),120},{250+rand(-2,2),185}}, {pressure={0.7,0.05}}) end
blend(rect(240,115,20,80), {angle=math.pi/2})

--@ chunk 4
rwd = pile{{"orange chrome",0.6},{"burnt sienna",0.6},{"Mars orange",0.4},{"lead white",0.15}, name="rwd"}
function refl2(wx, y0, n, wmax, opts)
  opts = opts or {}
  local b = brush{kind="flat", width=2.2, stiffness=0.5}
  local y = y0
  for i=1,n do
    local t = (i-1)/math.max(1,n-1)
    local bright = rand(0,1) > 0.25 + 0.5*t
    b:reload(bright and rw or rwd, opts.load or 0.55)
    local len = wmax*rand(0.45,1.0)*(1-0.35*t)
    local xo = wx + rand(-1.5,1.5)
    local pr = 0.75*(1-0.4*t)
    b:stroke({{xo-len/2, y},{xo+len/2, y+rand(-0.4,0.4)}}, {pressure={pr, pr*0.5}, ramps={0.15,0.5}})
    y = y + rand(2.5, 5.5) * (1+0.5*t)
  end
end
refl2(200, 215, 14, 12)
refl2(300, 215, 14, 9)
refl2(380, 215, 10, 9)

--@ chunk 5
local road = rect(100,100,180,95)
work(road, {hand="body", tool="flat 12", piles={{road_dk,1},{road_lt,0.45}}, coverage=2.6, fill=true, clip=true, angle=0, length={40,110}, seed=7})
wait(12*24*60); print(drying(150,140))

--@ chunk 6
reflc = pile{{"ultramarine blue",1},{"Prussian blue",0.3},{"burnt sienna",0.8},{"bone black",0.2}, medium=0.8, name="reflc"}
print(drying(200,240))
local m = rect(170,205,100,95)
work(m, {hand="glaze", tool={kind="filbert", width=18, stiffness=0.2}, pile=reflc, coverage=0.8, clip=m, angle=0, length={60,140}, seed=5})
blend(m, {angle=0})
blend(m, {angle=math.pi/2})
