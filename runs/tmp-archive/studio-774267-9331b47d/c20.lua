local m = mask(function(x, y) return (y > far(x) + 1.5 and y < 468) and 1 or 0 end)
for k=1,2 do blend(m, {angle=0, ruler=true, length={150,400}, coverage=2, seed=2000+k}) end
