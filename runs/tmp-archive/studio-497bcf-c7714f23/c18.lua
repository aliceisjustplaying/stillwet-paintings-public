townD = pile{{"lead white", 3}, {"smalt", 1.5}, {"pale smalt", 1}, {"raw umber", 0.6}, {"bone black", 0.08}, medium=0.12}
townT = pile{{"lead white", 3}, {"pale smalt", 1.5}, {"green earth", 1}, {"raw umber", 0.6}, {"smalt", 0.5}, medium=0.12}
-- shaded faces of towers and spires
local sh = poly({{267,391},{267,352},{272.5,391}}) + rect(267.5,390,4.5,42)
        + poly({{326.5,367},{326.5,317},{330,367}}) + rect(326.8,366,2.7,13) + rect(327,378,4,54)
        + poly({{433,356},{448,373},{433,373}}) + rect(434,372,12,60)
        + poly({{433,356},{448,373},{433,373}})
work(sh * town_all, {hand="detail", pile=townD, angle=math.pi/2, coverage=2.2, length={3,9}, fill=true, clip=true, edge="found"})
-- lower band of the town in the shadow of its own walls and trees
work(rect(226,424,370,14) * town_all, {hand="detail", pile=townD, angle=0, coverage=1.5, length={4,12}, fill=true, clip=true, edge="found"})
-- trees among the houses: small rounded clumps
local clumps = poly({{225,440},{226,431},{230,426},{236,425},{241,428},{244,433},{246,440}}, true)
  + poly({{560,440},{562,428},{568,422},{576,421},{583,425},{588,431},{592,440}}, true)
  + poly({{596,440},{598,433},{604,430},{611,432},{614,440}}, true)
  + poly({{300,440},{302,430},{308,427},{314,430},{316,440}}, true)
  + poly({{690,440},{692,431},{699,427},{707,429},{711,436},{712,440}}, true)
clumps = clumps:roughen(1.2, 5, 9)
stipple(clumps, {pile=townT, width=2.2, coverage=5, pressure={0.4,0.7}, clip=clumps})
print(wait(0))
