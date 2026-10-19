-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
sky_top = pile{{"smalt", 3}, {"lead white", 2}, {"bone black", 0.25}, {"rose madder", 0.15}, name="sky_top"}
sky_mid = pile{{"smalt", 2}, {"lead white", 4}, {"rose madder", 0.1}, name="sky_mid"}
rose = pile{{"lead white", 8}, {"rose madder", 0.5}, {"Naples yellow", 0.8}, {"vermilion", 0.05}, name="rose"}
eshadow = pile{{"lead white", 6}, {"smalt", 1.5}, {"rose madder", 0.25}, {"raw umber", 0.15}, name="eshadow"}
moon = pile{{"lead white", 6}, {"Naples yellow", 1.5}, name="moon"}
ridge1 = pile{{"lead white", 4}, {"smalt", 2}, {"rose madder", 0.3}, {"raw umber", 0.3}, name="ridge1"}
fg = pile{{"raw umber", 3}, {"Prussian blue", 0.4}, {"bone black", 0.5}, {"yellow ochre", 0.5}, name="fg"}

--@ chunk 3
sky_top2 = pile{{"smalt", 4}, {"lead white", 1}, {"Prussian blue", 0.15}, {"bone black", 0.1}, name="sky_top2"}
sky_top3 = pile{{"smalt", 3}, {"cobalt blue", 1}, {"lead white", 1.5}, {"bone black", 0.1}, {"rose madder", 0.1}, name="sky_top3"}
local ps = {sky_top, sky_top2, sky_top3, sky_mid, rose, eshadow, moon, ridge1, fg}
for i, p in ipairs(ps) do
  local x = 30 + (i-1) * 105
  work(rect(x, 40, 90, 200), {hand="body", pile=p, coverage=2, clip=true, angle=0})
  work(rect(x, 260, 90, 120), {hand="body", pile=pile{{"lead white",1}}, coverage=0, clip=true})
end
print("done")
