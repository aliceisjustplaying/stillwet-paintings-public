local REG = (HORSES:grow(3) + ellipse(700,534.5,24,4) + ellipse(733,531.5,23,4)) * LAND
HREG = REG
local litC  = pile{{"lead white",1.2},{"yellow ochre",1.7},{"chrome yellow",0.5},{"green earth",0.9},{"Prussian blue",0.12}, medium=0.1}
local mixC = pile{{"lead white",1.0},{"yellow ochre",1.5},{"chrome yellow",0.3},{"green earth",1.1},{"Prussian blue",0.18},{"raw umber",0.1}, medium=0.1}
work(REG, {hand="body", pile=litC, tool="filbert 5", clip=REG, angle=0, length={8,20}, coverage=2.4, fill=true, load=0.8})
work(REG * mask(function(x,y) return y > 527 and 1 or 0 end), {hand="body", pile=mixC, tool="filbert 4", clip=REG, angle=0, length={8,20}, coverage=1.5, fill=true, load=0.7})
-- remove the tiny far cattle
local cows = ellipse(877,478.7,11,2.5) + ellipse(620,479.5,3,2)
local farC = pile{{"lead white",2.2},{"green earth",1.6},{"yellow ochre",0.6},{"pale smalt",0.9},{"Prussian blue",0.03}, medium=0.1}
work(cows * LAND - RIVER:grow(0.3), {hand="detail", pile=farC, tool={kind="round", width=1.2, point=0.5}, angle=0, length={3,8}, coverage=3, clip=true, fill=true})
print(wait(0))
