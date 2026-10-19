umber = pal:only{"raw umber", "bone black", "lead white", "yellow ochre"}
bankM = below(BANK):roughen(1.2, 30, 3, 0.8)
trunkM = poly(TRUNK, true)
-- the sepia lay-in: thin raw umber, in values only, two washes crossing a little
work(bankM, {hand="glaze", color="#5b4633", medium=0.6, coverage=1.4, angle=0.02, length={80, 220}, pal=umber, edge="found"})
work(bankM * below(function(x) return 610 + 10 * math.sin(x / 90) end), {hand="glaze", color="#4d3b2b", medium=0.6, coverage=1.4, angle=-0.06, length={60, 200}, pal=umber, edge="found"})
work(trunkM, {hand="glaze", tool="filbert 7", color="#3d2f23", medium=0.6, coverage=1.4, angle=1.52, length={15, 50}, pal=umber, edge={found=0.5, soft=0.5, period=30}})
work(trunkM, {hand="glaze", tool="filbert 5", color="#3d2f23", medium=0.6, coverage=1.4, angle=1.3, length={15, 40}, pal=umber, edge={found=0.5, soft=0.5, period=30}})
