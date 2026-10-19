wait(60*24*5)
local keep = oakSil + oakM + (cloud2M + townM4):grow(0.5)
local zone = rect(-10,-10,1020,355) - keep
local bands = {
  {-10, 80,  pile{{"lead white",5},{"cobalt blue",1.6},{"smalt",1.1},{"pale smalt",0.3}, medium=0.12}},
  {60, 150,  pile{{"lead white",6.5},{"cobalt blue",1.2},{"smalt",0.8},{"pale smalt",0.7}, medium=0.12}},
  {130, 220, pile{{"lead white",8},{"pale smalt",1.7},{"cobalt blue",0.5},{"smalt",0.1}, medium=0.12}},
  {200, 290, pile{{"lead white",10},{"pale smalt",1.2},{"cobalt blue",0.12},{"yellow ochre",0.1}, medium=0.12}},
  {270, 350, pile{{"lead white",10},{"pale smalt",0.6},{"yellow ochre",0.3},{"vermilion",0.03}, medium=0.12}},
}
for i,b in ipairs(bands) do
  local m = zone * rect(-10, b[1], 1020, b[2]-b[1])
  work(m, {hand="broad", pile=b[3], tool="filbert 16", angle=0.0, coverage=2.4, fill=true, edge="firm", pressure={0.45,0.7}, seed=1410+i})
end
local bz = (rect(-10,-10,1020,362) - keep) 
blend(bz, {tool={kind="badger", width=40}, angle=0.0, coverage=2.0, pressure={0.3,0.5}, seed=1421})
blend(bz, {tool={kind="badger", width=30}, angle=0.02, coverage=1.2, pressure={0.2,0.4}, seed=1422})
