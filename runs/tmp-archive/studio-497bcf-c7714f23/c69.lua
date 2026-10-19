local band = rect(-5, 440.8, 250, 12) - lime_sil2:grow(0.5) - roof:grow(0.5) - rect(0,452,260,30)
work(band, {hand="detail", pile=haze, angle=0, coverage=2.2, length={4,12}, fill=true, clip=true, edge="soft"})
-- lower foliage on the middle lime to hide the bare fan of limbs
local low = ellipse(98, 438, 9, 6) + ellipse(122, 440, 8, 5) + ellipse(110, 432, 7, 5)
low = low:roughen(1.5, 4, 93)
stipple(low, {pile=tS, width=2.0, coverage=3.5, pressure={0.4,0.7}, clip=low, cluster=0.3})
stipple(low * mask(function(x,y) return (y < 436) and 1 or 0 end), {pile=tM2, width=1.8, coverage=1.5, pressure={0.35,0.6}, clip=low, cluster={0.5,4}, feather=0.5})
print(wait(0))
