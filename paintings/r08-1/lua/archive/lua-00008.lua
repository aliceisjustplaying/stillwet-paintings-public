dry()
-- snow blown over the ice in a few long streaks, more toward the far shore
local sn = noise{seed=81, octaves=5, period=150, stretch={0.0, 12}, warp={70, 10}}
local streak = mask(function(x, y)
  local t = clamp((y - shore(x)) / (bank(x) - shore(x)), 0, 1)
  return smoothstep(0.5 + 0.25*t, 0.7 + 0.25*t, sn:at01(x, y))
end) * POND
work(streak, {hand="body", tool="round 2.5", length={25, 80}, coverage=2.4, medium=0.15, hug=false, angle=0,
  angle_jitter=0.04, load=0.6, color=function(x, y) local t = clamp((y - shore(x)) / (bank(x) - shore(x)), 0, 1)
    return mix("#c9c0b6", "#a9acb4", t) end, edge="lost"})
-- open water: a long thin lead in the ice, dark, holding a little warm sky
HOLE = poly({{690,511},{730,509},{790,509.5},{850,512},{812,515.5},{752,516},{708,514.5}}, true):soften(0.8)
work(HOLE, {hand="detail", tool="round 1.5", length={15, 45}, coverage=3, medium=0.2, angle=0,
  color=function(x, y) return mix("#5b5c60", "#7e766d", smoothstep(509, 516, y)) end, edge={found=0.5, soft=0.5, period=25, seed=8}})
