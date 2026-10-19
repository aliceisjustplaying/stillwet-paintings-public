-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box giverny
--@ engine 5

--@ chunk 1
canvas{size=1100,aspect=1.38,linen={18,20},seed=418,ground={{pile={{'lead white',1},{'yellow ochre',0.025}},um=100,apply='knife',texture=0.12},{pile={{'lead white',1},{'cobalt blue',0.015},{'cobalt violet',0.02}},um=65,apply='brush'}}}

--@ chunk 2
blue=pile{{'cobalt blue',3},{'ultramarine blue',1},{'lead white',3},{'viridian',0.35},turps=0.25}; mauve=pile{{'cobalt violet',3},{'cobalt blue',1},{'rose madder',0.55},{'lead white',4},turps=0.25}; green=pile{{'viridian',3},{'ultramarine blue',2},{'cobalt blue',1},{'yellow ochre',0.5},{'lead white',0.7},turps=0.25}; light=pile{{'lead white',7},{'cobalt violet',0.65},{'yellow ochre',0.35},{'vermilion',0.15},turps=0.25}; work(everywhere(),{hand='broad',pile=blue,tool='filbert 42',coverage=2.8,fill=true,load=.8,length={90,180},angle=1.5}); opening=poly({{435,-30},{695,-20},{754,95},{635,206},{650,287},{549,378},{573,457},{489,548},{500,616},{405,690},{244,748},{180,670},{312,572},{327,494},{426,398},{403,316},{506,203},{463,128}},true); work(opening:soften(30),{hand='broad',pile=mauve,tool='filbert 38',coverage=2.1,load=.8,length={60,150},angle=1.7,edge='soft'}); gleam=poly({{497,-20},{686,-10},{680,105},{565,218},{581,284},{489,370},{460,458},{394,541},{334,582},{351,480},{402,394},{399,328},{485,199},{464,107}},true);work(gleam:soften(30),{hand='broad',pile=light,tool='filbert 32',coverage=1.4,load=.8,length={55,130},angle=1.65,edge='soft'}); left=poly({{-30,-30},{439,-20},{395,99},{342,141},{357,222},{292,260},{261,355},{152,384},{84,342},{-30,454}},true); right=poly({{812,-30},{1030,-30},{1030,578},{952,522},{928,409},{838,389},{794,297},{746,268},{760,177},{730,131}},true); work(left+right,{hand='broad',pile=green,tool='filbert 38',coverage=2,load=.8,length={65,150},angle=1.45,edge='soft'}); work(poly({{-30,570},{112,518},{205,563},{322,628},{405,742},{-30,760}},true),{hand='broad',pile=mauve,tool='filbert 30',coverage=1.2,load=.7,length={60,130},angle=.1,edge='soft'});

--@ chunk 3
wait(7*24*60); plum=pile{{'ultramarine blue',3},{'cobalt violet',2},{'rose madder',1},{'viridian',.45},blot=.15}; jade=pile{{'viridian',3},{'barium yellow',1.2},{'lead white',1.1},{'cobalt blue',.5},blot=.15}; rose=pile{{'lead white',3},{'cobalt violet',2},{'rose madder',.65},{'vermilion',.15},blot=.15}; work((left+right):shrink(25),{hand='body',pile=plum,tool='filbert 18',coverage=.7,load=.42,length={24,74},angle=1.5,edge='loose'}); work(left+right,{hand='body',pile=green,tool='filbert 19',coverage=.9,load=.55,length={25,66},angle=1.35,edge='loose'});work(poly({{-20,-20},{408,-20},{365,100},{272,135},{256,232},{135,277},{-20,368}},true),{hand='scumble',pile=jade,tool={kind='filbert',width=12,stiffness=.9,hair=.85},coverage=.65,dips={3,.23,.95},length={18,40},angle=1.3,edge='loose'});work(poly({{856,-20},{1020,-20},{1015,465},{950,408},{901,272},{820,212},{800,106}},true),{hand='scumble',pile=jade,tool={kind='filbert',width=12,stiffness=.9,hair=.85},coverage=.42,dips={3,.23,.95},length={18,40},angle=1.7,edge='loose'}); work(poly({{589,308},{712,330},{815,452},{945,569},{1016,695},{812,750},{543,726},{470,657},{610,572},{533,465}},true):soften(25),{hand='body',pile=mauve,tool='filbert 25',coverage=1.0,load=.55,length={45,105},angle=.05,edge='loose'});work(poly({{599,360},{703,392},{783,472},{761,520},{624,506},{546,582},{443,603},{461,546},{540,480}},true):soften(20),{hand='body',pile=rose,tool='filbert 18',coverage=.7,load=.45,length={35,75},angle=.02,edge='loose'}); work(gleam:grow(15),{hand='body',pile=mauve,tool='filbert 20',coverage=.6,load=.45,length={35,85},angle=.05,edge='loose'});work(gleam:shrink(15),{hand='body',pile=light,tool='filbert 17',coverage=.5,load=.45,length={25,65},angle=.02,edge='loose'});

