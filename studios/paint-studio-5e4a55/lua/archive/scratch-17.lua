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
local bg = rect(300, 560, 400, 200)
work(bg, {hand="body", tool={kind="flat", width=10}, length={20,50}, coverage=4, fill=true, clip=true, angle=0.0,
  piles={{haze, 1}, {amber, 0.7}, {deeprust, 0.12}}})
work(rockFace - newFalls, {hand="body", tool={kind="filbert", width=6}, length={10,24}, coverage=4, fill=true, clip=true, angle=1.5, piles={{lent,1},{rock,0.7}}})
work(newFalls, {hand="body", tool={kind="flat", width=6}, length={20,50}, coverage=4, fill=true, clip=true, angle=math.pi/2, piles={{fallwhite,1},{foamsh,0.3}}})
local caps = newFalls * mask(function(x,y) return 1 end) * above(function(x) return 685 end)
work(caps, {hand="body", tool={kind="flat", width=5}, length={8,20}, coverage=3, fill=true, clip=true, angle=0, piles={{foamsh,1},{lipglass,0.4}}})
wait(40*24*60)
print(drying(480,620), drying(360,700), drying(480,700))

--@ chunk 3
-- geometry for the new brink (shared with the painting)
newLine = {{326,676},{334,668},{346,659},{358,652},{370,649},{378,651},{383,658},{386,668},
  {410,667},{433,669},
  {437,662},{441,654},{445,651},{449,653},{452,655},
  {482,653},{512,655},
  {514,653},{517,652},{519,658},{521,676},
  {537,676},{539,666},{542,657},{545,656},{548,661},
  {570,660},{591,661},
  {596,663},{604,660},{614,658},{626,661},{640,668},{652,678},{664,692}}
local function lineY(pts, x)
  for i = 1, #pts - 1 do
    local a, b = pts[i], pts[i+1]
    if x >= a[1] and x <= b[1] then return lerp(a[2], b[2], (x - a[1]) / math.max(0.001, b[1] - a[1])) end
  end
  if x < pts[1][1] then return pts[1][2] end
  return pts[#pts][2]
end
lineYf = lineY
-- stream: between the toes, above the brink line
local sp = {}
for _, p in ipairs(newLine) do if p[1] >= 384 and p[1] <= 593 then sp[#sp+1] = {p[1], p[2]} end end
for _, p in ipairs({{580,652},{564,642},{548,634},{528,628},{500,625},{470,627},{446,631},{424,640},{402,652},{388,662}}) do sp[#sp+1] = p end
streamM = poly(sp)
-- toes
toeLTop = {{318,640},{334,633},{352,629},{372,628},{392,630},{414,632},{432,634},{446,632}}
local lp = {}
for _, p in ipairs(toeLTop) do lp[#lp+1] = p end
for _, p in ipairs({{424,640},{402,652},{388,662},{384,666}}) do lp[#lp+1] = p end
for i = #newLine, 1, -1 do local p = newLine[i]; if p[1] <= 383 then lp[#lp+1] = {p[1], p[2]} end end
lp[#lp+1] = {318, 680}
toeL = poly(lp, true)
toeRTop = {{546,635},{562,639},{584,642},{606,645},{628,648},{648,651},{666,656}}
local rp2 = {}
for _, p in ipairs(toeRTop) do rp2[#rp2+1] = p end
for i = #newLine, 1, -1 do local p = newLine[i]; if p[1] >= 594 then rp2[#rp2+1] = {p[1], p[2]} end end
for _, p in ipairs({{593,661},{580,652},{564,642}}) do rp2[#rp2+1] = p end
toeR = poly(rp2, true)
-- everything above the new line in the brink zone
aboveLine = mask(function(x, y)
  if x < 318 or x > 668 or y < 590 then return 0 end
  return (y < lineY(newLine, x)) and 1 or 0
end)
print(streamM:area(), toeL:area(), toeR:area(), aboveLine:area())

--@ chunk 4
local lineY = lineYf
local nz = noise{seed=12001, period=14, octaves=2}
-- a) tan where the old rock stood above the toes and the stream
local tanFix = (aboveLine - toeL - toeR - streamM) * rect(318, 590, 350, 100)
work(tanFix, {hand="body", tool={kind="flat", width=6, stiffness=0.5}, length={10,30}, coverage=4, fill=true, clip=true, load=1.0,
  angle=-math.pi/2, piles={{haze, 1}, {amber, 0.72}, {deeprust, 0.13}}})
-- b) toes: warm dark, hazier toward their tops, darker toward the water
local function toeDepth(top, x, y) return y - lineY(top, x) end
work((toeL + toeR) * aboveLine, {hand="body", tool={kind="filbert", width=5, stiffness=0.5}, length={5,12}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 1.57 + 0.9*math.sin(x/6 + y/5) end,
  piles={{leafshade, 1}, {brushdark, function(x,y) local t = (x < 500) and toeLTop or toeRTop; return 0.6 * clamp(toeDepth(t,x,y)/18, 0, 1) end},
         {amber, function(x,y) local t = (x < 500) and toeLTop or toeRTop; return 0.7 * clamp(1 - toeDepth(t,x,y)/8, 0, 1) * (0.5 + nz:at01(x,y)) end},
         {haze, function(x,y) local t = (x < 500) and toeLTop or toeRTop; return 0.5 * clamp(1 - toeDepth(t,x,y)/6, 0, 1) end}}})
-- c) the upper stream: horizontal strokes, light from the glow, darker reflections near the toes
local function sheen(x, y) return math.exp(-((x - 490)/70)^2) end
work(streamM, {hand="body", tool={kind="flat", width=5, stiffness=0.5}, length={12,36}, coverage=4, fill=true, clip=true, load=1.0,
  angle=function(x,y) return 0.03*nz(x,y) end, angle_jitter=0.02,
  piles={{glow, 1}, {fallwhite, function(x,y) return 0.5 + 0.8*sheen(x,y) end}, {haze, 0.5},
         {amber, function(x,y) return 0.5 * clamp(1 - (y - 626)/10, 0, 1) end},
         {leafshade, function(x,y) return 0.35 * (clamp((430 - x)/40, 0, 1) + clamp((x - 560)/30, 0, 1)) end}}})
blend(streamM:shrink(1.5), {angle=0.0})
print(drying(480, 640))
