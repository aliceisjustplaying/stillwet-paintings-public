local s = (oakM2:grow(5) - oakM2:grow(0.3)) * rect(312, 436, 20, 40) - foliM
local A = s * mask(function(x, y) return y < flatY(x) - 0.5 and 1 or 0 end)
local B = s * mask(function(x, y) return (y >= flatY(x) - 0.5 and y < 454) and 1 or 0 end)
local C = s * mask(function(x, y) return y >= 454 and 1 or 0 end)
work(A, {hand="detail", pile=hillMist, angle=0, coverage=3, fill=true, clip=true, length={2,5}})
work(B, {hand="detail", pile=farMist, angle=0, coverage=3, fill=true, clip=true, length={2,5}})
work(C, {hand="detail", pile=nearMist3, angle=0, coverage=3, fill=true, clip=true, length={2,5}})
