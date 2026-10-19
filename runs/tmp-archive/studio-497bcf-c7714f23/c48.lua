gG  = pile{{"green earth", 3}, {"yellow ochre", 1.6}, {"lead white", 1.6}, {"Prussian blue", 0.1}, {"chrome yellow", 0.2}, {"raw umber", 0.15}, medium=0.1}
gGf = pile{{"green earth", 3}, {"yellow ochre", 1.4}, {"lead white", 2.4}, {"pale smalt", 0.5}, {"raw umber", 0.15}, medium=0.1}
straw = pile{{"lead white", 4}, {"yellow ochre", 2}, {"green earth", 1}, {"raw umber", 0.2}, {"red earth", 0.05}, medium=0.1}
fieldB = poly({{318,522},{420,519},{560,515},{720,511},{880,508},{1010,507},{1010,574},{820,577},{640,579},{470,582},{430,581}})
local keep = river2:grow(1.5) + fore_m
fieldA = mask(function(x,y) return (y > 466 and y < 532) and 1 or 0 end) * mid_m - fieldB - keep
fieldC = mid_m * mask(function(x,y) return y >= 520 and 1 or 0 end) - fieldB - keep - fieldA
local fa_far = fieldA * mask(function(x,y) return y < 490 and 1 or 0 end)
work(fa_far, {hand="body", pile=gGf, angle=0, coverage=1.8, length={15,45}, pressure={0.4,0.7}, fill=true, clip=fa_far:grow(1), edge="soft"})
work(fieldA - fa_far, {hand="body", pile=gG, angle=0, coverage=1.8, length={15,50}, pressure={0.4,0.7}, fill=true, clip=(fieldA - fa_far):grow(1), edge="soft"})
work(fieldC, {hand="body", pile=gG, angle=0, coverage=1.8, length={15,50}, pressure={0.4,0.7}, fill=true, clip=fieldC:grow(1), edge="soft"})
work(fieldB - keep, {hand="body", pile=straw, angle=-0.02, coverage=1.8, length={20,60}, pressure={0.4,0.7}, fill=true, clip=(fieldB-keep):grow(1), edge="firm"})
local soft = (fieldA + fieldC):grow(2) * mid_m - river2:grow(1)
blend(soft, {angle=0, coverage=1.2, clip=true, tool={kind="badger", width=16}, pressure={0.25,0.4}})
blend(fieldB - keep, {angle=-0.02, coverage=1.0, clip=true, tool={kind="badger", width=16}, pressure={0.25,0.4}})
print(wait(0))
