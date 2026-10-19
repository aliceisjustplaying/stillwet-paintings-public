-- easel session "painting": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.

--@ chunk 1
canvas{size=560, aspect=1.4, linen={18,15}, seed=7, ground={{pile={{"lead white",4},{"yellow ochre",0.3}}, um=110, apply="knife", texture=0.3},{pile={{"lead white",1},{"red earth",0.5},{"raw umber",0.5},{"yellow ochre",0.5}}, um=20, apply="brush"}}}
print(W,H)

--@ chunk 2
draw = pile{{"raw umber",2},{"bone black",0.3}, medium=0.55}
rb = brush{kind="round", width=3, point=0.7}
rb:load(draw, 0.6)
-- horizon line of far land
rb:stroke({{0,442},{200,440},{420,443},{620,441},{800,444},{1000,440}}, {pressure={0.4,0.3}})
rb:load(draw, 0.6)
-- left tree group silhouette
rb:stroke({{40,442},{55,380},{90,330},{130,300},{170,285},{220,270},{260,290},{300,300},{340,330},{380,370},{410,420},{420,442}}, {pressure={0.5,0.3}})
rb:load(draw, 0.6)
-- right, lower copse
rb:stroke({{760,442},{780,410},{820,395},{860,392},{900,405},{930,425},{950,442}}, {pressure={0.5,0.3}})
rb:load(draw, 0.6)
-- creek banks: from horizon ~ (600..660) to bottom (330..700)
rb:stroke({{605,445},{570,470},{520,500},{500,530},{540,570},{560,610},{480,660},{380,714}}, {pressure={0.4,0.5}})
rb:load(draw, 0.6)
rb:stroke({{660,445},{650,470},{610,500},{600,530},{650,570},{700,620},{680,670},{700,714}}, {pressure={0.4,0.5}})

--@ chunk 3
hz = function(x) return 441 + 2*math.sin(x/130) end
sky = above(hz)
s1 = pile{{"lead white",3},{"smalt",1},{"cobalt blue",0.6},{"raw umber",0.25}, medium=0.1}
s2 = pile{{"lead white",4},{"cobalt blue",0.5},{"smalt",0.4},{"red earth",0.08}, medium=0.1}
s3 = pile{{"lead white",5},{"vermilion",0.12},{"yellow ochre",0.25},{"cobalt blue",0.12}, medium=0.1}
s4 = pile{{"lead white",6},{"chrome yellow",0.6},{"vermilion",0.12}, medium=0.1}
local bands = {{s1,0,150},{s2,120,270},{s3,240,370},{s4,340,450}}
for i,b in ipairs(bands) do
  local m = rect(0,b[2],1000,b[3]-b[2]) * sky
  work(m, {hand="broad", pile=b[1], angle=function(x,y) return 0.05*math.sin(x/200+y/90) end, coverage=2.5, fill=true, tool="filbert 18"})
end

