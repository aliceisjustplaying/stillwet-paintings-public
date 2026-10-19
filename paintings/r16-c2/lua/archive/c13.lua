local crowns = {{775,360,30,32},{835,335,36,40},{880,345,30,32},{922,358,28,26},{968,372,26,22},{995,380,18,16},{722,384,20,16},{748,375,20,20},{805,352,24,30},{857,340,22,30}}
local m = rect(596,394,410,12)
for _,c in ipairs(crowns) do m = m + ellipse(c[1],c[2],c[3],c[4]) end
m = m + mask(function(x,y) return (x>596 and y > 402 - math.min(10,(x-596)/8) and y < 406) and 1 or 0 end)
trees = m:roughen(4, 10, 31):roughen(1.5, 4, 32)
treeP = pile{{"raw umber",1},{"bone black",0.5},{"Prussian blue",0.08},{"green earth",0.3},{"lead white",0.35}}
work(trees, {hand="body", tool="filbert 6", pile=treeP, angle=function(x,y) return -1.2 + 0.6*math.sin(x/13+y/17) end, coverage=3, length={8,18}, fill=true, edge={found=0.3, soft=0.6, lost=0.1, period=20}})
