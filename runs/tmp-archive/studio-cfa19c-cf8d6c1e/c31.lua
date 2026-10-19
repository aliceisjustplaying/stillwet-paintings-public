local up = {{600,352,18},{630,340,22},{660,325,24},{690,306,26},{722,288,26},{752,275,26},{785,270,24},{812,280,20},{838,295,20},{866,309,22},{898,321,20},{930,330,18},{960,340,18},{990,350,18}}
local lo = {{650,362,18},{705,332,20},{760,316,22},{820,326,18},{880,346,18},{940,358,16},{985,370,15}}
local parts = {}
for i,b in ipairs(up) do parts[#parts+1] = {body.ellipsoid({b[1],b[2],0},{b[3]*1.1,b[3]*0.9,b[3]}):rough(2.5, 25, i)} end
for i,b in ipairs(lo) do parts[#parts+1] = {body.ellipsoid({b[1],b[2],25},{b[3]*1.15,b[3]*0.85,b[3]}):rough(2.5, 25, 50+i)} end
parts.light = {from={-1,-1.1}, front=0.25, ambient=0.15}
billF = form(parts)
local notTown = -(townM:grow(2))
ch = pile{{"lead white",9},{"pale smalt",1},{"red earth",0.1},{"yellow ochre",0.25}, medium=0.05}
cl3 = pile{{"lead white",14},{"yellow ochre",0.28},{"vermilion",0.04}}
local half = billF:lit{soft=0.45} * notTown
local lit = billF:lit{soft=0.12} * notTown
work(half, {hand="body", tool="filbert 4", pile=ch, angle=function(x,y) return billF:across(x,y) end, coverage=1.6, fill=true, pressure={0.35,0.55}, edge={found=0.6, soft=0.4}, seed=181})
work(lit, {hand="body", tool="filbert 3", pile=cl3, angle=function(x,y) return billF:across(x,y) end, coverage=2, fill=true, pressure={0.4,0.65}, edge={found=0.7, soft=0.3}, seed=182})
print(half:area(), lit:area())
