-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.35, ground={{apply="knife", pile={{"lead white", 6}, {"yellow ochre", 1}, {"raw umber", 0.35}}, texture=0.35, um=90}}, linen={18, 16}, seed=7, size=900}

--@ chunk 2
pale = pile{{"lead white",1.6},{"green earth",1.5},{"ultramarine blue",0.7},{"yellow ochre",0.7},{"raw umber",0.4},{"cobalt violet",0.2}, name="pale"}
work(rect(100,300,800,200), {hand="broad", pile=pale, coverage=1.4, fill=true})
print(wait(5*24*60)); print(drying(500,400))

--@ chunk 3
tree_old = pile{{"ultramarine blue",1},{"yellow ochre",1.5},{"raw umber",1.5},{"bone black",0.8},{"viridian",0.5}, name="tree_old"}
tree_opaque = pile{{"yellow ochre",2.2},{"Prussian blue",0.7},{"raw umber",1.1},{"bone black",0.5},{"lead white",0.35},{"red earth",0.25}, name="tree_opaque"}
lit2 = pile{{"yellow ochre",2},{"green earth",1},{"viridian",0.6},{"lead white",0.8},{"raw umber",0.5}, name="lit2"}
-- left patch: old recipe as used on crowns; right patch: opaque recipe; both body cov1.45 over dry pale
work(ellipse(320,400,110,65), {hand="body", angle=0.5, coverage=1.45, fill=true, edge="soft",
 piles={{tree_old,1.1},{lit2,0.25}}})
work(ellipse(640,400,110,65), {hand="body", angle=0.5, coverage=1.45, fill=true, edge="soft",
 piles={{tree_opaque,1.1},{lit2,0.25}}})
print("trials laid")
