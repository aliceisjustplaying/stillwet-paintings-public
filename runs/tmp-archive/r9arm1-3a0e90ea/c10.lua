wait(8*60)
local function k(y) return 1 + 7 * clamp((y - HZ) / (H - HZ), 0, 1) end
FARBANK = mask(function(x, y) return STREAMM:at(x, y) * (1 - STREAMM:at(x, y - k(y))) end):roughen(0.6, 8, 12, 0.4)
NEARLIP = mask(function(x, y) return STREAMM:at(x, y) * (1 - STREAMM:at(x, y + 0.6 * k(y))) end):roughen(0.8, 10, 13, 0.4)
work(FARBANK, {hand="detail", tool="round 1.5", length={4, 14}, coverage=3.5, medium=0.18, angle=0, angle_jitter=0.2,
  color=function(x, y) return mix("#8c8c9c", "#6f7385", smoothstep(HZ, H, y)) end, edge={found=0.2, soft=0.5, lost=0.3, period=25, seed=5}})
work(NEARLIP, {hand="detail", tool="round 1.8", length={5, 16}, coverage=3.5, medium=0.12, angle=0, angle_jitter=0.25,
  color=function(x, y) return shift(snowcol(x, y), 0.02, 0, 0.004) end, edge={found=0.4, soft=0.4, lost=0.2, period=22, seed=6}})
