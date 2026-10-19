-- calm the zebra snow on the spruces: a dark transparent glaze, lighter toward the tips where the snow catches the sky
sprGlaze = pile{{"Prussian blue",0.4},{"bone black",1},{"raw umber",0.5},{"smalt",0.3}, medium=0.75}
local m = (sprMask + sprSnowM):grow(0.8)
work(m, {hand="detail", tool={kind="round", width=3, point=0.4}, pile=sprGlaze, load=0.4, pressure={0.35, 0.55}, coverage=2, fill=true, clip=true, angle=0.3, angle_jitter=0.5,
   load_at=function(x, y)
     local best = 1
     for _, s in ipairs(spruces) do
       local d = math.abs(x - s.cx) / (s.h * 0.29 + 1)
       if d < best then best = d end
     end
     return 0.5 - 0.3 * best
   end})
