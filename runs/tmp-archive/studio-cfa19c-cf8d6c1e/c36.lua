clumps = {
 {240,142,34},{287,128,28},{203,172,30},{330,175,32},
 {160,218,34},{232,212,36},{300,214,34},{372,232,30},
 {128,278,32},{198,282,28},{262,272,30},{333,288,34},{397,302,26},
 {104,342,30},{170,340,32},{242,342,26},{312,352,30},{382,350,28},
 {120,400,26},{186,405,24},{290,410,24},{360,410,28},{410,392,20},{150,440,18},{343,446,16},
}
local parts = {}
for i,c in ipairs(clumps) do
  parts[#parts+1] = {body.ellipsoid({c[1],c[2],rand(-10,10)},{c[3]*1.12,c[3]*0.88,c[3]}):rough(c[3]*0.18, c[3]*0.5, 300+i)}
end
parts.light = {from={-1,-0.6}, front=0.35, ambient=0.15}
oakF = form(parts)
oakSil = oakF:silhouette{}
fd = pile{{"Prussian blue",1},{"raw umber",1.1},{"yellow ochre",1},{"bone black",0.15}, medium=0.05}
work(oakSil:shrink(6), {hand="body", tool="filbert 6", pile=fd, angle=function(x,y) return oakF:across(x,y) end, coverage=2, fill=true, pressure={0.45,0.7}, seed=221})
stipple(oakSil:grow(2), {pile=fd, width=5, coverage=function(x,y) return 1.4 end, pressure={0.4,0.8}, cluster={0.5, 6}, feather=0.5, dips={20,0.7,0.2}, seed=222})
print(oakSil:area())
