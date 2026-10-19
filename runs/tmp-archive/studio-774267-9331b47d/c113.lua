local hayrow = pile{{"yellow ochre", 1.2}, {"lead white", 1}, {"green earth", 0.3}, {"raw umber", 0.1}, medium=0.15}
local b = brush{kind="round", width=1.2, point=0.5}
local avoid = nil
for _,h in ipairs(HAY) do avoid = avoid and (avoid + h.m:grow(1.5)) or h.m:grow(1.5) end
local rows = {441, 445.5, 450.5, 456, 462, 468.5}
for i,y0 in ipairs(rows) do
  local sc = (y0 - 392)/70
  local x = 610 + rand(0, 30)
  while x < 1000 do
    local L = rand(25, 70)
    b:load(hayrow, 0.3)
    local y = y0 + (x - 800)*0.008
    b:stroke({{x, y}, {x + L*0.5, y + rand(-0.3, 0.3)}, {x + L, y + L*0.008}}, {pressure={b:pressure_for(0.5 + 0.7*sc), 0.1}, ramps={0.2, 0.3}, clip=-avoid, shake=0.5})
    x = x + L + rand(6, 20)
  end
end
