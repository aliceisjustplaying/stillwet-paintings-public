local region = rect(90,380,340,125)
local limbs = (oakM * region) - oakSil:shrink(1)
local barkDD = pile{{"raw umber",2},{"bone black",0.9},{"Prussian blue",0.15},{"lead white",0.15}, medium=0.05}
work(limbs, {hand="hatch", pile=barkDD, tool={kind="round", width=2.2, point=0.4}, angle=math.pi/2, coverage=2.2, pressure={0.6,0.9}, clip=true, seed=421})
