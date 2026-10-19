-- path darkened toward the foreground, cool shadow
local pS = pile{{"lead white",1.2},{"raw umber",0.9},{"yellow ochre",0.7},{"pale smalt",0.5},{"green earth",0.5}, medium=0.1}
local pM = pile{{"lead white",2.2},{"raw umber",0.7},{"yellow ochre",0.9},{"pale smalt",0.3},{"green earth",0.2}, medium=0.1}
local low = PATH * mask(function(x,y) return smoothstep(600, 660, y) end)
local mid = PATH * mask(function(x,y) return smoothstep(565, 600, y) * (1 - smoothstep(620, 660, y)) end)
work(mid, {hand="hatch", pile=pM, tool={kind="round", width=1.8, point=0.5}, angle=0.1, angle_jitter=0.3, length={3,9}, coverage=1.4, clip=true, threshold=0.4, load=0.6})
work(low, {hand="hatch", pile=pS, tool={kind="round", width=2.2, point=0.5}, angle=0.1, angle_jitter=0.3, length={4,12}, coverage=1.8, clip=true, threshold=0.4, load=0.6})
-- faint continuation of the path beyond the figures toward the river
local cont = ribbon({{484,540},{488,528},{496,518},{508,508},{522,500},{540,493}}, {3.2,2.6,2.1,1.6,1.2,0.8}) - FIGS:grow(0.5)
local pF = pile{{"lead white",3},{"yellow ochre",0.9},{"raw umber",0.35},{"green earth",0.4},{"pale smalt",0.2}, medium=0.1}
work(cont, {hand="detail", pile=pF, tool={kind="round", width=1.0, point=0.5}, angle=-0.5, length={3,8}, coverage=1.6, clip=true, fill=true})
print(wait(0))
