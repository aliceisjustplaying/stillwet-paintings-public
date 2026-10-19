local b = below({{-10,441.5},{1010,441.5}})
local lz = rect(150, 443, 70, 32) * b - lime_sil2:grow(1) - roof:grow(1)
blend(lz, {angle=0, coverage=2.0, clip=true, tool={kind="badger", width=14}, pressure={0.4,0.55}})
local top = rect(180, 441.5, 830, 10) * b - willow_heads
blend(top, {angle=0, coverage=1.5, clip=true, tool={kind="badger", width=8}, pressure={0.3,0.45}})
print(wait(0))
