local keep = oakSil:shrink(2.5)
for i,e in ipairs({{165,152,19,7},{245,108,17,7},{200,125,11,6},{320,120,11,6}}) do
  blend(ellipse(e[1],e[2],e[3]+4,e[4]+4) - keep, {tool={kind="badger", width=6}, angle=0.05, coverage=1.5, pressure={0.25,0.4}, seed=1200+i})
end
local P2 = pile{{"lead white",5},{"cobalt blue",1.2},{"smalt",0.9},{"pale smalt",0.6},{"raw umber",0.1},{"yellow ochre",0.08}, medium=0.1}
local P3 = pile{{"lead white",6},{"pale smalt",1.0},{"cobalt blue",0.7},{"smalt",0.4},{"yellow ochre",0.15},{"raw umber",0.08}, medium=0.1}
local P4 = pile{{"lead white",8},{"pale smalt",0.6},{"cobalt blue",0.2},{"yellow ochre",0.35},{"raw umber",0.05}, medium=0.1}
local P5 = pile{{"lead white",8},{"yellow ochre",0.5},{"vermilion",0.05},{"pale smalt",0.25},{"raw umber",0.04}, medium=0.1}
local rest = {{120,203,13,7,P2},{378,185,15,9,P2},{112,231,12,7,P3},{420,248,16,11,P3},{82,282,14,7,P4},{443,300,19,8,P4},{433,316,12,8,P4},{74,402,20,8,P5}}
for i,e in ipairs(rest) do
  local m = ellipse(e[1],e[2],e[3],e[4]) - keep
  work(m, {hand="body", pile=e[5], tool={kind="filbert", width=4}, angle=0.05, coverage=2.5, fill=true, edge="soft", pressure={0.45,0.7}, seed=1210+i})
  blend(ellipse(e[1],e[2],e[3]+4,e[4]+4) - keep, {tool={kind="badger", width=6}, angle=0.05, coverage=1.5, pressure={0.25,0.4}, seed=1230+i})
end
