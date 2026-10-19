brD = pile{{"raw umber", 2}, {"bone black", 0.3}, {"lead white", 1.2}, {"pale smalt", 1.0}, medium=0.1}
-- limbs seen through the gaps
local rb = brush{kind="round", width=2.2, point=0.8}
rb:load(brD, 0.6)
rb:stroke({{96,470},{95,440},{90,418},{86,398},{80,382}}, {pressure={0.7,0.25}, ramps={0.05,0.3}})
rb:stroke({{90,418},{96,402},{100,388}}, {pressure={0.45,0.15}, ramps={0.05,0.4}})
rb:stroke({{150,470},{148,440},{147,422},{150,408},{154,398}}, {pressure={0.6,0.2}, ramps={0.05,0.4}})
rb:load(brD, 0.5)
rb:stroke({{36,470},{38,440},{30,418},{26,404}}, {pressure={0.55,0.15}, ramps={0.05,0.4}})
rb:stroke({{40,436},{47,420},{44,408}}, {pressure={0.4,0.1}, ramps={0.05,0.5}})
rb:stroke({{120,425},{120,410},{117,398}}, {pressure={0.4,0.1}, ramps={0.05,0.5}})
rb:stroke({{65,450},{66,442},{67,438}}, {pressure={0.4,0.2}})
-- leaf sprays dragged in from the rims of every gap and the outer edge
local cr = (crownA + crownB + crownC) * above({{0,478},{1000,478}})
local rim = cr:rim(5, 2) + cr:grow(3) - cr
stipple(rim * above({{0,462},{1000,462}}), {pile=tD, width=1.6, coverage=1.3, pressure={0.35,0.65}, drag={2.5, -1.2}, twist=0.8, cluster={0.6, 6}, feather=0.6})
print(wait(0))
