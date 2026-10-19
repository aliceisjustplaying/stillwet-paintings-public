trunkMid = pile{{"raw umber",1.4},{"lead white",1.3},{"bone black",0.2},{"yellow ochre",0.1}, medium=0.15}
local burr = ellipse(203, 371, 11, 10)
work(burr, {hand="detail", pile=trunkMid, coverage=3, fill=true, angle=85, pressure={0.6,0.9}, load=0.9, tool={kind="round", width=2}})
blend(ellipse(203, 371, 13, 12), {angle=85})
-- a swelling suggested by a curved crack and a shadow underneath
local b = brush{kind="round", width=1.3}
b:load(barkDark, 0.8)
b:stroke({{195,366},{199,372},{204,376},{210,375}}, {pressure={0.5,0.7,0.5,0.2}})
b:stroke({{197,379},{203,381},{209,380}}, {pressure={0.4,0.6,0.3}})
b:stroke({{201,362},{203,368},{202,374}}, {pressure={0.3,0.5,0.2}})
