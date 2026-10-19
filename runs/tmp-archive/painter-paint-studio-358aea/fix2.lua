local lD = pile{{"green earth",1.6},{"raw umber",0.75},{"Prussian blue",0.3},{"yellow ochre",0.45},{"lead white",0.3}, medium=0.07}
local band = PWCRALL:shrink(2) * rect(0, 462, 450, 12)
stipple(band, {pile=lD, width=1.8, coverage=3.5, pressure={0.6,0.9}, cluster=0.3, dips={8,0.9,0.3}})
-- seam at the lit meadow edge on the left: grass blades crossing it
local seam = LAND * rect(0, 505, 440, 18) - PWALL:grow(0.5) - FIGS:grow(1) - PATH:shrink(2)
local gA = pile{{"yellow ochre",1.4},{"green earth",1.3},{"chrome yellow",0.25},{"lead white",1.0},{"Prussian blue",0.1}, medium=0.1}
local gB = pile{{"lead white",1.0},{"green earth",1.9},{"yellow ochre",1.1},{"pale smalt",0.35},{"Prussian blue",0.06},{"raw umber",0.2}, medium=0.1}
work(seam * mask(function(x,y) return smoothstep(508,516,y) end), {hand="hatch", pile=gA, tool={kind="round", width=1.3, point=0.8}, angle=-math.pi/2, angle_jitter=0.3, length={4,9}, coverage=1.4, pressure={0.35,0.75}, ramps={0.1,0.6}, threshold=0.3, seed=3301})
work(seam * mask(function(x,y) return 1 - smoothstep(508,516,y) end), {hand="hatch", pile=gB, tool={kind="round", width=1.1, point=0.8}, angle=-math.pi/2, angle_jitter=0.3, length={3,6}, coverage=1.0, pressure={0.35,0.7}, ramps={0.1,0.6}, threshold=0.3, seed=3302})
print(wait(0))
