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
rBlk = pile{{"rose madder", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 1.0}, name="rBlk"}
bBlk = pile{{"ultramarine blue", 0.4}, {"permanent alizarin", 0.5}, {"rose madder", 0.5}, {"lead white", 0.9}, name="bBlk"}
blkM = rect(600, 0, 400, 126)
work(blkM, {hand="body", coverage=1.5, fill=true, clip=true, edge="soft", load=1.0, piles={
  {bBlk, function(x,y) return clamp((60 - y)/40, 0, 1) end},
  {rBlk, function(x,y) return clamp((y - 40)/40, 0, 1) end}}})
wait(8640)
print(drying(800,60), drying(700,100))

--@ chunk 3
wait(5760)
print(drying(800,60), drying(700,100))

--@ chunk 4
cvTop = pile{{"ultramarine blue", 0.6}, {"cerulean blue", 0.9}, {"lead white", 1.5}, name="cvTop"}
cvMid = pile{{"cerulean blue", 0.8}, {"rose madder", 0.3}, {"permanent alizarin", 0.15}, {"lead white", 1.6}, name="cvMid"}
cvLow = pile{{"rose madder", 0.5}, {"ultramarine blue", 0.3}, {"lead white", 1.8}, name="cvLow"}
cvP = poly({{520,0},{1000,0},{1000,128},{962,138},{904,126},{846,146},{784,132},{722,152},{662,138},{612,152},{566,136},{526,124},{506,70},{512,20}}, true)
cvSoft = cvP:roughen(6, 40, 7):blur(16)
work(cvSoft, {hand="body", coverage=1.8, fill=true, clip=true, edge="soft", load=1.0, piles={
  {cvTop, function(x,y) return clamp((55 - y)/40, 0, 1) end},
  {cvMid, function(x,y) return clamp(1 - math.abs(y - 80)/40, 0, 1) end},
  {cvLow, function(x,y) return clamp((y - 100)/40, 0, 1) end}}})
print("feathered cover laid", drying(800,60))

--@ chunk 5
wait(8640)
print(drying(800,60), drying(700,100))

--@ chunk 6
wait(2880)
print(drying(800,60), drying(700,100))
