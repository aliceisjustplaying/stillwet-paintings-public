-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box hopper
--@ engine 5

--@ chunk 1
canvas{size=900,aspect=1.43,linen={24,22},seed=714,ground={{pile={{'lead white',1},{'yellow ochre',0.035}},um=95,apply='knife',texture=0.12}}}
function field(m,p) work(m,{hand='broad',pile=p,tool={kind='flat',width=30},coverage=1.6,load=0.85,clip=true,fill=true,angle=0.05}) end
sky=pile{{'lead white',7},{'cerulean blue',2},{'cobalt blue',0.4},turps=0.18}
wall=pile{{'lead white',8},{'yellow ochre',2},{'pale cadmium',0.6},{'red earth',0.13},turps=0.12}
shade=pile{{'lead white',3},{'ultramarine blue',1},{'yellow ochre',1},{'bone black',0.3},turps=0.12}
brick=pile{{'red earth',3},{'yellow ochre',1},{'lead white',1},{'bone black',0.5},turps=0.15}
paving=pile{{'lead white',5},{'yellow ochre',0.7},{'bone black',0.8},{'cobalt blue',0.4},turps=0.12}
road=pile{{'bone black',2},{'lead white',2},{'ultramarine blue',0.7},{'red earth',0.35},turps=0.15}
field(rect(0,0,1000,700),sky)
field(poly{{0,86},{151,106},{151,525},{0,541}},brick)
field(poly{{147,69},{1000,-9},{1000,555},{147,515}},wall)
field(poly{{147,69},{558,31},{379,525},{147,515}},shade)
field(poly{{0,521},{147,511},{1000,551},{1000,632},{0,605}},paving)
field(poly{{0,605},{1000,632},{1000,700},{0,700}},road)

--@ chunk 2
wait(7200)
function solid(m,p) work(m,{hand='broad',tool={kind='flat',width=22,lay=2},pile=p,coverage=3,load=.9,clip=true,fill=true,angle=0}) end
wall2=pile{{'lead white',8},{'yellow ochre',2},{'pale cadmium',0.6},{'red earth',0.13}}
shade2=pile{{'lead white',3},{'ultramarine blue',1},{'yellow ochre',1},{'bone black',0.3}}
brick2=pile{{'red earth',3},{'yellow ochre',1},{'lead white',1},{'bone black',0.5}}
paving2=pile{{'lead white',5},{'yellow ochre',0.7},{'bone black',0.8},{'cobalt blue',0.4}}
road2=pile{{'bone black',2},{'lead white',2},{'ultramarine blue',0.7},{'red earth',0.35}}
solid(poly{{147,69},{1000,-9},{1000,555},{379,525},{558,31}},wall2)
solid(poly{{147,69},{558,31},{379,525},{147,515}},shade2)
solid(poly{{0,86},{147,106},{147,515},{0,521}},brick2)
solid(poly{{0,521},{147,511},{1000,551},{1000,632},{0,605}},paving2)
solid(poly{{0,605},{1000,632},{1000,700},{0,700}},road2)
wait(7200)
dark=pile{{'bone black',3},{'ultramarine blue',1},{'yellow ochre',0.6}}
trim=pile{{'lead white',2},{'yellow ochre',2},{'bone black',1},{'viridian',.5}}
inside=pile{{'lead white',2},{'yellow ochre',2},{'viridian',.45},{'bone black',.8}}
shutter=pile{{'lead white',2},{'bone black',1},{'cerulean blue',.6},{'yellow ochre',.5}}
solid(poly{{182,210},{415,204},{415,519},{182,508}},trim)
solid(poly{{196,227},{401,222},{401,501},{196,493}},shutter)
solid(poly{{448,202},{580,198},{580,526},{448,520}},trim)
solid(poly{{461,219},{566,216},{566,510},{461,506}},dark)
solid(poly{{621,196},{941,187},{941,538},{621,529}},trim)
solid(poly{{638,214},{925,206},{925,488},{638,480}},dark)
solid(poly{{665,246},{922,237},{922,477},{665,470}},inside)
solid(poly{{820,240},{922,237},{922,477},{799,473}},wall2)

--@ chunk 3
wait(14400)
print(drying(250,160),drying(750,330))
function plane(m,p) work(m,{hand='body',tool={kind='flat',width=18,lay=2},pile=p,coverage=3,load=.95,dips={1,.95,1},length={25,50},clip=true,fill=true,angle=0.05}) end
plane(rect(185,100,140,75),shade2)

--@ chunk 4
wait(100*1440)
print(drying(250,160),drying(750,330))
plane(rect(185,100,140,75),shade2)

