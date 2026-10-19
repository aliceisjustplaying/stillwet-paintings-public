trunkM = poly({{226,590},{230,578},{233,560},{232,540},{234,515},{237,495},{238,478},{244,470},{258,470},{264,478},{264,495},{265,515},{266,540},{267,560},{271,578},{276,590}}, true)
tb3 = pile{{"raw umber",2},{"bone black",0.6},{"Prussian blue",0.15},{"lead white",0.25}, medium=0.05}
tb4 = pile{{"lead white",1.6},{"raw umber",1},{"yellow ochre",0.9},{"bone black",0.1}, medium=0.05}
work(trunkM, {hand="detail", pile=tb3, tool={kind="round", width=2.5, point=0.5}, angle=math.pi/2, coverage=2.5, fill=true, seed=291})
local lit = trunkM * mask(function(x,y) return smoothstep(-3, -11, x - spineX(y)) end)
work(lit, {hand="detail", pile=tb4, tool={kind="round", width=2, point=0.5}, angle=math.pi/2, coverage=2, fill=true, seed=292})
-- limbs underside dark too
local limbs = (oakM - trunkM:grow(1) - oakSil:shrink(2)) * rect(90,300,340,200)
work(limbs * mask(function(x,y) return 1 end), {hand="detail", pile=tb3, tool={kind="round", width=1.8, point=0.5}, angle=math.pi/2, coverage=1.5, fill=true, seed=293})
