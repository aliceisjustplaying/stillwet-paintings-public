mAB = pile{{"green earth", 2.2}, {"yellow ochre", 2.1}, {"lead white", 2.0}, {"pale smalt", 0.7}, {"raw umber", 0.25}, medium=0.1}
local band = mask(function(x,y) return math.max(0, 1 - math.abs(y - 468)/11) end) * below({{-10,441},{1010,441}})
work(band, {hand="scumble", pile=mAB, angle=0, coverage=1.6, length={15,40}, pressure={0.3,0.5}, load=0.4, threshold=0.25, clip=below({{-10,441},{1010,441}})})
blend(band:grow(3), {angle=0, coverage=1.5, clip=true, tool={kind="badger", width=12}, pressure={0.25,0.4}})
print(wait(0))
