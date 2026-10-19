-- snow as a cushion sitting on the limb tops (masks), bulging a little above the bark's edge
local cm = nil
local function cushion(p, q, w, prob)
  local dx, dy = q[1] - p[1], q[2] - p[2]
  local slope = math.abs(dy) / (math.abs(dx) + 1e-6)
  if slope > 0.7 or w < 1.8 or math.random() > prob then return end
  local th = math.min(0.5 * w, 3.6) * (1 - slope * 0.7)
  local t0, t1 = rand(0.0, 0.3), rand(0.65, 1.0)
  local pts, ws = {}, {}
  local n = 6
  for k = 0, n do
    local t = lerp(t0, t1, k / n)
    local x, y = lerp(p[1], q[1], t), lerp(p[2], q[2], t)
    local taper = math.sin(math.pi * k / n) ^ 0.6
    pts[#pts+1] = {x, y - w / 2 + th * 0.1}
    ws[#ws+1] = math.max(0.3, th * taper)
  end
  local r = ribbon(pts, ws)
  cm = cm and (cm + r) or r
end
for _, k in ipairs({"L1", "L5", "L2", "L6"}) do
  local b = oakB[k]
  for i = 1, #b.pts - 1 do cushion(b.pts[i], b.pts[i + 1], (b.w[i] + b.w[i+1]) / 2 * 0.9, 0.9) end
end
for _, list in ipairs({oakSegs, oakSegs2}) do
  for _, s in ipairs(list) do
    for i = 1, #s.pts - 1 do
      local w = lerp(s.w0, s.w1, (i - 0.5) / (#s.pts - 1))
      cushion(s.pts[i], s.pts[i + 1], w, 0.5)
    end
  end
end
-- heaps in the main crotches
cm = cm + ellipse(214, 286, 5, 2.2) + ellipse(262, 296, 6, 2.4) + ellipse(230, 334, 4, 1.8)
limbSnowM = cm:roughen(0.4, 2.5, 29)
work(limbSnowM, {hand="detail", tool={kind="round", width=1.2, point=0.8}, pile=limbSnow, load=0.9, pressure={0.5, 0.8}, coverage=3.5, fill=true, clip=true, angle=0})
