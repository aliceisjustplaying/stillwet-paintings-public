print(wait(60*24*2))
local cut = rect(0,0,1000,414)
local hz = (((townM + townM2 + townM3):grow(8)) - townM4:grow(0.2)) * cloud2M:grow(9) * cut * rect(560,300,200,114)
haloW = hz
local function Z(lo, hi, s) return cloudV:map(function(v) return smoothstep(lo - s, lo + s, v) * smoothstep(hi + s, hi - s, v) end) * hz end
local zL = cloudV:map(function(v) return smoothstep(0.56, 0.64, v) end) * hz
local list = {{Z(-1,0.24,0.015),kD},{Z(0.24,0.36,0.015),kS2},{Z(0.36,0.47,0.015),kQ},{Z(0.47,0.58,0.015),kH},{zL,kL}}
local ang = cloud2F:field("across")
for i, t in ipairs(list) do
  if t[1]:area() > 1 then
    work(t[1]:grow(0.8) * hz, {hand="detail", tool={kind="filbert", width=2.5}, pile=t[2], angle=ang, coverage=3, fill=true, clip=hz, pressure={0.45,0.7}, seed=3880 + i})
  end
end
blend(hz:shrink(0.4), {tool={kind="badger", width=6}, angle=ang, coverage=1.3, clip=true, pressure={0.2,0.35}, seed=3886})
