local lit = pile{{"lead white",4},{"pale smalt",0.9},{"smalt",0.25},{"yellow ochre",0.1},{"raw umber",0.08}, medium=0.08}
local litH = pile{{"lead white",3},{"pale smalt",0.9},{"smalt",0.5},{"yellow ochre",0.06},{"raw umber",0.1}, medium=0.08}
local roofD = pile{{"lead white",1.8},{"smalt",1.4},{"bone black",0.35},{"red earth",0.18}, medium=0.08}
local roofW = pile{{"lead white",2.0},{"smalt",1.0},{"red earth",0.3},{"bone black",0.15}, medium=0.08}
local det = function(m, p, w) work(m, {hand="detail", pile=p, tool={kind="round", width=w or 0.8, point=0.5}, angle=math.pi/2, length={2,5}, coverage=2.5, clip=true, fill=true, edge="found", load=0.7}) end
det(poly{{593,469},{593,446},{596.5,446},{596.5,469}}, lit)
det(poly{{674,469},{674,446},{677.5,446},{677.5,469}}, lit)
det(poly{{755,469},{755,446},{758,446},{758,469}}, lit)
det(poly{{607,469},{607,452},{611,445},{611,469}}, lit)
det(poly{{686,469},{686,454},{690.5,447},{690.5,469}}, lit)
det(poly{{612,445},{664,445},{668,451},{611,451}}, roofD)
det(poly{{691,447},{748,447},{751,452},{690,452}}, roofD)
local r = brush{kind="round", width=1.0, point=0.6}
local dk = pile{{"smalt",1},{"bone black",0.6},{"lead white",0.6}, medium=0.08}
r:load(dk, 0.4)
for x = 620, 660, 8 do r:stroke({{x,455},{x,462}}, {pressure={0.3,0.3}}) end
for x = 698, 744, 8 do r:stroke({{x,457},{x,464}}, {pressure={0.3,0.3}}) end
-- low houses in front, hazy: {x, width, wall h, roof h}
local H = {{558,8,3.5,3},{567,7,3,3.5},{575,9,4,3},{600,6,3,3},{614,10,3.5,3},{626,8,3,2.5},{648,9,3.5,3},{693,8,3,3},{704,10,4,3},{719,7,3,3},{733,9,3.5,3},{768,9,3.5,3.5},{782,8,3,3},{795,10,4,3},{808,8,3,3}}
for k,h in ipairs(H) do
  local x, w, wh, rh = h[1], h[2], h[3], h[4]
  local b = 469.6
  local wall = rect(x, b - wh, w, wh)
  local roof = poly{{x - 0.4, b - wh}, {x + 1.6, b - wh - rh}, {x + w - 1.6, b - wh - rh}, {x + w + 0.4, b - wh}}
  local gable = poly{{x - 0.2, b - wh + 0.2}, {x + 1.6, b - wh - rh}, {x + 3.2, b - wh + 0.2}}
  det(roof - gable, (k % 2 == 0) and roofW or roofD, 0.7)
  det(wall * rect(x, b - wh, 3.2, wh) + gable, (k % 3 == 0) and litH or lit, 0.6)
  det(wall - rect(x, b - wh, 3.2, wh), litH, 0.6)
  -- a dark door/window dot
  r:stroke({{x + rand(4, w-1.5), b - wh + 1}, {x + rand(4, w-1.5), b - wh + 1.8}}, {pressure={0.25,0.25}})
end
print(wait(0))
