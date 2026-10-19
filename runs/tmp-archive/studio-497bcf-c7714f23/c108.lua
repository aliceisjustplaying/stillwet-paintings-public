eL = pile{{"green earth", 2.2}, {"yellow ochre", 1.4}, {"lead white", 1.1}, {"raw umber", 0.5}, {"Prussian blue", 0.12}, medium=0.1}
-- leaf sprays: pinnate, arching down and out, in layered tiers catching light on their tops
local sp = brush{kind="round", width=2.0, point=0.9}
local n = 0
for i = 1, 140 do
  local x, y = rand(850, 1000), rand(472, 610)
  if elder2:at(x, y) > 0.8 then
    local left = ((x - 960) * -0.7 + (y - 600) * -0.5)
    if left > -40 or rand(0,1) < 0.3 then
      local dir = (x < 930) and -1 or (rand(0,1) < 0.5 and -1 or 1)
      local L = rand(6, 11)
      local a = dir < 0 and (math.pi + rand(0.2, 0.7)) or rand(-0.7, -0.2) + 0.0
      a = dir < 0 and (math.pi - rand(-0.5, 0.3)) or rand(-0.3, 0.5)
      sp:load(eL, 0.45)
      local ex, ey = x + L*math.cos(a), y + L*math.sin(a) + 2
      sp:stroke({{x, y}, {(x+ex)/2, (y+ey)/2 - 1.5}, {ex, ey}}, {pressure={0.1, 0.02}, ramps={0.1,0.5}, clip=elder2})
      -- leaflets in pairs along it
      for k = 1, 3 do
        local u = k / 4
        local px, py = lerp(x, ex, u), lerp(y, ey, u) - 1
        sp:touch(px, py - 1.2, {pressure=0.55, drag={2.2, a - 0.7}})
        sp:touch(px, py + 1.2, {pressure=0.55, drag={2.2, a + 0.7}})
      end
      n = n + 1
    end
  end
end
print(n, wait(0))
