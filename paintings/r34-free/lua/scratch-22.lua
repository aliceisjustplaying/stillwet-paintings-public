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
wait(5760)
print(drying(800,60), drying(700,100))

--@ chunk 3
rBlk = pile{{"rose madder", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 1.0}, name="rBlk"}
bBlk = pile{{"ultramarine blue", 0.4}, {"permanent alizarin", 0.5}, {"rose madder", 0.5}, {"lead white", 0.9}, name="bBlk"}
blkM = rect(600, 0, 400, 126)
work(blkM, {hand="body", coverage=1.5, fill=true, clip=true, edge="soft", load=1.0, piles={
  {bBlk, function(x,y) return clamp((60 - y)/40, 0, 1) end},
  {rBlk, function(x,y) return clamp((y - 40)/40, 0, 1) end}}})
wait(5760)
print(drying(800,60), drying(700,100))

--@ chunk 4
wait(5760)
print(drying(800,60), drying(700,100))

--@ chunk 5
wait(5760)
print(drying(800,60), drying(700,100))

--@ chunk 6
cvTop = pile{{"ultramarine blue", 0.6}, {"cerulean blue", 0.9}, {"lead white", 1.5}, name="cvTop"}
cvMid = pile{{"cerulean blue", 0.8}, {"rose madder", 0.3}, {"permanent alizarin", 0.15}, {"lead white", 1.6}, name="cvMid"}
cvLow = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.3}, {"lead white", 1.8}, name="cvLow"}
cvM = poly({{520,0},{1000,0},{1000,128},{962,138},{904,126},{846,146},{784,132},{722,152},{662,138},{612,152},{566,136},{526,124},{506,70},{512,20}}, true)
cvM = cvM:roughen(6, 40, 7)
work(cvM, {hand="body", coverage=1.8, fill=true, clip=true, edge="soft", load=1.0, piles={
  {cvTop, function(x,y) return clamp((55 - y)/40, 0, 1) end},
  {cvMid, function(x,y) return clamp(1 - math.abs(y - 80)/40, 0, 1) end},
  {cvLow, function(x,y) return clamp((y - 100)/40, 0, 1) end}}})
wait(5760)
print(drying(800,60), drying(700,100))

--@ chunk 7
wait(5760)
print(drying(800,60), drying(700,100))

--@ chunk 8
print("scratch-21 state", drying(490,60), drying(505,40), drying(700,100))
seamBand = poly({{462,0},{530,0},{530,150},{500,150},{482,120},{470,80},{462,40}}, true)
seamBand = seamBand:roughen(8, 30, 11)
midL = pile{{"ultramarine blue", 0.3}, {"permanent alizarin", 0.3}, {"cerulean blue", 0.4}, {"rose madder", 0.3}, {"lead white", 1.7}, name="midL"}
work(seamBand, {hand="body", pile=midL, coverage=1.4, fill=true, clip=true, edge="soft", load=1.0})
print("seam band laid on scratch", drying(495,60))

--@ chunk 9
wait(5760)
print("seam band", drying(495,60))

--@ chunk 10
wait(4320)
print("seam band", drying(495,60))

--@ chunk 11
print("seam state", drying(495,60), drying(470,60), drying(520,60))
stA = pile{{"cerulean blue", 0.6}, {"permanent alizarin", 0.3}, {"lead white", 1.4}, name="stA"}
stB = pile{{"rose madder", 0.5}, {"lead white", 1.4}, {"permanent alizarin", 0.2}, name="stB"}
db = brush("flat", 8)
n = 0
for i = 1, 26 do
  local y = 26 + math.random() * 96
  local x = 430 + math.random() * 110
  local len = 30 + math.random() * 60
  if i % 6 == 0 then db:load((math.random() < 0.5) and stA or stB, 0.22) end
  db:stroke({{x, y}, {x + len, y + (math.random() - 0.5) * 0.8}}, {pressure = 0.1 + 0.08 * math.random()})
  n = n + 1
end
print("horizontal dry streaks across seam", n)
