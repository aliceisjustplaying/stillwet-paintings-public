function cloudm(list, seed)
  local m = nil
  for i,e in ipairs(list) do
    local el = ellipse(e[1],e[2],e[3],e[4])
    m = m and (m + el) or el
  end
  return m:roughen(6, 40, seed):soften(3) * sky
end
cl_bank = cloudm({{520,170,120,14},{680,160,150,20},{850,150,170,26},{960,175,110,18},{760,185,120,10},{420,182,70,8}}, 11)
cl_mid  = cloudm({{120,280,140,10},{260,292,110,8},{60,300,80,7},{380,300,60,5}}, 12)
cl_low  = cloudm({{240,378,160,5},{470,388,120,4},{830,370,100,5},{120,395,70,3}}, 13)
cl_top  = cloudm({{120,60,180,22},{320,40,160,16},{40,90,120,14},{560,55,90,10}}, 14)
c1 = pile{{"lead white",3},{"smalt",0.6},{"red earth",0.3},{"raw umber",0.2},{"vermilion",0.05}, medium=0.15}
c2 = pile{{"lead white",3.5},{"red earth",0.3},{"cobalt blue",0.3},{"yellow ochre",0.15}, medium=0.15}
c0 = pile{{"lead white",2},{"smalt",0.7},{"raw umber",0.3},{"red earth",0.2}, medium=0.15}
local hor = function(x,y) return 0.03*math.sin(x/150) end
work(cl_top, {hand="body", pile=c0, angle=hor, coverage=2, length={40,120}, tool="filbert 10", load=0.6})
work(cl_bank, {hand="body", pile=c1, angle=hor, coverage=2.2, length={40,140}, tool="filbert 10", load=0.6})
work(cl_mid, {hand="body", pile=c1, angle=hor, coverage=2, length={30,110}, tool="filbert 7", load=0.55})
work(cl_low, {hand="body", pile=c2, angle=hor, coverage=1.8, length={30,100}, tool="filbert 5", load=0.5})