--@ chunk 5
function coat(m,p) work(m,{hand='broad',tool={kind='flat',width=22,lay=1},pile=p,coverage=2.2,dips={1,1,1},clip=true,fill=true,angle=0}) end
coat(poly{{147,69},{558,31},{494,202},{448,202},{448,335},{415,426},{415,204},{182,210},{182,508},{147,515}},shade2)
coat(poly{{448,202},{580,198},{580,526},{448,520}},trim)
coat(poly{{621,196},{941,187},{941,538},{621,529}},trim)
wait(100*1440)
coat(poly{{461,219},{566,216},{566,510},{461,506}},dark)
coat(poly{{638,214},{925,206},{925,488},{638,480}},dark)
coat(poly{{196,227},{401,222},{401,501},{196,493}},shutter)
wait(100*1440)
coat(poly{{665,246},{922,237},{922,477},{665,470}},inside)
wait(100*1440)
coat(poly{{820,240},{922,237},{922,477},{799,473}},wall2)

--@ chunk 6
wait(100*1440)
function shape(pts,p) coat(poly(pts),p) end
function line(pts,p,w) local b=brush{kind='flat',width=w,lay=1}; b:load(p,1); b:stroke(pts,{pressure=.8,ramps={0,0},shake=.12}) end
cool=pile{{'lead white',2},{'ultramarine blue',1},{'bone black',.7},{'red earth',.25}}
stone=pile{{'lead white',7},{'yellow ochre',1},{'red earth',.2}}
rust=pile{{'red earth',2},{'yellow ochre',.6},{'bone black',1}}
wood=pile{{'yellow ochre',2},{'red earth',1},{'bone black',1.5}}
shape({{0,521},{378,526},{289,614},{0,606}},cool)
shape({{0,605},{1000,632},{1000,644},{0,617}},stone)
shape({{0,617},{1000,644},{1000,650},{0,623}},dark)
shape({{148,69},{1000,-9},{1000,2},{148,82}},stone)
shape({{149,82},{552,45},{548,55},{149,91}},trim)
shape({{556,44},{1000,2},{1000,10},{553,52}},wood)
shape({{638,470},{922,477},{922,488},{638,480}},rust)
shape({{628,488},{947,496},{947,509},{628,501}},stone)
shape({{632,508},{945,516},{945,526},{632,519}},wood)
shape({{459,508},{573,512},{589,532},{439,526}},stone)
shape({{439,526},{589,532},{589,539},{439,533}},trim)
-- door panel, glass and raised wooden edges
shape({{475,264},{551,262},{551,390},{475,389}},shutter)
shape({{481,271},{545,269},{545,383},{481,382}},inside)
shape({{475,406},{551,407},{551,493},{475,490}},wood)
line({{465,250},{564,247}},trim,6)
line({{470,222},{470,501}},trim,5)
line({{556,222},{556,504}},trim,5)
line({{540,401},{540,416}},stone,3)
-- neighboring brick windows
shape({{0,160},{106,167},{106,273},{0,270}},wood)
shape({{6,173},{96,178},{96,258},{6,257}},dark)
shape({{0,281},{112,282},{112,293},{0,292}},trim)
shape({{0,340},{103,341},{103,459},{0,458}},wood)
shape({{5,350},{93,351},{93,445},{5,444}},dark)
line({{52,177},{51,257}},trim,5)
line({{8,216},{94,219}},trim,4)
line({{47,353},{47,442}},trim,5)
-- bench against room's back wall
shape({{731,421},{915,425},{915,438},{731,434}},wood)
shape({{727,444},{913,448},{904,455},{720,451}},rust)
line({{736,453},{733,475}},dark,5)
line({{900,455},{905,484}},dark,5)
-- first shutter seam trial
line({{200,242},{396,238}},trim,2.1)

--@ chunk 7
wait(100*1440)
seam=pile{{'lead white',2},{'bone black',1},{'yellow ochre',.6},{'ultramarine blue',.35}}
skin=pile{{'lead white',4},{'yellow ochre',1},{'red earth',.6}}
red=pile{{'red earth',3},{'deep cadmium',.6},{'bone black',.65}}
hair=pile{{'bone black',2},{'burnt sienna',1},{'yellow ochre',.3}}
function small(m,p) work(m,{hand='body',tool={kind='filbert',width=5,lay=1},pile=p,coverage=2.4,dips={1,1,1},length={8,16},clip=true,fill=true}) end
-- legs, seated figure, a first laid skin and cloth trial
small(poly{{801,441},{812,442},{814,461},{807,477},{797,478},{803,459}},skin)
small(poly{{819,442},{829,444},{825,464},{820,480},{811,481},{816,462}},skin)
small(poly{{820,368},{836,367},{847,381},{842,411},{851,423},{858,443},{816,447},{794,438},{801,424},{823,414}},red)
small(poly{{824,354},{837,354},{835,373},{824,375}},skin)
small(ellipse(830,346,13,17),hair)
small(poly{{821,334},{830,335},{833,345},{829,353},{829,364},{820,362},{816,357},{811,354},{816,349},{816,341}},skin)
small(ellipse(841,350,6,8),hair)
line({{200,258},{396,254}},seam,1.8)
-- restrained sign: hand drawn capital W trial
line({{656,161},{661,181},{668,167},{674,181},{679,161}},wood,2.4)

