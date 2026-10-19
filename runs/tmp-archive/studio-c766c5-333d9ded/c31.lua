plight = pile{{"lead white",3},{"chrome yellow",2}}
pdarkL = pile{{"yellow ochre",2},{"raw umber",1},{"green earth",0.8},{"smalt",0.3}}
-- model the two lemons in the bowl
local function model(m, cx, cy, rx, ry, seed)
  local lit = grad(cx,cy,rx,ry,-0.75,-0.66,0.55,1.0)
  local shad = grad(cx,cy,rx,ry,0.75,0.66,0.45,0.95)
  work(m * lit, {hand="body", pile=plight, clip=true, coverage=1.8, angle=0.9, seed=seed})
  work(m * shad, {hand="body", pile=pdarkL, clip=true, coverage=1.9, angle=0.9, seed=seed+1})
end
model(lemA, 600, 498, 60, 46, 251)
model(lemB, 700, 504, 54, 42, 253)
-- occlusion where the lemons meet and under them
pm = pile{{"raw umber",2},{"smalt",1.2},{"lead white",1.5}}
occl = ((ellipse(654,500,14,50) + ellipse(600,548,66,16) + ellipse(700,554,58,15)):soften(10)) * (lemA + lemB)
work(occl, {hand="body", pile=pm, clip=true, coverage=2.0, seed=255})
-- contact shadow on the bowl floor
floor = ((ellipse(600,556,70,15) + ellipse(700,562,58,14)):soften(8)) * open_in
work(floor, {hand="body", pile=pm, clip=true, coverage=1.8, seed=256})
