show(PROM, {label="prom"})
local cr, sh = {}, {}
for x = 0, 1000, 20 do cr[#cr+1] = {x, crest(x)}; sh[#sh+1] = {x, SHORE(x)} end
show(cr, {label="range", dots=false}); show(sh, {label="shore"}); show({{0,HZ},{1000,HZ}}, {label="HZ"})
show(MOON[1], MOON[2], "moon")
