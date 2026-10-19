-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=800, aspect=1.25, linen={15,13}, seed=7, ground={{pile={{"lead white",7},{"raw umber",1},{"yellow ochre",0.6}}, um=90, apply="knife", texture=0.35},{pile={{"lead white",10},{"raw umber",0.7}}, um=40, apply="brush"}}}

--@ chunk 2

p_wallD = pile{{"raw umber",6},{"bone black",4},{"Prussian blue",1.5}}
p_wallL = pile{{"raw umber",4},{"red earth",1.5},{"yellow ochre",1.2},{"lead white",1}}
p_table = pile{{"raw umber",5},{"red earth",2.5},{"yellow ochre",1.2},{"bone black",1.5}}
tableline = function(x) return 450 + 4*math.sin(x/150 + 1) + 2*math.sin(x/47) end
m_table = below(tableline)
m_wall  = -m_table
pool = mask(function(x, y) local dx=(x-170)/640; local dy=(y-70)/520; local d=math.sqrt(dx*dx+dy*dy); return clamp(1.2 - d, 0, 1) end)
print(m_table:area(), m_wall:area(), pool:area())

--@ chunk 3
print(work(m_wall, {hand="broad", pile=p_wallD, angle=0, coverage=2.2, length={110,240}, tool="filbert 22", edge="lost", seed=5}))

