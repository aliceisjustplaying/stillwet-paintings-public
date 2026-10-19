-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=500, aspect=1.25, linen={16,14}, seed=7, ground={{pile={{"lead white",6},{"yellow ochre",2},{"raw umber",0.4}}, um=150, apply="knife", texture=0.3}}}

--@ chunk 2
h = pencil("HB")
-- table edge (wall meets table)
h:rule({0,446},{1000,470},{pressure=0.2})
-- bottle
h:line({{238,606},{232,470},{238,398},{258,342},{276,304},{276,222},{296,220},{296,304},{314,344},{330,400},{340,470},{344,606}}, {pressure=0.2, smooth=true})
-- bowl rim (ellipse) and body
h:line({{498,542},{528,516},{578,504},{640,502},{702,508},{742,526},{762,546},{742,566},{692,578},{640,582},{578,576},{528,562},{500,550}}, {pressure=0.2, smooth=true})
h:line({{500,548},{508,592},{536,622},{588,634},{664,634},{712,618},{742,590},{760,548}}, {pressure=0.2, smooth=true})
-- pear (right foreground)
h:line({{820,660},{800,630},{806,590},{828,556},{852,540},{872,552},{878,590},{866,630},{852,660}}, {pressure=0.2, smooth=true})
h:line({{852,540},{856,512},{866,500}}, {pressure=0.2, smooth=true})
-- lemon (left foreground)
h:line({{92,662},{74,640},{80,614},{108,600},{146,600},{170,616},{168,644},{148,662}}, {pressure=0.2, smooth=true})

--@ chunk 3
h = pencil("B")
h:rule({0,446},{1000,470},{pressure=0.5})
h:line({{238,606},{232,470},{238,398},{258,342},{276,304},{276,222},{296,220},{296,304},{314,344},{330,400},{340,470},{344,606}}, {pressure=0.55, smooth=true})
h:line({{498,542},{528,516},{578,504},{640,502},{702,508},{742,526},{762,546},{742,566},{692,578},{640,582},{578,576},{528,562},{500,550}}, {pressure=0.55, smooth=true})
h:line({{500,548},{508,592},{536,622},{588,634},{664,634},{712,618},{742,590},{760,548}}, {pressure=0.55, smooth=true})
h:line({{820,660},{800,630},{806,590},{828,556},{852,540},{872,552},{878,590},{866,630},{852,660}}, {pressure=0.55, smooth=true})
h:line({{852,540},{856,512},{866,500}}, {pressure=0.55, smooth=true})
h:line({{92,662},{74,640},{80,614},{108,600},{146,600},{170,616},{168,644},{148,662}}, {pressure=0.55, smooth=true})

