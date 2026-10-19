-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}, name="rock"}
fallgray = pile{{"lead white",3},{"cobalt blue",0.3},{"raw umber",0.4},{"yellow ochre",0.15}, name="fallgray"}
fallwhite = pile{{"lead white",8},{"yellow ochre",0.25},{"cobalt blue",0.08}, name="fallwhite"}
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}, name="glow"}
work(rect(0,0,1000,500), {hand="body", coverage=3, fill=true, length={20,50}, angle=1.45, pile=rock})
work(rect(100,50,800,400), {hand="body", pile=fallgray, tool={kind="flat", width=12}, coverage=2.5, fill=true, angle=math.pi/2, length={60,120}, clip=true})
blend(rect(90,40,820,420):soften(6), {angle=math.pi/2})
wait(20*60)
print(drying(300, 200))

--@ chunk 3
wait(8*60)
print(drying(300, 200))
