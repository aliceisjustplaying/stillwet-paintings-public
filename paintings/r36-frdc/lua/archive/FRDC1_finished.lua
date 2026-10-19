-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 5

--@ chunk 1
canvas{size=700,aspect=1.4,linen={16,17},seed=41,ground={{pile={{'red earth',1},{'yellow ochre',2},{'lead white',3}},um=45,apply='knife',texture=.12},{pile={{'lead white',12},{'raw umber',.3},{'yellow ochre',.25}},um=40,apply='roller',texture=.1}}}
palette{set_out={'lead white','smalt','cobalt blue','yellow ochre','raw umber','red earth','bone black','rose madder','Naples yellow'}}

--@ chunk 2
cool=pile{{'lead white',7},{'cobalt blue',1.1},{'raw umber',.45},{'bone black',.15},thinner=.25}
warm=pile{{'lead white',12},{'Naples yellow',1.6},{'red earth',.22},{'yellow ochre',.2},thinner=.25}
work(everywhere(),{hand='broad',tool='filbert 45',piles={{cool,function(x,y)return 1-smoothstep(50,500,y)end},{warm,function(x,y)return smoothstep(50,500,y)end}},coverage=2,load=.8,fill=true,clip=true,angle=0,length={180,300}})
blend(everywhere(),{tool='badger 65',coverage=.5,angle=0})

--@ chunk 3
wait(4320)
far=pile{{'lead white',5},{'cobalt blue',1},{'raw umber',.7},{'rose madder',.12},thinner=.18}
water=pile{{'lead white',6},{'smalt',1.1},{'raw umber',.9},{'Naples yellow',.5},thinner=.2}
near=pile{{'raw umber',3},{'bone black',1.8},{'cobalt blue',.7},{'red earth',.5},thinner=.15}
mountains=below({{0,443},{56,430},{116,445},{182,410},{210,421},{242,400},{278,425},{315,439},{362,459},{405,474},{451,480},{488,476},{528,485},{582,470},{633,461},{670,441},{701,445},{753,424},{779,434},{812,412},{853,430},{902,437},{953,419},{1000,424}}):soften(1.8)
work(mountains*above(function(x)return 541 end),{hand='broad',tool='filbert 28',piles={{far,function(x,y)return 1-smoothstep(456,536,y)end},{warm,function(x,y)return smoothstep(456,536,y)end}},angle=0,coverage=2,load=.8,clip=true,fill=true,length={100,180}})
work(rect(0,539,1000,175):soften(2),{hand='broad',pile=water,coverage=2,load=.8,clip=true,fill=true,angle=0,tool='filbert 28',length={120,250}})
shore=below({{0,622},{75,615},{152,624},{221,613},{276,617},{331,607},{377,608},{424,599},{459,600},{490,595},{529,599},{571,595},{622,607},{678,615},{723,608},{790,620},{863,614},{920,625},{1000,621}}):roughen(1.4,14,9)
work(shore,{hand='broad',pile=near,coverage=2,load=.8,fill=true,clip=true,angle=0})

--@ chunk 4
wait(4320)
work(-mountains*above(function(x)return 540 end),{hand='broad',tool={kind='filbert',width=40,stiffness=.25},piles={{cool,function(x,y)return 1-smoothstep(50,500,y)end},{warm,function(x,y)return smoothstep(50,500,y)end}},coverage=3,load=.8,fill=true,clip=true,angle=0,length={90,160},ruler=true,curve={0,0},drift={0,300}})
work(mountains*above(function(x)return 537 end),{hand='broad',tool={kind='filbert',width=25,stiffness=.25},piles={{far,function(x,y)return 1-smoothstep(450,535,y)end},{warm,function(x,y)return smoothstep(450,535,y)end}},coverage=3,load=.8,clip=true,fill=true,angle=0,length={60,100},ruler=true,curve={0,0},drift={0,300}})
work(rect(0,540,1000,175)-shore,{hand='broad',tool={kind='filbert',width=25,stiffness=.25},pile=water,coverage=3,load=.8,clip=true,fill=true,angle=0,length={60,100},ruler=true,curve={0,0},drift={0,300}})
work(shore,{hand='broad',tool={kind='filbert',width=25,stiffness=.25},pile=near,coverage=3,load=.8,clip=true,fill=true,angle=0,length={60,100},ruler=true,curve={0,0},drift={0,300}})

