local cloudHole = cloudM:grow(1)
d1 = pile{{"lead white",3},{"cobalt blue",2},{"smalt",1.6}, medium=0.12}
d2 = pile{{"lead white",5},{"cobalt blue",1.6},{"smalt",1.0}, medium=0.12}
d3 = pile{{"lead white",7},{"cobalt blue",0.9},{"pale smalt",1.5}, medium=0.12}
local bands = {{d1,-5,105},{d2,90,195},{d3,180,275}}
for i,b in ipairs(bands) do
  local m = rect(-10,b[2],1020,b[3]-b[2]) - cloudHole
  work(m, {hand="broad", pile=b[1], angle=function(x,y) return 0.03*math.sin(x/230+i*3) end, coverage=2.2, fill=true, pressure={0.45,0.7}, edge=0.12, seed=70+i})
end
blend(rect(0,0,1000,350) - cloudHole, {angle=0, coverage=3, seed=74})
blend(rect(0,60,1000,260) - cloudHole, {angle=0.03, coverage=2, seed=75})
