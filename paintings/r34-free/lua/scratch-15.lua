-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
hdA = pile{{"ultramarine blue", 1}, {"burnt sienna", 0.7}, {"bone black", 0.4}, {"permanent alizarin", 0.3}, {"lead white", 0.15}, name="hdA"}
headT = poly({{0,372},{22,356},{54,344},{88,333},{118,326},{140,322},{160,326},{186,338},{214,352},{246,370},{280,388},{312,402},{336,412},{352,421},{0,423}}, true)
work(headT, {hand="body", pile=hdA, coverage=1.6, fill=true, clip=true})
work(headT, {hand="body", pile=hdA, coverage=1.0, fill=true, clip=true, load=1.0})
wait(4320)
print(drying(120,360), drying(200,380), drying(260,395))

--@ chunk 3
wait(4320)
print(drying(120,360), drying(200,380), drying(260,395))

--@ chunk 4
wait(2880)
print(drying(120,360), drying(200,380), drying(260,395))

--@ chunk 5
wait(1440)
print(drying(120,360), drying(200,380), drying(260,395))

--@ chunk 6
litA = pile{{"burnt sienna", 0.4}, {"rose madder", 0.3}, {"pale cadmium", 0.3}, {"lead white", 0.8}, turps=0.2, name="litA"}
litB = pile{{"lead white", 1.2}, {"pale cadmium", 0.4}, {"rose madder", 0.2}, turps=0.2, name="litB"}
slope = {{150,326},{186,342},{220,362},{252,380},{284,398},{312,408}}
b = brush("flat", 6)
b:load(litA, 0.6)
b:stroke({{160,332},{190,348},{222,366},{254,384},{286,400}}, {pressure = 0.35})
b:load(litB, 0.25)
b:stroke({{184,344},{216,362},{248,380},{276,396}}, {pressure = 0.18})
print("lit trial laid", drying(200,350))

--@ chunk 7
glzW = pile{{"burnt sienna", 0.4}, {"permanent alizarin", 0.3}, {"pale cadmium", 0.3}, medium=0.8, name="glzW"}
slopeM = poly({{130,322},{170,340},{220,366},{262,388},{300,404},{336,414},{300,418},{250,400},{200,376},{150,350}}, true) * headT
work(slopeM, {hand="glaze", pile=glzW, coverage=1.0, clip=true})
print("glaze trial laid")

--@ chunk 8
rockP = pile{{"ultramarine blue", 0.6}, {"permanent alizarin", 0.3}, {"cerulean blue", 0.3}, {"burnt sienna", 0.2}, {"lead white", 0.35}, turps=0.3, name="rockP"}
rockM = poly({{60,340},{88,333},{118,327},{132,330},{118,336},{104,344},{94,350},{76,352},{58,352}}, true)
work(rockM, {hand="body", pile=rockP, coverage=1.2, fill=true, clip=true})
print("rock plane trial laid")

--@ chunk 9
print(drying(200,600), drying(800,650))
wkL = pile{{"cerulean blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 1.4}, turps=0.4, name="wkL"}
wkM = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="wkM"}
wkD = pile{{"Prussian blue", 0.5}, {"ultramarine blue", 0.7}, {"permanent alizarin", 0.3}, {"lead white", 0.5}, turps=0.3, name="wkD"}
wr = rect(0, 452, 1000, 298)
work(wr, {hand="broad", coverage=1.4, fill=true, angle=0.02, piles={
  {wkL, function(x,y) return clamp(1 - (y-452)/50, 0, 1) end},
  {wkM, function(x,y) return clamp(1 - math.abs(y-580)/130, 0, 1) end},
  {wkD, function(x,y) return clamp((y-600)/150, 0, 1) end}}})
wait(4320)
print(drying(300,500), drying(300,600), drying(300,700))

--@ chunk 10
spP2 = pile{{"pale cadmium", 0.8}, {"lead white", 1.7}, turps=0.2, name="spP2"}
spW2 = pile{{"lead white", 1.0}, {"cadmium yellow", 0.4}, {"rose madder", 0.2}, turps=0.2, name="spW2"}
b = brush("flat", 6)
n = 0
local y = 452
while y < 640 do
  local t = (y - 452) / 298
  local half = 6 + t * 110
  local cnt = 2 + math.floor(t * 6)
  b:load((math.random() < 0.55) and spP2 or spW2, 0.25 + 0.2 * math.random())
  for j = 1, cnt do
    local cx = 646 - (y - 452) * 0.12
    local x0 = cx - half + math.random() * 2 * half * (0.7 + 0.3 * math.random())
    local len = (6 + math.random() * (10 + 40 * t)) * (0.6 + 0.6 * math.random())
    if math.random() < 0.75 then
      b:stroke({{x0, y}, {x0 + len, y + (math.random() - 0.5) * 0.8}}, {pressure = 0.14 + 0.16 * math.random()})
      n = n + 1
    end
  end
  y = y + 3 + t * 8
end
print("bricks laid on scratch", n, drying(646,500), drying(646,560))

--@ chunk 11
vlL = pile{{"rose madder", 0.4}, {"ultramarine blue", 0.4}, {"lead white", 1.3}, turps=0.3, name="vlL"}
vlP = pile{{"deep cadmium", 0.3}, {"rose madder", 0.3}, {"lead white", 1.5}, turps=0.3, name="vlP"}
b = brush("flat", 5)
n = 0
for i = 1, 60 do
  local y = 452 + (math.random() ^ 1.2) * 180
  local t = (y - 452) / 298
  local half = 6 + t * 110
  local cx = 646 - (y - 452) * 0.12
  local x0 = cx - half * 1.3 + math.random() * 2.6 * half
  local len = 6 + math.random() * (8 + 30 * t)
  if i % 8 == 0 then b:load((math.random() < 0.5) and vlL or vlP, 0.22) end
  b:stroke({{x0, y}, {x0 + len, y + (math.random() - 0.5) * 0.8}}, {pressure = 0.08 + 0.1 * math.random()})
  n = n + 1
end
print("veil dashes", n, drying(646,500))

--@ chunk 12
wait(60)
b = brush("flat", 6)
b:load(spP2, 0.12)
n = 0
for i = 1, 40 do
  local y = 470 + (math.random() ^ 1.1) * 150
  local t = (y - 452) / 298
  local half = 6 + t * 110
  local cx = 646 - (y - 452) * 0.12
  local x0 = cx - half + math.random() * 2 * half
  local len = 5 + math.random() * (6 + 30 * t)
  b:stroke({{x0, y}, {x0 + len, y + (math.random() - 0.5) * 0.6}}, {pressure = 0.08 + 0.08 * math.random()})
  n = n + 1
end
print("light dry-ish dashes", n, b:fullness())
