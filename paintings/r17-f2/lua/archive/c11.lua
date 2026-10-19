print(wait(24*60)); print(drying(940,533))
local fix = rect(918, 518, 44, 26) * elder2:shrink(0.3)
stipple(fix, {pile=eD, width=2.6, coverage=4.5, pressure={0.45,0.75}, clip=fix, cluster=0.25})
local sp = brush{kind="round", width=2.0, point=0.9}
for i = 1, 14 do
  local x, y = rand(922, 960), rand(518, 544)
  if fix:at(x, y) > 0.8 then
    local a = (x < 940) and (math.pi - rand(-0.5, 0.3)) or rand(-0.3, 0.5)
    local L = rand(6, 10)
    local ex, ey = x + L*math.cos(a), y + L*math.sin(a) + 2
    sp:load((i % 2 == 0) and eL or eM, 0.45)
    sp:stroke({{x, y}, {(x+ex)/2, (y+ey)/2 - 1.5}, {ex, ey}}, {pressure={0.1, 0.02}, ramps={0.1,0.5}, clip=elder2})
    for k = 1, 3 do
      local u = k / 4
      local px, py = lerp(x, ex, u), lerp(y, ey, u) - 1
      sp:touch(px, py - 1.2, {pressure=0.55, drag={2.2, a - 0.7}, clip=elder2})
      sp:touch(px, py + 1.2, {pressure=0.55, drag={2.2, a + 0.7}, clip=elder2})
    end
  end
end
-- one umbel in the shade
local fb = brush{kind="round", width=1.3, point=0.5}
fb:load(elderFs, 0.5)
for k = 1, 7 do local a = rand(0, 2*math.pi) local d = rand(0, 3.4) fb:touch(946 + d*math.cos(a), 527 + d*math.sin(a)*0.45, {pressure=rand(0.35,0.55)}) end
print(wait(0))
