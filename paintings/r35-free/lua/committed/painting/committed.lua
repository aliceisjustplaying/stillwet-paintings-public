-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{size=600, aspect=1.25, linen={18,20}, seed=741, ground={{pile={{'lead white',8},{'yellow ochre',1},{'red earth',0.4}},um=100,apply='knife',texture=0.12}}}
wall=pile{{'ultramarine blue',3},{'Indian red',2},{'bone black',1},name='aubergine wall'}
wallLight=pile{{'ultramarine blue',2},{'Indian red',1},{'lead white',2},name='wall dusk'}
tablePaint=pile{{'red earth',3},{'yellow ochre',2},{'lead white',1},name='warm table'}
clothPaint=pile{{'lead white',7},{'yellow ochre',0.6},{'ultramarine blue',0.25},name='linen light'}
blue=pile{{'Prussian blue',1},{'ultramarine blue',2},{'cerulean blue',2},name='jug blue'}
orange=pile{{'orange vermilion',3},{'cadmium yellow',2},{'red earth',0.3},name='persimmon'}

--@ chunk 2
tableShape=below({{0,532},{330,510},{710,526},{1000,502}})
clothShape=poly{{135,570},{356,539},{547,553},{736,603},{867,694},{957,800},{309,810},{287,698}}
jugShape=poly({{289,244},{318,271},{318,351},{271,407},{239,487},{254,567},{291,614},{401,631},{477,607},{505,553},{504,466},{464,392},{431,354},{437,273},{470,247},{407,229},{342,230}},true)
fruit1=poly({{607,540},{647,534},{688,550},{710,586},{699,620},{666,643},{621,637},{595,611},{588,576}},true)
fruit2=poly({{764,625},{802,618},{837,633},{858,665},{845,703},{815,720},{774,714},{741,686},{742,655}},true)
work(-tableShape,{hand='broad',piles={{wall,1},{wallLight,function(x,y) return 0.75*(1-x/1000) end}},coverage=3,tool='filbert 45',load=0.8,fill=true,clip=true,angle=1.45})
work(tableShape-clothShape,{hand='broad',pile=tablePaint,coverage=3,tool='filbert 35',load=0.8,fill=true,clip=true,angle=0.05})
work(clothShape,{hand='broad',pile=clothPaint,coverage=3,tool='filbert 30',load=0.8,fill=true,clip=true,angle=0.35})
wait(21*1440)
work(jugShape,{hand='body',pile=blue,coverage=3,tool='filbert 24',load=0.8,fill=true,clip=true,angle=1.4})
work(fruit1+fruit2,{hand='body',pile=orange,coverage=3,tool='filbert 18',load=0.8,fill=true,clip=true,angle=0.5})

--@ chunk 3
wait(21*1440)
print(drying(350,460),drying(600,710))
deep=pile{{'Prussian blue',2},{'ultramarine blue',1},{'bone black',1},name='blue shadow'}
lightBlue=pile{{'cerulean blue',3},{'lead white',2},{'ultramarine blue',1},name='blue light'}
clothShadow=pile{{'lead white',3},{'ultramarine blue',1},{'red earth',0.5},{'yellow ochre',0.6},name='fold shade'}
cast=pile{{'ultramarine blue',2},{'raw umber',2},{'lead white',2},name='cast shadow'}
handle=poly({{425,294},{498,286},{543,310},{562,359},{553,417},{526,461},{499,481},{483,444},{515,409},{528,365},{517,330},{489,318},{429,330}},true)
work(handle,{hand='body',pile=blue,coverage=3,tool='filbert 16',load=0.8,fill=true,clip=true})
shadow1=poly({{286,610},{391,599},{496,609},{598,659},{656,697},{550,703},{400,670},{307,642}},true)*clothShape-jugShape
work(shadow1,{hand='body',pile=cast,coverage=2.3,tool='filbert 20',load=0.8,clip=true,fill=true,angle=0.35})
work(poly({{609,618},{672,617},{748,658},{762,680},{700,675},{643,649}},true)*clothShape-fruit1-fruit2,{hand='body',pile=cast,coverage=2.3,tool='filbert 16',load=0.8,fill=true,clip=true,angle=0.3})
work(poly({{764,698},{824,699},{915,759},{860,763},{791,729}},true)*clothShape-fruit2,{hand='body',pile=cast,coverage=2.3,tool='filbert 16',load=0.8,fill=true,clip=true,angle=0.5})
work(poly{{289,699},{395,690},{552,720},{683,800},{311,800}},{hand='broad',pile=clothShadow,coverage=2.5,tool='filbert 24',load=0.8,fill=true,clip=true,angle=1.1})
work(poly{{529,554},{574,565},{714,657},{769,710},{945,800},{865,800},{716,727},{652,670}},{hand='body',pile=clothShadow,coverage=2.2,tool='filbert 20',load=0.8,fill=true,clip=true,angle=0.8})
b=brush{kind='filbert',width=38,lay=2}
b:load(lightBlue,0.85)
b:gesture({{331,395,.35},{297,435,.8},{283,489,.9},{289,534,.6},{310,566,.1}},{clip=jugShape})

