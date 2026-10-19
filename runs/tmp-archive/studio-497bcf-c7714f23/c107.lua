dress3 = pile{{"bone black", 1}, {"raw umber", 1.2}, {"red earth", 0.35}, {"smalt", 0.4}, medium=0.08}
work(wo_dress:shrink(0.4) + wo_body:shrink(0.3), {hand="detail", pile=dress3, angle=math.pi/2, coverage=3, length={2,5}, fill=true, clip=true, edge="found"})
local lt = pile{{"lead white", 1.5}, {"pale smalt", 1}, {"raw umber", 0.6}, {"red earth", 0.1}, medium=0.08}
local r = brush{kind="round", width=1.0, point=1}
r:load(lt, 0.35)
r:stroke({{675.3,592},{674.6,602},{674.4,611}}, {pressure={0.35,0.25}})
-- elder flowers: flat creamy umbels scattered over the upper, lit part of the bush
elderF = pile{{"lead white", 6}, {"yellow ochre", 0.35}, {"chrome yellow", 0.06}, medium=0.08}
elderFs = pile{{"lead white", 3}, {"yellow ochre", 0.4}, {"pale smalt", 0.5}, {"raw umber", 0.2}, medium=0.08}
local fb = brush{kind="round", width=1.4, point=0.5}
local count = 0
for i = 1, 70 do
  local x, y = rand(850, 1000), rand(478, 640)
  if elder2:at(x, y) > 0.9 and elder2:at(x, y - 6) > 0.5 then
    local s = 2.2 + (y - 470) / 60
    local lit = ((x - 960) * -0.7 + (y - 600) * -0.5) > -20
    fb:load(lit and elderF or elderFs, 0.5)
    for k = 1, 6 do
      local a = rand(0, 2*math.pi)
      local d = rand(0, 1) * s
      fb:touch(x + d*math.cos(a), y + d*math.sin(a)*0.45, {pressure=rand(0.35, 0.6)})
    end
    count = count + 1
  end
end
print(count, wait(0))
