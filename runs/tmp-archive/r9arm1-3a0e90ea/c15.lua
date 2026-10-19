FX, FY = 674, 522
TRACK = {{770,714},{742,664},{712,610},{692,568},{680,540},{674,522},{671,508},{676,497},{694,488},{716,481.5}}
KF = 1.7 * 500 / math.tan(math.rad(25))     -- ground: y - HZ = KF / Z (fov 50 over the width)
-- footprints in two broken lines, each step 0.36 m on the ground: distinct near, a trodden furrow far off
local side = 1
for i = 1, #TRACK - 1 do
  local a, b = TRACK[i], TRACK[i + 1]
  local dx, dy = b[1] - a[1], b[2] - a[2]
  local L = math.sqrt(dx * dx + dy * dy)
  local t = rand(0, 1)
  while t < L do
    local x, y = a[1] + dx * t / L, a[2] + dy * t / L
    local s = per_m(y)
    local hidden = (i == 5 or i == 6) and y < FY + 1 and y > FY - 14    -- under the walker
    if s > 3 and not hidden then
      local cx, cy = x + side * 0.1 * s + randn(0, 0.03 * s), y + randn(0, 0.01 * s)
      local w = 0.12 * s * rand(0.75, 1.2)
      local fb = brush{kind="filbert", width=math.max(0.6, 0.04 * s), stiffness=0.4}
      fb:load(shift(snowcol(cx, cy), -0.06 - 0.03 * rand(), -0.002, -0.022), 0.5)
      fb:stroke({{cx - w / 2, cy - 0.006 * s}, {cx + randn(0, 0.02 * s), cy + 0.012 * s}, {cx + w / 2, cy - 0.004 * s}}, {pressure={0.5, 0.35}, shake=0.6})
      if s > 25 and rand() < 0.7 then
        local lb = brush{kind="round", width=math.max(0.5, 0.02 * s), point=0.4}
        lb:load(shift(snowcol(cx, cy), 0.03, 0, 0.006), 0.5)
        lb:stroke({{cx - w * 0.4, cy - 0.03 * s}, {cx + w * 0.45, cy - 0.034 * s}}, {pressure={0.45, 0.2}, shake=0.6})
      end
    end
    side = -side
    local dz = 0.36 * rand(0.85, 1.15)
    local ystep = dz * (y - HZ)^2 / KF                   -- canvas y for that step on the ground
    local slope = math.abs(dy) / L
    t = t + math.max(0.35, ystep / math.max(0.3, slope))
  end
end
