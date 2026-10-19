local pu = pile{{"green earth", 2}, {"yellow ochre", 1.3}, {"chrome yellow", 0.18}, {"lead white", 0.95}, {"Prussian blue", 0.04}, medium=0.12}
-- converging banks: cover the water's edges more and more toward its end
local taper = LWATER:grow(0.5) * mask(function(x, y)
  if x < 312 then return 0 end
  local sy, sw = STREAMY(x)
  local k = clamp((x - 312)/18, 0, 1)
  local half = sw/2 * (1 - k)
  return (math.abs(y - sy) > half) and 1 or 0 end)
local patch = (WATER:grow(3) * rect(329, 0, 22, 700)) + taper
work(patch, {hand="detail", tool={kind="round", width=1.2, point=0.5}, pile=pu, angle=-0.1, coverage=3, fill=true, seed=10901})
-- a few rushes where the ditch runs out
local rush = pile{{"green earth", 1.4}, {"raw umber", 0.6}, {"yellow ochre", 0.5}, medium=0.1}
local rl = pile{{"yellow ochre", 1}, {"green earth", 0.8}, {"lead white", 0.5}, medium=0.1}
local b = brush{kind="round", width=0.6, point=1}
for i=1,26 do
  local x = rand(318, 336)
  local sy = STREAMY(x)
  local y = sy + rand(-2.5, 2.5)
  local h = rand(3, 7)
  b:load((i % 3 == 0) and rl or rush, 0.4)
  b:stroke({{x, y}, {x + rand(-1, 1), y - h}}, {pressure={0.35, 0}, ramps={0.05, 0.6}})
end
