print(wait(90))
-- shepherd standing, leaning on his crook, facing the flock (left); dog lying by him
local coat = poly({{177.2,500.2},{179.4,500.2},{180.2,504.8},{176.6,504.8}})
local legs = poly({{177.4,504.6},{179.6,504.6},{179.4,507},{177.6,507}})
local head = ellipse(178.3,499.2,0.8,0.85)
local hat = poly({{176.9,498.6},{179.7,498.6},{179.2,498.0},{177.4,498.0}})
local sh = ellipse(181.5,507.2,3.2,0.6)
local dog = ellipse(171.5,506.2,1.6,0.75) + ellipse(170.0,505.6,0.6,0.55)
local dsh = ellipse(172.8,506.9,1.8,0.4)
local gsh = pile{{"Prussian blue",0.5},{"raw umber",1},{"green earth",0.8},{"yellow ochre",0.6},{"lead white",0.4}, medium=0.15}
work(sh + dsh - legs - dog, {hand="detail", pile=gsh, tool={kind="round", width=0.8, point=0.4}, angle=0, coverage=2, fill=true, clip=true, pressure={0.35,0.6}, seed=3811})
local cp = pile{{"raw umber",1},{"smalt",0.3},{"bone black",0.3},{"lead white",0.5}, medium=0.05}
work(coat + hat, {hand="detail", pile=cp, tool={kind="round", width=0.7, point=0.4}, angle=math.pi/2, coverage=3.5, fill=true, clip=true, pressure={0.45,0.7}, seed=3812})
local lg = pile{{"raw umber",1},{"yellow ochre",0.4},{"lead white",0.8}, medium=0.05}
work(legs, {hand="detail", pile=lg, tool={kind="round", width=0.6, point=0.4}, angle=math.pi/2, coverage=3, fill=true, clip=true, pressure={0.4,0.6}, seed=3813})
local sk = pile{{"lead white",1.5},{"red earth",0.35},{"yellow ochre",0.4},{"raw umber",0.1}, medium=0.05}
work(head, {hand="detail", pile=sk, tool={kind="round", width=0.6, point=0.4}, angle=0, coverage=3, fill=true, clip=true, pressure={0.4,0.6}, seed=3814})
local dg = pile{{"raw umber",1},{"bone black",0.5},{"lead white",0.3}, medium=0.05}
work(dog, {hand="detail", pile=dg, tool={kind="round", width=0.6, point=0.4}, angle=0, coverage=3, fill=true, clip=true, pressure={0.4,0.6}, seed=3815})
local r = brush{kind="rigger", width=0.5, point=1}
r:reload(dg, 0.5)
r:stroke({{175.6,497.4},{175.9,502},{176.2,507.2}}, {pressure={0.35,0.3}})
r:stroke({{175.6,497.4},{174.8,497.0},{174.6,497.9}}, {pressure={0.3,0.2}})
