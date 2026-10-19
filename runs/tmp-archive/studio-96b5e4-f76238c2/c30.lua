gz = pile{{"raw umber",1},{"green earth",0.7},{"bone black",0.25}, medium=0.8}
local fgm = (marsh - creek:grow(3)) * below(function(x) return 545 + 10*math.sin(x/71) end)
local deep = (marsh - creek:grow(3)) * below(function(x) return 610 + 12*math.sin(x/43) end)
work(fgm, {hand="glaze", pile=gz, angle=0, coverage=1.3, clip=fgm})
work(deep, {hand="glaze", pile=gz, angle=0.05, coverage=1.3, clip=deep})
local bm = (marsh - creek:grow(4)) * below(function(x) return 520 + 10*math.sin(x/71) end)
blend(bm, {angle=0}); blend(bm, {angle=0.12}); blend(bm, {angle=-0.08})
