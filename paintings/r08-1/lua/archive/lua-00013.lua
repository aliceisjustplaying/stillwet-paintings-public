-- the wayside cross: old weathered timber, leaning a little, snow on its top and arms
local cx, cf = CROSS.x, bank(CROSS.x) + 20
local ct = cf - 142
CROSS.foot, CROSS.top, CROSS.lean = cf, ct, 5
local lean = 5
local function P(t) return {cx + lean*t, cf + (ct - cf)*t} end
UPRIGHT = ribbon({P(0), P(0.5), P(1)}, {5.2, 4.8, 4.4}):roughen(0.25, 4, 31, 0.15)
local by = ct + 31
CROSS.beam = by
BEAM = ribbon({{cx - 26 + lean*0.75, by + 1.2}, {cx + lean*0.75, by}, {cx + 27 + lean*0.75, by - 1}}, {4.2, 4.4, 4}):roughen(0.25, 4, 32, 0.15)
CROSSM = UPRIGHT + BEAM
work(CROSSM, {hand="body", tool="round 1.5", length={4, 12}, coverage=4, medium=0.1, load=0.9, angle=-1.53, angle_jitter=0.15,
  color=function(x, y) return mix("#2f2a29", "#4a423d", 0.5*smoothstep(-2, 2.5, x - (cx + lean*(cf - y)/(cf - ct)))) end,
  edge={found=0.8, soft=0.2, period=14, seed=33}})
work(BEAM, {hand="detail", tool="round 1.2", length={5, 14}, coverage=2.5, medium=0.1, angle=0.02, color="#332d2b", edge="found"})
