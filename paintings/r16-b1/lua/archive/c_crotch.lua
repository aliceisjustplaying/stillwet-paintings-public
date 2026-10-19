local pz = (ellipse(307, 362, 10, 10) + ellipse(329, 372, 10, 11)) - oakM2:shrink(0.5)
stipple(pz, {pile=foliDark, width=2.2, coverage=1.2, cluster={0.5, 4}, pressure={0.4, 0.8}, feather=0, seed=961})
stipple(pz, {pile=foliMidP, width=2.0, coverage=1.3, cluster={0.5, 4}, pressure={0.4, 0.8}, feather=0, seed=962})
stipple(pz * rect(290, 345, 60, 20), {pile=foliLight, width=1.8, coverage=0.6, cluster={0.5, 4}, pressure={0.3, 0.6}, feather=0, seed=963})
-- bark inside the circles: small rim-lit edge on the right limb
local ib = (ellipse(307, 362, 10, 10) + ellipse(329, 372, 10, 11)) * oakM2:shrink(0.5)
work(ib, {hand="detail", pile=barkD, angle=-1.3, coverage=1.5, clip=true, length={3,8}, pressure={0.3,0.6}})
