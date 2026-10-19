trunkZ = (oakM2 * rect(262, 330, 90, 275)) - foliM
work(trunkZ, {hand="body", pile=barkD, angle=-1.5708, coverage=3.2, fill=true, clip=true, length={10,30}, tool="filbert 5"})
work(trunkZ * rect(262, 330, 36, 275), {hand="body", pile=barkDark, angle=-1.5708, coverage=1.5, fill=true, clip=true, length={10,30}, tool="filbert 4"})
blend(trunkZ, {angle=-1.5708, coverage=2.5, length={30, 80}, tool="badger 12"})
barkRim = pile{{"raw umber", 2}, {"lead white", 0.9}, {"red earth", 0.35}, {"yellow ochre", 0.3}, {"bone black", 0.4}, medium=0.1}
local rim = (trunkZ - trunkZ:shrink(2.5)) * rect(306, 330, 60, 250)
work(rim, {hand="detail", pile=barkRim, angle=-1.5708, coverage=1.6, clip=true, length={6,18}, pressure={0.3,0.6}})
-- bark fissures: a few long vertical dark lines
local fb = brush{kind="round", width=1.6, point=1}
for i = 1, 14 do
  fb:load(barkDark, 0.8)
  local x = rand(290, 322); local y0 = rand(380, 520); local L = rand(20, 60)
  local pts = {}
  for k = 0, 4 do pts[#pts+1] = {x + randn(0, 1.2), y0 + L*k/4} end
  local m = trunkZ:shrink(2)
  if m:at(x, y0) > 0.5 and m:at(x, y0 + L) > 0.5 then
    fb:stroke(pts, {pressure={fb:pressure_for(1.2), fb:pressure_for(0.5)}, ramps={0.2, 0.3}})
  end
end
