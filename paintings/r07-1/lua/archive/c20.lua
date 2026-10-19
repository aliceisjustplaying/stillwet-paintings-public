-- the lower bole again, over the bank paint that came up into it; the foot sinks into the bank
local ln = noise{seed=23, period=35}
local low = trunkM * mask(function(x, y) return smoothstep(545 + 14 * ln(x, 0), 575 + 14 * ln(x, 9), y) end)
work(low, {hug=false, hand="body", tool="filbert 4", length={10, 28}, coverage=2.6, medium=0.15, pal=barkpal, angle=-1.57, angle_jitter=0.25,
  color=BARK.dark, edge={found=0.5, soft=0.5, period=20, seed=19}})
-- knobs on the head where the rods sprout: burrs, lumpy against the light
local kb = brush{kind="round", width=5, stiffness=0.6}
for k, kn in ipairs(KNOBS) do
  for j = 1, 3 do
    kb:reload(mix(BARK.body, BARK.dark, rand()), 0.7)
    local x, y = kn[1] + randn(0, 4), kn[2] + randn(0, 2.5) + 3
    kb:touch(x, y, {pressure=rand(0.5, 0.9), drag={randn(0, 0.6), -rand(0.3, 1.2)}, twist=rand(-0.3, 0.3)})
  end
end
-- the furrows carried down over it
local fb = brush{kind="round", width=1.6, point=0.6}
local sn = noise{seed=103, period=30}
for i = 1, 26 do
  local x0 = rand(450, 570)
  local y0, y1 = rand(540, 570), rand(600, 622)
  local pts = {}
  for k = 0, 5 do
    local y = y0 + (y1 - y0) * k / 5
    pts[#pts + 1] = {x0 + 4 * sn(x0, y) + 0.12 * (y - 560) * (x0 - 505) / 60, y}
  end
  if trunkM:at(pts[1][1], pts[1][2]) > 0.5 then
    if i % 5 == 1 then fb:reload(i % 2 == 0 and BARK.cleft or BARK.body, 0.7) end
    fb:stroke(pts, {pressure={rand(0.3, 0.6), rand(0.1, 0.4)}, ramps={0.15, 0.3}, shake=0.6, clip=trunkM})
  end
end
local t = timesheet(); print(t.sitting)
