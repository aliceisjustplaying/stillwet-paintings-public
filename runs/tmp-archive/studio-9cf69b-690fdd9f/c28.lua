stoneDark = pile{{"bone black",1},{"raw umber",1},{"lead white",1.3},{"pale smalt",0.8}, medium=0.08}
stoneMid  = pile{{"bone black",0.6},{"raw umber",0.7},{"lead white",2.2},{"pale smalt",1.0},{"yellow ochre",0.1}, medium=0.08}
chamber   = pile{{"bone black",1.4},{"raw umber",1.2},{"smalt",0.3},{"lead white",0.3}, medium=0.08}
cap = outline{{274,386,"c"},{282,374},{300,366},{330,362},{362,363},{394,366},{416,371},{428,380,"c"},{424,392,"c"},{400,397},{360,395},{320,399},{290,398},{274,394,"c"}, char="broken", seed=41, closed=true, amount=0.6}
u1 = outline{{287,432,"c"},{285,410},{290,392,"c"},{314,390,"c"},{320,412},{318,431,"c"}, char="broken", seed=42, closed=true, amount=0.6}
u2 = outline{{341,428,"c"},{340,410},{344,394,"c"},{364,394,"c"},{368,412},{366,428,"c"}, char="broken", seed=43, closed=true, amount=0.6}
u3 = outline{{384,431,"c"},{383,410},{388,392,"c"},{410,392,"c"},{416,410},{414,432,"c"}, char="broken", seed=44, closed=true, amount=0.6}
f1 = outline{{438,434,"c"},{444,420},{458,414},{474,418},{480,430,"c"}, char="broken", seed=45, closed=true, amount=0.5}
f2 = outline{{244,432,"c"},{248,422},{262,419},{270,426},{268,434,"c"}, char="broken", seed=46, closed=true, amount=0.5}
-- the chamber: the dark between the uprights, under the slab
chamberM = poly({{300,396},{410,394},{410,428},{300,430}})
work(chamberM, {hand="detail", pile=chamber, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=0})
stonesM = cap:mask() + u1:mask() + u2:mask() + u3:mask() + f1:mask() + f2:mask()
work(stonesM, {hand="detail", pile=stoneDark, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=-0.3, angle_jitter=0.6})
