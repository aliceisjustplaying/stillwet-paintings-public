local mx, fy = 596, 603
local hem = poly({{mx-11.6, 570}, {mx-11.8, 580.5}, {mx, 581.5}, {mx+11.8, 580.5}, {mx+11.6, 570}}, false)
work(hem, {hand="detail", pile=coatP, coverage=4.5, fill=true, clip=true, angle=0, length={2,5}})
local legs = poly({{mx-5.8, 581}, {mx-5.3, fy-1}, {mx-7, fy+1}, {mx-2, fy+1}, {mx-1.6, 581}}, false) + poly({{mx+1.2, 581}, {mx+2, fy+1}, {mx+6.5, fy+1}, {mx+5, fy-1}, {mx+5.4, 581}}, false)
work(legs, {hand="detail", pile=trouserP, coverage=3, fill=true, clip=true, angle=-1.57, length={2,5}})
local boots = rect(mx-7, fy-4, 5.5, 5) + rect(mx+1.5, fy-4, 5.5, 5)
work(boots * (legs:grow(1)), {hand="detail", pile=coatP, coverage=3, fill=true, clip=true, angle=0, length={1,3}})
