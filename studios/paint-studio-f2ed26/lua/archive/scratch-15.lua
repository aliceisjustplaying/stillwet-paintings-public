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
tw1 = pile{{"bone black",2},{"raw umber",1.5},{"smalt",0.8}, medium=0.15}
local r = brush{kind="rigger", width=2, point=1}
for i = 1, 12 do
  r:load(tw1, 0.9)
  local x = 60 + i * 70
  r:gesture({{x, 420, r:pressure_for(2.6)}, {x + 8, 330, r:pressure_for(2.0)}, {x - 4, 240, r:pressure_for(1.4)}, {x + 6, 150, r:pressure_for(0.6)}})
end
wait(12*24*60)
local fade = function(x, y) return 1 - smoothstep(40, 330, y) end
local mm = rect(0, 0, 1000, 430)
gl93 = pile{{"smalt",2},{"cobalt blue",2},{"rose madder",0.5},{"bone black",0.25}, medium=0.93}
work(mm, {hand="glaze", pile=gl93, angle=0, load_at=function(x,y) return 0.03 + 0.6 * fade(x,y) end, clip=true, seed=111})
blend(mm, {angle=0, seed=112}); blend(mm, {angle=0.05, seed=113})
wait(5*24*60)
gH = pile{{"smalt",3},{"cobalt blue",1.2},{"rose madder",0.25},{"bone black",0.5}, medium=0.92}
local fade2 = function(x, y) return 1 - smoothstep(0, 420, y) end
local m2 = rect(0, 0, 1000, 470)
work(m2, {hand="glaze", pile=gH, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.02 + 0.6 * fade2(x,y)^1.4 end, clip=true, seed=161})
blend(m2, {angle=0, seed=162}); blend(m2, {angle=0, seed=163})
wait(4*24*60)
gH3 = pile{{"smalt",3},{"cobalt blue",1.2},{"rose madder",0.25},{"bone black",0.55}, medium=0.86}
local fade3 = function(x, y) return 1 - smoothstep(0, 400, y) end
work(m2, {hand="glaze", pile=gH3, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.02 + 0.7 * fade3(x,y)^1.5 end, clip=true, seed=171})
blend(m2, {angle=0, seed=172}); blend(m2, {angle=0, seed=173})
wait(6*24*60)
print(drying(500, 50), drying(300, 300))

--@ chunk 3
gP1 = pile{{"Prussian blue",1},{"smalt",1},{"bone black",0.6},{"raw umber",0.4}, medium=0.9, name="gP1"}
gP2 = pile{{"Prussian blue",1},{"bone black",0.8},{"raw umber",0.3}, medium=0.92, name="gP2"}
local fade = function(x, y) return 1 - smoothstep(0, 360, y) end
local L = rect(0, 0, 495, 470)
work(L, {hand="glaze", pile=gP1, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.02 + 0.7 * fade(x,y)^1.5 end, clip=true, seed=1})
blend(L, {angle=0, seed=2}); blend(L, {angle=0, seed=3})
local R = rect(505, 0, 495, 470)
work(R, {hand="glaze", pile=gP2, angle=0, ruler=true, length={300,500}, coverage=3, load_at=function(x,y) return 0.02 + 0.7 * fade(x,y)^1.5 end, clip=true, seed=4})
blend(R, {angle=0, seed=5}); blend(R, {angle=0, seed=6})
