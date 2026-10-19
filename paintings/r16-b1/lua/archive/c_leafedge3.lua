local R = rect(40, 215, 120, 100)
local clump = (foliM:grow(6)) * R - oakM2
local top = clump * mask(function(x, y) local cy = 245 + (x - 40) * 0.25; return y < cy + 18 and 1 or 0 end)
stipple(clump, {pile=foliMidP, width=2.2, coverage=0.8, cluster={0.5, 5}, pressure={0.3, 0.7}, feather=0.3, seed=911})
stipple(top, {pile=foliLight, width=2.0, coverage=0.7, cluster={0.5, 5}, pressure={0.3, 0.65}, feather=0.4, seed=912})
local pz = (ellipse(307, 362, 7, 7) + ellipse(328, 371, 7, 7)) * oakM2 - foliM:shrink(1)
work(pz, {hand="detail", pile=barkD, coverage=4, fill=true, clip=true, length={2,6}})
