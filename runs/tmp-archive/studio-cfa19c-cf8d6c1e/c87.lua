-- two figures seen from behind on the crest, looking out toward the town
local coat = pile{{"Prussian blue",0.5},{"raw umber",1.2},{"bone black",0.6},{"green earth",0.4},{"lead white",0.15}, medium=0.05}
local coatL = pile{{"Prussian blue",0.4},{"raw umber",1},{"green earth",0.6},{"lead white",0.8},{"bone black",0.2}, medium=0.05}
local trs = pile{{"lead white",1.5},{"raw umber",0.8},{"yellow ochre",0.6},{"bone black",0.1}, medium=0.05}
local boot = pile{{"bone black",1},{"raw umber",0.8}, medium=0.05}
local dress = pile{{"red earth",1.3},{"raw umber",0.6},{"vermilion",0.2},{"bone black",0.15},{"lead white",0.2}, medium=0.05}
local dressL = pile{{"red earth",1.2},{"vermilion",0.3},{"lead white",0.6},{"yellow ochre",0.2}, medium=0.05}
local shawl = pile{{"lead white",1.2},{"yellow ochre",0.5},{"raw umber",0.4},{"pale smalt",0.15}, medium=0.05}
local hair = pile{{"raw umber",1.5},{"red earth",0.3},{"bone black",0.3},{"lead white",0.2}, medium=0.05}
local skin = pile{{"lead white",2},{"red earth",0.45},{"yellow ochre",0.4}, medium=0.05}
local gsh = pile{{"green earth",1.5},{"raw umber",0.7},{"Prussian blue",0.35},{"yellow ochre",0.8},{"lead white",0.2}, medium=0.08}

local mx, my = 328, 573   -- man's feet
local function M(u, v) return {mx + u, my - v} end
local wx, wy = 344, 577   -- woman's feet
local function W(u, v) return {wx + u, wy - v} end

-- cast shadows on the grass, falling to the right
work(poly({M(-3,0), M(4,-0.5), M(22,-3.5), M(24,-1.5), M(8,1)}, true), {hand="detail", pile=gsh, tool={kind="round", width=1.6, point=0.3}, angle=0.1, coverage=2.5, fill=true, seed=801})
work(poly({W(-6,0), W(8,-0.5), W(28,-3.5), W(30,-1), W(10,1.5)}, true), {hand="detail", pile=gsh, tool={kind="round", width=1.6, point=0.3}, angle=0.1, coverage=2.5, fill=true, seed=802})

-- the man: legs, then the long coat, then the head and cap
local legs = poly({M(-3.6,15.5), M(-3.3,1), M(-0.9,1), M(-0.4,15.5)}) + poly({M(0.6,15.5), M(1.0,1), M(3.4,1), M(3.8,15.5)})
work(legs, {hand="detail", pile=trs, tool={kind="round", width=1.2, point=0.3}, angle=math.pi/2, coverage=3, fill=true, clip=true, seed=803})
local boots = rect(mx-3.8, my-4, 3.2, 4.2) + rect(mx+0.8, my-4, 3.0, 4.2)
work(boots, {hand="detail", pile=boot, tool={kind="round", width=1.0, point=0.3}, angle=0, coverage=3, fill=true, clip=true, seed=804})
local coatM = poly({M(-2.2,43), M(-5.5,41.8), M(-6.8,39.5), M(-7.4,30), M(-7.8,22), M(-7.2,14.5), M(0,14), M(7.2,14.5), M(7.6,22), M(7.2,30), M(6.8,39.5), M(5.5,41.8), M(2.2,43)}, true)
work(coatM, {hand="detail", pile=coat, tool={kind="round", width=1.8, point=0.3}, angle=math.pi/2, coverage=3.5, fill=true, clip=true, seed=805})
-- lit left side of the coat and the arm
local coatLit = coatM * mask(function(x,y) return smoothstep(mx-2, mx-5.5, x) end)
work(coatLit, {hand="detail", pile=coatL, tool={kind="round", width=1.2, point=0.3}, angle=math.pi/2, coverage=1.8, clip=true, seed=806})
-- the arms' seams and the coat's centre vent, in a darker line
local r = brush{kind="rigger", width=0.8, point=1}
r:reload(boot, 0.5)
r:stroke({M(-5.2,38), M(-5.6,30), M(-5.2,23)}, {pressure={0.4,0.3}})
r:stroke({M(5.2,38), M(5.6,30), M(5.2,23)}, {pressure={0.4,0.3}})
r:stroke({M(0.2,30), M(0.1,14.5)}, {pressure={0.35,0.4}})
-- neck, head and the dark cap
local neck = ellipse(mx, my-44, 1.8, 1.4)
work(neck, {hand="detail", pile=skin, tool={kind="round", width=1, point=0.2}, angle=0, coverage=3, fill=true, clip=true, seed=807})
local head = ellipse(mx+0.2, my-47, 3.0, 3.5)
work(head, {hand="detail", pile=hair, tool={kind="round", width=1.2, point=0.3}, angle=math.pi/2, coverage=3, fill=true, clip=true, seed=808})
local cap = ellipse(mx+0.4, my-50, 4.1, 1.9)
work(cap, {hand="detail", pile=boot, tool={kind="round", width=1.2, point=0.3}, angle=0, coverage=3, fill=true, clip=true, seed=809})

