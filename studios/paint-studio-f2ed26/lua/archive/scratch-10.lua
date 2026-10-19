-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.4, um=60}, {apply="brush", pile={{"lead white", 10}, {"yellow ochre", 0.7}, {"raw umber", 0.25}}, um=35}}, linen={15, 13}, seed=1822, size=700}

--@ chunk 2
local mi = pile{{"lead white",8},{"Naples yellow",1.2},{"pale smalt",0.8}}
rgA = pile{{"raw umber",3},{"bone black",0.8},{"green earth",1},{"yellow ochre",0.4},{"smalt",0.3}}
rgB = pile{{"raw umber",3},{"bone black",1.4},{"green earth",0.6},{"smalt",0.4}}
rgC = pile{{"raw umber",2.5},{"bone black",2},{"smalt",0.6},{"rose madder",0.15}}
rpts = {{0,642},{120,634},{250,620},{380,604},{460,597},{500,595},{560,597},{650,606},{780,622},{900,636},{1000,646}}
function ryS(x) for i=1,#rpts-1 do local a,b=rpts[i],rpts[i+1]; if x>=a[1] and x<=b[1] then return lerp(a[2],b[2],(x-a[1])/(b[1]-a[1])) end end return 646 end
work(below(function(x) return 540 end) - below(rpts), {hand="body", pile=mi, coverage=2, fill=true, clip=true})
rmS = below(rpts):roughen(1.0, 10, 19)
work(rmS, {hand="body", tool={kind="filbert", width=10}, piles={
  {rgA, function(x,y) return 1 - smoothstep(10, 45, y - ryS(x)) end},
  {rgB, function(x,y) return math.exp(-((y - ryS(x) - 55)/30)^2) end},
  {rgC, function(x,y) return smoothstep(60, 120, y - ryS(x)) end}}, angle=0, coverage=2.5, fill=true, clip=true, length={40,110}})
blend(rmS:shrink(2), {angle=0})
-- a trunk like the painting's
local tr = pile{{"raw umber",2},{"bone black",2},{"smalt",0.6}}
work(ribbon({{500,612},{499,588},{496,562},{497,538},{501,500}}, {64,52,48,48,50}) + poly({{430,616},{458,606},{468,592},{532,592},{542,606},{574,615},{548,619},{500,616},{454,619}}, true), {hand="detail", pile=tr, coverage=3, fill=true})
wait(10*24*60)
print(drying(500, 650), drying(300, 600), drying(500,580))

--@ chunk 3
wait(5*24*60)
print(drying(500,580))
gB = pile{{"raw umber",3},{"bone black",1.3},{"green earth",0.9},{"smalt",0.3},{"yellow ochre",0.2}, name="g_body"}
gR = pile{{"raw umber",2},{"green earth",1.6},{"bone black",0.6},{"yellow ochre",0.25},{"lead white",0.12},{"smalt",0.3}, name="g_rim"}
gD = pile{{"raw umber",2.5},{"bone black",2.2},{"smalt",0.5},{"rose madder",0.15}, name="g_dark"}
gS = pile{{"raw umber",2},{"bone black",1.6},{"green earth",0.8}, medium=0.1, name="g_blade"}
-- grassy texture only near the crest, left part
local band = rmS * rect(0, 0, 420, 741) * mask(function(x,y) return 1 - smoothstep(25, 55, y - ryS(x)) end)
work(band, {hand="body", tool={kind="filbert", width=3}, piles={
  {gR, function(x,y) return 1 - smoothstep(2, 16, y - ryS(x)) end},
  {gB, function(x,y) return smoothstep(6, 30, y - ryS(x)) end}},
  angle=function(x,y) return -math.pi/2 + 0.15 end, angle_jitter=0.3, length={4,9}, coverage=1.0, clip=rmS, hug=false, seed=3})
-- tufts
function tuft(b, x, y, n, h, lean)
  for i = 1, n do
    local hh = h * rand(0.45, 1.0)
    local a = -math.pi/2 + lean + randn(0, 0.35)
    local bend = randn(0, 0.25)
    local x0 = x + randn(0, 1.2)
    local p1 = {x0 + math.cos(a)*hh*0.5, y + math.sin(a)*hh*0.5}
    local p2 = {x0 + math.cos(a+bend)*hh, y + math.sin(a+bend)*hh}
    b:gesture({{x0, y + 1.5, 0.75}, {p1[1], p1[2], 0.55}, {p2[1], p2[2], 0.15}}, {wobble=0.1})
  end
end
local r = brush{kind="rigger", width=1.2, point=1}
r:load(gS, 0.9)
for _, c in ipairs({{40, 6, 7}, {95, 9, 9}, {150, 5, 6}, {230, 8, 10}, {262, 4, 5}, {330, 7, 8}, {380, 10, 9}, {410, 5, 6}}) do
  if r:fullness() < 0.5 then r:load(gS, 0.9) end
  tuft(r, c[1], ryS(c[1]) + 1, c[2], c[3], randn(0.1, 0.15))
end

--@ chunk 4
gL = pile{{"raw umber",1.5},{"green earth",1.5},{"lead white",0.6},{"smalt",0.5},{"yellow ochre",0.2}, thinner=0.4, name="g_light_crest"}
local band = rmS * rect(560, 0, 440, 741) * mask(function(x,y) return 1 - smoothstep(4, 40, y - ryS(x)) end)
work(band, {hand="body", tool={kind="filbert", width=8}, pile=gL, angle=function(x,y) return math.atan(ryS(x+5)-ryS(x-5), 10) end, length={30,70}, coverage=1.2, clip=rmS, hug=false, pressure={0.3,0.5}, seed=5})
blend(rmS * rect(560,0,440,741) * mask(function(x,y) return 1 - smoothstep(30, 60, y - ryS(x)) end), {angle=0.1, seed=6})
local r = brush{kind="rigger", width=1.2, point=1}
r:load(gS, 0.9)
for _, c in ipairs({{600, 14, 14}, {640, 8, 9}, {700, 18, 16}, {760, 6, 8}, {820, 12, 13}, {870, 9, 10}, {930, 16, 15}, {975, 7, 9}}) do
  if r:fullness() < 0.5 then r:load(gS, 0.9) end
  tuft(r, c[1], ryS(c[1]) + 1, c[2], c[3], randn(0.15, 0.15))
end

--@ chunk 5
function fringe(b, pile, x0, x1, opts)
  opts = opts or {}
  local xs = uneven(opts.n or 80, x0, x1, opts.irregular or 0.7, opts.clump or 0.6, opts.seed or 1)
  local count = 0
  for _, x in ipairs(xs) do
    count = count + 1
    if count % 10 == 1 then b:load(pile, 0.8) end
    local y = ryS(x) + 1.5
    local hmax = (opts.h or 6)
    local hh = hmax * (0.3 + 0.7 * math.random() ^ 1.5)
    local a = -math.pi/2 + (opts.lean or 0.1) + randn(0, 0.28)
    local bend = randn(0, 0.2)
    b:gesture({{x, y, 0.7}, {x + math.cos(a)*hh*0.55, y + math.sin(a)*hh*0.55, 0.5}, {x + math.cos(a+bend)*hh, y + math.sin(a+bend)*hh, 0.1}}, {wobble=0.05})
  end
end
local r = brush{kind="rigger", width=1.0, point=1}
fringe(r, gS, 0, 410, {n=140, h=7, seed=2})
