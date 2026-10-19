-- the stork's feet sunk in the grass; a faint shadow to the right
local gA = pile{{"lead white",1.2},{"green earth",1.5},{"yellow ochre",1.5},{"chrome yellow",0.2},{"pale smalt",0.2}, medium=0.1}
local gB = pile{{"green earth",1.5},{"yellow ochre",0.9},{"raw umber",0.4},{"lead white",0.6},{"Prussian blue",0.1}, medium=0.1}
local sh = ellipse(194, 521.5, 8, 1.3) - ellipse(186,521.5,3,2)
work(sh, {hand="hatch", pile=gB, tool={kind="round", width=0.9, point=0.8}, angle=-math.pi/2, angle_jitter=0.3, length={2,3.5}, coverage=1.6, pressure={0.35,0.6}, ramps={0.1,0.6}, seed=881})
local feet = ellipse(188, 520, 9, 2.8)
work(feet, {hand="hatch", pile=gA, tool={kind="round", width=0.9, point=0.8}, angle=-math.pi/2, angle_jitter=0.35, length={2,4.5}, coverage=1.2, pressure={0.35,0.7}, ramps={0.1,0.6}, seed=882})
print(wait(0))
