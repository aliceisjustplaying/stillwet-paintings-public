local silver = pile{{"lead white", 2}, {"green earth", 0.8}, {"pale smalt", 0.35}, {"yellow ochre", 0.3}, medium=0.1}
local silver2 = pile{{"lead white", 2.6}, {"yellow ochre", 0.35}, {"green earth", 0.4}, {"red earth", 0.03}, medium=0.1}
local midg = pile{{"lead white", 1}, {"green earth", 1.4}, {"pale smalt", 0.5}, {"yellow ochre", 0.3}, medium=0.1}
for wi, w in ipairs(WILLOWS) do
  local s = w.h/60
  local upl = w.crown * mask(function(x, y) return ((x - w.hx)*0.7 + (y - (w.hy - w.h*0.35))*0.7 < 2*s) and 1 or 0 end)
  stipple(upl, {pile=midg, width=1.3*s + 0.5, coverage=1.1, cluster=0.6, clip=true, dips={14, 0.5, 0.5}, seed=8700+wi})
  local rim = mask(function(x, y) if w.crown:at(x, y) < 0.5 then return 0 end; return (w.crown:at(x - 2.2*s, y - 2.5*s) < 0.5) and 1 or 0 end)
  stipple(rim:grow(0.8), {pile=silver, width=1.1*s + 0.45, coverage=1.2, cluster=0.5, clip=true, seed=8720+wi})
  stipple(upl * rim:grow(2*s), {pile=silver2, width=0.9*s + 0.4, coverage=0.5, cluster=0.5, clip=true, seed=8740+wi})
  -- scattered leaf-light through the middle of the crown
  stipple(w.crown:shrink(2*s), {pile=silver, width=0.9*s + 0.4, coverage=0.25, cluster=0.7, clip=true, seed=8760+wi})
end
