-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
dkA = pile{{"rose madder", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.3}, {"lead white", 0.5}, turps=0.2, name="dkA"}
dkB = pile{{"ultramarine blue", 0.6}, {"burnt sienna", 0.7}, {"permanent alizarin", 0.4}, {"bone black", 0.1}, {"lead white", 0.15}, turps=0.15, name="dkB"}
dkC = pile{{"burnt sienna", 0.8}, {"ultramarine blue", 0.6}, {"bone black", 0.3}, {"permanent alizarin", 0.2}, turps=0.1, name="dkC"}
fgR = rect(0, 452, 1000, 298)
work(fgR, {hand="broad", coverage=1.2, fill=true, angle=0.03, piles={
  {dkA, function(x,y) return clamp(1 - (y-455)/50, 0, 1) end},
  {dkB, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {dkC, function(x,y) return clamp((y-580)/140, 0, 1) end}}})
wait(4320)
print(drying(300,500), drying(300,600), drying(300,700))

--@ chunk 3
cPeach = pile{{"pale cadmium", 0.6}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.2, name="cPeach"}
cLil = pile{{"ultramarine blue", 0.5}, {"permanent alizarin", 0.4}, {"lead white", 0.7}, turps=0.2, name="cLil"}
cWarm = pile{{"burnt sienna", 0.4}, {"yellow ochre", 0.4}, {"lead white", 0.6}, turps=0.2, name="cWarm"}
cDusk = pile{{"cerulean blue", 0.5}, {"rose madder", 0.3}, {"lead white", 0.9}, turps=0.2, name="cDusk"}
b = brush("flat", 8)
n = 0
for i = 1, 90 do
  local y = 452 + 296 * (math.random() ^ 1.7)
  local x = math.random() * 1000
  local t = (y - 452) / 296
  local p
  if math.random() < 0.5 then p = (math.random() < 0.6) and cWarm or cPeach else p = (math.random() < 0.6) and cLil or cDusk end
  if n % 5 == 0 then b:load(p, 0.18 + 0.08 * math.random()) end
  local len = (10 + 30 * t) + math.random() * (14 + 60 * t)
  b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * (0.6 + 1.2 * t)}}, {pressure = 0.12 + 0.13 * (1 - t) * math.random() + 0.04})
  n = n + 1
end
wait(1440)
print("bars", n, drying(330,548), drying(640,555), drying(440,568))

--@ chunk 4
b2 = brush("flat", 8)
b2:load(dkB, 0.2)
n = 0
for i = 1, 50 do
  local y = 452 + (math.random() ^ 1.2) * 296
  local x = math.random() * 1000
  local t = (y - 452) / 296
  local len = 30 + math.random() * 80
  b2:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 1.0}}, {pressure = 0.15 + 0.15 * math.random()})
  n = n + 1
end
print("dark dry-brush over bars", n, b2:fullness())
