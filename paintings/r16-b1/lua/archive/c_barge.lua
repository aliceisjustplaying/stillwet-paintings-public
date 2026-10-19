local wm = nil
for _, W in ipairs(willows) do local m = W.crown2:grow(W.h*0.5) + W.trunk; wm = wm and (wm + m) or m end
willowZone = wm
local rA = riverA - willowZone
work(rA * rect(0, 462, 1000, 24), {hand="detail", pile=riverWarm, angle=0, coverage=3, fill=true, clip=true, length={6,20}})
work(rA * rect(0, 486, 1000, 20), {hand="detail", pile=riverCool, angle=0, coverage=3, fill=true, clip=true, length={6,20}})
work((ribbon(farEdgeA, 1.5)):roughen(0.4, 3, 121) - willowZone, {hand="detail", pile=reedP, angle=0, coverage=2, fill=true, clip=true, length={4,12}, pressure={0.2,0.5}})
work((ribbon(nearEdgeA, 1.6)):roughen(0.5, 3, 122) - willowZone, {hand="detail", pile=bankShadow, angle=0, coverage=2, fill=true, clip=true, length={4,12}, pressure={0.2,0.5}})
-- barge
hullP = pile{{"raw umber", 2}, {"bone black", 1.2}, {"red earth", 0.3}, medium=0.05}
sailP = pile{{"lead white", 2}, {"raw umber", 1.2}, {"red earth", 0.3}, {"yellow ochre", 0.6}, medium=0.05}
local bx, by = 905, 486
hullM = poly({{bx-24, by-3.5}, {bx+22, by-4}, {bx+25, by-6}, {bx+20, by+0.8}, {bx-20, by+0.8}, {bx-26, by-5.5}}, true)
sailM = poly({{bx-2, by-8}, {bx-4, by-46}, {bx+19, by-40}, {bx+17, by-9}}, false)
local sail2 = poly({{bx-4, by-8}, {bx-3, by-36}, {bx-18, by-10}}, false)
local mastM = ribbon({{bx-3, by-3}, {bx-4, by-58}}, {1.4, 0.6})
work(sailM + sail2, {hand="detail", pile=sailP, coverage=3, fill=true, clip=true, angle=-1.57, length={3,10}})
work(hullM, {hand="detail", pile=hullP, coverage=3, fill=true, clip=true, angle=0, length={3,10}})
work(mastM, {hand="detail", pile=hullP, coverage=3, fill=true, clip=true, angle=-1.57, length={3,10}})
-- reflection
local refl = poly({{bx-20, by+1}, {bx+20, by+1}, {bx+14, by+7}, {bx-14, by+7}}, true)
work(refl, {hand="detail", pile=reflP, coverage=1.5, clip=true, angle=-1.57, length={2,5}, pressure={0.2,0.4}})
