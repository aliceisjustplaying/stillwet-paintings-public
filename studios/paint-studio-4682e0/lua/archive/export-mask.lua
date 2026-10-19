print(drying(610, 350), drying(600, 300), drying(620, 430), drying(585, 350))
local nz = noise{seed=71, period=40, octaves=3, kind="billow"}
local cx, cy, a = 596, 352, -0.55
smokeDoor = function(x, y)
  local u, v = x - cx, y - cy
  local along = u * math.cos(a) + v * math.sin(a)
  local across = -u * math.sin(a) + v * math.cos(a)
  local e = math.exp(-((along / 85)^2 + (across / 55)^2) * 1.6)
  return e * (0.55 + 0.6 * nz:at01(x, y))
end
local figure = (headF + zombieM + newArms + flaps):grow(1)
doorHaze = (rect(588, 270, 110, 200) * doorM) - figure - leafSliver

for py=648,1127 do
 local row={}
 for px=1392,1703 do
  row[#row+1]=string.format("%.9g",doorHaze:at((px+0.5)/2.4,(py+0.5)/2.4))
 end
 print("MASK "..py.." "..table.concat(row," "))
end
