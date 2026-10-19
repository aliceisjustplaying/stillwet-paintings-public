local wm
for i, w in ipairs(willows) do if i > 1 then local r = w.head:grow(1.2) wm = wm and (wm + r) or r end end
willow_heads = wm
local band = rect(180, 444, 830, 30) * below({{-10,441.5},{1010,441.5}}) - wm - lime_sil2:grow(1) - roof:grow(1)
band = band * mask(function(x,y) return 1 - smoothstep(466, 474, y) end)
work(band, {hand="body", pile=mAB, angle=0, coverage=1.8, length={20,50}, pressure={0.45,0.7}, fill=true, clip=band:grow(0.5), threshold=0.3})
blend(band:grow(3) * below({{-10,441.5},{1010,441.5}}) - wm, {angle=0, coverage=1.4, clip=true, tool={kind="badger", width=14}, pressure={0.3,0.45}})
print(wait(0))
