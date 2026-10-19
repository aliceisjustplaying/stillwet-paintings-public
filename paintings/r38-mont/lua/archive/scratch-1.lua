-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box giverny
--@ engine 5

--@ chunk 1
canvas{aspect=1.38, ground={{apply="knife", pile={{"lead white", 1}, {"yellow ochre", 0.025}}, texture=0.12, um=100}, {apply="brush", pile={{"lead white", 1}, {"cobalt blue", 0.015}, {"cobalt violet", 0.02}}, um=65}}, linen={18, 20}, seed=418, size=1100}

--@ chunk 2
blue=pile{{'cobalt blue',3},{'ultramarine blue',1},{'lead white',3},{'viridian',0.35},turps=0.25}; mauve=pile{{'cobalt violet',3},{'cobalt blue',1},{'rose madder',0.55},{'lead white',4},turps=0.25}; green=pile{{'viridian',3},{'ultramarine blue',2},{'cobalt blue',1},{'yellow ochre',0.5},{'lead white',0.7},turps=0.25}; light=pile{{'lead white',7},{'cobalt violet',0.65},{'yellow ochre',0.35},{'vermilion',0.15},turps=0.25}; work(rect(50,50,240,220),{hand='broad',tool='filbert 36',pile=blue,coverage=1.7,load=0.8,length={70,140},angle=1.5}); work(rect(320,50,240,220),{hand='broad',tool='filbert 36',pile=mauve,coverage=1.7,load=0.8,length={70,140},angle=1.5});work(rect(50,340,240,220),{hand='broad',tool='filbert 36',pile=green,coverage=1.7,load=0.8,length={70,140},angle=1.5});work(rect(320,340,240,220),{hand='broad',tool='filbert 36',pile=light,coverage=1.7,load=0.8,length={70,140},angle=1.5});

--@ chunk 3
wait(7*24*60); plum=pile{{'ultramarine blue',3},{'cobalt violet',2},{'rose madder',1},{'viridian',.45},blot=.15}; jade=pile{{'viridian',3},{'barium yellow',1.2},{'lead white',1.1},{'cobalt blue',.5},blot=.15}; rose=pile{{'lead white',3},{'cobalt violet',2},{'rose madder',.65},{'vermilion',.15},blot=.15}; work(rect(100,100,100,100),{hand='body',pile=plum,tool={kind='filbert',width=13,lay=2.5},load=.65,coverage=.85,length={18,46},angle=1.4}); work(rect(90,370,120,100),{hand='body',pile=jade,tool={kind='filbert',width=12,lay=2.5},load=.65,coverage=.9,length={16,42},angle=1.4}); work(rect(330,95,150,110),{hand='body',pile=rose,tool={kind='filbert',width=14,lay=2.5},load=.65,coverage=.8,length={25,60},angle=.05});

--@ chunk 4
work(rect(200,375,70,110),{hand='scumble',pile=jade,tool={kind='filbert',width=10,lay=1,hair=.85,stiffness=.9},load=.23,dips={3,.23,.95},coverage=1.2,length={12,30},angle=1.3}); work(rect(200,100,70,110),{hand='scumble',pile=plum,tool={kind='filbert',width=10,lay=1,hair=.85,stiffness=.9},load=.23,dips={3,.23,.95},coverage=.8,length={12,30},angle=1.4});
