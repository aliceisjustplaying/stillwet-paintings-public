STREAM = {{112,714},{165,690},{245,664},{322,643},{372,626},{392,611},{384,598},{360,588},{356,577},{380,566},{428,553},{470,540},{496,528},{498,517},{516,506},{546,496},{568,489},{580,484}}
function stream_w(y) return 3 + 52 * ((y - HZ) / (714 - HZ))^1.5 end
-- the stream as a band
local ws = {} for i, p in ipairs(STREAM) do ws[i] = stream_w(p[2]) end
STREAMM = ribbon(STREAM, ws):roughen(1.2, 14, 8, 0.6)
drift = noise{seed=23, octaves=4, period=160, stretch={0.05, 3.5}}
local fine = noise{seed=24, octaves=3, period=40, stretch={0.05, 3}}
function snowcol(x, y)
  local d = clamp((y - HZ) / (H - HZ), 0, 1)
  local g = math.exp(-((x - GLOW) / 380)^2)
  local c = gradient({{0, "#a9a6af"}, {0.12, "#b6b3ba"}, {0.45, "#c6c3c6"}, {1, "#d4d0cc"}}, d)
  c = mix(c, "#d8cfc0", 0.35 * g * (1 - d * 0.5))                   -- the glow's warmth on the far snow
  local sh = drift(x, y) * 0.5 + 0.5
  c = mix(c, shift(c, -0.05, -0.002, -0.022), smoothstep(0.55, 0.85, sh) * (0.3 + 0.7 * d))  -- lee of the drifts
  return shift(c, 0.012 * fine(x, y), 0, 0)
end
SNOW = below(function(x) return HZ + 1.2 + 0.8 * farn(x * 3, 5) end)
-- a thin underpainting over all the land, stream included
work(SNOW, {hand="broad", tool="flat 10", color=function(x, y) return shift(snowcol(x, y), -0.08, 0.0, -0.01) end, medium=0.35, coverage=4.5, length={60, 200}, angle=0.03, angle_jitter=0.04})
blend(SNOW, {angle=0.02, coverage=1.5})
