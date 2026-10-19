print(wait(60*24))
local dead3 = pile{{"raw umber",2},{"bone black",0.8},{"lead white",0.3}, medium=0.02}
local b = brush{kind="round", width=2.4, point=0.5}
for i=1,2 do
b:load(dead3, 1.0)
b:stroke({{321,170},{334,150},{343,132},{356,116},{366,104}}, {pressure={0.9,0.35}, ramps={0.05,0.3}, shake=0.4})
b:load(dead3, 0.8)
b:stroke({{343,132},{334,118},{331,104}}, {pressure={0.7,0.15}, ramps={0.05,0.5}, shake=0.4})
b:stroke({{356,116},{368,114},{378,106}}, {pressure={0.65,0.15}, ramps={0.05,0.5}, shake=0.4})
b:stroke({{366,104},{366,94},{370,88}}, {pressure={0.5,0.1}, ramps={0.05,0.5}, shake=0.4})
b:stroke({{334,150},{346,146},{352,140}}, {pressure={0.5,0.1}, ramps={0.05,0.5}, shake=0.4})
end
