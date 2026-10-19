fg2 = pile{{"lead white",3},{"smalt",1.3},{"raw umber",0.25},{"red earth",0.08},{"vermilion",0.03}, medium=0.1}
fg3 = pile{{"lead white",2},{"smalt",1.5},{"raw umber",0.45},{"red earth",0.12}, medium=0.1}
litS = pile{{"lead white",5},{"yellow ochre",0.15},{"vermilion",0.05},{"smalt",0.3}, medium=0.1}
local ang = function(x,y) return 0.03*math.sin(x/160) + (x<500 and -0.02 or 0.02) end
work(below(function(x) return 575 + 10*math.sin(x/130) end) * above(function(x) return 655 end), {hand="broad", pile=fg2, angle=ang, coverage=2.2, fill=true})
work(below(function(x) return 640 + 8*math.sin(x/110) end), {hand="broad", pile=fg3, angle=ang, coverage=2.2, fill=true})
blend(below(function(x) return 570 end), {angle=0})
