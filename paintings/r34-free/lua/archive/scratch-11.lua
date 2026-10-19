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
-- a few pale puffs of the old sand (as the painting has), to test covering them
puffP = pile{{"pale cadmium", 0.4}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.3, name="puffP"}
puffs = poly({{300,520},{340,512},{372,520},{352,528},{310,528}}, true) + poly({{560,580},{620,570},{660,582},{600,590}}, true)
work(puffs, {hand="body", pile=puffP, coverage=1.2, fill=true, clip=true})
wait(4320)
print(drying(300,500), drying(300,600), drying(300,700))

--@ chunk 3
dkD = pile{{"ultramarine blue", 0.7}, {"burnt sienna", 0.7}, {"bone black", 0.2}, {"permanent alizarin", 0.3}, turps=0.1, name="dkD"}
fg2 = rect(0, 452, 1000, 298)
work(fg2, {hand="body", pile=dkD, coverage=1.1, fill=true, angle=0.0, load=0.9, piles={
  {dkD, function(x,y) return 1 end},
  {dkC, function(x,y) return clamp((y-600)/120, 0, 0.6) end}}})
wait(360)
print(drying(330,520), drying(640,580), drying(300,600))

--@ chunk 4
wait(1440)
print(drying(330,520), drying(640,580), drying(300,600))

--@ chunk 5
wait(2880)
print(drying(330,520), drying(640,580), drying(300,600))

--@ chunk 6
wait(2880)
print(drying(330,520), drying(640,580), drying(300,600))

--@ chunk 7
wait(1440)
print(drying(330,520), drying(640,580), drying(300,600))

--@ chunk 8
sheenL = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.3}, {"lead white", 1.3}, turps=0.2, name="sheenL"}
sheenP = pile{{"pale cadmium", 0.6}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.2, name="sheenP"}
sheenC = pile{{"cerulean blue", 0.8}, {"lead white", 1.2}, turps=0.2, name="sheenC"}
b = brush("flat", 8)
n = 0
local specs = {{sheenL, 14}, {sheenP, 8}, {sheenC, 6}}
for _, s in ipairs(specs) do
  b:load(s[1], 0.2)
  for i = 1, s[2] do
    local y = 470 + math.random() * 260
    local x = math.random() * 900
    local len = 18 + math.random() * 70 * (0.4 + (y - 470) / 260)
    b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 1.2}}, {pressure = 0.1 + 0.12 * math.random()})
    n = n + 1
  end
end
print("sheen strokes", n, b:fullness())

--@ chunk 9
print("scratch-4 sky", drying(200,80), drying(600,120), drying(200,200), drying(640,250))
cloudV = pile{{"ultramarine blue", 0.7}, {"permanent alizarin", 0.5}, {"lead white", 1.1}, turps=0.2, name="cloudV"}
b = brush("flat", 6)
b:load(cloudV, 0.25)
n = 0
for i = 1, 16 do
  local y = 60 + math.random() * 120
  local x = 40 + math.random() * 700
  local len = 60 + math.random() * 130
  b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 6}}, {pressure = 0.14 + 0.12 * math.random()})
  n = n + 1
end
print("streaks", n, b:fullness())

--@ chunk 10
rL = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.3}, {"lead white", 1.3}, turps=0.2, name="rL"}
rP = pile{{"pale cadmium", 0.6}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.2, name="rP"}
rC = pile{{"cerulean blue", 0.8}, {"lead white", 1.2}, {"permanent alizarin", 0.1}, turps=0.2, name="rC"}
b = brush("flat", 8)
n = 0
local pals = {rL, rP, rC}
for i = 1, 60 do
  local x = math.random() * 1000
  local y = 452 + (math.random() ^ 1.4) * 52
  local d = math.abs(x - 646) / 420
  local p = (1 - clamp(d, 0, 1)) * (1 - (y - 452) / 60) + 0.05
  if math.random() < p then
    if n % 4 == 0 then b:reload(pals[math.random(1, 3)], 0.3) end
    local len = 22 + math.random() * 60 * (0.6 + 0.6 * (1 - (y - 452) / 52))
    b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 1.0}}, {pressure = 0.12 + 0.12 * math.random()})
    n = n + 1
  end
end
print("trial reflections", n, drying(500,470), drying(700,465))

--@ chunk 11
dkB = pile{{"ultramarine blue", 0.6}, {"burnt sienna", 0.7}, {"permanent alizarin", 0.4}, {"bone black", 0.1}, {"lead white", 0.15}, turps=0.15, name="dkB"}
b2 = brush("flat", 8)
b2:load(dkB, 0.2)
n = 0
for i = 1, 40 do
  local y = 452 + math.random() * 52
  local x = math.random() * 1000
  local len = 30 + math.random() * 70
  b2:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 1.0}}, {pressure = 0.15 + 0.15 * math.random()})
  n = n + 1
end
print("dark dry-brush over", n, b2:fullness())

--@ chunk 12
cool = pile{{"ultramarine blue", 0.5}, {"permanent alizarin", 0.4}, {"lead white", 0.7}, turps=0.2, name="cool"}
warm = pile{{"burnt sienna", 0.4}, {"yellow ochre", 0.4}, {"lead white", 0.6}, turps=0.2, name="warm"}
dusk = pile{{"cerulean blue", 0.5}, {"rose madder", 0.3}, {"lead white", 0.9}, turps=0.2, name="dusk"}
b = brush("flat", 10)
n = 0
local specs = {{cool, 40}, {warm, 36}, {dusk, 18}}
for _, s in ipairs(specs) do
  b:load(s[1], 0.2)
  for i = 1, s[2] do
    local y = 560 + math.random() * 170
    local x = math.random() * 960
    local len = 30 + math.random() * 90 * ((y - 540) / 170 + 0.3)
    b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 2.0}}, {pressure = 0.12 + 0.12 * math.random()})
    n = n + 1
  end
end
print("foreground dry-brush trial", n, b:fullness())
