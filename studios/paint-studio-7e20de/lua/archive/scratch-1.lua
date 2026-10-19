-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box every
--@ engine 7
--@ width 4800

--@ chunk 1
canvas{aspect=1.5, ground={{apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.3}}, texture=0.25, um=110}, {apply="brush", pile={{"lead white", 3}, {"red earth", 1.2}, {"raw umber", 1.0}, {"yellow ochre", 0.6}}, um=22}}, linen={16, 14}, seed=4417, size=900}

--@ chunk 2
sky_top = pile{{"Prussian blue",1},{"bone black",1},{"raw umber",0.5},{"lead white",0.6}, turps=0.5, name="sky_top"}
sky_low = pile{{"Prussian blue",0.5},{"yellow ochre",1},{"lead white",2.5},{"bone black",0.2}, turps=0.5, name="sky_low"}
gnd = pile{{"raw umber",1},{"yellow ochre",1},{"green earth",1},{"bone black",0.3},{"lead white",0.6}, turps=0.5, name="gnd"}
fig = pile{{"bone black",1},{"raw umber",1},{"Prussian blue",0.3}, turps=0.5, name="fig"}
work(rect(20,20,220,180), {hand="broad", pile=sky_top, coverage=1.2})
work(rect(260,20,220,180), {hand="broad", pile=sky_low, coverage=1.2})
work(rect(500,20,220,180), {hand="broad", pile=gnd, coverage=1.2})
work(rect(740,20,220,180), {hand="body", pile=fig, coverage=1.2})

--@ chunk 3
sky_mid = pile{{"Prussian blue",0.8},{"bone black",0.4},{"yellow ochre",0.5},{"lead white",1.2}, turps=0.5, name="sky_mid"}
local m = rect(20,230,460,400)
work(m, {hand="broad", piles={{sky_top, function(x,y) return clamp(1-(y-230)/250,0,1) end},
  {sky_mid, function(x,y) return 1-math.abs((y-430)/200) end},
  {sky_low, function(x,y) return clamp((y-480)/150,0,1) end}}, coverage=3, fill=true, angle=0.05})
work(rect(520,230,460,400), {hand="broad", pile=gnd, coverage=3, fill=true, angle=0})
