-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
zen = pile{{"ultramarine blue", 1}, {"cerulean blue", 1}, {"lead white", 1.0}, turps=0.5, name="zen"}
blu2 = pile{{"cerulean blue", 1}, {"lead white", 1.3}, {"permanent alizarin", 0.3}, turps=0.5, name="blu2"}
lil = pile{{"rose madder", 1}, {"ultramarine blue", 0.4}, {"lead white", 1.6}, turps=0.5, name="lil"}
dk = pile{{"ultramarine blue", 0.8}, {"permanent alizarin", 0.3}, {"cerulean blue", 0.3}, {"lead white", 0.4}, turps=0.5, name="dk"}
skyS = rect(0, 0, 1000, 125)
work(skyS, {hand="broad", coverage=1.5, fill=true, piles={
  {zen, function(x,y) return clamp((120 - y)/120, 0, 1) end},
  {blu2, function(x,y) return clamp(1 - math.abs(y-60)/60, 0, 1) end},
  {lil, function(x,y) return clamp(1 - math.abs(y-110)/50, 0, 1) end}}})
testS = rect(0, 0, 420, 70)
b = brush("flat", 10)
b:load(dk, 0.4)
for i = 1, 6 do
  local y = 12 + i * 8
  local x = 20 + math.random() * 60
  b:stroke({{x, y}, {x + 200 + math.random() * 120, y + (math.random() - 0.5) * 3}}, {pressure = 0.2})
end
blend(testS, {})
blend(testS, {})
print("sky laid, dark bars, box blended twice", drying(360,40))

--@ chunk 3
wait(5 * 1440)
print("blended sky after 5 days", drying(360,40), drying(200,60))

--@ chunk 4
cvT = pile{{"cerulean blue", 1}, {"ultramarine blue", 0.4}, {"permanent alizarin", 0.25}, {"lead white", 0.9}, name="cvT"}
cvM2 = pile{{"cerulean blue", 0.8}, {"lead white", 1.2}, {"permanent alizarin", 0.2}, name="cvM2"}
streakM = ellipse(370, 40, 34, 12):roughen(4, 20, 5):blur(8)
work(streakM, {hand="body", coverage=1.6, fill=true, clip=true, edge="soft", load=1.0, piles={
  {cvT, function(x,y) return clamp((36 - y)/10, 0, 1) end},
  {cvM2, function(x,y) return clamp(1 - math.abs(y-40)/10, 0, 1) end}}})
print("sky-matched body cover over the streak, scratch", drying(370,40))

--@ chunk 5
wait(5 * 1440)
print("cover after 5 days", drying(370,40))

--@ chunk 6
wait(4 * 1440)
print("cover after 9 days", drying(370,40))
