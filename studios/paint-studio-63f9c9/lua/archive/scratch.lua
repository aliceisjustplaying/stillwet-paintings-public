-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7
--@ limbs-join-nearest

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"lead white", 3}, {"red earth", 2}, {"yellow ochre", 2}}, texture=0.4, um=70}, {apply="knife", pile={{"lead white", 8}, {"yellow ochre", 0.6}, {"raw umber", 0.25}}, texture=0.25, um=40}, {apply="brush", pile={{"lead white", 10}, {"yellow ochre", 0.3}, {"raw umber", 0.1}}, um=25}}, linen={18, 16}, seed=1822, size=700}

--@ chunk 2
s_top = pile{{"lead white", 3}, {"smalt", 3}, {"bone black", 0.15}, {"rose madder", 0.2}, name="s_top"}
s_blue = pile{{"lead white", 5}, {"smalt", 2.5}, {"cobalt blue", 0.3}, name="s_blue"}
s_green = pile{{"lead white", 8}, {"pale smalt", 1.2}, {"Naples yellow", 1.0}, name="s_green"}
s_yel = pile{{"lead white", 8}, {"Naples yellow", 2.5}, {"chrome yellow", 0.15}, name="s_yel"}
s_glow = pile{{"lead white", 6}, {"Naples yellow", 2.5}, {"vermilion", 0.35}, {"rose madder", 0.25}, name="s_glow"}
s_deep = pile{{"lead white", 2}, {"smalt", 3}, {"Prussian blue", 0.1}, {"bone black", 0.2}, {"rose madder", 0.2}, name="s_deep"}
print(palette())

--@ chunk 3
s_deep = pile{{"lead white", 1.2}, {"smalt", 4}, {"Prussian blue", 0.15}, {"bone black", 0.1}, {"rose madder", 0.12}, name="s_deep"}
s_green:add{{"pale smalt", 0.6}, {"Prussian blue", 0.02}}
s_top:add{{"smalt", 1}, {"Prussian blue", 0.05}}
print(palette())

--@ chunk 4
local function bump(c, w) return function(x, y) local d = (y - c) / w; return math.max(0, 1 - d*d) end end
local skyw = {
  {s_deep, function(x,y) return math.max(0, 1 - y/140) end},
  {s_top, bump(140, 110)},
  {s_blue, bump(250, 110)},
  {s_green, bump(350, 90)},
  {s_yel, bump(425, 70)},
  {s_glow, function(x,y) return clamp((y - 430)/60, 0, 1) end},
}
local m = rect(40, 0, 300, 520)
work(m, {hand="broad", piles=skyw, angle=0, coverage=2.5, fill=true, clip=true, angle_jitter=0.05})
print(drying(150, 300))

--@ chunk 5
blend(rect(40, 0, 300, 520), {angle=0})

--@ chunk 6
u_blue = pile{{"smalt", 3}, {"lead white", 1}, {"Prussian blue", 0.1}, turps=0.6, name="u_blue"}
u_warm = pile{{"lead white", 3}, {"Naples yellow", 2}, {"vermilion", 0.2}, turps=0.6, name="u_warm"}
local m = rect(380, 0, 300, 520)
work(m, {hand="broad", piles={{u_blue, function(x,y) return clamp(1 - y/330, 0, 1) end}, {u_warm, function(x,y) return clamp((y-200)/250, 0, 1) end}}, angle=0, coverage=1.5, fill=true, clip=true})
wait(24*60)
print(drying(500, 100), drying(500, 450))

--@ chunk 7
wait(12*60)
print(drying(500, 100), drying(500, 450))
s_deep2 = pile{{"lead white", 1.0}, {"smalt", 4}, {"Prussian blue", 0.2}, {"bone black", 0.12}, medium=0.1, name="s_deep2"}
s_top2 = pile{{"lead white", 2.2}, {"smalt", 4}, {"Prussian blue", 0.1}, {"bone black", 0.06}, {"rose madder", 0.04}, medium=0.1, name="s_top2"}
print(palette())
