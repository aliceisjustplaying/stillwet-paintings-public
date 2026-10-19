t_far2 = pile{{"lead white",1.3},{"smalt",0.5},{"raw umber",0.45},{"red earth",0.2},{"vermilion",0.03},{"green earth",0.2}, medium=0.1}
local fl = farline * rect(470, 415, 300, 32) - creek:grow(0.5)
work(fl, {hand="detail", pile=t_far2, angle=0, coverage=2.5, length={4,12}, tool={kind="round", width=2.2, point=0.4}, fill=true, clip=true})
work(treesR * rect(735, 380, 70, 70), {hand="detail", pile=t_mid, angle=-1.3, coverage=2.2, length={4,10}, tool={kind="round", width=2.5, point=0.3}, fill=true, clip=true})
local r1 = brush{kind="round", width=1.6, point=0.8}
local r2 = brush{kind="round", width=1.0, point=1}
r1:load(fig, 0.8)
r1:stroke({{594.2,442.5},{594.4,447}}, {pressure={0.95,0.9}, ramps={0.02,0.05}})
r1:load(fig, 0.8)
r1:touch(594.3, 440.6, {pressure=0.7})
r2:load(fig, 0.6)
r2:stroke({{592.8,439.6},{595.8,439.4}}, {pressure={0.6,0.5}})
r2:load(fig, 0.7)
r2:stroke({{599.5,434},{595,443}}, {pressure={0.5,0.45}, ramps={0.1,0.05}})
r2:stroke({{594.5,444.2},{596.5,442.8},{597.2,441.8}}, {pressure={0.7,0.5}})
