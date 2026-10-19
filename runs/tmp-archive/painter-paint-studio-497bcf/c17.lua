local band = mask(function(x,y) local d = crest_depth(x,y) return (d > -1.5 and d < 12) and 1 or 0 end) * rect(560, 590, 300, 30) - figs:grow(1.2) - path_m:shrink(1) - elder2:grow(1)
local up = function(x, y) return -math.pi/2 + 0.25 * math.sin(x / 11 + y / 4) end
work(band, {hand="hatch", pile=fM, tool={kind="round", width=1.1, point=0.9}, angle=up, length={2,4.5}, coverage=1.3, pressure={0.4,0.65}, ramps={0.1,0.6}, clip=band:grow(1.5) - figs:grow(1), clump=0.4})
work(band, {hand="hatch", pile=grD, tool={kind="round", width=1.0, point=0.9}, angle=up, length={2,4}, coverage=0.4, pressure={0.35,0.55}, ramps={0.1,0.6}, clip=band:grow(1.5) - figs:grow(1), clump=0.7})
work(band, {hand="hatch", pile=grL, tool={kind="round", width=0.9, point=0.9}, angle=up, length={1.5,3.5}, coverage=0.3, pressure={0.3,0.5}, ramps={0.1,0.6}, clip=band:grow(1.5) - figs:grow(1), clump=0.7})
print(wait(0))
