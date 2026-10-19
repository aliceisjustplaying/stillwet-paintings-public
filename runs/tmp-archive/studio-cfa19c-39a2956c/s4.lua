print(wait(60*12))
local lic = pile{{"lead white",2},{"yellow ochre",1.2},{"green earth",0.6}, medium=0.05}
stipple(stoneM:shrink(3) * mask(function(x,y) return smoothstep(0.4, -0.2, (x-92)/60 + (y-676)/22) end), {pile=lic, width=1.2, coverage=0.3, pressure={0.3,0.6}, cluster={0.7,3}, seed=3531})
local crk = pile{{"raw umber",1},{"bone black",0.5},{"lead white",0.3}, medium=0.05}
local r = brush{kind="rigger", width=0.7, point=1}
r:reload(crk, 0.5)
r:stroke({{110,668},{114,677},{111,688}}, {pressure={0.35,0.1}})
r:stroke({{84,683},{95,686},{104,684}}, {pressure={0.3,0.1}})
-- grass growing up in front of and around the stones' foot
local gD = pile{{"raw umber",1.2},{"Prussian blue",0.6},{"yellow ochre",1.2},{"green earth",0.6},{"bone black",0.08}, medium=0.05}
local gM = pile{{"yellow ochre",2.5},{"Prussian blue",0.5},{"raw umber",0.4},{"lead white",0.8}, medium=0.05}
local b = brush{kind="round", width=1.6, point=0.9}
for i=1,110 do
  local x = rand(60, 192)
  local y = rand(692, 716)
  if i % 8 == 1 then b:reload((i%3==1) and gM or gD, 0.7) end
  local L = rand(6, 20)
  local a = -math.pi/2 + rand(-0.4, 0.4)
  b:stroke({{x,y},{x+math.cos(a)*L*0.5, y+math.sin(a)*L*0.5},{x+math.cos(a)*L+rand(-1.5,1.5), y+math.sin(a)*L}}, {pressure={0.75,0.0}, ramps={0.05,0.7}})
end
