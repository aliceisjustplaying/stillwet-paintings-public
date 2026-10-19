local far = pile{{"lead white",6},{"pale smalt",1.1},{"raw umber",0.25},{"red earth",0.04}, medium=0.08}
local nz = noise{seed=7901, period=25, octaves=3}
local top = function(x) return 465.8 - 1.2*smoothstep(560, 510, x) - 1.0*smoothstep(830, 880, x) + 0.9*nz(x, 0) end
local m = (below(top) * rect(505, 455, 380, 15) * above(function(x) return 469.6 end)) - TOWN:shrink(0.2) - LAND
work(m, {hand="detail", pile=far, tool={kind="round", width=1.2, point=0.4}, angle=0, length={4,12}, coverage=2.5, clip=true, fill=true, load=0.7})
print(wait(0))
