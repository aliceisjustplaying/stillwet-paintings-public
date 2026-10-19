print(wait(30*60)); print(drying(100,620))
stakeP = pile{{"raw umber",1},{"bone black",0.6},{"red earth",0.15}}
puddleP = pile{{"lead white",2.2},{"yellow ochre",0.5},{"chrome yellow",0.15},{"red earth",0.15},{"smalt",0.2},{"raw umber",0.15}}
puddleP2 = pile{{"lead white",1.6},{"smalt",0.7},{"red earth",0.3},{"raw umber",0.4}}
-- puddles, drawn as thin flat lenses
local p1 = outline{{40,606},{75,603},{112,605},{80,609}, closed=true, char="soft", amount=0.4, seed=121}:mask()
local p2 = outline{{130,626},{175,621},{215,625},{170,630}, closed=true, char="soft", amount=0.4, seed=122}:mask()
local p3 = outline{{10,641},{60,637},{95,640},{55,645}, closed=true, char="soft", amount=0.4, seed=123}:mask()
work(p1 + p2, {hand="detail", pile=puddleP, angle=0.05, coverage=2, fill=true, clip=true})
work(p3, {hand="detail", pile=puddleP2, angle=0.05, coverage=2, fill=true, clip=true})
-- stakes: old mooring posts leaning a little
local s = brush("flat", 4.5)
s:reload(stakeP, 0.9)
s:stroke({{118,578},{119.5,545},{121,512}}, {pressure={0.9,0.8}, ramps={0.02,0.05}, orient="across"})
s:reload(stakeP, 0.9)
s:stroke({{168,584},{167,560},{166,536}}, {pressure={0.85,0.75}, ramps={0.02,0.05}, orient="across"})
s:reload(stakeP, 0.8)
s:stroke({{205,590},{206,575},{207,560}}, {pressure={0.75,0.7}, ramps={0.02,0.05}, orient="across"})