--@ chunk 5
wait(4320)
stone=pile{{'raw umber',3},{'bone black',1},{'cobalt blue',.5},{'yellow ochre',.5},{'lead white',.6},thinner=.1}
outer=poly{{431,606},{436,536},{440,493},{440,454},{446,423},{459,397},{478,376},{490,357},{499,350},{502,334},{511,335},{514,344},{523,345},{522,360},{546,383},{563,412},{574,444},{575,487},{578,545},{585,609}}
opening=poly({{477,613},{477,492},{479,464},{485,442},{496,422},{510,403},{525,422},{538,447},{544,470},{545,610}} ,true)
arch=(outer-opening):roughen(.65,6,81)
leftremnant=poly{{390,610},{393,571},{403,570},{405,542},{414,543},{414,518},{425,521},{426,489},{440,490},{446,609}}
rightremnant=poly{{570,606},{573,518},{582,519},{582,551},{597,550},{598,577},{617,581},{624,614}}
ruin=arch+leftremnant+rightremnant
work(ruin,{hand='body',pile=stone,coverage=3,load=.8,clip=true,fill=true,tool={kind='filbert',width=14,stiffness=.25},angle=1.57,length={30,70}})

--@ chunk 6
wait(4320)
lightstone=pile{{'raw umber',3},{'bone black',.6},{'cobalt blue',.7},{'lead white',1.6},{'yellow ochre',.5},thinner=.12}
function facet(pts,p)
work(poly(pts)*ruin,{hand='detail',tool='filbert 5',pile=p,coverage=2,load=.7,fill=true,clip=true,angle=0,length={8,18}})
end
-- broad front planes, deliberately missing edges
facet({{440,602},{444,551},{447,493},{451,451},{461,420},{480,391},{500,366},{507,351},{515,363},{494,393},{477,427},{467,465},{465,523},{466,601}},lightstone)
facet({{513,371},{531,391},{550,424},{561,461},{560,512},{567,600},{550,600},{548,469},{536,436},{522,410},{509,394}},stone)
-- the inner reveal is darker than the frontal stones
facet({{466,601},{466,485},{471,453},{484,421},{510,390},{510,404},{495,425},{483,450},{477,478},{476,600}},near)
facet({{543,469},{550,474},{552,606},{545,606}},near)
-- broken end-wall planes
facet({{395,576},{407,578},{416,565},{427,568},{433,605},{394,606}},lightstone)
facet({{414,545},{426,546},{427,519},{438,522},{438,572},{420,571}},lightstone)
facet({{581,553},{592,558},{596,580},{580,590}},lightstone)
facet({{598,583},{613,585},{618,602},{597,601}},lightstone)

--@ chunk 7
wait(4320)
midstone=mix{{stone,1},{lightstone,1}}
facet({{548,481},{569,480},{570,499},{552,501}},midstone)
joint=brush{kind='rigger',width=1.8,point=.8,stiffness=.4};joint:load(near,.7);joint:stroke({{442,499},{452,500},{465,499},{473,501}},{pressure=.65,clip=ruin})
joint:reload(near,.7);joint:stroke({{456,500},{455,509},{457,520}},{pressure={.65,.25},clip=ruin})

