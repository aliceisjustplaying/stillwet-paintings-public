-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
hdA = pile{{"ultramarine blue", 1}, {"burnt sienna", 0.7}, {"bone black", 0.4}, {"permanent alizarin", 0.3}, {"lead white", 0.15}, name="hdA"}
litP = pile{{"burnt sienna", 0.7}, {"permanent alizarin", 0.5}, {"rose madder", 0.4}, {"ultramarine blue", 0.3}, {"lead white", 0.8}, {"pale cadmium", 0.2}, name="litP"}
shP = pile{{"ultramarine blue", 1}, {"burnt sienna", 0.5}, {"bone black", 0.4}, {"permanent alizarin", 0.3}, {"lead white", 0.15}, name="shP"}
print(hdA) print(litP) print(shP)

--@ chunk 3
litA = pile{{"burnt sienna", 0.8}, {"yellow ochre", 0.3}, {"ultramarine blue", 0.35}, {"rose madder", 0.15}, {"lead white", 0.9}, name="litA"}
litB = pile{{"burnt sienna", 0.6}, {"raw sienna", 0.5}, {"ultramarine blue", 0.3}, {"permanent alizarin", 0.2}, {"lead white", 1.0}, name="litB"}
litC = pile{{"burnt sienna", 0.9}, {"pale cadmium", 0.3}, {"ultramarine blue", 0.4}, {"lead white", 1.1}, name="litC"}
print(litA) print(litB) print(litC)

--@ chunk 4
bgG = pile{{"cadmium yellow", 0.9}, {"lead white", 1.5}, turps=0.4, name="bgG"}
bgP = pile{{"pale cadmium", 0.8}, {"rose madder", 0.4}, {"lead white", 1.4}, turps=0.4, name="bgP"}
bgM = rect(0, 296, 420, 130)
work(bgM, {hand="broad", coverage=1.4, fill=true, piles={
  {bgG, function(x,y) return clamp(1 - math.abs(y-330)/50, 0, 1) end},
  {bgP, function(x,y) return clamp((x-180)/120, 0, 1) * clamp(1 - math.abs(y-350)/60, 0, 1) end}}})
print("background sky laid", drying(200,330), drying(300,380))

--@ chunk 5
wait(4320)
print("bg after 3 days", drying(200,330), drying(300,380))

--@ chunk 6
HEADL = poly({{0,372},{22,356},{54,344},{88,333},{118,326},{140,322},{160,326},{186,338},{214,352},{246,370},{280,388},{312,402},{336,412},{352,421},{0,423}}, true)
ledgeM = poly({{270,404},{292,396},{318,398},{336,406},{352,414},{352,422},{270,422}}, true)
leftRock = poly({{0,380},{14,366},{34,362},{46,372},{30,386},{0,390}}, true)
work(HEADL, {hand="body", pile=hdA, coverage=1.6, fill=true, clip=true})
work(HEADL, {hand="body", pile=hdA, coverage=1.0, fill=true, clip=true, load=1.0})
work(ledgeM, {hand="body", pile=hdA, coverage=1.6, fill=true, clip=true})
work(leftRock, {hand="body", pile=hdA, coverage=1.6, fill=true, clip=true})
print("headland base laid on scratch", drying(120,340), drying(200,380), drying(300,410))

--@ chunk 7
wait(8640)
print("headland base at 6 days", drying(120,340), drying(200,380), drying(300,410), drying(20,375))

--@ chunk 8
wait(8640)
print("headland base at 12 days", drying(120,340), drying(200,380), drying(300,410), drying(20,375))

