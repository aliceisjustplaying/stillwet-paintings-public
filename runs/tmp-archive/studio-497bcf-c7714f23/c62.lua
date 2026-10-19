skyH2 = pile{{"lead white", 10}, {"yellow ochre", 0.5}, {"chrome yellow", 0.12}, {"vermilion", 0.05}, {"pale smalt", 0.14}, medium=0.08}
-- design the new group: three limes
lime_trees = {
  {bx=42, by=468, fx=44, fy=442, cx=46, cy=414, rx=40, ry=38, limbs={-2.3,-1.95,-1.6,-1.25,-0.9,-2.7,-0.5}},
  {bx=110, by=471, fx=111, fy=436, cx=112, cy=404, rx=42, ry=46, limbs={-2.4,-2.0,-1.7,-1.45,-1.15,-0.8,-2.8,-0.4}},
  {bx=170, by=472, fx=170, fy=452, cx=170, cy=433, rx=26, ry=26, limbs={-2.3,-1.8,-1.3,-0.8}},
}
clumps = {}
local sil
for ti, t in ipairs(lime_trees) do
  t.limbpts = {}
  for li, a in ipairs(t.limbs) do
    local L = math.sqrt((t.rx*math.cos(a))^2 + (t.ry*math.sin(a))^2) * rand(0.8, 1.0)
    local ex = t.cx + L * math.cos(a) * 1.05
    local ey = t.cy + L * math.sin(a) * 0.95 + 8
    local mx = lerp(t.fx, ex, 0.5) + rand(-4, 4)
    local my = lerp(t.fy, ey, 0.5) - rand(0, 6)
    t.limbpts[li] = {{t.fx, t.fy}, {mx, my}, {ex, ey}}
    for k = 1, 3 do
      local u = 0.45 + 0.28 * k
      local px = lerp(lerp(t.fx, mx, u), lerp(mx, ex, u), u)
      local py = lerp(lerp(t.fy, my, u), lerp(my, ey, u), u)
      local r = (t.rx * 0.23) * rand(0.75, 1.2) * (1.1 - 0.15 * k)
      clumps[#clumps+1] = {x=px + rand(-3,3), y=py + rand(-3,3), r=r, t=ti}
    end
  end
  -- inner filling clumps, leaving some air
  for k = 1, 6 do
    local a = rand(0, 2*math.pi)
    local d = rand(0.1, 0.55)
    clumps[#clumps+1] = {x=t.cx + t.rx*d*math.cos(a), y=t.cy + t.ry*d*math.sin(a) + 6, r=t.rx*rand(0.18, 0.26), t=ti}
  end
end
for i, c in ipairs(clumps) do
  local e = ellipse(c.x, c.y, c.r * 1.15, c.r * 0.9)
  sil = sil and (sil + e) or e
end
lime_sil = sil:roughen(2.2, 5, 81) * above({{0,470},{1000,470}})
local old = ((crownA + crownB + crownC) * above({{0,478},{1000,478}})):grow(5)
local skypatch = (old - lime_sil:shrink(1)) * above({{0,440.5},{1000,440.5}})
work(skypatch, {hand="detail", pile=skyH2, angle=0.2, coverage=2.5, length={3,9}, fill=true, clip=true, edge="firm"})
local lowpatch = (old - lime_sil:shrink(1)) - above({{0,440.5},{1000,440.5}})
work(lowpatch, {hand="detail", pile=mAB, angle=0, coverage=2.5, length={3,9}, fill=true, clip=true, edge="firm"})
print(#clumps, lime_sil:area(), wait(0))
