ROCKBAND = (CAPM:grow(1.5) + UPM) * mask(function(x,y) local b = capbot(x); if not b then return 0 end; return (y > b + 0.4) and 1 or 0 end)
work(ROCKBAND, {hand="detail", pile=rkA, coverage=3.5, fill=true, angle=0.1, load=1, pressure={0.6,0.9}, tool={kind="round", width=2, point=0.5}})
local n = noise{seed=9, period=14, octaves=3}
stipple(ROCKBAND, {pile=rkB, width=2.5, coverage=function(x,y) return 0.7*clamp(n(x,y)+0.1,0,1) end, pressure={0.35,0.6}})
-- slab: solid dark, then one lighter upper-left facet
local slabS = poly({{740,474},{744,466},{749,459},{762,457},{770,462},{768,465},{760,462},{751,463},{746,469},{743,476}}, true)
local sb = SLAB:mask() - slabS:grow(0.5)
work(sb, {hand="detail", pile=rkA, coverage=4, fill=true, angle=0, load=1, pressure={0.6,0.9}, tool={kind="round", width=2, point=0.5}})
local facet = sb * poly({{744,478},{750,466},{760,464},{768,468},{765,480},{754,490},{745,490}})
work(facet, {hand="detail", pile=rkB, coverage=2.5, fill=true, angle=0.3, load=0.9, pressure={0.5,0.8}, tool={kind="round", width=2, point=0.5}})
