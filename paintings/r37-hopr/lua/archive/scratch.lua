-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box hopper
--@ engine 5

--@ chunk 1
canvas{aspect=1.43, ground={{apply="knife", pile={{"lead white", 1}, {"yellow ochre", 0.035}}, texture=0.12, um=95}}, linen={24, 22}, seed=714, size=900}

--@ chunk 2
a=pile{{'lead white',8},{'yellow ochre',2},{'pale cadmium',0.6},{'red earth',0.13},turps=0.12}
s=pile{{'lead white',3},{'ultramarine blue',1},{'yellow ochre',1},{'bone black',0.3},turps=0.12}
work(rect(200,150,300,250),{hand='broad',pile=a,coverage=1.6,load=.85,clip=true,fill=true})
work(rect(200,150,150,250),{hand='broad',pile=s,coverage=1.6,load=.85,clip=true,fill=true})
wait(7200)
s2=pile{{'lead white',3},{'ultramarine blue',1},{'yellow ochre',1},{'bone black',0.3}}
work(rect(200,150,150,200),{hand='broad',tool={kind='flat',width=22,lay=2},pile=s2,coverage=3,load=.9,clip=true,fill=true,angle=0})

--@ chunk 3
wait(100*1440)
s3=pile{{'lead white',3},{'ultramarine blue',1},{'yellow ochre',1},{'bone black',0.3}}
work(rect(200,150,150,200),{hand='body',pile=s3,tool={kind='flat',width=20,lay=1,pickup=0},coverage=3,dips={1,1,1},length={30,55},clip=true,fill=true,angle=0})
