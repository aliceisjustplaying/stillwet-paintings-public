print(wait(24*60))
-- one unifying pass over the whole pasture, full width, graded by depth, no zone seams
local all = pasture2 + (((rect(488, 476, 124, 40) * mid_m) - fieldB - hedgerow:grow(0.5) - hedge2:grow(0.5) - horses_keep:grow(1) - load_m:grow(2) - rect(528, 470, 22, 30) - willow1_head:grow(1) - rect(572, 492, 11, 26) - rect(496, 505, 16, 30)))
local tl = function(x, y) return -math.pi/2 + 0.08 + 0.1 * math.sin(x / 23 + y / 7) end
local b1 = all * mask(function(x,y) return 1 - smoothstep(505, 525, y) end)
local b2 = all * mask(function(x,y) return smoothstep(505, 525, y) end)
work(b1, {hand="hatch", pile=pastCm, tool={kind="round", width=1.1, point=0.9}, angle=tl, length={1.5,3.5}, coverage=1.3, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=all, clump=0.3, threshold=0.5})
work(b2, {hand="hatch", pile=pastC, tool={kind="round", width=1.3, point=0.9}, angle=tl, length={2.5,5.5}, coverage=1.3, pressure={0.35,0.6}, ramps={0.1,0.6}, clip=all, clump=0.3, threshold=0.5})
-- a scatter of lighter tops (sun on grass heads) and darker tussocks, sparse
work(all, {hand="hatch", pile=pastL, tool={kind="round", width=1.0, point=0.9}, angle=tl, length={2,4}, coverage=0.12, pressure={0.3,0.5}, ramps={0.1,0.6}, clip=all, clump=0.7})
work(all * mask(function(x,y) return y > 515 and 1 or 0 end), {hand="hatch", pile=pastD, tool={kind="round", width=1.2, point=0.9}, angle=tl, length={2,5}, coverage=0.15, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=all, clump=0.8})
print(wait(0))
