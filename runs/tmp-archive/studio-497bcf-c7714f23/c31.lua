mL2 = pile{{"yellow ochre", 3}, {"green earth", 2}, {"lead white", 2.2}, {"chrome yellow", 0.25}, {"Prussian blue", 0.06}, {"raw umber", 0.25}, medium=0.1}
local A = poly({{-10,521},{120,519},{280,520},{380,523},{450,528},{380,531},{260,534},{100,536},{-10,537}}, true)
local B = poly({{640,506},{740,503},{860,503},{1010,504},{1010,514},{880,513},{760,512},{680,510}}, true)
local C = poly({{480,582},{600,574},{760,571},{900,572},{1010,570},{1010,600},{480,600}}, true)
keepSh = (A + B + C):roughen(2, 25, 51) * mid_m
local lights = mid_m * mask(function(x,y) return y > 470 and 1 or 0 end) - keepSh
work(lights, {hand="body", pile=mL2, angle=0, coverage=1.7, length={20,55}, pressure={0.4,0.7}, fill=true, clip=mid_m, edge="soft", threshold=0.4})
blend(lights, {angle=0, coverage=1.2, clip=true, tool={kind="badger", width=16}, pressure={0.25,0.4}})
print(wait(0))
