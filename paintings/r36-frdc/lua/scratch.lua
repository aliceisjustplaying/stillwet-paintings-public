-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 1}, {"yellow ochre", 2}, {"lead white", 3}}, texture=0.12, um=45}, {apply="roller", pile={{"lead white", 12}, {"raw umber", 0.3}, {"yellow ochre", 0.25}}, texture=0.1, um=40}}, linen={16, 17}, seed=41, size=700}

--@ chunk 2
cool=pile{{'lead white',7},{'cobalt blue',1.1},{'raw umber',.45},{'bone black',.15},thinner=.25}
cloud=pile{{'lead white',6},{'cobalt blue',1.3},{'raw umber',.8},{'bone black',.6},thinner=.25}
work(rect(100,70,800,260),{hand='broad',tool={kind='filbert',width=40,stiffness=.25},pile=cool,coverage=3,load=.8,clip=true,fill=true,angle=0,length={90,160},ruler=true,curve={0,0},drift={0,300}})
work(poly({{80,165},{210,160},{305,174},{436,167},{565,187},{740,201},{900,196},{905,220},{780,218},{640,212},{483,213},{391,193},{234,202},{98,193}},true):soften(20),{hand='broad',tool={kind='filbert',width=25,stiffness=.25},pile=cloud,coverage=1.2,load=.65,clip=true,angle=0,length={60,100},ruler=true,curve={0,0},drift={0,300}})
blend(rect(110,100,780,200),{tool='badger 45',coverage=1,angle=0})

--@ chunk 3
wait(4320)
cloudveil=pile{{'lead white',6},{'cobalt blue',1.3},{'raw umber',.8},{'bone black',.6},thinner=.45}
stipple(poly({{180,229},{280,215},{420,226},{535,222},{690,244},{806,253},{815,268},{681,261},{517,258},{365,250},{259,253},{170,246}},true):soften(16),{pile=cloudveil,width=2.5,coverage=.8,pressure={.2,.5},feather=1,clip=true,dips={12,.6,.95}})
