-- easel session "audit": a painting replayed chunk by chunk.
--   easel run paintings/lua/audit.lua
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=100,aspect=4,linen=15,ground={{pile={{"lead white",1}},um=50,apply="knife"}}}

--@ chunk 2
p=pile{{"bone black",1},medium=0.9}; print(wait(0)); glaze(nil,{pile=p,coats=20}); print(drying(500,100)); print(wait(0))

--@ chunk 3
b=brush("round",10); b:load(p,1); b:stroke({{100,100},{200,100}}); print(drying(150,100)); print(wait(0)); print(wait(1e100)); print(drying(150,100))
