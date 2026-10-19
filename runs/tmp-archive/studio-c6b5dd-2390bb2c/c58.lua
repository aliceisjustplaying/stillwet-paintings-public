col = (under:grow(4) * below(function(x) return 476 end)) - refl2
print(col:area())
local z1 = col * above(function(x) return 525 end)
local z2 = col * below(function(x) return 525 end) * above(function(x) return 610 end)
local z3 = col * below(function(x) return 610 end)
fA = pile{{"lead white",5},{"chrome yellow",0.7},{"vermilion",0.15},{"raw umber",0.05}}
fB = pile{{"lead white",5},{"pale smalt",0.8},{"vermilion",0.15},{"yellow ochre",0.2}}
fC = pile{{"lead white",4},{"smalt",1.0},{"raw umber",0.15},{"yellow ochre",0.1}}
local o = function(p) return {hand="body", tool="filbert 6", pile=p, angle=0, angle_jitter=0.05, coverage=4, load=0.9, fill=true, length={15,35}, clip=true} end
work(z1, o(fA)); work(z2, o(fB)); work(z3, o(fC))
