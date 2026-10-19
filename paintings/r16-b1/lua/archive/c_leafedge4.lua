local R = rect(40, 215, 120, 100)
local ring = (foliM:grow(7) - foliM:shrink(4)) * R - oakM2
stipple(ring, {pile=foliMidP, width=2.0, coverage=0.9, cluster={0.5, 4}, pressure={0.3, 0.7}, seed=921})
local topring = ring * mask(function(x, y) local cy = 245 + (x - 40) * 0.25; return y < cy + 12 and 1 or 0 end)
stipple(topring, {pile=foliLight, width=1.8, coverage=0.8, cluster={0.5, 4}, pressure={0.3, 0.65}, seed=922})
local pz = ellipse(307, 362, 7, 7) + ellipse(329, 372, 7, 8)
print(pz:area(), (pz*oakM2):area(), (pz*foliM):area())
work(pz * (oakM2 + foliM) , {hand="detail", pile=barkD, coverage=4, fill=true, clip=true, length={2,6}})
