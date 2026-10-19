-- the drawing: a light 2H search, then 3B for what I am sure of; the lake's far edge ruled
local function line_of(f, x0, x1, step) local p = {} for x = x0, x1, step do p[#p+1] = {x, f(x)} end return p end
RANGE_PTS = line_of(crest, 0, 1000, 25)
SHORE_PTS = line_of(SHORE, 0, 1000, 25)
local h = pencil("2H")
h:rule({0, HZ}, {1000, HZ}, {pressure=0.3})
h:sketch(RANGE_PTS, {pressure=0.3})
h:sketch(PROM, {pressure=0.3})
h:sketch(SHORE_PTS, {pressure=0.3})
local b = pencil("3B")
b:line(PROM, {pressure={0.55, 0.7, 0.65, 0.5}})
b:rule({448, HZ}, {1000, HZ}, {pressure=0.45})
b:line(RANGE_PTS, {pressure={0.4, 0.55, 0.5}})
b:line(SHORE_PTS, {pressure={0.5, 0.65, 0.5}})
-- the moon's place, a small circle
local m = {} for i = 0, 16 do local a = i/16*2*math.pi m[#m+1] = {MOON[1] + 9*math.cos(a), MOON[2] + 9*math.sin(a)} end
h:sketch(m, {pressure=0.25})
fix()
print(drawing_mask():area())
