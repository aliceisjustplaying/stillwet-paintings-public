local det = function(m, p, w, seed, cov) work(m, {hand="detail", tool={kind="round", width=w or 1, point=0.6}, pile=p, angle=math.pi/2, coverage=cov or 2.5, fill=true, seed=seed}) end
local shawl = poly({{335, 509.5}, {339, 506.5}, {346, 506.5}, {350, 509.5}, {351, 515}, {346, 522}, {342.5, 530}, {339, 522}, {334.2, 515}}, true)
local cream = pile{{"lead white", 2.2}, {"yellow ochre", 0.22}, {"raw umber", 0.06}, medium=0.08}
local creamsh = pile{{"lead white", 1.4}, {"raw umber", 0.3}, {"pale smalt", 0.35}, {"yellow ochre", 0.1}, medium=0.08}
det(shawl, cream, 1.0, 11101, 3.5)
