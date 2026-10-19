-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
h_dark2  = pile{{"raw umber",1.5},{"bone black",0.8},{"green earth",0.4},{"Prussian blue",0.04}, name="h_dark2"}
local m = rect(0,300,1000,414)
work(m, {hand="body", tool="filbert 7", pile=h_dark2, angle=0.03, coverage=2.6, fill=true, clip=m, length={20,55}, seed=171})
wait(6*24*60)
hf_base  = pile{{"raw umber",1.4},{"bone black",0.6},{"green earth",0.5},{"yellow ochre",0.1}, medium=0.3, name="hf_base"}
hf_slope = pile{{"raw umber",1.3},{"green earth",0.7},{"yellow ochre",0.35},{"bone black",0.25},{"lead white",0.12}, medium=0.3, name="hf_slope"}
-- A: medium paint, body hand
work(rect(0,320,330,380), {hand="body", tool="filbert 9", pile=hf_base, angle=0.03, coverage=2.2, fill=true, clip=rect(0,320,330,380), seed=1})
-- B: same + blend
work(rect(340,320,330,380), {hand="body", tool="filbert 9", pile=hf_base, angle=0.03, coverage=2.2, fill=true, clip=rect(340,320,330,380), seed=2})
blend(rect(342,322,326,376), {angle=0.03})
-- C: broad hand, slope pile graded into base
work(rect(680,320,320,380), {hand="broad", piles={{hf_slope, function(x,y) return clamp(1-(y-320)/200,0,1) end},{hf_base, function(x,y) return clamp((y-320)/200,0.05,1) end}}, angle=0.03, coverage=2.2, fill=true, clip=rect(680,320,320,380), seed=3})
blend(rect(682,322,316,376), {angle=0.03})

--@ chunk 3
hf_deep2 = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.3},{"Prussian blue",0.05}, medium=0.25, name="hf_deep2"}
hf_lev = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.3},{"Prussian blue",0.05}, medium=0.45, name="hf_lev"}
print(drying(150,500), drying(500,500))
-- A: knife lay directly over wet strip, firm pressure, horizontal sweeps
local k = knife{width=40}
for y=330,690,30 do
  k:load(hf_lev, 1.0)
  k:lay({{10,y},{160,y+3},{320,y}}, {pressure={0.8,0.8}})
end
-- B: scrape wet first, then knife lay
local k2 = knife{width=40}
for y=330,690,30 do
  k2:scrape({{345,y},{665,y}}, {pressure=1}); k2:wipe()
end
for y=330,690,30 do
  k2:load(hf_lev, 1.0)
  k2:lay({{350,y},{500,y+3},{660,y}}, {pressure={0.8,0.8}})
end
-- C: just blend more on strip C (already blended once)
blend(rect(682,322,316,376), {angle=0.03})
blend(rect(682,322,316,376), {angle=-0.03})

--@ chunk 4
print(wait(8*24*60), drying(150,500), drying(500,500), drying(800,500))
local k = knife{width=60}
for y=340,680,40 do
  k:load(hf_lev, 1.0)
  k:lay({{10,y},{160,y+2},{320,y}}, {pressure={0.4,0.4}})
end
local k2 = knife{width=60}
for y=340,680,40 do
  k2:load(hf_lev, 1.0)
  k2:lay({{350,y},{500,y+2},{660,y}}, {pressure={0.9,0.9}})
end
-- C: medium-rich paint brushed with soft broad brush and blended
local soft = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.3},{"Prussian blue",0.05}, medium=0.6, name="soft"}
work(rect(682,322,316,376), {hand="glaze", pile=soft, angle=0, coverage=2.5, fill=true, clip=rect(682,322,316,376), seed=9})
blend(rect(684,324,312,372), {angle=0})
