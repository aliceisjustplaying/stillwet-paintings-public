pastD = pile{{"green earth", 2.5}, {"yellow ochre", 1.0}, {"raw umber", 0.7}, {"lead white", 0.9}, {"Prussian blue", 0.06}, medium=0.08}
pastL = pile{{"lead white", 2}, {"yellow ochre", 1.6}, {"green earth", 1.4}, {"chrome yellow", 0.1}, medium=0.08}
local cm = cows[1]:grow(3) + cows[2]:grow(3) + cows[3]:grow(3)
pasture = (fieldA + fieldC) * below({{-10,478},{1010,478}}) - river2:grow(1.5) - cm - fore_m - figs:grow(2) - fieldB:grow(1) - elder2:grow(1) - hedgerow:grow(1) - rect(495,470,110,70)
for i, w in ipairs(willows) do pasture = pasture - rect(w.x - 5, w.top - 3, 10, w.yb - w.top + 5) end
local function tuft_len(y) local s = (y - 438) * 0.12 return {math.max(1.5, s*0.25), math.max(3, s*0.55)} end
local far = pasture * mask(function(x,y) return y < 530 and 1 or 0 end)
local near = pasture * mask(function(x,y) return y >= 530 and 1 or 0 end)
work(far, {hand="hatch", pile=pastD, tool={kind="round", width=1.0, point=0.9}, angle=-math.pi/2 + 0.1, length={1.5,3.5}, coverage=0.25, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=pasture, clump=0.6})
work(near, {hand="hatch", pile=pastD, tool={kind="round", width=1.2, point=0.9}, angle=-math.pi/2 + 0.1, length={3,7}, coverage=0.3, pressure={0.35,0.6}, ramps={0.1,0.6}, clip=pasture, clump=0.6})
work(near, {hand="hatch", pile=pastL, tool={kind="round", width=1.0, point=0.9}, angle=-math.pi/2 - 0.1, length={2,5}, coverage=0.15, pressure={0.3,0.5}, ramps={0.1,0.6}, clip=pasture, clump=0.6})
print(wait(0))
