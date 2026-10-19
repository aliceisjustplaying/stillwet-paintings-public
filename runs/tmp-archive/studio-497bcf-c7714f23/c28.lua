shG = pile{{"green earth", 3}, {"raw umber", 0.8}, {"Prussian blue", 0.25}, {"yellow ochre", 0.8}, {"lead white", 0.3}, medium=0.3}
local s1 = poly({{-10,524},{90,519},{210,516},{330,518},{430,523},{480,529},{420,535},{300,538},{150,541},{-10,543}}, true):roughen(2.5, 25, 41)
local s2 = poly({{590,506},{680,502},{800,501},{910,503},{1010,505},{1010,517},{910,519},{770,518},{650,514}}, true):roughen(2, 25, 42)
local s3 = poly({{430,570},{560,563},{720,561},{870,565},{1010,562},{1010,600},{430,600}}, true):roughen(3, 35, 43)
local s4 = poly({{600,538},{700,535},{780,537},{740,543},{640,544}}, true):roughen(1.5, 18, 44)
shad2 = (s1 + s2 + s3 + s4) * mid_m
work(shad2, {hand="body", pile=shG, angle=0, coverage=1.6, length={20,55}, pressure={0.4,0.65}, fill=true, clip=shad2:grow(1.5), edge="soft", load=0.6})
blend(shad2:grow(3), {angle=0, coverage=1.4, clip=true, tool={kind="badger", width=12}, pressure={0.2,0.35}})
print(wait(0))
