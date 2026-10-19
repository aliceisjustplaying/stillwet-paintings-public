local g = pile{{"raw umber",0.7},{"green earth",0.6},{"pale smalt",0.4},{"lead white",0.25}, medium=0.6}
local m = PATH:grow(1) * mask(function(x,y) return smoothstep(590, 690, y) end)
work(m, {hand="detail", pile=g, tool={kind="filbert", width=5}, angle=-1.0, length={10,25}, coverage=1.2, clip=true, load=0.3, threshold=0.2})
blend(PATH:grow(1) * mask(function(x,y) return y > 580 and 1 or 0 end), {angle=-1.0, coverage=1.3, tool={kind="badger", width=10}, pressure={0.25,0.4}})
print(wait(0))
