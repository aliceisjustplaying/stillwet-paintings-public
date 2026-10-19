lz = pile{{"yellow ochre",1},{"raw umber",0.5},{"green earth",1}, medium=0.65}
local L = lemons:grow(1)
local S = L * mask(function(x,y) return lf:value(x,y) end):map(function(v) return 1 - smoothstep(0.3, 0.5, v) end)
work(S, {hand="glaze", tool={kind="filbert", width=10, stiffness=0.3}, pile=lz, clip=L, angle=function(x,y) return lf:across(x,y) end, length={20,45}, coverage=2.5, threshold=0.4})
blend(L, {angle=function(x,y) return lf:across(x,y) end, tool={kind="badger", width=12}})
