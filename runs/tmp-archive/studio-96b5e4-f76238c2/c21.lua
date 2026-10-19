g_lit  = pile{{"yellow ochre",1.2},{"lead white",0.55},{"red earth",0.15},{"green earth",0.3}, medium=0.12}
g_lit2 = pile{{"yellow ochre",1},{"lead white",0.3},{"green earth",0.6},{"raw umber",0.2}, medium=0.12}
g_dk   = pile{{"raw umber",1},{"bone black",0.3},{"green earth",0.6},{"smalt",0.15}, medium=0.12}
local mm = marsh - treesL2:grow(2)
local N = noise{seed=71, period=120, octaves=3, stretch={0, 4}}
-- distance bands: {y0,y1,tool width,len}
local bands = {{450,470,1.4,{3,8}},{468,495,2,{5,12}},{493,525,2.6,{7,16}},{523,560,3.4,{9,22}}}
for i,b in ipairs(bands) do
  local m = mm * rect(0,b[1],1000,b[2]-b[1])
  local lit = m * mask(function(x,y) return N:at01(x,y) > 0.52 and 1 or 0 end)
  local dk  = m * mask(function(x,y) return N:at01(x,y) < 0.36 and 1 or 0 end)
  work(lit, {hand="hatch", pile=(i%2==0) and g_lit or g_lit2, angle=0, coverage=0.7, length=b[4], tool={kind="flat", width=b[3]}, clip=m, load=0.45, pressure={0.3,0.6}})
  work(dk, {hand="hatch", pile=g_dk, angle=0, coverage=0.6, length=b[4], tool={kind="flat", width=b[3]}, clip=m, load=0.45, pressure={0.3,0.6}})
end
