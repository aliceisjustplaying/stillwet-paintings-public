-- close the green haloes round the cattle and the stork with the new pasture colour
local cowsAll = cows[1] + cows[2] + cows[3]
local ring = (cows[1]:grow(4) + cows[2]:grow(4) + cows[3]:grow(4) + rect(110, 528, 22, 28)) * pasture:grow(4) - cowsAll:grow(0.3) - river2:grow(1) - fieldB
local stork = rect(115, 534, 16, 19) * mask(function(x,y) return 1 end)
local keepS = ellipse(122, 543, 7, 9) + ellipse(125, 551.5, 6, 1.3)
ring = ring - keepS
local tl = function(x, y) return -math.pi/2 + 0.08 + 0.1 * math.sin(x / 23 + y / 7) end
work(ring, {hand="hatch", pile=pastC, tool={kind="round", width=1.2, point=0.9}, angle=tl, length={2,4.5}, coverage=2.0, pressure={0.35,0.6}, ramps={0.1,0.6}, clip=ring, clump=0.2, threshold=0.3, fill=true})
-- the far river as a thin broken gleam of sky, running back to the hedge
local fp = {{226,505.3},{262,501.3},{305,497.3},{350,492.8},{392,488.3},{428,483.8},{458,478.8},{486,473.2}}
local wf = pile{{"lead white", 5}, {"pale smalt", 1.6}, {"cobalt blue", 0.3}, {"raw umber", 0.1}, medium=0.1}
local g = brush{kind="round", width=1.4, point=0.6}
for i = 1, #fp - 1 do
  g:load(wf, 0.45 - i * 0.03)
  local a, b = fp[i], fp[i+1]
  g:stroke({a, {lerp(a[1], b[1], 0.5), lerp(a[2], b[2], 0.5) + 0.3}, b}, {pressure={0.45 - i*0.03, 0.4 - i*0.035}, ramps={0.1, 0.2}})
end
print(wait(0))
