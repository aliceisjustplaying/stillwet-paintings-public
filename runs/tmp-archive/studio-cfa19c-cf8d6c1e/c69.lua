local region = rect(90,380,340,150)
local limbs = (oakM * region + trunkM*rect(200,460,100,60)) - oakSil:shrink(1)
local litB = pile{{"lead white",1.8},{"raw umber",0.9},{"yellow ochre",0.9},{"bone black",0.08}, medium=0.05}
local b = brush{kind="round", width=2.0, point=0.6}
local paths = {
  {{226,382},{226,400},{228,420},{230,442}},
  {{224,458},{216,446},{209,432},{203,421}},
  {{252,451},{255,438},{259,424},{262,413}},
  {{271,463},{283,452},{300,442},{317,434},{333,428}},
  {{235,472},{234,490},{234,505},{233,520}},
}
for i,p in ipairs(paths) do
  b:reload(litB, 0.6)
  b:stroke(p, {pressure={0.55,0.35}, ramps={0.1,0.3}, shake=0.4, clip=limbs})
  b:reload(litB, 0.4)
  -- a second broken touch alongside, for bark texture
  local q = {}
  for j,pt in ipairs(p) do q[#q+1] = {pt[1] + rand(1,2), pt[2] + rand(-1,1)} end
  b:stroke(q, {pressure={0.3,0.15}, ramps={0.2,0.4}, shake=0.8, clip=limbs})
end
