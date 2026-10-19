-- Evening at a Mountain Lake. Twilight after sunset, contre-jour: the afterglow low over the lake,
-- a thin waxing crescent above it, a far range in mist, a fir promontory from the left and its
-- reflection, a dark near shore with stones.
canvas{style="friedrich", palette="friedrich_1820_greens", aspect=1.4, seed=47, hand=true}
skypal = pal:only{"lead white","pale smalt","cobalt blue","yellow ochre","raw umber","red earth","chrome yellow","vermilion"}
G = function(x, c, s) return math.exp(-((x - c)/s)^2) end
HZ = 432                               -- the lake's far edge (eye level)
SUNX = 600                             -- the sun has set here
MOON = {676, 158}
rn = noise{seed=5, octaves=5, period=170}
rn2 = noise{seed=6, octaves=3, period=60}
crest = function(x)
  return HZ - 10 - 14*rn:at01(x, 0) - 3*rn2(x, 0) - 58*G(x, 790, 150) - 26*G(x, 965, 70) - 18*G(x, 470, 110)
end
-- the promontory: a fir wood's skyline falling from the upper left to a low point at the water
PROM = {{-10,214},{40,196},{90,226},{140,236},{190,268},{240,300},{290,344},{330,392},{362,430},{388,458},{404,470}}
PWL = function(x) return 470 + 0.012*(x - 404) end         -- its waterline (nearer than the horizon)
-- the near shore: a dark bank along the bottom, rising a little to the right
SHORE = function(x) return 640 - 22*G(x, 760, 190) - 10*rn2(x, 300) + 14*G(x, 180, 160) end
water = mask(function(x, y) return (y > HZ and y < SHORE(x) + 4) and 1 or 0 end)
print(H, water:area())
show(PROM, {label="prom"})
local cr, sh = {}, {}
for x = 0, 1000, 20 do cr[#cr+1] = {x, crest(x)}; sh[#sh+1] = {x, SHORE(x)} end
show(cr, {label="range", dots=false}); show(sh, {label="shore"}); show({{0,HZ},{1000,HZ}}, {label="HZ"})
show(MOON[1], MOON[2], "moon")
