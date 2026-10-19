LWATER = WATER * mask(function(x, y) return x < 330 and 1 or 0 end)
local wp = pile{{"lead white", 2.6}, {"pale smalt", 1.4}, {"smalt", 0.55}, {"raw umber", 0.05}, {"yellow ochre", 0.05}, medium=0.15}
work(LWATER, {hand="detail", tool={kind="round", width=2.2, point=0.4}, pile=wp, angle=-0.12, coverage=2.5, fill=true, seed=5001})
-- the far bank: a dark shaded lip along the upper edge of the water
local bank = mask(function(x, y) if x > 332 then return 0 end
  local v = LWATER:at(x, y); if v > 0.5 then return 0 end
  return (LWATER:at(x, y + 1.6) > 0.5) and 1 or 0 end):grow(0.5)
local bp = pile{{"raw umber", 1}, {"green earth", 1}, {"bone black", 0.15}, {"yellow ochre", 0.3}, medium=0.15}
work(bank, {hand="detail", tool={kind="round", width=1.2, point=0.6}, pile=bp, angle=-0.12, coverage=2, fill=true, seed=5002})
-- taper the end: grass over the last stretch
local endm = WATER:grow(2) * mask(function(x, y) return x > 300 and 1 or 0 end) * mask(function(x, y) return (x - 300)/36 > rand(0,1)*0 + ((y*7.3) % 1)*0.9 and 1 or 0 end)
local gp = pile{{"green earth", 2}, {"yellow ochre", 1.2}, {"lead white", 0.5}, {"raw umber", 0.2}, {"Prussian blue", 0.04}, medium=0.15}
work(WATER:grow(2) * rect(318, 0, 30, 700), {hand="detail", tool={kind="round", width=1.6, point=0.6}, pile=gp, angle=-0.15, coverage=2.2, fill=true, seed=5003})
