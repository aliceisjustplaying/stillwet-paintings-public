-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
print(table.concat(tubes(), ", "))

--@ chunk 2
canvas{size=600, aspect=1.5, linen={18,15}, seed=7, ground={{pile={{"lead white",1}}, um=120, apply="knife", texture=0.3},{pile={{"lead white",3},{"yellow ochre",1},{"red earth",0.4}}, um=25, apply="brush"}}}

--@ chunk 3

h = pencil("HB")
h:rule({0, 440}, {1000, 440}, {pressure=0.25})
-- far shore and trees right
h:sketch({{560,436},{700,432},{760,420},{800,408},{850,404},{900,412},{950,418},{1000,420}}, {pressure=0.3})
-- barge hull
h:sketch({{215,448},{240,462},{360,464},{395,450}}, {pressure=0.35})
-- mast and sail
h:line({{300,452},{303,150}}, {pressure=0.35})
h:sketch({{303,165},{365,215},{380,300},{385,440}}, {pressure=0.3})
h:sketch({{300,170},{250,300},{238,445}}, {pressure=0.3})
-- foresail
h:sketch({{300,180},{215,440}}, {pressure=0.3})
-- mud spit lower left
h:sketch({{0,560},{120,545},{260,570},{380,610},{450,667}}, {pressure=0.3})
-- posts
h:line({{120,500},{122,575}}, {pressure=0.3})
h:line({{175,520},{176,585}}, {pressure=0.3})

