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
cTop = pile{{"rose madder", 0.3}, {"ultramarine blue", 0.2}, {"lead white", 1.2}, {"pale cadmium", 0.15}, turps=0.4, name="cTop"}
cMid = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.5}, {"lead white", 0.9}, turps=0.4, name="cMid"}
cLow = pile{{"Prussian blue", 0.4}, {"ultramarine blue", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 0.4}, turps=0.3, name="cLow"}
PATHENV = poly({{628,440},{664,440},{722,650},{520,650}}, true)
seaCoatM = rect(0, 452, 1000, 298) - PATHENV
work(seaCoatM, {hand="broad", coverage=1.2, fill=true, clip=true, angle=0.02, edge="soft", piles={
  {cTop, function(x,y) return clamp(1 - (y-452)/60, 0, 1) end},
  {cMid, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {cLow, function(x,y) return clamp((y-580)/140, 0, 1) end}}})
wait(5760)
muteP = pile{{"ultramarine blue", 0.7}, {"permanent alizarin", 0.4}, {"Prussian blue", 0.15}, {"lead white", 0.9}, turps=0.3, name="muteP"}
muteM = rect(0, 640, 320, 110):blur(14) * rect(0, 452, 1000, 298)
work(muteM, {hand="broad", pile=muteP, coverage=1.1, fill=true, clip=true, edge="soft", load=0.9, angle=0.02})
wait(8640)
print("strip on scratch-26", drying(120,683))

--@ chunk 3
work(seaCoatM, {hand="broad", coverage=1.2, fill=true, clip=true, angle=0.02, edge="soft", piles={
  {cTop, function(x,y) return clamp(1 - (y-452)/60, 0, 1) end},
  {cMid, function(x,y) return clamp(1 - math.abs(y-560)/120, 0, 1) end},
  {cLow, function(x,y) return clamp((y-580)/140, 0, 1) end}}})
wait(8640)
print("re-laid sea on scratch-26", drying(120,683))

--@ chunk 4
print("scratch sea", drying(120,520), drying(300,600), drying(120,683), drying(800,600))

--@ chunk 5
rippleL = pile{{"rose madder", 0.3}, {"lead white", 1.2}, {"ultramarine blue", 0.2}, turps=0.25, name="rippleL"}
rippleG = pile{{"cerulean blue", 0.5}, {"ultramarine blue", 0.2}, {"lead white", 1.1}, turps=0.25, name="rippleG"}
peachR = pile{{"pale cadmium", 0.3}, {"rose madder", 0.3}, {"lead white", 1.2}, turps=0.25, name="peachR"}
teal2 = pile{{"cerulean blue", 0.6}, {"raw umber", 0.15}, {"lead white", 1.0}, turps=0.2, name="teal2"}
b7 = brush("flat", 3)
n = 0
local cur = nil
for i = 1, 44 do
  local y = 540 + (math.random() ^ 1.25) * 204
  local t = (y - 540) / 204
  local cx = 646 - (y - 440) * 0.08
  local x = math.random() * 1000
  local near = math.abs(x - cx) < 80
  local pick
  if near and math.random() < 0.6 then pick = peachR
  elseif math.random() < 0.5 then pick = rippleL
  elseif math.random() < 0.5 then pick = rippleG
  else pick = teal2 end
  if pick ~= cur or i % 8 == 0 then b7:reload(pick, 0.3); cur = pick end
  local len = 18 + 50 * t + math.random() * (14 + 40 * t)
  b7:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.04 * math.random()})
  n = n + 1
end
print("lower ripples trial", n, b7:fullness())

--@ chunk 6
n = 0
local cur = nil
for i = 1, 16 do
  local y = 552 + (math.random() ^ 1.5) * 150
  local t = (y - 540) / 204
  local cx = 646 - (y - 440) * 0.08
  local x = math.random() * 1000
  local near = math.abs(x - cx) < 80
  local pick
  if near and math.random() < 0.7 then pick = peachR
  elseif math.random() < 0.55 then pick = rippleL
  else pick = rippleG end
  if pick ~= cur or i % 8 == 0 then b7:reload(pick, 0.3); cur = pick end
  local len = 22 + 50 * t + math.random() * (14 + 40 * t)
  b7:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.4}}, {pressure = 0.07 + 0.03 * math.random()})
  n = n + 1
end
print("denser second layer", n)
