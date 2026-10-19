wait(60*24*3)
local town = townM4:grow(1)
local cut = rect(0,0,1000,414)
local CM = (cloud2M:grow(8) * cut) - town
local shd = cloud2F:shadow{soft=0.45} * cut
local gl = pile{{"lead white",2},{"pale smalt",1.6},{"smalt",0.35},{"red earth",0.3},{"raw umber",0.3}, medium=0.55}
local w = CM:shrink(3) * (shd + mask(function(x,y) return 0.8*smoothstep(345, 400, y) end))
work(w, {hand="glaze", pile=gl, tool={kind="filbert", width=12, stiffness=0.2}, angle=cloud2F:field("across"), coverage=1.3, clip=true, edge="found", pressure={0.3,0.5}, seed=1531})
blend(CM:shrink(4), {tool={kind="badger", width=12}, angle=cloud2F:field("across"), coverage=1.5, clip=true, pressure={0.2,0.4}, seed=1532})
