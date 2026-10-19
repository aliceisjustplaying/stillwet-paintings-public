-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 10}, {"bone black", 0.2}}, texture=0.3, um=120}, {apply="brush", pile={{"lead white", 6}, {"red earth", 1.2}, {"raw umber", 1}, {"yellow ochre", 0.6}}, texture=0.5, um=40}}, linen={16, 14}, seed=4471, size=900}

--@ chunk 2
-- reproduce the coat: md body -> dk body + folds + blend -> dry -> glaze4 -> dry; then trial glaze6 on back half
cw_coat_dk = pile{{"raw umber", 1}, {"bone black", 0.35}, {"ultramarine blue", 0.45}, {"burnt sienna", 0.4}, {"lead white", 0.05}}
cw_coat_md = pile{{"raw umber", 1}, {"burnt sienna", 0.6}, {"ultramarine blue", 0.3}, {"rose madder", 0.12}, {"lead white", 0.18}}
coat_hi = pile{{"raw umber", 1}, {"burnt sienna", 0.7}, {"Naples yellow", 0.4}, {"lead white", 0.35}, {"rose madder", 0.1}}
coat_glaze4 = pile{{"burnt sienna", 1}, {"ultramarine blue", 0.55}, {"bone black", 0.2}, medium=0.75}
local base = rect(100, 100, 300, 300)
work(base, {hand="body", pile=cw_coat_md, coverage=2, fill=true, clip=true, angle=1.5, seed=15})
wait(10*24*60)
work(base, {hand="body", pile=cw_coat_dk, coverage=1.6, fill=true, clip=true, angle=1.5, seed=16})
local fb = brush{kind="filbert", width=14, stiffness=0.45}
for i = 0, 3 do fb:reload(coat_hi, 0.4) fb:gesture({{140 + i*70, 110, 0.05}, {136 + i*70, 250, 0.6}, {130 + i*70, 390, 0.5}}, {wobble=2.5, clip=base}) end
blend(base, {angle=1.5})
wait(10*24*60)
work(base, {hand="glaze", pile=coat_glaze4, coverage=2, fill=true, clip=true, angle=1.5, seed=17})
blend(base, {angle=1.5})
wait(10*24*60)
coat_glaze6 = pile{{"burnt sienna", 0.6}, {"ultramarine blue", 0.8}, {"bone black", 0.25}, {"raw umber", 0.3}, medium=0.8}
local back = base * mask(function(x, y) return 1 - smoothstep(220, 280, x) end)
work(back, {hand="glaze", pile=coat_glaze6, coverage=2, fill=true, clip=base, angle=1.5, seed=18})
blend(base * mask(function(x, y) return 1 - smoothstep(250, 310, x) end), {angle=1.5})
