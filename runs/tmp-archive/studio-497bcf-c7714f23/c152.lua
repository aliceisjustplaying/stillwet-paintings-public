print(drying(280,550), drying(330,540))
cowGl = pile{{"raw umber", 1}, {"green earth", 0.8}, {"pale smalt", 0.5}, {"lead white", 0.4}, medium=0.6}
local reds = (cows[1] + cows[3]):shrink(0.3)
work(reds, {hand="detail", pile=cowGl, angle=0, coverage=1.3, length={2,5}, pressure={0.3,0.5}, load=0.35, fill=true, clip=true})
local wh = cows[2]:shrink(0.3)
local cowGl2 = pile{{"pale smalt", 1}, {"raw umber", 0.4}, {"lead white", 1.5}, {"yellow ochre", 0.2}, medium=0.6}
work(wh, {hand="detail", pile=cowGl2, angle=0, coverage=0.9, length={2,5}, pressure={0.3,0.5}, load=0.3, fill=true, clip=true})
blend(reds + wh, {angle=0, coverage=1.0, clip=true, tool={kind="badger", width=4}, pressure={0.2,0.3}})
print(wait(0))
