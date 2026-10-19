fore_m = below(rise_top)
fC = pile{{"yellow ochre", 2.5}, {"green earth", 2}, {"raw umber", 0.7}, {"Prussian blue", 0.12}, {"lead white", 1.0}, {"chrome yellow", 0.15}, medium=0.08}
fM = pile{{"green earth", 2.5}, {"yellow ochre", 1.8}, {"raw umber", 1.2}, {"Prussian blue", 0.2}, {"lead white", 0.5}, medium=0.08}
fD = pile{{"green earth", 2}, {"raw umber", 2}, {"yellow ochre", 1}, {"Prussian blue", 0.3}, {"bone black", 0.15}, {"lead white", 0.2}, medium=0.08}
local function crest_d(x, y) -- depth below the crest
  local t = 0
  for i = 1, #rise_top - 1 do local a, b = rise_top[i], rise_top[i+1]
    if x >= a[1] and x <= b[1] then t = a[2] + (b[2]-a[2]) * (x - a[1]) / (b[2]-a[1]) break end end
  return y - t
end
crest_depth = crest_d
local zC = mask(function(x,y) local d = crest_d(x,y) return d < 0 and 0 or (1 - smoothstep(18, 40, d)) end)
local zM = mask(function(x,y) local d = crest_d(x,y) return d < 0 and 0 or smoothstep(18, 40, d) * (1 - smoothstep(60, 90, d)) end)
local zD = mask(function(x,y) local d = crest_d(x,y) return d < 0 and 0 or smoothstep(60, 90, d) end)
work(zC, {hand="body", pile=fC, angle=0.03, coverage=2.0, length={20,50}, pressure={0.5,0.8}, fill=true, clip=fore_m, edge="found", threshold=0.3})
work(zM, {hand="body", pile=fM, angle=0.05, coverage=2.0, length={25,60}, pressure={0.5,0.8}, fill=true, clip=fore_m, threshold=0.3})
work(zD, {hand="body", pile=fD, angle=0.08, coverage=2.0, length={25,70}, pressure={0.5,0.85}, fill=true, clip=fore_m, threshold=0.3})
blend(fore_m, {angle=0.02, coverage=1.3, clip=true, tool={kind="badger", width=26}, pressure={0.3,0.5}})
print(wait(0))
