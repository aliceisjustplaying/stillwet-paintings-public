-- chamber openings, irregular
local g1 = poly({{584,468},{590,466},{603,468},{606,478},{604,490},{586,491},{583,480}}, true)
local g2 = poly({{628,469},{640,467},{652,469},{653,480},{651,490},{629,490},{627,480}}, true)
local g3 = poly({{677,468},{688,466},{697,467},{697,479},{696,490},{678,490},{676,480}}, true)
work(g1+g2+g3, {hand="detail", pile=rkK, coverage=5, fill=true, angle=0, load=1, pressure={0.7,0.95}})
-- uprights: darker body, then granite speckle
work(UPM, {hand="detail", pile=rkD2, coverage=3, fill=true, angle=math.pi/2, load=1, pressure={0.6,0.9}})
-- capstone rock face
work(CAPM, {hand="detail", pile=rkD2, coverage=3, fill=true, angle=0.06, load=1, pressure={0.6,0.9}})
