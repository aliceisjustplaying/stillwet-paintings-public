waterGlaze = pile{{"raw umber",1},{"smalt",1},{"Prussian blue",0.1},{"red earth",0.15}, medium=0.45}
local low = (rect(0,530,1000,150):roughen(10,120,3)) - spit:shrink(6)
work(low, {hand="glaze", pile=waterGlaze, angle=0, coverage=1.2})
local lower2 = (rect(0,595,1000,90):roughen(10,120,4)) - spit:shrink(6)
work(lower2, {hand="glaze", pile=waterGlaze, angle=0, coverage=1.0})
blend(rect(0,520,1000,160) - spit:shrink(6), {angle=0})
