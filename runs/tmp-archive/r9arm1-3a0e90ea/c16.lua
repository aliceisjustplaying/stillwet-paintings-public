-- the walker, seen from behind, going toward the village: greatcoat, tall hat, stick
local k = per_m(FY) / 26          -- the drawing below is in units at 26 per meter
local function R(pts) local o = {} for i, p in ipairs(pts) do o[i] = {FX + p[1] * k, FY + p[2] * k} end return o end
COAT = R{{-4.8,-38.2},{-6.2,-35},{-6.5,-27},{-7.0,-18},{-7.9,-9.0},{-4,-8.2},{0.2,-9.0},{3.6,-8.9},{7.2,-10.2},{6.6,-18},{6.0,-27},{5.9,-35},{4.7,-38.2},{2.2,-39.6},{-2.0,-39.6}}
HAT = R{{-4.0,-43.2},{4.1,-43.4},{3.9,-44.3},{2.7,-44.6},{2.5,-48.6},{0,-49},{-2.4,-48.7},{-2.7,-44.5},{-3.9,-44.2}}
LEGL = R{{-3.4,-9},{-1.1,-9},{-1.6,-0.3},{-3.7,0.1}}
LEGR = R{{1.2,-9},{3.4,-9.2},{4.6,-3.4},{4.9,-2.2},{3.0,-1.9},{2.3,-3.2}}
local coat, hat, head = poly(COAT, true), poly(HAT), ellipse(FX + 0.3 * k, FY - 41.2 * k, 2.4 * k, 3.0 * k)
local legs = poly(LEGL) + poly(LEGR)
FIGM = coat + hat + head + legs
work(legs, {hand="detail", tool="round 1", length={2, 5}, coverage=4, medium=0.12, angle=1.57, aim="masstone", color="#1f1d20", edge={found=0.8, soft=0.2, period=8, seed=1}})
work(coat, {hand="detail", tool="round 1.4", length={3, 9}, coverage=4.5, medium=0.12, angle=1.62, angle_jitter=0.15, aim="masstone",
  color=function(x, y) return mix("#262a35", "#1c1e25", smoothstep(FY - 38 * k, FY - 9 * k, y)) end, edge={found=0.7, soft=0.3, period=10, seed=2}})
work(head, {hand="detail", tool="round 1", length={1, 3}, coverage=4, medium=0.12, aim="masstone", color="#2c2526", edge="firm"})
work(hat, {hand="detail", tool="round 1", length={1.5, 4}, coverage=4, medium=0.12, angle=0, aim="masstone", color="#18171a", edge={found=0.9, soft=0.1, period=6, seed=3}})
-- the arm and the stick, the collar's fold, a lit edge of glow on his left shoulder
local ab = brush{kind="round", width=1.8 * k, point=0.5}
ab:load("#22242c", 0.9)
ab:stroke(R{{6.2,-36}, {7.8,-30}, {8.6,-24.5}}, {pressure={0.8, 0.7}})
local sb = brush{kind="rigger", width=0.7 * k, point=1}
sb:load("#2b2420", 0.9)
sb:stroke(R{{8.8,-25}, {10.6,-12}, {12.2,-0.2}}, {pressure={0.8, 0.55}, shake=0.3})
local rb = brush{kind="round", width=0.7 * k, point=1}
rb:load("#6a6268", 0.6)
rb:stroke(R{{-5.4,-37.6}, {-6.8,-34}, {-7.2,-28}}, {pressure={0.45, 0.05}})
rb:load("#595158", 0.5)
rb:stroke(R{{-3.6,-43.4}, {-2.2,-43.5}}, {pressure={0.35, 0.1}})
-- his shadow: at dusk only a faint cool trace, and snow over his boot soles
local sh = brush{kind="filbert", width=2.2 * k, stiffness=0.4}
sh:load(shift(snowcol(FX, FY), -0.06, -0.002, -0.02), 0.4)
sh:stroke(R{{-5,0.4}, {0,0.9}, {6,0.5}}, {pressure={0.5, 0.3}})
local sn = brush{kind="filbert", width=1.2 * k, stiffness=0.4}
sn:load(snowcol(FX, FY + 2), 0.6)
sn:stroke(R{{-4.6,0.1}, {-2.5,-0.5}, {-0.6,0.2}}, {pressure={0.6, 0.4}})
sn:stroke(R{{1.0,-1.4}, {2.6,-1.9}, {4.0,-1.2}}, {pressure={0.4, 0.2}})
