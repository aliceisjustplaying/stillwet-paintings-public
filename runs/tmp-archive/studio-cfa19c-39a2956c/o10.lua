local nz = noise{seed=3601, octaves=3, period=6}
-- close the left and lower-left openings to small irregular chinks, break the rest
local c1 = poly({{188,248},{200,238},{215,240},{222,250},{210,258},{195,258}}, true):grow(2) - ellipse(214,250,5,3):roughen(1.5,4,61)
local c2 = poly({{210,318},{222,302},{240,300},{248,312},{240,326},{222,330}}, true):grow(2) - poly({{226,312},{236,306},{242,312},{234,318}}, true):roughen(1.5,4,62)
local c3 = (oakHoles:grow(1) - oakHoles:shrink(4)) * mask(function(x,y) return clamp(0.3 + 1.4*nz(x,y), 0, 1) end)
stipple(c1 + c2, {pile=fd, width=2.6, coverage=1.8, pressure={0.4,0.8}, drag={1.2,-1.0}, twist=0.5, cluster={0.4,3}, feather=0.4, seed=3602})
stipple(c3, {pile=fd, width=2.4, coverage=1.0, pressure={0.3,0.7}, drag={1.4,-1.1}, twist=0.7, cluster={0.7,3}, feather=0.6, seed=3603})