--@ chunk 8
wait(100*1440)
-- shutter ribs, kept low contrast
for y=275,490,17 do line({{200,y},{396,y-4}},seam,1.4) end
line({{200,499},{399,506}},dark,4)
line({{288,482},{305,482}},dark,3)
-- lettering WESTBOUND, each letter drawn anew
line({{702,160},{687,160},{687,180},{703,180}},wood,2.3)
line({{688,169},{699,169}},wood,2.3)
line({{725,159},{711,159},{709,166},{723,171},{723,179},{708,179}},wood,2.3)
line({{731,159},{751,158}},wood,2.3)
line({{741,159},{741,179}},wood,2.3)
line({{759,179},{759,158},{772,158},{776,162},{772,168},{759,169},{773,169},{778,173},{774,178},{759,179}},wood,2.3)
line({{788,158},{784,163},{784,173},{788,178},{800,177},{804,172},{804,162},{799,157},{788,158}},wood,2.3)
line({{813,157},{813,174},{818,178},{827,177},{832,173},{832,156}},wood,2.3)
line({{841,177},{841,156},{859,176},{859,155}},wood,2.3)
line({{869,176},{869,155},{881,155},{889,161},{889,169},{882,175},{869,176}},wood,2.3)
-- modelling skirt as a bent lap rather than a standing bell
reddark=pile{{'red earth',2},{'bone black',1},{'ultramarine blue',.3}}
redlight=pile{{'red earth',3},{'deep cadmium',1},{'lead white',.6}}
small(poly{{835,379},{846,383},{840,411},{849,424},{832,433},{801,436},{796,431},{807,421},{825,417}},reddark)
small(poly{{807,422},{836,420},{848,434},{817,438},{797,434}},redlight)
line({{809,437},{849,441}},reddark,2.5)
-- face over now dry hair
small(poly{{820,337},{829,338},{830,345},{825,353},{826,360},{820,361},{816,356},{811,354},{816,350},{816,343}},skin)
small(poly{{825,359},{831,359},{831,372},{823,372}},skin)
-- near forearm and far forearm
small(poly{{836,387},{842,390},{837,411},{815,421},{810,418},{830,406}},skin)
small(poly{{821,382},{828,385},{820,404},{800,415},{793,414},{797,409},{814,398}},skin)
-- sleeves define shoulders and elbow rhythm
small(poly{{820,373},{828,374},{831,384},{823,391},{816,386}},redlight)
small(poly{{835,374},{844,380},{845,390},{837,394},{832,386}},red)
-- shoes
small(poly{{800,473},{807,475},{807,482},{791,483},{787,480}},hair)
small(poly{{813,477},{821,479},{821,485},{804,486},{802,484}},hair)
-- folded timetable, first dry room-backed paper block
paper=pile{{'lead white',9},{'yellow ochre',.5},{'bone black',.15}}
small(poly{{776,403},{799,409},{813,406},{805,423},{785,418}},paper)
-- pavement joints and a foundation shadow
line({{609,550},{569,619}},seam,1.3)
line({{156,524},{106,604}},shade2,1.4)
line({{940,558},{985,632}},seam,1.2)
line({{0,572},{307,584}},shade2,1.5)
line({{371,587},{710,600},{1000,612}},shade2,1.2)
line({{596,541},{993,558}},trim,3)
-- window glazing bar, separates empty bay from occupant
line({{757,239},{757,477}},trim,5)
line({{759,242},{759,471}},stone,1.3)