--@ chunk 4
blend(rect(651,573,165,130):soften(22),{tool='badger 36',coverage=.9,angle=.2}); work(rect(662,585,145,109):soften(22),{hand='body',pile=blue,tool='filbert 10',load=.28,dips={3,.28,.9},coverage=.65,length={20,53},angle=.05,edge='soft'});

--@ chunk 5
local rightwater=poly({{580,285},{729,333},{851,456},{948,538},{1030,582},{1030,760},{427,760},{406,653},{517,562},{481,473}},true):soften(28); work(rightwater,{hand='body',pile=blue,tool='filbert 10',load=.28,dips={3,.28,.9},coverage=1.65,length={20,53},angle=.03,edge='soft'}); work(poly({{-20,345},{189,393},{348,305},{423,344},{345,514},{319,614},{150,598},{-20,638}},true):soften(24),{hand='body',pile=mauve,tool='filbert 10',load=.28,dips={3,.28,.9},coverage=.75,length={20,53},angle=.03,edge='soft'}); work(poly({{498,-20},{700,-20},{752,108},{662,236},{626,327},{533,396},{415,540},{306,663},{237,667},{366,463},{424,372},{450,270},{500,172}},true):soften(24),{hand='body',pile=mauve,tool='filbert 12',load=.28,dips={3,.28,.9},coverage=.7,length={20,53},angle=.05,edge='soft'});

--@ chunk 6
wait(7*24*60);leafdark=pile{{'viridian',3},{'ultramarine blue',1},{'rose madder',.6},{'barium yellow',.4},{'lead white',.25},blot=.1};olive=pile{{'viridian',2},{'barium yellow',3},{'yellow ochre',1},{'lead white',1},{'cobalt blue',.3},blot=.2}; twig=brush{kind='round',width=9,point=.65}; function branch(points) twig:reload(leafdark,.6);twig:gesture(points,{wobble=2.2});end; branch({{86,-12,.8},{102,64,.55},{78,112,.6},{96,169,.2}});branch({{119,101,.65},{152,164,.7},{149,220,.3},{177,292,.08}});branch({{285,-10,.65},{261,60,.8},{267,104,.3},{241,166,.05}});branch({{219,165,.6},{199,202,.65},{218,248,.35},{191,338,.03}});branch({{333,82,.5},{307,146,.7},{321,190,.25},{298,234,.05}});branch({{45,216,.8},{68,247,.7},{57,303,.25},{30,358,.1}});branch({{917,-12,.65},{889,56,.8},{899,118,.4},{859,188,.05}});branch({{814,107,.4},{831,159,.75},{824,212,.35},{860,265,.06}});branch({{937,183,.6},{918,248,.8},{945,290,.2},{934,348,.03}});branch({{982,317,.8},{950,366,.6},{974,421,.3},{965,486,.05}}); raft1=poly({{-25,569},{58,540},{117,551},{167,511},{205,530},{246,515},{301,539},{340,560},{288,581},{263,619},{193,603},{144,647},{75,632},{18,669},{-30,634}},true);raft2=poly({{551,427},{608,402},{658,378},{700,369},{736,344},{784,368},{825,359},{870,392},{846,419},{786,427},{755,456},{691,443},{638,465},{595,453}},true);work(raft1+raft2,{hand='body',pile=leafdark,tool='filbert 14',load=.6,coverage=1.1,length={24,51},angle=.04,edge='soft'}); leaf=brush{kind='filbert',width=22,lay=2};function pad(x,y,w,p) leaf=brush{kind='filbert',width=w*.40,lay=2};leaf:load(p,.65);leaf:gesture({{x-w*.44,y,.35},{x-w*.1,y-w*.08,.8},{x+w*.38,y-w*.02,.38}},{orient=0,wobble=1.3});end;pad(92,574,57,olive);pad(173,548,48,jade);pad(220,576,58,olive);pad(127,613,62,jade);pad(620,426,43,jade);pad(688,402,45,olive);pad(765,386,45,jade);pad(799,418,49,olive);

