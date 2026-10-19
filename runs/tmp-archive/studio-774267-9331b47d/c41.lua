local litrim = mask(function(x, y)
  if TREES2:at(x, y) < 0.5 then return 0 end
  return (TREES2:at(x - 2.5, y - 2) < 0.5) and 1 or 0 end)
local lp = pile{{"lead white", 2.4}, {"pale smalt", 0.6}, {"yellow ochre", 0.5}, {"green earth", 0.5}, {"red earth", 0.05}, medium=0.1}
stipple(litrim:grow(0.5), {pile=lp, width=1.2, coverage=1.1, cluster=0.5, clip=true, dips={10, 0.4, 0.5}, seed=4101})
-- a few darker crown separations inside the woods
local inner = TREES2:shrink(2.5)
local dp = pile{{"pale smalt", 1.1}, {"smalt", 0.5}, {"raw umber", 0.55}, {"bone black", 0.1}, {"lead white", 0.5}, medium=0.15}
stipple(inner, {pile=dp, width=1.2, coverage=0.35, cluster=0.8, clip=true, dips={12, 0.4, 0.5}, seed=4102})