--@ chunk 8
function facet(pts,p)
work(poly(pts):roughen(.45,4,73)*ruin,{hand='detail',tool='filbert 5',pile=p,coverage=2,load=.7,fill=true,clip=true,angle=0,length={8,18}})
end
-- differently weathered courses; not every stone is exposed
facet({{446,475},{448,456},{465,455},{463,477}},midstone)
facet({{445,520},{463,522},{463,540},{443,541}},midstone)
facet({{440,566},{456,565},{459,582},{439,584}},midstone)
facet({{452,432},{462,413},{479,422},{472,439}},lightstone)
facet({{467,405},{480,389},{492,400},{481,416}},midstone)
facet({{483,383},{496,369},{505,381},{495,394}},lightstone)
facet({{501,338},{510,340},{510,349},{499,350}},midstone)
facet({{516,367},{531,381},{527,394},{514,382}},midstone)
facet({{534,390},{546,405},{541,415},{529,400}},lightstone)
facet({{548,415},{558,433},{548,438},{541,420}},midstone)
facet({{553,445},{569,444},{571,462},{554,462}},lightstone)
facet({{553,504},{575,507},{573,524},{552,522}},midstone)
facet({{556,547},{574,545},{575,563},{555,564}},lightstone)
facet({{555,583},{579,582},{580,599},{557,600}},midstone)
facet({{428,524},{439,525},{437,541},{430,540}},midstone)
facet({{415,568},{435,570},{437,583},{413,584}},stone)
-- hand-drawn mortar beds and staggered breaks
local seams={
{{444,478},{456,479},{472,478}},{{441,521},{453,520},{468,522}},{{440,545},{452,544},{465,546}},{{437,565},{449,565},{465,564}},{{437,586},{451,585},{465,587}},
{{451,478},{450,488},{451,498}},{{456,522},{457,533},{456,543}},{{447,546},{448,564}},{{458,566},{457,576},{459,585}},
{{447,454},{460,455},{473,455}},{{452,432},{462,437},{476,439}},{{461,411},{469,416},{482,421}},{{477,389},{483,396},{494,401}},{{491,371},{500,379},{505,383}},
{{514,385},{526,381}},{{525,405},{541,396}},{{537,424},{555,414}},{{545,445},{566,438}},{{550,466},{574,465}},{{551,480},{561,479},{574,480}},{{551,502},{565,503},{576,502}},{{551,525},{566,525},{575,526}},{{553,545},{565,543},{576,545}},{{555,565},{564,566},{577,564}},{{555,582},{569,582},{579,581}},
{{562,466},{562,478}},{{565,505},{564,524}},{{559,526},{560,542}},{{566,566},{567,580}},{{426,543},{437,545}},{{414,565},{426,567},{437,567}},{{405,585},{421,586},{436,585}},{{420,586},{420,600}},{{580,577},{592,574}},{{598,600},{611,599}}
}
for _,pts in ipairs(seams) do joint:reload(near,.7);joint:stroke(pts,{pressure={.58,.28},clip=ruin}) end

--@ chunk 9
wait(4320)
stipple(ruin,{pile=midstone,width=1.2,coverage=.3,pressure={.15,.4},clip=true,dips={10,.5,.9},cluster=.15})
-- fallen masonry closes the threshold; independently drawn blocks
function rock(pts,top)
local m=poly(pts):roughen(.55,5,29)
work(m,{hand='detail',pile=stone,coverage=2,load=.7,clip=true,fill=true,tool='filbert 5',angle=0})
work(poly(top)*m,{hand='detail',pile=midstone,coverage=1.6,load=.65,clip=true,tool='filbert 3',angle=0})
end
rock({{351,619},{366,608},{389,610},{398,622},{390,630},{359,629}},{{352,618},{366,609},{388,611},{378,619}})
rock({{407,622},{419,612},{438,615},{444,631},{426,635},{409,631}},{{408,621},{419,613},{436,616},{426,622}})
rock({{462,611},{476,604},{500,607},{508,618},{502,628},{469,626}},{{464,611},{477,605},{498,608},{490,616},{471,617}})
rock({{512,622},{526,612},{548,615},{556,631},{539,637},{516,633}},{{514,621},{526,613},{547,616},{536,624}})
rock({{584,625},{601,615},{625,620},{631,633},{616,639},{589,635}},{{586,624},{602,616},{624,621},{608,628}})
rock({{648,638},{663,629},{680,633},{688,641},{675,649},{652,647}},{{650,637},{664,630},{679,634},{668,640}})
rock({{271,653},{289,648},{307,653},{303,662},{279,665}},{{273,653},{289,649},{306,653},{294,657}})
rock({{724,672},{739,659},{764,662},{778,675},{767,686},{730,683}},{{726,671},{740,660},{762,663},{751,673}})

