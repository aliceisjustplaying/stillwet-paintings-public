-- snow drifted over the oak's foot
function driftLine(x)
  return 447 + 1.8 * math.sin(x / 5.5) + 1.2 * math.sin(x / 2.7 + 1) - 3 * math.exp(-((x - 238) / 14)^2) + 4 * math.exp(-((x - 196) / 8)^2) + 3 * math.exp(-((x - 285) / 8)^2)
end
local dm = below(driftLine) * rect(160, 425, 160, 50)
driftM = dm:roughen(0.7, 4, 31)
work(driftM, {hand="detail", tool={kind="round", width=2, point=0.6}, pile=knollShade, load=1, pressure={0.6, 0.9}, coverage=3.5, fill=true, angle=0, clip=true})
-- the lit top of the drift
local r = brush{kind="round", width=2.5, point=0.8}
local pts = {}
for x = 176, 302, 3 do pts[#pts+1] = {x, driftLine(x) + 0.8} end
r:load(limbSnow, 0.6)
r:stroke(pts, {pressure={0.35, 0.3}, swell={0.7, 1, 1.2, 0.8, 1, 0.6}, clip=driftM})
