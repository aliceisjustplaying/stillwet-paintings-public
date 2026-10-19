local nz = noise{seed=3611, octaves=3, period=5}
local h4 = poly({{288,305},{300,292},{312,300},{308,322},{296,332},{288,320}}, true):grow(2)
local keep4 = poly({{298,300},{307,302},{306,318},{299,324},{295,312}}, true):roughen(1.5,4,63)
local h1 = poly({{262,178},{270,166},{283,160},{292,166},{290,178},{280,186},{268,187}}, true):grow(2)
local keep1 = poly({{272,170},{284,165},{289,172},{281,181},{271,180}}, true):roughen(1.5,4,64)
stipple((h4 - keep4) + (h1 - keep1), {pile=fd, width=2.5, coverage=1.6, pressure={0.4,0.8}, drag={1.2,-1.0}, twist=0.5, cluster={0.5,3}, feather=0.5, seed=3612})
-- a few mid-green leaves on the new closures where the light reaches
stipple(((h4 - keep4) + (h1 - keep1)) * mask(function(x,y) return clamp(0.2 + nz(x,y), 0, 1) end), {pile=fmd, width=2.2, coverage=0.4, pressure={0.3,0.6}, drag={1.0,-0.8}, cluster={0.6,3}, feather=0.6, seed=3613})
