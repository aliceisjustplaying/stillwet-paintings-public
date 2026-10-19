-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}, name="haze"}
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}, name="amber"}
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}, name="glow"}
deeprust = pile{{"red earth",3},{"raw umber",2},{"yellow ochre",1}, name="deeprust"}
lent = pile{{"bone black",1},{"raw umber",1.2}, name="lent"}
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
fallwhite = pile{{"lead white",8},{"yellow ochre",0.25},{"cobalt blue",0.08}, name="fallwhite"}
brushdark = pile{{"raw umber",0.48},{"red earth",0.36},{"Prussian blue",0.07},{"yellow ochre",0.10}, name="brushdark"}
leafshade = pile{{"red earth",2},{"raw umber",2.5},{"vermilion",0.2}, name="leafshade"}
rim_warm = pile{{"yellow ochre",0.40},{"red earth",0.21},{"lead white",0.31},{"chrome yellow",0.05},{"vermilion",0.03}, name="rim_warm"}
foamsh = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.35},{"yellow ochre",0.1}, name="foamsh"}
lipglass = pile{{"lead white",4},{"chrome yellow",0.5},{"yellow ochre",0.6},{"raw umber",0.25}, name="lipglass"}
orangeleaf = pile{{"red earth",1},{"chrome yellow",1},{"vermilion",0.35},{"yellow ochre",0.5}, name="orangeleaf"}
crestPts = {{335,630},{345,622},{352,614},{362,619},{370,612},{380,626},{385,668},
  {434,669},{436,646},{441,637},{447,641},{451,655},
  {512,655},{514,643},{518,647},{520,676},
  {537,677},{540,651},{544,647},{548,663},
  {591,663},{594,645},{602,639},{612,643},{622,634},{636,641},{646,650}}
