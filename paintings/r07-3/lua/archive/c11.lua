-- the town's particulars: chimneys on the ridges, a few trees between the houses
local p = brush{kind="round", width=1.1, point=0.5}
p:load("#4c4d5c", 0.8)
for _, c in ipairs({{384,412.5,2.5},{421,410,2},{436.5,409.5,3},{459,409,2.2},{524.5,403.5,2.6},{535,403.5,2},{566,398.5,2.2},{606.5,407.5,2.4},{626,409.5,2}}) do
  p:stroke({{c[1] + randn(0, 0.1), c[2]}, {c[1] + randn(0, 0.15), c[2] - c[3]}}, {pressure={0.75, 0.6}, ramps={0.02, 0.1}})
end
local trees = nil
for i, tr in ipairs({{468, 404, 5, 4.5}, {553, 406, 7, 5}, {644, 409, 7, 4}, {399, 410, 4, 3}}) do
  local pts = {}
  local n = 7
  for k = 0, n do
    local a = math.pi * k / n
    local r = rand(0.75, 1.1)
    pts[#pts+1] = {tr[1] - math.cos(a) * tr[3] * r, tr[2] + 2 - math.sin(a) * tr[4] * r}
  end
  local m = outline{pts=pts, char="soft", lobe=1.6, seed=70 + i}:mask()
  trees = trees and (trees + m) or m
end
work(trees, {hand="detail", tool="round 1.2", angle_jitter=1.5, length={1.5, 4}, coverage=3.2, medium=0.2, pal=farpal, color="#50535f", edge="soft"})
local t = timesheet(); print(string.format("sitting %.0f min", t.sitting))
