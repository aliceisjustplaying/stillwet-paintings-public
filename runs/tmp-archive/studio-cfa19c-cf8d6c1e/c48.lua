local fgd = pile{{"lead white",1.2},{"smalt",1.5},{"green earth",1.5},{"raw umber",0.8},{"Prussian blue",0.05}, medium=0.08}
local avoid = oakM:grow(1) + oakSil + trunkM:grow(1)
local gm = (grovesM:grow(1.5) - avoid)
stipple(gm, {pile=fgd, width=2.4, coverage=1.3, pressure={0.35,0.7}, cluster={0.5,3}, feather=0.6, clip=grovesM:grow(2.5) - avoid, dips={20,0.6,0.2}, seed=311})
-- repair the limbs the grove went over
local rep = (oakM + trunkM) * grovesM:grow(3) - oakSil:shrink(2)
work(rep, {hand="detail", pile=tb3, tool={kind="round", width=1.8, point=0.5}, angle=math.pi/2, coverage=2.5, fill=true, seed=312})
