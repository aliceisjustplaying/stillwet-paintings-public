local gM = pile{{"yellow ochre",2.5},{"Prussian blue",0.5},{"raw umber",0.4},{"lead white",0.8}, medium=0.05}
local gL = pile{{"yellow ochre",3},{"Prussian blue",0.28},{"lead white",1.6},{"chrome yellow",0.35}, medium=0.05}
local b = brush{kind="round", width=1.8, point=0.8}
for i=1,90 do
  local x = rand(208, 298)
  local y = rand(596, 604)
  if i % 8 == 1 then b:reload((i % 16 == 1) and gL or gM, 0.7) end
  local L = rand(5, 11)
  local a = -math.pi/2 + rand(-0.35, 0.35)
  b:stroke({{x,y},{x+math.cos(a)*L*0.5, y+math.sin(a)*L*0.5},{x+math.cos(a)*L+rand(-0.7,0.7), y+math.sin(a)*L}}, {pressure={0.8,0.0}, ramps={0.05,0.7}})
end
