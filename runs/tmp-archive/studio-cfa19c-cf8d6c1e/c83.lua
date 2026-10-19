local shirt = pile{{"lead white",4},{"yellow ochre",0.15},{"pale smalt",0.1}, medium=0.04}
local trous = pile{{"raw umber",1},{"bone black",0.4},{"Prussian blue",0.3},{"lead white",0.5}, medium=0.04}
local skirtR = pile{{"red earth",1.5},{"vermilion",0.3},{"lead white",0.4},{"raw umber",0.2}, medium=0.04}
local skirtB = pile{{"Prussian blue",0.6},{"lead white",1},{"raw umber",0.3}, medium=0.04}
local flesh = pile{{"lead white",2},{"red earth",0.5},{"yellow ochre",0.4}, medium=0.04}
local hatP = pile{{"yellow ochre",1.5},{"lead white",1.5},{"raw umber",0.3}, medium=0.04}
local wood = pile{{"raw umber",1},{"yellow ochre",0.8},{"lead white",0.6}, medium=0.04}
function figure(x, y, H, o)
  local lean = o.lean or 0   -- forward bend of the torso, radians; + leans right
  local b = brush{kind="round", width=math.max(0.7, 0.13*H), point=0.4}
  local hipY = y - 0.47*H
  local hx = x
  if o.skirt then
    b:reload(o.skirt, 0.7)
    for k=-1,1 do b:stroke({{hx + k*0.04*H, hipY},{hx + k*0.1*H, y-0.02*H}}, {pressure={0.7,0.9}}) end
  else
    b:reload(trous, 0.7)
    b:stroke({{hx-0.03*H, hipY},{hx-0.07*H - (o.stride or 0), y}}, {pressure={0.8,0.7}})
    b:stroke({{hx+0.03*H, hipY},{hx+0.06*H + (o.stride or 0), y}}, {pressure={0.8,0.7}})
  end
  local sx, sy = hx + math.sin(lean)*0.36*H, hipY - math.cos(lean)*0.36*H
  local tb = brush{kind="round", width=math.max(0.8, 0.17*H), point=0.3}
  tb:reload(o.top or shirt, 0.7)
  tb:stroke({{hx, hipY},{sx, sy}}, {pressure={0.9,0.9}})
  -- head
  local hdx, hdy = sx + math.sin(lean)*0.08*H, sy - math.cos(lean)*0.08*H
  local hb = brush{kind="round", width=math.max(0.7, 0.11*H), point=0.2}
  hb:reload(flesh, 0.6); hb:touch(hdx, hdy, {pressure=0.8})
  hb:reload(o.hat or hatP, 0.6); hb:touch(hdx, hdy - 0.04*H, {pressure=0.7, drag={0.06*H, 0}})
  -- arms and tool
  local ab = brush{kind="round", width=math.max(0.5, 0.07*H), point=0.4}
  ab:reload(o.top or shirt, 0.6)
  local hxA, hyA = o.hand[1], o.hand[2]
  ab:stroke({{sx, sy + 0.03*H},{hxA, hyA}}, {pressure={0.7,0.6}})
  if o.tool then
    local wb = brush{kind="rigger", width=0.6, point=1}
    wb:reload(wood, 0.6)
    wb:stroke({{o.tool[1][1], o.tool[1][2]},{o.tool[2][1], o.tool[2][2]}}, {pressure={0.5,0.4}})
  end
end
-- a man raking near the third cock, leaning to the right
local x, y = 596, hayY(596, 0.7)
local H = 8.5
figure(x, y, H, {lean=0.45, hand={x+4, y-3.2}, tool={{x+1.2, y-5.5},{x+7.5, y+0.3}}, stride=0.4})
-- a woman in a red skirt with a rake, upright, beside him
x, y = 624, hayY(624, 0.5)
figure(x, y, 8.2, {skirt=skirtR, lean=0.05, hand={x-2.2, y-4}, tool={{x-2.8, y-7.5},{x-4, y+0.4}}, hat=shirt})
-- a man pitching hay onto the fifth cock
x, y = 768, hayY(768, 0.74)
figure(x, y, 10.5, {lean=-0.25, hand={x-3.5, y-7}, tool={{x-1, y-2.5},{x-6.5, y-11}}, stride=0.6})
-- a woman in blue further right, walking
x, y = 870, hayY(870, 0.5)
figure(x, y, 11.5, {skirt=skirtB, lean=0.08, hand={x+2.5, y-5}, tool={{x+2.5, y-11},{x+3.2, y+0.2}}, hat=shirt})
