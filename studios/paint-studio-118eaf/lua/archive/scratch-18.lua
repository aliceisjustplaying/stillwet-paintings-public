-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
ld_mid2 = pile{{"raw umber", 1}, {"rose madder", 0.25}, {"ultramarine blue", 0.4}, {"lead white", 0.4}, {"burnt sienna", 0.2}, name="ld_mid2"}
ld_near2 = pile{{"raw umber", 1}, {"bone black", 0.4}, {"ultramarine blue", 0.5}, {"burnt sienna", 0.35}, {"rose madder", 0.1}, name="ld_near2"}
gm_dk = pile{{"raw umber", 1}, {"ultramarine blue", 0.35}, {"rose madder", 0.15}, {"bone black", 0.15}, {"lead white", 0.15}, name="gm_dk"}
gm_lt = pile{{"lead white", 1}, {"raw umber", 0.6}, {"rose madder", 0.25}, {"Naples yellow", 0.3}, {"ultramarine blue", 0.15}, name="gm_lt"}
cw_dark = pile{{"bone black", 1}, {"raw umber", 1}, {"ultramarine blue", 0.5}, name="cw_dark"}
gnd = mix{{ld_mid2, 0.7}, {ld_near2, 0.3}, name="gnd"}
local m = rect(50, 50, 500, 200)
work(m, {hand="body", tool={kind="flat", width=12, stiffness=0.6}, pile=gnd, coverage=1.8, fill=true, clip=m, angle=0, seed=1})
wait(10*24*60)
print(drying(200,150))

--@ chunk 3
pit_wall = mix{{gm_dk, 0.45}, {cw_dark, 0.55}, name="pit_wall"}
heap_dk = mix{{gm_dk, 0.65}, {cw_dark, 0.35}, name="heap_dk"}
heap_dk2 = mix{{gm_dk, 0.8}, {cw_dark, 0.2}, name="heap_dk2"}
local list = {{gm_dk, 80}, {heap_dk2, 160}, {heap_dk, 240}, {pit_wall, 320}, {cw_dark, 400}}
for i, e in ipairs(list) do
  local m = rect(e[2], 90, 50, 30)
  work(m, {hand="detail", tool={kind="round", width=2.5}, pile=e[1], coverage=3, clip=m, angle=0, seed=10+i})
end
-- a mound shape trial with lit clods on top
local mound = poly({{100,215},{120,195},{150,185},{185,183},{215,190},{240,205},{255,218}}, true):roughen(2, 5, 3)
work(mound, {hand="detail", tool={kind="round", width=2.5}, pile=heap_dk2, coverage=3, clip=mound, angle=0, seed=21})
wait(8*24*60)
print(drying(100,100), drying(150,200))
