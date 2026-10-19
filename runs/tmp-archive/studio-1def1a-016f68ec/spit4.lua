spit3 = outline{{-30,574},{40,568},{110,566},{190,575},{260,594},{320,620},{370,652},{400,700,"c"},{-30,700,"c"}, closed=true, char="firm", amount=0.5, seed=95}:mask()
mudA = pile{{"raw umber",1},{"bone black",0.3},{"red earth",0.25},{"smalt",0.15},{"lead white",0.1}}
work(spit3, {hand="body", pile=mudA, angle=function(x,y) return 0.12 + x/2500 end, angle_jitter=0.08, coverage=3, length={30,90}, fill=true, edge={found=0.5, soft=0.5, period=50}})
