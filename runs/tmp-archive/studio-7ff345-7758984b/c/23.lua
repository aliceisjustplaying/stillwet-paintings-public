-- lower, drooping and horizontal branches under the big boughs, and a net of fine twiglets
oakSegs2 = {}
local function adiff(a, b) local d = a - b; while d > math.pi do d = d - 2*math.pi end; while d < -math.pi do d = d + 2*math.pi end; return d end
function growDroop(x, y, a, w, depth)
  local len = 9 * w + rand(12, 24)
  if w < 1.2 then len = rand(10, 22) end
  local n = math.max(2, math.floor(len / 9))
  local path, kink = {{x, y}}, (math.random() < 0.5) and 1 or -1
  for i = 1, n do
    kink = -kink
    -- droop first, then the tips turn up a little
    local g = (depth < 3) and 0.07 or -0.06
    a = a + kink * rand(0.08, 0.28) + randn(0, 0.1) + g * math.cos(a) * ((math.cos(a) > 0) and 1 or -1)
    x = x + math.cos(a) * len / n; y = y + math.sin(a) * len / n
    path[#path+1] = {x, y}
  end
  local w1 = w * 0.7
  oakSegs2[#oakSegs2+1] = {pts=path, w0=w, w1=w1, depth=depth}
  if w1 < 0.5 or depth > 6 or y > 395 then return end
  local k = (math.random() < 0.4) and 3 or 2
  local shares, tot = {}, 0
  for i = 1, k do shares[i] = rand(0.5, 1.5); tot = tot + shares[i] end
  for i = 1, k do
    growDroop(x, y, a + (i - (k + 1) / 2) * rand(0.5, 0.8) + randn(0, 0.12), w1 * math.sqrt(shares[i] / tot) * 1.05, depth + 1)
  end
end
-- from the undersides of L1 (going left) and L5 (going right)
for _, s in ipairs({{120, 257, math.pi - 0.1, 4}, {170, 268, math.pi - 0.35, 5}, {80, 256, math.pi + 0.05, 3},
                    {300, 300, 0.25, 5}, {360, 296, 0.15, 4}, {420, 302, 0.05, 3}, {205, 290, math.pi - 0.6, 4},
                    {228, 340, math.pi - 0.2, 3}, {262, 312, 0.5, 3.5}}) do
  growDroop(s[1], s[2], s[3], s[4], 1)
end
local n = 0
for _, s in ipairs(oakSegs2) do n = n + paintSeg(s, 0, 1000) end
print(#oakSegs2, n)
