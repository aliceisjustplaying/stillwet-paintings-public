local cuts = {0, 405, 424, 446, 480}
local ps = {
  pile{{"lead white", 1.6}, {"pale smalt", 1.2}, {"green earth", 1.2}, {"yellow ochre", 0.45}, medium=0.2},
  pile{{"lead white", 1.2}, {"green earth", 1.4}, {"yellow ochre", 0.8}, {"pale smalt", 0.55}, medium=0.2},
  pile{{"green earth", 1.6}, {"yellow ochre", 1.2}, {"lead white", 0.9}, {"chrome yellow", 0.12}, {"pale smalt", 0.15}, medium=0.2},
  pile{{"green earth", 2}, {"yellow ochre", 1.3}, {"chrome yellow", 0.18}, {"lead white", 0.9}, {"Prussian blue", 0.03}, medium=0.2},
}
for i=1,4 do
  local a, b = cuts[i], cuts[i+1]
  local m = mask(function(x, y)
    local top = (i == 1) and far(x) + 1.2 or a + 1.5*math.sin(x/37 + i)
    local bot = (i == 4) and 470 + 1.5*math.sin(x/50) or b + 1.5*math.sin(x/37 + i + 1)
    return (y >= top and y < bot) and 1 or 0 end) - TREES2 - TOWN
  work(m, {hand="body", tool={kind="flat", width=3 + i*1.2}, pile=ps[i], angle=0, angle_jitter=0.03, length={40,120}, coverage=1.5, fill=true, pressure={0.4,0.6}, load=0.7, edge="soft", clip=(i==1), seed=3600+i})
end
local all = mask(function(x, y) return (y > far(x) + 1.2 and y < 471) and 1 or 0 end) - TREES2 - TOWN
blend(all, {angle=0, ruler=true, length={100,300}, coverage=1.2, seed=3605})
