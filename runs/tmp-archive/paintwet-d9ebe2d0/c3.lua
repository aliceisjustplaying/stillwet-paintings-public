-- masks for the whole picture
local pl = {} for i, p in ipairs(PROM) do pl[i] = {p[1], p[2]} end
pl[#pl+1] = {452, PWL(452) + 1}; pl[#pl+1] = {-10, PWL(-10) + 1}
promM = poly(pl)                                              -- the promontory's land, skyline to waterline
promSky = function(x)                                        -- its skyline as a function (linear between points)
  if x <= PROM[1][1] then return PROM[1][2] end
  for i = 2, #PROM do local a, b = PROM[i-1], PROM[i]
    if x <= b[1] then return lerp(a[2], b[2], (x - a[1])/(b[1] - a[1])) end end
  return PWL(x)
end
promRefl = mask(function(x, y)                               -- the mirror of the promontory, shortened (we look down a little)
  if x > 452 then return 0 end
  local wl = PWL(x); local d = wl - promSky(x)
  return (y > wl and y < wl + 0.78*d) and 1 or 0 end):soften(1.5)
rangeM = mask(function(x, y) return (y > crest(x) and y < HZ + 2) and 1 or 0 end) - promM
rangeRefl = mask(function(x, y) return (y >= HZ and y < HZ + 0.7*(HZ - crest(x))) and 1 or 0 end) - promM - promRefl
shoreM = below(SHORE)
skyM = above(crest) - promM
waterM = mask(function(x, y) return (y > HZ and y < SHORE(x) + 6) and 1 or 0 end) - promM
print(promM:area(), promRefl:area(), rangeM:area(), shoreM:area(), skyM:area(), waterM:area())
-- the dead color: thin, lean, one sitting; values only a little lighter than meant, cool in the sky
local dead = pal:only{"lead white","raw umber","bone black","yellow ochre","cobalt blue"}
work(skyM, {hand="body", tool="filbert 10", color=function(x, y)
    return mix(mix("#6f757f", "#a9a293", smoothstep(80, HZ, y)), "#bca98c", 0.6*G(x, SUNX, 260)*smoothstep(200, HZ, y)) end,
  angle=0, angle_jitter=0.15, length={40, 120}, coverage=3.2, medium=0.4, load=0.6, pal=dead, clip=skyM:grow(3)})
work(waterM - promRefl, {hand="body", tool="filbert 10", color=function(x, y)
    return mix(mix("#a49d8f", "#6f727a", smoothstep(HZ, 640, y)), "#b3a48b", 0.5*G(x, SUNX, 200)*(1 - smoothstep(HZ, 600, y))) end,
  angle=0, angle_jitter=0.08, length={40, 120}, coverage=3.2, medium=0.4, load=0.6, pal=dead, clip=(waterM - promRefl):grow(3)})
work(rangeM + rangeRefl, {hand="body", tool="filbert 8", color="#6e6c70", angle=0, length={30, 90}, coverage=3, medium=0.4, load=0.6, pal=dead, clip=(rangeM + rangeRefl):grow(1.5)})
work(promM + promRefl, {hand="body", tool="filbert 8", color="#3a3a35", angle=1.3, angle_jitter=0.6, length={20, 60}, coverage=3.2, medium=0.4, load=0.6, pal=dead, clip=(promM + promRefl):grow(1.5)})
work(shoreM, {hand="body", tool="filbert 10", color="#3e3934", angle=0.05, angle_jitter=0.3, length={30, 90}, coverage=3.2, medium=0.4, load=0.6, pal=dead, clip=shoreM:grow(2)})
local t = timesheet() print(string.format("%.0f min this sitting", t.sitting))
