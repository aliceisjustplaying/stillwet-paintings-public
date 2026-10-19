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
wait(5760)
print(drying(300,500), drying(300,600), drying(300,700))

--@ chunk 3
wkL = pile{{"cerulean blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 1.4}, turps=0.4, name="wkL"}
wkM = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="wkM"}
wkD = pile{{"Prussian blue", 0.5}, {"ultramarine blue", 0.7}, {"permanent alizarin", 0.3}, {"lead white", 0.5}, turps=0.3, name="wkD"}
wr = rect(0, 452, 1000, 298)
work(wr, {hand="broad", coverage=1.4, fill=true, angle=0.02, piles={
  {wkL, function(x,y) return clamp(1 - (y-452)/50, 0, 1) end},
  {wkM, function(x,y) return clamp(1 - math.abs(y-580)/130, 0, 1) end},
  {wkD, function(x,y) return clamp((y-600)/150, 0, 1) end}}})
print("water base trial laid")

--@ chunk 4
wait(4320)
print(drying(300,500), drying(300,600), drying(300,700))

--@ chunk 5
rpL = pile{{"lead white", 1.0}, {"permanent alizarin", 0.3}, {"cerulean blue", 0.3}, turps=0.2, name="rpL"}
rpP = pile{{"pale cadmium", 0.6}, {"rose madder", 0.4}, {"lead white", 1.3}, turps=0.2, name="rpP"}
rpC = pile{{"cerulean blue", 0.9}, {"lead white", 1.4}, turps=0.2, name="rpC"}
b = brush("flat", 9)
n = 0
local specs = {{rpL, 26, 0.4}, {rpP, 14, 0.2}, {rpC, 14, 0.8}}
for _, s in ipairs(specs) do
  b:load(s[1], 0.25)
  for i = 1, s[2] do
    local y = 458 + (math.random() ^ 1.3) * 290
    local t = (y - 452) / 298
    local x = math.random() * 960
    local len = (20 + 90 * t) * (0.6 + math.random() * 0.8)
    b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.8}}, {pressure = 0.1 + 0.12 * math.random()})
    n = n + 1
  end
end
print("ripples", n, b:fullness())

--@ chunk 6
spP = pile{{"pale cadmium", 0.8}, {"lead white", 1.7}, turps=0.2, name="spP"}
spW = pile{{"lead white", 1.0}, {"cadmium yellow", 0.4}, {"rose madder", 0.2}, turps=0.2, name="spW"}
b = brush("flat", 6)
n = 0
local y = 452
while y < 745 do
  local t = (y - 452) / 298
  local half = 6 + t * 110
  local cnt = 2 + math.floor(t * 6)
  b:load((math.random() < 0.55) and spP or spW, 0.25 + 0.2 * math.random())
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
print("sun path dashes", n)
