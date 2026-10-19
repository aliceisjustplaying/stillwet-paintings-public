local m = MAN_COAT + MAN_COLLAR
local coatP2 = pile{{"bone black",1},{"Prussian blue",0.15},{"raw umber",0.8},{"green earth",0.5},{"lead white",0.3}, medium=0.06}
local coatL2 = pile{{"bone black",0.5},{"raw umber",0.6},{"green earth",0.6},{"lead white",1.2},{"pale smalt",0.3}, medium=0.06}
work(m, {hand="detail", pile=coatP2, tool={kind="round", width=1.1, point=0.5}, angle=math.pi/2, length={3,10}, coverage=3.5, clip=true, fill=true, edge="found", load=0.9})
local lit = m * mask(function(x,y) return smoothstep(446-5, 446-10, x) end)
work(lit, {hand="detail", pile=coatL2, tool={kind="round", width=0.9, point=0.5}, angle=math.pi/2, length={4,12}, coverage=1.4, clip=true, load=0.7})
-- fold lines
local r = brush{kind="rigger", width=0.7, point=1}
r:load(pile{{"bone black",1},{"raw umber",0.4}}, 0.4)
r:stroke({{444,500},{443.5,520},{443,533}}, {pressure={0.3,0.1}})
r:stroke({{450,505},{451,522},{452,532}}, {pressure={0.3,0.1}})
-- the woman's arm linked: a sleeve line
print(wait(0))
