local fronts = {
  pile{{"lead white", 3}, {"pale smalt", 1.3}, {"red earth", 0.35}, {"raw umber", 0.3}, medium=0.1},
  pile{{"lead white", 3}, {"pale smalt", 1.6}, {"raw umber", 0.45}, {"smalt", 0.2}, medium=0.1},
  pile{{"lead white", 4}, {"pale smalt", 1.0}, {"yellow ochre", 0.3}, {"red earth", 0.1}, medium=0.1},
  pile{{"lead white", 3}, {"pale smalt", 1.2}, {"red earth", 0.5}, {"yellow ochre", 0.15}, medium=0.1},
}
local towers = spJ + rect(262,389,10,52) + spN1 + rect(322,377,9,64) + rect(420,371,26,70)
local x = 226
local k = 0
while x < 592 do
  k = k + 1
  local w = rand(6, 14)
  local m = rect(x, 428.5, w, 12) - towers
  local p = fronts[1 + (k * 7 + math.floor(rand(0, 3))) % 4]
  work(m, {hand="detail", pile=p, angle=math.pi/2, coverage=2.4, length={1.5,4}, fill=true, clip=true, edge="found"})
  x = x + w
end
-- windows as tiny dark dots in a few fronts
local r = brush{kind="round", width=0.8, point=0.8}
r:load(acc, 0.35)
for i = 1, 40 do
  local wx = rand(230, 588)
  if towers:at(wx, 434) < 0.1 then r:touch(wx, rand(432, 436), {pressure=0.3}) end
end
print(wait(0))
