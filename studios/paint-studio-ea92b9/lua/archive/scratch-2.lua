-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
s_zen  = pile{{"lead white",0.9},{"smalt",2},{"cobalt blue",1},{"Prussian blue",0.06},{"raw umber",0.1}, name="s_zen"}
s_top  = pile{{"lead white",2},{"cobalt blue",1.2},{"smalt",1.5},{"raw umber",0.08}, name="s_top"}
s_mid  = pile{{"lead white",4},{"cobalt blue",0.6},{"smalt",0.6}, name="s_mid"}
s_grn  = pile{{"lead white",5},{"Naples yellow",1},{"cobalt blue",0.6}, name="s_grn"}
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.2},{"vermilion",0.05}, name="s_glow"}
s_low  = pile{{"lead white",4},{"Naples yellow",1.2},{"vermilion",0.15},{"rose madder",0.1}, name="s_low"}
local function wgt(c, r) return function(x,y) return math.max(0, 1 - math.abs(y-c)/r) end end
local sky = rect(20,0,460,470)
work(sky, {hand="broad", piles={{s_zen,wgt(0,90)},{s_top,wgt(90,100)},{s_mid,wgt(190,100)},{s_grn,wgt(290,100)},{s_glow,wgt(380,90)},{s_low,wgt(470,90)}}, angle=0, coverage=2.6, fill=true, clip=sky, seed=31})
blend(sky, {angle=0})
blend(sky, {angle=0.05})

--@ chunk 3
print(drying(200,30), drying(200,250), drying(200,450))
print(wait(2*24*60))
print(drying(200,30), drying(200,250), drying(200,450))

--@ chunk 4
print(wait(24*60))
print(drying(200,30), drying(200,100))
g_smalt = pile{{"smalt",2},{"cobalt blue",0.3},{"rose madder",0.1}, medium=0.75, name="g_smalt"}
-- graded glaze: heavier at top, fading by y~260. Use load_at to fade.
local m = rect(20,0,230,300)
work(m, {hand="glaze", pile=g_smalt, angle=0, coverage=1.2, clip=rect(20,0,230,470), load_at=function(x,y) return clamp(1 - y/260, 0, 1) end, seed=41})

--@ chunk 5
blend(rect(20,0,230,320), {angle=0})
blend(rect(20,0,230,320), {angle=0.03})
