farWood = pile{{"lead white",3},{"pale smalt",2},{"smalt",0.5},{"raw umber",0.35},{"vermilion",0.06}, medium=0.2}
local n = noise{seed=7, period=14, octaves=3}
local n2 = noise{seed=8, period=60, octaves=2}
local topf = function(x)
  local base = 463 - 4*math.max(0, n2(x,0)) 
  if x < 600 then base = base + (600-x)*0.08 end
  return base - 3.5*math.abs(n(x,0))
end
local pts = {}
for x = 560, 1010, 3 do pts[#pts+1] = {x, topf(x)} end
woodM = above({{540,475},{1010,475}}) * below(pts) * rect(560,440,450,40)
work(woodM, {hand="detail", pile=farWood, angle=0, coverage=3, pressure={0.5,0.8}, load=0.8})
stipple(woodM:rim(4, 2) , {pile=farWood, width=2, coverage=0.8, pressure={0.3,0.6}, feather=0.5, cluster=0.4})
