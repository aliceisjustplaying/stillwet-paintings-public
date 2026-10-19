postP = pile{{"raw umber",1.5},{"bone black",0.6},{"lead white",0.9},{"yellow ochre",0.3}, medium=0.08}
posts = {
  {pts={{90,646},{93,610},{97,574}}, ws={7.5,7,6.5}},
  {pts={{150,628},{151,600},{152,580}}, ws={6.5,6.2,6}},
  {pts={{213,612},{214,590},{216,574}}, ws={5.5,5.2,5}},
}
local m = nil
for _,p in ipairs(posts) do local r = ribbon(p.pts, p.ws); m = m and (m + r) or r end
-- a split, broken top on the middle post
m = m + poly({{148,582},{149,573},{151,577},{153,570},{155,581}})
-- the fallen rail, half sunk in the snow
local rail = ribbon({{96,600},{124,606},{150,612},{170,617}}, {4.5,4.2,4.2,4})
postsM = (m + rail):roughen(0.5, 3, 111)
work(postsM, {hand="detail", pile=postP, coverage=4, pressure={0.6,0.9}, load=1, fill=true, angle=-math.pi/2, angle_jitter=0.3})
-- grain and cracks of the weathered wood
local r = brush{kind="round", width=2, point=1}
r:load(chamber, 0.6)
r:stroke({{92,640},{94,612},{96,580}}, {pressure={0.3,0.05}})
r:stroke({{151,624},{151,596}}, {pressure={0.3,0.05}})
r:stroke({{214,608},{215,585}}, {pressure={0.28,0.05}})
