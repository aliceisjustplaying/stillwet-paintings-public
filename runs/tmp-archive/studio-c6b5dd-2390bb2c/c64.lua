gw7 = pile{{"lead white",2},{"smalt",1.5},{"Prussian blue",0.06},{"raw umber",0.5},{"red earth",0.1}}
local bot = openW * below(function(x) return 655 + 6*math.sin(x/70) end)
work(bot, {hand="body", tool="filbert 12", pile=gw7, angle=0, angle_jitter=0.02, coverage=2.5, load=0.8, fill=true, length={80,200}, clip=openW})
local mid = openW * below(function(x) return 625 end)
blend(mid, {angle=0, angle_jitter=0.015, tool="badger 30", length={80,220}})
blend(openW * rect(0,635,1000,40), {angle=1.5, angle_jitter=0.15, tool="badger 16", length={25,50}})
blend(mid, {angle=0, angle_jitter=0.01, tool="badger 30", length={100,250}, pressure={0.25,0.4}})
