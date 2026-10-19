-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
h_dark2  = pile{{"raw umber",1.5},{"bone black",0.8},{"green earth",0.4},{"Prussian blue",0.04}, name="h_dark2"}
h_crest2 = pile{{"raw umber",1.5},{"bone black",0.5},{"green earth",0.6},{"yellow ochre",0.2},{"smalt",0.3},{"lead white",0.15}, name="h_crest2"}
local m = rect(0,400,1000,314)
work(m, {hand="body", tool="filbert 7", piles={{h_crest2, function(x,y) return clamp(1-(y-400)/35,0,1) end},{h_dark2, function(x,y) return clamp((y-400)/35,0.05,1) end}}, angle=0.03, coverage=2.6, fill=true, clip=m, length={20,55}, seed=171})
print(wait(5*24*60), drying(500,500))
-- glaze trials in 4 vertical strips
g1 = pile{{"bone black",1},{"raw umber",1},{"Prussian blue",0.1}, medium=0.75, name="g1"}
g2 = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.6},{"Prussian blue",0.06}, medium=0.7, name="g2"}
g3 = pile{{"raw umber",1.5},{"bone black",0.5},{"rose madder",0.2}, medium=0.8, name="g3"}
work(rect(0,410,250,300), {hand="glaze", pile=g1, angle=0, coverage=1.5, clip=rect(0,410,250,300), seed=1})
work(rect(250,410,250,300), {hand="glaze", pile=g2, angle=0, coverage=1.5, clip=rect(250,410,250,300), seed=2})
work(rect(500,410,250,300), {hand="glaze", pile=g3, angle=0, coverage=1.5, clip=rect(500,410,250,300), seed=3})

--@ chunk 3
work(rect(750,410,250,300), {hand="glaze", pile=g2, angle=0, coverage=2.5, fill=true, clip=rect(750,410,250,300), seed=4})
blend(rect(752,412,246,296), {angle=0})
blend(rect(752,412,246,296), {angle=0.1})
-- also blend strip 2
blend(rect(252,412,246,296), {angle=0})
blend(rect(252,412,246,296), {angle=0.1})
