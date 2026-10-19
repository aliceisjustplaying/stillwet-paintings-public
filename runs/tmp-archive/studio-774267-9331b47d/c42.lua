-- the ditch: a spline through STREAM, densified, width growing toward us
local pts, wd, top = {}, {}, {}
local n = noise{seed=77, octaves=2, period=60}
for i=1,#STREAM-1 do
  for s=0,11 do
    local t = s/12
    local x = lerp(STREAM[i][1], STREAM[i+1][1], t)
    local y = lerp(STREAM[i][2], STREAM[i+1][2], t) + 0.8*n(x, 0)
    pts[#pts+1] = {x, y}
    local w = 1.2 + ((y - 428)/82)^1.3 * 6.5
    wd[#wd+1] = w * (0.85 + 0.3*n:at01(x*3, 50))
  end
end
pts[#pts+1] = STREAM[#STREAM]; wd[#wd+1] = 8
STREAMPTS, STREAMW = pts, wd
-- flatten the ribbon vertically: water seen at a grazing angle
WATER = ribbon(pts, wd):roughen(0.6, 5, 61)
local far_w = pile{{"lead white", 5}, {"yellow ochre", 0.25}, {"chrome yellow", 0.06}, {"pale smalt", 0.5}, medium=0.15}
local near_w = pile{{"lead white", 3.5}, {"pale smalt", 1.2}, {"smalt", 0.5}, {"yellow ochre", 0.05}, medium=0.15}
local wfar = WATER * mask(function(x, y) return x > 520 and 1 or 0 end)
local wnear = WATER - wfar
work(wfar, {hand="detail", tool={kind="round", width=1.4, point=0.5}, pile=far_w, angle=-0.08, coverage=2.5, fill=true, seed=4201})
work(wnear, {hand="detail", tool={kind="round", width=2.2, point=0.5}, pile=near_w, angle=-0.12, coverage=2.5, fill=true, seed=4202})
blend(WATER, {angle=-0.1, length={10,40}, coverage=1, seed=4203})
