-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
skyT = pile{{"ultramarine blue", 1}, {"cerulean blue", 1}, {"lead white", 1}, turps=0.5, name="skyT"}
skyM = pile{{"cerulean blue", 1}, {"lead white", 1.3}, {"permanent alizarin", 0.3}, turps=0.5, name="skyM"}
sky0 = rect(250, 0, 250, 120)
work(sky0, {hand="broad", coverage=1.5, fill=true, edge="soft", piles={
  {skyT, function(x,y) return clamp(1 - y/60, 0, 1) end},
  {skyM, function(x,y) return clamp(1 - math.abs(y-95)/50, 0, 1) end}}})
print("sky lay on scratch", drying(370,40), drying(370,95))

--@ chunk 3
darkBar = pile{{"ultramarine blue", 0.8}, {"burnt sienna", 0.4}, {"permanent alizarin", 0.3}, {"lead white", 0.2}, turps=0.3, name="darkBar"}
bdk = brush("flat", 6)
bdk:load(darkBar, 0.5)
for i = 1, 6 do
  local y = 30 + (i - 1) * 3
  bdk:stroke({{334, y}, {404, y + 0.4}}, {pressure = 0.3})
end
zoneG = rect(320, 20, 110, 40)
blend(zoneG, {angle=0.02})
blend(zoneG, {angle=0.02})
print("grain zone blended", drying(370,40))

--@ chunk 4
wait(2880)
print("grain zone after 2 days", drying(370,40), drying(330,36), drying(300,40))
