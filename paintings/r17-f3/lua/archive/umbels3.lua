local flowerP = pile{{"lead white",6},{"yellow ochre",0.12},{"green earth",0.1}, medium=0.05}
local flowerS = pile{{"lead white",2.2},{"green earth",0.7},{"pale smalt",0.4},{"raw umber",0.2}, medium=0.05}
local stemD = pile{{"green earth",1.2},{"raw umber",0.9},{"Prussian blue",0.2},{"yellow ochre",0.4},{"lead white",0.3}, medium=0.08}
local stemL = pile{{"yellow ochre",1},{"green earth",1},{"lead white",1.3}, medium=0.08}
local U = {{62,704,120,0.06},{92,706,96,-0.05},{35,708,80,0.12},{905,706,110,-0.07},{948,708,132,0.03},{870,710,70,0.1},{640,706,58,-0.04}}
local sb = brush{kind="round", width=1.8, point=0.7}
local lb = brush{kind="rigger", width=0.8, point=1}
local rb = brush{kind="rigger", width=0.7, point=1}
for i,u in ipairs(U) do
  local x, y, h, lean = u[1], u[2], u[3], u[4]
  local tx, ty = x + lean*h, y - h
  local R = h*0.14
  sb:reload(stemD, 0.7)
  sb:stroke({{x, y}, {x + lean*h*0.4, y - h*0.5}, {tx, ty + R*0.1}}, {pressure={0.8,0.45}})
  lb:reload(stemL, 0.5)
  lb:stroke({{x - 0.5, y - h*0.2}, {x + lean*h*0.4 - 0.5, y - h*0.5}, {tx - 0.4, ty + R*0.2}}, {pressure={0.4,0.2}})
  -- rays
  rb:reload(stemD, 0.5)
  for k=1,7 do
    local a = -math.pi/2 + (k-4)*0.36
    rb:stroke({{tx, ty + R*0.1}, {tx + math.cos(a)*R*0.9, ty + math.sin(a)*R*0.45 - R*0.2}}, {pressure={0.45,0.2}})
  end
  -- side leaf, divided
  if h > 70 then
    local lx, ly = x + lean*h*0.25, y - h*0.3
    rb:reload(stemD, 0.6)
    local side = (i % 2 == 0) and 1 or -1
    for j=0,3 do
      rb:stroke({{lx + side*j*3, ly - j*2}, {lx + side*(j*3 + 5), ly - j*2 - 4}}, {pressure={0.8,0.1}})
    end
  end
  local dome = (ellipse(tx, ty - R*0.28, R*1.05, R*0.42) * above(function(xx) return ty - R*0.05 end)):roughen(1.2, 4, 1800+i)
  stipple(dome, {pile=flowerS, width=1.5, coverage=1.8, pressure={0.4,0.7}, cluster=0.5})
  local top = dome * mask(function(xx,yy) return smoothstep(ty - R*0.1, ty - R*0.5, yy) end)
  stipple(top, {pile=flowerP, width=1.4, coverage=function(xx,yy) return 2.5*top:at(xx,yy) end, pressure={0.4,0.7}, cluster=0.5})
end
print(wait(0))