--@ chunk 7
work(rect(63,79,91,101):soften(12),{hand='body',pile=green,second={pile=jade,load=.25,side=1,share=.5},tool={kind='filbert',width=5,lay=3,stiffness=.85},coverage=1.25,load=.45,length={12,29},angle=1.3,edge='soft'}); leaf=brush{kind='filbert',width=19,lay=2};leaf:load(jade,.6);leaf:load(olive,.22,{side=1,share=.4});leaf:gesture({{649,438,.45},{664,434,.9},{682,438,.6}},{wobble=1});

--@ chunk 8
work((left+right)-rect(63,79,91,101):soften(12),{hand='body',pile=green,second={pile=jade,load=.25,side=1,share=.5},tool={kind='filbert',width=5,lay=3,stiffness=.85},coverage=.85,load=.45,length={12,29},angle=1.4,angle_jitter=.6,edge='loose'}); function broadpad(x,y,w,p,q) local b=brush{kind='filbert',width=w*.43,lay=2};b:load(p,.6);if q then b:load(q,.22,{side=1,share=.4}) end;b:gesture({{x-w*.42,y,.45},{x-w*.07,y-w*.07,.9},{x+w*.34,y-w*.015,.55}},{wobble=1.3});end;local a={{3,581,54},{45,565,48},{78,552,35},{124,568,44},{151,536,42},{198,532,43},{244,536,41},{272,552,51},{307,565,38},{251,588,58},{210,604,53},{168,596,49},{79,601,60},{35,611,51},{4,640,56},{53,644,51},{107,632,48},{149,625,48},{183,571,41},{31,586,42},{265,614,38},{287,582,40},{333,559,26}};for i,v in ipairs(a) do local p=jade;if i%3==0 then p=olive elseif i%5==0 then p=mauve end;broadpad(v[1],v[2],v[3],p,i%2==0 and olive or green);end;local c={{572,434,32},{607,416,42},{635,408,34},{659,390,39},{701,384,44},{735,368,36},{786,365,36},{827,380,39},{862,392,34},{837,411,43},{787,407,42},{756,427,44},{722,445,43},{688,437,40},{636,453,40},{599,447,33},{733,403,46},{710,416,31},{805,432,37},{665,417,31},{767,448,29},{795,388,29}};for i,v in ipairs(c) do local p=jade;if i%3==0 then p=olive elseif i%6==1 then p=mauve end;broadpad(v[1],v[2],v[3],p,i%2==0 and olive or green);end;

--@ chunk 9
blend(rect(71,75,126,155):soften(18),{tool='badger 45',coverage=3,angle=1.5});

--@ chunk 10
blend((left+right)-rect(80,90,100,120):soften(16),{tool='badger 45',coverage=1.9,angle=1.5}); bwater=brush{kind='filbert',width=12}; function ripple(p,pts) bwater:reload(p,.34);bwater:gesture(pts,{wobble=1.6});end;ripple(blue,{{18,269,.2},{55,268,.6},{86,273,.1}});ripple(mauve,{{84,311,.2},{124,307,.6},{157,312,.1}});ripple(blue,{{177,258,.15},{221,262,.6},{272,259,.08}});ripple(blue,{{267,202,.2},{298,197,.65},{340,199,.1}});ripple(mauve,{{298,137,.15},{329,130,.5},{362,132,.1}});ripple(blue,{{11,369,.2},{51,365,.7},{93,369,.1}});ripple(blue,{{784,175,.15},{818,173,.7},{848,176,.1}});ripple(mauve,{{863,262,.1},{903,258,.6},{927,261,.15}});ripple(blue,{{927,348,.2},{960,344,.7},{1006,349,.1}});ripple(mauve,{{899,441,.15},{935,437,.65},{967,442,.1}});ripple(blue,{{971,518,.5},{1007,521,.15}});

--@ chunk 11
work(poly({{920,38},{959,15},{973,90},{952,137},{926,166},{914,114}},true):soften(12),{hand='body',pile=plum,tool='filbert 10',load=.25,dips={3,.25,.9},coverage=.85,length={22,48},angle=1.5,edge='soft'}); work(poly({{253,23},{287,37},{289,97},{271,146},{244,114},{237,67}},true):soften(10),{hand='body',pile=olive,tool='filbert 9',load=.23,dips={3,.23,.9},coverage=.65,length={18,40},angle=1.55,edge='soft'});

