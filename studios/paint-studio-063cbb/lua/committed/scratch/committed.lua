-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.33333333, ground={{apply="brush", pile={{"lead white", 10}, {"raw umber", 1.8}, {"yellow ochre", 0.8}}, texture=0.15, um=45}}, linen={18, 14}, seed=1885, size=800}

--@ chunk 2
-- Scratch canvas test: mixes for background night sky, deep shadows, and blast warmth
p_night = pile{{"bone black", 4}, {"raw umber", 3}, {"ultramarine blue", 3}, turps=0.5}
p_ground = pile{{"raw umber", 5}, {"burnt sienna", 2}, {"bone black", 2}, turps=0.5}
p_flash_wash = pile{{"deep cadmium", 3}, {"Mars orange", 2}, {"lead white", 1}, turps=0.4}

-- Test lay-in across zones on scratch canvas
m_sky = rect(0, 0, 1000, 350)
m_ground = rect(0, 350, 1000, 400)
m_flash = ellipse(500, 400, 120, 100)

work(m_sky, {hand="broad", pile=p_night, coverage=1.2, angle=-0.1})
work(m_ground, {hand="broad", pile=p_ground, coverage=1.1, angle=0.05})
work(m_flash, {hand="body", pile=p_flash_wash, coverage=1.0, angle=0.3})

print("Scratch test completed. Drying states:")
print("Sky: " .. drying(200, 150))
print("Flash: " .. drying(500, 400))

--@ chunk 3
-- Scratch test: Zombie flesh, Cowboy duster, and Blast radiant core
p_flesh_dead = pile{{"green earth", 3.0}, {"raw umber", 2.0}, {"yellow ochre", 2.0}, {"lead white", 1.5}, turps=0.3}
p_cowboy_coat = pile{{"raw umber", 4.0}, {"bone black", 3.0}, {"burnt sienna", 2.0}, turps=0.3}
p_blast_radiant = pile{{"cadmium yellow", 4.0}, {"deep cadmium", 3.0}, {"orange vermilion", 2.0}, {"lead white", 1.5}}

-- Test patches on scratch canvas
m_patch1 = rect(150, 100, 120, 150)
m_patch2 = rect(300, 100, 120, 150)
m_patch3 = rect(450, 100, 120, 150)

work(m_patch1, {hand="body", pile=p_cowboy_coat, coverage=1.2, angle=0.2})
work(m_patch2, {hand="body", pile=p_flesh_dead, coverage=1.2, angle=-0.2})
work(m_patch3, {hand="body", pile=p_blast_radiant, coverage=1.3, angle=0.0})

print("Scratch test patches laid.")

--@ chunk 4
-- Scratch test: Gunsmoke, Blast rim light, Cool moonlight rim, and Blast gore
p_smoke = pile{{"lead white", 4.0}, {"raw umber", 2.0}, {"cobalt blue", 1.5}, {"Mars orange", 1.0}, turps=0.4}
p_blast_rim = pile{{"lead white", 3.0}, {"cadmium yellow", 4.0}, {"deep cadmium", 2.0}}
p_cool_rim = pile{{"lead white", 3.5}, {"cobalt blue", 2.0}, {"ultramarine blue", 1.0}}
p_gore_blast = pile{{"cadmium red", 3.0}, {"burnt sienna", 3.0}, {"bone black", 2.0}, {"raw umber", 1.0}}

-- Lay patches on scratch canvas over existing darks
m_test1 = rect(150, 300, 150, 100)
m_test2 = rect(350, 300, 150, 100)
m_test3 = rect(550, 300, 150, 100)

work(m_test1, {hand="body", pile=p_smoke, coverage=0.9, angle=0.3, edge="soft"})
work(m_test2, {hand="body", pile=p_blast_rim, coverage=1.2, angle=0.0})
work(m_test3, {hand="body", pile=p_cool_rim, coverage=1.2, angle=1.0})

print("Scratch test 3 completed.")
