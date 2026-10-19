rim = pile{{"lead white",4},{"pale smalt",2},{"smalt",0.5},{"raw umber",0.3}, medium=0.08}
-- the posts: shadowed right flank, cool light down the left, snow caps, drifts at the feet
local r = brush{kind="round", width=2.4, point=1}
r:load(chamber, 0.7)
r:stroke({{95.5,642},{97,610},{99.5,578}}, {pressure={0.5,0.3}})
r:stroke({{153.5,626},{154,600},{154.5,584}}, {pressure={0.45,0.3}})
r:stroke({{216,610},{217,590},{218,578}}, {pressure={0.4,0.3}})
r:load(rim, 0.5)
r:stroke({{87.5,640},{90,610},{94,578}}, {pressure={0.25,0.15}})
r:stroke({{147.8,624},{148.6,600},{149.5,586}}, {pressure={0.22,0.12}})
-- caps
local caps = ellipse(97, 574, 4.6, 2.2) + ellipse(216, 574, 3.4, 1.8) + poly({{147,583},{149,578},{152,580},{155,582},{151,584}}, true)
local railSnow = ribbon({{97,597.5},{124,603.3},{150,609.4},{170,614.4}}, {1.6,1.8,1.8,1.4})
work(caps + railSnow, {hand="detail", pile=snowTop, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=0, tool={kind="round", width=1.2}})
-- drifts piled at the feet, a little on the windward left
local d1 = poly({{72,648},{82,640},{89,634},{97,636},{104,641},{112,648}}, true)
local d2 = poly({{136,630},{144,624},{150,620},{156,622},{162,626},{170,631}}, true)
local d3 = poly({{202,613},{208,608},{213,605},{219,607},{226,612}}, true)
local rail2 = poly({{160,618},{166,613},{172,612},{182,619}}, true)
work(d1 + d2 + d3 + rail2, {hand="detail", pile=fieldB, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=0, tool={kind="round", width=1.5}})
r:load(snowTop, 0.5)
r:stroke({{74,647},{82,640},{89,634.5}}, {pressure={0.3,0.1}})
r:stroke({{138,629.5},{144,624},{150,620.5}}, {pressure={0.3,0.1}})
