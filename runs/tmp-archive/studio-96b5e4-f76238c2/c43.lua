fig = pile{{"raw umber",1},{"bone black",0.5},{"red earth",0.15}, medium=0.1}
local r1 = brush{kind="round", width=1.6, point=0.8}
local r2 = brush{kind="round", width=1.0, point=1}
-- hull: slightly curved, low
r1:load(fig, 0.8)
r1:stroke({{570,456.2},{578,457.6},{590,457.8},{600,456.6},{603,455.2}}, {pressure={0.9,0.8}, ramps={0.05,0.1}})
r1:load(fig, 0.8)
r1:stroke({{572,457.5},{588,458.8},{600,457.6}}, {pressure={0.7,0.5}, ramps={0.05,0.2}})
-- figure standing near the stern (right), coat
r1:load(fig, 0.8)
r1:stroke({{594.2,442.5},{594.4,447},{594.6,451},{594.8,455.5}}, {pressure={0.95,0.8}, ramps={0.02,0.05}, swell={1,1.3,1.4,1.2}})
r2:load(fig, 0.8)
r2:stroke({{593.4,450},{593.2,455.6}}, {pressure={0.8,0.7}})
r2:stroke({{595.8,450},{596.2,455.6}}, {pressure={0.8,0.7}})
-- head and hat
r1:load(fig, 0.8)
r1:touch(594.3, 440.6, {pressure=0.7})
r2:load(fig, 0.6)
r2:stroke({{592.8,439.6},{595.8,439.4}}, {pressure={0.6,0.5}})
-- arms and pole (pole leaning forward-left into water)
r2:load(fig, 0.7)
r2:stroke({{594.3,444},{592.2,446.5},{591.2,447.2}}, {pressure={0.7,0.5}})
r2:stroke({{594.5,444.2},{596.5,442.8},{597.2,441.8}}, {pressure={0.7,0.5}})
r2:load(fig, 0.7)
r2:stroke({{599.5,434},{595,443},{589,455},{587,459.5}}, {pressure={0.5,0.35}, ramps={0.1,0.2}})
-- a second seated figure at the bow (small hump)
r1:load(fig, 0.7)
r1:stroke({{577.5,452.5},{577.8,455.5}}, {pressure={0.9,0.9}, swell={1,1.4}})
r1:touch(577.6, 451.2, {pressure=0.55})
-- reflection in the water beneath the boat, broken
local r3 = brush{kind="flat", width=1.2}
r3:load(pile{{"raw umber",1},{"bone black",0.3},{"smalt",0.3},{"lead white",0.4}, medium=0.2}, 0.5)
for i=1,5 do local y = 459.5 + i*0.9; r3:stroke({{574 + rand(-2,2), y},{598 + rand(-2,2), y}}, {pressure={0.4,0.2}}) end