--@ chunk 10
-- submerge the surplus fragments and break the regular spacing
local bury=poly{{398,605},{444,607},{452,636},{429,644},{401,637}}+poly{{640,627},{682,623},{700,649},{674,657},{643,651}}+poly{{263,643},{306,644},{319,661},{300,673},{270,671}}
work(bury:soften(4),{hand='body',pile=near,tool={kind='filbert',width=14,stiffness=.25},coverage=3,load=.8,clip=true,fill=true,angle=0,length={30,65}})
-- shadowed broken faces, left visible upper rims
local faces=poly{{350,621},{370,621},{380,617},{394,620},{400,633},{356,635}}+poly{{469,617},{491,614},{507,618},{509,631},{469,631}}+poly{{515,626},{536,626},{550,620},{559,635},{539,642},{514,636}}+poly{{586,628},{609,627},{627,623},{634,637},{614,643},{585,639}}+poly{{727,675},{751,672},{768,669},{780,677},{769,691},{725,687}}
work(faces:roughen(.8,5,65),{hand='detail',pile=near,tool='filbert 5',coverage=2,load=.7,clip=true,fill=true,angle=0})

--@ chunk 11
wait(4320)
work(poly{{257,638},{305,638},{325,660},{300,678},{266,676}}:soften(5),{hand='body',pile=near,tool={kind='filbert',width=14,stiffness=.25},coverage=3,load=.8,clip=true,fill=true,angle=0,length={30,65}})

--@ chunk 12
kept=poly{{350,618},{366,607},{389,610},{396,620},{389,627},{355,626}}+poly{{461,610},{476,603},{500,607},{506,618},{497,625},{466,623}}+poly{{511,622},{526,611},{548,615},{553,627},{538,633},{515,631}}+poly{{584,624},{601,614},{625,620},{629,630},{614,636},{587,632}}
work(shore-ruin-kept,{hand='broad',tool={kind='filbert',width=25,stiffness=.25},pile=near,coverage=3,load=.8,clip=true,fill=true,angle=0,length={60,100},ruler=true,curve={0,0},drift={0,300}})

--@ chunk 13
cloudveil=pile{{'lead white',6},{'cobalt blue',1.3},{'raw umber',.8},{'bone black',.6},thinner=.45}
local bank=poly({{-30,134},{87,143},{184,138},{275,152},{351,149},{453,168},{545,165},{622,183},{703,190},{758,208},{652,206},{571,193},{480,199},{378,184},{283,188},{177,171},{68,179},{-30,168}},true):soften(16)
stipple(bank,{pile=cloudveil,width=2.5,coverage=.8,pressure={.2,.5},feather=1,clip=true,dips={12,.6,.95}})
local thinbank=poly({{628,260},{696,249},{774,254},{840,246},{925,260},{1030,254},{1030,282},{939,278},{852,283},{762,271},{687,274}},true):soften(16)
stipple(thinbank,{pile=cloudveil,width=2.5,coverage=.8,pressure={.2,.5},feather=1,clip=true,dips={12,.6,.95}})

--@ chunk 14
wait(4320)
earthlight=mix{{near,4},{stone,1}}
earthbrush=brush{kind='filbert',width=10,stiffness=.65};earthbrush:load(earthlight,.35);earthbrush:gesture({{175,671,.2},{203,669,.55},{227,673,.2},{245,672,0}})
ripple=mix{{water,2},{warm,1}}
waterbrush=brush{kind='filbert',width=2.5,stiffness=.3};waterbrush:load(ripple,.6);waterbrush:stroke({{125,563},{164,563},{188,563.5}},{pressure={.5,.15}})

--@ chunk 15
earthlight2=mix{{near,1},{stone,1}}
earthbrush:reload(earthlight2,.6);earthbrush:gesture({{83,649,.2},{109,645,.7},{145,647,.5},{177,645,0}})
waterbrush:reload(ripple,.6);waterbrush:stroke({{659,559},{692,559.5},{730,559}},{pressure={.5,.15}})

