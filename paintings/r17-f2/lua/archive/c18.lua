local band = rect(700, 596, 265, 20) * mask(function(x,y) local d = crest_depth(x,y) return (d > -4 and d < 12) and 1 or 0 end) - figs:grow(1.2) - elder2:grow(1)
local up = function(x, y) return -math.pi/2 + 0.25 * math.sin(x / 11 + y / 4) end
work(band, {hand="hatch", pile=grD, tool={kind="round", width=1.1, point=0.9}, angle=up, length={2.5,5}, coverage=0.9, pressure={0.4,0.6}, ramps={0.1,0.6}, clip=band:grow(1), clump=0.5})
work(band, {hand="hatch", pile=grL, tool={kind="round", width=1.0, point=0.9}, angle=up, length={2,4}, coverage=0.6, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=band:grow(1), clump=0.6})
print(wait(0))