--@ chunk 12
local purple=poly({{795,-20},{832,-20},{814,66},{851,141},{833,213},{859,299},{836,329},{807,243},{805,177},{779,122}},true)+poly({{1005,137},{963,182},{981,240},{950,303},{978,355},{960,417},{985,482},{1020,511}},true)+poly({{901,-20},{927,-20},{909,35},{925,72},{897,112},{875,146},{869,122},{896,60}},true);work(purple:soften(10),{hand='body',pile=plum,tool='filbert 10',load=.25,dips={3,.25,.9},coverage=.85,length={22,48},angle=1.5,edge='soft'});local gold=poly({{25,-20},{88,-20},{85,44},{113,89},{93,137},{110,188},{74,211},{46,177},{71,132},{48,81}},true)+poly({{144,129},{183,150},{169,191},{193,233},{166,287},{131,311},{112,287},{149,230},{138,196}},true)+poly({{355,-20},{397,-20},{399,32},{362,65},{350,128},{322,159},{305,146},{322,77}},true);work(gold:soften(12),{hand='body',pile=olive,tool='filbert 9',load=.23,dips={3,.23,.9},coverage=.65,length={18,40},angle=1.55,edge='soft'});local tops={{10,575,56},{55,592,53},{112,588,46},{156,563,45},{230,553,49},{279,567,48},{229,598,54},{177,616,45},{30,624,59},{88,622,45},{590,430,43},{646,427,44},{677,410,41},{713,394,43},{768,396,44},{818,396,43},{795,445,35},{704,432,49},{626,444,43}};for i,v in ipairs(tops) do broadpad(v[1],v[2],v[3],i%4==0 and olive or jade, i%3==0 and mauve or olive);end; bwater=brush{kind='filbert',width=7};ripple(mauve,{{0,659,.5},{31,654,.8},{68,656,.1}});ripple(blue,{{162,639,.3},{197,633,.7},{221,635,.1}});ripple(mauve,{{265,625,.2},{294,618,.8},{321,620,.08}});ripple(rose,{{573,453,.2},{603,455,.6},{624,452,.1}});ripple(mauve,{{688,469,.2},{720,465,.7},{751,467,.1}});ripple(blue,{{824,436,.2},{857,432,.8},{875,435,.1}});

--@ chunk 13
pink=pile{{'lead white',3},{'rose madder',2},{'vermilion',.6},{'cobalt violet',1},blot=.25};cream=pile{{'lead white',8},{'barium yellow',.6},{'vermilion',.1},{'rose madder',.2},blot=.25};wine=pile{{'rose madder',2},{'carmine lake',1},{'cobalt violet',1},{'vermilion',.5},{'lead white',1},blot=.15};petal=brush{kind='round',width=7,point=.7,lay=5};function pet(p,pts) petal:reload(p,.8);petal:gesture(pts,{wobble=.5});end;pet(wine,{{674,395,.4},{685,398,.9},{698,396,.15}});pet(pink,{{684,397,.8},{674,389,.6},{670,381,.03}});pet(pink,{{685,397,.8},{681,383,.7},{685,374,.02}});pet(pink,{{687,397,.85},{694,385,.6},{702,381,.03}});pet(cream,{{686,394,.7},{690,384,.5},{696,381,.02}});pet(cream,{{683,393,.7},{679,383,.5},{678,378,.02}});pet(cream,{{684,395,.7},{673,391,.4},{667,387,.03}});

