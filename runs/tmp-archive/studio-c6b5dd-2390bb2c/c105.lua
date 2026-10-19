local cl = nil
local xs = uneven(22, 480, 1000, 0.8, 0.8, 221)
for i, x in ipairs(xs) do
  local h = rand(3, 11)
  local w = rand(5, 16)
  local m = ellipse(x, 448 - h*0.5, w, h):roughen(2, 5, 230+i, 0)
  cl = cl and (cl + m) or m
end
distClumps = cl * above(function(x) return 452 end)
pFar2 = pile{{"lead white",1.2},{"smalt",1},{"raw umber",1.4},{"green earth",0.5},{"red earth",0.25}}
stipple(distClumps, {pile=pFar2, width=2.5, coverage=3, pressure={0.5,0.8}, dips={20,0.8,0.2}, drag={1.2, 0.5}, twist=0.6, clip=distClumps:grow(1)})
