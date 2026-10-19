mudGlaze = pile{{"bone black",0.6},{"raw umber",1},{"smalt",0.2}, medium=0.5}
local corner = spit3 * mask(function(x,y) return clamp(((y-600) - 0.35*x)/30 + 0.5, 0, 1) end)
work(corner, {hand="glaze", pile=mudGlaze, angle=0.15, coverage=1.2, clip=spit3})
sheen2 = pile{{"lead white",2},{"smalt",0.4},{"red earth",0.25},{"raw umber",0.3},{"yellow ochre",0.4}}
local sheenZone = spit3:shrink(10) * mask(function(x,y) local v = 1 - ((y-600) - 0.35*x)/40; return clamp(v,0,1) end)
work(sheenZone, {hand="scumble", tool="filbert 6", pile=sheen2, angle=function(x,y) return 0.18 + x/2500 end, coverage=0.5, pressure={0.12,0.3}, load=0.25, length={20,60}, clip=spit3:shrink(4)})
