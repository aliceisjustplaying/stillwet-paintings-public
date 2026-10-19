LAND = below(function(x) return far(x) end)
local bnds = {function(x) return far(x) end, function(x) return 403 + 2*math.sin(x/80) end, function(x) return 424 + 3*math.sin(x/110+1) end, function(x) return 466 + 5*math.sin(x/140+2) end, function(x) return fg(x) end, function(x) return 700 end}
ZONES = {}
for i=1,5 do
  local a, b = bnds[i], bnds[i+1]
  ZONES[i] = mask(function(x, y) local ya, yb = a(x), b(x); return (y >= ya and y < yb) and 1 or 0 end)
end
ZP = {
  pile{{"lead white", 3}, {"pale smalt", 1.6}, {"green earth", 1}, {"yellow ochre", 0.25}, {"red earth", 0.05}, medium=0.15},
  pile{{"lead white", 2}, {"green earth", 1.6}, {"yellow ochre", 0.7}, {"pale smalt", 0.7}, medium=0.15},
  pile{{"yellow ochre", 1.6}, {"green earth", 1.6}, {"lead white", 1.4}, {"chrome yellow", 0.2}, {"Prussian blue", 0.05}, medium=0.15},
  pile{{"yellow ochre", 1.4}, {"green earth", 2}, {"lead white", 0.8}, {"Prussian blue", 0.1}, {"raw umber", 0.15}, medium=0.15},
  pile{{"raw umber", 1}, {"green earth", 2}, {"yellow ochre", 1}, {"Prussian blue", 0.12}, {"bone black", 0.08}, medium=0.15},
}
local tools = {"flat 5", "flat 7", "flat 9", "filbert 10", "filbert 12"}
for i=1,5 do
  work(ZONES[i], {hand="body", tool=tools[i], pile=ZP[i], angle=function(x,y) return 0.03*math.sin(x/50) end, angle_jitter=0.1, length={25+i*10, 60+i*20}, coverage=2.3, fill=true, pressure={0.5,0.8}, seed=600+i})
end
