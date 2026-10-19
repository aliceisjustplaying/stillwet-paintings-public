local heads = willow1_head
for i = 2, 9 do heads = heads + new_heads[i].m end
pasture2 = pasture - heads:grow(1) - rect(112, 530, 18, 24) - horses_keep
pastC = pile{{"green earth", 2.5}, {"lead white", 2.0}, {"pale smalt", 0.8}, {"yellow ochre", 0.7}, {"raw umber", 0.45}, medium=0.08}
pastCf = pile{{"lead white", 2.8}, {"green earth", 2.0}, {"pale smalt", 1.0}, {"yellow ochre", 0.5}, {"raw umber", 0.25}, medium=0.08}
local left = pasture2 * rect(0, 470, 300, 140)
local near = left * mask(function(x,y) return y >= 525 and 1 or 0 end)
local far = left * mask(function(x,y) return y < 525 and 1 or 0 end)
work(far, {hand="hatch", pile=pastCf, tool={kind="round", width=1.2, point=0.9}, angle=-math.pi/2 + 0.08, length={1.5,3.5}, coverage=0.9, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=pasture2, clump=0.4})
work(near, {hand="hatch", pile=pastC, tool={kind="round", width=1.4, point=0.9}, angle=-math.pi/2 + 0.08, length={3,6}, coverage=0.9, pressure={0.35,0.6}, ramps={0.1,0.6}, clip=pasture2, clump=0.4})
print(wait(0))
