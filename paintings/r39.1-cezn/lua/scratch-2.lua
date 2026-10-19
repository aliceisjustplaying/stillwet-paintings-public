-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box cezanne
--@ engine 5

--@ chunk 1
canvas{aspect=1.25, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.25}}, texture=0.3, um=120}}, linen={18, 16}, seed=1906, size=730}

--@ chunk 2
skyF = pile{{"lead white",3},{"cobalt blue",1.6},{"ultramarine blue",0.3},{"viridian",0.15}}
skyH = pile{{"lead white",6},{"cobalt blue",0.5},{"rose madder",0.12},{"yellow ochre",0.2}}
line = pile{{"ultramarine blue",1},{"cobalt blue",0.6},{"lead white",0.35},{"rose madder",0.1}, medium=0.2}
work(rect(50,50,300,200), {hand="hatch", tool={kind="flat", width=12}, length={26,42}, angle=-1.1, piles={{skyF,1},{skyH,1}}, coverage=1.5, load=0.8})
local lb = brush{kind="round", width=4.5, point=0.5}
lb:load(line,0.55) lb:gesture({{60,150,0.1},{200,120,0.5},{340,110,0.3}}, {wobble=1})
wait(20*24*60)
mtLit = pile{{"lead white",6},{"yellow ochre",0.6},{"rose madder",0.35},{"cobalt blue",0.25}}
mPale = pile{{"lead white",7},{"yellow ochre",0.6},{"rose madder",0.2},{"cobalt blue",0.1}}
mPink = pile{{"lead white",5},{"rose madder",0.5},{"yellow ochre",0.6},{"vermilion",0.06}}
mViol = pile{{"lead white",3},{"cobalt blue",1.2},{"rose madder",0.6},{"ultramarine blue",0.3}}
work(rect(60,60,130,180), {hand="hatch", tool={kind="flat", width=8}, length={14,30}, angle=-0.4, angle_jitter=0.1, piles={{mtLit,1},{mPale,0.6},{mPink,0.5}}, coverage=1.3, load=0.8, clip=true})
work(rect(200,60,130,180), {hand="hatch", tool={kind="flat", width=8}, length={14,30}, angle=-0.4, angle_jitter=0.1, piles={{mtLit,1},{mPale,0.6},{mPink,0.5},{mViol,0.4}}, coverage=1.0, load=0.75, clip=true})
