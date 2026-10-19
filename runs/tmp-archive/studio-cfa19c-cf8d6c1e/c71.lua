local T = poly({{210,597},{222,591},{228,580},{231,563},{232,540},{233,515},{234,495},{236,476},{262,476},{263,495},{264,515},{265,540},{267,563},{272,580},{280,590},{294,598},{250,601}}, true):roughen(1.2, 8, 51)
trunk2M = T
local barkDD = pile{{"raw umber",2},{"bone black",0.8},{"Prussian blue",0.12},{"lead white",0.35}, medium=0.05}
local barkM = pile{{"raw umber",1.6},{"bone black",0.35},{"lead white",1.0},{"yellow ochre",0.4}, medium=0.05}
local barkL = pile{{"lead white",2},{"raw umber",0.8},{"yellow ochre",0.9},{"bone black",0.08}, medium=0.05}
work(T, {hand="hatch", pile=barkDD, tool={kind="round", width=2.6, point=0.3}, angle=math.pi/2, coverage=3.2, fill=true, pressure={0.6,0.95}, clip=true, seed=441})
-- the lit left side: sun from the upper left, strongest at the left third, broken by the furrows
local litSide = T * mask(function(x,y)
  local l = lerp(236, 222, clamp((y-476)/120,0,1)); local r = lerp(262, 290, clamp((y-476)/120,0,1))
  local t = (x - l)/(r - l)
  return smoothstep(0.55, 0.15, t) end)
work(litSide, {hand="hatch", pile=barkM, tool={kind="round", width=1.8, point=0.4}, angle=math.pi/2, coverage=1.6, pressure={0.5,0.85}, clip=true, broken=0.4, seed=442})
local litEdge = T * mask(function(x,y)
  local l = lerp(236, 222, clamp((y-476)/120,0,1)); local r = lerp(262, 290, clamp((y-476)/120,0,1))
  local t = (x - l)/(r - l)
  return smoothstep(0.3, 0.05, t) end)
work(litEdge, {hand="hatch", pile=barkL, tool={kind="round", width=1.4, point=0.5}, angle=math.pi/2, coverage=1.0, pressure={0.4,0.8}, clip=true, broken=0.5, seed=443})
