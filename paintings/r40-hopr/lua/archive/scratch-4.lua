-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box hopper
--@ engine 5

--@ chunk 1
canvas{aspect=1.6, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.25}}, texture=0.3, um=90}}, linen={18, 16}, seed=4127, size=900}

--@ chunk 2

street = pile{{"bone black",2.5},{"ultramarine blue",1},{"burnt sienna",0.6},{"viridian",0.2},{"lead white",0.3}, medium=0.05, name="street"}
spA2 = pile{{"lead white",3},{"yellow ochre",0.75},{"pale cadmium",0.15},{"bone black",0.34},{"viridian",0.06}, medium=0.05, name="spA2"}
walkd = pile{{"bone black",2.2},{"yellow ochre",0.6},{"burnt sienna",0.5},{"ultramarine blue",0.35},{"lead white",0.45}, medium=0.05, name="walkd"}
spB = mix{{spA2,0.45},{walkd,0.55}}
stlit = mix{{spB,0.5},{street,0.5}, name="stlit"}
local zone = rect(100,100,400,300)
local lit = poly({{150,100},{320,100},{380,300},{150,300}})
local litb = lit:blur(10)
work(zone, {hand="body", tool="filbert 10", piles={{stlit, function(x,y) return litb:at(x,y)*0.6 end},{street, function(x,y) return 1-litb:at(x,y)*0.6+0.02 end}}, coverage=3, fill=true, clip=true, angle=1.2, length={20,60}})
blend(zone:shrink(2), {angle=-0.06})
print(wait(10*24*60))
print(drying(300,200))

--@ chunk 3

local lit = poly({{150,100},{320,100},{380,300},{150,300}})
local n = lose(lit * rect(300,120,120,150), {pile=street, where=1, tool="filbert 6", reach={10,14}, load=0.15, pressure={0.3,0.02}})
print(n)
