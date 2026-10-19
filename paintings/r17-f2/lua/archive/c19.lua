-- (crest_depth has a slope bug; use the crest line directly)
local band = rect(690, 599, 275, 16) * below({{600,601},{700,602.5},{780,601},{900,598},{1000,596}}) - figs:grow(1.2) - elder2:grow(1) - fieldB
local up = function(x, y) return -math.pi/2 + 0.25 * math.sin(x / 11 + y / 4) end
work(band, {hand="hatch", pile=grD, tool={kind="round", width=1.1, point=0.9}, angle=up, length={2.5,5}, coverage=0.9, pressure={0.4,0.6}, ramps={0.1,0.6}, clip=band:grow(1), clump=0.5})
work(band, {hand="hatch", pile=grL, tool={kind="round", width=1.0, point=0.9}, angle=up, length={2,4}, coverage=0.6, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=band:grow(1), clump=0.6})
work(band, {hand="hatch", pile=fM, tool={kind="round", width=1.0, point=0.9}, angle=up, length={2,4}, coverage=0.5, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=band:grow(1), clump=0.6})
print(wait(0))
