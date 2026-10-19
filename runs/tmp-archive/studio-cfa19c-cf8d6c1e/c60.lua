local n = noise{seed=71, octaves=3, period=14}
local hedge = poly((function()
  local pts = {}
  for x=-5,372,4 do pts[#pts+1] = {x, 458 + 0.012*x - 4 - 3.5*math.max(0,n(x,0)) - 1.5*n(x,50)} end
  for x=372,-5,-4 do pts[#pts+1] = {x, 461 + 0.014*x} end
  return pts
end)(), true)
hedgeM = hedge - (oakM:grow(1) + oakSil:grow(1) + trunkM:grow(1))
hd = pile{{"green earth",1.5},{"Prussian blue",0.35},{"raw umber",0.6},{"lead white",1.2}, medium=0.06}
stipple(hedgeM, {pile=hd, width=2.2, coverage=2.2, pressure={0.4,0.8}, cluster={0.4,3}, feather=0.4, clip=hedgeM:grow(1.2), dips={20,0.6,0.2}, seed=381})
-- a few taller hedgerow trees
for i,t in ipairs({{28,5},{75,6},{340,5}}) do
  local x, r = t[1], t[2]
  local y = 456 + 0.012*x
  local m = ellipse(x, y - r*1.3, r, r*1.3):roughen(1, 3, i) - (oakM:grow(1) + oakSil:grow(1))
  stipple(m, {pile=hd, width=2, coverage=2.5, pressure={0.4,0.8}, clip=m:grow(0.8), seed=390+i})
end
