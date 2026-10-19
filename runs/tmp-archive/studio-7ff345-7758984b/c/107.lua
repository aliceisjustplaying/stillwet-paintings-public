print(wait(2*24*60))
print(drying(320,472), drying(300,478), drying(150,500), drying(700,640))
-- the land is backlit: its face toward us should sit clearly below the glow of the sky.
-- a deeper glaze over it, leaving a thin lit rim along the knoll crest and the mist in the hollow.
duskLand = pile{{"smalt",1},{"Prussian blue",0.35},{"bone black",0.35},{"red earth",0.25},{"green earth",0.3}, medium=0.9}
local nn = noise{seed=1071, period=70, octaves=3}
local m = landm - merem:grow(0.5) - figM:grow(1) - posts.cap:grow(0.5) - sprMask:grow(1) - oakLive:grow(0.5)
          - fallenM:grow(1.5) - stoneM:grow(0.8)
work(m, {hand="glaze", pile=duskLand, angle=0.03, angle_jitter=0.05, clip=true,
   load_at=function(x, y)
     local below = y - knollCrest(math.min(x, 520))
     local rim = smoothstep(2, 14, below)
     local mist = 1 - 0.8 * math.exp(-((x - 590) / 110)^2 - ((y - 478) / 22)^2)
     local base = 0.28 + 0.3 * smoothstep(430, 714, y)
     return base * rim * mist * (0.85 + 0.3 * nn(x, y))
   end,
   pressure={0.3, 0.5}, coverage=1.8, seed=1072})