--@ chunk 9
wait(100*1440)
skinshade=pile{{'lead white',2},{'yellow ochre',1},{'red earth',.7},{'ultramarine blue',.15}}
small(poly{{836,391},{841,392},{835,411},{815,420},{812,417},{831,406}},skin)
small(poly{{825,340},{831,343},{826,353},{827,360},{821,360},{821,354},{825,349}},skinshade)
line({{817,347},{821,348}},hair,1)
line({{816,356},{819,357}},skinshade,.9)
line({{824,363},{823,369}},skinshade,1.8)
line({{838,396},{833,409},{818,416}},skinshade,1.3)
line({{807,448},{808,459},{802,472}},skinshade,1.5)
line({{825,449},{821,463},{817,475}},skinshade,1.2)
line({{800,414},{806,415}},skin,2.4)
line({{795,409},{798,411}},skin,2.2)
line({{798,411},{795,419}},shade2,.9)
line({{781,407},{791,410}},shade2,.6)
line({{783,410},{790,412}},shade2,.6)
-- calm red modeling over dry skirt
small(poly{{802,424},{818,421},{838,424},{844,432},{821,434},{798,432}},redlight)
line({{819,424},{815,432}},red,1.6)
line({{833,424},{839,433}},red,1.7)
-- lit frame edges and inset lower panels
line({{583,200},{583,521}},stone,2.3)
line({{942,190},{942,492}},stone,3)
line({{624,197},{939,188}},stone,2.5)
line({{621,532},{942,542}},trim,3)
shape({{639,511},{927,519},{927,529},{639,521}},inside)
-- paper bus timetable on the dark half of room wall
small(poly{{693,306},{725,306},{725,363},{693,362}},paper)
-- transom street number
line({{500,230},{503,228},{503,240}},stone,1.2)
line({{510,228},{518,228},{512,241}},stone,1.2)

--@ chunk 10
wait(100*1440)
-- small destination timetable, drawn not typeset
line({{698,320},{698,311},{702,311},{704,313},{702,315},{698,315},{703,315},{704,318},{702,320},{698,320}},wood,.8)
line({{707,311},{707,318},{710,320},{713,318},{713,311}},wood,.8)
line({{721,311},{716,311},{716,315},{721,316},{721,320},{716,320}},wood,.8)
line({{698,326},{720,326}},trim,1)
line({{698,333},{706,333}},seam,.7)
line({{711,333},{720,333}},seam,.7)
line({{698,339},{704,339}},seam,.7)
line({{711,339},{720,339}},seam,.7)
line({{698,345},{706,345}},seam,.7)
line({{711,345},{719,345}},seam,.7)
line({{698,351},{705,351}},seam,.7)
line({{711,351},{720,351}},seam,.7)
-- lessen the too-heavy lower eye
line({{817,348.5},{821,349.5}},skin,1.4)
-- a small handbag beside her
small(poly{{872,431},{888,431},{892,444},{869,444}},hair)
line({{876,432},{876,426},{881,424},{886,427},{886,432}},hair,1.7)
line({{873,436},{888,436}},wood,1.3)
-- subdued glazing catches in otherwise transparent glass
reflection=pile{{'lead white',2},{'cerulean blue',1},{'bone black',.6},{'yellow ochre',.4}}
line({{643,259},{643,352}},reflection,1.3)
line({{643,375},{643,451}},reflection,1)
line({{766,250},{766,315}},shade2,.8)
line({{485,279},{485,327}},shade2,1.4)
line({{485,352},{485,376}},shade2,1)
line({{481,376},{524,378}},shade2,1.1)
-- reveal and curb scuffs, just three broken light notes
line({{87,615},{154,617}},paving2,1.5)
line({{485,631},{538,633}},paving2,1.1)
line({{809,640},{852,641}},paving2,1.3)
-- a few brick courses beside the cropped windows
line({{111,310},{146,313}},wood,.8)
line({{104,402},{143,402}},wood,.8)
line({{11,475},{80,477}},wood,.8)
line({{85,494},{145,497}},wood,.8)

--@ chunk 11
print('road',drying(70,666),drying(300,654),drying(730,678),drying(972,666))
print('recent eye/glass',drying(819,349),drying(643,300))

--@ chunk 12
roadquiet=pile{{'bone black',2},{'lead white',2},{'ultramarine blue',.7},{'red earth',.35}}
function roadcoat(m) work(m,{hand='broad',pile=roadquiet,tool={kind='flat',width=22,lay=1},coverage=2.2,dips={1,1,1},length={30,55},clip=true,fill=true,angle=0,angle_jitter=.05}) end
roadcoat(rect(35,651,145,43))

--@ chunk 13
wait(100*1440)
print('trial',drying(65,670),drying(140,681),'old road',drying(450,680),drying(850,676))

--@ chunk 14
roadcoat(poly{{0,623},{1000,650},{1000,700},{0,700}})

--@ chunk 15
print('road left',drying(150,670),'road center',drying(500,670),'road right',drying(850,675))
print('face',drying(821,350),'neck',drying(828,367),'brick window',drying(40,210),'glass catch',drying(765,285))

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
