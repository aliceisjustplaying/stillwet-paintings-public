-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 1}, {"yellow ochre", 2}, {"lead white", 3}}, texture=0.12, um=45}, {apply="roller", pile={{"lead white", 12}, {"raw umber", 0.3}, {"yellow ochre", 0.25}}, texture=0.1, um=40}}, linen={16, 17}, seed=41, size=700}

--@ chunk 2
cool=pile{{'lead white',7},{'cobalt blue',1.1},{'raw umber',.45},{'bone black',.15},thinner=.25}
warm=pile{{'lead white',12},{'Naples yellow',1.6},{'red earth',.22},{'yellow ochre',.2},thinner=.25}
work(rect(200,100,500,400),{hand='broad',tool='filbert 45',piles={{cool,function(x,y)return 1-smoothstep(130,470,y)end},{warm,function(x,y)return smoothstep(130,470,y)end}},coverage=2,load=.8,fill=true,clip=true,angle=0,length={180,300}})
blend(rect(210,110,480,380),{tool='badger 65',coverage=.5,angle=0})

--@ chunk 3
wait(4320)
far=pile{{'lead white',5},{'cobalt blue',1},{'raw umber',.7},{'rose madder',.12},thinner=.18}
water=pile{{'lead white',6},{'smalt',1.1},{'raw umber',.9},{'Naples yellow',.5},thinner=.2}
near=pile{{'raw umber',3},{'bone black',1.8},{'cobalt blue',.7},{'red earth',.5},thinner=.15}
work(poly{{260,330},{300,290},{350,318},{400,310},{420,400},{260,400}},{pile=far,hand='broad',coverage=2,load=.8,clip=true,fill=true})
work(rect(440,330,190,65),{pile=water,hand='broad',coverage=2,load=.8,clip=true,fill=true,angle=0})
work(rect(300,420,300,65),{pile=near,hand='broad',coverage=2,load=.8,clip=true,fill=true,angle=0})

--@ chunk 4
wait(4320)
work(rect(220,125,450,140),{hand='broad',tool={kind='filbert',width=40,stiffness=.25},pile=cool,coverage=3,load=.8,clip=true,fill=true,angle=0,length={90,160},ruler=true,curve={0,0},drift={0,300}})
work(rect(265,330,150,60),{hand='broad',tool={kind='filbert',width=25,stiffness=.25},pile=far,coverage=3,load=.8,clip=true,fill=true,angle=0,length={60,100},ruler=true,curve={0,0},drift={0,300}})
work(rect(305,423,290,60),{hand='broad',tool={kind='filbert',width=25,stiffness=.25},pile=near,coverage=3,load=.8,clip=true,fill=true,angle=0,length={60,100},ruler=true,curve={0,0},drift={0,300}})

--@ chunk 5
stone=pile{{'raw umber',3},{'bone black',1},{'cobalt blue',.5},{'yellow ochre',.5},{'lead white',.6},thinner=.1}
work(rect(720,300,70,230),{hand='body',pile=stone,coverage=3,load=.8,clip=true,fill=true,tool={kind='filbert',width=14,stiffness=.25},angle=1.57,length={30,70}})

--@ chunk 6
wait(4320)
work(rect(330,150,70,200),{hand='body',pile=stone,coverage=3,load=.8,clip=true,fill=true,tool={kind='filbert',width=14,stiffness=.25},angle=1.57,length={30,70}})

--@ chunk 7
wait(4320)
lightstone=pile{{'raw umber',3},{'bone black',.6},{'cobalt blue',.7},{'lead white',1.6},{'yellow ochre',.5},thinner=.12}
shade=pile{{'raw umber',3},{'bone black',1.8},{'cobalt blue',.7},{'red earth',.5},thinner=.15}
b=brush{kind='flat',width=14,stiffness=.3};b:load(lightstone,.65);b:stroke({{341,188},{373,188}},{pressure=.65})
c=brush{kind='rigger',width=2,point=.8};c:load(shade,.7);c:stroke({{334,209},{359,210},{378,211}},{pressure=.55})

--@ chunk 8
cloud=pile{{'lead white',6},{'cobalt blue',1.3},{'raw umber',.8},{'bone black',.6},thinner=.65}
work(poly({{430,175},{480,165},{535,172},{580,168},{647,184},{652,201},{589,193},{531,199},{475,190},{429,193}},true):soften(9),{hand='glaze',tool='filbert 25',pile=cloud,coverage=1.3,load=.7,clip=true,angle=0,length={60,130},ruler=true})
midstone=mix{{stone,1},{lightstone,1}}
stipple(rect(331,178,65,48),{pile=midstone,width=1.2,coverage=.3,pressure={.15,.4},clip=true,dips={10,.5,.9},cluster=.15})

--@ chunk 9
cloud2=pile{{'lead white',6},{'cobalt blue',1.3},{'raw umber',.8},{'bone black',.6},thinner=.25}
work(poly({{430,175},{480,165},{535,172},{580,168},{647,184},{652,201},{589,193},{531,199},{475,190},{429,193}},true):soften(9),{hand='broad',tool={kind='filbert',width=25,stiffness=.25},pile=cloud2,coverage=2,load=.8,clip=true,angle=0,length={60,100},ruler=true,curve={0,0},drift={0,300}})
