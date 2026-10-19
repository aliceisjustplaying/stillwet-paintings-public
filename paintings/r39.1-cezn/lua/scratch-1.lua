-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box cezanne
--@ engine 5

--@ chunk 1
canvas{aspect=1.25, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.25}}, texture=0.3, um=120}}, linen={18, 16}, seed=1906, size=730}

--@ chunk 2
draw = pile{{"ultramarine blue",1},{"lead white",0.2}, turps=0.7, name="draw"}
wash = pile{{"ultramarine blue",1},{"viridian",0.5},{"lead white",0.5}, turps=0.85, name="wash"}
sky = pile{{"lead white",6},{"cobalt blue",1},{"emerald green",0.15}, name="sky"}
green = pile{{"viridian",2},{"emerald green",1},{"yellow ochre",1},{"lead white",1},{"ultramarine blue",0.5}, name="green"}
ochre = pile{{"yellow ochre",3},{"lead white",3},{"vermilion",0.4}, name="ochre"}
roof = pile{{"red earth",2},{"vermilion",1},{"lead white",0.5}, name="roof"}
b = brush{kind="round", width=3, point=0.8}
b:load(draw, 0.8)
b:gesture({{50,100,0.3},{150,60,0.6},{260,120,0.4},{350,90,0.2}})
b:gesture({{50,180,0.5},{350,170,0.5}})
work(rect(50,200,280,150), {hand="glaze", pile=wash, coverage=1})
work(rect(400,50,250,150), {hand="hatch", pile=sky, tool={kind="flat", width=9}, length={25,40}, angle=-0.9, coverage=1.5})
work(rect(400,250,250,150), {hand="hatch", pile=green, tool={kind="flat", width=9}, length={25,40}, angle=-1.1, coverage=1.2})
work(rect(700,50,250,150), {hand="hatch", pile=ochre, tool={kind="flat", width=9}, length={25,40}, angle=0.0, coverage=1.2})
work(rect(700,250,250,150), {hand="hatch", pile=roof, tool={kind="flat", width=9}, length={25,40}, angle=-0.6, coverage=1.2})

--@ chunk 3
sky2 = pile{{"lead white",5},{"cobalt blue",1.5},{"ultramarine blue",0.3},{"emerald green",0.2}, turps=0.25, name="sky2"}
green2 = pile{{"viridian",1.5},{"emerald green",1.5},{"chrome yellow",0.4},{"yellow ochre",0.6},{"lead white",0.6},{"ultramarine blue",0.4}, turps=0.25, name="green2"}
work(rect(50,450,280,150), {hand="hatch", pile=sky2, tool={kind="flat", width=10}, length={28,42}, angle=-0.95, angle_jitter=0.08, curve={0.05,0}, coverage=1.3})
work(rect(400,450,250,150), {hand="hatch", pile=green2, tool={kind="flat", width=10}, length={28,42}, angle=-1.1, angle_jitter=0.08, curve={0.05,0}, coverage=1.1, clump=0.3})
work(rect(700,450,250,150), {hand="hatch", piles={{green2,1},{ochre,function(x,y) return (x-700)/250 end}}, tool={kind="flat", width=10}, length={28,42}, angle=-0.7, angle_jitter=0.1, coverage=1.1})

--@ chunk 4
gDark = pile{{"viridian",2},{"ultramarine blue",1},{"bone black",0.15},{"yellow ochre",0.5},{"lead white",0.3}, name="gDark"}
gYel = pile{{"emerald green",1},{"chrome yellow",0.5},{"yellow ochre",1.2},{"lead white",1}, name="gYel"}
shadeV = pile{{"ultramarine blue",1},{"rose madder",0.35},{"viridian",0.5},{"lead white",1.0}, name="shadeV"}
work(rect(50,650,400,130), {hand="hatch", tool={kind="flat", width=12}, length={26,46}, angle=-0.8, piles={{gYel,1},{shadeV,0.6},{gDark,0.4}}, coverage=1.3})
wait(10*24*60)
-- test semi-transparent unifying scumble: lean, turps
shGl = pile{{"ultramarine blue",1},{"viridian",0.6},{"rose madder",0.2},{"lead white",0.3}, turps=0.5, name="shGl"}
warmGl = pile{{"yellow ochre",1},{"chrome yellow",0.3},{"lead white",0.6},{"emerald green",0.2}, turps=0.4, name="warmGl"}
work(rect(50,650,130,130), {hand="hatch", tool={kind="flat", width=14}, length={30,50}, angle=-1.0, pile=shGl, coverage=1.0, clip=true})
work(rect(185,650,130,130), {hand="hatch", tool={kind="flat", width=14}, length={30,50}, angle=-0.5, pile=warmGl, coverage=1.0, clip=true})
work(rect(320,650,130,130), {hand="hatch", tool={kind="flat", width=14}, length={30,50}, angle=-0.5, pile=warmGl, coverage=0.7, clip=true, load=0.5})

--@ chunk 5
road = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.2},{"rose madder",0.1}, name="road"}
work(rect(500,650,400,130), {hand="hatch", tool={kind="flat", width=12}, length={26,46}, angle=-0.8, pile=road, coverage=1.5})
wait(10*24*60)
shR2 = pile{{"lead white",1},{"cobalt blue",1},{"ultramarine blue",0.4},{"rose madder",0.4},{"yellow ochre",0.2}, name="shR2"}
shG2 = pile{{"viridian",1},{"ultramarine blue",0.6},{"yellow ochre",0.5},{"lead white",0.4},{"rose madder",0.1}, name="shG2"}
work(rect(510,660,180,110), {hand="hatch", tool={kind="flat", width=11}, length={24,40}, angle=-0.25, pile=shR2, coverage=1.1, clip=true})
work(rect(700,660,190,110), {hand="hatch", tool={kind="flat", width=11}, length={24,40}, angle=-0.25, pile=shG2, coverage=1.1, clip=true})
work(rect(50,500,400,130), {hand="hatch", tool={kind="flat", width=11}, length={24,40}, angle=-0.25, pile=shG2, coverage=1.1, clip=true})

--@ chunk 6
wait(10*24*60)
line = pile{{"ultramarine blue",1},{"cobalt blue",0.6},{"lead white",0.3},{"rose madder",0.1}, medium=0.2, name="line"}
lb = brush{kind="round", width=3.5, point=0.5}
lb:load(line, 0.6)
lb:gesture({{520,700,0.2},{560,690,0.6},{620,680,0.7},{660,676,0.3}})
lb:load(line, 0.6)
lb:gesture({{700,700,0.5},{780,690,0.5}})
lb:load(line, 0.3)
lb:gesture({{520,740,0.4},{600,730,0.5},{680,722,0.2}})
