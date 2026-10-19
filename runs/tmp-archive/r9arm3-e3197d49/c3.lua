-- the evening sky: gray-violet above, a lemon-rose glow low where the sun went down (left)
bands = noise{seed=41, octaves=4, period=260, stretch={0.03, 6}}
skycol = function(x, y)
  local t = clamp(y / HZ, 0, 1)
  local c = gradient({{0, "#58647c"}, {0.35, "#7c8497"}, {0.62, "#a8a3a8"}, {0.82, "#cdb9aa"}, {1, "#e4d3a8"}}, t)
  -- the glow sits left of center and fades to mauve on the right
  local glow = math.exp(-((x - 260) / 420)^2) * smoothstep(0.55, 1, t)
  local right = mix(c, "#b6a6ad", 0.55 * smoothstep(0.6, 1, t))
  c = mix(right, c, glow)
  -- long cloud banks lying across, darker gray-violet
  local bk = smoothstep(0.15, 0.55, bands(x, y)) * (0.6 - 0.4 * t)
  return mix(c, "#6a6878", bk)
end
skym = above(function(x) return HZ + 14 end)
work(skym, {hand="broad", color=skycol, angle=function(x, y) return 0.02 * bands(x * 0.3, y) end,
  length={120, 320}, coverage=4.5, medium=0.3})
-- blend later
