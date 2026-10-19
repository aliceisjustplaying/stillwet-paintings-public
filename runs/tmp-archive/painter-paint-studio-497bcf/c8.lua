pastCm = pile{{"green earth", 2.6}, {"lead white", 2.1}, {"pale smalt", 0.8}, {"yellow ochre", 0.75}, {"raw umber", 0.4}, medium=0.08}
local nz = noise{seed=731, period=60, octaves=3}
local split = function(x, y) return 522 + 14 * nz(x, y) end
local far = pasture2 * mask(function(x,y) return y < split(x,y) and 1 or 0 end)
local near = pasture2 * mask(function(x,y) return y >= split(x,y) and 1 or 0 end)
local farL = far * rect(0, 470, 300, 100)
local farR = far - rect(0, 470, 300, 100)
local nearR = near - rect(0, 470, 300, 160)
-- darken the too-white far strokes on the left; lay the new green over the rest
work(farL, {hand="hatch", pile=pastC, tool={kind="round", width=1.2, point=0.9}, angle=-math.pi/2 + 0.08, length={1.5,3.5}, coverage=1.0, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=pasture2, clump=0.4})
work(farR, {hand="hatch", pile=pastCm, tool={kind="round", width=1.2, point=0.9}, angle=-math.pi/2 + 0.08, length={1.5,3.5}, coverage=0.9, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=pasture2, clump=0.4})
work(nearR, {hand="hatch", pile=pastC, tool={kind="round", width=1.4, point=0.9}, angle=-math.pi/2 + 0.08, length={3,6}, coverage=0.9, pressure={0.35,0.6}, ramps={0.1,0.6}, clip=pasture2, clump=0.4})
print(wait(0))
