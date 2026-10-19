glazeSoft = pile{{"pale smalt",1},{"raw umber",0.12},{"lead white",0.25},{"vermilion",0.02}, medium=0.85}
local m = rect(880,676,120,40)
work(m, {hand="glaze", pile=glazeSoft, coverage=1.2, clip=true, angle=0, load=0.5, pressure={0.3,0.5}})
blend(m, {angle=0})
