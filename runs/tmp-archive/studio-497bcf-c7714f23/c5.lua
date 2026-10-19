cloudw = pile{{"lead white", 10}, {"yellow ochre", 0.15}, {"vermilion", 0.04}, medium=0.1}
cloudg = pile{{"lead white", 6}, {"pale smalt", 1.2}, {"red earth", 0.25}, {"raw umber", 0.15}, medium=0.1}
local streaks = {{250,212,210,11,1},{660,158,270,10,2},{830,262,170,9,3},{140,118,150,8,4},{480,285,160,7,5},{900,110,120,7,6}}
for _, s in ipairs(streaks) do
  local m = ellipse(s[1], s[2], s[3], s[4]):roughen(6, 60, s[5]):soften(4)
  work(m, {hand="scumble", pile=cloudw, angle=0.0, coverage=1.3, length={20,50}, pressure={0.3,0.55}, load=0.5, edge="lost"})
end
-- low grey band of cloud over the horizon at right and centre
low_cloud = poly({{430,392},{470,380},{520,376},{560,370},{610,372},{650,364},{700,368},{760,360},{820,366},{880,358},{940,364},{1010,362},{1010,400},{900,404},{760,400},{600,402},{470,398}}, true):roughen(5, 40, 7)
work(low_cloud, {hand="scumble", pile=cloudg, angle=0, coverage=1.2, length={25,60}, pressure={0.3,0.5}, load=0.45, edge="soft"})
print(wait(0))
