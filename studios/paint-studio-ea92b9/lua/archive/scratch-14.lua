-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
h_dark2  = pile{{"raw umber",1.5},{"bone black",0.8},{"green earth",0.4},{"Prussian blue",0.04}, name="h_dark2"}
hf_deep2 = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.3},{"Prussian blue",0.05}, medium=0.25, name="hf_deep2"}
local m = rect(0,300,1000,414)
work(m, {hand="body", tool="filbert 7", pile=h_dark2, angle=0.03, coverage=2.6, fill=true, clip=m, length={20,55}, seed=171})
wait(6*24*60)
work(m, {hand="body", tool="filbert 9", pile=hf_deep2, angle=0.02, coverage=2.4, fill=true, clip=m, length={25,70}, seed=172})
wait(30*24*60)
lev = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.3},{"Prussian blue",0.05}, medium=0.5, name="lev"}
lev2 = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.3},{"Prussian blue",0.05}, medium=0.3, name="lev2"}
local k = knife{width=50}
for y=320,690,22 do k:load(lev, 1.0); k:lay({{5,y},{120,y+2},{245,y}}, {pressure={0.12,0.12}}) end
for y=320,690,22 do k:load(lev, 1.0); k:lay({{255,y},{370,y+2},{495,y}}, {pressure={0.22,0.22}}) end
for y=320,690,22 do k:load(lev2, 1.0); k:lay({{505,y},{620,y+2},{745,y}}, {pressure={0.22,0.22}}) end
-- knife then soft blend
for y=320,690,22 do k:load(lev, 1.0); k:lay({{755,y},{870,y+2},{995,y}}, {pressure={0.3,0.3}}) end
blend(rect(757,312,236,386), {angle=0})
print(wait(25*24*60))
