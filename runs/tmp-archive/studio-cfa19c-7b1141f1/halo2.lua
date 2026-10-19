-- repaint the cloud close around the tall spire in its own value zones, cut crisply to the tower
local town = townM4:grow(0.25) + townM:grow(0.2) + townM2:grow(0.2)
local near = ((townM4:grow(9) - town) * cloudC * rect(580,316,50,88)):soften(0)
nearS = near
local function Z(lo, hi, s) return cloudV:map(function(v) return smoothstep(lo - s, lo + s, v) * smoothstep(hi + s, hi - s, v) end) * near end
local ang = cloud2F:field("across")
local zH = Z(0.47, 0.58, 0.015)
local zQ = Z(0.36, 0.47, 0.015)
local zS = Z(0.24, 0.36, 0.015)
local zD = Z(-1, 0.24, 0.015)
local zL = cLz * near
for _, t in ipairs({{zD,kD},{zS,kS2},{zQ,kQ},{zH,kH},{zL,kL}}) do
  if t[1]:area() > 1 then
    work(t[1]:grow(0.8) * near, {hand="detail", tool={kind="round", width=1.6, point=0.3}, pile=t[2], angle=ang, coverage=3, fill=true, clip=near, pressure={0.5,0.75}, seed=3730 + _})
  end
end
blend(near:shrink(0.5), {tool={kind="badger", width=5}, angle=math.pi/2, coverage=1.2, clip=true, pressure={0.2,0.35}, seed=3736})
