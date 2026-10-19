wmask = nil
for i, w in ipairs(willows) do
  if i > 1 then
    local r = w.head:grow(0.5) + rect(w.x - 3.5 + w.lean*0.5, w.top - 2, 7.5, w.yb - w.top + 2.5)
    wmask = wmask and (wmask + r) or r
  end
end
local reg = fieldA * rect(236, 468, 780, 56) - river2:grow(1.2) - fieldB:grow(0.3) - wmask
local up = reg * mask(function(x,y) return 1 - smoothstep(482, 494, y) end)
local dn = reg * mask(function(x,y) return smoothstep(482, 494, y) end)
work(up, {hand="body", pile=gGf, angle=-0.01, coverage=2.0, length={15,45}, pressure={0.45,0.7}, fill=true, clip=reg, threshold=0.3})
work(dn, {hand="body", pile=gG, angle=-0.01, coverage=2.0, length={15,45}, pressure={0.45,0.7}, fill=true, clip=reg, threshold=0.3})
blend(reg, {angle=0, coverage=1.6, clip=true, tool={kind="badger", width=18}, pressure={0.3,0.45}})
print(wait(0))
