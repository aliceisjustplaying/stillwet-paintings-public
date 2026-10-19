eDD = pile{{"green earth", 2}, {"raw umber", 1.8}, {"Prussian blue", 0.4}, {"bone black", 0.25}, {"yellow ochre", 0.3}, medium=0.08}
local o = outline{{1004,716},{836,716,"c"},{840,700},{846,684},{843,668},{850,652},{847,636},{856,618},{862,600},{870,586},{1004,580,"c"}, char="soft", seed=181, lobe=8, amount=1.2, closed=true}
lowE = (o:mask() * elder2:grow(6)) * rect(0, 585, 1000, 140)
lowE = lowE * mask(function(x,y) return 1 end)
stipple(lowE, {pile=eDD, width=3.2, coverage=4.5, pressure={0.5,0.8}, clip=lowE, cluster=0.25})
-- blend the join with the upper bush by stippling eD across the seam
local seam = elder2 * rect(840, 575, 170, 30)
stipple(seam, {pile=eD, width=2.8, coverage=2.0, pressure={0.45,0.75}, clip=elder2, cluster=0.4})
print(wait(0))
