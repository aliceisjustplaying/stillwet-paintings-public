edgepts = {}
for y = 45, 455, 9 do
  local ex = nil
  for x = 470, 0, -2 do if trees:at(x, y) > 0.5 then ex = x break end end
  if ex then edgepts[#edgepts+1] = {ex, y} end
end
for x = 0, 140, 9 do
  for y = 20, 200, 2 do if trees:at(x, y) > 0.5 then edgepts[#edgepts+1] = {x, y} break end end
end
print(#edgepts)
local b = brush("filbert", 6)
local n = 0
for i, p in ipairs(edgepts) do
  if math.random() < 0.75 then
    local k = math.random(2, 5)
    local out = rand(3, 16)
    local base = (p[2] < 200 and p[1] < 140) and -math.pi/2 or 0
    for j = 1, k do
      if n % 4 == 0 then b:load(pDark2, 0.9) end
      n = n + 1
      local a = base + randn(0, 0.8)
      local d = rand(-4, out)
      local cx = p[1] + d*math.cos(base) + rand(-6,6)*math.sin(base)
      local cy = p[2] + d*math.sin(base) + rand(-6,6)*math.cos(base)
      b:touch(cx, cy, {pressure=rand(0.5,0.9), drag={math.cos(a)*rand(2,6), math.sin(a)*rand(2,6)}, twist=rand(-0.5,0.5), angle=a})
    end
  end
end
print(n)
