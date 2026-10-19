town2 = pile{{"smalt",2},{"lead white",2.2},{"raw umber",1},{"vermilion",0.1}, medium=0.3}
far2 = pile{{"pale smalt",2},{"green earth",1},{"raw umber",0.9},{"lead white",2}, medium=0.3}
-- town trees
TTREES = ellipse(352,440,9,7) + ellipse(364,437,8,9) + ellipse(338,442,10,5) + ellipse(655,438,10,8) + ellipse(672,441,12,6) + ellipse(690,443,10,4)
  + ellipse(250,442,22,4) + ellipse(870,442,30,4) + ellipse(930,443,20,3)
TTREES = TTREES:roughen(1.5, 6, 191)
work(FAR, {hand="detail", pile=far2, angle=0, coverage=3, fill=true, length={10,30}, seed=191})
work(TOWN + MILLB, {hand="detail", pile=town2, angle=math.pi/2, coverage=3.5, fill=true, length={4,12}, seed=192})
work(TTREES, {hand="detail", pile=far2, angle=0, coverage=3, fill=true, length={4,10}, seed=193})
-- sails
sb = brush{kind="round", width=1.2, point=0.6}
for _,m in ipairs({{712,420,0.35,15},{794.5,423,0.85,13}}) do
  for k=0,3 do
    local a = m[3] + k*math.pi/2
    sb:load(town2, 0.5)
    sb:stroke({{m[1]+2*math.cos(a), m[2]+2*math.sin(a)},{m[1]+m[4]*math.cos(a), m[2]+m[4]*math.sin(a)}}, {pressure={0.45,0.35}})
    -- lattice of the sail: a second parallel line offset
    local ox, oy = -math.sin(a)*2.2, math.cos(a)*2.2
    sb:stroke({{m[1]+5*math.cos(a)+ox, m[2]+5*math.sin(a)+oy},{m[1]+m[4]*math.cos(a)+ox, m[2]+m[4]*math.sin(a)+oy}}, {pressure={0.3,0.25}})
  end
end
