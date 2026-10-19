local gn = noise{seed=81, octaves=3, period=220}
local keep = FIGM
for _, f in ipairs(FEET) do keep = keep + f[5][1] end
KEEP = keep:grow(0.4)
local kk = keep:grow(0.8)
local function landf(x, y)
  if y < HZ - 1 then return 0 end
  local d = clamp((y - HZ) / (H - HZ), 0, 1)
  local e = math.abs(x - 520) / 520
  local g = math.exp(-((x - GLOW) / 330)^2)
  return clamp(0.35 + 0.45 * d + 0.35 * e * e - 0.18 * g * (1 - d) + 0.08 * gn(x, y), 0, 1) * smoothstep(HZ - 1, HZ + 3, y)
end
-- the trunks and the walker take the glaze evenly along their whole height, so it draws no horizon across them
LANDG = mask(function(x, y) local kv = kk:at(x, y); return kv * 0.6 + (1 - kv) * landf(x, y) end)
glaze(LANDG, {color="#737b98", coats=0.55, pigment="transparent"})
SKYG = mask(function(x, y)
  if y > HZ then return 0 end
  local e = ((x - 420) / 620)^2 + ((y + 60) / 520)^2
  return clamp((1 - y / HZ) * 0.6 * smoothstep(0.35, 1.2, e), 0, 1)
end)
glaze(SKYG - KEEP, {color="#4f5a74", coats=0.3, pigment="transparent"})
