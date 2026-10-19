local lD = pile{{"green earth",1.6},{"raw umber",0.7},{"Prussian blue",0.3},{"yellow ochre",0.45},{"lead white",0.4}, medium=0.07}
local lM = pile{{"lead white",0.9},{"green earth",1.9},{"yellow ochre",0.75},{"pale smalt",0.45},{"raw umber",0.3},{"Prussian blue",0.06}, medium=0.07}
local nz = worley{seed=7700, period=9, jitter=1}
for i,t in ipairs(PW) do
  local H = t.H
  local hx, hy = t.x + t.lean*0.43*H, t.y - 0.43*H
  local under = (CROWNNOW:grow(0.035*H) - CROWNNOW) * PWGAP[i]
  -- keep only hanging lobes: cells chosen by the worley field
  local lobes = under * mask(function(x,y) local d1, d2, wall, id = nz:at(x, y); return (id < 0.45) and 1 or 0 end)
  lobes = lobes:roughen(1, 4, 7710+i) - PWTR[i]:grow(0.5)
  stipple(lobes, {pile=lD, width=math.max(1.1, H*0.014), coverage=1.4, pressure={0.5,0.85}, cluster={0.6, H*0.02}, dips={10,0.7,0.4}})
  stipple(lobes * mask(function(x,y) return x < hx and 1 or 0 end), {pile=lM, width=math.max(1.0, H*0.011), coverage=0.4, pressure={0.45,0.8}, cluster={0.7, H*0.02}, feather=0.6})
end
print(wait(0))