local rp = {}
for _, p in ipairs(crestPts) do rp[#rp+1] = {p[1], p[2]} end
rp[#rp+1] = {652, 760}; rp[#rp+1] = {330, 760}
rockFace = outline{pts=rp, char="broken", seed=6001, amount=0.25}:mask()
NS = {}
NS[1] = outline{{386,671},{410,668},{433,671},{437,700},{441,760},{445,830},{448,904},{354,904},{364,830},{373,760},{381,700}, char="broken", seed=6011, amount=0.45}:mask()
NS[2] = outline{{452,656},{482,652},{512,656},{515,700},{519,765},{528,805},{560,850},{600,904},{478,904},{470,830},{462,760},{456,700}, char="broken", seed=6012, amount=0.45}:mask()
NS[3] = outline{{520,678},{528,675},{537,678},{540,720},{547,762},{562,800},{572,904},{530,904},{525,800},{522,720}, char="broken", seed=6013, amount=0.4}:mask()
NS[4] = outline{{548,664},{570,660},{591,664},{595,710},{601,780},{609,850},{620,904},{552,904},{548,800},{546,760},{547,710}, char="broken", seed=6014, amount=0.45}:mask()
newFalls = (NS[1] + NS[2] + NS[3] + NS[4]) * above(function(x) return 760 end)
local bg = rect(250, 540, 500, 230)
work(bg, {hand="body", tool={kind="flat", width=10}, length={20,50}, coverage=4, fill=true, clip=true, angle=-math.pi/2,
  piles={{haze, 1}, {amber, 0.7}, {deeprust, 0.12}}})
blend(bg:shrink(4), {angle=math.pi/2})
local lb = poly({{250,600},{300,610},{332,640},{338,700},{250,700}}, true)
work(lb, {hand="body", tool={kind="filbert", width=6}, length={6,14}, coverage=4, fill=true, clip=true, piles={{leafshade,1},{brushdark,0.6},{deeprust,0.3}}})
local rb = poly({{640,600},{700,590},{750,600},{750,700},{648,700}}, true)
work(rb, {hand="body", tool={kind="filbert", width=6}, length={6,14}, coverage=4, fill=true, clip=true, piles={{orangeleaf,1},{deeprust,0.6}}})
work(rockFace - newFalls, {hand="body", tool={kind="filbert", width=6}, length={10,24}, coverage=4, fill=true, clip=true, angle=1.5, piles={{lent,1},{rock,0.7}}})
work(newFalls, {hand="body", tool={kind="flat", width=6}, length={20,50}, coverage=4, fill=true, clip=true, angle=math.pi/2, piles={{fallwhite,1},{foamsh,0.3}}})
local caps = newFalls * above(function(x) return 685 end)
work(caps, {hand="body", tool={kind="flat", width=5}, length={8,20}, coverage=3, fill=true, clip=true, angle=0, piles={{foamsh,1},{lipglass,0.4}}})
wait(40*24*60)
print(drying(480,620), drying(360,700), drying(480,700))

--@ chunk 3
newLine = {{326,676},{334,668},{346,659},{358,652},{370,649},{378,651},{383,658},{386,668},
  {410,667},{433,669},
  {437,662},{441,654},{445,651},{449,653},{452,655},
  {482,653},{512,655},
  {514,653},{517,652},{519,658},{521,676},
  {537,676},{539,666},{542,657},{545,656},{548,661},
  {570,660},{591,661},
  {596,663},{604,660},{614,658},{626,661},{640,668},{652,678},{664,692}}
function lineYf(pts, x)
  for i = 1, #pts - 1 do
    local a, b = pts[i], pts[i+1]
    if x >= a[1] and x <= b[1] then return lerp(a[2], b[2], (x - a[1]) / math.max(0.001, b[1] - a[1])) end
  end
  if x < pts[1][1] then return pts[1][2] end
  return pts[#pts][2]
end
local lineY = lineYf
aboveLine = mask(function(x, y)
  if x < 318 or x > 668 or y < 590 then return 0 end
  return (y < lineY(newLine, x)) and 1 or 0
end)
-- stream: thin, its top nearly level, lost into the haze
streamTop = {{384,660},{392,654},{408,648},{430,645},{455,642},{480,641},{505,640},{530,641},{560,644},{578,647},{590,653},{596,662}}
streamM = mask(function(x, y)
  if x < 384 or x > 596 then return 0 end
  local t = lineY(streamTop, x)
  local b = lineY(newLine, x)
  if y > b then return 0 end
  return clamp((y - t + 4) / 6, 0, 1)
end)
-- toes: small soft far-bank tongues at the two ends of the stream
toeL = outline{{356,650},{364,644},{376,641},{390,642},{404,645},{418,648},{426,652},{410,655},{396,660},{386,666},{370,656}, char="soft", seed=12101, amount=0.7, lobe=5}:mask() * aboveLine
toeR = outline{{548,652},{556,648},{568,646},{582,646},{596,648},{610,652},{622,657},{610,660},{598,664},{586,659},{570,656}, char="soft", seed=12102, amount=0.7, lobe=5}:mask() * aboveLine
oldRock = (rockFace * aboveLine):grow(2) * aboveLine
tanFix = oldRock - toeL - toeR - streamM:map(function(v) return v > 0.5 and 1 or 0 end)
print(streamM:area(), toeL:area(), toeR:area(), oldRock:area(), tanFix:area())

--@ chunk 4
local lineY = lineYf
local nz = noise{seed=12001, period=14, octaves=2}
-- a) tan where the old rock tops stood
work(tanFix, {hand="body", tool={kind="flat", width=6, stiffness=0.5}, length={10,30}, coverage=4, fill=true, clip=true, load=1.0,
  angle=-math.pi/2, piles={{haze, 1}, {amber, 0.72}, {deeprust, 0.13}}})
blend(tanFix:shrink(1), {angle=math.pi/2})
-- b) the stream: graded from the haze at its far edge to a cool sheen at the brink
local function depth(x, y) local t = lineY(streamTop, x); local b = lineY(newLine, x); return clamp((y - t) / math.max(4, b - t), 0, 1) end
local function sheen(x) return math.exp(-((x - 495)/80)^2) end
work(streamM, {hand="body", tool={kind="flat", width=4, stiffness=0.5}, length={10,30}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.03*nz(x,y) end,
  piles={{haze, function(x,y) return 0.6 + 0.8*clamp(1 - depth(x,y)*3, 0, 1) end},
         {amber, function(x,y) return 0.5*clamp(1 - depth(x,y)*3, 0, 1) end},
         {glow, function(x,y) return 0.8*clamp(depth(x,y)*2, 0, 1) end},
         {fallwhite, function(x,y) return 0.35*sheen(x)*clamp(depth(x,y)*1.5 - 0.3, 0, 1) end},
         {foamsh, function(x,y) return 0.25*clamp(depth(x,y), 0, 1) end}}})
blend(streamM:shrink(1), {angle=0.0})
print(drying(480,650))

--@ chunk 5
local lineY = lineYf
brinkLine = {{384,668},{410,667},{433,668},{440,664},{447,657},{452,655},{482,653},{512,655},{516,662},{521,675},{537,676},{542,668},{548,661},{570,660},{591,661}}
-- the stream reaches down to the continuous brink (covers the old post tips)
local fillDown = mask(function(x, y)
  if x < 386 or x > 591 then return 0 end
  local b = lineY(brinkLine, x)
  local t = lineY(newLine, x) - 1
  return (y >= t and y <= b) and 1 or 0
end)
print(fillDown:area())
local function sheen(x) return math.exp(-((x - 495)/80)^2) end
work(fillDown, {hand="body", tool={kind="flat", width=3, stiffness=0.5}, length={6,14}, coverage=4, fill=true, clip=true, load=1.0, angle=0,
  piles={{glow, 0.8}, {haze, 0.6}, {fallwhite, function(x,y) return 0.35*sheen(x) end}, {foamsh, 0.25}}})
-- ripple lines across the stream: thin, slightly darker reflections, more crowded toward the far edge
local rb = brush{kind="round", width=1.6, point=0.6}
for k = 1, 26 do
  local y = 642 + math.floor(rand(0, 1)^1.6 * 20)
  local x0 = rand(392, 585)
  local L = rand(8, 26) * (0.6 + (y - 640)/25)
  rb:reload((k % 3 == 0) and amber or haze, 0.4)
  rb:stroke({{x0, y}, {x0 + L*0.5, y + rand(-0.4, 0.4)}, {x0 + L, y + rand(-0.4, 0.4)}}, {pressure={0.3, 0.15}, ramps={0.3, 0.4}, clip=streamM + fillDown})
end
-- a few brighter glints near the brink, under the glow
for k = 1, 10 do
  local x0 = rand(440, 560)
  local y = lineY(brinkLine, x0) - rand(3, 9)
  rb:reload(fallwhite, 0.4)
  local L = rand(6, 16)
  rb:stroke({{x0, y}, {x0 + L, y + rand(-0.3, 0.3)}}, {pressure={0.3, 0.1}, ramps={0.3, 0.5}, clip=streamM + fillDown})
end

--@ chunk 6
local lineY = lineYf
local nz = noise{seed=12201, period=10, octaves=2}
-- toes, bank-dark, merging into the banks on their outer sides
toeL2 = outline{{318,628},{330,630},{342,634},{356,638},{372,640},{390,641},{406,645},{420,649},{428,653},{412,655},{396,660},{386,667},{370,652},{350,660},{330,672},{318,676}, char="soft", seed=12111, amount=0.8, lobe=6}:mask() * aboveLine
toeR2 = outline{{546,653},{556,649},{572,647},{590,646},{610,645},{630,643},{648,640},{664,642},{668,690},{652,678},{626,661},{604,660},{594,663},{584,658},{566,656}, char="soft", seed=12112, amount=0.8, lobe=6}:mask() * aboveLine
local function topDist(m, x, y) local d = 0; for k = 1, 12 do if m:at(x, y - k*1.5) < 0.5 then return k*1.5 end end; return 18 end
work(toeL2 + toeR2, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={5,11}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{leafshade, 1}, {brushdark, function(x,y) return 0.7*clamp((y - 645)/15, 0, 1) end},
         {deeprust, function(x,y) return 0.5 * nz:at01(x,y) end},
         {haze, function(x,y) return 0.6*clamp((650 - y)/12, 0, 1) end},
         {orangeleaf, function(x,y) return 0.6*clamp((x - 600)/50, 0, 1) * nz:at01(x*1.5, y) end}}})
