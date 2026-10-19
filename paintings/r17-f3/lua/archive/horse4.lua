local bay = pile{{"red earth",1.1},{"raw umber",1.1},{"bone black",0.35},{"lead white",0.2}, medium=0.06}
local bayL = pile{{"red earth",1},{"yellow ochre",0.8},{"raw umber",0.4},{"lead white",0.6}, medium=0.06}
local blk = pile{{"bone black",1},{"raw umber",0.5},{"lead white",0.12},{"pale smalt",0.1}, medium=0.06}
local blkL = pile{{"bone black",0.5},{"raw umber",0.4},{"lead white",0.9},{"pale smalt",0.5}, medium=0.06}
local h1 = HORSES2 * rect(740, 470, 70, 40)
local h2 = HORSES2 * rect(810, 460, 60, 50)
local t = {kind="round", width=1.2, point=0.5}
work(h1, {hand="detail", pile=bay, tool=t, angle=0.2, length={2,6}, coverage=3.5, clip=true, fill=true, edge="found", load=0.9})
work(h1 * mask(function(x,y) return y < 503 - 1.25*19 and 1 or 0 end), {hand="detail", pile=bayL, tool={kind="round", width=1.0, point=0.5}, angle=0, length={2,6}, coverage=1.2, clip=true})
work(h2, {hand="detail", pile=blk, tool=t, angle=0.2, length={2,6}, coverage=3.5, clip=true, fill=true, edge="found", load=0.9})
work(h2 * mask(function(x,y) return y < 501.5 - 1.3*17.5 and 1 or 0 end), {hand="detail", pile=blkL, tool={kind="round", width=0.9, point=0.5}, angle=0, length={2,6}, coverage=0.8, clip=true})
-- shadows under them
local sh = pile{{"green earth",1.4},{"raw umber",0.7},{"Prussian blue",0.25},{"yellow ochre",0.4},{"lead white",0.3}, medium=0.08}
local shm = (ellipse(776, 503.5, 20, 1.4) + ellipse(834, 502, 17, 1.3)) - HORSES2
work(shm, {hand="detail", pile=sh, tool={kind="round", width=0.9, point=0.5}, angle=0, length={3,8}, coverage=1.5, clip=true})
print(wait(0))
