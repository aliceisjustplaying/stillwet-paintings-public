wait(24*60)
-- the snow in one wet lay-in, the mound modeled in it: its face toward the glow light and warm,
-- the plain in its lee cooler toward the crest, the far slope and the near drifts blue-violet
mound = function(x)
  local pts = MOUND
  for i = 1, #pts - 1 do
    local a, b = pts[i], pts[i + 1]
    if x >= a[1] and x <= b[1] then local t = (x - a[1]) / (b[1] - a[1]); return lerp(a[2], b[2], smoothstep(0, 1, t)) end
  end
  return 600
end
drift = noise{seed=52, octaves=4, period=140, stretch={0.05, 3}}
crestn = noise{seed=53, octaves=3, period=40}
snowcol = function(x, y)
  local d = clamp((y - HZ) / (714 - HZ), 0, 1)
  local far = mix("#cbc4c6", "#dcd2b6", math.exp(-((x - 260) / 380)^2) * 0.7)
  local c = mix(far, "#b9b8c4", smoothstep(0.05, 0.6, d))
  local m = mound(x) + 1.5 * crestn(x, 0)
  local onm = smoothstep(m - 1.5, m + 1.5, y)          -- 1 on the mound
  local west = 1 - smoothstep(400, 560, x)             -- the part of the mound facing the glow
  -- lee: the plain just behind the crest, cooler toward it
  local lee = (1 - onm) * smoothstep(HZ + 12, m, y) * (1 - smoothstep(560, 700, x))
  c = mix(c, "#b6b5c3", 0.8 * lee)
  -- face: light and warm under the crest, fading down the slope
  local face = onm * west * (1 - smoothstep(m + 4, m + 80, y))
  c = mix(c, mix("#e8ddca", "#dcd4cb", smoothstep(m, m + 60, y)), 0.9 * face)
  -- the slope turning away on the right of the mound
  local away = onm * smoothstep(400, 520, x) * (1 - smoothstep(600, 700, x)) * (1 - smoothstep(m + 6, m + 90, y))
  c = mix(c, "#b0b1c2", 0.8 * away)
  -- drifts: soft blue-violet shadows, stronger near
  c = mix(c, "#a4a7bb", (0.2 + 0.4 * d) * smoothstep(0.1, 0.6, drift(x, y)))
  return mix(c, "#9a9aab", 0.45 * smoothstep(0.6, 1, d))
end
snowm = below(function(x) return HZ - 4 end)
work(snowm, {hand="body", color=snowcol, angle=function(x, y) return 0.04 * drift(x, y) end,
  length={25, 80}, coverage=3.5, medium=0.2})
blend(snowm, {angle=0.02})