--@ chunk 14
local remote={{491,231,28},{533,223,30},{559,239,22},{605,209,27},{634,215,25},{470,249,21},{349,534,34},{386,519,26},{564,456,27},{889,401,27},{825,467,31},{849,460,25},{310,651,36}};for i,v in ipairs(remote) do broadpad(v[1],v[2]+2,v[3]+6,leafdark);broadpad(v[1]-1,v[2]-2,v[3],i%3==0 and olive or jade,i%2==0 and mauve or green);end;petal=brush{kind='round',width=6,point=.7,lay=5};pet(wine,{{731,426,.3},{742,429,.9},{757,426,.1}});pet(pink,{{743,427,.8},{735,418,.6},{733,413,.02}});pet(pink,{{744,428,.8},{746,412,.6},{750,408,.02}});pet(pink,{{747,427,.8},{756,418,.5},{765,415,.02}});pet(cream,{{743,425,.8},{741,416,.6},{742,410,.02}});pet(cream,{{745,425,.8},{755,420,.6},{759,415,.02}});petal=brush{kind='round',width=5,point=.7,lay=5};pet(wine,{{607,419,.4},{617,423,.8},{627,420,.1}});pet(pink,{{617,421,.8},{613,414,.6},{611,406,.02}});pet(pink,{{617,421,.8},{621,412,.5},{627,408,.02}});pet(cream,{{617,419,.8},{616,412,.5},{617,407,.02}});pet(cream,{{619,421,.8},{627,417,.5},{633,415,.02}});petal=brush{kind='round',width=8,point=.7,lay=5};pet(wine,{{146,585,.3},{163,588,.9},{180,584,.1}});pet(pink,{{164,587,.8},{149,577,.65},{145,569,.02}});pet(pink,{{164,586,.8},{158,572,.7},{161,562,.02}});pet(pink,{{166,586,.8},{175,574,.65},{184,568,.02}});pet(cream,{{164,583,.8},{162,574,.6},{165,567,.02}});pet(cream,{{167,584,.8},{174,579,.6},{180,572,.02}});pet(cream,{{162,584,.7},{151,580,.5},{143,575,.02}});petal=brush{kind='round',width=6,point=.7,lay=5};pet(wine,{{244,552,.3},{255,555,.8},{264,551,.1}});pet(pink,{{255,554,.8},{249,543,.6},{250,537,.02}});pet(pink,{{256,553,.8},{261,544,.6},{268,540,.02}});pet(cream,{{254,551,.8},{249,545,.5},{243,542,.02}});pet(cream,{{256,551,.8},{258,544,.6},{260,538,.02}});petal=brush{kind='round',width=4,point=.7,lay=4};pet(pink,{{533,221,.8},{530,214,.4},{532,210,.02}});pet(cream,{{534,220,.7},{538,215,.4},{542,214,.02}});pet(pink,{{54,625,.8},{49,616,.6},{50,612,.02}});pet(cream,{{55,624,.8},{61,618,.5},{66,616,.02}});

--@ chunk 15
rr=rag{width=38};rr:blot(490,233,{pressure=.95});rr:refold();rr:blot(490,233,{pressure=.95});rr:refold();rr:blot(490,233,{pressure=.95});flatleaf=brush{kind='filbert',width=6,lay=2};flatleaf:load(jade,.55);flatleaf:gesture({{473,229,.25},{489,228,.9},{505,230,.1}},{wobble=.4});

--@ chunk 16
rr=rag{width=37};rr:dip(.7);rr:wipe({{470,232},{504,232}},{pressure=.95});rr:refold();rr:wipe({{470,232},{504,232}},{pressure=.95});rr:refold();rr:wipe({{470,232},{504,232}},{pressure=.95});

--@ chunk 17
flatleaf:reload(jade,.55);flatleaf:gesture({{474,229,.1},{488,228,.9},{506,230,.05}},{wobble=.35});

--@ chunk 18
local rem={{533,223,30},{559,239,22},{605,209,27},{634,215,25},{470,249,21},{349,534,34},{386,519,26},{564,456,27},{889,401,27},{825,467,31},{849,460,25},{310,651,36}};for i,v in ipairs(rem) do local r=rag{width=30};r:dip(.7);for j=1,4 do r:wipe({{v[1]-v[3]*.4,v[2]+1},{v[1]+v[3]*.4,v[2]+1}},{pressure=.95});r:refold();end;local b=brush{kind='filbert',width=v[2]<300 and 5 or 8,lay=2};b:load(i%3==0 and olive or jade,.55);b:gesture({{v[1]-v[3]*.6,v[2],.12},{v[1],v[2]-1,.8},{v[1]+v[3]*.6,v[2]+1,.07}},{wobble=.5});end;mid=mix{{blue,3},{mauve,2}};repairwater=(poly({{-30,426},{79,369},{159,390},{258,305},{340,295},{392,334},{361,404},{342,466},{327,514},{252,534},{186,509},{101,541},{-30,555}},true)-raft1:grow(11)):soften(13);work(repairwater,{hand='body',pile=mid,tool='filbert 18',load=.65,coverage=2.8,fill=true,length={25,58},angle=.05,clip=true});work(repairwater,{hand='body',pile=rose,tool='filbert 7',load=.24,dips={3,.24,.95},coverage=.7,length={18,44},angle=.03,clip=true});blend(repairwater,{tool='badger 30',coverage=.75,angle=.05});

