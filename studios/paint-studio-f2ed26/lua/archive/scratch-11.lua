-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.4, um=60}, {apply="brush", pile={{"lead white", 10}, {"yellow ochre", 0.7}, {"raw umber", 0.25}}, um=35}}, linen={15, 13}, seed=1822, size=700}

--@ chunk 2
s0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1},{"rose madder",0.12},{"bone black",0.3}}
s1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}}
s2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}}
s3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.2}}
s4 = pile{{"lead white",6},{"Naples yellow",2.5},{"chrome yellow",0.6}}
s5 = pile{{"lead white",7},{"Naples yellow",2},{"chrome yellow",1},{"vermilion",0.12}}
s6 = pile{{"lead white",6},{"Naples yellow",2},{"chrome yellow",0.8},{"vermilion",0.35}}
local function ye(x, y) return y - 60 * (1 - math.exp(-((x - 500) / 380)^2)) end
local function g(c, w) return function(x, y) local yy = ye(x, y); return math.exp(-((yy - c) / w)^2) end end
local P = {{s0, g(-10, 75)},{s1, g(110, 75)},{s2, g(220, 65)},{s3, g(310, 55)},{s4, g(400, 50)},{s5, g(485, 42)},{s6, g(550, 30)}}
local m = rect(0, 0, 1000, 578)
work(m, {hand="broad", piles=P, angle=0, coverage=2, clip=true, seed=31})
work(m, {hand="broad", piles=P, angle=0, coverage=1.5, fill=true, clip=true, seed=32})
blend(m, {angle=0})
blend(rect(0, 0, 1000, 340):soften(40), {angle=0.03, seed=5})
wait(3*24*60)
n0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1},{"rose madder",0.12},{"bone black",0.3}, medium=0.1}
n1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}, medium=0.1}
n2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}, medium=0.1}
n3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.2}, medium=0.1}
n4 = pile{{"lead white",6},{"Naples yellow",2.6},{"chrome yellow",0.3},{"yellow ochre",0.15}, medium=0.1}
n5 = pile{{"lead white",6.5},{"Naples yellow",2.4},{"chrome yellow",0.5},{"vermilion",0.18}, medium=0.1}
n6 = pile{{"lead white",6},{"Naples yellow",2.2},{"chrome yellow",0.35},{"vermilion",0.45},{"rose madder",0.06}, medium=0.1}
local P2 = {{n0, g(-10, 75)},{n1, g(110, 75)},{n2, g(220, 65)},{n3, g(310, 55)},{n4, g(400, 50)},{n5, g(480, 40)},{n6, g(545, 28)}}
work(m, {hand="broad", piles=P2, angle=0, angle_jitter=0.03, curve={0.02, 0}, coverage=2, fill=true, clip=true, seed=91})
blend(m, {angle=0, seed=92})
blend(m, {angle=0, seed=93})
local tr = pile{{"raw umber",2},{"bone black",2},{"smalt",0.6}}
work(ribbon({{500,560},{505,350},{498,180}}, 12) + ribbon({{250,500},{270,200}}, 4) + ribbon({{750,500},{730,200}}, 4), {hand="detail", pile=tr, coverage=3, fill=true})
wait(10*24*60)
gl93 = pile{{"smalt",2},{"cobalt blue",2},{"rose madder",0.5},{"bone black",0.25}, medium=0.93}
local fade = function(x, y) return 1 - smoothstep(40, 330, y) end
local mm = rect(0, 0, 1000, 430)
work(mm, {hand="glaze", pile=gl93, angle=0, load_at=function(x,y) return 0.03 + 0.6 * fade(x,y) end, clip=true, seed=111})
blend(mm, {angle=0, seed=112})
blend(mm, {angle=0.05, seed=113})
wait(8*24*60)
print(drying(500,100), drying(500,300))

--@ chunk 3
-- left: deeper blue-violet glaze to y~400; right: same top plus a rose-violet "purple light" band in the mid sky
glD = pile{{"smalt",2.5},{"cobalt blue",1.5},{"rose madder",0.7},{"bone black",0.4}, medium=0.88, name="glD"}
glR = pile{{"rose madder",1.5},{"smalt",0.6},{"vermilion",0.08}, medium=0.9, name="glR"}
local topf = function(x, y) return 1 - smoothstep(20, 380, y) end
local L = rect(0, 0, 490, 470)
work(L, {hand="glaze", pile=glD, angle=0, load_at=function(x,y) return 0.02 + 0.7 * topf(x,y) end, clip=true, seed=1})
blend(L, {angle=0, seed=2}); blend(L, {angle=0.05, seed=3})
local R = rect(510, 0, 490, 470)
work(R, {hand="glaze", piles={{glD, function(x,y) return topf(x,y) end},{glR, function(x,y) return math.exp(-((y-310)/70)^2) end}}, angle=0,
  load_at=function(x,y) return 0.02 + 0.7 * math.max(topf(x,y), 0.5 * math.exp(-((y-310)/70)^2)) end, clip=true, seed=4})
blend(R, {angle=0, seed=5}); blend(R, {angle=0.05, seed=6})