--@ chunk 9
slopeP = {{140,322},{160,326},{186,338},{214,352},{246,370},{280,388},{312,402},{336,412},{352,421}}
function dSlope(x, y)
  local best = 1e9
  for i = 1, #slopeP - 1 do
    local ax, ay = slopeP[i][1], slopeP[i][2]
    local bx, by = slopeP[i+1][1], slopeP[i+1][2]
    local dx, dy = bx - ax, by - ay
    local t = clamp(((x-ax)*dx + (y-ay)*dy) / (dx*dx + dy*dy), 0, 1)
    local px, py = ax + t*dx, ay + t*dy
    local d = ((x-px)^2 + (y-py)^2)^0.5
    if d < best then best = d end
  end
  return best
end
function litW(x, y)
  local near = 1 - clamp(dSlope(x, y) / 40, 0, 1)
  return clamp(near * clamp((x - 120) / 200, 0, 1), 0, 1)
end
MASS = HEADL + ledgeM + leftRock
work(MASS, {hand="body", coverage=1.6, fill=true, clip=true, load=1.0, angle=function(x,y) return 0.5 * clamp((x-80)/120, 0, 1) end, piles={
  {litA, litW},
  {shP, function(x,y) return 1 - litW(x,y) end}}})
print("graded mass trial laid", litW(300,400), litW(200,350), litW(60,370), drying(200,380))

--@ chunk 10
wait(12 * 1440)
print("graded mass after 12 days", drying(200,380), drying(300,410), drying(120,340))

--@ chunk 11
seaS = rect(0, 452, 1000, 298)
cTopS = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 1.2}, {"pale cadmium", 0.15}, turps=0.4, name="cTopS"}
cMidS = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="cMidS"}
cLowS = pile{{"Prussian blue", 0.4}, {"ultramarine blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 0.4}, turps=0.3, name="cLowS"}
work(seaS, {hand="broad", coverage=1.2, fill=true, clip=true, angle=0.02, edge="soft", piles={
  {cTopS, function(x,y) return clamp(1 - (y-452)/60, 0, 1) end},
  {cMidS, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {cLowS, function(x,y) return clamp((y-580)/140, 0, 1) end}}})
print("sea base on scratch", drying(120,683))

--@ chunk 12
wait(12 * 1440)
print("sea base after 12 days", drying(120,683), drying(300,600))

--@ chunk 13
gtL = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 0.6}, turps=0.25, name="gtL"}
tlL = pile{{"cerulean blue", 0.6}, {"raw umber", 0.15}, {"lead white", 0.6}, turps=0.2, name="tlL"}
lilL = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.3}, {"lead white", 0.6}, turps=0.25, name="lilL"}
bA = brush("flat", 3)
n = 0
cur = nil
for i = 1, 26 do
  local y = 618 + (math.random() ^ 1.1) * 74
  local t = (y - 540) / 150
  local x = 14 + math.random() * 320
  local pick
  local r = math.random()
  if r < 0.4 then pick = gtL elseif r < 0.7 then pick = tlL else pick = lilL end
  if pick ~= cur then bA:reload(pick, 0.3); cur = pick end
  local len = 40 + math.random() * (30 + 40 * t)
  bA:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.5}}, {pressure = 0.07 + 0.03 * math.random()})
  n = n + 1
end
print("dim near band trial, low white, pressure .07-.10", n, drying(200,650))

--@ chunk 14
mL = rect(20, 462, 420, 80)
pcL = pile{{"pale cadmium", 0.3}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.25, name="pcL"}
gtL2 = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.1}, turps=0.25, name="gtL2"}
bL = brush("flat", 3)
n = 0
cur = nil
for i = 1, 26 do
  local y = 462 + math.random() * 80
  local t = (y - 462) / 80
  local x = 20 + math.random() * 420
  if mL:at(x, y) > 0.5 then
    local pick
    if math.random() < 0.5 then pick = pcL else pick = gtL2 end
    if pick ~= cur then bL:reload(pick, 0.3); cur = pick end
    local len = 18 + 56 * t + math.random() * (12 + 36 * t)
    bL:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.03 * math.random()})
    n = n + 1
  end
end
print("left-mid glints trial on scratch", n, drying(200,500))
