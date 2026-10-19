print(wait(36*60)); print(drying(100,620), drying(200,640))
mudDark = pile{{"raw umber",1},{"bone black",0.5},{"smalt",0.2},{"red earth",0.2}}
local o = {hand="body", tool="filbert 8", pile=mudDark, angle=function(x,y) return 0.12 + x/2500 end, angle_jitter=0.1, coverage=3.5, length={25,80}, fill=true, clip=spit3, load=0.9}
work(spit3, o)
