print(wait(60*24*3))
print(drying(600,360), drying(700,300))
-- lesson again: no local sky patches. Repaint the whole cumulus body in its zones, now cut only by the present town
local cut = rect(0,0,1000,414)
cloudC3 = (cloud2M:grow(9) * cut) - townM4:grow(0.2)
local function Z(lo, hi, s) return cloudV:map(function(v) return smoothstep(lo - s, lo + s, v) * smoothstep(hi + s, hi - s, v) end) * cloudC3 end
local ang = cloud2F:field("across")
local zL = cloudV:map(function(v) return smoothstep(0.56, 0.64, v) end) * cloudC3
local list = {{Z(-1,0.24,0.015),kD},{Z(0.24,0.36,0.015),kS2},{Z(0.36,0.47,0.015),kQ},{Z(0.47,0.58,0.015),kH},{zL,kL}}
for i, t in ipairs(list) do
  work(t[1]:grow(1) * cloudC3, {hand="body", tool="filbert 4", pile=t[2], angle=ang, length={8,22}, coverage=2.6, fill=true, clip=cloudC3, pressure={0.5,0.75}, seed=3900 + i})
end
