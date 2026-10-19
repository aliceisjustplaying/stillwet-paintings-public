-- an evening glaze over all the land, to quiet the gold of the grass and bring the snow down under the sky
eveGlaze = pile{{"smalt",1.2},{"Prussian blue",0.2},{"bone black",0.3},{"raw umber",0.3},{"red earth",0.15}, medium=0.9}
local nn = noise{seed=951, period=80, octaves=3}
local m = landm - merem:grow(0.5) - figM:grow(1) - posts.cap:grow(0.5) - sprMask:grow(1) - oakLive:grow(0.5) - rect(470, 440, 330, 60):soften(10)
work(m, {hand="glaze", pile=eveGlaze, angle=0.03, angle_jitter=0.05, clip=true,
   load_at=function(x, y) return (0.12 + 0.35 * smoothstep(420, 714, y)) * (0.85 + 0.3 * nn(x, y)) end,
   pressure={0.3, 0.5}, coverage=1.6, seed=952})
-- the reed beds dulled toward brown in the dusk
reedGlaze = pile{{"raw umber",1.5},{"bone black",0.3},{"smalt",0.8},{"red earth",0.2}, medium=0.85}
local rb = (ellipse(428, 556, 36, 18) + ellipse(900, 553, 42, 16)):soften(4) + (rect(480, 530, 300, 20) * above(function(x) return mereFar(x) + 1 end)):soften(1)
work(rb, {hand="detail", tool={kind="round", width=3, point=0.4}, pile=reedGlaze, load=0.4, pressure={0.35, 0.5}, coverage=2, fill=true, clip=true, angle=-1.5, angle_jitter=0.3})
