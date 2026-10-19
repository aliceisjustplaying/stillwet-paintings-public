-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
skyTopA = pile{{"ultramarine blue", 1}, {"cerulean blue", 1}, {"lead white", 1}, turps=0.5, name="skyTopA"}
skyTopB = pile{{"cerulean blue", 1}, {"lead white", 1.3}, {"permanent alizarin", 0.3}, turps=0.5, name="skyTopB"}
topBox = rect(0, 0, 500, 120)
work(topBox, {hand="broad", coverage=1.5, fill=true, piles={
  {skyTopA, function(x,y) return clamp(1 - y/60, 0, 1) end},
  {skyTopB, function(x,y) return clamp((y-20)/60, 0, 1) end}}})
print("sky lay on fresh scratch", drying(360,36))

--@ chunk 3
deepT = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.3}, {"cerulean blue", 0.3}, {"lead white", 0.4}, turps=0.5, name="deepT"}
b = brush("flat", 10)
b:load(deepT, 0.4)
for i = 1, 6 do
  local y = 22 + i * 6
  b:stroke({{300 + i * 4, y}, {410 - i * 3, y + 0.3}}, {pressure = 0.25})
end
print("six dark bars laid", drying(360,36))
blend(rect(0, 0, 420, 70), {})
print("blend 1", drying(360,36))
blend(rect(0, 0, 420, 70), {})
print("blend 2", drying(360,36))

--@ chunk 4
wait(2880)
print("scratch after 2 days", drying(360,36), drying(360,60), drying(300,30))

--@ chunk 5
washC = pile{{"cerulean blue", 0.6}, {"lead white", 0.4}, turps=0.85, name="washC"}
washM = ellipse(370, 52, 44, 14)
work(washM, {hand="broad", pile=washC, coverage=0.8, fill=true, clip=true, edge="soft"})
print("thin wash laid", drying(370,52))

--@ chunk 6
wait(240)
print("wash", drying(370,52), drying(340,52))

--@ chunk 7
wait(1440)
print("wash", drying(370,52), drying(340,52))
