local sil = BOULD
local lt = pile{{"yellow ochre", 1.2}, {"green earth", 1}, {"lead white", 0.4}, {"chrome yellow", 0.1}, medium=0.12}
local md = pile{{"green earth", 1.6}, {"yellow ochre", 1.1}, {"raw umber", 0.2}, {"lead white", 0.2}, medium=0.12}
local bl = brush{kind="round", width=1.3, point=1, stiffness=0.5}
local n = 0
for i=1,400 do
  local x = rand(745, 985)
  local yb
  for y = 645, 560, -1 do if sil:at(x, y) > 0.5 then yb = y; break end end
  if yb then
    n = n + 1
    local y = yb + rand(1, 7)
    local L = rand(6, 14)
    bl:reload((i % 4 == 0) and lt or md, 0.5)
    local a = -math.pi/2 + randn(0, 0.35)
    bl:stroke({{x, y}, {x + L*0.5*math.cos(a + 0.12), y + L*0.5*math.sin(a + 0.12)}, {x + L*math.cos(a), y + L*math.sin(a)}}, {pressure={bl:pressure_for(0.8), 0}, ramps={0.05, 0.7}})
  end
end
print(n)
