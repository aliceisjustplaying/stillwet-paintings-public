townL = pile{{"lead white", 6}, {"pale smalt", 1}, {"yellow ochre", 0.35}, {"red earth", 0.12}, medium=0.12}
townR = pile{{"lead white", 4}, {"pale smalt", 1.6}, {"red earth", 0.35}, {"raw umber", 0.35}, medium=0.12}
-- roofs of the naves: greyed a little
local roofs = poly({{331,410},{345,396},{420,396},{420,424},{331,424}}) + poly({{446,402},{452,398},{500,398},{508,410},{508,424},{446,424}})
work(roofs * town_all, {hand="detail", pile=townR, angle=0.0, coverage=1.2, length={5,14}, load=0.5, clip=true, edge="found"})
-- a row of small lit gable-fronted houses breaking the dark base line
houses = {}
local xs = {236, 247, 279, 291, 305, 343, 356, 372, 389, 404, 458, 471, 486, 512, 527, 542}
local m = nil
for i, x in ipairs(xs) do
  local w = 6 + (i % 3) * 1.5
  local top = 424 - (i % 4) * 1.5
  local hp = poly({{x, 438}, {x, top}, {x + w/2, top - w*0.55}, {x + w, top}, {x + w, 438}})
  m = m and (m + hp) or hp
end
houses = m
work(houses, {hand="detail", pile=townL, angle=math.pi/2, coverage=2.0, length={3,7}, fill=true, clip=true, edge="found"})
print(wait(0))