--@ chunk 16
wait(4320)
stipple(poly{{443,538},{466,539},{464,587},{438,586}}*ruin,{pile=near,width=1.1,coverage=.35,pressure={.18,.45},clip=true,dips={12,.45,.95},cluster={.5,5}})
work(poly{{30,652},{73,645},{103,642},{127,645},{169,642},{197,649},{177,655},{137,655},{111,659},{66,655}},{hand='detail',pile=earthlight,tool='filbert 6',coverage=2,load=.6,clip=true,fill=true,angle=0})

--@ chunk 17
stipple(ruin-rect(438,538,28,50),{pile=near,width=1.1,coverage=.25,pressure={.18,.45},clip=true,dips={12,.45,.95},cluster={.5,5}})
-- a few fissures stop within the stones
fine=brush{kind='rigger',width=1.1,point=1,stiffness=.45}
local cracks={{{454,457},{459,463},{456,470},{459,477}},{{558,447},{562,451},{559,455},{560,459}},{{541,398},{538,404},{540,409}},{{447,572},{452,576},{451,581}},{{520,366},{516,371},{519,374}},{{568,549},{565,554},{568,558}}}
for _,pts in ipairs(cracks) do fine:reload(near,.55);fine:stroke(pts,{pressure={.55,0},clip=ruin}) end
-- very low, broad strata keep the foreground shallow
local strata=poly{{0,687},{66,680},{115,684},{145,681},{190,692},{242,696},{214,705},{146,699},{92,702},{24,697},{0,700}}+poly{{647,657},{701,650},{731,654},{773,650},{817,656},{858,659},{835,665},{789,662},{742,667},{687,662}}+poly{{783,702},{818,689},{854,686},{899,691},{938,687},{1000,698},{1000,713},{927,707},{887,711},{850,703}}
work(strata,{hand='detail',pile=earthlight,tool='filbert 6',coverage=2,load=.6,clip=true,fill=true,angle=0})
-- interrupted light along the still surface; each interval independently drawn
local ripples={{{24,550},{57,550},{81,550.3}},{{218,551},{243,551.2},{268,551}},{{319,566},{346,565.8},{377,566}},{{190,586},{220,585.5},{263,586}},{{23,596},{70,596}},{{619,573},{647,573.2},{672,573}},{{754,549},{778,549.4},{802,549}},{{850,565},{886,565},{916,564.7}},{{734,595},{774,595.4},{808,595}},{{941,584},{974,584},{999,583.6}},{{486,555},{503,555},{529,555.2}}}
for _,pts in ipairs(ripples) do waterbrush:reload(ripple,.6);waterbrush:stroke(pts,{pressure={.5,.15},clip=-ruin}) end

--@ chunk 18
local continuations={{{558,443},{558,447}},{{560,459},{564,462},{565,465}},{{562,451},{566,452},{570,449}},{{568,545},{568,549}},{{568,558},{570,561},{574,564}},{{447,566},{447,572}},{{451,581},{449,585}},{{452,576},{457,576},{460,579}},{{454,455},{454,457}},{{456,470},{451,469},{447,472}},{{541,395},{541,398}},{{540,409},{542,412}},{{523,361},{520,366}},{{519,374},{524,378}}}
for _,pts in ipairs(continuations) do fine:reload(near,.5);fine:stroke(pts,{pressure={.33,.1},clip=ruin}) end

--@ chunk 19
wait(4320)
print('stone',drying(530,621),'earth',drying(558,637))
local dimstone=kept*rect(510,605,48,34)
work(dimstone,{hand='detail',tool={kind='filbert',width=5,stiffness=.25},pile=earthlight,coverage=3,load=.8,clip=true,fill=true,angle=0,length={8,16},ruler=true,curve={0,0}})

--@ chunk 20
local chip=poly{{360,615},{369,609},{383,611},{379,615},{369,617}}
local leftdim=kept*rect(345,600,55,35)-chip
work(leftdim,{hand='detail',tool={kind='filbert',width=5,stiffness=.25},pile=earthlight,coverage=3,load=.8,clip=true,fill=true,angle=0,length={8,16},ruler=true,curve={0,0}})
wait(4320)
print(drying(530,621),drying(362,620))

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
