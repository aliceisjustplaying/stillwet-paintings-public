discFix = pile{{"lead white",4},{"yellow ochre",0.9},{"chrome yellow",0.25},{"red earth",0.08},{"smalt",0.1}, medium=0.3}
local dm = (ellipse(214,416,32,28) * rect(0,380,1000,56)) - foresail:mask():grow(3)
work(dm, {hand="detail", pile=discFix, angle=0, coverage=1.5, pressure={0.2,0.4}, fill=true, clip=true})
blend(dm:grow(4):soften(6) - foresail:mask():grow(3), {angle=0})
-- mast reflection: a thin wavering dark line in the water
local r = brush{kind="rigger", width=1.6, point=1}
r:reload(lineP, 0.6)
local pts = {}
for i = 0, 10 do local y = 474 + i*9; pts[#pts+1] = {301 + 2.2*math.sin(i*1.9), y} end
r:stroke(pts, {pressure={0.5,0.05}, ramps={0.05,0.6}})
