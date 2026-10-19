local b = brush("filbert", 7)
local n = 0
for i, p in ipairs(edgepts) do
  if math.random() < 0.45 and p[2] < 440 then
    local top = (p[2] < 200 and p[1] < 140)
    local base = top and -math.pi/2 or (-0.5 + rand(-0.4, 0.4))
    local d = rand(10, 24)
    local cx = p[1] + d*math.cos(base)
    local cy = p[2] + d*math.sin(base)
    local k = math.random(4, 8)
    local r = rand(5, 10)
    for j = 1, k do
      if n % 3 == 0 then b:load(pDark2, 0.95) end
      n = n + 1
      local t = j / k
      -- touches from the clump back toward the edge so it stays attached
      local px = lerp(cx, p[1] - 4*math.cos(base), t*0.8) + rand(-r, r)
      local py = lerp(cy, p[2] - 4*math.sin(base), t*0.8) + rand(-r, r)
      local a = rand(0, math.pi)
      b:touch(px, py, {pressure=rand(0.7,1.0), drag={math.cos(a)*rand(2,5), math.sin(a)*rand(2,5)}, twist=rand(-0.6,0.6), angle=a})
    end
  end
end
print(n)
