glow1 = pile{{"lead white",6},{"yellow ochre",0.5},{"chrome yellow",0.3},{"vermilion",0.12}, medium=0.35}
glow2 = pile{{"lead white",6},{"yellow ochre",0.8},{"vermilion",0.45}, medium=0.3}
local sunx = 600
work(rect(0,372,1000,48), {hand="body", pile=glow1, angle=0, angle_jitter=0.02, coverage=2, fill=true, clip=true, length={60,140}, pressure={0.4,0.7}, load_at=function(x,y) return clamp(0.25+0.4*(y-372)/48 + 0.2*math.exp(-((x-sunx)/250)^2),0.1,0.9) end, seed=101})
work(rect(0,412,1000,40), {hand="body", pile=glow2, angle=0, angle_jitter=0.02, coverage=2.4, fill=true, clip=true, length={60,140}, pressure={0.5,0.8}, load_at=function(x,y) return clamp(0.4+0.4*(y-412)/40 + 0.25*math.exp(-((x-sunx)/250)^2),0.1,0.95) end, seed=102})
for i=1,2 do blend(rect(0,368,1000,85), {angle=0, ruler=true, length={150,350}, seed=103+i}) end
