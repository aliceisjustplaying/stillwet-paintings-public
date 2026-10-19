reedP = pile{{"raw umber", 2}, {"green earth", 2}, {"smalt", 0.5}, {"lead white", 0.6}, {"bone black", 0.3}, medium=0.1}
reflP = pile{{"lead white", 3}, {"smalt", 1.2}, {"vermilion", 0.2}, {"raw umber", 0.6}, {"green earth", 0.3}, medium=0.3}
bankShadow = pile{{"raw umber", 2}, {"green earth", 1.5}, {"bone black", 0.4}, {"yellow ochre", 0.5}, medium=0.1}
-- far bank edges: thin dark lines on the top edges
farEdgeB = {{362,459.5},{450,457.5},{560,457.5},{640,460.5},{688,465.5}}
farEdgeA = {{700,474},{800,472.5},{900,471.5},{1000,472.5}}
farEdgeC = {{112,453.2},{180,452.3},{260,453.3}}
local fe = ribbon(farEdgeB, 1.6) + ribbon(farEdgeA, 2.2) + ribbon(farEdgeC, 1.1)
work(fe:roughen(0.5, 3, 71), {hand="detail", pile=reedP, angle=0, coverage=3, fill=true, clip=true, length={4,12}})
-- reflections of the far tree lines, just under the far bank
local refl = (riverA * rect(0, 470, 1000, 8) + riverB * rect(0, 456, 1000, 4)):roughen(0.8, 4, 72)
work(refl, {hand="detail", pile=reflP, angle=-1.57, coverage=1.2, clip=true, length={2,5}, pressure={0.2,0.4}})
-- near bank of reach A: dark cut edge
nearEdgeA = {{688,482},{740,486.5},{840,492.5},{940,497.5},{1000,499.5}}
nearEdgeB = {{430,461.5},{520,462.8},{600,465},{660,468.5}}
local ne = ribbon(nearEdgeA, 2.2) + ribbon(nearEdgeB, 1.4)
work(ne:roughen(0.6, 3, 73), {hand="detail", pile=bankShadow, angle=0, coverage=3, fill=true, clip=true, length={5,14}})
