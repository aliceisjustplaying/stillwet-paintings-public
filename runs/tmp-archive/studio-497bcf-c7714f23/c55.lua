tD = pile{{"green earth", 2.5}, {"raw umber", 1.2}, {"Prussian blue", 0.25}, {"lead white", 1.6}, {"pale smalt", 1.0}, medium=0.1}
tM = pile{{"green earth", 2.5}, {"yellow ochre", 0.8}, {"raw umber", 0.6}, {"lead white", 2.2}, {"pale smalt", 0.9}, {"Prussian blue", 0.08}, medium=0.1}
tL = pile{{"lead white", 3}, {"green earth", 1.6}, {"yellow ochre", 1.0}, {"pale smalt", 0.5}, {"raw umber", 0.15}, medium=0.1}
local function lobes(list, seed)
  local m
  for i, l in ipairs(list) do
    local e = ellipse(l[1], l[2], l[3], l[4])
    m = m and (m + e) or e
  end
  return m:roughen(3.2, 9, seed)
end
crownA = lobes({{52,430,40,34},{30,440,22,20},{70,410,26,24},{45,400,22,18},{85,440,20,20},{22,455,16,12},{60,455,34,14}}, 61)
crownB = lobes({{112,410,34,38},{100,385,22,20},{125,378,16,16},{135,420,24,26},{95,440,28,22},{140,450,20,14},{115,455,30,12}}, 62)
crownC = lobes({{165,440,26,24},{175,425,16,15},{152,430,14,14},{183,450,14,12},{160,462,22,9}}, 63)
local holes = ellipse(24,423,4,3) + ellipse(88,402,3.5,3) + ellipse(145,398,3,4) + ellipse(62,392,3,2.5) + ellipse(178,436,3,2.5) + ellipse(122,432,3,2.5)
crowns = (crownA + crownB + crownC) * above({{0,478},{1000,478}}) - holes
stipple(crowns, {pile=tD, width=3.2, coverage=4.5, pressure={0.45,0.75}, clip=crowns, cluster=0.2})
print(wait(0))
