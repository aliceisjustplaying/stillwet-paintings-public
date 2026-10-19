coatP = pile{{"bone black", 1}, {"Prussian blue", 0.3}, {"raw umber", 1}, {"green earth", 0.6}, {"lead white", 0.15}}
trouserP = pile{{"raw umber", 1.5}, {"lead white", 0.5}, {"bone black", 0.35}, {"yellow ochre", 0.2}}
hairP = pile{{"raw umber", 2}, {"red earth", 0.5}, {"bone black", 0.3}}
skinP = pile{{"lead white", 1}, {"red earth", 0.5}, {"yellow ochre", 0.5}, {"raw umber", 0.5}}
dressP = pile{{"red earth", 1.6}, {"raw umber", 0.9}, {"bone black", 0.3}, {"vermilion", 0.2}}
shawlP = pile{{"lead white", 2}, {"yellow ochre", 0.4}, {"raw umber", 0.5}, {"smalt", 0.15}}
local mx, fy = 596, 603
local legs = poly({{mx-6, 574}, {mx-5.5, fy-1}, {mx-7, fy+1}, {mx-2, fy+1}, {mx-1.5, 575}, {mx+1, 575}, {mx+2, fy+1}, {mx+6.5, fy+1}, {mx+5, fy-1}, {mx+5.5, 574}}, false)
local coat = poly({{mx-9, 537}, {mx-10.5, 555}, {mx-11.5, 578}, {mx+11.5, 579}, {mx+10.5, 555}, {mx+9.5, 537}, {mx+4, 533}, {mx-4, 533}}, true)
local head = ellipse(mx, 526, 4.6, 5.6)
local neck = rect(mx-2.6, 530, 5.2, 4.5)
local cap = ellipse(mx - 0.5, 521.5, 6.8, 2.6)
local wx = 571
local dress = poly({{wx-5, 548}, {wx-9, 570}, {wx-13, fy+1}, {wx+13, fy+1}, {wx+9, 570}, {wx+5, 548}}, true)
local bodice = poly({{wx-6.5, 534}, {wx-6, 550}, {wx+6, 550}, {wx+6.5, 534}, {wx+3, 531}, {wx-3, 531}}, true)
local shawl = poly({{wx-7.5, 533}, {wx-8, 545}, {wx, 553}, {wx+8, 545}, {wx+7.5, 533}, {wx+3, 530}, {wx-3, 530}}, true)
local whead = ellipse(wx, 524.5, 4.1, 5.1)
local bun = ellipse(wx, 527.5, 2.8, 2.4)
local arm = ribbon({{wx+6, 537}, {wx+11, 545}, {mx-8, 548}}, {3.4, 3, 2.8})
local d = function(m, p) work(m, {hand="detail", pile=p, coverage=3.5, fill=true, clip=true, angle=-1.57, length={2,6}}) end
d(legs, trouserP); d(coat, coatP); d(neck, skinP); d(head, hairP); d(cap, coatP)
d(dress, dressP); d(bodice, dressP); d(shawl, shawlP); d(arm, shawlP); d(whead, hairP); d(bun, hairP)
figM = legs + coat + head + neck + cap + dress + bodice + shawl + whead + arm
-- walking stick
local st = brush{kind="round", width=2, point=0.6}
st:load(hullP, 0.8)
st:stroke({{mx+10, 566}, {mx+13, 585}, {mx+15.5, fy+1}}, {pressure={st:pressure_for(1.0), st:pressure_for(0.9)}})
