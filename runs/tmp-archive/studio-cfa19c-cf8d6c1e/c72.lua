local T = trunk2M
local ridge = pile{{"raw umber",1.6},{"bone black",0.5},{"lead white",0.7},{"green earth",0.3}, medium=0.05}
local right = T * mask(function(x,y)
  local l = lerp(236, 222, clamp((y-476)/120,0,1)); local r = lerp(262, 290, clamp((y-476)/120,0,1))
  local t = (x - l)/(r - l)
  return smoothstep(0.4, 0.6, t) * smoothstep(1.0, 0.85, t) end)
work(right, {hand="hatch", pile=ridge, tool={kind="round", width=1.2, point=0.5}, angle=math.pi/2+0.05, coverage=0.9, length={6,16}, pressure={0.35,0.7}, clip=true, broken=0.6, seed=451})
-- grass at the foot, over the root flare
local gr = pile{{"yellow ochre",2.5},{"Prussian blue",0.5},{"raw umber",0.4},{"lead white",0.6}, medium=0.06}
local grL = pile{{"yellow ochre",3},{"Prussian blue",0.3},{"lead white",1.5},{"chrome yellow",0.3}, medium=0.06}
local b = brush{kind="rigger", width=1.2, point=1}
for i=1,70 do
  local x = rand(200, 305)
  local y = rand(590, 606)
  local L = rand(4, 11)
  if i % 10 == 1 then b:reload((x<245) and grL or gr, 0.6) end
  local a = -math.pi/2 + rand(-0.35, 0.35)
  b:stroke({{x,y},{x+math.cos(a)*L*0.5+rand(-0.5,0.5), y+math.sin(a)*L*0.5},{x+math.cos(a)*L, y+math.sin(a)*L}}, {pressure={0.6,0.0}})
end
