local cloudHole = cloudM:grow(1)
b2 = pile{{"lead white",6},{"cobalt blue",1.1},{"smalt",0.8},{"pale smalt",0.6}, medium=0.12}
b3 = pile{{"lead white",8},{"pale smalt",1.8},{"cobalt blue",0.45}, medium=0.12}
b4 = pile{{"lead white",10},{"pale smalt",1.2},{"cobalt blue",0.1},{"yellow ochre",0.08}, medium=0.12}
local bands = {{b2,55,165},{b3,150,265},{b4,250,345}}
for i,b in ipairs(bands) do
  local m = rect(-10,b[2],1020,b[3]-b[2]) - cloudHole
  work(m, {hand="broad", pile=b[1], angle=function(x,y) return 0.03*math.sin(x/200+i*2) end, coverage=2.2, fill=true, pressure={0.45,0.7}, edge=0.12, seed=60+i})
end
blend(rect(0,40,1000,320) - cloudHole, {angle=0, coverage=2.5, seed=64})
