local shG = pile{{"yellow ochre",2},{"Prussian blue",0.55},{"raw umber",0.55},{"green earth",0.5},{"lead white",0.35}, medium=0.06}
local keep = trunk2M:grow(0.5) + rect(318,500,40,80)
-- the crown's shadow lying on the slope to the right of the trunk, broken by light through the leaves
local sh = poly({{262,598},{300,594},{350,596},{400,604},{440,614},{452,626},{420,632},{360,630},{300,622},{250,612},{226,604}}, true):roughen(4, 16, 941) - keep
work(sh, {hand="hatch", pile=shG, tool={kind="round", width=1.8, point=0.6}, angle=-math.pi/2+0.2, length={4,10}, coverage=2.2, pressure={0.35,0.75}, edge="soft", broken=0.3, seed=942})
-- grass over the foot of the trunk
local gM = pile{{"yellow ochre",2.5},{"Prussian blue",0.45},{"raw umber",0.3},{"lead white",1.0}, medium=0.05}
local gL = pile{{"yellow ochre",3},{"Prussian blue",0.28},{"lead white",1.6},{"chrome yellow",0.35}, medium=0.05}
local b = brush{kind="rigger", width=1.2, point=1}
for i=1,110 do
  local x = rand(206, 300)
  local y = rand(593, 606)
  if i % 10 == 1 then b:reload((x < 240) and gL or gM, 0.6) end
  local L = rand(4, 10)
  local a = -math.pi/2 + rand(-0.4, 0.4)
  b:stroke({{x,y},{x+math.cos(a)*L*0.5, y+math.sin(a)*L*0.5},{x+math.cos(a)*L+rand(-0.7,0.7), y+math.sin(a)*L}}, {pressure={0.6,0.0}})
end
