local mB = pile{{"yellow ochre",2.4},{"Prussian blue",0.45},{"raw umber",0.3},{"lead white",0.9},{"green earth",0.4}, medium=0.05}
local mBd = pile{{"yellow ochre",2.2},{"Prussian blue",0.5},{"raw umber",0.4},{"lead white",0.7},{"green earth",0.5}, medium=0.05}
local n = noise{seed=1011, octaves=2, period=30}
-- cover most of the ditch with the meadow; leave glints where the water shows between the grass
local cover = ditchM:grow(0.8) * mask(function(x,y) return smoothstep(-0.25, 0.1, n(x,y)) end)
work(cover, {hand="hatch", pile=mBd, tool={kind="round", width=1.3, point=0.6}, angle=-math.pi/2+0.1, length={2,6}, coverage=2.4, pressure={0.4,0.75}, seed=1012})
-- a quiet glaze of grey-green over the remaining water so it sits back in the meadow
local gz = pile{{"green earth",1},{"pale smalt",0.5},{"lead white",0.5},{"raw umber",0.2}, medium=0.5}
work(ditchM, {hand="detail", pile=gz, tool={kind="round", width=1.5, point=0.2}, angle=0.13, coverage=1.2, clip=true, pressure={0.3,0.5}, seed=1013})
