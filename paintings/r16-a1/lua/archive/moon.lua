moonP = pile{{"lead white",5},{"chrome yellow",0.2},{"yellow ochre",0.05}}
local mm = ellipse(752, 150, 8.5, 8.5) - ellipse(749.5, 146.2, 8.3, 8.3)
work(mm, {hand="detail", pile=moonP, coverage=4, fill=true, load=1, tool={kind="round", width=1.2, point=1}, pressure={0.5,0.8}})
-- faint ashen light on the dark part
local ash = pile{{"lead white",3},{"smalt",1.3},{"raw umber",0.1}, medium=0.5}
local am = ellipse(752, 150, 8.3, 8.3) - ellipse(752, 150, 8.5, 8.5):shrink(0) * (-(ellipse(749.5,146.2,8.3,8.3)))
