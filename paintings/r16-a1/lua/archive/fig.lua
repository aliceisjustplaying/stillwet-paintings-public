coatP = pile{{"bone black",0.7},{"raw umber",1},{"green earth",0.6},{"smalt",0.2},{"lead white",0.25}, medium=0.05}
capP = pile{{"bone black",1},{"raw umber",0.6},{"red earth",0.15}, medium=0.05}
local X, F = 502, 499   -- center, feet
local coat = poly({{X-4.6,F-31},{X-2,F-32.3},{X+2.2,F-32.3},{X+5,F-30.8},{X+6.2,F-27},{X+7.8,F-21.5},{X+8.3,F-19.5},{X+7,F-18.5},{X+7.2,F-10},{X+8,F-3.5},{X-7.5,F-3},{X-6.4,F-12},{X-5.8,F-22},{X-5.6,F-27.5}}, true)
local neck = rect(X-1.8, F-34.5, 3.6, 3)
local head = ellipse(X+0.3, F-36.2, 2.5, 3.0)
local cap = ellipse(X+0.1, F-38.3, 3.2, 1.7) + ellipse(X+1.2, F-38.9, 2.2, 1.4)
local legs = rect(X-4.2, F-3.5, 2.6, 3.5) + rect(X+1.8, F-3.5, 2.6, 3.8)
work(coat + neck + legs, {hand="detail", pile=coatP, coverage=4, fill=true, angle=math.pi/2, load=1, pressure={0.5,0.8}, tool={kind="round", width=1.2, point=0.8}})
work(head, {hand="detail", pile=capP, coverage=4, fill=true, load=1, pressure={0.5,0.8}, tool={kind="round", width=1, point=0.8}})
work(cap, {hand="detail", pile=capP, coverage=4, fill=true, load=1, pressure={0.5,0.8}, tool={kind="round", width=1, point=0.8}})
-- staff
local st = brush{kind="round", width=1.4, point=1}
st:load(capP, 0.8)
st:stroke({{X+8.5, F-20}, {X+10.2, F-10}, {X+11.8, F+0.5}}, {pressure={st:pressure_for(0.9), st:pressure_for(0.8)}})
st:stroke({{X+8.2, F-21.5}, {X+8.4, F-23.5}}, {pressure={st:pressure_for(0.9), st:pressure_for(0.8)}})
