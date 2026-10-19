-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ limbs-join-nearest

--@ chunk 1
canvas{size=700, aspect=1.4, linen={18, 16}, seed=1822,
  ground={
    {pile={{"lead white", 3}, {"red earth", 2}, {"yellow ochre", 2}}, um=70, apply="knife", texture=0.4},
    {pile={{"lead white", 8}, {"yellow ochre", 0.6}, {"raw umber", 0.25}}, um=40, apply="knife", texture=0.25},
    {pile={{"lead white", 10}, {"yellow ochre", 0.3}, {"raw umber", 0.1}}, um=25, apply="brush"},
  }}
print(W, H)
print(table.concat(tubes(), ", "))
