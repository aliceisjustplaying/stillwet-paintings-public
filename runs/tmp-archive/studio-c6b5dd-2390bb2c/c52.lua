local top = {{-10,440}}
local x = -10
while x < 470 do
  x = x + rand(10, 28)
  top[#top+1] = {x, 438 + rand(-8, 6) + (x > 380 and (x-380)*0.15 or 0)}
end
top[#top+1] = {478, 462}
local bot = {}
for xx = -10, 480, 15 do bot[#bot+1] = {xx, 469 + rand(-1.5, 1.5)} end
under = (below(top) * above(bot)):roughen(3, 14, 131, 0)
pUnder = pile{{"Prussian blue",0.45},{"raw umber",1.6},{"bone black",0.5},{"yellow ochre",0.7},{"green earth",0.3}}
work(under, {hand="body", tool="filbert 6", pile=pUnder, angle=function(x,y) return 0.5*math.sin(x/20) end, angle_jitter=0.5, coverage=3.5, load=0.95, fill=true, length={10,30}, edge="soft"})
-- the stub where the far-shore reflection runs under the near bank
local stub = rect(452, 460, 30, 20) * refl2:grow(12)
work(stub, {hand="detail", tool={kind="flat", width=4}, pile=pR1, coverage=3, load=0.9, fill=true})
