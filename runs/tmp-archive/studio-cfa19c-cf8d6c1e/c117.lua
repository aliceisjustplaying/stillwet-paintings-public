wait(60*24*4)
local keep = oakSil:shrink(2.5)
skyT = pile{{"lead white",4},{"cobalt blue",1.4},{"smalt",1.1},{"pale smalt",0.5},{"raw umber",0.1},{"yellow ochre",0.05}, medium=0.1}
for i,e in ipairs({{165,152,19,7},{245,108,17,7},{200,125,11,6},{320,120,11,6}}) do
  work(ellipse(e[1],e[2],e[3],e[4]) - keep, {hand="body", pile=skyT, tool={kind="filbert", width=4}, angle=0.05, coverage=2.5, fill=true, edge="soft", pressure={0.45,0.7}, seed=1190+i})
end
