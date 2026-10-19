local region = rect(90,380,340,125)
local limbs = (oakM * region) - oakSil:shrink(1)
local barkD = pile{{"raw umber",2},{"bone black",0.45},{"lead white",0.55},{"yellow ochre",0.3},{"Prussian blue",0.08}, medium=0.05}
work(limbs, {hand="detail", pile=barkD, tool={kind="round", width=2.4, point=0.4}, angle=math.pi/2, coverage=3.5, fill=true, pressure={0.6,0.9}, seed=411})
