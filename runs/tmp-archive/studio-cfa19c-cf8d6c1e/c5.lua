s1 = pile{{"lead white",5},{"cobalt blue",2},{"smalt",1.6}, medium=0.12}
s2 = pile{{"lead white",7},{"cobalt blue",1.2},{"smalt",1.0}, medium=0.12}
s3 = pile{{"lead white",9},{"pale smalt",1.6},{"cobalt blue",0.4}, medium=0.12}
s4 = pile{{"lead white",10},{"pale smalt",0.7},{"yellow ochre",0.15}, medium=0.12}
s5 = pile{{"lead white",10},{"yellow ochre",0.45},{"vermilion",0.06}, medium=0.12}
local bands = {{s1,0,110},{s2,95,210},{s3,195,300},{s4,285,370},{s5,355,HZ+4}}
for i,b in ipairs(bands) do
  local m = rect(-10, b[2], 1020, b[3]-b[2])
  work(m, {hand="broad", pile=b[1], angle=function(x,y) return 0.03*math.sin(x/170+i) end, coverage=2.5, fill=true, pressure={0.5,0.75}, seed=10+i})
end