--@ chunk 4
mtA = pile{{"lead white",2},{"smalt",2},{"cobalt blue",0.3},{"rose madder",0.25},{"raw umber",0.45}}
mtB = pile{{"lead white",5},{"smalt",1},{"rose madder",0.12},{"Naples yellow",1.0}}
rgB = pile{{"raw umber",3},{"bone black",1.4},{"green earth",0.6},{"smalt",0.4}}
local mpts = {{-10,524},{40,519},{90,513},{140,507},{185,502},{225,499},{262,496},{300,493},{330,494},{356,497},{385,503},{418,511},{448,517},{475,521},{500,523},{528,522},{560,518},{596,512},{630,507},{668,503},{705,499},{742,497},{775,498},{805,502},{840,507},{880,512},{925,517},{970,521},{1010,524}}
rpts = {{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}}
function ryS(x) for i=1,#rpts-1 do local a,b=rpts[i],rpts[i+1]; if x>=a[1] and x<=b[1] then return lerp(a[2],b[2],(x-a[1])/(b[1]-a[1])) end end return 646 end
local mm = below(mpts) * above(function(x) return 590 end)
work(mm, {hand="body", tool={kind="filbert", width=6}, piles={{mtA, function(x,y) return 1 - smoothstep(512, 575, y) end},{mtB, function(x,y) return smoothstep(512, 575, y) end}}, angle=0, coverage=2.5, fill=true, clip=true})
blend(mm:shrink(3), {angle=0})
-- mist A (as painting) everywhere first
mi1 = pile{{"lead white",8},{"Naples yellow",1.4},{"pale smalt",0.6},{"rose madder",0.05}}
mi2 = pile{{"lead white",7},{"pale smalt",1.2},{"Naples yellow",0.8},{"raw umber",0.15},{"rose madder",0.08}}
local mist = below(function(x) return 556 end) * above(function(x) return ryS(x) + 10 end)
work(mist, {hand="body", piles={{mi1, function(x,y) return 1 - smoothstep(565, 625, y) end},{mi2, function(x,y) return smoothstep(565, 625, y) end}}, angle=0, coverage=2.2, fill=true, clip=true, length={40,90}})
blend(rect(0, 540, 1000, 40):soften(6), {angle=0})
work(below(rpts), {hand="body", pile=rgB, coverage=2, fill=true, clip=true})
wait(15*24*60)
print(drying(500,560), drying(500,600), drying(500,650))

--@ chunk 5
mq1 = pile{{"lead white",8},{"Naples yellow",1.4},{"pale smalt",0.6},{"rose madder",0.05}, medium=0.05, name="mq1_top"}
mq2 = pile{{"lead white",6},{"pale smalt",1.2},{"rose madder",0.22},{"Naples yellow",0.6},{"raw umber",0.18}, medium=0.05, name="mq2_mid"}
mq3 = pile{{"lead white",4.5},{"smalt",0.9},{"pale smalt",0.6},{"rose madder",0.25},{"raw umber",0.4},{"Naples yellow",0.3}, medium=0.05, name="mq3_low"}
local mist = below(function(x) return 560 end) * above(function(x) return ryS(x) + 6 end) * rect(500, 0, 500, 741)
work(mist, {hand="body", piles={
  {mq1, function(x,y) return 1 - smoothstep(565, 595, y) end},
  {mq2, function(x,y) return math.exp(-((y-603)/16)^2) end},
  {mq3, function(x,y) return smoothstep(605, 635, y) end}}, angle=0, coverage=2.2, fill=true, clip=true, length={40,90}})
blend(mist, {angle=0})

--@ chunk 6
mq3 = pile{{"lead white",3},{"smalt",1},{"pale smalt",0.6},{"rose madder",0.3},{"raw umber",0.6},{"Naples yellow",0.3}, medium=0.05, name="mq3_low_b"}
wait(3*24*60)
local mist = below(function(x) return 560 end) * above(function(x) return ryS(x) + 6 end) * rect(750, 0, 250, 741)
work(mist, {hand="body", piles={
  {mq1, function(x,y) return 1 - smoothstep(568, 600, y) end},
  {mq2, function(x,y) return math.exp(-((y-603)/14)^2) end},
  {mq3, function(x,y) return smoothstep(600, 640, y) end}}, angle=0, coverage=2.2, fill=true, clip=true, length={40,90}})
blend(mist, {angle=0})

--@ chunk 7
wait(6*24*60)
gM = pile{{"smalt",2},{"rose madder",0.8},{"raw umber",0.6},{"bone black",0.1}, medium=0.85, name="glaze_mist"}
local zone = below(function(x) return 575 end) * above(function(x) return ryS(x) + 3 end) * rect(0, 0, 500, 741)
work(zone, {hand="glaze", pile=gM, angle=0, load_at=function(x,y) return 0.03 + 0.5 * smoothstep(580, 625, y) end, clip=true})
blend(zone, {angle=0})

--@ chunk 8
wait(10*24*60)
mz1 = pile{{"lead white",7},{"Naples yellow",1.1},{"pale smalt",0.8},{"rose madder",0.08}, medium=0.05, name="mz1"}
mz2 = pile{{"lead white",5},{"pale smalt",1.2},{"smalt",0.3},{"rose madder",0.2},{"raw umber",0.22},{"Naples yellow",0.45}, medium=0.05, name="mz2"}
mz3 = pile{{"lead white",4},{"smalt",0.7},{"pale smalt",0.8},{"rose madder",0.25},{"raw umber",0.45},{"Naples yellow",0.3}, medium=0.05, name="mz3"}
local mist = below(function(x) return 558 end) * above(function(x) return ryS(x) + 6 end) * rect(0, 0, 500, 741)
work(mist, {hand="body", piles={
  {mz1, function(x,y) return 1 - smoothstep(565, 592, y) end},
  {mz2, function(x,y) return math.exp(-((y-598)/14)^2) end},
  {mz3, function(x,y) return smoothstep(598, 630, y) end}}, angle=0, coverage=2.4, fill=true, clip=true, length={40,90}})
blend(mist:shrink(2), {angle=0})
