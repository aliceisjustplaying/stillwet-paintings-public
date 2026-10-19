local det = function(m, p, w, seed, ang) work(m, {hand="detail", tool={kind="round", width=w or 1.4, point=0.5}, pile=p, angle=ang or math.pi/2, coverage=3, fill=true, seed=seed}) end
-- cast shadows falling right along the slope
local shp = pile{{"green earth", 1.4}, {"raw umber", 1}, {"Prussian blue", 0.08}, {"bone black", 0.1}, medium=0.35}
local s1 = poly({{316, 566}, {330, 566}, {400, 571}, {428, 570}, {402, 568}}, true)
local s2 = poly({{334, 567}, {354, 567}, {430, 574}, {452, 573}, {426, 570}}, true)
SHADOWS = (s1 + s2):soften(1)
det(SHADOWS, shp, 2.2, 5601, 0.05)
-- the man
local legs = poly({{315.5, 545}, {321, 545}, {320.5, 563}, {316.5, 563}}) + poly({{323, 545}, {328.5, 545}, {327.5, 563}, {323.5, 563}})
local boots = ellipse(318.2, 564.6, 2.8, 1.9) + ellipse(325.8, 564.8, 2.8, 1.9)
local coat = poly({{314, 503}, {318, 500.5}, {326, 500.5}, {330.5, 503}, {332, 510}, {331.5, 524}, {330, 530}, {333.5, 546}, {321.5, 548}, {310.8, 546}, {314, 530}, {312.8, 524}, {312.5, 510}}, true)
local collar = poly({{316.5, 501.5}, {322, 499}, {327.5, 501.5}, {326, 504}, {318, 504}}, true)
local head = ellipse(322.2, 495, 3.4, 4.6)
local hat = ellipse(322.4, 490.8, 5.2, 2.1) + ellipse(322.2, 489.6, 4.2, 2.2)
local stick = ribbon({{331.5, 528}, {333.6, 547}, {335.4, 566}}, {1.0, 0.9, 0.8})
MAN = legs + boots + coat + collar + head + hat + stick
local coatp = pile{{"bone black", 0.8}, {"Prussian blue", 0.12}, {"raw umber", 0.6}, {"green earth", 0.4}, {"lead white", 0.12}, medium=0.08}
local trou = pile{{"raw umber", 0.6}, {"lead white", 0.55}, {"yellow ochre", 0.25}, {"bone black", 0.05}, medium=0.08}
local blk = pile{{"bone black", 1}, {"raw umber", 0.4}, medium=0.08}
local hair = pile{{"raw umber", 1}, {"bone black", 0.25}, {"red earth", 0.1}, medium=0.08}
det(legs, trou, 1.3, 5602)
det(boots, blk, 1.2, 5603, 0)
det(coat, coatp, 1.6, 5604)
det(head, hair, 1.2, 5605)
det(hat, blk, 1.2, 5606, 0)
det(stick, pile{{"raw umber", 1}, {"red earth", 0.2}, {"lead white", 0.2}, medium=0.08}, 0.8, 5607)
-- the woman
local skirt = poly({{336, 509}, {348.5, 509}, {350.5, 516}, {352.5, 540}, {355.5, 566.5}, {343, 568}, {331.5, 566.5}, {333.5, 540}, {334.5, 516}}, true)
local shawl = poly({{335, 509.5}, {339, 506.5}, {346, 506.5}, {350, 509.5}, {351, 515}, {346, 522}, {342.5, 530}, {339, 522}, {334.2, 515}}, true)
local whead = ellipse(342.4, 503, 3.1, 4.2)
local bun = ellipse(342.2, 498.6, 2.4, 1.9)
WOMAN = skirt + shawl + whead + bun
local dress = pile{{"red earth", 1}, {"vermilion", 0.25}, {"raw umber", 0.45}, {"bone black", 0.1}, medium=0.08}
local cream = pile{{"lead white", 2}, {"yellow ochre", 0.25}, {"raw umber", 0.08}, medium=0.08}
local whair = pile{{"raw umber", 1}, {"red earth", 0.35}, {"yellow ochre", 0.15}, medium=0.08}
det(skirt, dress, 1.6, 5610)
det(whead + bun, whair, 1.1, 5611)
det(shawl, cream, 1.3, 5612)
