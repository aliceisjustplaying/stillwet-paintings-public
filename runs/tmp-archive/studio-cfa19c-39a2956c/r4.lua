local R = riverM:shrink(0.3)
local zone = nil
for i,w in ipairs({{505,14},{560,18},{626,22},{702,27},{792,33},{884,38},{978,44}}) do
  local x, s = w[1], w[2]
  local yb = interp(farBank, x)
  local e = ellipse(x, yb + 0.6*s, 0.6*s, 0.45*s)
  zone = zone and (zone + e) or e
end
blend(zone * R, {tool={kind="badger", width=5}, angle=0.14, coverage=1.3, clip=true, pressure={0.2,0.35}, seed=3021})
blend(zone * R, {tool={kind="badger", width=4}, angle=math.pi/2, coverage=0.8, clip=true, pressure={0.2,0.3}, seed=3022})
