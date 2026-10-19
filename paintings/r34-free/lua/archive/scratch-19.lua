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
wait(5760)
print(drying(200,520), drying(800,600), drying(646,500))

--@ chunk 3
wedge = poly({{628,426},{664,426},{770,700},{512,700}}, true)
wedgeS = wedge:blur(9)
pTop = pile{{"pale cadmium", 0.5}, {"rose madder", 0.25}, {"lead white", 1.3}, turps=0.3, name="pTop"}
pMid = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.2}, turps=0.3, name="pMid"}
pLow = pile{{"ultramarine blue", 0.5}, {"permanent alizarin", 0.3}, {"lead white", 0.9}, turps=0.3, name="pLow"}
work(wedgeS * rect(0, 424, 1000, 300), {hand="broad", coverage=1.3, fill=true, clip=true, edge="soft", piles={
  {pTop, function(x,y) return clamp(1 - (y-426)/50, 0, 1) end},
  {pMid, function(x,y) return clamp(1 - math.abs(y-520)/70, 0, 1) end},
  {pLow, function(x,y) return clamp((y-560)/120, 0, 1) end}}})
print("path base laid", drying(646,500))

--@ chunk 4
gCream = pile{{"pale cadmium", 0.5}, {"lead white", 1.8}, turps=0.2, name="gCream"}
gWhite = pile{{"lead white", 1.0}, {"cadmium yellow", 0.3}, turps=0.2, name="gWhite"}
rb = brush{kind="round", width=3, point=1}
n = 0
for i = 1, 150 do
  local u = math.random()
  local y = 428 + 290 * (u ^ 1.5)
  local t = (y - 426) / 290
  local half = 4 + t * 100
  local cx = 646 - (y - 426) * 0.12
  local x0 = cx - half + math.random() * 2 * half
  local len = (5 + 10 * t) + math.random() * (10 + 40 * t)
  if i % 7 == 0 then rb:load((math.random() < 0.6) and gCream or gWhite, 0.8) end
  local pk = clamp((0.3 + 0.5 * math.random()) * (0.6 + 0.6 * t), 0, 1)
  rb:gesture({{x0, y, 0}, {x0 + len * 0.5, y + 0.2, pk}, {x0 + len, y + 0.4, 0}}, {})
  n = n + 1
end
print("tapered glints", n, rb:fullness())

--@ chunk 5
silB = pile{{"Prussian blue", 0.6}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.4}, {"bone black", 0.1}, {"lead white", 0.1}, name="silB"}
-- hull: a low curved wedge; bow to the right, sitting on the horizon line
hullB = outline{{784, 418, "c"}, {800, 424}, {826, 424}, {838, 416, "c"}, {818, 418}, {796, 416}, closed=true, char="firm", seed=4, amount=0.12}
hm = hullB:mask()
work(hm, {hand="detail", pile=silB, coverage=2.0, fill=true, clip=true})
-- main sail: one clean triangle, mast at its luff
sailB = poly({{806, 382}, {806, 414}, {788, 414}}, true)
work(sailB, {hand="detail", pile=silB, coverage=2.0, fill=true, clip=true})
-- jib: a small headsail forward of the mast
jibB = poly({{810, 390}, {810, 414}, {826, 414}}, true)
work(jibB, {hand="detail", pile=silB, coverage=2.0, fill=true, clip=true})
mastB = brush{kind="round", width=1.6, point=0}
mastB:load(silB, 1.0)
mastB:stroke({{806, 379}, {806, 418}}, {pressure=0.45})
print("boat trial laid")

--@ chunk 6
print("scratch-17 sky", drying(200,60), drying(500,200))
deepTop = pile{{"ultramarine blue", 0.9}, {"permanent alizarin", 0.35}, {"lead white", 0.35}, name="deepTop"}
topM = rect(0, 0, 1000, 150) * mask(function(x, y) return clamp((150 - y) / 80, 0, 1) end)
work(topM, {hand="broad", pile=deepTop, coverage=1.0, fill=true, edge="soft"})
print("deep top body laid", drying(200,60))

--@ chunk 7
print("scratch sea", drying(200,700), drying(800,700))
deepSea = pile{{"Prussian blue", 0.5}, {"ultramarine blue", 0.9}, {"permanent alizarin", 0.3}, {"lead white", 0.2}, turps=0.2, name="deepSea"}
cornerL = rect(0, 640, 330, 110) * mask(function(x, y) return clamp((x - 0) / 80, 0, 1) end)
work(cornerL, {hand="broad", pile=deepSea, angle=0.0, coverage=1.0, fill=true, edge="soft"})
print("corner laid", drying(150,700))

--@ chunk 8
blockM = rect(0, 640, 330, 110)
blend(blockM, {})
blend(blockM, {})
print("block blended", drying(150,700))

--@ chunk 9
rippleD = pile{{"ultramarine blue", 0.6}, {"permanent alizarin", 0.25}, {"Prussian blue", 0.3}, {"lead white", 0.35}, turps=0.2, name="rippleD"}
b3 = brush("flat", 3)
b3:load(rippleD, 0.3)
n = 0
for i = 1, 44 do
  local y = 650 + math.random() * 90
  local x = 6 + math.random() * 300
  local len = 40 + math.random() * 90
  b3:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.08 + 0.05 * math.random()})
  n = n + 1
end
print("dark ripples", n)
