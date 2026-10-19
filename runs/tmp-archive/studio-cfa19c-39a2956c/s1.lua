local st = body.ellipsoid({108,684,0},{40,24,30}):rough(3, 20, 961):cut({108,700,0},{0,1,0}, 1, 2)
local st2 = body.ellipsoid({166,694,0},{17,11,14}):rough(1.5, 10, 962)
stF = form{ {st}, {st2}, light={from={-1,-0.9}, front=0.3, ambient=0.2} }
local stSh = pile{{"raw umber",1.2},{"lead white",1.2},{"pale smalt",0.5},{"bone black",0.2}, medium=0.35}
local sh = stF:shadow{soft=0.5} * stoneM
work(sh, {hand="glaze", pile=stSh, tool={kind="filbert", width=5, stiffness=0.2}, angle=stF:field("across"), coverage=1.3, clip=stoneM, pressure={0.3,0.5}, seed=3501})
local all = pile{{"raw umber",1},{"lead white",1.6},{"yellow ochre",0.3},{"green earth",0.3}, medium=0.45}
work(stoneM, {hand="glaze", pile=all, tool={kind="filbert", width=6, stiffness=0.2}, angle=stF:field("across"), coverage=0.8, clip=stoneM, pressure={0.25,0.4}, seed=3503})
local ground = pile{{"Prussian blue",0.8},{"raw umber",1.2},{"green earth",0.8},{"bone black",0.2}, medium=0.05}
stipple((stoneM:grow(3) - stoneM) * rect(60,688,140,30), {pile=ground, width=2.5, coverage=1.4, pressure={0.4,0.8}, cluster={0.5,3}, seed=3502})
