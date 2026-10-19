-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
s2 = pile{{"Prussian blue",0.6},{"ultramarine blue",0.4},{"bone black",0.35},{"lead white",1.2},{"raw umber",0.15}}
s3 = pile{{"Prussian blue",0.45},{"viridian",0.2},{"yellow ochre",0.35},{"lead white",2},{"bone black",0.2}}
ztrou2 = pile{{"bone black",1},{"raw umber",0.7},{"green earth",0.25},{"ultramarine blue",0.15}}
zsuit2 = pile{{"bone black",0.8},{"raw umber",0.6},{"green earth",0.5},{"lead white",0.04}}
work(everywhere(), {hand="broad", coverage=2.2, fill=true, clip=true,
  piles={{s2, function(x,y) return smoothstep(500,0,y) end},{s3, function(x,y) return smoothstep(100,600,y) end}}})
wait(10*24*60)
-- two leg-like dark columns and a torso
LEGA = poly({{200,150},{240,150},{230,560},{190,560}})
LEGB = poly({{400,150},{440,150},{430,560},{390,560}})
LEGC = poly({{600,150},{640,150},{630,560},{590,560}})
LEGD = poly({{800,150},{840,150},{830,560},{790,560}})
work(LEGA+LEGB+LEGC+LEGD, {hand="body", pile=ztrou2, coverage=2.5, fill=true, clip=true, angle=1.6})
wait(20*24*60)
print(drying(210,300))

--@ chunk 3
warm_t = pile{{"raw umber",0.6},{"yellow ochre",0.6},{"red earth",0.15},{"lead white",0.3}, thinner=0.6}
warm_o = pile{{"raw umber",0.6},{"yellow ochre",0.55},{"red earth",0.15},{"lead white",0.2},{"bone black",0.1}}
zd_mid = pile{{"bone black",0.5},{"raw umber",0.6},{"green earth",0.6},{"yellow ochre",0.2},{"lead white",0.04}}
zd_mid_t = pile{{"bone black",0.5},{"raw umber",0.6},{"green earth",0.6},{"yellow ochre",0.2},{"lead white",0.04}, thinner=0.6}
-- A: warm thinned scumble, band on left side graded
local bandA = LEGA:times(function(x,y) local xl = lerp(200,190,(y-150)/410) return smoothstep(16, 2, x - xl) end)
work(bandA, {hand="scumble", pile=warm_t, coverage=1.3, fill=true, clip=LEGA, angle=1.6})
-- B: opaque thin edge line
local bandB = LEGB:times(function(x,y) local xl = lerp(400,390,(y-150)/410) return (x - xl < 4) and 1 or 0 end)
work(bandB, {hand="detail", pile=warm_o, coverage=1.5, fill=true, clip=bandB, angle=1.6})
-- C: mid-tone thinned scumble in vertical streak (crease light) + warm thinned edge
local bandC = LEGC:times(function(x,y) local xl = lerp(600,590,(y-150)/410) return smoothstep(12, 2, x - xl) end)
work(bandC, {hand="scumble", pile=warm_t, coverage=1.0, fill=true, clip=LEGC, angle=1.6})
local crease = ribbon({{618,200},{614,330},{611,400},{606,520}}, 6):blur(3)
work(crease, {hand="scumble", pile=zd_mid_t, coverage=1.2, fill=true, clip=crease*LEGC, angle=1.6})
-- D: opaque zd_mid body strokes for folds (knee) 
local f1 = ribbon({{800,330},{815,345},{832,350}}, 5)
local f2 = ribbon({{797,380},{815,392},{830,394}}, 4)
work((f1+f2)*LEGD, {hand="detail", pile=zd_mid, coverage=1.2, fill=true, clip=LEGD, angle=0.4})
wait(20*24*60)
