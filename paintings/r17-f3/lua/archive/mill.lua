millP = pile{{"raw umber",1},{"bone black",0.3},{"lead white",1.6},{"smalt",0.4}, medium=0.08}
millL = pile{{"lead white",3},{"yellow ochre",0.5},{"raw umber",0.5},{"red earth",0.1}, medium=0.08}
-- post mill body, turned slightly: lit left face, dark side face
local body = poly{{176,444},{176,429},{183,423},{190,429},{190,444}}
local side = poly{{190,444},{190,429},{194,431},{194,443}}
local post = poly{{182,444},{182,451},{185,451},{185,444}}
local legs = ribbon({{178,452},{183.5,446},{189,452}}, 0.9)
MILL = body + side + post + legs
work(body, {hand="detail", pile=millL, tool={kind="round", width=1.4, point=0.5}, angle=math.pi/2, length={3,8}, coverage=2.5, fill=true, clip=true, edge="found"})
work(side + post + legs, {hand="detail", pile=millP, tool={kind="round", width=1.2, point=0.5}, angle=math.pi/2, length={3,8}, coverage=2.5, fill=true, clip=true, edge="found"})
-- roof shadow line
local r = brush{kind="rigger", width=1.0, point=1}
r:load(millP, 0.5)
r:stroke({{175.5,429.5},{183,423},{190.5,429.5}}, {pressure={0.5,0.4}})
-- hub on the front face, sails as an X, slightly off-diagonal
local hx, hy = 181, 432
local arms = {{-0.72, 34}, {0.85, 34}, {2.42, 33}, {3.99, 34}}
local sb = brush{kind="rigger", width=1.1, point=1}
for i,a in ipairs(arms) do
  local ex, ey = hx + math.cos(a[1])*a[2], hy + math.sin(a[1])*a[2]
  sb:reload(millP, 0.5)
  sb:stroke({{hx,hy},{ex,ey}}, {pressure={0.55,0.35}})
  -- lattice sail: a parallel thin line offset, with cross bars
  local ox, oy = -math.sin(a[1])*3.2, math.cos(a[1])*3.2
  local fb = brush{kind="rigger", width=0.7, point=1}
  fb:load(millP, 0.35)
  local s0 = 0.3
  fb:stroke({{hx+math.cos(a[1])*a[2]*s0+ox, hy+math.sin(a[1])*a[2]*s0+oy},{ex+ox,ey+oy}}, {pressure={0.35,0.3}})
  for k=0,6 do
    local t = s0 + (1-s0)*k/6
    local px, py = hx + math.cos(a[1])*a[2]*t, hy + math.sin(a[1])*a[2]*t
    fb:stroke({{px,py},{px+ox,py+oy}}, {pressure={0.3,0.3}})
  end
end
print(wait(0))
