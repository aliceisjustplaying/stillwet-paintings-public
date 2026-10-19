local gsh = pile{{"green earth",1.2},{"raw umber",0.6},{"Prussian blue",0.4},{"yellow ochre",0.9},{"lead white",0.2}, medium=0.06}
local mx, my, wx, wy = 328, 573, 344, 577
local function M(u, v) return {mx + u, my - v} end
local function W(u, v) return {wx + u, wy - v} end
local s1 = poly({M(1,0.5), M(4,-0.5), M(22,-3.2), M(24,-1.8), M(8,1.2)}, true) - figM
local s2 = poly({W(4,0.5), W(8,-0.5), W(28,-3.2), W(30,-1.2), W(10,1.5)}, true) - figM
work(s1 + s2, {hand="detail", pile=gsh, tool={kind="round", width=1.4, point=0.3}, angle=0.12, coverage=2.5, fill=true, clip=true, seed=1091})
local h1 = ellipse(449, 552.5, 9, 1.4) - horsesM
local h2 = ellipse(526, 566.5, 10, 1.5) - horsesM
work(h1 + h2, {hand="detail", pile=gsh, tool={kind="round", width=1.2, point=0.3}, angle=0.05, coverage=2.2, fill=true, clip=true, seed=1092})
