-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.4, um=60}, {apply="brush", pile={{"lead white", 10}, {"yellow ochre", 0.7}, {"raw umber", 0.25}}, um=35}}, linen={15, 13}, seed=1822, size=700}

--@ chunk 2
local skyA = pile{{"smalt",3},{"cobalt blue",1},{"lead white",2}}
local skyB = pile{{"lead white",6},{"Naples yellow",2.5},{"chrome yellow",0.6}}
local mt = pile{{"lead white",3},{"smalt",1},{"rose madder",0.3},{"raw umber",0.3}}
local mist = pile{{"lead white",6},{"Naples yellow",1},{"smalt",0.4}}
local dk = pile{{"raw umber",3},{"bone black",1.5},{"smalt",1}}
local ridge = below(ridge_pts or {{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}})
local mp = {{0,522},{80,512},{160,502},{240,496},{300,494},{350,498},{410,510},{460,520},{500,524},{540,522},{600,514},{660,506},{720,500},{770,499},{830,505},{900,514},{1000,524}}
local mts = below(mp) * above(function(x) return 560 end)
work(rect(0,0,1000,600), {hand="broad", piles={{skyA, function(x,y) return math.max(0, 1 - y/350) end},{skyB, function(x,y) return math.min(1, y/350) end}}, angle=0, coverage=2, fill=true, clip=true})
work(below(function(x) return 555 end) - below({{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}}), {hand="body", pile=mist, angle=0, coverage=2, fill=true, clip=true})
work(mts, {hand="body", pile=mt, angle=0, coverage=2, fill=true, clip=true})
local rp = {{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}}
work(below(rp), {hand="body", pile=dk, angle=0, coverage=2, fill=true, clip=true})
-- tree, rough
local t = ribbon({{500,610},{501,560},{500,520},{500,485}}, {44,34,30,28})
local boughs = {
 {{{492,488},{440,470},{380,455},{330,430},{290,400},{262,385}}, {16,12,9,6,4,2}},
 {{{495,478},{470,420},{445,360},{430,300},{410,250},{395,215}}, {18,13,10,7,4,2}},
 {{{502,475},{508,410},{500,340},{510,270},{505,200},{512,150}}, {20,15,11,8,5,2}},
 {{{508,480},{545,430},{575,370},{600,310},{630,250},{650,210}}, {18,13,10,7,4,2}},
 {{{510,490},{570,478},{630,460},{680,430},{720,405},{745,395}}, {16,12,9,6,4,2}},
}
for _, bb in ipairs(boughs) do t = t + ribbon(bb[1], bb[2]) end
work(t, {hand="detail", pile=dk, coverage=3, fill=true})
