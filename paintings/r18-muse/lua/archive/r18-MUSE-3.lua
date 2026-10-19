-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=450, aspect=1.35, linen={14,12}, seed=7, ground={{pile={{"lead white", 8},{"yellow ochre", 1},{"raw umber", 0.4}}, um=120, apply="knife", texture=0.35}, {pile={{"lead white", 5},{"yellow ochre", 1}}, um=40, apply="brush"}}}

--@ chunk 2

print(table.concat(tubes(), ", "))
skyTop = pile{{"lead white", 4}, {"cobalt blue", 1}, {"smalt", 0.6}, {"bone black", 0.08}}
skyMid = pile{{"lead white", 5}, {"pale smalt", 1.2}, {"yellow ochre", 0.35}, {"vermilion", 0.12}}
horizonGlow = pile{{"lead white", 5}, {"chrome yellow", 1.1}, {"vermilion", 0.45}, {"red earth", 0.25}}
print(skyTop)
print(skyMid)
print(horizonGlow)
sky = rect(0, 0, 1000, 430)
work(sky, {hand="broad", pile=skyMid, angle=0.1, coverage=2.2, seed=11})

--@ chunk 3

-- strengthen sky mixtures, lay top cool and low warm
skyTop2 = pile{{"lead white", 3}, {"cobalt blue", 1}, {"smalt", 0.7}, {"Prussian blue", 0.12}}
skyLow = pile{{"lead white", 4}, {"pale smalt", 0.8}, {"chrome yellow", 0.35}, {"vermilion", 0.22}}
glowCore = pile{{"lead white", 4}, {"chrome yellow", 1.4}, {"vermilion", 0.6}, {"yellow ochre", 0.5}}
print(skyTop2); print(skyLow); print(glowCore)
topBand = rect(0,0,1000,240)
work(topBand, {hand="broad", pile=skyTop2, angle=-0.05, coverage=3.2, fill=true, seed=21})

