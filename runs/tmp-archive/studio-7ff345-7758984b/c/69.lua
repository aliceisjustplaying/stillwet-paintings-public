-- grass in clumps and drifts rather than sprinkles: dense stubble in the foreground corners, along the bank, by the reeds
local avoid = pathM:grow(2) + merem:grow(3) + oakLive + footM
local function patch(cx, cy, rx, ry, n, hmin, hmax)
  for i = 1, n do
    local x = cx + randn(0, rx)
    local y = cy + randn(0, ry)
    if avoid:at(x, y) < 0.5 and y < 716 then tuft(x, y, rand(hmin, hmax) * (0.6 + (y - 600) / 120), math.random(4, 11)) end
  end
end
patch(90, 690, 70, 14, 70, 12, 26)
patch(200, 700, 50, 10, 35, 12, 24)
patch(20, 660, 25, 12, 20, 10, 20)
patch(880, 700, 90, 10, 55, 12, 24)
patch(640, 705, 40, 8, 20, 10, 20)
-- along the bank crest, intermittent
for x = 0, 1000, 14 do
  if math.sin(x / 47) + 0.5 * math.sin(x / 13) > 0.3 then
    local y = bankY(x) + rand(0, 4)
    if avoid:at(x, y) < 0.5 then tuft(x, y, rand(6, 12), math.random(3, 8)) end
  end
end
-- by the reeds at the ends of the mere and along the near shore
patch(395, 590, 14, 6, 18, 5, 10)
patch(935, 580, 12, 6, 16, 5, 10)
patch(560, 612, 20, 3, 10, 3, 6)
patch(780, 604, 20, 3, 10, 3, 6)
print("ok")
