-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ box friedrich
--@ engine 7

--@ chunk 1
canvas{aspect=1.4, ground={{apply="knife", pile={{"red earth", 2}, {"yellow ochre", 2}, {"lead white", 1}}, texture=0.3, um=60}, {apply="brush", pile={{"lead white", 6}, {"yellow ochre", 0.35}, {"raw umber", 0.12}}, um=35}}, linen={16, 14}, seed=1774, size=650}

--@ chunk 2
s_glow = pile{{"lead white",5},{"Naples yellow",1.5},{"yellow ochre",0.25},{"vermilion",0.05}, name="s_glow"}
s_grn  = pile{{"lead white",5},{"Naples yellow",1},{"cobalt blue",0.6}, name="s_grn"}
s_mid  = pile{{"lead white",3},{"cobalt blue",0.6},{"smalt",0.6},{"Naples yellow",0.2}, name="s_mid"}
local m = rect(0,0,1000,714)
work(m, {hand="broad", piles={{s_mid, function(x,y) return math.max(0.02, 1-y/250) end},{s_grn, function(x,y) return math.max(0.02, 1-math.abs(y-330)/200) end},{s_glow, function(x,y) return math.max(0.02, (y-300)/300) end}}, coverage=2.6, fill=true, seed=11})
for i=1,2 do blend(m, {angle=0.02*i, seed=12+i}) end
print(wait(4*24*60))
sk300 = mix{{s_grn,0.65},{s_mid,0.35}, name="sk300"}
sk340 = mix{{s_grn,0.72},{s_glow,0.22},{s_mid,0.06}, name="sk340"}
-- raised patches like the painting's: detail filbert 3 coverage 3 fill
for i, c in ipairs({{150,330},{400,330},{650,330},{150,520},{400,520},{650,520}}) do
  local p = ellipse(c[1], c[2], 45, 35) + rect(c[1]+20, c[2]-10, 60, 30)
  work(p, {hand="detail", tool={kind="filbert", width=3}, piles={{sk300,0.5},{sk340,0.5}}, angle=0, coverage=3, fill=true, clip=p, seed=20+i})
end
print(wait(6*24*60))
print(drying(150,330))
