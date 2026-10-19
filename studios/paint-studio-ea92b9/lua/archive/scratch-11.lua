-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
hz = pile{{"lead white",1.2},{"smalt",1.2},{"raw umber",0.8},{"rose madder",0.1},{"Naples yellow",0.2}, name="hz"}
dk = pile{{"raw umber",0.49},{"green earth",0.25},{"yellow ochre",0.08},{"smalt",0.16},{"lead white",0.09},{"bone black",0.11}, name="dk"}
work(rect(0,0,1000,714), {hand="broad", pile=hz, angle=0, coverage=2.2, fill=true, seed=1})
wait(4*24*60)
for i=0,3 do
  local x = 100 + i*230
  work(ellipse(x, 300, 60, 14) + rect(x-60,300,120,6), {hand="detail", tool={kind="round", width=2, point=0.5}, pile=dk, coverage=3, fill=true, seed=10+i})
end
print(wait(10*24*60), drying(100,300))

--@ chunk 3
veil = pile{{"lead white",1.2},{"smalt",1.2},{"raw umber",0.8},{"rose madder",0.1},{"Naples yellow",0.2}, thinner=0.6, name="veil"}
veil2 = pile{{"lead white",1.2},{"smalt",1.2},{"raw umber",0.8},{"rose madder",0.1},{"Naples yellow",0.2}, medium=0.5, name="veil2"}
-- 1: thinner veil, one pass, body hand small filbert
work(rect(30,270,140,45), {hand="body", tool="filbert 5", pile=veil, angle=0, coverage=1.5, fill=true, clip=rect(30,270,140,45), seed=21})
-- 2: thinner veil, three light passes
for i=1,3 do work(rect(260,270,140,45), {hand="body", tool="filbert 5", pile=veil, angle=0, coverage=1.2, clip=rect(260,270,140,45), seed=30+i}) end
-- 3: medium veil glaze-like and blend
work(rect(490,270,140,45), {hand="body", tool="filbert 5", pile=veil2, angle=0, coverage=1.5, fill=true, clip=rect(490,270,140,45), seed=41})
blend(rect(490,270,140,45), {angle=0})
-- 4: scumble hand with thinner veil
work(rect(720,270,140,45), {hand="scumble", pile=veil, coverage=1.5, clip=rect(720,270,140,45), seed=51})
