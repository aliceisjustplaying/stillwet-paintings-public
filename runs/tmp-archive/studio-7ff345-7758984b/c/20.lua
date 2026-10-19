-- secondary and higher branches, grown from the boughs by oak habit:
-- crooked, kinked at nodes, clustered forks at the tips, widths by the branch-area rule
oakSegs = {}
local function adiff(a, b) local d = a - b; while d > math.pi do d = d - 2*math.pi end; while d < -math.pi do d = d + 2*math.pi end; return d end
local function inCrown(x, y)
  local dx, dy = (x - 250) / 250, (y - 215) / 150
  return dx*dx + dy*dy
end
function growOak(x, y, a, w, depth, dead)
  local len = (dead and 7 or 10) * w + rand(10, 22)
  if w < 1.2 then len = rand(10, 24) end
  local n = math.max(2, math.floor(len / 9))
  local path, kink = {{x, y}}, (math.random() < 0.5) and 1 or -1
  for i = 1, n do
    kink = -kink
    a = a + kink * rand(0.08, 0.3) + randn(0, 0.12) - 0.10 * adiff(a, -math.pi/2) * (dead and 1.5 or 1)
    if math.sin(a) > 0.35 then a = a - 0.25 end
    local s = len / n
    x = x + math.cos(a) * s; y = y + math.sin(a) * s
    path[#path+1] = {x, y}
    if inCrown(x, y) > 1.05 and not dead then break end
  end
  local w1 = w * 0.7
  oakSegs[#oakSegs+1] = {pts=path, w0=w, w1=w1, dead=dead, depth=depth}
  if dead then
    if w > 3 and depth < 2 then growOak(x, y, a + rand(-0.6, 0.6), w * 0.6, depth + 1, true) end
    return
  end
  if w1 < 0.5 or depth > 6 then return end
  -- clustered fork at the tip (acrotony): 2-3 children
  local k = (math.random() < 0.4) and 3 or 2
  local shares, tot = {}, 0
  for i = 1, k do shares[i] = rand(0.5, 1.5); tot = tot + shares[i] end
  local spread = rand(0.5, 0.9)
  for i = 1, k do
    local cw = w1 * math.sqrt(shares[i] / tot) * 1.05
    local ca = a + (i - (k + 1) / 2) * spread + randn(0, 0.15)
    growOak(x, y, ca, cw, depth + 1, false)
  end
  -- a lateral from mid-segment
  if #path > 2 and w > 1.5 and math.random() < 0.7 then
    local p = path[math.floor(#path / 2) + 1]
    growOak(p[1], p[2], a + ((math.random() < 0.5) and -1 or 1) * rand(0.6, 1.0), w * rand(0.35, 0.5), depth + 1, false)
  end
end
-- spawn from the main boughs
local function along(b, every, dead, wscale)
  local pts, ws = b.pts, b.w
  local side = 1
  for i = 1, #pts - 1 do
    local x0, y0, x1, y1 = pts[i][1], pts[i][2], pts[i+1][1], pts[i+1][2]
    local a = math.atan(y1 - y0, x1 - x0)
    local segl = math.sqrt((x1-x0)^2 + (y1-y0)^2)
    local t = rand(0.2, 0.8)
    if i > 1 and math.random() < every then
      side = -side
      local w = (ws[i] + ws[i+1]) / 2
      local off = w / 2 * 0.8
      local px, py = lerp(x0, x1, t), lerp(y0, y1, t)
      local ca = a + side * rand(0.5, 1.0)
      px = px + math.cos(ca) * off * 0.5; py = py + math.sin(ca) * off * 0.5
      growOak(px, py, ca, w * rand(0.3, 0.55) * wscale, dead and 1 or 1, dead)
    end
  end
  -- continue the tip
  local n = #pts
  local a = math.atan(pts[n][2] - pts[n-1][2], pts[n][1] - pts[n-1][1])
  if not dead then
    growOak(pts[n][1], pts[n][2], a - 0.3, ws[n] * 0.75, 1, false)
    growOak(pts[n][1], pts[n][2], a + 0.4, ws[n] * 0.6, 1, false)
  end
end
along(oakB.L1, 0.95, false, 1)
along(oakB.L2, 0.95, false, 1)
along(oakB.L5, 0.95, false, 1)
along(oakB.L3, 0.5, true, 0.8)
along(oakB.L4, 0.5, true, 0.8)
-- a few boughs straight out of the trunk crotch into the live crown
growOak(226, 292, -2.3, 9, 1, false)
growOak(256, 296, -0.9, 8, 1, false)
growOak(218, 330, -2.8, 6, 1, false)
growOak(262, 326, -0.35, 6, 1, false)
local c = {0, 0, 0}
for _, s in ipairs(oakSegs) do
  if s.w0 >= 3 then c[1] = c[1] + 1 elseif s.w0 >= 1.2 then c[2] = c[2] + 1 else c[3] = c[3] + 1 end
end
print(#oakSegs, c[1], c[2], c[3])
