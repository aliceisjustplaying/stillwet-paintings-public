local R = rect(38, 212, 125, 100)
local cl = foliM:grow(6) * R - oakM2
local topf = cl * mask(function(x, y) local cy = 240 + (x - 40) * 0.22; return y < cy + 16 and 1 or 0 end)
stipple(cl, {pile=foliMidP, width=2.0, coverage=0.7, cluster={0.5, 5}, pressure={0.35, 0.7}, feather=0, seed=951})
stipple(topf, {pile=foliLight, width=1.9, coverage=0.8, cluster={0.5, 5}, pressure={0.3, 0.65}, feather=0, seed=952})
local edge = foliM:grow(4) * rect(140, 225, 40, 75) - oakM2
stipple(edge, {pile=foliMidP, width=2.0, coverage=1.0, cluster={0.5, 5}, pressure={0.35, 0.7}, feather=0, seed=953})
stipple(edge, {pile=foliLight, width=1.8, coverage=0.4, cluster={0.5, 5}, pressure={0.3, 0.6}, feather=0, seed=954})
