-- a loader standing on the hay, and a man below pitching up a forkful
local shirt = pile{{"lead white",3},{"yellow ochre",0.2},{"pale smalt",0.2}, medium=0.05}
local dk = pile{{"raw umber",1},{"bone black",0.4},{"lead white",0.35}, medium=0.05}
local sk = pile{{"lead white",1.5},{"red earth",0.4},{"yellow ochre",0.4},{"raw umber",0.1}, medium=0.05}
local t1 = poly({{801.6,523.2},{803.4,523.2},{803.7,526.0},{801.3,526.0}})
local t1l = poly({{801.5,525.8},{803.5,525.8},{803.3,527.4},{801.7,527.4}})
local t2 = poly({{816.3,535.4},{818.3,535.4},{818.6,538.6},{816.0,538.6}})
local t2l = poly({{816.2,538.4},{818.4,538.4},{818.2,541.6},{816.4,541.6}})
work(t1 + t2, {hand="detail", pile=shirt, tool={kind="round", width=0.6, point=0.5}, angle=math.pi/2, coverage=3.5, fill=true, clip=true, pressure={0.4,0.6}, seed=3841})
work(t1l + t2l, {hand="detail", pile=dk, tool={kind="round", width=0.6, point=0.5}, angle=math.pi/2, coverage=3.5, fill=true, clip=true, pressure={0.4,0.6}, seed=3842})
work(ellipse(802.5,522.4,0.65,0.7) + ellipse(817.3,534.6,0.65,0.7), {hand="detail", pile=sk, tool={kind="round", width=0.5, point=0.5}, angle=0, coverage=3, fill=true, clip=true, pressure={0.4,0.6}, seed=3843})
local r = brush{kind="rigger", width=0.45, point=1}
r:reload(dk, 0.5)
r:stroke({{801.8,521.8},{803.2,521.6}}, {pressure={0.4,0.4}})           -- hat
r:stroke({{816.6,534.0},{818.0,533.8}}, {pressure={0.4,0.4}})
r:reload(pile{{"raw umber",1},{"yellow ochre",0.5},{"lead white",0.6}}, 0.5)
r:stroke({{816.8,537},{814.2,532},{812.4,528.2}}, {pressure={0.3,0.25}}) -- fork shaft raised to the load
r:stroke({{804,524.6},{806.2,522.4},{807.6,520.8}}, {pressure={0.25,0.2}})
local hay = pile{{"yellow ochre",1.2},{"lead white",1.3},{"chrome yellow",0.08}, medium=0.05}
r:reload(hay, 0.5)
r:stroke({{811.4,527.8},{812.6,527.2},{813.8,527.6}}, {pressure={0.55,0.3}}) -- the forkful
local gsh = pile{{"yellow ochre",1},{"raw umber",0.6},{"green earth",0.4},{"lead white",0.5},{"pale smalt",0.2}, medium=0.15}
work(ellipse(820.5,541.9,2.6,0.5) - t2l, {hand="detail", pile=gsh, tool={kind="round", width=0.6, point=0.4}, angle=0, coverage=2, fill=true, clip=true, pressure={0.35,0.5}, seed=3844})
