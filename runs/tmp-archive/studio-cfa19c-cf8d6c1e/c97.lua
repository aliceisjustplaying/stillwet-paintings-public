local sD2 = pile{{"lead white",0.8},{"raw umber",1},{"bone black",0.45},{"Prussian blue",0.15},{"green earth",0.3}, medium=0.05}
local lower = stoneM * mask(function(x,y) return smoothstep(-0.1, 0.5, (x-95)/60 + (y-680)/25) end)
work(lower, {hand="body", tool="filbert 3", pile=sD2, angle=0.3, coverage=2.2, clip=true, pressure={0.4,0.7}, seed=971})
blend(stoneM:shrink(1), {tool={kind="badger", width=6}, angle=-0.6, coverage=1.0, seed=972})
-- lichen speckles and a few cracks
local lic = pile{{"lead white",2},{"yellow ochre",1},{"green earth",0.5}, medium=0.05}
stipple(stoneM:shrink(2) * rect(70,660,80,25), {pile=lic, width=1.0, coverage=0.25, pressure={0.3,0.6}, cluster={0.6,3}, seed=973})
local r = brush{kind="rigger", width=0.8, point=1}
r:reload(sD2, 0.5)
r:stroke({{112,666},{116,674},{113,684}}, {pressure={0.4,0.2}})
r:stroke({{150,672},{140,680},{142,690}}, {pressure={0.3,0.1}})
-- grass growing up in front of the stones
local gD = pile{{"raw umber",1.2},{"Prussian blue",0.6},{"yellow ochre",1.2},{"green earth",0.6},{"bone black",0.08}, medium=0.05}
local gM = pile{{"yellow ochre",2.5},{"Prussian blue",0.5},{"raw umber",0.4},{"lead white",0.8}, medium=0.05}
local b = brush{kind="round", width=2.0, point=0.8}
for i=1,80 do
  local x = rand(62, 188)
  local y = rand(698, 716)
  if i % 8 == 1 then b:reload((i%24==1) and gM or gD, 0.7) end
  local L = rand(7, 18)
  local a = -math.pi/2 + rand(-0.35, 0.35)
  b:stroke({{x,y},{x+math.cos(a)*L*0.5, y+math.sin(a)*L*0.5},{x+math.cos(a)*L+rand(-1,1), y+math.sin(a)*L}}, {pressure={0.8,0.0}, ramps={0.05,0.7}})
end
