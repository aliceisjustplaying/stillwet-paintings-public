local gL = pile{{"yellow ochre",3},{"Prussian blue",0.28},{"lead white",1.6},{"chrome yellow",0.35}, medium=0.05}
local gM = pile{{"yellow ochre",2.5},{"Prussian blue",0.45},{"raw umber",0.3},{"lead white",1.0}, medium=0.05}
local b = brush{kind="rigger", width=1.1, point=1}
local keep = trunk2M:grow(1) + rect(318,500,40,80)
local n = 0
for x = -3, 1000, 1.3 do
  local c = riseY(x)
  if keep:at(x, c) < 0.5 then
    n = n + 1
    if n % 12 == 1 then b:reload((math.random() < 0.7) and gL or gM, 0.6) end
    local y0 = c + rand(1, 4)
    local L = rand(2.5, 7) * (1 + 0.4*math.max(0, (c-560)/100))
    local a = -math.pi/2 + rand(-0.4, 0.45)
    b:stroke({{x, y0},{x + math.cos(a)*L*0.5, y0 + math.sin(a)*L*0.5},{x + math.cos(a)*L + rand(-0.6,0.6), y0 + math.sin(a)*L}}, {pressure={0.55, 0.0}, clip=-keep})
  end
end
