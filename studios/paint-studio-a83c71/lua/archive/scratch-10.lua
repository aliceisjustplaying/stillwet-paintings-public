-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
sky_deep = pile{{"smalt", 3}, {"cobalt blue", 1}, {"lead white", 0.8}, {"bone black", 0.25}, {"rose madder", 0.15}, name="sky_deep"}
sky_blue = pile{{"smalt", 2.5}, {"cobalt blue", 0.7}, {"lead white", 2.5}, {"rose madder", 0.12}, name="sky_blue"}
sky_mid = pile{{"smalt", 1.5}, {"cobalt blue", 0.3}, {"lead white", 4}, {"rose madder", 0.2}, name="sky_mid"}
local function hat(c, w) return function(x, y) return math.max(0, 1 - math.abs(y - c) / w) end end
work(rect(0, 0, 1000, 300), {hand="broad", piles={{sky_deep, function(x,y) return clamp(1 - y/95, 0, 1) end}, {sky_blue, hat(95, 80)}, {sky_mid, function(x,y) return clamp((y - 95)/75, 0, 1) end}}, angle=0, coverage=3.5, load=1, fill=true, clip=true, tool={kind="filbert", width=22, lay=1.6}})
blend(rect(0, 0, 1000, 300), {angle=0, tool={kind="badger", width=60}})
wait(16*24*60)
print(drying(500, 50), drying(500, 250))

--@ chunk 3
gA = pile{{"smalt", 1}, {"cobalt blue", 0.3}, {"rose madder", 0.06}, medium=0.8, name="gA"}
gB = pile{{"smalt", 1}, {"cobalt blue", 0.3}, {"bone black", 0.06}, {"rose madder", 0.06}, medium=0.75, name="gB"}
gC = pile{{"smalt", 3}, {"cobalt blue", 1}, {"lead white", 0.5}, {"bone black", 0.3}, {"rose madder", 0.15}, thinner=0.5, name="gC"}
local function g(y) return clamp(1 - y / 230, 0, 1) end
work(rect(0, 0, 330, 300), {hand="glaze", pile=gA, coverage=2, clip=rect(0,0,330,300), angle=0, load_at=function(x, y) return 0.15 + 0.85 * g(y) end})
work(rect(335, 0, 330, 300), {hand="glaze", pile=gB, coverage=2, clip=rect(335,0,330,300), angle=0, load_at=function(x, y) return 0.15 + 0.85 * g(y) end})
work(rect(670, 0, 330, 300), {hand="broad", pile=gC, coverage=2.5, clip=rect(670,0,330,300), angle=0, load_at=function(x, y) return 0.1 + 0.9 * g(y) end})
print("ok")

--@ chunk 4
blend(rect(0, 0, 330, 300), {angle=0, tool={kind="badger", width=60}})
blend(rect(0, 0, 330, 300), {angle=0.05, tool={kind="badger", width=60}})
blend(rect(335, 0, 330, 300), {angle=0, tool={kind="badger", width=60}})
blend(rect(670, 0, 330, 300), {angle=0, tool={kind="badger", width=60}})
print(drying(100, 50))

--@ chunk 5
wait(16*24*60)
sky_night = pile{{"smalt", 3}, {"cobalt blue", 1.2}, {"lead white", 0.5}, {"bone black", 0.4}, {"rose madder", 0.2}, name="sky_night"}
local function hat(c, w) return function(x, y) return math.max(0, 1 - math.abs(y - c) / w) end end
local m = rect(0, 0, 1000, 300) * mask(function(x, y) return clamp((260 - y) / 60, 0, 1) end)
work(m, {hand="broad", piles={{sky_night, function(x,y) return clamp(1 - y/80, 0, 1) end}, {sky_deep, hat(80, 70)}, {sky_blue, hat(150, 70)}, {sky_mid, function(x,y) return clamp((y - 150)/70, 0, 1) end}}, angle=0, coverage=3.5, load=1, fill=true, clip=m, tool={kind="filbert", width=22, lay=1.6}, load_at=function(x, y) return clamp((250 - y) / 80, 0.1, 1) end})
blend(rect(0, 0, 1000, 280), {angle=0, tool={kind="badger", width=60}})
print("ok")
