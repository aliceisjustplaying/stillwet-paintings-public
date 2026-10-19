-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 1}}, texture=0.25, um=70}, {apply="brush", pile={{"lead white", 3}, {"yellow ochre", 1.2}, {"raw umber", 1}, {"red earth", 0.35}}, um=25}}, linen={16, 14}, seed=1873, size=700}

--@ chunk 2
darkA = pile{{"raw umber", 2}, {"burnt sienna", 1}, {"bone black", 0.5}, turps=0.5}
darkB = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.4}, turps=0.4}
glow = pile{{"burnt sienna", 1}, {"yellow ochre", 1}, {"raw umber", 0.3}, turps=0.5}
glow2 = pile{{"burnt sienna", 1}, {"raw umber", 1}, turps=0.6}
pale = pile{{"lead white", 6}, {"Naples yellow", 1}}
work(rect(20, 20, 180, 200), {hand="broad", pile=darkA, coverage=1.5})
work(rect(220, 20, 180, 200), {hand="broad", pile=darkB, coverage=1.5})
work(rect(420, 20, 180, 200), {hand="broad", pile=glow, coverage=1.5})
work(rect(620, 20, 180, 200), {hand="broad", pile=glow2, coverage=1.5})
work(rect(820, 20, 160, 200), {hand="body", pile=pale, coverage=2})
work(rect(20, 260, 180, 200), {hand="broad", pile=darkA, coverage=3})

--@ chunk 3
wallD = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.5}, turps=0.3}
wallD2 = pile{{"raw umber", 2}, {"bone black", 1}, {"burnt sienna", 0.5}, turps=0.15}
warmD = pile{{"raw umber", 2}, {"burnt sienna", 1.2}, {"bone black", 0.4}, turps=0.3}
work(rect(260, 260, 160, 200), {hand="body", pile=wallD, coverage=2, fill=true, clip=true})
work(rect(440, 260, 160, 200), {hand="body", pile=wallD2, coverage=2, fill=true, clip=true})
work(rect(620, 260, 160, 200), {hand="body", pile=warmD, coverage=2, fill=true, clip=true})

--@ chunk 4
wallHi = pile{{"yellow ochre", 2}, {"burnt sienna", 0.6}, {"lead white", 0.7}, {"raw umber", 0.2}}
wallMid = pile{{"raw umber", 1}, {"burnt sienna", 1}, {"yellow ochre", 1}}
work(rect(20, 520, 470, 100), {hand="body", tool="filbert 12", pile=wallHi, coverage=2, fill=true, clip=rect(20, 520, 470, 100), angle=0})
work(rect(510, 520, 470, 100), {hand="body", tool="filbert 12", pile=wallMid, coverage=2, fill=true, clip=rect(510, 520, 470, 100), angle=0})
print(wait(10 * 24 * 60))
print(drying(200, 570), drying(700, 570))

--@ chunk 5
gA = pile{{"burnt sienna", 1}, {"bone black", 0.5}, medium=0.75}
gB = pile{{"burnt sienna", 1}, {"bone black", 1}, {"raw umber", 0.5}, medium=0.6}
gC = pile{{"bitumen", 1}, {"bone black", 0.3}, medium=0.6}
for i, g in ipairs({gA, gB, gC}) do
  local x = 20 + (i - 1) * 160
  work(rect(x + 10, 510, 130, 260), {hand="glaze", pile=g, coverage=1})
  local x2 = 510 + (i - 1) * 160
  work(rect(x2 + 10, 510, 130, 260), {hand="glaze", pile=g, coverage=1})
end

--@ chunk 6
print(wait(3 * 24 * 60))
gD = pile{{"burnt sienna", 1}, {"bone black", 0.6}, {"raw umber", 0.4}, medium=0.35}
gE = pile{{"bone black", 1}, {"raw umber", 1}, {"burnt sienna", 0.5}, medium=0.3}
-- columns across the wallHi swatch: gD single, gD double, gE single, gE double
work(rect(30, 525, 70, 90), {hand="glaze", pile=gD, coverage=1})
work(rect(140, 525, 70, 90), {hand="glaze", pile=gD, coverage=1})
work(rect(250, 525, 70, 90), {hand="glaze", pile=gE, coverage=1})
work(rect(360, 525, 70, 90), {hand="glaze", pile=gE, coverage=1})
work(rect(530, 525, 70, 90), {hand="glaze", pile=gD, coverage=1})
work(rect(640, 525, 70, 90), {hand="glaze", pile=gE, coverage=1})
work(rect(140, 525, 70, 90), {hand="glaze", pile=gD, coverage=1})
work(rect(360, 525, 70, 90), {hand="glaze", pile=gE, coverage=1})
