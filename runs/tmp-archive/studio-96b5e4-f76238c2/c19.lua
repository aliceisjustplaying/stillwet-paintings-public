local function ells(list)
  local m=nil
  for _,e in ipairs(list) do local el=ellipse(e[1],e[2],e[3],e[4]); m = m and (m+el) or el end
  return m
end
crownA = ells({{185,285,30,24},{160,305,34,27},{212,308,36,30},{175,335,50,35},{218,345,44,35},{148,362,44,35},{195,375,60,38},{168,400,58,24},{228,398,38,24}})
crownB = ells({{300,322,34,28},{332,345,40,32},{278,352,36,30},{312,375,55,38},{348,388,40,30},{288,402,52,24},{330,410,40,18}})
crownC = ells({{75,352,30,28},{52,385,44,35},{102,378,34,32},{75,405,50,22},{30,410,26,20}})
crownD = ells({{396,388,24,22},{412,410,27,20},{384,414,24,15}})
bushes = ells({{128,428,34,14},{252,430,34,13},{362,432,28,11},{20,432,22,12}})
crowns = (crownA + crownB + crownC + crownD):roughen(6, 20, 51):roughen(2.5, 7, 52) + bushes:roughen(3, 10, 53)
trunks = ribbon({{182,398},{181,420},{184,447}}, 6) + ribbon({{306,400},{303,425},{302,447}}, 5)
       + ribbon({{70,402},{71,425},{73,447}}, 4.5) + ribbon({{400,415},{401,447}}, 3.2)
       + ribbon({{205,405},{209,447}}, 3) + ribbon({{330,412},{328,447}}, 3) + ribbon({{150,410},{146,447}}, 2.5)
treesL2 = (crowns + trunks) * above(function(x) return 450 end)
local carve = treesL - treesL2
sk_mid = pile{{"lead white",5},{"vermilion",0.07},{"yellow ochre",0.25},{"chrome yellow",0.12},{"cobalt blue",0.06}, medium=0.1}
sk_low = pile{{"lead white",6},{"chrome yellow",0.45},{"vermilion",0.08},{"yellow ochre",0.1}, medium=0.1}
local c1 = carve * above(function(x) return 372 end)
local c2 = carve * below(function(x) return 372 end) * above(function(x) return 438 end)
local c3 = carve * below(function(x) return 438 end)
for pass=1,2 do
  work(c1, {hand="detail", pile=sk_mid, angle=0, coverage=2.5, length={5,14}, tool={kind="filbert", width=4}, fill=true, clip=true})
  work(c2, {hand="detail", pile=sk_low, angle=0, coverage=2.5, length={5,14}, tool={kind="filbert", width=4}, fill=true, clip=true})
  work(c3, {hand="detail", pile=t_far, angle=0, coverage=2.5, length={4,10}, tool={kind="filbert", width=3}, fill=true, clip=true})
end