--@ chunk 4
wait(21*1440)
midBlue=pile{{'cerulean blue',3},{'ultramarine blue',2},{'Prussian blue',0.6},{'lead white',0.6},name='blue middle'}
work(jugShape,{hand='body',piles={{lightBlue,function(x,y) return 1.6*math.exp(-((x-315)/57)^2) end},{midBlue,0.7},{blue,function(x,y) return 0.7+math.max(0,x-360)/65 end},{deep,function(x,y) return math.max(0,x-425)/45 end}},tool={kind='filbert',width=19,lay=2},coverage=2.5,load=0.8,fill=true,clip=true,angle=1.65})
work(fruit1,{hand='body',pile=orange,tool={kind='filbert',width=18,lay=2},coverage=3,load=0.85,fill=true,clip=true,angle=0.5})
-- open elliptical mouth, not an outline around the entire jug
work(ellipse(379,245,85,13),{hand='body',pile=deep,tool='filbert 10',coverage=3,load=0.8,fill=true,clip=true,angle=0})
s=brush{kind='filbert',width=15,lay=2}
s:load(midBlue,.8);s:gesture({{440,303,.5},{482,297,.8},{518,312,.8},{537,343,.45}})
s:reload(deep,.8);s:gesture({{548,352,.35},{546,391,.7},{530,425,.8},{501,453,.3}})
-- fruit modelling trial on right fruit
redShade=pile{{'red earth',2},{'Chinese vermilion',2},{'permanent alizarin',0.5},name='fruit shadow'}
f=brush{kind='filbert',width=24,lay=1.5}
f:load(redShade,.75);f:gesture({{829,648,.2},{845,670,.7},{830,694,.85},{797,706,.6},{768,693,.15}},{clip=fruit2})

--@ chunk 5
wait(21*1440)
gold=pile{{'cadmium yellow',3},{'orange vermilion',2},{'lead-tin yellow',1},name='fruit light'}
work(fruit1,{hand='body',piles={{gold,function(x,y) return 2*math.exp(-((x-617)/44)^2-((y-559)/44)^2) end},{orange,1},{redShade,function(x,y) return math.max(0,(x-625)/55+(y-577)/39) end}},tool={kind='filbert',width=13,lay=2},coverage=2.8,load=0.8,fill=true,clip=true,angle=0.65})
-- soften jug's still-open texture only in its existing silhouette
-- dry now: fresh middle glancing strokes rather than a blender
j=brush{kind='filbert',width=27,lay=1}
j:load(midBlue,.55);j:gesture({{341,271,.5},{335,326,.7},{331,361,.2}},{clip=jugShape})
j:reload(midBlue,.5);j:gesture({{330,402,.2},{312,451,.65},{309,510,.55},{332,562,.15}},{clip=jugShape})
-- single pale reflection trial, deliberately narrower than first one
shine=pile{{'lead white',5},{'cerulean blue',2},name='window reflected'}
j=brush{kind='filbert',width=12,lay=3,ragged=.3}
j:load(shine,.7);j:gesture({{304,416,.2},{288,448,.6},{280,480,.65},{281,505,.05}},{clip=jugShape})

--@ chunk 6
blend(fruit1,{tool='badger 20',coverage=0.7,angle=0.9})
work(fruit2,{hand='body',piles={{gold,function(x,y) return 2*math.exp(-((x-773)/40)^2-((y-643)/39)^2) end},{orange,1},{redShade,function(x,y) return math.max(0,(x-782)/45+(y-663)/33) end}},tool={kind='filbert',width=13,lay=2},coverage=2.8,load=0.8,fill=true,clip=true,angle=0.7})
blend(fruit2,{tool='badger 20',coverage=0.7,angle=0.7})
-- lift unwanted middle-blue stripes while open, preserving dry modeled blue underneath
r=rag{width=25}
r:dip(.8);r:wipe({{335,278},{332,319},{331,345}},{pressure=.9})
r:refold();r:dip(.8);r:wipe({{320,414},{310,451},{309,504},{327,549}},{pressure=.9})

