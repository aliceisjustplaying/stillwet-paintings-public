-- the trodden path, from the walker back down to us through the gap in the bank
pathC = {{481,536},{462,542},{440,549},{412,558},{385,569},{364,585},{350,605},{342,630},{337,655},{333,685},{330,720}}
local ws = {}
for i, p in ipairs(pathC) do ws[i] = 2 + 30 * ((p[2] - 536) / 184)^1.4 end
pathM = ribbon(pathC, ws):roughen(1.0, 6, 43)
pathP = pile{{"smalt",1.5},{"pale smalt",1},{"bone black",0.2},{"lead white",1.5},{"vermilion",0.05}, medium=0.7}
work(pathM, {hand="detail", tool={kind="round", width=3, point=0.4}, pile=pathP, load=0.45, pressure={0.35, 0.6}, coverage=2, fill=true, clip=true, angle=function(x,y) return 1.2 end})
blend(pathM:grow(2), {angle=1.2})
