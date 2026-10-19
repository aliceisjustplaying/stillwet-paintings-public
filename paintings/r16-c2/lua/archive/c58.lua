local holes2 = ellipse(818,390,6,5) + ellipse(862,389,8,5) + ellipse(907,391,6,3.5)
local droop = (rect(780,362,175,40):roughen(4,9,171) - holes2:roughen(1.5,4,172))
work(droop, {hand="detail", tool="round 3.5", pile=treeP2, angle=function(x,y) return -1.4 + 0.5*math.sin(x/9) end, coverage=3, length={4,10}, fill=true})
work(ellipse(818,306,16,12), {hand="detail", tool="round 3", pile=treeP, angle=-1.0, coverage=3, length={4,9}, fill=true})
local r = brush{kind="rigger", width=1.5, point=1}
r:load(treeP2, 0.7)
for _,t in ipairs({{816,386},{861,384},{906,388},{866,386}}) do r:stroke({{t[1],t[2]},{t[1]+rand(-0.8,0.8),t[2]+6},{t[1]+rand(-1,1),399}}, {pressure={0.5,0.7}}) end
litEdge = mask(function(x,y) if x < 690 or y > 395 then return 0 end; return trees:at(x,y) * (1 - trees:at(x-5,y-6)) end)
treeLit = pile{{"raw umber",1},{"green earth",0.6},{"yellow ochre",0.35},{"lead white",0.5},{"bone black",0.1}}
stipple(litEdge, {pile=treeLit, width=2.4, coverage=0.9, pressure={0.3,0.6}, cluster=0.5, feather=0.4})
