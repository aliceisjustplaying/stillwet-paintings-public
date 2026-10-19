-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.25, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 1}, {"red earth", 0.4}}, texture=0.12, um=100}}, linen={18, 20}, seed=741, size=600}

--@ chunk 2
wall=pile{{'ultramarine blue',3},{'Indian red',2},{'bone black',1}}
blue=pile{{'Prussian blue',1},{'ultramarine blue',2},{'cerulean blue',2}}
clothPaint=pile{{'lead white',7},{'yellow ochre',0.6},{'ultramarine blue',0.25}}
orange=pile{{'orange vermilion',3},{'cadmium yellow',2},{'red earth',0.3}}
work(rect(80,100,580,450),{hand='broad',pile=wall,coverage=1.5,tool='filbert 35',load=0.8,clip=true})
wait(7*1440)
work(ellipse(240,320,90,135),{hand='body',pile=blue,tool='filbert 22',coverage=1.6,load=0.8,clip=true})
work(poly{{360,430},{630,370},{590,520},{345,510}},{hand='broad',pile=clothPaint,coverage=1.5,tool='filbert 30',load=0.8,clip=true})
work(ellipse(450,395,60,48),{hand='body',pile=orange,coverage=1.5,tool='filbert 18',load=0.8,clip=true})

--@ chunk 3
work(rect(700,130,270,450),{hand='broad',pile=wall,coverage=3,tool='filbert 35',load=0.8,clip=true,fill=true})
wait(7*1440)
work(poly{{710,405},{950,360},{940,560},{720,550}},{hand='broad',pile=clothPaint,coverage=3,tool='filbert 30',load=0.8,clip=true,fill=true})
wait(7*1440)
work(ellipse(825,400,65,50),{hand='body',pile=orange,coverage=3,tool='filbert 18',load=0.8,clip=true,fill=true})
