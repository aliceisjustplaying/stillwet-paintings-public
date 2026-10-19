print(drying(700, 485), drying(500, 462))
glintP = pile{{"lead white", 3}, {"chrome yellow", 0.25}, {"yellow ochre", 0.1}, medium=0.05}
rippleP = pile{{"lead white", 1.4}, {"smalt", 0.4}, {"raw umber", 0.5}, {"green earth", 0.2}, medium=0.05}
local gb = brush{kind="round", width=1.0, point=1}
local rb = brush{kind="round", width=0.9, point=1}
local rz = riverAll:shrink(1.2) - willowZone - hullM:grow(2)
local placed = 0
for i = 1, 900 do
  local x, y = rand(100, 1000), rand(450, 505)
  if rz:at(x, y) > 0.5 and rz:at(x + 10, y) > 0.5 and rz:at(x - 10, y) > 0.5 then
    local s = clamp((y - 440) / 60, 0.2, 1)
    local L = rand(4, 16) * s
    if rand(0,1) < 0.55 then
      gb:load(glintP, 0.7)
      gb:stroke({{x - L/2, y}, {x + L/2, y + randn(0, 0.1)}}, {pressure={0.0, gb:pressure_for(0.35*s + 0.15), 0.0}})
    else
      rb:load(rippleP, 0.6)
      rb:stroke({{x - L/2, y}, {x + L/2, y + randn(0, 0.1)}}, {pressure={0.0, rb:pressure_for(0.3*s + 0.12), 0.0}})
    end
    placed = placed + 1
    if placed > 140 then break end
  end
end
print(placed)
-- sail reflection, broken
sailRefP = pile{{"lead white", 2}, {"yellow ochre", 0.6}, {"raw umber", 0.7}, {"red earth", 0.2}, medium=0.05}
local bx, by = 905, 486
for k = 0, 10 do
  local yy = by + 3 + k * 1.6
  local w = lerp(18, 8, k/10) * rand(0.7, 1.1)
  if riverA:at(bx + 6, yy) > 0.5 then
    gb:load(sailRefP, 0.6)
    gb:stroke({{bx - 2 - w*0.3, yy}, {bx - 2 + w*0.7, yy}}, {pressure={0.0, gb:pressure_for(0.55), 0.0}})
  end
end
