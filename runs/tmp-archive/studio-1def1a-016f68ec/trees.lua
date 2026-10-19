treeD = pile{{"lead white",0.8},{"smalt",1},{"red earth",0.35},{"raw umber",0.9},{"green earth",0.4}}
local crowns = {
 {735,428,18,10},{758,421,17,15},{781,414,16,19},{803,404,7,30},{814,409,12,24},{838,413,22,19},
 {862,402,17,26},{884,409,15,22},{905,414,20,18},{930,421,20,14},{955,429,18,9},
 {447,431,12,6},{468,428,14,8},{492,430,14,7},{40,429,12,8},{62,425,10,12},{78,428,9,9},{100,431,12,6},
}
local m = nil
for i,c in ipairs(crowns) do
  local e = ellipse(c[1],c[2],c[3],c[4])
  m = m and (m + e) or e
end
m = m + rect(725,425,245,14)
m = m:roughen(4, 9, 21)
treesM = m * above(function(x) return 441 end)
stipple(treesM, {pile=treeD, width=3, coverage=5, pressure={0.4,0.8}, cluster=0.3})
