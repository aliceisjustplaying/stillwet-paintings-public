-- lit sprays across the seam on the sunward side, and a few bigger flower heads in half shade
local n = 0
for i = 1, 200 do
  local x, y = rand(842, 1000), rand(570, 640)
  if elder2:grow(4):at(x, y) + lowE:at(x, y) > 0.8 and n < 40 then
    local s = 1 + (y - 570) / 120
    local lit = x < 930 or rand(0,1) < 0.3
    local a = (x < 925) and (math.pi - rand(-0.5, 0.25)) or rand(-0.25, 0.5)
    local L = rand(8, 13) * s
    local ex, ey = x + L*math.cos(a), y + L*math.sin(a) + 3*s
    local sp = brush{kind="round", width=1.6 + s*0.6, point=0.9}
    sp:load(lit and eL or eM, 0.5)
    sp:stroke({{x, y}, {(x+ex)/2, (y+ey)/2 - 2*s}, {ex, ey}}, {pressure={0.1, 0.02}, ramps={0.1,0.5}})
    for k = 1, 4 do
      local u = k / 5
      local px, py = lerp(x, ex, u), lerp(y, ey, u) - 1.5*s*(1 - math.abs(u - 0.5))
      sp:touch(px, py - 1.3*s, {pressure=0.5, drag={2.4*s, a - 0.75}})
      sp:touch(px, py + 1.3*s, {pressure=0.5, drag={2.4*s, a + 0.75}})
    end
    n = n + 1
  end
end
local umb2
local m = 0
for i = 1, 300 do
  local x, y = rand(850, 990), rand(590, 665)
  if lowE:at(x, y) > 0.95 and m < 9 and (not umb2 or umb2:grow(10):at(x, y) < 0.1) then
    local s = 4.5 + (y - 585) / 22
    local e = ellipse(x, y, s, s*0.45):roughen(0.8, 2.5, 190 + m)
    umb2 = umb2 and (umb2 + e) or e
    m = m + 1
  end
end
stipple(umb2, {pile=elderFs, width=1.7, coverage=2.2, pressure={0.35,0.6}, clip=umb2:grow(0.8), cluster=0.4})
stipple(umb2 * mask(function(x,y) return 1 end):shrink(0.5), {pile=daisy, width=1.3, coverage=0.8, pressure={0.3,0.5}, clip=umb2, cluster=0.5})
print(n, m, wait(0))
