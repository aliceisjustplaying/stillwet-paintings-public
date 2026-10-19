dry()
-- his way back through the snow toward the lower right: a trodden furrow, then the dents of his steps,
-- spaced in perspective (the step grows as it nears), none alike
local path = {{713, 621}, {724, 633}, {737, 646}, {752, 660}, {768, 675}, {785, 691}, {803, 709}, {812, 718}}
local function at(u)   -- a point along the path, u in 0..1
  local L, seg = 0, {}
  for i = 1, #path - 1 do seg[i] = math.sqrt((path[i+1][1]-path[i][1])^2 + (path[i+1][2]-path[i][2])^2); L = L + seg[i] end
  local d = u * L
  for i = 1, #path - 1 do
    if d <= seg[i] then local t = d / seg[i]; return lerp(path[i][1], path[i+1][1], t), lerp(path[i][2], path[i+1][2], t) end
    d = d - seg[i]
  end
  return path[#path][1], path[#path][2]
end
-- the furrow: one thin cool drag, broken
local fur = brush{kind="filbert", width=3, stiffness=0.3}
for k = 0, 3 do
  local u0, u1 = k / 4, (k + 1) / 4 - 0.03
  local pts = {}
  for j = 0, 4 do local x, y = at(lerp(u0, u1, j / 4)); pts[#pts + 1] = {x + rand(-0.5, 0.5), y} end
  fur:reload(shift(sample(pts[3][1], pts[3][2], 3), -0.025, 0.001, -0.012), 0.35)
  fur:stroke(pts, {pressure={0.3 + 0.1 * k, 0.5 + 0.1 * k}, ramps={0.2, 0.3}, shake=1})
end
-- the steps
local u, n = 0.0, 0
while u < 1 do
  local x, y = at(u)
  local s = 0.8 + (y - 618) / 28
  n = n + 1
  local side = (n % 2 == 0) and 1 or -1
  local cx, cy = x + side * 1.3 * s + rand(-0.5, 0.5) * s, y + rand(-0.4, 0.4)
  local w = (1.8 + rand(0, 1.2)) * s
  local b = brush{kind="filbert", width=clamp(0.9 * s, 0.9, 5), stiffness=0.4}
  b:load(shift(sample(cx, cy, 2), -0.045 - rand(0, 0.02), 0.002, -0.016), 0.7, {medium=0.2})
  local tilt = rand(-0.25, 0.25) * s
  b:stroke({{cx - w * 0.5, cy + tilt}, {cx + rand(-0.3, 0.3), cy + rand(-0.3, 0.3) * s}, {cx + w * 0.5, cy - tilt}}, {pressure={0.55, 0.45}, ramps={0.2, 0.35}, orient="across", shake=0.8})
  local lp = brush{kind="round", width=clamp(0.35 * s, 0.5, 1.8), point=0.5}
  lp:load(shift(sample(cx, cy - s, 2), 0.035, 0, 0.004), 0.6, {medium=0.15})
  lp:stroke({{cx - w * 0.4 + rand(-0.4, 0.4), cy - 0.6 * s}, {cx + w * 0.4, cy - (0.5 + rand(0, 0.3)) * s}}, {pressure={0.35, 0.15}, ramps={0.2, 0.5}, shake=0.6})
  u = u + (0.028 + 0.05 * u) * rand(0.8, 1.2)
end
print(n, "steps")
