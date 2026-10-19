capShade = pile{{"lead white",4},{"smalt",0.8},{"raw umber",0.1},{"vermilion",0.03}, medium=0.08}
snowTop = pile{{"lead white",5},{"yellow ochre",0.1},{"vermilion",0.04},{"smalt",0.15}, medium=0.08}
local top = {{543,454},{549,446},{562,439},{582,434},{604,430},{628,428},{652,428},{676,429},{698,432},{716,436},{729,442},{737,450},{739,455}}
local bot = {{739,455},{731,452},{722,454},{711,451},{699,455},{687,452},{676,455},{663,452},{650,456},{637,452},{624,455},{611,452},{598,456},{585,452},{572,455},{560,452},{550,456},{543,454}}
local pts = {}
for _,p in ipairs(top) do pts[#pts+1] = p end
for _,p in ipairs(bot) do pts[#pts+1] = p end
SNOWCAP = poly(pts, true)
work(SNOWCAP, {hand="detail", pile=capShade, coverage=3.5, fill=true, angle=0, load=1, pressure={0.6,0.9}})
local ws = {}; for i=1,#top do ws[i] = 5 end
local rim = ribbon(top, ws) * SNOWCAP:grow(1)
work(rim, {hand="detail", pile=snowTop, coverage=3, fill=true, angle=0, load=0.9, pressure={0.5,0.8}})