blend((toeL2 + toeR2):shrink(2), {angle=1.2})
-- glassy band under the brink, longer tongues over the old slot tops
local slotTips = {{443, 682}, {517, 688}, {542, 690}}
glassM = mask(function(x, y)
  if x < 386 or x > 591 then return 0 end
  local b = lineY(brinkLine, x)
  local d = 8 + 3*math.sin(x/7)
  for _, s in ipairs(slotTips) do
    local w = 10
    local f = clamp(1 - math.abs(x - s[1]) / w, 0, 1)
    d = math.max(d, (s[2] - b) * f^0.6)
  end
  return (y >= b and y <= b + d) and 1 or 0
end)
print(glassM:area())
work(glassM, {hand="body", tool={kind="flat", width=3, stiffness=0.5}, length={5,12}, coverage=4, fill=true, clip=true, load=1.0, angle=math.pi/2,
  piles={{lipglass, 1}, {amber, 0.35}, {haze, 0.4}, {foamsh, 0.2}}})
blend(glassM:shrink(0.5), {angle=math.pi/2})

--@ chunk 7
local lineY = lineYf
glassy = pile{{"lead white",2},{"yellow ochre",1.2},{"raw umber",0.5},{"red earth",0.2},{"green earth",0.3}, name="glassy"}
local g4 = glassM * rect(546, 640, 50, 60)
work(g4, {hand="body", tool={kind="flat", width=3, stiffness=0.5}, length={5,12}, coverage=4, fill=true, clip=true, load=1.0, angle=math.pi/2,
  piles={{glassy, 1}, {haze, 0.6}, {foamsh, 0.4}}})
