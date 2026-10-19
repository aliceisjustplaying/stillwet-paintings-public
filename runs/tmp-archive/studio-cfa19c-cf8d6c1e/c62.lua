local region = rect(90,380,340,120)
local limbs = (oakM * region) - oakSil:shrink(1)
tb5 = pile{{"raw umber",1.6},{"bone black",0.5},{"lead white",0.9},{"Prussian blue",0.1}, medium=0.04}
work(limbs, {hand="detail", pile=tb5, tool={kind="round", width=2.0, point=0.4}, angle=function(x,y) return oakBody and math.pi/2 or math.pi/2 end, coverage=3.2, fill=true, seed=401})
-- a lighter top edge on the limbs where the sun from the left catches them
local tops = limbs * mask(function(x,y) return 1 end) - limbs:shrink(1.5)
local lb = pile{{"lead white",1.5},{"raw umber",0.8},{"yellow ochre",0.8}, medium=0.04}
