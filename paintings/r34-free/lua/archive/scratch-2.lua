-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
-- Revised sky trial: blue -> lilac -> peach -> gold, no green seam
zen = pile{{"ultramarine blue", 1}, {"cerulean blue", 1}, {"lead white", 1.0}, turps=0.5}
blu2 = pile{{"cerulean blue", 1}, {"lead white", 1.3}, {"permanent alizarin", 0.3}, turps=0.5}
lil = pile{{"rose madder", 1}, {"ultramarine blue", 0.4}, {"lead white", 1.6}, turps=0.5}
pch = pile{{"pale cadmium", 1}, {"rose madder", 0.4}, {"lead white", 1.5}, turps=0.5}
gold = pile{{"cadmium yellow", 1}, {"lead white", 1.5}, turps=0.5}
sky = rect(0, 0, 1000, 450)
b = brush("filbert", 22)
work(sky, {hand="broad", coverage=1.5, fill=true, piles={
  {zen, function(x,y) return clamp((120 - y)/120, 0, 1) end},
  {blu2, function(x,y) return clamp(1 - math.abs(y-110)/110, 0, 1) end},
  {lil, function(x,y) return clamp(1 - math.abs(y-220)/110, 0, 1) end},
  {pch, function(x,y) return clamp(1 - math.abs(y-330)/100, 0, 1) end},
  {gold, function(x,y) return clamp((y-360)/90, 0, 1) end}}})
print("sky laid 2")

--@ chunk 3
hd1 = pile{{"bone black", 1}, {"ultramarine blue", 1}, {"burnt sienna", 0.5}, {"lead white", 0.2}}
hd2 = pile{{"Prussian blue", 1}, {"burnt sienna", 0.7}, {"permanent alizarin", 0.2}}
print(hd1) print(hd2)
A = poly({{0,450},{0,400},{60,360},{120,330},{170,345},{230,395},{300,430},{330,450}}, true)
B = poly({{340,450},{380,425},{420,412},{470,430},{490,450}}, true)
b = brush("filbert", 12)
work(A * rect(0,0,1000,1000), {hand="body", pile=hd1, coverage=1.5, fill=true, clip=true})
work(B * rect(0,0,1000,1000), {hand="body", pile=hd2, coverage=1.5, fill=true, clip=true})
print("headland trial laid")

--@ chunk 4
seaA = pile{{"ultramarine blue", 0.6}, {"cerulean blue", 1}, {"lead white", 1}, {"permanent alizarin", 0.1}, turps=0.4}
sandA = pile{{"yellow ochre", 1}, {"lead white", 1}, {"raw umber", 0.2}, turps=0.4}
wetV = pile{{"ultramarine blue", 0.5}, {"burnt sienna", 0.5}, {"lead white", 1}, {"permanent alizarin", 0.2}, turps=0.3}
glint = pile{{"pale cadmium", 1}, {"lead white", 1.5}}
flats = rect(0, 450, 1000, 300)
b = brush("filbert", 16)
work(flats, {hand="broad", coverage=1.2, fill=true, piles={
  {seaA, function(x,y) return clamp(1 - (y-470)/40, 0, 1) end},
  {sandA, function(x,y) return clamp((y-500)/60, 0, 1) end},
  {wetV, function(x,y) return 0.6 end}}})
print("flats base laid")

--@ chunk 5
print(drying(500,100), drying(500,200), drying(500,300), drying(500,380), drying(500,600))

--@ chunk 6
wait(60)
print(drying(500,100), drying(500,200), drying(500,300), drying(500,380), drying(500,600))

--@ chunk 7
wait(240)
print(drying(500,100), drying(500,200), drying(500,300), drying(500,380), drying(500,600))

--@ chunk 8
wait(600)
print(drying(500,100), drying(500,200), drying(500,300), drying(500,380), drying(500,600))

--@ chunk 9
wait(300)
print(drying(500,100), drying(500,200), drying(500,300), drying(500,380), drying(500,600))
