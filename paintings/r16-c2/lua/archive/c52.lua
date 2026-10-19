innerP2 = pile{{"raw umber",1},{"lead white",0.6},{"cobalt blue",0.2},{"red earth",0.15}}
work(inner, {hand="detail", tool="round 2", pile=innerP2, angle=-0.05, coverage=2, length={6,15}, fill=true})
contact = poly({{186,612},{214,617},{246,617},{276,611},{292,605},{298,609},{280,617},{246,623},{210,623},{182,618}}, true)
work(contact, {hand="detail", tool="round 2", pile=shP, angle=0, coverage=2.5, length={6,15}, fill=true})
local r = brush{kind="rigger", width=1.4, point=1}
r:load(hullP, 0.8)
r:stroke({{238,599},{234,560},{229,515}}, {pressure={0.9,0.4}})
r:reload(hullP, 0.5)
r:stroke({{229,517},{262,556},{296,588}}, {pressure={0.25,0.2}})
r:reload(hullP, 0.6)
r:stroke({{179,597},{181,605},{183,611}}, {pressure={0.8,0.8}})
r:stroke({{292,592},{298,586},{301,583}}, {pressure={0.7,0.4}})
gl = pile{{"lead white",5},{"yellow ochre",0.4},{"vermilion",0.1}}
local g = brush{kind="round", width=1.2, point=0.7}
g:load(gl, 0.5)
g:stroke({{183,597},{205,599},{235,600},{262,598},{285,594},{297,590}}, {pressure={0.35,0.2}})
