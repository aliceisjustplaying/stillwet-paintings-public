-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
skyT = pile{{"ultramarine blue", 1}, {"cerulean blue", 1}, {"lead white", 1}, turps=0.8, name="skyT"}
skyM = pile{{"cerulean blue", 1}, {"lead white", 1.3}, {"permanent alizarin", 0.3}, turps=0.8, name="skyM"}
zoneS = rect(320, 10, 120, 60)
work(zoneS, {hand="broad", coverage=1.2, fill=true, edge="soft", piles={
  {skyT, function(x,y) return clamp(1 - y/60, 0, 1) end},
  {skyM, function(x,y) return clamp((y - 20)/40, 0, 1) end}}})
darkBar = pile{{"ultramarine blue", 0.8}, {"burnt sienna", 0.4}, {"permanent alizarin", 0.3}, {"lead white", 0.2}, turps=0.3, name="darkBar"}
bdk = brush("flat", 6)
bdk:load(darkBar, 0.5)
for i = 1, 6 do
  local y = 30 + (i - 1) * 3
  bdk:stroke({{334, y}, {404, y + 0.4}}, {pressure = 0.3})
end
blend(zoneS, {angle=0.02})
blend(zoneS, {angle=1.2})
blend(zoneS, {angle=0.02})
print("zone laid and blended 3 passes", drying(370,40))

--@ chunk 3
wait(2880)
print("zone after 2 days", drying(370,40), drying(340,40), drying(400,40))

--@ chunk 4
coolC = pile{{"cerulean blue", 1}, {"ultramarine blue", 0.3}, {"lead white", 0.7}, turps=0.3, name="coolC"}
coolCM = ellipse(370, 40, 34, 12):roughen(4, 16, 3):blur(8)
work(coolCM, {hand="body", pile=coolC, coverage=1.4, fill=true, clip=true, edge="soft", load=0.8})
print("cool cover on scratch", drying(370,40))

--@ chunk 5
wait(4320)
print("cool cover after 3 days", drying(370,40), drying(340,40))