--@ chunk 19
water=everywhere()-left-right-raft1:grow(9)-raft2:grow(9); protect=-(raft1:grow(9)+raft2:grow(9));mid=mix{{blue,3},{mauve,2}};glow=mix{{mid,1},{light,1}};work(water,{hand='body',pile=mid,tool='filbert 22',load=.65,coverage=3,fill=true,length={35,78},angle=.05,clip=protect});work(poly({{720,451},{1030,556},{1030,760},{496,760},{439,664},{631,595}},true)*water,{hand='body',pile=blue,tool='filbert 16',load=.28,coverage=.7,length={30,65},angle=.05,clip=protect});work(opening:grow(20)*water,{hand='body',pile=rose,tool='filbert 16',load=.3,coverage=.85,length={35,70},angle=1.5,clip=protect});work(gleam:grow(25)*water,{hand='body',pile=glow,tool='filbert 18',load=.4,coverage=1.7,length={24,55},angle=1.5,clip=protect});blend(water,{tool='badger 30',coverage=1.5,angle=1.5});

--@ chunk 20
edgeleaf=brush{kind='filbert',width=12,lay=2};edgeleaf:load(jade,.65);edgeleaf:gesture({{827,400,.15},{847,394,.9},{869,399,.1}},{wobble=.7});edgeleaf:reload(olive,.4);edgeleaf:gesture({{838,394,.1},{850,392,.45},{861,395,.06}},{wobble=.5});refl=brush{kind='filbert',width=10};refl:load(green,.22);refl:gesture({{761,464,.45},{755,479,.6},{762,490,.1}},{wobble=2}); bwater=brush{kind='filbert',width=7};ripple(mid,{{743,480,.15},{760,478,.65},{780,480,.1}});

--@ chunk 21
function flatpad(x,y,w,p) local b=brush{kind='filbert',width=w*.22,lay=2};b:load(p,.65);b:gesture({{x-w*.54,y,.12},{x-w*.03,y-w*.045,.85},{x+w*.49,y+w*.015,.07}},{wobble=.65});end;local edge={{542,433,41},{608,462,43},{652,466,32},{747,465,45},{801,442,42},{875,400,47},{836,365,34},{737,345,38},{777,356,30},{338,558,49},{291,613,40},{221,624,43},{146,653,46},{73,651,48},{20,674,42},{101,545,39},{211,516,34}};for i,v in ipairs(edge) do flatpad(v[1],v[2],v[3],i%4==0 and olive or jade);end;bwater=brush{kind='filbert',width=9};ripple(mid,{{559,453,.2},{584,447,.75},{609,451,.08}});ripple(mid,{{706,465,.2},{729,457,.7},{749,460,.05}});ripple(mid,{{801,428,.15},{827,426,.7},{850,428,.1}});ripple(mid,{{160,643,.15},{184,634,.8},{210,638,.1}});ripple(mid,{{274,587,.1},{303,583,.65},{322,587,.1}});ripple(mid,{{24,645,.12},{42,638,.7},{73,642,.1}});bwater=brush{kind='filbert',width=4,lay=2};ripple(glow,{{368,133,.1},{401,136,.6},{425,134,.1}});ripple(glow,{{605,143,.1},{633,146,.65},{674,145,.1}});ripple(glow,{{511,192,.1},{550,190,.55},{579,192,.1}});ripple(glow,{{409,283,.1},{439,280,.6},{472,283,.1}});ripple(glow,{{605,320,.1},{637,318,.6},{672,321,.1}});ripple(glow,{{226,435,.1},{270,438,.6},{307,437,.1}});ripple(glow,{{274,469,.1},{301,467,.55},{325,470,.1}});ripple(glow,{{507,495,.1},{552,492,.6},{579,494,.1}});ripple(glow,{{608,493,.1},{638,497,.65},{680,494,.1}});ripple(glow,{{728,489,.1},{767,491,.65},{798,489,.1}});ripple(glow,{{845,448,.1},{869,450,.65},{908,447,.1}});ripple(glow,{{322,606,.1},{355,604,.6},{398,607,.1}});ripple(glow,{{456,632,.1},{479,630,.55},{509,632,.1}});ripple(glow,{{704,605,.1},{733,607,.6},{787,604,.1}});ripple(glow,{{797,649,.1},{838,647,.6},{868,650,.1}});ripple(rose,{{144,681,.1},{182,684,.6},{223,681,.1}});ripple(rose,{{554,569,.1},{587,571,.6},{617,569,.1}});ripple(rose,{{633,679,.1},{668,677,.6},{691,680,.1}});

