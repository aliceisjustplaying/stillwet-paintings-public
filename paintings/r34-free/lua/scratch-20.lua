-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 5

--@ chunk 1
canvas{aspect=1.3333333333333333, ground={{apply="knife", pile={{"lead white", 3}, {"yellow ochre", 1}, {"raw umber", 0.4}}, texture=0.1, um=40}}, linen={24, 22}, seed=5, size=600}

--@ chunk 2
wait(60)
skyBlueC = pile{{"cerulean blue", 0.9}, {"permanent alizarin", 0.2}, {"lead white", 1.3}, name="skyBlueC"}
roseT = pile{{"rose madder", 0.8}, {"permanent alizarin", 0.3}, {"lead white", 1.0}, name="roseT"}
roseP = ellipse(800, 66, 60, 16)
work(roseP, {hand="body", pile=roseT, coverage=1.8, fill=true, clip=true, edge="soft", load=1.0})
wait(4320)
print("scratch rose cloud set", drying(800,66), drying(760,60))

--@ chunk 3
wait(2880)
print("scratch rose cloud", drying(800,66), drying(760,60))

--@ chunk 4
wait(2880)
print("scratch rose cloud", drying(800,66), drying(760,60))

--@ chunk 5
skyBlueC = pile{{"cerulean blue", 0.9}, {"permanent alizarin", 0.2}, {"lead white", 1.3}, name="skyBlueC"}
coverT = ellipse(800, 66, 60, 16)
work(coverT, {hand="broad", pile=skyBlueC, coverage=1.6, fill=true, clip=true, edge="lost", load=1.0})
print("scratch sky-blue cover on tacky rose", drying(800,66))
