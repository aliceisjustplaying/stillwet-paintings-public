-- a leafy bough hiding the blunt end of the right-hand limb
local bough = (poly({{312,428},{330,422},{350,428},{366,438},{372,450},{360,458},{340,456},{322,452},{310,444}}, true)):roughen(3, 8, 51)
bough = bough + ellipse(305,432,12,9):roughen(2.5,7,52)
boughM = bough
local nz = noise{seed=3401, octaves=3, period=7}
stipple(bough, {pile=fd, width=3.2, coverage=1.6, pressure={0.4,0.8}, cluster={0.5,4}, feather=0.4, dips={18,0.6,0.2}, seed=3402})
local fr = (bough:grow(6) - bough:shrink(2)) * mask(function(x,y) return clamp(0.4 + nz(x,y)*1.2, 0, 1) end)
stipple(fr, {pile=fd, width=2.2, coverage=0.8, pressure={0.3,0.7}, drag={1.3,1.2}, twist=0.6, cluster={0.7,3}, feather=0.7, seed=3403})
