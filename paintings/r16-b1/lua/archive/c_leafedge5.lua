local R = rect(40, 215, 115, 90)
local body = (foliM:grow(4):roughen(2, 4, 931)) * R - oakM2
work(body, {hand="detail", pile=foliDark, coverage=3.5, fill=true, clip=true, length={2,6}})
local fringe = (foliM:grow(9) - foliM:grow(3)) * R - oakM2
stipple(fringe, {pile=foliDark, width=1.6, coverage=0.7, cluster={0.6, 5}, pressure={0.35, 0.7}, feather=0, seed=932})
local topf = (foliM:grow(6)) * R * mask(function(x, y) local cy = 243 + (x - 40) * 0.22; return y < cy + 14 and 1 or 0 end)
stipple(topf, {pile=foliLight, width=1.8, coverage=0.9, cluster={0.5, 5}, pressure={0.3, 0.65}, feather=0, seed=933})
stipple(body * mask(function(x, y) local cy = 243 + (x - 40) * 0.22; return (y > cy + 10 and y < cy + 35) and 1 or 0 end), {pile=foliMidP, width=2, coverage=0.6, cluster={0.5, 5}, pressure={0.3, 0.6}, feather=0, seed=934})
local pz = (ellipse(307, 362, 8, 8) + ellipse(329, 372, 8, 9)) * foliM - oakM2:grow(0.5)
stipple(pz, {pile=foliMidP, width=2, coverage=1.6, cluster={0.5, 4}, pressure={0.4, 0.8}, feather=0, seed=935})
stipple(pz, {pile=foliLight, width=1.8, coverage=0.4, cluster={0.5, 4}, pressure={0.3, 0.6}, feather=0, seed=936})
