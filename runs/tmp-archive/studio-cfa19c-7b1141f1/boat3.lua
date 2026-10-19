-- the boat's reflection: its own broken ripples in the river, hull dark, sail a dull warm brown
local R = riverM:shrink(0.4)
local hr = pile{{"raw umber",1},{"bone black",0.3},{"lead white",0.6},{"pale smalt",0.4}, medium=0.2}
local sr = pile{{"red earth",0.8},{"raw umber",0.6},{"lead white",1.4},{"pale smalt",0.6}, medium=0.2}
local r = brush{kind="round", width=1.0, point=0.6}
r:reload(hr, 0.4)
r:stroke({{645,485.2},{653,485.4},{660,485.0}}, {pressure={0.35,0.2}, clip=R})
r:stroke({{647.5,486.4},{652,486.6},{657.5,486.3}}, {pressure={0.3,0.1}, clip=R})
r:reload(sr, 0.4)
local ys = {487.5, 488.6, 489.6, 490.5}
for i, y in ipairs(ys) do
  local x0 = 651 + rand(-0.8, 0.8)
  local x1 = 664 - i * 0.9 + rand(-1, 1)
  r:stroke({{x0,y},{(x0+x1)/2, y+rand(-0.15,0.15)},{x1,y+rand(-0.2,0.2)}}, {pressure={0.3,0.12}, clip=R})
end
