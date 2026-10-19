local FG = LAND * mask(function(x,y) return y > 600 and 1 or 0 end) - PATH:shrink(3)
local function fpass(m, p, len, w, cov, seed, jit)
  work(m, {hand="hatch", pile=p, tool={kind="round", width=w, point=0.8}, angle=-math.pi/2, angle_jitter=jit or 0.3, length=len, coverage=cov, pressure={0.4,0.8}, ramps={0.1,0.6}, threshold=0.5, seed=seed})
end
fpass(FG * zoneN(620, 660, 8, 6), gP.sh, {8,20}, 2.0, 1.4, 11)
fpass(FG * zoneN(650, 800, 8, 6), gP.dark, {12,30}, 2.4, 1.5, 12)
fpass(FG * zoneN(640, 800, 10, 6), gP.mid, {10,28}, 2.0, 0.8, 13)
print(wait(0))
