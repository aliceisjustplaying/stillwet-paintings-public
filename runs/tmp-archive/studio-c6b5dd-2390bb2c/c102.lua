local hm = hills * above(function(x) return 447 end)
pHill2 = pile{{"lead white",4},{"smalt",1.2},{"red earth",0.3},{"raw umber",0.2},{"vermilion",0.12}}
work(hm, {hand="body", tool="filbert 6", pile=pHill2, angle=0, angle_jitter=0.1, coverage=3.5, load=0.85, fill=true, length={20,60}, clip=hm})
