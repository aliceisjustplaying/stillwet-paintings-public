-- sheen of sky light on the black horse's back, crest and rump; a warm lit line on the bay's back
local h2 = HORSES2 * rect(810, 460, 60, 50)
local h1 = HORSES2 * rect(740, 470, 70, 40)
local sheen = pile{{"bone black",0.35},{"raw umber",0.5},{"lead white",1.3},{"pale smalt",0.6},{"yellow ochre",0.1}, medium=0.06}
local warm = pile{{"red earth",0.8},{"yellow ochre",1.0},{"lead white",1.0},{"raw umber",0.2}, medium=0.06}
local rim2 = (h2 - h2:shrink(1.1)) * mask(function(x,y) return y < 480 and 1 or 0 end)
work(rim2, {hand="detail", pile=sheen, tool={kind="round", width=0.8, point=0.6}, angle=0, length={2,5}, coverage=1.4, clip=true, load=0.5})
local rim1 = (h1 - h1:shrink(1.1)) * mask(function(x,y) return y < 481 and 1 or 0 end)
work(rim1, {hand="detail", pile=warm, tool={kind="round", width=0.8, point=0.6}, angle=0, length={2,5}, coverage=1.2, clip=true, load=0.5})
print(wait(0))
