print(wait(20*60))
print(drying(340,300))
glazeU = pile{{"raw umber",1},{"red earth",0.5},{"bone black",0.1}, medium=0.6}
local sails = mainsail:mask() + topsail:mask() + foresail:mask() + mizzen:mask()
-- darken the lower sails and the forward parts
local lower = sails * mask(function(x,y) return clamp((y-230)/120,0,1) end)
work(lower, {hand="glaze", tool="filbert 10", pile=glazeU, angle=-1.5, coverage=1.5, clip=true})
work(foresail:mask(), {hand="glaze", tool="filbert 10", pile=glazeU, angle=-1.3, coverage=1.5, clip=true})
