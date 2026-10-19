print(wait(60*30)); print(drying(835,475), drying(790,478))
local h2 = HORSES2 * rect(810, 460, 60, 50)
local blk = pile{{"bone black",1},{"raw umber",0.5},{"lead white",0.12},{"pale smalt",0.1}, medium=0.06}
-- take the outline back off the head, the throat and the front of the neck: keep sheen only on crest-back-rump
local front = (h2 - h2:shrink(1.6)) * mask(function(x,y) return (x < 827 and 1 or 0) end)
work(front, {hand="detail", pile=blk, tool={kind="round", width=0.8, point=0.6}, angle=0, length={2,5}, coverage=3, clip=true, fill=true, load=0.8})
-- the upper line of the crest and forehead gets a single thin cool glint
local r = brush{kind="round", width=0.7, point=0.8}
r:load(pile{{"bone black",0.3},{"raw umber",0.4},{"lead white",1.2},{"pale smalt",0.6}, medium=0.06}, 0.35)
print(wait(0))
