local R = riverM
local zone = nil
for i,w in ipairs({{452,11},{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local yb = interp(farBank, x)
  local e = ellipse(x, yb + 0.55*s, 0.5*s, 0.35*s)
  zone = zone and (zone + e) or e
end
zone = zone * R:shrink(0.3)
blend(zone, {tool={kind="badger", width=4}, angle=math.pi/2, coverage=1.5, seed=481})
blend(zone, {tool={kind="badger", width=4}, angle=0.1, coverage=0.8, seed=482})
