snowShade = pile{{"lead white",3},{"pale smalt",2},{"smalt",0.6},{"raw umber",0.25},{"vermilion",0.03}, medium=0.15}
snowLit = pile{{"lead white",7},{"yellow ochre",0.25},{"vermilion",0.05},{"pale smalt",0.2}, medium=0.12}
local drift = {{-10,628},{150,606},{320,598},{520,612},{720,630},{900,628},{1010,618}}
local d1 = below(drift) * above({{-10,668},{150,640},{320,632},{520,648},{720,672},{900,668},{1010,656}})
work(d1, {hand="body", pile=snowShade, angle=0, coverage=1.5, pressure={0.4,0.6}, length={40,90}, angle_jitter=0.06})
work(below({{-10,690},{400,680},{1010,660}}), {hand="body", pile=snowShade, angle=0, coverage=1.2, pressure={0.4,0.6}, length={40,90}})
-- lit crest of the drift
work(ribbon(drift, 8), {hand="body", pile=snowLit, angle=0, coverage=1.5, pressure={0.4,0.6}, length={30,80}, angle_jitter=0.03})
-- faint shade along the foot of the mound
work(land * rect(40,468,540,22), {hand="body", pile=snowShade, angle=0, coverage=0.8, pressure={0.3,0.5}, length={40,80}})
-- lit far snow near the horizon on the right
work(land * rect(600,472,400,14), {hand="body", pile=snowLit, angle=0, coverage=1.2, pressure={0.4,0.6}, length={40,90}})
blend(land * rect(0,590,1000,130), {angle=0})
blend(land * rect(0,465,1000,40), {angle=0})
