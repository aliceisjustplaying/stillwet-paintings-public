-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=460, aspect=1.25, linen={17,13}, seed=7, ground={{pile={{"lead white",1}}, um=120, apply="knife", texture=0.3}, {pile={{"lead white",3},{"yellow ochre",1},{"raw umber",1}}, um=25, apply="brush"}}}

--@ chunk 2
c = chalk()
-- table edges
c:sketch({{0,522},{300,520},{700,519},{1000,521}}, {pressure=0.3})
c:sketch({{0,690},{500,689},{1000,691}}, {pressure=0.3})
-- jug
jugL = {{300,192},{296,215},{302,240},{275,300},{240,380},{236,440},{252,510},{280,570},{300,600}}
jugR = {{420,192},{424,215},{418,240},{445,300},{480,380},{484,440},{468,510},{440,570},{420,600}}
c:sketch(jugL, {pressure=0.35})
c:sketch(jugR, {pressure=0.35})
c:sketch({{300,600},{360,610},{420,600}}, {pressure=0.3})
-- rim ellipse and spout
c:sketch({{300,192},{330,180},{360,177},{400,180},{420,192},{390,202},{360,204},{320,200},{300,192}}, {pressure=0.3})
c:sketch({{300,192},{275,178},{262,172}}, {pressure=0.3})
-- handle
c:sketch({{422,225},{470,222},{510,245},{520,300},{500,360},{475,400}}, {pressure=0.35})
c:sketch({{425,250},{465,248},{490,270},{493,310},{478,355},{470,375}}, {pressure=0.3})
-- lemons
c:sketch({{540,595},{560,560},{610,545},{660,555},{680,590},{660,625},{600,638},{555,625},{540,595}}, {pressure=0.3})
c:sketch({{650,555},{675,525},{720,515},{765,528},{780,560},{770,580}}, {pressure=0.3})
-- knife
c:sketch({{560,670},{700,690},{800,712}}, {pressure=0.3})
c:sketch({{560,670},{700,702},{800,724}}, {pressure=0.3})
c:sketch({{790,705},{870,735},{940,762},{950,778},{930,780},{860,757},{785,728}}, {pressure=0.35})

--@ chunk 3
local pts = {}
for _, p in ipairs(jugL) do pts[#pts+1] = p end
pts[#pts+1] = {360, 608}
for i = #jugR, 1, -1 do pts[#pts+1] = jugR[i] end
pts[#pts+1] = {360, 176}
jugBody = poly(pts, true)
spout = poly({{300,186},{268,170},{258,172},{285,195},{302,205}}, true)
handle = ribbon({{420,236},{468,234},{505,256},{510,300},{492,355},{474,392}}, {22,22,20,18,16,14})
jug = jugBody + spout + handle
lemon1 = ellipse(610, 592, 72, 46)
lemon2 = poly({{652,560},{672,527},{720,515},{765,527},{782,558},{770,582},{720,590},{668,582}}, true)
lemons = lemon1 + lemon2
table_top = rect(0, 521, 1000, 169)
front = rect(0, 690, 1000, 110)
wall = rect(0, 0, 1000, 521)
print(jug:area(), lemons:area())

