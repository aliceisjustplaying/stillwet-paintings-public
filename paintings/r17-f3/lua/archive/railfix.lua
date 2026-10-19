local wood = pile{{"raw umber",1},{"lead white",1.1},{"bone black",0.2},{"pale smalt",0.3},{"yellow ochre",0.3}, medium=0.08}
local m = (RAILS + FENCE) * (HORSES2:grow(2) + ellipse(776, 503.5, 24, 4) + ellipse(834, 502, 21, 4))
work(m, {hand="detail", pile=wood, tool={kind="round", width=0.9, point=0.4}, angle=-0.3, length={3,8}, coverage=3.5, clip=true, fill=true, edge="found", load=0.9})
-- break the shadow platforms with grass blades
local shm = (ellipse(776, 503.5, 22, 2.5) + ellipse(834, 502, 19, 2.5)) - HORSES2 - RAILS - FENCE
local gA = pile{{"lead white",1.2},{"green earth",1.7},{"yellow ochre",1.2},{"pale smalt",0.3},{"Prussian blue",0.05}, medium=0.1}
local gB = pile{{"green earth",1.5},{"yellow ochre",0.9},{"raw umber",0.4},{"lead white",0.6},{"Prussian blue",0.1}, medium=0.1}
work(shm, {hand="hatch", pile=gB, tool={kind="round", width=1.0, point=0.8}, angle=-math.pi/2, angle_jitter=0.35, length={2,4}, coverage=2.0, pressure={0.35,0.7}, ramps={0.1,0.6}, threshold=0.3, seed=3501})
local around = (ellipse(776, 503, 30, 4) + ellipse(834, 501.5, 26, 4)) - HORSES2 - RAILS - FENCE
work(around, {hand="hatch", pile=gA, tool={kind="round", width=1.0, point=0.8}, angle=-math.pi/2, angle_jitter=0.35, length={2,4}, coverage=1.0, pressure={0.35,0.7}, ramps={0.1,0.6}, threshold=0.3, seed=3502})
print(wait(0))
