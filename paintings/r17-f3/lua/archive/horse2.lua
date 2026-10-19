local function Pf(x0,y0,s,dir) return function(u,v) return {x0 + dir*u*s, y0 - v*s} end end
local P = Pf(742,531,12.5,-1)
local grey = pile{{"lead white",4},{"raw umber",0.3},{"pale smalt",0.3},{"yellow ochre",0.1}, medium=0.08}
local greyS = pile{{"lead white",2},{"raw umber",0.5},{"pale smalt",0.6},{"bone black",0.05}, medium=0.08}
local add = poly({P(0.4,1.45),P(0.75,1.62),P(0.95,1.95),P(1.12,1.98),P(1.05,1.6),P(0.95,1.2),P(0.8,0.98),P(0.5,0.95)}, true)
         + poly({P(-0.8,1.0),P(-0.3,0.84),P(0.4,0.84),P(0.8,0.98),P(0.8,1.2),P(-0.8,1.2)}, true)
         + poly({P(1.0,1.95),P(1.15,2.05),P(1.48,1.68),P(1.44,1.56),P(1.28,1.58),P(1.0,1.75)}, true)
local t = {kind="round", width=1.2, point=0.5}
work(add, {hand="detail", pile=grey, tool=t, angle=0, length={2,6}, coverage=3, clip=true, fill=true, edge="found"})
local under = (add + HORSES) * ellipse(742,531,30,30) * mask(function(x,y) return y > 531 - 1.05*12.5 and 1 or 0 end)
work(under, {hand="detail", pile=greyS, tool={kind="round", width=1.0, point=0.5}, angle=0, length={2,5}, coverage=1.5, clip=true})
HORSES = HORSES + add
-- manes and tails
local dark = pile{{"raw umber",1},{"bone black",0.6},{"lead white",0.2}, medium=0.08}
local r = brush{kind="rigger", width=0.9, point=1}
r:load(dark, 0.5)
r:stroke({P(0.72,1.62),P(0.9,1.9),P(1.05,2.03)}, {pressure={0.6,0.3}})
r:stroke({P(-0.84,1.3),P(-0.92,1.0),P(-0.88,0.62)}, {pressure={0.4,0.1}})
local Q = Pf(688,534,13,1)
r:reload(dark, 0.5)
r:stroke({Q(0.6,1.46),Q(0.85,1.36),Q(1.08,0.95),Q(1.16,0.55)}, {pressure={0.6,0.3}})
r:stroke({Q(-0.84,1.3),Q(-0.94,0.98),Q(-0.9,0.55)}, {pressure={0.7,0.2}})
-- hooves and cast shadows on the grass
local sh = pile{{"green earth",1.2},{"raw umber",0.8},{"Prussian blue",0.2},{"lead white",0.3}, medium=0.1}
local shm = ellipse(700,534.5,20,1.6) + ellipse(733,531.5,19,1.5)
work(shm, {hand="detail", pile=sh, angle=0, length={4,10}, coverage=2, clip=true, fill=true})
print(wait(0))
