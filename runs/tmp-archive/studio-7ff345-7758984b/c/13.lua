snowB1 = pile{{"lead white",5},{"pale smalt",1.5},{"vermilion",0.08},{"yellow ochre",0.1}, medium=0.15}
snowB2 = pile{{"lead white",3.5},{"smalt",1},{"pale smalt",0.6},{"bone black",0.12},{"vermilion",0.05}, medium=0.15}
snowB3 = pile{{"lead white",2.5},{"smalt",1.2},{"bone black",0.25},{"red earth",0.08}, medium=0.15}
knollP = pile{{"lead white",4},{"pale smalt",1.2},{"smalt",0.5},{"bone black",0.1},{"vermilion",0.05}, medium=0.15}
knm = landm * mask(function(x, y) local yy = 505 + 20*math.sin(x/70) ; return (x < 520 and y < yy - (x > 440 and (x-440)*0.4 or 0)) and 1 or 0 end)
work(knm, {hand="body", pile=knollP, angle=function(x, y) return 0.15 * math.cos((x - 190) / 120) end,
   length={30, 90}, coverage=2.4, fill=true, pressure={0.5, 0.75}, seed=131})
work(landm * rect(-10, 455, 1020, 90) - knm, {hand="body", pile=snowB1, angle=0, angle_jitter=0.04,
   length={50, 130}, coverage=2.4, fill=true, pressure={0.5, 0.75}, seed=132})
work(rect(-10, 530, 1020, 95) - knm, {hand="body", pile=snowB2, angle=0, angle_jitter=0.05,
   length={50, 140}, coverage=2.4, fill=true, pressure={0.5, 0.75}, seed=133})
work(rect(-10, 612, 1020, 120), {hand="body", pile=snowB3, angle=0, angle_jitter=0.07,
   length={50, 150}, coverage=2.4, fill=true, pressure={0.5, 0.75}, seed=134})
blend(landm * rect(-20, 440, 1040, 300), {angle=0})
blend(landm * rect(-20, 440, 1040, 300), {angle=0.08})
