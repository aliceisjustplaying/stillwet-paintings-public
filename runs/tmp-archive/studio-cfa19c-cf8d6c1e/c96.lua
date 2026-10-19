local st = body.ellipsoid({108,684,0},{40,24,30}):rough(3, 20, 961):cut({108,700,0},{0,1,0}, 1, 2)
local st2 = body.ellipsoid({166,694,0},{17,11,14}):rough(1.5, 10, 962)
local stF = form{ {st}, {st2}, light={from={-1,-0.9}, front=0.3, ambient=0.2} }
stoneM = stF:silhouette{} * rect(0,0,1000,703)
local sD = pile{{"lead white",1},{"raw umber",1},{"bone black",0.4},{"Prussian blue",0.1}, medium=0.05}
local sM = pile{{"lead white",2.2},{"raw umber",0.8},{"bone black",0.2},{"yellow ochre",0.3},{"red earth",0.1}, medium=0.05}
local sL = pile{{"lead white",3.5},{"yellow ochre",0.4},{"raw umber",0.3},{"red earth",0.05}, medium=0.05}
work(stoneM, {hand="body", tool="filbert 3", pile=sD, angle=stF:field("across"), coverage=3, fill=true, clip=true, seed=963})
work(stF:lit{soft=0.3} * stoneM, {hand="body", tool="filbert 3", pile=sM, angle=stF:field("across"), coverage=2.2, clip=true, seed=964})
local hi = (stF:lit{soft=0.2} * stoneM):map(function(v) return smoothstep(0.5, 0.85, v) end)
work(hi, {hand="detail", pile=sL, tool={kind="round", width=2.0, point=0.3}, angle=stF:field("across"), coverage=1.6, clip=true, seed=965})
