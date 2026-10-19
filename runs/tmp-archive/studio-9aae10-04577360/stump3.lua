fgMid = pile{{"lead white",2.5},{"smalt",1.4},{"raw umber",0.28},{"red earth",0.1}, medium=0.1}
local peaks = poly({{61,619},{64,611},{69,613},{74,610},{79,613},{85,614},{88,622},{86,623},{80,620},{75,616.5},{70,621},{66,617},{62,620}}, true)
work(peaks, {hand="detail", pile=fgMid, coverage=4, fill=true, load=1, pressure={0.5,0.8}, tool={kind="round", width=1.2, point=0.6}})
local drift = poly({{34,662},{44,655},{60,652.5},{80,653},{100,655},{112,661},{100,668},{40,668}}, true)
work(drift, {hand="body", pile=fgMid, coverage=2, fill=true, angle=0, edge="soft", tool={kind="filbert", width=5}, length={12,30}})
-- keep a lit lip of snow at the foot of the stump
local tb = brush{kind="round", width=1.6, point=0.8}
tb:load(capShade, 0.7)
tb:stroke({{44,655.5},{56,652.5},{70,654},{86,652.5},{99,655}}, {pressure={tb:pressure_for(1.2), tb:pressure_for(0.8)}, shake=0.4})
