HZ = 478
-- the far land line: flat, with a low wood band and the village
farn = noise{seed=41, octaves=4, period=90}
function farline(x)
  local wood = 10 * math.exp(-((x - 880) / 90)^2) + 6 * math.exp(-((x - 120) / 110)^2)
  return HZ - 3 - wood - 2.5 * farn(x, 0)
end
-- the stream: center line from near foreground to vanishing point
STREAM = {{150,714},{205,672},{300,626},{360,598},{388,574},{430,552},{478,530},{520,512},{548,500},{566,491},{578,484}}
-- widths shrink with depth
function stream_w(y) return 4 + 70 * ((y - HZ) / (714 - HZ))^1.6 end
-- willow feet on the right bank (x, y, height of trunk, head width)
WILLOWS = {{352,606,86,26},{462,546,46,15},{528,514,27,9},{562,496,15,5}}
FIG = {640, 552}   -- the walker's feet
MOON = {238, 176}
h = pencil("2H")
h:rule({0, HZ}, {1000, HZ}, {pressure=0.22})
local fl = {} for x = 0, 1000, 20 do fl[#fl+1] = {x, farline(x)} end
h:sketch(fl, {pressure=0.25})
-- stream banks
local L, R = {}, {}
for i, p in ipairs(STREAM) do local w = stream_w(p[2]) / 2; L[i] = {p[1] - w, p[2]}; R[i] = {p[1] + w, p[2]} end
h:sketch(L, {pressure=0.3}); h:sketch(R, {pressure=0.3})
-- willows: trunks and heads
for _, t in ipairs(WILLOWS) do
  local x, y, th, hw = t[1], t[2], t[3], t[4]
  h:sketch({{x - hw*0.35, y}, {x - hw*0.3, y - th*0.5}, {x - hw*0.5, y - th}}, {pressure=0.3})
  h:sketch({{x + hw*0.35, y}, {x + hw*0.28, y - th*0.5}, {x + hw*0.5, y - th}}, {pressure=0.3})
end
-- village and church
h:sketch({{700,HZ-4},{700,HZ-12},{712,HZ-18},{724,HZ-12},{724,HZ-4}}, {pressure=0.25})
h:sketch({{738,HZ-4},{738,HZ-30},{741,HZ-44},{744,HZ-30},{744,HZ-4}}, {pressure=0.25})
-- figure
h:sketch({{FIG[1]-4,FIG[2]},{FIG[1]-3,FIG[2]-22},{FIG[1],FIG[2]-30},{FIG[1]+3,FIG[2]-22},{FIG[1]+5,FIG[2]}}, {pressure=0.3})
fix()
