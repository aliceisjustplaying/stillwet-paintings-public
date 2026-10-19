-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{size=900, aspect=1.5, linen={16,14}, seed=4417,
  ground={
    {pile={{"lead white",8},{"yellow ochre",0.3}}, um=110, apply="knife", texture=0.25},
    {pile={{"lead white",3},{"red earth",1.2},{"raw umber",1.0},{"yellow ochre",0.6}}, um=22, apply="brush"},
  }}
print(W, H)
