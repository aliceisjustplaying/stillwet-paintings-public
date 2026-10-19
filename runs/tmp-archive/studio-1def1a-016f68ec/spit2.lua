mudDD = pile{{"raw umber",1},{"bone black",0.35},{"smalt",0.25},{"red earth",0.15}}
local inner = spit2:shrink(12)
work(inner * mask(function(x,y) return clamp((y-580)/40,0,1) end), {hand="body", pile=mudDD, angle=0.15, angle_jitter=0.1, coverage=2, length={30,90}})
blend(spit2:shrink(2), {angle=0.12})
