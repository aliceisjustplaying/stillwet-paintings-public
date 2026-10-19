-- the design, as globals: horizon, banks, pond; then the drawing
HZ = 468
-- far hills: a low, uneven line
hn = noise{seed=41, octaves=4, period=180}
function hills(x) return HZ - 6 - 10*hn:at01(x, 0) - 14*math.exp(-((x-820)/150)^2) - 6*math.exp(-((x-140)/110)^2) end
-- the far bank's top edge (snow) and the pond's far shore
function farbank(x) return HZ + 4 + 3*hn(x*2.1, 7) end
function shore(x) return HZ + 13 + 4*hn(x*1.7, 19) end
-- the near bank's top (where the snow starts in front)
bn = noise{seed=43, octaves=4, period=220}
function bank(x) return 566 - 28*math.exp(-((x-560)/210)^2) + 26*((x-500)/500)^2 + 6*bn(x, 0) end
CROSS = {x=572, foot=bank(572)+4, top=bank(572)-118}
FIG = {x=522, foot=bank(522)+6}
WILLOWS = {{128, 0.9}, {196, 1.05}, {262, 0.8}, {330, 0.95}}
OAK = {x=792, foot=farbank(792)+3}
MOON = {x=318, y=160, r=10}

local h = pencil("2H")
h:rule({0, HZ}, {1000, HZ}, {pressure=0.22})
local pts = {} for x = -5, 1005, 20 do pts[#pts+1] = {x, hills(x)} end
h:sketch(pts, {pressure=0.25})
pts = {} for x = -5, 1005, 25 do pts[#pts+1] = {x, shore(x)} end
h:sketch(pts, {pressure=0.25})
pts = {} for x = -5, 1005, 25 do pts[#pts+1] = {x, bank(x)} end
h:sketch(pts, {pressure=0.3})
-- the cross: an upright and a short beam, against the ruler, leaning a little
local b = pencil("HB")
b:rule({CROSS.x, CROSS.foot}, {CROSS.x + 4, CROSS.top}, {pressure=0.45})
b:rule({CROSS.x - 22, CROSS.top + 26}, {CROSS.x + 25, CROSS.top + 24}, {pressure=0.45})
-- the figure, a cloaked woman seen from behind
h:sketch({{FIG.x-8, FIG.foot}, {FIG.x-6, FIG.foot-30}, {FIG.x-4, FIG.foot-44}, {FIG.x, FIG.foot-50}, {FIG.x+4, FIG.foot-44}, {FIG.x+6, FIG.foot-30}, {FIG.x+9, FIG.foot}}, {pressure=0.35})
-- willows: short trunks and heads
for _, w in ipairs(WILLOWS) do
  local fx, fy, s = w[1], farbank(w[1]) + 2, w[2]
  h:sketch({{fx, fy}, {fx+1, fy - 40*s}}, {pressure=0.3})
  h:sketch({{fx-24*s, fy-70*s}, {fx-10*s, fy-95*s}, {fx+12*s, fy-98*s}, {fx+26*s, fy-72*s}}, {pressure=0.2})
end
-- the oak: trunk and the main limbs
h:sketch({{OAK.x, OAK.foot}, {OAK.x-2, OAK.foot-60}, {OAK.x-10, OAK.foot-110}, {OAK.x-40, OAK.foot-160}}, {pressure=0.3})
h:sketch({{OAK.x-2, OAK.foot-60}, {OAK.x+20, OAK.foot-105}, {OAK.x+55, OAK.foot-140}}, {pressure=0.3})
h:sketch({{OAK.x-60, OAK.foot-150}, {OAK.x-20, OAK.foot-185}, {OAK.x+30, OAK.foot-190}, {OAK.x+75, OAK.foot-150}}, {pressure=0.15})
-- the spire far off
h:sketch({{640, hills(640)+2}, {640, 440}, {643, 418}, {646, 440}, {646, hills(646)+2}}, {pressure=0.2})