--@ chunk 7
wait(21*1440)
work(jugShape,{hand='body',piles={{lightBlue,function(x,y) return 1.6*math.exp(-((x-315)/57)^2) end},{midBlue,0.7},{blue,function(x,y) return 0.7+math.max(0,x-360)/65 end},{deep,function(x,y) return math.max(0,x-425)/45 end}},tool={kind='filbert',width=23,lay=2},coverage=2.5,load=0.8,fill=true,clip=true,angle=1.65})
blend(jugShape,{tool='badger 40',coverage=2,angle=1.5})
work(handle-jugShape,{hand='body',piles={{midBlue,function(x,y) return math.max(.05,(375-y)/40) end},{blue,1},{deep,function(x,y) return math.max(.05,(y-350)/40) end}},tool={kind='filbert',width=12,lay=2},coverage=2.5,load=.8,fill=true,clip=true,angle=1.3})
blend(handle-jugShape,{tool='badger 18',coverage=1.5,angle=1.3})
-- quiet the cloth with cream-tinted planes, kept clear of objects
creamWarm=pile{{'lead white',8},{'Naples yellow',1},{'yellow ochre',.25},name='linen lit'}
creamCool=pile{{'lead white',6},{'ultramarine blue',.3},{'raw umber',.25},name='linen half-light'}
work(poly{{145,572},{257,573},{284,627},{379,659},{480,687},{390,690},{289,700}}-jugShape,{hand='body',piles={{creamWarm,1},{clothPaint,1}},tool={kind='filbert',width=25,lay=1.5},coverage=2,load=.75,clip=true,fill=true,angle=.5})
work(poly{{535,558},{628,615},{719,686},{882,787},{851,780},{694,709},{642,667}}-fruit1-fruit2,{hand='body',pile=creamCool,tool='filbert 19',coverage=2.5,load=.8,clip=true,fill=true,angle=.7})
-- a lifted cloth ridge descending toward the viewer
c=brush{kind='filbert',width=23,lay=2}
c:load(creamWarm,.8);c:gesture({{399,698,.4},{442,714,.85},{490,754,.8},{514,797,.5}},{clip=clothShape})

--@ chunk 8
wait(21*1440)
-- lower hanging linen: one connected plane, crest contained within it
lower=poly{{289,700},{396,691},{550,719},{683,800},{309,800}}
work(lower,{hand='broad',piles={{clothShadow,1},{creamCool,function(x,y) local crest=401+(y-700)*.95; return 2.5*math.exp(-((x-crest)/45)^2) end}},tool='filbert 27',coverage=2.6,load=.8,clip=true,fill=true,angle=1.0})
blend(lower,{tool='badger 30',coverage=1.5,angle=1.0})
-- mouth on dry blue, left lip thrusting a little forward
mouth=poly({{294,245},{328,237},{382,234},{426,238},{462,247},{425,253},{365,251},{318,251}},true)
work(mouth,{hand='body',pile=deep,tool='filbert 8',coverage=3,load=.8,clip=true,fill=true,angle=0})
lip=brush{kind='round',width=5,point=.5,lay=2}
lip:load(lightBlue,.8);lip:gesture({{291,245,.2},{316,253,.7},{357,258,.7},{400,258,.5},{446,251,.05}})
-- cooler, irregular window reflections
work(poly{{332,273},{350,277},{349,308},{342,330},{328,326}},{hand='body',pile=lightBlue,tool='filbert 9',coverage=2,load=.65,clip=true,fill=true,angle=1.5})
work(poly({{297,411},{307,417},{296,440},{288,478},{279,486},{279,459},{285,433}},true),{hand='body',pile=lightBlue,tool='filbert 9',coverage=2,load=.65,clip=true,fill=true,angle=1.8})
z=brush{kind='round',width=5,point=1,lay=3}
z:load(shine,.8);z:gesture({{299,417,.1},{290,437,.75},{284,456,.1}})
z:reload(shine,.7);z:gesture({{332,278,.1},{331,296,.65},{331,311,.1}})
z:reload(lightBlue,.7);z:gesture({{467,292,.1},{493,298,.6},{516,314,.4},{523,325,0}})
-- dark contacts, narrow enough not to outline objects
contact=pile{{'ultramarine blue',2},{'raw umber',1},{'bone black',.5},name='contact'}
a=brush{kind='filbert',width=9,lay=1}
a:load(contact,.7);a:gesture({{296,619,.1},{330,629,.55},{387,633,.7},{439,621,.3},{456,616,0}})
a:reload(contact,.7);a:gesture({{618,636,.1},{646,644,.6},{674,638,.15}})
a:reload(contact,.7);a:gesture({{776,714,.1},{801,722,.6},{831,713,.1}})
-- calyx on the first persimmon: a trial of broad olive leaves
olive=pile{{'raw umber',2},{'yellow ochre',1},{'viridian',.5},name='dry calyx'}
leaf=brush{kind='filbert',width=12,point=.7,lay=2}
leaf:load(olive,.8);leaf:gesture({{630,551,.3},{616,546,.8},{609,532,0}})
leaf:reload(olive,.8);leaf:gesture({{630,551,.3},{640,542,.8},{656,543,0}})
leaf:reload(olive,.8);leaf:gesture({{630,551,.5},{625,562,.7},{618,566,0}})
leaf:reload(olive,.8);leaf:gesture({{631,551,.4},{644,556,.8},{651,566,0}})

