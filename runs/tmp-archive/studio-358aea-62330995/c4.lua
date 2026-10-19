print(wait(60*28)); print(drying(186,500))
local blackP = pile{{"bone black",1},{"raw umber",0.4},{"lead white",0.1}, medium=0.05}
local red = pile{{"vermilion",1},{"red earth",0.5},{"lead white",0.15}, medium=0.05}
-- black flight feathers: the rear lower half of the folded wing, running out over the tail
local wing = poly({{183,501.2},{188,499.6},{193,500.2},{198.6,503.4},{196,504.2},{190,504.6},{184.5,504.2}}, true)
work(wing, {hand="detail", pile=blackP, tool={kind="round", width=0.7, point=0.6}, angle=0.15, length={2,4}, coverage=3.5, clip=true, fill=true, edge="found", load=0.8})
-- legs: long, red, one stepping back
local r = brush{kind="round", width=0.75, point=0.5}
r:load(red, 0.7)
r:stroke({{184.6,504.5},{184.2,510},{184.6,513.5},{183.6,521.5}}, {pressure={0.75,0.6}})
r:reload(red, 0.7)
r:stroke({{188.6,504.6},{189.6,510},{190.4,513},{192.8,520.6}}, {pressure={0.75,0.6}})
-- bill, pointing down to the grass
local b = brush{kind="round", width=0.8, point=0.9}
b:load(red, 0.6)
b:stroke({{172.4,489.4},{170,492.2},{167.6,495.6}}, {pressure={0.8,0.1}})
-- eye
local e = brush{kind="round", width=0.5, point=0.9}
e:load(blackP, 0.3)
e:touch(173.4, 488.8, {pressure=0.25})
print(wait(0))
