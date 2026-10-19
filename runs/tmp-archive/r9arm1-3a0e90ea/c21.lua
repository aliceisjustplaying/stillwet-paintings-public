function crow(cx, cy, L, dir, hunch)
  local function R(p) return {cx + dir * p[1] * L, cy + p[2] * L} end
  local pts = {}
  for i, p in ipairs({{-0.5,-0.42},{-0.44,-0.56 - hunch},{-0.3,-0.54 - hunch},{-0.12,-0.36},{0.12,-0.2},{0.3,0.0},{0.58,0.36},{0.66,0.48},{0.5,0.47},{0.34,0.3},{0.12,0.22},{-0.14,0.08},{-0.3,-0.1},{-0.42,-0.28}}) do pts[i] = R(p) end
  local body = poly(pts)
  work(body, {hand="detail", tool=string.format("round %.1f", math.max(0.6, L * 0.12)), length={L * 0.1, L * 0.4}, coverage=4.5, medium=0.12, aim="masstone",
    angle=0.3 * dir, color="#1b191c", edge={found=0.7, soft=0.3, period=L, seed=math.floor(cx)}})
  local b = brush{kind="round", width=math.max(0.5, L * 0.07), point=1}
  b:load("#1b191c", 0.8)
  b:stroke({R{-0.46, -0.47 - hunch}, R{-0.8, -0.43 - hunch}}, {pressure={0.9, 0.0}})           -- beak
  b:stroke({R{-0.02, 0.14}, R{-0.06, 0.34}}, {pressure={0.5, 0.2}})                               -- legs
  b:stroke({R{0.1, 0.2}, R{0.08, 0.36}}, {pressure={0.5, 0.2}})
end
function flying(cx, cy, span, tilt, up)
  local b = brush{kind="round", width=math.max(0.6, span * 0.1), point=1}
  b:load("#29262b", 0.85)
  local h = span * 0.5
  b:stroke({{cx - h, cy - up * h * 0.1 + tilt * h}, {cx - h * 0.6, cy - up * h * 0.45}, {cx - h * 0.25, cy - up * h * 0.2}, {cx - 0.02 * h, cy}}, {pressure={0.05, 0.95}, ramps={0.7, 0.05}})
  b:stroke({{cx + 0.02 * h, cy}, {cx + h * 0.25, cy - up * h * 0.22}, {cx + h * 0.6, cy - up * h * 0.5}, {cx + h, cy - up * h * 0.15 - tilt * h}}, {pressure={0.95, 0.05}, ramps={0.05, 0.7}})
  local bb = brush{kind="round", width=math.max(0.7, span * 0.13), point=0.6}
  bb:load("#29262b", 0.85)
  bb:stroke({{cx - 0.18 * h, cy + 0.02 * h}, {cx + 0.28 * h, cy + 0.06 * h}}, {pressure={0.9, 0.5}})
end
crow(822, 318, 21, 1, 0.05)
crow(918, 262, 19, -1, 0.0)
crow(470, 372, 13, 1, 0.08)
flying(612, 262, 20, 0.1, 1)
flying(588, 287, 16, -0.12, -0.5)
flying(330, 322, 11, 0.05, 0.8)
