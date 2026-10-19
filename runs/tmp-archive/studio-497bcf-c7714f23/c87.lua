local wm
for i, w in ipairs(willows) do local r = w.head:grow(1) + rect(w.x - 4, w.top - 2, 9, w.yb - w.top + 3) wm = wm and (wm + r) or r end
local z = (rect(570, 468, 60, 54) * fieldA) - fieldB:grow(0.5) - wm
blend(z, {angle=0, coverage=2.0, clip=true, tool={kind="badger", width=12}, pressure={0.35,0.5}})
blend(rect(150, 466, 460, 10) * fieldA, {angle=0, coverage=1.5, clip=true, tool={kind="badger", width=10}, pressure={0.3,0.45}})
print(wait(0))
