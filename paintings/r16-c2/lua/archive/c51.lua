hull = poly({{178,598},{205,602},{230,604},{260,602},{283,598},{297,591},{291,603},{276,611},{246,617},{214,617},{190,613},{180,608}}, true)
inner = poly({{181,597},{200,595},{240,594},{278,591},{296,590},{283,598},{260,602},{230,604},{205,602}}, true)
shadowB = poly({{170,612},{200,618},{250,621},{290,614},{305,610},{300,617},{250,625},{200,623},{168,617}}, true):soften(1.5)
hullP = pile{{"bone black",0.5},{"Prussian blue",0.08},{"raw umber",0.7},{"lead white",0.35}}
innerP = pile{{"raw umber",1},{"yellow ochre",0.5},{"lead white",0.9},{"red earth",0.2}}
shP = pile{{"raw umber",1},{"bone black",0.7},{"cobalt blue",0.2}, medium=0.3}
work(shadowB, {hand="detail", tool="round 3", pile=shP, angle=0, coverage=2, length={8,20}, fill=true})
work(inner, {hand="detail", tool="round 2", pile=innerP, angle=-0.05, coverage=2.5, length={6,15}, fill=true})
work(hull, {hand="detail", tool="round 2.5", pile=hullP, angle=-0.05, coverage=3, length={6,18}, fill=true})
