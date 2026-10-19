haze = pile{{"lead white", 6}, {"green earth", 2.2}, {"pale smalt", 1.5}, {"yellow ochre", 1.2}, {"raw umber", 0.15}, medium=0.12}
local below440 = below({{-10,440.5},{1010,440.5}})
local hz = mask(function(x,y) if y < 440 then return 0 end return 1 - smoothstep(452, 485, y) end)
work(hz, {hand="scumble", pile=haze, angle=0, coverage=1.6, length={15,40}, pressure={0.3,0.55}, load=0.45, clip=below440, threshold=0.25})
print(wait(0))
