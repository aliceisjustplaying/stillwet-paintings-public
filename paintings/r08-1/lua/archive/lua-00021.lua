-- the near snow: long wind drifts, each a cool shadow on its lee under a lit crest; a few stones
local KEEPF = -(CROSSM + FIGM):grow(1)
local dn = noise{seed=211, octaves=4, period=200, stretch={-0.08, 6}, warp={140, 10}}
DRIFTSH = mask(function(x, y)
  local d = y - bank(x); if d < 14 then return 0 end
  local v = dn:at01(x, y*1.6)
  return smoothstep(0.55, 0.62, v) * (1 - smoothstep(0.66, 0.74, v)) * smoothstep(14, 40, d) end) * KEEPF
glaze(DRIFTSH:blur(1.5), {color="#56607c", coats=0.3})
-- stones through the snow: dark tops, snow lying on them
local stb = brush{kind="round", width=3, point=0.3}
for i, s in ipairs({{206, 676, 17, 7}, {232, 682, 8, 4}}) do
  local x, y, w, h = s[1], s[2], s[3], s[4]
  local st = poly({{x - w, y}, {x - w*0.7, y - h*0.8}, {x - w*0.1, y - h}, {x + w*0.6, y - h*0.7}, {x + w, y}}, true):roughen(0.5, 3, 212 + i, 0.3)
  work(st, {hand="detail", tool="round 1.2", length={2, 6}, coverage=4, medium=0.1, angle=0.2, color="#4c4a4d", edge="found"})
  stb:reload("#bebdc4", 0.6)
  stb:stroke({{x - w*0.75, y - h*0.7}, {x - w*0.1, y - h*1.05}, {x + w*0.55, y - h*0.75}}, {pressure={0.15, 0.45, 0.1}, ramps={0.3, 0.4}})
  -- the snow it sits in, drawn up over its foot (the stone's own lower edge lost)
  work(poly({{x - w*1.2, y + 1.5}, {x - w*0.8, y - h*0.25}, {x, y - h*0.1}, {x + w*0.9, y - h*0.3}, {x + w*1.2, y + 1.5}}, true),
    {hand="detail", tool="round 1.4", length={3, 8}, coverage=3, medium=0.1, angle=0.05, color=sample(x, y + 4, 2), edge="lost"})
end
