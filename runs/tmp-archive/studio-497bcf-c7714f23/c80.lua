coat = pile{{"bone black", 1}, {"Prussian blue", 0.3}, {"raw umber", 1}, {"lead white", 0.35}, {"green earth", 0.4}, medium=0.08}
dress = pile{{"raw umber", 1.2}, {"smalt", 1}, {"bone black", 0.35}, {"lead white", 0.6}, {"red earth", 0.2}, medium=0.08}
shawl = pile{{"vermilion", 2}, {"red earth", 1}, {"raw umber", 0.3}, {"bone black", 0.08}, medium=0.08}
blackp = pile{{"bone black", 2}, {"raw umber", 1}, {"lead white", 0.1}, medium=0.08}
skin = pile{{"lead white", 2}, {"red earth", 0.5}, {"yellow ochre", 0.6}, {"raw umber", 0.3}, medium=0.08}
hair = pile{{"raw umber", 2}, {"red earth", 0.4}, {"bone black", 0.3}, {"lead white", 0.2}, medium=0.08}
local mx, fy = 697, 612
-- man
man_legs = poly({{mx-4.2,598},{mx-3.8,fy},{mx-0.9,fy},{mx-0.6,598}}) + poly({{mx+0.6,598},{mx+1.0,fy},{mx+3.9,fy},{mx+4.2,598}})
man_coat = poly({{mx-2.2,579.5},{mx-5.2,581},{mx-6.2,584},{mx-6.4,592},{mx-6.8,601},{mx+6.8,601},{mx+6.5,592},{mx+6.3,584},{mx+5.4,581},{mx+2.2,579.5}}, true)
man_head = ellipse(mx, 576.2, 2.7, 3.3)
man_hat = ellipse(mx + 0.3, 572.9, 4.3, 1.7) + ellipse(mx + 0.2, 574.0, 3.2, 1.3)
man = man_legs + man_coat + man_head + man_hat
-- woman
local wx = 681
wo_dress = poly({{wx-3,587},{wx-4.2,595},{wx-6.2,605},{wx-7.0,fy},{wx+7.0,fy},{wx+6.3,605},{wx+4.4,595},{wx+3,587}}, true)
wo_body = poly({{wx-2,580.5},{wx-4.4,582},{wx-4.2,588},{wx+4.2,588},{wx+4.4,582},{wx+2,580.5}}, true)
wo_head = ellipse(wx, 577.6, 2.5, 3.0)
wo_bonnet = ellipse(wx, 576.6, 3.3, 3.2)
wo_shawl = poly({{wx-4.8,581.5},{wx+4.8,581.5},{wx+4.3,585},{wx, 593},{wx-4.3,585}}, true)
wo_arm = ribbon({{wx+3.8,584},{wx+6.5,587},{mx-5.5,588}}, {2.2, 2.0, 1.8})
woman = wo_dress + wo_body + wo_head + wo_bonnet + wo_shawl + wo_arm
figs = man + woman
work(man_legs, {hand="detail", pile=blackp, angle=math.pi/2, coverage=3, length={2,5}, fill=true, clip=true, edge="found"})
work(man_coat + wo_arm, {hand="detail", pile=coat, angle=math.pi/2, coverage=3, length={2,6}, fill=true, clip=true, edge="found"})
work(wo_dress + wo_body, {hand="detail", pile=dress, angle=math.pi/2, coverage=3, length={2,6}, fill=true, clip=true, edge="found"})
work(man_head, {hand="detail", pile=hair, coverage=3, length={1,3}, fill=true, clip=true, edge="found"})
work(man_hat, {hand="detail", pile=blackp, angle=0, coverage=3, length={2,4}, fill=true, clip=true, edge="found"})
work(wo_bonnet, {hand="detail", pile=dress, coverage=3, length={1,3}, fill=true, clip=true, edge="found"})
work(wo_shawl, {hand="detail", pile=shawl, angle=math.pi/2, coverage=3, length={2,5}, fill=true, clip=true, edge="found"})
print(wait(0))
