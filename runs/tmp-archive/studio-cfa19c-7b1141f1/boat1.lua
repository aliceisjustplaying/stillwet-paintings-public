-- a small river barge with tanned gaff sail, heading upstream toward the town
boatHull = poly({{642.5,480.6},{647,481.4},{656,481.6},{662.5,480.4},{660.5,484.2},{646,484.4}})
boatSail = poly({{651.2,479.6},{651.2,452.5},{663.5,447.5},{665.5,479.2}})
boatJib  = poly({{650.2,454.5},{642.5,479.4},{650.2,479.6}})
local sailP = pile{{"red earth",1},{"yellow ochre",0.7},{"lead white",1.3},{"pale smalt",0.15}, medium=0.05}
local sailS = pile{{"red earth",1},{"raw umber",0.5},{"yellow ochre",0.3},{"lead white",0.8},{"pale smalt",0.2}, medium=0.05}
local hullP = pile{{"raw umber",1},{"bone black",0.4},{"lead white",0.35},{"pale smalt",0.15}, medium=0.05}
work(boatSail, {hand="detail", pile=sailP, tool={kind="round", width=1.2, point=0.4}, angle=math.pi/2, coverage=3.5, fill=true, clip=true, edge="found", pressure={0.5,0.8}, seed=3701})
work(boatJib, {hand="detail", pile=sailS, tool={kind="round", width=1.0, point=0.4}, angle=math.pi/2, coverage=3.5, fill=true, clip=true, edge="found", pressure={0.5,0.8}, seed=3702})
work(boatHull, {hand="detail", pile=hullP, tool={kind="round", width=1.0, point=0.4}, angle=0, coverage=3.5, fill=true, clip=true, edge="found", pressure={0.5,0.8}, seed=3703})
