function hzc(x) return 468 - (13 + 5*math.exp(-((x-170)/80)^2)) * (1 - smoothstep(300, 370, x)) end
LAND = below(hzc)
function rtop(x) return 485.5 - 5*(x-330)/670 + 1.2*math.sin(x/37) end
function rbot(x) return 487 + 6*(x-330)/670 + 1.5*math.sin(x/53+1) end
RIVER = (below(rtop) * above(rbot) * mask(function(x,y) return smoothstep(328,350,x) end)):soften(0.6)
local Lp = {
 {pile{{"lead white",5},{"pale smalt",1.2},{"green earth",1.2},{"yellow ochre",0.6},{"raw umber",0.2}, medium=0.12}, 430, 489, "filbert 6", {10,30}},
 {pile{{"lead white",4},{"yellow ochre",1.4},{"green earth",1},{"Prussian blue",0.08},{"pale smalt",0.4}, medium=0.12}, 484, 522, "filbert 7", {15,40}},
 {pile{{"lead white",3},{"yellow ochre",2},{"chrome yellow",0.6},{"Prussian blue",0.18},{"green earth",0.5}, medium=0.12}, 516, 572, "filbert 8", {20,50}},
 {pile{{"lead white",1.5},{"yellow ochre",2},{"chrome yellow",0.4},{"Prussian blue",0.25},{"green earth",1}, medium=0.12}, 566, 618, "filbert 9", {25,60}},
 {pile{{"lead white",0.4},{"yellow ochre",1.5},{"Prussian blue",0.35},{"raw umber",0.8},{"green earth",1.2}, medium=0.12}, 612, 662, "filbert 10", {25,60}},
 {pile{{"yellow ochre",1.2},{"Prussian blue",0.4},{"raw umber",1.2},{"green earth",1},{"bone black",0.1}, medium=0.12}, 656, 740, "filbert 11", {30,70}},
}
LANDP = Lp
for i,l in ipairs(Lp) do
  local m = yband(l[2], l[3], 6) * LAND - RIVER
  work(m, {hand="body", pile=l[1], tool=l[4], clip=LAND, angle=function(x,y) return -0.02 + 0.04*math.sin(x/140) end, angle_jitter=0.06, length=l[5], coverage=1.6, fill=true, load=0.55})
end
print(wait(0))
