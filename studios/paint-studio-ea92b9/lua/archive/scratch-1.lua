-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
s_top  = pile{{"lead white",2},{"cobalt blue",1.2},{"smalt",1.5},{"raw umber",0.08}, name="s_top"}
s_mid  = pile{{"lead white",4},{"cobalt blue",0.6},{"smalt",0.6}, name="s_mid"}
s_grn  = pile{{"lead white",5},{"Naples yellow",1},{"cobalt blue",0.25}, name="s_grn"}
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.2},{"vermilion",0.05}, name="s_glow"}
s_low  = pile{{"lead white",4},{"Naples yellow",1.2},{"vermilion",0.15},{"rose madder",0.1}, name="s_low"}
print(s_top, s_mid, s_grn, s_glow, s_low)

--@ chunk 3
s_top = pile{{"lead white",1},{"cobalt blue",1},{"smalt",2},{"raw umber",0.06}, name="s_top2"}
s_grn:add{{"cobalt blue",0.35}}
-- Option A: bands, left half
local bands = {{s_top,0,110},{s_mid,90,220},{s_grn,200,320},{s_glow,300,400},{s_low,385,470}}
for i,bd in ipairs(bands) do
  work(rect(20, bd[2], 460, bd[3]-bd[2]), {hand="broad", pile=bd[1], angle=0, coverage=1.6, clip=rect(20,0,460,470), seed=10+i})
end
blend(rect(20,0,460,470), {angle=0})
-- Option B: graded piles, right half
local function wgt(c) return function(x,y) return math.max(0, 1 - math.abs(y-c)/110) end end
work(rect(520,0,460,470), {hand="broad", piles={{s_top,wgt(40)},{s_mid,wgt(150)},{s_grn,wgt(260)},{s_glow,wgt(350)},{s_low,wgt(440)}}, angle=0, coverage=1.8, clip=rect(520,0,460,470), seed=20})
blend(rect(520,0,460,470), {angle=0})
