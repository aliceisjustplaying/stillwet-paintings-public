-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box cezanne
--@ engine 5

--@ chunk 1
canvas{aspect=1.25, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.25}}, texture=0.3, um=120}}, linen={18, 16}, seed=1906, size=730}

--@ chunk 2
draw = pile{{"ultramarine blue",3},{"bone black",0.3},{"lead white",0.5}, thinner=0.6, name="draw"}
r = brush{kind="round", width=3, point=0.8}
r:load(draw, 0.6)
r:gesture({{60,60,0.3},{150,80,0.7},{250,70,0.5},{320,120,0.2}}, {wobble=2})
r:gesture({{60,120,0.6},{200,140,0.6},{320,170,0.6}}, {wobble=2})
wallw = pile{{"lead white",2},{"cobalt blue",1},{"viridian",0.4},{"yellow ochre",0.6}, turps=0.6, name="wallw"}
work(rect(40,200,300,150), {hand="broad", pile=wallw, coverage=1.2, angle=-0.8})
wall1 = pile{{"lead white",3},{"cobalt blue",1},{"viridian",0.3},{"yellow ochre",0.8},{"red earth",0.2}, name="wall1"}
work(rect(380,200,280,150), {hand="hatch", tool={kind="flat", width=9}, pile=wall1, coverage=1.3, angle=-0.9, length={18,32}})
cw1 = pile{{"lead white",6},{"cobalt blue",0.3},{"rose madder",0.1}, name="cw1"}
cw2 = pile{{"lead white",6},{"yellow ochre",0.3},{"vermilion",0.05}, name="cw2"}
work(rect(700,200,260,150), {hand="body", pile=cw1, coverage=1, angle=0.4})
work(rect(700,280,260,70), {hand="body", pile=cw2, coverage=1, angle=0.4})
ap1 = pile{{"vermilion",2},{"rose madder",0.5},{"chrome yellow",0.3}, name="ap1"}
ap2 = pile{{"chrome yellow",2},{"yellow ochre",1},{"vermilion",0.3}, name="ap2"}
ap3 = pile{{"emerald green",2},{"chrome yellow",1},{"yellow ochre",0.5}, name="ap3"}
ap4 = pile{{"red earth",2},{"rose madder",1},{"ultramarine blue",0.3}, name="ap4"}
local xs = {80,240,400,560}
for i,p in ipairs({ap1,ap2,ap3,ap4}) do
  work(ellipse(xs[i]+60, 500, 55, 50), {hand="hatch", tool={kind="flat",width=7}, pile=p, coverage=1.5, angle=-0.8, length={10,22}})
end
tab = pile{{"red earth",2},{"yellow ochre",1},{"bone black",0.3},{"vermilion",0.3}, name="tab"}
dk = pile{{"ultramarine blue",1},{"bone black",0.5},{"red earth",0.5},{"viridian",0.4}, name="dk"}
work(rect(40,620,400,140), {hand="hatch", tool={kind="flat",width=10}, pile=tab, coverage=1.3, angle=-0.3, length={20,40}})
work(rect(500,620,400,140), {hand="body", pile=dk, coverage=1.3, angle=1.2})

--@ chunk 3
draw2 = pile{{"ultramarine blue",3},{"bone black",0.4},{"red earth",0.3}, thinner=0.3, name="draw2"}
r2 = brush{kind="round", width=4, point=0.7}
r2:load(draw2, 0.9)
r2:gesture({{60,420,0.5},{160,400,0.8},{260,410,0.6},{330,440,0.3}}, {wobble=2})
-- straighter constructive patches on wall
work(rect(720,420,250,120), {hand="hatch", tool={kind="flat", width=8}, pile=wall1, coverage=1.4, angle=-1.0, angle_jitter=0.08, length={22,34}, curve={0.02,0}, ruler=false})
-- modeled apple: base red, light patch, shadow patch
local cx, cy, rr = 850, 680, 45
local A = ellipse(cx, cy, rr, rr*0.95)
work(A, {hand="hatch", tool={kind="flat",width=7}, pile=ap1, coverage=1.2, angle=-0.9, angle_jitter=0.15, length={10,18}, clip=true})
work(A*ellipse(cx-15, cy-15, 25, 22), {hand="hatch", tool={kind="flat",width=6}, pile=ap2, coverage=1.0, angle=-0.6, length={8,14}, clip=true})
work(A*ellipse(cx+22, cy+20, 30, 28):soften(4), {hand="hatch", tool={kind="flat",width=6}, pile=ap4, coverage=1.0, angle=-1.2, length={8,14}, clip=true})
r2:reload(draw2, 0.7)
r2:gesture({{cx+rr*0.5, cy-rr*0.85, 0.2},{cx+rr, cy, 0.7},{cx+rr*0.6, cy+rr*0.8, 0.6},{cx-rr*0.2,cy+rr, 0.3}}, {wobble=1.5})

--@ chunk 4
draw3 = pile{{"ultramarine blue",3},{"bone black",0.4},{"red earth",0.3}, medium=0.3, name="draw3"}
local tests = {
 {brush{kind="round", width=3, point=0}, draw2, 0.9},
 {brush{kind="round", width=3, point=0}, draw3, 0.9},
 {brush{kind="round", width=5, point=0.5}, draw3, 0.9},
 {brush{kind="round", width=2.5, point=0.3}, draw3, 0.7},
}
for i,t in ipairs(tests) do
  local b = t[1]; b:load(t[2], 0.8)
  local y = 40 + i*25
  b:gesture({{450,y,t[3]},{550,y-6,t[3]},{650,y+4,t[3]*0.7},{720,y+10,0.3}}, {wobble=1.5})
end
