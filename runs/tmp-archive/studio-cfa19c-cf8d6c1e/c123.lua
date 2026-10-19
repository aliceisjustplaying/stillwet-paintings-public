local old = (townM + townM2 + townM3):grow(1.2) * rect(500,300,320,141)
local cover = old - townM4:grow(0.2)
local cb = pile{{"lead white",6},{"pale smalt",1.3},{"red earth",0.2},{"yellow ochre",0.22},{"raw umber",0.12},{"smalt",0.1}, medium=0.08}
local cr = pile{{"lead white",10},{"yellow ochre",0.45},{"vermilion",0.05},{"pale smalt",0.3},{"raw umber",0.03}, medium=0.08}
local up = cover * rect(500,300,320,114)
local lo = cover * rect(500,414,320,26)
work(up, {hand="detail", pile=cb, tool={kind="round", width=1.4, point=0.3}, angle=0.2, coverage=3.5, fill=true, clip=true, pressure={0.5,0.8}, seed=1231})
work(lo, {hand="detail", pile=cr, tool={kind="round", width=1.4, point=0.3}, angle=0.0, coverage=3.5, fill=true, clip=true, pressure={0.5,0.8}, seed=1232})