--@ chunk 9
wait(21*1440)
a=brush{kind='filbert',width=9,lay=1.5}
a:load(cast,.8);a:gesture({{615,646,.4},{641,650,.8},{666,646,.7},{680,639,.1}})
-- second calyx drawn separately and in a different attitude
leaf:reload(olive,.8);leaf:gesture({{784,636,.5},{770,633,.9},{758,639,0}})
leaf:reload(olive,.8);leaf:gesture({{784,636,.4},{781,625,.7},{791,619,0}})
leaf:reload(olive,.8);leaf:gesture({{784,638,.5},{800,640,.85},{805,649,0}})
leaf:reload(olive,.8);leaf:gesture({{782,638,.4},{779,650,.8},{768,657,0}})
leafLight=pile{{'yellow ochre',2},{'lead white',1},{'raw umber',1},{'viridian',.25},name='calyx fold'}
t=brush{kind='filbert',width=5,point=.7,lay=2}
t:load(leafLight,.7);t:gesture({{612,540,.1},{619,548,.7},{629,550,.05}})
t:reload(leafLight,.7);t:gesture({{634,547,.2},{641,544,.7},{650,544,0}})
t:reload(leafLight,.7);t:gesture({{763,637,.1},{774,635,.7},{782,637,.1}})
t:reload(leafLight,.7);t:gesture({{784,630,.1},{785,625,.7},{790,623,.1}})
stem=pile{{'raw umber',2},{'bone black',.5},name='stems'}
t:reload(stem,.8);t:gesture({{630,552,.7},{633,542,.5},{631,536,.1}})
t:reload(stem,.8);t:gesture({{784,637,.7},{789,632,.5},{789,628,.1}})
-- small warm light on the waxy fruit, a laid trial
fruitShine=pile{{'lead-tin yellow',3},{'cadmium yellow',1},{'orange vermilion',.7},name='waxy gold'}
g=brush{kind='filbert',width=12,lay=2}
g:load(fruitShine,.6);g:gesture({{606,566,.2},{607,577,.6},{604,585,.1}},{clip=fruit1})

--@ chunk 10
wait(21*1440)
firstShadow=poly({{609,625},{656,621},{691,632},{733,655},{759,679},{722,681},{679,663},{637,656},{611,651}},true)-fruit1-fruit2
work(firstShadow,{hand='body',piles={{cast,function(x,y) return 1.7-math.min(1,(x-620)/150) end},{creamCool,.45}},tool={kind='filbert',width=13,lay=2},coverage=3,load=.8,clip=true,fill=true,angle=.4})
blend(firstShadow,{tool='badger 18',coverage=2,angle=.4})

--@ chunk 11
secondShadow=poly({{770,705},{814,700},{852,722},{905,753},{920,764},{878,766},{823,742},{783,729},{766,724}},true)-fruit2
work(secondShadow,{hand='body',piles={{cast,function(x,y) return 1.7-math.min(1,(x-780)/150) end},{creamCool,.45}},tool={kind='filbert',width=13,lay=2},coverage=3,load=.8,clip=true,fill=true,angle=.5})
blend(secondShadow,{tool='badger 18',coverage=2,angle=.5})
softGold=mix{{fruitShine,1},{orange,2},name='quiet wax light'}
g:reload(softGold,.6);g:gesture({{758,658,.1},{757,669,.55},{760,676,.1}},{clip=fruit2})
