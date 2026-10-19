eMs = pile{{"green earth", 2.4}, {"raw umber", 1.2}, {"Prussian blue", 0.25}, {"yellow ochre", 0.6}, {"lead white", 0.35}, medium=0.08}
local sp = brush{kind="round", width=2.4, point=0.9}
local n = 0
-- lower, shaded leaf sprays: bigger toward the viewer, arching out and down
for i = 1, 260 do
  local x, y = rand(840, 1000), rand(585, 712)
  if lowE:at(x, y) > 0.8 and n < 110 then
    local s = 1 + (y - 585) / 110
    local lit = (x < 900 and rand(0,1) < 0.6) or rand(0,1) < 0.25
    local p = lit and eL or eMs
    local dir = (x < 925) and -1 or (rand(0,1) < 0.6 and 1 or -1)
    local a = dir < 0 and (math.pi - rand(-0.6, 0.2)) or rand(-0.2, 0.6)
    local L = rand(8, 14) * s
    local ex, ey = x + L*math.cos(a), y + L*math.sin(a) + 3*s
    sp = brush{kind="round", width=1.6 + s*0.8, point=0.9}
    sp:load(p, 0.5)
    sp:stroke({{x, y}, {(x+ex)/2, (y+ey)/2 - 2*s}, {ex, ey}}, {pressure={0.1, 0.02}, ramps={0.1,0.5}})
    for k = 1, 4 do
      local u = k / 5
      local px, py = lerp(x, ex, u), lerp(y, ey, u) - 1.5*s*(1 - math.abs(u - 0.5))
      sp:touch(px, py - 1.4*s, {pressure=0.55, drag={2.6*s, a - 0.75}})
      sp:touch(px, py + 1.4*s, {pressure=0.55, drag={2.6*s, a + 0.75}})
    end
    sp:touch(ex, ey, {pressure=0.5, drag={2.4*s, a}})
    n = n + 1
  end
end
-- shaded umbels in the lower bush, cooler and greyer
local fb = brush{kind="round", width=1.8, point=0.4}
local m = 0
for i = 1, 200 do
  local x, y = rand(850, 1000), rand(590, 680)
  if lowE:at(x, y) > 0.95 and m < 14 then
    local s = 2.8 + (y - 585) / 30
    for k = 1, 10 do
      local a = rand(0, 2*math.pi)
      local d = rand(0, 1)^0.6 * s
      fb:load(elderFs, 0.5)
      fb:touch(x + d*math.cos(a), y + d*math.sin(a)*0.45, {pressure=rand(0.35, 0.6)})
    end
    m = m + 1
  end
end
print(n, m, wait(0))
