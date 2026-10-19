-- Oak rework: close the small gaps between clumps into larger masses, keep a few deliberate openings
oakHoles = poly({{262,178},{270,166},{283,160},{292,166},{290,178},{280,186},{268,187}}, true)
  + poly({{188,248},{200,238},{215,240},{222,250},{210,258},{195,258}}, true)
  + poly({{210,318},{222,302},{240,300},{248,312},{240,326},{222,330}}, true)
  + poly({{288,305},{300,292},{312,300},{308,322},{296,332},{288,320}}, true)
  + poly({{316,254},{326,240},{340,238},{344,250},{334,262},{320,264}}, true)
oakHoles = oakHoles:roughen(2.5, 9, 41)
oakFork = poly({{205,475},{212,420},{228,388},{250,376},{285,388},{302,420},{312,475}}, true)
oakNew = (oakSil:grow(14):shrink(14)):roughen(4, 16, 42) + oakSil
oakNew = oakNew - oakHoles - (oakFork - oakSil)
local gapFill = oakNew - oakSil:shrink(3)
print(gapFill:area(), oakNew:area())
stipple(gapFill, {pile=fd, width=4.5, coverage=1.7, pressure={0.45,0.85}, cluster={0.4,5}, feather=0.3, dips={20,0.7,0.2}, clip=oakNew:grow(1.5), seed=2001})
local nz = noise{seed=2002, octaves=3, period=10}
local edgeLace = (oakNew:grow(6) - oakNew:shrink(2)) - oakHoles:shrink(2) - oakFork
stipple(edgeLace, {pile=fd, width=3, coverage=function(x,y) return clamp(0.3 + 0.7*oakNew:at(x,y) + 0.7*nz(x,y), 0, 1.3) end, pressure={0.35,0.75}, drag={1.2,-1.0}, twist=0.5, cluster={0.65,5}, feather=0.8, dips={16,0.6,0.2}, seed=2003})
