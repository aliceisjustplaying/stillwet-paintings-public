-- snow lying along the tops of the near-horizontal limbs, in broken lengths, heaped in the crotches
limbSnow = pile{{"lead white",6},{"pale smalt",1},{"smalt",0.15},{"vermilion",0.03}, medium=0.12}
local r = brush{kind="round", width=4, point=0.8}
local nS = 0
local function snowAlong(pts, w0, w1, prob)
  local n = #pts
  for i = 1, n - 1 do
    local p, q = pts[i], pts[i + 1]
    local dx, dy = q[1] - p[1], q[2] - p[2]
    local L = math.sqrt(dx * dx + dy * dy)
    local slope = math.abs(dy) / (math.abs(dx) + 1e-6)
    local w = lerp(w0, w1, (i - 0.5) / (n - 1))
    if slope < 0.75 and w >= 1.6 and math.random() < prob then
      local th = math.min(0.42 * w, 3.2) * (1 - slope * 0.8)
      local off = w / 2 - th * 0.35
      local t0, t1 = rand(0, 0.25), rand(0.7, 1)
      local a = {lerp(p[1], q[1], t0), lerp(p[2], q[2], t0) - off}
      local b = {lerp(p[1], q[1], t1), lerp(p[2], q[2], t1) - off}
      local m = {(a[1] + b[1]) / 2, (a[2] + b[2]) / 2 - th * 0.15}
      r:load(limbSnow, 0.7)
      r:stroke({a, m, b}, {pressure={r:pressure_for(th) * 0.6, r:pressure_for(th) * 0.5}, swell={0.6, 1.2, 0.5}, ramps={0.3, 0.35}})
      nS = nS + 1
    end
  end
end
for _, k in ipairs({"L1", "L5", "L2", "L6"}) do
  local b = oakB[k]
  for i = 1, #b.pts - 1 do snowAlong({b.pts[i], b.pts[i + 1]}, b.w[i], b.w[i + 1], 0.85) end
end
for _, s in ipairs(oakSegs) do snowAlong(s.pts, s.w0, s.w1, 0.55) end
for _, s in ipairs(oakSegs2) do snowAlong(s.pts, s.w0, s.w1, 0.55) end
print(nS)
