mudL = poly({{-10,556},{60,546},{130,538},{200,540},{260,547},{330,560},{390,575},{440,595},{480,617},{520,645},{555,680},{575,720},{-10,720}}, true):roughen(4, 40, 11)
mudR = poly({{1010,556},{960,562},{905,580},{860,610},{835,650},{822,690},{818,720},{1010,720}}, true):roughen(4, 40, 12)
bar = poly({{110,470},{170,462},{260,457},{360,459},{470,464},{560,469},{640,476},{560,479},{420,476},{280,474},{180,475}}, true):roughen(2, 30, 13)
barR = poly({{680,500},{760,492},{860,488},{1010,484},{1010,512},{900,508},{800,506},{720,505}}, true):roughen(2, 30, 14)
mudAll = mudL + mudR + bar + barR
waterM = rect(0,400,1000,320) - mudAll
wat1 = pile{{"lead white",5},{"chrome yellow",0.6},{"yellow ochre",0.6},{"vermilion",0.12},{"raw umber",0.1}}
wat2 = pile{{"lead white",4},{"yellow ochre",0.6},{"vermilion",0.15},{"cobalt blue",0.25},{"raw umber",0.1}}
wat3 = pile{{"lead white",3},{"cobalt blue",0.6},{"red earth",0.3},{"raw umber",0.15}}
wat4 = pile{{"lead white",2},{"cobalt blue",0.9},{"smalt",0.3},{"red earth",0.2},{"raw umber",0.25}}
local c = rect(0,399,1000,321)
work(waterM * rect(0,398,1000,62), {hand="body", tool="filbert 10", pile=wat1, angle=0, coverage=2.5, length={40,120}, fill=true, clip=c})
work(waterM * rect(0,455,1000,70), {hand="body", tool="filbert 12", pile=wat2, angle=0, coverage=2.5, length={40,120}, fill=true, clip=c})
work(waterM * rect(0,520,1000,90), {hand="body", tool="filbert 14", pile=wat3, angle=0, coverage=2.5, length={40,120}, fill=true, clip=c})
work(waterM * rect(0,605,1000,115), {hand="body", tool="filbert 14", pile=wat4, angle=0, coverage=2.5, length={40,120}, fill=true, clip=c})
