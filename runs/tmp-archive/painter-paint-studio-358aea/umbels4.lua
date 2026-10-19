local stemD = pile{{"green earth",1},{"raw umber",1},{"Prussian blue",0.25},{"bone black",0.1},{"lead white",0.15}, medium=0.06}
local stemL = pile{{"yellow ochre",1.2},{"green earth",0.8},{"lead white",1.6}, medium=0.06}
local U = {{62,704,120,0.06},{92,706,96,-0.05},{35,708,80,0.12},{905,706,110,-0.07},{948,708,132,0.03},{870,710,70,0.1},{640,706,58,-0.04}}
local sb = brush{kind="round", width=2.4, point=0.6}
local lb = brush{kind="round", width=1.2, point=0.8}
for i,u in ipairs(U) do
  local x, y, h, lean = u[1], u[2], u[3], u[4]
  local tx, ty = x + lean*h, y - h
  local R = h*0.14
  sb:reload(stemD, 0.8)
  sb:stroke({{x, y}, {x + lean*h*0.4, y - h*0.5}, {tx, ty - R*0.05}}, {pressure={0.9,0.6}, ramps={0.02,0.1}})
  lb:reload(stemL, 0.6)
  lb:stroke({{x - 0.8, y - h*0.35}, {x + lean*h*0.4 - 0.8, y - h*0.55}, {tx - 0.7, ty + R*0.25}}, {pressure={0.55,0.3}})
end
print(wait(0))
