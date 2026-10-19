cb = pile{{"lead white",2.2},{"smalt",0.6},{"red earth",0.22},{"raw umber",0.3},{"vermilion",0.04}, medium=0.2}
cbh = pile{{"lead white",2.6},{"cobalt blue",0.35},{"smalt",0.35},{"raw umber",0.25},{"red earth",0.1}, medium=0.2}
cg = pile{{"lead white",4},{"vermilion",0.22},{"chrome yellow",0.35},{"yellow ochre",0.1}, medium=0.15}
function streak(b, pl, x, y, len, load, pr, bow)
  b:reload(pl, load)
  local n = 6; local pts = {}
  for i=0,n do local t=i/n; pts[#pts+1] = {x + len*t, y + (bow or 0)*math.sin(t*math.pi) + randn(0,0.6)} end
  b:stroke(pts, {pressure={pr, pr*0.6}, ramps={0.25,0.4}, swell={0.8,1.1,1,0.7}})
end
local fb = brush{kind="filbert", width=7, stiffness=0.4}
local fs = brush{kind="filbert", width=4, stiffness=0.4}
-- bank A bodies (upper right)
for i=1,26 do
  local x = rand(330, 900); local y = rand(142, 182) - (x-330)*0.02
  streak(fb, cb, x, y, rand(60, 180), rand(0.35,0.55), rand(0.35,0.6), rand(-3,3))
end
-- bank A gold undersides
for i=1,18 do
  local x = rand(360, 940); local y = rand(180, 196) - (x-330)*0.02
  streak(fs, cg, x, y, rand(40, 140), rand(0.35,0.5), rand(0.3,0.5), rand(-2,2))
end
-- upper-left high clouds
for i=1,24 do
  local x = rand(-40, 560); local y = rand(35, 95) + (x)*0.015
  streak(fb, cbh, x, y, rand(70, 200), rand(0.3,0.5), rand(0.3,0.55), rand(-4,4))
end
for i=1,12 do
  local x = rand(-20, 520); local y = rand(90, 106) + (x)*0.015
  streak(fs, cg, x, y, rand(40, 130), rand(0.3,0.45), rand(0.25,0.45), rand(-2,2))
end
-- mid-left streak
for i=1,14 do
  local x = rand(-30, 380); local y = rand(270, 292)
  streak(fs, cb, x, y, rand(60, 160), rand(0.35,0.5), rand(0.35,0.55), rand(-2,2))
end
for i=1,8 do
  local x = rand(0, 400); local y = rand(292, 300)
  streak(fs, cg, x, y, rand(40, 110), rand(0.3,0.45), rand(0.3,0.45), rand(-1,1))
end
