skyline = {{0,478},{60,466},{130,446},{210,425},{300,414},{390,418},{470,434},{540,455},{610,471},{700,474},{1000,474}}
sky = above(skyline)
skyA = pile{{"lead white",3},{"pale smalt",3},{"smalt",1},{"bone black",0.12}, medium=0.15}
skyB = pile{{"lead white",5},{"pale smalt",2},{"smalt",0.3},{"raw umber",0.08}, medium=0.15}
skyC = pile{{"lead white",7},{"yellow ochre",0.35},{"pale smalt",0.5},{"vermilion",0.04}, medium=0.15}
skyD = pile{{"lead white",7},{"yellow ochre",0.9},{"vermilion",0.14}, medium=0.15}
local bands = {{skyA,-20,170},{skyB,140,300},{skyC,270,400},{skyD,370,500}}
for i,b in ipairs(bands) do
  local m = sky * rect(-20, b[2], 1040, b[3]-b[2])
  work(m, {hand="broad", pile=b[1], angle=0, coverage=2, fill=true, angle_jitter=0.05, pressure={0.5,0.8}})
end
