twigK = pile{{"bone black",1.2},{"raw umber",0.8},{"smalt",0.3}, medium=0.1}
local sub = {limbs={}}
for i,l in ipairs(OAKT.limbs) do if l.pts[1][1] < 330 and l.pts[1][2] < 200 then sub.limbs[#sub.limbs+1] = l end end
print(#sub.limbs, tree_restroke(sub, twigK, 3.5))
