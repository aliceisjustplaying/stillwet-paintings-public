local wx, mx = 571, 596
local shawl = poly({{wx-7.5, 533}, {wx-8, 545}, {wx, 553}, {wx+8, 545}, {wx+7.5, 533}, {wx+3, 530}, {wx-3, 530}}, true)
local arm = ribbon({{wx+6, 537}, {wx+11, 545}, {mx-8, 548}}, {3.4, 3, 2.8})
shawlP2 = pile{{"lead white", 2}, {"yellow ochre", 0.5}, {"raw umber", 0.6}, {"smalt", 0.12}, medium=0.05}
shawlSh = pile{{"lead white", 1.4}, {"raw umber", 0.8}, {"smalt", 0.25}, {"yellow ochre", 0.3}, medium=0.05}
local sh = shawl - ellipse(wx, 524.5, 4.1, 5.1)
work(sh + arm, {hand="detail", pile=shawlP2, coverage=4, fill=true, clip=true, angle=1.2, length={2,5}})
work((sh * rect(wx-9, 530, 5, 25)) + (sh * rect(wx-3, 546, 8, 8)), {hand="detail", pile=shawlSh, coverage=2, clip=true, angle=1.2, length={2,4}, pressure={0.3,0.5}})
-- fringe/tassel at the point
local fb = brush{kind="round", width=0.8, point=1}
fb:load(shawlSh, 0.7)
for k = -3, 3 do fb:stroke({{wx + k*0.9, 552}, {wx + k*1.1, 555.5}}, {pressure={fb:pressure_for(0.5), fb:pressure_for(0.3)}}) end
-- man's collar and hat band hints
local hb = brush{kind="round", width=1, point=1}
hb:load(pile{{"bone black", 1}, {"raw umber", 0.5}}, 0.8)
hb:stroke({{mx-4, 534}, {mx, 536}, {mx+4, 534}}, {pressure={hb:pressure_for(0.9), hb:pressure_for(0.9)}})
