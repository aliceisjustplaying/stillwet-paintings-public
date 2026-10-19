local function ells(list)
  local m=nil
  for _,e in ipairs(list) do local el=ellipse(e[1],e[2],e[3],e[4]); m = m and (m+el) or el end
  return m
end
-- far tree line: bumpy band along horizon
local n1 = noise{seed=31, period=40, octaves=3}
local n2 = noise{seed=32, period=12, octaves=2}
farline = below(function(x) return 438 - 5*math.max(0, n1(x,0)) * 2 - 2*n2(x,0) - (x>680 and x<760 and 4 or 0) end) * above(function(x) return 449 end)
t_far = pile{{"lead white",1.2},{"smalt",0.6},{"raw umber",0.5},{"red earth",0.12},{"green earth",0.3}, medium=0.1}
work(farline, {hand="detail", pile=t_far, angle=0, coverage=2.5, length={6,16}, tool={kind="round", width=3, point=0.4}, fill=true, clip=true})
-- left group
treesL = ells({{180,302,48,38},{150,340,60,45},{212,345,52,48},{168,390,72,45},{205,418,80,30},
               {292,338,44,40},{322,370,55,45},{268,388,58,40},{312,415,72,32},
               {72,368,38,40},{50,408,55,36},{98,418,52,28},{130,380,40,40},
               {382,392,30,30},{402,420,36,24},{240,395,40,40}}) + rect(20,418,410,32)
treesL = treesL:roughen(7, 22, 41):roughen(3, 8, 42) * above(function(x) return 450 end)
t_dark = pile{{"raw umber",1},{"bone black",0.35},{"green earth",1},{"smalt",0.3},{"lead white",0.2}, medium=0.08}
work(treesL, {hand="body", pile=t_dark, angle=function(x,y) return -1.2 + 0.4*math.sin(x/30) end, coverage=2.6, length={10,30}, tool="filbert 6", fill=true, clip=true, dips={3,0.8,0.3}})
-- right copse, bluish, more distant
treesR = ells({{830,405,45,22},{880,400,40,20},{790,420,40,18},{920,420,40,18},{860,425,90,16},{770,432,30,12},{950,435,30,10}})
treesR = treesR:roughen(5, 16, 43):roughen(2, 6, 44) * above(function(x) return 448 end)
t_mid = pile{{"raw umber",1},{"smalt",0.6},{"green earth",0.6},{"lead white",0.5},{"bone black",0.15}, medium=0.08}
work(treesR, {hand="body", pile=t_mid, angle=-1.3, coverage=2.6, length={8,20}, tool="filbert 4", fill=true, clip=true})
