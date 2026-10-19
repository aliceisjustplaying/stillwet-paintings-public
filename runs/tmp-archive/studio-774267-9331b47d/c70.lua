local det = function(m, p, w, seed, cov) work(m, {hand="detail", tool={kind="round", width=w or 1, point=0.6}, pile=p, angle=math.pi/2, coverage=cov or 2.5, fill=true, seed=seed}) end
-- shawl, clean
local shawl = poly({{335, 509.5}, {339, 506.5}, {346, 506.5}, {350, 509.5}, {351, 515}, {346, 522}, {342.5, 530}, {339, 522}, {334.2, 515}}, true)
local cream = pile{{"lead white", 2.2}, {"yellow ochre", 0.22}, {"raw umber", 0.06}, medium=0.08}
local creamsh = pile{{"lead white", 1.4}, {"raw umber", 0.3}, {"pale smalt", 0.35}, {"yellow ochre", 0.1}, medium=0.08}
det(shawl, cream, 1.1, 7001, 3)
det(shawl * rect(343, 0, 20, 700), creamsh, 0.9, 7002, 1.8)
-- a fringe edge along the shawl's point
local fr = brush{kind="round", width=0.5, point=1}
fr:load(creamsh, 0.4)
for i=0,8 do local t = i/8; local x = lerp(335.5, 342.5, t); local y = lerp(516, 530, t); fr:stroke({{x, y}, {x + 0.2, y + 1.5}}, {pressure={0.3, 0.05}}) end
for i=0,8 do local t = i/8; local x = lerp(342.5, 350.5, t); local y = lerp(530, 516, t); fr:stroke({{x, y}, {x + 0.2, y + 1.5}}, {pressure={0.3, 0.05}}) end
-- dress: shade on the right, folds, lit left edge
local skirt = poly({{336, 509}, {348.5, 509}, {350.5, 516}, {352.5, 540}, {355.5, 566.5}, {343, 568}, {331.5, 566.5}, {333.5, 540}, {334.5, 516}}, true)
local dsh = pile{{"red earth", 0.8}, {"raw umber", 0.7}, {"bone black", 0.25}, {"vermilion", 0.05}, medium=0.2}
local dlt = pile{{"red earth", 0.8}, {"vermilion", 0.35}, {"yellow ochre", 0.3}, {"lead white", 0.15}, medium=0.1}
det(skirt * poly({{346, 505}, {360, 505}, {360, 570}, {349, 570}}), dsh, 1.2, 7003, 2)
local fb = brush{kind="round", width=0.8, point=1}
fb:load(dsh, 0.5)
for _,f in ipairs({{341, 532, 339.5, 566}, {345.5, 534, 346.5, 567}, {349, 540, 351.5, 566}, {337.5, 540, 335, 566}}) do
  fb:stroke({{f[1], f[2]}, {(f[1]+f[3])/2 + 0.3, (f[2]+f[4])/2}, {f[3], f[4]}}, {pressure={0.05, 0.5}, ramps={0.4, 0.1}})
end
det(skirt * poly({{325, 505}, {336.8, 505}, {334, 540}, {331.8, 570}, {325, 570}}), dlt, 0.8, 7004, 1.5)
-- the man: warm light along his left contour, sleeve on the right, shading
local coat = poly({{314, 503}, {318, 500.5}, {326, 500.5}, {330.5, 503}, {332, 510}, {331.5, 524}, {330, 530}, {333.5, 546}, {321.5, 548}, {310.8, 546}, {314, 530}, {312.8, 524}, {312.5, 510}}, true)
local coatl = pile{{"bone black", 0.5}, {"Prussian blue", 0.1}, {"raw umber", 0.6}, {"lead white", 0.45}, {"yellow ochre", 0.25}, medium=0.1}
local coatd = pile{{"bone black", 1}, {"Prussian blue", 0.15}, {"raw umber", 0.4}, medium=0.1}
det((coat - coat:offset(0):shrink(1.4)) * rect(300, 0, 16.5, 700), coatl, 0.7, 7005, 1.6)
local sleeve = poly({{328.5, 503.5}, {332, 507}, {333.2, 518}, {331.8, 527}, {329.4, 527}, {330, 518}, {328.4, 508}}, true)
det(sleeve, coatd, 0.8, 7006, 2.5)
local sl = brush{kind="round", width=0.6, point=1}
sl:load(coatl, 0.4)
sl:stroke({{317, 503}, {315.5, 515}, {316.5, 527}}, {pressure={0.3, 0.1}})
sl:stroke({{318.5, 530}, {317.8, 544}}, {pressure={0.25, 0.05}})
-- hat brim catching light, and the collar edge
sl:load(pile{{"bone black", 0.6}, {"raw umber", 0.5}, {"lead white", 0.5}, medium=0.1}, 0.4)
sl:stroke({{317.4, 491.5}, {320, 492.3}, {324, 492.3}}, {pressure={0.35, 0.1}})
-- right trouser leg in shade
det(poly({{323, 545}, {328.5, 545}, {327.5, 563}, {323.5, 563}}) * rect(325.6, 0, 5, 700), pile{{"raw umber", 0.8}, {"lead white", 0.35}, {"bone black", 0.1}, medium=0.1}, 0.7, 7007, 1.6)