blend(g4:shrink(0.5), {angle=math.pi/2})
-- the bright turn-over line, broken, along the brink
local rb = brush{kind="round", width=2, point=0.6}
local x = 388
while x < 588 do
  local L = rand(6, 18)
  local x1 = math.min(588, x + L)
  rb:reload((rand(0,1) < 0.3) and glow or fallwhite, 0.5)
  rb:stroke({{x, lineY(brinkLine, x) + 0.5}, {(x + x1)/2, lineY(brinkLine, (x + x1)/2) + 0.3}, {x1, lineY(brinkLine, x1) + 0.5}}, {pressure={0.35, 0.2}, ramps={0.2, 0.4}})
  x = x1 + rand(3, 10)
end

--@ chunk 8
local lineY = lineYf
wait(20*24*60)
-- strand top spans at the brink and the band depth
capSpans = {{385, 435, 12}, {451, 514, 14}, {519, 538, 9}, {547, 593, 11}}
function capMask(i, extra)
  local s = capSpans[i]
  local nb = noise{seed=12300 + i, period=6, octaves=2}
  return mask(function(x, y)
    if x < s[1] - 2 or x > s[2] + 2 or y < 640 or y > 720 then return 0 end
    local b = lineYf(brinkLine, x)
    local d = s[3] + (extra or 0) + 4*nb(x, 0)
    if y < b - 0.5 or y > b + d then return 0 end
    return 1
  end) * (NS[i]:grow(2) + rect(s[1], 640, s[2] - s[1], 30))
