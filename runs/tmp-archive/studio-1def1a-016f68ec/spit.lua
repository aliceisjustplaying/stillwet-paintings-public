mudD = pile{{"raw umber",1},{"red earth",0.3},{"bone black",0.25},{"lead white",0.25},{"green earth",0.3}}
mudM = pile{{"raw umber",1},{"yellow ochre",0.4},{"red earth",0.2},{"lead white",0.6},{"smalt",0.2}}
spit2 = outline{{-20,566},{50,560},{130,561},{210,572},{290,596},{360,630},{410,672},{-20,690}, closed=true, char="soft", seed=91}:mask()
work(spit2, {hand="body", pile=mudD, angle=function(x,y) return 0.12 + (x/1000)*0.3 end, angle_jitter=0.1, coverage=3, length={20,70}, fill=true})
-- a lighter muddy top edge where the bank catches the sky
local lip = spit2 - spit2:offset(-7)
local lipTop = lip * mask(function(x,y) return 1 end)
work(lip, {hand="detail", pile=mudM, angle=0.2, coverage=1.2, pressure={0.3,0.6}})
