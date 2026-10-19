wv = {
 {pile{{"lead white",5},{"chrome yellow",0.45},{"vermilion",0.1},{"raw umber",0.15}, medium=0.1}, 436, 482, 2.2, {5,14}},
 {pile{{"lead white",5},{"chrome yellow",0.25},{"yellow ochre",0.15},{"vermilion",0.06},{"raw umber",0.2},{"cobalt blue",0.05}, medium=0.1}, 474, 532, 3, {8,20}},
 {pile{{"lead white",4},{"yellow ochre",0.15},{"vermilion",0.05},{"cobalt blue",0.2},{"raw umber",0.25}, medium=0.1}, 524, 592, 4, {12,28}},
 {pile{{"lead white",3.5},{"cobalt blue",0.35},{"smalt",0.25},{"raw umber",0.3}, medium=0.1}, 584, 652, 5, {15,35}},
 {pile{{"lead white",3},{"cobalt blue",0.45},{"smalt",0.4},{"raw umber",0.4},{"red earth",0.05}, medium=0.1}, 644, 725, 6, {18,45}},
}
for i,b in ipairs(wv) do
  local m = creek * below(function(x) return b[2] + 4*math.sin(x/19+i) end) * above(function(x) return b[3] + 4*math.sin(x/23+2*i) end)
  work(m, {hand="body", pile=b[1], angle=function(x,y) return 0.03*math.sin(x/30+y/7) end, coverage=2.6, length=b[5], tool={kind="flat", width=b[4], stiffness=0.5}, fill=true, clip=creek, dips={3,0.8,0.3}, pressure={0.5,0.8}})
end