end
local cm = capMask(1) + capMask(2) + capMask(3) + capMask(4)
capsAll = cm
print(cm:area())
work(cm, {hand="body", tool={kind="flat", width=3, stiffness=0.5}, length={6,14}, coverage=4, fill=true, clip=true, load=1.0, angle=0.05,
  piles={{glassy, 1}, {glow, function(x,y) return 0.7*clamp(1 - (y - lineYf(brinkLine, x))/6, 0, 1) end}, {haze, 0.5}, {foamsh, 0.4}}})
blend(cm:shrink(0.5), {angle=0.0})

--@ chunk 9
wait(25*24*60)
local cm = capsAll
local function dB(x, y) return y - lineYf(brinkLine, x) end
work(cm, {hand="body", tool={kind="flat", width=3, stiffness=0.5}, length={6,14}, coverage=4, fill=true, clip=true, load=1.0, angle=0.05,
  piles={{glassy, 1}, {foamsh, 0.6}, {rock, function(x,y) return 0.12*clamp(dB(x,y)/10, 0, 1) end}, {glow, function(x,y) return 0.6*clamp(1 - dB(x,y)/5, 0, 1) end}}})
blend(cm:shrink(0.5), {angle=0.0})
-- white starts: fan drags from varied heights inside the band downward
local fan = brush{kind="fan", width=7, stiffness=0.5}
for i = 1, 4 do
  local s = capSpans[i]
  local n = math.floor((s[2] - s[1]) / 3.5)
  for k = 1, n do
    local x = lerp(s[1] + 2, s[2] - 2, (k - 0.5)/n) + rand(-1, 1)
    local y0 = lineYf(brinkLine, x) + rand(3, s[3] + 3)
    fan:reload((k % 4 == 0) and foamsh or fallwhite, 0.3)
    fan:stroke({{x, y0}, {x + rand(-0.5, 0.5), y0 + 12}, {x + rand(-1, 1), y0 + rand(25, 40)}}, {pressure={0.25, 0.45}, orient="across", ramps={0.4, 0.2}, clip=NS[i]})
  end
end

--@ chunk 10
wait(30*24*60)
local cm = capsAll
local function dB(x, y) return y - lineYf(brinkLine, x) end
-- cover the fringe with white first in the zone below the band
local zone = mask(function(x, y) local d = dB(x, y); return (d >= 0 and d <= 34) and 1 or 0 end) * (NS[1] + NS[2] + NS[3] + NS[4] + capsAll)
work(zone - cm, {hand="body", tool={kind="flat", width=4, stiffness=0.5}, length={10,25}, coverage=3, fill=true, clip=true, load=0.9, angle=math.pi/2,
  piles={{fallwhite, 1}, {foamsh, 0.3}}})
work(cm, {hand="body", tool={kind="flat", width=3, stiffness=0.5}, length={6,14}, coverage=4, fill=true, clip=true, load=1.0, angle=0.05,
  piles={{glassy, 1}, {foamsh, 0.5}, {rock, function(x,y) return 0.1*clamp(dB(x,y)/10, 0, 1) end}, {glow, function(x,y) return 0.6*clamp(1 - dB(x,y)/5, 0, 1) end}}})
blend(zone:shrink(1), {angle=math.pi/2})
-- thin broken bright turn-over line
local rb = brush{kind="round", width=1.8, point=0.6}
local x = 388
while x < 590 do
  local L = rand(5, 16)
  local x1 = math.min(590, x + L)
  rb:reload((rand(0,1) < 0.35) and glow or fallwhite, 0.5)
  rb:stroke({{x, lineYf(brinkLine, x) + 0.8}, {(x + x1)/2, lineYf(brinkLine, (x + x1)/2) + 0.5}, {x1, lineYf(brinkLine, x1) + 0.8}}, {pressure={0.3, 0.18}, ramps={0.25, 0.4}})
  x = x1 + rand(3, 9)
end

