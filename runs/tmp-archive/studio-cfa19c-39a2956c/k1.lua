local cut = rect(0,0,1000,414)
local town = townM4:grow(1.5) + townM:grow(1) + townM2:grow(1)
cloudC = (cloud2M:grow(9) * cut) - town
bigF = form{ {body.ellipsoid({790,330,0},{250,130,160})}, light={from={-1,-0.9}, front=0.3, ambient=0.15} }
local big = bigF:lit{soft=0.45}
local bil = cloud2F:lit{soft=0.3}
cloudV = mask(function(x,y) return clamp(0.5*big:at(x,y) + 0.5*bil:at(x,y) - 0.35*smoothstep(372, 408, y), 0, 1) end)
cLz = cloudV:map(function(v) return smoothstep(0.56, 0.64, v) end) * cloudC
cSz = cloudV:map(function(v) return smoothstep(0.40, 0.32, v) end) * cloudC
cMz = cloudC - cLz - cSz
print(cLz:area(), cMz:area(), cSz:area())
