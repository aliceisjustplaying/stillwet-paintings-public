function crestY(x)
  for i = 1, #bankPts - 1 do
    local a, b = bankPts[i], bankPts[i+1]
    if x >= a[1] and x <= b[1] then
      local t = (x - a[1]) / (b[1] - a[1]); t = t*t*(3-2*t)
      return lerp(a[2], b[2], t)
    end
  end
  return bankPts[#bankPts][2]
end
keepOut = figM:grow(2) + oakM2:grow(1) + flare2:grow(1)
local band = (bankM2 * above(function(x) return crestY(x) + 30 end)) - keepOut
crestP = pile{{"raw umber", 2.4}, {"green earth", 2.4}, {"yellow ochre", 0.7}, {"bone black", 0.45}, medium=0.08}
work(band, {hand="body", pile=crestP, angle=-1.3, coverage=2.5, fill=true, clip=true, length={6,16}, tool="filbert 5"})
-- the halo at the oak foot
local halo = ellipse(305, 590, 64, 22) * bankM2 - flare2 - oakM2
work(halo, {hand="body", pile=crestP, angle=-1.3, coverage=2.5, fill=true, clip=true, length={6,14}, tool="filbert 5"})
