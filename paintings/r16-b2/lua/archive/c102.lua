local nz = noise{seed=1021, period=6, octaves=2}
local C = ellipse(338,430,11,17) + ellipse(352,432,9,13) + ellipse(365,437,8,9) + ellipse(328,428,8,14)
C = C - TOWN2:grow(0.5)
work(C, {hand="detail", pile=gdeep, tool={kind="round", width=1.2, point=0.6}, angle=-1.2, angle_jitter=0.9, coverage=4, fill=true, length={2,5}, seed=1022})
