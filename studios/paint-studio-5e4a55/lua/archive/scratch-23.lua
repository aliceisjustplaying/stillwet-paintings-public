-- easel session "scratch": a painting replayed chunk by chunk.
-- Each "--@ chunk" line starts one chunk as it was run at the easel.
--@ engine 8
--@ knife-skim
--@ limbs-join-nearest
--@ blend-feather
--@ brush-skim
--@ blend-at-masks
--@ glaze-film
--@ liquid-film-levels
--@ rag-lift
--@ full-palette-refuses
--@ drain

--@ chunk 1
canvas{aspect=0.8, ground={{apply="knife", pile={{"lead white", 10}, {"yellow ochre", 0.4}, {"raw umber", 0.15}}, texture=0.25, um=120}}, linen={18, 15}, seed=4417, size=480}

--@ chunk 2
lent = pile{{"bone black",1},{"raw umber",1.2}}
rock = pile{{"raw umber",2},{"Prussian blue",0.6},{"bone black",0.5},{"red earth",0.5}}
waterdark = pile{{"raw umber",3},{"Prussian blue",0.75},{"red earth",1},{"green earth",0.6}, name="waterdark"}
haze = pile{{"lead white",4},{"yellow ochre",1},{"red earth",0.3},{"smalt",0.6}}
amber = pile{{"yellow ochre",3},{"red earth",1},{"lead white",1}}
work(rect(100, 200, 800, 700), {hand="body", piles={{waterdark,0.62},{haze,0.28},{amber,0.1}}, coverage=3, fill=true, angle=1.5, tool="flat 9", length={30,80}})
rockS = outline{{100,300},{300,290},{420,330,"c"},{470,420},{500,560},{520,900},{100,900}, char="broken", seed=5, amount=0.35}:mask()
work(rockS, {hand="body", piles={{rock,1},{lent,0.4}}, coverage=4, fill=true, clip=true, tool="flat 8", length={16,40}, angle=1.45})
print(wait(40*24*60))

--@ chunk 3
midmix = mix{{rock,0.5},{waterdark,0.35},{haze,0.15}, name="midmix"}
watermix = mix{{waterdark,0.62},{haze,0.28},{amber,0.1}, name="watermix"}
local zA = rockS * rect(300, 420, 400, 140)
local zB = rockS * rect(300, 620, 400, 180)
print(lose(rockS * rect(300, 420, 400, 140) + (rect(300,420,400,140) - rockS), {pile=watermix, where=1, seed=3}))
print(lose(rockS * rect(300, 620, 400, 180) + (rect(300,620,400,180) - rockS), {pile=midmix, where=1, seed=4}))

--@ chunk 4
print(lose(rockS, {pile=watermix, where=function(x,y) return (y > 440 and y < 600 and x > 380) and 1 or 0 end, seed=5}))
print(lose(rockS, {pile=midmix, where=function(x,y) return (y > 640 and y < 860 and x > 380) and 1 or 0 end, seed=6}))

--@ chunk 5
glow = pile{{"lead white",5},{"chrome yellow",1.2},{"yellow ochre",0.8}}
fartrunk = pile{{"lead white",2},{"raw umber",1},{"red earth",0.4},{"smalt",0.8}}
deeprust = pile{{"red earth",3},{"raw umber",2},{"yellow ochre",1}}
work(rect(600, 900, 380, 330), {hand="body", piles={{glow,0.6},{haze,1.1},{amber,0.25}}, coverage=3, fill=true})
blend(rect(610, 910, 360, 310), {angle=math.pi/2})
for i, x in ipairs({680, 780, 880}) do
  local tm = ribbon({{x, 920}, {x + 2, 1100}, {x + 4, 1210}}, {6, 7, 7}):roughen(1, 14, i)
  work(tm, {hand="body", pile=fartrunk, tool="flat 5", angle=-math.pi/2, coverage=3, fill=true, clip=true, length={30,80}})
end
print(wait(40*24*60))

--@ chunk 6
warmG1 = pile{{"yellow ochre",1},{"red earth",0.4},{"raw umber",0.15}, medium=0.8, name="warmG1"}
warmG2 = pile{{"yellow ochre",1},{"red earth",0.25},{"lead white",0.4}, medium=0.75, name="warmG2"}
-- A: warmG1 on trunk 1, narrow glaze brush
work(ribbon({{680, 920}, {682, 1100}, {684, 1210}}, 9), {hand="glaze", pile=warmG1, tool="filbert 8", coverage=1, angle=math.pi/2})
-- B: warmG2 on trunk 2
work(ribbon({{780, 920}, {782, 1100}, {784, 1210}}, 9), {hand="glaze", pile=warmG2, tool="filbert 8", coverage=1, angle=math.pi/2})

--@ chunk 7
local m = ribbon({{880, 920}, {882, 1100}, {884, 1210}}, 6.5)
work(m, {hand="glaze", pile=warmG1, tool="filbert 6", coverage=1, angle=math.pi/2, clip=true})
