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
-- a dark "tree" bar to see glaze over dark
local tr = pile{{"raw umber",2},{"bone black",2},{"smalt",0.6}}
work(ribbon({{500,400},{505,250},{498,120}}, 12) + ribbon({{180,380},{200,200}}, 5) + ribbon({{820,380},{800,180}}, 5), {hand="detail", pile=tr, coverage=3, fill=true})
wait(6*24*60)
print(drying(500,100), drying(500,300), drying(500,500), drying(500, 250))

--@ chunk 3
gl93 = pile{{"smalt",2},{"cobalt blue",2},{"rose madder",0.5},{"bone black",0.25}, medium=0.93, name="gl93"}
gl90 = pile{{"smalt",2},{"cobalt blue",2},{"rose madder",0.5},{"bone black",0.25}, medium=0.9, name="gl90"}
local fade = function(x, y) return 1 - smoothstep(40, 330, y) end
work(rect(0, 0, 330, 420), {hand="glaze", pile=gl93, angle=0, load_at=function(x,y) return 0.03 + 0.6 * fade(x,y) end, clip=true, seed=1})
blend(rect(0, 0, 330, 420), {angle=0, seed=4})
blend(rect(0, 0, 330, 420), {angle=0.05, seed=5})
work(rect(340, 0, 320, 420), {hand="glaze", pile=gl93, angle=0, load_at=function(x,y) return 0.03 + 0.6 * fade(x,y) end, clip=true, seed=2})
work(rect(670, 0, 330, 420), {hand="glaze", pile=gl90, angle=0, load_at=function(x,y) return 0.03 + 0.6 * fade(x,y) end, clip=true, seed=3})
blend(rect(670, 0, 330, 420), {angle=0, seed=6})
blend(rect(670, 0, 330, 420), {angle=0.05, seed=7})

--@ chunk 4
local mi = pile{{"lead white",8},{"Naples yellow",1.2},{"pale smalt",0.8}}
rgA = pile{{"raw umber",3},{"bone black",0.8},{"green earth",1},{"yellow ochre",0.4},{"smalt",0.3}}
rgB = pile{{"raw umber",3},{"bone black",1.4},{"green earth",0.6},{"smalt",0.4}}
rgC = pile{{"raw umber",2.5},{"bone black",2},{"smalt",0.6},{"rose madder",0.15}}
local rpts = {{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}}
local function ry(x) for i=1,#rpts-1 do local a,b=rpts[i],rpts[i+1]; if x>=a[1] and x<=b[1] then return lerp(a[2],b[2],(x-a[1])/(b[1]-a[1])) end end return 646 end
ryS = ry
work(below(function(x) return 578 end) - below(rpts), {hand="body", pile=mi, coverage=2, fill=true, clip=true})
local rm = below(rpts):roughen(1.0, 10, 19)
work(rm, {hand="body", tool={kind="filbert", width=10}, piles={
  {rgA, function(x,y) return 1 - smoothstep(10, 45, y - ry(x)) end},
  {rgB, function(x,y) return math.exp(-((y - ry(x) - 55)/30)^2) end},
  {rgC, function(x,y) return smoothstep(60, 120, y - ry(x)) end}}, angle=0, coverage=2.5, fill=true, clip=true, length={40,110}})
blend(rm:shrink(2), {angle=0})
wait(8*24*60)
print(drying(500, 650), drying(300, 600))

--@ chunk 5
local rpts = {{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}}
local rm = below(rpts):roughen(1.0, 10, 19)
gC = pile{{"raw umber",2},{"green earth",1.6},{"bone black",0.5},{"yellow ochre",0.35},{"lead white",0.35},{"smalt",0.35}, name="g_crest"}
gB = pile{{"raw umber",3},{"bone black",1.3},{"green earth",0.9},{"smalt",0.3},{"yellow ochre",0.2}, name="g_body"}
gD = pile{{"raw umber",2.5},{"bone black",2.2},{"smalt",0.5},{"rose madder",0.15}, name="g_dark"}
-- left half: grassy short strokes graded by depth below crest
local L = rm * rect(0, 0, 500, 741)
work(L, {hand="body", tool={kind="filbert", width=4}, piles={
  {gC, function(x,y) return 1 - smoothstep(4, 30, y - ryS(x)) end},
  {gB, function(x,y) return math.exp(-((y - ryS(x) - 45)/30)^2) end},
  {gD, function(x,y) return smoothstep(50, 110, y - ryS(x)) end}},
  angle=function(x,y) return -math.pi/2 + 0.25 end, angle_jitter=0.35, length={5,14}, coverage=1.6, clip=true, scale_at=function(x,y) return 0.6 + 1.2 * smoothstep(0, 140, y - ryS(x)) end})

--@ chunk 6
local rpts = {{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}}
local rm = below(rpts):roughen(1.0, 10, 19)
local R = rm * rect(500, 0, 500, 741) * mask(function(x,y) return 1 - smoothstep(30, 70, y - ryS(x)) end)
work(R, {hand="body", tool={kind="filbert", width=3.5}, piles={
  {gC, function(x,y) return 1 - smoothstep(3, 22, y - ryS(x)) end},
  {gB, function(x,y) return smoothstep(10, 40, y - ryS(x)) end}},
  angle=function(x,y) return -math.pi/2 + 0.2 end, angle_jitter=0.3, length={4,10}, coverage=1.3, clip=rm, hug=false})
-- grass blades on the crest
local r = brush{kind="rigger", width=1.2, point=1}
gS = pile{{"raw umber",2},{"bone black",1.5},{"green earth",0.8}, medium=0.1}
for i = 1, 40 do
  local x = rand(620, 980)
  local y = ryS(x) + rand(1, 3)
  if i % 8 == 1 then r:load(gS, 0.8) end
  local h = rand(4, 12)
  local a = -math.pi/2 + randn(0, 0.3)
  r:gesture({{x, y, 0.8}, {x + math.cos(a)*h*0.5, y + math.sin(a)*h*0.5, 0.6}, {x + math.cos(a+0.1)*h, y + math.sin(a+0.1)*h, 0.3}})
end
