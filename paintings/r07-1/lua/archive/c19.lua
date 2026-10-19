-- close the gap round the bole: the bark carried a little past the drawn line
trunk2 = trunkM:grow(2.5)
work(trunk2 - trunkM:shrink(2), {hand="detail", tool="round 2.5", length={6, 18}, coverage=2.6, medium=0.15, pal=barkpal, clip=false,
  angle=function(x, y) return -1.57 + 0.004 * (x - 500) end, color=BARK.body, edge={found=0.5, soft=0.5, period=20, seed=17}})
-- furrows: long wavering vertical lines of the darkest bark, and the cleft
local fb = brush{kind="round", width=1.6, point=0.6}
local sn = noise{seed=101, period=30}
for i = 1, 38 do
  local x0 = rand(445, 560)
  local y0, y1 = rand(470, 520), rand(560, 620)
  local pts = {}
  for k = 0, 6 do
    local y = y0 + (y1 - y0) * k / 6
    pts[#pts + 1] = {x0 + 5 * sn(x0, y) + 0.06 * (y - 540) * (x0 - 500) / 60, y}
  end
  if trunkM:at(pts[1][1], pts[1][2]) > 0.5 and trunkM:at(pts[#pts][1], pts[#pts][2]) > 0.5 then
    if i % 5 == 1 then fb:reload(BARK.dark, 0.7) end
    fb:stroke(pts, {pressure={rand(0.3, 0.6), rand(0.1, 0.4)}, ramps={0.15, 0.3}, shake=0.6, clip=trunkM})
  end
end
fb:reload(BARK.cleft, 0.9)
fb:stroke({{516,452},{520,480},{514,510},{518,540},{512,566},{516,590}}, {pressure={0.9, 0.7, 0.4}, ramps={0.1, 0.4}, shake=0.5})
fb:stroke({{519,456},{522,478},{517,506},{520,530}}, {pressure={0.9, 0.3}, ramps={0.1, 0.4}, shake=0.5})
-- ridges between the furrows, lit faintly by the sky on the left and on the top of the head
local rb = brush{kind="round", width=1.2, point=0.5}
for i = 1, 40 do
  local x0 = rand(440, 540)
  local y0 = rand(450, 590)
  local len = rand(8, 30)
  local lit = smoothstep(530, 440, x0) * 0.6 + smoothstep(500, 455, y0) * 0.5
  if trunkM:shrink(1.5):at(x0, y0) > 0.5 and rand() < 0.3 + lit then
    rb:reload(mix(BARK.ridge, BARK.rim, clamp(lit, 0, 1) * 0.5), 0.5)
    rb:stroke({{x0, y0}, {x0 + randn(0, 1.2), y0 + len * 0.5}, {x0 + randn(0, 1.5), y0 + len}}, {pressure={0.35, 0.1}, ramps={0.2, 0.5}, clip=trunkM})
  end
end
-- the cool rim of sky light: a few broken strokes just inside the upper left flank and the head
local rimb = brush{kind="round", width=1.1, point=0.6}
local P = TRUNK
for k = 4, 13 do
  local a, b = P[k], P[k + 1]
  if rand() < 0.75 then
    local dx, dy = b[1] - a[1], b[2] - a[2]
    local L = math.sqrt(dx * dx + dy * dy)
    local nx, ny = dy / L, -dx / L         -- inward for this (counterclockwise on screen) run
    if trunkM:at(a[1] + nx * 3, a[2] + ny * 3) < 0.5 then nx, ny = -nx, -ny end
    local t0, t1 = rand(0, 0.3), rand(0.6, 1)
    local off = rand(1.0, 2.2)
    rimb:reload(mix(BARK.rim, BARK.ridge, rand(0.2, 0.6)), 0.5)
    rimb:stroke({{a[1] + dx * t0 + nx * off, a[2] + dy * t0 + ny * off}, {a[1] + dx * t1 + nx * (off + randn(0, 0.4)), a[2] + dy * t1 + ny * (off + randn(0, 0.4))}},
      {pressure={rand(0.25, 0.45), rand(0.05, 0.2)}, ramps={0.25, 0.5}, shake=0.4})
  end
end
local t = timesheet(); print(t.sitting)
