-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box giverny
--@ engine 5

--@ chunk 1
canvas{aspect=1.38, ground={{apply="knife", pile={{"lead white", 1}, {"yellow ochre", 0.025}}, texture=0.12, um=100}, {apply="brush", pile={{"lead white", 1}, {"cobalt blue", 0.015}, {"cobalt violet", 0.02}}, um=65}}, linen={18, 20}, seed=418, size=1100}

--@ chunk 2
blue=pile{{'cobalt blue',3},{'ultramarine blue',1},{'lead white',3},{'viridian',.35},turps=.25};mauve=pile{{'cobalt violet',3},{'cobalt blue',1},{'rose madder',.55},{'lead white',4},turps=.25};work(rect(50,80,400,300),{hand='broad',pile=blue,coverage=3,fill=true});work(rect(50,80,400,300),{hand='body',pile=mauve,coverage=.7,angle=0});wait(7*24*60);leafdark=pile{{'viridian',3},{'ultramarine blue',1},{'rose madder',.6},{'barium yellow',.4},{'lead white',.25},blot=.1};olive=pile{{'viridian',2},{'barium yellow',3},{'yellow ochre',1},{'lead white',1},{'cobalt blue',.3},blot=.2};leaf=brush{kind='filbert',width=22,lay=2};leaf:load(leafdark,.75);leaf:gesture({{110,195,.4},{135,187,.8},{159,194,.5}},{orient=0,wobble=2});leaf:reload(olive,.65);leaf:gesture({{111,190,.35},{132,182,.75},{153,190,.3}},{orient=0,wobble=1});twig=brush{kind='round',width=9,point=.65};twig:load(leafdark,.65);twig:gesture({{325,110,.5},{308,158,.85},{333,202,.4},{314,251,.1}},{wobble=3});

--@ chunk 3
pink=pile{{'lead white',3},{'rose madder',2},{'vermilion',.6},{'cobalt violet',1},blot=.25};cream=pile{{'lead white',8},{'barium yellow',.6},{'vermilion',.1},{'rose madder',.2},blot=.25};petal=brush{kind='round',width=7,point=.7,lay=5};petal:load(pink,.8);petal:gesture({{134,181,.8},{122,173,.5},{118,164,.05}});petal:reload(pink,.8);petal:gesture({{134,181,.8},{130,165,.5},{132,156,.02}});petal:reload(cream,.8);petal:gesture({{135,178,.8},{142,168,.6},{150,165,.03}});petal:reload(cream,.8);petal:gesture({{132,176,.7},{129,166,.3},{130,158,.01}});

--@ chunk 4
veil=pile{{'cobalt blue',2},{'cobalt violet',1},{'ultramarine blue',.4},{'lead white',.7},medium=.55};work(rect(207,92,215,210):soften(15),{hand='glaze',pile=veil,tool='filbert 26',load=.4,coverage=1.1,length={70,130},angle=.1,clip=true});

--@ chunk 5
wash=pile{{'cobalt blue',2},{'cobalt violet',1},{'ultramarine blue',.4},medium=.15,thinner=.8};work(rect(65,243,135,121):soften(10),{hand='glaze',pile=wash,tool='filbert 24',load=.25,coverage=1.6,length={45,85},angle=.03,clip=true});

--@ chunk 6
mid=mix{{blue,3},{mauve,2}};work(rect(60,80,128,123),{hand='body',pile=mid,tool='filbert 18',load=.65,coverage=2.8,fill=true,length={25,58},angle=.05,clip=true});rose=pile{{'lead white',3},{'cobalt violet',2},{'rose madder',.65},{'vermilion',.15},blot=.15};work(rect(60,80,128,123),{hand='body',pile=rose,tool='filbert 7',load=.24,dips={3,.24,.95},coverage=.7,length={18,44},angle=.03,clip=true});blend(rect(60,80,128,123),{tool='badger 30',coverage=.75,angle=.05});

--@ chunk 7
light=pile{{'lead white',7},{'cobalt violet',.65},{'yellow ochre',.35},{'vermilion',.15},turps=.25};work(poly({{100,75},{147,75},{138,140},{157,204},{104,209},{125,146}},true),{hand='body',pile=light,tool='filbert 15',load=.55,coverage=1.3,length={25,48},angle=1.5,edge='soft'});blend(rect(65,82,122,120),{tool='badger 30',coverage=1,angle=1.5});

--@ chunk 8
glow=mix{{mid,1},{light,1}};work(rect(80,80,82,128),{hand='body',pile=glow,tool='filbert 18',load=.4,coverage=1.7,length={24,55},angle=1.5});blend(rect(67,81,120,120),{tool='badger 30',coverage=1.5,angle=1.5});
