-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
sky_deep = pile{{"smalt", 3}, {"cobalt blue", 1}, {"lead white", 1.2}, {"bone black", 0.15}, {"rose madder", 0.12}, name="sky_deep"}
sky_mid = pile{{"smalt", 2}, {"cobalt blue", 0.5}, {"lead white", 3}, {"rose madder", 0.15}, name="sky_mid"}
sky_lilac = pile{{"lead white", 6}, {"rose madder", 0.4}, {"smalt", 0.8}, {"Naples yellow", 0.2}, name="sky_lilac"}
belt = pile{{"lead white", 8}, {"rose madder", 0.7}, {"Naples yellow", 0.8}, {"vermilion", 0.1}, name="belt"}
eshadow = pile{{"lead white", 4}, {"smalt", 2}, {"cobalt blue", 0.3}, {"rose madder", 0.3}, {"raw umber", 0.2}, name="eshadow"}
local function wt(c, w) return function(x, y) local d = (y - c) / w; return math.exp(-d*d) end end
local piles = {{sky_deep, wt(0, 110)}, {sky_mid, wt(130, 60)}, {sky_lilac, wt(205, 35)}, {belt, wt(250, 30)}, {eshadow, wt(330, 45)}}
work(rect(0, 0, 400, 380), {hand="broad", piles=piles, angle=0, coverage=2.5, fill=true, clip=true, angle_jitter=0.05})
print("laid")

--@ chunk 3
blend(rect(0, 0, 200, 380), {angle=0})
print(drying(100,100))

--@ chunk 4
blend(rect(0, 0, 200, 380), {angle=0})
blend(rect(200, 0, 200, 380), {angle=0, tool={kind="badger", width=60}})

--@ chunk 5
local function wt(c, w) return function(x, y) local d = (y - c) / w; return math.exp(-d*d) end end
local piles = {{sky_deep, wt(0, 110)}, {sky_mid, wt(130, 60)}, {sky_lilac, wt(205, 35)}, {belt, wt(250, 30)}, {eshadow, wt(330, 45)}}
work(rect(500, 0, 400, 380), {hand="broad", piles=piles, angle=0, coverage=3.5, load=1.0, fill=true, clip=true, angle_jitter=0.04, tool={kind="filbert", width=22, lay=1.6}})
blend(rect(500, 0, 400, 380), {angle=0, tool={kind="badger", width=60}})
print("ok")

--@ chunk 6
ridgeA = pile{{"lead white", 4}, {"smalt", 2}, {"cobalt blue", 0.3}, {"rose madder", 0.35}, {"raw umber", 0.35}, name="ridgeA"}
local top = {}
for x = 500, 700, 10 do top[#top+1] = {x, 330 - 25*math.sin((x-500)/60) - 8*math.sin(x/17)} end
local pts = {}
for _, p in ipairs(top) do pts[#pts+1] = p end
pts[#pts+1] = {700, 380}; pts[#pts+1] = {500, 380}
local m = poly(pts)
work(m, {hand="body", pile=ridgeA, angle=0, coverage=3, fill=true, clip=true})
print(drying(600, 350))

--@ chunk 7
print(wait(2*24*60))
print(drying(800, 200), drying(800, 350))
local top = {}
for x = 700, 900, 10 do top[#top+1] = {x, 320 - 20*math.sin((x-700)/50) - 6*math.sin(x/13)} end
local pts = {}
for _, p in ipairs(top) do pts[#pts+1] = p end
pts[#pts+1] = {900, 380}; pts[#pts+1] = {700, 380}
work(poly(pts), {hand="body", pile=ridgeA, angle=0, coverage=3, fill=true, clip=true})

--@ chunk 8
for i=1,6 do print(wait(24*60), drying(800,100), drying(800, 250), drying(800,330), drying(600,360)) end
