waterpal = pal:only{"lead white", "pale smalt", "cobalt blue", "yellow ochre", "raw umber", "bone black"}
-- the water mirrors the sky, a shade darker: glow under the far shore, then the higher sky toward me
WATER = {glow="#d9c69b", low="#c2ae92", mid="#a09a93", upper="#7f8694"}
local wob = noise{seed=43, period=300}
local function band(y0, y1)
  return mask(function(x, y)
    local a = y0 + 4 * wob(x, 0); local b = y1 + 4 * wob(x + 700, 0)
    return (y >= a and y < b) and 1 or 0 end)
end
waterM = below(function(x) return HZ + 2 end) * above(function(x) return 590 end) - trunkM:grow(2)
local o = {hand="broad", angle=0, coverage=3.2, medium=0.3, pal=waterpal, length={100, 260}, broken=0, tail=0, angle_jitter=0.01, edge="found"}
local function pass(m, c) local t = {} for k, v in pairs(o) do t[k] = v end; t.color = c; work(m * waterM, t) end
pass(band(440, 484), WATER.glow)
pass(band(476, 522), WATER.low)
pass(band(514, 556), WATER.mid)
pass(band(548, 600), WATER.upper)
blend(waterM - trunkM:grow(4), {angle=0, angle_jitter=0.003})
