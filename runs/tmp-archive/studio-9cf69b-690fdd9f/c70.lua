local fx, fy = FX, FY
local r = brush{kind="round", width=1.6, point=1}
-- the stick, restated dark and firm, planted in the snow
r:load(coatP, 0.8)
r:stroke({{fx-9.4,fy-21.5},{fx-10.5,fy-10},{fx-11.4,fy+0.5}}, {pressure={0.75,0.7}})
-- the hand on the stick
local hand = ellipse(fx-9.2, fy-20.4, 1.3, 1.5)
work(hand, {hand="detail", pile=coatP, coverage=3, pressure={0.5,0.8}, load=0.8, fill=true, tool={kind="round", width=1}})
-- cool light from the upper sky along the hat and the left shoulder
local rim = pile{{"lead white",4},{"pale smalt",2},{"smalt",0.5},{"raw umber",0.3}, medium=0.08}
r:load(rim, 0.5)
r:stroke({{fx-3.2,fy-41.6},{fx-0.5,fy-42.9},{fx+2.4,fy-42.6}}, {pressure={0.22,0.1}})
r:stroke({{fx-5.6,fy-31.8},{fx-3,fy-33.8},{fx-0.5,fy-34.2}}, {pressure={0.2,0.08}})
-- the fold down the back of the coat, and the belt
r:load(chamber, 0.5)
r:stroke({{fx+0.8,fy-30},{fx+1.2,fy-20},{fx+1.6,fy-8}}, {pressure={0.25,0.1}})
r:stroke({{fx-6.2,fy-21.5},{fx,fy-21},{fx+6.4,fy-21.6}}, {pressure={0.22,0.15}})
-- a little snow kicked up at his boots and the shadow he stands in
local base = ellipse(fx, fy + 0.8, 8.5, 1.6) - figM
work(base, {hand="detail", pile=printDeep, coverage=2.5, pressure={0.4,0.7}, load=0.6, fill=true, angle=0, tool={kind="round", width=1.2}})
