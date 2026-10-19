sky1 = pile{{"smalt",3},{"lead white",3},{"bone black",0.25},{"red earth",0.1}, medium=0.15}
sky2 = pile{{"pale smalt",2},{"lead white",5},{"smalt",0.5},{"bone black",0.08}, medium=0.15}
sky3 = pile{{"lead white",7},{"pale smalt",1},{"yellow ochre",0.35}, medium=0.15}
sky4 = pile{{"lead white",8},{"yellow ochre",0.8},{"vermilion",0.07}, medium=0.15}
sky5 = pile{{"lead white",6},{"yellow ochre",1},{"vermilion",0.3},{"red earth",0.15}, medium=0.15}
local bands = {{sky1, -10, 125}, {sky2, 105, 235}, {sky3, 215, 335}, {sky4, 315, 405}, {sky5, 390, 485}}
for i, b in ipairs(bands) do
  work(rect(-10, b[2], 1020, b[3] - b[2]), {hand="body", pile=b[1], angle=0, angle_jitter=0.06,
     length={70, 170}, coverage=2.6, fill=true, pressure={0.5, 0.75}, seed=30+i})
end
