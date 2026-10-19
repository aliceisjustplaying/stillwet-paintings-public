sailDeep = pile{{"red earth",1},{"raw umber",1.3},{"bone black",0.15},{"lead white",0.08}}
sailMid2 = pile{{"red earth",1.2},{"raw umber",0.8},{"vermilion",0.08},{"lead white",0.12}}
local mm = mainsail:mask()
local left = mask(function(x,y) return x < 348 + 10*math.sin(y/40) and 1 or 0 end)
work(mm*left, {hand="body", tool="filbert 5", pile=sailDeep, angle=-1.5, angle_jitter=0.06, coverage=3, fill=true, clip=mm, length={30,70}})
work(mm-left, {hand="body", tool="filbert 5", pile=sailMid2, angle=-1.53, angle_jitter=0.06, coverage=3, fill=true, clip=mm, length={30,70}})
work(topsail:mask(), {hand="body", tool="filbert 4", pile=sailMid2, angle=-1.3, coverage=3, fill=true, clip=topsail:mask()})
local seam = mm * mask(function(x,y) local c = 348 + 10*math.sin(y/40); return clamp(1 - math.abs(x-c)/14, 0, 1) end)
blend(seam, {angle=-1.5, tool="filbert 8"})
