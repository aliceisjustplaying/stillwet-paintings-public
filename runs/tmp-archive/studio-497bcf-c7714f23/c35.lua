riv_pts = {{-12,577},{50,573},{130,566},{205,556},{250,545},{240,533},{190,524},{160,515},{185,506},{260,498},{350,490},{420,482},{465,472},{505,462},{545,454},{575,449},{600,446}}
riv_w = {13,12.5,11.5,10,8.5,7.5,6.5,5.5,4.8,4.2,3.6,3.0,2.5,2.1,1.7,1.4,1.2}
river = ribbon(riv_pts, riv_w)
bankD = pile{{"green earth", 2}, {"raw umber", 1.6}, {"Prussian blue", 0.2}, {"yellow ochre", 0.6}, {"lead white", 0.4}, medium=0.08}
water = pile{{"lead white", 6}, {"pale smalt", 1.4}, {"cobalt blue", 0.35}, {"yellow ochre", 0.12}, medium=0.08}
-- the bank shadow: a slightly larger ribbon offset down, laid first
local bank = ribbon((function() local t = {} for i,p in ipairs(riv_pts) do t[i] = {p[1], p[2] + riv_w[i]*0.28} end return t end)(),
                    (function() local t = {} for i,w in ipairs(riv_w) do t[i] = w*1.25 end return t end)())
work(bank, {hand="detail", pile=bankD, angle=0, coverage=2, length={4,12}, fill=true, clip=true, edge="firm"})
work(river, {hand="detail", pile=water, angle=0, coverage=2.2, length={4,14}, fill=true, clip=true, edge="found"})
print(wait(0))