--@ chunk 22
watertint=mix{{mid,3},{glow,1}};stipple(rect(738,531,120,105):soften(15),{pile=watertint,tool={kind='filbert',width=4,lay=2},coverage=.65,pressure={.2,.55},dips={5,.4,.9},drag={5,0},cluster={.3,22},feather=.7});

--@ chunk 23
stipple(rect(738,531,120,105):soften(15),{pile=watertint,tool={kind='filbert',width=6,lay=2},coverage=.8,pressure={.6,.9},dips={5,.65,.9},drag={9,0},cluster={.3,22},feather=.7});

--@ chunk 24
leaflight=mix{{jade,2},{cream,1}};fine=brush{kind='filbert',width=5,lay=3};fine:load(leaflight,.6);fine:gesture({{193,599,.15},{207,597,.6},{219,600,.1}},{wobble=.7});fine:reload(wine,.35);fine:gesture({{202,606,.15},{210,608,.5},{220,605,.08}},{wobble=.5});

--@ chunk 25
fine=brush{kind='filbert',width=5,lay=3};function fleck(p,pts,load) fine:reload(p,load or .5);fine:gesture(pts,{wobble=.7});end;fleck(leaflight,{{62,600,.15},{74,596,.65},{84,598,.12}});fleck(leaflight,{{112,565,.12},{126,567,.7},{133,566,.1}});fleck(leaflight,{{227,545,.1},{239,543,.65},{247,545,.1}});fleck(leaflight,{{274,579,.1},{286,577,.55},{297,580,.12}});fleck(leaflight,{{134,624,.15},{143,622,.7},{154,624,.1}});fleck(leaflight,{{31,643,.1},{43,640,.6},{48,641,.1}});fleck(leaflight,{{624,426,.1},{635,424,.65},{646,426,.08}});fleck(leaflight,{{696,400,.1},{707,398,.65},{718,401,.1}});fleck(leaflight,{{771,383,.1},{783,380,.7},{793,382,.1}});fleck(leaflight,{{812,404,.1},{824,402,.7},{832,405,.1}});fleck(leaflight,{{737,443,.1},{747,441,.7},{758,442,.1}});fleck(wine,{{87,615,.15},{98,617,.5},{110,614,.1}},.3);fleck(wine,{{234,562,.1},{245,565,.55},{257,562,.1}},.3);fleck(wine,{{649,450,.1},{661,452,.55},{672,449,.1}},.3);fleck(wine,{{785,407,.1},{792,411,.5},{805,409,.1}},.3);bwater=brush{kind='filbert',width=6};ripple(mid,{{685,415,.15},{694,413,.65},{702,415,.1}});ripple(mid,{{231,584,.15},{242,582,.65},{254,583,.1}});ripple(mid,{{85,566,.1},{97,564,.65},{110,566,.1}}); far=brush{kind='filbert',width=4,lay=2};far:load(jade,.55);far:gesture({{522,216,.1},{538,214,.7},{551,216,.05}},{wobble=.45});far:reload(jade,.55);far:gesture({{558,207,.1},{573,206,.7},{581,207,.05}},{wobble=.5});far:reload(olive,.4);far:gesture({{545,225,.1},{556,224,.6},{568,225,.05}},{wobble=.4});petal=brush{kind='round',width=3.5,point=.7,lay=4};pet(pink,{{571,205,.7},{570,200,.6},{573,197,.05}});pet(cream,{{572,203,.6},{575,200,.5},{579,199,.02}});petal=brush{kind='round',width=4,point=.6,lay=4};pet(wine,{{832,383,.6},{836,376,.6},{835,372,.02}});pet(pink,{{835,381,.5},{837,376,.65},{836,372,.02}});

--@ chunk 26
cutwater=brush{kind='filbert',width=12};cutwater:load(mid,.65);cutwater:gesture({{603,389,.2},{626,391,.85},{650,392,.08}},{wobble=1});

