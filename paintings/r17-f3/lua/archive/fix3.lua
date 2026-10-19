local lD = pile{{"green earth",1.6},{"raw umber",0.75},{"Prussian blue",0.3},{"yellow ochre",0.45},{"lead white",0.3}, medium=0.07}
local band = PWCRALL:shrink(1.5) * mask(function(x,y) return math.abs(y - hzc(x)) < 3.5 and 1 or 0 end)
work(band, {hand="detail", pile=lD, tool={kind="round", width=1.6, point=0.4}, angle=0, length={4,10}, coverage=3, clip=true, fill=true, load=0.8})
stipple(band:grow(1.5) * PWCRALL:shrink(1), {pile=lD, width=1.8, coverage=1.5, pressure={0.5,0.8}, cluster=0.4})
print(wait(0))
