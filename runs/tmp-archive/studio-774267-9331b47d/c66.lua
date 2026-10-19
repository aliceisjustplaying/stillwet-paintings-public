local protect = (MAN + WOMAN):grow(1.5) + BOULD:grow(1) + NARROW:shrink(1)
local fgz = below(function(x) return fg(x) + 3 end) - protect
local nz = noise{seed=31, octaves=3, period=60, stretch={0, 2.5}}
local dk = pile{{"green earth", 1.6}, {"raw umber", 0.8}, {"Prussian blue", 0.08}, {"yellow ochre", 0.4}, {"bone black", 0.05}, medium=0.15}
local lt = pile{{"green earth", 1.5}, {"yellow ochre", 1.3}, {"chrome yellow", 0.12}, {"lead white", 0.4}, medium=0.15}
stipple(fgz, {pile=dk, width=2.6, coverage=function(x, y) return 0.9*clamp(nz:at01(x, y)*1.6 - 0.5, 0, 1) end, cluster=0.5, drag={1.5, -0.2}, dips={20, 0.5, 0.5}, seed=6601})
stipple(fgz * mask(function(x, y) return (y - fg(x) < 60) and 1 or 0 end), {pile=lt, width=2.2, coverage=function(x, y) return 0.7*clamp(0.9 - nz:at01(x + 300, y)*1.4, 0, 1) end, cluster=0.5, drag={1.5, -0.2}, dips={20, 0.5, 0.5}, seed=6602})
