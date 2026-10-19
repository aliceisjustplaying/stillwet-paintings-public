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
wait(40*24*60)
lev = pile{{"bone black",1},{"raw umber",1.2},{"green earth",0.3},{"Prussian blue",0.05}, medium=0.5, name="lev"}
local k = knife{width=50}
for r=0,15 do
  local y = 330 + r*21
  local x = -30 + (r%3)*35
  while x < 1030 do
    local x1 = math.min(x + 200, 1035)
    k:load(lev, 1.0); k:lay({{x,y},{(x+x1)/2,y+2},{x1,y}}, {pressure={0.12,0.12}})
    x = x1 + 2
  end
end
print("ok")
