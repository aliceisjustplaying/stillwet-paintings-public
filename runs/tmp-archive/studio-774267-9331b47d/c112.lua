local shawl = poly({{335, 509.5}, {339, 506.5}, {346, 506.5}, {350, 509.5}, {351, 515}, {346, 522}, {342.5, 530}, {339, 522}, {334.2, 515}}, true)
local creamsh = pile{{"lead white", 1.3}, {"raw umber", 0.32}, {"pale smalt", 0.4}, {"yellow ochre", 0.1}, medium=0.08}
work(shawl * poly({{344.5, 500}, {360, 500}, {360, 535}, {343, 535}}), {hand="detail", tool={kind="round", width=0.8, point=0.6}, pile=creamsh, angle=math.pi/2, coverage=1.6, fill=true, seed=11201})
local fr = brush{kind="round", width=0.45, point=1}
fr:load(creamsh, 0.4)
for i=0,7 do local t = i/7; local x = lerp(336, 342.5, t); local y = lerp(516.5, 530, t); fr:stroke({{x, y}, {x + 0.15, y + 1.4}}, {pressure={0.3, 0.05}}) end
for i=0,7 do local t = i/7; local x = lerp(342.5, 350, t); local y = lerp(530, 516.5, t); fr:stroke({{x, y}, {x + 0.15, y + 1.4}}, {pressure={0.3, 0.05}}) end
-- a fold line of the shawl down its back
fr:load(creamsh, 0.3)
fr:stroke({{342.4, 509}, {342.2, 518}, {342.5, 527}}, {pressure={0.2, 0.05}})
