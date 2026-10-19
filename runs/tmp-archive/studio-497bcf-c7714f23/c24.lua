mid_m = below({{-10,468},{1010,468}}) - below(rise_top)
mA = pile{{"green earth", 2.2}, {"yellow ochre", 2}, {"lead white", 1.8}, {"pale smalt", 0.6}, {"raw umber", 0.3}, medium=0.1}
mB = pile{{"yellow ochre", 3}, {"green earth", 2}, {"lead white", 1.6}, {"chrome yellow", 0.3}, {"Prussian blue", 0.1}, {"raw umber", 0.2}, medium=0.1}
mC = pile{{"green earth", 2.5}, {"yellow ochre", 1.6}, {"raw umber", 1.0}, {"Prussian blue", 0.18}, {"lead white", 0.8}, medium=0.1}
local zA = mask(function(x,y) return 1 - smoothstep(488, 508, y) end) * mid_m
local zB = mask(function(x,y) return smoothstep(488, 508, y) end) * mid_m
work(zA, {hand="body", pile=mA, angle=0, coverage=1.8, length={25,60}, pressure={0.45,0.75}, fill=true, clip=mid_m, edge="soft", threshold=0.2})
work(zB, {hand="body", pile=mB, angle=0, coverage=1.8, length={25,70}, pressure={0.45,0.75}, fill=true, clip=mid_m, edge="soft", threshold=0.2})
-- deliberate cloud shadows: long flat shapes lying on the meadow
cs1 = poly({{-10,522},{80,516},{200,513},{330,515},{420,520},{470,527},{430,534},{300,537},{150,540},{-10,541}}, true):roughen(3, 30, 31)
cs2 = poly({{560,507},{650,502},{780,500},{900,503},{1010,505},{1010,520},{900,522},{760,519},{640,517}}, true):roughen(2.5, 30, 32)
cs3 = poly({{380,568},{520,560},{700,558},{860,563},{1010,560},{1010,600},{380,600}}, true):roughen(3, 40, 33)
cs4 = poly({{120,487},{220,484},{330,485},{360,490},{250,493},{140,494}}, true):roughen(1.5, 20, 34)
csh = (cs1 + cs2 + cs3 + cs4) * mid_m
work(csh, {hand="body", pile=mC, angle=0, coverage=1.8, length={20,60}, pressure={0.45,0.75}, fill=true, clip=mid_m, edge="soft"})
blend(mid_m, {angle=0, coverage=1.8, clip=true, tool={kind="badger", width=28}})
blend(mid_m, {angle=0.12, coverage=1.0, clip=true, tool={kind="badger", width=20}, pressure={0.25,0.4}})
print(wait(0))
