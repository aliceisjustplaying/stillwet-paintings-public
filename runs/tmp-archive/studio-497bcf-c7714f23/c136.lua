grShade = pile{{"green earth", 2.4}, {"raw umber", 1.2}, {"yellow ochre", 0.9}, {"Prussian blue", 0.15}, {"lead white", 0.25}, medium=0.1}
local up = function(x,y) return -math.pi/2 + 0.3*math.sin(x/17 + y/11) end
local foot = rect(830, 650, 175, 66)
work(foot, {hand="hatch", pile=grDD, tool={kind="rigger", width=1.8, point=1}, angle=up, length={16,34}, coverage=0.7, pressure={0.5,0.8}, ramps={0.05,0.75}, clump=0.5})
work(foot, {hand="glaze", pile=pile{{"green earth", 2}, {"raw umber", 1.2}, {"Prussian blue", 0.15}, medium=0.7}, angle=-math.pi/2, coverage=0.8, load=0.35})
print(wait(0))
