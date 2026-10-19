fgBladeD = pile{{"raw umber", 2}, {"green earth", 1.6}, {"bone black", 0.9}, {"Prussian blue", 0.12}, medium=0.1}
fgBladeM = pile{{"raw umber", 2}, {"green earth", 2.2}, {"yellow ochre", 0.5}, {"bone black", 0.35}, medium=0.1}
fgBladeL = pile{{"green earth", 2}, {"yellow ochre", 1.1}, {"raw umber", 1.3}, {"lead white", 0.15}, medium=0.1}
gpiles = {fgBladeD, fgBladeM, fgBladeL, fgBladeD}
for i = 1, 4 do gb[i]:reload(gpiles[i], 0.8) end
local avoid = keepOut + boulderM:grow(1) + ellipse(300, 594, 82, 38)
local n = 0
for c = 1, 1600 do
  local x = rand(-5, 1005)
  local ytop = crestY(x)
  local y = lerp(ytop + 6, 712, rand(0,1)^0.85)
  if avoid:at(x, y) < 0.5 and avoid:at(x, y - 12) < 0.5 then
    local t = clamp((y - ytop) / (704 - ytop), 0, 1)
    local s = lerp(0.5, 1.5, t)
    local r = rand(0,1)
    local k = (r < 0.5) and 1 or ((r < 0.88) and 2 or 3)
    if t > 0.6 and k == 3 and rand(0,1) < 0.6 then k = 2 end
    for j = 1, math.random(2, 5) do
      blade(k, x + randn(0, 1.5*s), y + rand(0, 2*s), s * rand(6, 15), -math.pi/2 + randn(0, 0.25), s * rand(0.5, 0.9))
    end
    n = n + 1
  end
end
print(n)
