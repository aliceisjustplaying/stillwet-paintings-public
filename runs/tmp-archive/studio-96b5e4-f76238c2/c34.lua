w_refl = pile{{"raw umber",1},{"green earth",0.6},{"smalt",0.3},{"lead white",0.35},{"bone black",0.1}, medium=0.2}
local function edgeband(y0,y1,w) return (creek - creek:shrink(w)):roughen(w*0.4, 12, math.floor(y0)) * rect(0,y0,1000,y1-y0) end
local e1 = edgeband(441,505,1.6)
local e2 = edgeband(500,585,3.2)
local e3 = edgeband(580,720,5.5)
work(e1, {hand="detail", pile=w_refl, angle=0, coverage=1.6, length={3,8}, tool={kind="round", width=1.4}, clip=true})
work(e2, {hand="detail", pile=w_refl, angle=0, coverage=1.6, length={4,12}, tool={kind="round", width=2.2}, clip=true})
work(e3, {hand="detail", pile=w_refl, angle=0, coverage=1.6, length={6,16}, tool={kind="round", width=3}, clip=true})
