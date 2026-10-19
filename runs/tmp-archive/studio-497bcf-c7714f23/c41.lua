near_pts = {{-14,581},{50,576},{130,568},{200,558},{238,547},{233,535},{195,526},{168,518},{170,511},{198,507.5},{230,505}}
near_w   = {11,10,8.5,7,5.5,4.6,3.8,3.2,2.8,2.5,2.4}
river2 = ribbon(near_pts, near_w)
local old = river:grow(4) * mask(function(x,y) return x < 280 and 1 or 0 end) - fore_m
local cover = old - river2
work(cover, {hand="detail", pile=mL2, angle=0, coverage=2.6, length={4,12}, fill=true, clip=true, edge="soft"})
print(wait(0))