--@ chunk 27
function cut(pts) cutwater:reload(mid,.65);cutwater:gesture(pts,{wobble=1.2});end;cut({{548,417,.15},{571,423,.85},{593,421,.08}});cut({{596,402,.15},{615,405,.85},{638,401,.08}});cut({{637,380,.15},{652,385,.85},{668,382,.08}});cut({{690,359,.15},{708,370,.85},{724,367,.08}});cut({{706,343,.15},{727,351,.85},{746,353,.08}});cut({{791,353,.15},{808,366,.85},{826,368,.08}});cut({{860,381,.15},{879,383,.85},{894,389,.08}});cut({{128,518,.15},{145,530,.85},{161,530,.08}});cut({{185,509,.15},{205,523,.85},{222,526,.08}});cut({{274,531,.15},{291,539,.85},{308,539,.08}});cut({{20,545,.15},{40,554,.85},{57,556,.08}});cut({{298,606,.15},{281,600,.8},{267,603,.08}});cut({{743,470,.15},{751,457,.85},{767,454,.08}});

--@ chunk 28
print('water '..drying(720,580));print('left curtain '..drying(110,145));print('right flower '..drying(684,393));print('raft rim '..drying(626,400));

--@ chunk 29
print(drying(642,467))
softedge=brush{kind='badger',width=20}
softedge:gesture({{637,459,.3},{642,467,.65},{646,477,.15}})
softedge:wipe(1)
softedge:gesture({{652,459,.25},{653,467,.6},{656,475,.12}})

--@ chunk 30
softedge:wipe(1)
softedge:gesture({{593,394,.2},{599,402,.65},{603,411,.18}})
softedge:wipe(1)
softedge:gesture({{607,390,.2},{611,399,.6},{614,407,.12}})
softedge:wipe(1)
softedge:gesture({{665,363,.18},{665,374,.62},{669,383,.12}})
softedge:wipe(1)
softedge:gesture({{838,414,.22},{843,422,.6},{845,432,.12}})
softedge:wipe(1)

--@ chunk 31
print('water',drying(720,580)); print('curtain',drying(110,145)); print('flower',drying(684,393)); print('softened shadow',drying(642,467))

--@ chunk 32
print('water',drying(720,580),'left curtain',drying(110,145),'right curtain',drying(900,180),'flower',drying(684,393),'softened shadow',drying(642,467))

--@ chunk 33
print('water', drying(720,580)); print('left curtain', drying(110,145)); print('right curtain', drying(900,180)); print('flower', drying(684,393)); print('right shadow', drying(642,467))

--@ chunk 34
print('water',drying(720,580),'left curtain',drying(110,145),'right curtain',drying(900,180),'flower',drying(684,393),'shadow',drying(642,467))

--@ chunk 35
print('water', drying(720,580)); print('left curtain',drying(110,145)); print('right curtain',drying(900,180)); print('flower',drying(684,393)); print('softened shadow',drying(642,467))

--@ chunk 36
print('water',drying(720,580),'left curtain',drying(110,145),'right curtain',drying(900,180),'flower',drying(684,393),'softened shadow',drying(642,467))

--@ chunk 37
print('water',drying(720,580),'left curtain',drying(110,145),'right curtain',drying(900,180),'flower',drying(684,393),'shadow',drying(642,467))

--@ chunk 38
print('water', drying(720,580)); print('left curtain',drying(110,145)); print('right curtain',drying(900,180)); print('flower',drying(684,393)); print('softened shadow',drying(642,467))

--@ chunk 39
print('water',drying(720,580),'left curtain',drying(110,145),'right curtain',drying(900,180),'flower',drying(684,393),'shadow',drying(642,467))

--@ chunk 40
print('water',drying(720,580),'left curtain',drying(110,145),'right curtain',drying(900,180),'flower',drying(684,393),'softened shadow',drying(642,467))

--@ chunk 41
print('water',drying(720,580),'left curtain',drying(110,145),'right curtain',drying(900,180),'flower',drying(684,393),'softened shadow',drying(642,467))

--@ chunk 42
print('water',drying(720,580),'left curtain',drying(110,145),'right curtain',drying(900,180),'flower',drying(684,393),'shadow',drying(642,467))

--@ chunk (finishing)
-- finishing, applied after the session by scripts/finish_painting
local function when_dry(f)
  for _ = 1, 120 do
    local ok, e = pcall(f)
    if ok then return end
    if not tostring(e):find('not all dry', 1, true) then error(e, 0) end
    wait(30 * 24 * 60)
  end
  error('still not dry after ten years', 0)
end
when_dry(function() varnish{coats=0.4} end)
when_dry(function() cracks{} end)
