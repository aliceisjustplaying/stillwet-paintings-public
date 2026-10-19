local n = noise{seed=77, octaves=3, period=22}
local hedge2 = poly((function()
  local pts = {}
  for x=-5,374,3 do pts[#pts+1] = {x, 456 + 0.012*x - 2.5*math.max(0,n(x,0)+0.3) - 1.2*n(x,30)} end
  for x=374,-5,-4 do pts[#pts+1] = {x, 462 + 0.014*x} end
  return pts
end)(), true)
local hm = hedge2 - (oakM:grow(1) + oakSil:grow(1) + trunkM:grow(1))
local hdk = pile{{"green earth",1.5},{"yellow ochre",0.8},{"raw umber",0.7},{"Prussian blue",0.15},{"lead white",1.3}, medium=0.06}
local hlt = pile{{"lead white",2},{"green earth",1},{"yellow ochre",1},{"pale smalt",0.3}, medium=0.06}
stipple(hm, {pile=hdk, width=2.2, coverage=2.5, pressure={0.5,0.9}, cluster={0.4,4}, clip=hm:grow(1), seed=431})
local top = hm * mask(function(x,y) return smoothstep(459+0.013*x, 455+0.013*x, y) end)
stipple(top, {pile=hlt, width=1.6, coverage=0.8, pressure={0.35,0.7}, cluster={0.6,4}, clip=hm, seed=432})
