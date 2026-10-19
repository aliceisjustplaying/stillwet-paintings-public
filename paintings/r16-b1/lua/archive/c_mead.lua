meadL = pile{{"green earth", 2}, {"yellow ochre", 2}, {"lead white", 1.2}, {"raw umber", 0.5}, medium=0.15}
meadD = pile{{"green earth", 2.5}, {"raw umber", 1.5}, {"yellow ochre", 0.6}, {"Prussian blue", 0.08}, medium=0.15}
local mz = (meadowM - bankM2 - riverAll:grow(1.5) - oakM2:grow(2)) * rect(0, 462, 1000, 130)
-- mown strips: bands in perspective, thinner toward the horizon
local mn = noise{seed=91, octaves=2, period=120}
local strips = mask(function(x, y)
  local d = 1 / math.max(1, y - 438)            -- perspective
  local v = math.sin(1 / d * 0.0 + 1800 * d + 0.8*mn(x, y))
  return v > 0.25 and 1 or 0
end)
work(mz * strips, {hand="body", pile=meadL, angle=0, coverage=1.0, length={20,60}, pressure={0.25,0.5}, tool="filbert 5"})
work(mz - strips, {hand="body", pile=meadD, angle=0, coverage=0.7, length={20,60}, pressure={0.25,0.5}, tool="filbert 5"})
