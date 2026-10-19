land = -sky
snowFar  = pile{{"lead white",6},{"pale smalt",1},{"yellow ochre",0.15},{"vermilion",0.03}, medium=0.12}
snowMid  = pile{{"lead white",5},{"pale smalt",1.6},{"smalt",0.3},{"raw umber",0.1}, medium=0.12}
snowNear = pile{{"lead white",4},{"pale smalt",2},{"smalt",0.6},{"raw umber",0.2},{"bone black",0.04}, medium=0.12}
moundP   = pile{{"lead white",4.5},{"pale smalt",1.8},{"smalt",0.4},{"raw umber",0.15},{"vermilion",0.02}, medium=0.12}
local moundM = land * below({{0,470},{100,470},{200,470},{600,470},{700,480}}):map(function(v) return 1-v end)
work(land * rect(-20,460,1040,80), {hand="broad", pile=snowFar, angle=0, coverage=2, fill=true, angle_jitter=0.03, pressure={0.4,0.7}})
work(land * rect(-20,520,1040,90), {hand="broad", pile=snowMid, angle=0, coverage=2, fill=true, angle_jitter=0.04, pressure={0.4,0.7}})
work(land * rect(-20,590,1040,140), {hand="broad", pile=snowNear, angle=0.02, coverage=2, fill=true, angle_jitter=0.06, pressure={0.4,0.8}})
work(moundM, {hand="body", pile=moundP, angle=0.05, coverage=2, fill=true, angle_jitter=0.1, pressure={0.4,0.7}})
