local icen = noise{seed=31, octaves=4, period=30, stretch={0.0, 4}}
function icecol(x, y)
  local d = clamp((y - HZ) / (H - HZ), 0, 1)
  local c = gradient({{0, "#d9ccb4"}, {0.15, "#c3bdb6"}, {0.45, "#9ea2ae"}, {1, "#7f8798"}}, d)
  c = mix(c, "#cfd0d4", 0.35 * smoothstep(0.2, 0.7, icen(x, y)))   -- snow dusted on the ice
  return c
end
work(STREAMM, {hand="body", tool="filbert 3", color=icecol, medium=0.2, coverage=4.5, length={8, 30}, angle=0.0, angle_jitter=0.1,
  edge={found=0.3, soft=0.5, lost=0.2, period=35, seed=9}})
