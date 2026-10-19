FGM = below(function(x) return fg(x) end)
local cuts = {0, 12, 35, 70, 400}
local piles = {
  pile{{"green earth", 2}, {"yellow ochre", 1.6}, {"lead white", 0.6}, {"chrome yellow", 0.12}, {"raw umber", 0.1}, medium=0.15},
  pile{{"green earth", 2}, {"yellow ochre", 1.2}, {"lead white", 0.3}, {"raw umber", 0.3}, {"Prussian blue", 0.04}, medium=0.15},
  pile{{"green earth", 2}, {"yellow ochre", 0.9}, {"raw umber", 0.6}, {"Prussian blue", 0.07}, {"bone black", 0.05}, medium=0.15},
  pile{{"green earth", 1.6}, {"raw umber", 1}, {"yellow ochre", 0.6}, {"Prussian blue", 0.1}, {"bone black", 0.12}, medium=0.15},
}
for i=1,4 do
  local a, b = cuts[i], cuts[i+1]
  local m = mask(function(x, y) local d = y - fg(x); return (d >= a and d < b) and 1 or 0 end)
  work(m, {hand="body", tool="filbert 8", pile=piles[i], angle=function(x,y) return 0.08*math.sin(x/70) end, angle_jitter=0.15, length={25,70}, coverage=2.2, fill=true, edge=(i==1) and "firm" or "soft", seed=2200+i})
end
blend(FGM, {angle=0.05, length={50,150}, coverage=1.2, seed=2205})
