-- easel session "winter_willows": a painting replayed chunk by chunk.
--   easel run paintings/lua/winter_willows.lua [--width 3200]
-- Each "--@ chunk" line starts one chunk as it was run at the easel (clock = painting minutes).
-- sittings enforced: a sitting ends at its length; the easel refuses marks until rest(hours) (notes/time.md)

--@ chunk 1 · clock 0
canvas{style="friedrich", aspect=1.4, seed=29}; print(W, H); print(pal); print(type(world), type(tree))

--@ chunk 2 · clock 0
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

--@ chunk 3 · clock 0
skyn = noise{seed=17, octaves=3, period=380, stretch={0.02, 5}}
GLOW = 250
function skycol(x, y)
  local t = clamp(y / HZ, 0, 1)
  local g = math.exp(-((x - GLOW) / 330)^2)           -- where the sun went down
  local band = skyn(x, y) * 0.04
  local c = gradient({{0, "#5d6c86"}, {0.35, "#8190a6"}, {0.62, "#b1b3bb"}, {0.8, "#cdbfb6"}, {1, "#dcc8ae"}}, t + band)
  local warm = gradient({{0, "#6c7890"}, {0.45, "#a4a8b4"}, {0.7, "#d9c7b0"}, {0.88, "#ecd7a8"}, {1, "#f0dca6"}}, t + band)
  return mix(c, warm, g * smoothstep(0.2, 0.9, t) * 0.9)
end
skym = above(function(x) return farline(x) + 10 end)
work(skym, {hand="broad", color=skycol, angle=function(x, y) return 0.02 * skyn(x * 2, y) end, coverage=4.5, medium=0.28, length={80, 240}})
blend(skym, {angle=0.01})

