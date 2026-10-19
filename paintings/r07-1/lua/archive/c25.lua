-- the bole straighter: its waist filled out on both flanks (a pollard's bole is a post, not a vase)
TRUNKB = {{436,620},{447,604},{452,584},{449,562},{446,540},{441,518},{437,496},{428,478},{434,462},{452,454},{474,446},{497,451},{517,441},{540,447},{557,457},{569,472},{562,488},{555,502},{556,524},{558,548},{561,572},{568,598},{584,618}}
trunkB = outline{pts=TRUNKB, char="broken", amount=0.5, seed=131}:mask()
local add = trunkB - trunkM:shrink(1)
work(add, {hand="detail", tool="round 2.5", length={8, 24}, coverage=2.8, medium=0.15, pal=barkpal, clip=false,
  angle=-1.57, angle_jitter=0.2, color=function(x, y) return mix(BARK.body, BARK.dark, smoothstep(470, 610, y) * 0.7) end,
  edge={found=0.6, soft=0.4, period=20, seed=23}})
trunkM = trunkM + trunkB
local fb = brush{kind="round", width=1.4, point=0.6}
local sn = noise{seed=133, period=30}
for i = 1, 16 do
  local left = i % 2 == 0
  local x0 = left and rand(441, 458) or rand(546, 560)
  local y0, y1 = rand(480, 520), rand(560, 610)
  local pts = {}
  for k = 0, 5 do local y = y0 + (y1 - y0) * k / 5; pts[#pts + 1] = {x0 + 3 * sn(x0, y), y} end
  if i % 4 == 1 then fb:reload(i % 8 == 1 and BARK.cleft or BARK.dark, 0.7) end
  fb:stroke(pts, {pressure={rand(0.3, 0.55), rand(0.1, 0.3)}, ramps={0.15, 0.3}, shake=0.6, clip=trunkM})
end
local t = timesheet(); print(t.sitting)
