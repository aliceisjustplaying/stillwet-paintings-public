local sil = BOULD
local ang = BF:field("across")
local cool = pile{{"lead white", 1}, {"pale smalt", 0.7}, {"raw umber", 0.3}, {"bone black", 0.05}, medium=0.1}
local warm = pile{{"lead white", 1.6}, {"yellow ochre", 0.35}, {"raw umber", 0.2}, {"red earth", 0.04}, medium=0.1}
local midm = sil * mask(function(x, y) return (BF:value(x, y) > 0.42) and 1 or 0 end)
work(midm, {hand="scumble", tool="filbert 3", pile=cool, angle=ang, length={4,10}, coverage=1.3, pressure={0.3, 0.5}, clip=true, seed=9201})
local top = sil * mask(function(x, y)
  local tp = 572 + 0.004*(x - 800)^2
  return (BF:value(x, y) > 0.6 and y < tp + 14 + 4*math.sin(x/6)) and 1 or 0 end)
work(top, {hand="scumble", tool="filbert 2", pile=warm, angle=ang, length={3,8}, coverage=1.4, pressure={0.35, 0.55}, clip=true, seed=9202})
