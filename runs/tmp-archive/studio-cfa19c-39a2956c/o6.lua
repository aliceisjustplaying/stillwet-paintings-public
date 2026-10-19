print(wait(60*20))
print(drying(343,132))
local dead2 = pile{{"raw umber",1.6},{"bone black",0.35},{"lead white",0.45},{"yellow ochre",0.2}, medium=0.05}
local b = brush{kind="round", width=2.8, point=0.6}
b:load(dead2, 0.8)
b:stroke({{321,170},{334,150},{343,132},{356,116},{366,104}}, {pressure={0.85,0.3}, ramps={0.05,0.4}, shake=0.5})
b:load(dead2, 0.6)
b:stroke({{343,132},{334,118},{331,104}}, {pressure={0.6,0.1}, ramps={0.05,0.5}, shake=0.5})
b:stroke({{356,116},{368,114},{378,106}}, {pressure={0.55,0.1}, ramps={0.05,0.5}, shake=0.5})
b:stroke({{366,104},{366,94},{370,88}}, {pressure={0.45,0.05}, ramps={0.05,0.5}, shake=0.5})
b:stroke({{334,150},{346,146},{352,140}}, {pressure={0.45,0.05}, ramps={0.05,0.5}, shake=0.5})
-- a thin silvery light along its upper-left edge
local lt = pile{{"lead white",2},{"raw umber",0.5},{"yellow ochre",0.2}, medium=0.05}
local r = brush{kind="rigger", width=0.9, point=1}
r:load(lt, 0.4)
r:stroke({{322,166},{333,148},{341,131},{353,115}}, {pressure={0.35,0.15}, shake=0.4})
