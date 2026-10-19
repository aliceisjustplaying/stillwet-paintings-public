-- the reeds, again: a transparent cool glaze of the low-hiding tubes only, to take the wheat-gold into dusk
reedGlaze2 = pile{{"smalt",2},{"Prussian blue",0.15},{"green earth",0.6}, medium=0.9}
local rb = (ellipse(428, 556, 34, 17) + ellipse(900, 553, 40, 15)):soften(4) + (rect(480, 528, 300, 22) * above(function(x) return mereFar(x) + 1 end)):soften(1)
work(rb - figM:grow(1), {hand="detail", tool={kind="round", width=3, point=0.4}, pile=reedGlaze2, load=0.5, pressure={0.35, 0.5}, coverage=2, fill=true, clip=true, angle=-1.5, angle_jitter=0.3})
