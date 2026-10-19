local holes = ellipse(816,388,9,5) + ellipse(860,386,12,6) + ellipse(906,388,9,5) + ellipse(934,385,5,4)
local gap = (rect(785,366,170,34):roughen(4,10,71) - holes:roughen(2,5,72))
treeP2 = pile{{"raw umber",1},{"bone black",0.4},{"green earth",0.4},{"Prussian blue",0.05},{"lead white",0.3}}
work(gap, {hand="detail", tool="round 4", pile=treeP2, angle=function(x,y) return -1.3 + 0.5*math.sin(x/11) end, coverage=2.5, length={5,12}, fill=true})
work(ellipse(818,306,14,10), {hand="detail", tool="round 4", pile=treeP, angle=-1.2, coverage=3, length={5,10}, fill=true})
local r = brush{kind="rigger", width=1.6, point=1}
r:load(treeP2, 0.7)
for _,t in ipairs({{812,380,398,1.4},{820,381,398,1.0},{856,378,398,1.8},{866,382,398,1.0},{903,381,398,1.4},{910,383,398,0.9},{933,380,398,1.0}}) do
  r:stroke({{t[1],t[2]},{t[1]+rand(-1,1),(t[2]+t[3])/2},{t[1]+rand(-1.5,1.5),t[3]}}, {pressure={0.4*t[4],0.6*t[4]}})
end
