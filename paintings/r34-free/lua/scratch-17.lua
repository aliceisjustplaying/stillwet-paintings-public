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
wkL = pile{{"cerulean blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 1.4}, turps=0.4, name="wkL"}
wkM = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="wkM"}
wkD = pile{{"Prussian blue", 0.5}, {"ultramarine blue", 0.7}, {"permanent alizarin", 0.3}, {"lead white", 0.5}, turps=0.3, name="wkD"}
wr = rect(0, 452, 1000, 298)
work(wr, {hand="broad", coverage=1.4, fill=true, angle=0.02, piles={
  {wkL, function(x,y) return clamp(1 - (y-452)/50, 0, 1) end},
  {wkM, function(x,y) return clamp(1 - math.abs(y-580)/130, 0, 1) end},
  {wkD, function(x,y) return clamp((y-600)/150, 0, 1) end}}})
wait(5760)
print(drying(300,500), drying(300,600), drying(300,700))

--@ chunk 3
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
wait(1440)
print("bricks", n, drying(646,500), drying(646,580))

--@ chunk 4
wait(1440)
print(drying(646,500), drying(646,580), drying(600,620))
-- body coat over the lower bricks, right half of the path only (x>=646) to compare with the left half
covM = poly({{650,560},{760,560},{820,700},{600,700}}, true)
wkC = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.5}, turps=0.1, name="wkC"}
work(covM, {hand="body", pile=wkC, coverage=1.2, fill=true, clip=true, load=0.8})
print("body coat over right lower bricks")

--@ chunk 5
wait(1440)
print(drying(646,580), drying(700,640), drying(600,620))

--@ chunk 6
wait(2880)
print(drying(646,580), drying(700,640), drying(600,620))

--@ chunk 7
glitP = pile{{"pale cadmium", 0.7}, {"lead white", 2.0}, name="glitP"}
st = stipple(rect(560, 540, 260, 130), {pile=glitP, width=2, coverage=0.25, pressure={0.2, 0.4}, dips={24, 0.4, 0}})
print("stipple flecks", st)

--@ chunk 8
warmRef = pile{{"pale cadmium", 0.5}, {"rose madder", 0.35}, {"lead white", 1.2}, turps=0.2, name="warmRef"}
warmRef2 = pile{{"deep cadmium", 0.5}, {"rose madder", 0.3}, {"lead white", 1.0}, turps=0.2, name="warmRef2"}
b = brush("flat", 3)
n = 0
for i = 1, 34 do
  local x = 500 + math.random() * 260
  local d = math.abs(x - 646) / 150
  local y = 430 + (math.random() ^ 1.4) * 22
  if math.random() < clamp(1 - d, 0.1, 1) then
    if i % 6 == 0 then b:load((math.random() < 0.6) and warmRef or warmRef2, 0.3) end
    local len = 26 + math.random() * 50 * (1 - d * 0.5)
    b:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.3}}, {pressure = 0.07 + 0.05 * math.random()})
    n = n + 1
  end
end
print("warm reflection band", n, drying(646,436))

--@ chunk 9
PATHENV = poly({{628,440},{664,440},{722,650},{520,650}}, true)
seaCoatM = rect(0, 452, 1000, 298) - PATHENV
cTop = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 1.2}, {"pale cadmium", 0.15}, turps=0.4, name="cTop"}
cMid = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="cMid"}
cLow = pile{{"Prussian blue", 0.4}, {"ultramarine blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 0.4}, turps=0.3, name="cLow"}
cTeal = pile{{"cerulean blue", 0.8}, {"Prussian blue", 0.2}, {"lead white", 1.0}, turps=0.3, name="cTeal"}
work(seaCoatM, {hand="broad", coverage=1.2, fill=true, clip=true, angle=0.02, edge="soft", piles={
  {cTop, function(x,y) return clamp(1 - (y-452)/60, 0, 1) end},
  {cMid, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {cLow, function(x,y) return clamp((y-580)/140, 0, 1) end},
  {cTeal, function(x,y) return 0.25 * clamp(1 - math.abs(y-500)/60, 0, 1) end}}})
print("sea coat trial laid")
