hedgeF = pile{{"green earth", 2.5}, {"raw umber", 0.7}, {"lead white", 2.0}, {"pale smalt", 1.1}, {"yellow ochre", 0.5}, medium=0.1}
hedgeFL = pile{{"green earth", 2}, {"lead white", 2.8}, {"yellow ochre", 1.0}, {"pale smalt", 0.6}, medium=0.1}
local pts = {}
local x = 175
local n = noise{seed=121, period=18, octaves=3}
while x <= 1010 do
  local base = 474.5 - (x - 175) * 0.0015
  local h = 3.2 + 1.8 * n(x, 1)
  -- occasional hedgerow trees
  for _, t in ipairs({{262,11,9},{395,8,7},{548,13,10},{612,7,6},{850,9,8},{975,12,9}}) do
    local d = math.abs(x - t[1])
    if d < t[3] then h = math.max(h, t[2] * math.sqrt(1 - (d/t[3])^2) + 3) end
  end
  pts[#pts+1] = {x, base - math.max(1.5, h)}
  x = x + 2.5
end
local top = {}
for i, p in ipairs(pts) do top[i] = p end
local poly_pts = {{175, 476.5}}
for i, p in ipairs(pts) do poly_pts[#poly_pts+1] = p end
poly_pts[#poly_pts+1] = {1010, 476.5}
hedgerow = poly(poly_pts):roughen(0.9, 3, 122) - willow_heads
stipple(hedgerow, {pile=hedgeF, width=1.8, coverage=5, pressure={0.4,0.7}, clip=hedgerow, cluster=0.25})
local lit = hedgerow * mask(function(px,py) return 1 end) - hedgerow:offset(-1.5)
print(wait(0))
