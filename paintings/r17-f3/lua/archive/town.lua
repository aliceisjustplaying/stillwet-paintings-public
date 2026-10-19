local roofR = pile{{"lead white",2.6},{"red earth",0.35},{"smalt",0.6},{"raw umber",0.1}, medium=0.08}
local wallL = pile{{"lead white",4},{"pale smalt",0.7},{"yellow ochre",0.12}, medium=0.08}
local wallS = pile{{"lead white",2.2},{"smalt",0.9},{"bone black",0.12}, medium=0.08}
local treeH = pile{{"lead white",2.2},{"green earth",0.9},{"smalt",0.8},{"raw umber",0.1}, medium=0.08}
local det = function(m, p, w) work(m, {hand="detail", pile=p, tool={kind="round", width=w or 0.8, point=0.5}, angle=math.pi/2, length={2,5}, coverage=2.5, clip=true, fill=true, edge="found", load=0.7}) end
-- trees at the town's edges and between houses, hazy
local tr = nil
for _,c in ipairs({{540,462,9,6},{551,459,7,8},{529,464,6,4},{832,461,8,7},{845,463,9,5},{856,465,6,3},{664,463,5,4},{705,464,4,3}}) do
  local e = ellipse(c[1], c[2], c[3], c[4])
  tr = tr and (tr + e) or e
end
tr = (tr * above(function(x) return 468.5 end)):roughen(1.2, 3, 7801)
stipple(tr, {pile=treeH, width=1.4, coverage=3, pressure={0.5,0.8}, cluster=0.3, clip=tr})
-- low houses along the foot: each a wall and a pitched roof, gable ends to the west lit
local xs = {566, 576, 585, 602, 662, 672, 699, 712, 726, 776, 790, 803}
for k,x in ipairs(xs) do
  local w = rand(6, 10); local wh = rand(3, 5); local rh = rand(3, 5.5)
  local base = 468.5
  local wall = rect(x, base - wh, w, wh)
  local roof = poly{{x - 0.5, base - wh}, {x + 1.5, base - wh - rh}, {x + w - 1.5, base - wh - rh}, {x + w + 0.5, base - wh}}
  local gable = poly{{x, base - wh}, {x + 1.5, base - wh - rh}, {x + 3, base - wh}}
  det(roof - gable, roofR, 0.7)
  det(wall, (k % 3 == 0) and wallS or wallL, 0.7)
  det(gable, wallL, 0.6)
end
-- a far post mill on the horizon, right
local mc = pile{{"lead white",2.4},{"smalt",0.8},{"raw umber",0.2}, medium=0.08}
det(rect(884, 459, 4, 6), mc, 0.7)
det(poly{{885,465},{887,465},{888,468.5},{884,468.5}}, mc, 0.5)
local rb = brush{kind="rigger", width=0.45, point=1}
rb:load(mc, 0.5)
rb:stroke({{879,455},{893,469}}, {pressure={0.45,0.45}})
rb:stroke({{893,455},{879,469}}, {pressure={0.45,0.45}})
print(wait(0))
