cowGrSh = pile{{"green earth", 2.4}, {"raw umber", 1.1}, {"lead white", 1.0}, {"pale smalt", 0.6}, {"yellow ochre", 0.4}, medium=0.08}
local cowsAll = cows[1] + cows[2] + cows[3]
local sh = ellipse(287, 562.6, 24, 1.9) + ellipse(328, 549.6, 22, 1.7) + ellipse(72, 533.5, 19, 1.5) + ellipse(125, 551.6, 5, 0.8)
sh = sh:roughen(0.6, 3, 901) - cowsAll
work(sh, {hand="detail", pile=cowGrSh, angle=0, coverage=2.2, length={2,6}, fill=true, clip=true, edge="soft", load=0.55})
-- grass over the hooves
local g = brush{kind="rigger", width=0.9, point=1}
for _, c in ipairs({{258, 306, 562}, {301, 345, 549}, {49, 87, 533}}) do
  for k = 1, 16 do
    g:load((k % 3 == 0) and pastL or pastC, 0.45)
    local x = rand(c[1], c[2])
    local y = c[3] + rand(0.2, 1.4)
    g:stroke({{x, y}, {x + rand(-0.6, 0.6), y - rand(1.6, 3.0)}}, {pressure={0.5, 0.05}})
  end
end
print(wait(0))
