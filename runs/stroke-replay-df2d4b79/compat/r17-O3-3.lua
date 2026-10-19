-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=500, aspect=1.4, linen={18,15}, seed=7, ground={{pile={{"lead white",4},{"yellow ochre",1}}, um=100, apply="knife", texture=0.3},{pile={{"red earth",1},{"yellow ochre",2},{"lead white",3}}, um=20, apply="brush"}}}
print(W,H)

--@ chunk 2
h = pencil("2B")
h:rule({0, 440}, {1000, 440}, {pressure=0.25})
-- tree mass outline
h:sketch({{0,200},{40,170},{90,150},{140,175},{180,160},{230,190},{270,230},{300,290},{330,350},{345,410},{350,440}}, {pressure=0.3})
-- distant hills
h:sketch({{560,440},{620,418},{700,405},{790,412},{870,400},{950,410},{1000,415}}, {pressure=0.2})
-- far bank
h:sketch({{350,450},{500,448},{700,452},{1000,450}}, {pressure=0.2})
-- boat
h:sketch({{590,548},{605,556},{660,557},{680,547}}, {pressure=0.35})
h:sketch({{630,550},{632,522},{636,515}}, {pressure=0.35})
-- foreground bank
h:sketch({{0,600},{80,610},{160,640},{230,680},{260,714}}, {pressure=0.3})

--@ chunk 3
sky = above(function(x) return 452 end)
local function cut(y0, amp, s) return function(x) return y0 + amp*math.sin(x/130 + s) + 0.5*amp*math.sin(x/47 + 2*s) end end
local b1 = above(cut(150, 14, 1))
local b2 = above(cut(270, 12, 2))
local b3 = above(cut(370, 8, 3))
skyA = sky * b1
skyB = sky * b2 - b1
skyC = sky * b3 - b2
skyD = sky - b3
pA = pile{{"lead white",5},{"smalt",2},{"Prussian blue",0.08}}
pB = pile{{"lead white",7},{"pale smalt",1.2},{"yellow ochre",0.15}}
pC = pile{{"lead white",7},{"chrome yellow",0.35},{"vermilion",0.06},{"pale smalt",0.2}}
pD = pile{{"lead white",6},{"chrome yellow",0.8},{"vermilion",0.2}}
local opt = function(p) return {hand="body", tool="filbert 14", pile=p, angle=0.03, angle_jitter=0.12, coverage=3, fill=true, length={60,160}} end
work(skyA, opt(pA))
work(skyB, opt(pB))
work(skyC, opt(pC))
work(skyD, opt(pD))

