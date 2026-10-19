dry()
local roofs = poly({{695,HZ+1},{695,HZ-7},{702,HZ-14.5},{709,HZ-7},{710,HZ-5},{712,HZ-10.5},{716,HZ-5},{719,HZ-6},{725,HZ-12.5},{731,HZ-6},{731,HZ+1}})
local tower = poly({{736.6,HZ+1},{736.8,HZ-21},{742.4,HZ-21},{742.6,HZ+1}})
work(roofs + tower, {hand="detail", tool="round 1", length={2, 5}, coverage=4, medium=0.18, angle=1.57, color="#5f5b66", edge={found=0.8, soft=0.2, period=10, seed=2}, aim="masstone"})
local sp = brush{kind="round", width=1.8, point=1}
sp:load("#5d5963", 0.9)
sp:stroke({{739.6, HZ - 19}, {739.5, HZ - 30}, {739.4, HZ - 41}}, {pressure={0.95, 0.0}, ramps={0.0, 0.9}})
sp:stroke({{738.2, HZ - 21}, {739.4, HZ - 33}}, {pressure={0.8, 0.0}})
sp:stroke({{741.0, HZ - 21}, {739.6, HZ - 33}}, {pressure={0.8, 0.0}})
