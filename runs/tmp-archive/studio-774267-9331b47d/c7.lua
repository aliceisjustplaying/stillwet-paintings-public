-- long evening streaks, thin, catching warm light
local wisp = pile{{"lead white", 9}, {"yellow ochre", 0.2}, {"vermilion", 0.07}, {"pale smalt", 0.3}, medium=0.25}
local gray = pile{{"lead white", 5}, {"pale smalt", 1.5}, {"red earth", 0.1}, {"raw umber", 0.06}, medium=0.25}
local n = noise{seed=21, octaves=3, period=90}
local function streak(x0, x1, y0, dy, w, seed)
  local pts, ws = {}, {}
  for i=0,40 do
    local t = i/40
    local x = lerp(x0, x1, t)
    pts[#pts+1] = {x, y0 + dy*t + 2*n(x, y0)}
    ws[#ws+1] = w * math.sin(math.pi*t)^0.7 * (0.7 + 0.5*n:at01(x*2, y0+seed))
  end
  return ribbon(pts, ws):roughen(1.5, 12, seed)
end
WISPS = streak(560, 980, 212, -8, 7, 1) + streak(610, 890, 232, -4, 4, 2) + streak(700, 1010, 252, -6, 5, 3) + streak(480, 700, 268, 2, 3.5, 4) + streak(20, 330, 238, 4, 4, 5) + streak(90, 260, 222, 2, 2.5, 6)
GRAYS = streak(600, 940, 219, -7, 3, 7) + streak(720, 1000, 258, -5, 2.5, 8)
work(GRAYS, {hand="body", tool="filbert 4", pile=gray, angle=0, angle_jitter=0.08, length={30,80}, coverage=1.5, pressure={0.3,0.5}, seed=501})
work(WISPS, {hand="body", tool="filbert 5", pile=wisp, angle=0, angle_jitter=0.08, length={30,90}, coverage=1.8, pressure={0.3,0.6}, seed=502})
blend((WISPS+GRAYS):grow(5), {angle=0, ruler=true, length={40,120}, coverage=1, seed=503})
