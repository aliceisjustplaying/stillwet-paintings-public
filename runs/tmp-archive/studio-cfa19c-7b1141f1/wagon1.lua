-- a hay wagon being loaded on the mown meadow, a bay horse in the shafts
local loadM = poly({{791.5,537.2},{791,533},{792.6,529.6},{796,527.6},{801,526.8},{806,527.2},{810.4,528.8},{813,531.8},{813.4,537.8}}, true)
local bedM = poly({{791.2,536.8},{813.6,537.6},{813.4,538.9},{791.2,538.1}})
local shadowM = poly({{793,540.6},{816,541.8},{826,542.6},{822,543.8},{806,543.2},{794,542}})
wagonLoad, wagonBed = loadM, bedM
local hayShadow = pile{{"yellow ochre",1},{"raw umber",0.6},{"green earth",0.4},{"lead white",0.5},{"pale smalt",0.2}, medium=0.15}
work(shadowM, {hand="detail", pile=hayShadow, tool={kind="round", width=1.0, point=0.4}, angle=0.05, coverage=2.2, fill=true, clip=true, pressure={0.4,0.6}, seed=3821})
local hayL = pile{{"yellow ochre",1.2},{"lead white",1.3},{"raw umber",0.1},{"chrome yellow",0.08}, medium=0.05}
local hayS = pile{{"yellow ochre",1},{"raw umber",0.45},{"lead white",0.7},{"pale smalt",0.15}, medium=0.05}
work(loadM, {hand="detail", pile=hayL, tool={kind="round", width=1.1, point=0.4}, angle=0.3, coverage=3.5, fill=true, clip=true, pressure={0.45,0.7}, seed=3822})
local shade = loadM * mask(function(x,y) return smoothstep(0, 1, (x - 804)/5 + (y - 530)/4) end)
work(shade, {hand="detail", pile=hayS, tool={kind="round", width=1.0, point=0.4}, angle=0.3, coverage=3, fill=true, clip=true, pressure={0.4,0.65}, seed=3823})
local wd = pile{{"raw umber",1},{"bone black",0.35},{"red earth",0.2},{"lead white",0.3}, medium=0.05}
work(bedM, {hand="detail", pile=wd, tool={kind="round", width=0.7, point=0.4}, angle=0.04, coverage=3.5, fill=true, clip=true, pressure={0.45,0.65}, seed=3824})
