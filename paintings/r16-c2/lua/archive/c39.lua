mudL4 = poly({{-10,566},{80,561},{170,566},{260,569},{360,572},{450,574},{505,577},{516,583},{500,598},{486,606},{476,622},{452,646},{436,668},{414,692},{398,720},{-10,720}}):roughen(2.5, 18, 91)
mudR4 = poly({{1010,578},{900,580},{800,582},{735,584},{716,589},{728,601},{748,618},{772,640},{800,664},{826,688},{850,720},{1010,720}}):roughen(2.5, 18, 92)
mud4 = mudL4 + mudR4
local add = mud4 - mudAll2:shrink(2)
local o = {hand="body", tool="filbert 9", angle=0.01, coverage=3, length={25,80}, fill=true, clip=mud4, angle_jitter=0.03}
o.pile=mudD; work(add * rect(0,640,1000,90), o)
o.pile=mudDM; work(add * rect(0,596,1000,50), o)
o.pile=mudL3; o.tool="filbert 7"; work(add * rect(0,555,1000,45), o)
blend(mud4, {angle=0})
