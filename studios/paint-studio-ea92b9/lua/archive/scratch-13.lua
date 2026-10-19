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
print(wait(30*24*60), drying(500,500))

--@ chunk 3
lev = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.3},{"Prussian blue",0.05}, medium=0.5, name="lev"}
soft = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.3},{"Prussian blue",0.05}, medium=0.6, name="soft"}
local k = knife{width=60}
for y=320,690,28 do k:load(lev, 1.0); k:lay({{5,y},{120,y+2},{245,y}}, {pressure={0.6,0.6}}) end
work(rect(255,310,240,390), {hand="glaze", pile=soft, angle=0, coverage=2.5, fill=true, clip=rect(255,310,240,390), seed=2})
blend(rect(257,312,236,386), {angle=0})
local k2 = knife{width=60}
for y=320,690,28 do k2:load(lev, 1.0); k2:lay({{505,y},{620,y+2},{745,y}}, {pressure={0.3,0.3}}) end
work(rect(755,310,240,390), {hand="broad", pile=lev, angle=0, coverage=3, fill=true, clip=rect(755,310,240,390), seed=4})
blend(rect(757,312,236,386), {angle=0}); blend(rect(757,312,236,386), {angle=0.05})
print(wait(20*24*60))
