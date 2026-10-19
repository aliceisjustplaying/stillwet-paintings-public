sky_m = above({{0,446},{250,442},{500,444},{750,443},{1000,446}})
sky1 = pile{{"lead white", 2}, {"cobalt blue", 1.1}, {"smalt", 1.0}, medium=0.08}
sky2 = pile{{"lead white", 3}, {"cobalt blue", 0.9}, {"smalt", 0.7}, medium=0.08}
sky3 = pile{{"lead white", 5}, {"cobalt blue", 0.7}, {"smalt", 0.5}, medium=0.08}
sky4 = pile{{"lead white", 8}, {"cobalt blue", 0.4}, {"pale smalt", 0.5}, {"yellow ochre", 0.1}, medium=0.08}
sky5 = pile{{"lead white", 10}, {"yellow ochre", 0.35}, {"vermilion", 0.06}, {"pale smalt", 0.2}, medium=0.08}
sky6 = pile{{"lead white", 10}, {"yellow ochre", 0.45}, {"chrome yellow", 0.15}, {"vermilion", 0.05}, medium=0.08}
local bands = {{sky1,-10,120},{sky2,95,210},{sky3,185,295},{sky4,270,355},{sky5,330,405},{sky6,385,460}}
for i, b in ipairs(bands) do
  local m = rect(-10, b[2], 1020, b[3]-b[2]):soften(12) * sky_m
  work(m, {hand="broad", pile=b[1], angle=function(x,y) return 0.04*math.sin(x/170+i) end, coverage=2.2, length={90,200}, pressure={0.5,0.8}, fill=true, edge="soft"})
end
print(wait(0))