--@ chunk 11
wait(30*24*60)
mistw = pile{{"lead white",6},{"yellow ochre",0.15},{"cobalt blue",0.08}, medium=0.6, name="mistw"}
local mA = mask(function(x, y) local dx = (x - 370)/45; local dy = (y - 730)/22; return clamp(1 - (dx*dx + dy*dy), 0, 1) end)
work(mA, {hand="glaze", pile=mistw, coverage=1, angle=0.0, seed=1})
local mB = mask(function(x, y) local dx = (x - 610)/45; local dy = (y - 730)/22; return clamp(1 - (dx*dx + dy*dy), 0, 1) end)
work(mB, {hand="scumble", pile=fallwhite, coverage=0.6, seed=2})
local mC = mask(function(x, y) local dx = (x - 480)/40; local dy = (y - 745)/14; return clamp(1 - (dx*dx + dy*dy), 0, 1) end)
work(mC, {hand="glaze", pile=mistw, coverage=1, angle=0.0, seed=3})
blend(mA:shrink(2), {angle=0})

--@ chunk 12
-- dry dark test field first
local field = rect(200, 820, 300, 100)
work(field, {hand="body", tool={kind="filbert", width=8}, length={10,24}, coverage=4, fill=true, clip=true, angle=1.5, piles={{lent,1},{rock,0.7}}})
local wt = rect(300, 800, 60, 120)
work(wt, {hand="body", tool={kind="flat", width=6}, length={20,50}, coverage=4, fill=true, clip=true, angle=math.pi/2, piles={{fallwhite,1},{foamsh,0.3}}})
wait(40*24*60)
local nm = noise{seed=77, period=30, octaves=3, kind="billow", stretch={0, 2}}
mistT = mask(function(x, y)
  if x < 200 or x > 500 or y < 820 or y > 920 then return 0 end
  local v = clamp((y - 830)/60, 0, 1) * clamp((x - 200)/40, 0, 1) * clamp((500 - x)/40, 0, 1)
  return clamp(v * (0.3 + 1.2*nm:at01(x, y)) - 0.15, 0, 1)
end)
print(mistT:area())
work(mistT, {hand="glaze", pile=mistw, coverage=1, angle=0.0, seed=5})

--@ chunk 13
local field = rect(200, 960, 300, 110)
work(field, {hand="body", tool={kind="filbert", width=8}, length={10,24}, coverage=4, fill=true, clip=true, angle=1.5, piles={{lent,1},{rock,0.7}}})
local wt = rect(310, 940, 50, 130)
work(wt, {hand="body", tool={kind="flat", width=6}, length={20,50}, coverage=4, fill=true, clip=true, angle=math.pi/2, piles={{fallwhite,1},{foamsh,0.3}}})
wait(40*24*60)
mistw2 = pile{{"lead white",6},{"yellow ochre",0.15},{"cobalt blue",0.08}, medium=0.85, name="mistw2"}
local nm = noise{seed=78, period=26, octaves=3, kind="billow"}
local function mv(x, y)
  if x < 200 or x > 500 or y < 960 or y > 1070 then return 0 end
  local v = clamp((y - 975)/70, 0, 1) * clamp(1 - math.abs(x - 335)/150, 0, 1)
  return v * (0.4 + 0.9*nm:at01(x, y))
end
for i, th in ipairs({0.25, 0.5, 0.75}) do
  local m = mask(function(x, y) return clamp((mv(x, y) - th) * 8, 0, 1) end):soften(4)
  print(m:area())
  work(m, {hand="glaze", pile=mistw2, coverage=1, angle=-0.3, seed=10 + i})
end
-- spray: spatter
local sb = brush{kind="round", width=6}
sb:load(mistw, 0.5)
print(sb:spatter{at={340, 1060}, toward={-30, -60}, spread=0.6, force=0.4})
sb:load(mistw, 0.5)
print(sb:spatter{at={420, 1060}, toward={20, -50}, spread=0.6, force=0.7})
