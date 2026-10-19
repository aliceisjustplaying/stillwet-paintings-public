skypal = pal:only{"lead white", "pale smalt", "cobalt blue", "yellow ochre", "raw umber", "chrome yellow"}
-- five piles, mixed on the palette with the knife
SKY = {top="#6d7c94", upper="#949eac", mid="#b0a9a6", low="#d6bd9c", glow="#ead7a4"}
local wob = noise{seed=41, period=260}
local function band(y0, y1)
  return mask(function(x, y)
    local a = y0 + 14 * wob(x, 0) ; local b = y1 + 14 * wob(x + 900, 0)
    return (y >= a and y < b) and 1 or 0 end)
end
skyM = above(function(x) return HZ + 4 end) - trunkM:shrink(3)
local o = {hand="broad", angle=0, coverage=3.2, medium=0.3, pal=skypal, length={90, 240}}
local function pass(m, c) local t = {} for k, v in pairs(o) do t[k] = v end; t.color = c; work(m * skyM, t) end
pass(band(-20, 150), SKY.top)
pass(band(120, 270), SKY.upper)
pass(band(245, 355), SKY.mid)
pass(band(335, 420), SKY.low)
pass(band(400, 520), SKY.glow)
blend(skyM - trunkM:grow(2), {angle=0})
