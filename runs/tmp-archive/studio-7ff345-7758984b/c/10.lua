function landtop(x) return math.min(knoll(x), horizon(x)) end
landm = below(landtop)
snowFar = pile{{"lead white",7},{"pale smalt",1},{"vermilion",0.06},{"yellow ochre",0.15}, medium=0.12}
snowMid = pile{{"lead white",5},{"pale smalt",1.2},{"smalt",0.4},{"vermilion",0.05}, medium=0.12}
snowNear = pile{{"lead white",4},{"smalt",1},{"pale smalt",0.5},{"bone black",0.1},{"red earth",0.05}, medium=0.12}
snowKnoll = pile{{"lead white",5},{"pale smalt",1},{"smalt",0.5},{"bone black",0.05},{"vermilion",0.04}, medium=0.12}
local kn = landm * mask(function(x, y) return (x < 470 and y < 505) and 1 or 0 end)
work(kn, {hand="body", pile=snowKnoll, angle=function(x, y) return 0.12 * math.cos((x - 190) / 120) end,
   length={30, 90}, coverage=2.6, fill=true, pressure={0.5, 0.75}, seed=101})
work(landm * rect(430, 400, 600, 125) - kn, {hand="body", pile=snowFar, angle=0, angle_jitter=0.04,
   length={50, 130}, coverage=2.6, fill=true, pressure={0.5, 0.75}, seed=102})
work(landm * rect(-10, 500, 1020, 105) - rect(-10,400,440,105), {hand="body", pile=snowMid, angle=0, angle_jitter=0.05,
   length={50, 140}, coverage=2.6, fill=true, pressure={0.5, 0.75}, seed=103})
work(rect(-10, 590, 1020, 140), {hand="body", pile=snowNear, angle=0, angle_jitter=0.07,
   length={50, 150}, coverage=2.6, fill=true, pressure={0.5, 0.75}, seed=104})
blend(landm * rect(-20, 480, 1040, 260), {angle=0})
blend(kn:grow(12) * landm, {angle=0.1})
