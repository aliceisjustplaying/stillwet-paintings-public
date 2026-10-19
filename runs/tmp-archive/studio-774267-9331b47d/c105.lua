print(drying(200, 630), drying(600, 630), drying(345, 540))
local gz = pile{{"raw umber", 0.8}, {"green earth", 0.8}, {"Prussian blue", 0.06}, {"bone black", 0.1}, medium=0.75}
local m = mask(function(x, y) return (y > 592 and x < 736) and 1 or 0 end) - (MAN + WOMAN):grow(1)
work(m, {hand="glaze", tool="filbert 14", pile=gz, angle=0.05, length={100,250}, coverage=1.2, clip=true, load_at=function(x, y) return clamp((y - 592)/60, 0, 1)*0.55 end, seed=10501})
-- the dress: a deeper, cooler red glaze
local skirt = poly({{336, 509}, {348.5, 509}, {350.5, 516}, {352.5, 540}, {355.5, 566.5}, {343, 568}, {331.5, 566.5}, {333.5, 540}, {334.5, 516}}, true)
local rg = pile{{"red earth", 0.8}, {"raw umber", 0.5}, {"bone black", 0.12}, {"smalt", 0.15}, medium=0.65}
work(skirt, {hand="detail", tool={kind="round", width=1.8, point=0.3}, pile=rg, angle=math.pi/2, coverage=1.5, fill=true, load=0.5, seed=10502})
