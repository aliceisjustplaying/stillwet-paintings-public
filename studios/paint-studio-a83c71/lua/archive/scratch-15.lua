-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 1}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 8}, {"yellow ochre", 0.4}, {"raw umber", 0.12}}, um=45}}, linen={15, 13}, seed=1774, size=700}

--@ chunk 2
sky_lilac = pile{{"lead white", 6}, {"rose madder", 0.4}, {"smalt", 0.8}, {"Naples yellow", 0.2}, name="sky_lilac"}
belt = pile{{"lead white", 8}, {"rose madder", 0.7}, {"Naples yellow", 0.8}, {"vermilion", 0.1}, name="belt"}
eshadow = pile{{"lead white", 4}, {"smalt", 2}, {"cobalt blue", 0.3}, {"rose madder", 0.3}, {"raw umber", 0.2}, name="eshadow"}
glow = pile{{"lead white", 7}, {"Naples yellow", 0.8}, {"smalt", 0.7}, {"rose madder", 0.2}, name="glow"}
moon = pile{{"lead white", 6}, {"Naples yellow", 1.2}, {"vermilion", 0.03}, name="moon"}
local function hat(c, w) return function(x, y) return math.max(0, 1 - math.abs(y - c) / w) end end
local piles = {{sky_lilac, hat(218, 40)}, {belt, hat(258, 45)}, {eshadow, function(x, y) return clamp((y - 258) / 47, 0, 1) end}, {glow, function(x, y) local dx, dy = (x - 300) / 85, (y - 298) / 55; return 0.7 * math.exp(-(dx*dx + dy*dy)) end}}
work(rect(0, 150, 1000, 300), {hand="broad", piles=piles, angle=0, coverage=3.5, load=1, fill=true, clip=true, tool={kind="filbert", width=22, lay=1.6}})
blend(rect(0, 150, 1000, 300), {angle=0, tool={kind="badger", width=60}})
wait(14*24*60)
local m = ellipse(300, 298, 12.5, 12.5)
work(m, {hand="detail", pile=moon, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=20}, tool={kind="round", width=3.5}})
local m2 = ellipse(700, 298, 12.5, 12.5)
work(m2, {hand="detail", pile=moon, coverage=3, fill=true, edge={found=0.6, soft=0.4, period=20}, tool={kind="round", width=3.5}})
wait(10*24*60)
print(drying(300, 298))

--@ chunk 3
halo = pile{{"lead white", 8}, {"Naples yellow", 0.9}, {"smalt", 0.35}, {"rose madder", 0.12}, name="halo"}
-- A: opaque radial graded repaint, fading out by r=70
local function rad(cx, cy) return function(x, y) local dx, dy = x - cx, (y - cy) * 1.15; return math.sqrt(dx*dx + dy*dy) end end
local rA = rad(300, 298)
local mA = mask(function(x, y) local r = rA(x, y); return (r > 13.5) and clamp(1 - (r - 30) / 45, 0, 1) or 0 end)
local function hat(c, w) return function(x, y) return math.max(0, 1 - math.abs(y - c) / w) end end
work(mA, {hand="body", piles={{halo, function(x, y) return clamp(1 - (rA(x, y) - 14) / 40, 0, 1) end}, {belt, function(x, y) return clamp((rA(x, y) - 20) / 50, 0, 1) * hat(258, 45)(x, y) end}, {eshadow, function(x, y) return clamp((rA(x, y) - 20) / 50, 0, 1) * clamp((y - 258) / 47, 0, 1) end}, {glow, function(x, y) return 0.4 end}}, coverage=3, fill=true, clip=mA, angle=0, tool={kind="filbert", width=10}, load_at=function(x, y) return clamp(1 - (rA(x, y) - 14) / 60, 0.1, 1) end})
blend(mA, {angle=0, tool={kind="badger", width=30}})
-- B: thinner veil of halo by stipple, feathered
local rB = rad(700, 298)
local halo_t = pile{{"lead white", 8}, {"Naples yellow", 0.9}, {"smalt", 0.35}, {"rose madder", 0.12}, thinner=0.4, name="halo_t"}
local mB = mask(function(x, y) local r = rB(x, y); return (r > 13.5) and clamp(1 - (r - 14) / 50, 0, 1) or 0 end)
stipple(mB, {pile=halo_t, width=6, coverage=function(x, y) return 3 * clamp(1 - (rB(x, y) - 14) / 50, 0, 1) end, feather=0.6, clip=mB})
blend(mB, {angle=0, tool={kind="badger", width=30}})
print("ok")

--@ chunk 4
wait(14*24*60)
moon_w = pile{{"lead white", 6}, {"Naples yellow", 1.6}, {"vermilion", 0.12}, {"yellow ochre", 0.15}, name="moon_w"}
local m = ellipse(300, 298, 11.5, 11.5)
work(m, {hand="detail", pile=moon_w, coverage=2.5, fill=true, clip=m:soften(1), tool={kind="round", width=3}})
-- rim lighter, center slightly warmer: subtle limb
local m2 = ellipse(700, 298, 12.5, 12.5)
local mw = pile{{"lead white", 6}, {"Naples yellow", 1.4}, {"vermilion", 0.08}, {"yellow ochre", 0.1}, medium=0.5, name="mw"}
work(m2:shrink(1), {hand="detail", pile=mw, coverage=2, fill=true, clip=m2:shrink(1):soften(1), tool={kind="round", width=3}})
print("ok")
