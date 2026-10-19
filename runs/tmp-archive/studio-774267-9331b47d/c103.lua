local sil = BOULD
local dk = pile{{"green earth", 1.3}, {"raw umber", 1}, {"Prussian blue", 0.1}, {"bone black", 0.15}, medium=0.12}
local bl = brush{kind="round", width=1.5, point=1, stiffness=0.5}
for i=1,420 do
  local x = rand(745, 985)
  local yb
  for y = 645, 560, -1 do if sil:at(x, y) > 0.5 then yb = y; break end end
  if yb then
    local y = yb + rand(0, 9)
    local L = rand(5, 15)
    bl:reload(dk, 0.55)
    local a = -math.pi/2 + randn(0, 0.4)
    bl:stroke({{x, y}, {x + L*0.5*math.cos(a - 0.1), y + L*0.5*math.sin(a - 0.1)}, {x + L*math.cos(a), y + L*math.sin(a)}}, {pressure={bl:pressure_for(1.0), 0}, ramps={0.05, 0.7}})
  end
end
