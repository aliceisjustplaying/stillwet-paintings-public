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
local tr = pile{{"bone black",2},{"raw umber",1.5},{"smalt",0.8}, medium=0.15}
local r = brush{kind="rigger", width=2, point=1}
for i = 1, 6 do r:load(tr, 0.9); local x = 80 + i * 140; r:gesture({{x, 520, 0.9}, {x + 10, 400, 0.8}, {x - 5, 280, 0.7}, {x + 8, 170, 0.5}}) end
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
-- T1 (left): one glaze, cooler (less madder), graded deep at top, light veil through the mid sky; blend x3
gT = pile{{"smalt",3},{"cobalt blue",1.2},{"rose madder",0.25},{"bone black",0.4}, medium=0.9, name="gT"}
local fade = function(x, y) return 1 - smoothstep(0, 430, y) end
local L = rect(0, 0, 495, 470)
work(L, {hand="glaze", pile=gT, angle=0, load_at=function(x,y) return 0.02 + 0.75 * fade(x,y)^1.3 end, clip=true, seed=1})
blend(L, {angle=0, seed=2}); blend(L, {angle=0.04, seed=3}); blend(L, {angle=-0.03, seed=4})
-- T2 (right): same pile at half load, will repeat after drying
local R = rect(505, 0, 495, 470)
work(R, {hand="glaze", pile=gT, angle=0, load_at=function(x,y) return 0.02 + 0.4 * fade(x,y)^1.3 end, clip=true, seed=5})
blend(R, {angle=0, seed=6}); blend(R, {angle=0.04, seed=7})

--@ chunk 4
wait(6*24*60)
print(drying(200,100), drying(700,100))
gT2 = pile{{"smalt",3},{"cobalt blue",1.2},{"rose madder",0.25},{"bone black",0.5}, medium=0.85, name="gT2"}
local fade = function(x, y) return 1 - smoothstep(0, 400, y) end
local L = rect(0, 0, 495, 470)
work(L, {hand="glaze", pile=gT2, angle=0, load_at=function(x,y) return 0.02 + 0.8 * fade(x,y)^1.5 end, clip=true, seed=11})
blend(L, {angle=0, seed=12}); blend(L, {angle=0.04, seed=13}); blend(L, {angle=-0.03, seed=14})
local R = rect(505, 0, 495, 470)
work(R, {hand="glaze", pile=gT, angle=0, load_at=function(x,y) return 0.02 + 0.6 * fade(x,y)^1.3 end, clip=true, seed=15})
blend(R, {angle=0, seed=16}); blend(R, {angle=0.04, seed=17}); blend(R, {angle=-0.03, seed=18})

--@ chunk 5
wait(6*24*60)
gH = pile{{"smalt",3},{"cobalt blue",1.2},{"rose madder",0.25},{"bone black",0.5}, medium=0.92, name="gH"}
local fade = function(x, y) return 1 - smoothstep(0, 420, y) end
local R = rect(505, 0, 495, 470)
work(R, {hand="glaze", pile=gH, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.02 + 0.6 * fade(x,y)^1.4 end, clip=true, seed=21})
blend(R, {angle=0, seed=22}); blend(R, {angle=0, seed=23})
