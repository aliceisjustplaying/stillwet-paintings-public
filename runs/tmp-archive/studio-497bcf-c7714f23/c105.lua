print(drying(681,600), drying(697,590))
dress2 = pile{{"smalt", 1.2}, {"raw umber", 1.2}, {"bone black", 0.5}, {"lead white", 0.35}, {"red earth", 0.1}, medium=0.08}
work(wo_dress + wo_body + wo_bonnet, {hand="detail", pile=dress2, angle=math.pi/2, coverage=3, length={2,5}, fill=true, clip=true, edge="found"})
-- light down the left (sunward) edge of both figures: a hairline of grey
local lt = pile{{"lead white", 2}, {"pale smalt", 1}, {"raw umber", 0.4}, medium=0.08}
local r = brush{kind="round", width=1.0, point=1}
r:load(lt, 0.35)
r:stroke({{674.9,590},{674.3,600},{674.2,611}}, {pressure={0.35,0.25}})
r:stroke({{690.6,583},{690.3,592},{690.2,600}}, {pressure={0.3,0.2}})
-- the shawl's end hanging and a red ribbon at her bonnet
local sr = brush{kind="round", width=1.1, point=1}
sr:load(shawl, 0.5)
sr:stroke({{681,586},{681.5,592}}, {pressure={0.5,0.2}})
print(wait(0))
