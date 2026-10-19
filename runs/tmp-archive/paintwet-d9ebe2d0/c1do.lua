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
  return HZ - 10 - 14*rn:at01(x, 0) - 3*rn2(x, 0) - 66*G(x, 790, 140) - 30*G(x, 960, 60) - 20*G(x, 470, 110) - 8*G(x, 640, 40)
end
-- the promontory: a fir wood's skyline falling from the upper left to a low point at the water
PROM = {{-10,206},{36,188},{70,214},{112,222},{150,212},{186,252},{226,270},{262,318},{296,352},{318,398},{334,440},{346,458},{380,462},{420,466},{448,470}}
PWL = function(x) return 470 + 0.02*(448 - x) end         -- its waterline (nearer than the horizon)
-- the near shore: a dark bank along the bottom, rising a little to the right
SHORE = function(x) return 646 - 44*G(x, 800, 170) - 12*G(x, 620, 60) - 8*rn2(x, 300) + 10*G(x, 200, 160) end
water = mask(function(x, y) return (y > HZ and y < SHORE(x) + 4) and 1 or 0 end)
print(H, water:area())
