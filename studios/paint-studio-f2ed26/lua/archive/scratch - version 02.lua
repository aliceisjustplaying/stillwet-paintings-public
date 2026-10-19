-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.4, um=60}, {apply="brush", pile={{"lead white", 10}, {"yellow ochre", 0.7}, {"raw umber", 0.25}}, um=35}}, linen={15, 13}, seed=1822, size=700}

--@ chunk 2
s3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.2}}
s4 = pile{{"lead white",6},{"Naples yellow",2.5},{"chrome yellow",0.6}}
s5 = pile{{"lead white",7},{"Naples yellow",2},{"chrome yellow",1},{"vermilion",0.12}}
s6 = pile{{"lead white",6},{"Naples yellow",2},{"chrome yellow",0.8},{"vermilion",0.35}}
local function ye(x, y) return y - 60 * (1 - math.exp(-((x - 500) / 380)^2)) end
local function g(c, w) return function(x, y) local yy = ye(x, y); return math.exp(-((yy - c) / w)^2) end end
local P = {{s3, g(310, 55)},{s4, g(400, 50)},{s5, g(485, 42)},{s6, g(550, 30)}}
local m = rect(0, 250, 1000, 328)
work(m, {hand="broad", piles=P, angle=0, coverage=2, clip=true, seed=31})
work(m, {hand="broad", piles=P, angle=0, coverage=1.5, fill=true, clip=true, seed=32})
blend(m, {angle=0})
wait(3*24*60)
n3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.2}, medium=0.1}
n4 = pile{{"lead white",6},{"Naples yellow",2.6},{"chrome yellow",0.3},{"yellow ochre",0.15}, medium=0.1}
n5 = pile{{"lead white",6.5},{"Naples yellow",2.4},{"chrome yellow",0.5},{"vermilion",0.18}, medium=0.1}
n6 = pile{{"lead white",6},{"Naples yellow",2.2},{"chrome yellow",0.35},{"vermilion",0.45},{"rose madder",0.06}, medium=0.1}
local P2 = {{n3, g(310, 55)},{n4, g(400, 50)},{n5, g(480, 40)},{n6, g(545, 28)}}
work(m, {hand="broad", piles=P2, angle=0, angle_jitter=0.03, curve={0.02, 0}, coverage=2, fill=true, clip=true, seed=91})
blend(m, {angle=0, seed=92})
blend(m, {angle=0, seed=93})
-- mountains and a few twigs
local mpts = {{-10,524},{90,513},{185,502},{262,496},{300,493},{356,497},{418,511},{475,521},{500,523},{560,518},{630,507},{705,499},{742,497},{805,502},{880,512},{970,521},{1010,524}}
local mtA = pile{{"lead white",2},{"smalt",2},{"cobalt blue",0.3},{"rose madder",0.25},{"raw umber",0.45}}
local mtB = pile{{"lead white",5},{"smalt",1},{"rose madder",0.12},{"Naples yellow",1.0}}
work(below(mpts) * above(function(x) return 590 end), {hand="body", tool={kind="filbert", width=6}, piles={{mtA, function(x,y) return 1 - smoothstep(512, 575, y) end},{mtB, function(x,y) return smoothstep(512, 575, y) end}}, angle=0, coverage=2.5, fill=true, clip=true})
tw1 = pile{{"bone black",2},{"raw umber",1.5},{"smalt",0.8}, medium=0.15}
local r = brush{kind="rigger", width=2, point=1}
for i = 1, 8 do r:load(tw1, 0.9); local x = 60 + i * 110; r:gesture({{x, 500, r:pressure_for(2.4)}, {x + 8, 440, r:pressure_for(2.0)}, {x - 4, 380, r:pressure_for(1.4)}, {x + 6, 320, r:pressure_for(0.6)}}) end
wait(30*24*60)
print(drying(500, 450), drying(500,540))

--@ chunk 3
gW1 = pile{{"rose madder",1},{"vermilion",0.15},{"chrome yellow",0.4}, medium=0.93, name="gW1"}
local function w(x, y) return smoothstep(410, 505, y) * (1 - 0.6 * smoothstep(80, 450, math.abs(x - 500))) end
local area = rect(0, 330, 1000, 200)
local zone = above(function(x) return 528 end) * mask(function(x,y) return smoothstep(380, 440, y) end)
-- left half load .12 ; right half load .22
work(zone * rect(0,0,495,741), {hand="glaze", pile=gW1, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.01 + 0.12 * w(x,y) end, clip=rect(0,0,495,741) * above(function(x) return 528 end), seed=41})
work(zone * rect(505,0,495,741), {hand="glaze", pile=gW1, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.01 + 0.22 * w(x,y) end, clip=rect(505,0,495,741) * above(function(x) return 528 end), seed=42})
blend(rect(0, 330, 1000, 200), {angle=0, seed=43})
