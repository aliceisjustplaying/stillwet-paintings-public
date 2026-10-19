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
shineLil = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.3}, {"lead white", 1.3}, turps=0.2, name="shineLil"}
b = brush("flat", 8)
b:load(shineLil, 0.22)
n = 0
for i = 1, 26 do
  local y = 456 + math.random() * 60
  local x = math.random() * 960
  local len = 25 + math.random() * 60
  b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 1.5}}, {pressure = 0.12 + 0.12 * math.random()})
  n = n + 1
end
print("dry-brush lilac strokes", n, b:fullness())

--@ chunk 4
shineGold = pile{{"pale cadmium", 0.6}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.2, name="shineGold"}
b = brush("flat", 8)
b:load(shineGold, 0.45)
n = 0
for i = 1, 18 do
  local y = 600 + math.random() * 110
  local x = 180 + math.random() * 640
  local len = 20 + math.random() * 40
  b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 1.5}}, {pressure = 0.2 + 0.15 * math.random()})
  n = n + 1
end
b:load(shineLil, 0.6)
for i = 1, 14 do
  local y = 470 + math.random() * 40
  local x = math.random() * 960
  local len = 30 + math.random() * 60
  b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 1.5}}, {pressure = 0.25 + 0.15 * math.random()})
  n = n + 1
end
print("strokes", n, b:fullness())

--@ chunk 5
wetOl = pile{{"burnt sienna", 0.5}, {"yellow ochre", 0.4}, {"ultramarine blue", 0.5}, {"lead white", 0.6}, turps=0.3, name="wetOl"}
wetSl = pile{{"ultramarine blue", 0.7}, {"raw umber", 0.5}, {"lead white", 0.7}, turps=0.3, name="wetSl"}
wetBr = pile{{"raw umber", 0.6}, {"burnt sienna", 0.4}, {"permanent alizarin", 0.2}, {"lead white", 0.5}, turps=0.3, name="wetBr"}
pat = rect(0, 510, 1000, 230)
work(pat, {hand="body", coverage=0.55, fill=false, angle=0.02, piles={
  {wetOl, function(x,y) return 1 end},
  {wetSl, function(x,y) return clamp(math.sin(x/37.0 + y/23.0) * 0.5 + 0.5, 0, 1) end},
  {wetBr, function(x,y) return clamp(math.cos(x/53.0 - y/31.0) * 0.5 + 0.5, 0, 1) end}}})
print("sand patches laid")
