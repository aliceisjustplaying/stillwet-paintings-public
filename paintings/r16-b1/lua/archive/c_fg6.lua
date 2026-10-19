flare2 = poly({{262,598},{276,590},{286,578},{290,560},{292,548},{314,548},{316,560},{320,578},{332,590},{348,598},{336,601},{318,597},{300,600},{284,598},{270,602}}, true):roughen(1.2, 5, 43)
local halo = ellipse(305, 585, 60, 22) - flare2
work(halo, {hand="detail", pile=bankTop, coverage=3, fill=true, angle=-1.4, length={4,10}})
work(flare2, {hand="detail", pile=barkD, coverage=3, fill=true, angle=-1.5, length={4,10}})
-- a couple of surface roots
rig:reload(barkD, 0.8)
rig:stroke({{280,592},{266,597},{252,600}}, {pressure={rig:pressure_for(4), rig:pressure_for(0.8)}})
rig:stroke({{330,592},{345,598},{360,601}}, {pressure={rig:pressure_for(4), rig:pressure_for(0.8)}})
