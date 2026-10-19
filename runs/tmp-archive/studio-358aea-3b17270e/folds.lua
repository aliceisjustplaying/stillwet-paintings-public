-- folds and a half-belt on the man's greatcoat; folds in the woman's dress and shawl
local mx, wx = 446, 470
local r = brush{kind="round", width=0.8, point=0.7}
local dark = pile{{"bone black",1},{"raw umber",0.6},{"Prussian blue",0.1},{"lead white",0.05}, medium=0.1}
local ridge = pile{{"bone black",0.5},{"raw umber",0.6},{"green earth",0.6},{"lead white",1.0},{"pale smalt",0.3}, medium=0.1}
-- back vent, from the half-belt to the hem
r:load(dark, 0.4)
r:stroke({{mx+0.3,510},{mx+0.1,522},{mx-0.4,534}}, {pressure={0.35,0.5}, clip=MAN_COAT})
-- half-belt across the small of the back
local belt = poly({{mx-7,505},{mx+7.5,505},{mx+7.5,507.2},{mx-7,507.2}}) * MAN_COAT
work(belt, {hand="detail", pile=dark, tool={kind="round", width=0.7, point=0.6}, angle=0, length={2,5}, coverage=2, clip=true, load=0.5})
-- lit ridges of the skirt folds, on the left (lit) side and a fainter one right
r:reload(ridge, 0.35)
r:stroke({{mx-4.5,508},{mx-6.5,520},{mx-8.5,533}}, {pressure={0.3,0.45}, clip=MAN_COAT})
r:reload(ridge, 0.25)
r:stroke({{mx+4,509},{mx+5.5,521},{mx+7,532}}, {pressure={0.2,0.35}, clip=MAN_COAT})
r:reload(ridge, 0.3)
r:stroke({{mx-6,480},{mx-7,490},{mx-6.5,500}}, {pressure={0.25,0.3}, clip=MAN_COAT})
-- two buttons on the belt
local e = brush{kind="round", width=0.6, point=0.9}
e:load(pile{{"lead white",1},{"raw umber",0.6},{"yellow ochre",0.4}, medium=0.05}, 0.3)
e:touch(mx-2.2, 506.1, {pressure=0.3}); e:touch(mx+2.6, 506.1, {pressure=0.3})
-- woman: shadow folds falling from the waist and spreading to the hem
local dshade = pile{{"red earth",0.8},{"raw umber",1},{"bone black",0.35},{"lead white",0.1}, medium=0.1}
local dlit = pile{{"red earth",1},{"raw umber",0.3},{"vermilion",0.2},{"lead white",0.8},{"yellow ochre",0.3}, medium=0.1}
local WD = poly({{wx-6.5,484},{wx-7.5,500},{wx-9.5,520},{wx-12,545},{wx-13.5,561},{wx-2,562.5},{wx+8,562},{wx+13.5,560},{wx+11.5,544},{wx+9,520},{wx+7.5,500},{wx+6.5,484}}, true)
r:reload(dshade, 0.4)
r:stroke({{wx-2.5,508},{wx-4,530},{wx-5.5,560}}, {pressure={0.25,0.6}, clip=WD})
r:reload(dshade, 0.4)
r:stroke({{wx+3,506},{wx+4.5,530},{wx+6.5,560}}, {pressure={0.25,0.6}, clip=WD})
r:reload(dshade, 0.3)
r:stroke({{wx+7,520},{wx+9.5,545},{wx+11,559}}, {pressure={0.2,0.5}, clip=WD})
r:reload(dlit, 0.35)
r:stroke({{wx-0.5,509},{wx-1,532},{wx-1.5,560}}, {pressure={0.2,0.45}, clip=WD})
r:reload(dlit, 0.35)
r:stroke({{wx-6,512},{wx-8.5,535},{wx-10,559}}, {pressure={0.2,0.45}, clip=WD})
-- shawl: two soft folds converging to its point
r:reload(shawlS, 0.3)
r:stroke({{wx+4.5,485},{wx+2.5,495},{wx+0.6,504}}, {pressure={0.3,0.2}, clip=W_SHAWL})
r:reload(shawlS, 0.2)
r:stroke({{wx-3,486},{wx-1.8,496},{wx-0.4,503}}, {pressure={0.2,0.15}, clip=W_SHAWL})
print(wait(0))
