-- the far reach reads as a wire: cover it, then state it as a few meander gleams half hidden by banks and bushes
local fp = {{226,505.3},{262,501.3},{305,497.3},{350,492.8},{392,488.3},{428,483.8},{458,478.8},{486,473.2},{520,468}}
local cover = ribbon(fp, 4.5) * rect(205, 460, 330, 50) - river2:grow(0.5) - hedge2:grow(0.5) - hedgerow:grow(0.5)
local tl = function(x, y) return -math.pi/2 + 0.08 + 0.1 * math.sin(x / 23 + y / 7) end
work(cover, {hand="hatch", pile=pastCm, tool={kind="round", width=1.1, point=0.9}, angle=tl, length={1.5,3.5}, coverage=2.4, pressure={0.4,0.6}, ramps={0.1,0.6}, clip=cover, clump=0.2, fill=true})
print(wait(0))
