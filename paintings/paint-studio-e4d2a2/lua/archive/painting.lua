-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{size=480,aspect=1.25,linen={16,18},seed=721,ground={{pile={{'lead white',8},{'yellow ochre',1},{'red earth',0.3}},um=85,apply='knife',texture=0.12}}}
bg=pile{{'viridian',3},{'Prussian blue',1},{'raw umber',1},name='deep teal'}
wall=pile{{'viridian',3},{'cerulean blue',2},{'lead white',1},{'yellow ochre',0.4},name='wall green'}
tablepaint=pile{{'red earth',3},{'vermilion',2},{'lead white',2},{'yellow ochre',1},name='terracotta'}
print('prepared')

--@ chunk 2
work(everywhere(),{hand='broad',pile=bg,tool='filbert 60',coverage=2,load=0.85,fill=true,clip=true,angle=1.5})
work(poly{{0,0},{535,0},{480,480},{0,515}},{hand='broad',pile=wall,tool='filbert 55',coverage=1.6,load=0.85,fill=true,clip=true,angle=1.5})
top=poly{{0,502},{1000,450},{1000,800},{0,800}}
work(top,{hand='broad',pile=tablepaint,tool='filbert 55',coverage=2,load=0.85,fill=true,clip=true,angle=0.1})
