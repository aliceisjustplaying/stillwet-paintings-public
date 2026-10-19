-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.25, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 1}, {"red earth", 0.4}}, texture=0.12, um=100}}, linen={18, 20}, seed=741, size=600}

--@ chunk 2
blue=pile{{'Prussian blue',1},{'ultramarine blue',2},{'cerulean blue',2}}
lightBlue=pile{{'cerulean blue',3},{'lead white',2},{'ultramarine blue',1}}
midBlue=pile{{'cerulean blue',3},{'ultramarine blue',2},{'Prussian blue',0.6},{'lead white',0.6}}
deep=pile{{'Prussian blue',2},{'ultramarine blue',1},{'bone black',1}}
m=ellipse(365,470,125,160)
work(m,{pile=blue,tool='filbert 24',coverage=3,load=.8,clip=true,fill=true})
wait(21*1440)
work(m,{hand='body',piles={{lightBlue,function(x,y) return 1.6*math.exp(-((x-315)/57)^2) end},{midBlue,.7},{blue,function(x,y) return .7+math.max(0,x-360)/65 end},{deep,function(x,y) return math.max(0,x-425)/45 end}},tool={kind='filbert',width=23,lay=2},coverage=2.5,load=.8,clip=true,fill=true,angle=1.65})
blend(m,{tool='badger 40',coverage=2,angle=1.5})
