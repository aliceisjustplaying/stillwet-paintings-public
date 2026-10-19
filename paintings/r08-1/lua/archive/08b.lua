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
