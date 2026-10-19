local old = (NPATH:grow(5) - FPATH) * above(FGTOP)
local a = old * above(function(x) return 556 end)
local b = old - a
work(a, {hand="body", pile=L2, tool="filbert 5", angle=0, angle_jitter=0.1, coverage=4.5, fill=true, clip=true, length={8,24}, seed=431})
work(b, {hand="body", pile=L3b, tool="filbert 5", angle=0, angle_jitter=0.1, coverage=4.5, fill=true, clip=true, length={8,24}, seed=432})
