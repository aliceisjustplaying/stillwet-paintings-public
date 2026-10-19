print(drying(60,650), drying(100,690), drying(62,600))
for i = 1, 4 do gb[i]:reload(gpiles[i], 0.8) end
local n = 0
-- blades rooted along the root bottoms
for x = 240, 362, 0.9 do
  local yb = 600 + 4 * math.exp(-((x - 300)/40)^2) + randn(0, 2)
  if rand(0,1) < 0.8 then
    local k = (rand(0,1) < 0.55) and 1 or ((rand(0,1) < 0.8) and 2 or 3)
    blade(k, x, yb + rand(2, 8), rand(7, 18), -math.pi/2 + randn(0, 0.28), rand(0.6, 1.0))
    n = n + 1
  end
end
-- scattered over the ellipse of ground
for c = 1, 260 do
  local x, y = rand(220, 385), rand(575, 635)
  local e = ((x - 300)/85)^2 + ((y - 596)/40)^2
  if e < 1 and oakM2:at(x, y - 3) < 0.5 and (rootM2:at(x, y - 2) < 0.5) and y > crestY(x) + 3 then
    local k = (rand(0,1) < 0.5) and 1 or ((rand(0,1) < 0.8) and 2 or 3)
    for j = 1, math.random(2, 4) do
      blade(k, x + randn(0, 1.2), y + rand(0, 2), rand(5, 13), -math.pi/2 + randn(0, 0.3), rand(0.5, 0.9))
    end
    n = n + 1
  end
end
print(n)
-- a couple of dock leaves at the root foot
dockP = pile{{"green earth", 2}, {"raw umber", 1.4}, {"bone black", 0.35}, {"yellow ochre", 0.4}, medium=0.05}
dockL = pile{{"green earth", 2}, {"yellow ochre", 1}, {"raw umber", 0.8}, {"lead white", 0.3}, medium=0.05}
local lb = brush{kind="round", width=3, point=1}
local docks = {{262, 610, -2.3, 18}, {268, 612, -1.9, 16}, {340, 611, -0.9, 17}, {347, 612, -1.3, 14}}
for _, d in ipairs(docks) do
  local x, y, a, L = d[1], d[2], d[3], d[4]
  lb:load(dockP, 0.9)
  lb:stroke({{x, y}, {x + 0.3*L*math.cos(a), y + 0.3*L*math.sin(a)}, {x + 0.7*L*math.cos(a + 0.1), y + 0.7*L*math.sin(a + 0.1)}, {x + L*math.cos(a + 0.2), y + L*math.sin(a + 0.2)}}, {pressure={lb:pressure_for(1), lb:pressure_for(4.5), lb:pressure_for(3.2), 0}})
  local vb = brush{kind="round", width=0.7, point=1}; vb:load(dockL, 0.6)
  vb:stroke({{x, y}, {x + 0.5*L*math.cos(a + 0.05), y + 0.5*L*math.sin(a + 0.05)}, {x + 0.9*L*math.cos(a + 0.18), y + 0.9*L*math.sin(a + 0.18)}}, {pressure={vb:pressure_for(0.5), vb:pressure_for(0.2)}})
end
