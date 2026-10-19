hz = function(x) return 441 + 2*math.sin(x/130) end
sky = above(hz)
s1 = pile{{"lead white",3},{"smalt",1},{"cobalt blue",0.6},{"raw umber",0.25}, medium=0.1}
s2 = pile{{"lead white",4},{"cobalt blue",0.5},{"smalt",0.4},{"red earth",0.08}, medium=0.1}
s3 = pile{{"lead white",5},{"vermilion",0.12},{"yellow ochre",0.25},{"cobalt blue",0.12}, medium=0.1}
s4 = pile{{"lead white",6},{"chrome yellow",0.6},{"vermilion",0.12}, medium=0.1}
local bands = {{s1,0,150},{s2,120,270},{s3,240,370},{s4,340,450}}
for i,b in ipairs(bands) do
  local m = rect(0,b[2],1000,b[3]-b[2]) * sky
  work(m, {hand="broad", pile=b[1], angle=function(x,y) return 0.05*math.sin(x/200+y/90) end, coverage=2.5, fill=true, tool="filbert 18"})
end
