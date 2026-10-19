-- cover the stray spike near x 290
local bush = (ellipse(292, far(292) - 5, 9, 6) + ellipse(283, far(283) - 3, 6, 4) + ellipse(301, far(301) - 3.5, 5, 4)):roughen(1, 4, 9) * above(function(x) return far(x) + 2.5 end)
local tp = pile{{"pale smalt", 1.4}, {"lead white", 1.1}, {"green earth", 0.7}, {"raw umber", 0.35}, {"bone black", 0.07}, medium=0.1}
work(bush, {hand="detail", pile=tp, coverage=2.2, fill=true, seed=3301})
TREES2 = TREES2 + bush
-- light on the crowns from the low sun at left: upper-left rims
local litrim = mask(function(x, y)
  if TREES2:at(x, y) < 0.5 then return 0 end
  return (TREES2:at(x - 2.2, y - 2.2) < 0.5) and 1 or 0 end)
local lp = pile{{"lead white", 2.2}, {"pale smalt", 0.7}, {"yellow ochre", 0.45}, {"green earth", 0.5}, {"red earth", 0.04}, medium=0.1}
stipple(litrim:grow(0.6), {pile=lp, width=1.3, coverage=1.4, cluster=0.5, clip=true, seed=3302})
-- darker undersides and gaps between crowns
local lower = TREES2 * mask(function(x, y) local f = far(x); return (y > f - 4 and y < f + 3) and 1 or 0 end)
local dp = pile{{"pale smalt", 1.2}, {"smalt", 0.5}, {"raw umber", 0.5}, {"bone black", 0.1}, {"lead white", 0.6}, medium=0.15}
stipple(lower, {pile=dp, width=1.4, coverage=0.9, cluster=0.5, clip=true, seed=3303})
