-- easel session "painting": a painting replayed chunk by chunk.

--@ chunk 1
canvas{size=300, aspect=1, linen=15, ground={{pile={{"lead white",1}},um=100,apply="knife"}}}
b = brush("flat", 20); b:load(pile{{"bone black",3}}); b:stroke({100,200,400,200})
print(drying(250,200))
