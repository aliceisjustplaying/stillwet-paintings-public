-- the cream halos are the old, wider town masks that every cloud repaint excluded; paint them as cloud now
local cut = rect(0,0,1000,414)
local hz = (((townM + townM2 + townM3):grow(2.5)) - townM4:grow(0.2)) * cloud2M:grow(9) * cut
haloZ = hz
print(hz:area())
local function Z(lo, hi, s) return cloudV:map(function(v) return smoothstep(lo - s, lo + s, v) * smoothstep(hi + s, hi - s, v) end) * hz end
local zL = cloudV:map(function(v) return smoothstep(0.56, 0.64, v) end) * hz
local list = {{Z(-1,0.24,0.015),kD},{Z(0.24,0.36,0.015),kS2},{Z(0.36,0.47,0.015),kQ},{Z(0.47,0.58,0.015),kH},{zL,kL}}
for i, t in ipairs(list) do
  if t[1]:area() > 1 then
    work(t[1]:grow(0.8) * hz, {hand="detail", tool={kind="round", width=1.4, point=0.3}, pile=t[2], angle=math.pi/2, coverage=3.2, fill=true, clip=hz, edge="found", pressure={0.5,0.75}, seed=3850 + i})
  end
end
blend(hz:shrink(0.4), {tool={kind="badger", width=4}, angle=math.pi/2, coverage=1.0, clip=true, pressure={0.2,0.3}, seed=3856})