-- the woman: a long dress, a pale shawl over the shoulders, hair gathered up
local dressM = poly({W(-3.4,31), W(-4.2,24), W(-6.2,12), W(-8.2,1.5), W(-7.5,0), W(7.8,0), W(8.6,1.5), W(6.6,12), W(4.6,24), W(3.8,31)}, true)
work(dressM, {hand="detail", pile=dress, tool={kind="round", width=1.8, point=0.3}, angle=math.pi/2, coverage=3.5, fill=true, clip=true, seed=811})
local dressLit = dressM * mask(function(x,y) return smoothstep(wx-1, wx-5.5, x) end)
work(dressLit, {hand="detail", pile=dressL, tool={kind="round", width=1.2, point=0.3}, angle=math.pi/2, coverage=1.6, clip=true, seed=812})
r:reload(boot, 0.4)
for k,u in ipairs({-3.5, -0.8, 2.2, 5.0}) do r:stroke({W(u*0.55,24), W(u,1)}, {pressure={0.2,0.35}}) end
local shawlM = poly({W(-2,39.5), W(-5.6,37.5), W(-6.4,33), W(-5.2,27), W(0,24.5), W(5.4,27), W(6.4,33), W(5.6,37.5), W(2,39.5)}, true)
work(shawlM, {hand="detail", pile=shawl, tool={kind="round", width=1.3, point=0.3}, angle=math.pi/2, coverage=3.5, fill=true, clip=true, seed=813})
local shawlSh = shawlM * mask(function(x,y) return smoothstep(wx+1, wx+5, x) end)
work(shawlSh, {hand="detail", pile=pile{{"lead white",1},{"raw umber",0.6},{"pale smalt",0.4},{"yellow ochre",0.2}, medium=0.05}, tool={kind="round", width=1, point=0.3}, angle=math.pi/2, coverage=2, clip=true, seed=814})
local neckW = ellipse(wx, wy-40.2, 1.5, 1.2)
work(neckW, {hand="detail", pile=skin, tool={kind="round", width=0.9, point=0.2}, angle=0, coverage=3, fill=true, clip=true, seed=815})
local headW = ellipse(wx-0.2, wy-43.2, 2.7, 3.1)
work(headW, {hand="detail", pile=hair, tool={kind="round", width=1.1, point=0.3}, angle=math.pi/2, coverage=3, fill=true, clip=true, seed=816})
local bun = ellipse(wx-0.2, wy-46.2, 1.7, 1.4)
work(bun, {hand="detail", pile=hair, tool={kind="round", width=1, point=0.3}, angle=0, coverage=3, fill=true, clip=true, seed=817})
