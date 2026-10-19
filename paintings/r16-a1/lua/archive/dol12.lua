-- widen the left gap into a leaning wedge
local w1 = poly({{586,474},{588,472},{588,489},{577,490},{582,482}}, true)
work(w1 * above(function(x) return 479 end), {hand="detail", pile=dist2, coverage=4, fill=true, load=1, pressure={0.5,0.8}, tool={kind="round", width=1.3, point=0.5}})
work(w1 * below(function(x) return 479 end), {hand="detail", pile=crest, coverage=4, fill=true, load=1, pressure={0.5,0.8}, tool={kind="round", width=1.3, point=0.5}})
-- narrow the right opening: rock back over its right half, leaning
local r3 = poly({{689,471},{695,471},{696,489},{684,489},{687,480}}, true)
work(r3, {hand="detail", pile=rkA, coverage=4, fill=true, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.3, point=0.5}})
-- a thin sliver of light under the capstone at the right
local sl = poly({{703,467.5},{716,466.5},{717,468.5},{704,469.5}}, true)
work(sl, {hand="detail", pile=dist1, coverage=4, fill=true, load=1, pressure={0.4,0.7}, tool={kind="round", width=1, point=0.8}})
-- a fallen stone inside the middle opening, half in snow
local fs = poly({{634,489},{636,483},{641,481},{646,483},{648,489}}, true)
work(fs, {hand="detail", pile=rkA, coverage=4, fill=true, load=1, pressure={0.6,0.9}, tool={kind="round", width=1.2, point=0.5}})
