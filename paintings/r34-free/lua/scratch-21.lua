-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
zen = pile{{"ultramarine blue", 1}, {"cerulean blue", 1}, {"lead white", 1.0}, turps=0.5}
blu2 = pile{{"cerulean blue", 1}, {"lead white", 1.3}, {"permanent alizarin", 0.3}, turps=0.5}
lil = pile{{"rose madder", 1}, {"ultramarine blue", 0.4}, {"lead white", 1.6}, turps=0.5}
pch = pile{{"pale cadmium", 1}, {"rose madder", 0.4}, {"lead white", 1.5}, turps=0.5}
gold = pile{{"cadmium yellow", 1}, {"lead white", 1.5}, turps=0.5}
sky = rect(0, 0, 1000, 425)
work(sky, {hand="broad", coverage=1.5, fill=true, piles={
  {zen, function(x,y) return clamp((120 - y)/120, 0, 1) end},
  {blu2, function(x,y) return clamp(1 - math.abs(y-110)/110, 0, 1) end},
  {lil, function(x,y) return clamp(1 - math.abs(y-220)/110, 0, 1) end},
  {pch, function(x,y) return clamp(1 - math.abs(y-330)/100, 0, 1) end},
  {gold, function(x,y) return clamp((y-360)/90, 0, 1) end}}})
wait(4320)
print(drying(200,60), drying(500,200))

--@ chunk 3
cTopS = pile{{"ultramarine blue", 0.6}, {"permanent alizarin", 0.5}, {"lead white", 0.8}, name="cTopS"}
cMidS = pile{{"permanent alizarin", 0.4}, {"rose madder", 0.5}, {"lead white", 1.1}, name="cMidS"}
cloudS = ellipse(800, 62, 140, 40)
work(cloudS, {hand="body", coverage=1.5, fill=true, clip=true, edge="soft", load=1.0, piles={
  {cTopS, function(x,y) return clamp((62 - y)/30, 0, 1) end},
  {cMidS, function(x,y) return clamp((y - 52)/30, 0, 1) end}}})
wait(4320)
print(drying(800,62), drying(760,50))

--@ chunk 4
wait(4320)
print(drying(800,62), drying(760,50))

--@ chunk 5
wait(2880)
print(drying(800,62), drying(760,50))

--@ chunk 6
wait(2880)
print(drying(800,62), drying(760,50))

--@ chunk 7
cutB = pile{{"cerulean blue", 0.9}, {"permanent alizarin", 0.2}, {"lead white", 1.3}, turps=0.3, name="cutB"}
upper = {}
for i = 0, 10 do
  local x = 668 + i * 27.2
  local y = 62 - 40 * math.sqrt(math.max(0, 1 - ((x - 800) / 140)^2)) + 4
  upper[#upper + 1] = {x, y}
end
bf = brush("flat", 4)
bf:load(cutB, 0.7)
bf:stroke(upper, {pressure = 0.45})
print("upper edge cut", drying(800,30), drying(800,28))

--@ chunk 8
dryB = pile{{"cerulean blue", 0.7}, {"permanent alizarin", 0.25}, {"lead white", 1.2}, turps=0.2, name="dryB"}
bd = brush("flat", 6)
bd:load(dryB, 0.2)
outer = {}
for i = 0, 12 do
  local x = 664 + i * 24
  local y = 62 - 40 * math.sqrt(math.max(0, 1 - ((x - 800) / 140)^2)) - 2
  outer[#outer + 1] = {x, y}
end
bd:stroke(outer, {pressure = 0.16})
print("dry brush along upper edge outside", drying(800,20))

--@ chunk 9
print("scratch-20 cloud", drying(800,62), drying(760,50))
tSky = pile{{"ultramarine blue", 0.7}, {"cerulean blue", 0.6}, {"lead white", 1.0}, name="tSky"}
mSky = pile{{"cerulean blue", 0.6}, {"permanent alizarin", 0.35}, {"lead white", 1.2}, name="mSky"}
bSky = pile{{"rose madder", 0.5}, {"permanent alizarin", 0.25}, {"lead white", 1.4}, {"ultramarine blue", 0.2}, name="bSky"}
coverT = rect(600, 0, 400, 126)
work(coverT, {hand="broad", coverage=1.5, fill=true, clip=true, edge="soft", load=1.0, piles={
  {tSky, function(x,y) return clamp((40 - y)/25, 0, 1) end},
  {mSky, function(x,y) return clamp(1 - math.abs(y - 50)/36, 0, 1) end},
  {bSky, function(x,y) return clamp((y - 60)/30, 0, 1) end}}})
print("sky-matched cover on scratch laid", drying(800,62))

--@ chunk 10
wait(4320)
print("cover", drying(800,20), drying(800,62), drying(800,110))

--@ chunk 11
wait(2880)
print("cover", drying(800,20), drying(800,62), drying(800,110))
