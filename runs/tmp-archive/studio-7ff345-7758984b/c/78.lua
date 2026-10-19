-- a few clusters of withered leaves still hanging on the lower twigs, as young oaks keep them
leafP = pile{{"red earth",1.2},{"raw umber",1.2},{"yellow ochre",0.4},{"bone black",0.1}, medium=0.15}
leafL = pile{{"yellow ochre",1},{"red earth",0.8},{"raw umber",0.5},{"lead white",0.3}, medium=0.15}
local cands = {}
for _, s in ipairs(oakSegs) do
  local p = s.pts[#s.pts]
  if s.depth and s.depth >= 3 and p[2] > 230 and p[2] < 390 and oakDead:at(p[1], p[2]) < 0.2 then cands[#cands+1] = p end
end
print(#cands)
local m = nil
local picked = 0
local used = {}
for i = 1, 400 do
  if picked >= 9 then break end
  local p = cands[math.random(#cands)]
  local ok = true
  for _, q in ipairs(used) do if math.abs(q[1]-p[1]) + math.abs(q[2]-p[2]) < 40 then ok = false end end
  if ok then
    used[#used+1] = p
    picked = picked + 1
    for k = 1, math.random(4, 8) do
      local lx, ly = p[1] + randn(0, 2.2), p[2] + randn(1.5, 1.8)
      local e = ellipse(lx, ly, rand(0.9, 1.6), rand(0.5, 0.9))
      m = m and (m + e) or e
    end
  end
end
leafM = m:roughen(0.3, 1, 61)
work(leafM, {hand="detail", tool={kind="round", width=1, point=0.6}, pile=leafP, load=0.9, pressure={0.5, 0.8}, coverage=3, fill=true, clip=true, angle=0.5, angle_jitter=1})
work(leafM:shrink(0.4) * mask(function(x, y) return (math.sin(x * 1.7 + y * 2.3) > 0.3) and 1 or 0 end), {hand="detail", tool={kind="round", width=0.8, point=0.6}, pile=leafL, load=0.6, pressure={0.4, 0.6}, coverage=2, fill=true, clip=true})
for _, q in ipairs(used) do print(q[1], q[2]) end
