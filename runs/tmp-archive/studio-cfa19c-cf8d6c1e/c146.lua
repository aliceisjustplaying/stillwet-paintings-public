local bd = pile{{"raw umber",1},{"smalt",0.8},{"lead white",1.2},{"bone black",0.2}, medium=0.05}
local b = brush{kind="rigger", width=1.0, point=1}
b:load(bd, 0.8)
local birds = {{560,150,5.0,0.1},{588,168,4.0,-0.15},{612,142,3.4,0.2},{700,205,2.6,0},{470,120,3.8,-0.1}}
for _,q in ipairs(birds) do
  local x,y,s,t = q[1],q[2],q[3],q[4]
  b:stroke({{x-s, y-0.6*s+t*s}, {x-0.45*s, y-0.15*s}, {x, y+0.15*s}}, {pressure={0.1,0.45}, ramps={0.1,0.1}})
  b:stroke({{x, y+0.15*s}, {x+0.5*s, y-0.2*s}, {x+s*1.05, y-0.5*s-t*s}}, {pressure={0.45,0.1}, ramps={0.1,0.1}})
end
