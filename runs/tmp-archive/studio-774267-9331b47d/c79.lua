local sil = BOULD
local ang = BF:field("across")
local midp = pile{{"raw umber", 0.7}, {"pale smalt", 0.6}, {"lead white", 0.55}, {"bone black", 0.15}, {"yellow ochre", 0.1}, medium=0.08}
-- lower part of the stone turns away from the light and into the grass shade
local low = sil * mask(function(x, y)
  local top = 572 + 0.004*(x - 800)^2
  return (y > top + 14 + 6*math.sin(x/9)) and 1 or 0 end)
work(low, {hand="body", tool="filbert 3", pile=midp, angle=ang, length={5,12}, coverage=2.2, fill=true, clip=true, seed=7901})
local dark = pile{{"raw umber", 1}, {"smalt", 0.4}, {"bone black", 0.45}, {"lead white", 0.1}, medium=0.08}
local base = sil * mask(function(x, y) return (y > 612 + 3*math.sin(x/7)) and 1 or 0 end)
work(base, {hand="body", tool="filbert 3", pile=dark, angle=0, length={5,12}, coverage=2, fill=true, clip=true, seed=7902})
blend(sil, {angle=ang, length={6,14}, coverage=0.7, seed=7903})
