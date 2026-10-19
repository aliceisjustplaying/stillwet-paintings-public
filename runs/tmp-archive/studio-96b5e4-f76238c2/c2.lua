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
