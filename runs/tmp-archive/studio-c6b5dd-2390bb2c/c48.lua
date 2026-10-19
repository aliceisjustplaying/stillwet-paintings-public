local pts = {}
for x = 460, 1010, 12 do pts[#pts+1] = {x, 462 + rand(0,2)} end
local bot = {}
for x = 460, 1010, 10 do bot[#bot+1] = {x, 472 + rand(-1,4) + 2*math.sin(x/30)} end
shoreRefl = (below(pts) * above(bot)):roughen(1.5, 10, 121, 0)
pSR = pile{{"lead white",0.8},{"smalt",1},{"raw umber",1.5},{"green earth",0.5},{"red earth",0.2}}
work(shoreRefl, {hand="body", tool="filbert 4", pile=pSR, angle=0, angle_jitter=0.05, coverage=2.5, load=0.7, fill=true, length={20,60}, edge="soft"})
-- reflected cloud colour: drawn as its own soft horizontal patches
rc = (poly({{480,560},{600,552},{760,556},{900,550},{1010,556},{1010,590},{880,596},{740,592},{600,596},{500,588}}, true):roughen(8, 40, 122, 0)
   + poly({{560,640},{700,632},{860,636},{1010,630},{1010,668},{860,672},{700,668},{580,662}}, true):roughen(8, 40, 123, 0))
pRC = pile{{"lead white",2.5},{"smalt",1},{"red earth",0.4},{"raw umber",0.3},{"vermilion",0.05}}
work(rc, {hand="body", tool="filbert 10", pile=pRC, angle=0, angle_jitter=0.02, coverage=1.8, load=0.6, pressure={0.3,0.6}, length={60,200}, edge="soft"})
blend(rc:grow(10) - refl2, {angle=0, angle_jitter=0.01, tool="badger 30", length={80,200}})
