local wedge = poly({{482,427},{490,428.5},{500,433},{512,440},{524,447},{500,448},{484,446}}, true)
work(wedge, {hand="detail", pile=moundShade, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=0.3})
local r = brush{kind="round", width=2.2, point=1}
r:load(snowTop, 0.5)
r:stroke({{476,424},{488,428},{500,433},{512,440},{526,448}}, {pressure={0.3,0.1}})
-- the fallen stone to the right shows again under its cap
local st = poly({{443,425},{447,419.5},{458,417},{472,418.5},{478,424},{474,427.5},{452,428}}, true)
work(st - capSnowM, {hand="detail", pile=stoneDark, coverage=4, pressure={0.6,0.9}, load=1, fill=true, tool={kind="round", width=1.6}})
