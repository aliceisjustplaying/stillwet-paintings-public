print(wait(24*60)); print(drying(340,300))
sailDark = pile{{"red earth",1},{"raw umber",1.1},{"bone black",0.12},{"lead white",0.1}}
sailMid = pile{{"red earth",1.2},{"raw umber",0.7},{"vermilion",0.1},{"lead white",0.15}}
local luffside = mask(function(x,y) return x < 340 and 1 or 0 end)
work(mainsail:mask()*luffside, {hand="body", tool="filbert 5", pile=sailDark, angle=-1.52, angle_jitter=0.08, coverage=2.5, fill=true, clip=true, length={25,60}})
work(mainsail:mask()-luffside, {hand="body", tool="filbert 5", pile=sailMid, angle=-1.55, angle_jitter=0.08, coverage=2.5, fill=true, clip=true, length={25,60}})
work(foresail:mask(), {hand="body", tool="filbert 5", pile=sailDark, angle=-1.25, angle_jitter=0.08, coverage=2.5, fill=true, clip=true, length={25,60}})
work(topsail:mask(), {hand="body", tool="filbert 4", pile=sailMid, angle=-1.5, coverage=2.5, fill=true, clip=true})
work(mizzen:mask(), {hand="detail", pile=sailDark, angle=-1.5, coverage=2.5, fill=true})
blend(mainsail:mask():shrink(2), {angle=-1.5})
