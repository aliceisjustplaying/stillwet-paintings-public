local town = (townM + townM2):grow(0.3)
local cut = rect(0,0,1000,413)
local shd = (cloud2F:shadow{} * cut - town):soften(4)
local gl = pile{{"lead white",2},{"pale smalt",1.5},{"smalt",0.3},{"red earth",0.3},{"raw umber",0.3}, medium=0.6}
work(shd * cloud2M, {hand="glaze", pile=gl, tool={kind="filbert", width=12, stiffness=0.2}, angle=cloud2F:field("across"), coverage=1.4, clip=true, seed=1031})
local belly = cloud2M * mask(function(x,y) return smoothstep(340, 395, y) * smoothstep(600, 700, x) end) - town
work(belly, {hand="glaze", pile=gl, tool={kind="filbert", width=14, stiffness=0.2}, angle=0.05, coverage=1.0, clip=true, seed=1032})
