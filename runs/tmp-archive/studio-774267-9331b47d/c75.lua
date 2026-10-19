-- green the hedges, darker toward us; bluish only at the far rows
local near = HEDGES * mask(function(x, y) return y > 415 and 1 or 0 end)
local farh = HEDGES - near
local gnear = pile{{"green earth", 1.5}, {"raw umber", 0.45}, {"yellow ochre", 0.3}, {"Prussian blue", 0.05}, {"lead white", 0.35}, medium=0.12}
local gfar = pile{{"green earth", 1.2}, {"pale smalt", 0.6}, {"lead white", 0.7}, {"raw umber", 0.25}, {"yellow ochre", 0.2}, medium=0.12}
stipple(near:grow(0.4), {pile=gnear, width=1.2, coverage=1.6, cluster=0.5, clip=true, seed=7501})
stipple(farh:grow(0.3), {pile=gfar, width=1.0, coverage=1.4, cluster=0.5, clip=true, seed=7502})
local lit = mask(function(x, y) if HEDGES:at(x, y) < 0.5 then return 0 end; return (HEDGES:at(x - 1.2, y - 1.5) < 0.5) and 1 or 0 end)
local lp = pile{{"lead white", 1.2}, {"green earth", 1}, {"yellow ochre", 0.9}, {"chrome yellow", 0.12}, medium=0.1}
stipple(lit, {pile=lp, width=0.9, coverage=0.9, cluster=0.4, clip=true, seed=7503})
