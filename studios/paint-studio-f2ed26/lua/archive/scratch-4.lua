-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.4, um=60}, {apply="brush", pile={{"lead white", 10}, {"yellow ochre", 0.7}, {"raw umber", 0.25}}, um=35}}, linen={15, 13}, seed=1822, size=700}

--@ chunk 2
s0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1},{"rose madder",0.12},{"bone black",0.3}, name="s0_zenith"}
s1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}, name="s1_blue"}
s2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}, name="s2_paleblue"}
s3 = pile{{"lead white",8},{"pale smalt",0.6},{"Naples yellow",1.2},{"green earth",0.2}, name="s3_neutral"}
s4 = pile{{"lead white",6},{"Naples yellow",2.5},{"chrome yellow",0.6}, name="s4_yellow"}
s5 = pile{{"lead white",7},{"Naples yellow",2},{"chrome yellow",1},{"vermilion",0.12}, name="s5_glow"}
s6 = pile{{"lead white",6},{"Naples yellow",2},{"chrome yellow",0.8},{"vermilion",0.35}, name="s6_horizon"}
local function ye(x, y) return y - 60 * (1 - math.exp(-((x - 500) / 380)^2)) end
local function g(c, w) return function(x, y) local yy = ye(x, y); return math.exp(-((yy - c) / w)^2) end end
local P = {{s0, g(-10, 75)},{s1, g(110, 75)},{s2, g(220, 65)},{s3, g(310, 55)},{s4, g(400, 50)},{s5, g(485, 42)},{s6, g(550, 30)}}
local m = rect(0, 0, 1000, 578)
work(m, {hand="broad", piles=P, angle=0, coverage=2, clip=true, seed=31})
work(m, {hand="broad", piles=P, angle=0, coverage=1.5, fill=true, clip=true, seed=32})
blend(m, {angle=0})
blend(rect(0, 0, 1000, 340):soften(40), {angle=0.03, seed=5})
wait(3*24*60)
print(drying(500,100), drying(500,500))

--@ chunk 3
v0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1},{"rose madder",0.12},{"bone black",0.3}, thinner=0.5, name="v0"}
v1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}, thinner=0.5, name="v1"}
v2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}, thinner=0.5, name="v2"}
local function g(c, w) return function(x, y) return math.exp(-((y - c) / w)^2) end end
local P = {{v0, g(-10, 75)},{v1, g(110, 75)},{v2, g(220, 65)}}
local m = rect(0, 0, 330, 300)
work(m, {hand="broad", piles=P, angle=0, coverage=1.5, clip=true, pressure={0.3,0.5}, seed=1})
blend(m, {angle=0})

--@ chunk 4
m0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1.2},{"rose madder",0.12},{"bone black",0.25}, medium=0.4, name="m0"}
m1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3},{"bone black",0.08}, medium=0.4, name="m1"}
m2 = pile{{"lead white",6},{"smalt",1},{"cobalt blue",0.4}, medium=0.4, name="m2"}
local function g(c, w) return function(x, y) return math.exp(-((y - c) / w)^2) end end
local P = {{m0, g(-10, 75)},{m1, g(110, 75)},{m2, g(220, 65)}}
local m = rect(660, 0, 340, 300)
work(m, {hand="broad", piles=P, angle=0, coverage=2, clip=true, pressure={0.4,0.7}, seed=2})
blend(m, {angle=0})

--@ chunk 5
st0 = pile{{"smalt",5},{"cobalt blue",1.2},{"lead white",1.4},{"rose madder",0.12},{"bone black",0.25}, thinner=0.3, name="st0"}
st1 = pile{{"smalt",3},{"cobalt blue",1},{"lead white",3.5},{"bone black",0.08}, thinner=0.3, name="st1"}
local m = rect(350, 0, 140, 300)
stipple(m * mask(function(x,y) return y < 120 and 1 or 0 end), {pile=st0, width=6, coverage=3, pressure={0.3,0.6}})
stipple(m * mask(function(x,y) return (y >= 120 and y < 300) and 1 or 0 end), {pile=st1, width=6, coverage=3, pressure={0.3,0.6}})
-- right half: stipple then blend lightly
local m2 = rect(500, 0, 150, 300)
stipple(m2 * mask(function(x,y) return y < 120 and 1 or 0 end), {pile=st0, width=6, coverage=3, pressure={0.3,0.6}})
stipple(m2 * mask(function(x,y) return (y >= 120 and y < 300) and 1 or 0 end), {pile=st1, width=6, coverage=3, pressure={0.3,0.6}})
blend(m2, {angle=0})
